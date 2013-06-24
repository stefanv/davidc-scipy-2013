---
template:inverse

background-image:url(pictures/KyotoFushimiInariLarge.jpg)

# 3 Finding your way

---
template:inverse

background-image:url(pictures/pollock.jpg)

# 3.1 Code organization

---

layout:false

.left-column[
  ## Main sub-<br/>packages
]

.right-column[

.red[numpy/core]: the meat of NumPy (focus of the tutorial)

- code for multiarray (src/multiarray), ufunc extensions (src/umath)

- various support libraries (npymath, npysort)

- public headers in include

Other important parts:

- .red[numpy/lib]: various tools on top of core

- .red[numpy/fft], .red[numpy/linalg], .red[numpy/random]

Other parts not on topic for this tutorial
]

---
layout:false

.left-column[npymath]

.right-column[
.red[npymath] is a small C99 abstraction for cross platform math operations

- static library linked into the extensions that need it

- implement fundamental IEEE 754-related features (npy_isnan/npy_isinf/etc...)

- half float implementation

- C99 layer for functions, macros and constant definitions

npy_* functions should be used throughout numpy C code (e.g. npy_exp, not exp)

```
#include <numpy/npy_math.h>

void foo()
{
	double x = npy_exp(2.0);
}
```

API "documented" in numpy/npy_math.h header
]

---
layout:false

.left-column[multiarray extension bird view]

TODO: birdview of the different types

.right-column[Contain the implementation of the array, dtype and iterators
objects:

- .red[PyArrayObject] struct (numpy/ndarraytypes.h): array object (hidden in recent versions)
- .red[PyArray_Descr] struct (ditto): dtype object
- .red[PyArrayMultiIterObject] struct (ditto): iterator object (used in broadcasting)

```
/* in numpy/ndarraytypes.h  */
struct PyArrayObject {
  char *data; /* Pointer to the raw data buffer */
  int nd; /* number of dimensions */
  npy_intp *dimensions; /* The size in each dimension */
  npy_intp *strides; /* strides array */
  PyObject *base;
  PyArray_Descr *descr; /* Pointer to type structure */
  int flags;
  PyObject *weakreflist;
}
```

One numpy array -> one PyArrayObject instance

]

---

layout:false

.left-column[PyArray_Type: your main ticket to follow code flow]

.right-column[
PyArrayType is an extension type (singleton) which defines the array behavior

```c
// in src/multiarray/arrayobject.c
// code simplified for presentation
PyTypeObject PyArray_Type = {
   ...
   array_repr, /* __repr__ */
   &array_as_number, /* number protocol */
   &array_as_sequence, /* sequence protocol */
   &array_as_mapping, /* mapping protocol */
   ...
   array_str, /* __str__ */
   &array_as_buffer, /* buffer protocol */
   ...
   array_iter, /* iter protocol */
   ...
   array_methods, /* array methods */
   ...
}
```

Critical to understand code flow of an operation, e.g.:

```
a = np.random.randn(100)
# How to find below op entry point in the C code ?
b = a + a
```

Addition is part of the number protocol -> look into array_as_number array.
]

---
layout:false

.left-column[Example]

.right-column[
First, let`s compile numpy in debug mode:

```
# Create a virtualenv with debug python
virtualenv debug-env -p python2.7-dbg
source debug-env/bin/activate
# install bentomaker in that venv
cd $bento_sources && python setup.py install
# Build numpy in debug mode
CFLAGS="-O0 -g" LDFLAGS="-g" bentomaker build -i
```

We want to look into the snippet below to 'catch' the main entry point for '+'

```
# test_add.py
import numpy as np
a = np.array([1, 2, 3, 4])
b = a + a
```

In gdb

```
gdb python
> break array_add
> run test_add.py
> p ((int*)PyArray_DATA(m1))[0]
```

]

---
layout:false

.left-column[PyArrayDescr_Type]

.right-column[
PyArrayDescr_Type is an extension type (singleton) which defines the *dtype* class

```c
/* in src/multiarray/descriptor.c */
/* code simplified for presentation */
PyTypeObject PyArrayDescr_Type = {
    ...
    "numpy.dtype",
    ...
    /* sequence protocol (e.g. structured dtype) */
    &descr_as_sequence,
    &descr_as_mapping, /* mapping protocol */
    ...
    arraydescr_methods, /* methods */
    arraydescr_members, /* members */
    arraydescr_getsets, /* getset (properties) */
}
```

]
---

---
<!--
#Headers: ``numpy.get_include()``

# Exercise:

Try to fix https://github.com/numpy/numpy/issues/2592

	- find out where the meat of the functionality is implemented
	- can you understand the bug ?
	- fix it !
-->

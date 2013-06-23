---
template:inverse

background-image:url(pictures/pollock.jpg)

# 2. Code organization

---

layout:false

.left-column[
  ## Main sub-<br/>packages
]

.right-column[

.red[numpy/core]: the meat of NumPy (focus of the tutorial)

- code for multiarray, ufunc extensions

- various support libraries (npymath, npysort)

Other important parts:

- .red[numpy/lib]: various tools on top of core

- .red[numpy/fft], .red[numpy/linalg], .red[numpy/random]

Other parts not on topic for this tutorial 
]

---
template:inverse

# Support libraries

---
layout:false

.left-column[npymath]

.right-column[
.red[npymath] is a small C99 abstraction for cross platform math operations

- is a static library "linked" into the extensions that need it

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

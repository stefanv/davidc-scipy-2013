---
template: inverse

# 2. Building NumPy

---
layout:false

.left-column[
  ## Building with distutils
]

.right-column[
Simple in-place build with default compiler

```bash
$ python setup.py build_ext -i
```

Running the test suite on numpy.core

```bash
$ nosetests numpy/core
```

]

---
template:inverse

# That was not too hard !

<!-- another pic here -->

---
template:inverse
# Building with Bento

---

layout:false
.left-column[
 ## Building with Bento
]

.right-column[

Setting bento requires a few steps

```bash
# Recommendation: do this in a virtualenv
git clone https://github.com/cournape/Bento \
	~/src/bento-git
cd ~/src/bento-git && python setup.py install
git clone https://code.google.com/p/waf ~/src/waf-git
# Tells bento where to look for waf (waf has no setup.py)
export WAFDIR=~/src/waf-git
# In NumPy source tree
bentomaker build -i
```

Bento is nifty for NumPy development

```bash
# parallel builds
bentomaker build -i -j4
```

```bash
# reliable partial rebuilds
bentomaker build -i -j4
# Hack to bypass autoconfigure
bentomaker --disable-autoconfigure build -i -j4
```

```bash
# easy compilation customization
CC=clang CFLAGS="-O0 -g -Wall -Wextra" \
	bentomaker build -i -j4
```

]

---
template:inverse
# Practice
---

layout:false
.left-column[
 ## A first exercise
]

.right-column[

After setting up Bento, build NumPy with warning on

```
CFLAGS="-O0 -g -Wall -Wextra -W" bentomaker build -i
```

Lots of warnings of the type:

```
../numpy/linalg/lapack_litemodule.c:863:58: warning: \
	unused parameter 'args' [-Wunused-parameter]
lapack_lite_xerbla(PyObject *NPY_UNUSED(self), \
	PyObject *args)
1 warning generated.
```

NumPy has a special macro to decorate unused argument and give an error if they are used

```
void foo(PyObject *NPY_UNUSED(self), ...)
```

Try fixing one .c file so that there is no warning anymore
]

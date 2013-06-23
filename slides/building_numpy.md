---

# 1. Building NumPy

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

TODO: simple exercise to fix a warning

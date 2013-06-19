# Building NumPy with distutils

    python setup.py build_ext -i


# Issues with distutils

- customizing build difficult
- unreliable partial rebuilds



# Using Bento


# Installing bento for NumPy

- get waf: git clone https://code.google.com/p/waf/ $waf-sources (no install)
- get bento: git clone https://github.com/cournape/Bento.git and install it
- set shell variable WAFDIR=$waf-sources


# Simple in-place build

- bentomaker build -i
- bentomaker build -i -j8 -p # // builds
- bentomaker --disable-autoconfigure build -i -j8 -p # // bypass configure


# Interesting options

- CFLAGS="-O0 -g" LDFLAGS="-g" bentomaker ...
- CFLAGS="-O0 -g -W -Wall -Wextra" LDFLAGS="-g" bentomaker ...

from distutils.core import setup
from distutils.extension import Extension

import numpy

def template(fn):
    import tempita

    with open(fn.replace('.tmpl', ''), 'w') as out:
        out.write(tempita.Template.from_filename(fn).substitute())


template('my_ufunc_types.c.tmpl')


ext = Extension("my_ufuncs", ["my_ufuncs.c"],
                include_dirs=[numpy.get_include()])
ext = Extension("my_ufunc_types", ["my_ufunc_types.c"],
                include_dirs=[numpy.get_include()])


setup(ext_modules=[ext])

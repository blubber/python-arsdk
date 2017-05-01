import os

from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

base = os.path.abspath(os.path.dirname(__file__))

arsdk_includedirs = [
    os.path.join(base, 'sdk/packages/', d, 'Includes')
    for d in os.listdir('sdk/packages/')
    if d.startswith('libAR')
] + [
    'sdk/out/arsdk-native/staging/usr/include/',
]

arsdk_libdirs = [
    os.path.join(base, 'sdk/out/Unix-base/build', d)
    for d in os.listdir('sdk/out/Unix-base/build')
    if d.startswith('libAR')
]

ext_modules = [
    Extension(
        'arsdk',
        sources=['arsdk.pyx'],
        include_dirs=['sdk/out/arsdk-native/staging/usr/include/'],
        library_dirs=arsdk_libdirs,
        libraries=['ardiscovery', 'arcontroller'],
    ),
]

setup(
    name = "AR SDK",
    ext_modules = cythonize(ext_modules)
)

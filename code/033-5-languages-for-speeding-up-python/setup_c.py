from setuptools import Extension, setup

module = Extension("distance_c", sources=["distance.c"])

setup(
    name="DistanceCModule",
    version="1.0",
    description="Python interface for calculating distance in 2D plane",
    ext_modules=[module],
)

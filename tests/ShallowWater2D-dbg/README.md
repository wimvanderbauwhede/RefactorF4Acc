# Example: 2-D Shallow Water Model

## Overview
The sources are taken from the book "Kämpf, Jochen. Ocean Modelling for Beginners: Using Open-Source Software. Springer Science & Business Media, 2009".

Although reasonably close to Fortran 77, this example uses the following Fortran 90 features:

   - Type declarations with double colons (`::`) and the `PARAMETER` attribute
   - `end do` do-loop termination (although F77 allowed `end do` for `while` and `do while` loops)
   - `module` and `use` are F90
   - the `==` in a logical expression
   - free format source

## Refactoring and building
# Building without scons
To build this example you a fortran compiler. You must set the environment variable `FC` to the path to this compiler, e.g.

      $ export FC=/opt/local/bin/gfortran-mp-7

To use the provided build scripts you need [SCons](https://scons.org/). Otherwise, you can build the code as follows:

      $ export FFLAGS=" -Ofast -m64 -Wall -ffree-form -fconvert=big-endian -mcmodel=medium"
      $ gfortran $FFLAGS param.f90 sub.f90 main.f90 -o shallow_water_2D

To build the original code:

      $ cd fortran
      $ scons

To run the refactoring:

      $ cd fortran
      $ ./generate-and-build.sh

The generated code is stored in `RefactoredSources`, the SCons build script is `SConstruct.rf4a`.
      
You can then go to the directory with the generated code and build it:

      $ cd ../RefactoredSources

# Building with scons
If you have SCons,

      $ scons -f SConstruct.rf4a

You can also generate and build with SCons in one go:

      $ cd fortran
      $ ./generate-and-build-with-scons.sh

For parallelisation and OpenCL code generation please see [Auto-acceleration-README.md].

# Documentation
Visit the [wiki] for links to HTML documentation generated automatically by [FORD] for the beginning and refactored versions of the test code.

[Auto-acceleration-README.md]: https://github.com/wimvanderbauwhede/RefactorF4Acc/blob/main/tests/ShallowWater2D/Auto-acceleration-README.md
[FORD]: https://github.com/cmacmackin/ford
[wiki]: https://github.com/wimvanderbauwhede/RefactorF4Acc/wiki

# Example: 2-D Shallow Water Model

The sources are taken from the book "Kämpf, Jochen. Ocean Modelling for Beginners: Using Open-Source Software. Springer Science & Business Media, 2009".

Besides the Fortran 90 type declarations, this example uses other non-F77 features , including

   - end do do-loop termination (although F77 allowed end do for while and do while loops)
   -  module and use are F90
   -  the == in a logical expression
   -  free format source

To build this example you a fortran compiler. You must set the environment variable `FC` to the path to this compiler, e.g.

      $ export FC=/opt/local/bin/gfortran-mp-7

To use the provided build scripts you need [SCons](https://scons.org/). Otherwise, you can build the code as follows:

      $ export FFLAGS=" -Ofast -m64 -Wall -ffree-form -fconvert=big-endian -mcmodel=medium"
      $ gfortran $FFLAGS param.f95 sub.f95 main.f95 -o shallow_water_2D

To build the original code:

      $ cd fortran
      $ scons

To run the refactoring:

      $ cd fortran
      $ ./generate.sh

The generated code is stored in `RefactoredSources`, the SCons build script is `SConstruct.rf4a`.
      
You can then go to the directory with the generated code and build it:

      $ cd ../RefactoredSources

and if you have SCons:

      $ scons -f SConstruct.rf4a

You can also generate and build with SCons in one go:

      $ cd fortran
      $ ./generate_and_build.sh


For parallelisation and OpenCL code generation please see `Auto-acceleration-README.md`.

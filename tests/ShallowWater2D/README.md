# Example: 2-D Shallow Water Model

The sources are taken from the book "Kämpf, Jochen. Ocean Modelling for Beginners: Using Open-Source Software. Springer Science & Business Media, 2009".

To build this example you need [SCons](https://scons.org/) and a fortran compiler. You must set the environment variable `FC` to the path to this compiler, e.g.

      $ export FC=/opt/local/bin/gfortran-mp-7



To build the original code:

      $ cd fortran
      $ scons

To run the refactoring:

      $ cd fortran
      $ ./generate_and_build.sh

The generated code is stored in `RefactoredSources`, the SCons build script is `SConstruct.rf4a`.

For parallelisation and OpenCL code generation please see `Auto-acceleration-README.md`.

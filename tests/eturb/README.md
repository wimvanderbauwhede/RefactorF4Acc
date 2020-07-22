# eTurb refatoring test 

The folder `eturb/src` contains a subset of the Nek5000 source code used by the [eTurb](https://exabl.github.io/eturb/) project. Essentially, the subroutine `comp_gije` and all its dependencies. You can use the script `copy_srcs_from_Nek.pl` to copy the sources from your local Nek5000 repo.

Apart from the files taken from the [Nek5000 source](https://github.com/Nek5000/Nek5000), it contains the following files:

- Based on the eTurb sources (because the eturb source license does not allow me to include the originals here):

    - `dabl.f` : a dummy similar to`src/abl/abl.usr` from eturb-0.1.1
    - `SIZE` : similar to `src/abl/SIZE` from eturb-0.1.1

- From the OpenMPI header files

    - `mpif.h` : for convenience, a single-source merged version with all includes 

- From the [PAPI sources](https://bitbucket.org/icl/papi/src/master/)

    - `f77papi.h`

- A trivial driver program `drive.f`

To test the refactoring, it is sufficent to run

        $ refactorF4acc.pl

in the folder `eturb`. The refactored sources will be generated in `refactored-src`        


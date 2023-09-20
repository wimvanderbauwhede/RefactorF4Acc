#!/bin/bash
UNROLL=$1
WM=$2

if [  "$UNROLL" == "" ]; then
    echo "Please specify the unroll factor"
else
    if [  "$WM" == "" ]; then
        echo "Please specify WM"
    else
        if [ ! -d "../../autopar_${UNROLL}_$WM/" ]; then
            mkdir "../../autopar_${UNROLL}_$WM/"
        fi
        AutoParallel-Fortran-exe ./sor_superkernel.f95 -out ../../autopar_${UNROLL}_$WM/ -main ./test_sor_unroll.f95 -v -plat GPU -N -X NO_IO -v
    fi
fi

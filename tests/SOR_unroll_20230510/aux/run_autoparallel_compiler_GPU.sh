UNROLL=$1
if [  "$UNROLL" == "" ]; then
    echo "Please specify the unroll factor"
else
    if [ ! -d "../../autopar_$UNROLL/" ]; then
        mkdir "../../autopar_$UNROLL/"
    fi
    AutoParallel-Fortran-exe ./sor_superkernel.f95 -out ../../autopar_$UNROLL/ -main ./test_sor_unroll.f95 -v -plat GPU -N -X NO_IO -v
fi

UNROLL=$1
WD=$2
if [  "$UNROLL" == "" ]; then
    echo "Please specify the unroll factor"
else
if [  "$WD" == "" ]; then
    echo "Please specify WD"
else
    if [ ! -d "../../autopar_${UNROLL}_$WD/" ]; then
        mkdir "../../autopar_${UNROLL}_$WD/"
    fi
    AutoParallel-Fortran-exe ./sor_superkernel.f95 -out ../../autopar_${UNROLL}_$WD/ -main ./test_sor_unroll.f95 -v -plat GPU -N -X NO_IO -v
fi
fi
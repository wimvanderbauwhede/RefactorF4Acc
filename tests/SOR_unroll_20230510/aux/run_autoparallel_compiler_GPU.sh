if [ ! -d "./Autopar_GPU/" ]; then
    mkdir ./Autopar_GPU/
fi
AutoParallel-Fortran-exe ./sor_superkernel.f95 -out ./Autopar_GPU/ -main ./test_sor_unroll.f95 -v -plat GPU -N -X NO_IO -v


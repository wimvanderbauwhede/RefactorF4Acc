cd 'fortran'
export FFLAGS="-cpp -Ofast -m64 -Wall -ffree-form -fconvert=big-endian -mcmodel=medium"
$FC $FFLAGS param.f95 sub.f95 main.f95 -o shallow_water_2D

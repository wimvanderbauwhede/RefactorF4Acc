if [[ $1 == "" ]]
then
echo "Please specify the platform: CPU, GPU or FPGA"
exit 1
else
if [ ! -d "../Autopar_$1/" ]
then
mkdir "../Autopar_$1/"
fi
AutoParallel-Fortran-exe ./dyn_shapiro.f95 -out ../Autopar_$1/ -main ./main.f95 -v -plat $1 -N -X NO_IO -v
fi

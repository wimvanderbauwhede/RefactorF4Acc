refactorF4acc.pl $* -c ./rf4a.cfg -g
cd ../RefactoredSources
export FFLAGS="-cpp -Ofast -m64 -Wall -ffree-form -fconvert=big-endian -mcmodel=medium"
gfortran $FFLAGS dyn.f95 init.f95 shapiro.f95 sub.f95 update.f95 main.f95 -o shallow_water_2D


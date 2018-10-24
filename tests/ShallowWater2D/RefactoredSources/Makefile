executable := shallow_water_2D
compile := gfortran
link := $(compile)

opt := -cpp -Ofast -m64 -Wall -ffree-form -fconvert=big-endian -mcmodel=medium

# Locate required source files
source_files := $(shell ls *.f95)

# Swap .f90 file extensions for .o extensions 
object_files := $(subst .f95,.o,$(source_files))

# Specify dependencies, compile, and link
$(executable): $(object_files)
	$(link) $(object_files) -o $@

main.o: update.o sub.o

sub.o: init.o dyn.o shapiro.o

%.o: %.f95
	$(compile) $(opt) -c $<

.PHONY : clean

clean :
	-rm -f  *.o *.mod $(executable)

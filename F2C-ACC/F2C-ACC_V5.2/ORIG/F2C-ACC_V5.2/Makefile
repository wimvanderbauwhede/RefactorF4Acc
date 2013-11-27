# Makefile to build the Fortran to C or CUDA language translator and
# building CUDA or C code
#
# Written by:  Mark Govett	NOAA/ESRL
# April 2009
#
# Two types of files can be generated:
# CUDA:  target is <file>.cu    ! builds *_GPU.o file
# C:     target is <file>.o     ! builds *_CPU.o file
#
GPU_HOME = ./
F2C-ACC = $(GPU_HOME)/bin/F2C-ACC
#
# requires m4 is in your path
GPU_M4 = m4 -I $(GPU_HOME)/include/logical.m4 $(GPU_HOME)/include/ARCH.m4

# location of CUDA on my development machine 

all:	F2C-ACC

F2C-ACC:	
	(cd source; make; mv F2C-ACC.exe ../bin)
	(cd lib; make;)

clean:
	(cd source; make clean;)
	(cd examples; make clean;)
	(cd examples/gptl_lite; make clean;)
	(cd bin; rm F2C-ACC.exe)
	(cd lib; make clean)

.SUFFIXES: .o .f90 .f .c .m4 .cu

.f.o:	
	$(F2C-ACC) --Fixed --Generate=C $<
	$(GPU_M4) $*.m4 > $*_CPU.c
	cc -c $(FLAGS) -I $(GPU_HOME)/include $*_CPU.c

.f90.o:	
	$(F2C-ACC) --Free --Generate=C $<
	$(GPU_M4) $*.m4 > $*_CPU.c
	cc -c $(FLAGS) -I $(GPU_HOME)/include $*_CPU.c

.f.cu:	
	$(F2C-ACC) --Fixed --Generate=CUDA $<
	$(GPU_M4) $*.m4 > $*_GPU.cu

.f90.cu:	
	$(F2C-ACC) --Free  --Generate=CUDA $<
	$(GPU_M4) $*.m4 > $*_GPU.cu

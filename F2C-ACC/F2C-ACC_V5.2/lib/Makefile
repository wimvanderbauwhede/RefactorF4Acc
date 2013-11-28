# Makefile for building Fortran source callable from C or CUDA
# Written by  Mark Govett		NOAA/ESRL
# November 2012
#
#   define Fortran
OPT=-O2
F90=$(FC) $(OPT)
M4=m4
CUDA=$(CUDA_ROOT)/
NVCC=$(CUDA)/bin/nvcc
#
#
F2C_HOME = ../
# M4 executable + include files
GPU_M4 = $(M4) -I $(F2C_HOME)/include/logical.m4 $(F2C_HOME)/include/ARCH.m4

OBJS = cudaError.o

CPP       = cpp
CPPFLAGS = -traditional -P 

.SUFFIXES:
.SUFFIXES: .F90 .o .f90 .c .m4 .cu .a

all:	lib
lib:	$(OBJS)
	ar -rc libF2C.a $(OBJS)

.f90.o:
	$(F90) -c $<

.cu.o:
	$(NVCC) -c -m64 $<
clean:
	rm -f *.o libF2C.a


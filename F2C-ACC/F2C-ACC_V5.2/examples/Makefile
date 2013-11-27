# Makefile for building F2C-ACC C or CUDA code
# Written by  Mark Govett		NOAA/ESRL
# November 2010
#
# Description
# There are three source code targets used to build object files
# Fortran	make <file>.o	!build a Fortran object file for the CPU
# CUDA		make <file>.cu	!builds a CUDA object file for the GPU
# C		make <file.c>	!builds a C object file for the CPU
#
# There are two build targets:
# CPU		make cpu	!generates C code to run on the CPU
# GPU		make gpu	!generates CUDA code to run on the GPU
#
# I. Configuration instructions
#
#   define the location of the F2C-ACC software
F2C_HOME = /Users/wim/SoC_Research/F2C-ACC_V5.2
CUDA = /usr/local/cuda
CUDALIBS = -L$(CUDA)/lib -lcudart -L$(F2C_HOME)/lib -lF2C
#CUDALIBS = -L$(CUDA)/lib64 -lcudart -L$(F2C_HOME)/lib -lF2C
#
#   define Fortran,CUDA compilers, m4 (if not already in your path)
OPT=-O2
#F90=ifort $(OPT)
F90M32=gfortran -cpp -m32 $(OPT)
F90M64=gfortran -cpp -m64 $(OPT)
F90=gfortran -cpp $(OPT)
NVCC=$(CUDA)/bin/nvcc
M4=m4
#
#
# Use above defs to define executable, include files
F2C = $(F2C_HOME)/bin/F2C-ACC
# M4 executable + include files
GPU_M4 = $(M4) -I $(F2C_HOME)/include/logical.m4 $(F2C_HOME)/include/ARCH.m4

# CUDA compiler options
#EMULATOR=-deviceemu
NVCC_OPT=-arch sm_20 -pg $(EMULATOR)
# GPTL timing library: To shut off entirely, set USE_GPTL = no
USE_GPTL = yes
ifeq ($(USE_GPTL),yes)
# mac-fermi
  GPTL = $(F2C_HOME)/examples/gptl_lite/
#intel-jet
  GPTL32 = $(F2C_HOME)/examples/gptl_lite_m32/

  GPTLINCLUDE = -I$(GPTL)/include
  GPTLLIB     = -L$(GPTL)/lib -lgptl
  GPTLLIB32     = -L$(GPTL32)/lib -lgptl
endif

CPP       = cpp
CPPFLAGS = -traditional -P $(GPTLINCLUDE)
CPPFLAGS = -traditional -P 

.SUFFIXES:
.SUFFIXES: .f90cpp .o .f90 .c .m4 .cu .a

all:	driver_ftn driver_gpu driver_cpu

driver_ftn:	module_vars.f90 use_module.f90 driver.f90 accdata.f90 scalar.f90 copyIn.f90 intrinsics.f90 sharedChunk.f90 GlobalSharedTests.f90 PromoteDemoteTests.f90 GlobalSharedCopy.f90 blockShared.f90
	$(F90) -o driver_ftn -I$(F2C_HOME)/examples/ module_vars.f90 use_module.f90 driver.f90 accdata.f90 scalar.f90 copyIn.f90 intrinsics.f90 sharedChunk.f90 GlobalSharedTests.f90 PromoteDemoteTests.f90 GlobalSharedCopy.f90 blockShared.f90 $(GPTLLIB) 

driver_gpu:	module_vars.f90 use_module.f90 driver.f90 accdata.cu copyIn.cu intrinsics.cu scalar.cu GlobalSharedTests.cu sharedChunk.cu PromoteDemoteTests.cu GlobalSharedCopy.cu blockShared.cu
	$(F90M32) -o driver_gpu -I$(F2C_HOME)/examples/ module_vars.f90 use_module.f90 driver.f90 accdata.o scalar.o copyIn.o intrinsics.o GlobalSharedTests.o sharedChunk.o PromoteDemoteTests.o GlobalSharedCopy.o blockShared.o $(CUDALIBS) $(GPTLLIB32) -lstdc++

driver_cpu:	module_vars.f90 use_module.f90 driver.f90 accdata.c copyIn.c intrinsics.c scalar.c GlobalSharedTests.c sharedChunk.c PromoteDemoteTests.c GlobalSharedCopy.c blockShared.c
	$(F90) -o driver_cpu module_vars.f90 use_module.f90 driver.f90 accdata.o scalar.o copyIn.o intrinsics.o GlobalSharedTests.o sharedChunk.o PromoteDemoteTests.o GlobalSharedCopy.o blockShared.o $(GPTLLIB)
#	rm *.o

.f90.o:
	$(F90) -c $<
.f90.c:	
	$(F2C) --Generate=C  $<
	$(GPU_M4) $*.m4 > $*.c
	cc -c $(FLAGS) $(OPT) -I $(F2C_HOME)/include $*.c

.f90.cu:
	$(F2C) --Generate=CUDA $<
	$(GPU_M4) $*.m4 > $*.cu
	$(NVCC) -c $(NVCC_OPT) -I$(CUDA_SDK)/common/inc -I$(F2C_HOME)/include $*.cu

.f90cpp.f90:
	$(CPP) $(CPPFLAGS) $< >$*.f90
.f90.a:
	$(F2C) --Generate=CUDA --Analysis=1 $<

PromoteDemoteTests.cu:
	$(F2C) --Generate=CUDA --Constant NZ=50,NX=5000 $*.f90
	$(GPU_M4) $*.m4 > $*.cu
	$(NVCC) -c $(NVCC_OPT) -I$(CUDA_SDK)/common/inc -I$(F2C_HOME)/include $*.cu

scalar.cu:
	$(CPP) $(CPPFLAGS) -DGPU scalar.f90cpp >$*.f90
	$(F2C) --Generate=CUDA --Constant NZ=50,NX=5000 $*.f90
	$(GPU_M4) $*.m4 > $*.cu
	$(NVCC) -c $(NVCC_OPT) -I$(CUDA_SDK)/common/inc -I$(F2C_HOME)/include $*.cu
	
GlobalSharedCopy.cu:
	$(F2C) --Generate=CUDA --Constant NZ=50,NX=50,ITER=2 $*.f90
	$(GPU_M4) $*.m4 > $*.cu
	$(NVCC) -c $(NVCC_OPT) -I$(CUDA_SDK)/common/inc -I$(F2C_HOME)/include $*.cu

blockShared.cu:
	$(F2C) --Generate=CUDA --Constant IMS=1,IME=50,KMS=1,KME=20 $*.f90
	$(GPU_M4) $*.m4 > $*.cu
	$(NVCC) -c $(NVCC_OPT) -I$(CUDA_SDK)/common/inc -I$(F2C_HOME)/include $*.cu

use_module.o:	module_vars.o

clean:
	rm -f *.o *.m4 *.c *.cu *~ *.tmp scalar.f90 driver.f90 *.mod

distclean:	clean
	rm -f driver_ftn driver_cpu driver_gpu

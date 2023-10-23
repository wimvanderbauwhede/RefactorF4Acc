# 2-D Shallow water code acceleration

[gpu@gpuserver fortran]$ pwd
/home/gpu/RF4A/tests/ShallowWater2D/fortran

## Add a pragma

1/ a small fix to keep the autoparallelising compiler happy:
- extract a subroutine in the main time loop ("update")

	!$ACC Subroutine update
	...
	!$ACC End Subroutine update

so that there are only subroutine calls in the main time loop

## Convert, build and run

	[gpu@gpuserver fortran]$ cat rf4a.cfg 
	TOP = wave2d
	PREFIX = .
	SRCDIRS = .
	NEWSRCPATH = ../RefactoredSources
	#EXCL_SRCS = 
	#EXCL_DIRS = 
	#NO_MODULE =  
	NO_ONLY = 1
	SPLIT_LONG_LINES = 0
	RENAME_EXT = _G
	MACRO_SRC = macros.h
	
	[gpu@gpuserver fortran]$ refactorF4acc.pl -c ./rf4a.cfg -g -b
	
	[gpu@gpuserver fortran]$ cd ../RefactoredSources
	
	[gpu@gpuserver RefactoredSources]$ pwd
	/home/gpu/RF4A/tests/ShallowWater2D/RefactoredSources
	
	[gpu@gpuserver RefactoredSources]$ scons -f SConstruct.rf4a 
	[gpu@gpuserver RefactoredSources]$ time ./wave2d 
	 c =    14.0071411    
	 lambda =    9.90454480E-02
	 Data output at time =    16.6666660      min
	This is the original code, -O3
	real	4m24.844s
	user	4m24.334s
	sys	0m0.326s

## Auto-parallelise

	[gpu@gpuserver RefactoredSources]$ ./run_autoparallel_compiler GPU

## Convert kernel to OpenCL-C, build and run

	[gpu@gpuserver RefactoredSources]$ cd ../Autopar
	[gpu@gpuserver Autopar]$ pwd
	/home/gpu/RF4A/tests/ShallowWater2D/Autopar

Copy some files from the refactored sources

	[gpu@gpuserver Autopar]$ ./setup.pl

	[gpu@gpuserver Autopar]$ cat generate_OpenCL_kernel.sh 	
	refactorF4acc.pl -P translate_to_OpenCL -c rf4a_to_C.cfg $1
	cp  $1.cl $1_ORIG.cl
	cpp -DNTH=1 -DNUNITS=8 -I. -P $1.cl > tmpp.cl
	mv tmpp.cl $1_after_CPP.cl

	[gpu@gpuserver Autopar]$ ./generate_OpenCL_kernel.sh module_shapiro_dyn_update_superkernel
	
To build the OpenCL code for on the Iris Pro GPU on my laptop: 	

	[gpu@gpuserver Autopar]$ scons -f SConstruct.auto dev=GPU nth=32 nunits=40
		
Running the accelerated code on this GPU results in 2.7x speedup 
 
	 c =    14.0071411    
	 lambda =    9.90454480E-02
	 Data output at time =    16.6666660      min
	
	real	1m37.682s
	user	0m4.411s
	sys	0m9.859s
	
To build the OpenCL code for on the CPU on my laptop (you need to run `./run_autoparallel_compiler CPU` first) 
 	
	[gpu@gpuserver Autopar]$ scons -f SConstruct.auto dev=CPU nth=1 nunits=8 v=1 info=1

This is OpenCL on the Intel(R) Core(TM) i7-4850HQ CPU @ 2.30GHz, 2.4x

	 c =    14.0071411    
	 lambda =    9.90454480E-02
	 Data output at time =    16.6666660      min
	
	real	1m50.906s
	user	11m47.959s
	sys	0m5.939s

Result on a "proper" GPU

	[gpu@titam Autopar]$ scons  -f SConstruct.auto dev=GPU nth=512 nunits=15 v=1 info=1
	
	GeForce GTX TITAN Black ,  (268/19) = 14x
	
	real	0m19.240s
	user	0m15.320s
	sys	0m3.328s

for reference, the CPU on the GPU server:

	[gpu@titam Autopar]$ scons  -f SConstruct.auto dev=CPU nth=1 nunits=8 v=1 info=1

	Intel(R) Core(TM) i7-4771 CPU @ 3.50GHz
	
	real	1m28.456s
	user	11m29.689s
	sys	0m6.327s

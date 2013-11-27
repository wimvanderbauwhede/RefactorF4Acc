#!/bin/csh -f
#
# build script to make and install the F2C compiler
#
# Written by:   Mark Govett
#               NOAA Earth System Research Laboratory
#               June 2013
#
# Required software
#   - intel Fortran and C compiler:             test:  which ifort
#   - nvcc compiler                             test:  which nvcc
#   - cuda runtime library                      test:  find   libcudart.so
#   - gnu m4 library                            test:  which m4
#
# Assumptions for this script
#   1.  The node where this software is being installed can INTERACTIVELY
#       run a cuda gpu routine
#
#   If GPU nodes are only available via the batch system, a wrapper script
#   will be needed to submit the build and run tests as a batch routine
#
#   2.  Directory where you wish to install F2C-ACC exists
#
#
if ($#argv != 1) then
  echo "Usage: $0 install-path"
  echo "  install-path          location where F2C-ACC will be installed"
  exit 0
endif

set installdir = $argv[1]
if (! -e $installdir || ! -d $installdir) then
  echo "Error: $installdir does not exist or is not a directory"
  exit 1
endif
set mydir = $cwd
#
# build F2C-ACC compiler
cd source
make || echo 'First make failed--exiting' && exit 1
mv F2C-ACC.exe ../bin
cd ..
#
# modify perl driver script F2C-ACC, to build	
#
echo 'cd bin'
cd bin
cp F2C-ACC.template F2C-ACC
sed -i s,/Users/name/,$mydir, F2C-ACC 
#
cd ../examples/
cp Makefile.template Makefile
sed -i s,/Users/name/,$mydir, Makefile
#
cd ../lib
make || echo 'Second make failed--exiting' && exit 1
#
echo "Building gptl_lite..."
cd ../examples/gptl_lite
make || echo 'make failed in examples/gptl_lite--exiting' && exit 1
echo "Success building gptl_lite..."
cd ../
make
echo '---------------------------------------'
echo 'Validating Fortran code'
echo '---------------------------------------'
./driver_ftn
echo ''
echo '---------------------------------------'
echo 'Validating F2C-ACC Generated C code'
echo '---------------------------------------'
./driver_cpu
echo '---------------------------------------'
echo 'Validating F2C-ACC Generated CUDA code'
echo '---------------------------------------'
./driver_gpu
cd ..
#
#verify the path is not the source directory
echo 'Installing software in ' $installdir

if (($cwd != $installdir) && ($cwd'/' != $installdir)) then

# modify paths to point to the install path
#
  cd bin 
  \rm F2C-ACC
  cp -f F2C-ACC.template F2C-ACC
  sed -i s,/Users/name/,$installdir, F2C-ACC 
#
  cd ../examples/
  cp -f Makefile.template Makefile
  sed -i s,/Users/name/,$installdir, Makefile
  cd ..
#
# install F2C in the user specified location
  cp  F2C-ACC_Documentation_V4.2.pdf $installdir
  cp  README $installdir
#
  if (! -e $installdir/lib) then
    mkdir $installdir/lib
  endif
  cp lib/libF2C.a $installdir/lib
#
  cp -r include $installdir
  if (! -e $installdir/bin) then
    mkdir $installdir/bin 
  endif
  cp -r bin/F2C-ACC $installdir/bin
  cp -r bin/F2C-ACC.exe $installdir/bin
#
  if (! -e $installdir/examples) then
    mkdir $installdir/examples 
  endif
  cp -r examples/* $installdir/examples
endif

echo 'Installation complete'
exit 0

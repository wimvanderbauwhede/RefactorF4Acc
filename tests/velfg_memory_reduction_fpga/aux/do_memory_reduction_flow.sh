#!/bin/sh

# exit when any command fails
set -e

cwd=$(pwd)

# See README for full steps

memory_reduction.pl -C
cd MemoryReduction
perl ../aux/patch_scalarised_functions.pl -i
refactorF4acc.pl -c ./rf4a_inline.cfg 
cd ../mem_reduced_inlined/Generated 
perl ../../aux/patch_inlined_code.pl OpenCL
# perl ../../aux/patch_inlined_code.pl 

cd $cwd

echo "Final code is in mem_reduced_inlined/Generated/Patched"
echo "Run 'translate_kernels_to_OpenCLC.pl' on stage_kernel"



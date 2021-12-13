1. Run memory_reduction.pl -C from velfg_memory_reduction_fpga/
2. From MemoryReduction/ run: ../aux/patch_memreduced.sh -i
3. From MemoryReduction/ run: refactorF4Acc.pl -c ./rf4a_inline.cfg 
4. From mem_reduced_inlined/Generated run: perl ../../aux/patch_inlined_code.pl OpenCL
5. In Patched/ manually inline, so all superkernel source is in one file.
      gfortan should not have issues compiling when setting global_id=0
6. Run translate_kernels_to_OpenCLC.pl from Patched/
7. Manually fixup the OpenCL file


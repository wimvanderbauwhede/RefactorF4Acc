 memory_reduction.pl -t $1
 stack build --verbosity error
 stack exec --verbosity error MemoryReduction-exe > tmp_gen.f90 
 ./build_generated_code.sh tmp_gen.f90

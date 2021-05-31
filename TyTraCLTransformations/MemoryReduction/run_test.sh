 memory_reduction.pl -t $1
 stack build --verbosity error
 stack exec --verbosity error MemoryReduction-exe  
 ./build_generated_code.sh gen_test_$1.f95

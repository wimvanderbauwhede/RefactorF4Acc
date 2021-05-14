 memory_reduction.pl -t $1
 stack build --trace
 stack exec --trace -- MemoryReduction-exe +RTS -xc

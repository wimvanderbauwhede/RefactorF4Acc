generate_Haskell_AST_Code.pl -t $1
stack build --verbosity error
stack exec --verbosity error MemoryReduction-exe

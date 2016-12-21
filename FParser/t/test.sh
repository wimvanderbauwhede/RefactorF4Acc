ghc -keep-tmp-files -tmpdir=./tmp --make -i.. test_${1}.hs && ./test_${1}

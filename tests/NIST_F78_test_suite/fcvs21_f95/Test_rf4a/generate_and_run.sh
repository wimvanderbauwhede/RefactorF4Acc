./clean_up.sh
time perl run_testsuite.pl | tee generate.log 2>&1
echo "# Generation of the refactored test suite code:"
grep TOTAL generate.log
grep RUN generate.log
grep SKIPPED generate.log
echo 'Generation Failed:'
grep -c cp generate.log 
echo 'Generation Succeeded:'
ls -1 ../RefactoredSources/ | grep -c f95
cd ../RefactoredSources
time ./driver_parse > parse.log 2>&1
echo ""
echo "# Compilation of the refactored test suite:"
tail -n 5 parse.log
time ./driver_run > run.log 2>&1
echo "# Running the refactored test suite:"
./extract_overall_performance.sh


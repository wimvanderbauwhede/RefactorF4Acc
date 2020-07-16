./clean_up.sh >/dev/null 2>&1
time perl run_testsuite_generation.pl | tee generate.log 2>&1
echo "# Generation of the refactored test suite code:"
grep TOTAL generate.log
grep RUN generate.log
grep SKIPPED generate.log
echo 'Generation Failed:'
grep -c failed generate.log 
echo 'Generation Succeeded:'
ls -1 ../RefactoredSources/ | grep -c f95
cd ../RefactoredSources
parse_time=`time ./driver_parse > parse.log 2>&1`
echo $parse_time
echo $parse_time > parse_time
echo ""
echo "# Compilation of the refactored test suite:"
tail -n 5 parse.log
run_time=`time ./driver_run > run.log 2>&1`
echo $run_time
echo $run_time > run_time
echo "# Running the refactored test suite:"
./extract_overall_performance.sh


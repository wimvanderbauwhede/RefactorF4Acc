echo "# Generation of the refactored test suite code:"
grep TOTAL generate.log
grep RUN generate.log
grep SKIPPED generate.log
echo 'Generation Failed:'
grep -c failed generate.log 
echo 'Generation Succeeded:'
ls -1 ../RefactoredSources/ | grep -c f95
cd ../RefactoredSources
echo ""
cat parse_time
echo "# Compilation of the refactored test suite:"
tail -n 5 parse.log
cat run_time
echo "# Running the refactored test suite:"
./extract_overall_performance.sh


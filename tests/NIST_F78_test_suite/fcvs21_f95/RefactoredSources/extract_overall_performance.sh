grep 'REQUIRE INSPEC' *.res | grep -v '0 TESTS' > REQUIRE_INSPECTION.txt 
grep EXECUTED *.res > EXECUTED.txt 
grep FAILED *.res | grep -v '0 TESTS' > FAIL.txt 
grep PASSED *.res | grep -v '0 TESTS' > PASS.txt
./get_totals.pl

grep -a 'REQUIRE INSPEC' *.res | grep -v '0 TESTS' > REQUIRE_INSPECTION.txt 
grep -a EXECUTED *.res > EXECUTED.txt 
grep -a 'TESTS FAILED' *.res | grep -v '0 TESTS' > FAIL.txt 
grep -a PASSED *.res | grep -v '0 TESTS' > PASS.txt
./get_totals.pl

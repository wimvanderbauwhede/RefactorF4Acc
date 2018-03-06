#!/usr/bin/env perl
use v5.016;
use strict;
use warnings;

=pod
406 
one failed test, fails in gfortran as well: -0 instead of +0 in formatted write

923
two failed tests, both fail in gfortran as well
! T023* TEST 22 - CARD 25 QUOTES, BLANKS, COMMAS AND SLASHES ! ***** EMBEDDED IN CHARACTER STRINGS 
! T024* TEST 23 - CARD 26 CHARACTER STRINGS THAT ARE READ IN ! ***** VARIABLES OF DIFFERENT LENGTHS 

----

I skipped following files:
FM010.f
FM011.f 
FM200.f
This accounts for 23 tests

From the remaining 189, the driver that comes with the test suite skipped 8 tests; 1 test failed to parse (FM500.f, 37 tests) 

One test FM509 crashed
Process FM509
FM509.f95:411.17:
call sn512(c1n001(5)(2:9),cvcomp)
1

Warning: Actual argument contains too few elements for dummy argument 'c1d001' (19/48) at (1)
Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
Backtrace for this error:
#0 0x10871011b
#1 0x10870f8e8
#2 0x7fff8bd6f5a9
#3 0x108706e98
#4 0x108706907
#5 0x108708199
#6 0x108709533
./driver_run_single: line 23: 62657 Segmentation fault: 11 ./a.out > "${result}"
Finished.

TOTAL TESTS: 192
TESTS RUN: 189
SKIPPED: 3
Generation Failed:
0
Generation Succeeded:
189

Total : 189
Passed : 180
Failed : 1
Skipped: 8

PASSED: 2703
FAILED: 3
REQUIRE INSPECTION: 161
TOTAL: 2867

FM406.res: 1 TESTS FAILED
FM923.res: 2 TESTS FAILED

-rw-r--r--+ 1 wim staff 0 19 Aug 15:02 FM500.res
-rw-r--r--+ 1 wim staff 0 19 Aug 15:02 FM509.res

# Generation failed: (165 tests)
FM011.f 7 tests SPACES IN VARS

#
# Parse failed:
#
FM010.f 3 tests (124 tests) SPACES IN VARS
FM200.f 13 tests SPACES IN VARS

FM500.f 37 => SERIOUS MESS!
#
# Fails in original with gfortran
#
FM406.f (1 test)
FM923.f (2 tests)

Runtime error: 
-rw-r--r--+ 1 wim  staff      0  5 Aug 17:16 FM509.res

EQUIVALENCE occurs in
022
024
300
302
308
500***
700
722
809
811
813
185
817
820
828
829
830
831
833
834
906
908
909


FM514.f
FM517.f

FM317.f
FM328.f
=cut


my @skipped_tests=qw(
FM010.f
FM011.f    
FM045.f    
FM200.f
FM500.f
FM509.f
);



my %skip_test = map {$_ => 1} @skipped_tests;

my @sources = qw(FM001.f
FM002.f
FM003.f
FM004.f
FM005.f
FM006.f
FM007.f
FM008.f
FM009.f
FM010.f
FM011.f
FM012.f
FM013.f
FM014.f
FM016.f
FM017.f
FM018.f
FM019.f
FM020.f
FM021.f
FM022.f
FM023.f
FM024.f
FM025.f
FM026.f
FM028.f
FM030.f
FM031.f
FM032.f
FM033.f
FM034.f
FM035.f
FM036.f
FM037.f
FM038.f
FM039.f
FM040.f
FM041.f
FM042.f
FM043.f
FM044.f
FM045.f
FM046.f
FM050.f
FM056.f
FM060.f
FM061.f
FM062.f
FM080.f
FM090.f
FM091.f
FM097.f
FM098.f
FM099.f
FM100.f
FM101.f
FM102.f
FM103.f
FM104.f
FM105.f
FM106.f
FM107.f
FM108.f
FM109.f
FM110.f
FM111.f
FM199.f
FM200.f
FM201.f
FM202.f
FM203.f
FM204.f
FM205.f
FM251.f
FM252.f
FM253.f
FM254.f
FM255.f
FM256.f
FM257.f
FM258.f
FM259.f
FM260.f
FM261.f
FM300.f
FM301.f
FM302.f
FM306.f
FM307.f
FM308.f
FM311.f
FM317.f
FM328.f
FM351.f
FM352.f
FM353.f
FM354.f
FM355.f
FM356.f
FM357.f
FM359.f
FM360.f
FM361.f
FM362.f
FM363.f
FM364.f
FM368.f
FM369.f
FM370.f
FM371.f
FM372.f
FM373.f
FM374.f
FM375.f
FM376.f
FM377.f
FM378.f
FM379.f
FM401.f
FM402.f
FM403.f
FM404.f
FM405.f
FM406.f
FM407.f
FM411.f
FM413.f
FM500.f
FM503.f
FM506.f
FM509.f
FM514.f
FM517.f
FM520.f
FM700.f
FM701.f
FM710.f
FM711.f
FM715.f
FM718.f
FM719.f
FM722.f
FM800.f
FM801.f
FM802.f
FM803.f
FM804.f
FM805.f
FM806.f
FM807.f
FM808.f
FM809.f
FM810.f
FM811.f
FM812.f
FM813.f
FM814.f
FM815.f
FM816.f
FM817.f
FM818.f
FM819.f
FM820.f
FM821.f
FM822.f
FM823.f
FM824.f
FM825.f
FM826.f
FM827.f
FM828.f
FM829.f
FM830.f
FM831.f
FM832.f
FM833.f
FM834.f
FM900.f
FM901.f
FM903.f
FM905.f
FM906.f
FM907.f
FM908.f
FM909.f
FM910.f
FM912.f
FM914.f
FM915.f
FM916.f
FM917.f
FM919.f
FM920.f
FM921.f
FM922.f
FM923.f);
my $batch=1;
my $flags='';
if (@ARGV) {
    my $src = shift @ARGV;
    @sources=( $src );
    $flags = join(' ',@ARGV);
    $batch=0;
}
my $skipped=0;
my $run=0;
for my $src (@sources) {
    if (exists $skip_test{$src} and $batch==1) {
        say "SKIPPING $src";
        $skipped++;
        next;
    }
    say "TEST CASE $src";
    $run++;
    my $prog =$src;
    $prog=~s/\.f//;
    $prog=lc($prog);
    open my $CFG, '>', "rf4a_$prog.cfg";
    say $CFG "TOP = $prog";
    say $CFG <<'ENDCFG';
PREFIX = .
SRCDIRS = .
NEWSRCPATH = RefactoredSources
EXCL_SRCS = \w\.DAT
EXCL_DIRS = RefactoredSources
SPLIT_LONG_LINES = 0

ENDCFG

    close $CFG;
    system("cp ../$src .");
    say "refactorF4acc.pl -c rf4a_$prog.cfg $flags -g $prog";
    system("refactorF4acc.pl -c rf4a_$prog.cfg $flags -g $prog");
    if ($batch==1) {
    system("rm -f $src");
    system("rm -f rf4a_$prog.cfg");
    system("cp RefactoredSources/${src}95 ../RefactoredSources");
    }
    
}


say "TOTAL TESTS: ".scalar(@sources);
say "TESTS RUN: $run";
say "SKIPPED: $skipped";

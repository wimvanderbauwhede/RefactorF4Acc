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
FM010.f => replaced by FM090
FM011.f => replaced by FM091

FM045.f => OK now. So I removed FM046.f which was my patch
FM200.f => replaced by FM210

FM500.f
FM509.f
- The files `FM500.f` and `FM509.f` contain tests for corner cases of COMMON blocks and BLOCK DATA (37+16 tests) which we don't support.
=cut


my @skipped_tests=qw(
FM010.f
FM011.f
FM200.f
FM500.f
FM509.f
);



my %skip_test = map {$_ => 1} @skipped_tests;
# 196 source files
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
FM210.f
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
    if (@ARGV == 1 and $ARGV[0] eq '-h' or $ARGV[0] eq '--help' ) {
    die "
    * If you want to generate, compile and run the tests, please run `generate_and_run.sh`

    * To run a single test,

        $0 [name of test to run] [flags for refactorF4acc.pl]
    e.g.
        $0 FM330 -A

    * Valid flags for `refactorF4acc.pl`:

    " .`refactorF4acc.pl -h 2>&1`;
    }

    my $src = shift @ARGV;
    $src=~s/^\.\.\///;
    if ($src!~/\.f$/) {
        $src.='.f';
    }
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
    say "TEST CASE $run: $src";
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
MAX_LINE_LENGTH = 72
EXT = .f95
IGNORE_ERRORS = 1

ENDCFG

    close $CFG;
    system("cp ../$src .");
    say "refactorF4acc.pl -w 0 -c rf4a_$prog.cfg $flags -g $prog";
    system("refactorF4acc.pl -w 0 -c rf4a_$prog.cfg $flags -g $prog");
    if ($batch==1) {
    system("rm -f $src");
    system("rm -f rf4a_$prog.cfg");
    if (-e "RefactoredSources/${src}95" ) {
        system("cp RefactoredSources/${src}95 ../RefactoredSources");
    } else {
        say "Generation failed for ${src}95";
    }
    }

}


say "TOTAL TESTS: ".scalar(@sources);
say "TESTS RUN: $run";
say "SKIPPED: $skipped";

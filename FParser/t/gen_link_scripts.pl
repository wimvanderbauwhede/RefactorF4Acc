#!/usr/bin/perl
use warnings;
use strict;
my @fs=qw(
test_EvalExpr.hs
test_F95ArgDeclParser.hs
test_F95OpenACCParser.hs
test_F95SrcIO.hs
test_Main.hs
test_OpenCLAPIGenerator.hs
);

# Clean up
system("rm *.o *.hi");
system('rm ../F95ParserCommon.hi');
system('rm ../F95ParserCommon.o');
system('rm -Rf tmp');
mkdir 'tmp';
# Create target folder
system('rm -Rf ../TestHarnessBinaries');
system('mkdir -p ../TestHarnessBinaries/tbin');

for my $f (@fs) {
    print $f,"\n";
    my $n = $f;
    $n=~s/\.hs//;
# remove binaries    
    if (-x $n) {
        unlink $n;
    }
    system("./prepare_for_linking.sh $f > tmp.log");
    system("grep $n.o tmp.log | grep gcc > ../TestHarnessBinaries/tbin/link_$n.sh");
    system("mv $n.o ../TestHarnessBinaries/tbin");
    system("mv $n.hi ../TestHarnessBinaries/tbin");
}

system('cp -r tmp ../TestHarnessBinaries/tbin/');

system('cp ../F95ParserCommon.hi ../TestHarnessBinaries');
system('cp ../F95ParserCommon.o ../TestHarnessBinaries');

system('cp NormaliseF95Code.hi ../TestHarnessBinaries/tbin');
system('cp NormaliseF95Code.o ../TestHarnessBinaries/tbin');
system('cp F95ArgDeclParserTestRefs.hi ../TestHarnessBinaries/tbin');
system('cp RunTestWV.hi ../TestHarnessBinaries/tbin');
system('cp RunTestWV.o ../TestHarnessBinaries/tbin');


system('cp README ../TestHarnessBinaries');




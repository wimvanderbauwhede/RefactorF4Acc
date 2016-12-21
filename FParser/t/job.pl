@fs=qw(
test_EvalExpr.hs
test_F95ArgDeclParser.hs
test_F95OpenACCParser.hs
test_F95SrcIO.hs
test_Main.hs
test_OpenCLAPIGenerator.hs
);
system("rm *.o *.hi");
for my $f (@fs) {
    print $f,"\n";
    my $n = $f;
    $n=~s/\.hs//;
    system("./prepare_for_linking.sh $f > tmp.log");
    system("grep $n.o tmp.log | grep gcc > link_$n.sh");
    unlink $n;
}

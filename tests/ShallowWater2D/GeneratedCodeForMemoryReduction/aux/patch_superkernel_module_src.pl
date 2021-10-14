#!/usr/bin/env perl
use v5.20;
use strict;
use warnings;

# WV: This patches the generated kernel source so that it can be built for reference.

# For the 2-D Shallow Water, the input arrays are wet, hzero and the outputs eta, h, u, v
# etan, un and vn are internal
# Remove the intent from arrays that are not args
my @temp_var_list=qw(
cov1
cov2
cov3
cov4
cov5
cov6
cov7
cov8
cov9
dfu1
dfv1
dfw1
diu1
diu3
diu4
diu5
diu6
diu7
diu8
diu9
nou1
nou3
nou4
nou5
nou6
nou7
nou8
nou9
sm
);

# my $get_global_id='
#     subroutine get_global_id(idx,dim)
#     integer, intent(out) :: idx
#     integer, intent(in) :: dim
#     integer :: global_id
#     common /ocl/ global_id
#     idx = dim ! dummy
#     idx = global_id
#     end subroutine get_global_id
# ';

my %temp_vars = map {$_ => 1} @temp_var_list;
my @superkernel_files=glob('../module_*_superkernel.f95');
if (scalar @superkernel_files>1) {
    die 'Too many superkernel files!';
}
my $superkernel_file = shift @superkernel_files;

open my $SKMF, '<', $superkernel_file or die $!;
my @superkernel_file_lines = <$SKMF>;
close $SKMF;

$superkernel_file=~s/^\.\.\///;
open $SKMF, '>', "$superkernel_file" or die "$!";

for my $line (@superkernel_file_lines) {

    if ($line=~/intent.+?::\s+(\w+)/) {
        my $var = $1;
        if (exists $temp_vars{$var}) {
            $line=~s/\s*,\s*intent\(\w+\)//;
        }
    }
    print $SKMF $line;
    # if ($line=~/^\s*contains\s*$/) {
    #     print $SKMF $get_global_id;
    # }

}
close $SKMF;

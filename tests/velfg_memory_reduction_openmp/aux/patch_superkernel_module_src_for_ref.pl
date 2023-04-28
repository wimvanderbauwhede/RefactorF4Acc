#!/usr/bin/env perl
use v5.20;
use strict;
use warnings;

use Cwd;
use Carp qw(croak);
my $wd=cwd;
if ($wd!~/Build-reference/) {
    die "Run this script in 'Build-reference'\n";
}


# WV: This patches the generated kernel source so that it can be built for reference.

# Remove the intent from arrays that are not args
# Add definition of get_global_id
# my @temp_var_list=qw(
# cov1
# cov2
# cov3
# cov4
# cov5
# cov6
# cov7
# cov8
# cov9
# dfu1
# dfv1
# dfw1
# diu1
# diu3
# diu4
# diu5
# diu6
# diu7
# diu8
# diu9
# nou1
# nou3
# nou4
# nou5
# nou6
# nou7
# nou8
# nou9
# sm
# );


my $kernel_sig='subroutine velfg_superkernel(f,g,h,dzn,u,v,w,dx1,dy1,dzs,state_ptr, global_id, &
     diu1, diu2, diu3, diu4, diu5, diu6, diu7, diu8, diu9, &
     cov1, cov2, cov3, cov4, cov5, cov6, cov7, cov8, cov9, &
     nou1, nou5, nou9, nou2, nou3, nou4, nou6, nou7, nou8, &
     dfu1, dfv1, dfw1 &
     )';


# my %temp_vars = map {$_ => 1} @temp_var_list;
my @superkernel_files=glob('../module_*_superkernel.f95');
if (scalar @superkernel_files>1) {
    die 'Too many superkernel files!';
}
my $superkernel_file = shift @superkernel_files;

open my $SKMF, '<', $superkernel_file or die $!;
my @superkernel_file_lines = <$SKMF>;
close $SKMF;
# local modified copy
$superkernel_file=~s/^\.\.\///;
my $superkernel_dyn_file = $superkernel_file;
$superkernel_dyn_file=~s/\./-dyn./;
# system("cp $superkernel_file $superkernel_dyn_file");

open $SKMF, '>', "$superkernel_dyn_file" or die "$!";

for my $line (@superkernel_file_lines) {
    if ($line=~/subroutine\s+\w+_superkernel\(/) {
        say $SKMF $kernel_sig;
    } else {
        $line=~s/300/150*WM/g;
        print $SKMF $line;
    }

}
close $SKMF;

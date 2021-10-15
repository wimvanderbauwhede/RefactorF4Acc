#!/usr/bin/env perl
use v5.20;
use strict;
use warnings;

# Add an implementation for `get_global_id` and remove the intent for vars that are not stage kernel args.
use Cwd;
my $wd=cwd;
if ($wd!~/MemoryReduction$/) {
    die "Run this script in 'MemoryReduction'\n";
}

my $for_inlining = 0;
if (@ARGV) {

if ($ARGV[0] eq '-i') {
    $for_inlining = 1;
}
else {
   die "The only supported option is -i to patch before inlining\n";
}

}

my $get_global_id='
    subroutine get_global_id(idx,dim)
    integer, intent(out) :: idx
    integer, intent(in) :: dim
    integer :: global_id
    common /ocl/ global_id
    idx = dim ! dummy
    idx = global_id
    end subroutine get_global_id
';

my $module_global_id='
module module_global_id
    contains
    subroutine get_global_id(idx,dim)
        integer, intent(out) :: idx
        integer, intent(in) :: dim
        integer :: global_id
        common /ocl/ global_id
        idx = dim ! dummy
        idx = global_id
    end subroutine get_global_id

end module module_global_id
';

if (not -e 'Generated/module_global_id.f95') {
open my $MG, '>', 'Generated/module_global_id.f95' or die $!;
print $MG $module_global_id;
close $MG;
} elsif ($for_inlining) {
    unlink 'Generated/module_global_id.f95';
}

my @superkernel_files=glob('Generated/module_*_superkernel.f95');
if (scalar @superkernel_files>1) {
    die 'Too many superkernel files!';
}
my $superkernel_file = shift @superkernel_files;

open my $SKMF, '<', $superkernel_file or die $!;
my @superkernel_file_lines = <$SKMF>;
close $SKMF;
    $superkernel_file=~s/^\.\.\///;
open $SKMF, '>', "$superkernel_file" or die "$!";


my %stage_kernel_args=();
my $has_global_id_decl=0;

for my $line (@superkernel_file_lines) {
        if (not $for_inlining and $line=~/^module module/) {
            print $SKMF $line;
            print $SKMF 'use module_global_id'."\n";
            next;
        }
    # if ($line=~/integer\s*,\s*intent\(\w+\)\s+::\s+global_id/) {
    # $has_global_id_decl=1
    # }
    if ($line=~/subroutine\s+stage_kernel_\d+\(([\w,\s]+)\)/) {
        my $args_str = $1;
        my @args = split(/\s*,\s*/,$args_str);
        %stage_kernel_args = map {$_=>1} @args;
    }
    if ($line=~/intent\(\w+\)\s*::\s*(\w+)/) {
        my $var = $1;
        if (not exists $stage_kernel_args{$var}) {
            $line=~s/,\s*intent\(\w+\)//;
        }
    }
    print $SKMF $line;
#    if ($line=~/^\s*contains\s*$/) {
#        print $SKMF $get_global_id;
#    }

}
close $SKMF;

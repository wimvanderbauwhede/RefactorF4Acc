#!/usr/bin/perl

use v5.30;
use strict;
use warnings;
our $V=1;
# To be run in mem_reduced_inlined/Generated/Patched after the inliner and patch_inlined_code was run on the mem-reduced code

use Cwd;
use Carp qw(croak);
my $wd=cwd;
if ($wd!~/mem_reduced_inlined.Generated.Patched/) {
    die "Run this script in 'mem_reduced_inlined/Generated/Patched'\n";
}


# - Find the file with the main program. It is the file starting with 'gen_'
my @main_files =  glob('gen_*_superkernel.f95');
if (scalar @main_files>1) {
    die 'Too many main files!';
}
my $main_file = shift @main_files;


open my $SKMF, '<', $main_file or die $!;
my @main_file_lines = <$SKMF>;
close $SKMF;

my $main_file_omp_dyn =  $main_file;
$main_file_omp_dyn=~s/\.f95/_omp_dyn.f95/;

open $SKMF, '>', "$main_file_omp_dyn" or die "$!";
my $sub_sig=0;
my @alloc_lines = ();
my @dealloc_lines = ();
my $alloc=0;
my $global_id_do=0;
my $skip=0;
for my $line (@main_file_lines) {
    $skip=0;

    $line =~/^\s*program\s+main/ && do {
        $skip=1;
        print $SKMF $line;
        # define MM (WM*WM)
        say $SKMF
'
#ifdef WITH_OPENMP    
use omp_lib
#endif';
    };

    $line=~/integer,\s*parameter\s*::\s*[ij]p/ && do {
        say $SKMF $line; $skip=1;
    };
    
    $line=~/dimension\((.+)\)\s+::\s+(\w+)/ && $line!~/timestamp/ && do { 
        my $dim = $1;
        my $var = $2;
        if ($var!~/^d[xyz]/)  {
        push @alloc_lines, "allocate(${var}(${dim}))"; #_8*MM
        push @dealloc_lines, "deallocate(${var})";
        } else {
        push @alloc_lines, "allocate(${var}(${dim}))";#_8*WM
        push @dealloc_lines, "deallocate(${var})";

        }
        my $dyn_line=$line;
        my $stat_line=$line;
        # dimension(1:92*(150*WM+2)*(150*WM+3)) ::
        # allocatable
        # $stat_line =~s/$dim/${dim}_8*MM/;
        $dyn_line =~s/dimension.+?::/allocatable ::/;
        $dyn_line =~s/\s*$/(:)/;
        say $SKMF '#ifdef DYN_ALLOC';
        say $SKMF $dyn_line;
        say $SKMF '#else';
        print $SKMF $stat_line;
        say $SKMF '#endif';
        $skip=1;
    };
    $alloc==0 && $line=~/\#endif/  && do { # FIXME, VERY AD-HOC
        print $SKMF $line; $skip=1;
        $alloc=1;
        say $SKMF '#ifdef DYN_ALLOC';
        for my $alloc_line (@alloc_lines) {
            say $SKMF $alloc_line;
        }
        say $SKMF '#endif';
    };

    $line=~/do\s+global_id/ && do {
        $global_id_do=1;
        say $SKMF '#ifdef WITH_OPENMP
!$OMP PARALLEL DO
#endif'
    };

    $global_id_do==1 && $line=~/end do/ && do {
        print $SKMF $line; $skip=1;
        $global_id_do=0;
        say $SKMF '#ifdef WITH_OPENMP
!$OMP END PARALLEL DO
#endif'
    };

    $line=~/end\s+program/ && do {
        say $SKMF '#ifdef DYN_ALLOC';
                for my $dealloc_line (@dealloc_lines) {
            say $SKMF $dealloc_line;
        }
        say $SKMF '#endif';
        print $SKMF $line;
        $skip=1;
    };    
    print $SKMF $line unless $skip;
}
close $SKMF;
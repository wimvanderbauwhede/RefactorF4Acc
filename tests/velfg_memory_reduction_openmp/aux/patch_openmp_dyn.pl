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
my @main_files =  glob('gen_*.f95');
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
for my $line (@main_file_lines) {

    $line=~/do\s+global_id/ && do {
        $global_id_do=1;
        say $SKMF '#ifdef WITH_OPENMP
!$OMP PARALLEL DO
#endif'
    };

    $line=~/end\s+program/ && do {
        say $SKMF '#ifdef DYN_ALLOC';
                for my $dealloc_line (@dealloc_lines) {
            say $SKMF $dealloc_line;
        }
        say $SKMF '#endif';
    };

    print $SKMF $line;

    $line =~/program\s+main/ && do {
        say $SKMF
'#define MM (WM*WM)
#ifdef WITH_OPENMP    
use omp_lib
#endif';
    };
    
    $line=~/dimension\((.+)\)\s+::\s+(\w+)/ && do { 
        my $dim = $1;
        my $var = $2;
        push @alloc_lines, "allocate(${var}(${dim}_8*MM))";
        push @dealloc_lines, "deallocate(${var})";
        my $dyn_line=$line;
        my $stat_line=$line;
        $stat_line =~s/$dim/${dim}_8*MM/;
        $dyn_line =~s/dimension.+?\)/allocatable/;
        say $SKMF '#ifdef DYN_ALLOC';
        print $SKMF $dyn_line;
        say $SKMF '#else';
        print $SKMF $stat_line;
        say $SKMF '#endif';
    };
    $alloc==0 && $line=~/\s=\s/ && do { # FIXME, VERY AD-HOC
        $alloc=1;
        for my $alloc_line (@alloc_lines) {
            say $SKMF $alloc_line;
        }
    };
    $global_id_do==1 && $line=~/end do\s+global_id/ && do {
        $global_id_do=0;
        say $SKMF '#ifdef WITH_OPENMP
!$OMP END PARALLEL DO
#endif'
    };

}
close $SKMF;
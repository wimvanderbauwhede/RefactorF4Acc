#!/usr/bin/perl 
use v5.30;
use strict;
use warnings;
our $V=1;

# To be run in MemoryReduction/Generated 
# Substitute the parameters from the original module
# Add `pure` to the subroutine declarations
# Add a module declaration for get_global_id

use Cwd;
use Carp qw(croak);
use Data::Dumper;
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
# Clean up


my @orig_superkernel_files=glob('../module_*_superkernel.f95');
if (scalar @orig_superkernel_files>1) {
    die 'Too many superkernel files!';
}
my $orig_superkernel_file = shift @orig_superkernel_files;
# Get the parames from the original superkernel
my %params=();
open my $SMF, '<', $orig_superkernel_file or die $!;
while ( my $line = <$SMF>) {
    if ($line=~/integer\s*,\s*parameter\s*::\s*(\w+)\s*=\s*(\d+)/) {
        my $par =$1;
        my $val = $2;
        $params{$par}=$val;
    }
}
close $SMF;


# Patch the _scal files
# We need to substitute the parameters from the original module, so get them first

my @scal_funcs = glob('Scalarized/*.f95');
for my $scal_f_name (@scal_funcs) {

    my $patched_f_name = $scal_f_name;
    $patched_f_name =~s/Scalarized.//;
    open my $SFF, '<', $scal_f_name or die $!;
    my @lines = <$SFF>;
    close $SFF;
    open $SFF, '>', "Generated/$patched_f_name" or die $!;
    
    my $has_global_id_decl=0;
    my $first_decl=1;
    for my $line (@lines) {
        if (not $for_inlining and $line=~/^module singleton/) { 
            print $SFF $line;
            print $SFF 'use module_global_id'."\n";
            next;            
        }
        if ($line=~/dimension/) { 
            for my $par (sort keys %params) {
                my $val = $params{$par};
                $line=~s/\b$par\b/$val/;
            }            
        }
        # if ($line=~/integer\s+::\s+global_id/) {
        #     $line=~s/integer/integer, intent(In)/;
        #     $has_global_id_decl=1
        #     }
        if ($line=~/subroutine\s+$scal_f_name\s*\(/) {
            $line=~s/$scal_f_name\s*\(/$scal_f_name(global_id,/;
            $line=~s/subroutine/pure subroutine/;
        } 
        # elsif ($line=~/get_global_id/) {
        #     $line = '!'.$line;
        # }
        # if ($line=~/globalIdInitialisation/ and $has_global_id_decl==0) {
        #     say $SFF "integer, intent(In) :: global_id";
        #     $has_global_id_decl=1;
        # }
        # if ($line!~/::/ and $line=~/=/ and $first_decl==1 and $has_global_id_decl==0) { 
        #     say $SFF "integer, intent(In) :: global_id";
        #     $has_global_id_decl=1;
        #     $first_decl=0;
        # }

        print $SFF $line;
    }
    close $SFF;
}


# Make sure the SCons file is correct
my $test_scons_for_patched_scal_funcs = `grep Scalarized Generated/SConstruct`;
my $test_scons_for_global_id= `grep module_global_id Generated/SConstruct`;
my $test_scons_for_inlining =  ($for_inlining && $test_scons_for_global_id) || (!$for_inlining and !$test_scons_for_global_id);
if ($test_scons_for_patched_scal_funcs or $test_scons_for_inlining) {
my $maybe_module_global_id = $for_inlining ? '' : ", 'module_global_id.f95'" ;
open my $SC, '>', 'Generated/SConstruct' or die $!;

die 'WV 2021-10-06: The source file names need to be adapted!';
my $sconstruct_file = <<ENDSC;
import os
  
FC=os.environ.get('FC')

fsources = ['gen_velfg_superkernel.f95', 'module_gen_velfg_superkernel.f95', 'velfg_map_133.f95', 'velfg_map_218.f95', 'velfg_map_76.f95' $maybe_module_global_id ]

FFLAGS = ['-Wall','-cpp','-O3','-m64','-ffree-form','-ffree-line-length-0','-fconvert=little-endian','-frecord-marker=4']

envF=Environment(F95=FC,LINK=FC,F95FLAGS=FFLAGS,F95PATH=['.' ,'/usr/local/include'])

envF.Program('gen_velfg_superkernel',fsources,LIBS=['m'],LIBPATH=['.' ,'/usr/lib','/usr/local/lib'])

ENDSC

print $SC $sconstruct_file;
close $SC;
}


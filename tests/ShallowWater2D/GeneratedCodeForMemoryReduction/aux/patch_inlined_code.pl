#!/usr/bin/perl 

use v5.30;
use strict;
use warnings;
our $V=1;

# Patching for OpenCL is different 
my $OCL=0;
if (@ARGV && $ARGV[0] eq 'OpenCL') {
    $OCL=1;
}
# To be run in mem_reduced_inlined/Generated after the inliner was run on the mem-reduced code

# TODO: make sure global_id is added to args in  gen_*_superkernel.f95 and *_superkernel.f95

# - Clean up
# - Get the params from the original superkernel
# - Find the file with the main program. It is the file starting with 'gen_'
# - From the superkernel file, get the module name, subroutine name and stage kernel name(s)
# - In the superkernel file, in the superkernel subroutine, add the use declarations for the stage kernels
# - In the main file:
#    - get the module line and correct the name
# - In the stage kernel file
#    - find all unique calls     
# - We need to patch the call to deal with get_global_id, for now => not for OpenCL
# - Replace `call get_global_id(idx,0,global_id)` by `idx=global_id` => not for OpenCL
# - Patch the _scal files
# - We need to substitute the parameters from the original module
# - Create a SConstruct file if it does not exists

use Cwd;
use Carp qw(croak);
my $wd=cwd;
if ($wd!~/mem_reduced_inlined.Generated/) {
    die "Run this script in 'mem_reduced_inlined/Generated'\n";
}

# Clean up
unlink glob('f_*');
unlink 'module_gen_*_superkernel.f95';

my @orig_superkernel_files=glob('../../module_*_superkernel.f95');
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

my $min_dim = $params{'ip'}*$params{'jp'}*$params{'kp'};

# - Find the file with the main program. It is the file starting with 'gen_'
    my @main_files =  glob('gen_*.f95');
    if (scalar @main_files>1) {
        die 'Too many main files!';
    }
    my $main_file = shift @main_files;
    say "main_file: $main_file" if $V;
    my $superkernel_file = $main_file;$superkernel_file=~s/^gen_//;
    say "superkernel_file: $superkernel_file" if $V;

# - From the superkernel file, get the module name, subroutine name and stage kernel name(s)
    my $module_name = `grep -E '^\\s*module' $superkernel_file`;
    $module_name=~s/^\s*module\s+//;
    chomp $module_name;
    say "module_name $module_name" if $V;
    my $sub_name = `grep -E '^\\s*subroutine' $superkernel_file`;
    $sub_name=~s/^\s*subroutine\s+//;
    $sub_name=~s/\s*\(.+$//;
    chomp $sub_name;
    say "sub_name $sub_name" if $V;
    say "grep -E '^\\s*call\\s+.+_kernel' $superkernel_file" if $V;
    my @stage_kernel_names = `grep -E '^\\s*call\\s+.+_kernel' $superkernel_file`;
    for my $stage_kernel_name (@stage_kernel_names) {
        chomp $stage_kernel_name;
        $stage_kernel_name=~s/^\s*call\s+//;
        $stage_kernel_name=~s/\s*\(.+$//;
        
        say "stage_kernel_name <$stage_kernel_name>" if $V;
    }
    
    mkdir 'Patched';

# - In the superkernel file, in the superkernel subroutine, add the use declarations for the stage kernels
    open my $SKMF, '<', $superkernel_file or die $!;
    my @superkernel_file_lines = <$SKMF>;
    close $SKMF;
     
    open $SKMF, '>', "Patched/$superkernel_file" or die "$!";
    
    for my $line (@superkernel_file_lines) {
        print $SKMF $line;
        
        if ($line=~/^\s*subroutine\s+$sub_name/) { 
            for my $stage_kernel_name (@stage_kernel_names) {
                say $SKMF "use singleton_module_${stage_kernel_name}, only: ${stage_kernel_name}";
            }
        }
    }
    close $SKMF;
    
    system "cat Patched/$superkernel_file" if $V;
    
# - In the main file:
    # - get the module line and correct the name
    open my $MF, '<', $main_file or die $!;
    my @main_file_lines = <$MF>;
    close $MF;
    open $MF, '>', "Patched/$main_file"  or die $!;
    # my $min_dim=1e12;
    for my $line (@main_file_lines) {
        $line=~/dimension\s*.1:(\d+)/ && do {
            my $dim=$1;
            if ($dim<$min_dim) {
                $min_dim=$dim;
            }
        };
    }

    for my $line (@main_file_lines) {
        
        if ($line=~/^\s*use.+only\s*:\s+$sub_name/) {
            say $MF "use $module_name, only : $sub_name";
        } elsif ($line=~/do\s+global_id\s+=\s+1,\s*\d+/) { 
            my $rline=$line;
            $rline=~s/,\s*\d+/, $min_dim/;
            print $MF $rline;
        } else {
            print $MF $line;
        }
    }
    close $MF;
    system "cat Patched/$main_file" if $V;
    
# - In the stage kernel file
my %scalar_functions=();
for my $stage_kernel_name (@stage_kernel_names) { 
    my $stage_kernel_file=$stage_kernel_name.'.f95';
    open my $SKF, '<', $stage_kernel_file or die $!;
    my @stage_kernel_file_lines = <$SKF>;
    close $SKF;
    
    # - find all unique calls     
    for my $line (@stage_kernel_file_lines) {
        if ($line=~/^\s*call\s+(\w+?_scal)/) {
            my $scal_f_name=$1;
            $scalar_functions{$scal_f_name}=1;
            if (!$OCL) {
                $line=~s/$scal_f_name\s*\(/$scal_f_name(global_id,/
            }
        }
    }
    open $SKF, '>', "Patched/$stage_kernel_file" or die $!;
    my %stage_kernel_args=();
    my $has_global_id_decl=0;
    my $first_call_to_get_global_id=1;
    for my $line (@stage_kernel_file_lines) {
        $line=~/use singleton_module/ && next;
        if ($line=~/integer\s*,\s*intent\(\w+\)\s+::\s+global_id/) {
            $has_global_id_decl=1
            }        
            if (!$OCL) {
        if ($line=~/subroutine\s+stage_kernel_\d+\(([\w,\s]+)\)/) {
            my $args_str = $1;
            my @args = split(/\s*,\s*/,$args_str);
            %stage_kernel_args = map {$_=>1} @args;
            $line=~s/\)\s*$/,global_id)/;
            $line.="\n";
        }
    }
        if ($line=~/intent\(\w+\)\s*::\s*(\w+)/) {
            my $var = $1;
            if (not exists $stage_kernel_args{$var}) {
                $line=~s/,\s*intent\(\w+\)//;
            }
        }
        if ($line=~/integer :: global_id___/) {next;}
        $line=~s/global_id___\w+\b/global_id/g;
        # replace `call get_global_id(idx,0,global_id)` by `idx=global_id`
        if ($line=~/^\s*call\s+get_global_id/ ) {
        if (!$OCL) {
            if ( $first_call_to_get_global_id) {
                say $SKF "integer, intent(In) :: global_id" unless $has_global_id_decl;
                say $SKF "idx = global_id"; 
                $first_call_to_get_global_id=0;
            } else {
                next;
            }
        }
        } else {
            print $SKF $line;
        }
    }
    close $SKF;
    system "cat Patched/$stage_kernel_file" if $V;
}

# Patch the _scal files
# We need to substitute the parameters from the original module, so get them first


for my $scal_f_name (sort keys %scalar_functions) {
    my $f_name = $scal_f_name;
    $f_name=~s/_scal/.f95/;
    open my $SFF, '<', '../../MemoryReduction/Scalarized/'.$f_name or die $!;
    my @lines = <$SFF>;
    close $SFF;
    open $SFF, '>', "Patched/$f_name" or die $!;
    my $has_global_id_decl=0;
    my $first_decl=1;
    for my $line (@lines) {

        if ($line=~/dimension/) {
            for my $par (sort keys %params) {
                my $val = $params{$par};
                $line=~s/\b$par\b/$val/;
            }
        }
        if ($line=~/integer\s+::\s+global_id/) {
            $line=~s/integer/integer, intent(In)/ unless $OCL;
            $has_global_id_decl=1
            }
        if ($line=~/subroutine\s+$scal_f_name\s*\(/) {
            $line=~s/$scal_f_name\s*\(/$scal_f_name(global_id,/ unless $OCL;
            $line=~s/subroutine/pure subroutine/;
        } elsif (!$OCL and $line=~/get_global_id/) {
            $line = '!'.$line;
        }
        if ($line=~/globalIdInitialisation/ and $has_global_id_decl==0) {
            if (!$OCL) {
                say $SFF "integer, intent(In) :: global_id";
            } else {
            say $SFF "integer :: global_id";
        }
            $has_global_id_decl=1;
        }
        if ($line!~/::/ and $line=~/=/ and $first_decl==1 and $has_global_id_decl==0) { 
            if (!$OCL) {
            say $SFF "integer, intent(In) :: global_id";
        } else {
            say $SFF "integer :: global_id";
        }
            $has_global_id_decl=1;
            $first_decl=0;
        }

        print $SFF $line;
    }
    close $SFF;
    system "cat Patched/$f_name" if $V;
}

# Create a SConstruct file if it does not exists

if (not -e 'Patched/SConstruct') {
    die 'WV 2021-10-06 The source file names need to be adapted';

open my $SC, '>', 'Patched/SConstruct' or die $!;
my $sconstruct_file = <<'ENDSC';
import os
  
FC=os.environ.get('FC')

fsources = ['gen_velfg_superkernel.f95', 'stage_kernel_1.f95',
'velfg_map_133.f95', 'velfg_map_218.f95', 'velfg_map_76.f95', 
         'velfg_superkernel.f95']



FFLAGS = ['-flto','-Wall','-cpp','-Ofast','-m64','-ffree-form','-ffree-line-length-0','-fconvert=little-endian','-frecord-marker=4']

envF=Environment(F95=FC,LINK=FC,LINKFLAGS=['-Ofast','-flto'],F95FLAGS=FFLAGS,F95PATH=['.' ,'/usr/local/include'])

envF.Program('prog.exe',fsources,LIBS=['m'],LIBPATH=['.' ,'/usr/lib','/usr/local/lib'])

ENDSC

print $SC $sconstruct_file;
close $SC;

}

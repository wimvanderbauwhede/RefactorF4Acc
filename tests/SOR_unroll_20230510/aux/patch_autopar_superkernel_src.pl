#!/usr/bin/perl 

use v5.30;
use strict;
use warnings;
our $V=1;

# - We need to patch the call to deal with get_global_id, for now
# - Replace `call get_global_id(idx,0,global_id)` by `idx=global_id`
# - Patch the _scal files
# - We need to substitute the parameters from the original module
# - Create a SConstruct file if it does not exists

use Cwd;
use Carp qw(croak);
my $wd=cwd;
if ($wd!~/refactored-src_\d.src_\d_postcpp.Autopar_GPU/) {
    die "Run this script in 'refactored-src_{UNROLL}/src_{UNROLL}_postcpp/Autopar_GPU'\n";
}

# Clean up
# unlink 'module_sor_superkernel_superkernel_init.f95';
# unlink 'sor_superkernel_host.f95';

my @orig_superkernel_files=glob('./module_*_superkernel.f95');
if (scalar @orig_superkernel_files>1) {
    die 'Too many superkernel files!';
}
my $superkernel_file = shift @orig_superkernel_files;


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

    mkdir 'Patched';

# - In the superkernel file, in the superkernel subroutine, add the use declarations for the stage kernels
    open my $SKMF, '<', $superkernel_file or die $!;
    my @superkernel_file_lines = <$SKMF>;
    close $SKMF;

    open $SKMF, '>', "Patched/$superkernel_file" or die "$!";
    my %temp_arrays=();
    for my $line (@superkernel_file_lines) {
        if ($line=~/InOut.+?::\s*(\w+)/) {
            $temp_arrays{$1}=$1;
        }
    }
    for my $line (@superkernel_file_lines) {

        if ($line=~/^\s*call\s+\w+\s*\(/) {
            if ($line=~/call\s+get_global_id/) {
                $line = '! '.$line;
            } else {
                $line=~s/\(/(global_id,/;
            }
        }
        elsif ($line=~/^\s*subroutine\s+\w+\s*\(/ ) {
            $line=~s/\(/(global_id,/;
            if  ($line=~/superkernel\(/) {
                my @chunks = split(/\s*,\s*/,$line);
                my @red_chunks = grep { not exists $temp_arrays{$_} } @chunks;
                $line =join(', ',@red_chunks);
                  $line .= "\n" . '    integer, intent(In) :: global_id'."\n";
            }
        }
        elsif ($line=~/InOut/i) {
            $line=~s/,\s*intent.InOut.//i;
        }
        $line=~s/superkernel_//;
        print $SKMF $line;
        print $line;
    }
    close $SKMF;
    say '';
    # system "cat Patched/$superkernel_file" if $V;


# Create a SConstruct file if it does not exists

# if (not -e 'Patched/SConstruct') {

# open my $SC, '>', 'Patched/SConstruct' or die $!;
# my $sconstruct_file = <<'ENDSC';
# import os
  
# FC=os.environ.get('FC')

# fsources = ['gen_velfg_superkernel.f95', 'stage_kernel_1.f95',
# 'velfg_map_133.f95', 'velfg_map_218.f95', 'velfg_map_76.f95', #'les_map_87.f95' , 'les_map_107.f95' ,
#          'velfg_superkernel.f95']



# FFLAGS = ['-flto','-Wall','-cpp','-Ofast','-m64','-ffree-form','-ffree-line-length-0','-fconvert=little-endian','-frecord-marker=4']

# envF=Environment(F95=FC,LINK=FC,LINKFLAGS=['-Ofast','-flto'],F95FLAGS=FFLAGS,F95PATH=['.' ,'/usr/local/include'])

# envF.Program('prog.exe',fsources,LIBS=['m'],LIBPATH=['.' ,'/usr/lib','/usr/local/lib'])

# ENDSC

# print $SC $sconstruct_file;
# close $SC;

# }

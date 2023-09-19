#!/usr/bin/perl

use v5.30;
use strict;
use warnings;
our $V=1;
# To be run in mem_reduced_inlined/Generated after the inliner was run on the mem-reduced code

# TODO: make sure global_id is added to args in gen_sor_superkernel.f95 and sor_superkernel.f95

# These steps do not change any source code:
# - Clean up (just deletes unneeded files)
# - Get the parames from the original superkernel
# - Find the file with the main program. It is the file starting with 'gen_'
# - From the superkernel file, get the module name, subroutine name and stage kernel name(s)

# These steps change source code:
# - In the superkernel file (sor_superkernel.f95), in the superkernel subroutine, add the use declarations for the stage kernel(s)
# - In the main file (gen_sor_superkernel.f95):
#    - get the module line and correct the name, it should be singleton_module_sor_superkernel, in sor_superkernel.f95
# - In the stage kernel file (stage_kernel_1.f95)
#   - remove use decls
#   - We need to patch the call to deal with get_global_id, for now => obsolete
#   - Replace `call get_global_id(idx,0,global_id)` by `idx=global_id` => obsolete
# - Patch the _scal files => I think that is obsolete!
#   - We need to substitute the parameters from the original module
#   - Create a SConstruct file if it does not exists

use Cwd;
use Carp qw(croak);
my $wd=cwd;
if ($wd!~/mem_reduced_inlined.Generated/) {
    die "Run this script in 'mem_reduced_inlined/Generated'\n";
}

die 'Provide the unroll factor as arg'."\n" unless @ARGV;
my $unroll = shift @ARGV;

my $niters_unroll = 12/$unroll;

# Clean up
unlink glob('f_*');
unlink 'module_gen_sor_superkernel.f95';

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

my $min_dim = ($params{'ip'}/2).'*WM*'.($params{'jp'}/2).'*WM*'.$params{'kp'};

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
    my $sub_sig=0;
    for my $line (@superkernel_file_lines) {
        if ($line=~/dimension/) {
            $line=~s/:\d+/:*/;
        }
        print $SKMF $line;

        if ($line=~/^\s*subroutine\s+$sub_name/) {
            if ($line!~/\&\s*$/) {
                for my $stage_kernel_name (@stage_kernel_names) {
                    say $SKMF "use singleton_module_${stage_kernel_name}, only: ${stage_kernel_name}";
                }
            } else {
                $sub_sig=1;
            }
        }
        if ($sub_sig==1 and $line!~/\&\s*$/) {
            $sub_sig=0;
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
    my $init=0;
    for my $line (@main_file_lines) {

        if ($line=~/^\s*use.+only\s*:\s+$sub_name/) {
            say $MF "use $module_name, only : $sub_name";
            } elsif ($line=~/implicit\s+none/) {
                print $MF $line;
                say $MF '     integer, parameter :: im='.$params{'im'};#100
                say $MF '     integer, parameter :: jm='.$params{'jm'};#100
                say $MF '     integer, parameter :: km='.$params{'km'};#80

        } elsif ($line=~/niters\s*=\s*(\d+)/) { my $niters=$1;
        $line=~s/$niters/$niters_unroll/;
        print $MF $line;
        } elsif ($line=~/\#endif/ and $init==0) {
            $init=1;
            print $MF $line;
             print $MF '
    do i = 1,(im+1)*(jm+1)*(km+1)
        rhs_0(i) = 1.0
        p0_0(i) = 1.0
    end do
';
    say $MF '';
     say $MF '';

        } elsif($line=~/end\s+program/) {
            print $MF '#ifdef CHECKSUM
    print *, p0_0((im+2)*(jm+2)*(km+2)/2+(jm+2)*(km+2)/2+(km+2)/2)
#endif';
            say $MF '';
            print $MF $line;
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
            # We need to patch the call to deal with get_global_id, for now
            $line=~s/$scal_f_name\s*\(/$scal_f_name(global_id,/
        }
    }
    open $SKF, '>', "Patched/$stage_kernel_file" or die $!;
    my %stage_kernel_args=();
    # my $has_global_id_decl=0;
    my $first_call_to_get_global_id=1;
    for my $line (@stage_kernel_file_lines) {
        # Remove use lines
        $line=~/use singleton_module/ && next;
        # strip intent
        if ($line=~/intent\(\w+\)\s*::\s*(\w+)/) {
            my $var = $1;
            if (not exists $stage_kernel_args{$var}) {
                $line=~s/,\s*intent\(\w+\)//;
            }
        }
        print $SKF $line;
    }
    close $SKF;
    system "cat Patched/$stage_kernel_file" if $V;
}

# Create a SConstruct file if it does not exists

if (not -e 'Patched/SConstruct') {

open my $SC, '>', 'Patched/SConstruct' or die $!;
my $sconstruct_file = <<'ENDSC';
import os

FC=os.environ.get('FC')

fsources = ['gen_sor_superkernel.f95', 'stage_kernel_1.f95', 'sor_superkernel.f95']

FFLAGS = ['-flto','-Wall','-cpp','-Ofast','-m64','-ffree-form','-ffree-line-length-0','-fconvert=little-endian','-frecord-marker=4']

envF=Environment(F95=FC,LINK=FC,LINKFLAGS=['-Ofast','-flto'],F95FLAGS=FFLAGS,F95PATH=['.' ,'/usr/local/include'])

envF.Program('prog.exe',fsources,LIBS=['m'],LIBPATH=['.' ,'/usr/lib','/usr/local/lib'])

ENDSC

print $SC $sconstruct_file;
close $SC;

}


sub decompose_num { (my $n) = @_;
    my $a=1;
    my $ip=300;my $jp=300;
    my @factors=();
    # 1. small or large?
    if ($n < ($ip-3)*($jp-3)) {
        # small
        $a =int($n/$ip); # e.g. 2
        warn "$n => $a " unless $a<=2;

        # now brute-force:
        for my $b (0 .. 3) {
            for my $off1 (-1 .. 3) {
                if ($n == $a*($ip+$off1)+$b) {
                    $a=($a==2?'2*':'');
                    return $a.'(150*WM+'.$off1.')'.($b==0?'':'+'.$b);
                }
            }
        }
    } else {
        # medium or large?
        if ($n > ($ip+3)*($jp+3)+3) {
            $a=int($n/(($ip-3)*($jp-3)));
            warn "$n => $a " unless $a<=2;
        } else {
            $a=1;
        }

        for my $b (0 .. 3) {
            for my $off1 (0.. 6) {
                for my $off2 (0..4) {
                    # warn $a*($ip+$off1)*($jp+$off2)+$b,"\n";
                    if ($n == $a*($ip+$off1)*($jp+$off2)+$b) {
                        $a=($a==2?'2*':'');
                        return $a.'(150*WM+'.$off1.')*(150*WM+'.$off2.')'.($b==0?'':'+'.$b);
                    }
                }
            }
        }
        for my $b (0 .. 6) {
            for my $off1 (0.. 6) {
                for my $off2 (0..4) {
                    # warn $a*($ip+$off1)*($jp+$off2)+$b,"\n";
                    if ($n == $a*($ip+$off1)*($jp+$off2)+$ip+$b) {
                        $a=($a==2?'2*':'');
                        return $a.'(150*WM+'.$off1.')*(150*WM+'.$off2.')+150*WM'.($b==0?'':'+'.$b);
                    }
                }
            }
        }
    }
}
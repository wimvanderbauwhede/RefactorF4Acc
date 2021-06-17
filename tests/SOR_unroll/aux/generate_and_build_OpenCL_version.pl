#!/usr/bin/env perl
use v5.10;
use strict;
use warnings;

# add the './aux' path to the list of include paths
BEGIN {
    push @INC, './aux';
};

use Cwd;
# A module to run the C preprocessor
use RunCpp qw( run_cpp );
# Mistery module
use RestoreStashedLines qw( restore_stashed_lines );
# This converts macro definitions from .h file to command line flag macro syntax
use MacroFileToCmdLine qw( macro_file_to_cmd_line_str );

use Data::Dumper;
use Getopt::Long;

=pod

# Name 

  generate_and_build_OpenCL_version.pl

# Description

The purpose of this script is to ...

# Prerequisites

# Source code and directory structure requirements

The compilers used by the script do not work on all Fortran 77 or Fortran 95 code. However, it is usually possible with little effort to change the code and selected the correct compilation options to make it work.

# TODO

Curren status: 
* 1.refactor works
* 2.autopar works

* next stage: 3.reduce (i.e. memory reduction)
Now I need to run `memory_reduction.pl -C` on the results from autopar:

    mkdir "mem_reduced$suffix";
    system("cp generated_src$suffix/module_sor_main_superkernel.f95 mem_reduced$suffix");
    chdir "mem_reduced$suffix";
    system('memory_reduction.pl -C');

That will create a result in mem_reduced$suffix/MemoryReduction/Generated
I need to copy the files from mem_reduced$suffix/MemoryReduction/Scalarized into Generated

    system("cp mem_reduced$suffix/MemoryReduction/Scalarized/* mem_reduced$suffix/MemoryReduction/Generated");

* next stage: 4.inline
I need to run the inliner, so create `rf4a_inline.cfg` and store the result in `mem_reduced_inlined$suffix`

    chdir  "mem_reduced$suffix/MemoryReduction/Generated";
    # Generate cfg
    system('refactorF4Acc.pl -c rf4a_inline.cfg');

* next stage: 5.convert (to OpenCL)
    
    chdir "mem_reduced_inlined$suffix";
    # generate cfg
    system('refactorF4Acc.pl -P translate_to_OpenCL -c rf4a_ocl.cfg');
    # final result should be in opencl$suffix





=cut

my $plat = 'GPU';
my $nth = 256;
my $nunits = 16;
my $suffix ='';

my $vvv=0;

my $help_message =<<ENDH;

        $0 [-d, --dev CPU|GPU|FPGA] [-s, --stage stage] [--nth #threads ] [--nunits #units]   

    The script takes the following (optional) arguments: 
        --dev: the target device: CPU or GPU. Default is $plat
        --nth: the number of threads per compute unit. Default is $nth  
        --nunits: the number of compute units (--nunits). Default is $nunits
        --stage: the stage of the conversion: refactor, autopar, convert, build.
        --suffix: an optional suffix applied to config file names and folders                 
    You can provide several stages separated with a comma. 
    If not given, the script will attempt to run all stages in one go. 

    The stages are:

    1. refactor: Refactor the F77 code into accelerator-ready F95 code. 
    2. autopar: Auto-parallelise the host code and generate the kernel in F95 syntax. 
    3. reduce: Remove intermediate arrays using rewrite rules
    4. inline: The reduce step generates lots of functions, inline them
    5. convert: Convert the kernel to OpenCL. 
    The OpenCL kernel code uses two macros, the number of threads per compute unit NTH and the number of compute units NUNITS. 
    These can be defined using the --nth and --nunits flags or in the file `macros_kernel.h`.
    6. build: Build the OpenCL Fortran code. The code is built using an auto-generated SConstruct file. 
    You can of course modify this file and build the code manually. The script will not overwrite an existing `Sconstruct.auto` file.
    
ENDH
my $help=0;

my $stages_str='refactor,autopar,convert,build';
my $use_separate_stash_step=0;
my $verbose;
GetOptions ('nth=i' => \$nth,                   
            'nunits=i' => \$nunits,
            'dev=s'   => \$plat,     # I know, not consistent.
            'stage=s' => \$stages_str,
            'stash' => \$use_separate_stash_step,
            'verbose'  => \$vvv,
            'help' => \$help,
            'suffix=i' => \$suffix
        ) or die("Error in command line arguments\n");

if ($help) { die $help_message; }        
my $wd = cwd();

my $VV=1;
my $vflag= $vvv ? '-b' : '';

if ($suffix) {
    $suffix='_'.$suffix;
}

my $main_src = 'test_sor_unroll.f95';

# TODO: These should be extracted from the source code using rf4a. It would be best to save these to a file when running the refactoring

my @kernel_sources=qw(
sor_main.f95
);

# TODO: These should be extracted from the source code using rf4a

my @iowrite_subs=qw(

);

# TODO: These should be extracted from the source code using rf4a, because they are the source used for building the code minus the kernel sources.
# However, that would probably result in many unused files being copied. So we could just copy the src folder 
#bondv1.f95
my @orig_sources=qw(
macros.h
macros_to_skip.h
);

#

my $iowrite_subs_str = join(' ',@iowrite_subs);
my $kernel_sources_str = join(' ',map {"./$_" } @kernel_sources);

my @sub_names = map {s/\.f95$//;$_ } @kernel_sources;

# This 30 character limit was picked ad-hoc by Gavin
my $superkernel_name = substr(join('_',@sub_names),0,30);
if (length($superkernel_name)==30) {
    $superkernel_name .= "_etc_superkernel"
} else {
    $superkernel_name .= "_superkernel"
}

my $TRUST_THE_COMPILER = 1 - $use_separate_stash_step;
my @stages = qw(
    refactor
    autopar
    reduce
    inline
    convert
    build
    );    
my @skip_stage = map {1} @stages;

my %stages = map { $_ => $_} split(/\s*,\s*/,$stages_str);
my $idx=0;
for my $stage (@stages) {
    if (exists $stages{$stage}) {
        $skip_stage[$idx] = 0;
    }
    ++$idx;
}


my $gen_dir = 'generated_src'.$suffix;
# if ($TRUST_THE_COMPILER==1) {
#     $gen_dir = 'generated_src'.$suffix;
# }

# The compiler fails if this directory does not exists
if (not -d $gen_dir) {
    mkdir $gen_dir;
}

my $src_dir = 'src'.$suffix;

my $refactored=0;

if (not $skip_stage[0]) { # Refactor

    my $rf4a_cfg = <<ENDCFG;
# Relative path to the original Fortran source code
SRCDIRS = src$suffix
# Relative path to the refactored Fortran source code
NEWSRCPATH = refactored-src$suffix
# Name of the subroutine to start from. If this is the main program, leave blank.
# TOP = 
EXT = .f95
# It's our own code, we know this is safe
RENAME_PARS_IN_INLINED_SUBS = 0
RENAME_VARS_IN_INLINED_SUBS = 0
# Need to do this for apf
FOLD_CONSTANTS = 1

ENDCFG
    
    open my $CFG, '>', "rf4a$suffix.cfg";
    print $CFG $rf4a_cfg;
    close $CFG;

    say($ENV{RF4A_DIR}.'/bin/'.'refactorF4acc.pl '."$vflag -c rf4a$suffix.cfg"); 
    system($ENV{RF4A_DIR}.'/bin/'.'refactorF4acc.pl '."$vflag -c rf4a$suffix.cfg");

    $refactored=1;
}

$src_dir =  'refactored-src'.$suffix.'/'.$src_dir ;

my @redundant_sources = qw(
sor.f95
sor_kernel.f95
sor_params.f95
sor_routines.f95
);

for my $red_src (@redundant_sources) {
    if (-e "$src_dir/$red_src") {
    unlink "$src_dir/$red_src";
    }
}

# Stage 1. Run the auto-parallelizing GPU compiler `AutoParallel-Fortran-exe`. The output is stored in `GeneratedCodeV2`
if (not $skip_stage[1]) {
    chdir $src_dir;
    my $dots = ($src_dir=~/\//)
        ? '../' x (scalar( split(/\//, $src_dir) ) - 1)
        : '';

    ##
    say '*NOTE 2018-03-07* 
    The `AutoParallel-Fortran` compiler has built-in handling of macros via the -D and -X flags. 
    This generates the same code as when using the `run_cpp.pl` and `restore_stashed_lines.pl` scripts. 
    ' if 0;
    
    system("touch macros.h");
    system("touch macros_to_skip.h");

    (my $defined_macros_str, my $undef_macros_str) = macro_file_to_cmd_line_str( './macros.h','-D');
    (my $macros_to_skip_str, my $empty_str) = macro_file_to_cmd_line_str('./macros_to_skip.h','-X');
    
    # say("AutoParallel-Fortran-exe $kernel_sources_str -out ../$dots$gen_dir/ -iowrite $iowrite_subs_str -main ./$main_src -plat $plat  $defined_macros_str $macros_to_skip_str $vflag" );
    
    # system("AutoParallel-Fortran-exe $kernel_sources_str -out ../$dots$gen_dir/ -iowrite $iowrite_subs_str -main ./$main_src  -plat $plat  $defined_macros_str $macros_to_skip_str $vflag" );    
    
    say("AutoParallel-Fortran-exe $kernel_sources_str -out ../$dots$gen_dir/ -main ./$main_src $vflag -plat $plat -N  -v"); 
    system("AutoParallel-Fortran-exe $kernel_sources_str -out ../$dots$gen_dir/ -main ./$main_src $vflag -plat $plat -N -v"); 
   
}

if (not $skip_stage[2]) { 
# Stage 2. reduce (i.e. memory reduction)
# Run `memory_reduction.pl -C` on the results from autopar:

    mkdir "mem_reduced$suffix" unless -d "mem_reduced$suffix";
    system("cp generated_src$suffix/module_sor_main_superkernel.f95 mem_reduced$suffix");
    chdir "mem_reduced$suffix";
    system('memory_reduction.pl -C');

# That will create a result in mem_reduced$suffix/MemoryReduction/Generated
# Copy the files from mem_reduced$suffix/MemoryReduction/Scalarized into Generated

    system("cp MemoryReduction/Scalarized/* MemoryReduction/Generated");
}
if (not $skip_stage[3]) { 
# Stage 3. inline
# Run the inliner

    chdir $wd;
    mkdir "mem_reduced_inlined$suffix" unless -d "mem_reduced_inlined$suffix";
    chdir "mem_reduced$suffix/MemoryReduction";

# Create `rf4a_inline.cfg` 
    my $rf4a_inline = <<ENDCFG;
# Relative path to the original Fortran source code
SRCDIRS = Generated
# Relative path to the refactored Fortran source code
NEWSRCPATH = ../../mem_reduced_inlined$suffix
# Name of the subroutine to start from. If this is the main program, leave blank.
# TOP = 
EXT = .f95
RENAME_PARS_IN_INLINED_SUBS = 0
RENAME_VARS_IN_INLINED_SUBS = 0
ONE_SUB_PER_MODULE = 0
ENDCFG
    
    open my $CFG, '>', 'rf4a_inline.cfg';
    print $CFG $rf4a_inline;
    close $CFG;

    say($ENV{HOME}.'/Git/RefactorF4Acc/bin/'.'refactorF4acc.pl '.$vflag.' -c rf4a_inline.cfg');
    system($ENV{HOME}.'/Git/RefactorF4Acc/bin/'.'refactorF4acc.pl '.$vflag.' -c rf4a_inline.cfg');

}

# Stage 4. Copy non-modified source files and scripts and config files needed to build the OpenCL kernel, and generate the OpenCL kernel
if (not $skip_stage[4]) { 
    
    ##
    say "* In `$gen_dir`, we copy the non-modified source files into the current folder, as well as some scripts and config files needed to build the OpenCL kernel." if $VV;
    chdir $wd;
    chdir $gen_dir;
        
    my $ref_dir = $TRUST_THE_COMPILER ? "$wd/$src_dir" : "$wd/PostCPP";
    for my $src (@orig_sources) {
       system("cp $ref_dir/$src ."); 
    }

    ## TODO rf4a_to_C.cfg should be generated
    my $rf4a_to_C_cfg = <<ENDCFG;
MODULE = module_${superkernel_name}
MODULE_SRC = module_${superkernel_name}.f95
TOP = ${superkernel_name}
KERNEL = ${superkernel_name}
PREFIX = .
SRCDIRS = .
NEWSRCPATH = ./Temp
EXCL_SRCS = (module_${superkernel_name}_init|_host|\\.[^f])
MACRO_SRC = macros_kernel.h
EXCLUDE_ALL_SUBDIRS = 1

ENDCFG
    
    open my $CFG, '>', 'rf4a_to_C.cfg';
    print $CFG $rf4a_to_C_cfg;
    close $CFG;
    
    my @sources2=qw(
    macros_kernel.h
    array_index_f2c1d.h
    );
    
    my $ref_dir_2 = "$wd/aux";
    for my $src (@sources2) {
        system("cp $ref_dir_2/$src . ");
    }

    ##
    say '* Then we generate the actual OpenCL kernel code using `RefactorF4Acc`' if $VV;
    chdir $wd;
    chdir $gen_dir;
    
    my $macros_kernel_src = './macros_kernel.h';
    
    if (not -e $macros_kernel_src ) {
        say "No `macros_kernel.h` file for the macros NTH and NUNITS";
        say "Creating one with NTH=$nth and NUNITS=$nunits";
        open my $MKS, '>', 'macros_kernel.h';
        say $MKS "#define NTH $nth";
        say $MKS "#define NUNITS$nunits";
        close $MKS;

    }
    say($ENV{HOME}.'/Git/RefactorF4Acc/bin/'.'refactorF4acc.pl '.$vflag.' -P translate_to_OpenCL -c rf4a_to_C.cfg module_'.$superkernel_name); 
    system($ENV{HOME}.'/Git/RefactorF4Acc/bin/'.'refactorF4acc.pl '.$vflag.' -P translate_to_OpenCL -c rf4a_to_C.cfg module_'.$superkernel_name);
    system("cp Temp/module_$superkernel_name.cl module_${superkernel_name}_ORIG.cl");

}

# Step 3. Build the host code for the OpenCL kernel
if (not $skip_stage[5]) {
##
    chdir $wd;
    chdir $gen_dir;
    
    ## SConstruct.auto is generated
    create_sconstruct($main_src, \@kernel_sources, \@orig_sources, $superkernel_name);
    
    say 'Now we can build the OpenCL Fortran host code, setting the number of threads and compute units depending on the GPU';
    say 'Note that the Scons build runs cpp on the kernel for the macros NTH, NUNITS and BARRIER_OK';
    say 'Normally these are set via the `nth`, `nunits` and `dev` flags on the scons command line';
    say 'But you can also put them in `macros_kernel.h`';
    
    say("scons -f SConstruct.auto -s mcm=m dev=$plat nth=$nth nunits=$nunits");
    system("scons -f SConstruct.auto -s mcm=m dev=$plat nth=$nth nunits=$nunits");
}

# ----- Helper functions -----
# 
sub create_sconstruct { (my $main_src, my $kernel_sources, my $orig_sources, my $superkernel_name)=@_;

    my @host_srcs = map {
        my $name = strip_ext($_);
        my $host_name = $name.'_host';
        my $host_src = "'$host_name.f95'";
        $host_src
    } ($main_src, @{ $kernel_sources } );

    my $host_srcs_str = join(',',@host_srcs);
    my @q_orig_sources = map { "'./$_'" } @{ $orig_sources };
    my $orig_srcs_str = join(',',@q_orig_sources);

    my $module_init_str = "'./module_${superkernel_name}_init.f95'";
    my $kernel_src_cl_str = "'module_${superkernel_name}.cl'";

    if (not -e "SConstruct.auto" ) {
        open my $SCONS_TEMPL,'<',"$wd/aux/SConstruct.templ";    
        open my $SCONS,'>', "SConstruct.auto";
        while (my $line= <$SCONS_TEMPL> ) {
            $line=~/__HOST_SRCS__/ && do {
                $line=~s/__HOST_SRCS__/$host_srcs_str/;            
            }; 
            $line=~/__MODULE_INIT__/ && do {
                $line=~s/__MODULE_INIT__/$module_init_str/;
            }; 
            $line=~/__KERNEL_SRC_CL__/ && do {
                $line=~s/__KERNEL_SRC_CL__/$kernel_src_cl_str/;
            };
            $line=~/__ORIG_SOURCES__/ && do {
                $line=~s/__ORIG_SOURCES__/$orig_srcs_str/;
            }; 
            print $SCONS $line;
        }
        close $SCONS;
        close $SCONS_TEMPL;
    } else {
        say "SConstruct.auto already exists, not overwriting. Delete or rename the file and run the build stage again.";
    }

}

sub strip_ext { (my $fn)=@_;
    $fn=~s/\.\w+$//;
    return $fn;
}

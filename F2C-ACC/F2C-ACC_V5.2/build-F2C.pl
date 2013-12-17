#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

=info
This version of F2C_ACC works on OS X 10.6.8 
Need to make it work on Linux, at least 64-bit

=cut
# build script to make and install the F2C compiler
#
# Original csh script written by:   Mark Govett
#               NOAA Earth System Research Laboratory
#               June 2013
# 
# This Perl script: Wim Vanderbauwhede
#
# Required software
#   - Fortran and C compiler, define through $FC and $CC
#   - nvcc compiler                             test:  which nvcc, set $CUDA_ROOT
#   - cuda runtime library                      test:  find   libcudart.so
#   - gnu m4 library                            test:  which m4
#
# Assumptions for this script
#   1.  The node where this software is being installed can INTERACTIVELY
#       run a cuda gpu routine
#
#   If GPU nodes are only available via the batch system, a wrapper script
#   will be needed to submit the build and run tests as a batch routine
#
#   2.  Directory where you wish to install F2C-ACC exists
#
#
use Cwd;

my $cwd=cwd();

my $F2ACC_DOC_VERSION = 'V4.2';
my $CUDA_LIB_PATH=$ENV{'CUDA_ROOT'}.'/lib/';

my $F2C_HOME=$ENV{'F2C_HOME'};
my $F2C_ROOT=$cwd;
$ENV{'F2C_HOME'}=$F2C_ROOT;
use Getopt::Std;
use File::Copy;
my %opts=();
getopts('hvCcti:', \%opts);
my $CA= $opts{'C'} // 0;
my $C= $opts{'c'} || $opts{'C'};
my $V= $opts{'v'} // 0;
my $T= $opts{'t'} // 0;
my $I= $opts{'i'} ? 1 : 0;
my $installdir = $opts{'i'};

if ($opts{'h'}) { 
  say "Usage: $0 [-c -v -i install-path]";
  say "  install-path: location where F2C-ACC will be installed. Must be defined in environment as \$F2C_HOME";
  say "  -i: Install";
  say "  -C: Clean both F2C-ACC source and examples before building";
  say "  -c: Clean examples before building";
  say "  -t: Build and run examples for testing";
  say "  -v: Verbose";
  exit 0;
}

if ($I) {
    if( ! -e $installdir || ! -d $installdir) {
        say "Error: $installdir does not exist or is not a directory";
        exit 1;
    } else {
# remove anything in there! danger mouse!
        system("rm -Rf $installdir/bin/*");
        system("rm -Rf $installdir/examples/*");
        system("rm -Rf $installdir/lib/*");
        system("rm -Rf $installdir/include/*");
    }
}
my $mydir = $cwd;
#
# build F2C-ACC compiler;
chdir 'source';
system('make clean') if $CA;
system('make 2>&1  | tee build_source.log');
my $res1=`grep Error build_source.log`;
if ($res1) {
    say 'First make failed--exiting'; 
    exit 1;
} else {
    print $res1 if $V;
}
move 'F2C-ACC.exe','../bin';
chdir '..';
# #
# # modify perl driver script F2C-ACC, to build	
# #
# say 'chdir bin' if $V;
# chdir 'bin/';
# #copy 'F2C-ACC.template', 'F2C-ACC';
# #sed -i s,/Users/name/,$mydir, F2C-ACC ;
# open my $TEMPL, '<','F2C-ACC.template';
# open my $OUT, '>','F2C-ACC';
# while (my $line = <$TEMPL>) {
#     $line=~s/\/Users\/name\//$mydir/g;
#     print $OUT $line;
# }
# close $TEMPL;
# close $OUT;
# chmod 0755, 'F2C-ACC';
# chdir '..';


chdir 'lib';
system('make clean') if $CA;
my $res2 =`make`;
if (not $res2) {
    say 'Second make failed--exiting';
    exit 1;
}
chdir '..';

 if ($T) {
# # Building examples for testing
 say 'chdir examples/' if $V;
 chdir 'examples/';
# #copy 'Makefile.template', 'Makefile';
# #sed -i s,/Users/name/,$mydir, Makefile;
# open $TEMPL, '<','Makefile.template';
# open $OUT, '>','Makefile';
# while (my $line = <$TEMPL>) {
#     $line=~s/\/Users\/name\//$mydir/g;
#     print $OUT $line;
# }
# close $TEMPL;
# close $OUT;
system('make clean') if $C;
#
say "Building gptl_lite...";
chdir '../examples/gptl_lite';
system('make clean') if $C;
my $res_gptl =`make`;
if (not $res_gptl) {
    say 'make failed in examples/gptl_lite--exiting';
    exit 1;
}
say "Success building gptl_lite...";
chdir '../';
system('make');

# Running tests
say '---------------------------------------';
say 'Validating Fortran code';
say '---------------------------------------';
system('./driver_ftn');
say '';
say '---------------------------------------';
say 'Validating F2C-ACC Generated C code';
say '---------------------------------------';
# on Mac OS X 10.8.5 with gfortran-mp-4.8, it needs DYLD_LIBRARY_PATH=/opt/local/lib/gcc48 or /opt/local/lib/libgcc for libgfortran.3.dylib
system('./driver_cpu');
say '---------------------------------------';
say 'Validating F2C-ACC Generated CUDA code';
say '---------------------------------------';
# on Mac OS X 10.8.5 with gfortran-mp-4.8, it needs DYLD_LIBRARY_PATH=<path to 32-bit libgfortran.3.dylib>
system("LD_LIBRARY_PATH=$CUDA_LIB_PATH ./driver_gpu");
chdir '..';
}

if ($I) {
#verify the path is not the source directory;
    say 'Installing software in ' . $installdir;
    if ( ($cwd ne $installdir) && ($cwd.'/' ne $installdir)) {

# modify paths to point to the install path;
#    chdir 'bin' ;
#  unlink 'F2C-ACC';
#  copy('F2C-ACC.template','F2C-ACC');
#  sed -i s,/Users/name/,$installdir, F2C-ACC ;
#    open $TEMPL, '<','F2C-ACC.template';
#    open $OUT, '>','F2C-ACC_for_install';
#    while (my $line = <$TEMPL>) {
#        $line=~s/\/Users\/name\//$installdir/g;
#        print $OUT $line;
#    }
#    close $TEMPL;
#    close $OUT;

# Adapt Makefile  for tests to build in $instaldir
#    chdir '../examples/';
#  copy -f Makefile.template Makefile;
#  sed -i s,/Users/name/,$installdir, Makefile;
#    open $TEMPL, '<','Makefile.template';
#    open $OUT, '>','Makefile';
#    while (my $line = <$TEMPL>) {
#        $line=~s/\/Users\/name\//$installdir/g;
#        print $OUT $line;
#    }
#    close $TEMPL;
#    close $OUT;
#    chdir '..';

# install F2C in the user specified location;
    say "Copying documentation to $installdir ..." if $V; 
    copy  "F2C-ACC_Documentation_$F2ACC_DOC_VERSION.pdf", $installdir;
    copy  'README', $installdir;
    say "Copying F2C library to $installdir ... " if $V;
    if (! -e "$installdir/lib") {
        mkdir "$installdir/lib";
    }
    copy 'lib/libF2C.a',"$installdir/lib";
    say "Copying F2C include/ to $installdir ... " if $V;
    system("cp -r include $installdir");
    say "Copying F2C bin/ to $installdir ... " if $V;
    if (! -e "$installdir/bin") {
        mkdir "$installdir/bin";
    }
    copy 'bin/F2C-ACC', "$installdir/bin/F2C-ACC";
    chmod 0755, "$installdir/bin/F2C-ACC";
    copy 'bin/F2C-ACC.exe', "$installdir/bin";
    chmod 0755, "$installdir/bin/F2C-ACC.exe";
# Copy examples for tests to $installdir
    say "Copying examples/ to $installdir ..." if $V;
    if (! -e "$installdir/examples") {
        mkdir "$installdir/examples";
    }
    system("cp -r examples/* $installdir/examples");
    }
    say 'Installation complete';
}
exit 0;


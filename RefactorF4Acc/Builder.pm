package RefactorF4Acc::Builder;
use v5.10;

use RefactorF4Acc::Config; 

# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Builder::ISA = qw(Exporter);

@RefactorF4Acc::Builder::EXPORT_OK = qw(
    &create_build_script
    &build_executable
);
# -----------------------------------------------------------------------------
sub create_build_script { 
    ( my $stref ) = @_;

    my $gfortran = $ENV{'FC'};
    my $gcc = $ENV{'CC'};
    my $EXT = $Config{EXT};
    my $exe = (exists $Config{'EXE'} and $Config{'EXE'} ne '')
    ? $Config{'EXE'}
    : $stref->{'Top'}; 
    
    my @fsourcelst = sort keys %{ $stref->{'BuildSources'}{$EXT} };
    my $fsources = join( ',', map {
    	# Ad-hoc: names that do not end in .f\d+ or $EXT are renamed by substituting . with _ and $EXT is appended
    	# This is for includes transformed into modules
    	my $src=$_;
    	if ($src=~/\.f\d*$/) { 
    		$src=~s/\.f\d*/$EXT/;
    	} elsif ($src!~/$EXT$/) {
    		
    		$src=~s/(?!\w)\./_/g;
    		$src.=$EXT;
    	}
    	"'" . $src . "'"; 
    } @fsourcelst );

    my $csources = '';
    if ($noop) {
        $stref->{'BuildSources'}{'C'}{'noop.f'} = 1;
    }
    if ( exists $stref->{'BuildSources'}{'C'} ) {
        my @csourcelst = sort keys %{ $stref->{'BuildSources'}{'C'} };
        $csources = join( ',', map { s/\.f$/.c/; "'" . $_ . "'" } @csourcelst );
    }
    my $date  = localtime;
    my $libpaths_str = @{$Config{LIBPATHS}} ? ','.join(',',map { "'".$_."'" } @{$Config{LIBPATHS}}) : '';
    my $libs_str = @{$Config{LIBS}} ? ','.join(',',map { "'".$_."'" } @{$Config{LIBS}}) : ''; 

    	my $INCLPATHS = (@{ $Config{'INCLPATH'}}>0 ) ? $Config{'INCLPATH'} :
		(@{ $Config{'F95PATH'} } >0) ? $Config{'F95PATH'} : 
        (@{ $Config{'F90PATH'} }>0) ? $Config{'F90PATH'} : 
        [];
    my $inclpaths_str=@{$INCLPATHS} ? ','.join(',',map { "'".$_."'" } @{$INCLPATHS}) : '';
    my $maybe_fc = $EXT; $maybe_fc=~s/^\.//;
    my $fortran_compiler = $maybe_fc=~/f\d+/i ? uc($maybe_fc) : 'FORTRAN';
    my $fflags = 'FFLAGS = ['.join(',',map {"'".$_."'"   }  @{$Config{FFLAGS}}).']';
    my $maybe_f77flags = $Config{HAS_F77_SOURCES} ? 'FORTRANFLAGS = ['.join(',',map {"'".$_."'"   }  @{$Config{F77FLAGS}}).']' : '';
    my $maybe_f77path= $Config{HAS_F77_SOURCES} ? 'FORTRANPATH = ['.join(',',map {"'".$_."'"   }  @{$Config{F77FLAGS}}).']' : '';
    my $maybe_f77_compiler=$gfortran;
    my $maybe_f77_env=$Config{HAS_F77_SOURCES} ? ",FORTRAN=$maybe_f77_compiler, $maybe_f77flags, $maybe_f77path" : '';

    my $maybe_c_sources = '';
    my $program="envF.Program('$exe',fsources,LIBS=[$libs_str 'm'],LIBPATH=['.' $libpaths_str])";
    if ($csources ne '') {
        $maybe_c_sources = <<ENDC;
csources =[$csources]

CC=os.environ.get('CC')
envC=Environment(CC=CC,CPPPATH=[]);
if csources:
    envC.Library('${exe}_c',csources)
ENDC

        $program = <<ENDCP;
if csources:
    envF.Program('$exe',fsources,LIBS=[$libs_str '${exe}_c','m'],LIBPATH=['.' $libpaths_str])   
else:
    $program
ENDCP

    }

    my $scons = <<ENDSCONS;
# Generated build script for refactored source code
# $date
import os

FC=os.environ.get('FC')

fsources = [$fsources]

$maybe_c_sources

$fflags
$maybe_f77flags
#envF=Environment($fortran_compiler='$gfortran',LINK='$gfortran',${fortran_compiler}FLAGS=FFLAGS,${fortran_compiler}PATH=['.' $inclpaths_str]$maybe_f77_env)
envF=Environment($fortran_compiler=FC,LINK=FC,${fortran_compiler}FLAGS=FFLAGS,${fortran_compiler}PATH=['.' $inclpaths_str]$maybe_f77_env)

$program
ENDSCONS

=pod_no_C
At the moment I've removed support for C sources.
=cut

    open my $SC, '>', "$targetdir/SConstruct.rf4a";
    print $SC $scons;
    print $scons if $V;
    close $SC;

}    # END of create_build_script()

# -----------------------------------------------------------------------------
sub build_executable {
    chdir $targetdir;
    system('scons -f SConstruct.rf4a');
}

package RefactorF4Acc::Builder;

use RefactorF4Acc::Config; 

# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

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
    my $exe = $stref->{'Top'}; # FIXME: would make more sense to have $Config{'EXE'}
    my @fsourcelst = sort keys %{ $stref->{'BuildSources'}{'F'} };
    my $fsources = join( ',', map {
    	# Ad-hoc: names that do not end in .f or $EXT are renamed by substituting . with _ and $EXT is appended
    	# This is for includes transformed into modules
    	my $src=$_;
    	if ($src=~/\.f$/) { 
    		$src=~s/\.f$/$EXT/;
    	} elsif ($src!~/$EXT$/) {
    		$src=~s/\./_/g;
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
    my $libpaths_str = @{$LIBPATHS} ? ','.join(',',map { "'".$_."'" } @{$LIBPATHS}) : '';#'/opt/local/lib','/usr/local/lib'"; # TODO: get from rf4a.cfg
    my $libs_str = @{$LIBS} ? ','.join(',',map { "'".$_."'" } @{$LIBS}) : ''; # TODO: get from rf4a.cfg
    my $inclpaths_str=@{$INCLPATHS} ? ','.join(',',map { "'".$_."'" } @{$INCLPATHS}) : '';#",'/opt/local/include','/usr/local/include'"; # TODO: get from rf4a.cfg

    my $scons = <<ENDSCONS;
# Generated build script for refactored source code
# $date

#csources =[$csources]

fsources = [$fsources]

envC=Environment(CC='$gcc',CPPPATH=[]); 
#if csources:
#    envC.Library('${exe}_c',csources)

FFLAGS  = ['-cpp','-O3', '-m64', '-ffree-form', '-ffree-line-length-0','-fconvert=little-endian', '-frecord-marker=4']
envF=Environment(F95='$gfortran',LINK='$gfortran',F95FLAGS=FFLAGS,F95PATH=['.' $inclpaths_str])
#if csources:
#    envF.Program('$exe',fsources,LIBS=[$libs_str '${exe}_c','m'],LIBPATH=['.' $libpaths_str])   
#else:
#    envF.Program('$exe',fsources,LIBS=[$libs_str 'm'],LIBPATH=['.' $libpaths_str])
envF.Program('$exe',fsources,LIBS=[$libs_str 'm'],LIBPATH=['.' $libpaths_str])
ENDSCONS

    open my $SC, '>', "$targetdir/SConstruct.rf4a";
    print $SC $scons;
    print $scons if $V;
    close $SC;

}    # END of create_build_script()

# -----------------------------------------------------------------------------
sub build_executable {
    system('scons -f SConstruct.rf4a');
}

package RefactorF4Acc::Builder;

use RefactorF4Acc::Config; 

# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Builder::ISA = qw(Exporter);

@RefactorF4Acc::Builder::EXPORT_OK = qw(
    &create_build_script
    &build_flexpart
);
# -----------------------------------------------------------------------------
sub create_build_script {
    ( my $stref ) = @_;

    # FIXME: we should probe the system here!
    my @gfs = (
        '/opt/local/bin/gfortran-mp-4.6',
        '/usr/local/bin/gfortran-4.6', '/usr/bin/gfortran'
    );
    my $gfortran = 'gfortran';
    for my $mgf (@gfs) {
        if ( -e $mgf ) {
            $gfortran = $mgf;
            last;
        }
    }
    my @fsourcelst = sort keys %{ $stref->{'BuildSources'}{'F'} };
    my $fsources = join( ',', map { "'" . $_ . "'" } @fsourcelst );

    my $csources = '';
    if ($noop) {
        $stref->{'BuildSources'}{'C'}{'noop.f'} = 1;
    }
    if ( exists $stref->{'BuildSources'}{'C'} ) {
        my @csourcelst = sort keys %{ $stref->{'BuildSources'}{'C'} };
        $csources = join( ',', map { s/\.f$/.c/; "'" . $_ . "'" } @csourcelst );
    }
    my $date  = localtime;
    my $scons = <<ENDSCONS;
# Generated build script for refactored FLEXPART source code
# $date

csources =[$csources]

fsources = [$fsources]

envC=Environment(CC='gcc',CPPPATH=['/Users/wim/SoC_Research/F2C-ACC/include/']); # FIXME: use ENV
if csources:
    envC.Library('wrfc',csources)

FFLAGS  = ['-O3', '-m64', '-ffree-form', '-fconvert=little-endian', '-frecord-marker=4']
envF=Environment(F95='$gfortran',LINK='$gfortran',F95FLAGS=FFLAGS,F95PATH=['.','/opt/local/include','/usr/local/include'])
if csources:
    envF.Program('flexpart_wrf',fsources,LIBS=['netcdff','wrfc','m'],LIBPATH=['.','/opt/local/lib','/usr/local/lib'])   
else:
    envF.Program('flexpart_wrf',fsources,LIBS=['netcdff','m'],LIBPATH=['.','/opt/local/lib','/usr/local/lib'])
ENDSCONS
    open my $SC, '>', "$targetdir/SConstruct.flx_wrf";
    print $SC $scons;
    print $scons if $V;
    close $SC;

}    # END of create_build_script()

# -----------------------------------------------------------------------------
sub build_flexpart {
    system('scons -f SConstruct.flx_wrf');
}

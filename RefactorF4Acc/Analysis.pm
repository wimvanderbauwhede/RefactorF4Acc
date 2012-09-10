package RefactorF4Acc::Analysis;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::Includes qw( find_root_for_includes );
use RefactorF4Acc::Analysis::Globals qw( resolve_globals );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
use RefactorF4Acc::Analysis::Common qw( analyse_sources );
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

@RefactorF4Acc::Analysis::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::EXPORT = qw(
    &analyse_all
);

sub analyse_all {
	print "ANALYSE ALL SOURCES\n" if $V;
	(my $stref, my $subname)=@_;
	   # Find the root for each include in a proper way
    $stref = find_root_for_includes( $stref, $subname );
    
    # Now we can do proper globals handling
    # We need to walk the tree again, find the globals in rec descent.
    $stref = resolve_globals( $subname, $stref );
    $stref = analyse_sources($stref);
    
	return $stref;	
}
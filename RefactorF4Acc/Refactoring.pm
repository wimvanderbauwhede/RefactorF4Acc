# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

package RefactorF4Acc::Refactoring;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( create_refactored_source );
use RefactorF4Acc::Refactoring::Subroutines qw( refactor_all_subroutines refactor_kernel_signatures );
use RefactorF4Acc::Refactoring::Functions qw( refactor_called_functions );
use RefactorF4Acc::Refactoring::Includes qw( refactor_includes );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
$Carp::Verbose = 1;
use Data::Dumper;

use Exporter;
@RefactorF4Acc::Refactoring::ISA = qw(Exporter);
@RefactorF4Acc::Refactoring::EXPORT_OK = qw(
    &refactor_all
);

# -----------------------------------------------------------------------------
sub refactor_all {
	( my $stref, my $subname ) = @_;
        
    $stref = refactor_includes($stref);
    $stref = refactor_called_functions($stref);
    # Refactor the source, but don't split long lines and keep annotations
    $stref = refactor_all_subroutines($stref);
#    die Dumper(keys %{ $stref->{'Subroutines'}{'interpol_all_nests'}});
    # This can't go into refactor_all_subroutines() because it is recursive
    $stref = determine_argument_io_direction_rec( $subname, $stref );
# Now somehow we should use the IO direction, at first simply as annotation
#FIXME: This does not work! refactor_all_subroutines produces the refactored source!!!
    print "DONE determine_argument_io_direction_rec()\n" if $V;    
#    croak();
    # What I need to do here is use the IODir information
    # Initially this is just adding some comments to the refactored source;
    # Later it means rewriting the kernel signatures
    # Basically need this for every factored-out kernel candidate
    # But it doesn't hurt to annotate every subroutine of course 
#    $stref = refactor_kernel_signatures( $stref, $subname); # It would be better if I could do this in determine_argument_io_direction_rec() 
#    $stref = create_all_refactored_subroutine_sources($stref);
    # When all this is done, we can finally create the refactored sources for the subroutines
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
    	if (scalar keys %{$stref->{'Subroutines'}{$f}{'Callers'} } or $stref->{'Subroutines'}{$f}{'Program'} ) {    		
    		$stref = refactor_kernel_signatures( $stref, $f); # FIXME: rename this!
        $stref=create_refactored_source(  $stref, $f );
    	} else {
    		print "WARNING: SKIPPING $f: Callers: ",scalar keys %{$stref->{'Subroutines'}{$f}{'Callers'} },'; Program: ',$stref->{'Subroutines'}{$f}{'Program'},"\n" if $V;
    	}
    }
    return $stref;	
} # END of  

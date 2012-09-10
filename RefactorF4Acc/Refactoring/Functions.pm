package RefactorF4Acc::Refactoring::Functions;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( context_free_refactorings create_refactored_source );

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

@RefactorF4Acc::Refactoring::Functions::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Functions::EXPORT_OK = qw(
    &refactor_called_functions
);

=pod
Functions
    refactor_called_functions()
    refactor_function()
=cut


# -----------------------------------------------------------------------------
# The test for called functions is weak, a better test is the status:
# if the function was not parsed, it's not used, because we parse via recursive descent
sub refactor_called_functions {
    ( my $stref ) = @_;

    for my $f ( keys %{ $stref->{'Functions'} } ) {
        my $Ff = $stref->{'Functions'}{$f};
        if ( defined $Ff->{'Called'} ) { # FIXME: This test is weak because the caller might not be called itself!
        if ($Ff->{'Status'} == $READ) { 
        	warn "refactor_called_functions(): Function $f was never parsed";
        } else {        
            $stref = refactor_function( $f, $stref );
            $stref = create_refactored_source($stref, $f);
        }
        } 
    }
    return $stref;
}    # END of refactor_called_functions()

# -----------------------------------------------------------------------------
sub refactor_function {
    ( my $f, my $stref ) = @_;
    if ($V) {
        print "\n\n";
        print "#" x 80, "\n";
        print "Refactoring $f\n";
        print "#" x 80, "\n";
    }
    my $Ff = $stref->{'Functions'}{$f};
    print "REFACTORING FUNCTION $f\n" if $V;    

    if (   not exists $Ff->{'RefactoredCode'}
        or $Ff->{'RefactoredCode'} == []
        or exists $stref->{'BuildSources'}{'C'}{ $Ff->{'Source'} } )
    {
        $stref = context_free_refactorings( $stref, $f );
    }

    return $stref;

}    # END of refactor_function()
# -----------------------------------------------------------------------------

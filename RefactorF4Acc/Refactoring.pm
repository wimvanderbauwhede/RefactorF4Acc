# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

package RefactorF4Acc::Refactoring;
use v5.016;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( 
    create_refactored_source 
    get_annotated_sourcelines          
    splice_additional_lines
    );
use RefactorF4Acc::Refactoring::Subroutines qw( refactor_all_subroutines );
#use RefactorF4Acc::Refactoring::Subroutines::Declarations qw( find_and_add_missing_var_decls );
use RefactorF4Acc::Refactoring::Functions qw( refactor_called_functions remove_vars_masking_functions);
use RefactorF4Acc::Refactoring::IncludeFiles qw( refactor_include_files );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec update_argument_io_direction_all_subs);
use RefactorF4Acc::Refactoring::Modules qw( add_module_decls );

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
	( my $stref, my $subname, my $stage) = @_;

    $stref = refactor_include_files($stref);
    return $stref if $stage == 1;

    $stref = refactor_called_functions($stref); # Context-free only FIXME: this should be treated just like subs, but if course that requires full parsing of expressions
    return $stref if $stage == 2;
    # Refactor the source, but don't split long lines and keep annotations
    $stref = refactor_all_subroutines($stref);
    
    return $stref if $stage == 3;
    # This can't go into refactor_all_subroutines() because it is recursive
    # Also, this is actually analysis
    $stref = determine_argument_io_direction_rec( $subname, $stref );    
    return $stref if $stage == 4;    
    print "DONE determine_argument_io_direction_rec()\n" if $V;

    $stref = update_argument_io_direction_all_subs( $stref );
    # So at this point we know everything there is to know about the argument declarations, we can now update them

    say "remove_vars_masking_functions" if $V;    
    $stref = remove_vars_masking_functions($stref);    
    return $stref if $stage == 5;
    
    say "add_module_decls" if $V;
    $stref=add_module_decls($stref);
    
    return $stref;	
} # END of refactor_all()  




 
1;
package RefactorF4Acc::Refactoring;
# 
#   (c) 2010-now Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;

use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec update_argument_io_direction_all_subs);

use RefactorF4Acc::Refactoring::Helpers qw( top_src_is_module stateful_pass_inplace stateless_pass_inplace get_annotated_sourcelines );
use RefactorF4Acc::Refactoring::Subroutines qw( refactor_all_subroutines );
use RefactorF4Acc::Refactoring::Functions qw( refactor_called_functions remove_vars_masking_functions);
use RefactorF4Acc::Refactoring::IncludeFiles qw( refactor_include_files );
use RefactorF4Acc::Refactoring::Modules qw( add_module_decls );
use RefactorF4Acc::Refactoring::InlineSubroutine qw( inline_subroutines );
use RefactorF4Acc::Refactoring::EvalParamExprs qw( eval_param_expressions_all );
use RefactorF4Acc::Refactoring::DSM qw( refactor_dsm_all );
use RefactorF4Acc::Refactoring::FoldConstants qw( fold_constants_all );
# The detection of the loop nature is Analysis but in the current code the rewrites are interleaved
# use RefactorF4Acc::Analysis::LoopNature qw( analyse_loop_nature_all );

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

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
	( my $stref, my $code_unit_name, my $is_source_file_path) = @_;

	my $sub_or_func_or_mod = sub_func_incl_mod( $code_unit_name, $stref );
    if ($sub_or_func_or_mod eq 'Modules' and $is_source_file_path) {
       $code_unit_name = get_module_name_from_source($stref,$code_unit_name);
    }
   
    $stref = refactor_include_files($stref) unless $Config{'INLINE_INCLUDES'} == 1;

# FIXME: this should be treated just like subs, but of course that requires full parsing of expressions that contain function calls
    $stref = refactor_called_functions($stref); # Context-free only 
 	# say "BEFORE refactor_all_subroutines";    
    # Refactor the source, but don't split long lines and keep annotations
    $stref = refactor_all_subroutines($stref);    
#    say "AFTER refactor_all_subroutines";
#  croak Dumper pp_annlines($stref->{'Subroutines'}{'adam'}{'AnnLines'});
    # This can't go into refactor_all_subroutines() because it is recursive
    # Also, this is actually analysis
    # And this is only for Subroutines of course, not for Modules
	# The reason it is only called here is because we need to run this on the subroutines with refactored arguments.

    if ($sub_or_func_or_mod eq 'Subroutines') {
    	$stref = determine_argument_io_direction_rec( $stref,$code_unit_name );    	
    	say "DONE determine_argument_io_direction_rec()" if $V;

    	$stref = update_argument_io_direction_all_subs( $stref );
    }

    # So at this point we know everything there is to know about the argument declarations, we can now update them
    say "remove_vars_masking_functions" if $V;    
    $stref = remove_vars_masking_functions($stref);    
	if ( $Config{'EVAL_PARAM_EXPRS'}) {
    	say "eval_param_expressions_all" if $V;    
		$stref = eval_param_expressions_all($stref);
	}
    # Inlining 
    $stref = inline_subroutines($stref) ;

    # croak Dumper($stref->{'Subroutines'}{'dyn_shapiro_update'}{'RefactoredCode'});
	# Test array access and constant folding here

	# $stref = analyse_loop_nature_all($stref) ;

	# $stref = fold_constants_all($stref) ;
	# $stref = refactor_dsm_all($stref) ;
    # croak Dumper pp_annlines($stref->{'Subroutines'}{'press'}{'AnnLines'});
    # Custom refactoring, must be done before creating final modules
    say "add_module_decls" if $V;
    $stref=add_module_decls($stref);
    
    return $stref;	
} # END of refactor_all()  




1;

# 
#   (c) 2010-now Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

package RefactorF4Acc::CustomPasses;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw( top_src_is_module substitute_placeholders);
use RefactorF4Acc::Refactoring::Modules qw( add_module_decls );

#### CUSTOM PASSES ####

use RefactorF4Acc::Refactoring::Scalarise qw( pass_rename_array_accesses_to_scalars );
use RefactorF4Acc::Refactoring::EliminateDeadCode qw( pass_eliminate_dead_code );

use RefactorF4Acc::Translation::SaC qw( translate_module_to_SaC );
use RefactorF4Acc::Translation::OpenCLC qw( translate_module_to_C );
use RefactorF4Acc::Translation::Uxntal qw( translate_module_to_Uxntal );
use RefactorF4Acc::Translation::TyTraCL qw( pass_emit_TyTraCL );
use RefactorF4Acc::Translation::TyTraIR qw( pass_emit_TyTraIR );
use RefactorF4Acc::Translation::TyTra::MemoryReduction qw( pass_memory_reduction );

use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( pass_identify_stencils );

use RefactorF4Acc::CustomPasses::IfdefIO qw( ifdef_io_all );

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
@RefactorF4Acc::CustomPasses::ISA = qw(Exporter);
@RefactorF4Acc::CustomPasses::EXPORT_OK = qw(
    &run_custom_passes
);

# -----------------------------------------------------------------------------

sub run_custom_passes {
	( my $stref, my $code_unit_name, my $pass, my $is_source_file_path) = @_;
	my $sub_or_func_or_mod = sub_func_incl_mod( $code_unit_name, $stref );
	if ($sub_or_func_or_mod eq 'Modules' and $is_source_file_path) {
       $code_unit_name = get_module_name_from_source($stref,$code_unit_name);
    }
	 
    # Some of these passes use functionality that requires RefactoredArgs, so let's make sure it is populated
    # I assume that the input for a custom pass is essentially the output of the main compiler, so no globals, etc
    # So all args should be in DeclaredOrigArgs
    # So it should suffice to say 
    #croak Dumper($code_unit_name,
            
# Custom passes
	if ($pass =~/emit_TyTraCL/i) {
		$stref = pass_emit_TyTraCL($stref,$code_unit_name);
	}		
	if ($pass =~/emit_TyTraIR/i) {
		$stref = pass_emit_TyTraIR($stref,$code_unit_name);		
	}	
	if ($pass =~/identify_stencils/) {
		$stref = pass_identify_stencils($stref,$code_unit_name);
	}	
	if ($pass =~/rename_array_accesses_to_scalars|scalarize/) {
		$stref = pass_rename_array_accesses_to_scalars($stref,$code_unit_name);				
	}
	if ($pass =~/eliminate_dead_code|dead_code_elimination|dce|DCE/) {
		$stref = pass_eliminate_dead_code($stref,$code_unit_name);				
	}
	if ($pass =~/^\s*memory_reduction/) { # RS 19/11/21 - avoid name clash with "translate_to_OpenCL_memory_reduction"
		$stref = pass_memory_reduction($stref,$code_unit_name);
	}
	if ($pass =~/translate_to_C/) { 
		$stref = translate_module_to_C($stref,$code_unit_name,0);
	} elsif ( $pass =~/translate_to_TyTraC/) {              
        $stref = translate_module_to_C($stref,$code_unit_name,2);
	} elsif ( $pass =~/translate_to_TyTraLlvmIR/) {              
        $stref = translate_module_to_C($stref,$code_unit_name,4);		
	} elsif ( $pass =~/translate_to_OpenCL_with_pipes/) {              
        $stref = translate_module_to_C($stref,$code_unit_name,3);
	} elsif ( $pass =~/translate_to_OpenCL_memory_reduction/) {
        $stref = translate_module_to_C($stref,$code_unit_name,5);
	} elsif ( $pass =~/translate_to_OpenCL/) {				
		$stref = translate_module_to_C($stref,$code_unit_name,1);
	} elsif ( $pass =~/translate_to_SaC/) {				
		$stref = translate_module_to_SaC($stref,$code_unit_name);
	} elsif ( $pass =~/translate_to_Uxntal/) {				
		$stref = translate_module_to_Uxntal($stref,$code_unit_name);		
	}
	if ($pass =~/ifdef_io/i) {
		$stref = ifdef_io_all($stref);				
	}
# After a custom pass, do some postprocessing and exit	
	if ($pass ne '' ) {
		if (exists $stref->{'CustomPassPostProcessing'}) {
		$stref=substitute_placeholders($stref);
        # This is of course useless if the target language is not Fortran
        # So I should have a way to exclude this
        # The way to do this is to let the pass make sure that
        # top_src_is_module() is false
        # The easiest way is to set $stref->{'SourceContains'} = {}

		if (top_src_is_module($stref, $code_unit_name)) {
            $stref=add_module_decls($stref);
		}
		}
	} else {
        # Should never happen!
        say "No custom pass provided, doing nothing!";
       
    }
    # We also need a mechanism to stop the emitter 
    return $stref;	
} # END of run_custom_passes()  




1;

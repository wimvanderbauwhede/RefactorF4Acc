package RefactorF4Acc::Refactoring::Functions;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( context_free_refactorings stateful_pass );

# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.2.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::Functions::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Functions::EXPORT_OK = qw(
    &refactor_called_functions
    &remove_vars_masking_functions
);

=pod
Functions
    remove_vars_masking_functions()
    refactor_called_functions()
    _refactor_function()
    _convert_function_to_subroutine()
=cut


sub remove_vars_masking_functions { ( my $stref ) = @_;
	
    my $pass_actions = sub {
        (my $annline,  my $state) = @_;
        (my $stref, my $f) =@{$state};
        (my $line, my $info) = @{$annline};
        
        if (exists $info->{'VarDecl'}) {
            my $var = $info->{'VarDecl'}{'Name'};            
            if (exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$var}) {
                say "INFO: VAR $var is masking a function/sub in $f, LINE: $line" if $I;
                my $Sf = $stref->{'Subroutines'}{$f};                                
				my $src = $Sf->{'Source'};
				if (exists $stref->{'Subroutines'}{$var}{'Source'}) { # otherwise $var must be external
	           		my $cs_src = $stref->{'Subroutines'}{$var}{'Source'};
	           		# We comment the line out unless it's a program 
                 	if (
                 		($cs_src eq $src) and                  		
                 		(
                 		(exists $stref->{'Subroutines'}{$var}{'Program'} and $stref->{'Subroutines'}{$var}{'Program'}==1)
                 		or ($stref->{'Program'} eq $src)
                 		)
    	        	) {
    	        		$line.= '! decl of func/sub in program' if $DBG;
    	        	} else {
						delete $Sf->{'Vars'}{$var};
    	        	    delete $Sf->{'OrigArgs'}{$var};
        	        	delete $Sf->{'RefactoredArgs'}{$var};
            	    	$info->{'Deleted'}=1;
            		 	$line = '! '.$line. "$cs_src <> $src;".$stref->{'Subroutines'}{$var}{'Program'}.';'.$stref->{'Program'};
         	   		}                
				} else {
					# $var is an external subroutine, for now just mark it
					$line = '! '.$line. '! EXTERNAL SUB' if $DBG;
				}     
               
                push @{$info->{'Ann'}}, annotate($f, __LINE__  );    
                         
                return ([ [$line, $info] ], [$stref, $f]);
            }
        }
        return ([$annline], $state)        
    };
    
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {   
    	     
        next unless (defined $f and $f ne '');
        next if exists $stref->{'Entries'}{$f};
        next if exists $stref->{'ExternalSubroutines'}{$f};
        next if exists $stref->{'Modules'}{$f}; # HACK! FIXME!
        my $state = [$stref,$f];
        ($stref, $state) = stateful_pass($stref,$f, $pass_actions, $state, '');
    }
    return $stref;    
}
# -----------------------------------------------------------------------------
# The test for called functions is the status:
# if the function was not parsed, it's not used, because we parse via recursive descent
sub refactor_called_functions {
    ( my $stref ) = @_;

    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
    	next if exists $stref->{'Entries'}{$f};
        if (exists $stref->{'Subroutines'}{$f}{'Function'}) {
        	my $Ff = $stref->{'Subroutines'}{$f};
        	if ( defined $Ff->{'Called'} ) { # FIXME: This test is weak because the caller might not be called itself!
        		if ($Ff->{'Status'} == $READ) { 
        		warn "refactor_called_functions(): Function $f was never parsed";
        		} else {        
            		$stref = _refactor_function( $f, $stref );
        		}
        	}
        } 
    }
    return $stref;
}    # END of refactor_called_functions()

# -----------------------------------------------------------------------------
sub _refactor_function {
    ( my $f, my $stref ) = @_;
    if ($V) {
        print "\n\n";
        print "#" x 80, "\n";
        print "Refactoring $f\n";
        print "#" x 80, "\n";
    }
    my $Ff = $stref->{'Subroutines'}{$f};
    print "CONTEXT-FREE REFACTORING FUNCTION $f\n" if $V;    
	
    if (   not exists $Ff->{'RefactoredCode'}
        or $Ff->{'RefactoredCode'} == []
        ) {
        $stref = context_free_refactorings( $stref, $f );
    }

    return $stref;

}    # END of _refactor_function()
# -----------------------------------------------------------------------------
=info_convert_function_to_subroutine

A function is either (F77)

Syntax
[ type ] FUNCTION fun ( [ ar [, ar ] … ] )

 FUNCTION $fname($arg1, ...)
    $ftype :: $fname
    $arg1_type :: arg1
    $fname = ...
    RETURN
 END FUNCTION

or (F90)

Syntax
[PURE][ELEMENTAL][RECURSIVE] [type-spec] FUNCTION function-name
([dummy-arg-names]) [RESULT (result-name)]

 $ftype_decl function $fname($arg1,...) result($out_arg)
    $arg1_type, intent(In) :: $arg1 
    if ($ftype_decl eq '') {
    $out_arg_type             :: $out_arg
    } 
    $out_arg = ...
 end function $fname
 
 
 
 The syntax for a subroutine definition is:
subroutine-stmt
[use-stmts]
[specification-part]
[execution-part]
[internal-subprogram-part]
end-subroutine-stmt

The syntax for a function definition is:
function-stmt
[use-stmts]
[specification-part]
[execution-part]
[internal-subprogram-part]
end-function-stmt

In other words, they are the same.

* To convert a function definition to a subroutine definition:
- Rename the output arg if it has the same name as the function
- Add the output arg as the last arg of the function, intent Out
- delete the Function attribute $stref->{'Subroutines'}{$f}{'Function'}
* To convert a function call to a subroutine call:
- Change the function call expression to a variable name by replacing '(', ')' and ',' with '_'
- Declare this variable in the caller code unit. The type of this variable is the type of the return value, so maybe I should mark this.
- Add the variable to the arg list of the function call
- insert a line "CALL ..." before the expression containing the function call
=cut


sub _convert_function_to_subroutine {
	( my $f, my $stref ) = @_;
	return $stref;
}

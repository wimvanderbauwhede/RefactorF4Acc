package RefactorF4Acc::ExpressionAST::Evaluate;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw(
	pass_wrapper_subs_in_module
	stateful_pass
	stateful_pass_reverse
	stateless_pass
	emit_f95_var_decl
	splice_additional_lines_cond
	);

use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
use RefactorF4Acc::Parser::Expressions qw(
	parse_expression	
	emit_expr_from_ast
	get_vars_from_expression	
	);

#
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.2.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::ExpressionAST::Evaluate::ISA = qw(Exporter);

@RefactorF4Acc::ExpressionAST::Evaluate::EXPORT_OK = qw(
&eval_expression_with_parameters
&replace_param_by_val
&replace_consts_in_ast
);


# We replace LoopIters with $const and Parameters with their values.
# Apply to RHS of assignments
sub replace_consts_in_ast { (my $stref, my $f, my $block_id, my $ast, my $state, my $const)=@_;
	my $retval=0;
	if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {
			
			my $entry = $ast->[$idx];

			if (ref($entry) eq 'ARRAY') {
				(my $entry2, $state, $retval) = replace_consts_in_ast($stref,$f, $block_id,$entry, $state,$const);
				$ast->[$idx] = $entry2;
			} else {
				if ($idx==0 and (($entry & 0xFF) == 2)) { #eq '$'
					my $mvar = $ast->[$idx+1];
#					say "MVAR: $mvar in $f";
					if (exists $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'}{ $mvar }) { 
						$ast=''.$const.'';
						return ($ast,$state,1);
					} elsif (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$mvar)) {
						my $param_set = in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$mvar);
						
		  				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$mvar);
#		  				say 'DECL: '. Dumper($decl);
		  				#FIXME: the value could be an expression in terms of other parameters!
		  				my $val = $decl->{'Val'};
#		  				say "MVAL: $val";	
		  				$ast = parse_expression($val, {},$stref,$f);
		  				return ($ast,$state,1);
					} else {
						my $param_set = in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$mvar);
						carp "Can\'t replace $mvar, no parameter record found for in $f";#: <$param_set> = " . Dumper( $stref->{'Subroutines'}{$f}{'Parameters'} );
						return ($ast, $state,0);
					}
				}
			}
		}
	}
	return  ($ast, $state, $retval);
} # END of replace_consts_in_ast()


# Constant folding
sub replace_param_by_val { (my $stref, my $f, my $block_id, my $ast, my $state)=@_;
  		# - see if $val contains vars
  		my $vars=get_vars_from_expression($ast,{}) ;
  		# - if so, substitute them using replace_consts_in_ast
  		while (
  		(exists $vars->{'_OPEN_PAR_'} and scalar keys %{$vars} > 1)
  		or (not exists $vars->{'_OPEN_PAR_'} and scalar keys %{$vars} > 0)
  		) {
			($ast, $state, my $retval) = replace_consts_in_ast($stref, $f, $block_id, $ast, $state, 0);
			last if $retval == 0;
			# - check if the result is var-free, else repeat
			$vars=get_vars_from_expression($ast,{}) ;
  		}
  		# - return to be eval'ed
	return $ast;
} # END of replace_param_by_val()



sub eval_expression_with_parameters { (my $expr_str,my $info, my $stref, my $f) = @_;

    my $expr_ast=parse_expression($expr_str,$info, $stref,$f);
#    say Dumper($expr_ast);
    my $expr_ast2 = replace_param_by_val($stref, $f, 0,$expr_ast, {});
#    say Dumper($expr_ast2);
    my $evaled_expr_str= emit_expr_from_ast($expr_ast2);
#    say "TO EVAL:$evaled_expr_str";
    my $expr_val=eval($evaled_expr_str);
	return $expr_val;

} # END of eval_expression_with_parameters()


1;

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
	%sigil_codes
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
	# say ref($ast);
	if (ref($ast) eq 'ARRAY') {
		# But retval for arrays should only be 0 if it is 0 for every element!
		# So we need to sum them!
		for my  $idx (0 .. scalar @{$ast}-1) {
			
			my $entry = $ast->[$idx];

			if (ref($entry) eq 'ARRAY') {
				(my $entry2, $state, my $retval2) = replace_consts_in_ast($stref,$f, $block_id,$entry, $state,$const);
				$retval+=$retval2;
				# say "ARRAY ".Dumper($entry2). " RETVAL $retval";
				$ast->[$idx] = $entry2;
			} else {
				if ($idx==0 and (($entry & 0xFF) == 2)) { #eq '$'
					my $mvar = $ast->[$idx+1];
					# say "MVAR: $mvar in $f";
					if (exists $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'}{ $mvar }) { 
						$ast=''.$const.'';
						# say "MVAR $mvar RETURN $ast";
						return ($ast,$state,1);
					} elsif (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$mvar)) {
						my $param_set = in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$mvar);
						
		  				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$mvar);
		  				# say 'DECL: '. Dumper($decl);
		  				#The value could be an expression in terms of other parameters
		  				my $val = $decl->{'Val'};
		  				# carp( "MVAR $mvar MVAL: $val");	
		  				$ast = parse_expression($val, {},$stref,$f);
		  				return ($ast,$state,1);
					} elsif (in_nested_set($stref->{'Subroutines'}{$f},'Args',$mvar)) {
						# carp "VAR $mvar is an arg, not a parameter. Trying to eval anyway ... ";
						# if ( scalar keys %{$stref->{'Subroutines'}{$f}{'Callers'} }==1) {
							my $maybe_evaled_ast = __try_to_eval_arg($stref, $f, $mvar);
						# } 
						return ($maybe_evaled_ast,$state,1);
					} else {
						my $var_set = in_nested_set($stref->{'Subroutines'}{$f},'Vars',$mvar);	
						if ($var_set) {
							carp "replace_consts_in_ast($f,$const): Can\'t replace $mvar, no parameter record found in $f, it is a Var in $var_set";
							# So now we must find a line with an assignment to this var and do it again
 							my $eval_res = _try_to_eval_via_vars($stref, $f, $mvar);
							 croak Dumper($eval_res);
							return($eval_res,$state,1)	
						} else {
									croak "Cannot replace $mvar, no parameter or var record found in $f";
									return ($ast, $state,0);
						}
						

						
					}
				}
			}
		}
	} 
	# else {
	# 	say "NOT AN ARRAY: ".Dumper($ast);
	# }# else it must be a constant or what?
	# say "WHY? RETVAL $retval ";
	return  ($ast, $state, $retval);
} # END of replace_consts_in_ast()


# Constant folding
sub replace_param_by_val { (my $stref, my $f, my $block_id, my $ast, my $state)=@_;
  		# - see if $val contains vars
  		my $vars=get_vars_from_expression($ast,{}) ;
  		# - if so, substitute them using replace_consts_in_ast
  		while (
  		scalar keys %{$vars} > 0
  		) {
			($ast, $state, my $retval) = replace_consts_in_ast($stref, $f, $block_id, $ast, $state, 0);			
			last if $retval == 0;
			# - check if the result is var-free, else repeat
			$vars=get_vars_from_expression($ast,{}) ;
			# say Dumper($vars);
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
#    say "EXPR $expr_str TO EVAL:$evaled_expr_str";
   
    my $expr_val=eval($evaled_expr_str);
	return $expr_val;

} # END of eval_expression_with_parameters()

# This routine attempts to evaluate arguments by following them to the caller, 
# but in a very limited way.
sub __try_to_eval_arg { my ($stref,$f,$arg)=@_;
	# Get the caller and the ID of the line with the call in $f
	my $caller; my $line_id;
	for my $k (keys %{$stref->{'Subroutines'}{$f}{'Callers'} }) {
		$caller=$k;
		$line_id = $stref->{'Subroutines'}{$f}{'Callers'}{$k};
		last;
	};

	# Find the call to $f in $caller	
	my $pass_find_call= sub { my ($annline, $call_info)=@_;
		(my $line,my $info)=@{$annline};		
		my $new_annlines = [$annline];
		if ( exists $info->{'SubroutineCall'} 
			and	$info->{'SubroutineCall'}{'Name'} eq $f
		) {	
			$call_info->{$f} = $info;
		}		
		
		return ($new_annlines,$call_info);
	};
	
	my $call_info={};
 	($stref,$call_info) = stateful_pass($stref,$caller,$pass_find_call, $call_info,'_find_call ' . __LINE__  ) ;	

	# Find the call arguments 
	# warn "\n1. ARGMAP for call to $f in $caller:\n" .Dumper($call_info->{$f}{'SubroutineCall'}{'ArgMap'});
	my $call_arg = $call_info->{$f}{'SubroutineCall'}{'ArgMap'}{$arg};
	my $call_arg_type = $call_info->{$f}{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Type'};
	# warn '2. CALL ARG:'. Dumper($call_arg) . Dumper($call_arg_type);

	# Check if $call_arg is maybe a constant
	if ($call_arg_type eq 'Const') { 
		my $sub_type = $call_info->{$f}{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'SubType'};
		my $opcode = $sigil_codes{$sub_type};
		 return [$opcode,$call_arg];
	} 
	# Check if $call_arg is maybe an expression
	elsif ($call_arg_type eq 'Expr') {
		# warn 'EXPR:'. Dumper(
	 	# 	$call_info->{$f}{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}
		# );	
		my $expr_val = eval_expression_with_parameters($call_arg,{},  $stref, $caller) ;
			# assuming it is an integer, FIXME
			croak "Cannot eval $call_arg in $caller " unless defined $expr_val;
		return [29,$expr_val];	
	}
	# Check if $call_arg is maybe a parameter
	my $subset = in_nested_set( $stref->{'Subroutines'}{$caller}, 'Parameters', $call_arg );
	if ($subset) { # OK, this is a parameter, 
			my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$caller}{'Parameters'},$call_arg);
			my $val = $decl->{'Val'};
			my $ast = parse_expression($val, {},$stref,$f);
			# carp 'AST for parameter expression '.$call_arg.' : '.Dumper($ast);
			my $expr_val = eval_expression_with_parameters($val,{},  $stref, $caller) ;
			# assuming it is an integer, FIXME
			croak "Cannot eval $call_arg $val in $caller " unless defined $expr_val;
			return [29,$expr_val];
	} else {
		# OK, $call_arg is not a parameter in $caller, plough on

		my $expr_val = _try_to_eval_via_vars($stref, $caller, $call_arg);
		return $expr_val;
	}
}

#  call gop(dragpx,w1,'+  ',maxobj+1)
#  subroutine gop( x, w, op, n)
# 
# ARGMAP for call to gop in torque_calc:
# $VAR1 = {
#   'n' => undef,
#   'w' => 'w1',
#   'x' => 'torqvz',
#   'op' => '__PH0__'
# };

sub _try_to_eval_via_vars { my ($stref, $f, $var) = @_;
		# OK, $var is not a parameter in $f, plough on
		my $pass_find_assignment = sub {
			(my $annline, my $expr_asts)=@_;
			(my $line,my $info)=@{$annline};		
			my $new_annlines = [$annline];
			if (exists $info->{'Assignment'} 
			
			and $info->{'Lhs'}{'VarName'} eq $var
			and $info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' # no nonsense!
			) {	
				# warn  "3. ASSIGNMENT LINE: ". $line;a 
				$expr_asts->{$var}=$info->{'Rhs'}{'ExpressionAST'};
			}				
			return ($new_annlines,$expr_asts);
		};

		my $expr_asts={};

		($stref,$expr_asts) = stateful_pass($stref,$f,$pass_find_assignment, $expr_asts,'_find_assignment ' . __LINE__  ) ;	

		if (defined $expr_asts->{$var}) {
			# OK, there was an assigment line.
		
			my $expr_str = emit_expr_from_ast($expr_asts->{$var});

			my $expr_val = eval_expression_with_parameters ( $expr_str,{} 	,  $stref, $f) ;
			croak "Cannot eval $var via $expr_str in $f " unless defined $expr_val;		
			return [29,$expr_val]
		} else {
			# Instead of assigment, it could be a sig arg of the caller
			my $subset = in_nested_set( $stref->{'Subroutines'}{$f}, 'Args', $var );
			
			if ($subset) {
				my $result_expr = __try_to_eval_arg($stref,$f,$var);
				return $result_expr;
			} else {
				die "Sorry, can\'t evaluate $var in $f, giving up.";
			}
		}
} # END of try_to_eval_via_vars


1;
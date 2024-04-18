package RefactorF4Acc::ExpressionAST::Evaluate;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::F95SpecWords qw( 
	%F95_intrinsics 
	%F95_intrinsic_functions_for_eval 
	%F95_intrinsic_function_sigs 
	);
use RefactorF4Acc::Refactoring::Helpers qw(
	pass_wrapper_subs_in_module
	stateful_pass_inplace
	stateful_pass_reverse_inplace
	stateless_pass_inplace
	emit_f95_var_decl
	splice_additional_lines_cond_inplace
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
$VERSION = "5.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::ExpressionAST::Evaluate::ISA = qw(Exporter);

# eval_expression_with_parameters :: ExprString -> Val
# eval_expression_with_parameters: parse the expression string, substitute all params by their values (recursively) and compute the final expression value
# 	replace_param_by_val: part of eval_expression_with_parameters, it changes the parameters by their values in the AST.
# 		replace_consts_in_ast: part of replace_param_by_val; this returns an AST where all params are replaced by their value expressions
# _try_to_eval_arg extends this from parameters to subroutine arguments; calls eval_expression_with_parameters and _try_to_eval_via_vars
# _try_to_eval_via_vars extends this to local variables; calls eval_expression_with_parameters and _try_to_eval_arg

# I have a feeling this could be refactored to make it more elegant


@RefactorF4Acc::ExpressionAST::Evaluate::EXPORT_OK = qw(
&eval_expression_with_parameters
&eval_intrinsic
&replace_param_by_val
&replace_consts_in_ast
&replace_consts_in_ast_no_iters
&fold_constants_in_expr
&fold_constants_in_expr_no_iters
);


# We replace LoopIters with $const and Parameters with their values.
# Apply to RHS of assignments
sub replace_consts_in_ast { (my $stref, my $f, my $block_id, my $ast, my $state, my $const)=@_;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $retval=0;
	# say "AST in replace_consts_in_ast:",Dumper($ast);
	if (ref($ast) eq 'ARRAY') {
		# say 0 .. (scalar( @{$ast})-1) ;
		# But retval for arrays should only be 0 if it is 0 for every element!
		# So we need to sum them!
		for my  $idx (0 .. (scalar( @{$ast})-1)) {
			my $entry = $ast->[$idx];
			if (ref($entry) eq 'ARRAY') {
				# say 'RECURSE ON ',Dumper($entry);
				(my $entry2, my $retval2) = replace_consts_in_ast($stref,$f, $block_id,$entry, $state,$const);
				$retval+=$retval2;
				# say "ARRAY ".Dumper($entry2). " RETVAL $retval";
				$ast->[$idx] = $entry2;
			} else {
				# carp Dumper $entry;
				if ($idx==0 and (($entry & 0xFF) == 2)) { #eq '$'
					my $mvar = $ast->[$idx+1];
					# say "$f VAR $mvar ".Dumper($ast);
					# If $mvar is a loop iterator for a loop nest with ID $block_id,
					# we replace it with a constant value, this is to estimate bounds
					if (exists $state->{$block_id}{'LoopIters'}{ $mvar }) {
						$ast= ref($const) eq 'ARRAY' ? $const : ''.$const.'';
						# $ast->[$idx+1] =  ''.$const.'';
						# say "MVAR $mvar RETURN $ast";
						return ($ast,1);
					} elsif (in_nested_set($stref->{$sub_or_func_or_mod}{$f},'Parameters',$mvar)) {
						my $param_set = in_nested_set($stref->{$sub_or_func_or_mod}{$f},'Parameters',$mvar);

		  				my $decl = get_var_record_from_set( $stref->{$sub_or_func_or_mod}{$f}{'Parameters'},$mvar);
		  				# say 'DECL: '. Dumper($decl);
		  				#The value could be an expression in terms of other parameters
		  				my $val = $decl->{'Val'};
		  				# carp( "MVAR $mvar MVAL: $val");
		  				$ast = parse_expression($val, {},$stref,$f);
		  				return ($ast,1);
					} elsif (in_nested_set($stref->{$sub_or_func_or_mod}{$f},'Args',$mvar)) {
						# carp "VAR $mvar is an arg in $f, not a parameter. Trying to eval anyway ... ";
						# if ( scalar keys %{$stref->{$sub_or_func_or_mod}{$f}{'Callers'} }==1) {
							my $maybe_evaled_ast = _try_to_eval_arg($stref, $f, $mvar);
						# }
						return ($maybe_evaled_ast,1);
					} else {
						my $var_set = in_nested_set($stref->{$sub_or_func_or_mod}{$f},'Vars',$mvar);
						# FIXME: parameters from USEd modules are not found?!
						if ($var_set) {
							carp "replace_consts_in_ast($f,$const): Can\'t replace $mvar, no parameter record found in $f, it is a Var in $var_set"
							if $DBG;
							# So now we must find a line with an assignment to this var and do it again

 							my $eval_res = _try_to_eval_via_vars($stref, $f, $mvar);
							 croak Dumper($eval_res) if $DBG;
							if (scalar @{$eval_res} == 0) {
								return($ast,0)
							} else {
								return ($ast,1);
							}
						} else {
							croak "Cannot replace $mvar, no parameter or var record found in $f"
							."\n". Dumper( $stref->{$sub_or_func_or_mod}{$f}{Parameters}   ) if $DBG;
							return ($ast,0);
						}
					}
				}
			}
		} # for idx
	}
	# else {
	# 	say "NOT AN ARRAY: ".Dumper($ast);
	# }# else it must be a constant or what?
	# say "WHY? RETVAL $retval ";
	return  ($ast, $retval);
} # END of replace_consts_in_ast()

sub replace_consts_in_ast_no_iters { my ($stref, $f, $ast, $state)=@_;
	my $retval=0;
	# say "AST in replace_consts_in_ast_no_iters:".Dumper($ast);
	if (ref($ast) eq 'ARRAY') {
		# But retval for arrays should only be 0 if it is 0 for every element!
		# So we need to sum them!
		for my  $idx (0 .. scalar @{$ast}-1) {
			my $entry = $ast->[$idx];
			if (ref($entry) eq 'ARRAY') {
				(my $entry2, my $retval2) = replace_consts_in_ast_no_iters($stref,$f, $entry, $state);
				$retval+=$retval2;
				$ast->[$idx] = $entry2;
			} else {
				if ($idx==0 and (($entry & 0xFF) == 2)) { #eq '$'
					my $mvar = $ast->[$idx+1];
					my $sub_or_func = sub_func_incl_mod($f,$stref);
					if (in_nested_set($stref->{$sub_or_func}{$f},'Parameters',$mvar)) {
						my $param_set = in_nested_set($stref->{$sub_or_func}{$f},'Parameters',$mvar);

		  				my $decl = get_var_record_from_set( $stref->{$sub_or_func}{$f}{'Parameters'},$mvar);

		  				#The value could be an expression in terms of other parameters
		  				my $val = $decl->{'Val'};
		  				$ast = parse_expression($val, {},$stref,$f);
		  				return ($ast,1);
					} else {
						return ($ast,1);
					}
				}
				elsif ($idx==0 and (($entry & 0xFF) == 1) ) { #eq '&'
					my $fname = $ast->[$idx+1];
					if (exists $F95_intrinsics{$fname}) {
						# fold the arguments
						my $entry = $ast->[$idx+2];
						(my $entry2, my $retval2) = replace_consts_in_ast_no_iters($stref,$f, $entry, $state);
						if ($retval2==1 ) {
							my $evaled_expr_str= $fname.'('.emit_expr_from_ast($entry2).')';
							my $expr_val_ast = eval_intrinsic($evaled_expr_str,[1,$fname,$entry2]);
							return ($expr_val_ast,1);
						}
					}
				}
			}
		}
	}

	return  ($ast, $retval);

} # END of replace_consts_in_ast_no_iters

# Constant folding
# replace_param_by_val ::  StRef -> SubName -> BlockID -> AST -> State -> AST
# State = {}
sub replace_param_by_val { (my $stref, my $f, my $block_id, my $ast, my $state)=@_;
  		# - see if $val contains vars
  		my $vars=get_vars_from_expression($ast,{}) ;
  		# - if so, substitute them using replace_consts_in_ast
  		while (
  		scalar keys %{$vars} > 0
  		) {
			($ast, my $retval) = replace_consts_in_ast($stref, $f, $block_id, $ast, $state, 0);
			last if $retval == 0;
			# - check if the result is var-free, else repeat
			$vars=get_vars_from_expression($ast,{}) ;
			# say Dumper($vars);
  		}
  		# - return to be eval'ed
	return $ast;
} # END of replace_param_by_val()

sub fold_constants_in_expr { (my $stref, my $f, my $block_id, my $ast)=@_;
  		# - see if $val contains vars
  		my $vars=get_vars_from_expression($ast,{}) ;
  		# - if so, substitute them using replace_consts_in_ast
		# we should stop when it does not change anymore
		my $prev_vars_str='';
		my $vars_str=join('',sort keys %{$vars});
  		while (
			  $prev_vars_str ne $vars_str
			    		# scalar keys %{$vars} > 0
  		) {
			  $prev_vars_str=$vars_str;
			($ast, my $retval) = replace_consts_in_ast($stref, $f, $block_id, $ast, $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}, [29,0]);
			last if $retval == 0;
			# - check if the result is var-free, else repeat
			$vars=get_vars_from_expression($ast,{}) ;
			$vars_str = join('',sort keys %{$vars});

  		}
  		# - return to be eval'ed
	return $ast;
} # END of fold_constants_in_expr()

sub fold_constants_in_expr_no_iters { my ($stref, $f, $ast, $info)=@_;
  		# - see if $val contains vars
  		my $vars=get_vars_from_expression($ast,{}) ;
  		# - if so, substitute them using replace_consts_in_ast
		# we should stop when it does not change anymore
		my $prev_vars_str='';
		my $vars_str=join('',sort keys %{$vars});
  		while (
			  $prev_vars_str ne $vars_str
  		) {
			  $prev_vars_str=$vars_str;
			($ast, my $retval) = replace_consts_in_ast_no_iters($stref, $f, $ast, $info);
			last if $retval == 0;
			# - check if the result is var-free, else repeat
			$vars=get_vars_from_expression($ast,{}) ;
			$vars_str = join('',sort keys %{$vars});

  		}
  		# - return to be eval'ed
	return $ast;

} # END of fold_constants_in_expr_no_iters

# This is designed to return integers 
sub eval_expression_with_parameters { (my $expr_str,my $info, my $stref, my $f, my $err) = @_;
	# say "EXPR STR $expr_str";
	if (not defined $err) {$err=0}
	my $expr_str_no_ph = _substitute_PlaceHolders($expr_str,$info);
    my $expr_ast=parse_expression($expr_str_no_ph,$info, $stref,$f);
	# croak Dumper $expr_ast if $expr_str =~/__PH/;
    my $expr_ast2 = replace_param_by_val($stref, $f, 0,$expr_ast, {});
	my $evaled_expr_str= emit_expr_from_ast($expr_ast2);
	if ($expr_ast2->[0] ==1 and exists $F95_intrinsics{$expr_ast2->[1]} ) {
		# my $evaled_val = eval_expression_with_parameters($val_expr_str,$info, $stref, $f) ;
		# TODO: this only works if the args are constant literals. Need to eval the args.
		my $expr_val_ast = eval_intrinsic($evaled_expr_str,$expr_ast2);
		carp "INTRINSIC EXPR <$expr_str> TO EVAL: $evaled_expr_str => ",Dumper($expr_val_ast);
		if ($expr_val_ast->[0] != 29) {
			if ($err) {
				error("$expr_str does not reduce to an integer");
			} 
			return $evaled_expr_str;
		} else {
			return $expr_val_ast->[1];
		}
	} else {
		$evaled_expr_str=~s/\-/ -/g;
		$evaled_expr_str=~s/\/\//./g;
		my $expr_val=eval($evaled_expr_str);
		# croak "EXPR <$expr_str> TO EVAL: $evaled_expr_str => $expr_val".Dumper($info) if $expr_str_no_ph =~/CONCAT/;
		# carp Dumper($evaled_expr_str,$info);
		if (exists $info->{'ParsedParDecl'} and $info->{'ParsedParDecl'}{'TypeTup'}{'Type'} eq 'character') {
			if ($err) {
				error("$expr_str does not reduce to an integer");
			}
			return "'".$expr_val."'";
		} else {
			return $expr_val;
		}
	}
} # END of eval_expression_with_parameters()

# This returns an AST for constant folding
sub eval_expression_with_parameters_to_AST { (my $expr_str,my $info, my $stref, my $f) = @_;
	# say "EXPR STR $expr_str";
	my $expr_str_no_ph = _substitute_PlaceHolders($expr_str,$info);
    my $expr_ast=parse_expression($expr_str_no_ph,$info, $stref,$f);
	# croak Dumper $expr_ast if $expr_str =~/__PH/;
    my $expr_ast2 = replace_param_by_val($stref, $f, 0,$expr_ast, {});
	my $evaled_expr_str= emit_expr_from_ast($expr_ast2);
	if ($expr_ast2->[0] ==1 and exists $F95_intrinsics{$expr_ast2->[1]} ) {
		# my $evaled_val = eval_expression_with_parameters($val_expr_str,$info, $stref, $f) ;
		# TODO: this only works if the args are constant literals. Need to eval the args.
		my $expr_val_ast = eval_intrinsic($evaled_expr_str,$expr_ast2);
		# say "INTRINSIC EXPR <$expr_str> TO EVAL: $evaled_expr_str => <$expr_val>";
		return $expr_val_ast;
	} else {
		$evaled_expr_str=~s/\-/ -/g;
		$evaled_expr_str=~s/\/\//./g;
		my $expr_val=eval($evaled_expr_str);
		# croak "EXPR <$expr_str> TO EVAL: $evaled_expr_str => $expr_val".Dumper($info) if $expr_str_no_ph =~/CONCAT/;
		if ($info->{'ParsedParDecl'}{'TypeTup'}{'Type'} eq 'character') {
			return [32,"'".$expr_val."'"];
		} elsif ($info->{'ParsedParDecl'}{'TypeTup'}{'Type'} eq 'integer') {
			return [29,$expr_val];
		} elsif ($info->{'ParsedParDecl'}{'TypeTup'}{'Type'} eq 'logica') {
			croak "TODO: support for logical";
			return [31,$expr_val];
		} else { # assume it's a real
			return [30,$expr_val];
		}
	}
} # END of eval_expression_with_parameters_to_AST()

# This routine attempts to evaluate arguments by following them to the caller,
# but in a very limited way.
sub _try_to_eval_arg { my ($stref,$f,$arg)=@_;
# warn "\nSUB $f ARG: $arg TRY CALLER\n";
	# Get the caller and the ID of the line with the call in $f
	my $caller; my $line_id;
	for my $k (keys %{$stref->{'Subroutines'}{$f}{'Callers'} }) {
		$caller=$k;
		$line_id = $stref->{'Subroutines'}{$f}{'Callers'}{$k};
		last;
	};

	# Find the call to $f in $caller
	# say "Find the call to $f in $caller	";
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
 	($stref,$call_info) = stateful_pass_inplace($stref,$caller,$pass_find_call, $call_info,'_find_call ' . __LINE__  ) ;

	# Find the call arguments
	# warn "\n1. ARGMAP for call to $f in $caller:\n" .Dumper($call_info->{$f}{'SubroutineCall'}{'ArgMap'});
	# carp Dumper $stref->{'Subroutines'}{$f}{'Args'};
	# At this point, ExGlobArgs are not in the ArgMap. So I should do a check
	my $call_arg = exists $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'Set'}{$arg} ? $arg :
		$call_info->{$f}{'SubroutineCall'}{'ArgMap'}{$arg};
# As this can be called before COMMON vars have been turned into args, 
# it is possible that $arg is not in the ArgMap
	my $call_arg_type = exists $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'Set'}{$arg} ? 
		$stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'Set'}{$arg}{'ArrayOrScalar'} :
		$call_info->{$f}{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Type'};
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
			croak "Cannot eval $call_arg in $caller "  if $DBG and not defined $expr_val;
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
			croak "Cannot eval $call_arg $val in $caller "  if $DBG and not defined $expr_val;
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

sub _try_to_eval_via_vars  {my ($stref, $f, $var) = @_;
		# OK, $var is not a parameter in $f, plough on
		my $pass_find_assignment = sub {
			(my $annline, my $expr_asts)=@_;
			(my $line,my $info)=@{$annline};
			my $new_annlines = [$annline];
			my $no_self_assignment=1;
			if (exists $info->{'Assignment'}
			and $info->{'Lhs'}{'VarName'} eq $var
			and exists $info->{'Rhs'}{'Vars'}{'Set'}{$var}
			) {
				$no_self_assignment=0;
			}
			if (exists $info->{'Assignment'}

			and $info->{'Lhs'}{'VarName'} eq $var
			and $info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' # no nonsense!
			and $no_self_assignment
			) {
				# warn  "3. ASSIGNMENT LINE: ". $line;a
				$expr_asts->{$var}=$info->{'Rhs'}{'ExpressionAST'};
			}
			return ($new_annlines,$expr_asts);
		};

		my $expr_asts={};

		($stref,$expr_asts) = stateful_pass_inplace($stref,$f,$pass_find_assignment, $expr_asts,'_find_assignment ' . __LINE__  ) ;

		if (defined $expr_asts->{$var}) {
			# OK, there was an assigment line.

			my $expr_str = emit_expr_from_ast($expr_asts->{$var});

			my $expr_val = eval_expression_with_parameters ( $expr_str,{} 	,  $stref, $f) ;
			if (not defined $expr_val) {
				if( $DBG){
					croak "Cannot eval $var via $expr_str in $f "
				} else {
					return [];
				}
			} else {
				return [29,$expr_val];
			}
		} else {
			# Instead of assigment, it could be a sig arg of the caller
			my $subset = in_nested_set( $stref->{'Subroutines'}{$f}, 'Args', $var );

			if ($subset) {
				my $result_expr = _try_to_eval_arg($stref,$f,$var);
				return $result_expr;
			} else {
				if ($DBG) {
				croak "Sorry, can\'t evaluate $var in $f, giving up.";
				} else {
					return [];#[2,$var];
				}
			}
		}
} # END of _try_to_eval_via_vars

sub eval_intrinsic { my ($val_expr_str,$val_expr_ast) = @_;
    my $intr = $val_expr_str;
    $intr=~s/\s*\(.+$//;
    my $intr_args_str = $val_expr_str;
    $intr_args_str =~s/\s*\)\s*$//;
    $intr_args_str =~s/$intr\s*\(\s*//;
    my @intr_args = split(/\s*,\s*/,$intr_args_str);
    for my $intr_arg (@intr_args) {
        if ($intr_arg=~/^[a-z_]/) {
            warning("Evaluating intrinsics only works with constant arguments: $val_expr_str",0,'ERROR');
			return $val_expr_ast;
        }
    }
	if ($intr eq 'achar' and $intr_args[0] == 10) {
		# This evals to a newline which we can't print in Fortran, so just keep it.
		return $val_expr_ast;
	}

    my $intr_calc = $F95_intrinsic_functions_for_eval{$intr};
	my $sub_type = $F95_intrinsic_function_sigs{$intr}[-1];
	my $res = $intr_calc->(@intr_args);
	my $opcode = ($sub_type ne 'a')
		? $sigil_codes{$sub_type}
		: ($intr_args_str=~/\./) ? 30 : 29 ;
	return [$opcode,$res];
} # END of eval_intrinsic

sub _substitute_PlaceHolders { my ($expr_str,$info) = @_;
    if ($expr_str=~/__PH/ and exists $info->{'PlaceHolders'}) {
        # croak $expr_str.Dumper($info->{'PlaceHolders'})
        while ($expr_str =~ /(__PH\d+__)/) {
            my $ph=$1;
            my $ph_str = $info->{'PlaceHolders'}{$ph};
            $ph_str=~s/[\'\"]$/\"/;
            $ph_str=~s/^[\']/\"/;
            $expr_str=~s/$ph/$ph_str/;
        }
    }
    return $expr_str;
} # END of _substitute_PlaceHolders


1;

package RefactorF4Acc::Parser::Expressions;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils qw( sub_func_incl_mod );
use RefactorF4Acc::CallTree qw( add_to_call_tree );
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
$Data::Dumper::Indent = 1;

use Fortran::Expression::Evaluator::Parser; 
use RefactorF4Acc::Utils qw( %F95_reserved_words %F95_function_like_reserved_words %F95_intrinsics %F95_other_intrinsics %F95_intrinsic_functions );
use Exporter;

@RefactorF4Acc::Parser::Expressions::ISA = qw(Exporter);

@RefactorF4Acc::Parser::Expressions::EXPORT_OK = qw(
  &parse_expression
  &get_vars_from_expression
  &get_args_vars_from_expression
  &get_consts_from_expression
  &get_args_vars_from_subcall
  &emit_expr_from_ast
  &interpret
  &parse_expression_no_context
  &_find_consts_in_ast
  &find_vars_in_ast
  &_find_args_in_ast
  &find_args_vars_in_ast
  &find_assignments_to_scalars_in_ast
  &find_implied_do_in_ast
  &_traverse_ast_with_action
  @sigils
  %sigil_codes
  $defaultToArrays
);


our $defaultToArrays = 0;
my $DBG=0;
 
#               0    1    2    3    4    5    6    7    8    9    10   11   12   13    14
our @sigils = ('{', '&', '$', '+', '-', '*', '/', '%', '**', '=', '@', '#', ':' ,'//', ')('
#                15    16    17  18   19    20     21       22       23      24       25       26      
               ,'==', '/=', '<', '>', '<=', '>=', '.not.', '.and.', '.or.', '.xor.', '.eqv.', '.neqv.'
#                27   28 
               ,',', '(/',
# Constants               
#                29        30      31         32           33             34       35 
               ,'integer', 'real', 'logical', 'character', 'PlaceHolder', 'Label', 'BLANK'
              );
my $opcode=0;
our %sigil_codes = map { $_ => $opcode++  } @sigils;

my %F95_ops =(
	'==' => '.eq.',  
    '/=' => '.ne.',  
    '<=' => '.le.',  
    '>=' => '.ge.',
	'eq' => '==',
	'ne' => '/=',
	'le' => '<=',
	'ge' => '>=',     			
);
# Returns the AST
sub parse_expression { my ($exp, $info, $stref, $f)=@_;
	
		(my $ast, my $rest, my $err, my $has_funcs)  = parse_expression_no_context($exp);
		if($DBG and $err or $rest ne '') {
            croak "PARSE ERROR in <$exp>, REST: $rest";
#            return ($ast,$rest,$err);
		}
        #say 'AST:'.Dumper($ast);
        (my $ast2, my $grouped_messages) = $has_funcs ? _replace_function_calls_in_ast($stref,$f,$info,$ast, $exp, {}) : ($ast,{});
        #say 'AST2:'.Dumper($ast2);
	    if ($W) {
	        for my $warning_type (sort keys % {$grouped_messages->{'W'}} ) {
	            for my $k (sort keys %{$grouped_messages->{'W'}{$warning_type}}) {
	                my $line = $grouped_messages->{'W'}{$warning_type}{$k};
	                say $line;
	            }
	        }
	    }		
	    return $ast2;
	
} # END of parse_expression()

# This function changes functions to arrays
sub _change_func_to_array { (my $stref, my $f,  my $info, my $ast, my $exp, my $grouped_messages)=@_;
        #my $DBG=1;
	my $code_unit = sub_func_incl_mod( $f, $stref );
	if (ref($ast) eq 'ARRAY') {
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
#carp Dumper($ast);
		if (ref($entry) eq 'ARRAY') {
			(my $entry, $grouped_messages) = _change_func_to_array($stref,$f, $info,$entry, $exp,$grouped_messages);
			$ast->[$idx] = $entry;
		} else {
			if ($idx == 0) {
			if (($entry & 0xFF) == 1) {				
				my $mvar = $ast->[$idx+1];
				say 'Found function or array '.$mvar  if $DBG;
				
				# If the line is not a subroutine call, we set subname to #dummy#
				# We do this to check if the $mvar is maybe the subroutine itself
				my $subname = (exists $info->{'SubroutineCall'} and exists $info->{'SubroutineCall'}{'Name'}) ? $info->{'SubroutineCall'}{'Name'} : '#dummy#';
				# Now, when is $mvar NOT a function?
				# - if $mvar ne $subname including #dummy#, because this function is used for parsing both subcalls and assignments
				#	AND $mvar is not a called sub in $f AND $mvar is not an unmasked intrinsic
				# - if $mvar is in MaskedIntrinsics then it's a var masking an intrinsic
				# - if $f does not have a Called Sub named $mvar. Seems acceptable, but what if it's a function call and we have v = f(x) ?
				# So I say, if $mvar is the name of a subroutine in the whole source code base, and it's a function
				# 
				
				
 				if (
 					(
 				# 1. $mvar is not a function, including intrinsic
 					not(  (
 					exists $stref->{$code_unit}{$mvar} and 
 					exists $stref->{$code_unit}{$mvar}{'Function'} and 
 					$stref->{$code_unit}{$mvar}{'Function'} == 1 ) or (
 					exists $F95_intrinsics{$mvar} or
 					exists $F95_function_like_reserved_words{$mvar} # WV 2019-04-17
 					) 
 					
 					)
 				# 2. OR $mvar is a masked intrinsic	 
 					or exists $stref->{$code_unit}{$f}{'MaskedIntrinsics'}{$mvar}
 					) 
# 					or (
#				# 3. OR $mvar is actually an array 					 					  	
# 					$mvar ne '#dummy#' and $mvar ne $subname 
# 					and not exists $stref->{$code_unit}{$f}{'CalledSubs'}{'Set'}{$mvar}
#					and not exists $F95_reserved_words{$mvar}
##					and not exists $F95_intrinsics{$mvar} # Dangerous, because some idiot may have overwritten an intrinsic with an array! 					
#					)							
				) {
    		# change & to @
#    		croak '<'.(
#    		not( 
# 					exists $stref->{$code_unit}{$mvar} and 
# 					exists $stref->{$code_unit}{$mvar}{'Function'} and 
# 					$stref->{$code_unit}{$mvar}{'Function'} == 1
# 					)
#    		).'><'.( exists $stref->{$code_unit}{$f}{'MaskedIntrinsics'}{$mvar} ).'>' if $mvar eq 'aint';

    				$ast->[$idx]=  10 + (($ast->[$idx]>>8)<<8);#    '@';
    				say "\tFound array $mvar" if $DBG;
#    				croak Dumper($stref->{$code_unit}{$f}{'MaskedIntrinsics'}). (exists $F95_intrinsics{$mvar}) if $mvar eq 'write';
				} elsif (   	exists $F95_intrinsics{$mvar} ) {
					say "parse_expression('$exp') " . __LINE__ if $DBG;
                    say "WARNING: treating $mvar in $f as an intrinsic! " if $DBG;
					$grouped_messages->{'W'}{'VAR_AS_INTRINSIC'}{$mvar} =   "WARNING: treating $mvar in $f as an intrinsic! " if $WW;  
				} elsif (   	exists $F95_function_like_reserved_words{$mvar} ) {
					say "parse_expression('$exp') " . __LINE__ if $DBG;
                    say "Treating $mvar in $f as a function-like reserved word " if $DBG;
					$grouped_messages->{'W'}{'VAR_AS_INTRINSIC'}{$mvar} =   "WARNING: Treating $mvar in $f as a function-like reserved word  " if $WW;  
				} else {
					# FUNCTION CALL
					# So, this line contains a function call, so we should say so in $info!
					# I introduce FunctionCalls for this purpose!
					if (
					( exists $stref->{$code_unit}{$mvar} and exists $stref->{$code_unit}{$mvar}{'Function'} 
					  and $stref->{$code_unit}{$mvar}{'Function'} == 1) # It's def a function! 
					  and ( # 
						$mvar ne '#dummy#' and $mvar ne $subname 
 						and not exists $stref->{$code_unit}{$f}{'CalledSubs'}{'Set'}{$mvar}
						and not exists $F95_reserved_words{$mvar} 					
						)
					) {
						

						( my $expr_args, my $expr_other_vars ) = get_args_vars_from_subcall($ast);
						for my $expr_arg (@{$expr_args->{'List'}}) {
							if (substr($expr_arg,0,1) eq '*') {
								my $label=substr($expr_arg,1);
								$stref->{$code_unit}{$f}{'ReferencedLabels'}{$label}=$label;		
							}
						}
#die "TAG FunctionCalls $mvar in $f: ".Dumper($expr_args) if $mvar =~/rad2deg/i;
						push @{ $info->{'FunctionCalls'} },  {
							'Name' => $mvar,
							'Args' => $expr_args,
							'ExprVars' => $expr_other_vars,
							'ExpressionAST' => $ast,						
						};	
						# Add to CalledSubs for $f
						$stref->{$code_unit}{$f}{'CalledSubs'}{'Set'}{$mvar} = 2;
						push @{ $stref->{$code_unit}{$f}{'CalledSubs'}{'List'} }, $mvar;
						# Add $f to Callers for $mvar
						my $Sname =  $stref->{'Subroutines'}{$mvar};
						$Sname->{'Called'} = 1;
						if ( not exists $Sname->{'Callers'}{$f} ) {
							$Sname->{'Callers'}{$f} = [];
						}						
						push @{ $Sname->{'Callers'}{$f} }, $idx; # I know, this is the index in the AST, not the line number!
						# Add to the call tree
						$stref = add_to_call_tree( $mvar, $stref, $f );														
					}
				} 
			} elsif ($entry & 0xFF == 2) {
				my $mvar = $ast->[$idx+1];
				say "Found scalar $mvar" if $DBG;
				
			} elsif ($entry & 0xFF == 10) {
				my $mvar = $ast->[$idx+1];
				say "Found array $mvar" if $DBG;
			} elsif ($entry & 0xFF == 11) {
				my $mvar = $ast->[$idx+1];
				say "Found dummy $mvar" if $DBG;				
			} else {
				# This is either an operation or a constant
#				say $entry;
			}
			}
		}		
	}
	}

	return  ($ast, $grouped_messages);#($stref,$f, $ast);	
	
} # END of _change_func_to_array()

=coding
	{	0
	&	1
	$	2
	
	+	3
	-	4
	
	*	5
	/	6
	%	7
	
	^	8
	
	=	9
	@	10
	#	11
		12
		13
		14
		15	
=cut

# All variables in the expression
# $vars = {} to start
sub get_vars_from_expression {(my $ast, my $vars)=@_;
    croak  if $DBG and not ref($ast) eq 'ARRAY';
    $vars = find_vars_in_ast($ast,$vars);
	return $vars;		
} # END of get_vars_from_expression

# All variables in the expression
# $vars = {} to start
sub get_consts_from_expression {(my $ast, my $vars)=@_;
	croak if $DBG and not ref($ast) eq 'ARRAY';
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			$vars = get_consts_from_expression( $entry, $vars);			
		} else {
			my $val = $entry;
			if (
				($idx == 0) &&
				(($entry & 0xFF)==4)
			) {  # '-'
				 $val =$ast->[$idx+1];
			}
			if ($val =~/^[\.\d]/ ) {
				my $type='Unknown';
				if ( $val =~ /^\-?\d+$/ ) {
					$type = 'integer';
				}
				elsif ( $val =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edqEDQ][\-\+]?\d+)?)$/ ) {
					$type = 'real';
				} 
				$vars->{$val}=$type ;					
			} 
		}				
	}
	return $vars;		
}


# if the expression is a sub call (or in fact just a comma-sep list), return the arguments and also all variables that are not arguments
sub get_args_vars_from_expression {(my $ast)=@_;
#	FIXME!
	my $all_vars={'List'=>[],'Set'=>{} };
	my $args={'List'=>[],'Set'=>{}};
	if (ref($ast) eq 'ARRAY') {
			
	for my  $idx (0 .. scalar @{$ast}-1) {
		
		if ( ($idx == 0) &&
		 (($ast->[$idx] & 0xFF)==10)
		 ) {# eq '@'
			my $arg = $ast->[$idx+1];
			my $vars = get_vars_from_expression($ast,{} );
			delete $vars->{$arg}; 
			$all_vars->{'Set'}=$vars;
			$args->{'Set'}{$arg}={ 'Type'=>'Array','Vars'=>$vars};
			last;
		} else {
			
		if( ref( $ast->[$idx] ) ne '') {
			# So it's an array
			my $arg = $ast->[$idx][1];
			if ( 
					(($ast->[$idx][0] & 0xFF) == 10) # eq '@' 
				or  (($ast->[$idx][0] & 0xFF) == 2) #  eq '$'
				or  (($ast->[$idx][0] & 0xFF) == 1) # eq '&'
			) {
				if (
				(($ast->[$idx][0] & 0xFF) == 10) or  # '@'
				(($ast->[$idx][0] & 0xFF) == 1)  # '&'
				) {
					my $vars = get_vars_from_expression($ast->[$idx],{} );
					delete $vars->{$arg}; 
					$all_vars->{'Set'}={%{ $all_vars->{'Set'} },%{$vars}};
					if (
						($ast->[$idx][0] & 0xFF) == 10 #eq '@'
					) {
						$args->{'Set'}{$arg}={ 'Type'=>'Array','Vars'=>$vars};
					} elsif($ast->[$idx][1] eq 'do')	{ 
						my $tast=[@{$ast->[$idx]}];
						while($tast->[1] eq 'do') {
							$tast=$tast->[2]
						}
						
						my $arg_from_implicit_do = $tast->[1];
						$args->{'Set'}{$arg_from_implicit_do}={ 'Type'=>'Array'};
						delete $all_vars->{'Set'}{$arg_from_implicit_do};
					}
				} elsif($arg!~/__PH\d+__/ and $arg!~/_(?:CONCAT|COLON)_(?:PRE|POST)_/ and $arg!~/_PAREN_PAIR_/) {				
					$args->{'Set'}{$arg}={ 'Type'=>'Scalar'};
				} 
			} else {
				# This is an expression in its own right. 
				my $vars = get_vars_from_expression($ast->[$idx],{} );
						$all_vars->{'Set'}={%{ $all_vars->{'Set'} },%{$vars}};
			}
		} elsif (
			($idx==0) && 
			(($ast->[$idx] & 0xFF) == 2) #eq '$'
		) { 
			my $arg=$ast->[$idx+1];			
			$args->{'Set'}{$arg}={ 'Type'=>'Scalar'} unless ( $arg=~/__PH\d+__/ or $arg=~/_(?:CONCAT|COLON)_PRE_/ or $arg=~/_PAREN_PAIR_/);
		}
		}
	}	
	$args->{'List'} = [keys %{ $args->{'Set'} }]; 
	$all_vars->{'List'} = [keys %{ $all_vars->{'Set'} }]; 
	}
	return [$args,$all_vars];
} # END of get_args_vars_from_expression

# if the expression is a sub call (or in fact just a comma-sep list), return the arguments and also all variables that are not arguments
# We can of course have duplication here, and also some of the args can be functions or expressions. 
# So we have Args that can be Scalar, Array, Sub, Expr or Const

sub get_args_vars_from_subcall {(my $ast)=@_;
    my $args={'List'=>[],'Set'=>{}};
	my $all_vars={'List'=>[],'Set'=>{} };

	my $vars = get_vars_from_expression($ast,{} );
	$all_vars->{'Set'}=$vars;    
	$args = _parse_subcall_args($ast, $args);

	$all_vars->{'List'} = [sort keys %{ $all_vars->{'Set'} }];
	return ($args,$all_vars);
} # END of get_args_vars_from_subcall

sub _fix_colons_in_ast { (my $orig_ast)=@_;
	my $ast=_fix_colons_in_expr($orig_ast);
	if ( ref($ast) eq 'ARRAY') {
	my $new_ast=[];
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			my $new_entry = _fix_colons_in_ast($entry);
			push @{$new_ast}, $new_entry;
		} else {
			push @{$new_ast}, $entry;
		} 		
	}
	return $new_ast;			
	} else {
		return $ast;
	}
}
 
sub _fix_colons_in_expr { (my $ast)=@_;
	if ( ref($ast) eq 'ARRAY' ) {
		my $cloned_ast = [@{$ast}];
	    my $new_ast=();
	    for my $i ( 0 ..   @{$cloned_ast} -1 ) {
	        my $elt=$cloned_ast->[$i];
	        next unless defined $elt;
	        
	        if ($i==0 and ref($elt) eq 'ARRAY' and $elt->[1] eq '_COLON_PRE_') {
	        	if (ref($cloned_ast->[$i+2]) eq 'ARRAY' and $cloned_ast->[$i+2][1] eq '_STAR_') {
	        	 	$cloned_ast->[$i+2][1]= '*';#5+(($cloned_ast->[$i+2][1]>>8)<<8);# '*';
	        	}
	        	my $colon_code = 12+($Fortran::Expression::Evaluator::Parser::nodeId++<<8);
	            $elt = [$colon_code,'',$cloned_ast->[$i+2]];
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
	            next;
	        }
	        if (ref($cloned_ast->[$i+1]) eq 'ARRAY' and $cloned_ast->[$i+1][1] eq '_COLON_PRE_') {	            
	            if (defined $cloned_ast->[$i+2]) {
	            	my $colon_code = 12+($Fortran::Expression::Evaluator::Parser::nodeId++<<8);
	                $elt=[$colon_code, $elt,$cloned_ast->[$i+2]];#':'
	                if (ref($cloned_ast->[$i+2]) eq 'ARRAY' and $cloned_ast->[$i+2][1] eq '_STAR_') {
	                	$cloned_ast->[$i+2][1]= '*';#5;#+(($cloned_ast->[$i+2][1]>>8)<<8);# '*';
	                }
	            } else {
	            	my $colon_code = 12+($Fortran::Expression::Evaluator::Parser::nodeId++<<8);
	            	$elt=[$colon_code, $elt,''];	            	
	            }
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
	            $cloned_ast->[$i+2]=undef;
#	            $cloned_ast->[$i+3]=undef;	            
	            next;
	        }	
	        push @{$new_ast}, $elt;
	    }
    	return $new_ast;
	} else { 
		return $ast;
	}	
}

sub _fix_string_concat_in_ast { (my $orig_ast)=@_;
	if (
	ref($orig_ast) ne 'ARRAY' or
	scalar(@{$orig_ast}) < 2
	) {
		return $orig_ast;
	}
	my $ast=_fix_string_concat_in_expr($orig_ast);
	if ( ref($ast) eq 'ARRAY') {
	my $new_ast=[];
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			my $new_entry = _fix_string_concat_in_ast($entry);
			push @{$new_ast}, $new_entry;
		} else {
			push @{$new_ast}, $entry;
		} 		
	}
#	say 'ORIG AST:'.Dumper($orig_ast);
	if ($new_ast->[1] eq '#dummy#' and ( ($new_ast->[2][0] & 0xFF) == 13) ) {#  '//'
		$new_ast = $new_ast->[2];
	} 
	return $new_ast;			
	} else {
		return $ast;
	}
}
 
sub _fix_string_concat_in_expr { (my $ast)=@_;
	if ( ref($ast) eq 'ARRAY' ) {
		my $cloned_ast = [@{$ast}];
	    my $new_ast=();
	    for my $i ( 0 ..   @{$cloned_ast} -1 ) {
	        my $elt=$cloned_ast->[$i];
	        next unless defined $elt;
	        
	        if ($i==0 and ref($elt) eq 'ARRAY' and $elt->[1] eq '_CONCAT_PRE_') { 
	        	my $concat_code =  13+($Fortran::Expression::Evaluator::Parser::nodeId++<<8);
	            $elt = [$concat_code,$cloned_ast->[$i+2]];#'//'
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
#	            $cloned_ast->[$i+2]=undef;
	            next;
	        }
	        if (ref($cloned_ast->[$i+1]) eq 'ARRAY' and $cloned_ast->[$i+1][1] eq '_CONCAT_PRE_') {
	        	my $concat_code =  13+($Fortran::Expression::Evaluator::Parser::nodeId++<<8);
	            $elt=[$concat_code, $elt];# '//'
	            if (defined $cloned_ast->[$i+2]) {
	                push @{$elt},$cloned_ast->[$i+2];
	            }
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
	            $cloned_ast->[$i+2]=undef;
#	            $cloned_ast->[$i+3]=undef;	            
	            next;
	        }	
	        push @{$new_ast}, $elt;
	    }	    
    	return $new_ast;
	} else { 
		return $ast;
	}	
}


sub _fix_double_paren_in_ast { (my $orig_ast)=@_;
	my $ast=_fix_double_paren_in_expr($orig_ast);
	if ( ref($ast) eq 'ARRAY') {
	my $new_ast=[];
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			my $new_entry = _fix_double_paren_in_ast($entry);
			push @{$new_ast}, $new_entry;
		} else {
			push @{$new_ast}, $entry;
		} 		
	}
	return $new_ast;			
	} else {
		return $ast;
	}
}

sub _fix_double_paren_in_expr { (my $ast)=@_;
	if ( ref($ast) eq 'ARRAY' ) {
		my $cloned_ast = [@{$ast}];
	    my $new_ast=();
	    for my $i ( 0 ..   @{$cloned_ast} -1 ) {
	        my $elt=$cloned_ast->[$i];
	        next unless defined $elt;
	        
	        if ($i==0 and ref($elt) eq 'ARRAY' and $elt->[1] eq '_PAREN_PAIR_') {
	        	my $dpar_code =  14+($Fortran::Expression::Evaluator::Parser::nodeId++<<8);
	            $elt = [$dpar_code,$cloned_ast->[$i+2]];# ')('
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
#	            $cloned_ast->[$i+2]=undef;
	            next;
	        }
	        if (ref($cloned_ast->[$i+1]) eq 'ARRAY' and $cloned_ast->[$i+1][1] eq '_PAREN_PAIR_') {
	        	my $dpar_code =  14+($Fortran::Expression::Evaluator::Parser::nodeId++<<8);
	            $elt=[$dpar_code, $elt];# ')('
	            if (defined $cloned_ast->[$i+2]) {
	                push @{$elt},$cloned_ast->[$i+2];
	            }
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
	            $cloned_ast->[$i+2]=undef;
#	            $cloned_ast->[$i+3]=undef;	            
	            next;
	        }	
	        push @{$new_ast}, $elt;
	    }	    
    	return $new_ast;
	} else { 
		return $ast;
	}	
}

# ==============================================================================
# States
# 1            2           3                4        5           0           6             7                     8
# read_scalar, read_array, read_paren_expr, read_op, append_ast, do_nothing, handle_comma, handle_closing_paren, handle_not
#

# As we are not using the nodeId I will not waste cycles on it
# Sadly I need a lot more bits than originally so either I do not mask at all or use 0xFF and make sure the shift is <<8

# - Returns a flag to say that the AST contains function calls. If this is not the case there's no point in calling the _change_func_to_array()

=info_array_constants
To support this we need yet another sigil.
=cut

# parse_expression_no_context :: String -> (AST,String,Error,HasFuncs)
sub parse_expression_no_context { (my $str)=@_;	

    my $max_lev=11; # levels of precedence
    my $prev_lev=0;
    my $lev=0;
    # Let's try an array first
    my @ast=();
    my $op;
    my $state=0; # I will use state=8/9/10 as "has prefix .not. - + "
    my $error=0;
    # I will not treat * as a proper prefix


    my $expr_ast=[];
    my $arg_expr_ast=[];
    my $has_funcs=0;
    my $empty_arg_list=0;
    # carp "ORIG STR: $str";
    croak if $DBG and not defined $str;
    while (length($str)>0) {
        $error=0;
#		say "STR before prefix: $str";
        # Remove whitespace
        if ($str=~/^\s/) {
            $str=~s/^\s+//;
        }
        # Handle prefix -,+,.not.
        if ($str=~s/^\-//) {
            $state=4;
        }    
        elsif ($str=~s/^\+//) {
            $state=3;
        }    
        elsif ($str=~s/^\.not\.//) {
            $state=21;
        }    
        # Remove whitespace after prefix
        if ($state and $str=~/^\s/) {
            $str=~s/^\s+//;
        }
        #say "STR before term: $str";
        if ($str=~s/^([a-zA-Z_]\w*)\s*\(//) {
            # array access or function call
            
            # the name of the array or called function
            my $var=$1;
            $has_funcs=1;
            my $arg_expr_ast;
            if ($str!~/^\s*\)/) { # non-empty arg list
                ($arg_expr_ast,$str, my $err, my $has_funcs2)=parse_expression_no_context($str);
                if( ref($arg_expr_ast) ne 'ARRAY') {
                    $arg_expr_ast=[$arg_expr_ast];
                };
                $has_funcs||=$has_funcs2;
                # warn Dumper($arg_expr_ast,$str, $err, $has_funcs2);
            } else { # empty arg list                       
                # warn "EMPTY ARG LIST: str <$str>";
                $empty_arg_list=1;
                $str=~s/^\)\s*//; # A hack but I'm lazy
                $arg_expr_ast=[];
                # warn Dumper($arg_expr_ast,$str);
            }
            if ($defaultToArrays) {
                $expr_ast=[10,$var,$arg_expr_ast];
            } else {
                $expr_ast=[1,$var,$arg_expr_ast];
            }
            # f(x)(y)
            if ($str=~/^\(/) {
                (my $arg_expr_ast2,$str, my $err2,my $has_funcs2)=parse_expression_no_context($str);
                $expr_ast=[1, $var,[14,$arg_expr_ast,$arg_expr_ast2->[1]]];
                #$expr_ast=['&',$var,[')(',$arg_expr_ast,$arg_expr_ast2->[1]]];
                $has_funcs||=$has_funcs2;
            }
        }
        elsif ($str=~s/^\(\s*\/// or $str=~s/^\[//) {
            # constant array constructor expr
            ($expr_ast,$str, my $err,my $has_funcs2)=parse_expression_no_context($str);
            $has_funcs||=$has_funcs2;
            #$expr_ast=['(/',$expr_ast];
            $expr_ast=[28,$expr_ast];
            if($err) {
            	#say "ERR 1";
            	return ($expr_ast,$str, $err,0);
            }
        }
        elsif ($str=~s/^\(//) {
            # paren expr, I use '{' as it appears not to be used. Would make send to call it '('
            ($expr_ast,$str, my $err,my $has_funcs2)=parse_expression_no_context($str);
            $has_funcs||=$has_funcs2;
            #$expr_ast=['{',$expr_ast];
            $expr_ast=[0,$expr_ast];
            if($err) {#say "ERR 2";
            return ($expr_ast,$str, $err,0);
            }
        }
        # Apparently Fortran allows '$' as a character in a variable name but I think I'll ignore that.
        # I allow _ as starting character because of the placeholders
        elsif ( $str=~s/^([a-zA-Z]\w*)// ) {
            #variable
            $expr_ast=[2,$1];
            #$expr_ast=['$',$1];
        }
        elsif ( $str=~s/^((?:__PH\d+__)+)// ) {
            #variable
            $expr_ast=[33,$1];
            #$expr_ast=['$',$1];
            # Now it is possible that there are several of these in a row!
        }
        elsif ( $str=~s/^\.(true|false)\.// ) {
            # boolean constants
            $expr_ast=[31,'.'.$1.'.'];
            #$expr_ast='.'.$1.'.';
        }
        elsif (
            
            # eq 
            # 
        	(
                # and or xor lt gt le ge ne
                (
        		($str!~/^\d+\.[aoxlgn]/ and  $str!~/^\d+\.eq/) and
        		$str=~s/^((?:\d*\.\d*)(?:[edqEDQ][\-\+]?\d+)?)//        
                ) 
        	)
            or 
            $str=~s/^(\d*(?:[edqEDQ][\-\+]?\d+))//
        ) { 
            
            # reals
            $expr_ast=[30,$1];
            #$expr_ast=$1;
        }
        # elsif ($str=~s/^\*(\d+)//) { 
        elsif ($str=~s/^\*(\d+)//) {
            # The '*' is for "alternate returns", a bizarre F77 feature.
            # The integer following the * is a label 
            $expr_ast=[34,$1];
            #$expr_ast=$1;#['Label',$1];
        }        
        elsif ($Config{'ALLOW_SPACES_IN_NUMBERS'}==0 and $str=~s/^(\d+)//) {            
            # integers            
            # warn 'INTEGER, ALLOW_SPACES_IN_NUMBERS==0';
            $expr_ast=[29,$1];
            #$expr_ast=$1;#['integer',$1];
        }
        elsif ($Config{'ALLOW_SPACES_IN_NUMBERS'}==1 and $str=~s/^(\d[\d\s]*)//) {  # But spaces in numbers are allowed in fixed form. So 1 000 000 is fine. so we have (\d[\d\s]*) as the easiest one, assuming a trailing space won't harm
            # integers            
            # warn 'INTEGER, ALLOW_SPACES_IN_NUMBERS==1 '.$1;
            my $num_with_spaces=$1;
            my $has_spaces = $num_with_spaces=~/\d\s+\d/;
            $num_with_spaces=~s/\s*//g;
            $expr_ast=[29,$num_with_spaces];
            # croak $num_with_spaces if $has_spaces;
            #$expr_ast=$1;#['integer',$1];
        }

        elsif ($str=~s/^\*//) {
            # '*' format for write/print
            $expr_ast=[32,'*'];
        }
        # Maybe I should handle string constants as well
        # Although we use placeholders so they should not occur
        elsif ( $str=~s/^\'(.+?)\'// ) {
            $expr_ast=[32,"'".$1."'"];
            #$expr_ast="'".$1."'";
        }
        else {          
            # Here we return with an error value
            # What I could do is say:
            # if the next token is ':' or the pending op is ':' (12)
            # carp "STR:<$str>" if not defined $op;
            if($str=~/^\s*:/ or $op == 12) {
                # Return a blank
                $expr_ast=[35,'']
            } else { # error
            #say "ERR 3";
                $error=1;
                return ($expr_ast, $str, $error,0);
            }
        }

        # If state is not 0 there is a prefix
        if ($state) {
            $expr_ast=[$state,$expr_ast];
        }
        #say "STR before operator: $str";

        # Strip whitespace
        if ($str=~/^\s/) {
            $str=~s/^\s+//;
        }

        if (length($str)==0) {        	
            last;
        }
       
        if ($str=~s/^,//) { # comma
            # just set a state here
            $state=6;
        }
        elsif ($str=~s/^\/\s*\)// or $str=~s/^\]//) { # closing paren for constant array constructor
            # Again this is like falling off the end of the string
            # if  @{$arg_expr_ast} is not empty, then this must become the ast to return
            # after appending the final value
            if ( @{$arg_expr_ast} ) {
                # Just set a state here
                $state=7; # because the operator has already been set
            }
            # otherwise it is quite the same as the end of the string
            else {
            	#say "LEAVE WHILE: closing paren";
                last;
            }
        }        
        elsif ($str=~s/^\)//) { # closing paren
        
            # Again this is like falling off the end of the string
            # if  @{$arg_expr_ast} is not empty, then this must become the ast to return
            # after appending the final value
            # warn "HERE empty arg list: $empty_arg_list; $str ". Dumper($arg_expr_ast);
            # if ($empty_arg_list) {
            #         # warn "HERE empty arg list: $str";
            #         $state=6;
            #         $empty_arg_list=0;
            # }                
            # els
            if ( @{$arg_expr_ast}  ) {
                # Just set a state here
                $state=7;                
            }
            # otherwise it is quite the same as the end of the string
            else {
            	# say "LEAVE WHILE: closing paren";
                last;
            }
        } 
        else { 
            # warn "HERE OPS $str";
            # Operators
=info_operator_precedence
Level
    Scalars
0
    Arithmetic
1        right       ** NOTE F ** S ** Z means F ** (S ** Z)
2        right       unary + and - NOTE X ** -A * Z means X ** (-(A * Z)) => Handled in state=0
3        left        * / 
4        left        + - 
    Character
5        left         //
         left         :   NOTE I put this here, main purpose is array dims but it also works for substring ranges
         left         =   NOTE I put this here, main purpose is implicit do. Actually this should be a separate level between Relational and Logical
    Relational
6        nonassoc    < > <= >= .lt. .gt. .le. .ge.
7        nonassoc    == != .eq. .ne. 
    Logical
8        right       .not.
9        left        .and. 
10        left        .or. 
11        left        .xor. .eqv. .neqv.

So it looks like I need at least 6 bits, so we'll need <<8 and 0xFF

=cut 

            $prev_lev=$lev;
            if ($str=~s/^\+//) {
                $lev=4;
                #$op='+';
                $op=3;
            }
            elsif ($str=~s/^\-//) {
                $lev=4;
                #$op='-';
                $op=4;
            }
            elsif ($str=~s/^\*\*//) {
                # We store this incorrectly left-assoc, the emitter can fix it.
                $lev=2;
                #$op='**';
                $op=8;
            } 
            elsif ($str=~s/^\*//) {
                $lev=3;
                #$op='*';
                $op=5;
            }
            elsif ($str=~s/^\/\///) {
                $lev=5;
                #$op='//';
                $op=13;
            } 
            elsif ($str=~s/^://) {
                $lev=5;
                #$op=':';
                $op=12;
            } 
            elsif ($str=~s/^\///) {
                $lev=3;
                #$op='/';
                $op=6;
            } 
            elsif ($str=~s/^>=// || $str=~s/^\.ge\.// || $str=~s/^\.\s*ge\s*\.//) {
                $lev=6;
                #$op='>=';
                $op=20;
            } 
            elsif ($str=~s/^<=// || $str=~s/^\.le\.// || $str=~s/^\.\s*le\s*\.//) {
                $lev=6;
                #$op='<=';
                $op=19;
            } 
            elsif ($str=~s/^<// || $str=~s/^\.lt\.// || $str=~s/^\.\s*lt\s*\.//) {
                $lev=6;
                #$op='<';
                $op=17;
            } 
            elsif ($str=~s/^>// || $str=~s/^\.gt\.// || $str=~s/^\.\s*gt\s*\.//) {
                $lev=6;
                #$op='>';
                $op=18;
            } 
            elsif ($str=~s/^==// || $str=~s/^\.eq\.// || $str=~s/^\.\s*eq\s*\.//) {
                $lev=7;
                #$op='==';
                $op=15;
            } 
            elsif ($str=~s/^\!=// || $str=~s/^\.ne\.// || $str=~s/^\.\s*ne\s*\.//) {
                $lev=7;
                #$op='/=';
                $op=16;
            } 
            elsif ($str=~s/^\.and.// || $str=~s/^\.\s*and\s*\.//) {
                $lev=9;
                #$op='.and.';
                $op=22;
            } 
            elsif ($str=~s/^\.or.// || $str=~s/^\.\s*or\s*\.//) {
                $lev=10;
                #$op='.or.';
                $op=23;
            } 
            elsif ($str=~s/^\.xor.// || $str=~s/^\.\s*xor\s*\.//) {
                $lev=11;
                #$op='.xor.';
                $op=24;
            } 
            elsif ($str=~s/^\.eqv.// || $str=~s/^\.\s*eqv\s*\.//) {
                $lev=11;
                #$op='.eqv.';
                $op=25;
            } 
            elsif ($str=~s/^\.neqv.// || $str=~s/^\.\s*neqv\s*\.//) {
                $lev=11;
                #$op='.neqv.';
                $op=26;
            } 
            elsif ($str=~s/^\=//) {
                $lev=5;
                #$op='=';
                $op=9;
            } else {
                #                carp 'NO OP, ERROR '.$str;
                #say "LEAVE WHILE: ERROR, str $str does not match any op";
                $error=1;
                last;
                #return ($expr_ast, $str, 1,0);
            }

            $state=5;
        }
        if ($state==5 and not defined $op) {
        	#say "ERR 5";
            $error=1;
        	return ($expr_ast, $str, $error,0);
        }
        # Append to the AST
        if ($state==5 ) {
            if ($prev_lev==0) { # start
                $ast[$lev]=[$op,$expr_ast];
            } elsif ($prev_lev<$lev) { # '*' < '+'
                push @{$ast[$prev_lev]},$expr_ast;
                if (not defined $ast[$lev]) {
                    $ast[$lev]=$ast[$prev_lev];
                } else {
                    push @{$ast[$lev]}, $ast[$prev_lev];
                }
                undef $ast[$prev_lev];
                $ast[$lev] = [$op, $ast[$lev]];
            } elsif ($prev_lev>$lev) {
                $ast[$lev]=[$op, $expr_ast];
            } elsif ($lev==$prev_lev) {
                push @{$ast[$lev]},$expr_ast;
                $ast[$lev]=[$op, $ast[$lev]];
            }
            $state=0;
        } elsif ($state == 6 or $state==7) {
            # warn "$state $str";
            # This is the same as end of str, except we need to keep parsing afterwards
            # So we do the same as in that case
            if ( not defined $ast[$lev]) {
                $ast[$lev] = $expr_ast;
            } else {
                push @{$ast[$lev]}, $expr_ast;
            }
            # Now determine the highest level; fold the lower levels into it
            if( scalar @ast == 1) {
                push @{$arg_expr_ast},$ast[0];
            } else {
                for my $tlev (1 .. $max_lev) {
                    if (not defined $ast[$tlev+1]) {
                        $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                    } else {
                        push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                    }
                }
                push @{$arg_expr_ast},$ast[$max_lev+1];
            }
            if ($state==6) {
                @ast=();
                $state=0;
                $prev_lev=0;
                $lev=0;
            } else { # state==7
                # Now we return this as the ast
                #say "ERR 6 $error";
                # warn Dumper([27,@{$arg_expr_ast}],$str,$error,$has_funcs);
                return ([27,@{$arg_expr_ast}],$str,$error,$has_funcs);
            } 
        }
    } # while

    # So when we fall off the end of the string we need to clean up
    # There is an $expr_ast pending
    if ( not defined $ast[$lev]) {
        $ast[$lev] = $expr_ast;
    } else {
        push @{$ast[$lev]}, $expr_ast;
    }
    if(@{$arg_expr_ast}) {
        if( scalar @ast == 1) {
            push @{$arg_expr_ast},$ast[0];
        } else {
            for my $tlev (1 .. $max_lev) {
                if (not defined $ast[$tlev+1]) {
                    $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                } else {
                    push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                }
            }
            push @{$arg_expr_ast},$ast[$max_lev+1];
        }
        #say "ERR 7 $error";
        return([27,@{$arg_expr_ast}],$str,$error,$has_funcs);
    } else {
        # Now determine the highest level; fold the lower levels into it
        if( scalar @ast == 1) {
            return ($ast[0],$str,$error,$has_funcs);
        } else {
            for my $tlev (1 .. $max_lev) {
                if (not defined $ast[$tlev+1]) {
                    $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                } else {
                    push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                }
            }
            #say "ERR 8 $error";
            return ($ast[$max_lev+1],$str,$error,$has_funcs);
        }
    }
} # END of parse_expression_no_context

sub interpret { (my $ast)=@_;
    if (scalar @{$ast}==3) {
        (my $opcode, my $lexp, my $rexp) =@{$ast};
        my $lv = (ref($lexp) eq 'ARRAY') ? interpret($lexp) : $lexp;
        my $rv = (ref($rexp) eq 'ARRAY') ? interpret($rexp) : $rexp;
        my $op=$sigils[$opcode];
        if ($op=~/\./) {
            $op=~s/\.//g;
        }
        croak Dumper($lexp) if $DBG and not defined $lv;
        return eval("$lv $op $rv");
    } elsif (scalar @{$ast}==2) { 
        (my $op, my $exp) =@{$ast};
        if ($op == 0) { # {
            my $v = (ref($exp) eq 'ARRAY') ? interpret($exp) : $exp;
            return $v;
        } 
        elsif ($op == 3 ) {
            my $v = (ref($exp) eq 'ARRAY') ? interpret($exp) : $exp;
            return $v;            
        }
        elsif ($op == 4 ) {
            my $v = (ref($exp) eq 'ARRAY') ? interpret($exp) : $exp;
            return -$v;            
        }
        elsif ($op == 21 ) {
            my $v = (ref($exp) eq 'ARRAY') ? interpret($exp) : $exp;
            return !$v;
        }
        elsif ($op == 2 or $op>28) {
            return $exp; 
        }
    } 
} # END of interpret

# What to emit?
# binops 3
# unops 2
# arrays and functions 3 
# These can have an )( inside them
# if not, emit each elt in the list and join with ',' and surround by '()'
# if ')(', do the same for each of them and join them together
# parenthesised expressions unop
# atomics: vars and constants unop and scalar, or later unop?
sub emit_expr_from_ast { (my $ast)=@_;

#	say Dumper($ast);
    if (ref($ast) eq 'ARRAY') {
        if (scalar @{$ast}==3) {
            if ($ast->[0] ==1 or $ast->[0] ==10) { # '&' or '@', array access or function call
                (my $sigil, my $name, my $args) =@{$ast};
                # carp Dumper($ast);
                if (@{$args}) {
					if ($args->[0] != 14 ) { # ')('
						my @args_lst=();
						if($args->[0] == 27) { # ','
							for my $idx (1 .. scalar @{$args}-1) {
								my $arg = $args->[$idx];
								push @args_lst, emit_expr_from_ast($arg);
							}

							#                    for my $arg (@{$args->[1]}) {
							#       push @args_lst, emit_expr_from_ast($arg);
							#    }
                            # if (grep {(not defined $_)} @args_lst){
							#     carp Dumper($ast,@args_lst);
                            # }
							return "$name(".join(',',@args_lst).')';
						} else {
							return "$name(".emit_expr_from_ast($args).')';
						}
					} else { # f(x)(y)
						#say Dumper($args);
						(my $sigil,my $args1, my $args2) = @{$args};
						my $args_str1='';
						my $args_str2='';
						if($args1->[0] == 27) { #eq ',' 
							my @args_lst1=();
							for my $idx (1 .. scalar @{$args1}-1) {
								my $arg = $args1->[$idx];
								push @args_lst1, emit_expr_from_ast($arg);
							}
							$args_str1=join(',',@args_lst1);

						} else {
							$args_str1= emit_expr_from_ast($args1);
						}
						if($args2->[0] == 27) { #eq ','
							#say Dumper($args2);
							my @args_lst2=();
							for my $idx (1 .. scalar @{$args2}-1) {
								my $arg = $args2->[$idx];
								push @args_lst2, emit_expr_from_ast($arg);
							}

							#                for my $arg (@{$args2->[1]}) {
							#    push @args_lst2, emit_expr_from_ast($arg);
							#}
							$args_str2=join(',',@args_lst2);
						} else {
							$args_str2=emit_expr_from_ast($args2);
						}
						return "$name(".$args_str1.')('.$args_str2.')';
					}
				} else {
					return "$name()";
				}
            } else {
#            	say Dumper($ast);
                (my $opcode, my $lexp, my $rexp) =@{$ast};
                my $lv = (ref($lexp) eq 'ARRAY') ? emit_expr_from_ast($lexp) : $lexp;
                my $rv = (ref($rexp) eq 'ARRAY') ? emit_expr_from_ast($rexp) : $rexp;
                return $lv.$sigils[$opcode].$rv;
            }
        } elsif (scalar @{$ast}==2) { #  for '{'  and '$'
            (my $opcode, my $exp) =@{$ast};
            if ($opcode==0 ) {#eq '('
            # warn Dumper($exp);
                my $v = (ref($exp) eq 'ARRAY') ? emit_expr_from_ast($exp) : $exp;
                if (not defined $v) {
                    croak Dumper($ast) if $DBG;
                }
                return "($v)";
            } elsif ($opcode==28 ) {#eq '(/'
                my $v = (ref($exp) eq 'ARRAY') ? emit_expr_from_ast($exp) : $exp;
                return "(/ $v /)";
            } elsif ($opcode==2 or $opcode>28) {# eq '$' or constants    
                return ($opcode == 34) ?  "*$exp" : $exp;            
            } elsif ($opcode == 21 or $opcode == 4 or $opcode == 3) {# eq '.not.' '-'
                my $v = (ref($exp) eq 'ARRAY') ? emit_expr_from_ast($exp) : $exp;
                return $sigils[$opcode]. $v;
            } elsif ($opcode == 27) { # ',' 
                croak  Dumper($ast) if $DBG ;
                my @args_lst=();
                for my $arg (@{$exp}) {
                    push @args_lst, emit_expr_from_ast($arg);
                }
                return join(',',@args_lst);        
            } else {
                croak 'BOOM! '.Dumper($ast).$opcode if $DBG;
            }
        } elsif (scalar @{$ast} > 3) {

            if($ast->[0] == 27) { # ','
                my @args_lst=();
                for my $idx (1 .. scalar @{$ast}-1) {
                    my $arg = $ast->[$idx];
                    push @args_lst, emit_expr_from_ast($arg);
                }
                return join(',',@args_lst); 
            } else {
                croak Dumper($ast) if $DBG;
            }
        }
    } else {return $ast;}
} # END of emit_expr_from_ast

# This replaces _change_func_to_array
sub _replace_function_calls_in_ast { 
(my $stref, my $f,  my $info, my $ast, my $exp, my $grouped_messages)=@_;
    
    #say Dumper($ast);
    if (ref($ast) eq 'ARRAY' and scalar @{$ast}>0) { 
        if (($ast->[0] & 0xFF) == 1 or ($ast->[0] & 0xFF) == 10) { # '&', function call; '@', array
           
            if(($ast->[0] & 0xFF) == 1) {
                my $mvar =$ast->[1];
                #say 'FUNCTION CALL: '.$mvar;
	            my $code_unit = sub_func_incl_mod( $f, $stref );
				# If the line is not a subroutine call, we set subname to #dummy#
				# We do this to check if the $mvar is maybe the subroutine itself
				my $subname = (exists $info->{'SubroutineCall'} and exists $info->{'SubroutineCall'}{'Name'}) ? $info->{'SubroutineCall'}{'Name'} : '#dummy#';
				# Now, when is $mvar NOT a function?
				# - if $mvar ne $subname including #dummy#, because this function is used for parsing both subcalls and assignments
				#	AND $mvar is not a called sub in $f AND $mvar is not an unmasked intrinsic
				# - if $mvar is in MaskedIntrinsics then it's a var masking an intrinsic
				# - if $f does not have a Called Sub named $mvar. Seems acceptable, but what if it's a function call and we have v = f(x) ?
				# So I say, if $mvar is the name of a subroutine in the whole source code base, and it's a function
				# 
                if (
 					(
 				# 1. $mvar is not a function, including intrinsic
 					not(  ($mvar eq $subname) or (
 					exists $stref->{$code_unit}{$mvar} and 
 					exists $stref->{$code_unit}{$mvar}{'Function'} and 
 					$stref->{$code_unit}{$mvar}{'Function'} == 1 ) or (
 					exists $F95_intrinsics{$mvar} or
 					exists $F95_function_like_reserved_words{$mvar} # WV 2019-04-17
 					) 
 					)
 				# 2. OR $mvar is a masked intrinsic	 
 					or exists $stref->{$code_unit}{$f}{'MaskedIntrinsics'}{$mvar}
 					) 
                ) {
            		# change & to @
                	$ast->[0]=  10 + (($ast->[0]>>8)<<8);#    '@';
    				say "\tFound array $mvar" if $DBG;
				} elsif (   	exists $F95_intrinsics{$mvar} ) {
					say "parse_expression('$exp') " . __LINE__ if $DBG;
                    say "WARNING: treating $mvar in $f as an intrinsic! " if $DBG;
					$grouped_messages->{'W'}{'VAR_AS_INTRINSIC'}{$mvar} =   "WARNING: treating $mvar in $f as an intrinsic! " if $WW;  
				} elsif (   	exists $F95_function_like_reserved_words{$mvar} ) {
					say "parse_expression('$exp') " . __LINE__ if $DBG;
                    say "Treating $mvar in $f as a function-like reserved word " if $DBG;
					$grouped_messages->{'W'}{'VAR_AS_INTRINSIC'}{$mvar} =   "WARNING: Treating $mvar in $f as a function-like reserved word  " if $WW;  
				} else {
                    #say ' FUNCTION CALL';
					# So, this line contains a function call, so we should say so in $info!
					# I introduce FunctionCalls for this purpose!
					if (
					( exists $stref->{$code_unit}{$mvar} and exists $stref->{$code_unit}{$mvar}{'Function'}  
					  and $stref->{$code_unit}{$mvar}{'Function'} == 1) # $mvar is def a function! 
					  and ( # 
						$mvar ne $subname 
# 						and not exists $stref->{$code_unit}{$f}{'CalledSubs'}{'Set'}{$mvar}
						and not exists $F95_reserved_words{$mvar} 					
						)
					) {
						( my $expr_args, my $expr_other_vars ) = @{find_args_vars_in_ast($ast->[2])}; # look only at the argument list
                        #say Dumper($expr_args);
						for my $expr_arg (@{$expr_args->{'List'}}) {
							if ( $expr_args->{'Set'}{$expr_arg}{'Type'} eq 'Label') {
								my $label=$expr_arg;
								$stref->{$code_unit}{$f}{'ReferencedLabels'}{$label}=$label;		
							}
						}
						push @{ $info->{'FunctionCalls'} },  {
							'Name' => $mvar,
							'Args' => $expr_args,
							'ExprVars' => $expr_other_vars,
							'ExpressionAST' => $ast,						
						};	
						# Add to CalledSubs for $f
						if (not exists $stref->{$code_unit}{$f}{'CalledSubs'}{'Set'}{$mvar}) {
						push @{ $stref->{$code_unit}{$f}{'CalledSubs'}{'List'} }, $mvar;
						$stref->{$code_unit}{$f}{'CalledSubs'}{'Set'}{$mvar} = 2;
						}
						
						# Add $f to Callers for $mvar
						my $Sname =  $stref->{'Subroutines'}{$mvar};
						$Sname->{'Called'} = 1;
						if ( not exists $Sname->{'Callers'}{$f} ) {
							$Sname->{'Callers'}{$f} = [];
						}						
						push @{ $Sname->{'Callers'}{$f} }, $info->{'LineID'}; #the line number
						# Add to the call tree
						$stref = add_to_call_tree( $mvar, $stref, $f );														
					}
				} 
            } #else {
            #  say "\t".'ARRAY ACCESS: '.$ast->[1];
            #}
                (my $entry, $grouped_messages) = _replace_function_calls_in_ast($stref, $f,  $info, $ast->[2], $exp, $grouped_messages);
                $ast->[2]= $entry;
             
        } 
        elsif ( ($ast->[0] & 0xFF) != 2 and ($ast->[0] & 0xFF) < 29) { # not a var or constant
            for my $idx (1 .. scalar @{$ast} -1) {
                (my $entry, $grouped_messages)  = _replace_function_calls_in_ast($stref, $f,  $info, $ast->[$idx], $exp, $grouped_messages);
                $ast->[$idx]= $entry;
            }
        }
    }
    return ($ast,$grouped_messages);
} # END of _replace_function_calls_in_ast

# returns a hash const => sigil
sub _find_consts_in_ast { my ( $ast, $consts)=@_;
    
    if (ref($ast) eq 'ARRAY' and scalar @{$ast}>0) { 
        if (ref($ast->[0]) ne 'ARRAY') {
            if (($ast->[0] & 0xFF) == 1 or ($ast->[0] & 0xFF) == 10) { # '&', function call; '@', array
                $consts = _find_consts_in_ast($ast->[2], $consts);
            } 
            elsif ( ($ast->[0] & 0xFF) != 2 and ($ast->[0] & 0xFF) < 29) { # not a var or constant
                for my $idx (1 .. scalar @{$ast} -1) {
                    $consts  = _find_consts_in_ast( $ast->[$idx], $consts);
                }
            } 
            elsif (($ast->[0] & 0xFF) > 28) { # a constant
                # say Dumper($ast);
                $consts->{$ast->[1]} = $sigils[ $ast->[0] & 0xFF ];
            }
        } else {
             for my $idx (0 .. scalar @{$ast} -1) {
                $consts  = _find_consts_in_ast( $ast->[$idx], $consts);
            }
        }
    }
    return $consts;
} # END of _find_consts_in_ast

#sub find_vars_in_ast { (my $ast, my $vars)=@_;
#    
#    if (ref($ast) eq 'ARRAY' and scalar @{$ast}>0) { 
#        if (ref($ast->[0]) ne 'ARRAY') {
#            if ( ($ast->[0] & 0xFF) == 1 or ($ast->[0] & 0xFF) == 10) { # '&', function call; '@', array                 
#                if (($ast->[0] & 0xFF) == 10) { 
#                my $mvar = $ast->[1];
#                $vars->{$mvar}={'Type'=>'Array'};
#                # Handle IndexVars
#				my $index_vars={};
#                $index_vars =  get_vars_from_expression($ast->[2],$index_vars);
#
#					for my $idx_var (keys %{ $index_vars }) {
#						if ($index_vars->{$idx_var}{'Type'} eq 'Array') {
#							delete $index_vars->{$idx_var};
#						}
#					}					
#					$vars->{$mvar}{'IndexVars'} = $index_vars;
#                } else {                
#                    $vars = find_vars_in_ast($ast->[2], $vars);
#                }
#            } 
#            elsif ( ($ast->[0] & 0xFF) != 2 and ($ast->[0] & 0xFF) < 29) { # not a var or constant
#                for my $idx (1 .. scalar @{$ast} -1) {
#                    $vars  = find_vars_in_ast( $ast->[$idx], $vars);
#                }
#            } 
#            elsif (($ast->[0] & 0xFF) == 2) { # a constant
#                # say Dumper($ast);
#                my $mvar = $ast->[1]; 
#                if (not exists $Config{'Macros'}{uc($mvar)} ) {
#				    $vars->{$mvar}={'Type'=>'Scalar'} ;
#                }
#            }
#        } else {
#             for my $idx (0 .. scalar @{$ast} -1) {
#                $vars  = find_vars_in_ast( $ast->[$idx], $vars);
#            }
#        }
#    }
#    return $vars;
#} # END of find_vars_in_ast


# if the expression is a sub call (or in fact just a comma-sep list), return the arguments and also all variables that are not arguments
# range(...) is one use case. I guess we don't even need that anymore
sub find_args_vars_in_ast {(my $ast)=@_;

    my $all_vars={'List'=>[],'Set'=>{} };
    $all_vars->{'Set'}=find_vars_in_ast($ast,{});
    
    
    my $args={'List'=>[],'Set'=>{}};
    $args->{'Set'}=_find_args_in_ast($ast,{});
    $args->{'List'} = [keys %{ $args->{'Set'} }]; 
    for my $arg(@{ $args->{'List'} } ){
    	if (exists $all_vars->{'Set'}{$arg} ) {
    		delete $all_vars->{'Set'}{$arg};
    	}     	
    }
     
    $all_vars->{'List'} = [keys %{ $all_vars->{'Set'} }];
    return [$args,$all_vars];
} # END of find_args_vars_in_ast

sub _traverse_ast_with_action { (my $ast, my $acc, my $f) = @_;

  if(scalar @{$ast}==0) {
      return $acc;
  }

  if ( ($ast->[0] & 0xFF) == 1 or
       ($ast->[0] & 0xFF) == 10 ) { # array var or function/subroutine call
		$acc=$f->($ast,$acc);
		(my $entry, $acc) = _traverse_ast_with_action($ast->[2],$acc, $f);
		$ast->[2] = $entry;

  } elsif (($ast->[0] & 0xFF) == 2) { # scalar variable
	$acc=$f->($ast,$acc);	
  } elsif (($ast->[0] & 0xFF) > 28) { # constants
	$acc=$f->($ast,$acc);
  } else { # other operators
	$acc=$f->($ast,$acc);
	for my $idx (1 .. scalar @{$ast}-1) {
		(my $entry, $acc) = _traverse_ast_with_action($ast->[$idx],$acc, $f);
		$ast->[$idx] = $entry;
	}
  }

  return ($ast, $acc);

} # END of _traverse_ast_with_action

# returns a hash of the var names
sub find_vars_in_ast { my ( $ast, $vars)=@_;	

  return {} unless ref($ast) eq 'ARRAY';
  if(scalar @{$ast}==0) {
      return {};
  }
  if ( ($ast->[0] & 0xFF) == 1 or
       ($ast->[0] & 0xFF) == 10 ) { # array var or function/subroutine call
       
                if (($ast->[0] & 0xFF) == 10) { 
                my $mvar = $ast->[1];
                $vars->{$mvar}={'Type'=>'Array'};
                # Determine the dimension
                # Either it's 1 because not a comma-sep list or it's the size of the comma-sep list
                #my $dim=0;
                #if(scalar @{$ast->[2]}==0) {
                #	# empty list, this can't be an array
                #	croak "$mvar cannot be an array as the index list is empty!"
                #	
                #} elsif (($ast->[2][0] & 0xFF)==27) {
                #	$dim = scalar @{$ast->[2]}-1;
                #} else {
                #	$dim=1;
                #} 
                #$vars->{$mvar}{'Dim'}=$dim;
                # Handle IndexVars
                my $index_vars={};
                $index_vars =  find_vars_in_ast($ast->[2],$index_vars);

                    for my $idx_var (keys %{ $index_vars }) {
                        if ($index_vars->{$idx_var}{'Type'} eq 'Array') {
                            delete $index_vars->{$idx_var};
                        }
                    }                   
                    $vars->{$mvar}{'IndexVars'} = $index_vars;
                    # croak  Dumper($vars->{$mvar}{'IndexVars'});
                } else {      
#                	say "skipping functions: ".$ast->[1];          
                    $vars = find_vars_in_ast($ast->[2], $vars);
                }
  } elsif (($ast->[0] & 0xFF) == 2) { # scalar variable
                my $mvar = $ast->[1]; 
                if (not exists $Config{'Macros'}{uc($mvar)} ) {
                    $vars->{$mvar}={'Type'=>'Scalar'} ;
                }      
  } elsif (($ast->[0] & 0xFF) > 28) { # constants
    # constants
    #    my $mvar = $ast->[1]; 
    #$vars->{$mvar}={'Type'=>$sigils[ ($ast->[0] & 0xFF) ]} ;
  } else { # other operators    
    for my $idx (1 .. scalar @{$ast}-1) {
        $vars = find_vars_in_ast($ast->[$idx],$vars);        
    }
  }	

    return $vars;
} # END of find_vars_in_ast

sub find_assignments_to_scalars_in_ast { (my $ast, my $vars)=@_; 


  if(scalar @{$ast}==0) {
      return {};
  }
  if ( ($ast->[0] & 0xFF) == 1 or
       ($ast->[0] & 0xFF) == 10 ) { # array var or function/subroutine call       
    
        $vars = find_assignments_to_scalars_in_ast($ast->[2],$vars);        
    
  } elsif (($ast->[0] & 0xFF) == 9) { # '=' assignment
  # Now, this can eithe be an assignment to a scalar or to an array. 
  # I am only interested in assignments to scalars  
  # [ '=', ['$', $lhs_var], $rhs_ast ]
    if ( ($ast->[1][0] & 0xFF) == 2 ) {
        $vars->{$ast->[1][1]}=$ast->[2];
    }
  } elsif ( ($ast->[0] & 0xFF)  < 29 and ($ast->[0] & 0xFF)  !=2  ) { # other operators
      
    for my $idx (1 .. scalar @{$ast}-1) {
        $vars = find_assignments_to_scalars_in_ast($ast->[$idx],$vars);        
    }
  } 

    return $vars;
} # END of find_assignments_to_scalars_in_ast


# Look for [',',loop_expr,['=',loop_iter,loop_start],loop_end] and store this as loop_iter =>[loop_start, loop_end]

sub find_implied_do_in_ast { (my $ast, my $vars)=@_; 


  if(scalar @{$ast}==0) {
      return {};
  }
  if ( ($ast->[0] & 0xFF) == 1 or
       ($ast->[0] & 0xFF) == 10 ) { # array var or function/subroutine call       
    
        $vars = find_implied_do_in_ast($ast->[2],$vars);        
    
  } elsif ( ($ast->[0] & 0xFF)  < 29 and ($ast->[0] & 0xFF)  !=2  ) { # other operators
    if ( ($ast->[0] & 0xFF)  == 27 and ($ast->[2][0] & 0xFF)  == 9  ) {
#       croak 'IMPLIED DO:'. Dumper($ast, $vars);
    if ( ($ast->[2][1][0] & 0xFF) == 2 ) {
        $vars->{$ast->[2][1][1]}=[$ast->[2][2],$ast->[3]];
    }       
    }
      
    for my $idx (1 .. scalar @{$ast}-1) {
        $vars = find_implied_do_in_ast($ast->[$idx],$vars);        
    }
  } 

    return $vars;
} # END of find_implied_do_in_ast
# I'm only looking for arguments, so I don't bother with index vars
# Funny enough it seems I also need constant args because I look for ReferencedLabels
# I think only keeping these would be enough; and also maybe I should give them a proper Type and sigil
sub _find_args_in_ast { (my $ast, my $args) =@_;
	if (! @{$ast} ){ return $args; }
#	carp Dumper($ast);
	if ( ($ast->[0] & 0xFF) == 0 ) {	
	# descend
	   $args = _find_args_in_ast($ast->[1], $args);
	} elsif ( ($ast->[0] & 0xFF) == 27 ) {
		#process the list and collect any scalar or array
		for my $idx (1 .. scalar @{$ast}-1) {
			# This is a comma-sep arg list. We test for $ and @
			$args = _find_args_in_ast($ast->[$idx], $args);
		}
	}
	elsif (($ast->[0] & 0xFF)== 2) {
	        my $mvar = $ast->[1];
	        $args->{$mvar}={'Type'=>'Scalar'} ;
	    }
	elsif (($ast->[0] & 0xFF)== 10) {
	        my $mvar = $ast->[1];
	        $args->{$mvar}={'Type'=>'Array'} ;
	}  
    elsif (($ast->[0] & 0xFF) > 28) { # constants
    # constants
    my $mvar = $ast->[1]; 
    $args->{$mvar}={'Type'=>$sigils[ ($ast->[0] & 0xFF) ]} ;
    }	
    return $args;
} # END of _find_args_in_ast


#               0    1    2    3    4    5    6    7    8    9    10   11   12   13    14
#our @sigils = ('{', '&', '$', '+', '-', '*', '/', '%', '**', '=', '@', '#', ':' ,'//', ')('
#                15    16    17  18   19    20     21       22       23      24       25       26      
#              ,'==', '/=', '<', '>', '<=', '>=', '.not.', '.and.', '.or.', '.xor.', '.eqv.', '.neqv.'
#                27   28    29        30      31         32           33             34       35 
#              ,',', '(/', 'integer', 'real', 'logical', 'character', 'PlaceHolder', 'Label', 'BLANK'
#              );
# The assumption is that we pass this the 3rd arg of an AST for a subroutine call
# This can either be a comma-sep list or a single arg
sub _parse_subcall_args { (my $ast, my $args) =@_;
# An expression: 
# carp Dumper($ast);
    if (
    (scalar @{$ast} >= 3 and  
    $ast->[0]<27 and $ast->[0] != 2  and $ast->[0] != 10 )
    or
    (scalar @{$ast} == 2 and  $ast->[0] == 4 and $ast->[1][0]<27) # - not followed by const
    ) {
	# if ( ($ast->[0] & 0xFF) == 0 ) { #	'('
	# An expression. 
       my $expr_str = emit_expr_from_ast($ast);
	   my $vars = find_vars_in_ast($ast, {});
       $args->{'Set'}{$expr_str}={
           'Type'=>'Expr', 
           'Vars'=>$vars, 
           'Expr' => $expr_str,   
           'AST'=>$ast
       };
       push @{$args->{'List'}}, $expr_str;
    }
	elsif (($ast->[0] & 0xFF) == 2) { #'$'
	        my $arg = $ast->[1];
	        $args->{'Set'}{$arg}={ 	      
                'Type'=>'Scalar',              
                'Expr' => $arg
            };
       push @{$args->{'List'}}, $arg;
    }
    elsif (
        scalar @{$ast} == 2 and
        ($ast->[0] & 0xFF) == 4
    and ($ast->[1][0] & 0xFF) > 28
    ) { #'-' then const
        my $arg = '-'.$ast->[1][1]; 
        $args->{'Set'}{$arg}={    
            'Type'=>'Const', 
            'SubType'=>$sigils[ ($ast->[1][0] & 0xFF) ],
            'Expr' => '-'.$arg
        };
       push @{$args->{'List'}}, $arg;    
    }
    elsif (($ast->[0] & 0xFF) > 28) { # constants
        # constants
        my $arg = $ast->[1]; 
        $args->{'Set'}{$arg}={        
            'Type'=>'Const', 
            'SubType'=>$sigils[ ($ast->[0] & 0xFF) ],
            'Expr' => $arg
        };
        push @{$args->{'List'}}, $arg;
	}     
	elsif (($ast->[0] & 0xFF)== 10) { #'@'
        my $arg = $ast->[1]; 
        my $expr_str = emit_expr_from_ast($ast);
        my $vars = find_vars_in_ast($ast, {});
        $args->{'Set'}{$expr_str}={ 
                'Type'=>'Array',
                'Vars'=>$vars, 
                'Expr' => $expr_str, 
                'Arg' => $arg,
                'AST' => $ast
        };	
        push @{$args->{'List'}}, $expr_str;
    }  
	elsif (($ast->[0] & 0xFF)== 1) {# '&'
            my $arg = $ast->[1]; 
           my $expr_str = emit_expr_from_ast($ast);
	       my $vars = find_vars_in_ast($ast, {});
	        $args->{'Set'}{$expr_str}={   
                'Type'=>'Sub',  
                'Vars'=>$vars, 
                'Expr' => $expr_str,
                'Arg' => $arg,
                'AST' => $ast
            };	
       push @{$args->{'List'}}, $expr_str;
    }  
    elsif ( ($ast->[0] & 0xFF) == 27 ) {# ','
		#process the list and collect any scalar or array
		for my $idx (1 .. scalar @{$ast}-1) {
			# This is a comma-sep arg list. We test for $ and @
			$args = _parse_subcall_args($ast->[$idx], $args);
		}
	}    
    return $args;
} # END of _parse_subcall_args


1;
            

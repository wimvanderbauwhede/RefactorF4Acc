package RefactorF4Acc::Parser::Expressions;
use v5.16;
use RefactorF4Acc::Config;
#use RefactorF4Acc::Utils qw( in_nested_set );
#
#   (c) 2010-2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
$Data::Dumper::Indent = 1;

use Math::Expression::Evaluator::Parser; 
use RefactorF4Acc::Utils qw( %F95_reserved_words %F95_intrinsics %F95_other_intrinsics %F95_intrinsic_functions );
use Exporter;

@RefactorF4Acc::Parser::Expressions::ISA = qw(Exporter);

@RefactorF4Acc::Parser::Expressions::EXPORT_OK = qw(
  &parse_expression
  &emit_expression
  &get_vars_from_expression
  &get_args_vars_from_expression
  &get_args_vars_from_subcall
);

my $DBG=0;
=pod
[wim@workai RefactorF4Acc]$ perl -e 'use Data::Dumper;use Math::Expression::Evaluator::Parser; print Dumper(Math::Expression::Evaluator::Parser::parse("f(a,12.3,b(2,2.3e-4+v))",{}))'
$VAR1 = [
          '&',
          'f',
          [
            '$',
            'a'
          ],
          '12.3',
          [
            '&',
            'b',
            '2',
            [
              '+',
              '2.3e-4',
              [
                '$',
                'v'
              ]
            ]
          ]
        ];
=cut         
sub parse_expression { (my $exp, my $info, my $stref, my $f)=@_;
	my $preproc_expr = $exp;
	$preproc_expr =~s/\s+//g;
	# EVIL HACK because the Math::Expression::Evaluator::Parser does not support things like a ** b ** c
	$preproc_expr =~s/\*\*\s*(\w+)\s*\*\*\s*(\w+)/**($1 * $2)/;
	while ($preproc_expr=~/\.\w+\./) {
#		$preproc_expr =~s/\.not\.//g; # b .and. .not. a => b +_AND_+_NOT_+a
#		$preproc_expr =~s/\.false\./0/g;
#		$preproc_expr =~s/\.true\./1/g;
#		$preproc_expr =~s/\.\w+\./+/g;
		$preproc_expr =~s/\.not\./__not__\+/g; # b .and. .not. a => b +_AND_+_NOT_+a		
		$preproc_expr =~s/\.false\./__false__/g;
		$preproc_expr =~s/\.true\./__true__/g;
		$preproc_expr =~s/\.(\w+)\./\+__${1}__\+/g; 
		 
	}
#	if ($preproc_expr=~/\__/) {say $preproc_expr}
	# F77 allows 1D7 or 2Q-5 instead of 1E7 and 2E-5 
	while ($preproc_expr=~/\W[\.\d]+[dq][\d\-\+]/) { 
		$preproc_expr=~s/(\W[\.\d]+)[dq]([\d\-\+])/${1}e$2/;
	}
	# More EVIL HACK to "support" complex numbers
	
	if ($preproc_expr=~/^\([^\(\)]+,[^\(\)]+\)/) {
		$preproc_expr='_complex_'.$preproc_expr;
	}
	while ($preproc_expr=~/\W\(/) { 
		$preproc_expr=~s/(\W)\(/${1}_complex_\(/;
	}
#	 if ($exp =~/\*\*\s*(\w+)\s*\*\*\s*(\w+)/) {
#	 	croak $preproc_expr;
#	 }
	my $wrap=0;
	# We want to wrap if this is a list. But how can I tell without parsing it?
	my $wrapped_expr = $preproc_expr;
	if ($wrap) {
	 $wrapped_expr = '_dummy_('.$preproc_expr.')';
	}
#	say "PRE:$preproc_expr" if $preproc_expr=~/lvon01/;
    my $ast = Math::Expression::Evaluator::Parser::parse($wrapped_expr, {});
#    shift @{$ast};shift @{$ast};
	if ($wrap) {
	    $ast->[0]='&';
	    $ast->[1]=~s/_/\#/g;
	}
    #( $stref, $f, $ast)
    $ast =  _change_func_to_array($stref,$f,$info,$ast, $exp);
#    say Dumper($ast) if $preproc_expr=~/lvon01/;
	return $ast;
}

# This function changes functions to arrays
sub _change_func_to_array { (my $stref, my $f,  my $info, my $ast, my $exp)=@_;
	if (ref($ast) eq 'ARRAY') {
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
#		print "IDX: $idx => "; say Dumper ($ast); say $entry;
		if (ref($entry) eq 'ARRAY') {
			my $entry = _change_func_to_array($stref,$f, $info,$entry, $exp);
			$ast->[$idx] = $entry;
		} else {
			if ($entry eq '&') {				
				my $mvar = $ast->[$idx+1];
				say 'Found function '.$mvar  if $DBG;
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
 				not ( exists $stref->{'Subroutines'}{$mvar} and exists $stref->{'Subroutines'}{$mvar}{'Function'} and $stref->{'Subroutines'}{$mvar}{'Function'} == 1) 
 				and ( exists $stref->{'Subroutines'}{$f}{'MaskedIntrinsics'}{$mvar}
 				or (
 					$mvar ne '#dummy#' and $mvar ne $subname 
 					and not exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar}
					and not exists $F95_reserved_words{$mvar}
#					and not exists $F95_intrinsics{$mvar} # Dangerous, because some idiot may have overwritten an intrinsic with an array! 					
					)
					)		
				) {
    		# change & to @
    				$ast->[$idx]='@';
    				say "Found array $mvar" if $DBG;
				} elsif (   	exists $F95_intrinsics{$mvar} ) {
					say "parse_expression('$exp')" . __LINE__.": WARNING: treating $mvar in $f as an intrinsic! " if $W;  
				} else {
					# So, this line contains a function call, so we should say so in $info!
					# I introduce FunctionCalls for this purpose!
					if (
					( exists $stref->{'Subroutines'}{$mvar} and exists $stref->{'Subroutines'}{$mvar}{'Function'} and $stref->{'Subroutines'}{$mvar}{'Function'} == 1) and (
					$mvar ne '#dummy#' and $mvar ne $subname 
 					and not exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar}
					and not exists $F95_reserved_words{$mvar}
#					and not exists $F95_intrinsics{$mvar} # Dangerous, because some idiot may have overwritten an intrinsic with an array! 					
)
					) {
#						say "TAG FunctionCalls $mvar" ;
					$info->{'FunctionCalls'}{$mvar}=1;
					}
				}
			} elsif ($entry eq '$') {
				my $mvar = $ast->[$idx+1];
				say "Found scalar $mvar" if $DBG;
				
			} elsif ($entry eq '@') {
				my $mvar = $ast->[$idx+1];
				say "Found array $mvar" if $DBG;
			} elsif ($entry eq '#') {
				my $mvar = $ast->[$idx+1];
				say "Found dummy $mvar" if $DBG;				
			} else {
#				say $entry;
			}
		}		
	}
	}
	return  $ast;#($stref,$f, $ast);	
	
}

# This function changes functions to arrays
sub _walk_ast { (my $stref, my $f, my $info, my $ast, my $ast_node_action)=@_;
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
#		print "IDX: $idx => "; say Dumper ($ast); say $entry;
		if (ref($entry) eq 'ARRAY') {
			( $stref,  $f,  $info, my $entry) = _walk_ast($stref,$f,$info, $entry, $ast_node_action);
			$ast->[$idx] = $entry;
		} else {
			if ($entry eq '&') {
				say 'Found function'  if $DBG;
				my $mvar = $ast->[$idx+1];
#				say $mvar;
#				say Dumper($stref->{'Subroutines'}{$f});
				if ($mvar ne '#dummy#' and not exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar}
				and $mvar ne $info->{'SubroutineCall'}{'Name'}
				) {
    		# change & to @
    				$ast->[$idx]='@';
    				say "Found array $mvar" if $DBG;
				}    	
			} elsif ($entry eq '$') {
				my $mvar = $ast->[$idx+1];
				say "Found scalar $mvar" if $DBG;
				
			} elsif ($entry eq '@') {
				my $mvar = $ast->[$idx+1];
				say "Found array $mvar" if $DBG;
			} elsif ($entry eq '#') {
				my $mvar = $ast->[$idx+1];
				say "Found dummy $mvar" if $DBG;				
			} else {
#				say $entry;
			}
		}		
	}
	return ($stref,$f,$info, $ast);	
}

sub emit_expression {(my $ast, my $expr_str)=@_;
	my @expr_chunks=();
	my $skip=0;
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			 my $nest_expr_str = emit_expression( $entry, '');
#			 say "NEST:$nest_expr_str ";
			push @expr_chunks, $nest_expr_str;
		} else {
			if ($entry =~/#/) {
				$skip=1;
			} elsif ($entry eq '&') {
				my $mvar = $ast->[$idx+1];
				$expr_str.=$mvar.'(';
				$skip=1;
			} elsif ($entry eq '$') {
				my $mvar = $ast->[$idx+1];
				push @expr_chunks,$mvar;
				$skip=1;				
			} elsif ($entry eq '@') {
				my $mvar = $ast->[$idx+1];				
				$expr_str.=$mvar.'(';
				$skip=1;
#			} elsif ($entry =~/^\W/) {
#				my $mvar = $ast->[$idx+1];				
#				$expr_str.=$mvar.'(';
#				$skip=1;				
			} elsif (
				$ast->[$idx-1]!~/^[\&\@\$]/ 
			) {
#				say "ENTRY:$entry SKIP: $skip";
				push @expr_chunks,$entry;
				$skip=0;
			}
		}				
	}
	if ($ast->[0] eq '&' or $ast->[0] eq '@') {
		$expr_str.=join(',',@expr_chunks);
		$expr_str.=')'; 
	} elsif ($ast->[0] ne '$' and $ast->[0] =~ /\W/) {
		my $op = $ast->[0];
		if (scalar @{$ast} > 2) {
			my @ts=();
			for my $elt (1 .. scalar @{$ast} -1 ) {
				$ts[$elt-1] = (ref($ast->[$elt]) eq 'ARRAY') ? emit_expression( $ast->[$elt], '') : $ast->[$elt];					
			} 
			if ($op eq '^') {$op = '**'};
			$expr_str.=join($op,@ts);#$t1.$ast->[0].$t2;
		} elsif (defined $ast->[2]) { croak "OBSOLETE!";
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? emit_expression( $ast->[1], '') : $ast->[1];
			my $t2 = (ref($ast->[2]) eq 'ARRAY') ? emit_expression( $ast->[2], '') : $ast->[2];			
			$expr_str.=$t1.$ast->[0].$t2;
			if ($ast->[0] ne '=') {
				$expr_str="($expr_str)";
			}			
		} else {
			# FIXME! UGLY!
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? emit_expression( $ast->[1], '') : $ast->[1];
			$expr_str=$ast->[0].$t1;
			if ($ast->[0] eq '/') {
				$expr_str='1.0'.$expr_str; 
			}
		}
	} else {
		$expr_str.=join(';',@expr_chunks);
	}	
	$expr_str=~s/_complex_//g;
	if ($expr_str=~s/^\#dummy\#\(//) {
		$expr_str=~s/\)$//;
	}
	$expr_str=~s/\+\-/-/g;
#	say "PRE2: $expr_str" if $expr_str=~/false/;
	while ($expr_str=~/__[a-z]+__/ or $expr_str=~/\.\w+\.\+/) {
		$expr_str =~s/\+\.(\w+)\.\+/\.${1}\./g;
		$expr_str =~s/\.(\w+)\.\+/\.${1}\./g;
		$expr_str =~s/__not__\+/\.not\./g; 
		$expr_str =~s/__not__/\.not\./g; 		
		$expr_str =~s/__false__/\.false\./g;
		$expr_str =~s/__true__/\.true\./g;
		$expr_str =~s/\+__(\w+)__\+/\.${1}\./g;
		
		$expr_str =~s/__(\w+)__/\.${1}\./g; 
 		
	}
#	say "POST: $expr_str" if $expr_str=~/false/;
	return $expr_str;		
} # END of emit_expr
# All variables in the expression
sub get_vars_from_expression {(my $ast, my $vars)=@_;
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			$vars = get_vars_from_expression( $entry, $vars);			
		} else {
			if ($entry eq '$' ) {				
			my $mvar = $ast->[$idx+1];
				next if $mvar=~/__PH\d+__/;			
				$vars->{$mvar}={'Type'=>'Scalar'} ;					
			} elsif ($entry eq '@') {				
				my $mvar = $ast->[$idx+1];
				next if $mvar=~/__PH\d+__/;			
				$vars->{$mvar}={'Type' =>'Array'};					
			} 
		}				
	}
	return $vars;		
}
# if the expression is a sub call (or in fact just a comma-sep list), return the arguments and also all variables that are not arguments
sub get_args_vars_from_expression {(my $ast)=@_;
	
	my $all_vars={'List'=>[],'Set'=>{} };
	my $args={'List'=>[],'Set'=>{}};
	if (ref($ast) eq 'ARRAY') {
			
	for my  $idx (0 .. scalar @{$ast}-1) {
		if ($ast->[$idx] eq '@') {
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
#			say "ARG: $arg";
	
			if ( $ast->[$idx][0]  eq '@' 
			or  $ast->[$idx][0]  eq '$'
			or  $ast->[$idx][0]  eq '&') {
				if ($ast->[$idx][0] eq '@' or $ast->[$idx][0] eq '&') {
					my $vars = get_vars_from_expression($ast->[$idx],{} );
					delete $vars->{$arg}; 
					$all_vars->{'Set'}={%{ $all_vars->{'Set'} },%{$vars}};
					if ($ast->[$idx][0] eq '@') {
#						push @{$args->{'List'}},$arg;
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
				} elsif($arg!~/__PH\d+__/) {				
					$args->{'Set'}{$arg}={ 'Type'=>'Scalar'};
				} 
			} else {
				# This is an expression in its own right. 
				my $vars = get_vars_from_expression($ast->[$idx],{} );
#						$args->{'Set'}{$arg}={ 'Type'=>'Expr','Vars'=>$vars, 'AST'=>$ast->[$idx]};
						$all_vars->{'Set'}={%{ $all_vars->{'Set'} },%{$vars}};
			}
		} elsif ($ast->[$idx] eq '$') { 
			my $arg=$ast->[$idx+1];			
			$args->{'Set'}{$arg}={ 'Type'=>'Scalar'} unless $arg=~/__PH\d+__/;
		}
		}
	}	
	$args->{'List'} = [keys %{ $args->{'Set'} }]; 
	$all_vars->{'List'} = [keys %{ $all_vars->{'Set'} }]; 
	}
	return [$args,$all_vars];
}

# if the expression is a sub call (or in fact just a comma-sep list), return the arguments and also all variables that are not arguments
# We can of course have duplication here, and also some of the args can be functions or expressions. 
# So we have Args that can be Scalar, Array, Sub, Expr or Const

sub get_args_vars_from_subcall {(my $ast)=@_;
	
	my $all_vars={'List'=>[],'Set'=>{} };
	my $args={'List'=>[],'Set'=>{}};
	
	if (scalar @{$ast} > 2 ) {			
		for my  $idx (2 .. scalar @{$ast}-1) { # 0 and 1 are '&" and the subroutine name				
			if( ref( $ast->[$idx] ) eq 'ARRAY') { 				 
				my $arg = $ast->[$idx][1];
				if ($arg=~/__PH\d+__/ ) {
					$arg=0;
				}			
				if ($arg=~/^__(\w+)__$/) {
					$arg=~s/__(\w+)__/\.${1}\./;
				}
				if ( $ast->[$idx][0]  eq '@' 
				or  $ast->[$idx][0]  eq '$'
				or  $ast->[$idx][0]  eq '&') {
					if ($ast->[$idx][0] eq '@' or $ast->[$idx][0] eq '&') {
						my $vars = get_vars_from_expression($ast->[$idx],{} );
						delete $vars->{$arg}; 
						$all_vars->{'Set'}={%{ $all_vars->{'Set'} },%{$vars}};
						if ($ast->[$idx][0] eq '@') {
							my $array_expr = emit_expression($ast->[$idx]);
							$args->{'Set'}{$array_expr}={ 'Type'=>'Array','Vars'=>$vars, 'Expr' => $array_expr, 'Arg' => $arg};
							push @{$args->{'List'}}, $array_expr;#$arg;
						} else {							
							my $arg_expr=emit_expression($ast->[$idx]);
							$args->{'Set'}{$arg_expr}={ 'Type'=>'Sub','Vars'=>$vars, 'Expr' => $arg_expr};
							push @{$args->{'List'}}, $arg_expr;
						}
					} else { # A scalar			
						$args->{'Set'}{$arg}={ 'Type'=>'Scalar',  'Expr' => $arg};
						push @{$args->{'List'}}, $arg;
					} 
					
				} else {
					# This is an expression in its own right. 
					# In that case, $arg will be an array ref.
					my $arg_expr = emit_expression($ast->[$idx]);
					push @{$args->{'List'}}, $arg_expr;
					my $vars = get_vars_from_expression($ast->[$idx],{} );
					$args->{'Set'}{$arg_expr}={ 'Type'=>'Expr','Vars'=>$vars, 'AST'=>$ast->[$idx], 'Expr' => $arg_expr};
					$all_vars->{'Set'}={%{ $all_vars->{'Set'} },%{$vars}};
				}
			} else  { # It must be a constant 
				my $arg=$ast->[$idx];			
				if ($arg=~/__PH\d+__/ ) {
					$arg=0;
				}
				$args->{'Set'}{$arg}={ 'Type'=>'Const', 'Expr' => $arg};
				push @{$args->{'List'}}, $arg; 
			}		
		}	
	}
	$all_vars->{'List'} = [keys %{ $all_vars->{'Set'} }];
	return ($args,$all_vars);
}

1;

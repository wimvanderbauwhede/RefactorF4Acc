package RefactorF4Acc::Parser::Expressions;
use v5.16;
use RefactorF4Acc::Config;

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
	my $wrap=0;
	# We want to wrap if this is a list. But how can I tell without parsing it?
	my $wrapped_expr = $exp;
	if ($wrap) {
	 $wrapped_expr = '_dummy_('.$exp.')';
	}
    my $ast = Math::Expression::Evaluator::Parser::parse($wrapped_expr, {});
#    shift @{$ast};shift @{$ast};
	if ($wrap) {
	    $ast->[0]='&';
	    $ast->[1]=~s/_/\#/g;
	}
    #( $stref, $f, $ast)
    $ast = _change_func_to_array($stref,$f,$info,$ast, sub {});
#    say Dumper($ast);
return $ast;
}

# This function changes functions to arrays
sub _change_func_to_array { (my $stref, my $f,  my $info, my $ast, my $ast_node_action)=@_;
	if (ref($ast) eq 'ARRAY') {
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
#		print "IDX: $idx => "; say Dumper ($ast); say $entry;
		if (ref($entry) eq 'ARRAY') {
#			( $stref,  $f,   my $entry) = _change_func_to_array($stref,$f, $entry, $ast_node_action);
			my $entry = _change_func_to_array($stref,$f, $info,$entry, $ast_node_action);
			$ast->[$idx] = $entry;
		} else {
			if ($entry eq '&') {
				
				my $mvar = $ast->[$idx+1];
				say 'Found function '.$mvar  if $DBG;
#				say $mvar;
#				say Dumper($stref->{'Subroutines'}{$f});
				my $subname = (exists $info->{'SubroutineCall'} and exists $info->{'SubroutineCall'}{'Name'}) ? $info->{'SubroutineCall'}{'Name'} : '#dummy#';
 				if ($mvar ne '#dummy#' and not exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar}
				and not exists $F95_reserved_words{$mvar}
				and not exists $F95_other_intrinsics{$mvar} # so we leave out intrinsic functions from this check 
				and $mvar ne $subname
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
		if (defined $ast->[2]) {
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
	if ($expr_str=~s/^\#dummy\#\(//) {
		$expr_str=~s/\)$//;
	}
	return $expr_str;		
}
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

1;

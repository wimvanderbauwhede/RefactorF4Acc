package RefactorF4Acc::Parser::Expressions;
use v5.10;
use RefactorF4Acc::Config;
#use RefactorF4Acc::Utils qw( in_nested_set );
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
$Data::Dumper::Indent = 1;

use Fortran::Expression::Evaluator::Parser; 
use RefactorF4Acc::Utils qw( %F95_reserved_words %F95_intrinsics %F95_other_intrinsics %F95_intrinsic_functions );
use Exporter;

@RefactorF4Acc::Parser::Expressions::ISA = qw(Exporter);

@RefactorF4Acc::Parser::Expressions::EXPORT_OK = qw(
  &parse_expression
  &emit_expression
  &get_vars_from_expression
  &get_args_vars_from_expression
  &get_consts_from_expression
  &get_args_vars_from_subcall
);

my $DBG=0;
=pod
[wim@workai RefactorF4Acc]$ perl -e 'use Data::Dumper;use Fortran::Expression::Evaluator::Parser; print Dumper(Fortran::Expression::Evaluator::Parser::parse("f(a,12.3,b(2,2.3e-4+v))",{}))'
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

# '_dummy_(write(__PH1__,_CONCAT_PRE_,path(numpath+2*_OPEN_PAR_(...', 'HASH(0x7fb906282f70)') called at /Users/wim/Git/RefactorF4Acc/RefactorF4Acc/Parser/Expressions.pm line 144
# 'write(__PH1__//path(numpath+2*(k-1)+2)(1:len(numpath+2*(k-1)+2))
#write(*,'(a)') '     '//path(numpath+2*(k-1)+2)(1:len(numpath+2*(k-1)+2))

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
sub parse_expression { (my $exp, my $info, my $stref, my $f)=@_;
	my $preproc_expr = $exp;
#	say "EXPR: $preproc_expr" if $preproc_expr=~/write.+path.numpath/; 
	 # To make this robust, what I'll do is replace any '(' with '_OPEN_PAR_(' so that is looks like a function.
	 $preproc_expr=~s/^\(/_OPEN_PAR_\(/;
	while($preproc_expr=~/[\+\-\*\/,:\(]\s*\(/) { # basically, it can be: ,+-*/ 
			$preproc_expr=~s/([\+\-\*\/,:\(])\s*\(/${1}_OPEN_PAR_\(/;
	}	 
	$preproc_expr =~s/\s+//g;
	
	# EVIL HACK to 'support' Alternate Returns
	 $preproc_expr =~s/,\s*\*/,_LABEL_ARG_\*/g;
	 $preproc_expr =~s/\(\s*\*/\(_LABEL_ARG_\*/;

	# EVIL HACK because the Fortran::Expression::Evaluator::Parser does not support things like a ** b ** c
	while ($preproc_expr =~/\*\*\s*(\w+)\s*\*\*\s*(\w+)/) {
		$preproc_expr =~s/\*\*\s*(\w+)\s*\*\*\s*(\w+)/**($1 * $2)/;
	}
	# EVIL HACK because the Fortran::Expression::Evaluator::Parser does not support <=, ==, =>, /=
	$preproc_expr =~s/\<\=/.le./g;
	$preproc_expr =~s/\>\=/.ge./g;
	$preproc_expr =~s/\=\=/.eq./g;
	$preproc_expr =~s/\/\=/.ne./g;
	$preproc_expr =~s/\>/.gt./g;
	$preproc_expr =~s/\</.lt./g;
	while ($preproc_expr=~/\.[a-z]+\./) {
		$preproc_expr =~s/\.not\./__not__\+/g; # b .and. .not. a => b +_AND_+_NOT_+a		
		$preproc_expr =~s/\.false\./__false__/g;
		$preproc_expr =~s/\.true\./__true__/g;
		$preproc_expr =~s/\.([a-z]+)\./\+__${1}__\+/g;
		
	}
	$preproc_expr =~s/\+\-/-/g;
	$preproc_expr =~s/\+\+/+/g;
#	# F77 allows 1D7 or 2Q-5 instead of 1E7 and 2E-5 
#	while ($preproc_expr=~/\W[\.\d]+[dq][\d\-\+]/) { 
#		$preproc_expr=~s/(\W[\.\d]+)[dq]([\d\-\+])/${1}e$2/;
#	}
#	# More EVIL HACK to "support" complex numbers, WEAK!	
#	# ( <not ( ) > , <not ( )> )
#	if ($preproc_expr=~/^\([^\(\)]+,[^\(\)]+\)/) {
#		$preproc_expr='_complex_'.$preproc_expr;
#	}
#	while ($preproc_expr=~/\W\([^\(\)]+,[^\(\)]+\)/) { 
#		$preproc_expr=~s/(\W)\(/${1}_complex_\(/;
#	}
	# HACK to support ':'
	# Remove ':' because again this only occurs for characters strings
	my $wrap=0;
	my $has_colons=0;
	if ($preproc_expr =~ /:/) {
#		say "EXPR $exp";
		$has_colons=1;
		$preproc_expr =~ s/:\s*\*/,_COLON_PRE_,_STAR_/g;
		$preproc_expr =~ s/:/,_COLON_PRE_,/g;
		$preproc_expr =~ s/\(,_COLON_PRE_/\(_COLON_PRE_/g;
		$preproc_expr =~ s/_COLON_PRE_,\)/_COLON_PRE_\)/g;
		$preproc_expr =~ s/,,_COLON_PRE_/,_COLON_PRE_/g;
		$preproc_expr =~ s/_COLON_PRE_,,/_COLON_PRE_,/g;
	}
	# HACK to support '//'
	my $has_concat=0;
	if ($preproc_expr =~ /\/\//) {
		# If this expression contains parens I just remove them!
		# This is bad, it breaks 	 	#   path(3)(1:len(3))//wfname(ifn)
#		$preproc_expr =~ s/[\)\(]//g;
		$preproc_expr =~ s/\/\//,_CONCAT_PRE_,/g;
		$preproc_expr =~ s/\(,_CONCAT_PRE_/\(_CONCAT_PRE_/g;
		$preproc_expr =~ s/_CONCAT_PRE_,\)/_CONCAT_PRE_\)/g;
		$wrap=1;
	}	  
	
	my $double_paren=0;
	# EVIL HACK to get rid of f(x)(y)
	# Suppose we replace this by f( x,_PAREN_PAIR_,y)
	# Then we replace this by
	# ['&',f,[')(',['$','x'],['$','y']]]
	# We emit 
	# f( x)(y)
	if ($preproc_expr =~ /\)\s*\(/) {
		$double_paren=1;
		$preproc_expr =~ s/\)\s*\(/,_PAREN_PAIR_,/g;
		$preproc_expr =~ s/\(,_PAREN_PAIR_/\(_PAREN_PAIR_/g;
		$preproc_expr =~ s/_PAREN_PAIR_,\)/_PAREN_PAIR_\)/g;
		$preproc_expr =~ s/,,_PAREN_PAIR_/,_PAREN_PAIR_/g;
		$preproc_expr =~ s/_PAREN_PAIR_,,/_PAREN_PAIR_,/g;		
	}	  	
	# We want to wrap if this is a list. But how can I tell without parsing it?
	my $wrapped_expr = $preproc_expr;
	if ($wrap) {
	 $wrapped_expr = '_dummy_('.$preproc_expr.')';
	}

#	say "WRAPPED EXPR $f: $wrapped_expr" ; 
    my $ast = Fortran::Expression::Evaluator::Parser::parse($wrapped_expr, {});

	if ($wrap) {
	    $ast->[0]='&';
	    $ast->[1]=~s/_/\#/g;
	}
	
    my $ast2 =  _change_func_to_array($stref,$f,$info,$ast, $exp);
    
    my $ast3 = _fix_colons_in_ast($ast2);
    my $ast4 = _fix_string_concat_in_ast($ast3);
    my $ast5 = _fix_double_paren_in_ast($ast4);

	return $ast5;
}

# This function changes functions to arrays
sub _change_func_to_array { (my $stref, my $f,  my $info, my $ast, my $exp)=@_;
	if (ref($ast) eq 'ARRAY') {
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];

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
 					(
 				# 1. $mvar is not a function, including intrinsic
 					not(  (
 					exists $stref->{'Subroutines'}{$mvar} and 
 					exists $stref->{'Subroutines'}{$mvar}{'Function'} and 
 					$stref->{'Subroutines'}{$mvar}{'Function'} == 1 ) or (
 					exists $F95_intrinsics{$mvar}
 					) 
 					
 					)
 				# 2. OR $mvar is a masked intrinsic	 
 					or exists $stref->{'Subroutines'}{$f}{'MaskedIntrinsics'}{$mvar}
 					) 
# 					or (
#				# 3. OR $mvar is actually an array 					 					  	
# 					$mvar ne '#dummy#' and $mvar ne $subname 
# 					and not exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar}
#					and not exists $F95_reserved_words{$mvar}
##					and not exists $F95_intrinsics{$mvar} # Dangerous, because some idiot may have overwritten an intrinsic with an array! 					
#					)							
				) {
    		# change & to @
    		croak '<'.(
    		not( 
 					exists $stref->{'Subroutines'}{$mvar} and 
 					exists $stref->{'Subroutines'}{$mvar}{'Function'} and 
 					$stref->{'Subroutines'}{$mvar}{'Function'} == 1
 					)
    		).'><'.( exists $stref->{'Subroutines'}{$f}{'MaskedIntrinsics'}{$mvar} ).'>' if $mvar eq 'aint';
    				$ast->[$idx]='@';
    				say "Found array $mvar" if $DBG;
				} elsif (   	exists $F95_intrinsics{$mvar} ) {
#					say "Parser::Expressions::parse_expression('$exp') on line" . __LINE__.": WARNING: treating $mvar in $f as an intrinsic! " if $W;
				} elsif (   	$mvar eq 'fakerange' ) {
#					say "Parser::Expressions::parse_expression('$exp') on line" . __LINE__.": WARNING: treating $mvar in $f as an intrinsic! " if $W;					  
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
sub _UNUSED_walk_ast { (my $stref, my $f, my $info, my $ast, my $ast_node_action)=@_;
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
#		print "IDX: $idx => "; say Dumper ($ast); say $entry;
		if (ref($entry) eq 'ARRAY') {
			( $stref,  $f,  $info, my $entry) = _UNUSED_walk_ast($stref,$f,$info, $entry, $ast_node_action);
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
} # _UNUSED_walk_ast

sub emit_expression {(my $ast, my $expr_str)=@_;
	
	
	if (ref($ast) ne 'ARRAY') {return $ast;}
	croak 'EMPTY AST' unless @{$ast};
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
			$expr_str.=join($op,@ts);
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
#	$expr_str=~s/_complex_//g;
	$expr_str=~s/_OPEN_PAR_//g;
	if ($expr_str=~/_OPEN_CONST_ARRAY_/ ) {
		$expr_str=~s/_OPEN_CONST_ARRAY_//;
		$expr_str=~s/^\(/\(\//;
		$expr_str=~s/\)/\/\)/;
	};
	$expr_str=~s/_LABEL_ARG_//g;
	if ($expr_str=~s/^\#dummy\#\(//) {
		$expr_str=~s/\)$//;
	}
	$expr_str=~s/\+\-/-/g;
	# UGLY! HACK to fix boolean operations
	while ($expr_str=~/__[a-z]+__/ or $expr_str=~/\.\w+\.\+/) {
		$expr_str =~s/\+\.(\w+)\.\+/\.${1}\./g;
		$expr_str =~s/\.(\w+)\.\+/\.${1}\./g;
		$expr_str =~s/__not__\+/\.not\./g; 
		$expr_str =~s/__not__/\.not\./g; 		
		$expr_str =~s/__false__/\.false\./g;
		$expr_str =~s/__true__/\.true\./g;
		$expr_str =~s/\+__(\w+)__\+/\.${1}\./g;		
		$expr_str =~s/__(\w+)__/\.${1}\./g;
		
#		  		$expr_str =~s/\.(\w+)\./$F95_ops{$1}/g;
	}
	 
	return $expr_str;		
} # END of emit_expr

# All variables in the expression
# $vars = {} to start
sub get_vars_from_expression {(my $ast, my $vars)=@_;
#	croak Dumper($ast) unless 
	if (ref($ast) ne 'ARRAY') {
		if ($ast=~/([a-z]\w*)/) {
			my $mvar = $1;
			$vars->{$mvar}={'Type'=>'Scalar'} ;
		}
			return $vars;
	}
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			$vars = get_vars_from_expression( $entry, $vars);			
		} else {
			if ($entry eq '$' ) {				
				my $mvar = $ast->[$idx+1];
				next if $mvar=~/__[a-z]+__/;
				next if $mvar=~/__PH\d+__/;		
				next if $mvar=~/_(?:CONCAT|COLON)_PRE_/;
				next if $mvar=~/_PAREN_PAIR_/;			
				next if exists $Config{'Macros'}{uc($mvar)};
				$vars->{$mvar}={'Type'=>'Scalar'} ;					
			} elsif ($entry eq '@') {				
				my $mvar = $ast->[$idx+1];
				next if $mvar=~/__[a-z]+__/;
				next if $mvar=~/__PH\d+__/;
				next if $mvar=~/_(?:CONCAT|COLON)_PRE_/;
				next if $mvar=~/_PAREN_PAIR_/;						
				$vars->{$mvar}={'Type' =>'Array'};
				my $index_vars={};
				for my $elt_idx (2 ..  scalar @{$ast}-1) {
					if (ref($ast->[$idx+$elt_idx]) eq 'ARRAY') {
						$index_vars =  get_vars_from_expression($ast->[$idx+$elt_idx],$index_vars);
					}
					
					for my $idx_var (keys %{ $index_vars }) {
						if ($index_vars->{$idx_var}{'Type'} eq 'Array') {
							delete $index_vars->{$idx_var};
						}
					}					
					$vars->{$mvar}{'IndexVars'} = $index_vars;
				}					
				#['@','eta',['$','j'],['+',['$','k'],'1']]
			} 
		}				
	}
	return $vars;		
}

# All variables in the expression
# $vars = {} to start
sub get_consts_from_expression {(my $ast, my $vars)=@_;
	croak unless ref($ast) eq 'ARRAY';
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			$vars = get_consts_from_expression( $entry, $vars);			
		} else {
			my $val = $entry;
			if ($entry eq '-') {
				 $val =$ast->[$idx+1];
			}
			if ($val =~/^[\.\d]/ ) {
				my $type='Unknown';
				if ( $val =~ /^\-?\d+$/ ) {
					$type = 'integer';
				}
				elsif ( $val =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/ ) {
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
				} elsif($arg!~/__PH\d+__/ and $arg!~/_(?:CONCAT|COLON)_(?:PRE|POST)_/ and $arg!~/_PAREN_PAIR_/) {				
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
			$args->{'Set'}{$arg}={ 'Type'=>'Scalar'} unless ( $arg=~/__PH\d+__/ or $arg=~/_(?:CONCAT|COLON)_PRE_/ or $arg=~/_PAREN_PAIR_/);
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
		my $ignore=0;				
			if( ref( $ast->[$idx] ) eq 'ARRAY') { 				 
				my $arg = $ast->[$idx][1];
				
				if ($arg=~/__PH\d+__/ or $arg=~/_(?:CONCAT|COLON)_(?:PRE|POST)_/ or $arg=~/_PAREN_PAIR_/) {
					$ignore=1;																
				} 			
				elsif ($arg=~/^__(\w+)__$/) {
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
						if ("$arg" ne '0' ) { # FIXME! UGLY!
							$args->{'Set'}{$arg}={ 'Type'=>'Scalar',  'Expr' => $arg};
						} else {							
							$args->{'Set'}{$arg}={ 'Type'=>'Const',  'Expr' => $arg};
						}
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
				if ($arg=~/__PH\d+__/ or $arg=~/_(?:CONCAT|COLON)_(?:PRE|POST)_/ or $arg=~/_PAREN_PAIR_/) {
					$ignore=1;
#					$arg=0;
				}
				$args->{'Set'}{$arg}={ 'Type'=>'Const', 'Expr' => $arg};
				push @{$args->{'List'}}, $arg; 
			}		
		}	
	}
	$all_vars->{'List'} = [keys %{ $all_vars->{'Set'} }];
	return ($args,$all_vars);
}

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
	        	 	$cloned_ast->[$i+2][1]='*';
	        	}
	            $elt = [':','',$cloned_ast->[$i+2]];
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
	            next;
	        }
	        if (ref($cloned_ast->[$i+1]) eq 'ARRAY' and $cloned_ast->[$i+1][1] eq '_COLON_PRE_') {	            
	            if (defined $cloned_ast->[$i+2]) {
	                $elt=[':', $elt,$cloned_ast->[$i+2]];
	                if (ref($cloned_ast->[$i+2]) eq 'ARRAY' and $cloned_ast->[$i+2][1] eq '_STAR_') {
	                	$cloned_ast->[$i+2][1]='*';
	                }
	            } else {
	            	$elt=[':', $elt,''];	            	
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
	if ($new_ast->[1] eq '#dummy#' and $new_ast->[2][0] eq '//') {
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
	            $elt = ['//',$cloned_ast->[$i+2]];
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
#	            $cloned_ast->[$i+2]=undef;
	            next;
	        }
	        if (ref($cloned_ast->[$i+1]) eq 'ARRAY' and $cloned_ast->[$i+1][1] eq '_CONCAT_PRE_') {
	            $elt=['//', $elt];
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
	            $elt = [')(',$cloned_ast->[$i+2]];
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
#	            $cloned_ast->[$i+2]=undef;
	            next;
	        }
	        if (ref($cloned_ast->[$i+1]) eq 'ARRAY' and $cloned_ast->[$i+1][1] eq '_PAREN_PAIR_') {
	            $elt=[')(', $elt];
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

1;

package RefactorF4Acc::Parser::Expressions;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils qw( sub_func_incl_mod );
use RefactorF4Acc::CallTree qw( add_to_call_tree );
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
  &emit_expr_from_ast
  &interpret
  &parse_expression_faster
);

my $DBG=0;

=old
"f(a,12.3,b(2,2.3e-4+v))"
perl -e 'use Data::Dumper;use Fortran::Expression::Evaluator::Parser; print Dumper(Fortran::Expression::Evaluator::Parser::parse("f(a,12.3,b(2,2.3e-4+v))",{}))'
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
# $entry & 0xF = $num
# where $num =
#                 0    1    2    3    4    5    6    7    8     9   10   11   12   13   14
#our  @sigils = ( '{', '&', '$', '+', '-', '*', '/', '%', '**', '=', '@', '#', ':' ,'//',')(');

#               0    1    2    3    4    5    6    7    8     9    10   11   12   13   14
our @sigils = ('{', '&', '$', '+', '-', '*', '/', '%', '**', '=', '@', '#', ':' ,'//',')('
#                15   16   17  18  19   20    21      22      23     24      25      26      
               ,'==','!=','<','>','<=','>=','.not.','.and.','.or.','.xor.','.eqv.','.neqv.'
#                27        28     29        30        31
               ,'integer','real','logical','character', ','
              );



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
	if (1) {
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
	
#	while ($preproc_expr =~/\*\*/) {
#		$preproc_expr =~s/\*\*/\^/;
#	}
	
	# EVIL HACK because the Fortran::Expression::Evaluator::Parser does not support <=, ==, =>, /=
	# I replace this with a sum where the operator is a fake argument variable
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

	# HACK to support ':'
	# Remove ':' because this only occurs for characters strings
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
	# replace <//> by <,_CONCAT_PRE_,>
	# replace <(,_CONCAT_PRE_> by <(_CONCAT_PRE_>
	# replace <_CONCAT_PRE_,)> by <_CONCAT_PRE_)>
	my $has_concat=0;
	if ($preproc_expr =~ /\/\//) {
		$preproc_expr =~ s/\/\//,_CONCAT_PRE_,/g;
		$preproc_expr =~ s/\(,_CONCAT_PRE_/\(_CONCAT_PRE_/g;
		$preproc_expr =~ s/_CONCAT_PRE_,\)/_CONCAT_PRE_\)/g;
		$wrap=1;
	}	  
	
	my $double_paren=0;
	# EVIL HACK to get rid of f(x)(y)
	# Suppose we replace this by f( x,_PAREN_PAIR_,y)
	# Then we replace the AST by
	# ['&',f,[')(',['$','x'],['$','y']]]
	# i.e. we treat ')(' as an operator
	# We emit 
	# f( x)(y )
	# <) (> => ,_PAREN_PAIR_,
	# <(,_PAREN_PAIR_> => <(_PAREN_PAIR_>
	# <_PAREN_PAIR_,)> => <_PAREN_PAIR_)>
	# <,,_PAREN_PAIR_> => <,_PAREN_PAIR_>
	# <_PAREN_PAIR_,,> => <_PAREN_PAIR_,>
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
# say "PREPROC EXPR: $wrapped_expr";
    my $ast = Fortran::Expression::Evaluator::Parser::parse($wrapped_expr, {});

	if ($wrap) {
	    $ast->[0]= 1 + ($Fortran::Expression::Evaluator::Parser::nodeId++<<4);
	    $ast->[1]=~s/_/\#/g;
	}
#	say Dumper($ast);
    (my $ast2, my $grouped_messages) = _change_func_to_array($stref,$f,$info,$ast, $exp, {}) ;
    if ($W) {
        for my $warning_type (sort keys % {$grouped_messages->{'W'}} ) {
            for my $k (sort keys %{$grouped_messages->{'W'}{$warning_type}}) {
            	my $line = $grouped_messages->{'W'}{$warning_type}{$k};
                say $line;
            }
        }
    }
    
#    if ($I) {
#    for my $info_type (sort keys % {$grouped_messages->{'I'}} ) {
#        for my $line (sort keys %{$grouped_messages->{'I'}{$info_type}}) {
#            say $line;
#        }
#    }
#    }
    my $ast3 = _fix_colons_in_ast($ast2);
    my $ast4 = _fix_string_concat_in_ast($ast3);
    my $ast5 = _fix_double_paren_in_ast($ast4);
	return $ast5;
	} else {
		(my $ast, my $rest, my $err, my $has_funcs)  = parse_expression_faster($exp);
		if($err or $rest ne '') {
			croak "PARSE ERROR in <$exp>, REST: $rest";
		}
#		carp $exp.':'.Dumper($ast);
#say "HAS NO FUNCS: $exp " if !$has_funcs;
	    (my $ast2, my $grouped_messages) = $has_funcs ? _change_func_to_array($stref,$f,$info,$ast, $exp, {}) : ($ast,{});
	    if ($W) {
	        for my $warning_type (sort keys % {$grouped_messages->{'W'}} ) {
	            for my $k (sort keys %{$grouped_messages->{'W'}{$warning_type}}) {
	                my $line = $grouped_messages->{'W'}{$warning_type}{$k};
	                say $line;
	            }
	        }
	    }		
	    return $ast2;
	}
	
} # END of parse_expression()

# This function changes functions to arrays
sub _change_func_to_array { (my $stref, my $f,  my $info, my $ast, my $exp, my $grouped_messages)=@_;
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
			if (($entry & 0xF) == 1) {				
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
 					exists $stref->{$code_unit}{$mvar} and 
 					exists $stref->{$code_unit}{$mvar}{'Function'} and 
 					$stref->{$code_unit}{$mvar}{'Function'} == 1 ) or (
 					exists $F95_intrinsics{$mvar} or
 					exists $F95_reserved_words{$mvar} # WV 2019-04-17
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

    				$ast->[$idx]=  10 + (($ast->[$idx]>>4)<<4);#    '@';
    				say "Found array $mvar" if $DBG;
#    				croak Dumper($stref->{$code_unit}{$f}{'MaskedIntrinsics'}). (exists $F95_intrinsics{$mvar}) if $mvar eq 'write';
				} elsif (   	exists $F95_intrinsics{$mvar} ) {
					say "parse_expression('$exp')" . __LINE__ if $DBG;
					$grouped_messages->{'W'}{'VAR_AS_INTRINSIC'}{$mvar} =   "WARNING: treating $mvar in $f as an intrinsic! " if $W;  
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
						$stref->{$code_unit}{$f}{'CalledSubs'}{'Set'}{$mvar} = 1;
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
			} elsif ($entry & 0xF == 2) {
				my $mvar = $ast->[$idx+1];
				say "Found scalar $mvar" if $DBG;
				
			} elsif ($entry & 0xF == 10) {
				my $mvar = $ast->[$idx+1];
				say "Found array $mvar" if $DBG;
			} elsif ($entry & 0xF == 11) {
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

sub emit_expression {(my $ast, my $expr_str)=@_;
	
	if (ref($ast) ne 'ARRAY') {return $ast;}
	
	if (ref($ast) eq 'ARRAY' and scalar(@{$ast}<2)) {
		croak Dumper($ast);
	}
	
	croak 'EMPTY AST' unless @{$ast};
	my @expr_chunks=();
	my $skip=0;
	# Go through the list
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			 my $nest_expr_str = emit_expression( $entry, '');
#			 say "NEST:$nest_expr_str ";
			push @expr_chunks, $nest_expr_str;
		} elsif ($idx == 0) {
            #say Dumper($ast) if $entry=~/\/\//;;
				if (($entry  & 0xF) == 11) { # #
					$skip=1;
				} elsif (($entry & 0xF) == 1) { # &					
					my $mvar = $ast->[$idx+1];
					$expr_str.=$mvar.'(';
					$skip=1;
				} elsif (($entry & 0xF) == 2) { # $
					my $mvar = $ast->[$idx+1];
					push @expr_chunks,$mvar;
					$skip=1;				
				} elsif (($entry & 0xF) == 10) { # @
					my $mvar = $ast->[$idx+1];				
					$expr_str.=$mvar.'(';
					$skip=1;
				} elsif ((($entry & 0xF) >2 ) && (($entry & 0xF) <9)) { # arithmetic operators
					push @expr_chunks, $sigils[$entry & 0xF];
					$skip=0;				
				} else {  
					# do nothing
				}
		} else { # idx > 0
			if (
				(($idx == 1) &&
				(($ast->[$idx-1] & 0xF) != 1) &&
				(($ast->[$idx-1] & 0xF) != 2) &&
				(($ast->[$idx-1] & 0xF) != 10)
				) || ($idx>1)  
				) { # arithmetic operators
#					say "ENTRY:$entry SKIP: $skip";
					push @expr_chunks, $entry;# $sigils[$entry & 0xF];
					$skip=0;			
			}
		}				
	}
	
	if ((($ast->[0] & 0xF) == 1 ) or (($ast->[0]  & 0xF) == 10)) { # & or @	
		$expr_str.=join(',',@expr_chunks);
		$expr_str.=')'; 
	} elsif (($ast->[0]  & 0xF) != 2 and $ast->[0] =~ /^\d+$/) { # FIXME
		my $op = $ast->[0];
		if (scalar @{$ast} > 2) {
			my @ts=();
			for my $elt (1 .. scalar @{$ast} -1 ) {
				$ts[$elt-1] = (ref($ast->[$elt]) eq 'ARRAY') ? emit_expression( $ast->[$elt], '') : $ast->[$elt];					
			}
			
			my $op_sig = $sigils[$op & 0xF]; 
#			if (($op & 0xF) == 8) {$op = '**'}; # FIXME
			$expr_str.=join($op_sig,@ts);
		} elsif (defined $ast->[2]) { croak "OBSOLETE!";
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? emit_expression( $ast->[1], '') : $ast->[1];
			my $t2 = (ref($ast->[2]) eq 'ARRAY') ? emit_expression( $ast->[2], '') : $ast->[2];			
			$expr_str.=$t1.$ast->[0].$t2;
			if (($ast->[0] & 0xF) != 9) {
				$expr_str="($expr_str)";
			}			
		} else {
			# FIXME! UGLY!
#			say Dumper($ast);
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? emit_expression( $ast->[1], '') : $ast->[1];
			$expr_str= $sigils[ $ast->[0] & 0xF ].$t1;
#			say "$t1 => $expr_str"; 
			if (($ast->[0] & 0xF) == 6) {
				$expr_str='1'.$expr_str;# was '1.0' 
			}
		}
	} else {
#		say "ELSE: $expr_str ",$ast->[0] & 0xF,$sigils[ $ast->[0] & 0xF ];
		$expr_str.=join(';',@expr_chunks);
#		say "ELSE: $expr_str ",$ast->[0] & 0xF,$sigils[ $ast->[0] & 0xF ];
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
			if ($idx == 0) {
			if (($entry & 0xF) == 2  ) { # eq '$'				
				my $mvar = $ast->[$idx+1];
				next if $mvar=~/__[a-z]+__/;
				next if $mvar=~/__PH\d+__/;		
				next if $mvar=~/_(?:CONCAT|COLON)_PRE_/;
				next if $mvar=~/_PAREN_PAIR_/;			
				next if exists $Config{'Macros'}{uc($mvar)};
				$vars->{$mvar}={'Type'=>'Scalar'} ;					
			} elsif (($entry & 0xF) == 10) {#  eq '@'				
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
			if (
				($idx == 0) &&
				(($entry & 0xF)==4)
			) {  # '-'
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
#	FIXME!
	my $all_vars={'List'=>[],'Set'=>{} };
	my $args={'List'=>[],'Set'=>{}};
	if (ref($ast) eq 'ARRAY') {
			
	for my  $idx (0 .. scalar @{$ast}-1) {
		
		if ( ($idx == 0) &&
		 (($ast->[$idx] & 0xF)==10)
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
#			say "ARG: $arg";
#carp $idx.Dumper($ast);	
			if ( 
					(($ast->[$idx][0] & 0xF) == 10) # eq '@' 
				or  (($ast->[$idx][0] & 0xF) == 2) #  eq '$'
				or  (($ast->[$idx][0] & 0xF) == 1) # eq '&'
			) {
#				if ($ast->[$idx][0] eq '@' or $ast->[$idx][0] eq '&') {
				if (
				(($ast->[$idx][0] & 0xF) == 10) or 
				(($ast->[$idx][0] & 0xF) == 1) #eq '&'
				) {
					my $vars = get_vars_from_expression($ast->[$idx],{} );
					delete $vars->{$arg}; 
					$all_vars->{'Set'}={%{ $all_vars->{'Set'} },%{$vars}};
					if (
						($ast->[$idx][0] & 0xF) == 10 #eq '@'
					) {
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
		} elsif (
			($idx==0) &&
			(($ast->[$idx] & 0xF) == 2) #eq '$'
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
}

# if the expression is a sub call (or in fact just a comma-sep list), return the arguments and also all variables that are not arguments
# We can of course have duplication here, and also some of the args can be functions or expressions. 
# So we have Args that can be Scalar, Array, Sub, Expr or Const

sub get_args_vars_from_subcall {(my $ast)=@_;

	my $all_vars={'List'=>[],'Set'=>{} };
	my $args={'List'=>[],'Set'=>{}};
	
	if (scalar @{$ast} > 2 and scalar @{$ast->[2]}>0) {#			croak Dumper($ast);
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
				if ( 
					(($ast->[$idx][0] & 0xF) == 10) # eq '@' 
				or  (($ast->[$idx][0] & 0xF) == 2) #  eq '$'
				or  (($ast->[$idx][0] & 0xF) == 1) #  eq '&'
				) {
					if (
					(($ast->[$idx][0] & 0xF) == 10) #eq '@' 
					or (($ast->[$idx][0] & 0xF) == 1) #eq '&'
					) {
						my $vars = get_vars_from_expression($ast->[$idx],{} );
						delete $vars->{$arg}; 
						$all_vars->{'Set'}={%{ $all_vars->{'Set'} },%{$vars}};
						if (
							($ast->[$idx][0] & 0xF) == 10 #eq '@'
						) {
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
	        	 	$cloned_ast->[$i+2][1]= '*';#5+(($cloned_ast->[$i+2][1]>>4)<<4);# '*';
	        	}
	        	my $colon_code = 12+($Fortran::Expression::Evaluator::Parser::nodeId++<<4);
	            $elt = [$colon_code,'',$cloned_ast->[$i+2]];
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
	            next;
	        }
	        if (ref($cloned_ast->[$i+1]) eq 'ARRAY' and $cloned_ast->[$i+1][1] eq '_COLON_PRE_') {	            
	            if (defined $cloned_ast->[$i+2]) {
	            	my $colon_code = 12+($Fortran::Expression::Evaluator::Parser::nodeId++<<4);
	                $elt=[$colon_code, $elt,$cloned_ast->[$i+2]];#':'
	                if (ref($cloned_ast->[$i+2]) eq 'ARRAY' and $cloned_ast->[$i+2][1] eq '_STAR_') {
	                	$cloned_ast->[$i+2][1]= '*';#5;#+(($cloned_ast->[$i+2][1]>>4)<<4);# '*';
	                }
	            } else {
	            	my $colon_code = 12+($Fortran::Expression::Evaluator::Parser::nodeId++<<4);
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
	if ($new_ast->[1] eq '#dummy#' and ( ($new_ast->[2][0] & 0xF) == 13) ) {#  '//'
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
	        	my $concat_code =  13+($Fortran::Expression::Evaluator::Parser::nodeId++<<4);
	            $elt = [$concat_code,$cloned_ast->[$i+2]];#'//'
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
#	            $cloned_ast->[$i+2]=undef;
	            next;
	        }
	        if (ref($cloned_ast->[$i+1]) eq 'ARRAY' and $cloned_ast->[$i+1][1] eq '_CONCAT_PRE_') {
	        	my $concat_code =  13+($Fortran::Expression::Evaluator::Parser::nodeId++<<4);
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
	        	my $dpar_code =  14+($Fortran::Expression::Evaluator::Parser::nodeId++<<4);
	            $elt = [$dpar_code,$cloned_ast->[$i+2]];# ')('
	            push @{$new_ast}, $elt;
	            $cloned_ast->[$i+1]=undef;
#	            $cloned_ast->[$i+2]=undef;
	            next;
	        }
	        if (ref($cloned_ast->[$i+1]) eq 'ARRAY' and $cloned_ast->[$i+1][1] eq '_PAREN_PAIR_') {
	        	my $dpar_code =  14+($Fortran::Expression::Evaluator::Parser::nodeId++<<4);
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

# I think I should probably return a flag to say that the AST contains function calls. If this is not the case there's no point in calling the _change_func_to_array
sub parse_expression_faster {(my $str)=@_;
    my $max_lev=11; # levels of precedence
    my $prev_lev=0;
    my $lev=0;
    # Let's try an array first
    my @ast=();
    my $op;
    my $state=0;

    my $expr_ast=[];
    my $arg_expr_ast=[];
    my $has_funcs=0;
    
    while (length($str)>0) {
#    	say "STR: $str";
        if ($str=~/^\s/) {
            $str=~s/^\s+//;
        }
        if ($state==0 or $state==8) {
            $state+=4; # I guess this is cheaper than doing unless $state==8;
            # FIXME: handle prefix - 
            if ($str=~s/^([a-zA-Z_]\w*)\s*\(//) {
                # array access or function call
                my $var=$1;
#                say "ARRAY $var";
                $has_funcs=1;
                my $arg_expr_ast;
                if ($str!~/^\s*\)/) {
                    ($arg_expr_ast,$str, my $err, my $has_funcs2)=parse_expression_faster($str);
#                    say Dumper($arg_expr_ast);
                    if( ref($arg_expr_ast) ne 'ARRAY') {
                        $arg_expr_ast=[$arg_expr_ast];
                    };
                    $has_funcs||=$has_funcs2;
                } else {
                    $arg_expr_ast=[];
                }
#                $expr_ast=['&',$var,$arg_expr_ast];
                $expr_ast=[1,$var,$arg_expr_ast];
                if ($str=~/^\(/) {
                    (my $arg_expr_ast2,$str, my $err2,my $has_funcs2)=parse_expression_faster($str);
                    $expr_ast=[1, $var,[14,$arg_expr_ast,$arg_expr_ast2->[1]]];
                    #$expr_ast=['&',$var,[')(',$arg_expr_ast,$arg_expr_ast2->[1]]];
                    $has_funcs||=$has_funcs2;
                }

            }
            elsif ($str=~s/^\-\s*([a-zA-Z_]\w*)\s*\(//) {
                # array access or function call with prefix -
                my $var=$1;
                $has_funcs=1;
                my $arg_expr_ast;
                if ($str!~/^\s*\)/) {
                    ($arg_expr_ast,$str, my $err,my $has_funcs2)=parse_expression_faster($str);
                    if( ref($arg_expr_ast) ne 'ARRAY') {
                        $arg_expr_ast=[$arg_expr_ast];
                    };
                    $has_funcs||=$has_funcs2;
                } else {
                    $arg_expr_ast=[];
                }
                $expr_ast=[4,[1,$var,$arg_expr_ast]];
                if ($str=~/^\(/) {
                    (my $arg_expr_ast2,$str, my $err2,my $has_funcs2)=parse_expression_faster($str);
                    $expr_ast=[4,[1, $var,[14,$arg_expr_ast,$arg_expr_ast2->[1]]]];
                    $has_funcs||=$has_funcs2;
                }
            }           
            elsif ($str=~s/^\(//) {
                # paren expr, I use '{' as it appears not to be used.      
                ($expr_ast,$str, my $err,my $has_funcs2)=parse_expression_faster($str);
                $has_funcs||=$has_funcs2;
                #$expr_ast=['{',$expr_ast];
                $expr_ast=[0,$expr_ast];
                if($err) {return ($expr_ast,$str, 1,0);}
            }
            elsif ($str=~s/^\-\s*\(//) {
                # paren expr, I use '{' as it appears not to be used.      
                # FIXME: a prefix - will break this          
                ($expr_ast,$str, my $err,my $has_funcs2)=parse_expression_faster($str);
                $has_funcs||=$has_funcs2;
                #$expr_ast=['{',$expr_ast];
                $expr_ast=[4,[0,$expr_ast]];
                if($err) {return ($expr_ast,$str,1,0);}
            }            
            # Apparently Fortran allows '$' as a character in a variable name but I think I'll ignore that.
            # I allow _ as starting character because of the placeholders
            elsif ( $str=~s/^([a-zA-Z_]\w*)// ) {
                #variable
                $expr_ast=[2,$1];
                #$expr_ast=['$',$1];
            }
            # Exec decision: I don't handle prefix +
            elsif ( $str=~s/^\-\s*([a-zA-Z_]\w*)// ) {
                #variable
                $expr_ast=[4,[2,$1]];
                #$expr_ast=['$',$1];
            }            
            elsif ( $str=~s/^\.(true|false)\.// ) {
                #boolean constant
                $expr_ast=[29,'.'.$1.'.'];
                #$expr_ast='.'.$1.'.';
            }
            elsif ( $str=~s/^\.not\.\s*// ) {
                # logical not
                # This is just to skip everything and have a second round of term matching
                $state=8;
            }
            elsif ($str=~s/^([\-\+]?(?:\d*\.\d*|\d+)(?:[edq][\-\+]?\d+)?)//) {
#                say "REAL: $1";
                #reals
                $expr_ast=[28,$1];
                #$expr_ast=$1;
            }
            elsif ($str=~s/^([\+\-\*]?\d+)//) {
                #integers
                # The '*' is for "alternate returns", a bizarre F77 feature. 
                # I've just added it because it is free
                $expr_ast=[27,$1];
                #$expr_ast=$1;#['integer',$1];
            }
            
            # Maybe I should handle string constants as well
            # Although we use placeholders so they should not occur
            elsif ( $str=~s/^\'(.+?)\'// ) {
                #boolean constant
                $expr_ast=[30,"'".$1."'"];
                #$expr_ast="'".$1."'";
            }
            #            say "parsed term $expr_ast, rest: $str";
            else {          
                # Here we return with an error value
                return ($expr_ast, $str, 1,0);
            }
            if ($state==12) {
                 $expr_ast=[21,$expr_ast];
                 #$expr_ast=['.not.',$expr_ast];
                 $state=4;
            }
            
        }
        if ($str=~/^\s/) {
            $str=~s/^\s+//;
        }
        if (length($str)==0) {
            last;
        }
        if ($state==4) {
            #say "STATE:4";
            if ($str=~s/^,//) { # comma
                # just set a state here
                $state=6;

            }
            elsif ($str=~s/^\)//) { # closing paren
            # Again this is like falling off the end of the string
            # if  @{$arg_expr_ast} is not empty, then this must become the ast to return
            # after appending the final value
                if ( @{$arg_expr_ast} ) {
                # Just set a state here
                     $state=7;
                }
            # otherwise it is quite the same as the end of the string
                else {
                    last;
                }
        } 
        else { 
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
    Relational
6        nonassoc    < > <= >= .lt. .gt. .le. .ge.
7        nonassoc    == != .eq. .ne. 
    Logical
8        right       .not.
9        left        .and. 
10        left        .or. 
11        left        .xor. .eqv. .neqv.

So it looks like I need at least 6 bits, so we'll need <<8 and 0xFF
                 0    1    2    3    4    5    6    7    8     9    10   11   12   13   14 
our @sigils = ( '{', '&', '$', '+', '-', '*', '/', '%', '**', '=', '@', '#', ':' ,'//',')('
                 15   16  17  18  19   20    21      22      23     24      25      26      
               ,'==','!=',<','>','<=','>=','.not.','.and.','.or.','.xor.','.eqv.','.neqv.'
                 27        28     29        30 
               ,'integer','real','logical','character'
              );
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
#                $op='*';
                 $op=5;
            }
            elsif ($str=~s/^\/\///) {
                $lev=5;
#                $op='//';
                 $op=13;
            } 
            elsif ($str=~s/^://) {
                $lev=5;
#                $op=':';
                $op=12;
            } 
            elsif ($str=~s/^\///) {
                $lev=3;
#                $op='/';
                $op=6;
            } 
            elsif ($str=~s/^>=// || $str=~s/^\.ge\.//) {
                $lev=6;
#                $op='>=';
                $op=20;
            } 
            elsif ($str=~s/^<=// || $str=~s/^\.le\.//) {
                $lev=6;
#                $op='<=';
                $op=19;
            } 
            elsif ($str=~s/^<// || $str=~s/^\.lt\.//) {
                $lev=6;
#                $op='<';
                $op=17;
            } 
            elsif ($str=~s/^>// || $str=~s/^\.gt\.//) {
                $lev=6;
#                $op='>';
                $op=18;
            } 
            elsif ($str=~s/^==// || $str=~s/^\.eq\.//) {
                $lev=7;
#                $op='==';
                $op=15;
            } 
            elsif ($str=~s/^\!=// || $str=~s/^\.ne\.//) {
                $lev=7;
#                $op='!=';
                $op=16;
            } 
            elsif ($str=~s/^\.and.//) {
                $lev=9;
#                $op='.and.';
                $op=22;
            } 
            elsif ($str=~s/^\.or.//) {
                $lev=10;
#                $op='.or.';
                $op=23;
            } 
            elsif ($str=~s/^\.xor.//) {
                $lev=11;
#                $op='.xor.';
                $op=24;
            } 
            elsif ($str=~s/^\.eqv.//) {
                $lev=11;
#                $op='.eqv.';
                $op=25;
            } 
            elsif ($str=~s/^\.neqv.//) {
                $lev=11;
#                $op='.neqv.';
                 $op=26;
            } 
            $state=5;
        }
    }

    if ($state==5 ) {
        #append
        if ($prev_lev==0) { # start
            $ast[$lev]=[$op,$expr_ast];
        } elsif ($prev_lev<$lev) { # '*' < '+'
            push @{$ast[$prev_lev]},$expr_ast;
            if (not defined $ast[$lev]) {
                $ast[$lev]=$ast[$prev_lev];
            } else {
                push @{$ast[$lev]}, $ast[$prev_lev];
            }
            undef $ast[$prev_lev];#=[];
            $ast[$lev] = [$op, $ast[$lev]];
        } elsif ($prev_lev>$lev) {
            $ast[$lev]=[$op, $expr_ast];
        } elsif ($lev==$prev_lev) {
            push @{$ast[$lev]},$expr_ast;
            $ast[$lev]=[$op, $ast[$lev]];
        }
        $state=0;
    } elsif ($state == 6 or $state==7) {
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
                    # Now we should return this as the ast
#                    return ([',',$arg_expr_ast],$str,0);
                    return ([31,$arg_expr_ast],$str,0,$has_funcs);
                } 
            }
    } # while

    # So when we fall off the end of the string we need to clean up
    # The main thing is that there is a $expr_ast pending
    # This has to be added to the last ast we were working on, which means
    if ( not defined $ast[$lev]) {
        $ast[$lev] = $expr_ast;
    } else {
        push @{$ast[$lev]}, $expr_ast;
     }
    
    # Now determine the highest level; fold the lower levels into it
    if( scalar @ast == 1) {
        return ($ast[0],$str,0,$has_funcs);
    } else {
    my $max_lev=11;
    for my $tlev (1 .. $max_lev) {
        if (not defined $ast[$tlev+1]) {
            $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
        } else {
            push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
        }
    }
    return ($ast[$max_lev+1],$str,0,$has_funcs);
    }
} # END of parse_expression_faster

sub interpret { (my $ast)=@_;
    if (scalar @{$ast}==3) {
    (my $opcode, my $lexp, my $rexp) =@{$ast};
    my $lv = (ref($lexp) eq 'ARRAY') ? interpret($lexp) : $lexp;
    my $rv = (ref($rexp) eq 'ARRAY') ? interpret($rexp) : $rexp;
    my $op=$sigils[$opcode];
    return eval("$lv $op $rv");
} elsif (scalar @{$ast}==2) { 
    (my $op, my $exp) =@{$ast};
    if ($op == 0) { # {
        my $v = (ref($exp) eq 'ARRAY') ? interpret($exp) : $exp;
        return $v;
    } elsif ($op == 2 or $op>26) {
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
#   say Dumper($ast);
    if (ref($ast) eq 'ARRAY') {
    if (scalar @{$ast}==3) {
        if ($ast->[0] ==1) { # '&' array access or function call
            (my $sigil, my $name, my $args) =@{$ast};
            if ($args->[0] != 14 ) { # ')('
                my @args_lst=();
                if($args->[0] == 31) { # ','
                    for my $arg (@{$args->[1]}) {
                        push @args_lst, emit_expr_from_ast($arg);
                    }
                    return "$name(".join(',',@args_lst).')';
                } else {
                    return "$name(".emit_expr_from_ast($args).')';
                }
            } else { # f(x)(y)
                #say Dumper($args);
                (my $sigil,my $args1, my $args2) = @{$args};
                my $args_str1='';
                my $args_str2='';
                if($args1->[0] == 31) { #eq ','
                my @args_lst1=();
                for my $arg (@{$args1->[1]}) {
                    push @args_lst1, emit_expr_from_ast($arg);
                }
                $args_str1=join(',',@args_lst1);

            } else {
                $args_str1= emit_expr_from_ast($args1);
            }
                if($args2->[0] == 31) { #eq ','
                    #say Dumper($args2);
                my @args_lst2=();
                for my $arg (@{$args2->[1]}) {
                    push @args_lst2, emit_expr_from_ast($arg);
                }
                $args_str2=join(',',@args_lst2);
            } else {
                $args_str2=emit_expr_from_ast($args2);
            }
                return "$name(".$args_str1.')('.$args_str2.')';
            }
        } else {
    (my $opcode, my $lexp, my $rexp) =@{$ast};
    my $lv = (ref($lexp) eq 'ARRAY') ? emit_expr_from_ast($lexp) : $lexp;
    my $rv = (ref($rexp) eq 'ARRAY') ? emit_expr_from_ast($rexp) : $rexp;
    return $lv.$sigils[$opcode].$rv;
    }
} elsif (scalar @{$ast}==2) { #  for '{'  and '$'
    (my $opcode, my $exp) =@{$ast};
    if ($opcode==0 ) {#eq '{'
        my $v = (ref($exp) eq 'ARRAY') ? emit_expr_from_ast($exp) : $exp;
        return "($v)";
    } elsif ($opcode==2 or $opcode>26) {# eq '$'
            return $exp;
    } elsif ($opcode == 21 or $opcode == 4) {# eq '.not.' '-'
        my $v = (ref($exp) eq 'ARRAY') ? emit_expr_from_ast($exp) : $exp;
            return $sigils[$opcode]. $v;
    } else {
        die 'BOOM! '.Dumper($ast).$opcode;
    }
} 
} else {return $ast;}
} # END of emit_expr_from_ast

1;

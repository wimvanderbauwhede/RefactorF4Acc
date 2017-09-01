package RefactorF4Acc::Analysis::IdentifyStencils;
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
use RefactorF4Acc::Refactoring::Subroutines qw( emit_subroutine_sig );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
use RefactorF4Acc::Parser::Expressions qw(
	parse_expression
	emit_expression
	get_vars_from_expression
	);

# 
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Analysis::IdentifyStencils::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::IdentifyStencils::EXPORT_OK = qw(
&pass_identify_stencils
);

=info
Pass to determine stencils in map/reduce subroutines
Because of their nature we don't even need to analyse loops: the loop variables and bounds have already been determined.
So, for every line we check
If it is an assignment, a subroutine call or a condition in and If or Case, we go on
But in the kernels we don't have subroutines at the moment. We also don't have Case I think
If assignment, we separate LHS and RHS
If subcall, we separate In/Out/InOut
If cond, it is a read expression

In each of these we get the AST and hunt for arrays. This is easy but would be easier if we had an 'everywhere' or 'everything' function

We have `get_args_vars_from_expression` and `get_vars_from_expression` and we can grep these for arrays

=cut

sub pass_identify_stencils {(my $stref)=@_;
	$stref = pass_wrapper_subs_in_module($stref,
			[
#				[ sub { (my $stref, my $f)=@_;  alias_ordered_set($stref,$f,'DeclaredOrigArgs','DeclaredOrigArgs'); } ],
		  		[
			  		\&_identify_array_accesses_in_exprs,
				],
			]
		);			

	return $stref;
}

sub _identify_array_accesses_in_exprs { (my $stref, my $f) = @_;

	my $pass_identify_array_accesses_in_exprs = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		if ( exists $info->{'Signature'} ) {
			my $subname =$info->{'Signature'}{'Name'} ; 
			say  "\n".$subname ;
			$state->{'CurrentSub'}= $subname  ;
			$state->{'Subroutines'}{$subname }={};
#			die if  $subname  eq 'bondv1_map_107';
		}
		if (exists $info->{'Assignment'} ) {
			if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' and $info->{'Lhs'}{'VarName'} =~/^(\w+)_range/) {
				my $loop_iter=$1;
				 
				my $expr_str = emit_expression($info->{'Rhs'}{'ExpressionAST'},'');
				my $loop_range = eval($expr_str);
				$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'LoopIters'}{$loop_iter}={'Range' => $loop_range};
				say "$loop_iter: $loop_range";
					
			} else {				
				# Find all array accesses in the RHS AST.
				(my $ast, $state) = _find_array_access_in_ast($stref, $f,  $state, $info->{'Rhs'}{'ExpressionAST'});
			}			
			
						
		} 
#		if (exists $info->{'If'} ) {					
#			my $cond_expr_ast = $info->{'CondExecExprAST'};
#			# Rename all array accesses in the AST. This updates $state->{'StreamVars'}			
#			(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $cond_expr_ast, 'In');			
#			$info->{'CondExecExpr'}=$ast;
#			for my $var ( @{ $info->{'CondVars'}{'List'} } ) {
#				next if $var eq '_OPEN_PAR_';
#				if ($info->{'CondVars'}{'Set'}{$var}{'Type'} eq 'Array' and exists $info->{'CondVars'}{'Set'}{$var}{'IndexVars'}) {					
#					$state->{'IndexVars'}={ %{ $state->{'IndexVars'} }, %{ $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} } }
#				}
#			}
#				 if (ref($ast) ne '') {
#				my $vars=get_vars_from_expression($ast,{}) ;
#
#				$info->{'CondVars'}{'Set'}=$vars;
#				$info->{'CondVars'}{'List'}= [ grep {$_ ne 'IndexVars' and $_ ne '_OPEN_PAR_' } sort keys %{$vars} ];
#				 } else {
#				 	$info->{'CondVars'}={'List'=>[],'Set'=>{}};
#				 }
#			
#						
#		}
		return ([[$line,$info]],$state);
	};

	my $state = {'CurrentSub'=>'', 'Subroutines'=>{}};
 	($stref,$state) = stateful_pass($stref,$f,$pass_identify_array_accesses_in_exprs, $state,'pass_identify_array_accesses_in_exprs ' . __LINE__  ) ;
 	say Dumper($state->{'Subroutines'});
 	return $stref;	
} # END of _identify_array_accesses_in_exprs()




=info2
#  u(i-1,j+1,1)
#  
#  (i+i_off,j+j_off,k+k_off) => 
#  idx = i*use_i + i_range*j*use_j+i_range*k_range*k*use_k
#  idx_off = i_off + i_range*j_off + i_range*k_range*k_off
#  
#  if i, j or k is a constant then use_* is set to 0
	my @ast_a = @{$ast};
	my @args = @ast_a[2 .. $#ast_a]; 
	for my $idx (0 .. @args-1) {
  		my $item = $args[$idx];
  if (ref($item) eq 'ARRAY') {
  if ($item->[0] eq '$') {
  		# means this access has 0 offset
  		if (exists $state->{'LoopIters'}{ $item->[1] }) {
  			push @{$state->{'LoopIters'}{ $item->[1] }{'Offsets'}},0;
  			push @{$state->{'LoopIters'}{ $item->[1] }{'Used'}},1;
  		} else {
  			say 'UNKNOWN INDEX: '.Dumper($item);
  		}
  } elsif ($item->[0] eq '+') {
  	
  	
  	
  	} else {
  		say 'WHAT? '.Dumper($item);
  	}
  } else { # must be a const
  	# problem is, to which loop iter does it belong?
  	e.g. (1,j,k) (i,1,k) (i,j,1)
  	e.g. (1,2,k) (2,1,k) (i,2,1)
  	So we need some code to determine the ordering. Assuming we have that then we say:
  	my $loop_iters_order = $state->{'LoopItersOrder'}
  	my $iter =  $loop_iters_order->[$idx]
  			push @{$state->{'LoopIters'}{ $iter }{'Offsets'}},0;
  			push @{$state->{'LoopIters'}{ $iter }{'Used'}},1;
  	
  }
  
  
  $VAR1 = [
  '@',
  'u',
  [
    '+',
    [
      '$',
      'i'
    ],
    [
      '-',
      '1'
    ]
  ],
  [
    '+',
    [
      '$',
      'j'
    ],
    '1'
  ],
  '1'
];

So every stencil is identified by offset &  used for each of its iters 
v => { i => {offset, used}, j => ... }

=cut
# ============================================================================================================
sub _find_array_access_in_ast { (my $stref, my $f,  my $state, my $ast)=@_;
	if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {		
			my $entry = $ast->[$idx];
	
			if (ref($entry) eq 'ARRAY') {
				(my $entry, $state) = _find_array_access_in_ast($stref,$f, $state,$entry);
				$ast->[$idx] = $entry;
			} else {
				if ($entry eq '@') {				
					my $mvar = $ast->[$idx+1];
					if ($mvar ne '_OPEN_PAR_') {
						
						my $expr_str = emit_expression($ast,'');
						say '  '.$expr_str;#."\n"  . Dumper($ast);
						$state = determine_stencil_from_access($stref,$ast, $state);
						last;
					}
				} 
			}		
		}
	}
	return  ($ast, $state);	
	
}



sub determine_stencil_from_access { (my $stref, my $ast, my $state)=@_;
	my @ast_a = @{$ast};
	my @args = @ast_a[2 .. $#ast_a]; 
	my $var = $ast_a[1];
	my $loop_iters_order = ['i','j','k'] ;# $state->{'LoopItersOrder'}; FIXME!	  		
	my @stencil=();
	for my $idx (0 .. @args-1) {
#		say "IDX: $idx";
  		my $item = $args[$idx];
  		my $iter =  $loop_iters_order->[$idx];	
  		my $offset=0;  		
  		# The expression for this index is an array
  		if (ref($item) eq 'ARRAY') {
  			if ($item->[0] eq '$') {
		  		# means this access has 0 offset
		  		my $miter = $item->[1];		  		
		  		if (exists $state->{'Subroutines'}{ $state->{'CurrentSub'} }{'LoopIters'}{ $miter }) {
					$iter = $miter;		  			
#		  			push @{$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$var}{ $iter }{'Offsets'}},0;
#		  			push @{$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$var}{ $iter }{'Used'}},1;
#		  			say "stencil: $iter 1 0";
		  			$stencil[$idx]="$iter 1 0"
		  		} else {
		  			my $f = $state->{'CurrentSub'};
		  			 if (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$item->[1])) {
		  			 	my $parname=$item->[1];
		  			 	my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$parname);
#		  			 	say "Parameter $parname = ".$decl->{'Val'};
		  			 	$offset=$decl->{'Val'}*1;
#				  		push @{$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$var}{ $iter }{'Offsets'}},$item;
#				  		push @{$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$var}{ $iter }{'Used'}},0;  	
#		  			 	say "stencil: $iter 0 $offset";
		  			 	$stencil[$idx]="$iter 0 $offset"
		  			 } else {
		  				say 'UNKNOWN INDEX: '.Dumper($item); 	
		  			 }
		  		}
		  	} elsif ($item->[0] eq '+') {
		  		# FIXME: this is weak because we could of course in principle have arbitrarily deeply nested expressions!
		  		# So I guess we need a proper recursive algorithm here.
		  		# this means there is a proper offset
#		  		$iter='';
		  		for my $idx (1 .. scalar @{$item} -1) {
		  		# get the iter
		  			if (ref($item->[$idx]) eq 'ARRAY' and $item->[$idx][0] eq '$') {		  				
		  				my $miter = $item->[$idx][1];
				  		if (exists $state->{'Subroutines'}{ $state->{'CurrentSub'} }{'LoopIters'}{ $miter }) {
				  			$iter = $miter;				  			
#				  			push @{$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$var}{ $iter }{'Used'}},1;
				  		} else {
		  					my $f = $state->{'CurrentSub'};
		  			 		if (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$item->[$idx][1])) {
				  				my $parname=$item->[$idx][1];
				  				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$parname);
#				  				say "Parameter $parname = ".$decl->{'Val'};
				  				$offset+=$decl->{'Val'}*1;
				  			} else {
				  				say 'UNKNOWN INDEX (+): '.Dumper($item); 	
				  			}	
				  		}			  		
	  				}
	  			}
		  	
	  			
		  		for my $idx (1 .. scalar @{$item} -1) {
		  		# get the offset
			  		if (ref($item->[$idx]) eq 'ARRAY' ) {
			  			if( $item->[$idx][0] eq '-') {
			  				 $offset += -1*$item->[$idx][1];
			  			} elsif  ($item->[$idx][0] ne '$') {
			  				# if it is a $ we've already processed it I guess
			  			say "UNEXPECTED OP ".$item->[$idx][0] ;
			  			}
			  		} else {
			  			$offset += $item->[$idx];
			  		}
		  		}
#		  		push @{$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$var}{ $iter }{'Offsets'}},$offset;
#		  		say "stencil: $iter 1 $offset";
		  		$stencil[$idx]="$iter 1 $offset";
		  	} else {
		  		say 'WHAT? '.Dumper($item);
		  	}
		  } else { # must be a const
	  	# problem is, to which loop iter does it belong?
	#  	e.g. (1,j,k) (i,1,k) (i,j,1)
	#  	e.g. (1,2,k) (2,1,k) (i,2,1)
	#  	So we need some code to determine the ordering. Assuming we have that then we say:

#	  		push @{$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$var}{ $iter }{'Offsets'}},$item;
#	  		push @{$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$var}{ $iter }{'Used'}},0;  	
#	  		say "stencil: $iter 0 $item";
	  		$stencil[$idx]="$iter 0 $item";
	  	}
	}
	my $stencil=  join('_',@stencil);
	$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$var}{'Stencils'}{$stencil}=1;
	return $state;
}

=info3

In a first pass we try to get the iter order.
We look at the number of dimensions in the array, purely from the access
We see if there is an occurence of any of the declared iters in the array access
That gives us something like
u(const,j,k) so we know now that 0 => const 1 => j, 2 => k,
p(const, i,j,k)  so we know now that 0 => const 1 => i, 2 => j, 3 => k

Main question is: do we need this? Why not simply set the iters to 0 and evaluate the expression to get the offset?
Answer: because we need to know if this offset is to be added to the iter or not, e.g.

u(0,j,k) and u(1,j,k+1) would give stencils (0,0,0) and (1,0,1) but it is NOT i,j,k and i+1,j,k+1 
So I need to be able to distinguish constant access from iterator access. Once that his done we can express the stencil as (Offset,isConst) for every dimension, by index.

But suppose something like u(i,j,k) = u(1,j,k)+u(i,1,k) then thar results in ((1,const),(0,j),(0,k)) and ((0,i),(1,const),(0,k))
That is OK: the necessary information is there.
So in short: per index: 
- find iters, if not set to ''
- replace iter with 0 and consts with their values
- eval the expr and use as offset


=cut

# We replace LoopIters with 0 and Parameters with their values.
sub _replace_consts_in_ast { (my $stref, my $f,  my $state, my $ast)=@_;
	if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {		
			my $entry = $ast->[$idx];
	
			if (ref($entry) eq 'ARRAY') {
				(my $entry, $state) = _replace_consts_in_ast($stref,$f, $state,$entry);
				$ast->[$idx] = $entry;
			} else {
				if ($entry eq '$') {				
					my $mvar = $ast->[$idx+1];					
					if (exists $state->{'Subroutines'}{ $state->{'CurrentSub'} }{'LoopIters'}{ $mvar }) {
					$ast='0';
					} elsif (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$mvar)) {				  				
				  				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$mvar);
#				  				say "Parameter $parname = ".$decl->{'Val'};
				  				my $val = $decl->{'Val'};
				  				$ast=$val;						
					}					
				} 
			}		
		}
	}
	return  ($ast, $state);		
}
1;
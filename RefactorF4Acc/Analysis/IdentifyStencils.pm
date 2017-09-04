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


=info20170903
What we have now is for every array used in a subroutine, a set of all stencils with an indication if an access is constant or an offset from a given iterator.

Now we have two use cases, one is OpenCL pipes and the other is TyTraCL
For the stencils where all accesses use an iterator we have

vs = stencil patt v
v' = map f vs

There are two other main use cases

1/ LHS and RHS are both partial, i.e. one or more index is constant.
We can check this by comparing the Read and Write arrays. For TyTraCL I think we want to generate code that will apply the map to the accessed ranges and keep the old values for the rest.
But I think this still means we have to buffer: if e.g. we have

v(0)=v(10)
v(1) .. v(8) unchanged
v(9)=v(1)
v(10) unchanged

then we need to construct a stream which reorders, so we'll have to buffer the stream until in this example we reach 10. That is not hard.
 Furthermore, we need to write the partial ranges out to this stream in order of access. 
 As the stream is characterised by offsets, ranges and constants, this should be possible, but it is not trivial!
 
 For example
 
              u(ip,j,k) = u(ip,j,k)-dt*uout *(u(ip,j,k)-u(ip-1,j,k))/dxs(ip)
              v(ip+1,j,k) = v(ip+1,j,k)-dt*uout *(v(ip+1,j,k)-v(ip,j,k))/dxs(ip)
              w(ip+1,j,k) = w(ip+1,j,k)-dt*uout *(w(ip+1,j,k)-w(ip,j,k))/dxs(ip)   

so we have 
u
Write: [?,j,k] => [ip,0,0]
Read: [?,j,k] => [ip,0,0],[ip-1,0,0]

and
i: 0 :(ip + 1)
j: -1:(jp + 1)
k: 0 :(kp + 1)

So 
if (i==ip) then
	! apply the old code, but a stream - scalar value of it	
	u(ip,j,k) = u(ip,j,k)-dt*uout *(u(ip,j,k)-u(ip-1,j,k))/dxs(ip)	
else
	! keep the old value
	u(i,j,k) = u(i,j,k)
end if

So I guess what we do is, we create a tuple:

u_ip_j_k, u_ipm1_j_k, u_i_j_k

To do so, we need to identify the buffer, i.e. points within the range
i: ip, ip-1 => this is a 2-point stencil  
j: -1:(jp + 1)
k: 0 :(kp + 1)

Actually, by far the easiest solution would be to create this buffer and access it in non-streaming fashion. 
The key problem however is that the rest of the stream can't be buffered in the meanwhile.

2/ LHS is full and RHS is partial, i.e. one or more index is constant on RHS. This means we need to replicate the accesses. But in fact, random access as in case 1/ is probably best.

In both cases, we need to express this someway in TyTraCL, and I think I will use `select` and `replicate` to do this.

The unsolved question here is: if I do a "select"  I get a smaller 1-D list. So in case 1/ I apply this list to a part of the original list, but the question is: which part?
To give a simple example on a 4x4 array I select a column
[0,4,8,12] and I want to apply this to either to the bottom row [12,13,14,15] or the 2nd col [1,5,9,13] of the original list.
We could do this via an operation `insert` 

	insert target_pattern small_list target_list
	
Question is then where we get the target pattern, but I guess a start/stop/step should do:

for i in [0 .. 3]
	v1[i+12] = v_small[i]
	v2[i*4+1] = v_small[i]	
end
 
This means for the select we had the opposite:

for i in [0 .. 3]
	v_small[i] = v[i*4+0]	  
end

Finally I am a bit unsure about replication because I have a feeling that there might be cases where we need to interleave, i.e. for example rather than creating

[0,4,8,12,0,4,8,12,0,4,8,12,...]

we have to create

[0,0,0,...,4,4,4,...,8,8,8,...,12,12,12,...]


A possible simplifying case is by applying replicate on a by-elt basis:

replicate v n 
map (\elt -> replicate elt n) v

This could be good enough, but I need to work out how it relates to the actual assignement pattern.

for i in ...
	for j in ...
		for k in ...
			v(i,j,k) = v(a_i*i+b_i, a_j*j+b_j,k_const) 


=cut


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
if ($f!~/superkernel/) {
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
			if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' and $info->{'Lhs'}{'VarName'} =~/^(\w+)_rel/) {
				my $loop_iter=$1;
				$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'LoopIters'}{$loop_iter}={'Range' => 0};
			}
			if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' and $info->{'Lhs'}{'VarName'} =~/^(\w+)_range/) {
				my $loop_iter=$1;
				 
				my $expr_str = emit_expression($info->{'Rhs'}{'ExpressionAST'},'');
				my $loop_range = eval($expr_str);
				$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'LoopIters'}{$loop_iter}={'Range' => $loop_range};
#				say "$loop_iter: $loop_range";
					
			} else {				
				# Find all array accesses in the LHS and RHS AST.
				(my $rhs_ast, $state) = _find_array_access_in_ast($stref, $f,  $state, $info->{'Rhs'}{'ExpressionAST'},'Read');
				(my $lhs_ast, $state) = _find_array_access_in_ast($stref, $f,  $state, $info->{'Lhs'}{'ExpressionAST'},'Write');
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
}
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
sub _find_array_access_in_ast { (my $stref, my $f,  my $state, my $ast, my $rw)=@_;
	if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {		
			my $entry = $ast->[$idx];
	
			if (ref($entry) eq 'ARRAY') {
				(my $entry, $state) = _find_array_access_in_ast($stref,$f, $state,$entry, $rw);
				$ast->[$idx] = $entry;
			} else {
				if ($entry eq '@') {				
					my $mvar = $ast->[$idx+1];
					if ($mvar ne '_OPEN_PAR_') {
						
						my $expr_str = emit_expression($ast,'');
						say '  '.$expr_str;
#						$state = determine_stencil_from_access($stref,$ast, $state);
						$state = _find_iters_in_array_idx_expr($stref,$ast, $state,$rw);
						say Dumper($state);
						my $array_var = $ast->[1];
						if ($array_var =~/(glob|loc)al_/) { return ($ast,$state); }
#						# First we compute the offset
						(my $ast0,$state ) = _replace_consts_in_ast($stref,$ast, $state,0);
						my @ast_a0 = @{$ast0};						
						my @idx_args0 = @ast_a0[2 .. $#ast_a0]; 
						my @ast_exprs0 = map { emit_expression($_,'') } @idx_args0;
						my @ast_vals0 = map { eval($_) } @ast_exprs0;
						# Then we compute the multipliers (for proper stencils these are 1 but for the more general case e.g. copying a plane of a cube it can be different.
						(my $ast1,$state ) = _replace_consts_in_ast($stref,$ast, $state,1);
						my @ast_a1 = @{$ast1};
						my $array_var1 = $ast1->[1];
						my @idx_args1 = @ast_a1[2 .. $#ast_a1]; 
						my @ast_exprs1 = map { emit_expression($_,'') } @idx_args1;
						my @ast_vals1 = map { eval($_) } @ast_exprs1;
						
						my @iters = @{$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$array_var}{$rw}{'Iterators'}};
						say Dumper(@iters,$ast);
						my $iter_val_pairs=[];						
						for my $idx (0 .. @iters-1) {
							my $offset_val=$ast_vals0[$idx];
							my $mult_val=$ast_vals1[$idx]-$offset_val;
							push @{$iter_val_pairs}, {$iters[$idx] => [$mult_val,$offset_val]};
						}   
						$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$array_var}{$rw}{'Stencils'}{ join(',', @ast_vals0) } = $iter_val_pairs;#[[@iters],[@ast_vals]];
#						say '    '.join(',',@ast_exprs).'  => '.join(',',@ast_vals);
#						say '    '.join(',',@ast_vals); 
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
- find iters, if not set to '' => is this per sub or per expr? Let's start per expr.
- replace iter with 0 and consts with their values
- eval the expr and use as offset


=cut

# We replace LoopIters with 0 and Parameters with their values.
# Apply to RHS of assignments
sub _replace_consts_in_ast { (my $stref,  my $ast, my $state, my $const)=@_;
	my $f = $state->{'CurrentSub'};
#	say '_replace_consts_in_ast'; 
#	say Dumper($ast);
	if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {								
			my $entry = $ast->[$idx];	
			
			if (ref($entry) eq 'ARRAY') {
				(my $entry2, $state) = _replace_consts_in_ast($stref, $entry, $state,$const);
				$ast->[$idx] = $entry2;
			} else {
				if ($entry eq '$') {				
					my $mvar = $ast->[$idx+1];					
					if (exists $state->{'Subroutines'}{ $f }{'LoopIters'}{ $mvar }) {
						$ast=$const;
						return ($ast,$state);
					} elsif (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$mvar)) {				  				
		  				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$mvar);
#				  		say "Parameter $parname = ".$decl->{'Val'};
		  				my $val = $decl->{'Val'};
		  				$ast=$val;
		  				return ($ast,$state);						
					}	
									
				} 
			}		
		}
	}
	return  ($ast, $state);		
} # END of _replace_consts_in_ast()


sub _find_iters_in_array_idx_expr { (my $stref, my $ast, my $state, my $rw)=@_;
	my @ast_a = @{$ast};
	my @args = @ast_a[2 .. $#ast_a]; 
	my $array_var = $ast_a[1];
	$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$array_var}{$rw}{'Iterators'}=[];
	for my $idx (0 .. @args-1) {
		$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$array_var}{$rw}{'Iterators'}[$idx]='?';
  		my $item = $args[$idx];
  		say "EXPR:".emit_expression($item,'');
  		my $vars = get_vars_from_expression($item, {});
  		say 'VARS:'.Dumper($vars);
  		for my $var (keys %{$vars}) {
  			if (exists $state->{'Subroutines'}{ $state->{'CurrentSub'} }{'LoopIters'}{ $var }) {
  				# OK, I found an iterator in this index expression. I boldly assume there is only one.
  				say "Found iterator $var at index $idx for $array_var access";
  				$state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$array_var}{$rw}{'Iterators'}[$idx]=$var;
  			}
  		}
	}
#	say '    '.'['.join(',', @{ $state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$array_var}{$rw}{'Iterators'} }).']';
	return $state;
} # END of _find_iters_in_array_idx_expr

1;
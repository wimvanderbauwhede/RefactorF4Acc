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

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;
use Storable qw( dclone );

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


So the question is, how do we express this using `select` ?


for i in 0 .. im-1
	for j in 0 .. jm-1
		for k in 0 .. km-1
			v(i,j,k) = v(a_i*i+b_i, a_j*j_const+b_j,k)
			
Well, it is very easy:

-- selection can work like this
select patt v = map (\idx -> v !! idx) patt

v' = select [ i*jm*km+j*km+k_const | i <- [0 .. im-1],  j <- [0 .. jm-1], k <- [0..km-1] ] v

Key questions of course are (1) if we can parallelise this, and (2) what the generated code looks like.
(1) Translates to: given v :: Vec n a -> v" :: Vec m Vec n/m a
Then what is the definition for select" such that

v"' = select" patt v" 

Is this possible in general? It *should* be possible, because what it means is that we only access the data present in each chunk.
The problem is that the index pattern is not localised, for example

v_rhs1 = select [ i*jm*km+j*km+k_const | i <- [0 .. im-1],  j <- [0 .. jm-1], k <- [0..km-1] ] v
v_rhs2 = select [ i*jm*km+j_const*km+k | i <- [0 .. im-1],  j <- [0 .. jm-1], k <- [0..km-1] ] v
v_rhs3 = select [ i_const*jm*km+j*km+k | i <- [0 .. im-1],  j <- [0 .. jm-1], k <- [0..km-1] ] v

So I guess we need to consider (2), how to generate the most efficient buffer for this.

The most important question to answer is: when is it a stencil, when a select, when both?

#* It is a stencil if:
#- there is more than one access to an array => 
#- at least one of these accesses has a non-zero offset
#- all points in the array are processed in order 
* It is a select if:
- not all points in the array are covered, let's say this means we have a '?'
(this ignores the fact that the bounds might not cover the array!)

So if we have a combination, then we can do either
- create a stencil, then select from it
- create multiple select expressions

Crucially, a stencil is only really a stencil if the LHS and the RHS parts have the same number of points. I'm not sure if this really matters.

In any case, what we want to know is: 
- is straight scalarisation OK for a given variable in a given subroutine
- which variables should become local arrays
- which variables need stencils
- which variables need select.

At the moment I simply say: 3-D => stream, so scalarise; 1-D => local ; 2-D: Flag!

=cut


=info
Pass to determine stencils in map/reduce subroutines
Because of their nature we don't even need to analyse loops: the loop variables and bounds have already been determined.
So, for every line we check:
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
	
	if ($stref->{'Subroutines'}{$f}{'Source'}=~/module_adam_bondv1_feedbf_les_press_v_etc_superkernel.f95/ && $f!~/superkernel/) {  # TODO
#		say  "\nRunning _identify_array_accesses_in_exprs($f)\n";
		say  "\n-- $f\n";
		my $pass_identify_array_accesses_in_exprs = sub { (my $annline, my $state)=@_;
			(my $line,my $info)=@{$annline};
			if ( exists $info->{'Signature'} ) {
				my $subname =$info->{'Signature'}{'Name'} ; 
#				say  "\n".$subname ;
				$state->{'CurrentSub'}= $subname  ;
				croak if $subname ne $f;
				$state->{'Subroutines'}{$subname }={};
	#			die if  $subname  eq 'bondv1_map_107';
			}
			if (exists $info->{'VarDecl'} and not exists $info->{'ParamDecl'} and $line=~/dimension/) { # Lazy			 	
				my $array_var=$info->{'VarDecl'}{'Name'};				
#				die Dumper($annline) if $array_var eq 'zbm';
				
				my @dims = @{ $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} };
				$state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{'Dims'}=[];
#				say @dims;
				for my $dim (@dims) {
					(my $lo, my $hi)=$dim=~/:/ ? split(/:/,$dim) : (1,$dim);
					my $dim_vals=[];
					for my $bound_expr_str ($lo,$hi) {
						my $dim_val=$bound_expr_str;
						if ($bound_expr_str=~/\W/) {
#							say "$dim => $lo,$hi";
							my $dim_ast=parse_expression($bound_expr_str,$info, $stref,$f);
							
				  			my $dim_ast2 = _replace_param_by_val($stref, $f, $dim_ast);
#							say Dumper($dim_ast);
#							say 'DIM_AST <'.Dumper($dim_ast2).'>';
#							(my $dim_ast2, my $state) = _replace_consts_in_ast($stref, $f,  $dim_ast, {'CurrentSub' =>$f}, 0);
							my $dim_expr=emit_expression($dim_ast2,'');
							$dim_val=eval($dim_expr);
						} else {
							# It is either a number or a var
							if (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$bound_expr_str)) {				  				
				  				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$bound_expr_str);
				  				my $dim_val = $decl->{'Val'};
				  				my $dim_ast=parse_expression($bound_expr_str,$info, $stref,$f);
#				  				$dim_ast = _replace_param_by_val($stref, $f, $dim_ast);
				  			my $dim_ast2 = _replace_param_by_val($stref, $f, $dim_ast);
#							say Dumper($dim_ast);
#							say 'DIM_AST (NUM/VAR) <'.Dumper($dim_ast2).'>';
#							(my $dim_ast2, my $state) = _replace_consts_in_ast($stref, $f,  $dim_ast, {'CurrentSub' =>$f}, 0);
							my $dim_expr=emit_expression($dim_ast2,'');
							$dim_val=eval($dim_expr);
				  				
				  				#FIXME: must check if this is not an expression in terms of other parameters!
				  				# So, 
				  				# - get Val
				  				# - see if it contains vars
				  				# - if so, substitute them using _replace_consts_in_ast
				  				# - check if the result is var-free, else repeat
				  				# - finally eval
							}
						}
						push @{$dim_vals},$dim_val;
					}
					push @{ $state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{'Dims'} },$dim_vals;
	#				say "$array_var
				}
#				die if $array_var eq 'zbm';
			}
			if (exists $info->{'Assignment'} ) {
				# Assignment to scalar *_rel 					
				if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' and $info->{'Lhs'}{'VarName'} =~/^(\w+)_rel/) {
					my $loop_iter=$1;
					$state->{'Subroutines'}{ $f }{'LoopIters'}{$loop_iter}={'Range' => 0};
				}
				# Assignment to scalar *_range 
				if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' and $info->{'Lhs'}{'VarName'} =~/^(\w+)_range/) {
					my $loop_iter=$1;
					 
					my $expr_str = emit_expression($info->{'Rhs'}{'ExpressionAST'},'');
					my $loop_range = eval($expr_str);
					$state->{'Subroutines'}{ $f }{'LoopIters'}{$loop_iter}={'Range' => $loop_range};
	#				say "$loop_iter: $loop_range";
						
				} else {				
					# Find all array accesses in the LHS and RHS AST.
					if ( 
						ref($info->{'Rhs'}{'ExpressionAST'}) eq 'ARRAY' 
					and $info->{'Rhs'}{'ExpressionAST'}[0] eq '@'
					and ref($info->{'Lhs'}{'ExpressionAST'}) eq 'ARRAY' 
					and $info->{'Lhs'}{'ExpressionAST'}[0] eq '@'
					and $info->{'Lhs'}{'ExpressionAST'}[1] eq $info->{'Rhs'}{'ExpressionAST'}[1]
					) {
						my $var_name = $info->{'Rhs'}{'ExpressionAST'}[1];
#						say "IDENTITY OP for $var_name : ",$line;
						$state->{'Subroutines'}{ $f }{'Identity'}{$var_name} = 1;
					} 
#else {
#						my $var_name = $info->{'Rhs'}{'ExpressionAST'}[1];
#						say "IDENTITY OP for $var_name : ",$line;
#						$state->{'Subroutines'}{ $f }{'Assignments'}{$var_name}{'Identity'} = 0;
#					}
					 
					(my $rhs_ast, $state) = _find_array_access_in_ast($stref, $f,  $state, $info->{'Rhs'}{'ExpressionAST'},'Read');
					(my $lhs_ast, $state) = _find_array_access_in_ast($stref, $f,  $state, $info->{'Lhs'}{'ExpressionAST'},'Write');
				}			
				my $var_name = $info->{'Lhs'}{'VarName'};
				if (not exists $state->{'Subroutines'}{ $f }{'Assignments'}{$var_name}) {
					$state->{'Subroutines'}{ $f }{'Assignments'}{$var_name}=[];
				} 
				push @{$state->{'Subroutines'}{ $f }{'Assignments'}{$var_name}}, $info->{'Rhs'}{'ExpressionAST'};							
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
	# 	say Dumper($state->{'Subroutines'});die;
		$state = _link_writes_to_reads( $stref, $f, $state);
#		say "LINKS:";
#		(my $out_tup, my $in_tup) = pp_links($state->{'Subroutines'}{$f}{'Links'});
#		my $map_expr = '('.join(',',@{$out_tup}).')';
#		$map_expr .= ' = map '.$f.' ';
#		$map_expr .= '('.join(',',@{$in_tup}).')';
#		say $map_expr; 
		$stref = _classify_accesses($stref, $f, $state);
		
	} # if subkernel not superkernel
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
#						say '  '.$expr_str;
#						$state = determine_stencil_from_access($stref,$f,$ast, $state);
						$state = _find_iters_in_array_idx_expr($stref,$f,$ast, $state,$rw);
#						say Dumper($state);
						my $array_var = $ast->[1];
						if ($array_var =~/(glob|loc)al_/) { return ($ast,$state); }
#						# First we compute the offset
#						say "OFFSET";
						my $ast0 = dclone($ast); 
						($ast0,$state ) = _replace_consts_in_ast($stref,$f,$ast0, $state,0);
						my @ast_a0 = @{$ast0};						
						my @idx_args0 = @ast_a0[2 .. $#ast_a0]; 
						my @ast_exprs0 = map { emit_expression($_,'') } @idx_args0;
						my @ast_vals0 = map { eval($_) } @ast_exprs0;
#						say Dumper($ast0);
						# Then we compute the multipliers (for proper stencils these are 1 but for the more general case e.g. copying a plane of a cube it can be different.
#						say "MULT";
						my $ast1 = dclone($ast); 
						($ast1,$state ) = _replace_consts_in_ast($stref,$f,$ast1, $state,1);
						my @ast_a1 = @{$ast1};
						my $array_var1 = $ast1->[1];
						my @idx_args1 = @ast_a1[2 .. $#ast_a1]; 
						my @ast_exprs1 = map { emit_expression($_,'') } @idx_args1;
						my @ast_vals1 = map { eval($_) } @ast_exprs1;
#						say Dumper($ast1);
						my @iters = @{$state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{$rw}{'Iterators'}};
#						say Dumper(@iters);
						my $iter_val_pairs=[];						
						for my $idx (0 .. @iters-1) {
							my $offset_val=$ast_vals0[$idx];
							my $mult_val=$ast_vals1[$idx]-$offset_val;
							push @{$iter_val_pairs}, {$iters[$idx] => [$mult_val,$offset_val]};
						}
						$state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{$rw}{'Exprs'}{$expr_str}=1;   
						$state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{$rw}{'Stencils'}{ join('', @ast_vals0) } = $iter_val_pairs;#[[@iters],[@ast_vals]];
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



sub _UNUSED_determine_stencil_from_access { (my $stref,my $f, my $ast, my $state)=@_;
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
		  		if (exists $state->{'Subroutines'}{ $f }{'LoopIters'}{ $miter }) {
					$iter = $miter;		  			
#		  			push @{$state->{'Subroutines'}{ $f }{'Arrays'}{$var}{ $iter }{'Offsets'}},0;
#		  			push @{$state->{'Subroutines'}{ $f }{'Arrays'}{$var}{ $iter }{'Used'}},1;
#		  			say "stencil: $iter 1 0";
		  			$stencil[$idx]="$iter 1 0"
		  		} else {
		  			
		  			 if (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$item->[1])) {
		  			 	my $parname=$item->[1];
		  			 	my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$parname);
#		  			 	say "Parameter $parname = ".$decl->{'Val'};
						# FIXME: Val could be an expression in terms of parameters so need to do this iteratively
		  			 	$offset=$decl->{'Val'}*1;
#				  		push @{$state->{'Subroutines'}{ $f }{'Arrays'}{$var}{ $iter }{'Offsets'}},$item;
#				  		push @{$state->{'Subroutines'}{ $f }{'Arrays'}{$var}{ $iter }{'Used'}},0;  	
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
				  		if (exists $state->{'Subroutines'}{ $f }{'LoopIters'}{ $miter }) {
				  			$iter = $miter;				  			
#				  			push @{$state->{'Subroutines'}{ $f }{'Arrays'}{$var}{ $iter }{'Used'}},1;
				  		} else {
#		  					my $f = $state->{'CurrentSub'};
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
#		  		push @{$state->{'Subroutines'}{ $f }{'Arrays'}{$var}{ $iter }{'Offsets'}},$offset;
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

#	  		push @{$state->{'Subroutines'}{ $f }{'Arrays'}{$var}{ $iter }{'Offsets'}},$item;
#	  		push @{$state->{'Subroutines'}{ $f }{'Arrays'}{$var}{ $iter }{'Used'}},0;  	
#	  		say "stencil: $iter 0 $item";
	  		$stencil[$idx]="$iter 0 $item";
	  	}
	}
	my $stencil=  join('_',@stencil);
	$state->{'Subroutines'}{ $f }{'Arrays'}{$var}{'Stencils'}{$stencil}=1;
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
sub _replace_consts_in_ast { (my $stref, my $f,  my $ast, my $state, my $const)=@_;
#	my $f = $state->{'CurrentSub'};
#	say '_replace_consts_in_ast'; 
#	say Dumper($ast);
	if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {								
			my $entry = $ast->[$idx];	
			
			if (ref($entry) eq 'ARRAY') {
				(my $entry2, $state) = _replace_consts_in_ast($stref,$f, $entry, $state,$const);
				$ast->[$idx] = $entry2;
			} else {
				if ($entry eq '$') {				
					my $mvar = $ast->[$idx+1];					
					if (exists $state->{'Subroutines'}{ $f }{'LoopIters'}{ $mvar }) {
#						say 'Replacing ['."'".'$'."'".','.$mvar.'] by '.$const;
						$ast=''.$const.'';
						return ($ast,$state);
					} elsif (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$mvar)) {				  				
		  				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$mvar);
		  				#FIXME: the value could be an expression in terms of other parameters!
#				  		say "Parameter $parname = ".$decl->{'Val'};
		  				my $val = $decl->{'Val'};
		  				$ast = parse_expression($val, {},$stref,$f);		  				
#		  				$ast=$val;
		  				return ($ast,$state);						
					}	
									
				} 
			}		
		}
	}
	return  ($ast, $state);		
} # END of _replace_consts_in_ast()


sub _find_iters_in_array_idx_expr { (my $stref, my $f, my $ast, my $state, my $rw)=@_;
	my @ast_a = @{$ast};
	my @args = @ast_a[2 .. $#ast_a]; 
	my $array_var = $ast_a[1];
	$state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{$rw}{'Iterators'}=[];
	for my $idx (0 .. @args-1) {
		$state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{$rw}{'Iterators'}[$idx]='?';
  		my $item = $args[$idx];
#  		say "EXPR:".emit_expression($item,'');
  		my $vars = get_vars_from_expression($item, {});
#  		say 'VARS:'.Dumper($vars);
  		for my $var (keys %{$vars}) {
  			if (exists $state->{'Subroutines'}{ $f }{'LoopIters'}{ $var }) {
  				# OK, I found an iterator in this index expression. I boldly assume there is only one.
#  				say "Found iterator $var at index $idx for $array_var access";
  				$state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{$rw}{'Iterators'}[$idx]=$var;
  			}
  		}
	}
#	say '    '.'['.join(',', @{ $state->{'Subroutines'}{ $state->{'CurrentSub'} }{'Arrays'}{$array_var}{$rw}{'Iterators'} }).']';
	return $state;
} # END of _find_iters_in_array_idx_expr

=info
So first we need to gather all assignments in the subroutine, i.e. in a separate, trivial pass
I think I'll put this in the $state as 'Assignments'}

	$assignments = { $var => $assign_expr }
	
The links table starts out empty:

	$links = {}	

=cut

sub _link_writes_to_reads {(my $stref, my $f, my $state)=@_;
	my $links={};
	my $assignments = $state->{'Subroutines'}{$f}{'Assignments'};
	# So we have to establish the link for every variable that is a multi-dim (effectively 3-D) array argument
	for my $some_var ( sort keys %{ $assignments }  ) {
		next if $some_var=~/_rel|_range/;
		$links = _link_writes_to_reads_rec($stref, $f, $some_var,$assignments,$links,$state);
	}
	
	$links = _collapse_links($stref,$f,$links);
	# Now remove anything that is not an array arg link
	for my $var (keys %{$links} ){
		
		if (not isArg($stref, $f, $var) ) {
			delete $links->{$var};
		} 

		for my $lvar (keys %{$links->{$var}} ){
			if ($links->{$var}{$lvar} > 2 or $lvar eq '_OPEN_PAR_') {
				delete $links->{$var}{$lvar};
			}			
		}
		if (
			scalar keys  %{ $links->{$var}} == 0 or  
			$var eq '_OPEN_PAR_' 			
		) {
				delete $links->{$var};
		}
	}

	$state->{'Subroutines'}{$f}{'Links'}=$links;
	return $state;			 				
} # END of _link_writes_to_reads()

sub _link_writes_to_reads_rec {(my $stref, my $f, my $some_var, my $assignments,my  $links, my $state)=@_;
 		my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Vars'},$some_var);
		my $lhs_dim = scalar @{ $decl->{'Dim'} };
		if (exists $assignments->{$some_var} ) {
			my $rhs_array = $assignments->{$some_var};
#			say Dumper($rhs); 
			my $vars = {};
			for my $rhs (@{ $rhs_array }) {
				my %tvars = %{ get_vars_from_expression($rhs,{}) };
				my %avars = _remove_index_vars($stref,$f,$state,\%tvars);
				$vars = {%{$vars},%avars };
			}
#			die Dumper($vars) if $f=~/116/ and exists $vars->{'i'};
			for my $var ( keys %{$vars} ) {				
				next if $var=~/_rel|_range/;
				next if exists $links->{$some_var}{$var};
#				next if $var eq $some_var;
				if (isArg($stref, $f, $var)) {
					# look up Dim for $var
					my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Args'},$var);			
					my $dim = scalar @{ $decl->{'Dim'} };			
					if ($dim>0 && $dim == $lhs_dim) { 
#						die "<$dim>" if $var eq 'pz' or $some_var eq 'pz';
#						say "LINK $some_var => $var";
						$links->{$some_var}{$var}=1;
					} else {
						$links->{$some_var}{$var}=2;
					#	this is an arg but it is not the right Dim, so ignore it
					}
				} else { # var not arg
#					say "VAR $var IS NOT ARG";					
					$links->{$some_var}{$var}=4 unless $var eq '_OPEN_PAR_';
					if (exists $assignments->{$var} ) {
						my $non_arg_rhs_array = $assignments->{$var};						
						my $rhs_vars = {};
						for my $non_arg_rhs (@{ $non_arg_rhs_array }) {
							my %tvars =  %{ get_vars_from_expression($non_arg_rhs,{}) };
							my %avars = _remove_index_vars($stref,$f,$state,\%tvars);							
							$rhs_vars = {%{$vars},%avars };
						}						
#						say Dumper($non_arg_rhs);
#						my $rhs_vars = get_vars_from_expression($non_arg_rhs,{});
						for my $rhs_var (keys %{$rhs_vars}) {	
#							say "VAR in RHS of NON-ARG assignment for $var: $rhs_var";
							next if exists $links->{$var}{$rhs_var};
							$links->{$var}{$rhs_var}= isArg($stref, $f, $rhs_var) ? 2 : 3 unless $rhs_var eq '_OPEN_PAR_';	 
#							next if $var eq $rhs_var;
			 				$links=_link_writes_to_reads_rec($stref, $f, $rhs_var,$assignments,$links,$state);
						}
					}
				}
			}
		}
 		return $links;
} # END of _link_writes_to_reads_rec()

sub isArg { (my $stref, my $f, my $array_var)=@_;
	
#if (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$bound_expr_str)) {				  				
#			  				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$bound_expr_str);
#			  				$dim_val = $decl->{'Val'};
#						}	
	if ( in_nested_set($stref->{'Subroutines'}{$f},'Args',$array_var)) {				  				
			  				return 1;			  							  	
			} else {
				return 0;
			}
}

sub _classify_accesses { (my $stref, my $f, my $state) =@_;
# 	say "SUB $f\n";
	my @extracts=();
 	my @inserts=();
	my %stencils=();		
	my %non_map_args=();
	my %portions=();
	if (not exists $stref->{'UniqueVarCounters'}) {
		$stref->{'UniqueVarCounters'}={};
	}
	my $unique_var_counters=$stref->{'UniqueVarCounters'};
	
 	for my $array_var (keys %{$state->{'Subroutines'}{ $f }{'Arrays'}}) {  
 		next if $array_var =~/^global_|^local_/; 		
 		next if not defined  $state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{'Dims'} ;
 		if (not exists $unique_var_counters->{$array_var}) {
 			$unique_var_counters->{$array_var}=0;
 		}
 		
 		if (scalar @{ $state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{'Dims'} } ==1 ) {
# 			non_map_args{
# 			say "$array_var 1-D"; 			 			
 		} elsif (scalar @{ $state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{'Dims'} } ==2 ) { 			
# 			say "$array_var 2-D";
# 			say Dumper($state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{'Dims'} );
 		} else {
 			
 		}
 		
 		for my $rw ('Read','Write') { 			  			
 			if (exists  $state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{$rw} ) {
 				# because it could be read-only and even write-only: v = u+w 				
 				my $n_accesses  =scalar keys %{$state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{$rw}{'Stencils'} } ;
 				my @non_zero_offsets = grep { /[^0]/ } keys %{$state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{$rw}{'Stencils'} } ;
 				my $n_nonzeroffsets = scalar  @non_zero_offsets ;
 				my @qms = grep { /\?/ } @{ $state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{$rw}{'Iterators'} };
 				my $all_points = scalar @qms == 0;
# 				say '#ACCESSES: ',$n_accesses;
# 				say 'NON-0 OFFSETS: ',$n_nonzeroffsets, @non_zero_offsets ;
# 				say 'ALL POINTS: ',$all_points ? 'YES' : 'NO', @qms;
				#* It is a stencil if:
				if(  $n_accesses > 1
				#- there is more than one access to an array => 
					 and
				#- at least one of these accesses has a non-zero offset
					$n_nonzeroffsets > 0 and
				#- all points in the array are processes in order 
					$all_points
					) {
#						say "STENCIL for $rw of $array_var";
						my $ctr_in = $unique_var_counters->{$array_var};
						say "${array_var}_tup = stencil patt ${array_var}_${ctr_in}";
 		if (not exists $unique_var_counters->{"${array_var}_tup"}) {
 			$unique_var_counters->{"${array_var}_tup"}=0;
 		} else {
 			$unique_var_counters->{"${array_var}_tup"}++;
 		}						
						$stencils{$array_var}=1;
					} 
					if(  $n_accesses > 0
				#- there is more than one access to an array => 
					 and
				#- at least one of these accesses has a non-zero offset
					$n_nonzeroffsets == 0 and
				#- all points in the array are processed in order 
					$all_points
					) {
#						say "single access for $rw of $array_var (info only)";
					}
										
				if (not $all_points) {
					if ($rw eq 'Read') {
#						say "EXTRACT for $rw of $array_var";
#						say "SELECT for $rw of $array_var";
#						say "${array_var}_portion = extract patt $array_var";
						my $ctr_in = $unique_var_counters->{$array_var};
						push @extracts,"${array_var}_portion = extract patt ${array_var}_${ctr_in}";
 		if (not exists $unique_var_counters->{"${array_var}_portion"}) {
 			$unique_var_counters->{"${array_var}_portion"}=0;
 		} else {
 			$unique_var_counters->{"${array_var}_portion"}++;
 		}						
						$portions{$array_var}=1;
					} else {
#						say "INSERT for $rw of $array_var";
						;
#						say "${array_var}_out = insert patt buf_to_insert $array_var";
						my $ctr_in = $unique_var_counters->{$array_var};
						my $ctr_out = ++$ctr_in;
						$unique_var_counters->{$array_var}=$ctr_out;
						push @inserts, "${array_var}_${ctr_out} = insert patt buf_to_insert ${array_var}_${ctr_in}";
					}
				}							
			}
		}
	} 	
	# so this provides the output and input tuples for a given $f
	# so for each var in $in_tup we need to get the counter, and for each var in $out_tup after that too. 
		(my $out_tup, my $in_tup) = pp_links($state->{'Subroutines'}{$f}{'Links'});
		# FIXME: Bit of a hack	
		my @in_tup_3D =  grep {
			exists $state->{'Subroutines'}{ $f }{'Arrays'}{$_} and 
			scalar @{ $state->{'Subroutines'}{ $f }{'Arrays'}{$_}{'Dims'} } > 2
		} @{$in_tup} ;
		
		my @in_tup_non_map_args =  grep {
			(not exists $state->{'Subroutines'}{ $f }{'Arrays'}{$_}) or 
			(scalar @{ $state->{'Subroutines'}{ $f }{'Arrays'}{$_}{'Dims'} } < 3)
		} @{$in_tup} ;
		
		my $in_tup_ms = [
			map {
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				} 
				exists $stencils{$_} ? 
				$_.'_tup_'.$unique_var_counters->{$_.'_tup'} :
				exists $portions{$_} ?
				$_.'_portion_'.$unique_var_counters->{$_.'_portion'} : 
				$_.'_'. ++$unique_var_counters->{$_}
			} @in_tup_3D
		];
		my @non_map_args_ms = map { 
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				}
				exists $stencils{$_} ? 
				$_.'_tup_'.$unique_var_counters->{$_.'_tup'} :
				exists $portions{$_} ?
				$_.'_portion_'.$unique_var_counters->{$_.'_portion'} : 
				$_.'_'. $unique_var_counters->{$_}
			} @in_tup_non_map_args;
		
		for my $var (@{$out_tup}) {
			if (not exists $unique_var_counters->{$var}) {
				$unique_var_counters->{$var}=0;
			}
		}
		my $map_expr = scalar @{$out_tup} > 1 ? '('.join(',',map { $_.'_'.$unique_var_counters->{$_} } @{$out_tup}).')' : scalar @{$out_tup} > 0 ? $out_tup->[0].'_'.$unique_var_counters->{$out_tup->[0]} : 'BOOM!!';
		$map_expr .= @non_map_args_ms ? 
		' = map ('.$f.' '.join(' ',@non_map_args_ms).') '
		:
		' = map '.$f.' '
		;
		$map_expr .=  scalar @{$in_tup} > 1 ? '('.join(',',@{$in_tup_ms}).')' : scalar @{$in_tup_ms} > 0 ? $in_tup_ms->[0] : 'BOOM!';
		
			map { say $_ } @extracts;#"${array_var}_portion = extract patt $array_var";
		
		say $map_expr unless $map_expr=~/BOOM/; 
		
			map { say $_ } @inserts;	
	return $stref;			
} # END of _classify_accesses()

# What we need is the in and out tuples
# i.e. keys %{$links} = OUT
# union of vals is IN
sub pp_links { (my $links)=@_;
	my $in_tup_table={};
	for my $lhs_var (sort keys %{$links}) {
#		print "$lhs_var => ";
		my @rhs_vars=();
		for my $lvar (sort keys %{$links->{$lhs_var}} ){
			push @rhs_vars,$lvar;
			$in_tup_table->{$lvar}=1;
		}	
#		say join(', ',@rhs_vars);
	}	
	my $out_tup = [ sort keys  %{$links} ];
	my $in_tup = [ sort keys  %{$in_tup_table} ];
	return ($out_tup, $in_tup);
} # END of pp_links()

sub _replace_param_by_val { (my $stref, my $f, my $ast)=@_;
#	if (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$ast)) {				  				
#  		my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$ast);
#  		my $val = $decl->{'Val'};
  		# - see if $val contains vars
  		my $vars=get_vars_from_expression($ast,{}) ;
  		# - if so, substitute them using _replace_consts_in_ast  		
  		my $state =  {'CurrentSub' =>$f};
#  		say "AST0: ".Dumper($ast);
  		while (
  		(exists $vars->{'_OPEN_PAR_'} and scalar keys %{$vars} > 1) 
  		or (not exists $vars->{'_OPEN_PAR_'} and scalar keys %{$vars} > 0)
  		
  		) {
#  			say "again: ".Dumper($vars);
			($ast, $state) = _replace_consts_in_ast($stref, $f,  $ast, $state, 0);
			# - check if the result is var-free, else repeat
			$vars=get_vars_from_expression($ast,{}) ;
#			say 'VARS:'.Dumper($vars);
#			say "AST: ".Dumper($ast);	
  		}  				
  		# - finally eval
#  		say "AST: ".Dumper($ast);
#	}
	return $ast;			
}


sub _collapse_links { (my $stref, my $f, my $links)=@_;
	
	for my $var (keys %{$links}) {
		if (isArg($stref, $f, $var)) {
#say "ARG $var";
my $deleted_entries={};
	my $again=1;
	do {
			$again=0;
			for my $lvar (keys %{ $links->{$var} } ) {
				next if $lvar eq $var;
				next if $lvar eq '_OPEN_PAR_';
#				say "\tLVAR $lvar";
				if ($links->{$var}{$lvar} > 2) { # Not an argument
					$again=1;
#					say "DEL $lvar IN $var: ".$links->{$var}{$lvar};					
					delete $links->{$var}{$lvar};
					$deleted_entries->{$lvar}=1;
					for my $nlvar (keys %{ $links->{$lvar} } ) {
						next if $nlvar eq $var;
						next if $nlvar eq $lvar;
						next if $nlvar eq '_OPEN_PAR_';
						next if exists $deleted_entries->{$nlvar};
						$links->{$var}{$nlvar} = $links->{$lvar}{$nlvar};
					}					 
				}
			}				
	} until $again == 0;
			
		}
	}	
	return $links;
} # END of _collapse_links()

#my @iters = @{$state->{'Subroutines'}{ $f }{'Arrays'}{$array_var}{$rw}{'Iterators'}};
sub _remove_index_vars { (my $stref, my $f, my $state, my $vars_ref)=@_;
	my %vars = %{$vars_ref};
		my %non_idx_vars=();
		my %idx_vars=();
	for my $var (keys %vars ) {
		if ($vars_ref->{$var}{'Type'} eq 'Array') {
			for my $rw ('Read','Write') {
				if (exists $state->{'Subroutines'}{ $f }{'Arrays'}{$var}{$rw} and 
				exists $state->{'Subroutines'}{ $f }{'Arrays'}{$var}{$rw}{'Iterators'}
				) {
				my @iters = @{$state->{'Subroutines'}{ $f }{'Arrays'}{$var}{$rw}{'Iterators'}};
				%idx_vars = (%idx_vars, map { $_ => 1 } @iters);
				}
		}
	}
	}
	for my $var (keys %vars ) {
		if (not exists $idx_vars{$var}) {
			$non_idx_vars{$var}->{'Type'} = $vars_ref->{$var}{'Type'};
		}
	}
	return %non_idx_vars;
}

1;
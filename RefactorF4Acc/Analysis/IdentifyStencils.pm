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
&pass_emit_TyTraCL
);


=info20170903
What we have now is for every array used in a subroutine, a set of all stencils with an indication if an access is constant or an offset from a given iterator.
The syntax is

$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Stencils'}{ join(':', @ast_vals0) }
{$iters[$idx] => [$mult_val,$offset_val]};

 '0:-1' => [
    {
      'j' => [
        1,
        0
      ]
    },
    {
      'k' => [
        1,
        -1
      ]
    }
  ],


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
    # WV: I think Selects and Inserts should be in Lines but I'm not sure
	$stref->{'TyTraCL_AST'} = {'Lines' => [], 'Selects' => [], 'Inserts' => []};
	$stref = pass_wrapper_subs_in_module($stref,
			[
#				[ sub { (my $stref, my $f)=@_;  alias_ordered_set($stref,$f,'DeclaredOrigArgs','DeclaredOrigArgs'); } ],
		  		[
			  		\&_identify_array_accesses_in_exprs,
				],
			]
		);					

	return $stref;
} # END of pass_identify_stencils()

sub pass_emit_TyTraCL {(my $stref)=@_;
    # WV: I think Selects and Inserts should be in Lines but I'm not sure
	$stref->{'TyTraCL_AST'} = {'Lines' => [], 'Selects' => [], 'Inserts' => []};
	$stref = pass_wrapper_subs_in_module($stref,
			[
#				[ sub { (my $stref, my $f)=@_;  alias_ordered_set($stref,$f,'DeclaredOrigArgs','DeclaredOrigArgs'); } ],
		  		[
			  		\&_identify_array_accesses_in_exprs,
				],
			]
		);					
        my $tytracl_str = _emit_TyTraCL($stref);
        say $tytracl_str;
        exit ;

	return $stref;
} # END of pass_emit_TyTraCL()


# This was only meant to work for the OpenCL Fortran kernels emitted by this compiler, but should now work for other subroutines as well.

# Array accesses are stored in 
# $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{
# 'Exprs' => { $expr_str_1 => 1,...},
# 'Stencils' => { '0:1' =>  'j' => [1,0],'k' => [1,1]},
# 'Iterators' => ['i','j']
# };
#
# Array dimensions are stored in
# 	$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{'Dims'} = [[0,501],[1,500],...]
#
sub _identify_array_accesses_in_exprs { (my $stref, my $f) = @_;
    #	die $f.' : '.Dumper($stref->{'Subroutines'}{$f}{Source});
    if ($stref->{'Subroutines'}{$f}{'Source'}=~/(?:dyn.f95|module_\w+_superkernel.f95)/ && $f!~/superkernel/) {  # TODO
        
        # For TyTraCL
        push @{ $stref->{'TyTraCL_AST'}{'Lines'} }, {'NodeType' => 'Comment', 'CommentStr' => $f };

		my $pass_identify_array_accesses_in_exprs = sub { (my $annline, my $state)=@_;
			(my $line,my $info)=@{$annline};
                
            my $in_block = exists $info->{Block} ? $info->{Block}{LineID} : '-1';
            my $block_id = __mkLoopId( $state->{'Subroutines'}{$f}{'LoopNests'} );
            #say 'BLOCK '.$info->{LineID}."\t$block_id\t\'$line\'";# => ;#.' '.$info->{Block}{LineID} ;#if ($info->{LineID} == 0);# or $info->{Block}{LineID} == 0);
            #my $block_id = 0;#$info->{'Block'}{'LineID'};            
            #
			# Identify the subroutine 
			if ( exists $info->{'Signature'} ) {
				my $subname =$info->{'Signature'}{'Name'} ; 
				$state->{'CurrentSub'}= $subname  ;
				croak if $subname ne $f;
				$state->{'Subroutines'}{$subname }={};
				$state->{'Subroutines'}{$subname }{$block_id}={};
                $state->{'Subroutines'}{$f}{'LoopNests'}=[ [0,{}] ];
			}
			# For every VarDecl, identify dimension if it is an array
			if (exists $info->{'VarDecl'} and not exists $info->{'ParamDecl'} and __is_array_decl($info)) { 
						
				my $array_var=$info->{'VarDecl'}{'Name'};				
				my @dims = @{ $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} };
                 
				$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{'Dims'}=[];
				for my $dim (@dims) {
					(my $lo, my $hi)=$dim=~/:/ ? split(/:/,$dim) : (1,$dim);
					my $dim_vals=[];
					for my $bound_expr_str ($lo,$hi) {
						my $dim_val=$bound_expr_str;
						if ($bound_expr_str=~/\W/) {
                            #my $dim_ast=parse_expression($bound_expr_str,$info, $stref,$f);
                            #my $dim_ast2 = _replace_param_by_val($stref, $f, $dim_ast);
                            #my $dim_expr=emit_expression($dim_ast2,'');
                            #$dim_val=eval($dim_expr);
                            $dim_val=_eval_expression_w_params($bound_expr_str,$info, $stref,$f,$block_id,$state);
						} else {
							# It is either a number or a var
							if (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$bound_expr_str)) {
                                # Means it's a parameter
				  				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$bound_expr_str);
                                $dim_val = $decl->{'Val'};
                                #my $dim_ast=parse_expression($bound_expr_str,$info, $stref,$f);
                                #my $dim_ast2 = _replace_param_by_val($stref, $f, $dim_ast);
                                #my $dim_expr=emit_expression($dim_ast2,'');
                                #$dim_val=eval($dim_expr);
                                #$dim_val=_eval_expression_w_params($bound_expr_str,$info, $stref,$f,$block_id,$state);
							} # otherwise it's a number and we fall through
						}
						push @{$dim_vals},$dim_val;
					} 
                    # This is also used to generate the 1-D stencils for TyTraCL
					push @{ $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{'Dims'} },$dim_vals;
				}
			}
			if (exists $info->{'Assignment'} ) {
				# Assignment to scalar *_rel 					
				if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' and $info->{'Lhs'}{'VarName'} =~/^(\w+)_rel/) {
					my $loop_iter=$1;
					$state->{'Subroutines'}{ $f }{$block_id}{'LoopIters'}{$loop_iter}={'Range' => 0};
				}
				# Assignment to scalar *_range 
				elsif ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' and $info->{'Lhs'}{'VarName'} =~/^(\w+)_range/) {
					my $loop_iter=$1;
					 
					my $expr_str = emit_expression($info->{'Rhs'}{'ExpressionAST'},'');
					my $loop_range = eval($expr_str);
					$state->{'Subroutines'}{ $f }{$block_id}{'LoopIters'}{$loop_iter}={'Range' => $loop_range};
						
				} else {				
					# This tests for the case of the same array on LHS and RHS, but maybe with a different access location, so a(...) = a(...)
                    # Not sure why as this is rather unusual and it is unused
					if ( 
						ref($info->{'Rhs'}{'ExpressionAST'}) eq 'ARRAY' 
					and (($info->{'Rhs'}{'ExpressionAST'}[0] & 0xF) == 10) #eq '@'
					and ref($info->{'Lhs'}{'ExpressionAST'}) eq 'ARRAY' 
					and (($info->{'Lhs'}{'ExpressionAST'}[0] & 0xF) == 10) #eq '@'
					and $info->{'Lhs'}{'ExpressionAST'}[1] eq $info->{'Rhs'}{'ExpressionAST'}[1]
					) {
						my $var_name = $info->{'Rhs'}{'ExpressionAST'}[1];
						say "IDENTITY OP for $var_name : ",$line;
						$state->{'Subroutines'}{ $f }{$block_id}{'Identity'}{$var_name} = 1;
					} 
					 
					# Find all array accesses in the LHS and RHS AST.

					(my $rhs_ast, $state, my $rhs_accesses) = _find_array_access_in_ast($stref, $f, $block_id, $state, $info->{'Rhs'}{'ExpressionAST'},'Read',{});
					(my $lhs_ast, $state, my $lhs_accesses) = _find_array_access_in_ast($stref, $f, $block_id, $state, $info->{'Lhs'}{'ExpressionAST'},'Write',{});                    
                    #say $line .' => '.Dumper([$rhs_accesses,$lhs_accesses]);
                }			
				my $var_name = $info->{'Lhs'}{'VarName'};
				if (not exists $state->{'Subroutines'}{ $f }{$block_id}{'Assignments'}{$var_name}) {
					$state->{'Subroutines'}{ $f }{$block_id}{'Assignments'}{$var_name}=[];
				} 
				push @{$state->{'Subroutines'}{ $f }{$block_id}{'Assignments'}{$var_name}}, $info->{'Rhs'}{'ExpressionAST'};
			} 
	 		if (exists $info->{'If'} ) { 
                # FIXME: Surely conditions of if-statements can contain array accesses, so FIX THIS!
                #say "IF statement, TODO: ".Dumper($info->{'CondExecExpr'});
                my $cond_expr_ast = $info->{'CondExecExprAST'};
                ($cond_expr_ast, $state, my $cond_accesses) = _find_array_access_in_ast($stref, $f, $block_id, $state, $cond_expr_ast,'Read',{});
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
            elsif ( exists $info->{'Do'} ) {
                    if (exists $info->{'Do'}{'Iterator'} ) {
                        
                # Do => { 
                #           Label :: Int
                #           Iterator :: Var
                #           Range => { 
                #               Vars => [ Var ],
                #               Expressions => [ $range_start, $range_stop, $range_step ]
                #            }
                #       }
                (my $range_start, my $range_stop, my $range_step) = @{ $info->{'Do'}{'Range'}{'Expressions'} };
                my $loop_iter = $info->{'Do'}{'Iterator'};
                my $loop_range_expr_str = $range_stop.' - '.$range_start; # FIXME Maybe we don't need this. But if we do, we should probably eval() it
                my $loop_id = $info->{'LineID'};
                push @{ $state->{'Subroutines'}{$f}{'LoopNests'} },[$loop_id, $loop_iter , {'Range' => $loop_range_expr_str}];
                my $block_id = __mkLoopId( $state->{'Subroutines'}{$f}{'LoopNests'} );
                for my $loop_iter_rec ( @{ $state->{'Subroutines'}{$f}{'LoopNests'} } ) {
                    (my $loop_id, my $loop_iter, my $range_rec) = @{$loop_iter_rec};
                    $state->{'Subroutines'}{ $f }{$block_id}{'LoopIters'}{$loop_iter}=$range_rec;#{'Range' => $loop_range_expr_str};
                }
            } else {
                croak "Sorry, a `do` loop without an iterator is not supported";
            }
            } elsif ( exists $info->{'EndDo'} ) {

            }
			return ([[$line,$info]],$state);
		};
	
		my $state = {'CurrentSub'=>'', 'Subroutines'=>{}};
	 	($stref,$state) = stateful_pass($stref,$f,$pass_identify_array_accesses_in_exprs, $state,'pass_identify_array_accesses_in_exprs ' . __LINE__  ) ;
#	 	if ($f=~/vernieuw/) { 
	 	
		$state = _link_writes_to_reads( $stref, $f, $state);
#		say Dumper( $state->{'Subroutines'}{$f}{'Links'});
	 	
#		say "LINKS:";
#		(my $out_tup, my $in_tup) = pp_links($state->{'Subroutines'}{$f}{'Links'});
#		my $map_expr = '('.join(',',@{$out_tup}).')';
#		$map_expr .= ' = map '.$f.' ';
#		$map_expr .= '('.join(',', grep {$_!~/\!/} @{$in_tup}).')';
#		say $map_expr;
#		say 'END LINKS';
		
		$stref = _classify_accesses_and_generate_TyTraCL($stref, $f, $state);
		
	} # if subkernel not superkernel
	else {
        $stref->{'TyTraCL_AST'}{'Main'} = $f;

        		say "-- SUPERKERNEL $f: ";
#		map { say $_ } sort keys %{ $stref->{'Subroutines'}{$f} };
#		say Dumper $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'};
		 for my $arg (@{ $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'} } ) {
             #		 	say $arg. ' => '. $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'};
         $stref->{'TyTraCL_AST'}{'OrigArgs'}{$arg} =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'};
		 } 
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
sub _find_array_access_in_ast { (my $stref, my $f,  my $block_id, my $state, my $ast, my $rw, my $accesses)=@_;
    if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {		
			my $entry = $ast->[$idx];
	
			if (ref($entry) eq 'ARRAY') {
				(my $entry, $state) = _find_array_access_in_ast($stref,$f, $block_id, $state,$entry, $rw,$accesses);
				$ast->[$idx] = $entry;
			} else {
				if ($idx==0 and (($entry & 0xF)==10)) { #$entry eq '@'				
					my $mvar = $ast->[$idx+1];
					if ($mvar ne '_OPEN_PAR_') {
						
						my $expr_str = emit_expression($ast,'');
						$state = _find_iters_in_array_idx_expr($stref,$f,$block_id,$ast, $state,$rw);
						my $array_var = $ast->[1];
                        # Special case for our OpenCL kernels
						if ($array_var =~/(glob|loc)al_/) { return ($ast,$state); }
#						# First we compute the offset
#						say "OFFSET";
						my $ast0 = dclone($ast); 
						($ast0,$state ) = _replace_consts_in_ast($stref,$f,$block_id,$ast0, $state,0);
						my @ast_a0 = @{$ast0};						
						my @idx_args0 = @ast_a0[2 .. $#ast_a0]; 
						my @ast_exprs0 = map { emit_expression($_,'') } @idx_args0;
						my @ast_vals0 = map { eval($_) } @ast_exprs0;
						# Then we compute the multipliers (for proper stencils these are 1 but for the more general case e.g. copying a plane of a cube it can be different.
#						say "MULT";
						my $ast1 = dclone($ast); 
						($ast1,$state ) = _replace_consts_in_ast($stref,$f,$block_id,$ast1, $state,1);
						my @ast_a1 = @{$ast1};
						my $array_var1 = $ast1->[1];
						my @idx_args1 = @ast_a1[2 .. $#ast_a1]; 
						my @ast_exprs1 = map { emit_expression($_,'') } @idx_args1;
						my @ast_vals1 = map { eval($_) } @ast_exprs1;
						my @iters = @{$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'}};
                        
						my $iter_val_pairs=[];						
						for my $idx (0 .. @iters-1) {
							my $offset_val=$ast_vals0[$idx];
							my $mult_val=$ast_vals1[$idx]-$offset_val;
							push @{$iter_val_pairs}, {$iters[$idx] => [$mult_val,$offset_val]};
						}
						$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Exprs'}{$expr_str}=1;   
						$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Stencils'}{ join(':', @ast_vals0) } = $iter_val_pairs;
                        $accesses->{'Arrays'}{$array_var}{$rw}{'Exprs'}{$expr_str}=1;
                        $accesses->{'Arrays'}{$array_var}{$rw}{'Stencils'}{ join(':', @ast_vals0) } = $iter_val_pairs;
						last;
					}
				} 
			}		
		}
	}
	return  ($ast, $state, $accesses);	
	
} # END of _find_array_access_in_ast

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

# We replace LoopIters with $const and Parameters with their values.
# Apply to RHS of assignments
sub _replace_consts_in_ast { (my $stref, my $f, my $block_id, my $ast, my $state, my $const)=@_;
	if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {								
			my $entry = $ast->[$idx];	
			
			if (ref($entry) eq 'ARRAY') {
				(my $entry2, $state) = _replace_consts_in_ast($stref,$f, $block_id,$entry, $state,$const);
				$ast->[$idx] = $entry2;
			} else {
				if ($idx==0 and (($entry & 0xF) == 2)) { #eq '$'				
					my $mvar = $ast->[$idx+1];					
					if (exists $state->{'Subroutines'}{ $f }{$block_id}{'LoopIters'}{ $mvar }) {
						$ast=''.$const.'';
						return ($ast,$state);
					} elsif (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$mvar)) {				  				
		  				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$mvar);
		  				#FIXME: the value could be an expression in terms of other parameters!
		  				my $val = $decl->{'Val'};
		  				$ast = parse_expression($val, {},$stref,$f);		  				
		  				return ($ast,$state);						
					}										
				} 
			}		
		}
	}
	return  ($ast, $state);		
} # END of _replace_consts_in_ast()

# So when we find an iterator access in an array we must check in which loop this array is being accessed
# If the loop iter must be per loop nest, not per subroutine
# So I need at the very least 
# $state->{'Subroutines'}{ $f }{$loop_label}{'LoopIters'}{ $var }
# $state->{'Subroutines'}{ $f }{$loop_label}{'Arrays'}
# And an the subroutine can have $loop_label = 0
# So $loop_label should be an arg as well
sub _find_iters_in_array_idx_expr { (my $stref, my $f, my $block_id, my $ast, my $state, my $rw)=@_;
	my @ast_a = @{$ast};
	my @args = @ast_a[2 .. $#ast_a];
	my $array_var = $ast_a[1];
	$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'}=[];
	for my $idx (0 .. @args-1) {
		$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'}[$idx]='?';
  		my $item = $args[$idx];
  		my $vars = get_vars_from_expression($item, {});
  		for my $var (keys %{$vars}) {
  			if (exists $state->{'Subroutines'}{ $f }{ $block_id }{'LoopIters'}{ $var }) {
  				# OK, I found an iterator in this index expression. I boldly assume there is only one.
  				$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'}[$idx]=$var;
  			}
  		}
	}
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

    for my $block_id (sort keys %{ $state->{'Subroutines'}{$f} }) {
       next if $block_id eq 'LoopNests';
	my $links={};
	my $assignments = $state->{'Subroutines'}{$f}{$block_id}{'Assignments'};
	# So we have to establish the link for every variable that is a multi-dim (effectively 3-D) array argument
	for my $some_var ( sort keys %{ $assignments }  ) {
		
		next if $some_var=~/_rel|_range/;
		
		$links = _link_writes_to_reads_rec($stref, $f, $block_id, $some_var,$assignments,$links,$state);
	}
	
	$links = _collapse_links($stref,$f,$block_id,$links);
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

	$state->{'Subroutines'}{$f}{$block_id}{'Links'}=$links;
}
	return $state;			 				
} # END of _link_writes_to_reads()

sub _link_writes_to_reads_rec {(my $stref, my $f, my $block_id, my $some_var, my $assignments,my  $links, my $state)=@_;
 		my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Vars'},$some_var);
		my $lhs_dim = scalar @{ $decl->{'Dim'} };
		if (exists $assignments->{$some_var} ) {  
			my $rhs_array = $assignments->{$some_var};			 
			my $vars = {};
			for my $rhs (@{ $rhs_array }) {
				my %tvars = %{ get_vars_from_expression($rhs,{}) };
				my %avars = _remove_index_vars($stref,$f,$block_id,$state,\%tvars);
				$vars = {%{$vars},%avars };
			}
			# If an array gets assigned to and returned but does not depend on inputs, we need to make sure it is also in links
			if (scalar keys %{$vars} == 0) {
				$links->{$some_var}{'!'.$some_var.'!'}=1;
			}
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
							my %avars = _remove_index_vars($stref,$f,$block_id,$state,\%tvars);							
							$rhs_vars = {%{$vars},%avars };
						}						
#						say Dumper($non_arg_rhs);
#						my $rhs_vars = get_vars_from_expression($non_arg_rhs,{});
						for my $rhs_var (keys %{$rhs_vars}) {	
#							say "VAR in RHS of NON-ARG assignment for $var: $rhs_var";
							next if exists $links->{$var}{$rhs_var};
							$links->{$var}{$rhs_var}= isArg($stref, $f, $rhs_var) ? 2 : 3 unless $rhs_var eq '_OPEN_PAR_';	 
#							next if $var eq $rhs_var;
			 				$links=_link_writes_to_reads_rec($stref, $f, $block_id, $rhs_var,$assignments,$links,$state);
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

# Either this is a misnomer or I should split out the code generation and emitter
=info_classify_accesses 
This routine does not $state; it modifies $stref by creating $stref->{UniqueVarCounters} 
However, it does perform analysis:
For every $array_var in  $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}} it does the following:
- It populates UniqueVarCounters, although this is not very useful. We use $unique_var_counters to keep track of accesses to a variable for the purpose of creating unique names for TyTraCL
- It tests if the access pattern for $array_var is a proper stencil:
	- There is more than one access to an array, this is determined from $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Stencils'}, see _find_array_access_in_ast()
	- At least one of these accesses has a non-zero offset, this is determined from $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Stencils'}
	- All points in the array are processed in order, this is determined by checking $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'} for '?', see _find_iters_in_array_idx_expr()
	There outcome is put in %stencils (1 or 0)


=cut
sub _classify_accesses_and_generate_TyTraCL { (my $stref, my $f, my $state ) =@_;
# 	say "SUB $f\n"; 
    my $block_id=0; # TODO
	my $tytracl_ast = $stref->{'TyTraCL_AST'};
	
	my @selects=(); # These are portions of an array that are selected, we need an `select` primitive
 	my @inserts=(); # This is when a portion of an array is inserted, we need an `insert` primitive
	my %stencils=(); # The `stencil` call		
	my %non_map_args=();
	my %portions=();
	
	if (not exists $stref->{'UniqueVarCounters'}) {
		$stref->{'UniqueVarCounters'}={'!s' => 0};
	}
	my $unique_var_counters=$stref->{'UniqueVarCounters'};
	
 	for my $array_var (keys %{$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}}) {  
 		next if $array_var =~/^global_|^local_/; 		
 		next if not defined  $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{'Dims'} ;
 		
 		if (not exists $unique_var_counters->{$array_var}) {
 			$unique_var_counters->{$array_var}=0;
 		}
 		 		
 		for my $rw ('Read','Write') { 
 			if (exists  $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw} ) {
 				# because it could be read-only and even write-only: v = u+w 				
 				my $n_accesses  =scalar keys %{$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Stencils'} } ;
 				my @non_zero_offsets = grep { /[^0]/ } keys %{$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Stencils'} } ;
 				my $n_nonzeroffsets = scalar  @non_zero_offsets ;
 				my @qms = grep { /\?/ } @{ $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'} };
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
				#- all points in the array are processed in order 
					$all_points
					) {
#						say "STENCIL for $rw of $array_var";#.': '.Dumper($state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Stencils'});
						my $ctr_st = ++$unique_var_counters->{'!s'};
						my @stencil_pattern = map { $_=~s/:/,/;"[$_]" } keys %{$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Stencils'}};
						my $stencil_definition = "s$ctr_st = [".join(',',@stencil_pattern).']';
                        #						say $stencil_definition;
                        #	 $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{'Dims'}					
						push @{$tytracl_ast->{'Lines'}}, 
						{'NodeType' => 'StencilDef', 'FunctionName' => $f,
							'Lhs' => {'Ctr' => $ctr_st}, 
							'Rhs' => {'StencilPattern' => {
                                    'Accesses' => $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Stencils'}, 
                                    'Dims' => $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{'Dims'}
                                }
                            }
						};
						my $ctr_in = $unique_var_counters->{$array_var};
						
				 		if (not exists $unique_var_counters->{"${array_var}_s"}) {
				 			$unique_var_counters->{"${array_var}_s"}=0;
				 		} else {
				 			$unique_var_counters->{"${array_var}_s"}++;
				 		}
				 		my $ctr_sv = $unique_var_counters->{"${array_var}_s"};
                        #say "${array_var}_s$ctr_sv = stencil s$ctr_st ${array_var}_${ctr_in}";
				 		push @{ $tytracl_ast->{'Lines'} }, 
				 		{'NodeType' => 'StencilAppl', 'FunctionName' => $f,
				 			'Lhs' => {'Var' => [$array_var,$ctr_sv,'s'] }, 
				 			'Rhs' => {'StencilCtr' => $ctr_st,'Var' => [$array_var, $ctr_in,''] }
				 		};						
						$stencils{$array_var}=1;
					} 
					
#					if(  $n_accesses > 0
#				#- there is more than one access to an array => 
#					 and
#				#- at least one of these accesses has a non-zero offset
#					$n_nonzeroffsets == 0 and
#				#- all points in the array are processed in order 
#					$all_points
#					) {
##						say "single access for $rw of $array_var (info only)";
#					}
										
				if (not $all_points) {
					if ($rw eq 'Read') {
#						say "SELECT for $rw of $array_var";
#						say "${array_var}_portion = select patt $array_var";
						my $ctr_in = $unique_var_counters->{$array_var};
						push @selects,"${array_var}_portion = select patt ${array_var}_${ctr_in} -- TODO";
						push @{ $tytracl_ast->{'Selects'} },
						{
							'Lhs' => {'Var' => [$array_var, 'TODO','portion']}, 
							'Rhs' =>  {'Var' => [$array_var, $ctr_in,''], 'Pattern' =>['TODO']}
						};
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
						push @inserts, "${array_var}_${ctr_out} = insert patt buf_to_insert ${array_var}_${ctr_in} -- TODO";
						push @{$tytracl_ast->{'Inserts'}},{
							'Lhs' => {'Var' => [$array_var,$ctr_out,''] }, 
							'Rhs' =>  {'Var' => [$array_var, $ctr_in,''], 'Pattern'=> ['TODO']},
						};
					}
				}							
			}
		}
	} 	
	# so this provides the output and input tuples for a given $f
	# so for each var in $in_tup we need to get the counter, and for each var in $out_tup after that too. 
		(my $out_tup, my $in_tup_maybe_dummies) = pp_links($state->{'Subroutines'}{$f}{$block_id}{'Links'});
		# A slightly better way is to look at which arrays are covered entirely by a map operation
		my $n_dims = scalar keys %{$state->{'Subroutines'}{ $f }{$block_id}{'LoopIters'}};
		
		my @in_tup = grep { $_!~/^\!/ } @{$in_tup_maybe_dummies};
		my @in_tup_correct_dim =  grep {
			exists $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$_} and 
			scalar @{ $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$_}{'Dims'} } >= $n_dims
		} @in_tup;
	
		my @in_tup_non_map_args =  grep {
			(not exists $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$_}) or 
			(scalar @{ $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$_}{'Dims'} } < $n_dims)
		} @in_tup;
		my $in_tup_ms_ast = [
			map {
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				} 
				exists $stencils{$_} ? 
				[$_,$unique_var_counters->{$_.'_s'},'s'] : #
				exists $portions{$_} ?
				[$_,$unique_var_counters->{$_.'_portion'},'portion'] : 
				[$_,$unique_var_counters->{$_},'']
			} @in_tup_correct_dim
		];
		my $in_tup_ms = [
			map {
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				} 
				exists $stencils{$_} ? 
				$_.'_s'.$unique_var_counters->{$_.'_s'} : #
				exists $portions{$_} ?
				$_.'_portion_'.$unique_var_counters->{$_.'_portion'} : 
				$_.'_'. $unique_var_counters->{$_}
			} @in_tup_correct_dim
		];
		my @non_map_args_ms_ast = map { 
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				}
				exists $stencils{$_} ? 
				[$_,$unique_var_counters->{$_.'_s'},'s'] :
				exists $portions{$_} ?
				[$_,$unique_var_counters->{$_.'_portion'},'portion'] : 
				[$_,$unique_var_counters->{$_},'']
			} @in_tup_non_map_args;
		my @non_map_args_ms = map { 
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				}
				exists $stencils{$_} ? 
				$_.'_s'.$unique_var_counters->{$_.'_s'} :
				exists $portions{$_} ?
				$_.'_portion_'.$unique_var_counters->{$_.'_portion'} : 
				$_.'_'. $unique_var_counters->{$_}
			} @in_tup_non_map_args;
		my @out_tup_ast=();
		for my $var (@{$out_tup}) {
			if (not exists $unique_var_counters->{$var}) {
				$unique_var_counters->{$var}=0;
			} else {
				$unique_var_counters->{$var}++;
			}
			push @out_tup_ast,[$var,$unique_var_counters->{$var},'']
		}
		my $map_expr = scalar @{$out_tup} > 1 ? '('.join(',',map { $_.'_'.$unique_var_counters->{$_} } @{$out_tup}).')' : scalar @{$out_tup} > 0 ? $out_tup->[0].'_'.$unique_var_counters->{$out_tup->[0]} : 'BOOM!!';
		my $maybe_unzipt =  scalar @{$out_tup} > 1 ? 'unzipt $' : '';
        #        say " $f non-map args: <".scalar(@non_map_args_ms).'>';
		$map_expr .= scalar @non_map_args_ms > 0 ? 
    		' = '. $maybe_unzipt . 'map ('.$f.' '.join('>> ',@non_map_args_ms).') <<'
	    	:
		    ' = ' .$maybe_unzipt .' map '.$f.' '
    		;
		$map_expr .=  scalar @in_tup > 1 ? '(zipt ('.join(',',@{$in_tup_ms}).'))' : scalar @{$in_tup_ms} > 0 ? $in_tup_ms->[0] : 'BOOM!';
		
        #		map { say $_ } @selects; # "${array_var}_portion = select patt $array_var";
		
        #		say $map_expr;# unless $map_expr=~/BOOM/; 
		push @{$tytracl_ast->{'Lines'}},
		{'NodeType' => 'Map','FunctionName' => $f,
			
			'Lhs' => {
				'Vars' =>[@out_tup_ast],				
			},
			'Rhs' => {
                'Function' => $f,
				'NonMapArgs' => {
					'Vars'=>[@non_map_args_ms_ast],					
				},
				'MapArgs' =>{
					'Vars' =>$in_tup_ms_ast,					
				}
			}
		};
        #		map { say $_ } @inserts;	
	$stref->{'TyTraCL_AST'} =$tytracl_ast;	
	return $stref ;			
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

sub _replace_param_by_val { (my $stref, my $f, my $block_id, my $ast, my $state)=@_;
  		# - see if $val contains vars
  		my $vars=get_vars_from_expression($ast,{}) ;
  		# - if so, substitute them using _replace_consts_in_ast
        #my $state =  {'CurrentSub' =>$f};
  		while (
  		(exists $vars->{'_OPEN_PAR_'} and scalar keys %{$vars} > 1) 
  		or (not exists $vars->{'_OPEN_PAR_'} and scalar keys %{$vars} > 0)
  		) {
			($ast, $state) = _replace_consts_in_ast($stref, $f, $block_id, $ast, $state, 0);
			# - check if the result is var-free, else repeat
			$vars=get_vars_from_expression($ast,{}) ;
  		}  				
  		# - return to be eval'ed
	return $ast;			
} # END of _replace_param_by_val()

sub _eval_expression_w_params { (my $expr_str,my $info, my $stref, my $f, my $block_id, my $state) = @_;

    my $expr_ast=parse_expression($expr_str,$info, $stref,$f);
    my $expr_ast2 = _replace_param_by_val($stref, $f, $block_id,$expr_ast, $state);
    my $evaled_expr_str=emit_expression($expr_ast2,'');
    my $expr_val=eval($evaled_expr_str);
	return $expr_val;
    
} # END of _eval_expression_w_params()

sub _collapse_links { (my $stref, my $f, my $block_id, my $links)=@_;
	
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

sub _remove_index_vars { (my $stref, my $f, my $block_id, my $state, my $vars_ref)=@_;
	my %vars = %{$vars_ref};
    my %non_idx_vars=();
    my %idx_vars=();
	for my $var (keys %vars ) {
		if ($vars_ref->{$var}{'Type'} eq 'Array') {
			for my $rw ('Read','Write') {
				if (exists $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$var}{$rw} and 
				exists $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$var}{$rw}{'Iterators'}
				) {
				my @iters = @{$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$var}{$rw}{'Iterators'}};
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

sub __is_array_decl { (my $info)=@_; 
	
	return (exists $info->{'ParsedVarDecl'}
	&& exists $info->{'ParsedVarDecl'}{'Attributes'}
	&& exists $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}
	&& scalar @{$info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}} >0);	
}

# {'Lines' => [
#		{'NodeType' => 'StencilDef', 
#			'Lhs' => {'Ctr' => $ctr_st}, 
#			'Rhs' => {'StencilPattern' => { 'Accesses' => $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Stencils'}},
#			'Dims' => ...}
#		};
# 		{'NodeType' => 'StencilAppl', 
# 			'Lhs' => {'Var' => [$array_var,$ctr_sv,'s'] }, 
# 			'Rhs' => {'StencilCtr' => $ctr_st,'Var' => [$array_var, $ctr_in,''] }
# 		};						
#		{'NodeType' => 'Map',
#			'Lhs' => {
#				'Vars' =>[@out_tup_ast],				
#			},
#			'Rhs' => {
#				'NonMapArgs' => {
#					'Vars'=>[@non_map_args_ms_ast],					
#				},
#				'MapArgs' =>{
#					'Vars' =>$in_tup_ms_ast,					
#				}
#			}
#		};	
#	], 
#	'Selects' => [
#						{
#							'Lhs' => {'Var' => [$array_var, 'TODO','portion']}, 
#							'Rhs' =>  {'Var' => [$array_var, $ctr_in,''], 'Pattern' =>['TODO']}
#						};	
#	], 
#	'Inserts' => [
#						{
#							'Lhs' => {'Var' => [$array_var,$ctr_out,''] }, 
#							'Rhs' =>  {'Var' => [$array_var, $ctr_in,''], 'Pattern'=> ['TODO']},
#						};	
#	]
#};

sub _emit_TyTraCL {  (my $stref) = @_;
	# FIXME: we ignore Selects and Inserts for now.
    # We need the superkernel as the main, and we must identify its input and output arguments
    # Input args have Ctr==0 on the Rhs
    # Output args $arg have Ctr == $stref->{'UniqueVarCounters'}{$arg}
	my $tytracl_ast = $stref->{'TyTraCL_AST'} ;
	my $tytracl_strs = [];
    my $main_rec = {'NodeType' => 'Main', 'InArgs' => [], 'OutArgs' => [],'Main' => $tytracl_ast->{'Main'}};
    my $var_types={};
    my $stencils={};    
	for my $node (@{ $tytracl_ast->{'Lines'} } ) {
        my $fname = $node->{'FunctionName'};
		my $lhs = $node->{'Lhs'} ;
		my $rhs = $node->{'Rhs'} ;
        $main_rec = _addToMainSig($stref,$main_rec, $node, $lhs, $rhs, $fname);
        ($var_types, $stencils) = _addToVarTypes($stref, $var_types, $stencils, $node, $lhs, $rhs, $fname);
        # These are never arguments of the main function
		if ($node->{'NodeType'} eq 'StencilDef') {
			my $ctr = $lhs->{'Ctr'};
			my $stencil_ast = $rhs->{'StencilPattern'}{'Accesses'};	
            my $array_dims = $rhs->{'StencilPattern'}{'Dims'};
            my @evaled_array_dims = ();
            for my $array_dim (@{ $array_dims } ) {
                push @evaled_array_dims, eval( $array_dim->[1].' - '.$array_dim->[0] );
            }
            
			my @stencil_pattern = map { $_=~s/:/,/;"[$_]" } sort keys %{$stencil_ast};
            # I should get the linear dimension from somewhere, we could add this information to the stencil detection
            # TODO: this needs to be generic so I should split the above and combine it with the dimensions
            my @stencil_pattern_eval = map {my $res=eval("my \$a=$_;my \$b=\$a->[0]*".$evaled_array_dims[0]."+\$a->[1];\$b");$res} @stencil_pattern;# FIXME: HACK!
            #            die Dumper @stencil_pattern_eval ;
			my $stencil_definition = '['.join(',',@stencil_pattern).']';	
            my $stencils_ = _generate_TyTraCL_stencils( $rhs->{'StencilPattern'} );
            $stencil_definition = '['.join(',',@{$stencils_}).']';

			my $line = "s$ctr = $stencil_definition";
			push @{$tytracl_strs},$line;
		} 
        # The stencil itself should be skipped but the others can be main args
        # The value returned from a stencil application should never be an output arg
        # Because of the way we identify and generate stencils, the stencil arg will always be a var, not a tuple
		elsif ($node->{'NodeType'} eq 'StencilAppl') {
			my $lhs_var = _mkVarName($lhs->{'Var'});
			my $rhs_var = _mkVarName($rhs->{'Var'});
            (my $var_name, my $ctr, my $ext) = @{$rhs->{'Var'}};
            #            if ($ctr == 0 && $ext eq '') {
            #                push @{ $main_rec->{'InArgs'} }, $var_name;
            #            }
			my $stencil_ctr = $rhs->{'StencilCtr'};
			my $line = "$lhs_var = stencil s$stencil_ctr $rhs_var";
			push @{$tytracl_strs},$line;
		}
#			'Lhs' => {
#				'Vars' =>[@out_tup_ast],				
#			},
#			'Rhs' => {
#				'Function' => $f,					
#				'NonMapArgs' => {
#					'Vars'=>[@non_map_args_ms_ast],					
#				},
#				'MapArgs' =>{
#					'Vars' =>$in_tup_ms_ast,					
#				}
#			}		
        # Arguments of map can be main args in several ways
        # NonMapArgs, which I can make sure are not tuples
        # MapArgs which can be (in fact will usually be) a ZipT of args
		elsif ($node->{'NodeType'} eq 'Map') {
			my $out_vars = $lhs->{'Vars'};
			my $map_args = $rhs->{'MapArgs'}{'Vars'};
			my $non_map_args = $rhs->{'NonMapArgs'}{'Vars'};
			my $lhs_str = (scalar @{$out_vars} == 1 ) 
				? _mkVarName($out_vars->[0]). ' = ' 
				: '('.join(',',map {_mkVarName($_) } @{$out_vars}).') = unzipt $';
			
			my $non_map_arg_str = (scalar @{$non_map_args} == 0 ) ? '' : (scalar @{$non_map_args} == 1 ) 
				? _mkVarName($non_map_args->[0]) 
				: '('.join(',',map {_mkVarName($_) } @{$non_map_args}).')';
			my $map_arg_str = (scalar @{$map_args} == 1 ) 
					? _mkVarName($map_args->[0]) 
					: '(zipt ('.join(',',map {_mkVarName($_) } @{$map_args}).'))';
            my $f = $rhs->{'Function'};        
			my $f_str = $non_map_arg_str eq '' ? $f : "($f $non_map_arg_str)";
			my $line = "$lhs_str map $f_str $map_arg_str";
			push @{$tytracl_strs},$line;			
		} 
        elsif ($node->{'NodeType'} eq 'Comment') {
            my $line = ' -- ' . $node->{'CommentStr'};
            push @{$tytracl_strs},$line;
        }
		else {
			croak;
		}					
	} 	
    # Indent
     my @tytracl_strs_indent = map {"    $_"} @{$tytracl_strs};
   #
    
    # Wrap into main    
    #
    my $main_in_args_str = scalar @{$main_rec->{'InArgs'}} > 1 ? '('.join(',', @{$main_rec->{'InArgs'}}).')' :  $main_rec->{'InArgs'}->[0];
    my $main_out_args_str = scalar @{$main_rec->{'OutArgs'}} > 1 ? '('.join(',', @{$main_rec->{'OutArgs'}}).')' :  $main_rec->{'OutArgs'}->[0];
    unshift @tytracl_strs_indent, '  let';
    unshift @tytracl_strs_indent, "main $main_in_args_str =";
    unshift @tytracl_strs_indent, "";
    push @tytracl_strs_indent,'  in';
    push @tytracl_strs_indent,"    $main_out_args_str";

    # Add function type decls
    #
    for my $f (sort keys %{ $var_types }) {
        #        say $f;
        if (exists $var_types->{$f} and ref($var_types->{$f}) eq 'HASH' and exists $var_types->{$f}{'FunctionTypeDecl'}) {
            unshift @tytracl_strs_indent,$var_types->{$f}{'FunctionTypeDecl'};
        }
    }
    #    say Dumper($main_rec);
	my $tytracl_str = join("\n", @tytracl_strs_indent);
	return $tytracl_str;
} # END of _emit_TyTraCL()

sub _mkVarName { (my $rec) =@_;
    #carp(Dumper($rec));
	(my $v, my $c, my $e) = @{$rec};
	if ($e eq '') {
		return "${v}_${c}";
	} else {
		return "${v}_${e}_${c}";
	}	
} # END of _mkVarName()

sub __isMainInArg { (my $var_rec, my $stref) = @_; 
    (my $var_name, my $ctr, my $ext) = @{$var_rec};
    my $orig_args = $stref->{'TyTraCL_AST'}{'OrigArgs'};
    
    #   say "TEST IN: $var_name $ctr <> 0 <$ext> <".(exists $orig_args->{$var_name} ) .">";
    return (
        $ctr == 0 
        && $ext eq ''
        && ( exists $orig_args->{$var_name} )
        && (( $orig_args->{$var_name} eq 'in') 
            || ( $orig_args->{$var_name} eq 'inout'))
     
    ) ? 1 : 0;
} # END of __isMainInArg()

sub __isMainOutArg { (my $var_rec, my $stref) = @_; 
    (my $var_name, my $ctr, my $ext) = @{$var_rec};
    my $orig_args = $stref->{'TyTraCL_AST'}{'OrigArgs'};

    #    say "TEST OUT: $var_name $ctr <> ".$stref->{'UniqueVarCounters'}{$var_name}." <$ext> <".(exists $orig_args->{$var_name} ) .">";
    return (
        $ctr ==  $stref->{'UniqueVarCounters'}{$var_name}
        && $ext eq ''
        && ( exists $orig_args->{$var_name} )
        && (( $orig_args->{$var_name} eq 'inout') 
            || ( $orig_args->{$var_name} eq 'out'))
    ) ? 1 : 0;
} # END of __isMainOutArg()

# argument should be a node
sub _addToMainSig { (my $stref, my $main_rec, my $node, my $lhs, my $rhs, my $fname) = @_;
    my $orig_args = $stref->{'TyTraCL_AST'}{'OrigArgs'};
		if ($node->{'NodeType'} eq 'StencilAppl') {
            # TODO: refactor!
            (my $var_name, my $ctr, my $ext) = @{$rhs->{'Var'}};
            if (exists $orig_args->{$var_name} and 
                ($orig_args->{$var_name} eq 'in'
                        or $orig_args->{$var_name} eq 'inout' )) {
            if ($ctr == 0 && $ext eq '') {
                push @{ $main_rec->{'InArgs'} }, _mkVarName($rhs->{'Var'});#$var_name;
            }
        }
        } elsif ($node->{'NodeType'} eq 'Map') {
			my $out_var_recs = $lhs->{'Vars'};#croak 'OUTVARS: '.Dumper($lhs);
            for my $out_var_rec (@{$out_var_recs}) {
                if (__isMainOutArg($out_var_rec,$stref)) {
                    #                    my $var_name = $out_var_rec->[0];
                    push @{ $main_rec->{'OutArgs'} }, _mkVarName($out_var_rec);
                }
            }
			my $map_arg_recs = $rhs->{'MapArgs'}{'Vars'};
            for my $map_var_rec (@{$map_arg_recs}) {
                if (__isMainInArg($map_var_rec,$stref)) {
                    my $var_name = $map_var_rec->[0];
                    push @{ $main_rec->{'InArgs'} },  _mkVarName($map_var_rec);# $var_name;
                }                 
            }
			my $non_map_arg_recs = $rhs->{'NonMapArgs'}{'Vars'};
            for my $non_map_var_rec (@{$non_map_arg_recs}) {
                if (__isMainInArg($non_map_var_rec,$stref)) {
                    my $var_name = $non_map_var_rec->[0];
                    push @{ $main_rec->{'InArgs'} }, _mkVarName($non_map_var_rec);#$var_name;
                }                 
            }
        } elsif ($node->{'NodeType'} eq 'Fold') { 
            # Main question is: what is the initial value of the accumulator?
            # It can in practice be a constant or scalar variable
            # In general of course it could be just about anything.
            # The question at this point is only if it is a var or list of vars
            croak('TODO: fold');
        } elsif ($node->{'NodeType'} ne 'Comment' and $node->{'NodeType'} ne 'StencilDef') {
            croak "NodeType type ".$node->{'NodeType'}.' not yet supported.';
        }
        return $main_rec;
} # END of _addToMainSig()

    # Add function type declarations. This is a bit complicated, but we have following steps:
    # If it is a stencil, then I have to find the stencil pattern. We do this in the handling of the StencilDef node. 
    # The actual type and the size of the array we should get via $stref->{'Subroutines'}{$f}
    # The non-map args can be arrays, so in that case in principle we'd need the type.
    # So, for every Map and Fold nodes we look a the vars, and we build up a table. If they are stencils we do this in the StencilDef node.
sub _addToVarTypes { (my $stref, my $var_types, my $stencils, my $node, my $lhs, my $rhs, my $fname) = @_;
    # DeclaredOrigArgs
#		{'NodeType' => 'StencilDef', 
#			'Lhs' => {'Ctr' => $ctr_st}, 
#			'Rhs' => {'StencilPattern' => {'Accesses' => $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Stencils'}}, 'Dims' => ...}
#		};    
        if ($node->{'NodeType'} eq 'StencilDef') {
            my $s_var = $lhs->{'Ctr'};
            my $s_size = scalar keys %{$rhs->{'StencilPattern'}{'Accesses'}};
            $stencils->{$s_var}=$s_size;
# 		{'NodeType' => 'StencilAppl', 
# 			'Lhs' => {'Var' => [$array_var,$ctr_sv,'s'] }, 
# 			'Rhs' => {'StencilCtr' => $ctr_st,'Var' => [$array_var, $ctr_in,''] }
# 		};						            
        } elsif ($node->{'NodeType'} eq 'StencilAppl') {
            # Here we enter the stencil from the Lhs in the table
            my $s_var = _mkVarName($lhs->{'Var'});
            # A little problem: we don't quite know $f at this point, or do we? I'll need a 'FunctionName' node 
            my $f = $fname;
            my $var_name = $rhs->{'Var'}[0];
            my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
            my $var_type =  __toTyTraCLType( $var_rec->{'Type'} );
            my @s_type_array = ();
            for (1 .. $stencils->{$rhs->{'StencilCtr'}}) {
                push @s_type_array, $var_type;
            }
            my $s_type =  '('.join(',',@s_type_array).')';
            # Or rather, use SVec:
            $s_type = "SVec ".$stencils->{$rhs->{'StencilCtr'}}." $var_type";
            $var_types->{$s_var}=$s_type;
            #            say "STENCIL $s_var $s_type";

            #_addToVarTypes
#		{'NodeType' => 'Map',
#			'Lhs' => {
#				'Vars' =>[@out_tup_ast],				
#			},
#			'Rhs' => {
#				'NonMapArgs' => {
#					'Vars'=>[@non_map_args_ms_ast],					
#				},
#				'MapArgs' =>{
#					'Vars' =>$in_tup_ms_ast,					
#				}
#			}
#		};	            
        } elsif ($node->{'NodeType'} eq 'Map') {
            # Output arguments can't be stencil, so only DeclaredOrigArgs
            my $out_args = $lhs->{'Vars'} ;
            my $f = $fname;
            my @out_arg_types_array;
            for my $out_arg_rec (@{$out_args}) {
                my $var_name = $out_arg_rec->[0];
                my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                my $var_type =  __toTyTraCLType( $var_rec->{'Type'} );
                #my $out_arg = _mkVarName($out_arg_rec);
                #                $var_types->{$out_arg}=$var_type;
                push @out_arg_types_array, $var_type;                
            }
            $var_types->{$f}{'ReturnType'} = scalar @{$out_args} == 1 ? $out_arg_types_array[0] :  '('.join(',',@out_arg_types_array).')';
            #            say "RETURN TYPE of $f: ".$var_types->{$f};
            # This should always be a tuple and the values can only be scalars
            my $map_args = $rhs->{'MapArgs'}{'Vars'} ;
            #            say Dumper($map_args);
            my @map_arg_types_array=();
            for my $map_arg_rec (@{$map_args}) {
                my $maybe_stencil = _mkVarName($map_arg_rec);
                #say  "MAYBE STENCIL: $maybe_stencil";                
                if (exists $var_types->{ $maybe_stencil }) {
                    #   say 'STENCIL TYPE: ',$var_types->{ $maybe_stencil };
                    push @map_arg_types_array,$var_types->{ $maybe_stencil };
                } else {
                    my $var_name = $map_arg_rec->[0];
                    my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                    my $var_type =  __toTyTraCLType( $var_rec->{'Type'} );
                    push @map_arg_types_array, $var_type;                
                }
            }
            my $map_arg_type = scalar @{$map_args} == 1 ? $map_arg_types_array[0] :  '('.join(',',@map_arg_types_array).')';
            #            say "MAP ARG TYPE of $f: ".$map_arg_type;
             $var_types->{$f}{'MapArgType'} = $map_arg_type;

            # This should always be a tuple and the values can actually be arrays
            my $non_map_args = $rhs->{'NonMapArgs'}{'Vars'} ;
            my @non_map_arg_types_array=();
            for my $non_map_arg_rec (@{$non_map_args}) {
                    my $var_name = $non_map_arg_rec->[0];
                    my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                    my $var_type =  __toTyTraCLType( $var_rec->{'Type'} );
                    push @non_map_arg_types_array, $var_type;                
            }
            my $non_map_arg_type = scalar @{$non_map_args} == 0 ? '' :
            scalar @{$non_map_args} == 1 ? $non_map_arg_types_array[0] :  '('.join(',',@non_map_arg_types_array).')';
            #            say "NON-MAP ARG TYPE of $f: ".$non_map_arg_type;                                    
            $var_types->{$f}{'NonMapArgType'} = $non_map_arg_type;

            my @arg_types= $non_map_arg_type ne '' ? ($non_map_arg_type) : ();
            push @arg_types, $var_types->{$f}{'MapArgType'};
            push @arg_types, $var_types->{$f}{'ReturnType'};

            $var_types->{$f}{'FunctionTypeDecl'} = "$f :: ".join( ' -> ',  @arg_types) ;
            #say $var_types->{$f}{'FunctionTypeDecl'};
		} elsif ($node->{'NodeType'} eq 'Fold') { 
            # Main question is: what is the initial value of the accumulator?
            # It can in practice be a constant or scalar variable
            # In general of course it could be just about anything.
            # The question at this point is only if it is a var or list of vars
            croak('TODO: fold');
        } elsif ($node->{'NodeType'} ne 'Comment' and $node->{'NodeType'} ) {
            croak "NodeType type ".$node->{'NodeType'}.' not yet supported.';
        }


    return ($var_types, $stencils) ;
} # END of _addToVarTypes()

sub __toTyTraCLType { (my $type)=@_;

    if ($type eq 'real') { return 'Float';
    } elsif ($type eq 'integer') { return 'Int';
    } else {
        # ad-hoc!
        return ucfirst($type);
    } 
}

# Maybe I will be lazy and only support 1, 2, 3 and 4 dimension

sub _generate_TyTraCL_stencils { (my $stencil_patt)=@_;
    my $stencil_ast = $stencil_patt->{'Accesses'};	
    my $array_dims = $stencil_patt->{'Dims'};
    my @stencil_pattern = map { [ split(/:/,$_) ] } sort keys %{$stencil_ast};
    #    say Dumper(@stencil_pattern). ' ; '.Dumper($array_dims );
    my $tytracl_stencils=[];
    for my $index_tuple (@stencil_pattern) {
        my @ranges = ();
        my @lower_bounds = ();
        my $n_dims = scalar @{ $array_dims };
        for my $array_dim (@{ $array_dims } ) {
            push @ranges, eval( $array_dim->[1].' - '.$array_dim->[0] . ' + 1');
            push @lower_bounds, $array_dim->[0];
        }
        if ($n_dims == 1) {
            push @{$tytracl_stencils}, F1D2C(@lower_bounds, @{$index_tuple});
        } elsif ($n_dims == 2) {
            #            say Dumper( (@ranges[0..1],@lower_bounds, @{$index_tuple}) );
            push @{$tytracl_stencils}, F2D2C($ranges[0],@lower_bounds, @{$index_tuple});
        } elsif ($n_dims == 3) {
            push @{$tytracl_stencils}, F3D2C(@ranges[0..1],@lower_bounds, @{$index_tuple});
        } elsif ($n_dims == 4) {
            push @{$tytracl_stencils}, F4D2C(@ranges[0..2],@lower_bounds, @{$index_tuple});
        } else {
            croak "Sorry, only up to 4 dimensions supported right now!";
        }
    }

    my $tytracl_stencils_str;

    return $tytracl_stencils
}

sub __mkLoopId { (my $loop_nest_stack ) =@_;
    return join('',map {$_->[0]} @{$loop_nest_stack});
}

sub F3D2C { (
         my $i_rng, my $j_rng, # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, my $k_lb, # lower bounds
        my $ix, my $jx, my $kx
        ) =@_;
    return ($i_rng*$j_rng*($kx-$k_lb)+$i_rng*($jx-$j_lb)+$ix-$i_lb);
}

sub F2D2C { (
         my $i_rng, # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, # lower bounds
        my $ix, my $jx
        ) =@_;
    return ($i_rng*($jx-$j_lb)+$ix-$i_lb);
}


sub F1D2C { (
        my $i_lb, #// lower bounds
        my $ix
        ) = @_;
    return $ix-$i_lb;
}

sub F4D2C { (
         my $i_rng, my $j_rng,  my $k_rng, # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, my $k_lb, my $l_lb, # lower bounds
        my $ix, my $jx, my $kx, my $lx
        ) = @_;
    return ($i_rng*$j_rng*$k_rng*($lx-$l_lb)+
            $i_rng*$j_rng*($kx-$k_lb)+
            $i_rng*($jx-$j_lb)+
            $ix-$i_lb
            );
}
            
1;

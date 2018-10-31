package RefactorF4Acc::Translation::TyTraCL;
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

use RefactorF4Acc::Analysis::IdentifyStencils qw( identify_array_accesses_in_exprs );
#
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Translation::TyTraCL::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTraCL::EXPORT_OK = qw(
&pass_emit_TyTraCL
);


=info20170903
What we have now is for every array used in a subroutine, a set of all stencils with an indication if an access is constant or an offset from a given iterator.
The syntax is

$state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'}{ join(':', @ast_vals0) }
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

sub pass_emit_TyTraCL {(my $stref)=@_;
    # WV: I think Selects and Inserts should be in Lines but I'm not sure
    $stref->{'EmitAST'} = 'TyTraCL_AST';
	$stref->{'TyTraCL_AST'} = {'Lines' => [], 'Selects' => [], 'Inserts' => [], 'Stencils'=>{},'Portions'=>{},'ASTEmitter' => \&_add_TyTraCL_AST_entry};
	$stref = pass_wrapper_subs_in_module($stref,
			[
#				[ sub { (my $stref, my $f)=@_;  alias_ordered_set($stref,$f,'DeclaredOrigArgs','DeclaredOrigArgs'); } ],
		  		[
			  		\&identify_array_accesses_in_exprs,
				],
			]
		);
        my $tytracl_str = _emit_TyTraCL($stref);
        say $tytracl_str;
        exit ;

	return $stref;
} # END of pass_emit_TyTraCL()


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



# {'Lines' => [
#		{'NodeType' => 'StencilDef',
#			'Lhs' => {'Ctr' => $ctr_st},
#			'Rhs' => {'StencilPattern' => { 'Accesses' => $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'}},
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
    # Output args $arg have Ctr == $tytracl_ast->{'UniqueVarCounters'}{$arg}
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
    my $tytracl_ast = $stref->{'TyTraCL_AST'};
    my $orig_args = $tytracl_ast->{'OrigArgs'};


# say "TEST OUT: $var_name $ctr ";# <> ".$tytracl_ast->{'UniqueVarCounters'}{$var_name}." <$ext> <".(exists $orig_args->{$var_name} ) .">";
    return (
        $ctr ==  $tytracl_ast->{'UniqueVarCounters'}{$var_name}
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
#			'Rhs' => {'StencilPattern' => {'Accesses' => $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'}}, 'Dims' => ...}
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

sub _add_TyTraCL_AST_entry { (my $f, my $state, my $tytracl_ast, my $type, my $block_id, my $array_var, my $rw) = @_;
	if (not defined $array_var) {
		$array_var = '#dummy#';
	}
	if (not exists $tytracl_ast->{'UniqueVarCounters'}) {
		$tytracl_ast->{'UniqueVarCounters'}={'!s' => 0};
	}
	
	
	my $unique_var_counters=$tytracl_ast->{'UniqueVarCounters'};

 	if (not exists $unique_var_counters->{$array_var}) {
 			$unique_var_counters->{$array_var}=0;
 	}	
 	
	if ($type eq 'STENCIL') {
							my $ctr_st = ++$unique_var_counters->{'!s'};
						push @{$tytracl_ast->{'Lines'}},
						{'NodeType' => 'StencilDef', 'FunctionName' => $f,
							'Lhs' => {'Ctr' => $ctr_st},
							'Rhs' => {'StencilPattern' => {
                                    'Accesses' => $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'},
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
				 		$tytracl_ast->{'Stencils'}{$array_var}=1,
	} elsif ($type eq 'SELECT') {
				 								my $ctr_in = $unique_var_counters->{$array_var};
#						push @selects,"${array_var}_portion = select patt ${array_var}_${ctr_in} -- TODO";
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
				 		$tytracl_ast->{'Portions'}{$array_var}=1,
 	} elsif ($type eq 'INSERT') {
						my $ctr_in = $unique_var_counters->{$array_var};
						my $ctr_out = ++$ctr_in;
						$unique_var_counters->{$array_var}=$ctr_out;
#						push @inserts, "${array_var}_${ctr_out} = insert patt buf_to_insert ${array_var}_${ctr_in} -- TODO";						
						push @{$tytracl_ast->{'Inserts'}},{
							'Lhs' => {'Var' => [$array_var,$ctr_out,''] },
							'Rhs' =>  {'Var' => [$array_var, $ctr_in,''], 'Pattern'=> ['TODO']},
						};
 	} elsif ($type eq 'MAP') {
 		my %portions = %{$tytracl_ast->{'Portions'}};
 		my %stencils= %{$tytracl_ast->{'Stencils'}};
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
	} elsif ($type eq 'MAIN') {
		# TRICK: $state = $stref
#				$ast_to_emit = $ast_emitter->( $f,  $stref,  $ast_to_emit, 'SELECT',  $block_id,  $array_var,  $rw) if $emit_ast; 
        $tytracl_ast->{'Main'} = $f;

        		
#		map { say $_ } sort keys %{ $stref->{'Subroutines'}{$f} };
#		say Dumper $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'};
		 for my $arg (@{ $state->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'} } ) {
		 	say $arg. ' => '. $state->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'};
         $tytracl_ast->{'OrigArgs'}{$arg} =  $state->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'};
		 }
		
	}
				 		
	return $tytracl_ast;
} # END of _add_TyTraCL_AST_entry

1;

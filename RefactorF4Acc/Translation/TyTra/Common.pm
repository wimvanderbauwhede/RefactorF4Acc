package RefactorF4Acc::Translation::TyTra::Common;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
#
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Carp;
use Data::Dumper;


use Exporter;

@RefactorF4Acc::Translation::TyTra::Common::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTra::Common::EXPORT_OK = qw(
&pp_links 
&_mkVarName 
&__isMainInArg 
&__isMainOutArg 
&_addToMainSig 
&_addToVarTypes 
&F3D2C 
&F2D2C 
&F1D2C 
&F4D2C 
);




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
    my $orig_args = $stref->{$stref->{'EmitAST'}}{'OrigArgs'};

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
    my $tytracl_ast = $stref->{$stref->{'EmitAST'}};
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
    my $orig_args = $stref->{$stref->{'EmitAST'}}{'OrigArgs'};
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
			my $out_var_recs = $lhs->{'Vars'};#croak 'OUTVARS: '.Dumper($lhs);
            for my $out_var_rec (@{$out_var_recs}) {
                if (__isMainOutArg($out_var_rec,$stref)) {
                    push @{ $main_rec->{'OutArgs'} }, _mkVarName($out_var_rec);
                }
            }
			my $map_arg_recs = $rhs->{'FoldArgs'}{'Vars'};
            for my $map_var_rec (@{$map_arg_recs}) {
                if (__isMainInArg($map_var_rec,$stref)) {
                    my $var_name = $map_var_rec->[0];
                    push @{ $main_rec->{'InArgs'} },  _mkVarName($map_var_rec);# $var_name;
                }
            }
			my $non_map_arg_recs = $rhs->{'NonFoldArgs'}{'Vars'};
            for my $non_map_var_rec (@{$non_map_arg_recs}) {
                if (__isMainInArg($non_map_var_rec,$stref)) {
                    my $var_name = $non_map_var_rec->[0];
                    push @{ $main_rec->{'InArgs'} }, _mkVarName($non_map_var_rec);#$var_name;
                }
            }
            my $accs = $rhs->{'AccArgs'}{'Vars'};
            for my $non_map_var_rec (@{$accs}) {
                if (__isMainInArg($non_map_var_rec,$stref)) {
                    my $var_name = $non_map_var_rec->[0];
                    push @{ $main_rec->{'InArgs'} }, _mkVarName($non_map_var_rec);#$var_name;
                }
            }
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
sub _addToVarTypes { (my $stref, my $var_types, my $stencils, my $node, my $lhs, my $rhs, my $fname, my $type_formatter) = @_;
    # DeclaredOrigArgs
#		{'NodeType' => 'StencilDef',
#			'Lhs' => {'Ctr' => $ctr_st},
#			'Rhs' => {'StencilPattern' => {'Accesses' => $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'}}, 'Dims' => ...}
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
            my $var_type =  $type_formatter->( $var_rec->{'Type'} );
            my @s_type_array = ();
            for (1 .. $stencils->{$rhs->{'StencilCtr'}}) {
                push @s_type_array, $var_type;
            }
            my $s_type =  '('.join(',',@s_type_array).')';
            # Or rather, use SVec:
            $s_type = "SVec ".$stencils->{$rhs->{'StencilCtr'}}." $var_type";
            $var_types->{$s_var}=$s_type;
#			say "STENCIL $s_var $s_type";

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
                my $var_type =  $type_formatter->( $var_rec->{'Type'} );
                #my $out_arg = _mkVarName($out_arg_rec);
                #                $var_types->{$out_arg}=$var_type;
                push @out_arg_types_array, $var_type;
            }
            $var_types->{$f}{'ReturnType'} = scalar @{$out_args} == 1 ? $out_arg_types_array[0] :  '('.join(',',@out_arg_types_array).')';
            #            say "RETURN TYPE of $f: ".$var_types->{$f};
            
            # This should always be a tuple and the values can only be scalars
            my $map_args = $rhs->{'MapArgs'}{'Vars'} ;
#            say Dumper($rhs->{'MapArgs'});die if $f=~/44/;
            my @map_arg_types_array=();
            for my $map_arg_rec (@{$map_args}) {
#            	say Dumper($map_arg_rec);
                my $maybe_stencil = _mkVarName($map_arg_rec);
#				say  "MAYBE STENCIL: $maybe_stencil";
                if (exists $var_types->{ $maybe_stencil }) {
#                    say "STENCIL $maybe_stencil TYPE: ",$var_types->{ $maybe_stencil };
                    push @map_arg_types_array,$var_types->{ $maybe_stencil };
                } else {
                    my $var_name = $map_arg_rec->[0];
                    my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                    my $var_type =  $type_formatter->( $var_rec->{'Type'} );
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
                    my $var_type =  $type_formatter->( $var_rec->{'Type'} );
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
#            croak('TODO: fold');
            # Output arguments can't be stencil, so only DeclaredOrigArgs
            my $out_args = $lhs->{'Vars'} ;
            my $f = $fname;
            my @out_arg_types_array;
            for my $out_arg_rec (@{$out_args}) {
                my $var_name = $out_arg_rec->[0];
                my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                my $var_type =  $type_formatter->( $var_rec->{'Type'} );
                #my $out_arg = _mkVarName($out_arg_rec);
                #                $var_types->{$out_arg}=$var_type;
                push @out_arg_types_array, $var_type;
            }
            $var_types->{$f}{'ReturnType'} = scalar @{$out_args} == 1 ? $out_arg_types_array[0] :  '('.join(',',@out_arg_types_array).')';
            #            say "RETURN TYPE of $f: ".$var_types->{$f};
            
            # This should always be a tuple and the values can only be scalars
            my $map_args = $rhs->{'FoldArgs'}{'Vars'} ;
            my @map_arg_types_array=();
            for my $map_arg_rec (@{$map_args}) {
                my $maybe_stencil = _mkVarName($map_arg_rec);
                if (exists $var_types->{ $maybe_stencil }) {
                    push @map_arg_types_array,$var_types->{ $maybe_stencil };
                } else {
                    my $var_name = $map_arg_rec->[0];
                    my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                    my $var_type =  $type_formatter->( $var_rec->{'Type'} );
                    push @map_arg_types_array, $var_type;
                }
            }
            my $map_arg_type = scalar @{$map_args} == 1 ? $map_arg_types_array[0] :  '('.join(',',@map_arg_types_array).')';
             $var_types->{$f}{'FoldArgType'} = $map_arg_type;

            # This should always be a tuple and the values can actually be arrays
            my $non_map_args = $rhs->{'NonFoldArgs'}{'Vars'} ;
            
            my @non_map_arg_types_array=();
            for my $non_map_arg_rec (@{$non_map_args}) {
                    my $var_name = $non_map_arg_rec->[0];
                    my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                    my $var_type =  $type_formatter->( $var_rec->{'Type'} );
                    push @non_map_arg_types_array, $var_type;
            }
            my $non_map_arg_type = scalar @{$non_map_args} == 0 ? '' :
            scalar @{$non_map_args} == 1 ? $non_map_arg_types_array[0] :  '('.join(',',@non_map_arg_types_array).')';
            
            $var_types->{$f}{'NonFoldArgType'} = $non_map_arg_type;

            my $acc_args = $rhs->{'AccArgs'}{'Vars'} ;
            my @acc_arg_types_array=();
            for my $acc_arg_rec (@{$acc_args}) {
                    my $var_name = $acc_arg_rec->[0];
#                    say "ACC: $f $var_name ";
                    my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                    my $var_type =  $type_formatter->( $var_rec->{'Type'} );
                    push @acc_arg_types_array, $var_type;
            }
            my $acc_arg_type = scalar @{$acc_args} == 0 ? '' :
            scalar @{$acc_args} == 1 ? $acc_arg_types_array[0] :  '('.join(',',@acc_arg_types_array).')';
            $var_types->{$f}{'AccArgType'} = $acc_arg_type;


            my @arg_types= $non_map_arg_type ne '' ? ($non_map_arg_type) : ();
            push @arg_types, $var_types->{$f}{'AccArgType'};
            push @arg_types, $var_types->{$f}{'FoldArgType'};
            push @arg_types, $var_types->{$f}{'ReturnType'};

            $var_types->{$f}{'FunctionTypeDecl'} = "$f :: ".join( ' -> ',  @arg_types) ;            
            
            
        } elsif ($node->{'NodeType'} ne 'Comment' and $node->{'NodeType'} ) {
            croak "NodeType type ".$node->{'NodeType'}.' not yet supported.';
        }


    return ($var_types, $stencils) ;
} # END of _addToVarTypes()


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

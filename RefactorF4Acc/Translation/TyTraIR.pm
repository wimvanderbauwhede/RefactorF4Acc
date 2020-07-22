package RefactorF4Acc::Translation::TyTraIR;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw(
  pass_wrapper_subs_in_module
);
use RefactorF4Acc::Refactoring::Fixes qw( remove_redundant_arguments_and_fix_intents );
use RefactorF4Acc::Translation::TyTra::Common qw(
  pp_links
  __isMainInArg
  __isMainOutArg
  F3D2C
  F2D2C
  F1D2C
  F4D2C
  _mkVarName
);
use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( identify_array_accesses_in_exprs );
#
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "2.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Translation::TyTraIR::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTraIR::EXPORT_OK = qw(
  &pass_emit_TyTraIR
);

our $FOLD = 0;


sub pass_emit_TyTraIR {
    (my $stref, my $module_name) = @_;

    # Just like for TyTraCL, the hard work is done in identify_array_accesses_in_exprs() via the ASTEmitter below
    $stref->{'EmitAST'} = 'TyTraIR_AST';
    # WV: I think Selects and Inserts should be in Lines but I'm not sure
    $stref->{'TyTraIR_AST'} = {
        'Lines'      => [],
        'Selects'    => [],
        'Inserts'    => [],
        'Stencils'   => {},
        'Portions'   => {},
# 		'Main'		=> {}
#		'MainFunction' => ''
        'ASTEmitter' => \&_add_TyTraIR_AST_entry
    };
    $stref = pass_wrapper_subs_in_module(
        $stref, $module_name,

        # module-specific passes
        [],

        # subroutine-specific passes
        [
#				[ sub { (my $stref, my $f)=@_;  alias_ordered_set($stref,$f,'DeclaredOrigArgs','DeclaredOrigArgs'); } ],
            [\&remove_redundant_arguments_and_fix_intents],
            [   \&identify_array_accesses_in_exprs,
            ],
        ]
    );
    # my $tytra_ir_str = _emit_TyTraIR($stref);

	$stref = _construct_TyTraIR_AST_Main_node($stref);
    $stref = _emit_TyTraIR($stref);
    my $tytra_ir_str = $stref->{'TyTraIR_Code'};

    write_out($tytra_ir_str);

    # This makes sure that no fortran is emitted by emit_all()
    $stref->{'SourceContains'} = {};

    return $stref;
}    # END of pass_emit_TyTraIR()

# {'Lines' => [
#		{'NodeType' => 'StencilDef',
#			'Lhs' => {'Ctr' => $ctr_st},
#			'Rhs' => {'StencilPattern' => { 'Accesses' => $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'}},
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

sub _construct_TyTraIR_AST_Main_node {
    (my $stref) = @_;

    # FIXME: we ignore Selects and Inserts for now.
    # We need the superkernel as the main, and we must identify its input and output arguments
    # Input args have Ctr==0 on the Rhs
    # Output args $arg have Ctr == $tytra_ir_ast->{'UniqueVarCounters'}{$arg}
    my $tytra_ir_ast = $stref->{'TyTraIR_AST'};

    my $main_rec  = {
		'NodeType' => 'MainFunction',
		'InArgs' => [], 
		'OutArgs' => [], 
		'MainFunction' => $tytra_ir_ast->{'MainFunction'}
	};
    # my $var_types = {};
    # my $stencils  = {};
    for my $node (@{$tytra_ir_ast->{'Lines'}}) {
        my $fname = $node->{'FunctionName'};
        my $lhs   = $node->{'Lhs'};
        my $rhs   = $node->{'Rhs'};

        # This is not an Emitter step
        $main_rec = _addToMainSig($stref, $main_rec, $node, $lhs, $rhs, $fname);

        # ($var_types, $stencils) =
        #   _addToVarTypesAndStencils($stref, $var_types, $stencils, $node, $lhs, $rhs, $fname, \&__toTyTraCLType);
    }

    # $main_rec->{'Stencils'}=$stencils;
    # $main_rec->{'VarTypes'} = $var_types;

    # say Dumper($main_rec);
    $stref->{'TyTraIR_AST'}{'Main'} = $main_rec;

    return $stref;
} # END of _construct_TyTraIR_AST_Main_node

sub _emit_TyTraIR {
    (my $stref) = @_;

    # FIXME: we ignore Selects and Inserts for now.

    # We need the superkernel as the main, and we must identify its input and output arguments
    # Input args have Ctr==0 on the Rhs
    # Output args $arg have Ctr == $tytra_ir_ast->{'UniqueVarCounters'}{$arg}

    my $tytra_ir_ast  = $stref->{'TyTraIR_AST'};
    my $tytra_ir_strs = [];

    # my $var_types = {};
    # my $stencils  = {};
    my $state     = {};

    for my $node (@{$tytra_ir_ast->{'Lines'}}) {
        my $fname = $node->{'FunctionName'};
        my $lhs   = $node->{'Lhs'};
        my $rhs   = $node->{'Rhs'};

        # # WV20190801 FIXME: make this either $node on its own or $nodeid instead of $node
        # $main_rec = _addToMainSig($stref, $main_rec, $node, $lhs, $rhs, $fname);

        # These are never arguments of the main function
        if ($node->{'NodeType'} eq 'StencilDef') {
            my $ctr = $lhs->{'Ctr'};
            $state->{$ctr}{'StencilDef'} = $rhs->{'StencilPattern'};
        }

        # The stencil itself should be skipped but the others can be main args
        # The value returned from a stencil application should never be an output arg
        # Because of the way we identify and generate stencils, the stencil arg will always be a var, not a tuple
        elsif ($node->{'NodeType'} eq 'StencilAppl') {
            my $lhs_var = _mkVarName($lhs->{'Var'});
            (my $lhs_var_name, my $lhs_ctr, my $lhs_ext) = @{$lhs->{'Var'}};
            my $rhs_var = _mkVarName($rhs->{'Var'});
            $state->{'IsStencil'}{$rhs->{'Var'}[0]} = 1;
            (my $var_name, my $ctr, my $ext) = @{$rhs->{'Var'}};
            my $stencil_ctr = $rhs->{'StencilCtr'};
            my $exprs       = $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$var_name}{'Read'}{'Exprs'};
			
            my $var_type = _get_TyTraIR_type($stref, $fname, $var_name);
            my $ok       = 0;
            for my $expr (keys %{$exprs}) {
                my $k       = $exprs->{$expr};
                my $stencil = _generate_TyTraIR_stencil($state->{$stencil_ctr}{'StencilDef'}, $k);
                if ($stencil == 0) {

                    my ($v, $c, $e, $t, $s) = @{$rhs->{'Var'}};
                    $s       = _scalarize_array_expr($expr);
                    $rhs_var = _mkVarName([$v, $c, $e, $t, $s]);
                }
            }
            my @offset_streams = ("; Offset streams for $rhs_var");
            for my $expr (keys %{$exprs}) {
                my $k       = $exprs->{$expr};
                my $stencil = _generate_TyTraIR_stencil($state->{$stencil_ctr}{'StencilDef'}, $k);

#            	  if ($stencil != 0) {
                if ($stencil > 0) {
                    $stencil = '+' . $stencil;
                }

                #  i32 %vin0_p_0    = offstream  %vin0_stream, !tir.stream.offset !+0
                push @offset_streams,
                    $var_type . ' %'
                  . _scalarize_array_expr($expr) . '_s_'
                  . $lhs_ctr
                  . ' = offstream '
                  . $rhs_var
                  . ', !tir.stream.offset !'
                  . $stencil;

#            	  }
            }
            $tytra_ir_strs = [@{$tytra_ir_strs}, @offset_streams, ''];
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
            my $out_vars     = $lhs->{'Vars'};
            my $map_args     = $rhs->{'MapArgs'}{'Vars'};
            my $non_map_args = $rhs->{'NonMapArgs'}{'Vars'};
            my $f            = $rhs->{'Function'};

            # 1. get the original argument list
            # my $orig_args = $stref->{'Subroutines'}{$fname}{'Args'}{'Subsets'}{'OrigArgs'}{'List'};
			my $orig_args = $stref->{'Subroutines'}{$fname}{'DeclaredOrigArgs'}{'List'};
            my $line      = "call \@$f (";
            my @chunks    = ('', $line);

            # 2. But for each arg we get the expressions and create the scalarized args
            my %arg_ctrs = map {
                (my $var, my $ctr, my $e) = @{$_};
                ($var, $ctr)
            } (@{$out_vars}, @{$map_args}, @{$non_map_args});

            for my $var_name (@{$orig_args}) {
				# say "SUB $fname ARG $var_name";
                my $ctr      = exists $arg_ctrs{$var_name} ? $arg_ctrs{$var_name} : 0;
                my $decl     = $stref->{'Subroutines'}{$fname}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                my $var_type = __toTyTraIRType($decl->{'Type'});
                my $exprs    = {};
                if (exists $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$var_name}{'Read'}) {
                    $exprs = $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$var_name}{'Read'}{'Exprs'};
                }
                else {
                    $exprs = $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$var_name}{'Write'}{'Exprs'};
                }
                my $maybe_s = '';
                if (exists $state->{'IsStencil'}{$var_name}) {
                    $maybe_s = 's_';
                }
                if (scalar keys %{$exprs} > 0) {
                    my @tchunks = map { "\t\t\t" . $var_type . ' %' . _scalarize_array_expr($_) . '_' . $maybe_s . $ctr }
                      sort keys %{$exprs};
                    @chunks = (@chunks, @tchunks);
                }
                else {
                    push @chunks, "\t\t\t" . $var_type . ' %' . $var_name . '_' . $ctr;
                }
            }
            push @chunks, "\t)";
            push @chunks, "";
            $tytra_ir_strs = [@{$tytra_ir_strs}, @chunks];
        }
        elsif ($node->{'NodeType'} eq 'Fold') {
            my $out_vars     = $lhs->{'Vars'};
            my $map_args     = $rhs->{'FoldArgs'}{'Vars'};
            my $non_map_args = $rhs->{'NonFoldArgs'}{'Vars'};
            my $acc_args     = $rhs->{'AccArgs'}{'Vars'};
            my $f            = $rhs->{'Function'};

            # 1. get the original argument list
            my $orig_args = $stref->{'Subroutines'}{$fname}{'Args'}{'Subsets'}{'OrigArgs'}{'List'};
            my $line      = "call \@$f (";
            my @chunks    = ('', $line);

            # 2. But for each arg we get the expressions and create the scalarized args
            my %arg_ctrs = map {
                (my $var, my $ctr, my $e) = @{$_};
                ($var, $ctr)
            } (@{$out_vars}, @{$map_args}, @{$non_map_args}, @{$acc_args});
            for my $var_name (@{$orig_args}) {
                my $ctr      = exists $arg_ctrs{$var_name} ? $arg_ctrs{$var_name} : 0;
                my $decl     = $stref->{'Subroutines'}{$fname}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                my $var_type = __toTyTraIRType($decl->{'Type'});
                my $exprs    = {};
                if (exists $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$var_name}{'Read'}) {
                    $exprs = $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$var_name}{'Read'}{'Exprs'};
                }
                else {
                    $exprs = $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$var_name}{'Write'}{'Exprs'};
                }
                if (scalar keys %{$exprs} > 0) {
                    my @tchunks =
                      map { "\t\t\t" . $var_type . ' %' . _scalarize_array_expr($_) . '_' . $ctr } sort keys %{$exprs};
                    @chunks = (@chunks, @tchunks);
                }
                else {
                    push @chunks, "\t\t\t" . $var_type . ' %' . $var_name . '_' . $ctr;
                }
            }
            push @chunks, "\t)";
            $tytra_ir_strs = [@{$tytra_ir_strs}, @chunks];

        }
        elsif ($node->{'NodeType'} eq 'Comment') {
            my $line = ' ; ' . $node->{'CommentStr'};
            push @{$tytra_ir_strs}, $line;
        }
        else {
            croak;
        }
    }

    # Indent
    my @tytracl_strs_indent = map {"\t$_"} @{$tytra_ir_strs};
    #

    # Wrap into main
    #
	my $main_rec          = $tytra_ir_ast->{'Main'};
#    my $main_in_args_str = scalar @{$main_rec->{'InArgs'}} > 1 ? join(',', @{$main_rec->{'InArgs'}}) :  $main_rec->{'InArgs'}->[0];
#    my $main_out_args_str = scalar @{$main_rec->{'OutArgs'}} > 1 ? join(',', @{$main_rec->{'OutArgs'}}) :  $main_rec->{'OutArgs'}->[0];
    my @main_args        = (@{$main_rec->{'InArgs'}}, @{$main_rec->{'OutArgs'}});
    my %main_args_hash   = map { $_ => 1 } @main_args;
    my @uniq_main_args   = sort keys %main_args_hash;
    my @main_args_indent = map {"\t\t\t$_"} @uniq_main_args;

    # We must add the types!
    #unshift @tytracl_strs_indent, '  let';
    my @top_decl_head = ('define void @kernelTop (');
    my @top_decl_tail = ('                       ) pipe', '{');
    my @top_close     = ("\t" . 'ret void', '}');
    @tytracl_strs_indent = (@top_decl_head, @main_args_indent, @top_decl_tail, @tytracl_strs_indent, @top_close);

#    # Add function type decls
#    #
#    for my $f (sort keys %{ $var_types }) {
#        #        say $f;
#        if (exists $var_types->{$f} and ref($var_types->{$f}) eq 'HASH' and exists $var_types->{$f}{'FunctionTypeDecl'}) {
#            unshift @tytracl_strs_indent,$var_types->{$f}{'FunctionTypeDecl'};
#        }
#    }
    #    say Dumper($main_rec);
    my $tytra_ir_str = join("\n", @tytracl_strs_indent);

    $stref->{'TyTraIR_Code'} = $tytra_ir_str;

    return $stref;
}    # END of _emit_TyTraIR()


sub __toTyTraIRType {
    (my $type) = @_;
croak if not defined $type;
    if ($type eq 'real') {
        return 'float32';
    }
    elsif ($type eq 'integer') {
        return 'i32';
    }
    else {
        # ad-hoc!
        return ucfirst($type);
    }
}

# Maybe I will be lazy and only support 1, 2, 3 and 4 dimension

sub _generate_TyTraIR_stencils {
    (my $stencil_patt) = @_;
    croak 'OBSOLETE';
    my $stencil_ast     = $stencil_patt->{'Accesses'};
    my $array_dims      = $stencil_patt->{'Dims'};
    my @stencil_pattern = map { [split(//, $_)] } sort keys %{$stencil_ast};

    #    say Dumper(@stencil_pattern). ' ; '.Dumper($array_dims );
    my $tytracl_stencils = [];
    for my $index_tuple (@stencil_pattern) {
        my @ranges       = ();
        my @lower_bounds = ();
        my $n_dims       = scalar @{$array_dims};
        for my $array_dim (@{$array_dims}) {
            push @ranges,       eval($array_dim->[1] . ' - ' . $array_dim->[0] . ' + 1');
            push @lower_bounds, $array_dim->[0];
        }
        if ($n_dims == 1) {
            push @{$tytracl_stencils}, F1D2C(@lower_bounds, @{$index_tuple});
        }
        elsif ($n_dims == 2) {

            #            say Dumper( (@ranges[0..1],@lower_bounds, @{$index_tuple}) );
            push @{$tytracl_stencils}, F2D2C($ranges[0], @lower_bounds, @{$index_tuple});
        }
        elsif ($n_dims == 3) {
            push @{$tytracl_stencils}, F3D2C(@ranges[0 .. 1], @lower_bounds, @{$index_tuple});
        }
        elsif ($n_dims == 4) {
            push @{$tytracl_stencils}, F4D2C(@ranges[0 .. 2], @lower_bounds, @{$index_tuple});
        }
        else {
            croak "Sorry, only up to 4 dimensions supported right now!";
        }
    }

    my $tytracl_stencils_str;

    return $tytracl_stencils;
}

sub _generate_TyTraIR_stencil {
    (my $stencil_patt, my $index_tuple_str) = @_;
    my $stencil_ast = $stencil_patt->{'Accesses'};
    my $array_dims  = $stencil_patt->{'Dims'};
    my $index_tuple = [split(/:/, $index_tuple_str)];

    #    say Dumper(@stencil_pattern). ' ; '.Dumper($array_dims );
    my $tytracl_stencils = [];

    my @ranges       = ();
    my @lower_bounds = ();
    my $n_dims       = scalar @{$array_dims};
    for my $array_dim (@{$array_dims}) {
        push @ranges,       eval($array_dim->[1] . ' - ' . $array_dim->[0] . ' + 1');
        push @lower_bounds, $array_dim->[0];
    }
    my $tytracl_stencils_str = '';
    if ($n_dims == 1) {
        $tytracl_stencils_str = F1D2C(@lower_bounds, @{$index_tuple});
    }
    elsif ($n_dims == 2) {

        #            say Dumper( (@ranges[0..1],@lower_bounds, @{$index_tuple}) );
        $tytracl_stencils_str = F2D2C($ranges[0], @lower_bounds, @{$index_tuple});
    }
    elsif ($n_dims == 3) {
        $tytracl_stencils_str = F3D2C(@ranges[0 .. 1], @lower_bounds, @{$index_tuple});
    }
    elsif ($n_dims == 4) {
        $tytracl_stencils_str = F4D2C(@ranges[0 .. 2], @lower_bounds, @{$index_tuple});
    }
    else {
        croak "Sorry, only up to 4 dimensions supported right now!";
    }

    return $tytracl_stencils_str;
}    # END of _generate_TyTraIR_stencil

# Add arguments to the signature of the main function
sub _addToMainSig {
    (my $stref, my $main_rec, my $node, my $lhs, my $rhs, my $fname) = @_;

    my $orig_args = $stref->{$stref->{'EmitAST'}}{'OrigArgs'};

    if ($node->{'NodeType'} eq 'StencilAppl') {

        # TODO: refactor!
        (my $var_name, my $ctr, my $ext) = @{$rhs->{'Var'}};
        if (exists $orig_args->{$var_name}
            and (  $orig_args->{$var_name} eq 'in'
                or $orig_args->{$var_name} eq 'inout')
          )
        {
            if ($ctr == 0 && $ext eq '') {
                $rhs->{'Var'} = _add_TyTraIR_type_to_var_rec($stref, $fname, $rhs->{'Var'}, 'Read');
                push @{$main_rec->{'InArgs'}}, _mkVarName($rhs->{'Var'});    #$var_name;
            }
        }
    }
    elsif ($node->{'NodeType'} eq 'Map') {
        my $out_var_recs = $lhs->{'Vars'};                                   #croak 'OUTVARS: '.Dumper($lhs);
        for my $out_var_rec (@{$out_var_recs}) {
            if (__isMainOutArg($out_var_rec, $stref)) {
                $out_var_rec = _add_TyTraIR_type_to_var_rec($stref, $fname, $out_var_rec, 'Write');
                push @{$main_rec->{'OutArgs'}}, _mkVarName($out_var_rec);
            }
        }
        my $map_arg_recs = $rhs->{'MapArgs'}{'Vars'};
        for my $map_var_rec (@{$map_arg_recs}) {
            if (__isMainInArg($map_var_rec, $stref)) {
                $map_var_rec = _add_TyTraIR_type_to_var_rec($stref, $fname, $map_var_rec, 'Read');
                push @{$main_rec->{'InArgs'}}, _mkVarName($map_var_rec);     # $var_name;
            }
        }
        my $non_map_arg_recs = $rhs->{'NonMapArgs'}{'Vars'};
        for my $non_map_var_rec (@{$non_map_arg_recs}) {
            if (__isMainInArg($non_map_var_rec, $stref)) {
                $non_map_var_rec = _add_TyTraIR_type_to_var_rec($stref, $fname, $non_map_var_rec, 'Read');
                push @{$main_rec->{'InArgs'}}, _mkVarName($non_map_var_rec);    #$var_name;
            }
        }
    }
    elsif ($node->{'NodeType'} eq 'Fold') {

        # Main question is: what is the initial value of the accumulator?
        # It can in practice be a constant or scalar variable
        # In general of course it could be just about anything.
        # The question at this point is only if it is a var or list of vars
        my $out_var_recs = $lhs->{'Vars'};    #croak 'OUTVARS: '.Dumper($lhs);
        for my $out_var_rec (@{$out_var_recs}) {
            if (__isMainOutArg($out_var_rec, $stref)) {
                $out_var_rec = _add_TyTraIR_type_to_var_rec($stref, $fname, $out_var_rec, 'Write');
                push @{$main_rec->{'OutArgs'}}, _mkVarName($out_var_rec);
            }
        }
        my $map_arg_recs = $rhs->{'FoldArgs'}{'Vars'};
        for my $map_var_rec (@{$map_arg_recs}) {
            if (__isMainInArg($map_var_rec, $stref)) {
                $map_var_rec = _add_TyTraIR_type_to_var_rec($stref, $fname, $map_var_rec, 'Read');
                push @{$main_rec->{'InArgs'}}, _mkVarName($map_var_rec);    # $var_name;
            }
        }
        my $non_map_arg_recs = $rhs->{'NonFoldArgs'}{'Vars'};
        for my $non_map_var_rec (@{$non_map_arg_recs}) {
            if (__isMainInArg($non_map_var_rec, $stref)) {
                $non_map_var_rec = _add_TyTraIR_type_to_var_rec($stref, $fname, $non_map_var_rec, 'Read');
                push @{$main_rec->{'InArgs'}}, _mkVarName($non_map_var_rec);    #$var_name;
            }
        }
        my $accs = $rhs->{'AccArgs'}{'Vars'};
        for my $non_map_var_rec (@{$accs}) {
            if (__isMainInArg($non_map_var_rec, $stref)) {
                $non_map_var_rec = _add_TyTraIR_type_to_var_rec($stref, $fname, $non_map_var_rec, 'Read');
                push @{$main_rec->{'InArgs'}}, _mkVarName($non_map_var_rec);    #$var_name;
            }
        }
    }
    elsif ($node->{'NodeType'} ne 'Comment' and $node->{'NodeType'} ne 'StencilDef') {
        croak "NodeType type " . $node->{'NodeType'} . ' not yet supported.';
    }
    return $main_rec;
}    # END of _addToMainSig()


# This is IDENTICAL to _add_TyTraCL_AST_entry, so I guess we could put this in Translation::TyTra::Common and call it add_TyTra_AST_entry() ?
sub _add_TyTraIR_AST_entry {
    (my $f, my $state, my $tytra_ir_ast, my $type, my $block_id, my $array_var, my $rw) = @_;

    if (not defined $array_var) {
        $array_var = '#dummy#';    # This I think is obsolete
    }

    if ($type eq 'INIT_AST') {
        if (not exists $tytra_ir_ast->{'UniqueVarCounters'}) {
            $tytra_ir_ast->{'UniqueVarCounters'} = {'!s' => 0};
        }
    }

    my $unique_var_counters = $tytra_ir_ast->{'UniqueVarCounters'};

    if ($type eq 'INIT_COUNTERS') {
        if (not exists $unique_var_counters->{$array_var}) {
            $unique_var_counters->{$array_var} = 0;
        }
    }
    if ($type eq 'STENCIL') {
        my $ctr_st = ++$unique_var_counters->{'!s'};
        push @{$tytra_ir_ast->{'Lines'}},
          { 'NodeType'     => 'StencilDef',
            'FunctionName' => $f,
            'Lhs'          => {'Ctr' => $ctr_st},
            'Rhs'          => {
                'StencilPattern' => {
                    'Accesses' => $state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$array_var}{$rw}{'Accesses'},
                    'Dims'     => $state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$array_var}{'Dims'}
                }
            }
          };
        my $ctr_in = $unique_var_counters->{$array_var};

        if (not exists $unique_var_counters->{"${array_var}_s"}) {
            $unique_var_counters->{"${array_var}_s"} = 0;
        }
        else {
            $unique_var_counters->{"${array_var}_s"}++;
        }
        my $ctr_sv = $unique_var_counters->{"${array_var}_s"};

        push @{$tytra_ir_ast->{'Lines'}},
          { 'NodeType'     => 'StencilAppl',
            'FunctionName' => $f,
            'Lhs'          => {'Var' => [$array_var, $ctr_sv, 's']},
            'Rhs'          => {'StencilCtr' => $ctr_st, 'Var' => [$array_var, $ctr_in, '']}
          };
        $tytra_ir_ast->{'Stencils'}{$array_var} = 1;
    }
    elsif ($type eq 'SELECT') {
        my $ctr_in = $unique_var_counters->{$array_var};

        push @{$tytra_ir_ast->{'Selects'}},
          { 'Lhs' => {'Var' => [$array_var, 'TODO', 'portion']},
            'Rhs' => {'Var' => [$array_var, $ctr_in, ''], 'Pattern' => ['TODO']}
          };
        if (not exists $unique_var_counters->{"${array_var}_portion"}) {
            $unique_var_counters->{"${array_var}_portion"} = 0;
        }
        else {
            $unique_var_counters->{"${array_var}_portion"}++;
        }
        $tytra_ir_ast->{'Portions'}{$array_var} = 1,;
    }
    elsif ($type eq 'INSERT') {
        my $ctr_in  = $unique_var_counters->{$array_var};
        my $ctr_out = ++$ctr_in;
        $unique_var_counters->{$array_var} = $ctr_out;

        push @{$tytra_ir_ast->{'Inserts'}},
          { 'Lhs' => {'Var' => [$array_var, $ctr_out, '']},
            'Rhs' => {'Var' => [$array_var, $ctr_in,  ''], 'Pattern' => ['TODO']},
          };
    }
    elsif ($type eq 'MAP') {
        my $node_type = 'Map';
        my %portions  = %{$tytra_ir_ast->{'Portions'}};
        my %stencils  = %{$tytra_ir_ast->{'Stencils'}};

        # so this provides the output and input tuples for a given $f
        # so for each var in $in_tup we need to get the counter, and for each var in $out_tup after that too.
        (my $out_tup, my $in_tup_maybe_dummies) = pp_links($state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Links'});
        $in_tup_maybe_dummies = $state->{'Subroutines'}{$f}{'Args'}{'In'};

        # This is incorrect because it does not return arguments that are used in conditions only
        my %accs     = ();
        my @acc_args = ();
        if ($FOLD) {
            @acc_args = @{$state->{'Subroutines'}{$f}{'Args'}{'Acc'}};
            if (scalar @acc_args > 0) {
                say "$f is a reduction " if $V;
                $node_type = 'Fold';
            }
            %accs = map { $_ => $_ } @acc_args;
        }

        # A slightly better way is to look at which arrays are covered entirely by a map operation
        my $n_dims = scalar keys %{$state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'LoopIters'}};

        my @in_tup             = grep { $_ !~ /^\!/ } @{$in_tup_maybe_dummies};
        my @in_tup_correct_dim = grep {
            exists $state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$_}
              and scalar @{$state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$_}{'Dims'}} >= $n_dims
        } @in_tup;

        my @in_tup_non_map_args = grep {
            (        (not exists $state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$_})
                  or (scalar @{$state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$_}{'Dims'}} < $n_dims)
            )
        } @in_tup;

		# non-fold args are non-map args that are not acc args
        my @in_tup_non_fold_args = grep { not exists $accs{$_} } @in_tup_non_map_args;

        my $in_tup_ms_ast = [
            map {
                if (not exists $unique_var_counters->{$_}) {
                    $unique_var_counters->{$_} = 0;
                }
                exists $stencils{$_} ? [$_, $unique_var_counters->{$_ . '_s'}, 's'] :    #
                  exists $portions{$_}
                  ? [$_, $unique_var_counters->{$_ . '_portion'}, 'portion']
                  : [$_, $unique_var_counters->{$_}, '']
            } @in_tup_correct_dim
        ];

        my $map_args_ms_ast  = $in_tup_ms_ast;
        my $fold_args_ms_ast = $in_tup_ms_ast;

#		my $in_tup_ms = [
#			map {
#				if (not exists $unique_var_counters->{$_}) {
#					$unique_var_counters->{$_}=0;
#				}
#				exists $stencils{$_} ?
#				$_.'_s'.$unique_var_counters->{$_.'_s'} : #
#				exists $portions{$_} ?
#				$_.'_portion_'.$unique_var_counters->{$_.'_portion'} :
#				$_.'_'. $unique_var_counters->{$_}
#			} @in_tup_correct_dim
#		];
        my @non_map_args_ms_ast = map {
            if (not exists $unique_var_counters->{$_}) {
                $unique_var_counters->{$_} = 0;
            }
                exists $stencils{$_} ? [$_, $unique_var_counters->{$_ . '_s'},       's']
              : exists $portions{$_} ? [$_, $unique_var_counters->{$_ . '_portion'}, 'portion']
              : [$_, $unique_var_counters->{$_}, '']
        } @in_tup_non_map_args;

        my @non_fold_args_ms_ast = map {
            if (not exists $unique_var_counters->{$_}) {
                $unique_var_counters->{$_} = 0;
            }
                exists $stencils{$_} ? [$_, $unique_var_counters->{$_ . '_s'},       's']
              : exists $portions{$_} ? [$_, $unique_var_counters->{$_ . '_portion'}, 'portion']
              : [$_, $unique_var_counters->{$_}, '']
        } @in_tup_non_fold_args;

        my @acc_args_ast = map {
            if (not exists $unique_var_counters->{$_}) {
                $unique_var_counters->{$_} = 0;
            }
            [$_, $unique_var_counters->{$_}, '']
        } @acc_args;

        my @out_tup_ast = ();
        for my $var (@{$out_tup}) {
            if (not exists $unique_var_counters->{$var}) {
                $unique_var_counters->{$var} = 0;
            }
            else {
                $unique_var_counters->{$var}++;
            }
            push @out_tup_ast, [$var, $unique_var_counters->{$var}, ''];
        }

        if ($node_type eq 'Map') {
            push @{$tytra_ir_ast->{'Lines'}}, {
                'NodeType'     => $node_type,
                'FunctionName' => $f,

                'Lhs' => {'Vars' => [@out_tup_ast],},
                'Rhs' => {
                    'Function'   => $f,
                    'NonMapArgs' => {'Vars' => [@non_map_args_ms_ast],},
                    'MapArgs'    => {'Vars' => $map_args_ms_ast,}
                }
            };
        }
        elsif ($FOLD and $node_type eq 'Fold') {
            push @{$tytra_ir_ast->{'Lines'}}, {
                'NodeType'     => 'Fold',
                'FunctionName' => $f,

                'Lhs' => {'Vars' => [@out_tup_ast],},
                'Rhs' => {
                    'Function'    => $f,
                    'AccArgs'     => {'Vars' => [@acc_args_ast],},
                    'NonFoldArgs' => {'Vars' => [@non_fold_args_ms_ast],},
                    'FoldArgs'    => {'Vars' => $fold_args_ms_ast,}
                }
            };
        }
    }
    elsif ($type eq 'MAIN') {
        $tytra_ir_ast->{'MainFunction'} = $f;
        for my $arg (@{$state->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'}}) {
            $tytra_ir_ast->{'OrigArgs'}{$arg} = $state->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'};
        }
    }

    return $tytra_ir_ast;
}    # END of _add_TyTraIR_AST_entry

sub _scalarize_array_expr {
    (my $expr_str) = @_;
    my $var_str = $expr_str;

    #$var_str=~s/[\(,]/_/g;
    #$var_str=~s/\)//g;
    #$var_str=~s/\+/p/g;
    #$var_str=~s/\-/m/g;
    #$var_str=~s/\*/t/g;
    $var_str =~ tr/(,+\-*)/__pmt /;
    $var_str =~ s/\s+//g;
    return $var_str;

}    # END of _scalarize_array_expr


# sub _mkVarName {
#     (my $rec) = @_;
#     (my $v, my $c, my $e, my $t, my $s) = @{$rec};
#     if   (not defined $t) { $t = ''; }
#     else                  { $t = "$t "; }
#     if (defined $s) { $v = $s }
#     if ($e eq '') {
#         return "$t%${v}_${c}";
#     }
#     else {
#         return "$t%${v}_${e}_${c}";
#     }
# }    # END of _mkVarName()

sub _get_TyTraIR_type {
    (my $stref, my $fname, my $var_name) = @_;
    my $var_rec  = $stref->{'Subroutines'}{$fname}{'DeclaredOrigArgs'}{'Set'}{$var_name};
    my $var_type = __toTyTraIRType($var_rec->{'Type'});
    return $var_type;
}    # END of _get_TyTraIR_type

sub _add_TyTraIR_type_to_var_rec {
    (my $stref, my $fname, my $var_rec, my $rw) = @_;

    my $var_name      = $var_rec->[0];
    my $scal_var_name = $var_name;
    if (exists $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$var_name}) {
        my $exprs           = $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$var_name}{$rw}{'Exprs'};
        my $stencil_pattern = {
            'Accesses' => $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$var_name}{$rw}{'Accesses'},
            'Dims'     => $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$var_name}{'Dims'}
        };

        for my $expr (keys %{$exprs}) {
            my $k       = $exprs->{$expr};
            my $stencil = _generate_TyTraIR_stencil($stencil_pattern, $k);
            if ($stencil == 0) {
                $scal_var_name = _scalarize_array_expr($expr);
                last;
            }
        }
    }

    my $var_type = _get_TyTraIR_type($stref, $fname, $var_name);
    push @{$var_rec}, $var_type;
    $var_rec->[4] = $scal_var_name;
    return $var_rec;
}    # END of _add_TyTraIR_type_to_var_rec

1;

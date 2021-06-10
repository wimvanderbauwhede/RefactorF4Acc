package RefactorF4Acc::Translation::TyTraCL;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw( pass_wrapper_subs_in_module );
use RefactorF4Acc::Refactoring::Fixes qw( remove_redundant_arguments_and_fix_intents );
use RefactorF4Acc::Translation::TyTra::Common qw(
  pp_links
  __isMainInArg
  __isMainOutArg
  _mkVarName
  _mkSigArgName
    mkMap
    mkFold
    mkStencilDef
    mkStencilAppl
    mkComment
    addTypeDecl   
  F3D2C
  F2D2C
  F1D2C
  F4D2C
);

use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( identify_array_accesses_in_exprs );
#
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "2.1.1";

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
  &emit_TyTraCL
  &construct_TyTraCL_AST_Main_node
  &generate_TyTraCL_stencils
  &_add_TyTraCL_AST_entry
  &_emit_TyTraCL_FunctionSigs
  &__toTyTraCLType
);

# If set to 0, Folds are identified as Maps (for dev/debug)
# The way a Fold is detected is by detecting an accumulation operation ('Acc')

# The NodeType is set in _add_TyTraCL_AST_entry() which is called in Analysis::ArrayAccessPatterns
# In Analysis::ArrayAccessPatterns, there is a routine _classify_accesses_and_emit_AST which runs this routine via
#	$ast_emitter = $stref->{$stref->{'EmitAST'}}{'ASTEmitter'}
#   $ast_to_emit = $ast_emitter->( $f,  $state,  $ast_to_emit, 'INIT_AST')
#
# This routine is called at the end of identify_array_accesses_in_exprs()

our $FOLD = 1;

sub pass_emit_TyTraCL {
    (my $stref, my $module_name) = @_;

    # WV: I think Selects and Inserts should be in Lines but I'm not sure
    $stref->{'EmitAST'}     = 'TyTraCL_AST';
    $stref->{'TyTraCL_AST'} = {
        'Lines'        => [],
        'Selects'      => [],
        'Inserts'      => [],
        'Stencils'     => {},
        'Portions'     => {},
        'Main'         => {},
        'MainFunction' => 'main',
        'FunctionArgsMappings' =>{}, # This is very simply for every $f a map of every arg to its location in the original args list
        'ASTEmitter'   => \&_add_TyTraCL_AST_entry
    };
    $stref = pass_wrapper_subs_in_module(
        $stref, $module_name,

        # module-specific passes
        [],

        # subroutine-specific passes
        [
#				[ sub { (my $stref, my $f)=@_;  alias_ordered_set($stref,$f,'DeclaredOrigArgs','DeclaredOrigArgs'); } ],
            # All Fixes are off by default, list them in $Config{'FIXES'} to enable them                
            [\&remove_redundant_arguments_and_fix_intents],
            [\&identify_array_accesses_in_exprs ], # This returns TyTraCL_AST using _add_TyTraCL_AST_entry
        ]
    );

# say Dumper $stref->{'TyTraCL_AST'}{'Lines'};
    $stref = construct_TyTraCL_AST_Main_node($stref);
    # This is to emit Haskell later, could maybe go in a separate pass
    $stref = _emit_TyTraCL_FunctionSigs($stref);    
    # carp Dumper($stref->{'TyTraCL_FunctionSigs'});#{$f}=[$non_map_arg_str,$acc_arg_str,$map_arg_str, $lhs_str];
    # $stref = _add_VE_to_AST($stref);
    $stref = emit_TyTraCL($stref);
    my $tytracl_str = $stref->{'TyTraCL_Code'};
    # say $tytracl_str;
    # carp Dumper($stref->{'TyTraCL_AST'}{'Lines'});
    write_out($tytracl_str, 'STDOUT');


    
    # This makes sure that no fortran is emitted by emit_all()
    $stref->{'SourceContains'} = {};
    return $stref;
}    # END of pass_emit_TyTraCL()

sub construct_TyTraCL_AST_Main_node {
    (my $stref) = @_;

    # FIXME: we ignore Selects and Inserts for now.
    # We need the superkernel as the main, and we must identify its input and output arguments
    # Input args have Ctr==0 on the Rhs
    # Output args $arg have Ctr == $tytracl_ast->{'UniqueVarCounters'}{$arg}
    my $tytracl_ast = $stref->{'TyTraCL_AST'};

    my $main_rec = {
        'NodeType'     => 'MainFunction',
        'InArgs'       => [],
        'OutArgs'      => [],
        'InArgsTypes'  => {},
        'OutArgsTypes' => {},
        'MainFunction' => $tytracl_ast->{'MainFunction'},

        # 'Stencils'=>{},
        'VarTypes' => {}
    };
    my $var_types = {};
    my $stencils  = {};
    for my $node (@{$tytracl_ast->{'Lines'}}) {
        my $fname = $node->{'FunctionName'};
        my $lhs   = $node->{'Lhs'};
        my $rhs   = $node->{'Rhs'};

        # This is not an Emitter step
        $main_rec = _addToMainSig($stref, $main_rec, $node, $lhs, $rhs, $fname);
        ($var_types, $stencils) =
          _addToVarTypesAndStencils($stref, $var_types, $stencils, $node, $lhs, $rhs, $fname, \&__toTyTraCLType);
    }

    # $main_rec->{'Stencils'}=$stencils;
    $main_rec->{'VarTypes'} = $var_types;

    # say Dumper($main_rec);
    $stref->{'TyTraCL_AST'}{'Main'} = $main_rec;

    return $stref;
} # END of construct_TyTraCL_AST_Main_node




sub emit_TyTraCL {
    (my $stref) = @_;

    # FIXME: we ignore Selects and Inserts for now.

    # We need the superkernel as the main, and we must identify its input and output arguments
    # Input args have Ctr==0 on the Rhs
    # Output args $arg have Ctr == $tytracl_ast->{'UniqueVarCounters'}{$arg}
    my $tytracl_ast  = $stref->{'TyTraCL_AST'};
    my $tytracl_strs = [];

    for my $node (@{$tytracl_ast->{'Lines'}}) {
        my $fname = $node->{'FunctionName'};
        my $lhs   = $node->{'Lhs'};
        my $rhs   = $node->{'Rhs'};

        # These are never arguments of the main function
        if ($node->{'NodeType'} eq 'StencilDef') {
            my $ctr = $lhs->{'Ctr'};
            my $stencils_          = generate_TyTraCL_stencils($rhs->{'StencilPattern'});
            my $stencil_definition = '[' . join(',', @{$stencils_}) . ']';

            my $line = "s$ctr = $stencil_definition";
            push @{$tytracl_strs}, $line;
        }

        # The stencil itself should be skipped but the others can be main args
        # The value returned from a stencil application should never be an output arg
        # Because of the way we identify and generate stencils, the stencil arg will always be a var, not a tuple
        elsif ($node->{'NodeType'} eq 'StencilAppl') {
            my $lhs_var = _mkVarName($lhs->{'Var'});
            my $rhs_var = _mkVarName($rhs->{'Var'});
            (my $var_name, my $ctr, my $ext) = @{$rhs->{'Var'}};
            my $stencil_ctr = $rhs->{'StencilCtr'};
            my $line        = "$lhs_var = stencil s$stencil_ctr $rhs_var";
            push @{$tytracl_strs}, $line;
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
            my $lhs_str =
              (scalar @{$out_vars} == 1)
              ? _mkVarName($out_vars->[0]) . ' = '
              : '(' . join(',', map { _mkVarName($_) } @{$out_vars}) . ') = unzipt $';

            my $non_map_arg_str =
                (scalar @{$non_map_args} == 0) ? ''
              : (scalar @{$non_map_args} == 1) ? _mkVarName($non_map_args->[0])
              :                                  '(' . join(',', map { _mkVarName($_) } @{$non_map_args}) . ')';
            my $map_arg_str =
              (scalar @{$map_args} == 1)
              ? _mkVarName($map_args->[0])
              : '(zipt (' . join(',', map { _mkVarName($_) } @{$map_args}) . '))';
            my $f     = $rhs->{'Function'};
            my $f_str = $non_map_arg_str eq '' ? $f : "($f $non_map_arg_str)";
            my $line  = "$lhs_str map $f_str $map_arg_str";
            push @{$tytracl_strs}, $line;
        }
        elsif ($node->{'NodeType'} eq 'Fold') {
            my $out_vars     = $lhs->{'Vars'};
            my $map_args     = $rhs->{'FoldArgs'}{'Vars'};
            my $non_map_args = $rhs->{'NonFoldArgs'}{'Vars'};
            my $acc_args     = $rhs->{'AccArgs'}{'Vars'};

            my $lhs_str =
              (scalar @{$out_vars} == 1)
              ? _mkVarName($out_vars->[0]) . ' = '
              : '(' . join(',', map { _mkVarName($_) } @{$out_vars}) . ') = '; # This was unzipt $ but a fold returns a scalar by definition

            my $non_map_arg_str =
                (scalar @{$non_map_args} == 0) ? ''
              : (scalar @{$non_map_args} == 1) ? _mkVarName($non_map_args->[0])
              :                                  '(' . join(',', map { _mkVarName($_) } @{$non_map_args}) . ')';

            my $acc_arg_str =
              (scalar @{$acc_args} == 1)
              ? _mkVarName($acc_args->[0])
              : '(' . join(',', map { _mkVarName($_) } @{$acc_args}) . ')';
            my $map_arg_str =
              (scalar @{$map_args} == 1)
              ? _mkVarName($map_args->[0])
              : '(zipt (' . join(',', map { _mkVarName($_) } @{$map_args}) . '))';

            my $f     = $rhs->{'Function'};
            my $f_str = $non_map_arg_str eq '' ? $f : "($f $non_map_arg_str)";
            my $line  = "$lhs_str fold $f_str $acc_arg_str $map_arg_str";
            push @{$tytracl_strs}, $line;
        }
        elsif ($node->{'NodeType'} eq 'Comment') {
            my $line = ' -- ' . $node->{'CommentStr'};
            push @{$tytracl_strs}, $line;
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
    my $main_rec          = $tytracl_ast->{'Main'};
    # croak Dumper $tytracl_ast;
    my $in_args_types     = $main_rec->{'InArgsTypes'};
    my @in_arg_type_decls = ();
    my @in_arg_ftypes     = ();
    for my $in_arg (@{$main_rec->{'InArgs'}}) {
        push @in_arg_type_decls, "$in_arg :: " . emit_TyTraCLType($in_args_types->{$in_arg});
        push @in_arg_ftypes,     emit_TyTraCLType($in_args_types->{$in_arg});
    }
    my $in_arg_ftypes_str = '(' . join(',', @in_arg_ftypes) . ')';

    my $out_args_types     = $main_rec->{'OutArgsTypes'};
    my @out_arg_type_decls = ();
    my @out_arg_ftypes     = ();
    for my $out_arg (@{$main_rec->{'OutArgs'}}) {    #sort keys %{$out_args_types}){
        push @out_arg_type_decls, "$out_arg :: " . emit_TyTraCLType($out_args_types->{$out_arg});
        push @out_arg_ftypes,     emit_TyTraCLType($out_args_types->{$out_arg});
    }
    my $out_arg_ftypes_str = '(' . join(',', @out_arg_ftypes) . ')';

    my $main_in_args_str =
      scalar @{$main_rec->{'InArgs'}} > 1 ? '(' . join(',', @{$main_rec->{'InArgs'}}) . ')' : $main_rec->{'InArgs'}->[0];
    my $main_out_args_str =
      scalar @{$main_rec->{'OutArgs'}} > 1 ? '(' . join(',', @{$main_rec->{'OutArgs'}}) . ')' : 
      scalar @{$main_rec->{'OutArgs'}} ==1 
      ? $main_rec->{'OutArgs'}->[0]
      : '()';

    unshift @tytracl_strs_indent, '  let';
    unshift @tytracl_strs_indent, "main $main_in_args_str =";
    unshift @tytracl_strs_indent, "main :: $in_arg_ftypes_str -> $out_arg_ftypes_str";
    unshift @tytracl_strs_indent, "";
    push @tytracl_strs_indent, '  in';
    push @tytracl_strs_indent, "    $main_out_args_str";

    # Add function type decls
    my $var_types = $main_rec->{'VarTypes'};
    for my $f (sort keys %{$var_types}) {
        if (exists $var_types->{$f} and ref($var_types->{$f}) eq 'HASH' and exists $var_types->{$f}{'FunctionTypeDecl'}) {
            unshift @tytracl_strs_indent, _emit_FunctionTypeDecl($var_types->{$f}{'FunctionTypeDecl'});
        }
    }
    @tytracl_strs_indent = (@in_arg_type_decls, '', @out_arg_type_decls, '', @tytracl_strs_indent);
    my $tytracl_str = join("\n", @tytracl_strs_indent);
    # $stref->{'TyTraCL_CodeLines'} = \@tytracl_strs_indent; 
    $stref->{'TyTraCL_Code'} = $tytracl_str;
    return $stref;
}    # END of emit_TyTraCL()

sub emit_TyTraCLType {
    my ($decl) = @_;
    return join(' ', @{$decl});
}    # END of emit_TyTraCLType

sub _emit_FunctionTypeDecl {
    my ($fdecl) = @_;
    croak ref($fdecl) . ' : ' . Dumper $fdecl if ref($fdecl) ne 'ARRAY';    #->[0]=~/reduce/;
    my $f        = shift @{$fdecl};
    my @argdecls = ();
    for my $argdecl (@{$fdecl}) {
        if (scalar @{$argdecl} == 1) {
            push @argdecls, emit_TyTraCLType(ref($argdecl->[0]) eq 'ARRAY' ? $argdecl->[0] : [$argdecl->[0]]);
        }
        elsif (scalar @{$argdecl} > 1) {
            my $tup_decl = '(' . join(',', map { emit_TyTraCLType(ref($_) eq 'ARRAY' ? $_ : [$_]) } @{$argdecl}) . ')';
            push @argdecls, $tup_decl;
        }
        ;                                                                   #unless scalar @{$argdecl} == 0;
    }
    my $f_type_decl = "$f :: " . join(' -> ', @argdecls);

    # say $f_type_decl;
    return $f_type_decl;
}    # END of _emit_FunctionTypeDecl


sub __toTyTraCLScalarType {
    (my $type) = @_;

    if ($type eq 'real') {
        return 'Float';
    }
    elsif ($type eq 'integer') {
        return 'Int';
    }
    else {
        # ad-hoc!
        return ucfirst($type);
    }
}

# Return the type as a datastructure and use emit_TyTraCLType
# What it returns is [$scalar_type] | ['Vec', $vec_sz, $scalar_type] | ['SVec', $vec_sz, $scalar_type] 
# Vec is only used for streams, anything else is SVec
sub __toTyTraCLType {
    (my $type, my $array_dims, my $non) = @_;
    # If $non is not defined, set it to 0;
    $non = 0 unless defined $non;    
    # If $non is not 0, set it to 1
    $non = 1 unless "$non" eq 0;
    croak "TYPE $type is not defined" if not defined $type;
    if (not defined $array_dims or scalar @{$array_dims} == 0) {    # Scalar
        if ($type eq 'real') {
            return ['Float'];
        }
        elsif ($type eq 'integer') {
            return ['Int'];
        }
        else {
            # ad-hoc!
            return [ucfirst($type)];
        }
    }
    else {                                                          # Vector
        my @ranges = ();
        # carp Dumper $array_dims;
        for my $array_dim (@{$array_dims}) {
            push @ranges, '(' . $array_dim->[1] . '- ' . $array_dim->[0] . '+1)';
        }
        # carp join('*', @ranges);
        my $vec_sz      = eval(join('*', @ranges));                 # FIXME: needs proper constant folding here!
        my $scalar_type = ucfirst($type);
        if ($type eq 'real') {
            $scalar_type = 'Float';
        }
        elsif ($type eq 'integer') {
            $scalar_type = 'Int';
        }

        my $tycl_type = [$non==1 ? 'SVec' : 'Vec', $vec_sz, $scalar_type];
        # carp Dumper $tycl_type;
        # WV 2019-08-12 the '0' below feels hacky
        # say $tycl_type;
        return $tycl_type;
    }

}    # END of __toTyTraCLType


# Maybe I will be lazy and only support 1, 2, 3 and 4 dimension

sub generate_TyTraCL_stencils {
    (my $stencil_patt) = @_;

# I added this mainly to make it easy to create ASTs using the mk* functions
    if (exists $stencil_patt->{'Pattern'}) {
        return $stencil_patt->{'Pattern'};
    }
# Accesses:
#   '-1:0' => [
#     {
#       'j:0' => [
#         1,
#         -1
#       ]
#     },
#     {
#       'k:1' => [
#         1,
#         0
#       ]
#     }
#   ],
# Dims: 
#   [['0',501],['0',501]]
    my $stencil_ast     = $stencil_patt->{'Accesses'};
    # say Dumper $stencil_ast;
    my $array_dims      = $stencil_patt->{'Dims'};

    # Because of the way this is constructed, the key is a stringification of the offsets in the order as they occur in the original array access
    # say 'OFFSET STRS: ',join (', ', sort keys %{$stencil_ast});
    my @stencil_pattern = map { [split(/:/, $_)] } sort keys %{$stencil_ast};

    my $tytracl_stencils = [];
    for my $index_tuple (@stencil_pattern) {
        my @ranges       = ();
        my @lower_bounds = ();
        my $n_dims       = scalar @{$array_dims};
        for my $array_dim (@{$array_dims}) {
            push @ranges,       eval($array_dim->[1] . ' - ' . $array_dim->[0] . ' + 1');
            push @lower_bounds, $array_dim->[0] - 1; # -1 because an array 1:500 in Fortran has a zero position of (1,1,1), not (0,0,0)
        }
        if ($n_dims == 1) {
            push @{$tytracl_stencils}, F1D2C(@lower_bounds, @{$index_tuple});
        }
        elsif ($n_dims == 2) {
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
# say 'LINEAR OFFSETS: ',join (', ', @{$tytracl_stencils} );
# say 'SORTED LINEAR OFFSETS: ',join (', ', sort numeric @{$tytracl_stencils} );
    return [sort numeric @{$tytracl_stencils}];
    # return $tytracl_stencils;
}    # END of generate_TyTraCL_stencils

# WV20190813 It would be better to return a datastructure with the original info and to the emit via a separate function
sub _addToVarTypesAndStencils {
    (my $stref, my $var_types, my $stencils, my $node, my $lhs, my $rhs, my $fname, my $type_formatter) = @_;

# say "<$fname>";
    if ($node->{'NodeType'} eq 'StencilDef') {
        my $s_var = $lhs->{'Ctr'};
        my $s_size =
          exists $rhs->{'StencilPattern'}{'Pattern'}
          ? scalar @{$rhs->{'StencilPattern'}{'Pattern'}}
          : scalar keys %{$rhs->{'StencilPattern'}{'Accesses'}};
        $stencils->{$s_var} = $s_size;
    }
    elsif ($node->{'NodeType'} eq 'StencilAppl') {

        # Here we enter the stencil from the Lhs in the table
        my $s_var = _mkVarName($lhs->{'Var'});

        # A little problem: we don't quite know $f at this point, or do we? I'll need a 'FunctionName' node
        my $f            = $fname;
        my $var_name     = $rhs->{'Var'}[0];
        my $var_rec      = $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
        my $var_type     = $type_formatter->($var_rec->{'Type'});
        my @s_type_array = ();
        
        if (not exists $stencils->{$rhs->{'StencilCtr'}}) {
            carp $rhs->{'StencilCtr'};
        croak Dumper $stencils;
        }
        for (1 .. $stencils->{$rhs->{'StencilCtr'}}) {
            push @s_type_array, $var_type;
        }
        my $s_type = '(' . join(',', @s_type_array) . ')';

        # Or rather, use SVec:
        $s_type = ['SVec', $stencils->{$rhs->{'StencilCtr'}}, $var_type->[0]];

        # This is odd compared to the other nodes
        $var_types->{$s_var} = $s_type;
    }
    elsif ($node->{'NodeType'} eq 'Map') {
        # Output arguments can't be stencil, so only DeclaredOrigArgs
        my $out_args = $lhs->{'Vars'};
        my $f        = $fname;
        my @out_arg_types_array;
        for my $out_arg_rec (@{$out_args}) {
            my $var_name = $out_arg_rec->[0];
            my $var_rec  = $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
            my $var_type = $type_formatter->($var_rec->{'Type'});
            push @out_arg_types_array, $var_type;
        }
        $var_types->{$f}{'ReturnType'} = [@out_arg_types_array];

        # This should always be a tuple and the values can only be scalars
        my $map_args            = $rhs->{'MapArgs'}{'Vars'};
        my @map_arg_types_array = ();
        my %map_arg_types       = ();
        for my $map_arg_rec (@{$map_args}) {
            my $var_name      = $map_arg_rec->[0];
            my $maybe_stencil = _mkVarName($map_arg_rec);
            if (exists $var_types->{$maybe_stencil}) {
                push @map_arg_types_array, $var_types->{$maybe_stencil};
                $map_arg_types{$var_name} = $var_types->{$maybe_stencil};
            }
            else {
                my $var_rec  = $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                my $var_type = $type_formatter->($var_rec->{'Type'});

                # say 'DECL: '. $var_name.' :: '.emit_TyTraCLType( $var_type);
                push @map_arg_types_array, $var_type;
                $map_arg_types{$var_name} = $var_type;
            }
        }

        $var_types->{$f}{'MapArgType'}    = [@map_arg_types_array];
        $var_types->{$f}{'MapArgTypeMap'} = \%map_arg_types;

        # This should always be a tuple and the values can actually be arrays
        my $non_map_args            = $rhs->{'NonMapArgs'}{'Vars'};
        my @non_map_arg_types_array = ();
        for my $non_map_arg_rec (@{$non_map_args}) {
            my $var_name = $non_map_arg_rec->[0];
            my $var_rec  = $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
            # carp Dumper $var_rec;
            my $var_type = $type_formatter->($var_rec->{'Type'});
            push @non_map_arg_types_array, $var_type;
        }
        $var_types->{$f}{'NonMapArgType'} = [@non_map_arg_types_array];
        my @arg_types = ();
        push @arg_types, $var_types->{$f}{'NonMapArgType'};
        push @arg_types, $var_types->{$f}{'MapArgType'};
        push @arg_types, $var_types->{$f}{'ReturnType'};

        $var_types->{$f}{'FunctionTypeDecl'} = [$f, @arg_types];

    }
    elsif ($node->{'NodeType'} eq 'Fold') {

        # Main question is: what is the initial value of the accumulator?
        # It can in practice be a constant or scalar variable
        # In general of course it could be just about anything.
        # The question at this point is only if it is a var or list of vars
#            croak('TODO: fold');
        # Output arguments can't be stencil, so only DeclaredOrigArgs
        my $out_args = $lhs->{'Vars'};
        my $f        = $fname;
        my @out_arg_types_array;
        for my $out_arg_rec (@{$out_args}) {
            my $var_name = $out_arg_rec->[0];
            my $var_rec  = $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
            my $var_type = $type_formatter->($var_rec->{'Type'});
            push @out_arg_types_array, $var_type;
        }
        $var_types->{$f}{'ReturnType'} = [@out_arg_types_array];

        # This should always be a tuple and the values can only be scalars
        my $map_args            = $rhs->{'FoldArgs'}{'Vars'};
        my @map_arg_types_array = ();
        for my $map_arg_rec (@{$map_args}) {
            my $maybe_stencil = _mkVarName($map_arg_rec);
            if (exists $var_types->{$maybe_stencil}) {
                push @map_arg_types_array, $var_types->{$maybe_stencil};
            } else {
                my $var_name = $map_arg_rec->[0];
                
                my $var_rec  = $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                
                my $var_type = $type_formatter->($var_rec->{'Type'});
                push @map_arg_types_array, $var_type;
            }
        }

        $var_types->{$f}{'FoldArgType'} = [@map_arg_types_array];

        # This should always be a tuple and the values can actually be arrays
        my $non_map_args = $rhs->{'NonFoldArgs'}{'Vars'};

        my @non_map_arg_types_array = ();
        for my $non_map_arg_rec (@{$non_map_args}) {            
            my $var_name = $non_map_arg_rec->[0];
            my $var_rec  = $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
            my $var_type = $type_formatter->($var_rec->{'Type'});
            push @non_map_arg_types_array, $var_type;
        }


        $var_types->{$f}{'NonFoldArgType'} = [@non_map_arg_types_array];

        my $acc_args            = $rhs->{'AccArgs'}{'Vars'};
        my @acc_arg_types_array = ();
        for my $acc_arg_rec (@{$acc_args}) {

            my $var_name = $acc_arg_rec->[0];
            if ($var_name ne '') {
                my $var_rec  = $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                my $var_type = $type_formatter->($var_rec->{'Type'});
                push @acc_arg_types_array, $var_type;
            }
        }

        $var_types->{$f}{'AccArgType'} = [@acc_arg_types_array];

        my @arg_types = ();
        push @arg_types, $var_types->{$f}{'NonFoldArgType'};
        push @arg_types, $var_types->{$f}{'AccArgType'};
        push @arg_types, $var_types->{$f}{'FoldArgType'};
        push @arg_types, $var_types->{$f}{'ReturnType'};

        $var_types->{$f}{'FunctionTypeDecl'} = [$f, @arg_types];


    }
    elsif ($node->{'NodeType'} ne 'Comment' and $node->{'NodeType'}) {
        croak "NodeType type " . $node->{'NodeType'} . ' not yet supported.';
    }


    return ($var_types, $stencils);
}    # END of _addToVarTypesAndStencils()

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
                my $var_name =_mkVarName($rhs->{'Var'});                 
                push @{$main_rec->{'InArgs'}}, $var_name;
                $main_rec = __add_to_MainArgTypes('InArgs', $stref, $fname, $rhs->{'Var'}, $main_rec);
            }
        }
    }
    elsif ($node->{'NodeType'} eq 'Map') {
        my $out_var_recs = $lhs->{'Vars'};
        for my $out_var_rec (@{$out_var_recs}) {
            if (__isMainOutArg($out_var_rec, $stref)) {
                push @{$main_rec->{'OutArgs'}}, _mkVarName($out_var_rec);
                $main_rec = __add_to_MainArgTypes('OutArgs', $stref, $fname, $out_var_rec, $main_rec);
            }
        }
        my $map_arg_recs = $rhs->{'MapArgs'}{'Vars'};
        for my $map_var_rec (@{$map_arg_recs}) {
            if (__isMainInArg($map_var_rec, $stref)) {
                my $var_name = $map_var_rec->[0];
                push @{$main_rec->{'InArgs'}}, _mkVarName($map_var_rec);
                $main_rec = __add_to_MainArgTypes('InArgs', $stref, $fname, $map_var_rec, $main_rec);
            }
        }
        my $non_map_arg_recs = $rhs->{'NonMapArgs'}{'Vars'};
        for my $non_map_var_rec (@{$non_map_arg_recs}) {
            if (__isMainInArg($non_map_var_rec, $stref)) {
                my $var_name = $non_map_var_rec->[0];
                push @{$main_rec->{'InArgs'}}, _mkVarName($non_map_var_rec);
                $main_rec = __add_to_MainArgTypes('InArgs', $stref, $fname, $non_map_var_rec, $main_rec, 'Non');
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
                push @{$main_rec->{'OutArgs'}}, _mkVarName($out_var_rec);
                $main_rec = __add_to_MainArgTypes('OutArgs', $stref, $fname, $out_var_rec, $main_rec);
            }
        }
        my $map_arg_recs = $rhs->{'FoldArgs'}{'Vars'};
        for my $map_var_rec (@{$map_arg_recs}) {
            if (__isMainInArg($map_var_rec, $stref)) {
                my $var_name = $map_var_rec->[0];
                push @{$main_rec->{'InArgs'}}, _mkVarName($map_var_rec);
                $main_rec = __add_to_MainArgTypes('InArgs', $stref, $fname, $map_var_rec, $main_rec);
            }
        }
        my $non_map_arg_recs = $rhs->{'NonFoldArgs'}{'Vars'};
        for my $non_map_var_rec (@{$non_map_arg_recs}) {
            if (__isMainInArg($non_map_var_rec, $stref)) {
                my $var_name = $non_map_var_rec->[0];
                push @{$main_rec->{'InArgs'}}, _mkVarName($non_map_var_rec);    #$'InArgTypes' => {},var_name;
                $main_rec = __add_to_MainArgTypes('InArgs', $stref, $fname, $non_map_var_rec, $main_rec,'Non');
            }
        }
        my $accs = $rhs->{'AccArgs'}{'Vars'};
        for my $acc_var_rec (@{$accs}) {

            if (__isMainInArg($acc_var_rec, $stref)) {
                my $var_name = $acc_var_rec->[0];
                if ($var_name ne '') {
                    push @{$main_rec->{'InArgs'}}, _mkVarName($acc_var_rec);
                    $main_rec = __add_to_MainArgTypes('InArgs', $stref, $fname, $acc_var_rec, $main_rec);
                }
            }
        }
    }
    elsif ($node->{'NodeType'} ne 'Comment' and $node->{'NodeType'} ne 'StencilDef') {
        croak "NodeType type " . $node->{'NodeType'} . ' not yet supported.';
    }

    return $main_rec;
}    # END of _addToMainSig()

# The NodeType is set in _add_TyTraCL_AST_entry() which is called in Analysis::ArrayAccessPatterns
# In Analysis::ArrayAccessPatterns, there is a routine _classify_accesses_and_emit_AST which runs this routine via
#	$ast_emitter = $stref->{$stref->{'EmitAST'}}{'ASTEmitter'}
#   $ast_to_emit = $ast_emitter->( $f,  $state,  $ast_to_emit, 'INIT_AST')
#
# This routine is called at the end of identify_array_accesses_in_exprs()

sub _add_TyTraCL_AST_entry {
    (my $f, my $state, my $tytracl_ast, my $type, my $block_id, my $array_var, my $rw) = @_;

    if (not defined $array_var) {
        $array_var = '#dummy#';
    }
    if ($type eq 'INIT_AST') {
        if (not exists $tytracl_ast->{'UniqueVarCounters'}) {
            $tytracl_ast->{'UniqueVarCounters'} = {'!s' => 0};
        }
    }

    my $unique_var_counters = $tytracl_ast->{'UniqueVarCounters'};

    if ($type eq 'INIT_COUNTERS') {
        if (not exists $unique_var_counters->{$array_var}) {
            $unique_var_counters->{$array_var} = 0;
        }
    }

    if ($type eq 'STENCIL') {
        my $ctr_st = ++$unique_var_counters->{'!s'};
        push @{$tytracl_ast->{'Lines'}},
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
        my $s_sz = scalar keys %{$state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$array_var}{$rw}{'Accesses'}};
        # my $s_sz = scalar @{$state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$array_var}{'Dims'}};
        # say "STENCIL $array_var : $s_sz ".Dumper($state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$array_var}{'Dims'});
        my $ctr_in = $unique_var_counters->{$array_var};

        if (not exists $unique_var_counters->{"${array_var}_s"}) {
            $unique_var_counters->{"${array_var}_s"} = 0;
        }
        else {
            $unique_var_counters->{"${array_var}_s"}++;
        }
        my $ctr_sv = $unique_var_counters->{"${array_var}_s"};

        push @{$tytracl_ast->{'Lines'}},
          { 'NodeType'     => 'StencilAppl',
            'FunctionName' => $f,
            'Lhs'          => {'Var' => [$array_var, $ctr_sv, 's']},
            'Rhs'          => {
                'StencilCtr' => $ctr_st, 
                'StencilSz' => $s_sz, 
                'Var' => [$array_var, $ctr_in, '']}
          };
        $tytracl_ast->{'Stencils'}{$array_var} = 1;
    }
    elsif ($type eq 'SELECT') {
        my $ctr_in = $unique_var_counters->{$array_var};

        push @{$tytracl_ast->{'Selects'}},
          { 'Lhs' => {'Var' => [$array_var, 'TODO', 'portion']},
            'Rhs' => {'Var' => [$array_var, $ctr_in, ''], 'Pattern' => ['TODO']}
          };
        if (not exists $unique_var_counters->{"${array_var}_portion"}) {
            $unique_var_counters->{"${array_var}_portion"} = 0;
        }
        else {
            $unique_var_counters->{"${array_var}_portion"}++;
        }
        $tytracl_ast->{'Portions'}{$array_var} = 1,;
    }
    elsif ($type eq 'INSERT') {
        my $ctr_in  = $unique_var_counters->{$array_var};
        my $ctr_out = ++$ctr_in;
        $unique_var_counters->{$array_var} = $ctr_out;

        push @{$tytracl_ast->{'Inserts'}},
          { 'Lhs' => {'Var' => [$array_var, $ctr_out, '']},
            'Rhs' => {'Var' => [$array_var, $ctr_in,  ''], 'Pattern' => ['TODO']},
          };
    }
    elsif ($type eq 'MAP') {
        my $node_type = 'Map';
        my %portions  = %{$tytracl_ast->{'Portions'}};
        my %stencils  = %{$tytracl_ast->{'Stencils'}};

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
        # my $n_dims = scalar keys %{$state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'LoopIters'}};

        my @in_tup             = grep { $_ !~ /^\!/ } @{$in_tup_maybe_dummies};
        # carp "$f $block_id: ".Dumper $state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'};
        my @in_tup_correct_dim = grep {
            exists $state->{'Subroutines'}{$f}{'StreamVars'}{$_}
            # exists $state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$_}
            # and scalar @{$state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$_}{'Dims'}} >= $n_dims
        } @in_tup;

# So a non-map arg is an arg that is either a scalar or an array with a lower dimensionality than the mapped arrays
# TODO: I guess we could be more strict and extend this to arrays with the same dimension but (much) smaller size
# But this would require us to calculate and compare the sizes.
# Taking into account that mappable args might have slightly different sizes because of the halos, in fact the mapped range should be the maximum
# I could put an ad-hoc limit on the size of a halo, say 5 points.
        my @in_tup_non_map_args = grep {
            # (        (not exists $state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$_})
            #       or (scalar @{$state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Arrays'}{$_}{'Dims'}} < $n_dims)
            # )
            not exists $state->{'Subroutines'}{$f}{'StreamVars'}{$_}
        } @in_tup;
# carp "NON-MAP ARGS: $f:".Dumper(@in_tup_non_map_args)."\n".Dumper($state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Scalars'});
        # non-fold args are non-map args that are not acc args
        my @in_tup_non_fold_args = grep { not exists $accs{$_} } @in_tup_non_map_args;

        my $in_tup_ms_ast = [
            map {
                my $stencil_access = scalar keys %{ $state->{'Subroutines'}{$f}{'Blocks'}{0}{'Arrays'}{$_}{'Read'}{'Accesses'}} > 1 ? 1 : 0;
                # say "$f $_ " .Dumper($state->{'Subroutines'}{$f}{'Blocks'}{0}{'Arrays'}{$_});
                if (not exists $unique_var_counters->{$_}) {
                    $unique_var_counters->{$_} = 0;
                }
                ($stencil_access and exists $stencils{$_}) ? [$_, $unique_var_counters->{$_ . '_s'}, 's'] :    #
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
            my $stencil_access = scalar keys %{ $state->{'Subroutines'}{$f}{'Blocks'}{0}{'Arrays'}{$_}{'Read'}{'Accesses'}} > 1 ? 1 : 0;
            if (not exists $unique_var_counters->{$_}) {
                $unique_var_counters->{$_} = 0;
            }
              ($stencil_access and  exists $stencils{$_}) ? [$_, $unique_var_counters->{$_ . '_s'},'s']
              : exists $portions{$_} ? [$_, $unique_var_counters->{$_ . '_portion'}, 'portion']
              : [$_, $unique_var_counters->{$_}, '']
        } @in_tup_non_map_args;

        my @non_fold_args_ms_ast = map {
            my $stencil_access = scalar keys %{ $state->{'Subroutines'}{$f}{'Blocks'}{0}{'Arrays'}{$_}{'Read'}{'Accesses'}} > 1 ? 1 : 0;
            if (not exists $unique_var_counters->{$_}) {
                $unique_var_counters->{$_} = 0;
            }
                ($stencil_access and exists $stencils{$_}) ? [$_, $unique_var_counters->{$_ . '_s'},       's']
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
            push @{$tytracl_ast->{'Lines'}}, {
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
            push @{$tytracl_ast->{'Lines'}}, {
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
        # Here, $state is $stref
        $tytracl_ast->{'MainFunction'} = $f;
        my $arg_pos=0;
        # carp $f. ' RefactoredArgs: '.Dumper $state->{'Subroutines'}{$f}{'RefactoredArgs'}; # This is OK
        # croak $f.' DeclaredOrigArgs: '.Dumper $state->{'Subroutines'}{$f}{'DeclaredOrigArgs'}; # This is NOK?!
        for my $arg (@{$state->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'}}) {
            $tytracl_ast->{'OrigArgs'}{$arg} = 
                $state->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'};
            $tytracl_ast->{'FunctionArgsMappings'}{$f}{$arg}=$arg_pos;
            ++$arg_pos;
        }
    }

    return $tytracl_ast;
}    # END of _add_TyTraCL_AST_entry

sub __add_to_MainArgTypes {
    my ($inoutargs, $stref, $fname, $var_name_rec, $main_rec, $non) = @_;
    my $orig_var_name = $var_name_rec->[0];
    my $var_name      = _mkVarName($var_name_rec);
    my $var_rec       = $stref->{'Subroutines'}{$fname}{'DeclaredOrigArgs'}{'Set'}{$orig_var_name};
# carp Dumper $var_name_rec, $var_name, $var_rec;

    # WV 2019-08-12 the '0' below feels hacky
    my $dim = $stref->{'Subroutines'}{$fname}{'ArrayAccesses'}{0}{'Arrays'}{$orig_var_name}{'Dims'};

    # my $dim = $var_rec->{'Dim'};
    my $type = $var_rec->{'Type'};
    # add to InArgsTypes or OutArgsTypes
    if (not exists $main_rec->{$inoutargs . 'Types'}{$var_name}) {
        $main_rec->{$inoutargs . 'Types'}{$var_name} = __toTyTraCLType($type, $dim, $non);    
    } else {
        pop @{$main_rec->{$inoutargs} };
    }
    
    return $main_rec;
}    # END of __add_to_MainArgTypes

# This is to emit Haskell later
sub _emit_TyTraCL_FunctionSigs { (my $stref) = @_;

    # FIXME: we ignore Selects and Inserts for now.

    # We need the superkernel as the main, and we must identify its input and output arguments
    # Input args have Ctr==0 on the Rhs
    # Output args $arg have Ctr == $tytracl_ast->{'UniqueVarCounters'}{$arg}
    my $tytracl_ast  = $stref->{'TyTraCL_AST'};
    # carp Dumper $tytracl_ast;
    $stref->{'TyTraCL_FunctionSigs'}={};

    for my $node (@{$tytracl_ast->{'Lines'}}) {
        
        my $lhs   = $node->{'Lhs'};
        my $rhs   = $node->{'Rhs'};
        my $f     = $rhs->{'Function'};    

        if ($node->{'NodeType'} eq 'Map') {
            my $out_vars     = $lhs->{'Vars'};
            my $map_args     = $rhs->{'MapArgs'}{'Vars'};
            my $non_map_args = $rhs->{'NonMapArgs'}{'Vars'};

            my $lhs_rec = [map { _mkVarName($_) } @{$out_vars}];
            my $non_map_arg_rec = (scalar @{$non_map_args} == 0) ? []  : [map { _mkVarName($_) } @{$non_map_args}];            
            my $map_arg_rec = [map { _mkVarName($_) } @{$map_args}];              

            # $stref->{'TyTraCL_FunctionSigs'}{$f}=[$non_map_arg_rec,$map_arg_rec, $lhs_rec];
            $stref->{'TyTraCL_FunctionSigs'}{$f}=[$non_map_args,$map_args, $out_vars];

        }
        elsif ($node->{'NodeType'} eq 'Fold') {
            my $out_vars     = $lhs->{'Vars'};
            my $map_args     = $rhs->{'FoldArgs'}{'Vars'};
            my $non_map_args = $rhs->{'NonFoldArgs'}{'Vars'};
            my $acc_args     = $rhs->{'AccArgs'}{'Vars'};

            my $lhs_rec = [map { _mkVarName($_) } @{$out_vars}];
            my $non_map_arg_rec = (scalar @{$non_map_args} == 0) ? []  : [map { _mkVarName($_) } @{$non_map_args}];
            my $acc_arg_rec = [map { _mkVarName($_) } @{$acc_args}];
            my $map_arg_rec = [map { _mkVarName($_) } @{$map_args}];              

            # $stref->{'TyTraCL_FunctionSigs'}{$f}=[$non_map_arg_rec,$acc_arg_rec,$map_arg_rec, $lhs_rec];
            $stref->{'TyTraCL_FunctionSigs'}{$f}=[$non_map_args,$acc_args,$map_args, $out_vars];

        }
    }
    return $stref;
} # END of _emit_TyTraCL_FunctionSigs

1;


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


type Name = String
data VE = VI  | VO  | VS  | VT deriving (Show, Typeable, Data, Eq)
    
type AST = [(Expr,Expr)]                      

data Expr =
        -- Left-hand side:
                      Scalar Name
                    | Const Int -- bb: IntLit Integer
                    | Tuple [Expr] --  bb: Tup [Expr]
                    | Vec VE Name -- bb: Var Name, type via cofree comonad, but VE info is not there

        -- Right-hand side:
                    | SVec Int Name -- bb: SVec [Expr] -> to get a name, use a Let
                    | ZipT [Expr] -- bb: App Zip (Tup  [...])
                    | UnzipT Expr -- bb: App Unzip (vec of tuples)
                    | Elt Int Expr -- bb: App (Select Integer) Tup
                    | PElt Int -- bb does not need this
                    | Map Expr Expr -- bb: App (Map Expr) Expr
                    | Fold Expr Expr Expr -- bb: App (Fold (App action acc) Expr
                    | Stencil Expr Expr -- bb uses App : App (Stencil (SVec [IntLit])) vector
                    | Function Name -- bb: uses Var Name with a function type
                    | Id -- bb has Id 
                    | Mu Expr Expr -- \a e -> g a (f e) -- of course bb does not have this, no need
                    | ApplyT [Expr]  -- bb: App FTup [Expr]
                    | MapS Expr -- bb does not have this, not needed
                    | Comp Expr Expr -- bb does not have this, not needed

     -- shapiro_reduce_18
    etan_avg_1 =  fold shapiro_reduce_18 etan_avg_0 etan_0
     -- shapiro_map_23
    s1 = [-1,-502,0,502,1]
    wet_s_0 = stencil s1 wet_0
    s2 = [-1,-502,0,502,1]
    etan_s_0 = stencil s2 etan_0
    eta_1 =  map (shapiro_map_23 (eps_0,etan_avg_1)) (zipt (wet_s_0,etan_s_0,eta_0))
     -- dyn_map_39
    s3 = [-502,0]
    un_s_0 = stencil s3 un_0
    s4 = [-1,0]
    vn_s_0 = stencil s4 vn_0
    s5 = [0,502,1]
    wet_s_1 = stencil s5 wet_0
    s6 = [-1,-502,0,502,1]
    h_s_0 = stencil s6 h_0
    s7 = [0,502,1]
    eta_s_0 = stencil s7 eta_1
    (du_1,duu_1,dv_1,dvv_1,etan_1,un_1,vn_1) = unzipt $ map (dyn_map_39 (dt_0,g_0,dx_0,dy_0,duu_0,dvv_0)) (zipt (eta_s_0,u_0,du_0,wet_s_1,v_0,dv_0,un_s_0,h_s_0,vn_s_0))
     -- update_map_24
    (h_1,u_1,v_1,wet_1) = unzipt $ map (update_map_24 hmin_0) (zipt (hzero_0,eta_s_0,h_s_0,un_s_0,vn_s_0))

$ast->{'Lines'} = [
		{'NodeType' => 'StencilDef',
			'FunctionName' => $f,
            # s2 = [-1,-502,0,502,1]
			'Lhs' => {'Ctr' => $ctr_st},
			'Rhs' => {'StencilPattern' => { # This is $stencil_patt
            # 'Accesses' => { '0:1' =>  {'j' => [1,0],'k' => [1,1]}}, 
               'Accesses' => { 
                   join(':', @offset_vals) => {
                       $iters[$idx] => [$mult_val,$offset_val],
                     }
                }
            # 'Dims' => [[0,501],[1,500],...]
   			'Dims' => [[$i_start,$i_end],[$j_start,$j_end],...]
          }
		};
		{'NodeType' => 'StencilAppl',
          'FunctionName' => $f,    
            # wet_s_0 = stencil s2 wet_0
			'Lhs' => {'Var' => [$array_var,$ctr_sv,'s'] },
			'Rhs' => {'StencilCtr' => $ctr_st,'Var' => [$array_var, $ctr_in,''] }
		};
		{'NodeType' => 'Map',
          'FunctionName' => $f,
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
		{'NodeType' => 'Fold',
          'FunctionName' => $f,
			'Lhs' => {
				'Vars' =>[@out_tup_ast],
			},
			'Rhs' => {
				'Function' => $f,    
				'NonFoldArgs' => {
					'Vars'=>[@non_map_args_ms_ast],
				},
				'FoldArgs' =>{
					'Vars' =>$in_tup_ms_ast,
				}
				'AccArgs' =>{
					'Vars' =>$in_tup_ms_ast,
				}
			}
		};
	];

	$ast->{'Selects'} = [
        {
            'Lhs' => {'Var' => [$array_var, 'TODO','portion']},
            'Rhs' =>  {'Var' => [$array_var, $ctr_in,''], 'Pattern' =>['TODO']}
        };
	];

	$ast->{'Inserts'} = [
        {
            'Lhs' => {'Var' => [$array_var,$ctr_out,''] },
            'Rhs' =>  {'Var' => [$array_var, $ctr_in,''], 'Pattern'=> ['TODO']},
        },
    ];

    $ast->{'Portions'} = [
        {
            $array_var => 1, 
        }
	];

EntryID is the line number in 'Lines'

$ast->{'Nets'}{$net} = {
    From => {
            'Name'=>$f,
            'EntryID'=>$entry_id,
            'NodeType'=> Map | Fold | StencilAppl | Input | Output
        },

    To => [
        {
            'Name'=>$f,
            'EntryID'=>$entry_id,
            'NodeType'=> Map | Fold | StencilAppl | Input | Output
        },
        ...
    ],
    NetType => Vec | Scalar
}      

$ast->{'Nodes'} = {
          
        $node_name => {
            NodeType => Map | Fold | StencilAppl | Input | Output
            EntryID => $entry_id,
            Inputs => [@input_nets],
            Outputs => [@output_nets]            
            Dependencies => {
                $dep_name => NodeType,
            }
        },
        
}

=cut

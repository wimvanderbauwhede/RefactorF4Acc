package RefactorF4Acc::Translation::TyTraCL;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw(
	pass_wrapper_subs_in_module					
	);
use RefactorF4Acc::Translation::TyTra::Common qw(
pp_links  
__isMainInArg 
__isMainOutArg  
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
$VERSION = "1.2.0";

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

# If set to 0, Folds are identified as Maps (for dev/debug)
# The NodeType is set in _add_TyTraCL_AST_entry which is called in ArrayAccessPatterns
# The way a Fold is detected is by detecting an accumulation operation ('Acc')
our $FOLD=1;

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
          
        $map_name => {
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

sub pass_emit_TyTraCL {(my $stref, my $module_name)=@_;
    # WV: I think Selects and Inserts should be in Lines but I'm not sure
    $stref->{'EmitAST'} = 'TyTraCL_AST';
	$stref->{'TyTraCL_AST'} = {
        'Lines' => [], 
        'Selects'=>[], 'Inserts'=>[], 'Stencils'=>{},'Portions'=>{},
        'Main' => {},
        'ASTEmitter' => \&_add_TyTraCL_AST_entry
        };
	$stref = pass_wrapper_subs_in_module($stref,$module_name,
	           # module-specific passes 
            [],
            # subroutine-specific passes 
	
			[
#				[ sub { (my $stref, my $f)=@_;  alias_ordered_set($stref,$f,'DeclaredOrigArgs','DeclaredOrigArgs'); } ],
		  		[
			  		\&identify_array_accesses_in_exprs,
				],
			]
		);
        $stref = _construct_TyTraCL_AST_Main_node($stref);
        $stref = _emit_TyTraCL($stref);
        my $tytracl_str = $stref->{'TyTraCL_Code'} ;
        say $tytracl_str; # Maybe store in stref as TyTraCL_Code and return $stref
        my $ast = $stref->{'TyTraCL_AST'} ; # The MainRec node has info about VarTypes and Stencils
        say '=' x 80;
        say '=' x 10, ' Build Connectivity Graph ';
        say '=' x 80;
        
        $ast = build_connectivity_graph($ast);
# croak Dumper $ast->{Nodes};
        say '=' x 80;
        say '=' x 10, ' Add IO Nodes to Connectivity Graph ';
        say '=' x 80;

        $ast = add_io_nodes_to_connectivity_graph($ast);

        say '=' x 80;
        say '=' x 10, 'Add IO Net Types';
        say '=' x 80;

        $ast = add_io_net_types($ast);

        say '=' x 80;
        say '=' x 10, 'Propagate Net Types';
        say '=' x 80;

        $ast = propagate_net_types($ast);
        # die;
        say '=' x 80;
        say '=' x 10, 'Propagate Latency';
        say '=' x 80;

        $ast = propagate_latency($ast);
# croak Dumper $ast->{Nets};
        # say '=' x 80;
        # say '=' x 10, ' Remove Stencil Nodes from Connectivity Graph ';
        # say '=' x 80;

        # $ast = remove_stencil_nodes_from_connectivity_graph($ast);
        
        say '=' x 80;
        say '=' x 10, ' Find Dataflow Dependencies ';
        say '=' x 80;        

        $ast = find_dataflow_dependencies($ast);
        
        # emitDotGraph($ast->{'Nets'});
        exit ;

	return $stref;
} # END of pass_emit_TyTraCL()

# {'Lines' => [
#		{'NodeType' => 'StencilDef',
#			'FunctionName' => $f,
#			'Lhs' => {'Ctr' => $ctr_st},
#			'Rhs' => {'StencilPattern' => { # This is $stencil_patt
#                'Accesses' => { 
#                    join(':', @offset_vals) => {
#                        $iters[$idx] => [$mult_val,$offset_val],
#                      }
#                 }
#    			'Dims' => [[$i_start,$i_end],[$j_start,$j_end],...]
#           }
#		};
# 		{'NodeType' => 'StencilAppl',
#           'FunctionName' => $f,
# 			'Lhs' => {'Var' => [$array_var,$ctr_sv,'s'] },
# 			'Rhs' => {'StencilCtr' => $ctr_st,'Var' => [$array_var, $ctr_in,''] }
# 		};
#		{'NodeType' => 'Map',
#           'FunctionName' => $f,
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
#		};
#		{'NodeType' => 'Fold',
#           'FunctionName' => $f,
#			'Lhs' => {
#				'Vars' =>[@out_tup_ast],
#			},
#			'Rhs' => {
#				'Function' => $f,    
#				'NonFoldArgs' => {
#					'Vars'=>[@non_map_args_ms_ast],
#				},
#				'FoldArgs' =>{
#					'Vars' =>$in_tup_ms_ast,
#				}
#				'AccArgs' =>{
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
#   'Portions' => {
#                      $array_var => 1, 
#                 }
#	]
#};

sub _construct_TyTraCL_AST_Main_node {  (my $stref) = @_;
	# FIXME: we ignore Selects and Inserts for now.
    # We need the superkernel as the main, and we must identify its input and output arguments
    # Input args have Ctr==0 on the Rhs
    # Output args $arg have Ctr == $tytracl_ast->{'UniqueVarCounters'}{$arg}
	my $tytracl_ast = $stref->{'TyTraCL_AST'} ;
	
    my $main_rec = {
        'NodeType' => 'Main', 
        'InArgs' => [], 
        'OutArgs' => [],
        'InArgsTypes' => {},
        'OutArgsTypes' => {},
        'Main' => $tytracl_ast->{'Main'},
        'Stencils'=>{},
        'VarTypes' => {}
        };
    my $var_types={};
    my $stencils={};
	for my $node (@{ $tytracl_ast->{'Lines'} } ) {
        my $fname = $node->{'FunctionName'};
		my $lhs = $node->{'Lhs'} ;
		my $rhs = $node->{'Rhs'} ;
        # This is not an Emitter step
        $main_rec = _addToMainSig($stref,$main_rec, $node, $lhs, $rhs, $fname);
        ($var_types, $stencils) = _addToVarTypesAndStencils($stref, $var_types, $stencils, $node, $lhs, $rhs, $fname,\&__toTyTraCLType);        
    }
    $main_rec->{'Stencils'}=$stencils;
    $main_rec->{'VarTypes'}=$var_types;
    # say Dumper($main_rec);
    $stref->{'TyTraCL_AST'}{'MainRec'} = $main_rec;

    return $stref;
}

sub _emit_TyTraCL {  (my $stref) = @_;
	# FIXME: we ignore Selects and Inserts for now.
    # We need the superkernel as the main, and we must identify its input and output arguments
    # Input args have Ctr==0 on the Rhs
    # Output args $arg have Ctr == $tytracl_ast->{'UniqueVarCounters'}{$arg}
	my $tytracl_ast = $stref->{'TyTraCL_AST'} ;
	my $tytracl_strs = [];
    

	for my $node (@{ $tytracl_ast->{'Lines'} } ) {
        my $fname = $node->{'FunctionName'};
		my $lhs = $node->{'Lhs'} ;
		my $rhs = $node->{'Rhs'} ;

        # These are never arguments of the main function
		if ($node->{'NodeType'} eq 'StencilDef') {
			my $ctr = $lhs->{'Ctr'};
#			my $stencil_ast = $rhs->{'StencilPattern'}{'Accesses'};
#            my $array_dims = $rhs->{'StencilPattern'}{'Dims'};
#            my @evaled_array_dims = ();
#            for my $array_dim (@{ $array_dims } ) {
#                push @evaled_array_dims, eval( $array_dim->[1].' - '.$array_dim->[0] );
#            }

#			my @stencil_pattern = map { $_=~s/:/,/;"[$_]" } sort keys %{$stencil_ast};
            # I should get the linear dimension from somewhere, we could add this information to the stencil detection
            # TODO: this needs to be generic so I should split the above and combine it with the dimensions
#            my @stencil_pattern_eval = map {my $res=eval("my \$a=$_;my \$b=\$a->[0]*".$evaled_array_dims[0]."+\$a->[1];\$b");$res} @stencil_pattern;# FIXME: HACK!
            #my $stencil_definition = '['.join(',',@stencil_pattern).']';
            my $stencils_ = _generate_TyTraCL_stencils( $rhs->{'StencilPattern'} );
            my $stencil_definition = '['.join(',',@{$stencils_}).']';

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
		elsif ($node->{'NodeType'} eq 'Fold') { 
			my $out_vars = $lhs->{'Vars'};
			my $map_args = $rhs->{'FoldArgs'}{'Vars'};
			my $non_map_args = $rhs->{'NonFoldArgs'}{'Vars'};
			my $acc_args = $rhs->{'AccArgs'}{'Vars'};
			
			my $lhs_str = (scalar @{$out_vars} == 1 )
				? _mkVarName($out_vars->[0]). ' = '
				: '('.join(',',map {_mkVarName($_) } @{$out_vars}).') = unzipt $';

			my $non_map_arg_str = (scalar @{$non_map_args} == 0 ) ? '' : (scalar @{$non_map_args} == 1 )
				? _mkVarName($non_map_args->[0])
				: '('.join(',',map {_mkVarName($_) } @{$non_map_args}).')';
				
			my $acc_arg_str	= (scalar @{$acc_args} == 1 )
				? _mkVarName($acc_args->[0])
				: '('.join(',',map {_mkVarName($_) } @{$acc_args}).')';
			my $map_arg_str = (scalar @{$map_args} == 1 )
                ? _mkVarName($map_args->[0])
                : '(zipt ('.join(',',map {_mkVarName($_) } @{$map_args}).'))';
					
            my $f = $rhs->{'Function'};
			my $f_str = $non_map_arg_str eq '' ? $f : "($f $non_map_arg_str)";
			my $line = "$lhs_str fold $f_str $acc_arg_str $map_arg_str";
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
    my $main_rec = $tytracl_ast->{'MainRec'};
    my $in_args_types = $main_rec->{'InArgsTypes'};
    my @in_arg_type_decls=();
    for my  $in_arg (sort keys %{$in_args_types}){
        push @in_arg_type_decls, "$in_arg :: ". _emit_TyTraCLType($in_args_types->{$in_arg});
    }
    my $out_args_types = $main_rec->{'OutArgsTypes'};
    my @out_arg_type_decls=();
    for my  $out_arg (sort keys %{$out_args_types}){
        push @out_arg_type_decls, "$out_arg :: ". _emit_TyTraCLType($out_args_types->{$out_arg});
    }

    my $main_in_args_str = scalar @{$main_rec->{'InArgs'}} > 1 ? '('.join(',', @{$main_rec->{'InArgs'}}).')' :  $main_rec->{'InArgs'}->[0];
    my $main_out_args_str = scalar @{$main_rec->{'OutArgs'}} > 1 ? '('.join(',', @{$main_rec->{'OutArgs'}}).')' :  $main_rec->{'OutArgs'}->[0];
    unshift @tytracl_strs_indent, '  let';
    unshift @tytracl_strs_indent, "main $main_in_args_str =";
    unshift @tytracl_strs_indent, "";
    push @tytracl_strs_indent,'  in';
    push @tytracl_strs_indent,"    $main_out_args_str";

    # Add function type decls
    my $var_types=$main_rec->{'VarTypes'};
    for my $f (sort keys %{ $var_types }) {
               
        if (exists $var_types->{$f} and ref($var_types->{$f}) eq 'HASH' and exists $var_types->{$f}{'FunctionTypeDecl'}) {
            unshift @tytracl_strs_indent,_emit_FunctionTypeDecl($var_types->{$f}{'FunctionTypeDecl'});
        }
    }
    @tytracl_strs_indent=(@in_arg_type_decls,'', @out_arg_type_decls,'',@tytracl_strs_indent);
	my $tytracl_str = join("\n", @tytracl_strs_indent);
    
    $stref->{'TyTraCL_Code'} = $tytracl_str;

	return  $stref;
} # END of _emit_TyTraCL()

sub _emit_TyTraCLType {my ($decl)=@_;
    return join(' ',@{$decl});
} # END of _emit_TyTraCLType

sub _emit_FunctionTypeDecl{my ($fdecl)=@_;
    croak ref($fdecl).' : '.Dumper $fdecl if ref($fdecl) ne 'ARRAY';#->[0]=~/reduce/;
    my $f = shift @{$fdecl};
    my @argdecls=();
    for my $argdecl (@{$fdecl}){
        if ( scalar @{$argdecl} == 1 ) {
                push @argdecls, _emit_TyTraCLType(
                    ref($argdecl->[0]) eq 'ARRAY' ? $argdecl->[0] : [ $argdecl->[0] ]
                    );
        } elsif (scalar @{$argdecl} > 1 ) {
            my $tup_decl = '('.join(',', map {_emit_TyTraCLType(ref($_) eq 'ARRAY' ? $_ : [$_])} @{$argdecl}).')';
        push @argdecls, $tup_decl;
         }; #unless scalar @{$argdecl} == 0;
    }
    my $f_type_decl =  "$f :: ".join(' -> ',@argdecls);
    # say $f_type_decl;
    return $f_type_decl;
} # END of _emit_FunctionTypeDecl

sub _mkVarName { (my $rec) =@_;
    # carp(Dumper($rec));
	(my $v, my $c, my $e) = @{$rec};
	if ($e eq '') {
		return "${v}_${c}";
	} else {
		return "${v}_${e}_${c}";
	}
} # END of _mkVarName()

sub __toTyTraCLScalarType { (my $type)=@_;

    if ($type eq 'real') { return 'Float';
    } elsif ($type eq 'integer') { return 'Int';
    } else {
        # ad-hoc!
        return ucfirst($type);
    }
}

# Maybe this should return the type as a datastructure and use _emit_TyTraCLType
sub __toTyTraCLType { (my $type, my $array_dims)=@_;

if (not defined $array_dims or scalar @{$array_dims} == 0) { # Scalar
    if ($type eq 'real') { 
        return ['Float'];
    } elsif ($type eq 'integer') { 
        return ['Int'];
    } else {
        # ad-hoc!
        return [ucfirst($type)];
    }
 } else { # Vector
#  say Dumper($array_dims);
    my @ranges=();
    for my $array_dim (@{ $array_dims } ) {
        push @ranges, '('.$array_dim->[1].'-'.$array_dim->[0] . '+1)';            
    }
    my $vec_sz = eval(join('*',@ranges)); # FIXME: needs proper constant folding here!
    my $scalar_type = ucfirst($type);
    if ($type eq 'real') { 
        $scalar_type = 'Float';
    } elsif ($type eq 'integer') { 
        $scalar_type = 'Int';
    }

    my $tycl_type= ['Vec' ,$vec_sz, $scalar_type]; 
    # WV 2019-08-12 the '0' below feels hacky
    # say $tycl_type;
    return $tycl_type;
 }
 
} # END of __toTyTraCLType



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
} # END of _generate_TyTraCL_stencils

    # WV20190813 It would be better to return a datastructure with the original info and to the emit via a separate function
sub _addToVarTypesAndStencils { (my $stref, my $var_types, my $stencils, my $node, my $lhs, my $rhs, my $fname, my $type_formatter) = @_;
        if ($node->{'NodeType'} eq 'StencilDef') {
            my $s_var = $lhs->{'Ctr'};
            my $s_size = scalar keys %{$rhs->{'StencilPattern'}{'Accesses'}};
            $stencils->{$s_var}=$s_size;
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
            $s_type = ['SVec',$stencils->{$rhs->{'StencilCtr'}},$var_type->[0]];
            # This is odd compared to the other nodes
            $var_types->{$s_var}=$s_type;
        } elsif ($node->{'NodeType'} eq 'Map') {
            # Output arguments can't be stencil, so only DeclaredOrigArgs
            my $out_args = $lhs->{'Vars'} ;
            my $f = $fname;
            my @out_arg_types_array;
            for my $out_arg_rec (@{$out_args}) {
                my $var_name = $out_arg_rec->[0];
                my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                my $var_type =  $type_formatter->( $var_rec->{'Type'} );
                push @out_arg_types_array, $var_type;
            }
            $var_types->{$f}{'ReturnType'} = [@out_arg_types_array];
            
            # This should always be a tuple and the values can only be scalars
            my $map_args = $rhs->{'MapArgs'}{'Vars'} ;
            my @map_arg_types_array=();
            my %map_arg_types=();
            for my $map_arg_rec (@{$map_args}) {
                my $var_name = $map_arg_rec->[0];
                my $maybe_stencil = _mkVarName($map_arg_rec);
                if (exists $var_types->{ $maybe_stencil }) {
                    push @map_arg_types_array,$var_types->{ $maybe_stencil };
                    $map_arg_types{$var_name}=$var_types->{ $maybe_stencil };
                } else {                
                    my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                    my $var_type =  $type_formatter->( $var_rec->{'Type'} );
                    # say 'DECL: '. $var_name.' :: '._emit_TyTraCLType( $var_type);
                    push @map_arg_types_array, $var_type;
                    $map_arg_types{$var_name}=$var_type;
                }
            }
            # \%map_arg_types;
             $var_types->{$f}{'MapArgType'} = [@map_arg_types_array];
            $var_types->{$f}{'MapArgTypeMap'} = \%map_arg_types;
            # This should always be a tuple and the values can actually be arrays
            my $non_map_args = $rhs->{'NonMapArgs'}{'Vars'} ;
            my @non_map_arg_types_array=();
            for my $non_map_arg_rec (@{$non_map_args}) {
                    my $var_name = $non_map_arg_rec->[0];
                    my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                    my $var_type =  $type_formatter->( $var_rec->{'Type'} );
                    push @non_map_arg_types_array, $var_type;
            }
            $var_types->{$f}{'NonMapArgType'} = [@non_map_arg_types_array];
            my @arg_types= ();
            push @arg_types, $var_types->{$f}{'NonMapArgType'};
            push @arg_types, $var_types->{$f}{'MapArgType'};
            push @arg_types, $var_types->{$f}{'ReturnType'};

            $var_types->{$f}{'FunctionTypeDecl'} = [$f,@arg_types] ;

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
                push @out_arg_types_array, $var_type;
            }
            $var_types->{$f}{'ReturnType'} = [@out_arg_types_array];
            
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
            
            $var_types->{$f}{'FoldArgType'} = [@map_arg_types_array];

            # This should always be a tuple and the values can actually be arrays
            my $non_map_args = $rhs->{'NonFoldArgs'}{'Vars'} ;
            
            my @non_map_arg_types_array=();
            for my $non_map_arg_rec (@{$non_map_args}) {
                    my $var_name = $non_map_arg_rec->[0];
                    my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                    my $var_type =  $type_formatter->( $var_rec->{'Type'} );
                    push @non_map_arg_types_array, $var_type;
            }

            
            $var_types->{$f}{'NonFoldArgType'} = [@non_map_arg_types_array];

            my $acc_args = $rhs->{'AccArgs'}{'Vars'} ;
            my @acc_arg_types_array=();
            for my $acc_arg_rec (@{$acc_args}) {
                    my $var_name = $acc_arg_rec->[0];
                    my $var_rec =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name};
                    my $var_type =  $type_formatter->( $var_rec->{'Type'} );
                    push @acc_arg_types_array, $var_type;
            }
            
            $var_types->{$f}{'AccArgType'} = [@acc_arg_types_array];

            my @arg_types = ();
            push @arg_types, $var_types->{$f}{'NonFoldArgType'};
            push @arg_types, $var_types->{$f}{'AccArgType'};
            push @arg_types, $var_types->{$f}{'FoldArgType'};
            push @arg_types, $var_types->{$f}{'ReturnType'};

            $var_types->{$f}{'FunctionTypeDecl'} = [$f, @arg_types] ;            
            
            
        } elsif ($node->{'NodeType'} ne 'Comment' and $node->{'NodeType'} ) {
            croak "NodeType type ".$node->{'NodeType'}.' not yet supported.';
        }


    return ($var_types, $stencils) ;
} # END of _addToVarTypesAndStencils()

    # Add function type declarations. This is a bit complicated, but we have following steps:
    # If it is a stencil, then I have to find the stencil pattern. We do this in the handling of the StencilDef node.
    # The actual type and the size of the array we should get via $stref->{'Subroutines'}{$f}
    # The non-map args can be arrays, so in that case in principle we'd need the type.
    # So, for every Map and Fold nodes we look a the vars, and we build up a table. If they are stencils we do this in the StencilDef node.
    # WV20190813 It would be better to return a datastructure with the original info and to the emit via a separate function
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
             $var_types->{$f}{'MapArgTypeMap'} = $map_arg_type;

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
            push @arg_types, $var_types->{$f}{'MapArgTypeMap'};
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

# Add arguments to the signature of the main function
sub _addToMainSig { (my $stref, my $main_rec, my $node, my $lhs, my $rhs, my $fname) = @_;
        my $orig_args = $stref->{$stref->{'EmitAST'}}{'OrigArgs'};
		if ($node->{'NodeType'} eq 'StencilAppl') {
            # TODO: refactor!
            (my $var_name, my $ctr, my $ext) = @{$rhs->{'Var'}};
            if (exists $orig_args->{$var_name} and
                ($orig_args->{$var_name} eq 'in'
                        or $orig_args->{$var_name} eq 'inout' )) {
            if ($ctr == 0 && $ext eq '') {
                push @{ $main_rec->{'InArgs'} }, _mkVarName($rhs->{'Var'});
                $main_rec =  __add_to_MainArgTypes('InArgs',$stref,$fname,$rhs->{'Var'},$main_rec);
            }
        }
        } elsif ($node->{'NodeType'} eq 'Map') {
			my $out_var_recs = $lhs->{'Vars'};
            for my $out_var_rec (@{$out_var_recs}) {
                if (__isMainOutArg($out_var_rec,$stref)) {
                    push @{ $main_rec->{'OutArgs'} }, _mkVarName($out_var_rec);
                    $main_rec =  __add_to_MainArgTypes('OutArgs',$stref,$fname,$out_var_rec,$main_rec);
                }
            }
			my $map_arg_recs = $rhs->{'MapArgs'}{'Vars'};
            for my $map_var_rec (@{$map_arg_recs}) {
                if (__isMainInArg($map_var_rec,$stref)) {
                    my $var_name = $map_var_rec->[0];
                    push @{ $main_rec->{'InArgs'} },  _mkVarName($map_var_rec);
                    $main_rec =  __add_to_MainArgTypes('InArgs',$stref,$fname,$map_var_rec,$main_rec);
                }
            }
			my $non_map_arg_recs = $rhs->{'NonMapArgs'}{'Vars'};
            for my $non_map_var_rec (@{$non_map_arg_recs}) {
                if (__isMainInArg($non_map_var_rec,$stref)) {
                    my $var_name = $non_map_var_rec->[0];
                    push @{ $main_rec->{'InArgs'} }, _mkVarName($non_map_var_rec);
                    $main_rec =  __add_to_MainArgTypes('InArgs',$stref,$fname,$non_map_var_rec,$main_rec);
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
                    $main_rec =  __add_to_MainArgTypes('OutArgs',$stref,$fname,$out_var_rec,$main_rec);
                }
            }
			my $map_arg_recs = $rhs->{'FoldArgs'}{'Vars'};
            for my $map_var_rec (@{$map_arg_recs}) {
                if (__isMainInArg($map_var_rec,$stref)) {
                    my $var_name = $map_var_rec->[0];
                    push @{ $main_rec->{'InArgs'} },  _mkVarName($map_var_rec);
                    $main_rec =  __add_to_MainArgTypes('InArgs',$stref,$fname,$map_var_rec,$main_rec);
                }
            }
			my $non_map_arg_recs = $rhs->{'NonFoldArgs'}{'Vars'};
            for my $non_map_var_rec (@{$non_map_arg_recs}) {
                if (__isMainInArg($non_map_var_rec,$stref)) {
                    my $var_name = $non_map_var_rec->[0];
                    push @{ $main_rec->{'InArgs'} }, _mkVarName($non_map_var_rec);#$'InArgTypes' => {},var_name;
                    $main_rec =  __add_to_MainArgTypes('InArgs',$stref,$fname,$non_map_var_rec,$main_rec);
                }
            }
            my $accs = $rhs->{'AccArgs'}{'Vars'};
            for my $non_map_var_rec (@{$accs}) {
                if (__isMainInArg($non_map_var_rec,$stref)) {
                    my $var_name = $non_map_var_rec->[0];
                    push @{ $main_rec->{'InArgs'} }, _mkVarName($non_map_var_rec);#$'InArgTypes' => {},var_name;
                    $main_rec =  __add_to_MainArgTypes('InArgs',$stref,$fname,$non_map_var_rec,$main_rec);
                }
            }
        } elsif ($node->{'NodeType'} ne 'Comment' and $node->{'NodeType'} ne 'StencilDef') {
            croak "NodeType type ".$node->{'NodeType'}.' not yet supported.';
        }

        return $main_rec;
} # END of _addToMainSig()

sub _add_TyTraCL_AST_entry { (my $f, my $state, my $tytracl_ast, my $type, my $block_id, my $array_var, my $rw) = @_;
	
	if (not defined $array_var) {
		$array_var = '#dummy#';
	}
	if ($type eq 'INIT_AST') {
        if (not exists $tytracl_ast->{'UniqueVarCounters'}) {
            $tytracl_ast->{'UniqueVarCounters'}={'!s' => 0};
        }
	}
	
	my $unique_var_counters=$tytracl_ast->{'UniqueVarCounters'};
	
	if ($type eq 'INIT_COUNTERS') {
        if (not exists $unique_var_counters->{$array_var}) {
                $unique_var_counters->{$array_var}=0;
        }	
	}

	if ($type eq 'STENCIL') {
        my $ctr_st = ++$unique_var_counters->{'!s'};
        push @{$tytracl_ast->{'Lines'}},
        {'NodeType' => 'StencilDef', 'FunctionName' => $f,
            'Lhs' => {'Ctr' => $ctr_st},
            'Rhs' => {'StencilPattern' => {
                    'Accesses' => $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'},
                    'Dims' => $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{'Dims'}
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
 		my $node_type = 'Map';
 		my %portions = %{$tytracl_ast->{'Portions'}};
 		my %stencils= %{$tytracl_ast->{'Stencils'}};
 		# so this provides the output and input tuples for a given $f
	    # so for each var in $in_tup we need to get the counter, and for each var in $out_tup after that too.
		(my $out_tup, my $in_tup_maybe_dummies) = pp_links($state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Links'});
		 $in_tup_maybe_dummies =$state->{'Subroutines'}{$f}{'Args'}{'In'};
		# This is incorrect because it does not return arguments that are used in conditions only
		my %accs =();
		my @acc_args = ();
		if ($FOLD) {             
		 @acc_args =  @{$state->{'Subroutines'}{$f}{'Args'}{'Acc'}};
		 if (scalar @acc_args > 0) {
		 	say "$f is a reduction ";
		 	$node_type = 'Fold';		 	
		 }
		  %accs = map {$_ => $_} @acc_args;
		}
		# A slightly better way is to look at which arrays are covered entirely by a map operation
		my $n_dims = scalar keys %{$state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'}};

		my @in_tup = grep { $_!~/^\!/ } @{$in_tup_maybe_dummies};
		my @in_tup_correct_dim =  grep {
			exists $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$_} and
			scalar @{ $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$_}{'Dims'} } >= $n_dims
		} @in_tup;

		my @in_tup_non_map_args =  grep {
			# Add ACC condition			
			(
			(not exists $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$_}) or
			(scalar @{ $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$_}{'Dims'} } < $n_dims)
			)
		} @in_tup;
		
		my @in_tup_non_fold_args = grep { not exists $accs{$_}  } @in_tup_non_map_args; 

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
		
		my $map_args_ms_ast = $in_tup_ms_ast;
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
					$unique_var_counters->{$_}=0;
				}
				exists $stencils{$_} ?
				[$_,$unique_var_counters->{$_.'_s'},'s'] :
				exists $portions{$_} ?
				[$_,$unique_var_counters->{$_.'_portion'},'portion'] :
				[$_,$unique_var_counters->{$_},'']
			} @in_tup_non_map_args;
			
		my @non_fold_args_ms_ast = map {
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				}
				exists $stencils{$_} ?
				[$_,$unique_var_counters->{$_.'_s'},'s'] :
				exists $portions{$_} ?
				[$_,$unique_var_counters->{$_.'_portion'},'portion'] :
				[$_,$unique_var_counters->{$_},'']
			} @in_tup_non_fold_args;			
			
		my @acc_args_ast = map {
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				}				
				[$_,$unique_var_counters->{$_},'']
			} @acc_args;			
			
		my @out_tup_ast=();
		for my $var (@{$out_tup}) {
			if (not exists $unique_var_counters->{$var}) {
				$unique_var_counters->{$var}=0;
			} else {
				$unique_var_counters->{$var}++;
			}
			push @out_tup_ast,[$var,$unique_var_counters->{$var},'']
		}

        if ($node_type eq 'Map') {
            push @{$tytracl_ast->{'Lines'}},
                {'NodeType' => $node_type,'FunctionName' => $f,

                    'Lhs' => {
                        'Vars' =>[@out_tup_ast],
                    },
                    'Rhs' => {
                        'Function' => $f,
                        'NonMapArgs' => {
                            'Vars'=>[@non_map_args_ms_ast],
                        },
                        'MapArgs' =>{
                            'Vars' =>$map_args_ms_ast,
                        }
                    }
                };
        } elsif ($FOLD and $node_type eq 'Fold') { #croak 'FOLD!';
            push @{$tytracl_ast->{'Lines'}},
            {'NodeType' => 'Fold','FunctionName' => $f,

                'Lhs' => {
                    'Vars' =>[@out_tup_ast],
                },
                'Rhs' => {
                    'Function' => $f,
                    'AccArgs' => {
                        'Vars'=>[@acc_args_ast],
                    },
                    'NonFoldArgs' => {
                        'Vars'=>[@non_fold_args_ms_ast],
                    },
                    'FoldArgs' =>{
                        'Vars' =>$fold_args_ms_ast,
                    }
                }
            };        	
        }
	} elsif ($type eq 'MAIN') {
         $tytracl_ast->{'Main'} = $f;
		 for my $arg (@{ $state->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'} } ) {
            $tytracl_ast->{'OrigArgs'}{$arg} =  $state->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'};
		 }		
	}
				 		
	return $tytracl_ast;
} # END of _add_TyTraCL_AST_entry


# ==============================================================================================================================
# GRAPH ANALYSIS AND TRANSFORMATION FOR STAGING
# ==============================================================================================================================

=pod AST


EntryID is the line number in 'Lines'

$ast->{'Nets'} = {
    $net => {
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
        Latency => Integer

    },
};      

$ast->{'Nodes'} = {          
        $node_name => {
            NodeType => Map | Fold | StencilAppl | StencilDef | Input | Output
            Latency => Integer
            EntryID => $entry_id,
            Inputs => [@input_nets],
            Outputs => [@output_nets]            
            Dependencies => {
                $dep_name => NodeType,
            }
        },        
};

$ast->{'NodeTypes'}{$node_type}= 
{   $node_name => $ast->{'Nodes'}{$node_name},
};

=cut


# We need to know the nodes connected to every net. 
# We are only interested in the map/fold nodes, so we should skip any other node
# For stencils this is trivial and it looks like we don't have zipt/unzipt in the AST
# So for a stencil node, we replace the out net by the in net and continue.
# So to build 'Nets', I think it is actually very simple:

sub build_connectivity_graph { my ($ast) = @_;
# For stencils this is trivial and it looks like we don't have zipt/unzipt in the AST
# So for a stencil node, we replace the out net by the in net and continue.
# So to build 'Nets', I think it is actually very simple:

    $ast->{'Nets'}={};
    $ast->{'Nodes'}={};
    my $entry_id=0;
    for my $entry ( @{ $ast->{'Lines'} } ) {
        my $node_type=$entry->{'NodeType'};
        my $f;
        my $latency=0;
        my $node_inputs=[];
        my $node_outputs=[];
        if ($node_type eq 'Map') {            
            
        # Inputs are Rhs NonMapArgs and Rhs MapArgs
             $f = $entry->{'Rhs'}{'Function'};     
             if (not exists $ast->{'Nodes'}{$f}{'Outputs'}) {
                 $ast->{'Nodes'}{$f}{'Outputs'}=[];
             }
             if (not exists $ast->{'Nodes'}{$f}{'Inputs'}) {
                 $ast->{'Nodes'}{$f}{'Inputs'}=[];
             }
            my @outputs = map { _mkVarName($_)  } @{ $entry->{'Lhs'}{'Vars'} };
            my @map_inputs = map { _mkVarName($_)  } @{ $entry->{'Rhs'}{'MapArgs'}{'Vars'} };
            my @nonmap_inputs = map { _mkVarName($_)  } @{ $entry->{'Rhs'}{'NonMapArgs'}{'Vars'}};

            for my $output (@outputs) {
                say "$node_type $f OUT: $output";     
                push @{$ast->{'Nets'}{$output}{'From'}},{'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};                
                $ast->{'Nets'}{$output}{'NetType'}='Stream';
                $ast->{'Nets'}{$output}{'Latency'}=0;
                # push @{$ast->{'Nodes'}{$f}{'Outputs'}}, $output;
            }
            for my $input (@map_inputs) {
                say "$node_type $f IN: $input";     
                push @{$ast->{'Nets'}{$input}{'To'}},{'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};
                $ast->{'Nets'}{$input}{'NetType'}='Stream';
                $ast->{'Nets'}{$input}{'Latency'}=0;
                # push @{$ast->{'Nodes'}{$f}{'Inputs'}}, $input;
            }
            for my $input (@nonmap_inputs) {
                say "$node_type $f IN: $input";     
                push @{$ast->{'Nets'}{$input}{'To'}},{'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};
                $ast->{'Nets'}{$input}{'NetType'}=['Scalar'];
                # push @{$ast->{'Nodes'}{$f}{'Inputs'}}, $input;
            }
            $node_inputs=[@map_inputs,@nonmap_inputs];
            $node_outputs = \@outputs;
# NOT OK: These are the types for the opaque, not for the Vector!
        #  for my $fold_arg (@{$entry->{'Rhs'}{'MapArgs'}{'Vars'}}) {
        #         my $var_name = $fold_arg->[0];
        #         say 'VARTYPES:'.Dumper( $ast->{'MainRec'}{'VarTypes'}{$f});
        #         my $var_type = $ast->{'MainRec'}{'VarTypes'}{$f}{'MapArgTypeMap'}{$var_name};
        #         say "VAR TYPE: ".Dumper($var_type);
        #     }
            # say Dumper($ast->{'Nodes'}{$f});die;
        }
        elsif ($node_type eq 'Fold') {
        # Inputs are Rhs NonFoldArgs and Rhs FoldArgs and presumably Rhs AccArgs   
        # So how do I get the Latency for the fold? I think we should actually explicitly type all input vectors!
             $f = $entry->{'Rhs'}{'Function'};
            my @outputs = map { _mkVarName($_)  } @{ $entry->{'Lhs'}{'Vars'} };
            my @fold_inputs = map { _mkVarName($_)  } @{ $entry->{'Rhs'}{'FoldArgs'}{'Vars'} };
            my @nonfold_inputs = map { _mkVarName($_)  } @{ $entry->{'Rhs'}{'NonFoldArgs'}{'Vars'} };
            my @acc_inputs = map { _mkVarName($_)  } @{ $entry->{'Rhs'}{'AccArgs'}{'Vars'} };

            for my $output (@outputs) {
                say "$f OUT: $node_type: $output";     
                push @{$ast->{'Nets'}{$output}{'From'}},{'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};
                $ast->{'Nets'}{$output}{'NetType'}=['Scalar'];
                push @{$ast->{'Nodes'}{$f}{'Outputs'}}, $output;
            }
            for my $input (@fold_inputs) {
                say "$f IN: $node_type: $input";     
                push @{$ast->{'Nets'}{$input}{'To'}},{'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};
                $ast->{'Nets'}{$input}{'NetType'}='Stream';
                $ast->{'Nets'}{$input}{'Latency'}=0;
                push @{$ast->{'Nodes'}{$f}{'Inputs'}}, $input;
            }
            for my $input (@nonfold_inputs, @acc_inputs) {
                say "$f IN: $node_type: $input";     
                push @{$ast->{'Nets'}{$input}{'To'}},{'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};
                $ast->{'Nets'}{$input}{'NetType'}=['Scalar'];
                push @{$ast->{'Nodes'}{$f}{'Inputs'}}, $input;
            }
            $node_inputs=[@fold_inputs,@nonfold_inputs,@acc_inputs];
            $node_outputs = \@outputs;
          
            # $latency=

        }
        elsif ($node_type eq 'StencilAppl') {
# 		{'NodeType' => 'StencilAppl',
#           'FunctionName' => $f,
# 			'Lhs' => {'Var' => [$array_var,$ctr_sv,'s'] },
# 			'Rhs' => {'StencilCtr' => $ctr_st,'Var' => [$array_var, $ctr_in,''] }
# 		};            
        # Inputs are Rhs NonFoldArgs and Rhs FoldArgs and presumably Rhs AccArgs   
            my $ctr = $entry->{'Rhs'}{'StencilCtr'};
            $f = 'sa_'.$ctr;
            $entry->{'Rhs'}{'Function'}=$f; # for convenience so all nodes have the same structure
            my $st_def='sd_'.$ctr;
            $latency = $ast->{'Nodes'}{$st_def}{'Latency'};

            my $output = _mkVarName( $entry->{'Lhs'}{'Var'} );       
            say "$node_type $f OUT: $output" if $DBG;     
            my $input = _mkVarName( $entry->{'Rhs'}{'Var'} );            
            say "$node_type $f IN: $input" if $DBG;     
            push @{$ast->{'Nets'}{$output}{'From'}},{'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};
            $ast->{'Nets'}{$output}{'NetType'}='Stream';
        
            push @{$ast->{'Nets'}{$input}{'To'}},{'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};
            $ast->{'Nets'}{$input}{'NetType'}='Stream';
            say "Stencil $f : $input => $output" if $DBG;
            $node_inputs=[$input];
            $node_outputs=[$output];            
        }
        elsif ($node_type eq 'StencilDef') {
            # The StencilDef always comes before the StencilAppl
            # We need to set the latency here and then take it from here
            
            my $ctr = $entry->{'Lhs'}{'Ctr'};
            my $stencil_patt = $entry->{'Rhs'}{'StencilPattern'};
            my $stencil_values = _generate_TyTraCL_stencils($stencil_patt);
            # say Dumper($stencil_values);
            my ($min,$max)=__get_min_max_from_array($stencil_values);
            $latency = $max-$min;
            $f = 'sd_'.$ctr; # because otherwise StencilDef and StencilAppl will clash
            # $ast->{'Nodes'}{$f}={'Inputs'=>[],'Outputs'=>[$ctr]};
            $node_inputs=[];
            $node_outputs=[$ctr];            

        }

        if (defined $f) {
            # say "F: $f";
            
            $ast->{'Nodes'}{$f}{'NodeType'} =  $node_type;
            $ast->{'Nodes'}{$f}{'EntryId'} = $entry_id;
            $ast->{'Nodes'}{$f}{'Inputs'} =  $node_inputs;
            $ast->{'Nodes'}{$f}{'Outputs'} =  $node_outputs;
            $ast->{'Nodes'}{$f}{'Latency'} = $latency;
            $ast->{'Nodes'}{$f}{'Dependencies'} = {};
            
             
            # else {
            #     say "Node for $f already exists: ".Dumper($ast->{'Nodes'}{$f});
            # }
        }
        $entry_id++;
    }
    
    return $ast;

} # END of build_connectivity_graph

sub add_io_nodes_to_connectivity_graph { my ($ast) = @_;
    
    for my $net (sort keys %{ $ast->{'Nets'} }) {
        #  say "NET: $net";
        #  say Dumper($ast->{'Nets'}{$net});
        if (not exists $ast->{'Nets'}{$net}{'To'}) {
            say "Net $net is an output for " 
            .join (' and ', map { $_->{'Name'} } @{ $ast->{'Nets'}{$net}{'From'} } ) if $DBG;

                $ast->{'Nets'}{$net}{'To'}=[{
                    'Name'=>$net,
                    'NodeType'=>'Output'                    
                }];
                $ast->{'Nodes'}{$net}={
                    'NodeType' => 'Output',
                    'EntryID' => -1,
                    'Inputs' => [$net],
                    'Outputs' => [],
                    'Latency' => 0,
                    'Dependencies' => {}
                };
        }
        elsif (not exists $ast->{'Nets'}{$net}{'From'}) {
            # say Dumper($ast->{'Nets'}{$net}{'To'});
            say "Net $net is an input for ".join (' and ', map { $_->{'Name'} } @{ $ast->{'Nets'}{$net}{'To'} } ) if $DBG;
                $ast->{'Nets'}{$net}{'From'}=[
                    {
                    'Name'=>$net,
                    'NodeType'=>'Input'
                }
                ];        
                $ast->{'Nodes'}{$net}={
                    'NodeType' => 'Input',
                    'EntryID' => -1,
                    'Inputs' => [],
                    'Outputs' => [$net],
                    'Latency' => 0,
                    'Dependencies' => {}
                };        
        }
        if (not exists $ast->{'Nets'}{$net}{'Latency'}) {
            $ast->{'Nets'}{$net}{'Latency'} =0;
        }
    }

    return $ast;
} # END of add_io_nodes_to_connectivity_graph

sub add_io_net_types { my ($ast) = @_;
    my $main_rec = $ast->{'MainRec'};
    my $in_args_types = $main_rec->{'InArgsTypes'};
    for my  $arg (sort keys %{$in_args_types}){
        if (exists $ast->{'Nets'}{$arg}) {
            # say "$arg :: "._emit_TyTraCLType($in_args_types->{$arg});
            $ast->{'Nets'}{$arg}{'NetType'} = [$ast->{'Nets'}{$arg}{'NetType'},$in_args_types->{$arg}];
        } else {
            carp "PROBLEM: Main IO arg $arg does not have an entry in Nets!"
        }
    }
    my $out_args_types = $main_rec->{'OutArgsTypes'};
    for my  $arg (sort keys %{$out_args_types}){
        if (exists $ast->{'Nets'}{$arg}) {
            $ast->{'Nets'}{$arg}{'NetType'} = [$ast->{'Nets'}{$arg}{'NetType'},$out_args_types->{$arg}];
        } else {
            carp "PROBLEM: Main IO arg $arg does not have an entry in Nets!"
        }
    }
    return $ast;
} # END of add_io_net_types


=pod propagate_net_types 
We start from the Input nodes, i.e. we loop over all Input nodes
We find their To, look it up in Nodes
- first check if the output nets already have proper types
- If it's a Map, and the input net is a Map arg (how do I know?), then the output net gets that type
- If it's a StencilAppl, the output net gets is a Vector of a tuple
- If it's a Fold or a StencilDef or an Output, we do nothing (We stop on Fold and Output, ignore StencilDef)

 - Then we call the function again with each of the output nets, etc.
=cut

sub propagate_net_types { my ($ast) = @_;
    for my $node (sort keys %{ $ast->{'Nodes'} }) {
        if ($ast->{'Nodes'}{$node}{'NodeType'} eq 'Input') {
            my $input_nets = $ast->{'Nodes'}{$node}{'Outputs'};            
            $ast = _prop_net_types_rec($ast,$input_nets);                        
        }
    }
    return $ast;
} # END of propagate_net_types

sub _prop_net_types_rec { my ($ast, $nets) = @_;
    for my $net (@{$nets}) {        
        if ($ast->{'Nets'}{$net}{'NetType'}->[0] eq 'Stream') { # It should be a tuple from the first stage
        # say "NET: $net ";#.Dumper($ast->{'Nets'}{$net});
            for my $to_rec (@{$ast->{'Nets'}{$net}{'To'}}) {
                my $to = $to_rec->{'Name'};
                # say "TO ".$to->{'NodeType'}. ' ' . $to->{'Name'};
                if ($to_rec->{'NodeType'} eq 'Map' or $to_rec->{'NodeType'} eq 'StencilAppl') {                    
                    # say "TO ".$to_rec->{'NodeType'}. ' ' . $to; 
                    # The outputs of this map must get the type from input                    
                    # say Dumper($ast->{'Nodes'}{$to});
                    my $out_nets = $ast->{'Nodes'}{$to}{'Outputs'};
                    for my $out_net (@{$out_nets}) {
                        # say "TO $to has OUT $out_net";
                        $ast->{'Nets'}{$out_net}{'NetType'} = $ast->{'Nets'}{$net}{'NetType'};
                    }
                    # then we recurse with these output as the new inputs
                    $ast = _prop_net_types_rec($ast,$out_nets);
                } elsif ($to_rec->{'NodeType'} eq 'Fold'
                and $ast->{'Nodes'}{$to}{'Latency'} == 0
                ) {                                        
                    $ast->{'Nodes'}{$to}{'Latency'} = $ast->{'Nets'}{$net}{'NetType'}[1][1];
                }
            }
        }
        #  else {
        #     say "Not a stream, skipping";
        # }
    }
    return $ast;
} # END of _prop_net_types_rec

=pod latency
# Step 0

- All nodes and edges must have a latency annotation, initially set at 0 except for Fold nodes (set at the vector size) an StencilAppl nodes (set at the stencil reach based on the StencilDef)
- For all Input nodes, find the edges; for all edges, find the endpoint nodes. 
- Set the endpoint node latency to the max of the latencies. This should be a different entry, 'AccumulatedLatency'. We should add the Latency of the node to this.
Set all outgoing edges to that value. Do this in rec descent fashion. 
=cut

sub propagate_latency { my ($ast) = @_;
    for my $node (sort keys %{ $ast->{'Nodes'} }) {
        if ($ast->{'Nodes'}{$node}{'NodeType'} eq 'Input') {
            my $input_nets = $ast->{'Nodes'}{$node}{'Outputs'};            
            $ast = _prop_latency_rec($ast,$input_nets);                        
        }
    }
    return $ast;
} # END of propagate_net_types

sub _prop_latency_rec { my ($ast, $nets) = @_;
    for my $net (@{$nets}) {        
        # say "NET: $net ".$ast->{'Nets'}{$net}{'Latency'};
            for my $to_rec (@{$ast->{'Nets'}{$net}{'To'}}) {
                my $to = $to_rec->{'Name'};
                # say "TO ".$to->{'NodeType'}. ' ' . $to->{'Name'};
                if ($to_rec->{'NodeType'} ne 'Output' ) {                    

                    my $in_nets = $ast->{'Nodes'}{$to}{'Inputs'};
                    my $max_in_net_latency=0;
                    for my $in_net (@{$in_nets}) {                        
                        $max_in_net_latency = $ast->{'Nets'}{$in_net}{'Latency'} > $max_in_net_latency ?  $ast->{'Nets'}{$in_net}{'Latency'} : $max_in_net_latency;
                    }
                    my $node_latency = $ast->{'Nodes'}{$to}{'Latency'};
                    my $out_net_latency = $max_in_net_latency + $node_latency;
                    # say "TO ".$to_rec->{'NodeType'}. ' ' . $to; 
                    # The outputs of this map must get the type from input                    
                    # say Dumper($ast->{'Nodes'}{$to});
                    my $out_nets = $ast->{'Nodes'}{$to}{'Outputs'};
                    for my $out_net (@{$out_nets}) {
                        # say "TO $to has OUT $out_net";
                        $ast->{'Nets'}{$out_net}{'Latency'} = $out_net_latency;
                    }
                    # then we recurse with these output as the new inputs
                    $ast = _prop_latency_rec($ast,$out_nets);
                } 
            }
    }
    return $ast;
} # END of _prop_latency_rec


sub remove_stencil_nodes_from_connectivity_graph { my ($ast) = @_;
    # find all nets that have a 'To' stencil; find the 
    for my $net (sort keys %{ $ast->{'Nets'} }) {
        for my $to (@{$ast->{'Nets'}{$net}{'To'}})   {
            if ($to->{'NodeType'} eq 'StencilAppl') {
            
                my $stencil_node = $to->{'Name'};
                say "Net $net input for stencil $stencil_node ";
                # say Dumper($ast->{'Nodes'}{'StencilAppl'}{$stencil_node});
                my $stencil_out = $ast->{'Nodes'}{$stencil_node}{'Outputs'}[0];
                # this $stencil_out is an input for a non-stencil node:
                my $target_node = $ast->{'Nets'}{$stencil_out}{'To'}[0]; # there can only be one
                $ast->{'Nets'}{$net}{'To'}=[$target_node];
            }
        }
        for my $from (@{$ast->{'Nets'}{$net}{'From'}})   {
            if ($from->{'NodeType'} eq 'StencilAppl') {        
                my $stencil_node = $from->{'Name'};
                say "Net $net output from stencil $stencil_node ";
                # say Dumper($ast->{'Nodes'}{'StencilAppl'}{$stencil_node});
                my $stencil_in = $ast->{'Nodes'}{$stencil_node}{'Inputs'}[0];
                # this $stencil_out is an input for a non-stencil node:
                my $target_node = $ast->{'Nets'}{$stencil_in}{'From'}[0]; # there can only be one
                $ast->{'Nets'}{$net}{'From'}=[$target_node];
            }        
        }
    }

    return $ast;
} # END of remove_stencil_nodes_from_connectivity_graph


# For every kernel, we look at its inputs and make a list of the kernels that provide those inputs, 
# noting if they are vec or scalar and if the kernels are map or fold. We also note non-kernel inputs 
# Considering the purpose, all we need is the non-fold dependencies
# I am using a flag for this
sub find_dataflow_dependencies { my ($ast)=@_;
    my $non_fold_only=1;
    for my $node (sort keys %{ $ast->{'Nodes'} }) {
        # say $node,Dumper $ast->{'Nodes'}{$node};
        # say $ast->{'Nodes'}{$node}{NodeType}," NODE: $node";
        $ast->{'Nodes'}{$node}{'Dependencies'}={};
        $ast = _find_deps_rec($ast,$node,$node,$non_fold_only);
        say $ast->{'Nodes'}{$node}{NodeType}," NODE: $node DEPS: ".Dumper($ast->{'Nodes'}{$node}{'Dependencies'}) unless $ast->{'Nodes'}{$node}{'NodeType'} eq 'Input' or $ast->{'Nodes'}{$node}{'NodeType'} eq 'StencilDef';
    }
    return $ast;
} # END of find_dataflow_dependencies

sub _find_deps_rec { my ($ast,$f_curr, $f_target,$non_fold_only) = @_;
# say $f_curr.':'. Dumper($ast->{'Nodes'}{$f_curr}{'Inputs'});
    for my $input_net_name ( @{ $ast->{'Nodes'}{$f_curr}{'Inputs'} } ) {
        # In the 'Nets' part of the AST we look up the 'From' field
        # I guess the best way is to make this the index into Lines
        # say "$f_curr $input_net_name".':'.Dumper($ast->{'Nets'}{$input_net_name}) ;
        my $dep_node_type=$ast->{'Nets'}{$input_net_name}{'From'}[0]{'NodeType'};
        
        if ($dep_node_type ne 'Input' and
        $dep_node_type ne 'StencilDef' and
             (not $non_fold_only or $dep_node_type ne 'Fold')
        ) {
            my $dep_entry_id = $ast->{'Nets'}{$input_net_name}{'From'}[0]{'EntryID'};
            my $dep_entry = $ast->{'Lines'}[$dep_entry_id];

            my $g = $dep_entry->{'Rhs'}{'Function'};
            $ast->{'Nodes'}{$f_target}{'Dependencies'}{$g}=$dep_node_type;            
            $ast = _find_deps_rec($ast,$g,$f_target,$non_fold_only);
        } 
        # else {
        #     say "LEAF: $input_net_name in $f_curr for $f_target";
        # }
    }
    # carp "SHOULD NEVER COME HERE!";
    return $ast;
    
} # END of _find_deps_rec

=pod latency

2019-08-08

annotate each edge with the latency
latencies are only non-0 for stencil caches

if a node has incoming edges with different latencies:
- the largest is propagated
- the paths from inputs to this node must be separated

I think we can follow each edge to its From, and get the (non-fold?) deps for that node. Then see if the cross-section is empty between all these paths, if so, no problem. If not, then the nodes in the cross section must be split.

So, 
- given a node
- with two or more inputs with different latency
- get the From nodes for each input
- get the dependencies for these nodes. 


=cut





sub emitDotGraph { (my $nets)=@_;
    # a -> b [ label="a to b" ];
    open my $DOT, '>', 'test_graph.dot' or die $!;
    say $DOT 'digraph G {';
    for my $net (sort keys %{$nets}) {
        my $entry = $nets->{$net};
        # carp Dumper $entry;
        for my $from (@{$entry->{'From'}}) {
        my $a = $from->{'NodeType'}.':'.$from->{'Name'};
        for my $to (@{$entry->{'To'}}) {
        my $b = $to->{'NodeType'}.':'.$to->{'Name'};
        my $edge_label = $entry->{'NetType'}.':'.$net;
        say $DOT "\"$a\" -> \"$b\" [ label=\"$edge_label\" ];";
        }
        }

    }
    say $DOT '}';
    close $DOT ;
}

sub __get_min_max_from_array { my ($values) = @_;

    my $max = shift @{$values};
    my $min = $max;

    for my $val (@{$values}) {
        $max = $val > $max ? $val : $max;
        $min = $val < $min ? $val : $min;
    }
    return ($min, $max);
} # END of __get_min_max_from_array_from_array


sub __add_to_MainArgTypes { my ($inoutargs,$stref,$fname,$var_name_rec,$main_rec) = @_;                
    my $orig_var_name= $var_name_rec->[0];
    my $var_name = _mkVarName($var_name_rec);
    my $var_rec =  $stref->{'Subroutines'}{$fname}{'DeclaredOrigArgs'}{'Set'}{$orig_var_name};
    # WV 2019-08-12 the '0' below feels hacky
    my $dim = $stref->{'Subroutines'}{ $fname }{'ArrayAccesses'}{0}{'Arrays'}{$orig_var_name}{'Dims'} ;
    # my $dim = $var_rec->{'Dim'};
    my $type = $var_rec->{'Type'};
    $main_rec->{$inoutargs.'Types'}{$var_name}=__toTyTraCLType($type,$dim);  
    return $main_rec;
} # END of __add_to_MainArgTypes

1;

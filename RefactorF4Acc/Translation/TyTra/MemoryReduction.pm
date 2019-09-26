package RefactorF4Acc::Translation::TyTra::MemoryReduction;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( pass_wrapper_subs_in_module );
use RefactorF4Acc::Refactoring::Fixes qw( remove_redundant_arguments_and_fix_intents );
use RefactorF4Acc::Translation::TyTra::Common qw( _mkVarName );

use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( identify_array_accesses_in_exprs );
use RefactorF4Acc::Translation::TyTraCL qw( emit_TyTraCL construct_TyTraCL_AST_Main_node generate_TyTraCL_stencils _add_TyTraCL_AST_entry );

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

@RefactorF4Acc::Translation::TyTra::MemoryReduction::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTra::MemoryReduction::EXPORT_OK = qw(
  &pass_memory_reduction
);


sub pass_memory_reduction {
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
        'ASTEmitter'   => \&_add_TyTraCL_AST_entry
    };
    $stref = pass_wrapper_subs_in_module(
        $stref, $module_name,

        # module-specific passes
        [],

        # subroutine-specific passes
        [
#				[ sub { (my $stref, my $f)=@_;  alias_ordered_set($stref,$f,'DeclaredOrigArgs','DeclaredOrigArgs'); } ],
            [\&remove_redundant_arguments_and_fix_intents],
            [\&identify_array_accesses_in_exprs],
        ]
    );

# say Dumper $stref->{'TyTraCL_AST'}{'Lines'};
    $stref = construct_TyTraCL_AST_Main_node($stref);
    $stref = _add_VE_to_AST($stref);
    $stref = _emit_TyTraCL_Haskell_AST_Code($stref);

    # What this does is emitting the Haskell AST to a Haskell module file
    my $tytracl_hs_str = $stref->{'TyTraCL_Haskell_AST_Code'};

    write_out($tytracl_hs_str);

    # This makes sure that no fortran is emitted by emit_all()
    $stref->{'SourceContains'} = {};

    exit;

    return $stref;
}    # END of pass_memory_reduction()

=info

The AST

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

ast = [
          (Vec VS "etan_s_0" , Stencil (SVec 5 "s1") (Vec VI "etan_0"))
          ,(Vec VS "wet_s_0" , Stencil (SVec 5 "s2") (Vec VI "wet_0"))
          ,(Vec VO "eta_1", Map (Function "shapiro_map_15 eps_0") (ZipT [Vec VS "wet_s_0",Vec VS "etan_s_0"]))
          ,(Vec VS "eta_s_0", Stencil (SVec 3 "s3") (Vec VO "eta_1"))
          ,((Tuple [Vec VO "du_1", Vec VO "dv_1"]) , UnzipT (Map (Function "dyn_map_38 (dt_0,g_0,dx_0,dy_0)") (Vec VS "eta_s_0") ) )
          ,(Vec VS "wet_s_1", Stencil (SVec 3 "s4") (Vec VI "wet_0"))
          ,(Tuple [Vec VT "duu_1",Vec VT "dvv_1",Vec VO "un_1",Vec VO "vn_1"] , UnzipT (Map (Function "dyn_map_44 (duu_0,dvv_0)") (ZipT [Vec VI "u_0",Vec VO "du_1",Vec VS "wet_s_1",Vec VI "v_0",Vec VO "dv_1"])) )
          ,(Vec VS "vn_s_0" , Stencil (SVec 2 "s5") (Vec VO "vn_1"))
          ,(Vec VS "un_s_0" , Stencil (SVec 2 "s6") (Vec VO "un_1"))
          ,(Vec VS "h_s_0" , Stencil (SVec 5 "s7") (Vec VI "h_0"))
          ,(Vec VO "etan_1" , Map (Function "dyn_map_64 (dt_0,dx_0,dy_0)") (ZipT [Vec VS "un_s_0",Vec VS "h_s_0",Vec VS "vn_s_0",Vec VS "eta_s_0"]))
          ,(Tuple [Vec VO "h_1",Vec VO "u_1",Vec VO "v_1",Vec VO "wet_1"] , UnzipT (Map (Function "vernieuw_map_23 hmin_0") (ZipT [Vec VI "hzero_0",Vec VS "eta_s_0",Vec VS "h_s_0",Vec VS "un_s_0",Vec VS "vn_s_0"])))
       ]


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


{'NodeType' => 'Comment','CommentStr' => 'shapiro_reduce_18'}
{'Rhs' => {'FoldArgs' => {'Vars' => [['etan',0,'']]},'NonFoldArgs' => {'Vars' => []},'Function' => 'shapiro_reduce_18','AccArgs' => {'Vars' => [['etan_avg',0,'']]}},'FunctionName' => 'shapiro_reduce_18','NodeType' => 'Fold','Lhs' => {'Vars' => [['etan_avg',1,'']]}}

{'CommentStr' => 'shapiro_map_23','NodeType' => 'Comment'}
{'NodeType' => 'StencilDef','Lhs' => {'Ctr' => 1},'FunctionName' => 'shapiro_map_23','Rhs' => {'StencilPattern' => {'Dims' => [['0',501],['0',501]],'Accesses' => {'0:-1' => [{'j:0' => [1,0]}],'0:0' => [{'k:0' => [1,0]}],'1:0' => [{'k:0' => [1,1]}],'0:1' => [{'j:0' => [1,0]}],'-1:0' => [{'k:0' => [1,-1]}]}}}}

{'Rhs' => {'Var' => ['wet',0,''],'StencilCtr' => 1},'FunctionName' => 'shapiro_map_23','NodeType' => 'StencilAppl','Lhs' => {'Var' => ['wet',0,'s']}}
{'NodeType' => 'StencilDef','Lhs' => {'Ctr' => 2},'Rhs' => {'StencilPattern' => {'Dims' => [['0',501],['0',501]],'Accesses' => {'0:1' => [{'k:0' => [1,0]}],'-1:0' => [{'j:0' => [1,-1]}],'0:-1' => [{'j:0' => [1,0]}],'1:0' => [{'j:0' => [1,1]}],'0:0' => [{'j:0' => [1,0]}]}}},'FunctionName' => 'shapiro_map_23'}

{'Lhs' => {'Var' => ['etan',0,'s']},'NodeType' => 'StencilAppl','FunctionName' => 'shapiro_map_23','Rhs' => {'StencilCtr' => 2,'Var' => ['etan',0,'']}}
{'Lhs' => {'Vars' => [['eta',1,'']]},'NodeType' => 'Map','FunctionName' => 'shapiro_map_23','Rhs' => {'Function' => 'shapiro_map_23','MapArgs' => {'Vars' => [['wet',0,'s'],['etan',0,'s'],['eta',0,'']]},'NonMapArgs' => {'Vars' => [['eps',0,''],['etan_avg',1,'']]}}}

{'NodeType' => 'Comment','CommentStr' => 'dyn_map_39'}
{'NodeType' => 'StencilDef','Lhs' => {'Ctr' => 3},'Rhs' => {'StencilPattern' => {'Accesses' => {'0:0' => [{'j:0' => [1,0]}],'0:-1' => [{'k:0' => [1,0]}]},'Dims' => [['0',501],['0',501]]}},'FunctionName' => 'dyn_map_39'}
{'NodeType' => 'StencilAppl','Lhs' => {'Var' => ['un',0,'s']},'Rhs' => {'Var' => ['un',0,''],'StencilCtr' => 3},'FunctionName' => 'dyn_map_39'}
{'Rhs' => {'StencilPattern' => {'Accesses' => {'-1:0' => [{'j:0' => [1,-1]}],'0:0' => [{'k:0' => [1,0]}]},'Dims' => [['0',501],['0',501]]}},'FunctionName' => 'dyn_map_39','NodeType' => 'StencilDef','Lhs' => {'Ctr' => 4}}
{'Lhs' => {'Var' => ['vn',0,'s']},'NodeType' => 'StencilAppl','FunctionName' => 'dyn_map_39','Rhs' => {'StencilCtr' => 4,'Var' => ['vn',0,'']}}
{'NodeType' => 'StencilDef','Lhs' => {'Ctr' => 5},'FunctionName' => 'dyn_map_39','Rhs' => {'StencilPattern' => {'Dims' => [['0',501],['0',501]],'Accesses' => {'0:1' => [{'k:0' => [1,0]}],'1:0' => [{'k:0' => [1,1]}],'0:0' => [{'j:0' => [1,0]}]}}}}
{'Lhs' => {'Var' => ['wet',1,'s']},'NodeType' => 'StencilAppl','FunctionName' => 'dyn_map_39','Rhs' => {'Var' => ['wet',0,''],'StencilCtr' => 5}}
{'Lhs' => {'Ctr' => 6},'NodeType' => 'StencilDef','FunctionName' => 'dyn_map_39','Rhs' => {'StencilPattern' => {'Dims' => [['0',501],['0',501]],'Accesses' => {'0:0' => [{'k:0' => [1,0]}],'1:0' => [{'k:0' => [1,1]}],'0:-1' => [{'j:0' => [1,0]}],'-1:0' => [{'j:0' => [1,-1]}],'0:1' => [{'j:0' => [1,0]}]}}}}
{'Rhs' => {'StencilCtr' => 6,'Var' => ['h',0,'']},'FunctionName' => 'dyn_map_39','NodeType' => 'StencilAppl','Lhs' => {'Var' => ['h',0,'s']}}
{'Rhs' => {'StencilPattern' => {'Accesses' => {'1:0' => [{'j:0' => [1,1]}],'0:0' => [{'k:0' => [1,0]}],'0:1' => [{'k:0' => [1,0]}]},'Dims' => [['0',501],['0',501]]}},'FunctionName' => 'dyn_map_39','NodeType' => 'StencilDef','Lhs' => {'Ctr' => 7}}
{'Rhs' => {'Var' => ['eta',1,''],'StencilCtr' => 7},'FunctionName' => 'dyn_map_39','NodeType' => 'StencilAppl','Lhs' => {'Var' => ['eta',0,'s']}}
{'FunctionName' => 'dyn_map_39','Rhs' => {'NonMapArgs' => {'Vars' => [['dt',0,''],['g',0,''],['dx',0,''],['dy',0,''],['duu',0,''],['dvv',0,'']]},'Function' => 'dyn_map_39','MapArgs' => {'Vars' => [['eta',0,'s'],['u',0,''],['du',0,''],['wet',1,'s'],['v',0,''],['dv',0,''],['un',0,'s'],['h',0,'s'],['vn',0,'s']]}},'NodeType' => 'Map','Lhs' => {'Vars' => [['du',1,''],['duu',1,''],['dv',1,''],['dvv',1,''],['etan',1,''],['un',1,''],['vn',1,'']]}}

{'NodeType' => 'Comment','CommentStr' => 'update_map_24'}
{'Lhs' => {'Vars' => [['h',1,''],['u',1,''],['v',1,''],['wet',1,'']]},'NodeType' => 'Map','FunctionName' => 'update_map_24','Rhs' => {'NonMapArgs' => {'Vars' => [['hmin',0,'']]},'MapArgs' => {'Vars' => [['hzero',0,''],['eta',0,'s'],['h',0,'s'],['un',0,'s'],['vn',0,'s']]},'Function' => 'update_map_24'}}


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

=info_VE
VE is the Haskell datatype

        data VE = VI  | VO  | VS  | VT

The VI | VO information is available by testing against

        $stref->{'TyTraCL_AST'}{'Main'}{InArgsTypes}
        $stref->{'TyTraCL_AST'}{'Main'}{OutArgsTypes}

The VS information is in the var name tuple: an 's' means VS
So we start by setting the value to VT.

I will simply extend the var tuple with this additional attribute, as a string.
=cut
sub _emit_TyTraCL_Haskell_AST_Code {
    (my $stref) = @_;

    my $tytracl_ast  = $stref->{'TyTraCL_AST'};


    my $tytracl_hs_ast_strs = [];
    for my $node (@{$tytracl_ast->{'Lines'}}) {

        if ($node->{'NodeType'} eq 'StencilDef') {
            # do nothing
        }
        elsif ($node->{'NodeType'} eq 'StencilAppl') {

            my $line = mkStencilApplAST($node);
            push @{$tytracl_hs_ast_strs}, $line;
        }

        elsif ($node->{'NodeType'} eq 'Map') {
            my $line = mkMapAST($node);
            push @{$tytracl_hs_ast_strs}, $line;
        }
        elsif ($node->{'NodeType'} eq 'Fold') {
            my $line = mkFoldAST($node);
           push @{$tytracl_hs_ast_strs}, $line;
        }
        elsif ($node->{'NodeType'} eq 'Comment') {
            my $line = ' -- ' . $node->{'CommentStr'};
         push @{$tytracl_hs_ast_strs}, $line;
        }
        else {
            croak;
        }
    }

my $header =
'module ASTInstance where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
';

    my @indented_tytracl_hs_ast_strs=();
    my $idx=0;
    for my $tytracl_hs_ast_str ( @{$tytracl_hs_ast_strs}) {
        my $indented_tytracl_hs_ast_str = $tytracl_hs_ast_str;
            if ($idx>0 and $tytracl_hs_ast_str!~/^\s*\-\-/) {
                $tytracl_hs_ast_str=','.$tytracl_hs_ast_str;
            }
            $indented_tytracl_hs_ast_str='        '.$indented_tytracl_hs_ast_str;
            ++$idx;
            push @indented_tytracl_hs_ast_strs, $indented_tytracl_hs_ast_str;
    }

    my $tytracl_hs_ast_code_str=join("\n", @indented_tytracl_hs_ast_strs);
    $tytracl_hs_ast_code_str=$header.$tytracl_hs_ast_code_str."\n        ]\n";

    $stref->{'TyTraCL_Haskell_AST_Code'} = $tytracl_hs_ast_code_str ;

    return $stref;
}    # END of _emit_TyTraCL_Haskell_AST_Code


sub _add_VE_to_AST {
    (my $stref) = @_;

    my $tytracl_ast  = $stref->{'TyTraCL_AST'};


    for my $node (@{$tytracl_ast->{'Lines'}}) {

        if ($node->{'NodeType'} eq 'StencilDef') {
            # do nothing
        }
        elsif ($node->{'NodeType'} eq 'StencilAppl') {

            push @{$node->{'Lhs'}{'Var'}}, 'VS';
            my $rhs_var_rec = $node->{'Rhs'}{'Var'};

            my $ve= __determine_VE($stref, $rhs_var_rec);

            push @{$node->{'Rhs'}{'Var'}}, $ve;
        }

        elsif ($node->{'NodeType'} eq 'Map') {
            $node->{'Lhs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Lhs'}{'Vars'} }
            ];

            $node->{'Rhs'}{'MapArgs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Rhs'}{'MapArgs'}{'Vars'} }
            ];
        }
        elsif ($node->{'NodeType'} eq 'Fold') {

            $node->{'Rhs'}{'FoldArgs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Rhs'}{'FoldArgs'}{'Vars'} }
            ];

        }
        elsif ($node->{'NodeType'} eq 'Comment') {
            # do nothing
        }
        else {
            croak;
        }
    }

    return $stref;
}    # END of _add_VE_to_AST()


# ==============================================================================================================================
# AUX
# ==============================================================================================================================


# mkFold(shapiro_reduce_18 => [] , [['etan_avg',0,'']] => [['etan',0,'']] => [['etan_avg',1,'']]);
sub mkFold {
    my ($fname, $non_fold_args, $acc_args, $fold_args, $ret_vars) = @_;
    return {
        'Rhs' => {
            'FoldArgs'    => {'Vars' => $fold_args},
            'NonFoldArgs' => {'Vars' => $non_fold_args},
            'Function'    => $fname,
            'AccArgs'     => {'Vars' => $acc_args}
        },
        'FunctionName' => $fname,
        'NodeType'     => 'Fold',
        'Lhs'          => {'Vars' => $ret_vars}
    };
}

# mkMap( shapiro_map_23 => [['eps',0,''],['etan_avg',1,'']] => [['wet',0,'s'],['etan',0,'s'],['eta',0,'']] => [['eta',1,'']] );
sub mkMap {
    my ($fname, $non_map_args, $map_args, $ret_vars) = @_;
    return {
        'Rhs' => {
            'MapArgs'    => {'Vars' => $map_args},
            'NonMapArgs' => {'Vars' => $non_map_args},
            'Function'   => $fname,
        },
        'FunctionName' => $fname,
        'NodeType'     => 'Map',
        'Lhs'          => {'Vars' => $ret_vars}
    };
}

# mkStencilAppl( 1 => ['wet',0,''] => ['wet',0,'s']);
sub mkStencilAppl {
    my ($ctr, $arg, $ret_var) = @_;
    return {
        'Rhs'          => {'Var' => $arg, 'StencilCtr' => $ctr},
        'FunctionName' => "sa$ctr",
        'NodeType'     => 'StencilAppl',
        'Lhs'          => {'Var' => $ret_var}
    };
}

# mkStencilDef(2, [-1,-502,0,502,1]);
sub mkStencilDef {
    my ($ctr, $pattern) = @_;
    return {
        'NodeType'     => 'StencilDef',
        'Lhs'          => {'Ctr' => 1},
        'FunctionName' => "s$ctr",
        'Rhs'          => {'StencilPattern' => {'Pattern' => $pattern,}}
    };
}

sub addTypeDecl {
    my ($stref, $f, $var_name, $var_type, $dim) = @_;

    $stref->{'Subroutines'}{$f}{'ArrayAccesses'}{0}{'Arrays'}{$var_name} = {'Dims' => $dim};
    $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name} = {'Type' => $var_type};
    return $stref;
}


#========================================================================================================================

# The code below is for the memory reduction pass
# This should of course go into a separate module MemoryReduction.pm
# I  emit the Haskell AST, then the work is done in Haskell.
# I could then re-emit the Perl AST and go from there to Fortran, or emit Fortran straight from Haskell

sub mkStencilApplAST {
    (my $stencilApplNode) = @_;

    # $stencilApplNode = {
    #     'Lhs' => {'Var' => ['etan',0,'s']},
    #     'NodeType' => 'StencilAppl',
    #     'FunctionName' => 'shapiro_map_23',
    #     'Rhs' => {'StencilCtr' => 2,'Var' => ['etan',0,'']}};
    my $s_var    = _mkVarName($stencilApplNode->{'Lhs'}{'Var'});
    my $var      = _mkVarName($stencilApplNode->{'Rhs'}{'Var'});
    my $ve       = $stencilApplNode->{'Rhs'}{'Var'}[3];
    my $s        = 's' . $stencilApplNode->{'Rhs'}{'StencilCtr'};
    my $s_sz     = $stencilApplNode->{'Rhs'}{'StencilSz'};
    my $ast_line = '(Vec VS "' . $s_var . '" , Stencil (SVec ' . $s_sz . ' "' . $s . '") (Vec ' . $ve . ' "' . $var . '"))';

    return $ast_line;
}

=perl2hs
((Tuple [Vec VO "du_1", Vec VO "dv_1"]) , UnzipT (Map (Function "dyn_map_38 (dt_0,g_0,dx_0,dy_0)") (Vec VS "eta_s_0") ) )
,(Tuple [Vec VT "duu_1",Vec VT "dvv_1",Vec VO "un_1",Vec VO "vn_1"] , UnzipT (Map (Function "dyn_map_44 (duu_0,dvv_0)") (ZipT [Vec VI "u_0",Vec VO "du_1",Vec VS "wet_s_1",Vec VI "v_0",Vec VO "dv_1"])) )
,(Vec VO "etan_1" , Map (Function "dyn_map_64 (dt_0,dx_0,dy_0)") (ZipT [Vec VS "un_s_0",Vec VS "h_s_0",Vec VS "vn_s_0",Vec VS "eta_s_0"]))
,(Tuple [Vec VO "h_1",Vec VO "u_1",Vec VO "v_1",Vec VO "wet_1"] , UnzipT (Map (Function "vernieuw_map_23 hmin_0") (ZipT [Vec VI "hzero_0",Vec VS "eta_s_0",Vec VS "h_s_0",Vec VS "un_s_0",Vec VS "vn_s_0"])))
,(Vec VO "eta_1", Map (Function "shapiro_map_15 eps_0") (ZipT [Vec VS "wet_s_0",Vec VS "etan_s_0"]))

{'Lhs' => {'Vars' => [['eta',1,'']]},'NodeType' => 'Map','FunctionName' => 'shapiro_map_23','Rhs' => {'Function' => 'shapiro_map_23','MapArgs' => {'Vars' => [['wet',0,'s'],['etan',0,'s'],['eta',0,'']]},'NonMapArgs' => {'Vars' => [['eps',0,''],['etan_avg',1,'']]}}}
{'FunctionName' => 'dyn_map_39','Rhs' => {'NonMapArgs' => {'Vars' => [['dt',0,''],['g',0,''],['dx',0,''],['dy',0,''],['duu',0,''],['dvv',0,'']]},'Function' => 'dyn_map_39','MapArgs' => {'Vars' => [['eta',0,'s'],['u',0,''],['du',0,''],['wet',1,'s'],['v',0,''],['dv',0,''],['un',0,'s'],['h',0,'s'],['vn',0,'s']]}},'NodeType' => 'Map','Lhs' => {'Vars' => [['du',1,''],['duu',1,''],['dv',1,''],['dvv',1,''],['etan',1,''],['un',1,''],['vn',1,'']]}}

If the LHS is a tuple, we emit Tuple [Vec ...,...]  and the RHS needs UnzipT
If the MapArgs is a tuple, we emit ZipT [Vec ..., ...]  else Vec ...

So really the only issue is the I/O/S/T type
=cut


# This will need context, unless I already add the I/O/T/S types when creating the AST
sub mkMapAST {
    (my $mapNode) = @_;

# I need to determine if a vector is VO, VI, VS or VS
# VS is for stencil
# I should know the inputs and outputs
# anything else is VT

# more than one
    my $lhs = scalar @{$mapNode->{'Lhs'}{'Vars'}} > 1
      ? '(Tuple [' . join(',', map { __mkVec($_) } @{$mapNode->{'Lhs'}{'Vars'}}) . '])'

# otherwise
      : __mkVec($mapNode->{'Lhs'}{'Vars'}[0]);
    my $map_args =
      scalar @{$mapNode->{'Rhs'}{'MapArgs'}{'Vars'}} > 1
      ? '(ZipT [' . join(',', map { __mkVec($_) } @{$mapNode->{'Rhs'}{'MapArgs'}{'Vars'}}) . '])'
      : '(' . __mkVec($mapNode->{'Rhs'}{'MapArgs'}{'Vars'}[0]) . ')';
    my $f_exp = $mapNode->{'Rhs'}{'Function'};
    if (exists $mapNode->{'Rhs'}{'NonMapArgs'}
        and scalar @{$mapNode->{'Rhs'}{'NonMapArgs'}{'Vars'}} > 0)
    {
# FIXME: I guess a single arg should not be a tuple ...
        my $non_map_arg_str = ' (' . join(',', map { _mkVarName($_) } @{$mapNode->{'Rhs'}{'NonMapArgs'}{'Vars'}}) . ')';
        $f_exp .= $non_map_arg_str;
    }
    my $rhs_core = 'Map (Function "' . $f_exp . '") ' . $map_args . ')';


    my $rhs = scalar @{$mapNode->{'Lhs'}{'Vars'}} > 1 ? "UnzipT ( $rhs_core )" : $rhs_core;

    my $ast_line = "( $lhs, $rhs )";

    return $ast_line;
}

sub mkFoldAST {
    (my $foldNode) = @_;

# {'Rhs' => {'FoldArgs' => {'Vars' => [['etan',0,'']]},'NonFoldArgs' => {'Vars' => []},'Function' => 'shapiro_reduce_18','AccArgs' => {'Vars' => [['etan_avg',0,'']]}},
# 'Lhs' => {'Vars' => [['etan_avg',1,'']]}}
# I need to determine if a vector is VO, VI, VS or VS
# VS is for stencil
# I should know the inputs and outputs
# anything else is VT

# more than one
    my $lhs =

     scalar @{$foldNode->{'Lhs'}{'Vars'}} > 1
      ? '(Tuple [' . join(',', map { __mkScalar($_) } @{$foldNode->{'Lhs'}{'Vars'}}) . '])'
# otherwise
    : __mkScalar($foldNode->{'Lhs'}{'Vars'}[0]);
    my $fold_args =
      scalar @{$foldNode->{'Rhs'}{'FoldArgs'}{'Vars'}} > 1
      ? '(ZipT [' . join(',', map { __mkVec($_) } @{$foldNode->{'Rhs'}{'FoldArgs'}{'Vars'}}) . '])'
      : '(' . __mkVec($foldNode->{'Rhs'}{'FoldArgs'}{'Vars'}[0]) . ')';
    my $acc_args =   scalar @{$foldNode->{'Rhs'}{'AccArgs'}{'Vars'}} > 1
      ? '(' . join(',', map { __mkScalar($_) } @{$foldNode->{'Rhs'}{'AccArgs'}{'Vars'}}) . ')'
      : '(' . __mkScalar($foldNode->{'Rhs'}{'AccArgs'}{'Vars'}[0]) . ')';
    my $f_exp = $foldNode->{'Rhs'}{'Function'};
    if (exists $foldNode->{'Rhs'}{'NonFoldArgs'}
        and scalar @{$foldNode->{'Rhs'}{'NonFoldArgs'}{'Vars'}} > 0)
    {
# FIXME: I guess a single arg should not be a tuple ...
        my $non_fold_arg_str = ' (' . join(',', map { _mkVarName($_) } @{$foldNode->{'Rhs'}{'NonFoldArgs'}{'Vars'}}) . ')';
        $f_exp .= $non_fold_arg_str;
    }
    my $rhs = 'Fold (Function "' . $f_exp . '") ' . $acc_args.' '.$fold_args . ')';

    my $ast_line = "( $lhs, $rhs )";

    return $ast_line;
}


sub __mkVec {
    my ($v_rec) = @_;
    my $v_name  = _mkVarName($v_rec);
    my $ve      = $v_rec->[3];
    return 'Vec ' . $ve . ' "' . $v_name . '"';
}

sub __mkScalar {
    my ($v_rec) = @_;
    my $v_name  = _mkVarName($v_rec);
    return 'Scalar "' . $v_name . '"';
}


sub __determine_VE { (my $stref, my $var_rec)=@_;
    if ($var_rec->[2] eq 's') {
        return 'VS'
    } else {
        my $var_name = _mkVarName($var_rec);
        my $ve='VT';
        if (exists $stref->{'TyTraCL_AST'}{'Main'}{'InArgsTypes'}{$var_name}) {
            $ve='VI';
        }
        elsif (exists $stref->{'TyTraCL_AST'}{'Main'}{'OutArgsTypes'}{$var_name}) {
            $ve='VO';
        }
        return $ve;
    }
} # END of __determine_VE

1;

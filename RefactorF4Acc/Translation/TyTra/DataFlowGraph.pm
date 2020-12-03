package RefactorF4Acc::Translation::TyTra::DataFlowGraph;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw(
	pass_wrapper_subs_in_module					
	);
use RefactorF4Acc::Translation::TyTra::Common qw( 
    _mkVarName 
    addTypeDecl
    mkMap
    mkFold
    mkStencilDef
    mkStencilAppl
    mkComment
    );
use RefactorF4Acc::Translation::TyTraCL qw( 
    emit_TyTraCL 
    construct_TyTraCL_AST_Main_node 
    generate_TyTraCL_stencils
    );

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

@RefactorF4Acc::Translation::TyTra::DataFlowGraph::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTra::DataFlowGraph::EXPORT_OK = qw(
&main
);


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

sub main {
    my $stref={};
    $stref->{'EmitAST'} = 'TyTraCL_AST';
	$stref->{'TyTraCL_AST'} = {
        'Lines' => [],
        'Selects'=>[], 'Inserts'=>[], 'Stencils'=>{},'Portions'=>{}, 
        'Main' => {},
        'MainFunction' => 'main',       
        };

        # Proof of concept of constructing an AST using a small API
        # I'm sure I can refine this a bit¡

        for my $f (qw(f1 f2 f3 f4  f5 sa1)) {
            $stref = addTypeDecl( $stref, $f, 'v', 'integer', [[1,500]]);
            $stref = addTypeDecl( $stref, $f, 'acc', 'integer', []);
        }
        
       $stref->{'TyTraCL_AST'} = {
        'OrigArgs' => {'v' => 'inout','acc'=>'local'},
        'UniqueVarCounters'=>{'v' => 4,'acc'=>1},
        'Lines' => [
            mkMap('f1'=>[]=>[['v',0,'']],[['v',1,'']]),
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['v',1,'']=>['v',1,'s']),
            mkMap('f2'=>[]=>[['v',1,'']],[['v',2,'']]),
            mkMap('f3'=>[]=>[['v',2,''],['v',1,'s']]=>[['v',3,'']]),
            mkFold('f4'=>[]=>[['',0,'']]=>[['v',3,'']]=>[['acc',1,'']]),
            mkMap('f5'=>[['acc',1,'']]=>[['v',3,'']]=>[['v',4,'']]),
        ], 
        };

        $stref = construct_TyTraCL_AST_Main_node($stref);
        $stref = emit_TyTraCL($stref);
        my $tytracl_str = $stref->{'TyTraCL_Code'} ;
        say $tytracl_str;        

        my $ast = $stref->{'TyTraCL_AST'} ; # The MainRec node has info about VarTypes and Stencils
        say '=' x 80;
        say '=' x 10, ' Build Connectivity Graph ';
        say '=' x 80;
        
        $ast = build_connectivity_graph($ast);
        say '=' x 80;
        say '=' x 10, ' Add IO Nodes to Connectivity Graph ';
        say '=' x 80;

        $ast = add_io_nodes_to_connectivity_graph($ast);

        say '=' x 80;
        say '=' x 10, 'Add IO Net Types';
        say '=' x 80;
$ast = generate_breadth_first_ordering($ast);
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
} # END of main()



# ==============================================================================================================================
# GRAPH ANALYSIS AND TRANSFORMATION FOR SPLITTING AND STAGING
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

# This routine builds up the 'Nets' and 'Nodes' tables based on the 'Lines' in the AST 
sub build_connectivity_graph { my ($ast) = @_;
# For stencils this is trivial and it looks like we don't have zipt/unzipt in the AST
# So for a stencil node, we replace the out net by the in net and continue.
# So to build 'Nets', I think it is actually very simple:

    $ast->{'Nets'}={};
    $ast->{'Nodes'}={};
    my $entry_id=0;
    local $Data::Dumper::Indent =0;
    local $Data::Dumper::Terse=1;
    for my $entry ( @{ $ast->{'Lines'} } ) {
        say Dumper $entry;
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
        }
        elsif ($node_type eq 'Fold') { 
        # Inputs are Rhs NonFoldArgs and Rhs FoldArgs and presumably Rhs AccArgs   
        # So how do I get the Latency for the fold? I think we should actually explicitly type all input vectors!
             $f = $entry->{'Rhs'}{'Function'};
            my @outputs = map { _mkVarName($_)  } @{ $entry->{'Lhs'}{'Vars'} };
            my @fold_inputs = map { _mkVarName($_)  } @{ $entry->{'Rhs'}{'FoldArgs'}{'Vars'} };
            my @nonfold_inputs = map { _mkVarName($_)  } @{ $entry->{'Rhs'}{'NonFoldArgs'}{'Vars'} };
            my @acc_inputs = map { _mkVarName($_)  } grep {$_->[0] ne '' } @{ $entry->{'Rhs'}{'AccArgs'}{'Vars'} };

            for my $output (@outputs) {
                say "$node_type $f OUT: $output";     
                push @{$ast->{'Nets'}{$output}{'From'}},{'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};
                $ast->{'Nets'}{$output}{'NetType'}=['Scalar'];
                push @{$ast->{'Nodes'}{$f}{'Outputs'}}, $output;
            }
            for my $input (@fold_inputs) {
                say "$node_type $f IN: $input";     
                push @{$ast->{'Nets'}{$input}{'To'}},{'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};
                $ast->{'Nets'}{$input}{'NetType'}='Stream';
                $ast->{'Nets'}{$input}{'Latency'}=0; 
                push @{$ast->{'Nodes'}{$f}{'Inputs'}}, $input;
            }
            for my $input (@nonfold_inputs, @acc_inputs) {
                say "$node_type $f IN: $input";     
                push @{$ast->{'Nets'}{$input}{'To'}},{'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};
                $ast->{'Nets'}{$input}{'NetType'}=['Scalar'];
                push @{$ast->{'Nodes'}{$f}{'Inputs'}}, $input;
            }
            $node_inputs=[@fold_inputs,@nonfold_inputs,@acc_inputs];
            $node_outputs = \@outputs;
            # TODO! 
            # The latency for a fold node is the size of the vector to fold 
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
            my $stencil_values = generate_TyTraCL_stencils($stencil_patt);
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

# The graph resulting from build_connectivity_graph() does not have actual nodes for inputs and outputs. We add them here.
sub add_io_nodes_to_connectivity_graph { my ($ast) = @_;
    
    for my $net (sort keys %{ $ast->{'Nets'} }) {                
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

# This adds info from $main_rec->{'InArgsTypes'} to $ast->{'Nets'}{$arg}{'NetType'} and same for Out
# The type info is 
# $scalar_type = Int | Float
# $tycl_type=' ['Vec' ,$vec_sz, $scalar_type]; 

sub add_io_net_types { my ($ast) = @_;
    my $main_rec = $ast->{'Main'};
    my $in_args_types = $main_rec->{'InArgsTypes'};
    for my  $arg (sort keys %{$in_args_types}){
        if (exists $ast->{'Nets'}{$arg}) {
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

# A utility to simplify the graph, currently unused
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
# $ast->{'Nodes'}{$node}{'Dependencies'}{$fname}=$ftype;
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

If a node has incoming edges with different latencies:
- the largest is propagated
- the paths from inputs to this node must be separated

I think we can follow each edge to its From, and get the (non-fold?) deps for that node. Then see if the cross-section is empty between all these paths,
- If so, no problem. 
- If not, then the nodes in the cross section must be split.

So, 
- Given a node with two or more inputs with different latency:
    - Group and sort by latency. The highest-latency net is what we preserve, the others will now lead *eventually* to a split-out subgraph
    - I think we need do all-to-all here at group level    
    - Get the From nodes for each input
        - A key question to sort out is, given a From node, which net needs to be rewired? Essentially I think it is any net that leads to a node in the split-out graph. If there is no such net, we need to follow upstream until we find one.
    - Get the dependencies for these nodes, include the node itself
    - Get the subgraph of all nodes in the intersection of the dependencies
    - Wire up that subgraph: all nodes, and any net that leads to a node within the subgraph, need to be renamed
        - Note that the subgraph still part of the original graph will keep all its connections except those that lead to the input net we started from
    - Then actually repeat the whole procedure within this subgraph, because there can be subgraphs that need splitting in there. This is recursive
    - Wire the subgraph into the graph
    - Repeat the procedure on the whole graph.
=cut

sub split_paths {  my ($ast) = @_;
    # loop over all Map and Fold nodes. No other node, I think, should have more than one input.
    my $node_name; # TODO

    my @in_nets = @{ $ast->{'Nodes'}{$node_name}{'Inputs'} };
    if (scalar @in_nets > 1) {

    my $split_paths=0;
    my %latency_group_hash=(); # Do this even if it turns out we don't have a case

    my $net_1 = shift @in_nets;#
    my $lat_1 = $ast->{'Nets'}{$net_1}{'Latency'};
    if (not exists $latency_group_hash{$lat_1} ) {
        $latency_group_hash{$lat_1}=[$net_1];
    } else {
        push @{$latency_group_hash{$lat_1}}, $net_1;     
    }
    for my $net_2 (@in_nets) {
        my $lat_2 = $ast->{'Nets'}{$net_2}{'Latency'};
        if (not exists $latency_group_hash{$lat_2} ) {
            $latency_group_hash{$lat_2}=[$net_2];
        } else {
            push @{$latency_group_hash{$lat_2}}, $net_2;     
        }
        if ($lat_1 != $lat_2) {
            $split_paths=1;                
        }
    }

    if ($split_paths) {
        my @sorted_latencies = reverse sort keys %latency_group_hash;
        my @latency_groups= map {  $latency_group_hash{$_}  } @sorted_latencies;

        for my $g_idx_1 (0 .. scalar( @latency_groups ) - 1 ) {
            # For every net in the latency group
            my $latency_group_1 = $latency_groups[$g_idx_1];
            my %deps_1=();
            for my $net_1 (@{$latency_group_1}) {
                # Find From-node 1             
                my $from_node_1 = $ast->{'Nets'}{$net_1}{'From'}[0];
                 my $deps_from_node_1 = $ast->{'Nodes'}{$from_node_1->{'Name'}}{'Dependencies'};    
                # Get the dependencies for this node, include the node itself
                %deps_1 = (%deps_1,%{$deps_from_node_1});
            }    
            for my $g_idx_2 ($g_idx_1+1 .. scalar( @latency_groups ) - 1 ) {
                # Find From-node 2
                # Get the dependencies for this node, include the node itself
                my $latency_group_2 = $latency_groups[$g_idx_2];
                my %deps_2=();
                for my $net_2 (@{$latency_group_2}) {
                    # Find From-node 1             
                    my $from_node_2 = $ast->{'Nets'}{$net_2}{'From'}[0];
                    my $deps_from_node_2 = $ast->{'Nodes'}{$from_node_2->{'Name'}}{'Dependencies'};    
                    # Get the dependencies for this node, include the node itself
                    %deps_2 = (%deps_2,%{$deps_from_node_2});
                }                    
                # Compute the intersection
                my $subgraph_nodes = intersection(\%deps_1,\%deps_2);
                # Create the subgraph
            }
        }
    }
    }
    return $ast;
} # END of split_paths


sub generate_breadth_first_ordering { my ($ast)=@_;
    $ast->{'ByDist'}=[];
    for my $node (sort keys %{ $ast->{'Nodes'} }) {
        if ($ast->{'Nodes'}{$node}{'NodeType'} eq 'Input') {
            $ast->{'Nodes'}{$node}{'Dist'}=0;
            push @{$ast->{'ByDist'}[0]},$node;
        }
    }
    $ast = _gen_breadth_first_ord_rec(0, $ast);
    croak Dumper $ast->{'ByDist'};
    return $ast;

} # END of generate_breadth_first_ordering

sub _gen_breadth_first_ord_rec { my ($dist, $ast) = @_;
    my $nodes = $ast->{'ByDist'}[$dist];
    # say Dumper $nodes;
    for my $node (@{$nodes}){
        # get the output edges
        if ($ast->{'Nodes'}{$node}{'NodeType'} ne 'Output' and
            exists $ast->{'Nodes'}{$node}{'Outputs'} ) {
            my $out_nets = $ast->{'Nodes'}{$node}{'Outputs'};
            # from there get the dests 
            my @dests = map { @{ $ast->{'Nets'}{$_}{'To'} } } @{$out_nets}; # so this is a flat array;

            for my $dest (@dests) {
                my $node_name = $dest->{'Name'};
                if (not exists $ast->{'Nodes'}{$node_name}{'Dist'} ) {
                    $ast->{'Nodes'}{$node_name}{'Dist'} = $dist+1;
                    push @{$ast->{'ByDist'}[$dist+1]},$node_name;
                }
                
            }
        }
    }
    # die;
    if (defined $ast->{'ByDist'}[$dist+1] and scalar @{$ast->{'ByDist'}[$dist+1]}>0) {
        # say $dist+1,Dumper($ast->{'ByDist'}[$dist+1]);
        $ast = _gen_breadth_first_ord_rec($dist+1, $ast);
    }
    return $ast;
} # END of _gen_breadth_first_ord_rec

# ==============================================================================================================================
# AUX
# ==============================================================================================================================

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


1;
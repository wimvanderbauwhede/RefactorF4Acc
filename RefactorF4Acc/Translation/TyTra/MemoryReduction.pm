package RefactorF4Acc::Translation::TyTra::MemoryReduction;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( pass_wrapper_subs_in_module emit_f95_var_decl);
use RefactorF4Acc::Refactoring::Fixes qw( remove_redundant_arguments_and_fix_intents );
use RefactorF4Acc::Translation::TyTra::Common qw( 
    _mkVarName    
    mkMap
    mkFold
    mkStencilDef
    mkStencilAppl
    mkComment
    addTypeDecl    
    mkAST
);

use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( identify_array_accesses_in_exprs );
use RefactorF4Acc::Translation::TyTraCL qw( 
    emit_TyTraCL construct_TyTraCL_AST_Main_node 
    generate_TyTraCL_stencils 
    _add_TyTraCL_AST_entry
    _emit_TyTraCL_FunctionSigs
    __toTyTraCLType
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

@RefactorF4Acc::Translation::TyTra::MemoryReduction::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTra::MemoryReduction::EXPORT_OK = qw(
  &pass_memory_reduction
);


sub pass_memory_reduction {
    (my $stref, my $module_name) = @_;
    
    my $TEST =  exists $Config{'TEST'} ? $Config{'TEST'} : 0;
    
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
if ($TEST==0) {
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
}
elsif ($TEST==1) { 
 # 3 maps with 2 stencils in between.
    $stref = mkAST(
        [
            mkMap('f1'=>[]=>[['v',0,'']]=>[['v',1,'']]),
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['v',1,'']=>['v',1,'s']),            
            mkMap('f2'=>[]=>[['v',1,'s']]=>[['v',2,'']]),
            mkStencilDef(2,[-1,0,1]),
            mkStencilAppl(2,3,['v',2,'']=>['v',2,'s']),
            mkMap('f3'=>[]=>[['v',2,'s']]=>[['v',3,'']]),            
        ],
        {'v' =>[ 'integer', [1,500], 'inout'] }
    );            
}
elsif ($TEST==2) {      
# two maps, one stencil, but two input vectors      
    $stref = mkAST(
        [
            mkMap('f1'=>[['nm',0,'']]=>[['v1',0,''],['v2',0,'']]=>[['v3',0,'']]),
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['v3',0,'']=>['v3',0,'s']),
            mkMap('f2'=>[]=>[['v3',0,'s']],[['v4',0,'']]),
        ],
        {
            'nm' =>[ 'integer', 'in'],
    'v1' =>[ 'integer', [1,500], 'in'],
    'v2' =>[ 'integer', [1,500], 'in'],
    'v3' =>[ 'integer', [1,500], 'local'],
    'v4' =>[ 'integer', [1,500], 'out']   
}
    );  
}
elsif ($TEST==3) {
# fold-stencil-map    
    $stref = mkAST(
        [
            mkFold('f1'=>[]=>[['acc',0,'']]=>[['v',0,'']],[['acc',1,'']]),
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['v',0,'']=>['v',0,'s']),
            mkMap('f2'=>[['acc',1,'']]=>[['v',0,'s']],[['v',1,'']]),
        ],
        {
        'v' =>[ 'integer', [1,500], 'inout'],
        'acc' =>[ 'integer',  'in'],
        }
    );  
}    
elsif ($TEST==4) {
# stencil-fold-map    
    $stref = mkAST(
        [
            
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['v',0,'']=>['v',0,'s']),
            mkFold('f1'=>[]=>[['acc',0,'']]=>[['v',0,'s']],[['acc',1,'']]),
            mkMap('f2'=>[['acc',1,'']]=>[['v',0,'s']],[['v',1,'']]),
        ],
        {
        'v' =>[ 'integer', [1,500], 'inout'],
        'acc' =>[ 'integer',  'in'],
        }
    );  
}  
elsif ($TEST==5) {
# stencil-map-fold-map    
    $stref = mkAST(
        [            
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['v',0,'']=>['v',0,'s']),
            mkMap('f1'=>[]=>[['v',0,'s']],[['v',1,'']]),
            mkFold('f2'=>[]=>[['acc',0,'']]=>[['v',1,'']],[['acc',1,'']]),
            mkMap('f3'=>[['acc',1,'']]=>[['v',1,'']],[['v',2,'']]),
        ],
        {
        'v' =>[ 'integer', [1,500], 'inout'],
        'acc' =>[ 'integer',  'in'],
        }
    );  
}  
elsif ($TEST==6) {
# stencil-fold-map-stencil-map-fold-map    
    $stref = mkAST(
        [            
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['v',0,'']=>['v',0,'s']),
            mkFold('f0'=>[['t1',0,''],['t2',0,'']]=>[['acc1',0,'']]=>[['v',0,'']]=>[['acc1',1,'']]),
            mkMap('f1'=>[['acc1',1,'']]=>[['v',0,'s']],[['v',1,'']]),
            # stencil
            mkStencilDef(2,[-1,0,1]),
            mkStencilAppl(2,3,['v',1,'']=>['v',1,'s']),
            # map
            mkMap('f4'=>[]=>[['v',1,'s']],[['v',2,'']]),
            mkFold('f2'=>[]=>[['acc3',0,'']]=>[['v',2,'']],[['acc3',1,'']]),
            mkMap('f3'=>[['acc3',1,'']]=>[['v',2,'']],[['v',3,'']]),
        ],
        {
        'v' =>[ 'integer', [1,500], 'inout'],
        't1' =>[ 'integer',  'in'],
        't2' =>[ 'integer',  'in'],
        'acc1' =>[ 'integer',  'in'],
        'acc3' =>[ 'integer',  'in'],
        }
    );  
} 
elsif ($TEST==7) {
 # map map map stencil map stencil map
    $stref = mkAST(
        [
            mkMap('f1a'=>[]=>[['va',0,''],['vc',0,'']]=>[['va',1,'']]),
            mkMap('f1b'=>[]=>[['vb',0,'']]=>[['vb',1,'']]),
            mkMap('f1c' =>[]=>[['va',1,''],['vb',1,'']]=>[['v',0,'']]),
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['v',0,'']=>['v',1,'s']),
            mkMap('f2'=>[]=>[['v',1,'s']]=>[['v',2,'']]),
            mkStencilDef(2,[-1,0,1]),
            mkStencilAppl(2,3,['v',2,'']=>['v',2,'s']),
            mkMap('f3'=>[]=>[['v',2,'s']]=>[['v',3,'']]),            
        ],
        {
            'va' =>[ 'real', [1,500], 'in'] ,
            'vc' =>[ 'real', [1,500], 'in'] ,
            'vb' =>[ 'real', [1,500], 'in'] ,
            'vab' =>[ 'real', [1,500], 'local'] ,
            'v' =>[ 'real', [1,500], 'out'] ,
            }
    );            
}
elsif ($TEST==8) {
    # stencil map map 
$stref = mkAST(
        [
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['etan',0,'']=>['etan',0,'s']),
            mkMap( "shapiro_map_16" => [] => [ ["wet",0,''],["etan",0,'s']] => [ ['eta',0,''] ]),
            mkMap ( "update_map_24" => [] => [ ["eta",0,''],["un",0,'']  ] => [ ["h",0,''],["u",0,''],["wet",1,'']] )
      ],
        {
            'wet' => ['int',[1,500], 'inout'] ,
            'etan' => ['real',[1,500], 'in'] ,
            'eta'=> ['real',[1,500], 'local'] ,
            'un'=> ['real',[1,500], 'in'] ,
            'u'=> ['real',[1,500], 'out'] ,
            'h'=> ['real',[1,500], 'out'] ,
        }
);
}
elsif ($TEST==9) {
    # iterative stencil-map 
$stref = mkAST(
        [
mkStencilDef(1,[-1,0,1]),
mkStencilAppl(1,3,['p','0',''],['p','1','s']),
mkMap('sor',[],[['p','1','s']],[['p','1','']]),
mkStencilAppl(1,3,['p','1',''],['p','2','s']),
mkMap('sor',[],[['p','2','s']],[['p','2','']]),
mkStencilAppl(1,3,['p','2',''],['p','3','s']),
mkMap('sor',[],[['p','3','s']],[['p','3','']]),
mkStencilAppl(1,3,['p','3',''],['p','4','s']),
mkMap('sor',[],[['p','4','s']],[['p','4','']]),
      ],
        {
            'p' => ['real',[1,500], 'inout'] ,
        }
);
}



    $stref = construct_TyTraCL_AST_Main_node($stref);

    $stref = _emit_TyTraCL_FunctionSigs($stref);    

    $stref = _add_VE_to_AST($stref);
    
    $stref = _emit_TyTraCL_Haskell_AST_Code($stref);

    # What this does is emitting the Haskell AST to a Haskell module file
    my $tytracl_hs_str = $stref->{'TyTraCL_Haskell_AST_Code'};

    write_out($tytracl_hs_str);

    # This makes sure that no fortran is emitted by emit_all()
    $stref->{'SourceContains'} = {};

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

    my @stencil_defs=();
    # [($f, [($orig_name, $tytracl_name)])]
    my @origNamesList=();

    my $tytracl_hs_ast_strs = [];
    for my $node (@{$tytracl_ast->{'Lines'}}) {

        if ($node->{'NodeType'} eq 'StencilDef') {
            my $lhs   = $node->{'Lhs'};
            my $rhs   = $node->{'Rhs'};
            my $ctr = $lhs->{'Ctr'};
            my $stencils_          = generate_TyTraCL_stencils($rhs->{'StencilPattern'});
            my $stencil_definition = '[' . join(',', @{$stencils_}) . ']';

            push @stencil_defs, [ "s$ctr", $stencil_definition];
            
        }
        elsif ($node->{'NodeType'} eq 'StencilAppl') {
            my $svec_rec = $node->{'Lhs'}{'Var'};
            my $svec_var = _mkVarName($svec_rec);

            my $svec_type = $tytracl_ast->{'Main'}{'VarTypes'}{$svec_var};
            $node->{'VecType'}= $svec_type->[2];
            my $line = mkStencilApplAST($node);
            push @{$tytracl_hs_ast_strs}, $line;
        }

        elsif ($node->{'NodeType'} eq 'Map') {
            my $fname = $node->{'FunctionName'};
            $node->{'NonMapType'}= $tytracl_ast->{'Main'}{'VarTypes'}{$fname}{'NonMapArgType'};
            $node->{'VecType'}= $tytracl_ast->{'Main'}{'VarTypes'}{$fname}{'MapArgType'};
            $node->{'ReturnType'}= $tytracl_ast->{'Main'}{'VarTypes'}{$fname}{'ReturnType'};
            my $line = mkMapAST($node);
            push @origNamesList, __origNamesListEntry($node);
            push @{$tytracl_hs_ast_strs}, $line;
        }
        elsif ($node->{'NodeType'} eq 'Fold') {
            my $fname = $node->{'FunctionName'};
            $node->{'NonFoldType'}= $tytracl_ast->{'Main'}{'VarTypes'}{$fname}{'NonFoldArgType'};
            $node->{'VecType'}= $tytracl_ast->{'Main'}{'VarTypes'}{$fname}{'FoldArgType'};
            $node->{'AccType'}= $tytracl_ast->{'Main'}{'VarTypes'}{$fname}{'AccArgType'};
            $node->{'ReturnType'}= $tytracl_ast->{'Main'}{'VarTypes'}{$fname}{'ReturnType'};# Which should of course be the same

            my $line = mkFoldAST($node);
            push @origNamesList, __origNamesListEntry($node);
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

    my @indented_tytracl_hs_ast_strs=();
    my $idx=0;
    for my $tytracl_hs_ast_str ( @{$tytracl_hs_ast_strs}) {
        my $indented_tytracl_hs_ast_str = $tytracl_hs_ast_str;
            if ($tytracl_hs_ast_str!~/^\s*\-\-/) {
                if ($idx>0) {                
                    $indented_tytracl_hs_ast_str=','.$indented_tytracl_hs_ast_str;
                }
                ++$idx;
            }
            $indented_tytracl_hs_ast_str='        '.$indented_tytracl_hs_ast_str;            
            push @indented_tytracl_hs_ast_strs, $indented_tytracl_hs_ast_str;
            
    }

    my $tytracl_hs_ast_code_str=join("\n", @indented_tytracl_hs_ast_strs);


    my $header =
'module ASTInstance ( ast
        , functionSignaturesList
        , stencilDefinitionsList
        , mainArgDeclsList 
        , scalarisedArgsList
        , origNamesList
        ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
    ';

    $tytracl_hs_ast_code_str=$header.$tytracl_hs_ast_code_str."\n        ]\n";

    my $fsigs_str = _create_TyTraCL_Haskell_signatures($stref);
    my $stencil_defs_str = _create_TyTraCL_Haskell_stencilDefs(\@stencil_defs);
    my $main_arg_decls_str = _create_TyTraCL_Haskell_MainArgDecls($stref,$tytracl_ast->{'MainFunction'});

    $tytracl_hs_ast_code_str.= "\n".$fsigs_str;
    $tytracl_hs_ast_code_str.= "\n".$stencil_defs_str;
    $tytracl_hs_ast_code_str.= "\n".$main_arg_decls_str;

if (exists $stref->{'ScalarisedArgs'} and defined $stref->{'ScalarisedArgs'}) {
    my $scalarised_args_lst_str = _create_TyTraCL_Haskell_scalarisedArgsList($stref);
    my $orig_names_lst_str = _create_TyTraCL_Haskell_origNamesList(\@origNamesList);

    $tytracl_hs_ast_code_str.= "\n".$scalarised_args_lst_str;
    $tytracl_hs_ast_code_str.= "\n".$orig_names_lst_str;
}
    $stref->{'TyTraCL_Haskell_AST_Code'} = $tytracl_hs_ast_code_str ;

    return $stref;
}    # END of _emit_TyTraCL_Haskell_AST_Code

#========================================================================================================================

sub _add_VE_to_AST {
    (my $stref) = @_;

    my $tytracl_ast  = $stref->{'TyTraCL_AST'};


    for my $node (@{$tytracl_ast->{'Lines'}}) {

        if ($node->{'NodeType'} eq 'StencilDef') {
            # do nothing
        }
        elsif ($node->{'NodeType'} eq 'StencilAppl') {

            push @{$node->{'Lhs'}{'Var'}}, 'VS'; # because this is a var name rec []
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

            $node->{'Rhs'}{'NonMapArgs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Rhs'}{'NonMapArgs'}{'Vars'} }
            ];            
        }
        elsif ($node->{'NodeType'} eq 'Fold') {

            $node->{'Lhs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    # warn( "FOLD LHS VE: $ve\n");
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Lhs'}{'Vars'} }
            ];

            $node->{'Rhs'}{'FoldArgs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    # warn( "FOLD VE: $ve\n");
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Rhs'}{'FoldArgs'}{'Vars'} }
            ];
            $node->{'Rhs'}{'NonFoldArgs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    # warn( "NON-FOLD VE: $ve\n");
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Rhs'}{'NonFoldArgs'}{'Vars'} }
            ];            

        $node->{'Rhs'}{'AccArgs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    # warn( "FOLD ACC VE: $ve\n");
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Rhs'}{'AccArgs'}{'Vars'} }
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

sub _add_DType_to_AST {
    (my $stref) = @_;

    my $tytracl_ast  = $stref->{'TyTraCL_AST'};


    for my $node (@{$tytracl_ast->{'Lines'}}) {

        if ($node->{'NodeType'} eq 'StencilDef') {
            # do nothing
        }
        elsif ($node->{'NodeType'} eq 'StencilAppl') {

            push @{$node->{'Lhs'}{'Var'}}, 'VS'; # because this is a var name rec []
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

            $node->{'Rhs'}{'NonMapArgs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Rhs'}{'NonMapArgs'}{'Vars'} }
            ];            
        }
        elsif ($node->{'NodeType'} eq 'Fold') {

            $node->{'Lhs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    # warn( "FOLD LHS VE: $ve\n");
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Lhs'}{'Vars'} }
            ];

            $node->{'Rhs'}{'FoldArgs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    # warn( "FOLD VE: $ve\n");
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Rhs'}{'FoldArgs'}{'Vars'} }
            ];
            $node->{'Rhs'}{'NonFoldArgs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    # warn( "NON-FOLD VE: $ve\n");
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Rhs'}{'NonFoldArgs'}{'Vars'} }
            ];            

        $node->{'Rhs'}{'AccArgs'}{'Vars'}=[
                map {
                    my $var_rec=$_;
                    my $ve = __determine_VE($stref, $var_rec);
                    # warn( "FOLD ACC VE: $ve\n");
                    push @{$var_rec},$ve;
                    $var_rec;
                } @{ $node->{'Rhs'}{'AccArgs'}{'Vars'} }
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
} # END of _add_DType_to_AST()

#========================================================================================================================

# I  emit the Haskell AST, then the work is done in Haskell.
# I could then re-emit the Perl AST and go from there to Fortran, or emit Fortran straight from Haskell

sub mkStencilApplAST {
    (my $stencilApplNode) = @_;

    # $stencilApplNode = {
    #     'Lhs' => {'Var' => ['etan',0,'s']},
    #     'NodeType' => 'StencilAppl',
    #     'FunctionName' => 'shapiro_map_23',
    #     'Rhs' => {'StencilCtr' => 2,'Var' => ['etan',0,'']}};
    my $vec_type = $stencilApplNode->{'VecType'};
    my $s_var    = _mkVarName($stencilApplNode->{'Lhs'}{'Var'});
    my $var      = _mkVarName($stencilApplNode->{'Rhs'}{'Var'});
    my $ve       = $stencilApplNode->{'Rhs'}{'Var'}[3];
    my $s        = 's' . $stencilApplNode->{'Rhs'}{'StencilCtr'};
    my $s_sz     = $stencilApplNode->{'Rhs'}{'StencilSz'};
    my $ast_line = '(Vec VS (SVec '.$s_sz.' (Scalar VDC D'.$vec_type.' "' . $s_var . '" )) ,'
    . ' Stencil (SVec ' . $s_sz . ' (Scalar VDC DInt "' . $s . '")) '
    . '(Vec ' . $ve . ' (Scalar VDC D' .$vec_type. ' "' . $var . '")))';

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
    my $non_map_type = $mapNode->{'NonMapType'};
    my $vec_type = $mapNode->{'VecType'}; # This is a list as it could be a tuple; can be SVecs as well
    my $ret_type = $mapNode->{'ReturnType'};
# I need to determine if a vector is VO, VI, VS or VS
# VS is for stencil
# I should know the inputs and outputs
# anything else is VT
    my $lhs_vars_types = zip( $mapNode->{'Lhs'}{'Vars'}, $ret_type );
    
# more than one
    my $lhs = scalar @{$mapNode->{'Lhs'}{'Vars'}} > 1
      ? '(Tuple [' . join(',', map { __mkVec($_) } @{$lhs_vars_types}) . '])'
# otherwise
      : __mkVec($lhs_vars_types->[0]);

    my $non_map_vars_types = zip( $mapNode->{'Rhs'}{'NonMapArgs'}{'Vars'}, $non_map_type);

    my $map_vars_types=zip($mapNode->{'Rhs'}{'MapArgs'}{'Vars'}, $vec_type);
    my $map_args =
      scalar @{$mapNode->{'Rhs'}{'MapArgs'}{'Vars'}} > 1
      ? '(ZipT [' . join(',', map { __mkVec($_) } @{$map_vars_types}) . '])'
      : '(' . __mkVec($map_vars_types->[0]) . ')';
    my $f_exp = $mapNode->{'Rhs'}{'Function'};
    my $non_map_arg_str='[]';
    if (exists $mapNode->{'Rhs'}{'NonMapArgs'}
        and scalar @{$mapNode->{'Rhs'}{'NonMapArgs'}{'Vars'}} > 0)
    {
# FIXME: I guess a single arg should not be a tuple ...
        $non_map_arg_str = ' [' . join(',', map { __mkScalar($_) } @{$non_map_vars_types}) . ']';        
        # $non_map_arg_str = ' [' . join(',', map { '"'._mkVarName($_).'"' } @{$mapNode->{'Rhs'}{'NonMapArgs'}{'Vars'}}) . ']';
    }
    my $rhs_core = 'Map (Function "' . $f_exp . '" '.$non_map_arg_str. ') ' . $map_args ;


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
    my $acc_type = $foldNode->{'AccType'}; # This is a list as it could be a tuple
    my $non_fold_type = $foldNode->{'NonFoldType'};
    my $vec_type = $foldNode->{'VecType'}; # This is a list as it could be a tuple
    my $ret_type = $foldNode->{'ReturnType'}; # This is a list as it could be a tuple
    my $lhs_vars_types = zip($foldNode->{'Lhs'}{'Vars'},$ret_type);
# more than one
    my $lhs =
     scalar @{$foldNode->{'Lhs'}{'Vars'}} > 1
      ? '(Tuple [' . join(',', map { __mkScalar($_) } @{$lhs_vars_types}) . '])'
# otherwise
    : __mkScalar($lhs_vars_types->[0]);    
# # more than one
#     my $lhs =
#      scalar @{$foldNode->{'Lhs'}{'Vars'}} > 1
#       ? '(Tuple [' . join(',', map { __mkScalar($_) } @{$foldNode->{'Lhs'}{'Vars'}}) . '])'
# # otherwise
#     : __mkScalar($foldNode->{'Lhs'}{'Vars'}[0]);

    my $non_fold_vars_types = zip( $foldNode->{'Rhs'}{'NonFoldArgs'}{'Vars'}, $non_fold_type);
    my $fold_vars_types = zip($foldNode->{'Rhs'}{'FoldArgs'}{'Vars'},$vec_type);
    my $fold_args =
      scalar @{$foldNode->{'Rhs'}{'FoldArgs'}{'Vars'}} > 1
      ? '(ZipT [' . join(',', map { __mkVec($_) } @{$fold_vars_types}) . '])'
      : '(' . __mkVec($fold_vars_types->[0]) . ')';

    my $acc_vars_types = zip($foldNode->{'Rhs'}{'AccArgs'}{'Vars'}, $acc_type);
    my $acc_args =   scalar @{$foldNode->{'Rhs'}{'AccArgs'}{'Vars'}} > 1
      ? '(' . join(',', map { __mkScalar($_) } @{$acc_vars_types}) . ')'
      : '(' . __mkScalar($acc_vars_types->[0]) . ')';

    my $f_exp = $foldNode->{'Rhs'}{'Function'};
    my $non_fold_arg_str = '[]';
    if (exists $foldNode->{'Rhs'}{'NonFoldArgs'}
        and scalar @{$foldNode->{'Rhs'}{'NonFoldArgs'}{'Vars'}} > 0)
    {
# FIXME: I guess a single arg should not be a tuple ...

        $non_fold_arg_str = ' [' . join(',', map { __mkScalar($_) } @{$non_fold_vars_types}) . ']';
        # $non_fold_arg_str = ' [' . join(',', map { '"'. _mkVarName($_).'"' } @{$foldNode->{'Rhs'}{'NonFoldArgs'}{'Vars'}}) . ']';
        # $f_exp .= $non_fold_arg_str;
    }
    my $rhs = 'Fold (Function "' . $f_exp . '" '. $non_fold_arg_str.      ') ' . $acc_args.' '.$fold_args ;

    my $ast_line = "( $lhs, $rhs )";

    return $ast_line;
}

# In principle the SVec type can contain another SVec but not while generating the code
# sub __mkType { (my $t_rec)=@_;
#     if ($t_rec->[0] ne 'SVec') {
#         return 'D'.$t_rec->[0];
#     } else {
#         return '(DSVec '.$t_rec->[1]. ' D'.$t_rec->[2].')';
#     }
# }

# (Vec VI (Tuple [Scalar Float "eta_0", Scalar DInt "wet_0"] ) )
# (Vec VI (Scalar Float "eta_0") )
# (Vec VS (SVec 5 (Scalar DFloat "eta_s_0") ) )
# ['SVec',3,'DFloat']
sub __mkType { (my $t_rec, my $v_name)=@_;
    if ($t_rec->[0] ne 'SVec') {
        return 'Scalar VDC D'.$t_rec->[0].' "'.$v_name.'"';
    } else {
        return 'SVec '.$t_rec->[1]. '(Scalar VDC D'.$t_rec->[2].' "'.$v_name.'")';
    }
}

sub __mkVec {
    my ($var_type_rec) = @_;
    my ($v_rec, $t_rec) = @{$var_type_rec};
    # t_rec is either [Int] or [SVec,3,Int]
    my $v_name  = _mkVarName($v_rec);
    my $ve      = $v_rec->[3];
    return 'Vec ' . $ve . ' ('.__mkType($t_rec, $v_name).')'; #.' "' . $v_name . '"';
}

sub __mkUntypedVec {
    my ($v_rec) = @_;
    
    # t_rec is either [Int] or [SVec,3,Int]
    my $v_name  = _mkVarName($v_rec);
    my $ve      = $v_rec->[3];
    return 'Vec ' . $ve . ' DDC "' . $v_name . '"';
}
sub __mkScalar {
    my ($var_type_rec) = @_;

    my ($v_rec, $t_rec) = @{$var_type_rec};

    my $v_name  = _mkVarName($v_rec);
    my $ve      = $v_rec->[3];    
    if (scalar @{$t_rec} == 1) {
        return __mkType($t_rec,$v_name);#.'  "' . $v_name . '"';
    } else {
    return 'Scalar '.$ve.' '.__mkType($t_rec,$v_name);#.'  "' . $v_name . '"';
    }
}

sub __mkUntypedScalar {
    my ($v_rec) = @_;
    my $v_name  = _mkVarName($v_rec);
    my $ve      = $v_rec->[3];    
    return 'Scalar '.$ve.' DDC  "' . $v_name . '"';
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
=pod sigs_and_types
What we need is a mechanism to create signatures for the intermediate functions
In principle, having the types for all vars and functions should be enough
In practice, I'd like to get the names right. 


# How to derive the signatures?

        (Function "f_comp_acc3_1_1" [],Comp (Function "f4" []) (Function "f_maps_acc3_1_0" []))

        If I look up "f4" I get

    
 [ 'f4', [], [ [ 'SVec', 3, 'Int' ] ], [ [ 'Int' ] ] ],
$stref->{'TyTraCL_FunctionSigs'}{'f4'} =

 [ '', 'v_s', 'v' ]

So I think I should have a Map fromList

("f4", MapFSig [[],[SVec 3 (Scalar Int "v_s")],[Scalar Int "v"]])

    [ 'f3', [ [ 'Int' ] ], [ [ 'Int' ] ], [ [ 'Int' ] ] ],
    [ ['acc3'], ['v'], ['v'] ],

    [ 'f0', [], [ [ 'Int' ] ], [ [ 'Int' ] ], [ [ 'Int' ] ] ],
    [ [], ['acc1'], ['v'], ['acc1'] ],

     [ 'f1', [ [ 'Int' ] ], [ [ 'SVec', 3, 'Int' ] ], [ [ 'Int' ] ] ],
    [ 'acc1', 'v_s', 'v' ],
=cut
sub _create_TyTraCL_Haskell_signatures { (my $stref) = @_;
    my $sig_lines=[];
    $Data::Dumper::Deepcopy=1;
    # croak Dumper keys %{$stref->{'TyTraCL_AST'}{'Main'}{'VarTypes'}};
    # croak Dumper($stref->{'TyTraCL_FunctionSigs'});

    my $map_list_entries=[];
    for my $f (sort keys %{$stref->{'TyTraCL_FunctionSigs'}}) {
        my $FSig_ctor =  exists $stref->{'TyTraCL_AST'}{'Main'}{'VarTypes'}{$f}{'FoldArgType'} ? 'FoldFSig'
        : exists $stref->{'TyTraCL_AST'}{'Main'}{'VarTypes'}{$f}{'MapArgType'} ? 'MapFSig' : croak "NOT Map or Fold : $f";
        
        my $ftypedecl = $stref->{'TyTraCL_AST'}{'Main'}{'VarTypes'}{$f}{'FunctionTypeDecl'} ;
        my $fsig =$stref->{'TyTraCL_FunctionSigs'}{$f};
        
        my $fname = $ftypedecl->[0] ;
        croak unless $fname eq $f;
        # For every argument tuple, i.e. Non-{Map,Fold} [,Acc], {Map,Fold}, Out
        my $typed_arg_tups=[];
        for my $idx (1 .. scalar @{$ftypedecl} - 1) {
            my $typetup = $ftypedecl->[$idx] ;#[ [], [ [ 'Int' ] ], [ [ 'Int' ] ], [ [ 'Int' ] ] ],
            my $argtup = $fsig->[$idx-1]; # [ [], ['v_s'],[ 'v'] ]
            my $typed_arg_tup=[];
            if (scalar @{$typetup}) {
                for my $type (@{$typetup}) {
                    my $arg = shift @{$argtup};
                    if ($type->[0] ne 'SVec') { # It's a scalar 
                        push @{$typed_arg_tup}, 'Scalar VDC D'.$type->[0].' "'.$arg.'"';
                    } else {
                        push @{$typed_arg_tup}, 'SVec '.$type->[1].' (Scalar VDC D'.$type->[2].' "'.$arg.'")';
                    }                    
                }
            } 
            push @{$typed_arg_tups}, $typed_arg_tup;
        }                    
        my $map_list_entry = [$fname, [$FSig_ctor, $typed_arg_tups]];
        push @{$map_list_entries}, $map_list_entry;
    }

    my @map_list_strs = map {__pp_MapListEntry($_)} @{$map_list_entries};

    return 'functionSignaturesList = ['."\n        ".join(",\n        ",@map_list_strs)."\n    ".']';
} # END of _create_TyTraCL_Haskell_signatures


sub __pp_MapListEntry { (my $map_list_entry) = @_;
    my ($fname, $fsig) = @{$map_list_entry};
    my ($FSig_ctor, $typed_arg_tups) = @{$fsig};
    my $map_list_entry_str = 
    '("'.$fname.'", '
     . ' [' . join(',', map {
        #  warn( Dumper $_); 
         my $t = scalar @{$_} == 0 
         ? 'Tuple []'
         : scalar @{$_} > 1 ?
         'Tuple ['.join(',',@{$_}).']' 
         : $_->[0];
         $t;
         } @{$typed_arg_tups})
     . '])';
    return $map_list_entry_str;
}

sub _create_TyTraCL_Haskell_stencilDefs { (my $stencil_defs)=@_;
return 
    'stencilDefinitionsList = ['.
    join(', ', map { 
        '("'.$_->[0].'" , '.  $_->[1] .' )' 
        } @{$stencil_defs}
    )
    .']';

} # END _create_TyTraCL_Haskell_stencilDefs


sub _create_TyTraCL_Haskell_MainArgDecls { (my $stref, my $f) = @_;
        
    my $arg_decl_str_pairs=[];
for my $in_arg_name (keys %{$stref->{'TyTraCL_AST'}{'Main'}{'InArgsTypes'}}) {
    my $tytracl_var_rec =  $stref->{'TyTraCL_AST'}{'Main'}{'InArgsTypes'}{$in_arg_name};
    my $in_arg_decl = __toFortranDecl($in_arg_name,$tytracl_var_rec,'in');
    push @{$arg_decl_str_pairs}, [$in_arg_name,$in_arg_decl];
}
for my $out_arg_name (keys %{$stref->{'TyTraCL_AST'}{'Main'}{'OutArgsTypes'}}) {
    my $tytracl_var_rec =  $stref->{'TyTraCL_AST'}{'Main'}{'OutArgsTypes'}{$out_arg_name};
    my $out_arg_decl = __toFortranDecl($out_arg_name,$tytracl_var_rec,'out');
    push @{$arg_decl_str_pairs}, [$out_arg_name,$out_arg_decl];
}


    return "\n".
        'mainArgDeclsList = ['."\n".'      '.
        join ("\n".'    , ', map {
            '("'.$_->[0].'" , "'.  $_->[1] .'" )' 
            } @{$arg_decl_str_pairs}
        )
        ."\n".'  ]';
} # END of _create_TyTraCL_Haskell_MainArgDecls

sub __toFortranDecl {(my $arg_name, my $tytracl_var_rec, my $intent) =@_;

    my %fortran_type = (
    'Float' => 'real',
    'Int' => 'integer'
    );

    my $vt  = shift @{$tytracl_var_rec };
    if ($vt eq 'Vec') {
        my $dim = shift @{$tytracl_var_rec };
        my $vt = shift @{$tytracl_var_rec};
        return $fortran_type{$vt}.', dimension(1:'.$dim.'), intent('.$intent.') :: '. $arg_name;
    } else {
        return $fortran_type{$vt}.', intent('.$intent.') :: '. $arg_name;
    }

} # END of __toFortranDecl

=pod
I put this info in `$stref->{'ScalarisedArgs'}`. Now, how to use it? We need the link between the TyTraCL names and the original names, 
and from there to the scalarised names. Using Name and StencilIndex from the var rec. 

So I think I need a table 

            origNamesList = [($f, [($orig_name, $tytracl_name)])]
            $f => { $orig_name => $tytracl_name}

and a list $f => [($orig_name, $stencil_index)] with the order for the scalarised sig.

            scalarisedArgsList = [($f , [($orig_name, $stencil_index)])]

Then for every f we map (orig_name, stencil_index) -> ((origNames ! f) ! orig_name)++(if stencil_index==0 then "" else "("++(show stencil_index++")")))
=cut

sub _create_TyTraCL_Haskell_scalarisedArgsList { (my $stref)=@_;

    my $sig_mappings={};
    my @origNamesList = ();
    my @scalarisedArgsList = ();

    for my $f (sort keys %{ $stref->{'ScalarisedArgs'} }) {
        my @arg_idx_lst=();
        for my $arg (@{ $stref->{'ScalarisedArgs'}{$f}{'List'} }) {
            my $var_rec = $stref->{'ScalarisedArgs'}{$f}{'Set'}{$arg};
            my $orig_name = $var_rec->{'Name'};
            my $stencil_index = exists $var_rec->{'StencilIndex'} ?  $var_rec->{'StencilIndex'} : 0;
            push @arg_idx_lst, [$orig_name,$stencil_index];            
        }
            push @scalarisedArgsList,[$f,\@arg_idx_lst]
    }
    return "\nscalarisedArgsList = [\n     ".
     join("\n".'    ,',map { 
                (my $f, my $lst) = @{$_}; 
                my $lst_str = join(', ', map {
                        (my $on, my $idx) = @{$_}; 
                        '("'.$on.'",'.$idx.')'
                    } @{$lst}
                );
                '( "'.$f.'",['.$lst_str.'])'
        } @scalarisedArgsList
    )
    ."\n  ]";       
} # END of _create_TyTraCL_Haskell_scalarisedArgsList

sub _create_TyTraCL_Haskell_origNamesList { (my $orig_names_list)=@_;
    return "\norigNamesList = [\n     ".
     join("\n".'    ,',map { 
                (my $f, my $lst) = @{$_}; 
                my $lst_str = join(', ', map {
                        (my $on, my $nn) = @{$_}; 
                        '("'.$on.'","'.$nn.'")'
                    } @{$lst}
                );
                '( "'.$f.'",['.$lst_str.'])'
        } @{$orig_names_list}
    )
    ."\n  ]";    
}# END of _create_TyTraCL_Haskell_origNamesList

sub __origNamesListEntry { my ($node) = @_;
    my $arg_name_pairs = [];
    my $fname = $node->{'FunctionName'};

        if ($node->{'NodeType'} eq 'Map') {
            for my $arg_rec (
                @{$node->{'Rhs'}{'NonMapArgs'}{'Vars'}},
                @{$node->{'Rhs'}{'MapArgs'}{'Vars'}},
                @{$node->{'Lhs'}{'Vars'}}
            ) {
                push @{$arg_name_pairs},[$arg_rec->[0],_mkVarName($arg_rec)];
            }
        }
        elsif ($node->{'NodeType'} eq 'Fold') {
            for my $arg_rec (
                @{$node->{'Lhs'}{'Vars'}}
               ,@{$node->{'Rhs'}{'FoldArgs'}{'Vars'}}
               ,@{$node->{'Rhs'}{'NonFoldArgs'}{'Vars'}}
            ,@{$node->{'Rhs'}{'AccArgs'}{'Vars'}}
            ) {
                push @{$arg_name_pairs},[$arg_rec->[0],_mkVarName($arg_rec)];
            }
        }
        
    return [$fname,$arg_name_pairs];
        
} # END of __origNamesListEntry


1;

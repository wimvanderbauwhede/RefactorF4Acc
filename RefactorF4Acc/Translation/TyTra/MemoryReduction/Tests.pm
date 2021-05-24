package RefactorF4Acc::Translation::TyTra::MemoryReduction::Tests;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::State qw( init_state );
use RefactorF4Acc::Translation::TyTra::Common qw( 
    mkMap
    mkFold
    mkStencilDef
    mkStencilAppl
    mkAST
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

@RefactorF4Acc::Translation::TyTra::MemoryReduction::Tests::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTra::MemoryReduction::Tests::EXPORT_OK = qw(
  &memory_reduction_tests
);


sub memory_reduction_tests {
    (my $stref) = @_;
    
    my $TEST =   $Config{'TEST'} ;
    my $comment = "TEST $TEST" ;
    
    $stref = init_state('main');

    # WV: I think Selects and Inserts should be in Lines but I'm not sure
    $stref->{'EmitAST'}     = 'TyTraCL_AST';
    $stref->{'TyTraCL_AST'} = {
        'Comment'      => $comment,
        'Lines'        => [],
        'Selects'      => [],
        'Inserts'      => [],
        'Stencils'     => {},
        'Portions'     => {},
        'Main'         => {},
        'MainFunction' => 'main',
        'ASTEmitter'   => \&_add_TyTraCL_AST_entry
    };

if ($TEST==1) { 
 # 3 maps with 2 stencils in between.
 # Expected result is a single map with a merged stencil.
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
        ,$comment
    );            
}
elsif ($TEST==2) {      
# two maps, one stencil, but two input vectors    
# To test if multiple input vectors (i.e. ZipT) works as expected.  
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
        ,$comment
    );  
}
elsif ($TEST==3) {
# fold-stencil-map    
# To test if the fold result is used correctly.
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
        ,$comment
    );  
}    
elsif ($TEST==4) {
# stencil-fold-map    
# Test for fold of a stencil, then see if acc is used as expected
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
        ,$comment
    );  
}  
elsif ($TEST==5) {
# stencil-map-fold-map    
# Test to check if this becomes two stages
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
        ,$comment
    );  
}  
elsif ($TEST==6) {
# stencil-fold-map-stencil-map-fold-map    
# Test to check if this becomes two stages
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
        ,$comment
    );  
} 
elsif ($TEST==7) {
 # map map map stencil map stencil map
 # Test to check if this becomes a single stage
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
        ,$comment
    );            
}
elsif ($TEST==8) {
# stencil map map 
# This test is for the output tuple and the input of a stencil and ordinary vector
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
        ,$comment
);
}
elsif ($TEST==9) {
# iterative stencil-map 
# Mimics a few steps of a SOR
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
        ,$comment
);
}
elsif ($TEST==10) {
    # like TEST 8 but no zip on the stencil
    # stencil map map 
    # So only tests the output tuple
$stref = mkAST(
        [
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['etan',0,'']=>['etan',0,'s']),
            mkMap( "shapiro_map_16" => [] => [ ["etan",0,'s']] => [ ['eta',0,''] ]),
            mkMap ( "update_map_24" => [] => [ ["wet",0,''],["eta",0,''],["un",0,'']  ] => [ ["h",0,''],["u",0,''],["wet",1,'']] )
      ],
        {
            'wet' => ['int',[1,500], 'inout'] ,
            'etan' => ['real',[1,500], 'in'] ,
            'eta'=> ['real',[1,500], 'local'] ,
            'un'=> ['real',[1,500], 'in'] ,
            'u'=> ['real',[1,500], 'out'] ,
            'h'=> ['real',[1,500], 'out'] ,
        }
        ,$comment
);
}
elsif ($TEST==11) {
    # like TEST 10 but no tuple outputs
    # stencil map map 
$stref = mkAST(
        [
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['etan',0,'']=>['etan',0,'s']),
            mkMap( "shapiro_map_16" => [] => [ ["etan",0,'s']] => [ ['eta',0,''] ]),
            mkMap ( "update_map_24" => [] => [ ["wet",0,''],["eta",0,''],["un",0,'']  ] => [ ["u",0,''],["wet",1,'']] )
      ],
      #["h",0,''],
        {
            'wet' => ['int',[1,500], 'inout'] ,
            'etan' => ['real',[1,500], 'in'] ,
            'eta'=> ['real',[1,500], 'local'] ,
            'un'=> ['real',[1,500], 'in'] ,
            'u'=> ['real',[1,500], 'out'] ,
            # 'h'=> ['real',[1,500], 'out'] ,
        }
        ,$comment
);
}
elsif ($TEST==12) {
# stencil map map 
# This test is for the input of a stencil and ordinary vector
$stref = mkAST(
        [
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['etan',0,'']=>['etan',0,'s']),
            mkMap( "shapiro_map_16" => [] => [ ["wet",0,''],["etan",0,'s']] => [ ['eta',0,''] ]),
            mkMap ( "update_map_24" => [] => [ ["eta",0,''],["un",0,'']  ] => [ ["u",0,'']] )
      ],
        {
            'wet' => ['int',[1,500], 'in'] ,
            'etan' => ['real',[1,500], 'in'] ,
            'eta'=> ['real',[1,500], 'local'] ,
            'un'=> ['real',[1,500], 'in'] ,
            'u'=> ['real',[1,500], 'out'] ,
        }
        ,$comment
);
}
elsif ($TEST==13) { 

# A single map 
# This test is used to generate the example code in the paper.
$stref = mkAST(
        [
            mkMap( "f" => [] => [ ["in",0,''] ] => [ ['out',0,''] ]),
      ],
        {
            'in' => ['real',[1,500], 'in'] ,
            'out'=> ['real',[1,500], 'out'] ,
        }
        ,$comment
);
}
elsif ($TEST==14) { 
# A single fold   
# This test is used to generate the example code in the paper.
    $stref = mkAST(
        [
            mkFold('f1'=>[]=>[['acc_in',0,'']]=>[['v',0,'']],[['acc_out',0,'']]),
        ],
        {
        'v' =>[ 'integer', [1,500], 'in'],
        'acc_in' =>[ 'integer',  'in'],
        'acc_out' =>[ 'integer',  'out'],
        }
        ,$comment
    );  
}  

elsif ($TEST==15) { # HANGS on Substitute vectors (recursive)
# fold-map    
# 
    $stref = mkAST(
        [
            mkFold('f1'=>[]=>[['acc',0,'']]=>[['v',0,'']],[['acc1',0,'']]),
            mkMap('f2'=>[['acc1',0,'']]=>[['v',0,'']],[['v',1,'']]),
        ],
        {
        'v' =>[ 'integer', [1,500], 'inout'],
        'acc' =>[ 'integer',  'in'],
        'acc1' =>[ 'integer',  'local'],
        }
        ,$comment
    );  
}   

elsif ($TEST==16) { 

# A single map 
# This test is used to generate the example code in the paper.
$stref = mkAST(
        [
            mkMap( "f" => [["s_nm",0,''],["v_nm",0,'']] => [ ["v_in",0,''] ] => [ ['v_out',0,''] ]),
      ],
        {
            'v_in' => ['real',[1,500], 'in'] ,
            'v_nm' => ['real',[1,10], 'in'] ,
            's_nm' => ['integer', 'in'] ,
            'v_out'=> ['real',[1,500], 'out'] ,
        }
        ,$comment
);
}

    return $stref;
}    # END of memory_reduction_tests()

1;

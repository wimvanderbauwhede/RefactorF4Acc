module ASTInstance ( ast
        , functionSignaturesList
        , stencilDefinitionsList
        , mainArgDeclsList 
        , scalarisedArgsList
        , origNamesList
        ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
             -- shapiro_map_16
        (Vec VS (SVec 5 (Scalar VDC DFloat "eta_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "eta_0")))
        ,(Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DInt "wet_0")))
        ,( Vec VT (Scalar VDC DFloat "eta_1"), Map (Function "shapiro_map_16"  [Scalar VDC DFloat "eps_0"]) (ZipT [Vec VS (SVec 5(Scalar VDC DInt "wet_s_0")),Vec VS (SVec 5(Scalar VDC DFloat "eta_s_0"))]) )
         -- dyn_map_39
        ,(Vec VS (SVec 3 (Scalar VDC DFloat "eta_s_1" )) , Stencil (SVec 3 (Scalar VDC DInt "s3")) (Vec VT (Scalar VDC DFloat "eta_1")))
        ,( (Tuple [Vec VO (Scalar VDC DFloat "du_1"),Vec VO (Scalar VDC DFloat "dv_1")]), UnzipT ( Map (Function "dyn_map_39"  [Scalar VDC DFloat "dt_0",Scalar VDC DFloat "g_0",Scalar VDC DFloat "dx_0",Scalar VDC DFloat "dy_0"]) (Vec VS (SVec 3(Scalar VDC DFloat "eta_s_1"))) ) )
         -- dyn_map_45
        ,(Vec VS (SVec 3 (Scalar VDC DInt "wet_s_1" )) , Stencil (SVec 3 (Scalar VDC DInt "s4")) (Vec VI (Scalar VDC DInt "wet_0")))
        ,( (Tuple [Vec VT (Scalar VDC DFloat "un_1"),Vec VT (Scalar VDC DFloat "vn_1")]), UnzipT ( Map (Function "dyn_map_45" []) (ZipT [Vec VI (Scalar VDC DFloat "u_0"),Vec VO (Scalar VDC DFloat "du_1"),Vec VS (SVec 3(Scalar VDC DInt "wet_s_1")),Vec VI (Scalar VDC DFloat "v_0"),Vec VO (Scalar VDC DFloat "dv_1")]) ) )
         -- dyn_map_65
        ,(Vec VS (SVec 5 (Scalar VDC DFloat "h_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s5")) (Vec VI (Scalar VDC DFloat "h_0")))
        ,(Vec VS (SVec 2 (Scalar VDC DFloat "vn_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s6")) (Vec VT (Scalar VDC DFloat "vn_1")))
        ,(Vec VS (SVec 2 (Scalar VDC DFloat "un_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s7")) (Vec VT (Scalar VDC DFloat "un_1")))
        ,( Vec VT (Scalar VDC DFloat "eta_2"), Map (Function "dyn_map_65"  [Scalar VDC DFloat "dt_0",Scalar VDC DFloat "dx_0",Scalar VDC DFloat "dy_0"]) (ZipT [Vec VS (SVec 2(Scalar VDC DFloat "un_s_0")),Vec VS (SVec 5(Scalar VDC DFloat "h_s_0")),Vec VS (SVec 2(Scalar VDC DFloat "vn_s_0")),Vec VT (Scalar VDC DFloat "eta_1")]) )
         -- update_map_24
        ,( (Tuple [Vec VO (Scalar VDC DFloat "h_1"),Vec VO (Scalar VDC DFloat "u_1"),Vec VO (Scalar VDC DFloat "v_1"),Vec VO (Scalar VDC DInt "wet_1")]), UnzipT ( Map (Function "update_map_24"  [Scalar VDC DFloat "hmin_0"]) (ZipT [Vec VI (Scalar VDC DFloat "hzero_0"),Vec VT (Scalar VDC DFloat "eta_2"),Vec VT (Scalar VDC DFloat "un_1"),Vec VT (Scalar VDC DFloat "vn_1")]) ) )
        ]

functionSignaturesList = [
        ("dyn_map_39",  [Tuple [Scalar VDC DFloat "dt_0",Scalar VDC DFloat "g_0",Scalar VDC DFloat "dx_0",Scalar VDC DFloat "dy_0"],SVec 3 (Scalar VDC DFloat "eta_s_1"),Tuple [Scalar VDC DFloat "du_1",Scalar VDC DFloat "dv_1"]]),
        ("dyn_map_45",  [Tuple [],Tuple [Scalar VDC DFloat "u_0",Scalar VDC DFloat "du_1",SVec 3 (Scalar VDC DInt "wet_s_1"),Scalar VDC DFloat "v_0",Scalar VDC DFloat "dv_1"],Tuple [Scalar VDC DFloat "un_1",Scalar VDC DFloat "vn_1"]]),
        ("dyn_map_65",  [Tuple [Scalar VDC DFloat "dt_0",Scalar VDC DFloat "dx_0",Scalar VDC DFloat "dy_0"],Tuple [SVec 2 (Scalar VDC DFloat "un_s_0"),SVec 5 (Scalar VDC DFloat "h_s_0"),SVec 2 (Scalar VDC DFloat "vn_s_0"),Scalar VDC DFloat "eta_1"],Scalar VDC DFloat "eta_2"]),
        ("shapiro_map_16",  [Scalar VDC DFloat "eps_0",Tuple [SVec 5 (Scalar VDC DInt "wet_s_0"),SVec 5 (Scalar VDC DFloat "eta_s_0")],Scalar VDC DFloat "eta_1"]),
        ("update_map_24",  [Scalar VDC DFloat "hmin_0",Tuple [Scalar VDC DFloat "hzero_0",Scalar VDC DFloat "eta_2",Scalar VDC DFloat "un_1",Scalar VDC DFloat "vn_1"],Tuple [Scalar VDC DFloat "h_1",Scalar VDC DFloat "u_1",Scalar VDC DFloat "v_1",Scalar VDC DInt "wet_1"]])
    ]
stencilDefinitionsList = [("s1" , [-502,-1,0,1,502] ), ("s2" , [-502,-1,0,1,502] ), ("s3" , [0,1,502] ), ("s4" , [0,1,502] ), ("s5" , [-502,-1,0,1,502] ), ("s6" , [-1,0] ), ("s7" , [-502,0] )]

mainArgDeclsList = [
      ("h_0" , MkFDecl "real"  (Just [252004]) (Just In) ["h_0"] )
    , ("eta_0" , MkFDecl "real"  (Just [252004]) (Just In) ["eta_0"] )
    , ("dy_0" , MkFDecl "real" Nothing (Just In) ["dy_0"] )
    , ("dx_0" , MkFDecl "real" Nothing (Just In) ["dx_0"] )
    , ("dt_0" , MkFDecl "real" Nothing (Just In) ["dt_0"] )
    , ("g_0" , MkFDecl "real" Nothing (Just In) ["g_0"] )
    , ("u_0" , MkFDecl "real"  (Just [252004]) (Just In) ["u_0"] )
    , ("eps_0" , MkFDecl "real" Nothing (Just In) ["eps_0"] )
    , ("v_0" , MkFDecl "real"  (Just [252004]) (Just In) ["v_0"] )
    , ("hzero_0" , MkFDecl "real"  (Just [252004]) (Just In) ["hzero_0"] )
    , ("hmin_0" , MkFDecl "real" Nothing (Just In) ["hmin_0"] )
    , ("wet_0" , MkFDecl "integer"  (Just [252004]) (Just In) ["wet_0"] )
    , ("du_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["du_1"] )
    , ("h_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["h_1"] )
    , ("v_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["v_1"] )
    , ("dv_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["dv_1"] )
    , ("u_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["u_1"] )
    , ("wet_1" , MkFDecl "integer"  (Just [252004]) (Just Out) ["wet_1"] )
  ]

scalarisedArgsList = [
     ( "dyn_map_39",[("dt",(0,In,"real")), ("g",(0,In,"real")), ("eta",(1,In,"real")), ("eta",(2,In,"real")), ("eta",(3,In,"real")), ("dx",(0,In,"real")), ("dy",(0,In,"real")), ("du",(0,Out,"real")), ("dv",(0,Out,"real"))])
    ,( "dyn_map_45",[("u",(0,In,"real")), ("du",(0,In,"real")), ("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("v",(0,In,"real")), ("dv",(0,In,"real")), ("un",(0,Out,"real")), ("vn",(0,Out,"real"))])
    ,( "dyn_map_65",[("un",(1,In,"real")), ("un",(2,In,"real")), ("h",(1,In,"real")), ("h",(2,In,"real")), ("h",(3,In,"real")), ("h",(4,In,"real")), ("h",(5,In,"real")), ("vn",(1,In,"real")), ("vn",(2,In,"real")), ("eta",(0,InOut,"real")), ("dt",(0,In,"real")), ("dx",(0,In,"real")), ("dy",(0,In,"real"))])
    ,( "shapiro_map_16",[("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("wet",(4,In,"integer")), ("wet",(5,In,"integer")), ("eps",(0,In,"real")), ("eta",(1,In,"real")), ("eta",(2,In,"real")), ("eta",(3,InOut,"real")), ("eta",(4,In,"real")), ("eta",(5,In,"real"))])
    ,( "update_map_24",[("hzero",(0,In,"real")), ("eta",(0,In,"real")), ("h",(0,InOut,"real")), ("hmin",(0,In,"real")), ("un",(0,In,"real")), ("vn",(0,In,"real")), ("wet",(0,Out,"integer")), ("u",(0,Out,"real")), ("v",(0,Out,"real"))])
  ]

origNamesList = [
     ( "shapiro_map_16",[("eps",[("eps_0",In)]), ("wet",[("wet_s_0",In)]), ("eta",[("eta_s_0",In),("eta_1",Out)])])
    ,( "dyn_map_39",[("dt",[("dt_0",In)]), ("g",[("g_0",In)]), ("dx",[("dx_0",In)]), ("dy",[("dy_0",In)]), ("eta",[("eta_s_1",In)]), ("du",[("du_1",Out)]), ("dv",[("dv_1",Out)])])
    ,( "dyn_map_45",[("u",[("u_0",In)]), ("du",[("du_1",In)]), ("wet",[("wet_s_1",In)]), ("v",[("v_0",In)]), ("dv",[("dv_1",In)]), ("un",[("un_1",Out)]), ("vn",[("vn_1",Out)])])
    ,( "dyn_map_65",[("dt",[("dt_0",In)]), ("dx",[("dx_0",In)]), ("dy",[("dy_0",In)]), ("un",[("un_s_0",In)]), ("h",[("h_s_0",In)]), ("vn",[("vn_s_0",In)]), ("eta",[("eta_1",In),("eta_2",Out)])])
    ,( "update_map_24",[("hmin",[("hmin_0",In)]), ("hzero",[("hzero_0",In)]), ("eta",[("eta_2",In)]), ("un",[("un_1",In)]), ("vn",[("vn_1",In)]), ("h",[("h_1",Out)]), ("u",[("u_1",Out)]), ("v",[("v_1",Out)]), ("wet",[("wet_1",Out)])])
  ]
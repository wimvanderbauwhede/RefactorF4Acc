-- dyn_shapiro_update_superkernel
module ASTInstance ( ast
        , functionSignaturesList
        , stencilDefinitionsList
        , mainArgDeclsList 
        , scalarisedArgsList
        , origNamesList
        , superkernelName
        ) where
import TyTraCLAST

superkernelName :: String
superkernelName = "dyn_shapiro_update_superkernel"

ast :: TyTraCLAST
ast = [
        -- dyn_shapiro_update_map_53
       (Vec VS (SVec 3 (Scalar VDC DFloat "eta_s_0" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "eta_0")))
       ,( (Tuple [Vec VO (Scalar VDC DFloat "du_dyn_1"),Vec VO (Scalar VDC DFloat "dv_dyn_1")]), UnzipT ( Map (Function "dyn_shapiro_update_map_53"  [Scalar VI DFloat "dt_0",Scalar VI DFloat "g_0",Scalar VI DFloat "dx_0",Scalar VI DFloat "dy_0"]) (Vec VS (SVec 3 (Scalar VDC DFloat "eta_s_0"))) ) )
        -- dyn_shapiro_update_map_59
       ,(Vec VS (SVec 3 (Scalar VDC DInt "wet_s_0" )) , Stencil (SVec 3 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DInt "wet_0")))
       ,( (Tuple [Vec VT (Scalar VDC DFloat "duu_dyn_1"),Vec VO (Scalar VDC DFloat "un_1"),Vec VO (Scalar VDC DFloat "vn_1")]), UnzipT ( Map (Function "dyn_shapiro_update_map_59"  [Scalar VI DFloat "duu_dyn_0"]) (ZipT [Vec VI (Scalar VDC DFloat "u_0"),Vec VO (Scalar VDC DFloat "du_dyn_1"),Vec VS (SVec 3 (Scalar VDC DInt "wet_s_0")),Vec VI (Scalar VDC DFloat "v_0"),Vec VO (Scalar VDC DFloat "dv_dyn_1")]) ) )
        -- dyn_shapiro_update_map_79
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "un_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s3")) (Vec VO (Scalar VDC DFloat "un_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "vn_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s4")) (Vec VO (Scalar VDC DFloat "vn_1")))
       ,(Vec VS (SVec 5 (Scalar VDC DFloat "h_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s5")) (Vec VI (Scalar VDC DFloat "h_0")))
       ,( Vec VO (Scalar VDC DFloat "etan_1"), Map (Function "dyn_shapiro_update_map_79"  [Scalar VI DFloat "dt_0",Scalar VI DFloat "dx_0",Scalar VI DFloat "dy_0"]) (ZipT [Vec VS (SVec 2 (Scalar VDC DFloat "un_s_0")),Vec VS (SVec 5 (Scalar VDC DFloat "h_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "vn_s_0")),Vec VI (Scalar VDC DFloat "eta_0")]) )
        -- dyn_shapiro_update_map_96
       ,(Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s6")) (Vec VO (Scalar VDC DFloat "etan_1")))
       ,(Vec VS (SVec 5 (Scalar VDC DInt "wet_s_1" )) , Stencil (SVec 5 (Scalar VDC DInt "s7")) (Vec VI (Scalar VDC DInt "wet_0")))
       ,( Vec VO (Scalar VDC DFloat "eta_1"), Map (Function "dyn_shapiro_update_map_96"  [Scalar VI DFloat "eps_0"]) (ZipT [Vec VS (SVec 5 (Scalar VDC DInt "wet_s_1")),Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0"))]) )
        -- dyn_shapiro_update_map_108
       ,( (Tuple [Vec VO (Scalar VDC DFloat "h_1"),Vec VO (Scalar VDC DFloat "u_1"),Vec VO (Scalar VDC DFloat "v_1"),Vec VO (Scalar VDC DInt "wet_1")]), UnzipT ( Map (Function "dyn_shapiro_update_map_108"  [Scalar VI DFloat "hmin_0"]) (ZipT [Vec VI (Scalar VDC DFloat "hzero_0"),Vec VO (Scalar VDC DFloat "eta_1"),Vec VI (Scalar VDC DFloat "h_0"),Vec VO (Scalar VDC DFloat "un_1"),Vec VO (Scalar VDC DFloat "vn_1")]) ) )
        ]

functionSignaturesList = [
        ("dyn_shapiro_update_map_108",  [Scalar VI DFloat "hmin_0",Tuple [Scalar VI DFloat "hzero_0",Scalar VO DFloat "eta_1",Scalar VI DFloat "h_0",Scalar VO DFloat "un_1",Scalar VO DFloat "vn_1"],Tuple [Scalar VO DFloat "h_1",Scalar VO DFloat "u_1",Scalar VO DFloat "v_1",Scalar VO DInt "wet_1"]]),
        ("dyn_shapiro_update_map_53",  [Tuple [Scalar VI DFloat "dt_0",Scalar VI DFloat "g_0",Scalar VI DFloat "dx_0",Scalar VI DFloat "dy_0"],SVec 3 (Scalar VDC DFloat "eta_s_0"),Tuple [Scalar VO DFloat "du_dyn_1",Scalar VO DFloat "dv_dyn_1"]]),
        ("dyn_shapiro_update_map_59",  [Scalar VI DFloat "duu_dyn_0",Tuple [Scalar VI DFloat "u_0",Scalar VO DFloat "du_dyn_1",SVec 3 (Scalar VDC DInt "wet_s_0"),Scalar VI DFloat "v_0",Scalar VO DFloat "dv_dyn_1"],Tuple [Scalar VT DFloat "duu_dyn_1",Scalar VO DFloat "un_1",Scalar VO DFloat "vn_1"]]),
        ("dyn_shapiro_update_map_79",  [Tuple [Scalar VI DFloat "dt_0",Scalar VI DFloat "dx_0",Scalar VI DFloat "dy_0"],Tuple [SVec 2 (Scalar VDC DFloat "un_s_0"),SVec 5 (Scalar VDC DFloat "h_s_0"),SVec 2 (Scalar VDC DFloat "vn_s_0"),Scalar VI DFloat "eta_0"],Scalar VO DFloat "etan_1"]),
        ("dyn_shapiro_update_map_96",  [Scalar VI DFloat "eps_0",Tuple [SVec 5 (Scalar VDC DInt "wet_s_1"),SVec 5 (Scalar VDC DFloat "etan_s_0")],Scalar VO DFloat "eta_1"])
    ]
stencilDefinitionsList = [("s1" , [503,504,1005] ), ("s2" , [503,504,1005] ), ("s3" , [1,503] ), ("s4" , [502,503] ), ("s5" , [1,502,503,504,1005] ), ("s6" , [1,502,503,504,1005] ), ("s7" , [1,502,503,504,1005] )]

mainArgDeclsList = [
      ("u_0" , MkFDecl "real"  (Just [252004]) (Just In) ["u_0"] )
    , ("v_0" , MkFDecl "real"  (Just [252004]) (Just In) ["v_0"] )
    , ("g_0" , MkFDecl "real" Nothing (Just In) ["g_0"] )
    , ("duu_dyn_0" , MkFDecl "real" Nothing (Just In) ["duu_dyn_0"] )
    , ("eps_0" , MkFDecl "real" Nothing (Just In) ["eps_0"] )
    , ("eta_0" , MkFDecl "real"  (Just [252004]) (Just In) ["eta_0"] )
    , ("dt_0" , MkFDecl "real" Nothing (Just In) ["dt_0"] )
    , ("hmin_0" , MkFDecl "real" Nothing (Just In) ["hmin_0"] )
    , ("hzero_0" , MkFDecl "real"  (Just [252004]) (Just In) ["hzero_0"] )
    , ("dy_0" , MkFDecl "real" Nothing (Just In) ["dy_0"] )
    , ("wet_0" , MkFDecl "integer"  (Just [252004]) (Just In) ["wet_0"] )
    , ("dx_0" , MkFDecl "real" Nothing (Just In) ["dx_0"] )
    , ("h_0" , MkFDecl "real"  (Just [252004]) (Just In) ["h_0"] )
    , ("etan_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["etan_1"] )
    , ("h_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["h_1"] )
    , ("eta_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["eta_1"] )
    , ("du_dyn_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["du_dyn_1"] )
    , ("u_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["u_1"] )
    , ("v_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["v_1"] )
    , ("dv_dyn_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["dv_dyn_1"] )
    , ("un_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["un_1"] )
    , ("wet_1" , MkFDecl "integer"  (Just [252004]) (Just Out) ["wet_1"] )
    , ("vn_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["vn_1"] )
  ]

scalarisedArgsList = [
     ( "dyn_shapiro_update_map_108",[("hzero",(0,In,"real")), ("eta",(0,In,"real")), ("h",(0,InOut,"real")), ("hmin",(0,In,"real")), ("un",(0,In,"real")), ("vn",(0,In,"real")), ("wet",(0,Out,"integer")), ("u",(0,Out,"real")), ("v",(0,Out,"real"))])
    ,( "dyn_shapiro_update_map_53",[("dt",(0,In,"real")), ("g",(0,In,"real")), ("eta",(1,In,"real")), ("eta",(2,In,"real")), ("eta",(3,In,"real")), ("dx",(0,In,"real")), ("dy",(0,In,"real")), ("du_dyn",(0,Out,"real")), ("dv_dyn",(0,Out,"real"))])
    ,( "dyn_shapiro_update_map_59",[("u",(0,In,"real")), ("du_dyn",(0,In,"real")), ("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("duu_dyn",(0,InOut,"real")), ("v",(0,In,"real")), ("dv_dyn",(0,In,"real")), ("un",(0,Out,"real")), ("vn",(0,Out,"real"))])
    ,( "dyn_shapiro_update_map_79",[("un",(1,In,"real")), ("un",(2,In,"real")), ("h",(1,In,"real")), ("h",(2,In,"real")), ("h",(3,In,"real")), ("h",(4,In,"real")), ("h",(5,In,"real")), ("vn",(1,In,"real")), ("vn",(2,In,"real")), ("eta",(0,In,"real")), ("dt",(0,In,"real")), ("dx",(0,In,"real")), ("dy",(0,In,"real")), ("etan",(0,Out,"real"))])
    ,( "dyn_shapiro_update_map_96",[("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("wet",(4,In,"integer")), ("wet",(5,In,"integer")), ("eps",(0,In,"real")), ("etan",(1,In,"real")), ("etan",(2,In,"real")), ("etan",(3,In,"real")), ("etan",(4,In,"real")), ("etan",(5,In,"real")), ("eta",(0,Out,"real"))])
  ]

origNamesList = [
     ( "dyn_shapiro_update_map_53",[("dt",[("dt_0",In)]), ("g",[("g_0",In)]), ("dx",[("dx_0",In)]), ("dy",[("dy_0",In)]), ("eta",[("eta_s_0",In)]), ("du_dyn",[("du_dyn_1",Out)]), ("dv_dyn",[("dv_dyn_1",Out)])])
    ,( "dyn_shapiro_update_map_59",[("duu_dyn",[("duu_dyn_0",In)]), ("u",[("u_0",In)]), ("du_dyn",[("du_dyn_1",Out)]), ("wet",[("wet_s_0",In)]), ("v",[("v_0",In)]), ("dv_dyn",[("dv_dyn_1",Out)]), ("duu_dyn",[("duu_dyn_1",Out)]), ("un",[("un_1",Out)]), ("vn",[("vn_1",Out)])])
    ,( "dyn_shapiro_update_map_79",[("dt",[("dt_0",In)]), ("dx",[("dx_0",In)]), ("dy",[("dy_0",In)]), ("un",[("un_s_0",In)]), ("h",[("h_s_0",In)]), ("vn",[("vn_s_0",In)]), ("eta",[("eta_0",In)]), ("etan",[("etan_1",Out)])])
    ,( "dyn_shapiro_update_map_96",[("eps",[("eps_0",In)]), ("wet",[("wet_s_1",In)]), ("etan",[("etan_s_0",In)]), ("eta",[("eta_1",Out)])])
    ,( "dyn_shapiro_update_map_108",[("hmin",[("hmin_0",In)]), ("hzero",[("hzero_0",In)]), ("eta",[("eta_1",Out)]), ("h",[("h_0",In),("h_1",Out)]), ("un",[("un_1",Out)]), ("vn",[("vn_1",Out)]), ("u",[("u_1",Out)]), ("v",[("v_1",Out)]), ("wet",[("wet_1",Out)])])
  ]

{-
eta_0 :: Vec 252004 Float
dt_0 :: Float
g_0 :: Float
dx_0 :: Float
dy_0 :: Float
wet_0 :: Vec 252004 Int
u_0 :: Vec 252004 Float
v_0 :: Vec 252004 Float
duu_dyn_0 :: Float
h_0 :: Vec 252004 Float
eps_0 :: Float
hzero_0 :: Vec 252004 Float
hmin_0 :: Float

du_dyn_1 :: Vec 252004 Float
dv_dyn_1 :: Vec 252004 Float
un_1 :: Vec 252004 Float
vn_1 :: Vec 252004 Float
etan_1 :: Vec 252004 Float
eta_1 :: Vec 252004 Float
h_1 :: Vec 252004 Float
u_1 :: Vec 252004 Float
v_1 :: Vec 252004 Float
wet_1 :: Vec 252004 Int

dyn_shapiro_update_map_96 :: Float -> (SVec 5 Int,SVec 5 Float) -> Float
dyn_shapiro_update_map_79 :: (Float,Float,Float) -> (SVec 2 Float,SVec 5 Float,SVec 2 Float,Float) -> Float
dyn_shapiro_update_map_59 :: Float -> (Float,Float,SVec 3 Int,Float,Float) -> (Float,Float,Float)
dyn_shapiro_update_map_53 :: (Float,Float,Float,Float) -> SVec 3 Float -> (Float,Float)
dyn_shapiro_update_map_108 :: Float -> (Float,Float,Float,Float,Float) -> (Float,Float,Float,Int)

main :: (Vec 252004 Float,Float,Float,Float,Float,Vec 252004 Int,Vec 252004 Float,Vec 252004 Float,Float,Vec 252004 Float,Float,Vec 252004 Float,Float) -> (Vec 252004 Float,Vec 252004 Float,Vec 252004 Float,Vec 252004 Float,Vec 252004 Float,Vec 252004 Float,Vec 252004 Float,Vec 252004 Float,Vec 252004 Float,Vec 252004 Int)
main (eta_0,dt_0,g_0,dx_0,dy_0,wet_0,u_0,v_0,duu_dyn_0,h_0,eps_0,hzero_0,hmin_0) =
  let
     -- dyn_shapiro_update_map_53
    s1 = [503,504,1005]
    eta_s_0 = stencil s1 eta_0
    (du_dyn_1,dv_dyn_1) = unzipt $ map (dyn_shapiro_update_map_53 (dt_0,g_0,dx_0,dy_0)) eta_s_0
     -- dyn_shapiro_update_map_59
    s2 = [503,504,1005]
    wet_s_0 = stencil s2 wet_0
    (duu_dyn_1,un_1,vn_1) = unzipt $ map (dyn_shapiro_update_map_59 duu_dyn_0) (zipt (u_0,du_dyn_1,wet_s_0,v_0,dv_dyn_1))
     -- dyn_shapiro_update_map_79
    s3 = [1,503]
    un_s_0 = stencil s3 un_1
    s4 = [502,503]
    vn_s_0 = stencil s4 vn_1
    s5 = [1,502,503,504,1005]
    h_s_0 = stencil s5 h_0
    etan_1 =  map (dyn_shapiro_update_map_79 (dt_0,dx_0,dy_0)) (zipt (un_s_0,h_s_0,vn_s_0,eta_0))
     -- dyn_shapiro_update_map_96
    s6 = [1,502,503,504,1005]
    etan_s_0 = stencil s6 etan_1
    s7 = [1,502,503,504,1005]
    wet_s_1 = stencil s7 wet_0
    eta_1 =  map (dyn_shapiro_update_map_96 eps_0) (zipt (wet_s_1,etan_s_0))
     -- dyn_shapiro_update_map_108
    (h_1,u_1,v_1,wet_1) = unzipt $ map (dyn_shapiro_update_map_108 hmin_0) (zipt (hzero_0,eta_1,h_0,un_1,vn_1))
  in
    (du_dyn_1,dv_dyn_1,un_1,vn_1,etan_1,eta_1,h_1,u_1,v_1,wet_1)
-}

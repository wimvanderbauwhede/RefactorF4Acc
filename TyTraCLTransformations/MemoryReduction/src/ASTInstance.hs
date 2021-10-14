-- dyn_shapiro_superkernel
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
superkernelName = "dyn_shapiro_superkernel"

ast :: TyTraCLAST
ast = [
        -- dyn_shapiro_map_49
       (Vec VS (SVec 3 (Scalar VDC DFloat "eta_s_0" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "eta_0")))
       ,( (Tuple [Vec VT (Scalar VDC DFloat "du___dyn_1"),Vec VT (Scalar VDC DFloat "dv___dyn_1")]), UnzipT ( Map (Function "dyn_shapiro_map_49"  [Scalar VI DFloat "dt_0",Scalar VI DFloat "g_0",Scalar VI DFloat "dx_0",Scalar VI DFloat "dy_0"]) (Vec VS (SVec 3 (Scalar VDC DFloat "eta_s_0"))) ) )
        -- dyn_shapiro_map_55
       ,(Vec VS (SVec 3 (Scalar VDC DInt "wet_s_0" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DInt "wet_0")))
       ,( (Tuple [Vec VO (Scalar VDC DFloat "un_1"),Vec VO (Scalar VDC DFloat "vn_1")]), UnzipT ( Map (Function "dyn_shapiro_map_55" []) (ZipT [Vec VI (Scalar VDC DFloat "u_0"),Vec VT (Scalar VDC DFloat "du___dyn_1"),Vec VS (SVec 3 (Scalar VDC DInt "wet_s_0")),Vec VI (Scalar VDC DFloat "v_0"),Vec VT (Scalar VDC DFloat "dv___dyn_1")]) ) )
        -- dyn_shapiro_map_75
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "un_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s3")) (Vec VO (Scalar VDC DFloat "un_1")))
       ,(Vec VS (SVec 5 (Scalar VDC DFloat "h_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s4")) (Vec VI (Scalar VDC DFloat "h_0")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "vn_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s5")) (Vec VO (Scalar VDC DFloat "vn_1")))
       ,( Vec VT (Scalar VDC DFloat "etan_1"), Map (Function "dyn_shapiro_map_75"  [Scalar VI DFloat "dt_0",Scalar VI DFloat "dx_0",Scalar VI DFloat "dy_0"]) (ZipT [Vec VS (SVec 2 (Scalar VDC DFloat "un_s_0")),Vec VS (SVec 5 (Scalar VDC DFloat "h_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "vn_s_0")),Vec VI (Scalar VDC DFloat "eta_0")]) )
        -- dyn_shapiro_map_92
       ,(Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s4")) (Vec VT (Scalar VDC DFloat "etan_1")))
       ,(Vec VS (SVec 5 (Scalar VDC DInt "wet_s_1" )) , Stencil (SVec 5 (Scalar VDC DInt "s4")) (Vec VI (Scalar VDC DInt "wet_0")))
       ,( Vec VO (Scalar VDC DFloat "etann_1"), Map (Function "dyn_shapiro_map_92"  [Scalar VI DFloat "eps_0"]) (ZipT [Vec VS (SVec 5 (Scalar VDC DInt "wet_s_1")),Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0"))]) )
        ]

functionSignaturesList = [
        ("dyn_shapiro_map_49",  [Tuple [Scalar VI DFloat "dt_0",Scalar VI DFloat "g_0",Scalar VI DFloat "dx_0",Scalar VI DFloat "dy_0"],SVec 3 (Scalar VDC DFloat "eta_s_0"),Tuple [Scalar VT DFloat "du___dyn_1",Scalar VT DFloat "dv___dyn_1"]]),
        ("dyn_shapiro_map_55",  [Tuple [],Tuple [Scalar VI DFloat "u_0",Scalar VT DFloat "du___dyn_1",SVec 3 (Scalar VDC DInt "wet_s_0"),Scalar VI DFloat "v_0",Scalar VT DFloat "dv___dyn_1"],Tuple [Scalar VO DFloat "un_1",Scalar VO DFloat "vn_1"]]),
        ("dyn_shapiro_map_75",  [Tuple [Scalar VI DFloat "dt_0",Scalar VI DFloat "dx_0",Scalar VI DFloat "dy_0"],Tuple [SVec 2 (Scalar VDC DFloat "un_s_0"),SVec 5 (Scalar VDC DFloat "h_s_0"),SVec 2 (Scalar VDC DFloat "vn_s_0"),Scalar VI DFloat "eta_0"],Scalar VT DFloat "etan_1"]),
        ("dyn_shapiro_map_92",  [Scalar VI DFloat "eps_0",Tuple [SVec 5 (Scalar VDC DInt "wet_s_1"),SVec 5 (Scalar VDC DFloat "etan_s_0")],Scalar VO DFloat "etann_1"])
    ]
stencilDefinitionsList = [("s1" , [503,504,1005] ), ("s3" , [1,503] ), ("s4" , [1,502,503,504,1005] ), ("s5" , [502,503] )]

mainArgDeclsList = [
      ("h_0" , MkFDecl "real"  (Just [252004]) (Just In) ["h_0"] )
    , ("dx_0" , MkFDecl "real" Nothing (Just In) ["dx_0"] )
    , ("g_0" , MkFDecl "real" Nothing (Just In) ["g_0"] )
    , ("dy_0" , MkFDecl "real" Nothing (Just In) ["dy_0"] )
    , ("v_0" , MkFDecl "real"  (Just [252004]) (Just In) ["v_0"] )
    , ("eta_0" , MkFDecl "real"  (Just [252004]) (Just In) ["eta_0"] )
    , ("eps_0" , MkFDecl "real" Nothing (Just In) ["eps_0"] )
    , ("u_0" , MkFDecl "real"  (Just [252004]) (Just In) ["u_0"] )
    , ("wet_0" , MkFDecl "integer"  (Just [252004]) (Just In) ["wet_0"] )
    , ("dt_0" , MkFDecl "real" Nothing (Just In) ["dt_0"] )
    , ("un_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["un_1"] )
    , ("etann_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["etann_1"] )
    , ("vn_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["vn_1"] )
  ]

scalarisedArgsList = [
     ( "dyn_shapiro_map_49",[("dt",(0,In,"real")), ("g",(0,In,"real")), ("eta",(1,In,"real")), ("eta",(2,In,"real")), ("eta",(3,In,"real")), ("dx",(0,In,"real")), ("dy",(0,In,"real")), ("du___dyn",(0,Out,"real")), ("dv___dyn",(0,Out,"real"))])
    ,( "dyn_shapiro_map_55",[("u",(0,In,"real")), ("du___dyn",(0,In,"real")), ("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("v",(0,In,"real")), ("dv___dyn",(0,In,"real")), ("un",(0,Out,"real")), ("vn",(0,Out,"real"))])
    ,( "dyn_shapiro_map_75",[("un",(1,In,"real")), ("un",(2,In,"real")), ("h",(1,In,"real")), ("h",(2,In,"real")), ("h",(3,In,"real")), ("h",(4,In,"real")), ("h",(5,In,"real")), ("vn",(1,In,"real")), ("vn",(2,In,"real")), ("eta",(0,In,"real")), ("dt",(0,In,"real")), ("dx",(0,In,"real")), ("dy",(0,In,"real")), ("etan",(0,Out,"real"))])
    ,( "dyn_shapiro_map_92",[("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("wet",(4,In,"integer")), ("wet",(5,In,"integer")), ("eps",(0,In,"real")), ("etan",(1,In,"real")), ("etan",(2,In,"real")), ("etan",(3,In,"real")), ("etan",(4,In,"real")), ("etan",(5,In,"real")), ("etann",(0,Out,"real"))])
  ]

origNamesList = [
     ( "dyn_shapiro_map_49",[("dt",[("dt_0",In)]), ("g",[("g_0",In)]), ("dx",[("dx_0",In)]), ("dy",[("dy_0",In)]), ("eta",[("eta_s_0",In)]), ("du___dyn",[("du___dyn_1",Out)]), ("dv___dyn",[("dv___dyn_1",Out)])])
    ,( "dyn_shapiro_map_55",[("u",[("u_0",In)]), ("du___dyn",[("du___dyn_1",In)]), ("wet",[("wet_s_0",In)]), ("v",[("v_0",In)]), ("dv___dyn",[("dv___dyn_1",In)]), ("un",[("un_1",Out)]), ("vn",[("vn_1",Out)])])
    ,( "dyn_shapiro_map_75",[("dt",[("dt_0",In)]), ("dx",[("dx_0",In)]), ("dy",[("dy_0",In)]), ("un",[("un_s_0",In)]), ("h",[("h_s_0",In)]), ("vn",[("vn_s_0",In)]), ("eta",[("eta_0",In)]), ("etan",[("etan_1",Out)])])
    ,( "dyn_shapiro_map_92",[("eps",[("eps_0",In)]), ("wet",[("wet_s_1",In)]), ("etan",[("etan_s_0",In)]), ("etann",[("etann_1",Out)])])
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
h_0 :: Vec 252004 Float
eps_0 :: Float

un_1 :: Vec 252004 Float
vn_1 :: Vec 252004 Float
etann_1 :: Vec 252004 Float

dyn_shapiro_map_92 :: Float -> (SVec 5 Int,SVec 5 Float) -> Float
dyn_shapiro_map_75 :: (Float,Float,Float) -> (SVec 2 Float,SVec 5 Float,SVec 2 Float,Float) -> Float
dyn_shapiro_map_55 :: (Float,Float,SVec 3 Int,Float,Float) -> (Float,Float)
dyn_shapiro_map_49 :: (Float,Float,Float,Float) -> SVec 3 Float -> (Float,Float)

main :: (Vec 252004 Float,Float,Float,Float,Float,Vec 252004 Int,Vec 252004 Float,Vec 252004 Float,Vec 252004 Float,Float) -> (Vec 252004 Float,Vec 252004 Float,Vec 252004 Float)
main (eta_0,dt_0,g_0,dx_0,dy_0,wet_0,u_0,v_0,h_0,eps_0) =
  let
     -- dyn_shapiro_map_49
    s1 = [503,504,1005]
    eta_s_0 = stencil s1 eta_0
    (du___dyn_1,dv___dyn_1) = unzipt $ map (dyn_shapiro_map_49 (dt_0,g_0,dx_0,dy_0)) eta_s_0
     -- dyn_shapiro_map_55
    s2 = [503,504,1005]
    wet_s_0 = stencil s2 wet_0
    (un_1,vn_1) = unzipt $ map dyn_shapiro_map_55 (zipt (u_0,du___dyn_1,wet_s_0,v_0,dv___dyn_1))
     -- dyn_shapiro_map_75
    s3 = [1,503]
    un_s_0 = stencil s3 un_1
    s4 = [1,502,503,504,1005]
    h_s_0 = stencil s4 h_0
    s5 = [502,503]
    vn_s_0 = stencil s5 vn_1
    etan_1 =  map (dyn_shapiro_map_75 (dt_0,dx_0,dy_0)) (zipt (un_s_0,h_s_0,vn_s_0,eta_0))
     -- dyn_shapiro_map_92
    s6 = [1,502,503,504,1005]
    etan_s_0 = stencil s6 etan_1
    s7 = [1,502,503,504,1005]
    wet_s_1 = stencil s7 wet_0
    etann_1 =  map (dyn_shapiro_map_92 eps_0) (zipt (wet_s_1,etan_s_0))
  in
    (un_1,vn_1,etann_1)
-}

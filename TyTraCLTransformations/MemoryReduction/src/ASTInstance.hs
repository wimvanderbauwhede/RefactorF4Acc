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
       ,( (Tuple [Vec VT (Scalar VDC DFloat "du_dyn_1"),Vec VT (Scalar VDC DFloat "dv_dyn_1")]), UnzipT ( Map (Function "dyn_shapiro_update_map_53" []) (Vec VS (SVec 3 (Scalar VDC DFloat "eta_s_0"))) ) )
        -- dyn_shapiro_update_map_59
       ,(Vec VS (SVec 3 (Scalar VDC DInt "wet_s_0" )) , Stencil (SVec 3 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DInt "wet_0")))
       ,( (Tuple [Vec VO (Scalar VDC DFloat "un_1"),Vec VO (Scalar VDC DFloat "vn_1")]), UnzipT ( Map (Function "dyn_shapiro_update_map_59" []) (ZipT [Vec VI (Scalar VDC DFloat "u_0"),Vec VT (Scalar VDC DFloat "du_dyn_1"),Vec VS (SVec 3 (Scalar VDC DInt "wet_s_0")),Vec VI (Scalar VDC DFloat "v_0"),Vec VT (Scalar VDC DFloat "dv_dyn_1")]) ) )
        -- dyn_shapiro_update_map_79
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "vn_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s3")) (Vec VO (Scalar VDC DFloat "vn_1")))
       ,(Vec VS (SVec 5 (Scalar VDC DFloat "h_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s4")) (Vec VI (Scalar VDC DFloat "h_0")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "un_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s5")) (Vec VO (Scalar VDC DFloat "un_1")))
       ,( Vec VT (Scalar VDC DFloat "etan_1"), Map (Function "dyn_shapiro_update_map_79" []) (ZipT [Vec VS (SVec 2 (Scalar VDC DFloat "un_s_0")),Vec VS (SVec 5 (Scalar VDC DFloat "h_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "vn_s_0")),Vec VI (Scalar VDC DFloat "eta_0")]) )
        -- dyn_shapiro_update_map_96
       ,(Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s6")) (Vec VT (Scalar VDC DFloat "etan_1")))
       ,(Vec VS (SVec 5 (Scalar VDC DInt "wet_s_1" )) , Stencil (SVec 5 (Scalar VDC DInt "s7")) (Vec VI (Scalar VDC DInt "wet_0")))
       ,( Vec VO (Scalar VDC DFloat "eta_1"), Map (Function "dyn_shapiro_update_map_96" []) (ZipT [Vec VS (SVec 5 (Scalar VDC DInt "wet_s_1")),Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0"))]) )
        -- dyn_shapiro_update_map_108
       ,( (Tuple [Vec VT (Scalar VDC DFloat "u_1"),Vec VT (Scalar VDC DFloat "v_1")]), UnzipT ( Map (Function "dyn_shapiro_update_map_108" []) (ZipT [Vec VO (Scalar VDC DFloat "un_1"),Vec VO (Scalar VDC DFloat "vn_1")]) ) )
        ]

functionSignaturesList = [
        ("dyn_shapiro_update_map_108",  [Tuple [],Tuple [Scalar VO DFloat "un_1",Scalar VO DFloat "vn_1"],Tuple [Scalar VT DFloat "u_1",Scalar VT DFloat "v_1"]]),
        ("dyn_shapiro_update_map_53",  [Tuple [],SVec 3 (Scalar VDC DFloat "eta_s_0"),Tuple [Scalar VT DFloat "du_dyn_1",Scalar VT DFloat "dv_dyn_1"]]),
        ("dyn_shapiro_update_map_59",  [Tuple [],Tuple [Scalar VI DFloat "u_0",Scalar VT DFloat "du_dyn_1",SVec 3 (Scalar VDC DInt "wet_s_0"),Scalar VI DFloat "v_0",Scalar VT DFloat "dv_dyn_1"],Tuple [Scalar VO DFloat "un_1",Scalar VO DFloat "vn_1"]]),
        ("dyn_shapiro_update_map_79",  [Tuple [],Tuple [SVec 2 (Scalar VDC DFloat "un_s_0"),SVec 5 (Scalar VDC DFloat "h_s_0"),SVec 2 (Scalar VDC DFloat "vn_s_0"),Scalar VI DFloat "eta_0"],Scalar VT DFloat "etan_1"]),
        ("dyn_shapiro_update_map_96",  [Tuple [],Tuple [SVec 5 (Scalar VDC DInt "wet_s_1"),SVec 5 (Scalar VDC DFloat "etan_s_0")],Scalar VO DFloat "eta_1"])
    ]
stencilDefinitionsList = [("s1" , [503,504,1005] ), ("s2" , [503,504,1005] ), ("s3" , [502,503] ), ("s4" , [1,502,503,504,1005] ), ("s5" , [1,503] ), ("s6" , [1,502,503,504,1005] ), ("s7" , [1,502,503,504,1005] )]

mainArgDeclsList = [
      ("h_0" , MkFDecl "real"  (Just [252004]) (Just In) ["h_0"] )
    , ("v_0" , MkFDecl "real"  (Just [252004]) (Just In) ["v_0"] )
    , ("wet_0" , MkFDecl "integer"  (Just [252004]) (Just In) ["wet_0"] )
    , ("u_0" , MkFDecl "real"  (Just [252004]) (Just In) ["u_0"] )
    , ("eta_0" , MkFDecl "real"  (Just [252004]) (Just In) ["eta_0"] )
    , ("un_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["un_1"] )
    , ("eta_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["eta_1"] )
    , ("vn_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["vn_1"] )
  ]

scalarisedArgsList = [
     ( "dyn_shapiro_update_map_108",[("un",(0,In,"real")), ("vn",(0,In,"real")), ("u",(0,Out,"real")), ("v",(0,Out,"real"))])
    ,( "dyn_shapiro_update_map_53",[("eta",(1,In,"real")), ("eta",(2,In,"real")), ("eta",(3,In,"real")), ("du_dyn",(0,Out,"real")), ("dv_dyn",(0,Out,"real"))])
    ,( "dyn_shapiro_update_map_59",[("u",(0,In,"real")), ("du_dyn",(0,In,"real")), ("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("v",(0,In,"real")), ("dv_dyn",(0,In,"real")), ("un",(0,Out,"real")), ("vn",(0,Out,"real"))])
    ,( "dyn_shapiro_update_map_79",[("un",(1,In,"real")), ("un",(2,In,"real")), ("h",(1,In,"real")), ("h",(2,In,"real")), ("h",(3,In,"real")), ("h",(4,In,"real")), ("h",(5,In,"real")), ("vn",(1,In,"real")), ("vn",(2,In,"real")), ("eta",(0,In,"real")), ("etan",(0,Out,"real"))])
    ,( "dyn_shapiro_update_map_96",[("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("wet",(4,In,"integer")), ("wet",(5,In,"integer")), ("etan",(1,In,"real")), ("etan",(2,In,"real")), ("etan",(3,In,"real")), ("etan",(4,In,"real")), ("etan",(5,In,"real")), ("eta",(0,Out,"real"))])
  ]

origNamesList = [
     ( "dyn_shapiro_update_map_53",[("eta",[("eta_s_0",In)]), ("du_dyn",[("du_dyn_1",Out)]), ("dv_dyn",[("dv_dyn_1",Out)])])
    ,( "dyn_shapiro_update_map_59",[("u",[("u_0",In)]), ("du_dyn",[("du_dyn_1",In)]), ("wet",[("wet_s_0",In)]), ("v",[("v_0",In)]), ("dv_dyn",[("dv_dyn_1",In)]), ("un",[("un_1",Out)]), ("vn",[("vn_1",Out)])])
    ,( "dyn_shapiro_update_map_79",[("un",[("un_s_0",In)]), ("h",[("h_s_0",In)]), ("vn",[("vn_s_0",In)]), ("eta",[("eta_0",In)]), ("etan",[("etan_1",Out)])])
    ,( "dyn_shapiro_update_map_96",[("wet",[("wet_s_1",In)]), ("etan",[("etan_s_0",In)]), ("eta",[("eta_1",Out)])])
    ,( "dyn_shapiro_update_map_108",[("un",[("un_1",Out)]), ("vn",[("vn_1",Out)]), ("u",[("u_1",Out)]), ("v",[("v_1",Out)])])
  ]

{-
eta_0 :: Vec 252004 Float
wet_0 :: Vec 252004 Int
u_0 :: Vec 252004 Float
v_0 :: Vec 252004 Float
h_0 :: Vec 252004 Float

un_1 :: Vec 252004 Float
vn_1 :: Vec 252004 Float
eta_1 :: Vec 252004 Float

dyn_shapiro_update_map_96 :: (SVec 5 Int,SVec 5 Float) -> Float
dyn_shapiro_update_map_79 :: (SVec 2 Float,SVec 5 Float,SVec 2 Float,Float) -> Float
dyn_shapiro_update_map_59 :: (Float,Float,SVec 3 Int,Float,Float) -> (Float,Float)
dyn_shapiro_update_map_53 :: SVec 3 Float -> (Float,Float)
dyn_shapiro_update_map_108 :: (Float,Float) -> (Float,Float)

main :: (Vec 252004 Float,Vec 252004 Int,Vec 252004 Float,Vec 252004 Float,Vec 252004 Float) -> (Vec 252004 Float,Vec 252004 Float,Vec 252004 Float)
main (eta_0,wet_0,u_0,v_0,h_0) =
  let
     -- dyn_shapiro_update_map_53
    s1 = [503,504,1005]
    eta_s_0 = stencil s1 eta_0
    (du_dyn_1,dv_dyn_1) = unzipt $ map dyn_shapiro_update_map_53 eta_s_0
     -- dyn_shapiro_update_map_59
    s2 = [503,504,1005]
    wet_s_0 = stencil s2 wet_0
    (un_1,vn_1) = unzipt $ map dyn_shapiro_update_map_59 (zipt (u_0,du_dyn_1,wet_s_0,v_0,dv_dyn_1))
     -- dyn_shapiro_update_map_79
    s3 = [502,503]
    vn_s_0 = stencil s3 vn_1
    s4 = [1,502,503,504,1005]
    h_s_0 = stencil s4 h_0
    s5 = [1,503]
    un_s_0 = stencil s5 un_1
    etan_1 =  map dyn_shapiro_update_map_79 (zipt (un_s_0,h_s_0,vn_s_0,eta_0))
     -- dyn_shapiro_update_map_96
    s6 = [1,502,503,504,1005]
    etan_s_0 = stencil s6 etan_1
    s7 = [1,502,503,504,1005]
    wet_s_1 = stencil s7 wet_0
    eta_1 =  map dyn_shapiro_update_map_96 (zipt (wet_s_1,etan_s_0))
     -- dyn_shapiro_update_map_108
    (u_1,v_1) = unzipt $ map dyn_shapiro_update_map_108 (zipt (un_1,vn_1))
  in
    (un_1,vn_1,eta_1)
-}

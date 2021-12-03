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
       ,( (Tuple [Vec VT (Scalar VDC DFloat "du___dyn_1"),Vec VT (Scalar VDC DFloat "dv___dyn_1")]), UnzipT ( Map (Function "dyn_shapiro_map_49" []) (Vec VS (SVec 3 (Scalar VDC DFloat "eta_s_0"))) ) )
        -- dyn_shapiro_map_55
       ,(Vec VS (SVec 3 (Scalar VDC DInt "wet_s_0" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DInt "wet_0")))
       ,( (Tuple [Vec VO (Scalar VDC DFloat "un_1"),Vec VO (Scalar VDC DFloat "vn_1")]), UnzipT ( Map (Function "dyn_shapiro_map_55" []) (ZipT [Vec VI (Scalar VDC DFloat "u_0"),Vec VT (Scalar VDC DFloat "du___dyn_1"),Vec VS (SVec 3 (Scalar VDC DInt "wet_s_0")),Vec VI (Scalar VDC DFloat "v_0"),Vec VT (Scalar VDC DFloat "dv___dyn_1")]) ) )
        ]

functionSignaturesList = [
        ("dyn_shapiro_map_49",  [Tuple [],SVec 3 (Scalar VDC DFloat "eta_s_0"),Tuple [Scalar VT DFloat "du___dyn_1",Scalar VT DFloat "dv___dyn_1"]]),
        ("dyn_shapiro_map_55",  [Tuple [],Tuple [Scalar VI DFloat "u_0",Scalar VT DFloat "du___dyn_1",SVec 3 (Scalar VDC DInt "wet_s_0"),Scalar VI DFloat "v_0",Scalar VT DFloat "dv___dyn_1"],Tuple [Scalar VO DFloat "un_1",Scalar VO DFloat "vn_1"]])
    ]
stencilDefinitionsList = [("s1" , [503,504,1005] )]

mainArgDeclsList = [
      ("wet_0" , MkFDecl "integer"  (Just [252004]) (Just In) ["wet_0"] )
    , ("eta_0" , MkFDecl "real"  (Just [252004]) (Just In) ["eta_0"] )
    , ("v_0" , MkFDecl "real"  (Just [252004]) (Just In) ["v_0"] )
    , ("u_0" , MkFDecl "real"  (Just [252004]) (Just In) ["u_0"] )
    , ("vn_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["vn_1"] )
    , ("un_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["un_1"] )
  ]

scalarisedArgsList = [
     ( "dyn_shapiro_map_49",[("eta",(1,In,"real")), ("eta",(2,In,"real")), ("eta",(3,In,"real")), ("du___dyn",(0,Out,"real")), ("dv___dyn",(0,Out,"real"))])
    ,( "dyn_shapiro_map_55",[("u",(0,In,"real")), ("du___dyn",(0,In,"real")), ("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("v",(0,In,"real")), ("dv___dyn",(0,In,"real")), ("un",(0,Out,"real")), ("vn",(0,Out,"real"))])
  ]

origNamesList = [
     ( "dyn_shapiro_map_49",[("eta",[("eta_s_0",In)]), ("du___dyn",[("du___dyn_1",Out)]), ("dv___dyn",[("dv___dyn_1",Out)])])
    ,( "dyn_shapiro_map_55",[("u",[("u_0",In)]), ("du___dyn",[("du___dyn_1",In)]), ("wet",[("wet_s_0",In)]), ("v",[("v_0",In)]), ("dv___dyn",[("dv___dyn_1",In)]), ("un",[("un_1",Out)]), ("vn",[("vn_1",Out)])])
  ]

{-
eta_0 :: Vec 252004 Float
wet_0 :: Vec 252004 Int
u_0 :: Vec 252004 Float
v_0 :: Vec 252004 Float

un_1 :: Vec 252004 Float
vn_1 :: Vec 252004 Float

dyn_shapiro_map_55 :: (Float,Float,SVec 3 Int,Float,Float) -> (Float,Float)
dyn_shapiro_map_49 :: SVec 3 Float -> (Float,Float)

main :: (Vec 252004 Float,Vec 252004 Int,Vec 252004 Float,Vec 252004 Float) -> (Vec 252004 Float,Vec 252004 Float)
main (eta_0,wet_0,u_0,v_0) =
  let
     -- dyn_shapiro_map_49
    s1 = [503,504,1005]
    eta_s_0 = stencil s1 eta_0
    (du___dyn_1,dv___dyn_1) = unzipt $ map dyn_shapiro_map_49 eta_s_0
     -- dyn_shapiro_map_55
    s2 = [503,504,1005]
    wet_s_0 = stencil s2 wet_0
    (un_1,vn_1) = unzipt $ map dyn_shapiro_map_55 (zipt (u_0,du___dyn_1,wet_s_0,v_0,dv___dyn_1))
  in
    (un_1,vn_1)
-}

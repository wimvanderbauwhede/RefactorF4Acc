-- module_shapiro_dyn_update_superkernel
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
superkernelName = "shapiro_dyn_update_superkernel"

ast :: TyTraCLAST
ast = [
        -- update_map_24
       ( (Tuple [Vec VO (Scalar VDC DFloat "h_1"),Vec VO (Scalar VDC DFloat "u_1"),Vec VO (Scalar VDC DFloat "v_1"),Vec VO (Scalar VDC DInt "wet_1")]), UnzipT ( Map (Function "update_map_24" []) (ZipT [Vec VI (Scalar VDC DFloat "hzero_0"),Vec VI (Scalar VDC DFloat "eta_0"),Vec VI (Scalar VDC DFloat "un_0"),Vec VI (Scalar VDC DFloat "vn_0")]) ) )
        ]

functionSignaturesList = [
        ("update_map_24",  [Tuple [],Tuple [Scalar VI DFloat "hzero_0",Scalar VI DFloat "eta_0",Scalar VI DFloat "un_0",Scalar VI DFloat "vn_0"],Tuple [Scalar VO DFloat "h_1",Scalar VO DFloat "u_1",Scalar VO DFloat "v_1",Scalar VO DInt "wet_1"]])
    ]
stencilDefinitionsList = []

mainArgDeclsList = [
      ("un_0" , MkFDecl "real"  (Just [252004]) (Just In) ["un_0"] )
    , ("vn_0" , MkFDecl "real"  (Just [252004]) (Just In) ["vn_0"] )
    , ("eta_0" , MkFDecl "real"  (Just [252004]) (Just In) ["eta_0"] )
    , ("hzero_0" , MkFDecl "real"  (Just [252004]) (Just In) ["hzero_0"] )
    , ("v_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["v_1"] )
    , ("u_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["u_1"] )
    , ("h_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["h_1"] )
    , ("wet_1" , MkFDecl "integer"  (Just [252004]) (Just Out) ["wet_1"] )
  ]

scalarisedArgsList = [
     ( "update_map_24",[("hzero",(0,In,"real")), ("eta",(0,In,"real")), ("h",(0,InOut,"real")), ("un",(0,In,"real")), ("vn",(0,In,"real")), ("wet",(0,Out,"integer")), ("u",(0,Out,"real")), ("v",(0,Out,"real"))])
  ]

origNamesList = [
     ( "update_map_24",[("hzero",[("hzero_0",In)]), ("eta",[("eta_0",In)]), ("un",[("un_0",In)]), ("vn",[("vn_0",In)]), ("h",[("h_1",Out)]), ("u",[("u_1",Out)]), ("v",[("v_1",Out)]), ("wet",[("wet_1",Out)])])
  ]

{-
hzero_0 :: Vec 252004 Float
eta_0 :: Vec 252004 Float
un_0 :: Vec 252004 Float
vn_0 :: Vec 252004 Float

h_1 :: Vec 252004 Float
u_1 :: Vec 252004 Float
v_1 :: Vec 252004 Float
wet_1 :: Vec 252004 Int

update_map_24 :: (Float,Float,Float,Float) -> (Float,Float,Float,Int)

main :: (Vec 252004 Float,Vec 252004 Float,Vec 252004 Float,Vec 252004 Float) -> (Vec 252004 Float,Vec 252004 Float,Vec 252004 Float,Vec 252004 Int)
main (hzero_0,eta_0,un_0,vn_0) =
  let
     -- update_map_24
    (h_1,u_1,v_1,wet_1) = unzipt $ map update_map_24 (zipt (hzero_0,eta_0,un_0,vn_0))
  in
    (h_1,u_1,v_1,wet_1)
-}

-- module_shapiro_dyn_update_superkernel
module ASTInstance ( ast
        , functionSignaturesList
        , stencilDefinitionsList
        , mainArgDeclsList 
        , scalarisedArgsList
        , origNamesList
        , moduleName
        ) where
import TyTraCLAST

moduleName :: String
moduleName = "module_shapiro_dyn_update_superkernel"

ast :: TyTraCLAST
ast = [
        -- update_map_24
       ( (Tuple [Vec VO (Scalar VDC DFloat "h_1"),Vec VO (Scalar VDC DFloat "u_1")]), UnzipT ( Map (Function "update_map_24" []) (ZipT [Vec VI (Scalar VDC DFloat "hzero_0"),Vec VI (Scalar VDC DFloat "un_0")]) ) )
        ]

functionSignaturesList = [
        ("update_map_24",  [Tuple [],Tuple [Scalar VI DFloat "hzero_0",Scalar VI DFloat "un_0"],Tuple [Scalar VO DFloat "h_1",Scalar VO DFloat "u_1"]])
    ]
stencilDefinitionsList = []

mainArgDeclsList = [
      ("hzero_0" , MkFDecl "real"  (Just [252004]) (Just In) ["hzero_0"] )
    , ("un_0" , MkFDecl "real"  (Just [252004]) (Just In) ["un_0"] )
    , ("h_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["h_1"] )
    , ("u_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["u_1"] )
  ]

scalarisedArgsList = [
     ( "update_map_24",[("hzero",(0,In,"real")), ("h",(0,Out,"real")), ("un",(0,In,"real")), ("u",(0,Out,"real"))])
  ]

origNamesList = [
     ( "update_map_24",[("hzero",[("hzero_0",In)]), ("un",[("un_0",In)]), ("h",[("h_1",Out)]), ("u",[("u_1",Out)])])
  ]

{-
hzero_0 :: Vec 252004 Float
un_0 :: Vec 252004 Float

h_1 :: Vec 252004 Float
u_1 :: Vec 252004 Float

update_map_24 :: (Float,Float) -> (Float,Float)

main :: (Vec 252004 Float,Vec 252004 Float) -> (Vec 252004 Float,Vec 252004 Float)
main (hzero_0,un_0) =
  let
     -- update_map_24
    (h_1,u_1) = unzipt $ map update_map_24 (zipt (hzero_0,un_0))
  in
    (h_1,u_1)
-}

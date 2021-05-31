-- module_test3d_superkernel
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
moduleName = "module_test3d_superkernel"

ast :: TyTraCLAST
ast = [
        -- f3d
       (Vec VS (SVec 3 (Scalar VDC DFloat "v_s_0" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "v_0")))
       ,( Vec VO (Scalar VDC DFloat "v_1"), Map (Function "f3d"  [Scalar VI DFloat "acc_0"]) (Vec VS (SVec 3 (Scalar VDC DFloat "v_s_0"))) )
        ]

functionSignaturesList = [
        ("f3d",  [Scalar VI DFloat "acc_0",SVec 3 (Scalar VDC DFloat "v_s_0"),Scalar VO DFloat "v_1"])
    ]
stencilDefinitionsList = [("s1" , [-250501,0,250501] )]

mainArgDeclsList = [
      ("acc_0" , MkFDecl "real" Nothing (Just In) ["acc_0"] )
    , ("v_0" , MkFDecl "real"  (Just [20000000]) (Just In) ["v_0"] )
    , ("v_1" , MkFDecl "real"  (Just [20000000]) (Just Out) ["v_1"] )
  ]

scalarisedArgsList = [
     ( "f3d",[("acc",(0,In,"real")), ("v",(1,In,"real")), ("v",(2,InOut,"real")), ("v",(3,In,"real"))])
  ]

origNamesList = [
     ( "f3d",[("acc",[("acc_0",In)]), ("v",[("v_s_0",In),("v_1",Out)])])
  ]

{-
v_0 :: Vec 20000000 Float
acc_0 :: Float

v_1 :: Vec 20000000 Float

f3d :: Float -> SVec 3 Float -> Float

main :: (Vec 20000000 Float,Float) -> (Vec 20000000 Float)
main (v_0,acc_0) =
  let
     -- f3d
    s1 = [-250501,0,250501]
    v_s_0 = stencil s1 v_0
    v_1 =  map (f3d acc_0) v_s_0
  in
    v_1
-}

-- module_test_superkernel
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
        -- f
       ( Vec VO (Scalar VDC DFloat "v_1"), Map (Function "f"  [Scalar VI DFloat "acc_0"]) (Vec VI (Scalar VDC DFloat "v_0")) )
        ]

functionSignaturesList = [
        ("f",  [Scalar VI DFloat "acc_0",Scalar VI DFloat "v_0",Scalar VO DFloat "v_1"])
    ]
stencilDefinitionsList = []

mainArgDeclsList = [
      ("acc_0" , MkFDecl "real" Nothing (Just In) ["acc_0"] )
    , ("v_0" , MkFDecl "real"  (Just [500]) (Just In) ["v_0"] )
    , ("v_1" , MkFDecl "real"  (Just [500]) (Just Out) ["v_1"] )
  ]

scalarisedArgsList = [
     ( "f",[("acc",(0,In,"real")), ("v",(0,InOut,"real"))])
  ]

origNamesList = [
     ( "f",[("acc",[("acc_0",In)]), ("v",[("v_0",In),("v_1",Out)])])
  ]

{-
v_0 :: Vec 500 Float
acc_0 :: Float

v_1 :: Vec 500 Float

f :: Float -> Float -> Float

main :: (Vec 500 Float,Float) -> (Vec 500 Float)
main (v_0,acc_0) =
  let
     -- f
    v_1 =  map (f acc_0) v_0
  in
    v_1
-}

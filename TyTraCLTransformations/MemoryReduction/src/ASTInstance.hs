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
        (Scalar VO DFloat "acc_1", Fold (Function "f" []) (Scalar VI DFloat "acc_0") (Vec VI (Scalar VDC DFloat "v_0")))
        ]

functionSignaturesList = [
        ("f",  [Tuple [],Scalar VDC DFloat "acc_0",SVec 500 (Scalar VDC DFloat "v_0"),Scalar VDC DFloat "acc_1"])
    ]
stencilDefinitionsList = []

mainArgDeclsList = [
      ("acc_0" , MkFDecl "real" Nothing (Just In) ["acc_0"] )
    , ("v_0" , MkFDecl "real"  (Just [500]) (Just In) ["v_0"] )
    , ("acc_1" , MkFDecl "real" Nothing (Just Out) ["acc_1"] )
  ]

scalarisedArgsList = [
     ( "f",[("acc",(0,InOut,"real")), ("v",(0,In,"real"))])
  ]

origNamesList = [
     ( "f",[("acc",[("acc_1",Out)]), ("v",[("v_0",In)]), ("acc",[("acc_0",In)])])
  ]

{-
v_0 :: Vec 500 Float
acc_0 :: Float

acc_1 :: Float

f :: Float -> Float -> Float

main :: (Vec 500 Float,Float) -> (Float)
main (v_0,acc_0) =
  let
     -- f
    acc_1 =  fold f acc_0 v_0
  in
    acc_1
-}

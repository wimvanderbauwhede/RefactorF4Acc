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
        -- f1
        (Scalar VO DFloat "acc_1", Fold (Function "f1" []) (Scalar VI DFloat "acc_0") (Vec VI (Scalar VDC DFloat "v_0")))
        -- f2
       ,( Vec VO (Scalar VDC DFloat "v_1"), Map (Function "f2"  [Scalar VI DFloat "acc_1"]) (Vec VI (Scalar VDC DFloat "v_0")) )
        ]

functionSignaturesList = [
        ("f1",  [Tuple [],Scalar VDC DFloat "acc_0",SVec 500 (Scalar VDC DFloat "v_0"),Scalar VDC DFloat "acc_1"]),
        ("f2",  [Scalar VDC DFloat "acc_1",SVec 500 (Scalar VDC DFloat "v_0"),SVec 500 (Scalar VDC DFloat "v_1")])
    ]
stencilDefinitionsList = []

mainArgDeclsList = [
      ("v_0" , MkFDecl "real"  (Just [500]) (Just In) ["v_0"] )
    , ("acc_0" , MkFDecl "real" Nothing (Just In) ["acc_0"] )
    , ("v_1" , MkFDecl "real"  (Just [500]) (Just Out) ["v_1"] )
  ]

scalarisedArgsList = [
     ( "f1",[("acc",(0,InOut,"real")), ("v",(0,In,"real"))])
    ,( "f2",[("acc",(0,In,"real")), ("v",(0,InOut,"real"))])
  ]

origNamesList = [
     ( "f1",[("acc",[("acc_1",Out)]), ("v",[("v_0",In)]), ("acc",[("acc_0",Out)])])
    ,( "f2",[("acc",[("acc_1",In)]), ("v",[("v_0",In),("v_1",Out)])])
  ]

{-
v_0 :: Vec 500 Float
acc_0 :: Float

v_1 :: Vec 500 Float

f2 :: Float -> Float -> Float
f1 :: Float -> Float -> Float

main :: (Vec 500 Float,Float) -> (Vec 500 Float)
main (v_0,acc_0) =
  let
     -- f1
    acc_1 =  fold f1 acc_0 v_0
     -- f2
    v_1 =  map (f2 acc_1) v_0
  in
    v_1
-}

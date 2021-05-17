-- TEST 14
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
        (Scalar VO DInt "acc_out_0", Fold (Function "f1" []) (Scalar VI DInt "acc_in_0") (Vec VI (Scalar VDC DInt "v_0")))
        ]

functionSignaturesList = [
        ("f1",  [Tuple [],Scalar VDC DInt "acc_in_0",Scalar VDC DInt "v_0",Scalar VDC DInt "acc_out_0"])
    ]
stencilDefinitionsList = []

mainArgDeclsList = [
      ("acc_in_0" , MkFDecl "integer" Nothing (Just In) ["acc_in_0"] )
    , ("v_0" , MkFDecl "integer"  (Just [500]) (Just In) ["v_0"] )
    , ("acc_out_0" , MkFDecl "integer" Nothing (Just Out) ["acc_out_0"] )
  ]
scalarisedArgsList = []
origNamesList = []

{-
v_0 :: Vec 500 Int
acc_in_0 :: Int

acc_out_0 :: Int

f1 :: Int -> Int -> Int

main :: (Vec 500 Int,Int) -> (Int)
main (v_0,acc_in_0) =
  let
    acc_out_0 =  fold f1 acc_in_0 v_0
  in
    acc_out_0
-}

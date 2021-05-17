-- TEST 13
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
       ( Vec VO (Scalar VDC DFloat "out_0"), Map (Function "f" []) (Vec VI (Scalar VDC DFloat "in_0")) )
        ]

functionSignaturesList = [
        ("f",  [Tuple [],Scalar VDC DFloat "in_0",Scalar VDC DFloat "out_0"])
    ]
stencilDefinitionsList = []

mainArgDeclsList = [
      ("in_0" , MkFDecl "real"  (Just [500]) (Just In) ["in_0"] )
    , ("out_0" , MkFDecl "real"  (Just [500]) (Just Out) ["out_0"] )
  ]
scalarisedArgsList = []
origNamesList = []

{-
in_0 :: Vec 500 Float

out_0 :: Vec 500 Float

f :: Float -> Float

main :: (Vec 500 Float) -> (Vec 500 Float)
main in_0 =
  let
    out_0 =  map f in_0
  in
    out_0
-}

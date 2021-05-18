-- TEST 16
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
       ( Vec VO (Scalar VDC DFloat "v_out_0"), Map (Function "f"  [Scalar VI DInt "s_nm_0",Scalar VI DFloat "v_nm_0"]) (Vec VI (Scalar VDC DFloat "v_in_0")) )
        ]

functionSignaturesList = [
        ("f",  [Tuple [Scalar VDC DInt "s_nm_0",SVec 10 (Scalar VDC DFloat "v_nm_0")],Scalar VDC DVec "v_in_0",Scalar VDC DVec "v_out_0"])
    ]
stencilDefinitionsList = []

mainArgDeclsList = [
      ("v_in_0" , MkFDecl "real"  (Just [500]) (Just In) ["v_in_0"] )
    , ("v_nm_0" , MkFDecl "real"  (Just [10]) (Just In) ["v_nm_0"] )
    , ("s_nm_0" , MkFDecl "integer" Nothing (Just In) ["s_nm_0"] )
    , ("v_out_0" , MkFDecl "real"  (Just [500]) (Just Out) ["v_out_0"] )
  ]
scalarisedArgsList = []
origNamesList = []

{-
v_in_0 :: Vec 500 Float
s_nm_0 :: Int
v_nm_0 :: SVec 10 Float

v_out_0 :: Vec 500 Float

f :: (Int,Float) -> Float -> Float

main :: (Vec 500 Float,Int,SVec 10 Float) -> (Vec 500 Float)
main (v_in_0,s_nm_0,v_nm_0) =
  let
    v_out_0 =  map (f (s_nm_0,v_nm_0)) v_in_0
  in
    v_out_0
-}

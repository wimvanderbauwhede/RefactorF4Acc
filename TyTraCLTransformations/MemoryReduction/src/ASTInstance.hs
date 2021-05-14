-- TEST 2
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
       ( Vec VT (Scalar VDC DInt "v3_0"), Map (Function "f1"  [Scalar VI DInt "nm_0"]) (ZipT [Vec VI (Scalar VDC DInt "v1_0"),Vec VI (Scalar VDC DInt "v2_0")]) )
       ,(Vec VS (SVec 3 (Scalar VDC DInt "v3_s_0" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VT (Scalar VDC DInt "v3_0")))
       ,( Vec VO (Scalar VDC DInt "v4_0"), Map (Function "f2" []) (Vec VS (SVec 3(Scalar VDC DInt "v3_s_0"))) )
        ]

functionSignaturesList = [
        ("f1",  [Scalar VDC DInt "nm_0",Tuple [Scalar VDC DInt "v1_0",Scalar VDC DInt "v2_0"],Scalar VDC DInt "v3_0"]),
        ("f2",  [Tuple [],SVec 3 (Scalar VDC DInt "v3_s_0"),Scalar VDC DInt "v4_0"])
    ]
stencilDefinitionsList = [("s1" , [-1,0,1] )]

mainArgDeclsList = [
      ("nm_0" , MkFDecl "integer" Nothing (Just In) ["nm_0"] )
    , ("v1_0" , MkFDecl "integer"  (Just [500]) (Just In) ["v1_0"] )
    , ("v2_0" , MkFDecl "integer"  (Just [500]) (Just In) ["v2_0"] )
    , ("v4_0" , MkFDecl "integer"  (Just [500]) (Just Out) ["v4_0"] )
  ]
scalarisedArgsList = []
origNamesList = []

{-
v1_0 :: Vec 500 Int
v2_0 :: Vec 500 Int
nm_0 :: Int

v4_0 :: Vec 500 Int

f2 :: SVec 3 Int -> Int
f1 :: Int -> (Int,Int) -> Int

main :: (Vec 500 Int,Vec 500 Int,Int) -> (Vec 500 Int)
main (v1_0,v2_0,nm_0) =
  let
    v3_0 =  map (f1 nm_0) (zipt (v1_0,v2_0))
    s1 = [-1,0,1]
    v3_s_0 = stencil s1 v3_0
    v4_0 =  map f2 v3_s_0
  in
    v4_0
-}

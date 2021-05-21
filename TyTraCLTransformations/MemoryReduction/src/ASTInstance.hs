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
       (Vec VS (SVec 2 (Scalar VDC DFloat "v_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "v_0")))
       ,( Vec VO (Scalar VDC DFloat "v_1"), Map (Function "f"  [Scalar VI DFloat "acc_0"]) (Vec VS (SVec 2(Scalar VDC DFloat "v_s_0"))) )
        ]

functionSignaturesList = [
        ("f",  [Scalar VI DFloat "acc_0",SVec 2 (Scalar VDC DFloat "v_s_0"),Scalar VO DFloat "v_1"])
    ]
stencilDefinitionsList = [("s1" , [-2,0] )]

mainArgDeclsList = [
      ("v_0" , MkFDecl "real"  (Just [500]) (Just In) ["v_0"] )
    , ("acc_0" , MkFDecl "real" Nothing (Just In) ["acc_0"] )
    , ("v_1" , MkFDecl "real"  (Just [500]) (Just Out) ["v_1"] )
  ]

scalarisedArgsList = [
     ( "f",[("acc",(0,In,"real")), ("v",(1,In,"real")), ("v",(2,In,"real")), ("v",(3,Out,"real"))])
  ]

origNamesList = [
     ( "f",[("acc",[("acc_0",In)]), ("v",[("v_s_0",In),("v_1",Out)])])
  ]

{-
v_0 :: Vec 500 Float
acc_0 :: Float

v_1 :: Vec 500 Float

f :: Float -> SVec 2 Float -> Float

main :: (Vec 500 Float,Float) -> (Vec 500 Float)
main (v_0,acc_0) =
  let
     -- f
    s1 = [-2,0]
    v_s_0 = stencil s1 v_0
    v_1 =  map (f acc_0) v_s_0
  in
    v_1
-}

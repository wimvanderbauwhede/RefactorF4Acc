-- sor_main_superkernel
module ASTInstance ( ast
        , functionSignaturesList
        , stencilDefinitionsList
        , mainArgDeclsList 
        , scalarisedArgsList
        , origNamesList
        , superkernelName
        ) where
import TyTraCLAST

superkernelName :: String
superkernelName = "sor_main_superkernel"

ast :: TyTraCLAST
ast = [
        -- sor_main_map_23
       (Vec VS (SVec 9 (Scalar VDC DFloat "p0_s_0" )) , Stencil (SVec 9 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "p0_0")))
       ,( Vec VO (Scalar VDC DFloat "p1_1"), Map (Function "sor_main_map_23" []) (ZipT [Vec VS (SVec 9 (Scalar VDC DFloat "p0_s_0")),Vec VI (Scalar VDC DFloat "rhs_0")]) )
        ]

functionSignaturesList = [
        ("sor_main_map_23",  [Tuple [],Tuple [SVec 9 (Scalar VDC DFloat "p0_s_0"),Scalar VI DFloat "rhs_0"],Scalar VO DFloat "p1_1"])
    ]
stencilDefinitionsList = [("s1" , [103,10405,10407,10506,10507,10508,10607,10609,20911] )]

mainArgDeclsList = [
      ("p0_0" , MkFDecl "real"  (Just [853128]) (Just In) ["p0_0"] )
    , ("rhs_0" , MkFDecl "real"  (Just [853128]) (Just In) ["rhs_0"] )
    , ("p1_1" , MkFDecl "real"  (Just [853128]) (Just Out) ["p1_1"] )
  ]

scalarisedArgsList = [
     ( "sor_main_map_23",[("p0",(1,In,"real")), ("p0",(2,In,"real")), ("p0",(3,In,"real")), ("p0",(4,In,"real")), ("p0",(5,In,"real")), ("p0",(6,In,"real")), ("p0",(7,In,"real")), ("p0",(8,In,"real")), ("p0",(9,In,"real")), ("rhs",(0,In,"real")), ("p1",(0,Out,"real"))])
  ]

origNamesList = [
     ( "sor_main_map_23",[("p0",[("p0_s_0",In)]), ("rhs",[("rhs_0",In)]), ("p1",[("p1_1",Out)])])
  ]

{-
p0_0 :: Vec 853128 Float
rhs_0 :: Vec 853128 Float

p1_1 :: Vec 853128 Float

sor_main_map_23 :: (SVec 9 Float,Float) -> Float

main :: (Vec 853128 Float,Vec 853128 Float) -> (Vec 853128 Float)
main (p0_0,rhs_0) =
  let
     -- sor_main_map_23
    s1 = [103,10405,10407,10506,10507,10508,10607,10609,20911]
    p0_s_0 = stencil s1 p0_0
    p1_1 =  map sor_main_map_23 (zipt (p0_s_0,rhs_0))
  in
    p1_1
-}

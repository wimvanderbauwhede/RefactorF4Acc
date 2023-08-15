-- sor_superkernel
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
superkernelName = "sor_superkernel"

ast :: TyTraCLAST
ast = [
        -- sor_map_21
       (Vec VS (SVec 9 (Scalar VDC DFloat "p0_s_0" )) , Stencil (SVec 9 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "p0_0")))
       ,( Vec VT (Scalar VDC DFloat "p1_1"), Map (Function "sor_map_21"  [Scalar VI DInt "global_id_0"]) (ZipT [Vec VS (SVec 9 (Scalar VDC DFloat "p0_s_0")),Vec VI (Scalar VDC DFloat "rhs_0")]) )
        -- sor_map_45
       ,(Vec VS (SVec 9 (Scalar VDC DFloat "p1_s_0" )) , Stencil (SVec 9 (Scalar VDC DInt "s1")) (Vec VT (Scalar VDC DFloat "p1_1")))
       ,( Vec VO (Scalar VDC DFloat "p2_1"), Map (Function "sor_map_45"  [Scalar VI DInt "global_id_0"]) (ZipT [Vec VS (SVec 9 (Scalar VDC DFloat "p1_s_0")),Vec VI (Scalar VDC DFloat "rhs_0")]) )
        ]

functionSignaturesList = [
        ("sor_map_21",  [Scalar VI DInt "global_id_0",Tuple [SVec 9 (Scalar VDC DFloat "p0_s_0"),Scalar VI DFloat "rhs_0"],Scalar VT DFloat "p1_1"]),
        ("sor_map_45",  [Scalar VI DInt "global_id_0",Tuple [SVec 9 (Scalar VDC DFloat "p1_s_0"),Scalar VI DFloat "rhs_0"],Scalar VO DFloat "p2_1"])
    ]
stencilDefinitionsList = [("s1" , [103,10405,10407,10506,10507,10508,10607,10609,20911] )]

mainArgDeclsList = [
      ("global_id_0" , MkFDecl "integer" Nothing (Just In) ["global_id_0"] )
    , ("p0_0" , MkFDecl "real"  (Just [(1,853128)]) (Just In) ["p0_0"] )
    , ("rhs_0" , MkFDecl "real"  (Just [(1,853128)]) (Just In) ["rhs_0"] )
    , ("p2_1" , MkFDecl "real"  (Just [(1,853128)]) (Just Out) ["p2_1"] )
  ]

scalarisedArgsList = [
     ( "sor_map_21",[("global_id",(0,In,"integer")), ("p0",(1,In,"real")), ("p0",(2,In,"real")), ("p0",(3,In,"real")), ("p0",(4,In,"real")), ("p0",(5,In,"real")), ("p0",(6,In,"real")), ("p0",(7,In,"real")), ("p0",(8,In,"real")), ("p0",(9,In,"real")), ("rhs",(0,In,"real")), ("p1",(0,Out,"real"))])
    ,( "sor_map_45",[("global_id",(0,In,"integer")), ("p1",(1,In,"real")), ("p1",(2,In,"real")), ("p1",(3,In,"real")), ("p1",(4,In,"real")), ("p1",(5,In,"real")), ("p1",(6,In,"real")), ("p1",(7,In,"real")), ("p1",(8,In,"real")), ("p1",(9,In,"real")), ("rhs",(0,In,"real")), ("p2",(0,Out,"real"))])
  ]

origNamesList = [
     ( "sor_map_21",[("global_id",[("global_id_0",In)]), ("p0",[("p0_s_0",In)]), ("rhs",[("rhs_0",In)]), ("p1",[("p1_1",Out)])])
    ,( "sor_map_45",[("global_id",[("global_id_0",In)]), ("p1",[("p1_s_0",In)]), ("rhs",[("rhs_0",In)]), ("p2",[("p2_1",Out)])])
  ]

{-
p0_0 :: Vec 853128 Float
rhs_0 :: Vec 853128 Float
global_id_0 :: Int

p2_1 :: Vec 853128 Float

sor_map_45 :: Int -> (SVec 9 Float,Float) -> Float
sor_map_21 :: Int -> (SVec 9 Float,Float) -> Float

main :: (Vec 853128 Float,Vec 853128 Float,Int) -> (Vec 853128 Float)
main (p0_0,rhs_0,global_id_0) =
  let
     -- sor_map_21
    s1 = [103,10405,10407,10506,10507,10508,10607,10609,20911]
    p0_s_0 = stencil s1 p0_0
    p1_1 =  map (sor_map_21 global_id_0) (zipt (p0_s_0,rhs_0))
     -- sor_map_45
    s2 = [103,10405,10407,10506,10507,10508,10607,10609,20911]
    p1_s_0 = stencil s2 p1_1
    p2_1 =  map (sor_map_45 global_id_0) (zipt (p1_s_0,rhs_0))
  in
    p2_1
-}

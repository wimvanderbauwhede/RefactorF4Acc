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
        -- sor_map_20
       (Vec VS (SVec 9 (Scalar VDC DFloat "p0_s_0" )) , Stencil (SVec 9 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "p0_0")))
       ,( Vec VO (Scalar VDC DFloat "p1_1"), Map (Function "sor_map_20"  [Scalar VI DInt "global_id_0"]) (ZipT [Vec VS (SVec 9 (Scalar VDC DFloat "p0_s_0")),Vec VI (Scalar VDC DFloat "rhs_0")]) )
        ]

functionSignaturesList = [
        ("sor_map_20",  [Scalar VI DInt "global_id_0",Tuple [SVec 9 (Scalar VDC DFloat "p0_s_0"),Scalar VI DFloat "rhs_0"],Scalar VO DFloat "p1_1"])
    ]
stencilDefinitionsList = [("s1" , [4803,23059205,23059207,23064006,23064007,23064008,23068807,23068809,46123211] )]

mainArgDeclsList = [
      ("global_id_0" , MkFDecl "integer" Nothing (Just In) ["global_id_0"] )
    , ("rhs_0" , MkFDecl "real"  (Just [(1,2121446768)]) (Just In) ["rhs_0"] )
    , ("p0_0" , MkFDecl "real"  (Just [(1,2121446768)]) (Just In) ["p0_0"] )
    , ("p1_1" , MkFDecl "real"  (Just [(1,2121446768)]) (Just Out) ["p1_1"] )
  ]

scalarisedArgsList = [
     ( "sor_map_20",[("global_id",(0,In,"integer")), ("p0",(1,In,"real")), ("p0",(2,In,"real")), ("p0",(3,In,"real")), ("p0",(4,In,"real")), ("p0",(5,In,"real")), ("p0",(6,In,"real")), ("p0",(7,In,"real")), ("p0",(8,In,"real")), ("p0",(9,In,"real")), ("rhs",(0,In,"real")), ("p1",(0,Out,"real"))])
  ]

origNamesList = [
     ( "sor_map_20",[("global_id",[("global_id_0",In)]), ("p0",[("p0_s_0",In)]), ("rhs",[("rhs_0",In)]), ("p1",[("p1_1",Out)])])
  ]

{-
p0_0 :: Vec 2121446768 Float
rhs_0 :: Vec 2121446768 Float
global_id_0 :: Int

p1_1 :: Vec 2121446768 Float

sor_map_20 :: Int -> (SVec 9 Float,Float) -> Float

main :: (Vec 2121446768 Float,Vec 2121446768 Float,Int) -> (Vec 2121446768 Float)
main (p0_0,rhs_0,global_id_0) =
  let
     -- sor_map_20
    s1 = [4803,23059205,23059207,23064006,23064007,23064008,23068807,23068809,46123211]
    p0_s_0 = stencil s1 p0_0
    p1_1 =  map (sor_map_20 global_id_0) (zipt (p0_s_0,rhs_0))
  in
    p1_1
-}

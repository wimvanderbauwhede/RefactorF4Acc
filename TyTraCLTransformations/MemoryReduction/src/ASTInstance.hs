-- TEST 8
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
       (Vec VS (SVec 3 (Scalar VDC DFloat "etan_s_0" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "etan_0")))
       ,( Vec VT (Scalar VDC DFloat "eta_0"), Map (Function "shapiro_map_16" []) (ZipT [Vec VI (Scalar VDC DInt "wet_0"),Vec VS (SVec 3(Scalar VDC DFloat "etan_s_0"))]) )
       ,( (Tuple [Vec VO (Scalar VDC DFloat "h_0"),Vec VO (Scalar VDC DFloat "u_0"),Vec VO (Scalar VDC DInt "wet_1")]), UnzipT ( Map (Function "update_map_24" []) (ZipT [Vec VT (Scalar VDC DFloat "eta_0"),Vec VI (Scalar VDC DFloat "un_0")]) ) )
        ]

functionSignaturesList = [
        ("shapiro_map_16",  [Tuple [],Tuple [Scalar VDC DInt "wet_0",SVec 3 (Scalar VDC DFloat "etan_s_0")],Scalar VDC DFloat "eta_0"]),
        ("update_map_24",  [Tuple [],Tuple [Scalar VDC DFloat "eta_0",Scalar VDC DFloat "un_0"],Tuple [Scalar VDC DFloat "h_0",Scalar VDC DFloat "u_0",Scalar VDC DInt "wet_1"]])
    ]
stencilDefinitionsList = [("s1" , [-1,0,1] )]

mainArgDeclsList = [
      ("wet_0" , MkFDecl "integer"  (Just [500]) (Just In) ["wet_0"] )
    , ("un_0" , MkFDecl "real"  (Just [500]) (Just In) ["un_0"] )
    , ("etan_0" , MkFDecl "real"  (Just [500]) (Just In) ["etan_0"] )
    , ("h_0" , MkFDecl "real"  (Just [500]) (Just Out) ["h_0"] )
    , ("wet_1" , MkFDecl "integer"  (Just [500]) (Just Out) ["wet_1"] )
    , ("u_0" , MkFDecl "real"  (Just [500]) (Just Out) ["u_0"] )
  ]
scalarisedArgsList = []
origNamesList = []

{-
etan_0 :: Vec 500 Float
wet_0 :: Vec 500 Int
un_0 :: Vec 500 Float

h_0 :: Vec 500 Float
u_0 :: Vec 500 Float
wet_1 :: Vec 500 Int

update_map_24 :: (Float,Float) -> (Float,Float,Int)
shapiro_map_16 :: (Int,SVec 3 Float) -> Float

main :: (Vec 500 Float,Vec 500 Int,Vec 500 Float) -> (Vec 500 Float,Vec 500 Float,Vec 500 Int)
main (etan_0,wet_0,un_0) =
  let
    s1 = [-1,0,1]
    etan_s_0 = stencil s1 etan_0
    eta_0 =  map shapiro_map_16 (zipt (wet_0,etan_s_0))
    (h_0,u_0,wet_1) = unzipt $ map update_map_24 (zipt (eta_0,un_0))
  in
    (h_0,u_0,wet_1)
-}

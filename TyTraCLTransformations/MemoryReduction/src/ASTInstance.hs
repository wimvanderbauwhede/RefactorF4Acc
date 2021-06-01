-- module_shapiro_dyn_update_superkernel
module ASTInstance ( ast
        , functionSignaturesList
        , stencilDefinitionsList
        , mainArgDeclsList 
        , scalarisedArgsList
        , origNamesList
        , moduleName
        ) where
import TyTraCLAST

moduleName :: String
moduleName = "module_shapiro_dyn_update_superkernel"

ast :: TyTraCLAST
ast = [
        -- shapiro_map_24
       (Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "etan_0")))
       ,(Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DInt "wet_0")))
       ,( Vec VO (Scalar VDC DFloat "eta_1"), Map (Function "shapiro_map_24"  [Scalar VI DFloat "eps_0",Scalar VI DFloat "etan_avg_0"]) (ZipT [Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0")),Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0")),Vec VI (Scalar VDC DFloat "eta_0")]) )
        ]

functionSignaturesList = [
        ("shapiro_map_24",  [Tuple [Scalar VI DFloat "eps_0",Scalar VI DFloat "etan_avg_0"],Tuple [SVec 5 (Scalar VDC DInt "wet_s_0"),SVec 5 (Scalar VDC DFloat "etan_s_0"),Scalar VI DFloat "eta_0"],Scalar VO DFloat "eta_1"])
    ]
stencilDefinitionsList = [("s1" , [1,502,503,504,1005] ), ("s2" , [1,502,503,504,1005] )]

mainArgDeclsList = [
      ("eta_0" , MkFDecl "real"  (Just [252004]) (Just In) ["eta_0"] )
    , ("eps_0" , MkFDecl "real" Nothing (Just In) ["eps_0"] )
    , ("wet_0" , MkFDecl "integer"  (Just [252004]) (Just In) ["wet_0"] )
    , ("etan_0" , MkFDecl "real"  (Just [252004]) (Just In) ["etan_0"] )
    , ("etan_avg_0" , MkFDecl "real" Nothing (Just In) ["etan_avg_0"] )
    , ("eta_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["eta_1"] )
  ]

scalarisedArgsList = [
     ( "shapiro_map_24",[("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("wet",(4,In,"integer")), ("wet",(5,In,"integer")), ("eps",(0,In,"real")), ("etan",(1,In,"real")), ("etan",(2,In,"real")), ("etan",(3,In,"real")), ("etan",(4,In,"real")), ("etan",(5,In,"real")), ("eta",(0,InOut,"real")), ("etan_avg",(0,In,"real"))])
  ]

origNamesList = [
     ( "shapiro_map_24",[("eps",[("eps_0",In)]), ("etan_avg",[("etan_avg_0",In)]), ("wet",[("wet_s_0",In)]), ("etan",[("etan_s_0",In)]), ("eta",[("eta_0",In),("eta_1",Out)])])
  ]

{-
etan_0 :: Vec 252004 Float
wet_0 :: Vec 252004 Int
eta_0 :: Vec 252004 Float
eps_0 :: Float
etan_avg_0 :: Float

eta_1 :: Vec 252004 Float

shapiro_map_24 :: (Float,Float) -> (SVec 5 Int,SVec 5 Float,Float) -> Float

main :: (Vec 252004 Float,Vec 252004 Int,Vec 252004 Float,Float,Float) -> (Vec 252004 Float)
main (etan_0,wet_0,eta_0,eps_0,etan_avg_0) =
  let
     -- shapiro_map_24
    s1 = [1,502,503,504,1005]
    etan_s_0 = stencil s1 etan_0
    s2 = [1,502,503,504,1005]
    wet_s_0 = stencil s2 wet_0
    eta_1 =  map (shapiro_map_24 (eps_0,etan_avg_0)) (zipt (wet_s_0,etan_s_0,eta_0))
  in
    eta_1
-}

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
        -- shapiro_reduce_19
        (Scalar VO DFloat "etan_avg_1", Fold (Function "shapiro_reduce_19" []) (Scalar VI DFloat "etan_avg_0") (Vec VI (Scalar VDC DFloat "etan_0")))
        -- shapiro_map_24
       ,(Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DInt "wet_0")))
       ,(Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DFloat "etan_0")))
       ,( Vec VO (Scalar VDC DFloat "eta_1"), Map (Function "shapiro_map_24"  [Scalar VI DFloat "eps_0",Scalar VT DFloat "etan_avg_1"]) (ZipT [Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0")),Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_0")),Vec VI (Scalar VDC DFloat "eta_0")]) )
        -- dyn_map_39
       ,( Vec VO (Scalar VDC DFloat "etan_1"), Map (Function "dyn_map_39"  [Scalar VT DFloat "etan_avg_1"]) (ZipT [Vec VO (Scalar VDC DFloat "eta_1"),Vec VI (Scalar VDC DInt "wet_0")]) )
        ]

functionSignaturesList = [
        ("dyn_map_39",  [Scalar VT DFloat "etan_avg_1",Tuple [Scalar VO DFloat "eta_1",Scalar VI DInt "wet_0"],Scalar VO DFloat "etan_1"]),
        ("shapiro_map_24",  [Tuple [Scalar VI DFloat "eps_0",Scalar VT DFloat "etan_avg_1"],Tuple [SVec 5 (Scalar VDC DInt "wet_s_0"),SVec 5 (Scalar VDC DFloat "etan_s_0"),Scalar VI DFloat "eta_0"],Scalar VO DFloat "eta_1"]),
        ("shapiro_reduce_19",  [Tuple [],Scalar VI DFloat "etan_avg_0",Scalar VI DFloat "etan_0",Scalar VT DFloat "etan_avg_1"])
    ]
stencilDefinitionsList = [("s1" , [1,502,503,504,1005] ), ("s2" , [1,502,503,504,1005] )]

mainArgDeclsList = [
      ("eps_0" , MkFDecl "real" Nothing (Just In) ["eps_0"] )
    , ("etan_0" , MkFDecl "real"  (Just [252004]) (Just In) ["etan_0"] )
    , ("wet_0" , MkFDecl "integer"  (Just [252004]) (Just In) ["wet_0"] )
    , ("eta_0" , MkFDecl "real"  (Just [252004]) (Just In) ["eta_0"] )
    , ("etan_avg_0" , MkFDecl "real" Nothing (Just In) ["etan_avg_0"] )
    , ("eta_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["eta_1"] )
    , ("etan_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["etan_1"] )
  ]

scalarisedArgsList = [
     ( "dyn_map_39",[("eta",(0,In,"real")), ("wet",(0,In,"integer")), ("etan",(0,Out,"real")), ("etan_avg",(0,In,"real"))])
    ,( "shapiro_map_24",[("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("wet",(4,In,"integer")), ("wet",(5,In,"integer")), ("eps",(0,In,"real")), ("etan",(1,In,"real")), ("etan",(2,In,"real")), ("etan",(3,In,"real")), ("etan",(4,In,"real")), ("etan",(5,In,"real")), ("eta",(0,InOut,"real")), ("etan_avg",(0,In,"real"))])
    ,( "shapiro_reduce_19",[("etan",(0,In,"real")), ("etan_avg",(0,InOut,"real"))])
  ]

origNamesList = [
     ( "shapiro_reduce_19",[("etan_avg",[("etan_avg_1",Out)]), ("etan",[("etan_0",In)]), ("etan_avg",[("etan_avg_0",In)])])
    ,( "shapiro_map_24",[("eps",[("eps_0",In)]), ("etan_avg",[("etan_avg_1",In)]), ("wet",[("wet_s_0",In)]), ("etan",[("etan_s_0",In)]), ("eta",[("eta_0",In),("eta_1",Out)])])
    ,( "dyn_map_39",[("etan_avg",[("etan_avg_1",In)]), ("eta",[("eta_1",Out)]), ("wet",[("wet_0",In)]), ("etan",[("etan_1",Out)])])
  ]

{-
etan_0 :: Vec 252004 Float
etan_avg_0 :: Float
wet_0 :: Vec 252004 Int
eta_0 :: Vec 252004 Float
eps_0 :: Float

eta_1 :: Vec 252004 Float
etan_1 :: Vec 252004 Float

shapiro_reduce_19 :: Float -> Float -> Float
shapiro_map_24 :: (Float,Float) -> (SVec 5 Int,SVec 5 Float,Float) -> Float
dyn_map_39 :: Float -> (Float,Int) -> Float

main :: (Vec 252004 Float,Float,Vec 252004 Int,Vec 252004 Float,Float) -> (Vec 252004 Float,Vec 252004 Float)
main (etan_0,etan_avg_0,wet_0,eta_0,eps_0) =
  let
     -- shapiro_reduce_19
    etan_avg_1 =  fold shapiro_reduce_19 etan_avg_0 etan_0
     -- shapiro_map_24
    s1 = [1,502,503,504,1005]
    wet_s_0 = stencil s1 wet_0
    s2 = [1,502,503,504,1005]
    etan_s_0 = stencil s2 etan_0
    eta_1 =  map (shapiro_map_24 (eps_0,etan_avg_1)) (zipt (wet_s_0,etan_s_0,eta_0))
     -- dyn_map_39
    etan_1 =  map (dyn_map_39 etan_avg_1) (zipt (eta_1,wet_0))
  in
    (eta_1,etan_1)
-}

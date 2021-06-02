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
        -- reduce_18
       (Vec VS (SVec 2 (Scalar VDC DFloat "etan_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "etan_0")))
       , (Scalar VO DFloat "acc_1", Fold (Function "reduce_18" []) (Scalar VI DFloat "acc_0") (Vec VS (SVec 2 (Scalar VDC DFloat "etan_s_0"))))
        -- shapiro_reduce_19
       , (Scalar VO DFloat "etan_avg_1", Fold (Function "shapiro_reduce_19"  [Scalar VI DFloat "acc_1"]) (Scalar VI DFloat "etan_avg_0") (Vec VI (Scalar VDC DFloat "etan_0")))
        -- shapiro_map_24
       ,(Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DInt "wet_0")))
       ,(Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_1" )) , Stencil (SVec 5 (Scalar VDC DInt "s3")) (Vec VI (Scalar VDC DFloat "etan_0")))
       ,( Vec VT (Scalar VDC DFloat "eta1_local_1"), Map (Function "shapiro_map_24"  [Scalar VI DFloat "eps_0",Scalar VT DFloat "etan_avg_1"]) (ZipT [Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0")),Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_1"))]) )
        -- shapiro_map_25
       ,(Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_2" )) , Stencil (SVec 5 (Scalar VDC DInt "s4")) (Vec VI (Scalar VDC DFloat "etan_0")))
       ,(Vec VS (SVec 5 (Scalar VDC DInt "wet_s_1" )) , Stencil (SVec 5 (Scalar VDC DInt "s5")) (Vec VI (Scalar VDC DInt "wet_0")))
       ,( Vec VT (Scalar VDC DFloat "eta2_local_1"), Map (Function "shapiro_map_25"  [Scalar VI DFloat "eps_0",Scalar VT DFloat "etan_avg_1"]) (ZipT [Vec VS (SVec 5 (Scalar VDC DInt "wet_s_1")),Vec VS (SVec 5 (Scalar VDC DFloat "etan_s_2"))]) )
        -- dyn_map_39
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "eta1_local_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s6")) (Vec VT (Scalar VDC DFloat "eta1_local_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "eta2_local_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s7")) (Vec VT (Scalar VDC DFloat "eta2_local_1")))
       ,( Vec VO (Scalar VDC DFloat "eta_1"), Map (Function "dyn_map_39"  [Scalar VT DFloat "acc_1"]) (ZipT [Vec VS (SVec 2 (Scalar VDC DFloat "eta1_local_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "eta2_local_s_0")),Vec VI (Scalar VDC DInt "wet_0")]) )
        ]

functionSignaturesList = [
        ("dyn_map_39",  [Scalar VT DFloat "acc_1",Tuple [SVec 2 (Scalar VDC DFloat "eta1_local_s_0"),SVec 2 (Scalar VDC DFloat "eta2_local_s_0"),Scalar VI DInt "wet_0"],Scalar VO DFloat "eta_1"]),
        ("reduce_18",  [Tuple [],Scalar VI DFloat "acc_0",SVec 2 (Scalar VDC DFloat "etan_s_0"),Scalar VT DFloat "acc_1"]),
        ("shapiro_map_24",  [Tuple [Scalar VI DFloat "eps_0",Scalar VT DFloat "etan_avg_1"],Tuple [SVec 5 (Scalar VDC DInt "wet_s_0"),SVec 5 (Scalar VDC DFloat "etan_s_1")],Scalar VT DFloat "eta1_local_1"]),
        ("shapiro_map_25",  [Tuple [Scalar VI DFloat "eps_0",Scalar VT DFloat "etan_avg_1"],Tuple [SVec 5 (Scalar VDC DInt "wet_s_1"),SVec 5 (Scalar VDC DFloat "etan_s_2")],Scalar VT DFloat "eta2_local_1"]),
        ("shapiro_reduce_19",  [Scalar VT DFloat "acc_1",Scalar VI DFloat "etan_avg_0",Scalar VI DFloat "etan_0",Scalar VT DFloat "etan_avg_1"])
    ]
stencilDefinitionsList = [("s1" , [0,1006] ), ("s2" , [1,502,503,504,1005] ), ("s3" , [1,502,503,504,1005] ), ("s4" , [1,502,503,504,1005] ), ("s5" , [1,502,503,504,1005] ), ("s6" , [0,1006] ), ("s7" , [2,1004] )]

mainArgDeclsList = [
      ("acc_0" , MkFDecl "real" Nothing (Just In) ["acc_0"] )
    , ("etan_avg_0" , MkFDecl "real" Nothing (Just In) ["etan_avg_0"] )
    , ("wet_0" , MkFDecl "integer"  (Just [252004]) (Just In) ["wet_0"] )
    , ("eps_0" , MkFDecl "real" Nothing (Just In) ["eps_0"] )
    , ("etan_0" , MkFDecl "real"  (Just [252004]) (Just In) ["etan_0"] )
    , ("eta_1" , MkFDecl "real"  (Just [252004]) (Just Out) ["eta_1"] )
  ]

scalarisedArgsList = [
     ( "dyn_map_39",[("eta1_local",(1,In,"real")), ("eta1_local",(2,In,"real")), ("eta2_local",(1,In,"real")), ("eta2_local",(2,In,"real")), ("wet",(0,In,"integer")), ("eta",(0,Out,"real")), ("acc",(0,In,"real"))])
    ,( "reduce_18",[("etan",(1,In,"real")), ("etan",(2,In,"real")), ("acc",(0,InOut,"real"))])
    ,( "shapiro_map_24",[("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("wet",(4,In,"integer")), ("wet",(5,In,"integer")), ("eps",(0,In,"real")), ("etan",(1,In,"real")), ("etan",(2,In,"real")), ("etan",(3,In,"real")), ("etan",(4,In,"real")), ("etan",(5,In,"real")), ("eta1_local",(0,InOut,"real")), ("etan_avg",(0,In,"real"))])
    ,( "shapiro_map_25",[("wet",(1,In,"integer")), ("wet",(2,In,"integer")), ("wet",(3,In,"integer")), ("wet",(4,In,"integer")), ("wet",(5,In,"integer")), ("eps",(0,In,"real")), ("etan",(1,In,"real")), ("etan",(2,In,"real")), ("etan",(3,In,"real")), ("etan",(4,In,"real")), ("etan",(5,In,"real")), ("eta2_local",(0,InOut,"real")), ("etan_avg",(0,In,"real"))])
    ,( "shapiro_reduce_19",[("acc",(0,In,"real")), ("etan",(0,In,"real")), ("etan_avg",(0,InOut,"real"))])
  ]

origNamesList = [
     ( "reduce_18",[("acc",[("acc_1",Out)]), ("etan",[("etan_s_0",In)]), ("acc",[("acc_0",In)])])
    ,( "shapiro_reduce_19",[("etan_avg",[("etan_avg_1",Out)]), ("etan",[("etan_0",In)]), ("acc",[("acc_1",In)]), ("etan_avg",[("etan_avg_0",In)])])
    ,( "shapiro_map_24",[("eps",[("eps_0",In)]), ("etan_avg",[("etan_avg_1",In)]), ("wet",[("wet_s_0",In)]), ("etan",[("etan_s_1",In)]), ("eta1_local",[("eta1_local_1",Out)])])
    ,( "shapiro_map_25",[("eps",[("eps_0",In)]), ("etan_avg",[("etan_avg_1",In)]), ("wet",[("wet_s_1",In)]), ("etan",[("etan_s_2",In)]), ("eta2_local",[("eta2_local_1",Out)])])
    ,( "dyn_map_39",[("acc",[("acc_1",In)]), ("eta1_local",[("eta1_local_s_0",In)]), ("eta2_local",[("eta2_local_s_0",In)]), ("wet",[("wet_0",In)]), ("eta",[("eta_1",Out)])])
  ]

{-
etan_0 :: Vec 252004 Float
acc_0 :: Float
etan_avg_0 :: Float
wet_0 :: Vec 252004 Int
eps_0 :: Float

eta_1 :: Vec 252004 Float

shapiro_reduce_19 :: Float -> Float -> Float -> Float
shapiro_map_25 :: (Float,Float) -> (SVec 5 Int,SVec 5 Float) -> Float
shapiro_map_24 :: (Float,Float) -> (SVec 5 Int,SVec 5 Float) -> Float
reduce_18 :: Float -> SVec 2 Float -> Float
dyn_map_39 :: Float -> (SVec 2 Float,SVec 2 Float,Int) -> Float

main :: (Vec 252004 Float,Float,Float,Vec 252004 Int,Float) -> (Vec 252004 Float)
main (etan_0,acc_0,etan_avg_0,wet_0,eps_0) =
  let
     -- reduce_18
    s1 = [0,1006]
    etan_s_0 = stencil s1 etan_0
    acc_1 =  fold reduce_18 acc_0 etan_s_0
     -- shapiro_reduce_19
    etan_avg_1 =  fold (shapiro_reduce_19 acc_1) etan_avg_0 etan_0
     -- shapiro_map_24
    s2 = [1,502,503,504,1005]
    wet_s_0 = stencil s2 wet_0
    s3 = [1,502,503,504,1005]
    etan_s_1 = stencil s3 etan_0
    eta1_local_1 =  map (shapiro_map_24 (eps_0,etan_avg_1)) (zipt (wet_s_0,etan_s_1))
     -- shapiro_map_25
    s4 = [1,502,503,504,1005]
    etan_s_2 = stencil s4 etan_0
    s5 = [1,502,503,504,1005]
    wet_s_1 = stencil s5 wet_0
    eta2_local_1 =  map (shapiro_map_25 (eps_0,etan_avg_1)) (zipt (wet_s_1,etan_s_2))
     -- dyn_map_39
    s6 = [0,1006]
    eta1_local_s_0 = stencil s6 eta1_local_1
    s7 = [2,1004]
    eta2_local_s_0 = stencil s7 eta2_local_1
    eta_1 =  map (dyn_map_39 acc_1) (zipt (eta1_local_s_0,eta2_local_s_0,wet_0))
  in
    eta_1
-}

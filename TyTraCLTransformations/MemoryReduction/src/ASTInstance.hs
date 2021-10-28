-- velfg_superkernel
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
superkernelName = "velfg_superkernel"

ast :: TyTraCLAST
ast = [
        -- velfg_map_76
       (Vec VS (SVec 4 (Scalar VDC DFloat "w_s_0" )) , Stencil (SVec 4 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "w_0")))
       ,(Vec VS (SVec 5 (Scalar VDC DFloat "v_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DFloat "v_0")))
       ,(Vec VS (SVec 5 (Scalar VDC DFloat "u_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s3")) (Vec VI (Scalar VDC DFloat "u_0")))
       ,( (Tuple [Vec VT (Scalar VDC DFloat "cov1_1"),Vec VT (Scalar VDC DFloat "cov2_1"),Vec VT (Scalar VDC DFloat "cov3_1"),Vec VT (Scalar VDC DFloat "cov4_1"),Vec VT (Scalar VDC DFloat "cov5_1"),Vec VT (Scalar VDC DFloat "cov6_1"),Vec VT (Scalar VDC DFloat "cov9_1"),Vec VT (Scalar VDC DFloat "diu1_1"),Vec VT (Scalar VDC DFloat "diu2_1"),Vec VT (Scalar VDC DFloat "diu3_1"),Vec VT (Scalar VDC DFloat "diu4_1"),Vec VT (Scalar VDC DFloat "diu5_1"),Vec VT (Scalar VDC DFloat "diu6_1"),Vec VT (Scalar VDC DFloat "diu9_1"),Vec VT (Scalar VDC DFloat "nou1_1"),Vec VT (Scalar VDC DFloat "nou2_1"),Vec VT (Scalar VDC DFloat "nou3_1"),Vec VT (Scalar VDC DFloat "nou4_1"),Vec VT (Scalar VDC DFloat "nou5_1"),Vec VT (Scalar VDC DFloat "nou6_1"),Vec VT (Scalar VDC DFloat "nou9_1")]), UnzipT ( Map (Function "velfg_map_76"  [SVec 303 (Scalar VDC DFloat "dx1_0"),SVec 302 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")]) (ZipT [Vec VS (SVec 5 (Scalar VDC DFloat "u_s_0")),Vec VS (SVec 5 (Scalar VDC DFloat "v_s_0")),Vec VS (SVec 4 (Scalar VDC DFloat "w_s_0"))]) ) )
        -- velfg_map_133
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "u_s_1" )) , Stencil (SVec 2 (Scalar VDC DInt "s4")) (Vec VI (Scalar VDC DFloat "u_0")))
       ,(Vec VS (SVec 3 (Scalar VDC DFloat "w_s_1" )) , Stencil (SVec 3 (Scalar VDC DInt "s5")) (Vec VI (Scalar VDC DFloat "w_0")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "v_s_1" )) , Stencil (SVec 2 (Scalar VDC DInt "s6")) (Vec VI (Scalar VDC DFloat "v_0")))
       ,( (Tuple [Vec VT (Scalar VDC DFloat "cov7_1"),Vec VT (Scalar VDC DFloat "cov8_1"),Vec VT (Scalar VDC DFloat "diu7_1"),Vec VT (Scalar VDC DFloat "diu8_1"),Vec VT (Scalar VDC DFloat "nou7_1"),Vec VT (Scalar VDC DFloat "nou8_1")]), UnzipT ( Map (Function "velfg_map_133"  [SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 303 (Scalar VDC DFloat "dx1_0"),SVec 302 (Scalar VDC DFloat "dy1_0")]) (ZipT [Vec VS (SVec 2 (Scalar VDC DFloat "u_s_1")),Vec VS (SVec 3 (Scalar VDC DFloat "w_s_1")),Vec VS (SVec 2 (Scalar VDC DFloat "v_s_1"))]) ) )
        -- velfg_map_218
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu9_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s7")) (Vec VT (Scalar VDC DFloat "diu9_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov8_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s8")) (Vec VT (Scalar VDC DFloat "cov8_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov1_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s9")) (Vec VT (Scalar VDC DFloat "cov1_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov3_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s7")) (Vec VT (Scalar VDC DFloat "cov3_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov7_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s11")) (Vec VT (Scalar VDC DFloat "cov7_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov5_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s12")) (Vec VT (Scalar VDC DFloat "cov5_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov2_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s8")) (Vec VT (Scalar VDC DFloat "cov2_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu6_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s7")) (Vec VT (Scalar VDC DFloat "diu6_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu4_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s11")) (Vec VT (Scalar VDC DFloat "diu4_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu5_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s12")) (Vec VT (Scalar VDC DFloat "diu5_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu2_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s8")) (Vec VT (Scalar VDC DFloat "diu2_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov6_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s7")) (Vec VT (Scalar VDC DFloat "cov6_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov4_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s11")) (Vec VT (Scalar VDC DFloat "cov4_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu1_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s9")) (Vec VT (Scalar VDC DFloat "diu1_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu3_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s7")) (Vec VT (Scalar VDC DFloat "diu3_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov9_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s7")) (Vec VT (Scalar VDC DFloat "cov9_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu8_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s8")) (Vec VT (Scalar VDC DFloat "diu8_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu7_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s11")) (Vec VT (Scalar VDC DFloat "diu7_1")))
       ,( (Tuple [Vec VT (Scalar VDC DFloat "dfu1_1"),Vec VT (Scalar VDC DFloat "dfv1_1"),Vec VT (Scalar VDC DFloat "dfw1_1"),Vec VO (Scalar VDC DFloat "f_1"),Vec VO (Scalar VDC DFloat "g_1"),Vec VO (Scalar VDC DFloat "h_1")]), UnzipT ( Map (Function "velfg_map_218"  [SVec 303 (Scalar VDC DFloat "dx1_0"),SVec 302 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")]) (ZipT [Vec VS (SVec 2 (Scalar VDC DFloat "cov1_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov2_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov3_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu1_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu2_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu3_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov4_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov5_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov6_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu4_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu5_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu6_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov7_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov8_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov9_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu7_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu8_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu9_s_0"))]) ) )
        ]

functionSignaturesList = [
        ("velfg_map_133",  [Tuple [SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 303 (Scalar VDC DFloat "dx1_0"),SVec 302 (Scalar VDC DFloat "dy1_0")],Tuple [SVec 2 (Scalar VDC DFloat "u_s_1"),SVec 3 (Scalar VDC DFloat "w_s_1"),SVec 2 (Scalar VDC DFloat "v_s_1")],Tuple [Scalar VT DFloat "cov7_1",Scalar VT DFloat "cov8_1",Scalar VT DFloat "diu7_1",Scalar VT DFloat "diu8_1",Scalar VT DFloat "nou7_1",Scalar VT DFloat "nou8_1"]]),
        ("velfg_map_218",  [Tuple [SVec 303 (Scalar VDC DFloat "dx1_0"),SVec 302 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")],Tuple [SVec 2 (Scalar VDC DFloat "cov1_s_0"),SVec 2 (Scalar VDC DFloat "cov2_s_0"),SVec 2 (Scalar VDC DFloat "cov3_s_0"),SVec 2 (Scalar VDC DFloat "diu1_s_0"),SVec 2 (Scalar VDC DFloat "diu2_s_0"),SVec 2 (Scalar VDC DFloat "diu3_s_0"),SVec 2 (Scalar VDC DFloat "cov4_s_0"),SVec 2 (Scalar VDC DFloat "cov5_s_0"),SVec 2 (Scalar VDC DFloat "cov6_s_0"),SVec 2 (Scalar VDC DFloat "diu4_s_0"),SVec 2 (Scalar VDC DFloat "diu5_s_0"),SVec 2 (Scalar VDC DFloat "diu6_s_0"),SVec 2 (Scalar VDC DFloat "cov7_s_0"),SVec 2 (Scalar VDC DFloat "cov8_s_0"),SVec 2 (Scalar VDC DFloat "cov9_s_0"),SVec 2 (Scalar VDC DFloat "diu7_s_0"),SVec 2 (Scalar VDC DFloat "diu8_s_0"),SVec 2 (Scalar VDC DFloat "diu9_s_0")],Tuple [Scalar VT DFloat "dfu1_1",Scalar VT DFloat "dfv1_1",Scalar VT DFloat "dfw1_1",Scalar VO DFloat "f_1",Scalar VO DFloat "g_1",Scalar VO DFloat "h_1"]]),
        ("velfg_map_76",  [Tuple [SVec 303 (Scalar VDC DFloat "dx1_0"),SVec 302 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")],Tuple [SVec 5 (Scalar VDC DFloat "u_s_0"),SVec 5 (Scalar VDC DFloat "v_s_0"),SVec 4 (Scalar VDC DFloat "w_s_0")],Tuple [Scalar VT DFloat "cov1_1",Scalar VT DFloat "cov2_1",Scalar VT DFloat "cov3_1",Scalar VT DFloat "cov4_1",Scalar VT DFloat "cov5_1",Scalar VT DFloat "cov6_1",Scalar VT DFloat "cov9_1",Scalar VT DFloat "diu1_1",Scalar VT DFloat "diu2_1",Scalar VT DFloat "diu3_1",Scalar VT DFloat "diu4_1",Scalar VT DFloat "diu5_1",Scalar VT DFloat "diu6_1",Scalar VT DFloat "diu9_1",Scalar VT DFloat "nou1_1",Scalar VT DFloat "nou2_1",Scalar VT DFloat "nou3_1",Scalar VT DFloat "nou4_1",Scalar VT DFloat "nou5_1",Scalar VT DFloat "nou6_1",Scalar VT DFloat "nou9_1"]])
    ]
stencilDefinitionsList = [("s1" , [92111,92112,92413,183617] ), ("s2" , [605,91809,91810,92110,92111] ), ("s3" , [605,91809,92110,92111,92412] ), ("s4" , [92110,183616] ), ("s5" , [183315,183616,183617] ), ("s6" , [91809,183315] ), ("s7" , [92113,183922] ), ("s8" , [92113,92416] ), ("s9" , [92418,92419] ), ("s11" , [92113,92114] ), ("s12" , [92418,92722] )]

mainArgDeclsList = [
      ("v_0" , MkFDecl "real"  (Just [(1,8418552)]) (Just In) ["v_0"] )
    , ("dzn_0" , MkFDecl "real"  (Just [(-1,94)]) (Just In) ["dzn_0"] )
    , ("dy1_0" , MkFDecl "real"  (Just [(0,302)]) (Just In) ["dy1_0"] )
    , ("dx1_0" , MkFDecl "real"  (Just [(-1,303)]) (Just In) ["dx1_0"] )
    , ("w_0" , MkFDecl "real"  (Just [(1,8510058)]) (Just In) ["w_0"] )
    , ("u_0" , MkFDecl "real"  (Just [(1,8418552)]) (Just In) ["u_0"] )
    , ("dzs_0" , MkFDecl "real"  (Just [(-1,94)]) (Just In) ["dzs_0"] )
    , ("g_1" , MkFDecl "real"  (Just [(1,8244691)]) (Just Out) ["g_1"] )
    , ("h_1" , MkFDecl "real"  (Just [(1,8244691)]) (Just Out) ["h_1"] )
    , ("f_1" , MkFDecl "real"  (Just [(1,8244691)]) (Just Out) ["f_1"] )
  ]

scalarisedArgsList = [
     ( "velfg_map_133",[("dzn",(0,In,"real")), ("u",(1,In,"real")), ("u",(2,In,"real")), ("w",(1,In,"real")), ("w",(2,In,"real")), ("w",(3,In,"real")), ("dx1",(0,In,"real")), ("nou7",(0,InOut,"real")), ("diu7",(0,InOut,"real")), ("v",(1,In,"real")), ("v",(2,In,"real")), ("dy1",(0,In,"real")), ("nou8",(0,InOut,"real")), ("diu8",(0,InOut,"real")), ("cov7",(0,Out,"real")), ("cov8",(0,Out,"real"))])
    ,( "velfg_map_218",[("dx1",(0,In,"real")), ("cov1",(1,In,"real")), ("cov1",(2,In,"real")), ("cov2",(1,In,"real")), ("cov2",(2,In,"real")), ("cov3",(1,In,"real")), ("cov3",(2,In,"real")), ("diu1",(1,In,"real")), ("diu1",(2,In,"real")), ("diu2",(1,In,"real")), ("diu2",(2,In,"real")), ("dy1",(0,In,"real")), ("diu3",(1,In,"real")), ("diu3",(2,In,"real")), ("dzn",(0,In,"real")), ("dfu1",(0,InOut,"real")), ("cov4",(1,In,"real")), ("cov4",(2,In,"real")), ("cov5",(1,In,"real")), ("cov5",(2,In,"real")), ("cov6",(1,In,"real")), ("cov6",(2,In,"real")), ("diu4",(1,In,"real")), ("diu4",(2,In,"real")), ("diu5",(1,In,"real")), ("diu5",(2,In,"real")), ("diu6",(1,In,"real")), ("diu6",(2,In,"real")), ("dfv1",(0,InOut,"real")), ("cov7",(1,In,"real")), ("cov7",(2,In,"real")), ("cov8",(1,In,"real")), ("cov8",(2,In,"real")), ("cov9",(1,In,"real")), ("cov9",(2,In,"real")), ("diu7",(1,In,"real")), ("diu7",(2,In,"real")), ("diu8",(1,In,"real")), ("diu8",(2,In,"real")), ("diu9",(1,In,"real")), ("diu9",(2,In,"real")), ("dzs",(0,In,"real")), ("dfw1",(0,InOut,"real")), ("f",(0,Out,"real")), ("g",(0,Out,"real")), ("h",(0,Out,"real"))])
    ,( "velfg_map_76",[("u",(1,In,"real")), ("u",(2,In,"real")), ("u",(3,In,"real")), ("u",(4,In,"real")), ("u",(5,In,"real")), ("dx1",(0,In,"real")), ("v",(1,In,"real")), ("v",(2,In,"real")), ("v",(3,In,"real")), ("v",(4,In,"real")), ("v",(5,In,"real")), ("dy1",(0,In,"real")), ("w",(1,In,"real")), ("w",(2,In,"real")), ("w",(3,In,"real")), ("w",(4,In,"real")), ("dzn",(0,In,"real")), ("nou1",(0,InOut,"real")), ("diu1",(0,InOut,"real")), ("nou5",(0,InOut,"real")), ("diu5",(0,InOut,"real")), ("nou9",(0,InOut,"real")), ("diu9",(0,InOut,"real")), ("nou2",(0,InOut,"real")), ("diu2",(0,InOut,"real")), ("dzs",(0,In,"real")), ("nou3",(0,InOut,"real")), ("diu3",(0,InOut,"real")), ("nou4",(0,InOut,"real")), ("diu4",(0,InOut,"real")), ("nou6",(0,InOut,"real")), ("diu6",(0,InOut,"real")), ("cov1",(0,Out,"real")), ("cov5",(0,Out,"real")), ("cov9",(0,Out,"real")), ("cov2",(0,Out,"real")), ("cov3",(0,Out,"real")), ("cov4",(0,Out,"real")), ("cov6",(0,Out,"real"))])
  ]

origNamesList = [
     ( "velfg_map_76",[("dx1",[("dx1_0",In)]), ("dy1",[("dy1_0",In)]), ("dzn",[("dzn_0",In)]), ("dzs",[("dzs_0",In)]), ("u",[("u_s_0",In)]), ("v",[("v_s_0",In)]), ("w",[("w_s_0",In)]), ("cov1",[("cov1_1",Out)]), ("cov2",[("cov2_1",Out)]), ("cov3",[("cov3_1",Out)]), ("cov4",[("cov4_1",Out)]), ("cov5",[("cov5_1",Out)]), ("cov6",[("cov6_1",Out)]), ("cov9",[("cov9_1",Out)]), ("diu1",[("diu1_1",Out)]), ("diu2",[("diu2_1",Out)]), ("diu3",[("diu3_1",Out)]), ("diu4",[("diu4_1",Out)]), ("diu5",[("diu5_1",Out)]), ("diu6",[("diu6_1",Out)]), ("diu9",[("diu9_1",Out)]), ("nou1",[("nou1_1",Out)]), ("nou2",[("nou2_1",Out)]), ("nou3",[("nou3_1",Out)]), ("nou4",[("nou4_1",Out)]), ("nou5",[("nou5_1",Out)]), ("nou6",[("nou6_1",Out)]), ("nou9",[("nou9_1",Out)])])
    ,( "velfg_map_133",[("dzn",[("dzn_0",In)]), ("dx1",[("dx1_0",In)]), ("dy1",[("dy1_0",In)]), ("u",[("u_s_1",In)]), ("w",[("w_s_1",In)]), ("v",[("v_s_1",In)]), ("cov7",[("cov7_1",Out)]), ("cov8",[("cov8_1",Out)]), ("diu7",[("diu7_1",Out)]), ("diu8",[("diu8_1",Out)]), ("nou7",[("nou7_1",Out)]), ("nou8",[("nou8_1",Out)])])
    ,( "velfg_map_218",[("dx1",[("dx1_0",In)]), ("dy1",[("dy1_0",In)]), ("dzn",[("dzn_0",In)]), ("dzs",[("dzs_0",In)]), ("cov1",[("cov1_s_0",In)]), ("cov2",[("cov2_s_0",In)]), ("cov3",[("cov3_s_0",In)]), ("diu1",[("diu1_s_0",In)]), ("diu2",[("diu2_s_0",In)]), ("diu3",[("diu3_s_0",In)]), ("cov4",[("cov4_s_0",In)]), ("cov5",[("cov5_s_0",In)]), ("cov6",[("cov6_s_0",In)]), ("diu4",[("diu4_s_0",In)]), ("diu5",[("diu5_s_0",In)]), ("diu6",[("diu6_s_0",In)]), ("cov7",[("cov7_s_0",In)]), ("cov8",[("cov8_s_0",In)]), ("cov9",[("cov9_s_0",In)]), ("diu7",[("diu7_s_0",In)]), ("diu8",[("diu8_s_0",In)]), ("diu9",[("diu9_s_0",In)]), ("dfu1",[("dfu1_1",Out)]), ("dfv1",[("dfv1_1",Out)]), ("dfw1",[("dfw1_1",Out)]), ("f",[("f_1",Out)]), ("g",[("g_1",Out)]), ("h",[("h_1",Out)])])
  ]

{-
w_0 :: Vec ARRAY(0x7f842e0a9fb0) Float
v_0 :: Vec ARRAY(0x7f842e0a3448) Float
u_0 :: Vec ARRAY(0x7f842e0b1838) Float
dx1_0 :: SVec ARRAY(0x7f842e0a0910) Float
dy1_0 :: SVec ARRAY(0x7f842e098978) Float
dzn_0 :: SVec ARRAY(0x7f842cdd01f0) Float
dzs_0 :: SVec ARRAY(0x7f842f1196f8) Float

f_1 :: Vec ARRAY(0x7f842f11b9c8) Float
g_1 :: Vec ARRAY(0x7f842f11baa0) Float
h_1 :: Vec ARRAY(0x7f842f11bb78) Float

velfg_map_76 :: (Float,Float,Float,Float) -> (SVec 5 Float,SVec 5 Float,SVec 4 Float) -> (Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float)
velfg_map_218 :: (Float,Float,Float,Float) -> (SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float) -> (Float,Float,Float,Float,Float,Float)
velfg_map_133 :: (Float,Float,Float) -> (SVec 2 Float,SVec 3 Float,SVec 2 Float) -> (Float,Float,Float,Float,Float,Float)

main :: (Vec ARRAY(0x7f842e0a9fb0) Float,Vec ARRAY(0x7f842e0a3448) Float,Vec ARRAY(0x7f842e0b1838) Float,SVec ARRAY(0x7f842e0a0910) Float,SVec ARRAY(0x7f842e098978) Float,SVec ARRAY(0x7f842cdd01f0) Float,SVec ARRAY(0x7f842f1196f8) Float) -> (Vec ARRAY(0x7f842f11b9c8) Float,Vec ARRAY(0x7f842f11baa0) Float,Vec ARRAY(0x7f842f11bb78) Float)
main (w_0,v_0,u_0,dx1_0,dy1_0,dzn_0,dzs_0) =
  let
     -- velfg_map_76
    s1 = [92111,92112,92413,183617]
    w_s_0 = stencil s1 w_0
    s2 = [605,91809,91810,92110,92111]
    v_s_0 = stencil s2 v_0
    s3 = [605,91809,92110,92111,92412]
    u_s_0 = stencil s3 u_0
    (cov1_1,cov2_1,cov3_1,cov4_1,cov5_1,cov6_1,cov9_1,diu1_1,diu2_1,diu3_1,diu4_1,diu5_1,diu6_1,diu9_1,nou1_1,nou2_1,nou3_1,nou4_1,nou5_1,nou6_1,nou9_1) = unzipt $ map (velfg_map_76 (dx1_0,dy1_0,dzn_0,dzs_0)) (zipt (u_s_0,v_s_0,w_s_0))
     -- velfg_map_133
    s4 = [92110,183616]
    u_s_1 = stencil s4 u_0
    s5 = [183315,183616,183617]
    w_s_1 = stencil s5 w_0
    s6 = [91809,183315]
    v_s_1 = stencil s6 v_0
    (cov7_1,cov8_1,diu7_1,diu8_1,nou7_1,nou8_1) = unzipt $ map (velfg_map_133 (dzn_0,dx1_0,dy1_0)) (zipt (u_s_1,w_s_1,v_s_1))
     -- velfg_map_218
    s7 = [92113,183922]
    diu9_s_0 = stencil s7 diu9_1
    s8 = [92113,92416]
    cov8_s_0 = stencil s8 cov8_1
    s9 = [92418,92419]
    cov1_s_0 = stencil s9 cov1_1
    s10 = [92113,183922]
    cov3_s_0 = stencil s10 cov3_1
    s11 = [92113,92114]
    cov7_s_0 = stencil s11 cov7_1
    s12 = [92418,92722]
    cov5_s_0 = stencil s12 cov5_1
    s13 = [92113,92416]
    cov2_s_0 = stencil s13 cov2_1
    s14 = [92113,183922]
    diu6_s_0 = stencil s14 diu6_1
    s15 = [92113,92114]
    diu4_s_0 = stencil s15 diu4_1
    s16 = [92418,92722]
    diu5_s_0 = stencil s16 diu5_1
    s17 = [92113,92416]
    diu2_s_0 = stencil s17 diu2_1
    s18 = [92113,183922]
    cov6_s_0 = stencil s18 cov6_1
    s19 = [92113,92114]
    cov4_s_0 = stencil s19 cov4_1
    s20 = [92418,92419]
    diu1_s_0 = stencil s20 diu1_1
    s21 = [92113,183922]
    diu3_s_0 = stencil s21 diu3_1
    s22 = [92113,183922]
    cov9_s_0 = stencil s22 cov9_1
    s23 = [92113,92416]
    diu8_s_0 = stencil s23 diu8_1
    s24 = [92113,92114]
    diu7_s_0 = stencil s24 diu7_1
    (dfu1_1,dfv1_1,dfw1_1,f_1,g_1,h_1) = unzipt $ map (velfg_map_218 (dx1_0,dy1_0,dzn_0,dzs_0)) (zipt (cov1_s_0,cov2_s_0,cov3_s_0,diu1_s_0,diu2_s_0,diu3_s_0,cov4_s_0,cov5_s_0,cov6_s_0,diu4_s_0,diu5_s_0,diu6_s_0,cov7_s_0,cov8_s_0,cov9_s_0,diu7_s_0,diu8_s_0,diu9_s_0))
  in
    (f_1,g_1,h_1)
-}

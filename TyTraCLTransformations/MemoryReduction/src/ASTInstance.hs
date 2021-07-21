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
       ,( (Tuple [Vec VT (Scalar VDC DFloat "cov1_1"),Vec VT (Scalar VDC DFloat "cov2_1"),Vec VT (Scalar VDC DFloat "cov3_1"),Vec VT (Scalar VDC DFloat "cov4_1"),Vec VT (Scalar VDC DFloat "cov5_1"),Vec VT (Scalar VDC DFloat "cov6_1"),Vec VT (Scalar VDC DFloat "cov9_1"),Vec VT (Scalar VDC DFloat "diu1_1"),Vec VT (Scalar VDC DFloat "diu2_1"),Vec VT (Scalar VDC DFloat "diu3_1"),Vec VT (Scalar VDC DFloat "diu4_1"),Vec VT (Scalar VDC DFloat "diu5_1"),Vec VT (Scalar VDC DFloat "diu6_1"),Vec VT (Scalar VDC DFloat "diu9_1"),Vec VT (Scalar VDC DFloat "nou1_1"),Vec VT (Scalar VDC DFloat "nou2_1"),Vec VT (Scalar VDC DFloat "nou3_1"),Vec VT (Scalar VDC DFloat "nou4_1"),Vec VT (Scalar VDC DFloat "nou5_1"),Vec VT (Scalar VDC DFloat "nou6_1"),Vec VT (Scalar VDC DFloat "nou9_1")]), UnzipT ( Map (Function "velfg_map_76"  [SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")]) (ZipT [Vec VS (SVec 5 (Scalar VDC DFloat "u_s_0")),Vec VS (SVec 5 (Scalar VDC DFloat "v_s_0")),Vec VS (SVec 4 (Scalar VDC DFloat "w_s_0")),Vec VT (Scalar VDC DFloat "diu1_0"),Vec VT (Scalar VDC DFloat "nou5_0"),Vec VT (Scalar VDC DFloat "diu5_0"),Vec VT (Scalar VDC DFloat "nou9_0"),Vec VT (Scalar VDC DFloat "diu9_0"),Vec VT (Scalar VDC DFloat "nou2_0"),Vec VT (Scalar VDC DFloat "diu2_0"),Vec VT (Scalar VDC DFloat "nou3_0"),Vec VT (Scalar VDC DFloat "diu3_0"),Vec VT (Scalar VDC DFloat "nou4_0"),Vec VT (Scalar VDC DFloat "diu4_0"),Vec VT (Scalar VDC DFloat "nou6_0"),Vec VT (Scalar VDC DFloat "diu6_0")]) ) )
        -- velfg_map_133
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "u_s_1" )) , Stencil (SVec 2 (Scalar VDC DInt "s4")) (Vec VI (Scalar VDC DFloat "u_0")))
       ,(Vec VS (SVec 3 (Scalar VDC DFloat "w_s_1" )) , Stencil (SVec 3 (Scalar VDC DInt "s5")) (Vec VI (Scalar VDC DFloat "w_0")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "v_s_1" )) , Stencil (SVec 2 (Scalar VDC DInt "s6")) (Vec VI (Scalar VDC DFloat "v_0")))
       ,( (Tuple [Vec VT (Scalar VDC DFloat "cov7_1"),Vec VT (Scalar VDC DFloat "cov8_1"),Vec VT (Scalar VDC DFloat "diu7_1"),Vec VT (Scalar VDC DFloat "diu8_1"),Vec VT (Scalar VDC DFloat "nou7_1"),Vec VT (Scalar VDC DFloat "nou8_1")]), UnzipT ( Map (Function "velfg_map_133"  [SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0")]) (ZipT [Vec VS (SVec 2 (Scalar VDC DFloat "u_s_1")),Vec VS (SVec 3 (Scalar VDC DFloat "w_s_1")),Vec VT (Scalar VDC DFloat "nou7_0"),Vec VT (Scalar VDC DFloat "diu7_0"),Vec VS (SVec 2 (Scalar VDC DFloat "v_s_1")),Vec VT (Scalar VDC DFloat "nou8_0"),Vec VT (Scalar VDC DFloat "diu8_0"),Vec VT (Scalar VDC DFloat "cov7_0"),Vec VT (Scalar VDC DFloat "cov8_0")]) ) )
        -- velfg_map_218
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov8_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s7")) (Vec VT (Scalar VDC DFloat "cov8_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov7_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s8")) (Vec VT (Scalar VDC DFloat "cov7_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu3_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s9")) (Vec VT (Scalar VDC DFloat "diu3_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu5_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s10")) (Vec VT (Scalar VDC DFloat "diu5_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu4_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s11")) (Vec VT (Scalar VDC DFloat "diu4_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov6_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s12")) (Vec VT (Scalar VDC DFloat "cov6_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov1_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s13")) (Vec VT (Scalar VDC DFloat "cov1_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov9_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s14")) (Vec VT (Scalar VDC DFloat "cov9_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu2_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s15")) (Vec VT (Scalar VDC DFloat "diu2_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov5_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s16")) (Vec VT (Scalar VDC DFloat "cov5_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov3_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s17")) (Vec VT (Scalar VDC DFloat "cov3_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu7_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s18")) (Vec VT (Scalar VDC DFloat "diu7_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu8_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s19")) (Vec VT (Scalar VDC DFloat "diu8_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov2_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s20")) (Vec VT (Scalar VDC DFloat "cov2_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu9_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s21")) (Vec VT (Scalar VDC DFloat "diu9_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu1_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s22")) (Vec VT (Scalar VDC DFloat "diu1_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu6_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s23")) (Vec VT (Scalar VDC DFloat "diu6_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "cov4_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s24")) (Vec VT (Scalar VDC DFloat "cov4_1")))
       ,( (Tuple [Vec VT (Scalar VDC DFloat "dfu1_1"),Vec VT (Scalar VDC DFloat "dfv1_1"),Vec VT (Scalar VDC DFloat "dfw1_1"),Vec VT (Scalar VDC DFloat "f_1"),Vec VT (Scalar VDC DFloat "g_1"),Vec VT (Scalar VDC DFloat "h_1")]), UnzipT ( Map (Function "velfg_map_218"  [SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")]) (ZipT [Vec VS (SVec 2 (Scalar VDC DFloat "cov1_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov2_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov3_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu1_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu2_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu3_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov4_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov5_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov6_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu4_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu5_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu6_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov7_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov8_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "cov9_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu7_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu8_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu9_s_0"))]) ) )
        -- les_map_87
       ,(Vec VS (SVec 4 (Scalar VDC DFloat "diu3_s_1" )) , Stencil (SVec 4 (Scalar VDC DInt "s25")) (Vec VT (Scalar VDC DFloat "diu3_1")))
       ,(Vec VS (SVec 4 (Scalar VDC DFloat "diu7_s_1" )) , Stencil (SVec 4 (Scalar VDC DInt "s26")) (Vec VT (Scalar VDC DFloat "diu7_1")))
       ,(Vec VS (SVec 4 (Scalar VDC DFloat "diu8_s_1" )) , Stencil (SVec 4 (Scalar VDC DInt "s27")) (Vec VT (Scalar VDC DFloat "diu8_1")))
       ,(Vec VS (SVec 4 (Scalar VDC DFloat "diu4_s_1" )) , Stencil (SVec 4 (Scalar VDC DInt "s28")) (Vec VT (Scalar VDC DFloat "diu4_1")))
       ,(Vec VS (SVec 4 (Scalar VDC DFloat "diu6_s_1" )) , Stencil (SVec 4 (Scalar VDC DInt "s29")) (Vec VT (Scalar VDC DFloat "diu6_1")))
       ,(Vec VS (SVec 4 (Scalar VDC DFloat "diu2_s_1" )) , Stencil (SVec 4 (Scalar VDC DInt "s30")) (Vec VT (Scalar VDC DFloat "diu2_1")))
       ,( Vec VT (Scalar VDC DFloat "sm_1"), Map (Function "les_map_87"  [SVec 90 (Scalar VDC DFloat "delx1_0")]) (ZipT [Vec VT (Scalar VDC DFloat "diu1_1"),Vec VS (SVec 4 (Scalar VDC DFloat "diu2_s_1")),Vec VS (SVec 4 (Scalar VDC DFloat "diu3_s_1")),Vec VS (SVec 4 (Scalar VDC DFloat "diu4_s_1")),Vec VT (Scalar VDC DFloat "diu5_1"),Vec VS (SVec 4 (Scalar VDC DFloat "diu6_s_1")),Vec VS (SVec 4 (Scalar VDC DFloat "diu7_s_1")),Vec VS (SVec 4 (Scalar VDC DFloat "diu8_s_1")),Vec VT (Scalar VDC DFloat "diu9_1")]) )
        -- les_map_107
       ,(Vec VS (SVec 3 (Scalar VDC DFloat "diu3_s_2" )) , Stencil (SVec 3 (Scalar VDC DInt "s31")) (Vec VT (Scalar VDC DFloat "diu3_1")))
       ,(Vec VS (SVec 3 (Scalar VDC DFloat "diu7_s_2" )) , Stencil (SVec 3 (Scalar VDC DInt "s32")) (Vec VT (Scalar VDC DFloat "diu7_1")))
       ,(Vec VS (SVec 3 (Scalar VDC DFloat "diu8_s_2" )) , Stencil (SVec 3 (Scalar VDC DInt "s33")) (Vec VT (Scalar VDC DFloat "diu8_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu5_s_1" )) , Stencil (SVec 2 (Scalar VDC DInt "s34")) (Vec VT (Scalar VDC DFloat "diu5_1")))
       ,(Vec VS (SVec 15 (Scalar VDC DFloat "sm_s_0" )) , Stencil (SVec 15 (Scalar VDC DInt "s35")) (Vec VT (Scalar VDC DFloat "sm_1")))
       ,(Vec VS (SVec 3 (Scalar VDC DFloat "diu6_s_2" )) , Stencil (SVec 3 (Scalar VDC DInt "s36")) (Vec VT (Scalar VDC DFloat "diu6_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu1_s_1" )) , Stencil (SVec 2 (Scalar VDC DInt "s37")) (Vec VT (Scalar VDC DFloat "diu1_1")))
       ,(Vec VS (SVec 3 (Scalar VDC DFloat "diu2_s_2" )) , Stencil (SVec 3 (Scalar VDC DInt "s38")) (Vec VT (Scalar VDC DFloat "diu2_1")))
       ,(Vec VS (SVec 2 (Scalar VDC DFloat "diu9_s_1" )) , Stencil (SVec 2 (Scalar VDC DInt "s39")) (Vec VT (Scalar VDC DFloat "diu9_1")))
       ,(Vec VS (SVec 3 (Scalar VDC DFloat "diu4_s_2" )) , Stencil (SVec 3 (Scalar VDC DInt "s40")) (Vec VT (Scalar VDC DFloat "diu4_1")))
       ,( (Tuple [Vec VO (Scalar VDC DFloat "f_2"),Vec VO (Scalar VDC DFloat "g_2"),Vec VO (Scalar VDC DFloat "h_2")]), UnzipT ( Map (Function "les_map_107"  [SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 94 (Scalar VDC DFloat "dzn_0")]) (ZipT [Vec VS (SVec 15 (Scalar VDC DFloat "sm_s_0")),Vec VS (SVec 2 (Scalar VDC DFloat "diu1_s_1")),Vec VS (SVec 3 (Scalar VDC DFloat "diu2_s_2")),Vec VS (SVec 3 (Scalar VDC DFloat "diu4_s_2")),Vec VS (SVec 3 (Scalar VDC DFloat "diu3_s_2")),Vec VS (SVec 3 (Scalar VDC DFloat "diu7_s_2")),Vec VT (Scalar VDC DFloat "f_1"),Vec VS (SVec 2 (Scalar VDC DFloat "diu5_s_1")),Vec VS (SVec 3 (Scalar VDC DFloat "diu6_s_2")),Vec VS (SVec 3 (Scalar VDC DFloat "diu8_s_2")),Vec VT (Scalar VDC DFloat "g_1"),Vec VS (SVec 2 (Scalar VDC DFloat "diu9_s_1")),Vec VT (Scalar VDC DFloat "h_1")]) ) )
        ]

functionSignaturesList = [
        ("les_map_107",  [Tuple [SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 94 (Scalar VDC DFloat "dzn_0")],Tuple [SVec 15 (Scalar VDC DFloat "sm_s_0"),SVec 2 (Scalar VDC DFloat "diu1_s_1"),SVec 3 (Scalar VDC DFloat "diu2_s_2"),SVec 3 (Scalar VDC DFloat "diu4_s_2"),SVec 3 (Scalar VDC DFloat "diu3_s_2"),SVec 3 (Scalar VDC DFloat "diu7_s_2"),Scalar VT DFloat "f_1",SVec 2 (Scalar VDC DFloat "diu5_s_1"),SVec 3 (Scalar VDC DFloat "diu6_s_2"),SVec 3 (Scalar VDC DFloat "diu8_s_2"),Scalar VT DFloat "g_1",SVec 2 (Scalar VDC DFloat "diu9_s_1"),Scalar VT DFloat "h_1"],Tuple [Scalar VO DFloat "f_2",Scalar VO DFloat "g_2",Scalar VO DFloat "h_2"]]),
        ("les_map_87",  [SVec 90 (Scalar VDC DFloat "delx1_0"),Tuple [Scalar VT DFloat "diu1_1",SVec 4 (Scalar VDC DFloat "diu2_s_1"),SVec 4 (Scalar VDC DFloat "diu3_s_1"),SVec 4 (Scalar VDC DFloat "diu4_s_1"),Scalar VT DFloat "diu5_1",SVec 4 (Scalar VDC DFloat "diu6_s_1"),SVec 4 (Scalar VDC DFloat "diu7_s_1"),SVec 4 (Scalar VDC DFloat "diu8_s_1"),Scalar VT DFloat "diu9_1"],Scalar VT DFloat "sm_1"]),
        ("velfg_map_133",  [Tuple [SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0")],Tuple [SVec 2 (Scalar VDC DFloat "u_s_1"),SVec 3 (Scalar VDC DFloat "w_s_1"),Scalar VT DFloat "nou7_0",Scalar VT DFloat "diu7_0",SVec 2 (Scalar VDC DFloat "v_s_1"),Scalar VT DFloat "nou8_0",Scalar VT DFloat "diu8_0",Scalar VT DFloat "cov7_0",Scalar VT DFloat "cov8_0"],Tuple [Scalar VT DFloat "cov7_1",Scalar VT DFloat "cov8_1",Scalar VT DFloat "diu7_1",Scalar VT DFloat "diu8_1",Scalar VT DFloat "nou7_1",Scalar VT DFloat "nou8_1"]]),
        ("velfg_map_218",  [Tuple [SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")],Tuple [SVec 2 (Scalar VDC DFloat "cov1_s_0"),SVec 2 (Scalar VDC DFloat "cov2_s_0"),SVec 2 (Scalar VDC DFloat "cov3_s_0"),SVec 2 (Scalar VDC DFloat "diu1_s_0"),SVec 2 (Scalar VDC DFloat "diu2_s_0"),SVec 2 (Scalar VDC DFloat "diu3_s_0"),SVec 2 (Scalar VDC DFloat "cov4_s_0"),SVec 2 (Scalar VDC DFloat "cov5_s_0"),SVec 2 (Scalar VDC DFloat "cov6_s_0"),SVec 2 (Scalar VDC DFloat "diu4_s_0"),SVec 2 (Scalar VDC DFloat "diu5_s_0"),SVec 2 (Scalar VDC DFloat "diu6_s_0"),SVec 2 (Scalar VDC DFloat "cov7_s_0"),SVec 2 (Scalar VDC DFloat "cov8_s_0"),SVec 2 (Scalar VDC DFloat "cov9_s_0"),SVec 2 (Scalar VDC DFloat "diu7_s_0"),SVec 2 (Scalar VDC DFloat "diu8_s_0"),SVec 2 (Scalar VDC DFloat "diu9_s_0")],Tuple [Scalar VT DFloat "dfu1_1",Scalar VT DFloat "dfv1_1",Scalar VT DFloat "dfw1_1",Scalar VT DFloat "f_1",Scalar VT DFloat "g_1",Scalar VT DFloat "h_1"]]),
        ("velfg_map_76",  [Tuple [SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")],Tuple [SVec 5 (Scalar VDC DFloat "u_s_0"),SVec 5 (Scalar VDC DFloat "v_s_0"),SVec 4 (Scalar VDC DFloat "w_s_0"),Scalar VT DFloat "diu1_0",Scalar VT DFloat "nou5_0",Scalar VT DFloat "diu5_0",Scalar VT DFloat "nou9_0",Scalar VT DFloat "diu9_0",Scalar VT DFloat "nou2_0",Scalar VT DFloat "diu2_0",Scalar VT DFloat "nou3_0",Scalar VT DFloat "diu3_0",Scalar VT DFloat "nou4_0",Scalar VT DFloat "diu4_0",Scalar VT DFloat "nou6_0",Scalar VT DFloat "diu6_0"],Tuple [Scalar VT DFloat "cov1_1",Scalar VT DFloat "cov2_1",Scalar VT DFloat "cov3_1",Scalar VT DFloat "cov4_1",Scalar VT DFloat "cov5_1",Scalar VT DFloat "cov6_1",Scalar VT DFloat "cov9_1",Scalar VT DFloat "diu1_1",Scalar VT DFloat "diu2_1",Scalar VT DFloat "diu3_1",Scalar VT DFloat "diu4_1",Scalar VT DFloat "diu5_1",Scalar VT DFloat "diu6_1",Scalar VT DFloat "diu9_1",Scalar VT DFloat "nou1_1",Scalar VT DFloat "nou2_1",Scalar VT DFloat "nou3_1",Scalar VT DFloat "nou4_1",Scalar VT DFloat "nou5_1",Scalar VT DFloat "nou6_1",Scalar VT DFloat "nou9_1"]])
    ]
stencilDefinitionsList = [("s1" , [23561,23562,23713,46817] ), ("s2" , [305,23409,23410,23560,23561] ), ("s3" , [305,23409,23560,23561,23712] ), ("s4" , [23560,46816] ), ("s5" , [46665,46816,46817] ), ("s6" , [23409,46665] ), ("s7" , [23563,23716] ), ("s8" , [23563,23564] ), ("s9" , [23563,46972] ), ("s10" , [23718,23872] ), ("s11" , [23563,23564] ), ("s12" , [23563,46972] ), ("s13" , [23718,23719] ), ("s14" , [23563,46972] ), ("s15" , [23563,23716] ), ("s16" , [23718,23872] ), ("s17" , [23563,46972] ), ("s18" , [23563,23564] ), ("s19" , [23563,23716] ), ("s20" , [23563,23716] ), ("s21" , [23563,46972] ), ("s22" , [23718,23719] ), ("s23" , [23563,46972] ), ("s24" , [23563,23564] ), ("s25" , [23562,23563,46971,46972] ), ("s26" , [154,155,23563,23564] ), ("s27" , [154,307,23563,23716] ), ("s28" , [23410,23411,23563,23564] ), ("s29" , [23410,23563,46819,46972] ), ("s30" , [23562,23563,23715,23716] ), ("s31" , [23563,46971,46972] ), ("s32" , [155,23563,23564] ), ("s33" , [307,23563,23716] ), ("s34" , [23718,23872] ), ("s35" , [308,309,23564,23565,23716,23717,23718,23869,23870,23871,46973,47125,47126,47127,47279] ), ("s36" , [23563,46819,46972] ), ("s37" , [23718,23719] ), ("s38" , [23563,23715,23716] ), ("s39" , [23563,46972] ), ("s40" , [23411,23563,23564] )]

mainArgDeclsList = [
      ("w_0" , MkFDecl "real"  (Just [2162808]) (Just In) ["w_0"] )
    , ("dx1_0" , MkFDecl "real"  (Just [153]) (Just In) ["dx1_0"] )
    , ("u_0" , MkFDecl "real"  (Just [2139552]) (Just In) ["u_0"] )
    , ("dzs_0" , MkFDecl "real"  (Just [94]) (Just In) ["dzs_0"] )
    , ("dzn_0" , MkFDecl "real"  (Just [94]) (Just In) ["dzn_0"] )
    , ("v_0" , MkFDecl "real"  (Just [2139552]) (Just In) ["v_0"] )
    , ("dy1_0" , MkFDecl "real"  (Just [152]) (Just In) ["dy1_0"] )
    , ("g_2" , MkFDecl "real"  (Just [2074891]) (Just Out) ["g_2"] )
    , ("f_2" , MkFDecl "real"  (Just [2074891]) (Just Out) ["f_2"] )
    , ("h_2" , MkFDecl "real"  (Just [2074891]) (Just Out) ["h_2"] )
  ]

scalarisedArgsList = [
     ( "les_map_107",[("sm",(1,In,"real")), ("sm",(2,In,"real")), ("sm",(3,In,"real")), ("sm",(4,In,"real")), ("sm",(5,In,"real")), ("sm",(6,In,"real")), ("sm",(7,In,"real")), ("sm",(8,In,"real")), ("sm",(9,In,"real")), ("sm",(10,In,"real")), ("sm",(11,In,"real")), ("sm",(12,In,"real")), ("sm",(13,In,"real")), ("sm",(14,In,"real")), ("sm",(15,In,"real")), ("dy1",(0,In,"real")), ("dx1",(0,In,"real")), ("dzn",(0,In,"real")), ("diu1",(1,In,"real")), ("diu1",(2,In,"real")), ("diu2",(1,In,"real")), ("diu2",(2,In,"real")), ("diu2",(3,In,"real")), ("diu4",(1,In,"real")), ("diu4",(2,In,"real")), ("diu4",(3,In,"real")), ("diu3",(1,In,"real")), ("diu3",(2,In,"real")), ("diu3",(3,In,"real")), ("diu7",(1,In,"real")), ("diu7",(2,In,"real")), ("diu7",(3,In,"real")), ("f",(0,InOut,"real")), ("diu5",(1,In,"real")), ("diu5",(2,In,"real")), ("diu6",(1,In,"real")), ("diu6",(2,In,"real")), ("diu6",(3,In,"real")), ("diu8",(1,In,"real")), ("diu8",(2,In,"real")), ("diu8",(3,In,"real")), ("g",(0,InOut,"real")), ("diu9",(1,In,"real")), ("diu9",(2,In,"real")), ("h",(0,InOut,"real"))])
    ,( "les_map_87",[("diu1",(0,In,"real")), ("diu2",(1,In,"real")), ("diu2",(2,In,"real")), ("diu2",(3,In,"real")), ("diu2",(4,In,"real")), ("diu3",(1,In,"real")), ("diu3",(2,In,"real")), ("diu3",(3,In,"real")), ("diu3",(4,In,"real")), ("diu4",(1,In,"real")), ("diu4",(2,In,"real")), ("diu4",(3,In,"real")), ("diu4",(4,In,"real")), ("diu5",(0,In,"real")), ("diu6",(1,In,"real")), ("diu6",(2,In,"real")), ("diu6",(3,In,"real")), ("diu6",(4,In,"real")), ("diu7",(1,In,"real")), ("diu7",(2,In,"real")), ("diu7",(3,In,"real")), ("diu7",(4,In,"real")), ("diu8",(1,In,"real")), ("diu8",(2,In,"real")), ("diu8",(3,In,"real")), ("diu8",(4,In,"real")), ("diu9",(0,In,"real")), ("delx1",(0,In,"real")), ("sm",(0,Out,"real"))])
    ,( "velfg_map_133",[("dzn",(0,In,"real")), ("u",(1,In,"real")), ("u",(2,In,"real")), ("w",(1,In,"real")), ("w",(2,In,"real")), ("w",(3,In,"real")), ("dx1",(0,In,"real")), ("nou7",(0,InOut,"real")), ("diu7",(0,InOut,"real")), ("v",(1,In,"real")), ("v",(2,In,"real")), ("dy1",(0,In,"real")), ("nou8",(0,InOut,"real")), ("diu8",(0,InOut,"real")), ("cov7",(0,Out,"real")), ("cov8",(0,Out,"real"))])
    ,( "velfg_map_218",[("dx1",(0,In,"real")), ("cov1",(1,In,"real")), ("cov1",(2,In,"real")), ("cov2",(1,In,"real")), ("cov2",(2,In,"real")), ("cov3",(1,In,"real")), ("cov3",(2,In,"real")), ("diu1",(1,In,"real")), ("diu1",(2,In,"real")), ("diu2",(1,In,"real")), ("diu2",(2,In,"real")), ("dy1",(0,In,"real")), ("diu3",(1,In,"real")), ("diu3",(2,In,"real")), ("dzn",(0,In,"real")), ("dfu1",(0,InOut,"real")), ("cov4",(1,In,"real")), ("cov4",(2,In,"real")), ("cov5",(1,In,"real")), ("cov5",(2,In,"real")), ("cov6",(1,In,"real")), ("cov6",(2,In,"real")), ("diu4",(1,In,"real")), ("diu4",(2,In,"real")), ("diu5",(1,In,"real")), ("diu5",(2,In,"real")), ("diu6",(1,In,"real")), ("diu6",(2,In,"real")), ("dfv1",(0,InOut,"real")), ("cov7",(1,In,"real")), ("cov7",(2,In,"real")), ("cov8",(1,In,"real")), ("cov8",(2,In,"real")), ("cov9",(1,In,"real")), ("cov9",(2,In,"real")), ("diu7",(1,In,"real")), ("diu7",(2,In,"real")), ("diu8",(1,In,"real")), ("diu8",(2,In,"real")), ("diu9",(1,In,"real")), ("diu9",(2,In,"real")), ("dzs",(0,In,"real")), ("dfw1",(0,InOut,"real")), ("f",(0,Out,"real")), ("g",(0,Out,"real")), ("h",(0,Out,"real"))])
    ,( "velfg_map_76",[("u",(1,In,"real")), ("u",(2,In,"real")), ("u",(3,In,"real")), ("u",(4,In,"real")), ("u",(5,In,"real")), ("dx1",(0,In,"real")), ("v",(1,In,"real")), ("v",(2,In,"real")), ("v",(3,In,"real")), ("v",(4,In,"real")), ("v",(5,In,"real")), ("dy1",(0,In,"real")), ("w",(1,In,"real")), ("w",(2,In,"real")), ("w",(3,In,"real")), ("w",(4,In,"real")), ("dzn",(0,In,"real")), ("nou1",(0,InOut,"real")), ("diu1",(0,InOut,"real")), ("nou5",(0,InOut,"real")), ("diu5",(0,InOut,"real")), ("nou9",(0,InOut,"real")), ("diu9",(0,InOut,"real")), ("nou2",(0,InOut,"real")), ("diu2",(0,InOut,"real")), ("dzs",(0,In,"real")), ("nou3",(0,InOut,"real")), ("diu3",(0,InOut,"real")), ("nou4",(0,InOut,"real")), ("diu4",(0,InOut,"real")), ("nou6",(0,InOut,"real")), ("diu6",(0,InOut,"real")), ("cov1",(0,Out,"real")), ("cov5",(0,Out,"real")), ("cov9",(0,Out,"real")), ("cov2",(0,Out,"real")), ("cov3",(0,Out,"real")), ("cov4",(0,Out,"real")), ("cov6",(0,Out,"real"))])
  ]

origNamesList = [
     ( "velfg_map_76",[("dx1",[("dx1_0",In)]), ("dy1",[("dy1_0",In)]), ("dzn",[("dzn_0",In)]), ("dzs",[("dzs_0",In)]), ("u",[("u_s_0",In)]), ("v",[("v_s_0",In)]), ("w",[("w_s_0",In)]), ("diu1",[("diu1_0",In),("diu1_1",Out)]), ("nou5",[("nou5_0",In),("nou5_1",Out)]), ("diu5",[("diu5_0",In),("diu5_1",Out)]), ("nou9",[("nou9_0",In),("nou9_1",Out)]), ("diu9",[("diu9_0",In),("diu9_1",Out)]), ("nou2",[("nou2_0",In),("nou2_1",Out)]), ("diu2",[("diu2_0",In),("diu2_1",Out)]), ("nou3",[("nou3_0",In),("nou3_1",Out)]), ("diu3",[("diu3_0",In),("diu3_1",Out)]), ("nou4",[("nou4_0",In),("nou4_1",Out)]), ("diu4",[("diu4_0",In),("diu4_1",Out)]), ("nou6",[("nou6_0",In),("nou6_1",Out)]), ("diu6",[("diu6_0",In),("diu6_1",Out)]), ("cov1",[("cov1_1",Out)]), ("cov2",[("cov2_1",Out)]), ("cov3",[("cov3_1",Out)]), ("cov4",[("cov4_1",Out)]), ("cov5",[("cov5_1",Out)]), ("cov6",[("cov6_1",Out)]), ("cov9",[("cov9_1",Out)]), ("nou1",[("nou1_1",Out)])])
    ,( "velfg_map_133",[("dzn",[("dzn_0",In)]), ("dx1",[("dx1_0",In)]), ("dy1",[("dy1_0",In)]), ("u",[("u_s_1",In)]), ("w",[("w_s_1",In)]), ("nou7",[("nou7_0",In),("nou7_1",Out)]), ("diu7",[("diu7_0",In),("diu7_1",Out)]), ("v",[("v_s_1",In)]), ("nou8",[("nou8_0",In),("nou8_1",Out)]), ("diu8",[("diu8_0",In),("diu8_1",Out)]), ("cov7",[("cov7_0",In),("cov7_1",Out)]), ("cov8",[("cov8_0",In),("cov8_1",Out)])])
    ,( "velfg_map_218",[("dx1",[("dx1_0",In)]), ("dy1",[("dy1_0",In)]), ("dzn",[("dzn_0",In)]), ("dzs",[("dzs_0",In)]), ("cov1",[("cov1_s_0",In)]), ("cov2",[("cov2_s_0",In)]), ("cov3",[("cov3_s_0",In)]), ("diu1",[("diu1_s_0",In)]), ("diu2",[("diu2_s_0",In)]), ("diu3",[("diu3_s_0",In)]), ("cov4",[("cov4_s_0",In)]), ("cov5",[("cov5_s_0",In)]), ("cov6",[("cov6_s_0",In)]), ("diu4",[("diu4_s_0",In)]), ("diu5",[("diu5_s_0",In)]), ("diu6",[("diu6_s_0",In)]), ("cov7",[("cov7_s_0",In)]), ("cov8",[("cov8_s_0",In)]), ("cov9",[("cov9_s_0",In)]), ("diu7",[("diu7_s_0",In)]), ("diu8",[("diu8_s_0",In)]), ("diu9",[("diu9_s_0",In)]), ("dfu1",[("dfu1_1",Out)]), ("dfv1",[("dfv1_1",Out)]), ("dfw1",[("dfw1_1",Out)]), ("f",[("f_1",Out)]), ("g",[("g_1",Out)]), ("h",[("h_1",Out)])])
    ,( "les_map_87",[("delx1",[("delx1_0",In)]), ("diu1",[("diu1_1",In)]), ("diu2",[("diu2_s_1",In)]), ("diu3",[("diu3_s_1",In)]), ("diu4",[("diu4_s_1",In)]), ("diu5",[("diu5_1",In)]), ("diu6",[("diu6_s_1",In)]), ("diu7",[("diu7_s_1",In)]), ("diu8",[("diu8_s_1",In)]), ("diu9",[("diu9_1",In)]), ("sm",[("sm_1",Out)])])
    ,( "les_map_107",[("dy1",[("dy1_0",In)]), ("dx1",[("dx1_0",In)]), ("dzn",[("dzn_0",In)]), ("sm",[("sm_s_0",In)]), ("diu1",[("diu1_s_1",In)]), ("diu2",[("diu2_s_2",In)]), ("diu4",[("diu4_s_2",In)]), ("diu3",[("diu3_s_2",In)]), ("diu7",[("diu7_s_2",In)]), ("f",[("f_1",In),("f_2",Out)]), ("diu5",[("diu5_s_1",In)]), ("diu6",[("diu6_s_2",In)]), ("diu8",[("diu8_s_2",In)]), ("g",[("g_1",In),("g_2",Out)]), ("diu9",[("diu9_s_1",In)]), ("h",[("h_1",In),("h_2",Out)])])
  ]

{-
w_0 :: Vec 2162808 Float
v_0 :: Vec 2139552 Float
u_0 :: Vec 2139552 Float
dx1_0 :: SVec 153 Float
dy1_0 :: SVec 152 Float
dzn_0 :: SVec 94 Float
dzs_0 :: SVec 94 Float

f_2 :: Vec 2074891 Float
g_2 :: Vec 2074891 Float
h_2 :: Vec 2074891 Float

velfg_map_76 :: (Float,Float,Float,Float) -> (SVec 5 Float,SVec 5 Float,SVec 4 Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float) -> (Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float,Float)
velfg_map_218 :: (Float,Float,Float,Float) -> (SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float,SVec 2 Float) -> (Float,Float,Float,Float,Float,Float)
velfg_map_133 :: (Float,Float,Float) -> (SVec 2 Float,SVec 3 Float,Float,Float,SVec 2 Float,Float,Float,Float,Float) -> (Float,Float,Float,Float,Float,Float)
les_map_87 :: Float -> (Float,SVec 4 Float,SVec 4 Float,SVec 4 Float,Float,SVec 4 Float,SVec 4 Float,SVec 4 Float,Float) -> Float
les_map_107 :: (Float,Float,Float) -> (SVec 15 Float,SVec 2 Float,SVec 3 Float,SVec 3 Float,SVec 3 Float,SVec 3 Float,Float,SVec 2 Float,SVec 3 Float,SVec 3 Float,Float,SVec 2 Float,Float) -> (Float,Float,Float)

main :: (Vec 2162808 Float,Vec 2139552 Float,Vec 2139552 Float,SVec 153 Float,SVec 152 Float,SVec 94 Float,SVec 94 Float) -> (Vec 2074891 Float,Vec 2074891 Float,Vec 2074891 Float)
main (w_0,v_0,u_0,dx1_0,dy1_0,dzn_0,dzs_0) =
  let
     -- velfg_map_76
    s1 = [23561,23562,23713,46817]
    w_s_0 = stencil s1 w_0
    s2 = [305,23409,23410,23560,23561]
    v_s_0 = stencil s2 v_0
    s3 = [305,23409,23560,23561,23712]
    u_s_0 = stencil s3 u_0
    (cov1_1,cov2_1,cov3_1,cov4_1,cov5_1,cov6_1,cov9_1,diu1_1,diu2_1,diu3_1,diu4_1,diu5_1,diu6_1,diu9_1,nou1_1,nou2_1,nou3_1,nou4_1,nou5_1,nou6_1,nou9_1) = unzipt $ map (velfg_map_76 (dx1_0,dy1_0,dzn_0,dzs_0)) (zipt (u_s_0,v_s_0,w_s_0,diu1_0,nou5_0,diu5_0,nou9_0,diu9_0,nou2_0,diu2_0,nou3_0,diu3_0,nou4_0,diu4_0,nou6_0,diu6_0))
     -- velfg_map_133
    s4 = [23560,46816]
    u_s_1 = stencil s4 u_0
    s5 = [46665,46816,46817]
    w_s_1 = stencil s5 w_0
    s6 = [23409,46665]
    v_s_1 = stencil s6 v_0
    (cov7_1,cov8_1,diu7_1,diu8_1,nou7_1,nou8_1) = unzipt $ map (velfg_map_133 (dzn_0,dx1_0,dy1_0)) (zipt (u_s_1,w_s_1,nou7_0,diu7_0,v_s_1,nou8_0,diu8_0,cov7_0,cov8_0))
     -- velfg_map_218
    s7 = [23563,23716]
    cov8_s_0 = stencil s7 cov8_1
    s8 = [23563,23564]
    cov7_s_0 = stencil s8 cov7_1
    s9 = [23563,46972]
    diu3_s_0 = stencil s9 diu3_1
    s10 = [23718,23872]
    diu5_s_0 = stencil s10 diu5_1
    s11 = [23563,23564]
    diu4_s_0 = stencil s11 diu4_1
    s12 = [23563,46972]
    cov6_s_0 = stencil s12 cov6_1
    s13 = [23718,23719]
    cov1_s_0 = stencil s13 cov1_1
    s14 = [23563,46972]
    cov9_s_0 = stencil s14 cov9_1
    s15 = [23563,23716]
    diu2_s_0 = stencil s15 diu2_1
    s16 = [23718,23872]
    cov5_s_0 = stencil s16 cov5_1
    s17 = [23563,46972]
    cov3_s_0 = stencil s17 cov3_1
    s18 = [23563,23564]
    diu7_s_0 = stencil s18 diu7_1
    s19 = [23563,23716]
    diu8_s_0 = stencil s19 diu8_1
    s20 = [23563,23716]
    cov2_s_0 = stencil s20 cov2_1
    s21 = [23563,46972]
    diu9_s_0 = stencil s21 diu9_1
    s22 = [23718,23719]
    diu1_s_0 = stencil s22 diu1_1
    s23 = [23563,46972]
    diu6_s_0 = stencil s23 diu6_1
    s24 = [23563,23564]
    cov4_s_0 = stencil s24 cov4_1
    (dfu1_1,dfv1_1,dfw1_1,f_1,g_1,h_1) = unzipt $ map (velfg_map_218 (dx1_0,dy1_0,dzn_0,dzs_0)) (zipt (cov1_s_0,cov2_s_0,cov3_s_0,diu1_s_0,diu2_s_0,diu3_s_0,cov4_s_0,cov5_s_0,cov6_s_0,diu4_s_0,diu5_s_0,diu6_s_0,cov7_s_0,cov8_s_0,cov9_s_0,diu7_s_0,diu8_s_0,diu9_s_0))
     -- les_map_87
    s25 = [23562,23563,46971,46972]
    diu3_s_1 = stencil s25 diu3_1
    s26 = [154,155,23563,23564]
    diu7_s_1 = stencil s26 diu7_1
    s27 = [154,307,23563,23716]
    diu8_s_1 = stencil s27 diu8_1
    s28 = [23410,23411,23563,23564]
    diu4_s_1 = stencil s28 diu4_1
    s29 = [23410,23563,46819,46972]
    diu6_s_1 = stencil s29 diu6_1
    s30 = [23562,23563,23715,23716]
    diu2_s_1 = stencil s30 diu2_1
    sm_1 =  map (les_map_87 delx1_0) (zipt (diu1_1,diu2_s_1,diu3_s_1,diu4_s_1,diu5_1,diu6_s_1,diu7_s_1,diu8_s_1,diu9_1))
     -- les_map_107
    s31 = [23563,46971,46972]
    diu3_s_2 = stencil s31 diu3_1
    s32 = [155,23563,23564]
    diu7_s_2 = stencil s32 diu7_1
    s33 = [307,23563,23716]
    diu8_s_2 = stencil s33 diu8_1
    s34 = [23718,23872]
    diu5_s_1 = stencil s34 diu5_1
    s35 = [308,309,23564,23565,23716,23717,23718,23869,23870,23871,46973,47125,47126,47127,47279]
    sm_s_0 = stencil s35 sm_1
    s36 = [23563,46819,46972]
    diu6_s_2 = stencil s36 diu6_1
    s37 = [23718,23719]
    diu1_s_1 = stencil s37 diu1_1
    s38 = [23563,23715,23716]
    diu2_s_2 = stencil s38 diu2_1
    s39 = [23563,46972]
    diu9_s_1 = stencil s39 diu9_1
    s40 = [23411,23563,23564]
    diu4_s_2 = stencil s40 diu4_1
    (f_2,g_2,h_2) = unzipt $ map (les_map_107 (dy1_0,dx1_0,dzn_0)) (zipt (sm_s_0,diu1_s_1,diu2_s_2,diu4_s_2,diu3_s_2,diu7_s_2,f_1,diu5_s_1,diu6_s_2,diu8_s_2,g_1,diu9_s_1,h_1))
  in
    (f_2,g_2,h_2)
-}

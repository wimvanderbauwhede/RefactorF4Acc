module ASTInstance ( ast, functionSignaturesList, stencilDefinitionsList ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
         -- shapiro_map_16
        (Vec VS (DSVec 2 DInt) "wet_s_0" , Stencil (SVec 2 DInt "s1") (Vec VI DInt "wet_0"))
        ,(Vec VS (DSVec 2 DFloat) "etan_s_0" , Stencil (SVec 2 DInt "s2") (Vec VI DFloat "etan_0"))
        ,( Vec VO DFloat "eta_1", Map (Function "shapiro_map_16"  [Scalar VI DFloat  "eps_0"]) (ZipT [Vec VS (DSVec 5 DInt) "wet_s_0",Vec VS (DSVec 5 DFloat) "etan_s_0"]) )
         -- dyn_map_39
        ,(Vec VS (DSVec 2 DFloat) "un_s_0" , Stencil (SVec 2 DInt "s3") (Vec VI DFloat "un_0"))
        ,(Vec VS (DSVec 2 DInt) "wet_s_1" , Stencil (SVec 2 DInt "s4") (Vec VI DInt "wet_0"))
        ,(Vec VS (DSVec 2 DFloat) "eta_s_0" , Stencil (SVec 2 DInt "s5") (Vec VO DFloat "eta_1"))
        ,(Vec VS (DSVec 2 DFloat) "vn_s_0" , Stencil (SVec 2 DInt "s6") (Vec VI DFloat "vn_0"))
        ,(Vec VS (DSVec 2 DFloat) "h_s_0" , Stencil (SVec 2 DInt "s7") (Vec VI DFloat "h_0"))
        ,( (Tuple [Vec VO DFloat "du_1",Vec VO DFloat "dv_1",Vec VO DFloat "etan_1",Vec VO DFloat "un_1",Vec VO DFloat "vn_1"]), UnzipT ( Map (Function "dyn_map_39"  [Scalar VI DFloat  "dt_0",Scalar VI DFloat  "g_0",Scalar VI DFloat  "dx_0",Scalar VI DFloat  "dy_0"]) (ZipT [Vec VS (DSVec 3 DFloat) "eta_s_0",Vec VI DFloat "u_0",Vec VS (DSVec 3 DInt) "wet_s_1",Vec VI DFloat "v_0",Vec VS (DSVec 5 DFloat) "h_s_0"]) ) )
         -- update_map_24
        ,( (Tuple [Vec VO DFloat "h_1",Vec VO DFloat "u_1",Vec VO DFloat "v_1",Vec VO DInt "wet_1"]), UnzipT ( Map (Function "update_map_24"  [Scalar VI DFloat  "hmin_0"]) (ZipT [Vec VI DFloat "hzero_0",Vec VS (DSVec 3 DFloat) "eta_s_0",Vec VS (DSVec 2 DFloat) "un_s_0",Vec VS (DSVec 2 DFloat) "vn_s_0"]) ) )
        ]

functionSignaturesList = [
        ("dyn_map_39", MapFSig (Tuple [Scalar VDC DFloat "dt_0",Scalar VDC DFloat "g_0",Scalar VDC DFloat "dx_0",Scalar VDC DFloat "dy_0"],Tuple [SVec 3 DFloat "eta_s_0",Scalar VDC DFloat "u_0",SVec 3 DInt "wet_s_1",Scalar VDC DFloat "v_0",SVec 5 DFloat "h_s_0"],Tuple [Scalar VDC DFloat "du_1",Scalar VDC DFloat "dv_1",Scalar VDC DFloat "etan_1",Scalar VDC DFloat "un_1",Scalar VDC DFloat "vn_1"])),
        ("shapiro_map_16", MapFSig (Scalar VDC DFloat "eps_0",Tuple [SVec 5 DInt "wet_s_0",SVec 5 DFloat "etan_s_0"],Scalar VDC DFloat "eta_1")),
        ("update_map_24", MapFSig (Scalar VDC DFloat "hmin_0",Tuple [Scalar VDC DFloat "hzero_0",SVec 3 DFloat "eta_s_0",SVec 2 DFloat "un_s_0",SVec 2 DFloat "vn_s_0"],Tuple [Scalar VDC DFloat "h_1",Scalar VDC DFloat "u_1",Scalar VDC DFloat "v_1",Scalar VDC DInt "wet_1"]))
    ]
stencilDefinitionsList = [("s1" , [-502,-1,0,1,502] ), ("s2" , [-502,-1,0,1,502] ), ("s3" , [-502,0] ), ("s4" , [0,1,502] ), ("s5" , [0,1,502] ), ("s6" , [-1,0] ), ("s7" , [-502,-1,0,1,502] )]
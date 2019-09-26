module ASTInstance ( ast ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
         -- shapiro_reduce_19
        ( Scalar "etan_avg_1", Fold (Function "shapiro_reduce_19") (Scalar "etan_avg_0") (Vec VI "etan_0") )
         -- shapiro_map_24
        ,(Vec VS "wet_s_0" , Stencil (SVec 2 "s1") (Vec VI "wet_0"))
        ,(Vec VS "etan_s_0" , Stencil (SVec 2 "s2") (Vec VI "etan_0"))
        ,( Vec VO "eta_1", Map (Function "shapiro_map_24 (eps_0,etan_avg_1)") (ZipT [Vec VS "wet_s_0",Vec VS "etan_s_0"]) )
         -- dyn_map_39
        ,(Vec VS "h_s_0" , Stencil (SVec 2 "s3") (Vec VI "h_0"))
        ,(Vec VS "vn_s_0" , Stencil (SVec 2 "s4") (Vec VI "vn_0"))
        ,(Vec VS "eta_s_0" , Stencil (SVec 2 "s5") (Vec VO "eta_1"))
        ,(Vec VS "wet_s_1" , Stencil (SVec 2 "s6") (Vec VI "wet_0"))
        ,(Vec VS "un_s_0" , Stencil (SVec 2 "s7") (Vec VI "un_0"))
        ,( (Tuple [Vec VO "du_1",Vec VO "dv_1",Vec VO "etan_1",Vec VO "un_1",Vec VO "vn_1"]), UnzipT ( Map (Function "dyn_map_39 (dt_0,g_0,dx_0,dy_0)") (ZipT [Vec VS "eta_s_0",Vec VI "u_0",Vec VS "wet_s_1",Vec VI "v_0",Vec VS "h_s_0"]) ) )
         -- update_map_24
        ,( (Tuple [Vec VO "h_1",Vec VO "u_1",Vec VO "v_1",Vec VO "wet_1"]), UnzipT ( Map (Function "update_map_24 (hmin_0)") (ZipT [Vec VI "hzero_0",Vec VS "eta_s_0",Vec VS "un_s_0",Vec VS "vn_s_0"]) ) )
        ]

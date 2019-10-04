module ASTInstance ( ast, functionSignaturesList ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
        ( Vec VT DInt "va_1", Map (Function "f1a" []) (Vec VI DInt "va_0") )
        ,( Vec VT DInt "vb_1", Map (Function "f1b" []) (Vec VI DInt "vb_0") )
        ,( Vec VT DInt "v_0", Map (Function "f1c" []) (ZipT [Vec VT DInt "va_1",Vec VT DInt "vb_1"]) )
        ,(Vec VS (DSVec 3 DInt) "v_s_1" , Stencil (SVec 3 DInt "s1") (Vec VT DInt "v_0"))
        ,( Vec VT DInt "v_2", Map (Function "f2" []) (Vec VS (DSVec 3 DInt) "v_s_1") )
        ,(Vec VS (DSVec 3 DInt) "v_s_2" , Stencil (SVec 3 DInt "s2") (Vec VT DInt "v_2"))
        ,( Vec VO DInt "v_3", Map (Function "f3" []) (Vec VS (DSVec 3 DInt) "v_s_2") )
        ]

functionSignaturesList = [
        ("f1a", MapFSig (Tuple [],Scalar VDC DInt "va_0",Scalar VDC DInt "va_1")),
        ("f1b", MapFSig (Tuple [],Scalar VDC DInt "vb_0",Scalar VDC DInt "vb_1")),
        ("f1c", MapFSig (Tuple [],Tuple [Scalar VDC DInt "va_1",Scalar VDC DInt "vb_1"],Scalar VDC DInt "v_0")),
        ("f2", MapFSig (Tuple [],SVec 3 DInt "v_s_1",Scalar VDC DInt "v_2")),
        ("f3", MapFSig (Tuple [],SVec 3 DInt "v_s_2",Scalar VDC DInt "v_3"))
    ]
module ASTInstance ( ast, functionSignaturesList, stencilDefinitionsList ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
        ( Vec VT DFloat "va_1", Map (Function "f1a" []) (ZipT [Vec VI DFloat "va_0",Vec VI DFloat "vc_0"]) )
        ,( Vec VT DFloat "vb_1", Map (Function "f1b" []) (Vec VI DFloat "vb_0") )
        ,( Vec VT DFloat "v_0", Map (Function "f1c" []) (ZipT [Vec VT DFloat "va_1",Vec VT DFloat "vb_1"]) )
        ,(Vec VS (DSVec 3 DFloat) "v_s_1" , Stencil (SVec 3 DInt "s1") (Vec VT DFloat "v_0"))
        ,( Vec VT DFloat "v_2", Map (Function "f2" []) (Vec VS (DSVec 3 DFloat) "v_s_1") )
        ,(Vec VS (DSVec 3 DFloat) "v_s_2" , Stencil (SVec 3 DInt "s2") (Vec VT DFloat "v_2"))
        ,( Vec VO DFloat "v_3", Map (Function "f3" []) (Vec VS (DSVec 3 DFloat) "v_s_2") )
        ]

functionSignaturesList = [
        ("f1a", MapFSig (Tuple [],Tuple [Scalar VDC DFloat "va_0",Scalar VDC DFloat "vc_0"],Scalar VDC DFloat "va_1")),
        ("f1b", MapFSig (Tuple [],Scalar VDC DFloat "vb_0",Scalar VDC DFloat "vb_1")),
        ("f1c", MapFSig (Tuple [],Tuple [Scalar VDC DFloat "va_1",Scalar VDC DFloat "vb_1"],Scalar VDC DFloat "v_0")),
        ("f2", MapFSig (Tuple [],SVec 3 DFloat "v_s_1",Scalar VDC DFloat "v_2")),
        ("f3", MapFSig (Tuple [],SVec 3 DFloat "v_s_2",Scalar VDC DFloat "v_3"))
    ]
stencilDefinitionsList = [("s1" , [-1,0,1] ), ("s2" , [-1,0,1] )]
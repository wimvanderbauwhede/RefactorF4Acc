module ASTInstance ( ast ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
        (Vec VS (DSVec 3 DInt) "v_s_0" , Stencil (SVec 3 DInt "s1") (Vec VI DInt "v_0"))
        ,( Scalar VT DInt  "acc1_1", Fold (Function "f0" []) (Scalar VI DInt  "acc1_0") (Vec VI DInt "v_0") )
        ,( Vec VT DInt "v_1", Map (Function "f1"  ["acc1_1"]) (Vec VS (DSVec 3 DInt) "v_s_0") )
        ,(Vec VS (DSVec 3 DInt) "v_s_1" , Stencil (SVec 3 DInt "s2") (Vec VT DInt "v_1"))
        ,( Vec VT DInt "v_2", Map (Function "f4" []) (Vec VS (DSVec 3 DInt) "v_s_1") )
        ,( Scalar VT DInt  "acc3_1", Fold (Function "f2" []) (Scalar VI DInt  "acc3_0") (Vec VT DInt "v_2") )
        ,( Vec VO DInt "v_3", Map (Function "f3"  ["acc3_1"]) (Vec VT DInt "v_2") )
        ]

functionSignaturesList = [
        ("f0", FoldFSig ([],[Scalar VDC DInt "acc1"],[Scalar VDC DInt "v"],[Scalar VDC DInt "acc1"])),
        ("f1", MapFSig ([Scalar VDC DInt "acc1"],[SVec 3 DInt "v_s"],[Scalar VDC DInt "v"])),
        ("f2", FoldFSig ([],[Scalar VDC DInt "acc3"],[Scalar VDC DInt "v"],[Scalar VDC DInt "acc3"])),
        ("f3", MapFSig ([Scalar VDC DInt "acc3"],[Scalar VDC DInt "v"],[Scalar VDC DInt "v"])),
        ("f4", MapFSig ([],[SVec 3 DInt "v_s"],[Scalar VDC DInt "v"]))
    ]
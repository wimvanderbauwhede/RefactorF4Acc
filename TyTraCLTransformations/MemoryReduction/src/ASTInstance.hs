module ASTInstance ( ast, functionSignaturesList, stencilDefinitionsList ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
        (Vec VS (DSVec 3 DInt) "v_s_0" , Stencil (SVec 3 DInt "s1") (Vec VI DInt "v_0"))
        ,( Scalar VT DInt  "acc_1", Fold (Function "f1" []) (Scalar VI DInt  "acc_0") (Vec VS (DSVec 3 DInt) "v_s_0") )
        ,( Vec VO DInt "v_1", Map (Function "f2"  ["acc_1"]) (Vec VS (DSVec 3 DInt) "v_s_0") )
        ]

functionSignaturesList = [
        ("f1", FoldFSig (Tuple [],Scalar VDC DInt "acc_0",SVec 3 DInt "v_s_0",Scalar VDC DInt "acc_1")),
        ("f2", MapFSig (Scalar VDC DInt "acc_1",SVec 3 DInt "v_s_0",Scalar VDC DInt "v_1"))
    ]
stencilDefinitionsList = [("s1" , [-1,0,1] )]
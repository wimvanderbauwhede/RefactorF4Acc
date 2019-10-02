module ASTInstance ( ast ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
        (Vec VS "v_s_0" , Stencil (SVec 3 "s1") (Vec VI "v_0"))
        ,( Scalar VT "acc1_1", Fold (Function "f0" []) (Scalar VI "acc1_0") (Vec VI "v_0") )
        ,( Vec VT "v_1", Map (Function "f1"  ["acc1_1"]) (Vec VS "v_s_0") )
        ,(Vec VS "v_s_1" , Stencil (SVec 3 "s2") (Vec VT "v_1"))
        ,( Vec VT "v_2", Map (Function "f4" []) (Vec VS "v_s_1") )
        ,( Scalar VT "acc3_1", Fold (Function "f2" []) (Scalar VI "acc3_0") (Vec VT "v_2") )
        ,( Vec VO "v_3", Map (Function "f3"  ["acc3_1"]) (Vec VT "v_2") )
        ]

module ASTInstance ( ast ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
        (Vec VS "v_s_0" , Stencil (SVec 3 "s1") (Vec VI "v_0"))
        ,( Vec VT "v_1", Map (Function "f1" []) (Vec VS "v_s_0") )
        ,( Scalar VT "acc_1", Fold (Function "f2" []) (Scalar VI "acc_0") (Vec VT "v_1") )
        ,( Vec VO "v_2", Map (Function "f3"  ["acc_1"]) (Vec VT "v_1") )
        ]

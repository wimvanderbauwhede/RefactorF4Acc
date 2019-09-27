module ASTInstance ( ast ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
        ( Vec VT "v_1", Map (Function "f1" []) (Vec VI "v_0") )
        ,(Vec VS "v_s_1" , Stencil (SVec 3 "s1") (Vec VT "v_1"))
        ,( Vec VT "v_2", Map (Function "f2" []) (Vec VS "v_s_1") )
        ,(Vec VS "v_s_2" , Stencil (SVec 3 "s2") (Vec VT "v_2"))
        ,( Vec VO "v_3", Map (Function "f3" []) (Vec VS "v_s_2") )
        ]

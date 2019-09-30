module ASTInstance ( ast ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
        ( Vec VT "v3_0", Map (Function "f1" []) (ZipT [Vec VI "v1_0",Vec VI "v2_0"]) )
        ,(Vec VS "v3_s_0" , Stencil (SVec 3 "s1") (Vec VT "v3_0"))
        ,( Vec VO "v4_0", Map (Function "f2" []) (Vec VS "v3_s_0") )
        ]

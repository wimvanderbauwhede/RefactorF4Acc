module ASTInstance ( ast, functionSignaturesList, stencilDefinitionsList, mainArgDeclsList ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
        (Vec VS (DSVec 3 DFloat) "p_s_1" , Stencil (SVec 3 DInt "s1") (Vec VI DFloat "p_0"))
        ,( Vec VT DFloat "p_1", Map (Function "sor" []) (Vec VS (DSVec 3 DFloat) "p_s_1") )
        ,(Vec VS (DSVec 3 DFloat) "p_s_2" , Stencil (SVec 3 DInt "s1") (Vec VT DFloat "p_1"))
        ,( Vec VT DFloat "p_2", Map (Function "sor" []) (Vec VS (DSVec 3 DFloat) "p_s_2") )
        ,(Vec VS (DSVec 3 DFloat) "p_s_3" , Stencil (SVec 3 DInt "s1") (Vec VT DFloat "p_2"))
        ,( Vec VT DFloat "p_3", Map (Function "sor" []) (Vec VS (DSVec 3 DFloat) "p_s_3") )
        ,(Vec VS (DSVec 3 DFloat) "p_s_4" , Stencil (SVec 3 DInt "s1") (Vec VT DFloat "p_3"))
        ,( Vec VO DFloat "p_4", Map (Function "sor" []) (Vec VS (DSVec 3 DFloat) "p_s_4") )
        ]

functionSignaturesList = [
        ("sor", MapFSig (Tuple [],SVec 3 DFloat "p_s_4",Scalar VDC DFloat "p_4"))
    ]
stencilDefinitionsList = [("s1" , [-1,0,1] )]
mainArgDeclsList = [
      ("p_0" , "real, dimension(1:500), intent(in) :: p_0" )
    , ("p_4" , "real, dimension(1:500), intent(out) :: p_4" )
  ]
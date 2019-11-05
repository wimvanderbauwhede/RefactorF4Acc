module ASTInstance ( ast
        , functionSignaturesList
        , stencilDefinitionsList
        , mainArgDeclsList 
        , scalarisedArgsList
        , origNamesList
        ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
            (Vec VS (SVec 3 (Scalar VDC DFloat "p_s_1" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "p_0")))
        ,( Vec VT (Scalar VDC DFloat "p_1"), Map (Function "sor" []) (Vec VS (SVec 3(Scalar VDC DFloat "p_s_1"))) )
        ,(Vec VS (SVec 3 (Scalar VDC DFloat "p_s_2" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VT (Scalar VDC DFloat "p_1")))
        ,( Vec VT (Scalar VDC DFloat "p_2"), Map (Function "sor" []) (Vec VS (SVec 3(Scalar VDC DFloat "p_s_2"))) )
        ,(Vec VS (SVec 3 (Scalar VDC DFloat "p_s_3" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VT (Scalar VDC DFloat "p_2")))
        ,( Vec VT (Scalar VDC DFloat "p_3"), Map (Function "sor" []) (Vec VS (SVec 3(Scalar VDC DFloat "p_s_3"))) )
        ,(Vec VS (SVec 3 (Scalar VDC DFloat "p_s_4" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VT (Scalar VDC DFloat "p_3")))
        ,( Vec VO (Scalar VDC DFloat "p_4"), Map (Function "sor" []) (Vec VS (SVec 3(Scalar VDC DFloat "p_s_4"))) )
        ]

functionSignaturesList = [
        ("sor",  [Tuple [],SVec 3 (Scalar VDC DFloat "p_s_4"),Scalar VDC DFloat "p_4"])
    ]
stencilDefinitionsList = [("s1" , [-1,0,1] )]

mainArgDeclsList = [
      ("p_0" , MkFDecl "real"  (Just [500]) (Just In) ["p_0"] )
    , ("p_4" , MkFDecl "real"  (Just [500]) (Just Out) ["p_4"] )
  ]
scalarisedArgsList = []
origNamesList = []
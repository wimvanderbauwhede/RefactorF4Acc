module F95ParDecl where
import F95VarDecl 

data ParDecl = MkParDecl {
	pd_partype :: VarType
	,pd_dimension :: [Range]	
	,pd_parname:: VarName
	,pd_parval:: Expr
} deriving (Eq, Ord, Show)



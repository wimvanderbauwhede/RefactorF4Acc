module F95ParDecl where
import F95VarDecl 

-- A parameter declaration consists of the type, dimension and name of the parameter and the right-hand side expression
data ParDecl = MkParDecl {
	pd_partype :: VarType
	,pd_dimension :: [Range]	
	,pd_parname:: VarName
	,pd_parval:: Expr
} deriving (Eq, Ord, Show)



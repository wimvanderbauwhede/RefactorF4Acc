module F95VarDecl where

data VarDecl = MkVarDecl {
	vd_vartype :: VarType
	,vd_dimension :: [Range]	
	,vd_intent :: Intent
	,vd_varlist :: [VarName]
	,vd_argmode :: OclArgMode
    ,vd_is_arg :: Bool
} deriving (Eq, Ord, Show)

data Intent = In | Out | InOut  deriving (Eq, Ord, Show)

data VarType = MkVarType {
	at_numtype :: NumType,
	at_wordsz :: Integer
}  deriving (Eq, Ord, Show)

data NumType =  F95Integer | F95Real  deriving (Eq, Ord, Show)

data OclArgMode = Read | Write | ReadWrite 
	deriving (Eq, Ord, Show)

data Range = MkRange {
		r_start :: Expr
		,r_stop :: Expr
}  deriving (Eq, Ord, Show)

data Expr = Var VarName | Const Integer | Op OpExpr | Pref PrefixOpExpr  deriving (Eq, Ord, Show)

type VarName = String

data OpExpr = MkOpExpr {
	oe_op :: String
   ,oe_lhs :: Expr
   , oe_rhs :: Expr
}  deriving (Eq, Ord, Show)
data PrefixOpExpr = MkPrefixOpExpr {
	poe_op :: String
   ,poe_exp :: Expr
}  deriving (Eq, Ord, Show)



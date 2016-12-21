{-# lANGUAGE DeriveDataTypeable #-}
module F95VarDecl where
import Data.Typeable
import Data.Data
data VarDecl = MkVarDecl {
	vd_vartype :: VarType
	,vd_dimension :: [Range]	
	,vd_intent :: Intent
	,vd_varlist :: [VarName]
	,vd_argmode :: OclArgMode
    ,vd_is_arg :: Bool
    ,vd_has_const_ranges :: Bool -- This variable has constant ranges
    ,vd_shape :: [Int] -- The shape of the variable if vd_has_const_ranges = True   
} deriving (Ord, Show, Read, Typeable, Data)

-- weak equality to be forgiving
instance Eq VarDecl where (==) t1 t2 = vd_vartype t1 == vd_vartype t2 && length (vd_dimension t1) == length (vd_dimension t2) && vd_intent t1 == vd_intent t2 && vd_varlist t1 == vd_varlist t2 && vd_argmode t1 == vd_argmode t2 

data Intent = In | Out | InOut  deriving (Eq, Ord, Show, Read, Typeable, Data)

data VarType = MkVarType {
	at_numtype :: NumType,
	at_wordsz :: Integer
}  deriving (Eq, Ord, Show, Read, Typeable, Data)

data NumType =  F95Integer | F95Real  deriving (Eq, Ord, Show, Read, Typeable, Data)

data OclArgMode = Read | Write | ReadWrite 
	deriving (Eq, Ord, Show, Read, Typeable, Data)

data Range = MkRange {
		r_start :: Expr
		,r_stop :: Expr
}  deriving (Eq, Ord, Show, Read, Typeable, Data)

data Expr = Var VarName | Const Integer | Op OpExpr | Pref PrefixOpExpr 
    | ArrayIdx VarName Expr
    | ArrayCtor [Expr]
    deriving (Eq, Ord, Show, Read, Typeable, Data)

type VarName = String

data OpExpr = MkOpExpr {
	oe_op :: String
   ,oe_lhs :: Expr
   , oe_rhs :: Expr
}  deriving (Eq, Ord, Show, Read, Typeable, Data)
data PrefixOpExpr = MkPrefixOpExpr {
	poe_op :: String
   ,poe_exp :: Expr
}  deriving (Eq, Ord, Show, Read, Typeable, Data)



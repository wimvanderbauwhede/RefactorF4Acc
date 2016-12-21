{-# LANGUAGE DeriveDataTypeable #-}
module FExpr where
import Data.Data

-- WV: Symbol, I guess
type Sm              = Name  -- a String
-- 
-- data SmData          = DsSmData SpecStmt | SpSmData SubProg
--  deriving (Show, Eq, Typeable, Data)

type SmTEntry        = Sm -- (Sm,SmData) -- WV: a tuple of the symbol and its data

type SmT             = [SmTEntry] -- WV: a list of these tuples, i.e. a symbol table. Why is this not a Map?

data Lit
 = IntLit         SmT Integer         Type
 | CharLit        SmT String          Type
 | BoolLit        SmT Bool            Type
 | RealLit        SmT Double          Type
 | CmplxLit       SmT (Double,Double) Type
 deriving (Show, Eq, Typeable, Data)

data Op
 = UOp SmT UOp
 | BOp SmT BOp
 deriving (Show, Eq, Typeable, Data)

data UOp
 = Plus | Minus | Not | DefUOp SmT String
 deriving (Show, Eq, Typeable, Data)

data BOp
 = Concat | Add | Sub | Mul | Div | Expt
 | OEq | ONeq | OLt | OLtoe | OGt | OGtoe
 | And | Or | Eqv | Neqv | DefBOp SmT String
 deriving (Show, Eq, Typeable, Data)

data Subscript
 = Subscript   SmT Expr
 | SubscriptV  SmT Expr
 | Shape       SmT (Maybe Expr,Maybe Expr)
 | SubstrRange SmT (Maybe Expr,Maybe Expr) -- Always has the colon
 | Triplet     SmT (Maybe Expr,Maybe Expr,Maybe Expr)
 deriving (Show, Eq, Typeable, Data)

data Expr
 = UExpr     SmT UOp Expr
 | BExpr     SmT BOp Expr Expr
 | ImpliedDo SmT [Expr] (Prim,(Expr,Expr,Maybe Expr))
-- | LengthStarIntExpr
-- | FormatStarCharExpr -- Remove: see read_stmt in particular
 | Lit       SmT Lit
 | ExprPrim  SmT Prim
 | ArrayCtor SmT [Expr]
 | ArrayIdx  SmT Prim [Expr]
 | IntrinsicCall SmT Name [Expr]
 | Null
 deriving (Show, Eq, Typeable, Data)

data Prim
 = VarName SmT Name
 | UnknownApp  SmT Name [(Maybe Name, Expr)]
 | UnknownComp SmT [(Prim,[Subscript])] (Maybe Subscript)
 deriving (Show, Eq, Typeable, Data)

data Type
 = IntType     SmT Kind
 | RealType    SmT Kind
 | CharType    SmT Kind (Maybe Expr)
 | CmplxType   SmT Kind
 | LogicalType SmT Kind
 | DerivedType SmT Name
 deriving (Show, Eq, Typeable, Data)

data ExecStmt = AssignStmt     SmT Prim Expr
 deriving (Show, Eq, Typeable, Data)

type Name    = String
type Kind    = (Maybe Prim)


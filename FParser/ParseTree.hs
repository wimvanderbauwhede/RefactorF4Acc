{-# LANGUAGE DeriveDataTypeable #-}
module ParseTree where
-- WV: This is the parsed syntax tree, I guess it's the AST
-- Annotating everyting with SmT is a bit heavyweight, but OK
-- I'm assuming this is used to build the Program symbol table from the partial ones
import Data.Data

-- WV: Symbol, I guess
type Sm              = Name  -- a String
-- 
data SmData          = DsSmData SpecStmt | SpSmData SubProg
  deriving (Show, Eq, Typeable, Data)

type SmTEntry        = (Sm,SmData) -- WV: a tuple of the symbol and its data

type SmT             = [SmTEntry] -- WV: a list of these tuples, i.e. a symbol table. Why is this not a Map?

{--

data Program
 = Program ProgUnit [ProgUnit]
 deriving (Show, Eq, Typeable, Data)

data ProgUnit
 = MainProg       SmT (Name,Name) [PSpecStmt] [PExecStmt]
 | PrivateMod     SmT (Name,Name) [PSpecStmt] [SubProg]
 | PublicMod      SmT (Name,Name) [PSpecStmt]
 deriving (Show, Eq, Typeable, Data)

data SubProg
 = FuncSubProg    SmT Bool (Name,Name) [PSpecStmt] [PExecStmt] [AttrSpec] [Name] Prim
 | SubrSubProg    SmT Bool (Name,Name) [PSpecStmt] [PExecStmt] [AttrSpec] [Name] 
 deriving (Show, Eq, Typeable, Data)

data SpecStmt
 = AccessStmt     SmT AttrSpec [GenSpec]
 | DerivedTypeDef SmT (Name,Name) AttrSpec (Maybe PSpecStmt) [PSpecStmt]
 | DummyProcIFaceBlock SmT [SubProg]
 | IntrinsicStmt  SmT [Name]
 | ModProcIFaceBlock SmT GenSpec [Name]
 | OptionalStmt   SmT [Name]
 | PrivStmt
 | TypeDeclStmt   SmT Type [AttrSpec] [(Name,Maybe Expr)]
 | UseStmt        SmT Name String [GenSpec]
 deriving (Show, Eq, Typeable, Data)

data PSpecStmt = PSpecStmt { isPar::Bool, getDS::SpecStmt }
  deriving (Show, Eq, Typeable, Data)

data PExecStmt = PExecStmt Bool ExecStmt
  deriving (Show, Eq, Typeable, Data)

data ExecStmt
 = ControlStmt    SmT ControlStmt
 | IOStmt         SmT IOStmt
 | AllocateStmt   SmT [(Prim,[(Maybe Expr,Expr)])]   (Maybe Prim)
 | AssignStmt     SmT Prim Expr
 | CallStmt       SmT Name    [(Maybe Name,Expr)]
 | DeAllocateStmt SmT [Prim] (Maybe Prim)
 | PtrAssignStmt  SmT Prim Prim -- Expr
 | ReturnStmt
 deriving (Show, Eq, Typeable, Data)

data ControlStmt
 = CaseCons       SmT Expr [([(Maybe Expr,String,Maybe Expr)],Block)] (Maybe Block)
 | CycleStmt      SmT Name
 | DoCons         SmT Name (Maybe (Prim,(Expr,Expr,Maybe Expr))) Block
 | ExitStmt       SmT Name
 | ForAll         SmT [(Prim,(Expr,Expr,Maybe Expr))] (Maybe Expr) Block
 | IfCons         SmT [(Expr,Block)] (Maybe Block)
 | BlockCons      SmT Name [PSpecStmt] Block
 | StopStmt
 | WhereCons      SmT (Expr,Block) [(Expr,Block)] Block
 deriving (Show, Eq, Typeable, Data)

data IOStmt
 = BackSpaceStmt  SmT [(String,Expr)]
 | CloseStmt      SmT [(String,Expr)]
 | EndFileStmt    SmT [(String,Expr)]
 | InquireStmt    SmT [(String,Expr)] [Expr]
 | OpenStmt       SmT [(String,Expr)]
 | PrintStmt      SmT Expr     [Expr]
 | ReadStmt       SmT (Maybe Expr) [(String,Expr)] [Prim]
 | RewindStmt     SmT [(String,Expr)]
 | WriteStmt      SmT [(String,Expr)] [Expr]
 deriving (Show, Eq, Typeable, Data)

--}

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
 deriving (Show, Eq, Typeable, Data)

data Prim
 = UnknownName SmT Name
 | UnknownApp  SmT Name [(Maybe Name, Expr)]
 | UnknownComp SmT [(Prim,[Subscript])] (Maybe Subscript)
 deriving (Show, Eq, Typeable, Data)

{--
data GenSpec -- Like Prim, this should mainly hold plain Strings.
 = OpSpec SmT Op | AssignSpec | GenName SmT Name
 | OnlyName SmT Name | OnlyRename SmT Name Name
 | LocalName SmT Name
 deriving (Show, Eq, Typeable, Data)

data AttrSpec
 = ParameterSpec
 | PublicSpec 
 | PrivateSpec
 | AllocatableSpec 
 | DimensionSpec SmT [Subscript]
 | IntentInOutSpec | IntentInSpec | IntentOutSpec
 | OptionalSpec
 | PointerSpec
 | SaveSpec
 | TargetSpec 
 | ElementalSpec
 | PureSpec
 | RecursiveSpec
 deriving (Show, Eq, Typeable, Data)

data Type
-- = NullType
 = IntType     SmT Kind
 | RealType    SmT Kind
 | CharType    SmT Kind (Maybe Expr)
 | CmplxType   SmT Kind
 | LogicalType SmT Kind
 | DerivedType SmT Name
-- | UnknownType
 deriving (Show, Eq, Typeable, Data)
--}
type Kind    = (Maybe Prim)
type Name    = String
type Block   = [PExecStmt]

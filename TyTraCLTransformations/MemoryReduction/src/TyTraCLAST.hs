{-# LANGUAGE DeriveDataTypeable #-}
module TyTraCLAST where

import Data.Generics (Data, Typeable)
import Data.List (intercalate)

type Name = String
type Size = Int
data VE = VI  | VO  | VS  | VT | VDC deriving (Show, Ord, Typeable, Data, Eq)
data DType = 
    DInteger | DInt 
  | DReal | DFloat 
  | DSVec Int DType --  to encode SVecs
  | DTuple [DType] -- to encode Tuple
  | DDC -- Don't Care ; Int and Integer, Real and Float as I can't make up my mind
    deriving (Show, Ord, Typeable, Data, Eq)

-- I wonder if     data FSig = FSig [Expr] would not be a better approach, or even 
type FSig = [Expr]
-- data FSig = 
--     MapFSig (Expr,Expr,Expr)
--   | FoldFSig (Expr,Expr,Expr,Expr)
--   deriving (Show, Typeable, Data, Eq)

data FName = Single String | Composite [FName]
  deriving (Show, Ord, Typeable, Data, Eq)

data FIntent = In | Out | InOut | Unknown | NA
  deriving (Show, Ord, Typeable, Data, Eq)

data FDecl = MkFDecl {
  ftype :: String,
  dim :: Maybe Int,
  intent :: Maybe FIntent,
  names :: [String] 
  }
 deriving (Ord, Typeable, Data, Eq)

instance Show FDecl where  
  show (MkFDecl ftype dim intent names ) = let
        attributes = [ftype]
        attributes' = case dim of
          Just n -> attributes++["dimension(1:"++(show n)++")"]
          Nothing -> attributes
        attributes'' = case intent of
            Just i -> attributes'++["intent("++(show i)++")"]
            Nothing -> attributes'
      in
        (intercalate ", " attributes'') ++ " :: "++ (intercalate ", " names)

type TyTraCLAST = [(Expr,Expr)]                      

data Expr =
        -- Left-hand side:
                      Scalar VE DType Name
                    | Const Int
                    | Tuple [Expr]
                    | Vec VE Expr -- Name -- (Vec ve (SVec sz (Scalar ve dt v_n) ) )

        -- Right-hand side:
                    | SVec Size Expr -- Name
                    | ZipT [Expr]
                    | UnzipT Expr
                    | Elt Int Expr
                    | PElt Int -- partially applied Elt
                    | Map Expr Expr -- map f v
                    | Fold Expr Expr Expr -- fold f acc v
                    | Stencil Expr Expr -- stencil s v
                    | Function Name [Expr] -- 2nd arg is list of non-map/fold args
                    | Id Name [Expr] -- id, but it's treated as a named function for ease of code generation
                    | ApplyT [Expr]  -- applyt (f1,f2)
                    | MapS Expr Expr -- maps s f
                    | Comp Expr Expr -- comp f2 f1
                    | FComp Expr Expr -- like comp but to combine a fold and a map, quite a-hoc!
                    | SComb Expr Expr -- scomb s1 s2
                        deriving (Show, Ord, Typeable, Data, Eq)

newtype LHSPrint = LHSPrint Expr

instance Show LHSPrint where
    show (LHSPrint (Scalar _ _ x)) = show x
    show (LHSPrint (Vec _ x)) = show (LHSPrint x)
    show (LHSPrint (Function x _)) = show x
    show (LHSPrint x) = show x

-- How can I encode the type of e.g. MapS?
-- maps :: SVec k Int -> (a->b) -> SVec k a -> SVec k b
-- suppose I have a function f :: a->b and and sv :: SVec k a and I have (maps s f) 
-- Function "f" []
-- MapS sv f
-- I think maybe we define the type as 

-- data ExprType = A | B | SVec Int ExprType  | Vec Int ExprType | FType [ExprType] | Idx

-- f_type = FType [A,B]
-- maps_type = FType [SVec k Idx, FType [A,B], SVec k A, SVec k B]
-- s_type = SVec k Idx
-- map_type = FType [FType [A,B], Vec n A, Vec n B]
-- maps_s_f_type = FType [ SVec k A, SVec k B]
-- vec_svec_type = Vec n (SVec k A)
-- map_maps_f_type_vec_svec_type
-- -- need to build this from the rules
-- map_type = FType [FType [ SVec k A, SVec k B], Vec n (SVec k A), Vec n (SVec k B)]

-- toDType :: Expr -> DType
-- toDType (Scalar _ dt _) = dt
-- toDType (Tuple es) = DTuple (map toDType es)
-- toDType (SVec sz dt _) = DSVec sz dt

getDType (Vec _ dt_exp ) = dt_exp
getDType (ZipT es) = Tuple (map getDType es)

setName :: FName -> Expr -> Expr
setName (Single name') (Scalar ve dt name) = Scalar ve dt name'
setName (Single name') (Vec ve exp) = Vec ve (setName (Single name') exp)
setName (Single name') (SVec sz exp) = SVec sz (setName (Single name') exp)
-- Tuple [SVec 5 (Scalar VDC DInt "wet_s_0"),SVec 5 (Scalar VDC DFloat "eta_s_0")]
setName (Single name') (Tuple exps) = Tuple $ map (\(exp,ct) -> setName (Single (name'++"_"++(show ct))) exp) (zip exps [0..])
setName (Composite names') (Tuple exps) = Tuple $ map (\(exp,name) -> setName name exp) (zip exps names')

setName fnm@(Composite names') (SVec sz exp) = SVec sz (setName fnm exp)

setName name' exp = error $ "Don't know how to set the name "++(show name')++" for "++(show exp)


-- SVec 3 (Tuple [SVec 5 (Scalar VDC DInt "sv_wet_s_0_in"),SVec 5 (Scalar VDC DFloat "sv_eta_s_0_in")])

getName :: Expr -> FName
getName (Scalar ve dt name) = Single name
getName (Vec ve exp) = getName exp
getName (SVec sz exp) = getName exp
-- WV: I want to know if this happens
-- getName (Tuple exps) = error $ "No unique name to get for "++(show exps)
getName (Tuple exps) = Composite (map getName exps)

updateName :: String -> String -> Expr -> Expr
updateName prefix postfix (Tuple exps) = Tuple $ map (\exp -> setName (appendPrePost prefix postfix (getName exp)) exp) exps
updateName prefix postfix exp =  setName (appendPrePost prefix postfix (getName exp)) exp

appendPrePost :: String -> String -> FName -> FName 
appendPrePost prefix postfix (Single nm) = -- prefix++"_"++nm++"_"++postfix
  let
    nm' = if 
      -- (take (1 + length prefix) nm) == prefix++"_" || 
          prefix=="" then nm else prefix++"_"++nm
    nm'' = if 
      -- (drop ( length nm' -length postfix -1) nm') == "_" ++ postfix || 
      postfix == "" then nm' else nm'++"_"++postfix
  in
    Single nm''    
appendPrePost prefix postfix (Composite nms) = Composite $ map (appendPrePost prefix postfix) nms
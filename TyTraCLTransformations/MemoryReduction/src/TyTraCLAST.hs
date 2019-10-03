{-# LANGUAGE DeriveDataTypeable #-}
module TyTraCLAST where

import Data.Generics (Data, Typeable)


type Name = String
type Size = Int
data VE = VI  | VO  | VS  | VT | VDC deriving (Show, Typeable, Data, Eq)
data DType = 
    DInt | DInteger 
  | DReal | DFloat 
  | DSVec Int DType --  to encode SVecs
  | DTuple [DType] -- to encode Tuple
  | DDC -- Don't Care ; Int and Integer, Real and Float as I can't make up my mind
    deriving (Show, Typeable, Data, Eq)
data FSig = 
    MapFSig (Expr,Expr,Expr)
  | FoldFSig (Expr,Expr,Expr,Expr)
  | VecSig Expr
  deriving (Show, Typeable, Data, Eq)

type TyTraCLAST = [(Expr,Expr)]                      

data Expr =
        -- Left-hand side:
                      Scalar VE DType Name
                    | Const Int -- bb: IntLit Integer
                    | Tuple [Expr] --  bb: Tup [Expr]
                    | Vec VE DType Name -- bb: Var Name, type via cofree comonad, but VE info is not there

        -- Right-hand side:
                    | SVec Size DType Name -- bb: SVec [Expr] -> to get a name, use a Let
                    | ZipT [Expr] -- bb: App Zip (Tup  [...])
                    | UnzipT Expr -- bb: App Unzip (vec of tuples)
                    | Elt Int Expr -- bb: App (Select Integer) Tup
                    | PElt Int -- partially applied Elt
                    | Map Expr Expr -- map f v
                    | Fold Expr Expr Expr -- fold f acc v
                    | Stencil Expr Expr -- stencil s v
                    | Function Name [Name] -- 2nd arg is list of non-map/fold args
                    | Id -- id
                    -- | Mu Expr Expr -- \a e -> g a (f e) -- of course bb does not have this, no need
                    | ApplyT [Expr]  -- applyt (f1,f2)
                    | MapS Expr Expr -- maps s f
                    | Comp Expr Expr -- comp f2 f1
                    | FComp  Expr Expr -- like comp but to combine a fold and a map, quite a-hoc!
                    | SComb Expr Expr -- scomb s1 s2
                    -- | bb has Let Expr Expr
                    -- | bb has App Expr Expr to apply and Expr to an Expr
                    -- bb has Split, Merge and Par which I don't need
                        deriving (Show, Typeable, Data, Eq)

newtype LHSPrint = LHSPrint Expr

instance Show LHSPrint where
    show (LHSPrint (Scalar _ _ x)) = show x
    show (LHSPrint (Vec _ _ x)) = show x
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

toDType :: Expr -> DType
toDType (Scalar _ dt _) = dt
toDType (Tuple es) = DTuple (map toDType es)
toDType (SVec sz dt _) = DSVec sz dt

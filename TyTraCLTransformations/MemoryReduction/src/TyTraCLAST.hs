{-# LANGUAGE DeriveDataTypeable #-}
module TyTraCLAST where

import Data.Generics (Data, Typeable)


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
                    | Id Expr -- id
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

setName name' (Scalar ve dt name) = Scalar ve dt name'
setName name' (Vec ve exp) = Vec ve (setName name' exp)
setName name' (SVec sz exp) = SVec sz (setName name' exp)
-- Tuple [SVec 5 (Scalar VDC DInt "wet_s_0"),SVec 5 (Scalar VDC DFloat "eta_s_0")]
setName name' (Tuple exps) = Tuple $ map (\(exp,ct) -> setName (name'++"_"++(show ct)) exp) (zip exps [0..])
setName name' exp = error $ "Don't know how to set the name for "++(show exp)

getName (Scalar ve dt name) = name
getName (Vec ve exp) = getName exp
getName (SVec sz exp) = getName exp
-- WV: I want to know if this happens
getName (Tuple exps) = error $ "No unique name to get for "++(show exps)
-- getName (Tuple exps) = intercalate "_" (map getName exps)

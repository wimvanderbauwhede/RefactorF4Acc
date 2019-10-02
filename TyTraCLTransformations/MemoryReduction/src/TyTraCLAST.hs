{-# LANGUAGE DeriveDataTypeable #-}
module TyTraCLAST where


import Data.Generics (Data, Typeable)


type Name = String
data VE = VI  | VO  | VS  | VT deriving (Show, Typeable, Data, Eq)
    
type TyTraCLAST = [(Expr,Expr)]                      

data Expr =
        -- Left-hand side:
                      Scalar VE Name
                    | Const Int -- bb: IntLit Integer
                    | Tuple [Expr] --  bb: Tup [Expr]
                    | Vec VE Name -- bb: Var Name, type via cofree comonad, but VE info is not there

        -- Right-hand side:
                    | SVec Int Name -- bb: SVec [Expr] -> to get a name, use a Let
                    | ZipT [Expr] -- bb: App Zip (Tup  [...])
                    | UnzipT Expr -- bb: App Unzip (vec of tuples)
                    | Elt Int Expr -- bb: App (Select Integer) Tup
                    | PElt Int -- bb does not need this
                    | Map Expr Expr -- bb: App (Map Expr) Expr
                    | Fold Expr Expr Expr -- bb: App (Fold (App action acc) Expr
                    | Stencil Expr Expr -- bb uses App : App (Stencil (SVec [IntLit])) vector
                    | Function Name [Name] -- 2nd arg is list of non-map/fold args-- bb: uses Var Name with a function type
                    | Id -- bb has Id 
                    | Mu Expr Expr -- \a e -> g a (f e) -- of course bb does not have this, no need
                    | ApplyT [Expr]  -- bb: App FTup [Expr]
                    | MapS Expr Expr -- bb does not have this, not needed
                    | Comp Expr Expr -- bb does not have this, not needed
                    | FComp  Expr Expr --  to combine a fold and a map, quite a-hoc!
                    | SComb Expr Expr
                    -- | bb has Let Expr Expr
                    -- | bb has App Expr Expr to apply and Expr to an Expr
                    -- bb has Split, Merge and Par which I don't need
                        deriving (Show, Typeable, Data, Eq)

newtype LHSPrint = LHSPrint Expr

instance Show LHSPrint where
    show (LHSPrint (Scalar _ x)) = show x
    show (LHSPrint (Vec _ x)) = show x
    show (LHSPrint (Function x _)) = show x
    show (LHSPrint x) = show x
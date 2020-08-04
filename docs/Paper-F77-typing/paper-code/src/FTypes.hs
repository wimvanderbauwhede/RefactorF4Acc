module FTypes where

import Data.Map.Strict as H hiding (map,null)


type VarName = String
type Kind = Int

-- type ArrayOrScalar = Integer -- 1 for Array, 0 for Scalar
type Dim = [(Int,Int)]
type PrefixStr = [String] 


data VarDecl = MkVarDecl {
    vType :: FType,
    vArrayOrScalar :: ArrayOrScalar,
    vName :: VarName,
    vKind :: Kind,
    vDim :: Dim, 
    vPrefix :: [String]    
}

type CommonVarTuple = (VarDecl,Int)

data SubroutineRecord = MkSubroutineRecord {
    commonBlockSequences :: H.Map String [CommonVarTuple]
    -- , ...
}

data State = MkState {
    subroutines :: H.Map String SubroutineRecord
    -- , ...
}

data FType = FInteger | FReal | FComplex | FLogical deriving (Eq, Show)

data ArrayOrScalar = Array | Scalar deriving (Eq, Show)

emptyState = MkState H.empty
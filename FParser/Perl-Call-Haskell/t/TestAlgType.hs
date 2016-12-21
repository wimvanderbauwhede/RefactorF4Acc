{-# LANGUAGE DeriveDataTypeable #-}
module TestAlgType
where
import Data.Typeable
data AlgType = MkAlgType String Int deriving (Read, Show, Typeable)

f1 :: AlgType -> Int
f1 (MkAlgType sc iv) = iv

f2 :: Int -> AlgType
f2 iv = MkAlgType "55" iv

f3 :: AlgType -> AlgType
f3 (MkAlgType sv iv)  = MkAlgType (sv++sv) (iv*12) 


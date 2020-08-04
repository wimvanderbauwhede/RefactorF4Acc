module Main where

import MatchCommonSequences (matchCommonSequences)
import CommonBlockTypecheckRules (commonBlockTypecheck)
import FTypes 
import Data.Map.Strict as H hiding (map,null)

main :: IO ()
-- main = someFunc
main =  do
    matchCommonSequences (emptyState,"","","") [] [] []
    print $ commonBlockTypecheck (FReal, Array, 4, 2, 1) (FComplex, Scalar, 4, 0,0)   

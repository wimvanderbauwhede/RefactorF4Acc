module TestMap (f1, f2, f3 ) where
import qualified Data.Map as H

f1 :: H.Map String Int -> Int
f1 m = H.size m

f2 :: Int -> H.Map String Int 
f2 iv = H.singleton "GO!GO!" iv

f3 :: H.Map String Int ->H.Map String Int
f3 m = H.insert  "k3" 33 m



module ProcessStr where

f1 :: String -> String -> Int -> String
f1 str1 str2 x = (take x str1)++str2

f2 :: String -> String 
f2 str = "From Haskell: <"++str++">\n"

f3 :: Double -> Int
f3 x 
    | x < 0.0 = -1
    | x > 0.0 = 1
    | otherwise = 0

f4 :: [Int] -> Int
f4 xs = product xs
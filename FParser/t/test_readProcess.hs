module Main where

import System.Process

main = do 
    lt <- readProcess "/bin/date" [] []
    putStrLn lt
    lst <- readProcess "/bin/ls" ["-l"] []
    putStrLn lst



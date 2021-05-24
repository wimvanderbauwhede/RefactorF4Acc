module ASTReader where

import TyTraCLAST

-- main :: IO ()
-- main = do
--   astFilePath <- getArgs
--   ast <- readAST astFilePath -- better make this the file name provided as argument
--   print ast

readAST :: FilePath -> IO ASTInstance
readAST path = do
  ast_str <- readFile path
  let
     ast = read ast_str
  return ast


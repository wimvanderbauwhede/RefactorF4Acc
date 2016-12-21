module Main where

import Text.ParserCombinators.Parsec hiding (State)
import FExpr
import FExprParser

import Control.Monad.State
import Data.Generics

-- run_parser_print :: Show a => Parser a -> String -> IO ()
run_parser_print p str = do
      case runParser p [] "" str of
           Left err -> do
               putStr "parse error at "
               print err
           Right x  -> putStrLn $ "    "++(show x)++","

run_parser p str = do
      case runParser p [] "" str of
           Left err ->  error $ "parse error at " ++ (show err)
           Right x  -> x



generalParseF prod contents =
 case runParser prod [] "" contents of
  Left err -> do putStr "parse error at "
                 print err 
                 return (AssignStmt [] (VarName [] "") Null )
  Right p  -> return p           

main = do
    run_parser_print  f77_f95_expr_parser "var = 42\n"
    run_parser_print  f77_f95_expr_parser "var = (i+1)*2\n"
    run_parser_print  f77_f95_expr_parser "var = 2*ABS(4)\n"
    run_parser_print  f77_f95_expr_parser "var = v(42)+w(2*i+j)\n"
    let
        parsed_expr = run_parser f77_f95_expr_parser "var = v(42)+w(2*i+j)\n"
        AssignStmt [] _ rhs = parsed_expr
        res = execState (everywhereM (mkM get_varnames) rhs) [] 
    putStrLn $ show parsed_expr
    putStrLn $ show res

get_varnames :: Prim -> State [String] Prim
get_varnames p@(VarName [] v) = do
            vs <- get
            put (vs++[v])
            return p
get_varnames p = return p

   

module GetVarNamesFromExpr ( getVarNamesFromExpr ) where

import Text.ParserCombinators.Parsec hiding (State)
import FExpr
import FExprParser

import Control.Monad.State
import Data.Generics

run_parser p str = do
      case runParser p [] "" str of
           Left err ->  error $ "parse error at " ++ (show err) ++ " in string "++str
           Right x  -> x

get_varnames :: Prim -> State [String] Prim
get_varnames p@(VarName [] v) = do
            vs <- get
            put (vs++[v])
            return p
get_varnames p = return p

getVarNamesFromExpr :: String -> (String,[String])
getVarNamesFromExpr assign_expr = 
    let
        parsed_expr = run_parser f77_f95_expr_parser assign_expr -- "var = v(42)+w(2*i+j)\n"
        AssignStmt [] (VarName [] vn) rhs = parsed_expr
        varnames = execState (everywhereM (mkM get_varnames) rhs) [] 
    in (vn, varnames)

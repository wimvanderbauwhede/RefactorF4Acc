module EvalExpr (eval, VarTable) where
import F95Types
import qualified Data.Map as H

type VarTable = H.Map String Expr
-- given an expression and the variable lookup table, return the integer value of the evaluated expression and the updated table
eval :: Expr -> VarTable -> (Integer, VarTable)
eval expr vtable = (0,H.empty)

-- given a binary operator expression (e.g. x+y) and the variable lookup table, return the integer value of the evaluated expression
eval_expr :: OpExpr -> VarTable -> Integer    
eval_expr oe vt = 0

-- given a unary operator expression (e.g. -x) and the variable lookup table, return the integer value of the evaluated expression
eval_prefix_expr :: PrefixOpExpr -> VarTable -> Integer
eval_prefix_expr pe vt = 0

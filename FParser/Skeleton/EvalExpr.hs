module EvalExpr (eval, VarTable) where
import F95Types
import qualified Data.Map as H

type VarTable = H.Map String Expr

eval :: Expr -> VarTable -> (Integer, VarTable)
eval expr vtable = (0,H.empty)

eval_expr :: OpExpr -> VarTable -> Integer    
eval_expr oe vt = 0

eval_prefix_expr :: PrefixOpExpr -> VarTable -> Integer
eval_prefix_expr pe vt = 0

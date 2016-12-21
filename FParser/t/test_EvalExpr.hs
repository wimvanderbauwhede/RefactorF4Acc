import EvalExpr
import F95Types
import Test.HUnit
import RunTestWV (runTestWV)
import qualified Data.Map as H

-- 6*(x+1)
x_expr =    Op (MkOpExpr {oe_op = "*", oe_lhs = Const 6, oe_rhs = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "x", oe_rhs = Const 1})})
-- 0+x*y
x_y_expr =    Op (MkOpExpr {oe_op = "+", oe_lhs = Const 0, oe_rhs = Op (MkOpExpr {oe_op = "*", oe_lhs = Var "x", oe_rhs = Var "y"})})
-- 6*(3+4)
const_expr =    Op (MkOpExpr {oe_op = "*", oe_lhs = Const 6, oe_rhs = Op (MkOpExpr {oe_op = "+", oe_lhs = Const 3, oe_rhs = Const 4})})
z_expr = Var "z"
z2_expr = Op (MkOpExpr {oe_op = "*", oe_lhs = Var "z", oe_rhs = Const 1})
w_expr = Var "ww"
-- (z+ww)/2
zw_expr = Op (MkOpExpr {oe_op = "/", oe_lhs = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "z", oe_rhs = Var "ww"}),oe_rhs = Const 2 })

var_test_list = [
    ("x", Const 6),
    ("y", Const 7),
    ("z", x_expr),
    ("ww", x_y_expr)
    ]

var_test_table = H.fromList var_test_list

(res1,vt1) = eval const_expr var_test_table 
(res2,vt2) = eval x_expr vt1
(res3,vt3) = eval x_y_expr vt2
(res4,vt4) = eval z_expr vt3
(res5,vt5) = eval z2_expr vt4 
(res6,vt6) = eval w_expr vt5
(res7,vt7) = eval zw_expr vt6

test_expr1 = assertEqual "1" 42 res1
test_expr2 = assertEqual "1" 42 res2
test_expr3 = assertEqual "1" 42 res3
test_expr4 = assertEqual "1" 42 res4
test_expr5 = assertEqual "1" 42 res5
test_expr6 = assertEqual "1" 42 res6
test_expr7 = assertEqual "1" 42 res7

val (Const x) = x
val _ = 0

test_eval_table = assertEqual "" (sum (map (\(_,e) -> val e) (H.toList vt7))) 97
tests = TestList [
	"Eval test " ~: test_expr1,
	"Eval test " ~: test_expr2,
	"Eval test " ~: test_expr3,
	"Eval test " ~: test_expr4,
	"Eval test " ~: test_expr5,
	"Eval test " ~: test_expr6,
	"Eval test " ~: test_expr7,
	"Eval eval table " ~: test_eval_table
	]
main = do
    runTestWV "EvalExpr" tests
{-    
    putStrLn $ show res1
    putStrLn $ show res2
    putStrLn $ show res3
    putStrLn $ show res4
    putStrLn $ show res5
    putStrLn $ show res6
    putStrLn $ show $ sum (map (\(_,Const x) -> x) (H.toList vt6))
-}


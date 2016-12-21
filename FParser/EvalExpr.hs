module EvalExpr (eval, 
        VarTable
        ) where
import F95Types
import qualified Data.Map as H
{-
Compile-time computation: for Fortran 95
- given parameter statements, extract the values
 integer, parameter  :: ip = 150
 integer, parameter  :: jp = 150
 integer, parameter  :: kp = 90

param_decl = do
    pt <- type_parser
    comma
    symbol "parameter"
    symbol "::"
    pn <- identifier
    symbol "="
    pv <- expression_parser -- because params can be defined in terms of other params
    return $ MkParDecl pn pv

Then we must build a lookup table with these parameters. We can either do this while parsing or later.

I also need to make up my mind about the complete structure. I guess we can have a list of declarations, which will be either ArgDecl or ParDecl

data Decl = Var VarDecl | Arg ArgDecl | Param ParDecl

Initially everything is Var. When we parse the subroutine signature, we get the args. For the CW, everything is Arg.

** To do this in an easy way, we need a preprocessor that joins lines and inlines parameter files. That is easy enough.
It should maybe also split lines? I guess a Perl script is by far the easies way to do this. In fact, we can use rf4a for this.
For the CW, we assume this has been done **

So, after parsing, we have a list of Decls. We go through this list and compute the parameter values, as follows:

ParDecl -> parname, parval_expr
=> We need a mini-interpreter for parval_expr. For example, suppose it is 

-- 2*(x+1)
--    Op (MkOpExpr {oe_op = "*", oe_lhs = Const 2, oe_rhs = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "x", oe_rhs = Const 1})}),
-- 2+x*y
--    Op (MkOpExpr {oe_op = "+", oe_lhs = Const 2, oe_rhs = Op (MkOpExpr {oe_op = "*", oe_lhs = Var "x", oe_rhs = Var "y"})}),

What we need is an eval function which we can give the type.
-}

type VarTable = H.Map VarName Expr
eval :: Expr -> VarTable -> (Integer, VarTable)
eval expr vtable = case expr of
    Const n -> (n, vtable)
    Var x -> case H.lookup x vtable of
        Just (Const cv) -> (cv,vtable)
        Just e -> let (v,vt) = eval e vtable in (v,H.insert x (Const v) vt)
        Nothing -> error $ "No match for "++x++" in vtable"
    Op oe -> (eval_expr oe vtable, vtable)
    Pref pe -> (eval_prefix_expr pe vtable ,vtable)
    
eval_expr :: OpExpr -> VarTable -> Integer    
eval_expr oe vt = let
    rhs = oe_rhs oe
    lhs = oe_lhs oe
    op = oe_op oe
    (rv,_) = eval rhs vt
    (lv,_) = eval lhs vt
    v 
      | op == "+" = rv+lv
      | op == "-" = rv-lv
      | op == "*" = rv*lv
      | op == "/" = quot lv rv 
    in
        v
eval_prefix_expr :: PrefixOpExpr -> VarTable -> Integer
eval_prefix_expr pe vt = let
        e = poe_exp pe
        (rv,_) = eval e vt
    in
        -1*rv


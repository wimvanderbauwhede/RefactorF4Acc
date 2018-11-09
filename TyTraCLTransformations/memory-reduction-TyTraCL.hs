{-# LANGUAGE DeriveDataTypeable #-}
module Main where

--import Data.Generics (mkQ, mkT, gmapQ, gmapT, everything, everywhere)
import Data.Generics (Data, Typeable, mkQ, mkT, gmapQ, gmapT, everything, everywhere, everywhere')

main = do
    putStrLn "Original AST"
    mapM print ast
    putStrLn "\nSplit LHS tuples"
    mapM print ast'
    putStrLn "\nSubstitute vectors (recursive)"
    mapM print ast''
    putStrLn "\nTest for Vec in RHS Expr"
    mapM (print . get_vec_subexprs . snd) ast''
    putStrLn "\nTest for non-input Vec in RHS Expr"
    mapM (print . expr_has_non_input_vecs . snd) ast'
    putStrLn "\nTest for non-input Vec in RHS Expr"
    mapM (print . expr_has_non_input_vecs . snd) ast''
--    print $ find_in_ast ast' (Vec VT "duu_1")

{-
    main (etan_0,wet_0,eps_0,dt_0,g_0,dx_0,dy_0,wet_0,u_0,v_0,duu_0,dvv_0,h_0,dt_0,dx_0,dy_0,hzero_0,hmin_0) =
      let
         -- shapiro_map_15
        s1 = [-1,-502,0,502,1]
        etan_s_0 = stencil s1 etan_0
        s2 = [-1,-502,0,502,1]
        wet_s_0 = stencil s2 wet_0
        eta_1 =  map (shapiro_map_15 eps_0) (zipt (wet_s_0,etan_s_0))
         -- dyn_map_38
        s3 = [0,502,1]
        eta_s_0 = stencil s3 eta_1
        (du_1,dv_1) = unzipt $ map (dyn_map_38 (dt_0,g_0,dx_0,dy_0)) eta_s_0
         -- dyn_map_44
        s4 = [0,502,1]
        wet_s_1 = stencil s4 wet_0
        (duu_1,dvv_1,un_1,vn_1) = unzipt $ map (dyn_map_44 (duu_0,dvv_0)) (zipt (u_0,du_1,wet_s_1,v_0,dv_1))
         -- dyn_map_64
        s5 = [-1,0]
        vn_s_0 = stencil s5 vn_1
        s6 = [-502,0]
        un_s_0 = stencil s6 un_1
        s7 = [-1,-502,0,502,1]
        h_s_0 = stencil s7 h_0
        etan_1 =  map (dyn_map_64 (dt_0,dx_0,dy_0)) (zipt (un_s_0,h_s_0,vn_s_0,eta_s_0))
         -- vernieuw_map_23
        (h_1,u_1,v_1,wet_1) = unzipt $ map (vernieuw_map_23 hmin_0) (zipt (hzero_0,eta_s_0,h_s_0,un_s_0,vn_s_0))
      in
        (eta_1,du_1,dv_1,un_1,vn_1,etan_1,h_1,u_1,v_1,wet_1)
-}

type Name = String
data VE = VI  | VO  | VS  | VT deriving (Show, Typeable, Data, Eq)
type AST = [(Expr,Expr)]                      

data Expr =
        -- Left-hand side:
                      Scalar 
                    | Tuple [Expr]
                    | Vec VE Name

        -- Right-hand side:
                    | SVec Int Name
                    | ZipT [Expr] 
                    | UnzipT Expr
                    | Elt Int Expr
                    | PElt Int
                    | Map Expr Expr
                    | Fold Expr Expr Expr
                    | Stencil Expr Expr 
                    | Function Name 
                    | ApplyT [Name]  
                    | MapS Name
                        deriving (Show, Typeable, Data, Eq)

        -- Initially, all RHS nodes will be Map, Fold or Stencil.
ast :: AST
ast = [
          (Vec VS "etan_s_0" , Stencil (SVec 5 "s1") (Vec VI "etan_0"))
          ,(Vec VS "wet_s_0" , Stencil (SVec 5 "s2") (Vec VI "wet_0"))
          ,(Vec VO "eta_1", Map (Function "shapiro_map_15 eps_0") (ZipT [Vec VS "wet_s_0",Vec VS "etan_s_0"]))
          ,(Vec VS "eta_s_0", Stencil (SVec 3 "s3") (Vec VO "eta_1"))
          ,((Tuple [Vec VO "du_1", Vec VO "dv_1"]) , UnzipT (Map (Function "dyn_map_38 (dt_0,g_0,dx_0,dy_0)") (Vec VS "eta_s_0") ) )
          ,(Vec VS "wet_s_1", Stencil (SVec 3 "s4") (Vec VI "wet_0"))
          ,(Tuple [Vec VT "duu_1",Vec VT "dvv_1",Vec VO "un_1",Vec VO "vn_1"] , Map (Function "dyn_map_44 (duu_0,dvv_0)") (ZipT [Vec VI "u_0",Vec VO "du_1",Vec VS "wet_s_1",Vec VI "v_0",Vec VO "dv_1"]))
          ,(Vec VS "vn_s_0" , Stencil (SVec 2 "s5") (Vec VO "vn_1"))
          ,(Vec VS "un_s_0" , Stencil (SVec 2 "s6") (Vec VO "un_1"))
          ,(Vec VS "h_s_0" , Stencil (SVec 5 "s7") (Vec VI "h_0"))
          ,(Vec VO "etan_1" , Map (Function "dyn_map_64 (dt_0,dx_0,dy_0)") (ZipT [Vec VS "un_s_0",Vec VS "h_s_0",Vec VS "vn_s_0",Vec VS "eta_s_0"]))
          ,(Tuple [Vec VO "h_1",Vec VO "u_1",Vec VO "v_1",Vec VO "wet_1"] , Map (Function "vernieuw_map_23 hmin_0") (ZipT [Vec VI "hzero_0",Vec VS "eta_s_0",Vec VS "h_s_0",Vec VS "un_s_0",Vec VS "vn_s_0"]))
       ]

-- 1.  Replace all LHS _Tuple_ occurences with multiple expressions using _Elt_ on the RHS. As a result, the LHS will be purely _Vec_. 


ast' = foldl split_lhs_tuples [] ast
split_lhs_tuples acc t@(lhs,rhs) = let
    ts = case lhs of
        Tuple vecs -> split_tuple vecs rhs
        _ -> [t]
    in
        acc++ts
        
split_tuple vecs rhs = let
        vecs_idxs = zip vecs [0 .. length vecs - 1]
    in
        foldl (\acc (vec,idx) ->  acc++[(vec, Elt idx rhs)]) [] vecs_idxs

-- 2. Substitute all _Vec VT_ and _Vec VS_ recursively until no _Vec VT_ and _Vec VS_ remain in the AST. We start from the last expression in the list. We must also substitute _Vec VO_ on the RHS but tuples with _Vec VO_ on the LHS can't be removed. Clearly, _Vec VI_ should never occur on the LHS.
-- There are two subtasks here: 
-- 2.1 Find occurences of _Vec_ in the RHS expression of any tuple with a _Vec VO_ on the LHS
-- 2.2 Look up and substitute these _Vec_s with their RHS expression
-- I think the easiest way is to use Generics: with `everywhere` we can update all nodes in place

find_in_ast :: AST -> Expr -> Expr
find_in_ast ast v@(Vec _ _)  = let
    maybe_v = filter (\(lhs,rhs) -> lhs == v) ast
    in
        if length maybe_v == 1 
        then
            snd $ head maybe_v
        else
            v
find_in_ast ast e  = e
            
--substitute_vec :: AST -> Expr ->  Expr
--substitute_vec ast v@(Vec _ _)  = find_in_ast ast v 
--substitute_vec ast e = e
{-
get_vec_type :: Expr -> [VE]
get_vec_type v@(Vec vt _) = [vt]
get_vec_type _ = []

get_vec_subexpr_types :: Expr -> [VE]
get_vec_subexpr_types expr = everything (++) (mkQ [] get_vec_type) expr

expr_has_non_input_vecs :: Expr -> Bool
expr_has_non_input_vecs expr = let
    vec_subexprs = get_vec_subexpr_types expr
    non_input_vecs =  filter (
            \v -> case v of 
                VI -> False
                _ -> True
            ) vec_subexprs
    in
        length non_input_vecs > 0  
-}

expr_has_non_input_vecs expr = length (non_input_vecs expr) > 0

get_vec :: Expr -> [Expr]
get_vec v@(Vec vt _) = [v]
get_vec _ = []

get_vec_subexprs :: Expr -> [Expr]
get_vec_subexprs expr = everything (++) (mkQ [] get_vec) expr

non_input_vecs :: Expr -> [Expr]
non_input_vecs expr = let
    vec_subexprs = get_vec_subexprs expr
    in
        filter (
            \v -> case v of 
                Vec VI _ -> False
                _ -> True
            ) vec_subexprs

-- The actual substitution should of course use `everywhere`
--
--
substitute_vec_by_expr svec sexpr expr = everywhere (mkT (substitute_vec_by_expr' svec sexpr)) expr

substitute_vec_by_expr' svec sexpr  vec
    | vec == svec = sexpr
    |  otherwise = vec
    
{-
Finally, we go trough all lines of the ast and do a recursive substitution: 
-}    
ast'' =  map (substitute_vec_rec ast') (filter lhs_is_output_vec ast')

lhs_is_output_vec (lhs_vec,expr) = case lhs_vec of
    Vec VO _ -> True
    _ -> False
-- Create a list of all Vecs in the expr
-- Find the corresponding RHS expressions
-- Substitute all of them in the given expression
substitute_vec ast expr_tup@(lhs_vec,expr) = let
        vecs = non_input_vecs expr
        exprs = map (find_in_ast ast) vecs
        tups = zip vecs exprs
        expr' = foldl (\expr' (svec,sexpr) -> substitute_vec_by_expr svec sexpr expr') expr tups
    in 
        (lhs_vec,expr')
        
-- To do this recursively, we must test if there are still non_input_vecs, and if so, repeat substitute_vec until there are non left
 
substitute_vec_rec ast expr_tup@(lhs_vec,expr) = let
        vecs = non_input_vecs expr
    in
        if length vecs > 0 then 
            let
                expr_tup' = substitute_vec ast expr_tup
            in
                substitute_vec_rec ast expr_tup'
        else -- we're dome, return the result 
            expr_tup

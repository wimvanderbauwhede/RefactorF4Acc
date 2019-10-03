module Transforms (splitLhsTuples, substituteVectors, applyRewriteRules, fuseStencils, decomposeExpressions) where

import Data.Generics (Data, Typeable, mkQ, mkT, mkM, gmapQ, gmapT, everything, everywhere, everywhere', everywhereM)
import Control.Monad.State
import TyTraCLAST
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Replace all LHS Tuple occurrences with multiple expressions using Elt on the RHS. As a result, the LHS will be purely Vec.
splitLhsTuples :: TyTraCLAST -> TyTraCLAST
splitLhsTuples = foldl split_lhs_tuples []

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
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
{-
2. Substitute all _Vec VT_ and _Vec VS_ recursively until no _Vec VT_ and _Vec VS_ remain in the AST. 
We start from the last expression in the list. 
We must also substitute _Vec VO_ on the RHS but tuples with _Vec VO_ on the LHS can't be removed. 
Clearly, _Vec VI_ should never occur on the LHS.
There are two subtasks here: 
2.1 Find occurences of _Vec_ in the RHS expression of any tuple with a _Vec VO_ on the LHS
2.2 Look up and substitute these _Vec_s with their RHS expression
I think the easiest way is to use Generics: with `everywhere` we can update all nodes in place
-}

-- 
find_in_ast :: TyTraCLAST -> Expr -> Expr
find_in_ast ast v@(Vec _ _)  = let
    maybe_v = filter (\(lhs,rhs) -> lhs == v) ast
    in
        if length maybe_v == 1 
        then
            snd $ head maybe_v -- return the rhs
        else
            v
find_in_ast ast e  = e
            
-- expr_has_non_input_vecs expr = length (non_input_vecs expr) > 0

-- If an expression is a vector, return it in a list, else return an empty list
get_vec :: Expr -> [Expr]
get_vec v@(Vec vt _) = [v]
get_vec _ = []

get_vec_subexprs :: Expr -> [Expr]
get_vec_subexprs = everything (++) (mkQ [] get_vec) 

-- returns all non-input vectors in an expression
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
substitute_vec_by_expr svec sexpr expr = everywhere (mkT (substitute_vec_by_expr' svec sexpr)) expr

substitute_vec_by_expr' svec sexpr  vec
    | vec == svec = sexpr
    |  otherwise = vec
    

-- Finally, we go trough all lines of the ast and do a recursive substitution:     
substituteVectors ast' =  map (substitute_vec_rec ast') (filter lhs_is_output_vec ast')

{-
The AST is now reduced to a list of tuples where the first elt (LHS) is an output vector and the second element is an expression which only contains input vectors.     
Now we should start applying the rewrite rules to reduce each of these expressions to a single Map.
-}

lhs_is_output_vec (lhs_vec,expr) = case lhs_vec of
    Vec VO _ _ _ -> True
    Scalar VT _ _ -> True
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

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Examples
-- A linked list
ll = Tuple [ Const 11, Tuple [ Const 22, Tuple [ Const 33, Tuple [ Const 44, Tuple [   Const 55, Const 66 ] ] ] ] ]


-- Sum all nodes in the linked list
reduce_ll ll = everywhere (mkT reduce_ll_chain) ll

reduce_ll_chain expr = case expr of
    Tuple [ Const n, Const m] -> Const (n+m)
    _ -> expr


{-
 A binary tree
                    11
                /       \
             22            44    
           /   \        /     \
          33    0      55      66
         / \          /  \    /  \
        0   0        0    0  0    0  
-}
tree = Tuple [ Const 11, Tuple [ Const 22, Tuple [ Const 33, Const 0, Const 0], Const 0], Tuple [ Const 44, Tuple [   Const 55, Const 0, Const 0], Tuple [Const 66, Const 0, Const 0 ] ] ] 

-- Sum all nodes in the binary tree
reduce_tree tree = everywhere (mkT reduce_subtree) tree

reduce_subtree expr = case expr of
    Tuple [ Const n, Const m, Const k] -> Const (n+m+k)
    _ -> expr

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
-- 3. With this preparation I guess we are ready for the actual rewrites:
--
rewrite_ast_expr :: Expr -> Expr
rewrite_ast_expr ast = everywhere (mkT rewrite_ast_sub_expr) ast

{-
Rewrite rules
1.
    map f_2 (map f_1 v) = map (f_2 . f_1) v    

2.
    stencil s_1 (map f_1) = map (maps f_1) (stencil s_1)
    
3.
    zipt (map f_1 v_1, map f_2 v_2) = map (applyt (f_1,f_2)) (zipt (v_1, v_2)) -- if all exprs in ZipT are maps

4.
    v = map id v -- but only if this v appears in a ZipT where at least one of the other expressions is a map

5.
    (elt i) . unzipt . (map f exprs) = map ((elt i) . f) exprs

-- I don't think we can ever arrive at this with the given rewrite rules, because ApplyT is never used outside a Map
6.
    applyt (g_1,g_2) $ applyt (f_1,f_2)  = applyt (g_1 . f_1, g_2 . f_2) 
-- This is a separate pass
7.  stencil s1 $ stencil s2 $ v = stencil (scomb s1 s2)  v
-}

-- (Stencil (SVec 3 "s2") (Stencil (SVec 3 "s1") (Vec VI "v_0"))))
-- (Stencil (SComb (SVec 3 "s2") (SVec 3 "s1")) (Vec VI "v_0"))))
rewrite_ast_sub_expr expr = case expr of 
    -- 1. Map composition
    Map f1_expr (Map f2_expr v_expr) -> Map (Comp f1_expr f2_expr) v_expr
    -- 1b. Fold-Map composition
    Fold f1_expr acc_expr (Map f2_expr v_expr) -> Fold (FComp f1_expr f2_expr) acc_expr v_expr
    -- 2. The key rule: Stencil of Map becomes Map of MapS of Stencil
    Stencil s_1 (Map f_1 v_expr) -> Map (MapS s_1 f_1) (Stencil s_1 v_expr)   
    ZipT es -> 
        -- If all args of ZipT are Map
        if (length ( filter isMap es ) == length es) 
            -- 3. ZipT of tuple of Map becomes Map of ApplyT of the functions to ZipT of the vectors
            then rewriteZipTMap es
            -- Otherwise, check if at least one of them is a Map, if so, rewrite Vec to Id
            else if (length ( filter isMap es ) > 0) 
                -- 4. Rewrite Vec and Stencil as Map of Id 
                then ZipT (map rewriteId es) 
                else expr
    -- 5.  Tuple select (Elt) after UnzipT of Map becomes Map of the composition of Elt and the mapped function
    Elt i_expr (UnzipT (Map f_expr exprs)) -> Map (Comp (PElt i_expr) f_expr) exprs
    -- This gets ignored?
    -- Stencil s_1 (Stencil s_2 v_expr) -> Stencil (SComb s_1 s_2) v_expr
    _ -> expr

fuseStencils ast 
    | nmatches==0 = ast'
    | otherwise = fuseStencils ast'
    where
        -- ast' = map (\(lhs,rhs) -> (lhs,rewrite_ast_expr' rhs)) ast
        (nmatches, ast') = foldl (\(nm,ast_acc) (lhs,rhs) -> 
            let 
                (m, rhs') = rewrite_ast_expr' rhs
            in    
                (nm+m, ast_acc++[(lhs,rhs')])
            ) (0,[]) ast

-- What we do is fuse stencils and make sure stencils are applied to input vectors, not zips
rewrite_ast_expr' expr = case expr of   
    Map f_expr (Stencil s_1 (Stencil s_2 v_expr)) -> (1,Map f_expr (Stencil (SComb s_1 s_2) v_expr))
    Fold f_expr acc_expr (Stencil s_1 (Stencil s_2 v_expr)) -> (1,Fold f_expr acc_expr (Stencil (SComb s_1 s_2) v_expr))
    Map f_expr (Stencil s (ZipT vs)) -> (1,Map f_expr (ZipT (map (Stencil s) vs)))
    Fold f_expr acc_expr (Stencil s (ZipT vs)) -> (1,Fold f_expr acc_expr (ZipT (map (Stencil s) vs)))
    _ -> (0,expr)
{- 
This needs to be done repeatedly until a fixpoint is reached.    
Fixpoint is reached when there is only a single Map expression
-}
applyRewriteRules  = map (\(lhs,rhs) -> (lhs,rewrite_ast_into_single_map 0 rhs))
      
-- fuseStencils ast = let
--         ast' = map (\(lhs,rhs) -> (lhs,rewrite_ast_expr' rhs)) ast
--         ast'' = map (\(lhs,rhs) -> (lhs,rewrite_ast_expr' rhs)) ast'
--     in
--         ast''

-- ast''' = map (\(lhs,rhs) -> (lhs,rewrite_ast_into_single_map rhs)) ast''
--
map_checks :: TyTraCLAST -> [Int]
map_checks ast = filter (/=0) $ map  (\(lhs,rhs) -> n_map_subexprs rhs) ast

isMap expr = case expr of
    Map _ _ -> True
    _ -> False

-- (map f_1 v_1, map f_2 v_2) = map (applyt (f_1,f_2)) (zipt (v_1, v_2))    
rewriteZipTMap es =  let
        f_s = map (\(Map f v) -> f) es
        v_s = map (\(Map f v) -> v) es
    in
        Map (ApplyT f_s) (ZipT v_s)

rewriteId expr =  case expr of
    Vec vt n -> Map Id expr
    Stencil _ (Vec _ _) -> Map Id expr
    _ -> expr

get_map :: Expr -> [Expr]
get_map m@(Map _ _) = [m]
get_map _ = []

n_map_subexprs :: Expr -> Int
n_map_subexprs expr = length (everything (++) (mkQ [] get_map) expr) 

-- This only works if the rules eliminate all maps
-- I also want to check if the number did not change anymore
has_map_subexprs :: Expr ->  Int
has_map_subexprs expr = length (everything (++) (mkQ [] get_map) expr) -- > 1

rewrite_ast_into_single_map :: Int -> Expr -> Expr
rewrite_ast_into_single_map count exp = 
    let 
        count' = count+1
        map_count = has_map_subexprs exp 
    in
        if map_count > 1
            then 
                let
                    exp' = rewrite_ast_expr exp
                in
                    rewrite_ast_into_single_map count' exp'
            else
                exp            

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
{-
The additional complexity is to rewrite the result in such a way that I can emit
Fortran from it.    

-}    

{-
4. First decompose the expressions. This is some kind of ANF/SSA style: every vector, stencil and function gets a name.

-}

subsitute_expr :: Expr -> Expr -> State (Int,[(Expr,Expr)]) Expr
subsitute_expr lhs exp = do
            let 
                (vec_name, decomposeMap) = case lhs of
                    Vec VO vname -> (vname, False)
                    Scalar _ sname -> (sname, True)
            (ct,var_expr_pairs) <- get
            let ((ct',var_expr_pairs'),exp') = case exp of
                      Scalar _ _ -> ((ct,var_expr_pairs),exp)
                      Const _ -> ((ct,var_expr_pairs),exp)
                      Tuple _ -> ((ct,var_expr_pairs),exp)
                      Vec _ _ -> ((ct,var_expr_pairs),exp)
                      Id -> ((ct,var_expr_pairs),exp)
                      Function _ _ -> ((ct,var_expr_pairs),exp)
                      SVec _ _ -> ((ct,var_expr_pairs),exp)
                      SComb _ _ -> ((ct,var_expr_pairs),exp)
                      PElt _ -> ((ct,var_expr_pairs),exp)
                      Map _ _ -> if decomposeMap 
                        then
                            let -- ((ct,var_expr_pairs),exp)
                                var = Vec VT ("var_"++vec_name++"_"++(show ct)) 
                            in
                            ((ct+1,var_expr_pairs++[(var,exp)]),var)
                        else
                            ((ct,var_expr_pairs),exp)
                      Fold _ _ _ -> ((ct,var_expr_pairs),exp)
                      MapS _ _ -> let
                            f_expr = Function ("f_maps_"++vec_name++"_"++(show ct)) []
                        in
                            ((ct+1,var_expr_pairs++[(f_expr,exp)]),f_expr)
                      ApplyT _ -> let
                            f_expr = Function ("f_applyt_"++vec_name++"_"++(show ct)) []
                        in
                            ((ct+1,var_expr_pairs++[(f_expr,exp)]),f_expr)
                      Comp _ _ -> let
                            f_expr = Function ("f_comp_"++vec_name++"_"++(show ct)) []
                        in
                            ((ct+1,var_expr_pairs++[(f_expr,exp)]),f_expr)
                      FComp _ _ -> let
                            f_expr = Function ("f_fcomp_"++vec_name++"_"++(show ct)) []
                        in
                            ((ct+1,var_expr_pairs++[(f_expr,exp)]),f_expr)
                      Stencil (SVec n _) _ -> let                            
                            var = Vec VS ("svec_"++vec_name++"_"++(show ct))
                        in
                            ((ct+1,var_expr_pairs++[(var,exp)]),var)
                      _ -> let
                              var = Vec VT ("vec_"++vec_name++"_"++(show ct))
                           in
                             ((ct+1,var_expr_pairs++[(var,exp)]),var)
            put (ct',var_expr_pairs')
            return exp'

subsitute_exprs :: Expr -> Expr -> [(Expr,Expr)]
subsitute_exprs lhs ast = let
        -- Vec VO vec_name = vec
        (ast',(ct,var_expr_pairs)) = runState (everywhereM (mkM (subsitute_expr lhs)) ast) (0,[])
    in 
       var_expr_pairs ++ [ (lhs,ast') ]
-- subsitute_exprs scal@(Scalar _ _) ast = let
--         -- Scalar _ scal_name = scal
--         (ast',(ct,var_expr_pairs)) = runState (everywhereM (mkM (subsitute_expr scal)) ast) (0,[])
--     in 
--        var_expr_pairs ++ [ (scal,ast') ]

-- This returns the decomposed expressions as a lists of lists
-- Because of the original code, this is guaranteed to be in dependency order.
decomposeExpressions = map (\(lhs,rhs) -> (subsitute_exprs lhs rhs )) 


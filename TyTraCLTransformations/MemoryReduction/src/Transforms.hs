module Transforms (splitLhsTuples, substituteVectors, applyRewriteRules, fuseStencils, decomposeExpressions) where

import Data.Generics (Data, Typeable, mkQ, mkT, mkM, gmapQ, gmapT, everything, everywhere, everywhere', everywhereM)
import Control.Monad.State
import qualified Data.Map.Strict as Map

import TyTraCLAST
import Warning ( warning )

(!) = (Map.!)
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
find_in_ast ast v@(Vec _ _ )  = let
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
get_vec v@(Vec vt _ ) = [v]
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
                Vec VI _  -> False
                _ -> True
            ) vec_subexprs

  

-- Finally, we go trough all lines of the ast and do a recursive substitution:     
substituteVectors ast' =  map (substitute_vec_rec ast') (filter lhs_is_output_vec ast')

{-
The AST is now reduced to a list of tuples where the first elt (LHS) is an output vector and the second element is an expression which only contains input vectors.     
Now we should start applying the rewrite rules to reduce each of these expressions to a single Map.
-}

lhs_is_output_vec (lhs_vec,expr) = case lhs_vec of
    Vec VO _ -> True
    Scalar VT _ _ -> True
    _ -> False

-- Create a list of all Vecs in the expr
-- Find the corresponding RHS expressions
-- Substitute all of them in the given expression

-- To do this recursively, we must test if there are still non_input_vecs, and if so, repeat substitute_vec until there are non left
 
substitute_vec_rec ast expr_tup@(lhs_vec,expr) = let
        vecs = non_input_vecs expr
    in
        if length vecs > 0 then 
            let
                expr_tup' = substitute_vec ast expr_tup
            in
                substitute_vec_rec ast expr_tup'
        else -- we're done, return the result 
            expr_tup

substitute_vec ast expr_tup@(lhs_vec,expr) = let
        vecs = non_input_vecs expr
        exprs = map (find_in_ast ast) vecs
        tups = zip vecs exprs
        expr' = foldl (\expr' (svec,sexpr) -> substitute_vec_by_expr svec sexpr expr') expr tups
    in 
        (lhs_vec,expr')
        
-- The actual substitution should of course use `everywhere`
substitute_vec_by_expr svec sexpr  = everywhere (mkT (substitute_vec_by_expr' svec sexpr)) 

substitute_vec_by_expr' svec sexpr  vec
    | vec == svec = sexpr
    |  otherwise = vec

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
{-
-- Examples
-- A linked list
ll = Tuple [ Const 11, Tuple [ Const 22, Tuple [ Const 33, Tuple [ Const 44, Tuple [   Const 55, Const 66 ] ] ] ] ]


-- Sum all nodes in the linked list
reduce_ll ll = everywhere (mkT reduce_ll_chain) ll

reduce_ll_chain expr = case expr of
    Tuple [ Const n, Const m] -> Const (n+m)
    _ -> expr



 A binary tree
                    11
                /       \
             22            44    
           /   \        /     \
          33    0      55      66
         / \          /  \    /  \
        0   0        0    0  0    0  

tree = Tuple [ Const 11, Tuple [ Const 22, Tuple [ Const 33, Const 0, Const 0], Const 0], Tuple [ Const 44, Tuple [   Const 55, Const 0, Const 0], Tuple [Const 66, Const 0, Const 0 ] ] ] 

-- Sum all nodes in the binary tree
reduce_tree tree = everywhere (mkT reduce_subtree) tree

reduce_subtree expr = case expr of
    Tuple [ Const n, Const m, Const k] -> Const (n+m+k)
    _ -> expr
-}
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
-- 3. With this preparation I guess we are ready for the actual rewrites:
--
-- I should use a monadic version with the State monad
-- We populate the Map with (id_$ct, [Tuple [], $in_exp, $in_exp ] )
-- Key question is where to get $in_exp 
--  runState (everywhereM (mkM (rewrite_ast_sub_expr lhs)) ast) (0,Map.empty)
-- rewrite_ast_expr :: Expr -> Expr
-- rewrite_ast_expr ast = everywhere (mkT rewrite_ast_sub_expr) ast

rewrite_ast_expr :: Expr -> State (Int,Map.Map Name [Expr]) Expr
rewrite_ast_expr ast = everywhereM (mkM rewrite_ast_sub_expr) ast

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
rewrite_ast_sub_expr expr = do
        case expr of 
            -- 1. Map composition
            Map f1_expr (Map f2_expr v_expr) -> return $ Map (Comp f1_expr f2_expr) v_expr
            -- 1b. Fold-Map composition
            Fold f1_expr acc_expr (Map f2_expr v_expr) -> return $ Fold (FComp f1_expr f2_expr) acc_expr v_expr
            -- 2. The key rule: Stencil of Map becomes Map of MapS of Stencil
            Stencil s_1 (Map f_1 v_expr) -> return $ Map (MapS s_1 f_1) (Stencil s_1 v_expr)   
            ZipT es -> do
                -- If all args of ZipT are Map
                if (length ( filter isMap es ) == length es) 
                    -- 3. ZipT of tuple of Map becomes Map of ApplyT of the functions to ZipT of the vectors
                    then return $ rewriteZipTMap es
                    -- Otherwise, check if at least one of them is a Map, if so, rewrite Vec to Id
                    else if (length ( filter isMap es ) > 0) 
                        -- 4. Rewrite Vec and Stencil as Map of Id 
                        then 
                            do
                                res <- mapM rewriteIdToFunc es
                                return $ ZipT res -- (map rewriteIdToFunc es) 
                        else return expr
            -- 5.  Tuple select (Elt) after UnzipT of Map becomes Map of the composition of Elt and the mapped function
            Elt i_expr (UnzipT (Map f_expr exprs)) -> return $ Map (Comp (PElt i_expr) f_expr) exprs
            -- This gets ignored?
            -- Stencil s_1 (Stencil s_2 v_expr) -> Stencil (SComb s_1 s_2) v_expr
            _ -> return $ expr


fuseStencils ast 
    | nmatches==0 = ast'
    | otherwise = fuseStencils ast'
    where
        (nmatches, ast') = foldl (\(nm,ast_acc) (lhs,rhs) -> 
            let 
                (m, rhs') = rewrite_ast_expr_fuse rhs
            in    
                (nm+m, ast_acc++[(lhs,rhs')])
            ) (0,[]) ast

-- What we do is fuse stencils and make sure stencils are applied to input vectors, not zips
-- This is not good because it fails on a ZipT arg   

-- rewrite_ast_expr_fuse expr = case expr of   
--     Map f_expr (Stencil s_1 (Stencil s_2 v_expr)) -> (1,Map f_expr (Stencil (SComb s_1 s_2) v_expr))
--     Fold f_expr acc_expr (Stencil s_1 (Stencil s_2 v_expr)) -> (1,Fold f_expr acc_expr (Stencil (SComb s_1 s_2) v_expr))
--     Map f_expr (Stencil s (ZipT vs)) -> (1,Map f_expr (ZipT (map (Stencil s) vs)))
--     Fold f_expr acc_expr (Stencil s (ZipT vs)) -> (1,Fold f_expr acc_expr (ZipT (map (Stencil s) vs)))
--     Map f_expr (ZipT v_exprs) -> (1,)
--     _ -> (0,expr)


rewrite_ast_expr_fuse expr = case expr of   
    Map f_expr v_expr -> let
                (m,v_expr') = fuse_stencils v_expr
            in 
                (m, Map f_expr v_expr')
    Fold f_expr acc_expr v_expr -> let
                (m,v_expr') = fuse_stencils v_expr
            in 
                (m, Fold acc_expr f_expr v_expr')                
    _ -> (0,expr)

fuse_stencils (Stencil s_1 (Stencil s_2 v_expr)) = (1,Stencil (SComb s_1 s_2) v_expr)
fuse_stencils (Stencil s (ZipT vs)) = (1,ZipT (map (Stencil s) vs))
fuse_stencils (ZipT v_exprs) = 
    let
        (ms,v_exprs') = unzip $ map fuse_stencils v_exprs
    in 
        (if sum ms > 0 then 1 else 0, ZipT v_exprs' )
fuse_stencils v_expr = (0,v_expr)


-- fuseStencils (Stencil s_1 (Stencil s_2 v_expr)) = Stencil (SComb s_1 s_2) v_expr
-- fuseStencils (Stencil s (ZipT v_exprs)) = ZipT (map (Stencil s) v_exprs)
-- fuseStencils (ZipT v_exprs) = ZipT (map fuseStencils v_exprs)
-- fuseStencils v_expr = v_expr

{-      
This needs to be done repeatedly until a fixpoint is reached.    
Fixpoint is reached when there is only a single Map expression

Maybe it is easier to do runState and then use a fold manage the Map?
runState returns ((ct,mp),rhs)
foldl (\(lst,(ct,mp)) (lhs,rhs) -> let
    ((ct',mp'),rhs') = runState (rewrite_ast_into_single_map 0 rhs) (ct,mp))
    in (lst++[(lhs,rhs')],(ct',mp'))
) ([], (0,Map.empty)) ast

where
    f' (\(lst,acc) elt -> (lst++[elt],acc)
-}
applyRewriteRules ast = foldl (\(lst,(ct,mp)) (lhs,rhs) -> 
        let
            (rhs',(ct',mp')) = runState (rewrite_ast_into_single_map 0 rhs) (ct,mp)
        in (lst++[(lhs,rhs')],(ct',mp'))
    ) ([], (0,Map.empty)) ast
    
--     runState (rewriteWithState ast) (0,Map.empty)

-- rewriteWithState ast = do
--     let
--         ast' = map (\(lhs,rhs) -> (lhs,rewrite_ast_into_single_map 0 rhs)) ast      
--     return ast'

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

-- Instead of inserting Id I should insert a Function with a fresh name 
-- and put that function in the functionSignaturesList
-- the dt or (SVec sz dt) is the Expr to be put in the function signature

rewriteId expr =  case expr of
    Vec _ dt   -> Map (Id dt) expr
    Stencil (SVec sz _ )  (Vec _ dt ) -> Map (Id (SVec sz dt)) expr
    _ -> expr

-- TODO PUT THIS IN PLACE AND MAKE THIS MONADIC EVERYWHERE    
rewriteIdToFunc :: Expr -> State (Int, Map.Map Name [Expr]) Expr
rewriteIdToFunc expr = do
    (ct, fsigs) <- get
    let 
        id_name = ("id_"++(show ct))
        (rexp,in_exp, isId) = case expr of
            Vec _ dt   -> (Map (Function id_name []) expr, dt, True)
            Stencil (SVec sz _ )  (Vec _ dt ) -> (Map (Function id_name []) expr, SVec sz dt, True)
            _ -> (expr, expr, False)
    if isId 
        then
            put (ct+1, Map.insert ("id_"++(show ct)) [Tuple [], in_exp, in_exp] fsigs)
        else
            put (ct, fsigs)            
    return rexp



get_map :: Expr -> [Expr]
get_map m@(Map _ _) = [m]
get_map m@(Fold _ _ _) = [m] -- cheating
get_map _ = []

n_map_subexprs :: Expr -> Int
n_map_subexprs expr = length (everything (++) (mkQ [] get_map) expr) 

-- This only works if the rules eliminate all maps
-- I also want to check if the number did not change anymore
has_map_subexprs :: Expr ->  Int
has_map_subexprs expr = length (everything (++) (mkQ [] get_map) expr) -- > 1

rewrite_ast_into_single_map :: Int -> Expr -> State (Int,Map.Map Name [Expr]) Expr
rewrite_ast_into_single_map count exp = do
    let 
        count' = count+1
        map_count = has_map_subexprs exp 
    -- in
    if map_count > 1
        then do 
            -- let
            exp' <- rewrite_ast_expr exp
            -- in
            rewrite_ast_into_single_map count' exp'
        else
            return exp            

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
{-
The additional complexity is to rewrite the result in such a way that I can emit
Fortran from it.    

-}    

{-
4. First decompose the expressions. This is some kind of ANF/SSA style: every vector, stencil and function gets a name.


( Vec VT (Scalar VDC DFloat "eta_2"), 
Map (Function "dyn_map_65"  [
    Scalar VDC DFloat "dt_0",
    Scalar VDC DFloat "dx_0",
    Scalar VDC DFloat "dy_0"]) 
    
    (ZipT [Vec VS (SVec 2(Scalar DFloat "un_s_0")),Vec VS (SVec 5(Scalar DFloat "h_s_0")),Vec VS (SVec 2(Scalar DFloat "vn_s_0")),Vec VT (Scalar VDC DFloat "eta_1")]) )
-}

subsitute_expr :: Expr -> Expr -> State (Int,Map.Map Expr Expr,Map.Map Expr Expr,[(Expr,Expr)]) Expr
subsitute_expr lhs exp = do
            let 
                (vec_name, decomposeMap) = case lhs of
                    Vec VO  (Scalar _ _ vname) -> (vname, False)
                    Scalar _ _ sname -> (sname, True)
            (ct,orig_bindings,added_bindings,var_expr_pairs) <- get
            let ((ct',orig_bindings', added_bindings',var_expr_pairs'),exp') = case exp of
                      Scalar _ _ _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Const _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Tuple _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Vec _ _  -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Id _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Function _ _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      SVec _ _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      SComb _ _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      PElt _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      ZipT _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Map _ _ -> if decomposeMap 
                        then
                            let -- ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                                var = Vec VT (Scalar VT DDC ("var_"++vec_name++"_"++(show ct))) 
                            in
                                maybeAddBinding var exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                        else
                            ((ct,orig_bindings, added_bindings,var_expr_pairs),exp)
                      Fold _ _ _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      MapS _ (Function _ nms) -> let
                            f_expr = Function ("f_maps_"++vec_name++"_"++(show ct)) nms
                        in
                            -- ((ct+1,var_expr_pairs++[(f_expr,exp)]),f_expr)
                            maybeAddBinding f_expr exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      ApplyT fs -> let
                            nmss = concatMap getNonMapFoldArgs fs
                            f_expr = Function ("f_applyt_"++vec_name++"_"++(show ct)) nmss
                        in
                            -- ((ct+1,var_expr_pairs++[(f_expr,exp)]),f_expr)
                            maybeAddBinding f_expr exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      Comp (Function _ nms1) (Function _ nms2) -> let
                            f_expr = Function ("f_comp_"++vec_name++"_"++(show ct)) (nms1++nms2)
                        in
                            -- ((ct+1,var_expr_pairs++[(f_expr,exp)]),f_expr)
                            maybeAddBinding f_expr exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      Comp (PElt idx) (Function _ nms2) -> let
                        -- I think the vec_name here is unique so no need for ++"_"++(show idx)
                            f_expr = Function ("f_pelt_"++vec_name++"_"++(show ct)) nms2
                        in
                            -- ((ct+1,var_expr_pairs++[(f_expr,exp)]),f_expr)
                            maybeAddBinding f_expr exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      FComp (Function _ nms1) (Function _ nms2) -> let
                            f_expr = Function ("f_fcomp_"++vec_name++"_"++(show ct)) (nms1++nms2)
                        in
                            -- ((ct+1,var_expr_pairs++[(f_expr,exp)]),f_expr)
                            maybeAddBinding f_expr exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      Stencil (SVec _ _ ) v_exp -> let
                            dt_exp = getDType v_exp
                            var = Vec VS (setName ("svec_"++vec_name++"_"++(show ct)) dt_exp)
                        in
                            -- ((ct+1,var_expr_pairs++[(var,exp)]),var)
                            maybeAddBinding var exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      Stencil (SComb _ _) v_exp -> let
                            dt_exp = getDType v_exp
                            var = Vec VS (setName  ("svec_"++vec_name++"_"++(show ct)) dt_exp)
                        in
                            -- ((ct+1,var_expr_pairs++[(var,exp)]),var)
                            maybeAddBinding var exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      _ -> let
                              var = Vec VT (Scalar VT DDC ("vec_"++vec_name++"_"++(show ct)))
                           in
                            --  ((ct+1,var_expr_pairs++[(var,exp)]),var)
                             maybeAddBinding var exp (ct,orig_bindings, added_bindings, var_expr_pairs)
            put (ct',orig_bindings',added_bindings',var_expr_pairs')
            return exp'


{-
So we test if an expression is in added_bindings.
If it is, do nothing,
If it is not, we check if it is on orig_bindings.
	if yes, we remove it from orig_bindings, add it to added_bindings, and add the new binding to the AST
	if not, then it's a new binding, add it to added_bindings , and add the new binding to the AST


-}
-- (ct',orig_bindings', added_bindings', var_expr_pairs') =
maybeAddBinding :: Expr -> Expr -> (Int,Map.Map Expr Expr,Map.Map Expr Expr,[(Expr,Expr)]) -> ((Int,Map.Map Expr Expr,Map.Map Expr Expr,[(Expr,Expr)]), Expr)
maybeAddBinding var exp (ct,orig_bindings, added_bindings, var_expr_pairs) =
    if Map.member exp added_bindings 
        then
        -- We already have this, so do nothing
        -- But this means we should definitely add this pair to the final AST 
        let
            added_name = added_bindings ! exp                    
        in
            ((ct,orig_bindings, added_bindings, var_expr_pairs),(warning added_name ("Already added binding "++(show var)++"<>"++(show added_name)++" for "++(show exp))))
        else 
            if Map.member exp orig_bindings 
                then
                    let
                        orig_name = orig_bindings ! exp                    
                    in
                        ((ct,Map.delete exp orig_bindings, Map.insert exp var added_bindings, var_expr_pairs++[(orig_name,exp)]),(warning orig_name ("Binding "++(show orig_name)++" for "++(show exp)++" is original")))            
                else                    
                    ((ct+1,orig_bindings, Map.insert exp var added_bindings, var_expr_pairs++[(var,exp)]),(warning var ("Adding binding "++(show var)++" for "++(show exp))))            


subsitute_exprs ::  (Map.Map Expr Expr) -> Expr -> Expr -> [(Expr,Expr)]
subsitute_exprs orig_bindings lhs ast = let
        -- ast' is the original expression into which lhs has been substituted
        -- var_expr_pairs are the new intermediate bindings that have been created as a result
        (ast',(ct,orig_bindings',added_bindings',var_expr_pairs)) = runState (everywhereM (mkM (subsitute_expr lhs)) ast) (0,orig_bindings,Map.empty,[])
    in 
       var_expr_pairs ++ [ (lhs,ast') ]

-- subsitute_exprs scal@(Scalar _ _) ast = let
--         -- Scalar _ scal_name = scal
--         (ast',(ct,var_expr_pairs)) = runState (everywhereM (mkM (subsitute_expr scal)) ast) (0,[])
--     in 
--        var_expr_pairs ++ [ (scal,ast') ]

-- This returns the decomposed expressions as a lists of lists
-- Because of the original code, this is guaranteed to be in dependency order.
decomposeExpressions :: TyTraCLAST -> TyTraCLAST -> [TyTraCLAST] 
decomposeExpressions orig_ast ast = 
    let
        bindings = Map.fromList $ map (\(f,s)->(s,f)) orig_ast
    in
        map (\(lhs,rhs) -> (subsitute_exprs bindings lhs rhs )) ast

getNonMapFoldArgs :: Expr -> [Expr]
getNonMapFoldArgs exp = everything (++) (mkQ [] (getNonMapFoldArgs')) exp

getNonMapFoldArgs' :: Expr -> [Expr]
getNonMapFoldArgs' (Function _ nms) = nms
getNonMapFoldArgs' _ = []


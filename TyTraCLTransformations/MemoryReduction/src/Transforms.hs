module Transforms (splitLhsTuples, substituteVectors, applyRewriteRules, fuseStencils, regroupTuples, decomposeExpressions) where

import Data.Generics (Data, Typeable, mkQ, mkT, mkM, gmapQ, gmapT, everything, everywhere, everywhere', everywhereM)
import Control.Monad.State
import qualified Data.Map.Strict as Map
import Data.List (intercalate)

import TyTraCLAST
-- import Warning ( warning )

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
We use Generics: with `everywhere` we update all nodes in place
-}

-- Go trough all lines of the ast and do a recursive substitution on the lines with an output vector in the LHS
substituteVectors :: TyTraCLAST -> TyTraCLAST
substituteVectors ast' 
    | noStencilRewrites = map (substitute_vec_rec ast') (filter lhs_is_VO_or_VT_vec ast')
    | otherwise =  map (substitute_vec_rec ast') (filter lhs_is_output_vec ast')

-- The result of a Fold is always an output
lhs_is_output_vec (lhs_vec,Fold _ _ _) = True
lhs_is_output_vec (lhs_vec,expr) = case lhs_vec of
    Vec VO _ -> True
    -- This is now probably redundant, as only Fold can return a Scalar
    Scalar _ _ _ -> True -- maybe too loose, should be VT really 
    _ -> False


lhs_is_VO_or_VT_vec (lhs_vec,Fold _ _ _) = True    
lhs_is_VO_or_VT_vec (lhs_vec,expr) = case lhs_vec of
    Vec VO _ -> True 
    Vec VT _ -> True    
    -- This is now probably redundant, as only Fold can return a Scalar
    Scalar _ _ _ -> True -- maybe too loose, should be VT really 
    _ -> False

-- Create a list of all Vecs in the expr
-- Find the corresponding RHS expressions
-- Substitute all of them in the given expression

-- To do this recursively, we must test if there are still non_input_vecs, and if so, repeat substitute_vec until there are non left
-- WV 2021-05-14
-- TEST 8 hangs for noStencilRewrites, because the Vec VS vector is not substituted.
-- Either that is OK and then vecs should not contain any Vec VS    
-- Or it must be substituted and we must find out why it is not.
substitute_vec_rec :: TyTraCLAST -> (Expr, Expr) -> (Expr, Expr)
substitute_vec_rec ast expr_tup@(lhs_vec,expr) = let
        vecs
            | noStencilRewrites = non_input_or_temp_vecs expr
            | otherwise = non_input_vecs expr
    in
        if not $ null vecs then 
            let
                expr_tup' = substitute_vec ast expr_tup
            in
                if (expr_tup' == expr_tup) 
                    then 
                        -- Loop
                        error $ "LOOP! "++(show vecs)
                    else
                        substitute_vec_rec ast expr_tup'
        else -- we're done, return the result 
            expr_tup

-- We look for the non-input vectors in the RHS expression (vecs)
-- We find all lines in the AST that have any of these non-input vectors on the LHS (exprs)
-- We substituts vecs by exprs
-- we return the substituted expression
substitute_vec :: TyTraCLAST -> (Expr, Expr) -> (Expr, Expr)            
substitute_vec ast expr_tup@(lhs_vec,expr) = let
        vecs = non_input_vecs expr
        exprs = map (find_in_ast ast) vecs
        tups = zip vecs exprs
        expr' = foldl (\expr' (svec,sexpr) -> substitute_vec_by_expr svec sexpr expr') expr tups
    in 
        (lhs_vec,expr')

-- works because there can be at most one occurence of v in ast
-- It might be better to use a Map here because then it would simply be a lookup
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

-- The actual substitution with `everywhere`
substitute_vec_by_expr :: Expr -> Expr -> Expr -> Expr
substitute_vec_by_expr svec sexpr  = everywhere (mkT (
    if noStencilRewrites
        then
            substitute_vec_by_expr'' svec sexpr
        else
            substitute_vec_by_expr' svec sexpr
            )) 

substitute_vec_by_expr' :: Expr -> Expr -> Expr -> Expr 
substitute_vec_by_expr' svec sexpr vec
    | vec == svec = sexpr -- For the no-stencil-rewrite case I need to match on Map and Fold, not on the Vec itself!    
    | otherwise = vec

substitute_vec_by_expr'' :: Expr -> Expr -> Expr -> Expr     
substitute_vec_by_expr'' svec sexpr (Map f vec) 
    | vec == svec = Map f sexpr -- For the no-stencil-rewrite case I need to match on Map and Fold, not on the Vec itself!    
    | otherwise = Map f vec
substitute_vec_by_expr'' svec sexpr (Fold f acc vec)    
    | vec == svec = Fold f acc sexpr -- For the no-stencil-rewrite case I need to match on Map and Fold, not on the Vec itself!    
    | otherwise = Fold f acc vec
substitute_vec_by_expr'' _ _ expr = expr 
   
-- returns all non-input vectors in an expression
-- This should change to add VT if we want to use this code to emit the original TyTraCL
non_input_vecs :: Expr -> [Expr]
non_input_vecs expr = let
    vec_subexprs = get_vec_subexprs expr
    in
        filter (
            \v -> case v of 
                Vec VI _  -> False
                _ -> True
            ) vec_subexprs    

non_input_or_temp_vecs :: Expr -> [Expr]
non_input_or_temp_vecs expr = let -- @(Stencil _ _)
    vec_subexprs = get_vec_subexprs expr
    in
        filter (
            \v -> case v of 
                Vec VI _  -> False
                Vec VT _  -> False
                _ -> True
            ) vec_subexprs              
-- non_input_or_temp_vecs expr = let
--     vec_subexprs = get_vec_subexprs expr
--     in
--         filter (
--             \v -> case v of 
--                 Vec VI _  -> False
--                 _ -> True
--             ) vec_subexprs    


get_vec_subexprs :: Expr -> [Expr]
get_vec_subexprs = everything (++) (mkQ [] get_vec)    

-- If an expression is a vector, return it in a list, else return an empty list
get_vec :: Expr -> [Expr]
get_vec v@(Vec vt _ ) = [v]
get_vec _ = []

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

{-
The AST is now reduced to a list of tuples where the first elt (LHS) is an output vector and the second element is an expression which only contains input vectors.     
Now we apply the rewrite rules to reduce each of these expressions to a single Map.
-}

-- 3. With this preparation we are ready for the actual rewrites:

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

{-      
This needs to be done repeatedly until a fixpoint is reached.    
Fixpoint is reached when there is only a single Map expression
-}
applyRewriteRules ast = foldl (\(lst,(ct,mp)) (lhs,rhs) -> 
        let
            (rhs',(ct',mp')) = runState (rewrite_ast_into_single_map 0 rhs) (ct,mp)
        in (lst++[(lhs,rhs')],(ct',mp'))
    ) ([], (0,[])) ast
--
-- I use a monadic version with the State monad
-- We populate the Map with (id_$ct, [Tuple [], $in_exp, $in_exp ] )

rewrite_ast_expr :: Expr -> State (Int, [(Name, [Expr])]) Expr
rewrite_ast_expr ast = everywhereM (mkM rewrite_ast_sub_expr) ast

rewrite_ast_into_single_map :: Int -> Expr -> State (Int,[(Name, [Expr])]) Expr
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
-- (Stencil (SVec 3 "s2") (Stencil (SVec 3 "s1") (Vec VI "v_0"))))
-- (Stencil (SComb (SVec 3 "s2") (SVec 3 "s1")) (Vec VI "v_0"))))
rewrite_ast_sub_expr expr = 
        case expr of 
            -- 1. Map composition
            Map f1_expr (Map f2_expr v_expr) -> return $ Map (Comp f1_expr f2_expr) v_expr
            -- 1b. Fold-Map composition
            Fold f1_expr acc_expr (Map f2_expr v_expr) -> return $ Fold (FComp f1_expr f2_expr) acc_expr v_expr
            -- 2. The key rule: Stencil of Map becomes Map of MapS of Stencil
            Stencil s_1 (Map f_1 v_expr) -> if noStencilRewrites 
                then return expr
                else return $ Map (MapS s_1 f_1) (Stencil s_1 v_expr)   
            ZipT es -> 
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
                                return $ ZipT res
                        else return expr
            -- 5.  Tuple select (Elt) after UnzipT of Map becomes Map of the composition of Elt and the mapped function
            Elt i_expr (UnzipT (Map f_expr exprs)) -> return $ Map (Comp (PElt i_expr) f_expr) exprs
            _ -> return $ expr

{-
3b. fuse stencils and rewrite so stencils are applied to input vectors, not zips
-}
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

regroupTuples ast = let            
        regrouped_tuples_map = foldl (
            \acc (lhs,rhs) -> case rhs of
                Elt n expr -> if Map.member expr acc 
                    then 
                        let
                            lst = acc ! expr
                        in
                            Map.adjust (\lst -> lst++[(lhs,n)]) expr acc
                        else 
                            Map.insert expr [(lhs,n)] acc
                _ -> acc    
            ) Map.empty ast
        non_elt_ast = filter (\(lhs,rhs) -> case rhs of
                    Elt _ _ -> False
                    _ -> True
                ) ast
        tuples_ast = map (\rhs_expr -> 
            let
                val_tups = regrouped_tuples_map ! rhs_expr
                lhs_exprs = map fst val_tups
            in 
                (Tuple lhs_exprs,rhs_expr)
            ) (Map.keys regrouped_tuples_map)
    in            
        tuples_ast ++ non_elt_ast


-- What we do is fuse stencils and make sure stencils are applied to input vectors, not zips
rewrite_ast_expr_fuse expr = case expr of   
    Map f_expr v_expr -> let
                (m,v_expr') = fuse_stencils v_expr
            in 
                (m, Map f_expr v_expr')
    Fold f_expr acc_expr v_expr -> let
                (m,v_expr') = fuse_stencils v_expr
            in 
                (m, Fold f_expr acc_expr v_expr')                
    _ -> (0,expr)

fuse_stencils (Stencil s_1 (Stencil s_2 v_expr)) = (1,Stencil (SComb s_1 s_2) v_expr)
fuse_stencils (Stencil s (ZipT vs)) = (1,ZipT (map (Stencil s) vs))
fuse_stencils (ZipT v_exprs) = 
    let
        (ms,v_exprs') = unzip $ map fuse_stencils v_exprs
    in 
        (if sum ms > 0 then 1 else 0, ZipT v_exprs' )
fuse_stencils v_expr = (0,v_expr)


    

-- map_checks :: TyTraCLAST -> [Int]
-- map_checks ast = filter (/=0) $ map  (\(lhs,rhs) -> n_map_subexprs rhs) ast

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

-- rewriteId expr =  case expr of
--     Vec _ dt   -> Map (Id dt) expr
--     Stencil (SVec sz _ )  (Vec _ dt ) -> Map (Id (SVec sz dt)) expr
--     _ -> expr

-- TODO PUT THIS IN PLACE AND MAKE THIS MONADIC EVERYWHERE    
rewriteIdToFunc :: Expr -> State (Int, [(Name, [Expr])]) Expr
rewriteIdToFunc expr = do
    (ct, fsigs) <- get
    let 
        id_name = ("id_"++(show ct))
        (rexp,in_exp, isId) = case expr of
            Vec _ dt   -> (Map (Id id_name []) expr, dt, True)
            Stencil (SVec sz _ )  (Vec _ dt ) -> (Map (Id id_name []) expr, SVec sz dt, True)
            -- I think this could also be ZipT
            _ -> (expr, expr, False)
    if isId 
        then
            put (ct+1, fsigs++[( "id_"++(show ct), [Tuple [], 
            updateName "" "in" in_exp, 
            updateName "" "out" in_exp
            ])] )
        else
            put (ct, fsigs)            
    return rexp

-- scalarFromVec expr =
--     case expr of
--         Vec _ dt   -> dt
--         Stencil (SVec sz _ )  (Vec _ dt ) -> SVec sz dt
--         ZipT es -> Tuple $ map scalarFromVec es
--         _ -> error $ show expr



get_map :: Expr -> [Expr]
get_map m@(Map _ _) = [m]
get_map m@(Fold _ _ _) = [m] -- cheating
get_map _ = []

-- This only works if the rules eliminate all maps
-- I also want to check if the number did not change anymore
has_map_subexprs :: Expr ->  Int
has_map_subexprs expr = length (everything (++) (mkQ [] get_map) expr) -- > 1

         

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
{-
The additional complexity is to rewrite the result in such a way that I can emit
Fortran from it.    

-}    

{-
4. First decompose the expressions. We rewrite in a variant of ANF: every vector, stencil and function gets a name.


( Vec VT (Scalar VDC DFloat "eta_2"), 
Map (Function "dyn_map_65"  [
    Scalar VDC DFloat "dt_0",
    Scalar VDC DFloat "dx_0",
    Scalar VDC DFloat "dy_0"]) 
    
    (ZipT [Vec VS (SVec 2(Scalar DFloat "un_s_0")),Vec VS (SVec 5(Scalar DFloat "h_s_0")),Vec VS (SVec 2(Scalar DFloat "vn_s_0")),Vec VT (Scalar VDC DFloat "eta_1")]) )
-}

-- This returns the decomposed expressions as a lists of lists
-- Because of the original code, this is guaranteed to be in dependency order.
decomposeExpressions :: TyTraCLAST -> TyTraCLAST -> [TyTraCLAST] 
decomposeExpressions orig_ast ast = 
    let
        bindings = Map.fromList $ map (\(f,s)->(s,f)) orig_ast
    in
        map (\(lhs,rhs) -> (subsitute_exprs bindings lhs rhs )) ast

subsitute_exprs ::  (Map.Map Expr Expr) -> Expr -> Expr -> [(Expr,Expr)]
subsitute_exprs orig_bindings lhs ast = let
        -- ast' is the original expression into which lhs has been substituted
        -- var_expr_pairs are the new intermediate bindings that have been created as a result
        (ast',(_,_,_,var_expr_pairs)) = runState (everywhereM (mkM (subsitute_expr lhs)) ast) (0,orig_bindings,Map.empty,[])
    in 
       var_expr_pairs ++ [ (lhs,ast') ]

subsitute_expr :: Expr -> Expr -> State (Int,Map.Map Expr Expr,Map.Map Expr Expr,[(Expr,Expr)]) Expr
subsitute_expr lhs exp = do
            let 
                (vec_name, decomposeMap,dt) = case lhs of
                    Vec VO  (Scalar _ dt vname) -> (vname, False,dt)
                    Vec VT  (Scalar _ dt vname) -> (vname, False,dt) -- only for noStencilRewrites
                    Tuple exprs -> let
                            vname = intercalate "_" (map (\(Vec _ (Scalar _ _ vname)) -> vname) exprs)
                            expr1 = head exprs
                            (Vec _ (Scalar _ dt _)) = expr1
                        in
                            -- case exp of
                            --     UnzipT _ -> error $ (show lhs) ++ " => " ++ (show exp) -- (vname,False,dt)
                            --     _ -> 
                            (vname,False,dt)
                    Scalar _ dt sname -> (sname, True,dt)                    
            (ct,orig_bindings,added_bindings,var_expr_pairs) <- get
            let ((ct',orig_bindings', added_bindings',var_expr_pairs'),exp') = case exp of
                      Scalar _ _ _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Const _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Tuple _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Vec _ _  -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Id _ _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Function _ _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      SVec _ _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      SComb _ _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      PElt _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      ZipT _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Fold _ _ _ -> ((ct,orig_bindings,added_bindings,var_expr_pairs),exp)
                      Map _ _ -> if decomposeMap 
                        then
                            let 
                                var = Vec VT (Scalar VT dt ("var_"++vec_name++"_"++(show ct))) 
                            in
                                maybeAddBinding var exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                        else
                            ((ct,orig_bindings, added_bindings,var_expr_pairs),exp)                      
                      MapS _ (Function _ nms) -> let
                            f_expr = Function ("f_maps_"++vec_name++"_"++(show ct)) nms
                        in                            
                            maybeAddBinding f_expr exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      ApplyT fs -> let
                            nmss = concatMap getNonMapFoldArgs fs
                            f_expr = Function ("f_applyt_"++vec_name++"_"++(show ct)) nmss
                        in
                            maybeAddBinding f_expr exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      Comp (Function _ nms1) (Function _ nms2) -> let
                            f_expr = Function ("f_comp_"++vec_name++"_"++(show ct)) (nms1++nms2)
                        in
                            maybeAddBinding f_expr exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      Comp (PElt idx) (Function _ nms2) -> let
                        -- I think the vec_name here is unique so no need for ++"_"++(show idx)
                            f_expr = Function ("f_pelt_"++vec_name++"_"++(show ct)) nms2
                        in
                            maybeAddBinding f_expr exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      FComp (Function _ nms1) (Function _ nms2) -> let
                            f_expr = Function ("f_fcomp_"++vec_name++"_"++(show ct)) (nms1++nms2)
                        in
                            maybeAddBinding f_expr exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      Stencil (SVec _ _ ) v_exp -> let
                            dt_exp = getDType v_exp
                            var = Vec VS (setName (Single ("svec_"++vec_name++"_"++(show ct))) dt_exp)
                        in
                            maybeAddBinding var exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      Stencil (SComb _ _) v_exp -> let
                            dt_exp = getDType v_exp
                            var = Vec VS (setName  (Single ("svec_"++vec_name++"_"++(show ct))) dt_exp)
                        in
                            maybeAddBinding var exp (ct,orig_bindings, added_bindings, var_expr_pairs)
                      UnzipT map_exp -> ((ct,orig_bindings, added_bindings,var_expr_pairs),exp)  -- error $ show map_exp  
                      _ -> let
                              var = Vec VT (Scalar VT dt ("vec_"++vec_name++"_"++(show ct)))
                           in
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
            ((ct,orig_bindings, added_bindings, var_expr_pairs)
            , added_name )
        else 
            if Map.member exp orig_bindings 
                then
                    let
                        orig_name = orig_bindings ! exp                    
                    in
                        ((ct,Map.delete exp orig_bindings, Map.insert exp var added_bindings, var_expr_pairs++[(orig_name,exp)])
                        , orig_name )
                else                    
                    ((ct+1,orig_bindings, Map.insert exp var added_bindings, var_expr_pairs++[(var,exp)])
                    , var )            


getNonMapFoldArgs :: Expr -> [Expr]
getNonMapFoldArgs exp = everything (++) (mkQ [] (getNonMapFoldArgs')) exp

getNonMapFoldArgs' :: Expr -> [Expr]
getNonMapFoldArgs' (Function _ nms) = nms
getNonMapFoldArgs' _ = []

-- analyse_stage_exprs_for_args ::  (Map.Map Expr Expr) -> Expr -> Expr -> [(Expr,Expr)]
-- analyse_stage_exprs_for_args orig_bindings lhs ast = let
--         (ast',(_,_,_,var_expr_pairs)) = runState (everywhereM (mkM (subsitute_expr lhs)) ast) (0,orig_bindings,Map.empty,[])
--     in 
--        var_expr_pairs ++ [ (lhs,ast') ]

{- When the stages have been formed, some VT variables are actually In or Out args of a stage, so they must become VI or VO.
To solve the issue with VT in the stages, we need the following analysis:

- if we encounter a VT on the RHS before we encounter one on the LHS, then that VT becomes VI. I don't think it is possible to encounter a VT on the LHS after encountering one on the RHS.
- if we encounter a VT on the LHS but never on the RHS, then that VT becomes VO
- if we encounter a VT on the LHS an later on the RHS, then that VT stays VT
So we need to maintain a map from the name to its VE and a bit to say it was LHS or RHS
e.g. String => Either VT

We need a fold over [(lhs_expr,rhs_expr)] wit a map as accumulator

\acc (lhs_expr,rhs_expr) -> let
        m_lhs_vts = find_VT_in_expr lhs_expr
        m_rhs_vts = find_VT_in_expr rhs_expr
        
        lhs_vt_name = (name lhs_vt)
        acc' = if lhs_vt_name `Map.member` acc then 
            -- update the map, append LHS
        else 
            Map.insert lhs_vt_name [LHS] acc
        acc'' = if rhs_vt_name `Map.member` acc' then 
            -- update the map, append RHS
        else 
            Map.insert rhs_vt_name [RHS] acc'

    in 
        acc''    
Maybe the easiest way is to built the LHS/RHS access sequence for every VT var
[LHS] => VO
[LHS,RHS,RHS,...] => VT
[LHS,LHS] => Error!

[RHS] => VI
[RHS,LHS] => Error
[RHS,RHS,...] => VI
The list can't be empty, by construction. So:

pos:r_pos_lst =  pos_lst
| pos == LHS 
    | null r_pos_lst 
            = VO
    | null (filter (==LHS) r_pos_lst) = VT
    | otherwise = error "variable assigned to more than once"
| otherwise -- means it is RHS
    | null (filter (==LHS) r_pos_lst) = VI
    | otherwise = error $ "In arg " ++ var_name ++" assigned to"

-}

data Pos = LHS| RHS
-- analyse_exprs_for_stage_args :: Expr -> Expr -> State (Int,Map.Map Expr Expr,Map.Map Expr Expr,[(Expr,Expr)]) Expr
-- analyse_exprs_for_stage_args lhs exp = do
--     let 
--     return exp'


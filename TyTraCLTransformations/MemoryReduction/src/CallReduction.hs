module CallReduction (reduceCalls ) where

import Data.Generics (Data, Typeable, mkQ, mkT, mkM, gmapQ, gmapT, everything, everywhere, everywhere', everywhereM)
import qualified Data.Map.Strict as Map
import Data.List (intercalate,foldl')
import Data.Char (isAlphaNum)
import TyTraCLAST
import Warning ( warning )

{-# ANN module "HLint: ignore Use camelCase" #-}
{-# ANN module "HLint: ignore Use lambda-case" #-}
{-# ANN module "HLint: ignore Use any" #-}
{-# ANN module "HLint: ignore Use :" #-}

(!) :: Ord k => Map.Map k a -> k -> a
(!) = (Map.!)

reorderArgs = True 

{-
To group all identical args, we need an additional step: we need to reorder v_s and f_s so that arguments with identical vectors are consecutive.
I think this is OK because we infer the signatures only later and the opaques are not affected. 

First we need to make an inventory of all unqiue args in v_s. Maybe there is a "unique" function for this but it is rather easy to write

unique_v_s = uniques v_s

reordered_f_s_v_s = map (\unique_v -> filter (\(f,v) -> v == unique_v) (zip f_s v_s)) unique_v_s
(reordered_f_s, reordered_v_s) = unzip reordered_f_s_v_s

and then we need to filter v_s on these unique args that we get 

TODOS: 
* Because the reduction with reordering messes up the order we need to keep a nested list of the original order
So we need a list idx_s which originally is simple (take length f_s $ [0 ..])
I think this needs to be returned from reorder_call_args

* Also, MapS (Comp (PElts [i,j,...] f)) has a different type from [MapS (Comp (Pelt i) f), MapS (Comp (Pelt j) f),...] 

RApplyT can take care of that as well: example:

(Comp Pelt i1 f1, Maps Comp Pelt i2 f2, h1, Comp Pelt j1 f1, Maps Comp Pelt j2 f2, Maps Comp Pelt k2 k2, Comp Pelt k1 f1, h2) ::
(b1 -> a1_i1, b2 -> SVec a2_i2, b3 -> c3, b1 -> a1_j1, b2 -> a2_j2, b2 -> a2_k2, b1 -> a1_k1, b4 -> c4)

\(x1,x2,x3,x4,x5,x6,x7,x8) -> (y1 :: a1_i1, y2:: a2_i2, y3::c3, y4::a1_j1, y5::a2_j2, y6::a2_k2, y7::a1_k1, y8::c4) 

After transform:

(Comp Pelts [i1,j1,k1] f1, Maps Comp Pelts [i2,j2,k2] f2, h1, h2) ::
(b1 -> (a1_i1,a1_j1,a1_k1), b2 -> SVec (a2_i2,a2_j2,a2_k2), b3 -> c3, b4 -> c4)

\(x1',x2',x3',x4') -> (y1'::Tup (a1_i1,a1_j1,a1_k1), y2'::SVec (Tup (a2_i2,a2_j2,a2_k2)), y3':: c3, y4':: c4)

The index sequence is [[0,3,6],[1,4,5],2,7]

What RApplyT must do is turn this into 

\(x1',x2',x3',x4') -> (y1 :: a1_i1, y2:: a2_i2, y3::c3, y4::a1_j1, y5::a2_j2, y6::a2_k2, y7::a1_k1, y8::c4) 

which is done by unpacking:

Tup (y11,y12,y13) = y1'
-- assuming it is an SVec of 2 elts
SVec [Tup (y210,y220,y230),Tup (y211,y221,y231)] = y2'
y21 = SVec [y210,y211]
y22 = SVec [y220,y221]
y23 = SVec [y230,y231]

and then using the index sequence to recreate

(y11,y21,y3',y12,y22,y23,y13,y4')


-}

reduceCalls :: [Expr] -> [Expr] -> Bool -> ([Expr],[Expr], [[Int]])
reduceCalls f_s' v_s' False = (f_s', v_s', map (\x ->[x]) $ take (length f_s') [0 .. ])
reduceCalls f_s' v_s' True = let
        idx_s' = take (length f_s') [0 .. ]
        (f_s,v_s,idx_s)
            | reorderArgs = reorder_call_args f_s' v_s' idx_s'
            | otherwise = (f_s',v_s', idx_s')
        t_v_s = group_identical_args v_s -- list of tuples (v,count)
        (f_s_g, t_v_s_g, idx_s_g) = group_pelt_terms f_s t_v_s idx_s [] [] [] -- this also needs idx_s and return the grouped version
        v_s_g = map fst t_v_s_g -- the vectors
    in
        (f_s_g, v_s_g, idx_s_g)     

-- I think I need erase_maps_svec_names in uniques
reorder_call_args f_s v_s idx_s = let
        unique_v_s = uniques v_s
        reordered_f_s_v_s_idx_s = map (\unique_v -> filter (\(_,v,_) -> erase_maps_svec_names v == erase_maps_svec_names unique_v) (zip3 f_s v_s idx_s)) unique_v_s 
        flattened_reordered_f_s_v_s_idx_s = foldl' (++) [] reordered_f_s_v_s_idx_s
    in        
        -- error $ show $ 
        unzip3 flattened_reordered_f_s_v_s_idx_s 
        -- error $ show unique_v_s ++ "\n" ++ show v_s
        
{-
First of all we need to create v_s' which is a version of v_s where the 2nd arg of every SVec is  replaced by e.g. Const :
SVec sz _ -> SVec sz (Const sz) 
We can do this with everywhere
-}
erase_maps_svec_names :: Expr -> Expr
erase_maps_svec_names = everywhere (mkT ( \expr -> case expr of
            MapS (SVec sz _) f -> MapS (SVec sz (Const sz)) f
            Stencil (SVec sz _) v -> Stencil (SVec sz (Const sz)) v
            e -> e
        )
    ) 
{-
Next we want to group identical arguments, and we need to know how many, so we have [v1,v1,v2,v3,v3] -> [(v1,2),(v2,1),(v3,2)]
- take the element and put it in the acc: [(v1,1)]
- take the next elt, take first tuple from the acc and see if it matches
-}
group_identical_args :: [Expr] -> [(Expr,Int)]
group_identical_args v =
    let
        r_t_v = foldl' (\acc elt -> 
            if null acc 
                then
                    [(elt,1)]
                else
                    let
                        t:ts = acc
                        (t_e,t_c) = t
                        t_e' = erase_maps_svec_names t_e
                        elt' = erase_maps_svec_names elt
                    in
                        if t_e' == elt' then (t_e,t_c+1):ts else (elt,1):acc
                        ) [] v
    in
        reverse r_t_v

-- Now, what we actually need from this is just the numbers, so we could do snd $ unzip 

{-
I think the possible arguments of ApplyT are:
- Function -> skip
- Id -> skip
- MapS -> test if the 2nd arg is Comp PElt
- Comp -> test if the first arg is PElt
- FComp -> skip because the first arg can never be PElt? 
I guess that there is no bare PElt, as it would be Comp (PElt i) Id; but we can add it and see if there is an error
- PElt

What we do is: let's say the list of elt counts is elt_counts
So I think we take the applyt args and the vectors
t_v_s = group_identical_args v_s

-}

group_pelt_terms :: [Expr] -> [(Expr,Int)] -> [Int] -> [Expr] -> [(Expr,Int)] -> [[Int]] -> ([Expr],[(Expr,Int)],[[Int]])
group_pelt_terms f_s t_v_s idx_s f_s_g t_v_s_g idx_s_g = 
    if null t_v_s 
        then (f_s_g, t_v_s_g, idx_s_g)
        else
            let
                (t_e, elt_count) : t_v_s' = t_v_s
                f_s_elts = take elt_count f_s
                idx_s_elts = take elt_count idx_s
                f_s' = drop elt_count f_s
                idx_s' = drop elt_count idx_s
                (f_s_g', t_v_s_g', idx_s_g') = if is_PElt_series f_s_elts -- <test if f_s_elts is a series of PElt calls to the same f or same in a MapS>
                    then 
                        let
                            f_s_pelts = replace_with_PElts f_s_elts
                        in
                            (f_s_g++f_s_pelts,t_v_s_g++[(t_e,1)], idx_s_g++[idx_s_elts])
                    else -- <add the orginals to f_s' and to t_v_s'>
                        (f_s_g++f_s_elts,t_v_s_g++[(t_e,elt_count)], idx_s_g++[idx_s_elts])
            in
                group_pelt_terms f_s' t_v_s' idx_s' f_s_g' t_v_s_g' idx_s_g'

{-
We test if the series of expressions that are args of AppluT are Comp PElt ... or Maps of Comp PElt
If so, we can group them    
-}
is_PElt_series :: [Expr] -> Bool
is_PElt_series [] = error "PELT series can't be empty!";
is_PElt_series (f_s_elt:f_s_elts) = case f_s_elt of
    MapS (SVec k _) (Comp (PElt _) f) -> null $ filter (
        \elt -> case elt of
                MapS (SVec k _) (Comp (PElt _) f) -> False
                _ -> True
            ) f_s_elts -- If all remaining elts are MapS sv (Comp (PElt _) f        
    Comp (PElt i) f -> null $ filter (\elt -> case elt of
        Comp (PElt _) f -> False
        _ -> True
        ) f_s_elts -- If all remaining elts are MapS sv (Comp (PElt _) f
    _ -> False

replace_with_PElts :: [Expr] -> [Expr] -- In principle the return value is a single Expr but in case it fails it could be the original
replace_with_PElts [] = [] -- keep hlint happy
replace_with_PElts (f_s_elt:f_s_elts) = case f_s_elt of 
    MapS sv@(SVec k _) (Comp (PElt i) f) -> let
            idxs = map (\(MapS (SVec k _) (Comp (PElt j) f)) -> j) f_s_elts
        in
            [MapS sv (Comp (PElts (i:idxs)) f)]
    Comp (PElt i) f -> let
            idxs = map (\(Comp (PElt j) f) -> j) f_s_elts
        in
            [Comp (PElts (i:idxs)) f]
    _ -> error "Should be MapS sv (Comp (PElt i) f or Comp (PElt i) f"

uniques :: [Expr] -> [Expr]
uniques = fst . foldl' (
    \(unique_lst, unique_lst') elt -> 
        let elt' = erase_maps_svec_names elt in
            if elt' `elem` unique_lst' 
                then (unique_lst,unique_lst') 
                else (unique_lst++[elt],unique_lst'++[elt'])
    ) ([],[]) 



{-
WV 20210820 grouping map calls is now done in regroupTuples in Transforms, much cleaner

As a final step, I should merge the remaining Comp PElt calls into Comp PElts, this is exactly like in callReduction except that we are not working on the arguments of ApplyT

1. We go through the AST an look for calls to Comp PElt i f where f is common, this is done by reordering as in callReduction.
2. Then we replace that by PElts, so we have
f_pelts_... = Comp PElts idxs (f ...)

However, the next bit is different: we need to keep a list of the grouped f_pelt calls, and what we do is 
1. Find Map expressions with grouped calls: Map (f ...) -> if f `elem` grouped_pelt_calls then store the RHS in a new list, map_calls_with_grouped_pelt; but we need the LHS as well because we need the link with the PElt index. So we should store both.
2. Then we check if these Map calls in the list have common args, both non-map and map. Remove all others.The final step is to convert the calls with common args into a single call:

Tuple (v1, v2, v3, ...) = UnzipT (Map (f_pelts ... ) ...)

- The tricky bit is to link the output vector with the correct index; 
- We also must make sure the types match.
    PElts returns a Tuple so Map f_Pelts will be [(...,...,...)] so we need indeed UnzipT to get the final tuple of vectors

I think this might require a change to the code generator too as so far I have assumed no tuples on the LHS
-}

groupMapCalls ast = let
        (pelt_map, f_pelt_names) = find_pelt_calls ast
        (ast',f_pelts) = replace_pelt_calls_by_pelts_call pelt_map ast
        grouped_maps = group_map_calls f_pelt_names ast'
        ast'' = reduce_map_calls f_pelts pelt_map f_pelt_names grouped_maps ast'
    in
        -- error $ show f_pelts
        -- error $ (unlines $ map show $ Map.toList pelt_map) ++ "\n\n" ++ (unlines $ map show $ Map.toList f_pelt_names) ++ "\n\n" ++ (show f_pelts) ++ "\n\n" ++ (unlines $ map show $ Map.toList grouped_maps)
        ast''

find_pelt_calls ::  [ (Expr, Expr)] -> (Map.Map Expr [Int], Map.Map Expr (Int,Expr))
find_pelt_calls =
    foldl' (\(pelt_map_, f_pelt_names_) (lhs,rhs) -> 
        case rhs of 
            Comp (PElt i) f -> let
                    pelt_map' = if Map.member f pelt_map_ 
                        then Map.adjust (++[i]) f pelt_map_
                        else Map.insert f [i] pelt_map_
                    f_pelt_names' = Map.insert lhs (i,f) f_pelt_names_
                in
                    (pelt_map',f_pelt_names')    
            _ -> (pelt_map_,f_pelt_names_)
    ) (Map.empty,Map.empty)

    -- (pelt_map, f_pelt_names) = find_pelt_calls ast

-- Now replace the first occurrence of the Comp PElt call with Comp PElts remove the Comp PElt calls that are not first occurrence. 
-- We should return the name of the function that becomes PElts    
replace_pelt_calls_by_pelts_call pelt_map =
    foldl' (\(ast_,lhs_) (lhs,rhs) -> 
        case rhs of 
            Comp (PElt i) f -> if i == head (pelt_map ! f) 
                then (ast_++[(lhs, Comp (PElts (pelt_map ! f)) f)],lhs)
                else (ast_,  lhs_ )
            _ -> (ast_++[(lhs,rhs)],lhs_)
    ) ([],Nil)

-- e.g f_pelt_f_1_6 and we make it into f_pelts_f_1_g_1_h_1_6

rename_to_PElts lhs@(Function f_name f_args ) = let
    
    f_name' = if take 6 f_name == "f_pelt" 
        then 
                "f_pelts"++ drop 6 f_name
        else
                f_name       
    in
        Function f_name' f_args

rename_to_PElts lhs = error $ show lhs

append_to_PElts_name (Function pelts_name pelts_args ) (Function f_name f_args ) = 
    let
    
        f_name' = if take 6 f_name == "f_pelt" 
            then 
                let
                    chunks = split_ (drop 7 f_name)
                in
                    intercalate "_" $ init chunks
                    -- drop 7 f_name
            else
                    "XXX"       
        pelts_name_head =  intercalate "_"  $ init $ split_ pelts_name --
        pelts_name' = pelts_name_head++":"++f_name
    in
        Function pelts_name' pelts_args

append_to_PElts_name lhs lhs_ = error $ show lhs ++ show lhs_

rename_from_PElts lhs@(Function f_name f_args ) = let
    
    f_name' = if take 7 f_name == "f_pelts" 
        then 
            let
                chunks = split_ (drop 7 f_name)
            in
                "f_pelt_"++ head chunks ++ "_" ++ head (tail chunks) ++ "_" ++ last chunks 
        else
                f_name       
    in
        Function f_name' f_args
rename_from_PElts lhs = error $ show lhs

-- Map calls with identical v_expr and an f_expr which has the same f    
group_map_calls f_pelt_names = 
    foldl' (\grouped_maps_ (lhs,rhs) ->
        case rhs of
            Map f_expr v_expr -> if Map.member f_expr f_pelt_names 
                    then
                        let
                            (i,f) = f_pelt_names ! f_expr
                        in
                            if not (Map.member f grouped_maps_)
                                then Map.insert f [(lhs,i,v_expr)] grouped_maps_
                                else 
                                    let
                                        (_,_,v_expr') = head $ grouped_maps_ ! f
                                    in
                                        if v_expr == v_expr' then
                                                Map.adjust (++[(lhs,i,v_expr)]) f grouped_maps_
                                            else grouped_maps_
                    else grouped_maps_
            _ -> grouped_maps_
        ) Map.empty 

reduce_map_calls f_pelts pelt_map f_pelt_names grouped_maps ast = 
    snd $ foldl' (\(first_occ,ast_) (lhs,rhs) ->
        case rhs of
            Map f_expr v_expr -> if Map.member f_expr f_pelt_names 
                    then
                        let
                            (i,f) = f_pelt_names ! f_expr
                            lhs_idx_s = grouped_maps ! f
                        in
                            if first_occ
                                then 
                                    let
                                        map_pelts_call = create_map_pelts_call f_pelts pelt_map f_pelt_names grouped_maps lhs rhs
                                    in 
                                        (False,ast_++[map_pelts_call])
                                else (first_occ,ast_)
                    else 
                        (first_occ,ast_++[(lhs,rhs)])
            _ -> (first_occ,ast_++[(lhs,rhs)])
        ) (True,[]) ast

-- what we need is the ordering from pelt_map and the index from grouped_maps
-- pelt_map:  f => [i,...]
-- grouped_maps: f => [(lhs,i,v_expr)]
-- f_pelts is the f_expr for the Map          
create_map_pelts_call f_pelts pelt_map f_pelt_names grouped_maps lhs rhs@(Map f_expr v_expr) = 
    if f_expr == f_pelts 
        then     
            let
                -- what is f?
                (i,f)  = f_pelt_names ! f_pelts
                -- what is the order of indices?
                idxs = pelt_map ! f
                -- what is the grouped_maps entry?
                grouped_maps_entry = grouped_maps ! f    
                ordered_map_entry = map (\idx -> head $ filter (\(lhs_,idx_,v_expr) -> idx_==idx) grouped_maps_entry) idxs
                -- get the lhs vecs
                lhs_vecs = map (\(lhs_,_,_) -> lhs_) ordered_map_entry
            in
                (Tuple lhs_vecs, UnzipT (Map f_pelts v_expr))
        else
            (lhs,Map f_expr v_expr)
create_map_pelts_call f_pelts pelt_map f_pelt_names grouped_maps lhs rhs = (lhs,rhs)


{-
(ApplyT,ZipT): [
    (MapS (SVec 2 (Const 2)) (Comp (PElt 0) (Function "velfg_map_76" [SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")])),
        Stencil (SVec 2 (Const 2)) (ZipT [Stencil (   
    (MapS (SVec 2 (Const 2)) (Comp (PElt 1) (Function "velfg_map_76" [SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")])),
        Stencil (SVec 2 (Const 2)) (ZipT [Stencil (SVec 5 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "u_0")),Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DFloat "v_0")),Stencil (SVec 4 (Scalar VDC DInt "s3")) (Vec VI (Scalar VDC DFloat "w_0"))])),
    (MapS (SVec 2 (Const 2)) (Comp (PElt 2) (Function "velfg_map_76" [SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")])),
        Stencil (SVec 2 (Const 2)) (ZipT [Stencil (SVec 5 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "u_0")),Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DFloat "v_0")),Stencil (SVec 4 (Scalar VDC DInt "s3")) (Vec VI (Scalar VDC DFloat "w_0"))])),

        ZipT: [
            
                Stencil (SVec 2 (Const 2)) (ZipT [Stencil (SVec 5 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "u_0")),Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DFloat "v_0")),Stencil (SVec 4 (Scalar VDC DInt "s3")) (Vec VI (Scalar VDC DFloat "w_0"))])),   
            
                Stencil (SVec 2 (Const 2)) (ZipT [Stencil (SVec 5 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "u_0")),Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DFloat "v_0")),Stencil (SVec 4 (Scalar VDC DInt "s3")) (Vec VI (Scalar VDC DFloat "w_0"))])),
            
                Stencil (SVec 2 (Const 2)) (ZipT [Stencil (SVec 5 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DFloat "u_0")),Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DFloat "v_0")),Stencil (SVec 4 (Scalar VDC DInt "s3")) (Vec VI (Scalar VDC DFloat "w_0"))]))
        ]
ApplyT: [
    (MapS (SVec 2 (Const 2)) (Comp (PElt 0) (Function "velfg_map_76" [SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")])),
        
    (MapS (SVec 2 (Const 2)) (Comp (PElt 1) (Function "velfg_map_76" [SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")])),
        
    (MapS (SVec 2 (Const 2)) (Comp (PElt 2) (Function "velfg_map_76" [SVec 153 (Scalar VDC DFloat "dx1_0"),SVec 152 (Scalar VDC DFloat "dy1_0"),SVec 94 (Scalar VDC DFloat "dzn_0"),SVec 94 (Scalar VDC DFloat "dzs_0")])),
        
-}

-- (map f_1 v_1, map f_2 v_2) = map (applyt (f_1,f_2)) (zipt (v_1, v_2))    
-- WV 2021-07-27: For the case of 
-- map (applyt ((pelt i) . f,(pelt j). f)) (zipt (v, v))    
-- and of
-- map (applyt (maps sv ((pelt i) . f),maps sv ((pelt j). f))) (zipt (v, v)) 
-- and any combination of these for other f' and v' and expresions without pelt
-- we can rewrite this as
-- map (apply ((pelts [i,j]) . f) v 
-- and in general
-- -- map (applyt ((pelts [i,j]) . f,g, maps sv ((pelts [i',j',k']) . h))) (zipt (v,u,w))
-- rewriteZipTMap es =  let
--         f_s = map (\(Map f v) -> f) es
--         v_s = map (\(Map f v) -> v) es
--         fv_s = zip f_s v_s
--     in
--         warning (Map (ApplyT f_s) (ZipT v_s)) ("(ApplyT,ZipT): "++ show fv_s) 

split_ :: String -> [String]
split_ s =  let 
                (strs,str) = foldl' (\(strs_,str_) c -> if c == '_' then (strs_++[str_],"") else (strs_,str_++[c])) ([],"") s 
            in
                strs++[str]

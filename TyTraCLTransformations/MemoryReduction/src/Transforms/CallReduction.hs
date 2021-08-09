module CallReduction (reduceCalls) where

import Data.Generics (Data, Typeable, mkQ, mkT, mkM, gmapQ, gmapT, everything, everywhere, everywhere', everywhereM)
import qualified Data.Map.Strict as Map
import Data.List (intercalate,foldl')

import TyTraCLAST
import Warning ( warning )

{-# ANN module "HLint: ignore Use camelCase" #-}
{-# ANN module "HLint: ignore Use lambda-case" #-}
{-# ANN module "HLint: ignore Use any" #-}
(!) :: Ord k => Map.Map k a -> k -> a
(!) = (Map.!)

reduceCalls :: [Expr] -> [Expr] -> Bool -> ([Expr],[Expr])
reduceCalls f_s v_s False = (f_s, v_s)
reduceCalls f_s v_s True = let
        t_v_s = group_identical_args v_s
        (f_s_g, t_v_s_g) = group_pelt_terms f_s t_v_s [] []
        v_s_g = map fst t_v_s_g 
    in
        (f_s_g, v_s_g)
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
            let
                t:ts = acc
                t_e = fst t
                t_e' = erase_maps_svec_names t_e
                elt' = erase_maps_svec_names elt
            in
                if t_e' == elt' then (elt,snd t+1):ts else acc
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

group_pelt_terms :: [Expr] -> [(Expr,Int)] -> [Expr] -> [(Expr,Int)] -> ([Expr],[(Expr,Int)])
group_pelt_terms f_s t_v_s f_s_g t_v_s_g = 
    if null t_v_s 
        then (f_s_g, t_v_s_g)
        else
            let
                (t_e, elt_count) : t_v_s' = t_v_s
                f_s_elts = take elt_count f_s
                f_s' = drop elt_count f_s
                (f_s_g', t_v_s_g') = if is_PElt_series f_s_elts -- <test if f_s_elts is a series of PElt calls to the same f or same in a MapS>
                    then 
                        let
                            f_s_pelts = replace_with_PElts f_s_elts
                        in
                            (f_s_g++f_s_pelts,t_v_s_g++[(t_e,1)])
                    else -- <add the orginals to f_s' and to t_v_s'>
                        (f_s_g++f_s_elts,t_v_s_g++[(t_e,elt_count)])
            in
                group_pelt_terms f_s' t_v_s' f_s_g' t_v_s_g'            

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
replace_with_PElts (f_s_elt:f_s_elts) = case f_s_elt of -- Placeholder
    MapS sv@(SVec k _) (Comp (PElt i) f) -> let
            idxs = map (\(MapS (SVec k _) (Comp (PElt j) f)) -> j) f_s_elts
        in
            [MapS sv (Comp (PElts (i:idxs)) f)]
    Comp (PElt i) f -> let
            idxs = map (\(Comp (PElt j) f) -> j) f_s_elts
        in
            [Comp (PElts (i:idxs)) f]
    _ -> error "Should be MapS sv (Comp (PElt i) f or Comp (PElt i) f"

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
-- map (applyt ((pelts [i,j]) . f,g, maps sv ((pelts [i',j',k']) . h))) (zipt (v,u,w))
rewriteZipTMap es =  let
        f_s = map (\(Map f v) -> f) es
        v_s = map (\(Map f v) -> v) es
        fv_s = zip f_s v_s
    in
        warning (Map (ApplyT f_s) (ZipT v_s)) ("(ApplyT,ZipT): "++ show fv_s) 
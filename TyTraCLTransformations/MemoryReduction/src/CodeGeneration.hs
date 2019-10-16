module CodeGeneration (    
    inferSignatures, 
    -- generatedOpaqueFunctionDefs, 
    -- createStages, 
    -- generateDefs, 
    -- generateNonSubDefs, 
    -- generateStageKernel, 
    -- generateMainProgram
    generateFortranCode    
    ) where

import Data.Generics (mkQ, everything, mkM, everywhereM, everywhere, mkT)  
import Control.Monad.State
import qualified Data.Map.Strict as Map
import Data.List (intercalate, nub, partition, zip4)

import TyTraCLAST
import ASTInstance (functionSignaturesList, stencilDefinitionsList, mainArgDeclsList, origNamesList, scalarisedArgsList)

(!) = (Map.!)

{-
About the duplicated arguments: it's actually very simple. 
I keep them all until the very last moment of code generation, and only then do I remove the duplicates

But also I should make sure there are no duplicates after the decomposeExpressions pass
So I should keep a table of the named expressions and only make a new one if it's not already there

Furthermore I should _not_ flatten the expressions in the signatures until I do code generation

And I must throw out the counting-based approach

-}


{-
f1 :: acc1_T -> SVec 3 v_T -> v_T
f1 acc1_T ::  SVec 3 v_T -> v_T
maps : (a -> b) -> SVec k a -> SVec k b
maps : (SVec 3 v_T -> v_T) 

So, given an intermediate function definition, what is its signature?
e.g.


We have

 ("f1", [Scalar VDC DInt "acc1"],[SVec 3 DInt "v_s"],[Scalar VDC DInt "v"]]),

-}

functionSignatures :: Map.Map Name FSig 
functionSignatures =  Map.fromList functionSignaturesList

mainArgDecls :: Map.Map Name String
mainArgDecls =  Map.fromList mainArgDeclsList

stencilDefinitions :: Map.Map Name [Integer]
stencilDefinitions  =  Map.fromList stencilDefinitionsList

origNames :: Map.Map Name (Map.Map Name Name)
origNames = Map.fromList $ map (\(k,v)-> (k, Map.fromList v)) origNamesList

scalarisedArgs :: Map.Map Name [(Name,Integer)]
scalarisedArgs = Map.fromList scalarisedArgsList 



-- For info only
inferSignatures :: TyTraCLAST -> [(Name,FSig)]
inferSignatures ast = Map.toList (inferSignaturesMap ast)

-- We must update this map with the new signatures, so probably use the state monad
-- let's be old-school contrarian and use fold
inferSignaturesMap :: TyTraCLAST -> Map.Map Name FSig
inferSignaturesMap = foldl inferSignature functionSignatures

inferSignature ::  (Map.Map Name FSig) -> (Expr,Expr) -> Map.Map Name FSig
inferSignature functionSignatures ast_tup =
    let
        (lhs,rhs) = ast_tup
        (fname,mfsig) = case lhs of
            Function fname _ -> (fname,Just $ getFunctionSignature rhs functionSignatures)
            _ -> ("",Nothing)
    in 
        case mfsig of
            Just fsig -> Map.insert fname fsig functionSignatures 
            Nothing -> functionSignatures

getFunctionSignature :: Expr ->  (Map.Map Name FSig) -> FSig
getFunctionSignature rhs functionSignatures =
    let
        fsig = case rhs of
            MapS (SVec sv_sz _ ) (Function fname _) -> deriveSigMaps sv_sz fname functionSignatures
            Comp (Function f1 _) (Function f2 _) -> deriveSigComp f1 f2 functionSignatures
            Comp (PElt idx) (Function fname _) -> deriveSigPELt idx fname functionSignatures
            FComp (Function f1 _) (Function f2 _) -> deriveSigFComp f1 f2 functionSignatures
            ApplyT fs -> deriveSigApplyT fs functionSignatures
        -- flattened_fsig = map flattenSigExpr fsig -- this is [Expr]
    in
        -- flattened_fsig            
        fsig

-- ApplyT can only arise because of Map, so it can't be Fold.       
-- Arguments to ApplyT can be Function, Id, what else? Let's assume that is all
-- The signature of the derived function should be grouped   
deriveSigApplyT :: [Expr] -> (Map.Map Name FSig) -> FSig      
deriveSigApplyT fs functionSignatures =
    let
        fsigs = getFSigs fs functionSignatures        
        -- ApplyT simply applies a number of functions to a number of elements in a tuple
        -- So the signature is the combination of all signatures


        -- So we gave for every function a list [Expr, Expr, Expr]
        -- I need to combine this into a single list. To do so, I have to remove the Tuple and then concat. Easy:
        (nsl, msl, osl) = unzip3 $ map (\[nm,m,o] -> (nm,m,o)) fsigs
        (ns, ms, os) = (Tuple nsl,Tuple msl,Tuple osl)
        -- fnsl = removeDuplicateArgs $ concat $ map (\nm -> case nm of
        --             Tuple es -> es
        --             _ -> [nm]
        --             ) nsl
        -- ns 
        --     | length fnsl == 1 = head fnsl    
        --     | otherwise = Tuple fnsl

        -- fmsl = concat $ map (\nm -> case nm of
        --         Tuple es -> es
        --         _ -> [nm]
        --         ) msl
        -- ms
        --     | length fmsl == 1 = head fmsl    
        --     | otherwise = Tuple fmsl   
            
        -- fosl = concat $ map (\nm -> case nm of
        --         Tuple es -> es
        --         _ -> [nm]
        --         ) osl
        -- os
        --     | length fosl == 1 = head fosl    
        --     | otherwise = Tuple fosl    
              
        -- (nsl,msl,osl) = foldl (
        --     \(nsl,msl,osl) fsig -> case fsig of
        --         [nms,ms,os] -> if nms /= Tuple [] 
        --             then
        --                 ( nsl++[nms],msl++[ms],osl++[os] )
        --             else
        --                 ( nsl,msl++[ms],osl++[os] )    
        --         _ -> (nsl,msl,osl)
        --     ) ([],[],[]) fsigs
        -- nsl' = filter(/= (Tuple [])) nsl -- non-empty
        -- ns = if length nsl' == 1 then head nsl' else Tuple (removeDuplicateArgs nsl')
        -- msl' =  filter(/= (Tuple [])) msl
        -- ms = if length msl' == 1 then head msl' else Tuple msl' -- (removeDuplicateArgs  msl')
        -- osl' =  filter(/= (Tuple [])) osl
        -- os = if length osl' == 1 then head osl' else Tuple osl' -- (removeDuplicateArgs  osl')
    in
        [ns,ms,os] 

deriveSigMaps :: Int -> Name -> (Map.Map Name FSig) -> FSig
deriveSigMaps sv_sz fname functionSignatures =
    let
        fsig = case Map.lookup fname functionSignatures  of
            Just sig -> sig
            Nothing -> error $ "deriveSigMaps: no entry for "++fname
    in            
        case fsig of
            [nms,ms,os] -> let
{-
maps :: SVec sz a -> c->a->b -> c->SVec sz a -> SVec sz b
I wonder, why not keep the name from the original expression?
Let's try that
-}                
                    ms' = SVec sv_sz ms -- (setName ("sv_"++fname++"_in") ms)
                    os' = SVec sv_sz os -- (setName ("sv_"++fname++"_out") os)
                in
                    [nms,ms',os']
            [nms,as,ms,os] -> let
                    ms' = SVec sv_sz ms -- (setName  ("sv_"++fname++"_in") ms)
                    os' = SVec sv_sz os -- (setName ("sv_"++fname++"_out") os)
                in
                    [nms,as,ms',os']

deriveSigComp :: Name -> Name -> (Map.Map Name FSig) -> FSig
deriveSigComp fname1 fname2 functionSignatures =      
    let
        fsig1 = case Map.lookup fname1 functionSignatures  of
            Just sig1 -> sig1
            Nothing -> error $ "deriveSigComp: no entry for "++fname1
        fsig2 = case Map.lookup fname2 functionSignatures  of
            Just sig2 -> sig2
            Nothing -> error $ "deriveSigComp: no entry for "++fname2
        [nms1,ms1,os1] = fsig1
        [nms2,ms2,os2] = fsig2
-- the output of f2 is used as the input for f1
        (nms,ms',os') = (Tuple [nms1,nms2], ms2, os1)
            -- combineSigArgs ([nms1,nms2], [ms2], [os1])
        -- nms 
        --     | (nms1 == Tuple []) && (nms2 == Tuple []) = Tuple []
        --     | nms1 == Tuple [] = nms2
        --     | nms2 == Tuple [] = nms1
        --     | otherwise = Tuple $ removeDuplicateArgs [nms1,nms2]
        -- ms' = case ms2 of
        --         Tuple es -> Tuple es -- $ removeDuplicateArgs es
        --         _ -> ms2
        -- os' = os1
    in
        [nms,ms',os']


deriveSigFComp fname1 fname2 functionSignatures =               
    let
        fsig1 = case Map.lookup fname1 functionSignatures  of
            Just sig1 -> sig1
            Nothing -> error $ "deriveSigFComp: no entry for "++fname1
        fsig2 = case Map.lookup fname2 functionSignatures  of
            Just sig2 -> sig2
            Nothing -> error $ "deriveSigFComp: no entry for "++fname2
        [nms1,as,ms1,os1] = fsig1
        [nms2,ms2,os2] = fsig2
    -- the output of f2 is used as the input for f1
    -- the nms1 and nms2 should probably a tuple of tuples
        (nms,ms',os') = (Tuple [nms1,nms2], ms2, os1)
            -- combineSigArgs ([nms1,nms2], [ms2], [os1])
        -- nms 
        --     | (nms1 == Tuple []) && (nms2 == Tuple []) = Tuple []
        --     | nms1 == Tuple [] = nms2 -- which could be a Tuple
        --     | nms2 == Tuple [] = nms1
        --     | (nms2 == Tuple es2) && (nms1 == Tuple es1) = Tuple $ removeDuplicateArgs  $ es1++es2
        --     | (nms2 == Tuple es2)  = Tuple $ removeDuplicateArgs  $ [nms1]++es2
        --     | (nms1 == Tuple es1) = Tuple $ removeDuplicateArgs  $ es1++[nms2]
        --     | otherwise = Tuple $ removeDuplicateArgs [nms1,nms2]
        -- ms' = case ms2 of
        --     Tuple es -> ms2 -- Tuple $ removeDuplicateArgs es
        --     _ -> ms2

        -- os' = (nms,ms',_) = 
    in
        [nms,as,ms',os']
        

deriveSigPELt idx fname functionSignatures = 
    let
        fsig = case Map.lookup fname functionSignatures  of
            Just sig -> sig
            Nothing -> error $ "deriveSigPELt: no entry for "++fname

    in
        case fsig of
            [nms,ms,os] -> let
                    Tuple es = os
                    os' = es !! idx
                in
                     [nms,ms,os']
            [nms,as,ms,os] -> let
                    Tuple es = os
                    os' = es !! idx
                in
                    [nms,as,ms,os']
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------        


combineSigArgs (nsl, msl, osl) =
    let
        fnsl = removeDuplicateArgs $ concat $ map (\nm -> case nm of
                    Tuple es -> es
                    _ -> [nm]
                    ) nsl
        ns 
            | length fnsl == 1 = head fnsl    
            | otherwise = Tuple fnsl

        fmsl = concat $ map (\nm -> case nm of
                Tuple es -> es
                _ -> [nm]
                ) msl
        ms
            | length fmsl == 1 = head fmsl    
            | otherwise = Tuple fmsl   
            
        fosl = concat $ map (\nm -> case nm of
                Tuple es -> es
                _ -> [nm]
                ) osl
        os
            | length fosl == 1 = head fosl    
            | otherwise = Tuple fosl          
    in
        (ns,ms,os)

removeDuplicateArgs = id -- nub       
removeDuplicateArgNames = id -- nub

-- Question here is suppose we have SVec DTup, SVec DTup, then that should become Tuple SVec
-- flattenTuples es 
--     | hasTuple es = flattenTuples $ concat $ map (\e -> case e of
--                                     Tuple es' -> es'
--                                     e' -> [e']
--                                     ) es
--     | otherwise = es 

-- hasTuple es = not $ null $ filter isTuple es
-- isTuple (Tuple _) = True
-- isTuple _ = False

fortranType (Scalar _ DInt _) = "integer"
fortranType (Scalar _ DInteger _) = "integer" 
fortranType (Scalar _ DReal _) = "real"
fortranType (Scalar _ DFloat _) = "real"       
fortranType (SVec sz dt) = (fortranType dt)++", dimension("++(show sz)++")"
fortranType dt = "No equivalent Fortran type for "++(show dt)

opaqueFunctionExprs = map (\(fname, _) -> (Function fname [], Id (Tuple []) )) functionSignaturesList
generatedOpaqueFunctionDefs = map (\elt -> fst $ generateSubDef functionSignatures elt []) opaqueFunctionExprs
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- A tuple, fst elt is a list of declarations, snd elt is a list of statements
-- The statements can only be Stencil, Map or Fold
generateNonSubDefs :: (Map.Map Name FSig) -> TyTraCLAST -> ([String],[String])
generateNonSubDefs functionSignatures ast = 
    let
        (stmts, decls) = foldl (
            \(lst,st) elt ->  let
                (elt',st') = generateNonSubDef functionSignatures elt
            in
                (lst++[elt'],st++st')
                ) ([],[]) ast
        unique_decls = nub decls                
    in
        (unique_decls, stmts)

-- Returns a string with the statement and a list of decl strings
generateNonSubDef :: (Map.Map Name FSig) -> (Expr, Expr) -> (String,[String])
generateNonSubDef functionSignatures t  =
    let
        (lhs,rhs) = t
        v_name = getName lhs
        -- Vec _ (Scalar _ _ v_name)  = lhs
        -- Scalar _ _ sc_name = lhs
    in
        case rhs of 
            Stencil s_exp v_exp -> generateStencilAppl s_exp v_exp v_name stencilDefinitions
            Map f_exp v_exp -> generateMap functionSignatures f_exp v_exp v_name 
            Fold f_exp acc_exp v_exp -> generateFold functionSignatures f_exp acc_exp v_exp v_name 
            _ -> (show rhs, ["generateNonSubDef: TODO: "++(show t)])        
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------        
generateDefs :: (Map.Map Name FSig) -> TyTraCLAST -> [String] -- 
generateDefs  functionSignatures ast =
    --  let --         
    -- in
        fst $ foldl (
            \(lst,st) elt ->  let
                (elt',st') = generateSubDef functionSignatures elt st
            in
                (lst++[elt'],st')
                ) ([],[]) ast

generateSubDef :: (Map.Map Name FSig) -> (Expr, Expr) -> [String] -> (String,[String])
generateSubDef functionSignatures t st =
    let
        (lhs,rhs) = t
        Function ho_fname _ = lhs
        Vec _ (Scalar _ _ v_name)  = lhs
        -- Vec VS _ sv_name  = lhs
        -- Vec _ _ ov_name  = lhs
        Scalar _ _ sc_name = lhs
    in
        (case rhs of 
            MapS sv_exp f_exp -> generateSubDefMapS sv_exp f_exp ho_fname functionSignatures
            ApplyT f_exps -> generateSubDefApplyT f_exps ho_fname functionSignatures
            Comp (PElt idx) f_exp -> generateSubDefElt idx f_exp ho_fname functionSignatures
            Comp f1_exp f2_exp -> generateSubDefComp f1_exp f2_exp ho_fname functionSignatures
            FComp f1_exp f2_exp -> generateSubDefFComp f1_exp f2_exp ho_fname functionSignatures     
            -- Stencil s_exp v_exp -> generateStencilAppl s_exp v_exp v_name stencilDefinitions
            -- Map f_exp v_exp -> generateMap f_exp v_exp v_name 
            -- Fold f_exp acc_exp v_exp -> generateFold f_exp acc_exp v_exp sc_name 
            Id _ -> generateSubDefOpaque ho_fname functionSignatures
            _ -> show rhs
            ,[])

generateSubDefOpaque fname functionSignatures =
    let
        fsig = case Map.lookup fname functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"  
-- Then for every f we do:
        argsList = scalarisedArgs ! fname
        mappedArgsList =  map (
                \(orig_name, stencil_index) -> 
                    ((origNames ! fname) ! orig_name)++(if stencil_index==0 then "" else "("++(show stencil_index++")"))
            ) argsList   
        mappedArgsListStr = commaSepList mappedArgsList
        in                      
            case fsig of 
                [nms,ms,os] -> 
                    let                
                        non_map_arg_decls = createDecls nms -- tuple becomes list of decls
                        in_arg_decls = createDecls ms
                        out_arg_decls = createDecls os
                        non_map_args = getVarNames nms
                        in_args = getVarNames ms
                        out_args = getVarNames os           
                    in
                        unlines [
                            "subroutine "++fname++"("  ++(mkArgList [non_map_args,in_args,out_args])++")"
                            , mkDeclLines [non_map_arg_decls,in_arg_decls,out_arg_decls]
                            ,"    !!! Call to the original scalarised subroutine"
                            ,"    !!! call "++fname++"_scal("++mappedArgsListStr++")"
                            ,"end subroutine "++fname
                        ]
                [nms,as,ms,os] ->
                    let                
                        non_map_arg_decls = createDecls nms -- tuple becomes list of decls
                        acc_arg_decls = createDecls as
                        in_arg_decls = createDecls ms
                        out_arg_decls = createDecls os
                        non_map_args = getVarNames nms
                        acc_args  = getVarNames as
                        in_args = getVarNames ms
                        out_args = getVarNames os           
                    in
                        unlines [
                            "subroutine "++fname++"("  ++(mkArgList [non_map_args,acc_args,in_args,out_args])++")"
                            , mkDeclLines [non_map_arg_decls,acc_arg_decls,in_arg_decls,out_arg_decls]
                            ,"!!!"
                            ,"end subroutine "++fname
                        ]

generateSubDefMapS :: Expr -> Expr -> Name -> (Map.Map Name FSig) -> String
generateSubDefMapS sv_exp f_exp maps_fname functionSignatures =
    let
-- MapS sv f  = rhs
        SVec sv_sz _ = sv_exp
        Function fname _ = f_exp
        maps_fsig = case Map.lookup maps_fname functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"
        fsig = case Map.lookup fname functionSignatures of
                Just fs -> fs
                Nothing -> error "BOOM!"            
        [nms',in_arg',out_arg] = maps_fsig
        nms = makeDeclsUnique nms'
        -- acc_arg = makeDeclsUnique acc_arg'        
        in_arg = makeDeclsUnique in_arg'     
        non_map_arg_decls = createDecls nms -- tuple becomes list of decls
        sv_in_decl = createDecls in_arg
        sv_out_decl = createDecls out_arg
        non_map_args = getVarNames nms
        sv_in_iters = createIter in_arg
        sv_out_iters = createIter out_arg
        sv_in_accesses = map (\(x,y)-> x++y) $ zip sv_in sv_in_iters
        sv_out_accesses = map (\(x,y)-> x++y) $ zip sv_out sv_out_iters
        sv_in = getVarNames in_arg
        sv_out = getVarNames out_arg                
    in unlines [        
        "subroutine "++maps_fname++"("  ++(mkArgList [non_map_args,sv_in,sv_out])++")"
        , mkDeclLines [non_map_arg_decls,sv_in_decl,sv_out_decl]
        ,"    integer :: i"
        ,"    do i=1,"++ (show sv_sz )
        ,"        call "++fname++"("++
        (mkArgList [non_map_args,sv_in_accesses,sv_out_accesses])
        -- (mkArgList [non_map_args,map (++"(i)") sv_in,map (++"(i)") sv_out])
        ++")"
        ,"    end do"
        ,"end subroutine "++maps_fname
    ]

{-
New and hopefully better approach: Because we have simply tupled the args for all elts in the apply,
we can simply untuple them. So from applyt_fsig, we unpack the tuples \(Tuple es) -> es

-}

generateSubDefApplyT :: [Expr]  -> Name -> (Map.Map Name FSig) -> String
generateSubDefApplyT f_exps applyt_fname functionSignatures = 
    let
            fsigs = getFSigs f_exps functionSignatures

            applyt_fsig = case Map.lookup applyt_fname functionSignatures of
                Just fs -> fs
                Nothing -> error "BOOM!"
            [Tuple nmst,Tuple in_argt, Tuple out_argt] = applyt_fsig
            -- so nmst etc are lists, one per function in f_exps
            non_map_args = map getVarNames nmst
            in_args = map getVarNames in_argt
            out_args = map getVarNames out_argt

            non_map_args' = concat non_map_args
            in_args' = concat in_args
            out_args' = concat out_args 
            fsig_names_tups = zip4 f_exps non_map_args in_args out_args
            
            non_map_arg_decls = concat $ map createDecls nmst -- tuple becomes list of decls
            in_arg_decls = concat $ map createDecls in_argt
            out_arg_decls = concat $ map createDecls out_argt
            

    in 
        unlines $ concat [
            [            
            "subroutine "++applyt_fname++"("  ++(mkArgList [non_map_args',in_args',out_args'])++")"            
            , mkDeclLines [non_map_arg_decls,in_arg_decls,out_arg_decls]
            ]
            -- , [show applyt_fsig]
            ,(map show fsig_names_tups)
            , map (\(f_expr,nms,ms,os) -> case f_expr of
                    (Function fname _) -> "    call "++fname++"(" ++(mkArgList [nms,ms,os]) ++")"
                    Id dt -> unlines $ map (\(o,m) -> "    "++o++" = "++m) (zip os ms)
                    ) fsig_names_tups
            ,["end subroutine "++applyt_fname]
        ]

generateSubDefApplyT_OLD :: [Expr]  -> Name -> (Map.Map Name FSig) -> String
generateSubDefApplyT_OLD f_exps applyt_fname functionSignatures = 
    let
            fsigs = getFSigs f_exps functionSignatures
            -- FIXME: The counts are not correct because we've removed the duplicates.
            -- 
            arg_counts = map (\[ns,ms,os]-> (countNArgs ns,countNArgs ms, countNArgs os) ) fsigs
            (nm_arg_counts,m_arg_counts,o_arg_counts) = unzip3 arg_counts

            applyt_fsig = case Map.lookup applyt_fname functionSignatures of
                Just fs -> fs
                Nothing -> error "BOOM!"
            [nms',in_arg',out_arg] = applyt_fsig
            nms = makeDeclsUnique nms'
            in_arg = makeDeclsUnique in_arg'

            non_map_args = getVarNames nms
            in_args = getVarNames in_arg
            out_args = getVarNames out_arg

            grouped_non_map_args = groupArgs non_map_args nm_arg_counts
            grouped_in_args = groupArgs in_args m_arg_counts
            grouped_out_args = groupArgs out_args o_arg_counts
            fsig_names_tups = zip4 f_exps grouped_non_map_args grouped_in_args grouped_out_args
            info = zip fsigs arg_counts
            info' = let
                    [nms, ms, os] = fsigs !! 0
                in
                    case ms of
                        SVec _ dt  -> (show dt) ++ "\n!"++(show (flattenSigExpr dt))
                        ms -> show ms
            
            non_map_arg_decls = createDecls nms -- tuple becomes list of decls
            in_arg_decls = createDecls in_arg
            out_arg_decls = createDecls out_arg
            

    in 
        unlines $ concat [
            [
            "!" ++info',
            "subroutine "++applyt_fname++"("  ++(mkArgList [non_map_args,in_args,out_args])++")"            
            , mkDeclLines [non_map_arg_decls,in_arg_decls,out_arg_decls]
            ]
            , map (\(f_expr,nms,ms,os) -> case f_expr of
                    (Function fname _) -> "    call "++fname++"(" ++(mkArgList [nms,ms,os]) ++")"
                    Id dt -> unlines $ map (\(o,m) -> "    "++o++" = "++m) (zip os ms)
                    ) fsig_names_tups
            ,["end subroutine "++applyt_fname]
        ]

-- Comp (Function "f4" []) (Function "f_maps_v_3_0" []))
-- nms are joint
-- ms is for f2
-- os is for f1
generateSubDefComp :: Expr -> Expr -> Name -> (Map.Map Name FSig) -> String
generateSubDefComp f1_exp f2_exp comp_fname functionSignatures = 
    let
        Function fname1 _ = f1_exp
        Function fname2 _ = f2_exp
        fsig1 = case Map.lookup fname1 functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"
        fsig2 = case Map.lookup fname2 functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"
        comp_fsig = case Map.lookup comp_fname functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"
        [nms',in_arg',out_arg] = comp_fsig
        nms = makeDeclsUnique nms'
        in_arg = makeDeclsUnique in_arg'
        in_args = getVarNames in_arg
        out_args = getVarNames out_arg
        non_map_args = getVarNames nms
        in_args_decl = createDecls in_arg
        out_args_decl = createDecls out_arg
        non_map_arg_decls = createDecls nms -- tuple becomes list of decls
        [ns1,ms1,os1] = fsig1 -- Expr
        [ns2,ms2,os2] = fsig2
        nm_arg_counts1 = countNArgs ns1
        nm_arg_counts2 = countNArgs ns2
        non_map_args1 = take nm_arg_counts1 non_map_args
        non_map_args2 = drop nm_arg_counts1 non_map_args
        local_vars_decl = createDecls ms1
        tmp_args = getVarNames ms1

    in 
        unlines [
            -- show fnames,
            -- show fsigs,
            "subroutine "++comp_fname++"("  ++(mkArgList [non_map_args,in_args,out_args])++")"            
            , mkDeclLines [non_map_arg_decls,in_args_decl,out_args_decl,local_vars_decl]
            , "    call "++fname2++"(" ++(mkArgList [non_map_args2,in_args,tmp_args]) ++")"
            , "    call "++fname1++"(" ++(mkArgList [non_map_args1,tmp_args,out_args]) ++")"            
            ,"end subroutine "++comp_fname
        ]

-- (Function "f_fcomp_acc3_1_2" [],FComp (Function "f2" []) (Function "f_comp_acc3_1_1" []))
generateSubDefFComp :: Expr -> Expr -> Name -> (Map.Map Name FSig) -> String
generateSubDefFComp f1_exp f2_exp fcomp_fname functionSignatures = 
    let
        Function fname1 _ = f1_exp
        Function fname2 _ = f2_exp
        fsig1 = case Map.lookup fname1 functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"
        fsig2 = case Map.lookup fname2 functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"
        -- fnames = [fname1,fname2]            
        -- fsigs = [fsig1,fsig2]
        fcomp_fsig = case Map.lookup fcomp_fname functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"

        [nms',acc_arg',in_arg',out_arg] = fcomp_fsig
        nms = makeDeclsUnique nms'
        acc_arg = makeDeclsUnique acc_arg'        
        in_arg = makeDeclsUnique in_arg'        

        in_args = getVarNames in_arg
        out_args = getVarNames out_arg
        acc_args = getVarNames acc_arg
        non_map_args = getVarNames nms

        in_args_decl = createDecls in_arg
        out_args_decl = createDecls out_arg
        acc_arg_decl = createDecls acc_arg
        non_map_arg_decls = createDecls nms -- tuple becomes list of decls

        [ns1,as1, ms1,os1] = fsig1 -- Expr
        [ns2,ms2,os2] = fsig2
        nm_arg_counts1 = countNArgs ns1
        nm_arg_counts2 = countNArgs ns2
        non_map_args1 = take nm_arg_counts1 non_map_args
        non_map_args2 = drop nm_arg_counts1 non_map_args
        local_vars_decl = createDecls ms1
        tmp_args = getVarNames ms1

    in 
        unlines $ concat [
            
            ["subroutine "++fcomp_fname++"("  ++(mkArgList [non_map_args,acc_args,in_args,out_args])++")"]            
            , map ("    "++) (non_map_arg_decls++acc_arg_decl++in_args_decl++out_args_decl++local_vars_decl)
            , ["    call "++fname2++"(" ++(mkArgList [non_map_args2,in_args,tmp_args]) ++")"
            , "    call "++fname1++"(" ++(mkArgList [non_map_args1,acc_args,tmp_args,out_args]) ++")"            
            ,"end subroutine "++fcomp_fname]
        ]

-- essentially, select the idx of the tuple as the output of this sub
-- but this seems a bit silly as it means I have the same function n times
generateSubDefElt idx f_exp felt_name functionSignatures =
    let
        Function fname _ = f_exp
        fsig = case Map.lookup fname functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"        
        [nms',in_arg',out_arg] = fsig
        nms = makeDeclsUnique nms'
        in_arg = makeDeclsUnique in_arg'             

        non_map_arg_decls = createDecls nms -- tuple becomes list of decls
        in_args_decl = createDecls in_arg
        out_args_decl = createDecls out_arg
        non_map_args = getVarNames nms
        in_args = getVarNames in_arg
        out_args = getVarNames out_arg
        sel_out_arg = out_args !! idx
    in
        unlines [
            "subroutine "++felt_name++"("  ++(mkArgList [non_map_args,in_args,[sel_out_arg]])++")"            
            , mkDeclLines [non_map_arg_decls,in_args_decl,out_args_decl]
            , "    call "++fname++"(" ++(mkArgList [non_map_args,in_args,out_args]) ++")"
            ,"end subroutine "++felt_name
        ]

-- This function rewrites an expressions so that it becomes a single tuple of Scalar or nested SVec
flattenSigExpr dt = rewriteDTRec dt (Tuple [])        
-- We need to call rewriteDT' repeatedly untill all occurences of Tuple [Tuple ] have gone
rewriteDTRec dt dt' 
    | dt == dt' = dt
    | otherwise = rewriteDTRec  (rewriteDT' dt) dt   

-- The result is that Tuple is always on the outside and SVec is nested 
rewriteDT' :: Expr -> Expr
rewriteDT' dt = case dt of
    SVec sz (Tuple dts) ->  Tuple (map (\dt -> SVec sz (rewriteDT' dt)) dts)
    SVec sz (SVec sz2 dt2) ->  SVec sz (rewriteDT' (SVec sz2 dt2))
    SVec sz dt2 ->  dt
    Tuple dts -> Tuple $ concat (map (\dt -> case dt of
                        Tuple dts -> map rewriteDT' dts
                        SVec sz2 dt2 -> [ rewriteDT' (SVec sz2 dt2)]
                        dt' -> [ dt']
                        ) dts)
    -- Tuple dts -> Tuple (foldl (
    --         \dtl dt -> case dt of 
    --             Tuple dts -> dtl++( map flattenSigExpr dts)
    --             _ -> dtl++[dt]
    --     ) [] dts)
    _ -> dt



createIter :: Expr -> [String]
createIter (SVec sz dt) = let
        vn = getName dt
    in
        case dt of
            -- we know this can only be either nested DSVec or terminal
            SVec _ _  ->  let
                    (szs,dt') = getSzFromSVec dt []
                    colons = map (\_->":") szs
                in                    
                    ["("++(commaSepList ("i":colons)) ++")"]
            -- we know this has no tuples inside it                
            Tuple dts -> createIter (
                Tuple (
                    snd $ foldl (\(ct,tl) dt -> (ct+1,tl++[SVec sz (setName (vn++(show ct)) dt) ] ) )  (0,[]) dts 
                    )
                )
            -- DDC -> error "SVec DDC!"
            dt -> ["(i)"]
createIter (Tuple es) = concatMap createIter es





makeDeclsUnique :: Expr -> Expr
makeDeclsUnique expr = expr -- evalState (everywhereM (mkM makeDeclsUnique'') expr) 0

makeDeclsUnique' :: Expr -> Int -> Expr
makeDeclsUnique' (SVec sz dt) ct = 
    let
        vn = getName dt
    in
        SVec sz (setName (vn++"_"++(show ct)) dt)
makeDeclsUnique' (Scalar ve dt vn) ct = Scalar ve dt (vn++"_"++(show ct))
makeDeclsUnique' e ct = e

makeDeclsUnique'' :: Expr -> State Int Expr
makeDeclsUnique'' expr = do
            ct <- get
            let
                expr' = makeDeclsUnique' expr ct 
            put (ct+1)
            return expr'


createDecls :: Expr -> [String]
createDecls (SVec sz dt) = let
        vn = getName dt
    in
        case dt of
            -- we know this can only be either nested DSVec or terminal
            SVec _ _  ->  let
                    (szs,dt') = getSzFromSVec dt []
                in
                    [(fortranType dt')++", dimension("++(commaSepList (map show (sz:szs)))++") :: "++ vn]  
            -- we know this has no tuples inside it                
            Tuple dts -> createDecls (
                Tuple (
                    snd $ foldl (\(ct,tl) dt -> (ct+1,tl++[SVec sz (setName (vn++(show ct)) dt) ] ) )  (0,[]) dts 
                    )
                )
            dt -> [(fortranType dt)++", dimension("++(show sz)++") :: "++ vn]
createDecls (Scalar _ DDC vn) =  error "DDC!"
createDecls sdt@(Scalar _ dt vn) = [(fortranType sdt)++" :: "++vn]
createDecls (Tuple es) = concatMap createDecls es

getVarNames :: Expr -> [String]
getVarNames (SVec sz dt) = getVarNames dt
    --     case dt of
    --         -- we know this can only be either nested DSVec or terminal
    --         DSVec _ _  ->  [vn]
    --         -- we know this has no tuples inside it    
    --         DTuple dts -> getVarNames (
    --             Tuple (
    --                 snd $ foldl (\(ct,tl) dt -> (ct+1,tl++[SVec sz dt (vn++(show ct))] ) )  (0,[]) dts 
    --                 )
    --             )
    --         DDC -> error "SVec DDC!"
    --         dt -> [vn]
getVarNames (Scalar _ _ vn) = [vn]
getVarNames (Tuple es) = concatMap getVarNames es 
getVarNames (ZipT es) = concatMap getVarNames es 
getVarNames (Vec _ dt) = getVarNames dt
    --  case dt of
    --             DTuple dts -> map (\ct -> vn++"_"++(show ct)) [0 .. length dts - 1]
    --             _ -> [vn]

getSzFromSVec :: Expr -> [Int] -> ([Int],Expr)
getSzFromSVec (SVec sz dt) szs = getSzFromSVec dt (szs++[sz])  
getSzFromSVec dt szs = (szs,dt)

-- I should rewrite the argument expressions so that they are a single Tuple of something else, i.e. either SVec or Scalar
countNArgs :: Expr -> Int
countNArgs (Tuple ls) = length ls
countNArgs (SVec _ dt ) = case dt of
    Tuple ls -> error "countNArgs: SVec should not contain a Tuple!" -- length ls
    _ -> 1
countNArgs _ = 1

groupArgs args f_arg_counts = 
    fst $ foldl (
        \(f_args,args) arg_ct -> (f_args++[take arg_ct args],drop arg_ct args)
     ) ([],args) f_arg_counts

mkArgList :: [[String]] -> String
mkArgList  = commaSepList . concat 

commaSepList :: [String] -> String
commaSepList = intercalate ", "

mkDeclLines :: [[String]] -> String
mkDeclLines  = unlines . (map ("    "++)) . concat 

-- (Vec VS DDC "svec_v_3_6",Stencil (SVec 3 DInt "s2") (ZipT [Vec VI DFloat "va_0",Vec VI DFloat "vc_0"]))
-- I suppose to do this right I'd need to actually define the combined stencil and name it
-- 
generateStencilAppl :: Expr -> Expr -> Name -> Map.Map Name [Integer] -> (String,[String])
generateStencilAppl s_exp (Vec _ dt) sv_name stencilDefinitions = 
    let
        v_name = getName dt
        sv_type = fortranType dt      
        -- (s_name,s_def,sv_szs) = generateStencilDef s_exp stencilDefinitions
        (s_names,s_defs,sv_szs) = generateStencilDef' s_exp stencilDefinitions
        -- instead of generating new stencils we can also recompute, simply
        stencil_accesses = intercalate "+" (map (\(s_name,ct)-> s_name++"(s_idx_"++(show ct)++")") $ zip s_names [1..])
        -- sv_sz = length s_def
        rhs_idx_str = "        "++(createLinearIdxExprFromNDim sv_szs "s_idx")
        lhs_idx_str =  commaSepList  $ map (\ct -> "s_idx_"++(show ct)) [1 .. length sv_szs]
        decl_lines =
            (map (\(s_name, s_def, sv_sz) -> ("integer, parameter, dimension("++(show sv_sz)++") :: "++s_name++" = "++(show s_def))) (zip3 s_names s_defs sv_szs))++
            [
                
            -- if the $sv_type is DDC, it means we need to lookup the type from the definition, which will likely be a zip            
                sv_type++", dimension("++(commaSepList $ map show sv_szs)++") :: "++sv_name
                -- ,"integer :: s_idx"           
            ]++(map (\ct -> "integer :: s_idx_"++(show ct) ) [1 .. length sv_szs]   )
    in
        (
        unlines $ concat [
            [""],
            map (\(sv_sz,ct) -> "    do s_idx_"++(show ct)++" = 1,"++(show sv_sz)) (zip sv_szs [1..]),
            [
             "        "++sv_name++"("++lhs_idx_str++") = "++v_name++"(idx+"++stencil_accesses++")"
             ],
            replicate (length sv_szs) "    end do"
          ]
        ,decl_lines)
generateStencilAppl s_exp (ZipT vs_exps) sv_name stencilDefinitions = let
        gen_stencils :: [String]
        -- [(String,[String])] -> ([String], [[String]])
        (gen_stencils,decls) = unzip $ map (\(v_exp,ct) -> generateStencilAppl s_exp v_exp (sv_name++"_"++(show ct)) stencilDefinitions) (zip vs_exps [0..])
        -- I want to "zip" them but it's a list of lists, so I need to round-robin over it
        gen_stencils_lines :: [[String]]
        gen_stencils_lines = map lines gen_stencils
        grouped_lines :: [[String]]
        grouped_lines = pairUpZipCode gen_stencils_lines []
        -- grouped_lines = gen_stencils_lines
        unique_grouped_lines :: [[String]]
        unique_grouped_lines = map nub grouped_lines
        all_lines :: [String]
        all_lines = concat unique_grouped_lines
    in
        (unlines all_lines, concat decls)

createLinearIdxExprFromNDim sv_szs s_idx = create_iter_expr (tail sv_szs) 1 (s_idx++" = "++s_idx++"_"++(show (length sv_szs)))
create_iter_expr sv_szs i expr_str 
    | length sv_szs == 0 = expr_str
    | otherwise =
        create_iter_expr (tail sv_szs) (i+1) 
            (expr_str ++ "+(s_idx_"++(show i)++"-1)*"++(show $ product sv_szs)) -- (intercalate "*" (map show sv_szs)))        
-- some kind of a fold where the result is, if I start from n lists, with each list k lines, then I will have k lists of n lines
-- so for each of these n lists I take the head , that gets me n lines
pairUpZipCode lsts acc
            | null (head lsts) = acc
            | otherwise =
                let
                    (l1,rest) = unzip  $ map (\(x:xs) -> (x,xs)) lsts -- which is a list of tuples                    
                in
                    pairUpZipCode rest (acc++[l1])

-- -- -> (Name,[Int],[Int])
-- generateStencilDef s_exp stencilDefinitions = 
--      case s_exp of
--         SVec sv_sz DInt s_name -> case Map.lookup s_name stencilDefinitions of
--             Just s_def -> (s_name,s_def, [length s_def])
--         SComb s1 s2 -> let
--                 (s1_name,s1_def, len_s1) = generateStencilDef s1 stencilDefinitions 
--                 (s2_name,s2_def, len_s2) = generateStencilDef s2 stencilDefinitions 
--                 scomb_name = s1_name++"_"++s2_name
--                 scomb_def = [ x+y | x <- s1_def, y <- s2_def]
--             in
--                 (scomb_name, scomb_def,len_s1++len_s2) -- [length s1_def, length s2_def])

generateStencilDef' :: Expr -> Map.Map Name [Integer] -> ([String],[[Integer]],[Int])                
generateStencilDef' s_exp stencilDefinitions = 
     case s_exp of
        SVec sv_sz sv_exp -> let
                    s_name = getName sv_exp
                in
                    case Map.lookup s_name  stencilDefinitions of
                        Just s_def -> ([s_name],[s_def], [length s_def])
        SComb s1 s2 -> let
                (s1_name,s1_def, len_s1) = generateStencilDef' s1 stencilDefinitions 
                (s2_name,s2_def, len_s2) = generateStencilDef' s2 stencilDefinitions 
                scomb_name = s1_name++s2_name
                -- scomb_def = [ x+y | x <- s1_def, y <- s2_def]
            in
                (scomb_name, s1_def++s2_def,len_s1++len_s2) -- [length s1_def, length s2_def])                

-- Map (Function "f2" ["acc_1"]) (Vec VS DDC "svec_v_1_0")
-- map (generateSubDef functionSignatures) ast                     
generateMap functionSignatures f_exp v_exp ov_name =
    let
        Function fname nms_exps = f_exp
        -- fsig = case Map.lookup fname functionSignatures of
        --     Just fs -> fs
        --     Nothing -> error $ "generateMap: BOOM! "++fname                 
        -- [nms_exps',v_exp',ov_exp] = fsig
        nms = getVarNames (Tuple nms_exps)        
        vs_in = getVarNames v_exp
        -- nms = getVarNames nms_exps'
        -- vs_in = getVarNames v_exp'
        ov_name'' = ov_name -- getName ov_exp
        vs_in' = map (\vn -> if Map.member vn mainArgDecls then vn++"(idx)" else vn) vs_in
        ov_name' = if Map.member ov_name mainArgDecls then ov_name''++"(idx)" else ov_name''
    in
        (
            "! Map \n"++
        "    call "++fname++"("
        ++(commaSepList ((removeDuplicateArgNames nms) ++vs_in' ++[ov_name']))
        ++")"
        ,[])

generateFold functionSignatures f_exp acc_exp v_exp sc_name =
    let
        Function fname nms_exps = f_exp
        fsig = case Map.lookup fname functionSignatures of
            Just fs -> fs
            Nothing -> error $ "BOOM! "++fname
        nms = getVarNames (Tuple nms_exps)
        vs_in = getVarNames v_exp
        Scalar _ _ acc_name = acc_exp
    in  
        (
        "    call "++fname++"("
        ++(commaSepList (nms ++[acc_name] ++vs_in ++[sc_name]))
        ++")"
        ++"\n"
        ++acc_name++" = "++sc_name
        ,[])

-- for every stage:
-- stage_ast is the AST with only non-function-defs
generateStageKernel :: (Map.Map Name FSig) -> Int -> TyTraCLAST -> String
generateStageKernel functionSignatures ct stage_ast  =
    let
   
        (generatedDecls,generatedStmts) = generateNonSubDefs functionSignatures stage_ast
        uniqueGeneratedDecls = nub generatedDecls

        -- now I need to extract all VI and VO from non_func_exprs
        -- best way to do that is with `everything` I think
        in_args = nub $ concatMap (\(lhs,rhs) -> getInputArgs rhs) stage_ast
        out_args = nub $ concatMap (\(lhs,rhs) -> getOutputArgs lhs) stage_ast
        -- and I need the declarations for these, so I guess I need to get the Exprs and then the names and decls from there
        -- also I need a mechanism to detect the accs that are passed between the stages
        arg_decl_lines = map (\arg_name -> case Map.lookup arg_name mainArgDecls of
                                    Just decl -> decl
                                    Nothing -> error $ "No declaration for "++arg_name++ " in mainArgDecls"
                            ) (in_args++out_args)

    in unlines $
        [
            "subroutine stage_kernel_"++(show ct)++"("++(mkArgList [in_args, out_args])++")"
        ]
        ++(map ("  "++) arg_decl_lines)
        ++(map ("    "++) uniqueGeneratedDecls)
        ++generatedStmts
        ++[            
            "end subroutine stage_kernel_"++(show ct)
        ]


getInputArgs = everything (++) (mkQ [] (getInputArgs')) 

getInputArgs' :: Expr -> [Name]
getInputArgs' node = case node of
                            Vec VI dt -> [getName dt] 
                            Scalar VI _ sn -> [sn]
                            _ -> []

getOutputArgs = everything (++) (mkQ [] (getOutputArgs')) 

getOutputArgs' :: Expr -> [Name]
getOutputArgs' node = case node of
                            Vec VO dt -> [getName dt] 
                            Scalar VO _ sn -> [sn]
                            _ -> []                                    


getFNames :: Expr -> [Name]
getFNames = everything (++) (mkQ [] (getFNames')) 

getFNames' :: Expr -> [Name]
getFNames' (Function fname _) = [fname]
getFNames' _ = []                            

getFSigs :: [Expr] -> Map.Map Name FSig -> [FSig] 
getFSigs fs functionSignatures = map (\(f_expr, idx) -> case f_expr of
        (Function fname _) -> case Map.lookup fname functionSignatures  of
            Just sig -> sig
            Nothing -> error $ "getFSigs: no entry for "++fname
        Id dt -> [Tuple [], setName ("id_in_"++(show idx)) dt, setName ("id_out_"++(show idx)) dt ]
    ) (zip fs [1..])

{-
The problem with the stages is that not every "stage" is really a stage. Basically it is about dependencies.
And in fact, staging is only needed for folds. 
We have now already set it up such that any maps preceding a fold are part of the fold.
So any "stage" with a fold AND the last stage are real stages. The other should be combined with the last stage

So basically, split out all Fold entries 
And we should split out all function definitions and put them up front

So what this returns is
- A list of ASTs of the function definitions
- A list of ASTs of the non-function-definition code for each stage
-}

createStages :: [TyTraCLAST] -> (TyTraCLAST,[TyTraCLAST])
createStages asts =
    let
        -- For every Map or Fold, a list of the decomposed function defs and a list of the rest
        -- These are always the same length
        -- But as we want a single superkernel we will always have all defs so I can combine them
        (asts_function_defs, asts_no_function_defs) = unzip $ map (partition isFunctionDef) asts
        -- All ASTs with Map can be combined as the Maps don't depend on one another
        (asts_with_fold,asts_without_fold) = partition hasFold asts_no_function_defs
        ast_without_fold = concat asts_without_fold

    in 
        -- error $ show (length asts_function_defs, length asts_no_function_defs, length asts_with_fold, length ast_without_fold)
        (concat asts_function_defs,asts_with_fold++[ast_without_fold])

hasFold ast = let
        fold_exprs = filter (\(lhs, rhs) -> case rhs of
            Fold _ _ _ -> True
            _ -> False
            ) ast
    in
        length fold_exprs > 0     

isFunctionDef ((Function _ _),_) = True
isFunctionDef _ = False

-- "real, dimension(1:252004), intent(in) :: eta_0" 
createMainProgramDecl decl = let
        chunks = words decl
        chunks' = case  chunks of
            [type_str,dim_str,intent_str,double_colon,var_name_str] -> [type_str,init dim_str,double_colon,var_name_str]
            [type_str,intent_str,double_colon,var_name_str] -> [init type_str,double_colon,var_name_str]        
    in
        unwords chunks'


generateMainProgram :: (Map.Map Name FSig) -> [TyTraCLAST] -> String
generateMainProgram functionSignatures ast_stages  =
    let
        generateStageKernel' functionSignatures  ct stage_ast  =
            let
                (generatedDecls,generatedStmts) = generateNonSubDefs functionSignatures stage_ast
                uniqueGeneratedDecls = nub generatedDecls
        
                -- now I need to extract all VI and VO from non_func_exprs
                -- best way to do that is with `everything` I think
                in_args = nub $ concatMap (\(lhs,rhs) -> getInputArgs rhs) stage_ast
                out_args = nub $ concatMap (\(lhs,rhs) -> getOutputArgs lhs) stage_ast
                -- and I need the declarations for these, so I guess I need to get the Exprs and then the names and decls from there
                -- also I need a mechanism to detect the accs that are passed between the stages
                arg_decl_lines = map (\arg_name -> case Map.lookup arg_name mainArgDecls of
                                            Just decl -> decl
                                            Nothing -> error $ "No declaration for "++arg_name++ " in mainArgDecls"
                                    ) (in_args++out_args)
        
            in        
                (arg_decl_lines,
                "call stage_kernel_"++(show ct)++"("++(mkArgList [in_args, out_args])++")"
                )
    
        -- stage_kernel_info :: ([[String]],[String])
        (stage_kernel_decls, stage_kernel_calls) = unzip $ map (\(ast,ct) -> (generateStageKernel' functionSignatures) ct ast) (zip ast_stages [1..])
        unique_stage_kernel_decls = nub $ concat stage_kernel_decls
        main_program_decls = map createMainProgramDecl unique_stage_kernel_decls
        loops_over_calls = map (\call_str -> unlines [
            "do global_id=1,VSZ",
            "  "++call_str,
            "end do"
            ]
            )stage_kernel_calls
    in unlines $ [
        "program main",
        "integer :: global_id",
        "common /ocl/ global_id"
        ] ++
        main_program_decls ++
        loops_over_calls ++
        [
        "end program main  ",
        "",
        "subroutine get_global_id(idx)",
        "integer, intent(out) :: idx",
        "integer :: global_id",
        "common /ocl/ global_id",
        "idx = global_id",
        "end subroutine get_global_id"
        ]
       
generateFortranCode decomposed_ast =
    let
        (asts_function_defs,ast_stages) = createStages decomposed_ast
        functionSignatures = inferSignaturesMap asts_function_defs
        generatedFunctionDefs = generateDefs functionSignatures asts_function_defs
        generatedStageKernels = map (\(ast,ct) -> (generateStageKernel functionSignatures) ct ast) (zip ast_stages [1..])
        mainProgramStr = generateMainProgram functionSignatures ast_stages        
        generatedOpaqueFunctionDefsStr = unlines generatedOpaqueFunctionDefs
        -- putStrLn "\n! Generate subroutine definitions"
        generatedFunctionDefsStr = unlines generatedFunctionDefs
        -- putStrLn "\n! Generated stage kernels"
        generatedStageKernelsStr =  unlines generatedStageKernels         
    in
        unlines [
            mainProgramStr,
            generatedOpaqueFunctionDefsStr,
            generatedFunctionDefsStr,
            generatedStageKernelsStr
        ]        
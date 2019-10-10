module CodeGeneration (inferSignatures, generateSignatures, generatedOpaqueFunctionDefs, createStages, generateDefs, generateNonSubDefs, generateStageKernel) where

-- import Data.Generics (Data, Typeable, mkQ, mkT, mkM, gmapQ, gmapT, everything, everywhere, everywhere', everywhereM)
import Data.Generics (mkQ, everything)  
-- import Control.Monad.State
import TyTraCLAST
import ASTInstance (functionSignaturesList, stencilDefinitionsList, mainArgDeclsList, origNamesList, scalarisedArgsList)
import qualified Data.Map.Strict as Map
import Data.List

(!) = (Map.!)
{-
f1 :: acc1_T -> SVec 3 v_T -> v_T
f1 acc1_T ::  SVec 3 v_T -> v_T
maps : (a -> b) -> SVec k a -> SVec k b
maps : (SVec 3 v_T -> v_T) 

So, given an intermediate function definition, what is its signature?
e.g.


We have

 ("f1", MapFSig ([Scalar VDC DInt "acc1"],[SVec 3 DInt "v_s"],[Scalar VDC DInt "v"])),

-}
nonMapArgs (MapFSig (nms,ms,os)) = nms
mapArgs (MapFSig (nms,ms,os)) = ms
outArgs (MapFSig (nms,ms,os)) = os
outArgs (FoldFSig (nfs,as,fs,os)) = os

nonFoldArgs (FoldFSig (nfs,as,fs,os)) = nfs
foldArgs (FoldFSig (nfs,as,fs,os)) = fs
accArgs (FoldFSig (nfs,as,fs,os)) = as

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



-- We must update this map with the new signatures, so probably use the state monad
-- let's be old-school contrarian and use fold
inferSignaturesMap :: TyTraCLAST -> Map.Map Name FSig
inferSignaturesMap = foldl inferSignature functionSignatures

inferSignatures :: TyTraCLAST -> [(Name,FSig)]
inferSignatures ast = Map.toList (inferSignaturesMap ast)

generateSignatures :: TyTraCLAST -> [String]
generateSignatures ast =  map functionSigStr (inferSignatures ast)

opaqueFunctionExprs = map (\(fname, _) -> (Function fname [], Id DDC) ) functionSignaturesList
generatedOpaqueFunctionDefs = map (\elt -> fst $ generateSubDef functionSignatures elt []) opaqueFunctionExprs

generateNonSubDefs :: TyTraCLAST -> ([String],[String])
generateNonSubDefs ast = 
    let
        (stmts, decls) = foldl (
            \(lst,st) elt ->  let
                (elt',st') = generateNonSubDef elt
            in
                (lst++[elt'],st++st')
                ) ([],[]) ast
        unique_decls = nub decls                
    in
        (unique_decls, stmts)
        
generateDefs :: TyTraCLAST -> [String]
generateDefs ast = let 
        functionSignatures = inferSignaturesMap ast
    in
        fst $ foldl (
            \(lst,st) elt ->  let
                (elt',st') = generateSubDef functionSignatures elt st
            in
                (lst++[elt'],st')
                ) ([],[]) ast

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
    case rhs of
        MapS (SVec sv_sz _ _) (Function fname _) -> deriveSigMaps sv_sz fname functionSignatures
        Comp (Function f1 _) (Function f2 _) -> deriveSigComp f1 f2 functionSignatures
        Comp (PElt idx) (Function fname _) -> deriveSigPELt idx fname functionSignatures
        FComp (Function f1 _) (Function f2 _) -> deriveSigFComp f1 f2 functionSignatures
        ApplyT fs -> deriveSigApplyT fs functionSignatures

-- ApplyT can only arise because of Map, so it can't be Fold.       
-- Arguments to ApplyT can be Function, Id, what else? Let's assume that is all
-- The signature of the derived function should be grouped   
deriveSigApplyT :: [Expr] -> (Map.Map Name FSig) -> FSig      
deriveSigApplyT fs functionSignatures =
    let
        -- fnames = concatMap getFNames fs -- map (\(Function fn _) -> fn) fs
        -- fsigs = map (\fname -> case Map.lookup fname functionSignatures  of
        --         Just sig -> sig
        --         Nothing -> error "Impossible"
        --     ) fnames
        fsigs = getFSigs fs functionSignatures
        
        -- ApplyT simply applies a number of functions to a number of elements in a tuple
        -- So the signature is the combination of all signatures
        (nsl,msl,osl) = foldl (
            \(nsl,msl,osl) fsig -> case fsig of
                MapFSig (nms,ms,os) -> if nms /= Tuple [] 
                    then
                        ( nsl++[nms],msl++[ms],osl++[os] )
                    else
                        ( nsl,msl++[ms],osl++[os] )    
                _ -> (nsl,msl,osl)
            ) ([],[],[]) fsigs
        nsl' = filter(/= (Tuple [])) nsl
        ns = if length nsl' == 1 then head nsl' else Tuple nsl'
        msl' =  filter(/= (Tuple [])) msl
        ms = if length msl' == 1 then head msl' else Tuple msl'
        osl' =  filter(/= (Tuple [])) osl
        os = if length osl' == 1 then head osl' else Tuple osl'
    in
        MapFSig (ns,ms,os)
            

deriveSigMaps :: Int -> Name -> (Map.Map Name FSig) -> FSig
deriveSigMaps sv_sz fname functionSignatures = 
    let
        fsig = case Map.lookup fname functionSignatures  of
            Just sig -> sig
            Nothing -> error $ "deriveSigMaps: no entry for "++fname
    in            
        case fsig of
            MapFSig (nms,ms,os) -> let
{-
How do we do this?
The type is SVec Int DType, so I must map Expr to DType!
-}                
                    ms' = SVec sv_sz (toDType ms) ("sv_"++fname++"_in")
                    os' = SVec sv_sz (toDType os) ("sv_"++fname++"_out")
                in
                    MapFSig (nms,ms',os')
            FoldFSig (nms,as,ms,os) -> let
                    ms' = SVec sv_sz (toDType ms) ("sv_"++fname++"_in")
                    os' = SVec sv_sz (toDType os) ("sv_"++fname++"_out")
                in
                    FoldFSig (nms,as,ms',os')          

deriveSigComp :: Name -> Name -> (Map.Map Name FSig) -> FSig
deriveSigComp fname1 fname2 functionSignatures =      
    let
        fsig1 = case Map.lookup fname1 functionSignatures  of
            Just sig1 -> sig1
            Nothing -> error $ "deriveSigComp: no entry for "++fname1
        fsig2 = case Map.lookup fname2 functionSignatures  of
            Just sig2 -> sig2
            Nothing -> error $ "deriveSigComp: no entry for "++fname2
        MapFSig (nms1,ms1,os1) =  fsig1
        MapFSig (nms2,ms2,os2) = fsig2
-- the output of f2 is used as the input for f1
        nms 
            | (nms1 == Tuple []) && (nms2 == Tuple []) = Tuple []
            | nms1 == Tuple [] = nms2
            | nms2 == Tuple [] = nms1
            | otherwise = Tuple [nms1,nms2]
        ms' = ms2
        os' = os1
    in
        MapFSig (nms,ms',os')

-- unpackFSig  MapFSig (nms1,ms1,os1) =  (nms1,ms1,os1)     
-- unpackFSig  FoldFSig (nms1,as1,ms1,os1) =  (nms1,as1,ms1,os1)

deriveSigFComp fname1 fname2 functionSignatures =               
    let
        fsig1 = case Map.lookup fname1 functionSignatures  of
            Just sig1 -> sig1
            Nothing -> error $ "deriveSigFComp: no entry for "++fname1
        fsig2 = case Map.lookup fname2 functionSignatures  of
            Just sig2 -> sig2
            Nothing -> error $ "deriveSigFComp: no entry for "++fname2
        FoldFSig (nms1,as,ms1,os1) = fsig1
        MapFSig (nms2,ms2,os2) = fsig2
    -- the output of f2 is used as the input for f1
    -- the nms1 and nms2 should probably a tuple of tuples
        nms 
            | (nms1 == Tuple []) && (nms2 == Tuple []) = Tuple []
            | nms1 == Tuple [] = nms2
            | nms2 == Tuple [] = nms1
            | otherwise = Tuple [nms1,nms2]
        ms' = ms2
        os' = os1
    in
        FoldFSig (nms,as,ms',os')        

deriveSigPELt idx fname functionSignatures = 
    let
        fsig = case Map.lookup fname functionSignatures  of
            Just sig -> sig
            Nothing -> error $ "deriveSigPELt: no entry for "++fname

    in
        case fsig of
            MapFSig (nms,ms,os) -> let
                    Tuple es = os
                    os' = es !! idx
                in
                    MapFSig (nms,ms,os')
            FoldFSig (nms,as,ms,os) -> let
                    Tuple es = os
                    os' = es !! idx
                in
                    FoldFSig (nms,as,ms,os')         
        

-- t = ("f_maps_acc3_1_0",MapFSig (Scalar VDC DInt "acc1",SVec 3 (DSVec 3 DInt) "sv_f1_in",SVec 3 DInt "sv_f1_out"))
functionSigStr :: (Name, FSig) -> String
functionSigStr t = let
        (fname,ftype) = t
        args = argList ftype 
    in
        fname++"("++(commaSepList args)++")"

varName :: Expr -> [Name]
varName (Scalar _ _ vn) = [vn]
varName (SVec _ _  vn) = [vn]
varName (Tuple ts) = concatMap varName ts

argList (MapFSig (nms,ms,os)) =  (varName nms) ++ (varName ms) ++ (varName os)
argList (FoldFSig (nms,as,ms,os)) = (varName nms) ++ (varName as) ++ (varName ms) ++ (varName os)

createDecl = head . createDecls

fortranType DInt = "integer"
fortranType DInteger = "integer" 
fortranType DReal = "real"
fortranType DFloat = "real"       
fortranType (DSVec sz dt) = (fortranType dt)++", dimension("++(show sz)++")"
fortranType dt = "No equivalent Fortran type for "++(show dt)

-- TODO: the non-sub defs must be split between declarations and other statements
-- So having generateNonSubDef might be better, it will return a string with the statement and a list of decl strings
generateNonSubDef :: (Expr, Expr) -> (String,[String])
generateNonSubDef t =
    let
        (lhs,rhs) = t
        Vec _ _ v_name  = lhs
        Scalar _ _ sc_name = lhs
    in
        case rhs of 
            Stencil s_exp v_exp -> generateStencilAppl s_exp v_exp v_name stencilDefinitions
            Map f_exp v_exp -> generateMap f_exp v_exp v_name 
            Fold f_exp acc_exp v_exp -> generateFold f_exp acc_exp v_exp sc_name 
            _ -> (show rhs, ["TODO"])
        

generateSubDef :: (Map.Map Name FSig) -> (Expr, Expr) -> [String] -> (String,[String])
generateSubDef functionSignatures t st =
    let
        (lhs,rhs) = t
        Function ho_fname _ = lhs
        Vec _ _ v_name  = lhs
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
                MapFSig (nms,ms,os) -> 
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
                            ,"    call "++fname++"_scal("++mappedArgsListStr++")"
                            ,"end subroutine "++fname
                        ]
                FoldFSig (nms,as,ms,os) ->
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
        SVec sv_sz sv_t _ = sv_exp
        Function fname _ = f_exp
        maps_fsig = case Map.lookup maps_fname functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"
        fsig = case Map.lookup fname functionSignatures of
                Just fs -> fs
                Nothing -> error "BOOM!"            
        MapFSig (nms,in_arg,out_arg) = maps_fsig
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
generateSubDefApplyT :: [Expr]  -> Name -> (Map.Map Name FSig) -> String
generateSubDefApplyT f_exps applyt_fname functionSignatures = 
    let
            fsigs = getFSigs f_exps functionSignatures
            fnames = map (
                        \f_expr -> case f_expr of
                            (Function fname _) -> fname
                            Id dt -> "id"
                    )  f_exps
            -- in ApplyT these are always MapFSig (Expr,Expr,Expr)
            arg_counts = map (\(MapFSig (ns,ms,os))-> (countNArgs ns,countNArgs ms, countNArgs os) ) fsigs
            (nm_arg_counts,m_arg_counts,o_arg_counts) = unzip3 arg_counts
            applyt_fsig = case Map.lookup applyt_fname functionSignatures of
                Just fs -> fs
                Nothing -> error "BOOM!"
            MapFSig (nms,in_arg,out_arg) = applyt_fsig
            in_args = getVarNames in_arg
            out_args = getVarNames out_arg

            grouped_non_map_args = groupArgs non_map_args nm_arg_counts
            grouped_in_args = groupArgs in_args m_arg_counts
            grouped_out_args = groupArgs out_args o_arg_counts
            fsig_names_tups = zip4 f_exps grouped_non_map_args grouped_in_args grouped_out_args

            
            non_map_arg_decls = createDecls nms -- tuple becomes list of decls
            in_arg_decls = createDecls in_arg
            out_arg_decls = createDecls out_arg
            non_map_args = getVarNames nms

    in 
        unlines $ concat [
            [
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
        fnames = [fname1,fname2]            
        fsigs = [fsig1,fsig2]
        comp_fsig = case Map.lookup comp_fname functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"
        MapFSig (nms,in_arg,out_arg) = comp_fsig

        in_args = getVarNames in_arg
        out_args = getVarNames out_arg
        non_map_args = getVarNames nms
        in_args_decl = createDecls in_arg
        out_args_decl = createDecls out_arg
        non_map_arg_decls = createDecls nms -- tuple becomes list of decls
        MapFSig (ns1,ms1,os1) = fsig1 -- Expr
        MapFSig (ns2,ms2,os2) = fsig2
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

        FoldFSig (nms,acc_arg,in_arg,out_arg) = fcomp_fsig

        in_args = getVarNames in_arg
        out_args = getVarNames out_arg
        acc_args = getVarNames acc_arg
        non_map_args = getVarNames nms

        in_args_decl = createDecls in_arg
        out_args_decl = createDecls out_arg
        acc_arg_decl = createDecls acc_arg
        non_map_arg_decls = createDecls nms -- tuple becomes list of decls

        FoldFSig (ns1,as1, ms1,os1) = fsig1 -- Expr
        MapFSig (ns2,ms2,os2) = fsig2
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
        maps_fsig = case Map.lookup felt_name functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"
        MapFSig (nms,in_arg,out_arg) = fsig
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


-- The result is that DTuple is always on the outside and DSVec is nested 
rewriteDT :: DType -> DType
rewriteDT dt = case dt of
    DSVec sz (DTuple dts) ->  DTuple (map (\dt -> DSVec sz (rewriteDT dt)) dts)
    DTuple dts -> DTuple (foldl (
            \dtl dt -> case dt of 
                DTuple dts -> dtl++dts
                _ -> dtl++[dt]
        ) [] dts)
    _ -> dt

createIter :: Expr -> [String]
createIter (SVec sz dt' vn) = let
        dt = rewriteDT dt'
    in
        case dt of
            -- we know this can only be either nested DSVec or terminal
            DSVec _ _  ->  let
                    (szs,dt') = getSzFromDSVec dt []
                    colons = map (\_->":") szs
                in                    
                    ["("++(commaSepList ("i":colons)) ++")"]
            -- we know this has no tuples inside it                
            DTuple dts -> createIter (
                Tuple (
                    snd $ foldl (\(ct,tl) dt -> (ct+1,tl++[SVec sz dt (vn++(show ct))] ) )  (0,[]) dts 
                    )
                )
            -- DDC -> error "SVec DDC!"
            dt -> ["(i)"]
-- createIter (Scalar _ DDC vn) =  error "DDC!"
-- createIter (Scalar _ dt vn) = [(fortranType dt)++" :: "++vn]
createIter (Tuple es) = concatMap createIter es


createDecls :: Expr -> [String]
createDecls (SVec sz dt' vn) = let
        dt = rewriteDT dt'
    in
        case dt of
            -- we know this can only be either nested DSVec or terminal
            DSVec _ _  ->  let
                    (szs,dt') = getSzFromDSVec dt []
                in
                    [(fortranType dt')++", dimension("++(commaSepList (map show (sz:szs)))++") :: "++ vn]  
            -- we know this has no tuples inside it                
            DTuple dts -> createDecls (
                Tuple (
                    snd $ foldl (\(ct,tl) dt -> (ct+1,tl++[SVec sz dt (vn++(show ct))] ) )  (0,[]) dts 
                    )
                )
            DDC -> error "SVec DDC!"
            dt -> [(fortranType dt)++", dimension("++(show sz)++") :: "++ vn]
createDecls (Scalar _ DDC vn) =  error "DDC!"
createDecls (Scalar _ dt vn) = [(fortranType dt)++" :: "++vn]
createDecls (Tuple es) = concatMap createDecls es

getVarNames :: Expr -> [String]
getVarNames (SVec sz dt' vn) = let
        dt = rewriteDT dt'
    in
        case dt of
            -- we know this can only be either nested DSVec or terminal
            DSVec _ _  ->  [vn]
            -- we know this has no tuples inside it    
            DTuple dts -> getVarNames (
                Tuple (
                    snd $ foldl (\(ct,tl) dt -> (ct+1,tl++[SVec sz dt (vn++(show ct))] ) )  (0,[]) dts 
                    )
                )
            DDC -> error "SVec DDC!"
            dt -> [vn]
getVarNames (Scalar _ dt vn) = [vn]
getVarNames (Tuple es) = concatMap getVarNames es 
getVarNames (ZipT es) = concatMap getVarNames es 
getVarNames (Vec _ dt vn) = case dt of
                DTuple dts -> map (\ct -> vn++"_"++(show ct)) [0 .. length dts - 1]
                _ -> [vn]

getSzFromDSVec :: DType -> [Int] -> ([Int],DType)
getSzFromDSVec (DSVec sz dt) szs = getSzFromDSVec dt (szs++[sz])  
getSzFromDSVec dt szs = (szs,dt)

countNArgs :: Expr -> Int
countNArgs (Tuple ls) = length ls
countNArgs (SVec _ dt _ ) = case rewriteDT dt of
    DTuple ls -> length ls
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
generateStencilAppl s_exp (Vec _ dt v_name) sv_name stencilDefinitions = 
    let
        sv_type = fortranType dt         
        -- (s_name,s_def,sv_szs) = generateStencilDef s_exp stencilDefinitions
        (s_names,s_def,sv_szs) = generateStencilDef' s_exp stencilDefinitions
        -- instead of generating new stencils we can also recompute, simply
        stencil_accesses = intercalate "+" (map (\(s_name,ct)-> s_name++"(s_idx_"++(show ct)++")") $ zip s_names [1..])
        sv_sz = length s_def
        rhs_idx_str = "        "++(createLinearIdxExprFromNDim sv_szs "s_idx")
        lhs_idx_str =  commaSepList  $ map (\ct -> "s_idx_"++(show ct)) [1 .. length sv_szs]
        decl_lines = [
                -- "integer, parameter, dimension("++(show sv_sz)++") :: "++s_name++" = "++(show s_def),
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
                --   rhs_idx_str,
             "        "++sv_name++"("++lhs_idx_str++") = "++v_name++"(idx+"++stencil_accesses++")"
            --  ,"        "++sv_name++"("++lhs_idx_str++") = "++v_name++"(idx+"++s_name++"(s_idx))"
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

-- -> (Name,[Int],[Int])
generateStencilDef s_exp stencilDefinitions = 
     case s_exp of
        SVec sv_sz DInt s_name -> case Map.lookup s_name stencilDefinitions of
            Just s_def -> (s_name,s_def, [length s_def])
        SComb s1 s2 -> let
                (s1_name,s1_def, len_s1) = generateStencilDef s1 stencilDefinitions 
                (s2_name,s2_def, len_s2) = generateStencilDef s2 stencilDefinitions 
                scomb_name = s1_name++"_"++s2_name
                scomb_def = [ x+y | x <- s1_def, y <- s2_def]
            in
                (scomb_name, scomb_def,len_s1++len_s2) -- [length s1_def, length s2_def])

generateStencilDef' s_exp stencilDefinitions = 
     case s_exp of
        SVec sv_sz DInt s_name -> case Map.lookup s_name stencilDefinitions of
            Just s_def -> ([s_name],s_def, [length s_def])
        SComb s1 s2 -> let
                (s1_name,s1_def, len_s1) = generateStencilDef' s1 stencilDefinitions 
                (s2_name,s2_def, len_s2) = generateStencilDef' s2 stencilDefinitions 
                scomb_name = s1_name++s2_name
                scomb_def = [ x+y | x <- s1_def, y <- s2_def]
            in
                (scomb_name, scomb_def,len_s1++len_s2) -- [length s1_def, length s2_def])                

-- Map (Function "f2" ["acc_1"]) (Vec VS DDC "svec_v_1_0")
-- map (generateSubDef functionSignatures) ast                     
generateMap f_exp v_exp ov_name =
    let
        Function fname nms_exps = f_exp
        nms = getVarNames (Tuple nms_exps)        
        vs_in = getVarNames v_exp
        vs_in' = map (\vn -> if Map.member vn mainArgDecls then vn++"(idx)" else vn) vs_in
        ov_name' = if Map.member ov_name mainArgDecls then ov_name++"(idx)" else ov_name
    in
        (
        "    call "++fname++"("
        ++(commaSepList (nms ++vs_in' ++[ov_name']))
        ++")"
        ,[])

generateFold f_exp acc_exp v_exp sc_name =
    let
        Function fname nms_exps = f_exp
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
generateStageKernel :: Int -> TyTraCLAST -> [String]
generateStageKernel ct stage_ast  =
    let
        (generatedDecls,generatedStmts) = generateNonSubDefs stage_ast
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
                            Vec VI dt vn -> [vn] 
                            Scalar VI dt sn -> [sn]
                            _ -> []

getOutputArgs = everything (++) (mkQ [] (getOutputArgs')) 

getOutputArgs' :: Expr -> [Name]
getOutputArgs' node = case node of
                            Vec VO _ vn -> [vn] 
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
        Id dt -> MapFSig (Tuple [], Scalar VDC dt ("id_in_"++(show idx)), Scalar VDC dt ("id_out_"++(show idx)) )
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

createStages :: [TyTraCLAST] -> ([TyTraCLAST],[TyTraCLAST])
createStages asts =
    let
        (asts_function_defs, asts_no_function_defs) = unzip $ map (partition isFunctionDef) asts
        (asts_with_fold,asts_without_fold) = partition hasFold asts_no_function_defs
        ast_without_fold = concat asts_without_fold

    in 
        (asts_function_defs,asts_with_fold++[ast_without_fold])

hasFold ast = let
        fold_exprs = filter (\(lhs, rhs) -> case rhs of
            Fold _ _ _ -> True
            _ -> False
            ) ast
    in
        length fold_exprs > 0     

isFunctionDef ((Function _ _),_) = True
isFunctionDef _ = False


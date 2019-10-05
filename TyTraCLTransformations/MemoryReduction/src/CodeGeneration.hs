module CodeGeneration (inferSignatures, generateSignatures, generateDefs) where

import Data.Generics (Data, Typeable, mkQ, mkT, mkM, gmapQ, gmapT, everything, everywhere, everywhere', everywhereM)
import Control.Monad.State
import TyTraCLAST
import ASTInstance (ast, functionSignaturesList)
import qualified Data.Map.Strict as Map
import Data.List

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

-- We must update this map with the new signatures, so probably use the state monad
-- let's be old-school contrarian and use fold
inferSignaturesMap :: TyTraCLAST -> Map.Map Name FSig
inferSignaturesMap = foldl inferSignature functionSignatures

inferSignatures :: TyTraCLAST -> [(Name,FSig)]
inferSignatures ast = Map.toList (inferSignaturesMap ast)

generateSignatures :: TyTraCLAST -> [String]
generateSignatures ast =  map functionSigStr (inferSignatures ast)

generateDefs :: TyTraCLAST -> [String]
generateDefs ast = let 
        functionSignatures = inferSignaturesMap ast
    in
        map (generateSubDef functionSignatures) ast 

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
        Comp (Function f1 nms1) (Function f2 nms2) -> deriveSigComp f1 f2 functionSignatures
        FComp (Function f1 nms1) (Function f2 nms2) -> deriveSigFComp f1 f2 functionSignatures
        ApplyT fs -> deriveSigApplyT fs functionSignatures

-- ApplyT can only arise because of Map, so it can't be Fold.         
deriveSigApplyT :: [Expr] -> (Map.Map Name FSig) -> FSig      
deriveSigApplyT fs functionSignatures =
    let
        fnames = map (\(Function fn _) -> fn) fs
        fsigs = map (\fname -> case Map.lookup fname functionSignatures  of
                Just sig -> sig
                Nothing -> error "Impossible"
            ) fnames
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
            Nothing -> error "Impossible"
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
            Nothing -> error "Impossible"
        fsig2 = case Map.lookup fname2 functionSignatures  of
            Just sig2 -> sig2
            Nothing -> error "Impossible"
        MapFSig (nms1,ms1,os1) =  fsig1
        MapFSig (nms2,ms2,os2) = fsig2
-- the output of f1 is used as the input for f2
-- the nms1 and nms2 should probably a tuple of tuples
        nms 
            | (nms1 == Tuple []) && (nms2 == Tuple []) = Tuple []
            | nms1 == Tuple [] = Tuple [nms2]
            | nms2 == Tuple [] = Tuple [nms1]            
            | otherwise = Tuple [nms1,nms2]
        ms' = ms1
        os' = os2
    in
        MapFSig (nms,ms',os')

-- unpackFSig  MapFSig (nms1,ms1,os1) =  (nms1,ms1,os1)     
-- unpackFSig  FoldFSig (nms1,as1,ms1,os1) =  (nms1,as1,ms1,os1)

deriveSigFComp fname1 fname2 functionSignatures =               
    let
        fsig1 = case Map.lookup fname1 functionSignatures  of
            Just sig1 -> sig1
            Nothing -> error "Impossible"
        fsig2 = case Map.lookup fname2 functionSignatures  of
            Just sig2 -> sig2
            Nothing -> error "Impossible"
        FoldFSig (nms1,as,ms1,os1) = fsig1
        MapFSig (nms2,ms2,os2) = fsig2
    -- the output of f1 is used as the input for f2
    -- the nms1 and nms2 should probably a tuple of tuples
        nms = Tuple [nms1,nms2]
        ms' = ms1
        os' = os2
    in
        FoldFSig (nms,as,ms',os')        



-- t = ("f_maps_acc3_1_0",MapFSig (Scalar VDC DInt "acc1",SVec 3 (DSVec 3 DInt) "sv_f1_in",SVec 3 DInt "sv_f1_out"))
functionSigStr :: (Name, FSig) -> String
functionSigStr t = let
        (fname,ftype) = t
        args = argList ftype 
    in
        fname++"("++(intercalate ", " args)++")"

varName :: Expr -> [Name]
varName (Scalar _ _ vn) = [vn]
varName (SVec _ _  vn) = [vn]
varName (Tuple ts) = concatMap varName ts

argList (MapFSig (nms,ms,os)) =  (varName nms) ++ (varName ms) ++ (varName os)
argList (FoldFSig (nms,as,ms,os)) = (varName nms) ++ (varName as) ++ (varName ms) ++ (varName os)

-- getVarNames :: Expr -> [String]
-- getVarNames (SVec sz dt vn) = [vn]
-- getVarNames (Scalar _ dt vn) = [vn]
-- getVarNames (Tuple es) = concatMap getVarNames es 

-- createDecls :: Expr -> [String]
-- createDecls (SVec sz dt vn) = case dt of
--     DSVec sz2 dt ->  [fortranType(dt)++", dimension("++(show sz)++", "++(show sz2)++") :: "++ vn]
--     DTuple dts -> error "SVec of tuples!" 
--     DDC -> error "SVec DDC!"
--     dt -> [fortranType(dt)++", dimension("++(show sz)++") :: "++ vn]
-- createDecls (Scalar _ dt vn) = if dt == DDC then error "DDC!" else [(fortranType dt)++" :: "++vn]
-- createDecls (Tuple es) = concatMap createDecls es 

createDecl = head . createDecls

fortranType DInt = "integer"
fortranType DInteger = "integer" 
fortranType DReal = "real"
fortranType DFloat = "real"       
fortranType dt = "BOOM! "++(show dt)       

generateSubDef :: (Map.Map Name FSig) -> (Expr, Expr) -> String
generateSubDef functionSignatures t  =
    let
        (lhs,rhs) = t
        Function ho_fname _ = lhs
    in
        case rhs of 
            MapS sv_exp f_exp -> generateSubDefMapS sv_exp f_exp ho_fname functionSignatures
            ApplyT f_exps -> generateSubDefApplyT f_exps ho_fname functionSignatures
            _ -> show rhs


--         t = (Function "f_maps_acc3_1_0" [],MapS (SVec 3 DInt "s2") (Function "f1" ["acc1_1"]))
-- (lhs,rhs) = t
-- Function maps_fname = lhs
generateSubDefMapS :: Expr -> Expr -> Name -> (Map.Map Name FSig) -> String
generateSubDefMapS sv_exp f_exp maps_fname functionSignatures =
    let
-- MapS sv f  = rhs
        SVec sv_sz sv_t _ = sv_exp
        Function fname _ = f_exp
        maps_fsig = case Map.lookup maps_fname functionSignatures of
            Just fs -> fs
            Nothing -> error "BOOM!"
        MapFSig (nms,in_arg,out_arg) = maps_fsig
        non_map_arg_decls = createDecls nms -- tuple becomes list of decls
        sv_in_decl = createDecls in_arg
        sv_out_decl = createDecls out_arg
        non_map_args = getVarNames nms
        sv_in = getVarNames in_arg
        sv_out = getVarNames out_arg
    in unlines [
        "subroutine "++maps_fname++"("  ++(intercalate ", " (non_map_args++sv_in++sv_out))++")"
        , (unlines (map ("    "++) (non_map_arg_decls++sv_in_decl++sv_out_decl)))
        ,"    do i=1,"++ (show sv_sz )
        ,"        call "++fname++"("
            ++(intercalate ", " non_map_args)++", "
            ++(intercalate ", " (map (++"(i)") sv_in))++", "
            ++(intercalate ", " (map (++"(i)") sv_out))
            ++")"
        ,"    end do"
        ,"end subroutine "++maps_fname
    ]
generateSubDefApplyT :: [Expr]  -> Name -> (Map.Map Name FSig) -> String
generateSubDefApplyT f_exps applyt_fname functionSignatures = ""

-- Comp (Function "f4" []) (Function "f_maps_v_3_0" []))
generateSubDefComp :: Expr -> Expr -> Name -> (Map.Map Name FSig) -> String
generateSubDefComp f1_exp f2_exp comp_fname functionSignatures = ""

-- (Function "f_fcomp_acc3_1_2" [],FComp (Function "f2" []) (Function "f_comp_acc3_1_1" []))
generateSubDefFComp :: Expr -> Expr -> Name -> (Map.Map Name FSig) -> String
generateSubDefFComp f1_exp f2_exp fcomp_fname functionSignatures = ""

-- -- Scalar VDC DInt "acc1_1"  => integer :: acc1_1

-- ("f_maps_acc3_1_0",MapFSig (Scalar VDC DInt "acc1_1",SVec 3 (DSVec 3 DInt) "sv_f1_in",SVec 3 DInt "sv_f1_out"))
-- ("f1",MapFSig (Scalar VDC DInt "acc1_1",SVec 3 DInt "v_s_0",Scalar VDC DInt "v_1"))



createDecls :: Expr -> [String]
createDecls (SVec sz dt' vn) = let
        dt = rewriteDT dt'
    in
        case dt of
            -- we know this can only be either nested DSVec or terminal
            DSVec _ _  ->  let
                    (szs,dt') = getSzFromDSVec dt []
                in
                    [fortranType(dt')++", dimension("++(intercalate "," (map show szs))++") :: "++ vn]  
            -- we know this has no tuples inside it    
            DTuple dts -> createDecls (
                Tuple (
                    snd $ foldl (\(ct,tl) dt -> (ct+1,tl++[SVec sz dt (vn++(show ct))] ) )  (0,[]) dts 
                    )
                )
            DDC -> error "SVec DDC!"
            dt -> [fortranType(dt)++", dimension("++(show sz)++") :: "++ vn]
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



-- The result is that DTuple is always on the outside and DSVec is nested 
rewriteDT dt = case dt of
    DSVec sz (DTuple dts) ->  DTuple (map (\dt -> DSVec sz (rewriteDT dt)) dts)
    DTuple dts -> DTuple (foldl (
            \dtl dt -> case dt of 
                DTuple dts -> dtl++dts
                _ -> dtl++[dt]
        ) [] dts)
    _ -> dt

getSzFromDSVec (DSVec sz dt) szs = getSzFromDSVec dt (szs++[sz])  
getSzFromDSVec dt szs = (szs,dt)
module CodeGeneration (inferSignatures) where

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
inferSignatures ast = map functionSigStr (Map.toList (foldl inferSignature functionSignatures ast))

inferSignature ::  (Map.Map Name FSig) -> (Expr,Expr) -> Map.Map Name FSig
inferSignature functionSignatures ast_tup =
    let
-- ast_tup = (Function "f_maps_acc3_1_0" [],MapS (SVec 3 "s2") (Function "f1" ["acc1_1"]))
        (lhs,rhs) = ast_tup
        -- if LHS is a Function we need to add the type info, or not?
       -- maybe not, just updating the map should be enough, we can use that when generating code     
        (fname,mfsig) = case lhs of
            Function fname _ -> (fname,Just $ getFunctionSignature rhs functionSignatures)
            _ -> ("",Nothing)
            -- (Vec VT DDC "vec_acc3_1_3",Stencil (SComb (SVec 3 DInt "s2") (SVec 3 DInt "s1")) (Vec VI DInt "v_0"))            
            -- Vec ve DDC vname -> typeVec rhs ve vname
            -- Scalar 
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
        nms = Tuple [nms1,nms2]
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


-- typeVec rhs ve vname =
--     let        
--         vec = case rhs of
--             Stencil (SComb (SVec sv_sz1 _ _) (SVec sv_sz2 _ _)) (Vec _ dt _) -> Vec VS (SVec sv_sz1 (DSVec sv_sz2 dt) vname)
--             Stencil (SVec sv_sz _ _) (Vec _ dt _) -> Vec VS (SVec sv_sz dt vname)
--             _ -> Vec ve DDC vname
--     in
--         (vec, VecSig vec)

t = ("f_maps_acc3_1_0",MapFSig (Scalar VDC DInt "acc1",SVec 3 (DSVec 3 DInt) "sv_f1_in",SVec 3 DInt "sv_f1_out"))
functionSigStr t = let
        (fname,ftype) = t
        args = argList ftype 
    in
        fname++"("++(intercalate ", " args)++")"

varName :: Expr -> [Name]
varName (Scalar _ _ vn) = [vn]
varName (SVec _ _  vn) = [vn]
varName (Tuple ts) = concat $ map varName ts




argList (MapFSig (nms,ms,os)) =  (varName nms) ++ (varName ms) ++ (varName os)
argList (FoldFSig (nms,as,ms,os)) = (varName nms) ++ (varName as) ++ (varName ms) ++ (varName os)

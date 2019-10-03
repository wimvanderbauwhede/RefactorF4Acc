module CodeGeneration where

import Data.Generics (Data, Typeable, mkQ, mkT, mkM, gmapQ, gmapT, everything, everywhere, everywhere', everywhereM)
import Control.Monad.State
import TyTraCLAST
import ASTInstance 
import qualified Data.Map.Strict as Map

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
nonMapArgs MapFSig (nms,ms,os) = nms
mapArgs MapFSig (nms,ms,os) = ms
outArgs MapFSig (nms,ms,os) = os

nonFoldArgs MapFSig (nfs,as,fs,os) = nfs
foldArgs FoldFSig (nfs,as,fs,os) = fs
accArgs FoldFSig (nfs,as,fs,os) = as
outArgs FoldFSig (nfs,as,fs,os) = os

functionSignatures =  Map.fromList functionSignaturesList

-- We must update this map with the new signatures, so probably use the state monad

ast_tup = (Function "f_maps_acc3_1_0" [],MapS (SVec 3 "s2") (Function "f1" ["acc1_1"]))
(lhs,rhs) = ast_tup

lhs' = case lhs of
    Function fname -> getFunctionSignature rhs 
    _ -> lhs -- for now

getFunctionSignature rhs =
    case rhs of
        MapS (SVec sv_sz _) (Function fname _) -> deriveSigMaps sv_sz fname 
        Comp (Function f1 nms1) (Function f2 nms2) -> deriveSigComp f1 f2
        FComp (Function f1 nms1) (Function f2 nms2) -> deriveSigFComp f1 f2

deriveSigMaps sv_sz fname = 
    let
        fsig = case Map.lookup functionSignatures fname of
            Just sig -> sig
            Nothing -> error "Impossible"
    in            
        case fsig of
            MapFSig (nms,ms,os) -> let
                    ms' = SVec sv_sz ms
                    os' = SVec sv_sz os
                in
                    MapFSig (nms,ms',os')
            FoldFSig (nms,as,ms,os) -> let
                ms' = SVec sv_sz ms
                os' = SVec sv_sz os
            in
                FoldFSig (nms,as,ms',os')          
                
deriveSigComp fname1 fname2                
    let
        fsig1 = case Map.lookup functionSignatures fname1 of
            Just sig1 -> sig1
            Nothing -> error "Impossible"
        fsig2 = case Map.lookup functionSignatures fname2 of
            Just sig2 -> sig2
            Nothing -> error "Impossible"
        MapFSig (nms1,ms1,os1) = fsig1
        MapFSig (nms2,ms2,os2) = fsig2
-- the output of f1 is used as the input for f2
-- the nms1 and nms2 should probably a tuple of tuples
        nms = Tuple [nms1,nms2]
        ms' = ms1
        os' = os2
    in
        MapFSig (nms,ms',os')



deriveSigFComp fname1 fname2                
    let
        fsig1 = case Map.lookup functionSignatures fname1 of
            Just sig1 -> sig1
            Nothing -> error "Impossible"
        fsig2 = case Map.lookup functionSignatures fname2 of
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

-- (Function "f_fcomp_acc3_1_2" [],FComp (Function "f2" []) (Function "f_comp_acc3_1_1" []))        

{-
    MapS means that
- the NonMapArgs are kept 
- The OutArgs are transformed into an SVec based on the 1st arg of MapS
- The input args of the new function are an SVec of the input arg of the function, i.e. the MapArgs
- This can work on FoldFSig but it means that the accumulator is part of the function

f_maps_acc3_1_0 :: (acc1 :: Int)  -> (vs :: SVec 3 (SVec 3 Int))  -> SVec 3 v_T
!-- "f_maps_acc3_1_0" :: 

-}            



module MatchCommonSequences (matchCommonSequences) where

import FTypes 
import Data.Map.Strict as H hiding (map,null)
-- (!) = (H.!)

matchCommonSequences (stref,local,caller,block) localCommonSeq callerCommonSeq equivalencePairs =
        let
        localDim' 
            | localDimSz - localLinIdx == callerDimSz - callerLinIdx  = -- Arrays of identical size
                    updateDim stLocal localDim localLinIdx 1
            | localDimSz - localLinIdx > callerDimSz - callerLinIdx = -- local > caller
                let
                    localLinIdxEnd   = localLinIdx + callerDimSz - callerLinIdx                                 
                in
                    updateDim stLocal localDim localLinIdx localLinIdxEnd
            | otherwise = -- local < caller
                    updateDim stLocal localDim localLinIdx 1              
        callerDim'
            | localDimSz - localLinIdx == callerDimSz - callerLinIdx  = -- Arrays of identical size
                    updateDim stCaller callerDim callerLinIdx 1                            
            | localDimSz - localLinIdx > callerDimSz - callerLinIdx = -- local > caller
                    updateDim stCaller callerDim callerLinIdx 1 
            | otherwise = -- local < caller
                let
                    callerLinIdxEnd   = callerLinIdx + localDimSz - localLinIdx 
                in 
                    updateDim stCaller callerDim callerLinIdx callerLinIdxEnd
        localCommonSeq''
            | localDimSz - localLinIdx == callerDimSz - callerLinIdx  = -- Arrays of identical size
                    localCommonSeq'
            | localDimSz - localLinIdx > callerDimSz - callerLinIdx = -- local > caller
                    if  localDimSz - (localLinIdxEnd + 1) >= 0 
                            then (localDecl, localLinIdxEnd + 1) : localCommonSeq'
                            else localCommonSeq'
            | otherwise = -- local < caller
                    localCommonSeq'        
        callerCommonSeq'' 
            | localDimSz - localLinIdx == callerDimSz - callerLinIdx  = -- Arrays of identical size
                    callerCommonSeq'
            | localDimSz - localLinIdx > callerDimSz - callerLinIdx = -- local > caller
                    callerCommonSeq'
            | otherwise = -- local < caller                
                    if callerDimSz - (callerLinIdxEnd + 1) >= 0 
                        then (callerDecl, callerLinIdxEnd + 1) : callerCommonSeq'
                        else callerCommonSeq'
        equivalencePairs' = equivalencePairs 
            ++ [(localDecl{vDim=localDim'}, callerDecl{vDim=callerDim',vPrefix=prefix})]
        in        
            matchCommonSequences (stref,local,caller,block) localCommonSeq'' callerCommonSeq'' equivalencePairs'
    where
        localElt:localCommonSeq' = localCommonSeq     
        stLocal = (subroutines stref) ! local
        stCaller = (subroutines stref) ! caller
        (localDecl,localLinIdx) = localElt
        localDim = vDim localDecl
        localDimSz = dimSize localDim
        callerElt:callerCommonSeq' = callerCommonSeq
        (callerDecl, callerLinIdx) = callerElt
        callerDim = vDim callerDecl
        callerDimSz = dimSize callerDim
        prefix = [ caller, block ]
        dimSize dim = 1 --dummy
        updateDim st dim ls le = [] --dummy
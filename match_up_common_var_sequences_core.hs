
    (localDim', callerDim', localCommonSeq'',callerCommonSeq'') 
    | localDimSz - localLinIdx ==  callerDimSz - callerLinIdx  = -- Arrays of identical size
        let
            localDim' = updateDim stLocal localDim localLinIdx 1
            callerDim' = updateDim stCaller callerDim callerLinIdx 1                            
        in                            
            (localDim', callerDim', localCommonSeq', callerCommonSeq')                        
    | -- local > caller
            localDimSz - localLinIdx > callerDimSz - callerLinIdx =
            let
                localLinIdxEnd   = localLinIdx + callerDimSz - callerLinIdx                                 
                localDim' = updateDim stLocal localDim localLinIdx localLinIdxEnd 
                callerDim' = updateDim stCaller callerDim callerLinIdx 1 
                localCommonSeq'' = if  localDimSz - (localLinIdxEnd + 1) >= 0 
                        then (decl_local, localLinIdxEnd + 1) : localCommonSeq'
                        else localCommonSeq'
            in
                (localDim', callerDim' ,localCommonSeq'' ,callerCommonSeq')
    | otherwise = -- local < caller
            let
                callerLinIdxEnd   = callerLinIdx + localDimSz - localLinIdx 
                localDim' = updateDim stLocal localDim localLinIdx 1              
                callerDim' = updateDim stCaller callerDim callerLinIdx callerLinIdxEnd
                callerCommonSeq'' = if callerDimSz - (callerLinIdxEnd + 1) >= 0 
                    then (decl_caller, callerLinIdxEnd + 1) : callerCommonSeq'
                    else callerCommonSeq'
            in 
                (localDim', callerDim', localCommonSeq', callerCommonSeq'')
    equivalence_pairs' = equivalence_pairs 
        ++ [(decl_local{vDim=localDim'}, decl_caller{vDim=callerDim',vPrefix=prefix})]

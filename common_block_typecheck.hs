module CommonBlocks where

data FType = FInteger | FReal | FComplex | FLogical

data ArrayOrScalar = Array | Scalar

typecheck 
    (localFType,  localArrayOrScalar,  localKind,  localSize,  localRank ) 
    (callerFType, callerArrayOrScalar, callerKind, callerSize, callerRank) = 
    
    (localKind == callerKind) &&
    (localFType == callerFType ||
            
            case (localArrayOrScalar, callerArrayOrScalar) of
            (Scalar,Scalar) ->
                    (callerFType == FLogical && localFType==FInteger)
                 || (callerFType == FInteger && localFType==FLogical)
                 || (callerFType == FReal    && localFType==FLogical)
            (Array,Array) ->  
                   (localFType == FReal && callerFType == FComplex
                     && localSize >= 2*callerSize)
                || (localFType == FComplex && callerFType == FReal
                     && callerSize >= 2*localSize)
            (Array, Scalar) ->
                (localFType == FReal && callerFType==FComplex
                     && localSize>=2 && localRank==1 )
            (Scalar, Array) ->
                (localFType==FComplex && callerFType == FReal 
                     && callerSize>=2 && callerRank==1)
     ) 

main =  print $ typecheck (FReal, Array, 4, 2, 1) (FComplex, Scalar, 4, 0,0)   

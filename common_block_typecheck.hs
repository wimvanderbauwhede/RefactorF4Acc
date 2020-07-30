module CommonBlocks where
{-
typecheck_rec [] _ = Array
typecheck_rec common_local_seq common_caller_seq = let
        elt_local:common_local_seq' = common_local_seq
	    (name_local, decl_local, kind_local, dim_local, dimsz_local, lin_idx_local, used_local ) = elt_local
        type_local = declType decl_local
    in
		if (!null common_caller_seq) then 
-- get caller
            let
                elt_caller:common_caller_seq' = common_caller_seq
                (name_caller, decl_caller, kind_caller, dim_caller, dimsz_caller, lin_idx_caller, used_caller ) = elt_caller
                type_caller = declType decl_caller
            in

            case (declArrayOrScalar decl_local, declArrayOrScalar decl_caller) of
            (Scalar,Scalar) ->
                if type_local == type_caller then
                    if kind_local == kind_caller then
                        typecheck_rec common_local_seq' common_caller_seq'
                    else  
                        error "Can't match scalars with different kinds"
                else
                    if type_caller == "logical" && type_local=="integer"
                    || type_caller == "integer" && type_local=="logical"
                    || type_caller == "real" && type_local=="logical"
                    then 
                        typecheck_rec common_local_seq' common_caller_seq'
                    else
                        error "Types of local and caller are not compatible"
            (Array,Array) ->  
                if type_local == type_caller then
                        if size_local == size_caller then    
                            if kind_local == kind_caller then -- this is fine, matching array
                                typecheck_rec common_local_seq' common_caller_seq'
                            else 
                                error "Can't match arrays with different kinds"
                        else -- The arrays are not the same size, 
                            if size_local > size_caller then -- the caller array can be entirely mapped onto the local array
                                typecheck_rec common_local_seq' common_caller_seq'
                            else -- consume the entire caller array and then the rest
                                typecheck_rec common_local_seq' common_caller_seq'                            
                        else -- the caller array cannot be entirely mapped onto the local array
                                -- consume the entirel local array
                                typecheck_rec common_local_seq' common_caller_seq'
                else -- type mismatch
                        if type_local == "real" && type_caller == "complex"
                            && size_local >= 2*size_caller                            
                        then -- if the sizes match, we accept that
                                typecheck_rec common_local_seq' common_caller_seq'                           
                        else if type_local == "complex" and type_caller == "real"
                            && size_caller >= 2*size_local
                        then -- if the sizes match, we accept that
                                typecheck_rec common_local_seq' common_caller_seq'
                        else
                            error $ "Can't match array of size "++(show size_local)++" and type "++type_local
                            " to array of "++(show size_caller)++" and type "++type_caller
                            error "Types of local and caller don't match"
            (Array, Scalar) ->
                if type_local == type_caller then
                    if kind_local == kind_caller then
                        typecheck_rec common_local_seq' common_caller_seq'
                    else
                        error "Can't match a scalar to an array with different kinds in call to $f in $caller"		
                else
                    if  type_local == "real" and size_local==2 and rank_local==1 and type_caller=="complex"
                    then
                    else
                        error "Types of local and caller are not compatible in call to $f in $caller"
            (Scalar, Array) ->
                if type_local == type_caller then
                    if kind_local == kind_caller then
                        typecheck_rec common_local_seq' common_caller_seq'
                    else
                        error "Can't match a scalar to an array with different kinds in call to $f in $caller"
                else
                    if  type_local=="complex" and type_caller == "real" and size_caller==2 and rank_caller==1 
                    then
                        typecheck_rec common_local_seq' common_caller_seq'
                    else
                        error "Types of local and caller are not compatible in call to $f in $caller"
        else
            error "Local common block sequence can't be longer than caller common block sequence"
-}

data ArrayOrScalar = Array | Scalar

typecheck 
    (type_local,  array_or_scalar_local,  kind_local,  size_local,  rank_local ) 
    (type_caller, array_or_scalar_caller, kind_caller, size_caller, rank_caller) = 
    
    (kind_local == kind_caller) &&
    (type_local == type_caller ||
            
            case (array_or_scalar_local, array_or_scalar_caller) of
            (Scalar,Scalar) ->
                    (type_caller == "logical" && type_local=="integer")
                 || (type_caller == "integer" && type_local=="logical")
                 || (type_caller == "real"    && type_local=="logical")
            (Array,Array) ->  
                   (type_local == "real" && type_caller == "complex"
                     && size_local >= 2*size_caller)
                || (type_local == "complex" && type_caller == "real"
                     && size_caller >= 2*size_local)
            (Array, Scalar) ->
                (type_local == "real" && type_caller=="complex"
                     && size_local>=2 && rank_local==1 )
            (Scalar, Array) ->
                (type_local=="complex" && type_caller == "real" 
                     && size_caller>=2 && rank_caller==1)
     ) 

main =  print $ typecheck ("real", Array, 4, 2, 1) ("complex", Scalar, 4, 0,0)   

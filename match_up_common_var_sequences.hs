module MatchUpCommonBlocks where

import Data.Map.Strict as H hiding (map,null)


type VarName = String
type Kind = Int
type FType = String -- integer | real | character | ...
-- type ArrayOrScalar = Integer -- 1 for Array, 0 for Scalar
type Dim = [(Int,Int)]
type PrefixStr = [String] 

data ArrayOrScalar = Array | Scalar

data VarDecl = MkVarDecl {
    vType :: FType,
    vArrayOrScalar :: ArrayOrScalar,
    vName :: VarName,
    vKind :: Kind,
    vDim :: Dim, 
    vPrefix :: [String]    
}

type CommonVarTuple = (VarDecl,Int)

data SubroutineRecord = MkSubroutineRecord {
    commonBlockSequences :: H.Map String [CommonVarTuple]
    -- , ...
}

data State = MkState {
    subroutines :: H.Map String SubroutineRecord
    -- , ...
}

-- dim and coords have the same shape and size
__update_dim_with_coords dim coords_start coords_end =
    map (\(d, cs, ce) -> (cs,ce)) (zip3 dim coords_start coords_end)
__update_dim_start_with_coords dim coords =
        map (\(d, c) -> (c,snd d)) (zip dim coords)    
__update_dim_end_with_coords dim coords =
        map (\(d, c) -> (fst d,c)) (zip dim coords)

_calculate_multidim_indices_from_linear _Sfc dim lin_idx = [] -- dummy
addVarDecl stLocal  decl_caller  = MkSubroutineRecord H.empty -- dummy
addPrefixedArg stLocal  decl_caller  = MkSubroutineRecord H.empty -- dummy
dimSize dim = 1 --dummy

_updateDim' dim coords_start coords_end 
    | null coords_start && null coords_end = dim
    | null coords_start = __update_dim_end_with_coords dim coords_end
    | null coords_end = __update_dim_end_with_coords dim coords_start
    | otherwise = __update_dim_with_coords dim coords_start coords_end

updateDim _Sfc dim lin_idx_start lin_idx_end = let
            coords_start
                | lin_idx_start == 1 = []
                | otherwise =  _calculate_multidim_indices_from_linear _Sfc dim lin_idx_start 
            coords_end 
                | lin_idx_end == 1 = []
                | otherwise = _calculate_multidim_indices_from_linear _Sfc dim lin_idx_end 
        in
            _updateDim' dim coords_start coords_end

_match_up_common_var_sequences stref local caller block = let
        stLocal               = subroutines stref ! local
        stCaller               = subroutines stref ! caller
        common_local_seq =  commonBlockSequences stLocal ! block
        common_caller_seq = commonBlockSequences stCaller ! block 
    in        
        __consume_sequences stref (local,caller,block) common_local_seq common_caller_seq []



__consume_sequences stref (local,caller,block) [] common_caller_seq equivalence_pairs = equivalence_pairs
__consume_sequences stref (local,caller,block) common_local_seq [] equivalence_pairs = error "Local too long for caller" -- "
__consume_sequences stref (local,caller,block) (elt_local:common_local_seq') common_caller_seq equivalence_pairs = 
    let
        stLocal = subroutines stref ! local
        stCaller = subroutines stref ! caller
        (decl_local,lin_idx_local) = elt_local
        (name_local, type_local, kind_local, dim_local) = (vName decl_local, vType decl_local, vKind decl_local, vDim decl_local)
        dimsz_local = dimSize dim_local
        elt_caller:common_caller_seq' = common_caller_seq
        (decl_caller, lin_idx_caller) = elt_caller
        name_caller = vName decl_caller
        type_caller = vType decl_caller
        kind_caller = vKind decl_caller
        dim_caller = vDim decl_caller
        dimsz_caller = dimSize dim_caller

        prefix = [ caller, block ]
        (equivalence_pairs',common_local_seq'',common_caller_seq'') = 
            if kind_local /= kind_caller then error "kind mismatch" else
            case (vArrayOrScalar decl_local,vArrayOrScalar decl_caller) of
            (Scalar,Scalar) -> 
                            (equivalence_pairs, common_local_seq',common_caller_seq')
--  If I treat a Scalar as an Array of size 1, I only need this one:                            
            (Array,Array) -> 
                let
                    (dim_local', dim_caller', common_local_seq'',common_caller_seq'') 
                        | dimsz_local - lin_idx_local ==  dimsz_caller - lin_idx_caller  = -- Arrays of identical size
                            let
                                dim_local' = updateDim stLocal dim_local lin_idx_local 1
                                dim_caller' = updateDim stCaller dim_caller lin_idx_caller 1                            
                            in                            
                                (dim_local', dim_caller', common_local_seq', common_caller_seq')                        
                        | -- local > caller
                             dimsz_local - lin_idx_local > dimsz_caller - lin_idx_caller =
                                let
                                    lin_idx_local_end   = lin_idx_local + dimsz_caller - lin_idx_caller                                 
                                    dim_local' = updateDim stLocal dim_local lin_idx_local lin_idx_local_end 
                                    dim_caller' = updateDim stCaller dim_caller lin_idx_caller 1 
                                    common_local_seq'' = if  dimsz_local - (lin_idx_local_end + 1) >= 0 
                                            then (decl_local, lin_idx_local_end + 1) : common_local_seq'
                                            else common_local_seq'
                                in
                                    (dim_local', dim_caller' ,common_local_seq'' ,common_caller_seq')
                        | otherwise = -- local < caller
                                let
                                    lin_idx_caller_end   = lin_idx_caller + dimsz_local - lin_idx_local 
                                    dim_local' = updateDim stLocal dim_local lin_idx_local 1              
                                    dim_caller' = updateDim stCaller dim_caller lin_idx_caller lin_idx_caller_end
                                    common_caller_seq'' = if dimsz_caller - (lin_idx_caller_end + 1) >= 0 
                                        then (decl_caller, lin_idx_caller_end + 1) : common_caller_seq'
                                        else common_caller_seq'
                                in 
                                    (dim_local', dim_caller', common_local_seq', common_caller_seq'')
                    equivalence_pairs' = equivalence_pairs 
                        ++ [(decl_local{vDim=dim_local'}, decl_caller{vDim=dim_caller',vPrefix=prefix})]
                in
                    (equivalence_pairs' ,common_local_seq'' ,common_caller_seq'')
            (Scalar,Array) ->
                    let
                        dim_caller'      =  updateDim stCaller dim_caller lin_idx_caller lin_idx_caller

                        common_caller_seq'' = if dimsz_caller - lin_idx_caller + 1 >= 0 
                            then (decl_caller, lin_idx_caller + 1) : common_caller_seq'
                            else common_caller_seq'                    

                        equivalence_pairs' = equivalence_pairs 
                            ++ [(decl_local,decl_caller{vDim=dim_caller',vPrefix=prefix})]
                    in
                        (equivalence_pairs' ,common_local_seq' ,common_caller_seq'')
            (Array,Scalar) -> 
                    let
                        dim_local'      = updateDim stLocal dim_local lin_idx_local lin_idx_local

                        equivalence_pairs' = equivalence_pairs 
                            ++ [(decl_local{vDim=dim_local'},decl_caller{vPrefix=prefix})]

                        common_local_seq'' = if dimsz_local - lin_idx_local + 1 >= 0  
                            then (decl_local, lin_idx_local + 1) : common_local_seq'
                            else common_local_seq'    

                    in
                        (equivalence_pairs' ,common_local_seq'' ,common_caller_seq')    

        stLocal' = addPrefixedArg stLocal decl_caller{vPrefix=prefix}                        
        subroutines' = H.adjust (const stLocal') local (subroutines stref)
        stref' = stref{subroutines = subroutines' }
    in
        __consume_sequences stref' (local,caller,block) common_local_seq'' common_caller_seq'' equivalence_pairs' 




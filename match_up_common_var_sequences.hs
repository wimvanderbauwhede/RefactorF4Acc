module MatchUpCommonBlocks where

import Data.Map.Strict as H hiding (map)


type VarName = String
type Kind = Int
type FType = String -- integer | real | character | ...
-- type ArrayOrScalar = Integer -- 1 for Array, 0 for Scalar
type Dim = [(Int,Int)]
type PrefixStr = [String] 

data ArrayOrScalar = Array | Scalar

data VarDecl = MkVarDecl {
    getType :: String,
    getArrayOrScalar :: ArrayOrScalar
}

type CommonVarTuple = (VarName, VarDecl, Kind, Dim, Int, Int, Bool)

data SubroutineRecord = MkSubroutineRecord {
    commonBlockSequences :: H.Map String [CommonVarTuple]
}

data State = MkState {
    subroutines :: H.Map String SubroutineRecord
}

-- dim and coords have the same shape and size
__update_dim_with_coords dim coords_start coords_end =
    map (\d cs ce -> (cs,ce)) (zip3 dim coords_start coords_end)
__update_dim_start_with_coords dim coords =
        map (\d c -> (c,snd d)) (zip dim coords)    
__update_dim_end_with_coords dim coords =
        map (\d c -> (fst d,c)) (zip dim coords)

_match_up_common_var_sequences stref f caller block = let
        _Sf :: SubroutineRecord
        _Sf               = (subroutines stref) ! f
        _Sc               = (subroutines stref) ! caller
        common_local_seq =  (commonBlockSequences _Sf) ! block
        common_caller_seq =  (commonBlockSequences _Sc) ! block 

        -- equivalence_pairs ::  [(VarName,FType,ArrayOrScalar,Dim,PrefixStr)]
        --  [ name, type, 0|1, [], [] ]
        -- type VarName = String
        -- type FType = String -- integer | real | character | ...
        -- type ArrayOrScalar = Integer -- 1 for Array, 0 for Scalar
        -- type Dim is [[Integer]]
        -- type PrefixStr = [String]    
        in        
        -- equivalence_pairs = 
        __consume_sequences stref f common_local_seq common_caller_seq []

calculate_multidim_indices_from_linear stref caller dim_caller_copy lin_idx_caller = []

__consume_sequences stref f [] common_caller_seq equivalence_pairs = equivalence_pairs
__consume_sequences stref f common_local_seq [] equivalence_pairs = error "Local too long for caller" -- "
__consume_sequences stref f (elt_local:common_local_seq') common_caller_seq equivalence_pairs = let
    _Sf = (subroutines stref) ! f
    (name_local, decl_local, kind_local, dim_local, dimsz_local, lin_idx_local, used_local ) = elt_local
    type_local = getType decl_local
    elt_caller:common_caller_seq' = common_caller_seq
    (name_caller, decl_caller, kind_caller, dim_caller, dimsz_caller, lin_idx_caller, used_caller ) = elt_caller
    type_caller = getType decl_caller
    prefix = if block == "BLANK" then [caller] else [ caller, block ]
    (_Sf',equivalence_pairs',common_local_seq'',common_caller_seq'') = 
        if kind_local /= kind_caller then error "kind mismatch" else
        case (getArrayOrScalar decl_local,getArrayOrScalar decl_scalar) of
        (Scalar,Scalar) ->
                        (add_var_decl_to_set _Sf "ExGlobArgs" name_caller decl_caller
                        ,equivalence_pairs,common_local_seq')
        (Array,Array) ->                        
                if dimsz_local - lin_idx_local ==  dimsz_caller - lin_idx_caller  then    -- Arrays of identical size
                    let
                        dim_local_copy = if lin_idx_local /= 1 then
                                let
                                    coords_local = calculate_multidim_indices_from_linear stref f dim_local lin_idx_local 
                                in
                                    __update_dim_start_with_coords dim_local coords_local
                            else dim_local
                    
                        dim_caller_copy = if lin_idx_caller /= 1 
                            then
                                let
                                    coords_caller = calculate_multidim_indices_from_linear stref caller dim_caller lin_idx_caller 
                                in
                                    __update_dim_start_with_coords dim_caller coords_caller
                            else dim_caller
                    in
                        if  name_local == name_caller then
                            if  lin_idx_local /= lin_idx_caller then
                                ( __add_prefixed_arg _Sf name_caller decl_caller caller block 
                                , equivalence_pairs 
                                ++ [((name_local, type_local, Array, dim_local_copy, []), (name_caller, type_caller, Array, dim_caller_copy, prefix))]
                                ,common_local_seq'
                                ,common_caller_seq')
                            else    -- we use the same name for caller and local, but it means we have to add the arg to ExGlobArgs
                                (add_var_decl_to_set _Sf "ExGlobArgs" name_caller decl_caller
                                , equivalence_pairs
                                ,common_local_seq'
                                ,common_caller_seq') 
                        else  -- different names.
                            (add_var_decl_to_set _Sf "ExGlobArgs" name_caller decl_caller
                            , equivalence_pairs
                            ++ [((name_local, type_local, Array, dim_local_copy, []),(name_caller, type_caller, Array, dim_caller_copy, []))]
                            ,common_local_seq'
                            ,common_caller_seq'
                            )
                    
                else   --error "" -- Arrays of different size        
                    -- if they have the same name I need to prefix the caller name
                    if  dimsz_local - lin_idx_local  > dimsz_caller - lin_idx_caller then  -- local is larger
                        let
                            lin_idx_local_end   = lin_idx_local + dimsz_caller - lin_idx_caller 
                            lin_idx_local_start = lin_idx_local

                            -- Now increment the index
                            coords_local_end = calculate_multidim_indices_from_linear stref f dim_local_copy lin_idx_local_end 
                            dim_local_copy' = __update_dim_end_with_coords dim_local coords_local_end
                            dim_local_copy = if lin_idx_local_start /= 1 then 
                                    let
                                    coords_local = calculate_multidim_indices_from_linear stref f dim_local_copy lin_idx_local_start
                                    in 
                                        __update_dim_start_with_coords dim_local_copy' coords_local
                                else dim_local_copy'
                            dim_caller_copy = -- error "" --if lin_idx_caller /= 1 then
                                let
                                   coords_caller = calculate_multidim_indices_from_linear stref caller dim_caller_copy lin_idx_caller
                                in
                                   __update_dim_start_with_coords dim_caller coords_caller
                            lin_idx_local' =  lin_idx_local + dimsz_caller - lin_idx_caller + 1 
                            common_local_seq'' =
                                if  dimsz_local - lin_idx_local' >= 0 then 
                                    let
                                      elt_local =  (name_local, decl_local, kind_local, dim_local, dimsz_local, lin_idx_local, used_local) 
                                    in
                                      elt_local:common_local_seq'
                                else 
                                    common_local_seq
                            (_Sf', prefix') = if name_local == name_caller then
                                        ( __add_prefixed_arg _Sf name_caller decl_caller caller block, prefix)
                                    else 
                                        (add_var_decl_to_set _Sf "ExGlobArgs" name_caller decl_caller, [])    
                        in
                            (_Sf'
                            ,equivalence_pairs 
                            ++ [((name_local, type_local, Array, dim_local_copy, []),(name_caller, type_caller, Array, dim_caller_copy, prefix'))]
                            ,common_local_seq''
                            ,common_caller_seq')

                            -- if the local lin index has not entirely consumed the array, we need to unshift
                    else -- the opposite 
                      let
                        lin_idx_caller_end   = lin_idx_caller + dimsz_local - lin_idx_local 
                        lin_idx_caller_start = lin_idx_caller
                        -- Now increment the index
                        coords_caller_end = calculate_multidim_indices_from_linear stref caller dim_caller_copy lin_idx_caller_end
                        dim_caller_copy' = __update_dim_end_with_coords dim_caller coords_caller_end
                        dim_local_copy = if lin_idx_local /= 1 
                          then 
                            let
                                coords_local = calculate_multidim_indices_from_linear stref f dim_local_copy lin_idx_local
                            in
                                __update_dim_start_with_coords dim_local coords_local
                          else local_copy 
                        dim_caller_copy = if lin_idx_caller_start /= 1 
                          then 
                            let
                                coords_caller = calculate_multidim_indices_from_linear stref caller dim_caller_copy lin_idx_caller_start
                            in
                                __update_dim_start_with_coords dim_caller_copy' coords_caller

                          else caller_copy 
                        lin_idx_caller' = lin_idx_caller + dimsz_local - lin_idx_local + 1 
                        common_caller_seq'' = if dimsz_caller - lin_idx_caller' >= 0 
                          then
                            let
                                elt_caller = (name_caller, decl_caller, kind_caller, dim_caller, dimsz_caller, lin_idx_caller, used_caller)
                            in
                                elt_caller: common_caller_seq'
                          else common_caller_seq'
                        (_Sf', prefix') = if name_local eq name_caller 
                          then
                                -- In that case the SigArg should get the prefix as well
                                (__add_prefixed_arg _Sf name_caller decl_caller caller block, prefix)
                          else 
                                (add_var_decl_to_set _Sf "ExGlobArgs" name_caller decl_caller, [])
                      in 
                            (_Sf
                            ,equivalence_pairs 
                            ++ [((name_local, type_local, Array, dim_local_copy, []),(name_caller, type_caller, Array, dim_caller_copy, prefix'))]
                            ,common_local_seq'
                            ,common_caller_seq'')
        (Scalar,Array) -> -- local is Scalar, caller is Array
                let
                    -- increment dim
                    -- We support a scalar with a larger kind, simply by having
                    lin_idx_caller_start = lin_idx_caller
                    lin_idx_caller_end   = lin_idx_caller_start + kind_caller / kind_local - 1                -- so, usually this is 0
                    coords_start         = calculate_multidim_indices_from_linear( stref, caller, dim_caller, lin_idx_caller_start )
                    coords_end           = calculate_multidim_indices_from_linear( stref, caller, dim_caller, lin_idx_caller_end )

                    dim_caller_copy      =  __update_dim_with_coords dim_caller coords_start coords_end

                    (_Sf', prefix') = if  name_local eq name_caller then
                        -- In that case the SigArg should get the prefix as well
                        (__add_prefixed_arg _Sf name_caller decl_caller caller block , prefix)
                    else 
                        (add_var_decl_to_set _Sf "ExGlobArgs" name_caller decl_caller, [] )
                    -- increment lin idx. But if the lin idx is already the dimsz, we should not do this, as it means we"re at the last element.
                    -- e.g. if the caller idx is 3 and the caller array is 4, then 4-3 = 1 > 0
                    lin_idx_caller' = lin_idx_caller + kind_local / kind_caller    -- currently this of course just means +=1
                    common_caller_seq'' = if dimsz_caller - lin_idx_caller >= 0 then
                        let
                            elt_caller = ( name_caller, decl_caller, kind_caller, dim_caller, dimsz_caller, lin_idx_caller, used_caller) 
                        in
                            elt_caller : common_caller_seq'
                    else common_caller_seq'
                    
                in
                    (_Sf'        
                    ,equivalence_pairs 
                    ++ [ [ name_local, type_local, Scalar, dim_local_copy, [] ], [ name_caller, type_caller, Array, [], prefix' ] ]
                    ,common_local_seq'
                    ,common_caller_seq'')
        (Array,Scalar) -> -- local is Array, caller is Scalar
                let
                    lin_idx_local_start = lin_idx_local
                    lin_idx_local_end   = lin_idx_local_start + kind_local / kind_caller - 1          -- so, usually this is 0
                    coords_start        = calculate_multidim_indices_from_linear( stref, f, dim_local, lin_idx_local_start )
                    coords_end          = calculate_multidim_indices_from_linear( stref, f, dim_local, lin_idx_local_end )
                    dim_local_copy      = __update_dim_with_coords dim_local coords_start coords_end
                    (_Sf',prefix') = if name_local eq name_caller then
                        -- In that case the SigArg should get the prefix as well
                         (__add_prefixed_arg _Sf name_caller decl_caller caller block, prefix )
                    else                        
                        (add_var_decl_to_set _Sf "ExGlobArgs" name_caller decl_caller,[] )
                    -- increment lin idx. But if the lin idx is already the dimsz, we should not do this, as it means we"re at the last element.
                    lin_idx_local' =lin_idx_local + kind_caller / kind_local    -- works if the are dividable
                    common_local_seq'' = if dimsz_local - lin_idx_local >= 0  then      -- 15-14>0 => unshift it
                            let
                                elt_local = [ name_local, decl_local, kind_local, dim_local, dimsz_local, lin_idx_local, used_local ]
                            in
                                elt_local :common_local_seq'
                        else common_local_seq'    
                in
                    (_Sf'
                    ,equivalence_pairs
                    ++ [((name_local, type_local, Array, dim_local_copy, []),(  name_caller, type_caller, Scalar, [], prefix')) ]
                    ,common_local_seq''
                    ,common_caller_seq')

    in
        __consume_sequences 
        stref{subroutines = H.update (subroutines stref) f _Sf'}
         f common_local_seq'' common_caller_seq'' equivalence_pairs' 

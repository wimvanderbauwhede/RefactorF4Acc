# Memory Reduction for Scientific Computing on GPUs

## Background

Currently, the LES uses a large number of intermediate arrays which are stored in the global memory.

I contend that we only need the actual input arrays and we can recompute all the rest from those. So rather than writing back to memory, we store what we need in a smart buffer.

For the LES we have u,v,w,p as inputs, but we actually use:

    p (double)
    u,v,w
    usum,vsum,wsum
    f,g,h
    fold,gold,hold
    sm
    rhs


So my contention is that we could go from these 16 arrays to only 4 plus 12 smart buffers which only take 3/kp of the space, so in total:

4+12*3/kp = 4.45 for kp=80 so a reduction in memory of 3.6x, so we could go from the current domain size of 300x300 to 568x568

## Current status

F77 -> F95 without globals<br>
F95 without globals -> OpenCL with maps and folds<br>
OpenCL with maps and folds -> TyTraCL & TyTraIR -> FPGA<br>
TyTraCL -> TyTraIR<br>
TyTraIR -> FPGA

## Removing intermediate arrays


### TyTraCL

The TyTraCL language is syntactically a subset of Haskell, with the addition of two types of vectors of fixed size.

#### Types

    v_i :: Vec n a
    s_i :: SVec k Int
    f_i :: a -> b

#### Primitives

    -- As in Haskell but on Vec rather than []
    map : (a -> b) -> Vec n a -> Vec n b
    -- Haskell's foldl but on Vec rather than []
    fold :: (a -> b -> a) -> a -> Vec n b -> a

    -- Ordinary map but only works on SVec
    maps : (a -> b) -> SVec k a -> SVec k b

    -- Every element of the vector is replaced by the stencil defined by the first argument
    stencil : SVec k Int -> Vec n a -> Vec n (SVec k a)

    -- Like Haskell's zip/unzip but takes a tuple as argument and works on Vec
    zipt :: (...,Vec n a_i,...)  -> Vec n (...,a_i,...)]
    unzipt :: Vec n (...,a_i,...) -> (...,Vec n a_i,...)

    -- Apply a tuple of functions to a tuple of values
    applyt :: (...,a_i -> b_i,...) (...,a_i,...) -> (...,b_i,...)
    applyt (...,f_i,...) (...,e_i,...) =\(...,e_i,...) -> (...,f_i e_i,...)

    -- Generalisation of Haskell's fst/snd
    elt :: i:: Int -> (...,a_i,...) -> a_i
    elt i (...,e_i,...) = e_i

#### Other TyTraCL primitives    

    split :: k -> Vec n a -> Vec k (Vec n/k a)
    merge :: Vec k (Vec n/k a) -> Vec n a

    select :: SVec k Int -> Vec n a -> Vec k a
    select patt v = maps (\idx -> v !! idx) patt
    -- Example:
    v' = select [ i*jm*km+j*km+k_const | i <- [0 .. im-1],  j <- [0 .. jm-1], k <- [0..km-1] ] v

    insert :: SVec k Int -> Vec k a -> Vec n a -> Vec n a
    insert target_pattern small_list target_list    

    replicate :: Int k => k -> a -> Vec k a

#### Rewrite rules SEE CODE!

    map f_2 (map f_1 v) = map (f_2 . f_1) v    

    v = map id v -- but only if this v appears in a ZipT where at least one of the other expressions is a map

    zipt (map f_1 v_1, map f_2 v_2) = map (applyt (f_1,f_2)) (zipt (v_1, v_2)) -- if all exprs in ZipT are maps

    applyt (g_1,g_2) $ applyt (f_1,f_2)  = applyt (g_1 . f_1, g_2 . f_2)

    (elt i) . unzipt . (map f (zipt (...,v_i,...))) = map ((elt i) . f) (zipt (...,v_i,...))

    stencil s_1 (map f_1) = map (maps f_1) (stencil s_1)

## Aim

The aim is to rewrite the program so that it is a single `map` call.

## AST

Starting from the OpenCL Fortran code:

1. Scalarize all functions
2. Insert `stencil` calls as required
3. If a call requires a stencil of a previous call, insert a `maps` as required

Then we transform the resulting AST into a simpler AST for rewriting, see below.

## Rewrite algorithm

### Without `fold`

For every call, we look at the V_like argument first.
If it is not a vector then it must be a ZipT or a Stencil.
For a ZipT we do each arg in turn.
In principle this maybe have to be done recursively until we hit an actual Vector. For that Vector we find the assignment where it is on the LHS. Then we check the type of the RHS and the type of the parent node. As our aim is to reduce the maps, we always apply rules that aim to transform a nest call into a single map.

## Fortran-OpenCL implementation

The actual stencils

    ! stencil
    integer, dimension(size_s,2) :: s
    real, dimension(size_s) :: v_s    
    do s_idx = 1,size_s
      v_s(s_idx) = v(j+s(s_idx,1),k+s(s_idx,2))
    end do

    ! maps -- I think we'll need to add in the stencil as arg after all, to get the size
    real :: u_0, v_s
    real, dimension(size_s) :: u_s    
    do s_idx = 1,size_s
      v_s = v(j+s(s_idx,1),k+s(s_idx,2))
      call f(u_0,v_s)
      u_s(s_idx)=u_0
    end do

    ! applyt

    

### Reduction

- Pair up `applyt` with `zipt` and `maps` with `stencil`
- Reduce via SSA

## Staging

  However, this requires staging. For example, take the case of the rhs for the SOR.

  This is calculated from p,u,v,w using a reduction, and then the reduced value is subtracted from the original.

  So what we have to do is always recompute rather than store the intermediates in memory.

## Proofs

### Proof for the Stencil-Map rewrite rule

    s1 : SVec k Int
    f1 : a -> b

    stencil s1 (map f1) = map (maps f1) (stencil s1)

    v0 : Vec n a
    f1 : a -> b
    v1 : Vec n b

    v1s : Vec n (SVec k b)
    v1 = map f1 v0
    v1s = stencil s1 v1

    v0s : Vec (SVec k a)
    v0s = stencil s1 v0

    maps f1 : SVec k a -> SVec k b
    v1s : Vec n (SVec k b)
    v1s = map (maps f1) v0s

    or

    stencil s1 (map f1 v1) = map (maps f1) (stencil s1 v1)


### Proof that the rewrite rules terminate into the correct expressions

...

### What about `fold`

The purpose of the exercise is to eliminate intermediate arrays. These occur because of the need for stencils; or they might be present in the original code.

- If an intermediate array is present in the original code, we have something like

    v1 = map f1 v0
    v2 = map f2 v1

This means that the intermediate array will automatically disappear because of the `substituteVectors` pass.

- If there is a stencil, it can either occur between a `map` and a `map` or between a `map` and a `fold`. E.g.

    v1 = map f1 v0
    v1_s = stencil s1 v1
    v2 = map f2 v1_s

or

    v1 = map f1 v0
    v1_s = stencil s1 v1
    acc2 = fold f2 acc0 v1_s

Now, after the 2nd pass this will be

    acc2 = fold f2 acc0 (stencil s1 (map f1 v0))

This will then be rewritten into     

    acc2 = fold f2 acc0 (map (maps f1) (stencil s1 v0))

The `fold` does not even come into this.

So all I need to do is ensure that the fold expressions are not ignored.

## Example code and refining of AST

### Example: TyTrCL for 2-D Shallow Water Model

    main (etan_0,wet_0,eps_0,dt_0,g_0,dx_0,dy_0,wet_0,u_0,v_0,duu_0,dvv_0,h_0,dt_0,dx_0,dy_0,hzero_0,hmin_0) =
      let
         -- shapiro_map_15
        s1 = [-1,-502,0,502,1]
        etan_s_0 = stencil s1 etan_0
        s2 = [-1,-502,0,502,1]
        wet_s_0 = stencil s2 wet_0
        eta_1 =  map (shapiro_map_15 eps_0) (zipt (wet_s_0,etan_s_0))
         -- dyn_map_38
        s3 = [0,502,1]
        eta_s_0 = stencil s3 eta_1
        (du_1,dv_1) = unzipt $ map (dyn_map_38 (dt_0,g_0,dx_0,dy_0)) eta_s_0
         -- dyn_map_44
        s4 = [0,502,1]
        wet_s_1 = stencil s4 wet_0
        (duu_1,dvv_1,un_1,vn_1) = unzipt $ map (dyn_map_44 (duu_0,dvv_0)) (zipt (u_0,du_1,wet_s_1,v_0,dv_1))
         -- dyn_map_64
        s5 = [-1,0]
        vn_s_0 = stencil s5 vn_1
        s6 = [-502,0]
        un_s_0 = stencil s6 un_1
        s7 = [-1,-502,0,502,1]
        h_s_0 = stencil s7 h_0
        etan_1 =  map (dyn_map_64 (dt_0,dx_0,dy_0)) (zipt (un_s_0,h_s_0,vn_s_0,eta_s_0))
         -- vernieuw_map_23
        (h_1,u_1,v_1,wet_1) = unzipt $ map (vernieuw_map_23 hmin_0) (zipt (hzero_0,eta_s_0,h_s_0,un_s_0,vn_s_0))
      in
        (eta_1,du_1,dv_1,un_1,vn_1,etan_1,h_1,u_1,v_1,wet_1)

### The AST type    

type Name = String
data VE = VI  | VO  | VS  | VT deriving (Show)
type AST = [(Expr,Expr)]                      

data Expr =
        -- Left-hand side:
                      Scalar
                    | Tuple [Expr]
                    | Vec VE Name

        -- Right-hand side:
                    | SVec Int Name
                    | ZipT [Expr]
                    | UnzipT Expr
                    | Elt Integer Expr -- I also need this partially-applied
                    | PElt Integer
                    | Map Expr Expr
                    | Fold Expr Expr Expr
                    | Stencil Expr Expr
                    | Function Name
                    | ApplyT [Name]  
                    | MapS Name
                    | Comp Expr Expr
                        deriving (Show)

        -- Initially, all RHS nodes will be Map, Fold or Stencil.

### AST of the example        
ast :: AST
ast = [
          (Vec VS "etan_s_0" , Stencil (SVec 5 "s1") (Vec VI "etan_0"))
          ,(Vec VS "wet_s_0" , Stencil (SVec 5 "s2") (Vec VI "wet_0"))
          ,(Vec VO "eta_1", Map (Function "shapiro_map_15 eps_0") (ZipT [Vec VS "wet_s_0",Vec VS "etan_s_0"]))
          ,(Vec VS "eta_s_0", Stencil (SVec 3 "s3") (Vec VO "eta_1"))
          ,((Tuple [Vec VO "du_1", Vec VO "dv_1"]) , UnzipT (Map (Function "dyn_map_38 (dt_0,g_0,dx_0,dy_0)") (Vec VS "eta_s_0") ) )
          ,(Vec VS "wet_s_1", Stencil (SVec 3 "s4") (Vec VI "wet_0"))
          ,(Tuple [Vec VT "duu_1",Vec VT "dvv_1",Vec VO "un_1",Vec VO "vn_1"] , Map (Function "dyn_map_44 (duu_0,dvv_0)") (ZipT [Vec VI "u_0",Vec VO "du_1",Vec VS "wet_s_1",Vec VI "v_0",Vec VO "dv_1"]))
          ,(Vec VS "vn_s_0" , Stencil (SVec 2 "s5") (Vec VO "vn_1"))
          ,(Vec VS "un_s_0" , Stencil (SVec 2 "s6") (Vec VO "un_1"))
          ,(Vec VS "h_s_0" , Stencil (SVec 5 "s7") (Vec VI "h_0"))
          ,(Vec VO "etan_1" , Map (Function "dyn_map_64 (dt_0,dx_0,dy_0)") (ZipT [Vec VS "un_s_0",Vec VS "h_s_0",Vec VS "vn_s_0",Vec VS "eta_s_0"]))
          ,(Tuple [Vec VO "h_1",Vec VO "u_1",Vec VO "v_1",Vec VO "wet_1"] , Map (Function "vernieuw_map_23 hmin_0") (ZipT [Vec VI "hzero_0",Vec VS "eta_s_0",Vec VS "h_s_0",Vec VS "un_s_0",Vec VS "vn_s_0"]))
       ]

main = do
    print ast      

### Applying the rewrite rules

1.  Replace all LHS _Tuple_ occurrences with multiple expressions using _Elt_ on the RHS. As a result, the LHS will be purely _Vec_.

      ast' = foldl split_lhs_tuples [] ast
      split_lhs_tuples acc t@(lhs,rhs) = let
          ts = case lhs of
              Tuple vecs -> split_tuple vecs rhs
              _ -> [t]
          in
              acc++ts

      split_tuple vecs rhs = let
              vecs_idxs = zip vecs [0 .. length vecs - 1]
          in
              foldl (\acc (vec,idx) ->  acc++[(vec, Elt idx rhs)]) [] vecs_idxs

2. Substitute all _Vec VT_ and _Vec VS_ recursively until no _Vec V_ and _Vec VS_ remain in the AST. We start from the last expression in the list. We must also substitute _Vec VO_ on the RHS but tuples with _Vec VO_ on the LHS can't be removed. Clearly, _Vec VI_ should never occur on the LHS.
3. In this AST we can start applying the rewrite rules.
4. After this we decompose the expressions in SSA/ANF style

The key question is which rules to apply, does the order matter? We need to look for patterns. As the principal aim is to replace stencils of maps, looking for stencils is a good first step.

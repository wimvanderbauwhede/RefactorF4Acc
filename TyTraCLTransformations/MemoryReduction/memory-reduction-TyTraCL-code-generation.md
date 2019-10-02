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

TyTraCL is a composition language, its aim is to express dataflow graphs. The actual input values and computations do not  need to be defined, so instances of the above types are ony declared.

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

To recreate the Fortran code from the AST, I need the signatures for the original scalarised Fortran subroutines as well as the signatures for the TyTraCL functions. And I also need signatures for the generated functions. I will then need to generate wrapper functions to go between the TyTraCL functions and the Fortran routines. Essentially, packing/unpacking of stencil tuples. A lot of this has been done in `RefactorF4Acc::Translation::LlvmToTyTraIR`

### SVec encoding

The stencil `SVec s_i_ sz "s_i"` is encoded as an array which contain the index offset tuple for each stencil point. For a paper I think making this work for 2-D arrays is fine. For every global index value, we derive `j` and `k` as usual. Then we populate the array `v_s` with the values at the points in `v` references by the stencil around `(j,k)`.

We can emit all of these from the stencil pattern info, see e.g. `RefactorF4Acc::Translation::TyTraCL::generate_TyTraCL_stencils()`.

### Stencil

Given the stencil information, we can generate the stencil as a constant array.

Example: `(SVec 2 "exp_h_1_4",Stencil (SVec 2 "s1") (Vec VI "wet_0"))`

    ! stencil
    integer, parameter, dimension(2*2) :: s1 = [...]
    real, dimension(2) :: exp_h_1_4    
    do s_idx = 0,1
      exp_h_1_4(s_idx) = v(j+s1(s_idx*2),k+s_i(s_idx*2+1))
    end do


### MapS

For any new function, I need to create the signature. I think I'd better keep the non-map/fold args separate from the function name

Example: `(Function "exp_h_1_1",MapS (SVec 2 "s5") (Function "shapiro_map_24 (eps_0,etan_avg_1)"))`

    ! maps 
    subroutine exp_h_1_1(eps_0,etan_avg_1, v_i, j,k, v_o)
        real, parameter :: s_i_sz 
        real, dimension(2*s_i_sz), parameter :: s_i = [ ...]         
        real, dimension(jm,km), intent(in) :: v_i
        real, dimension(s_i_sz), intent(out) :: v_o
        real :: u_o
        do s_idx = 0,v_s_i-1
            v_s = v_i(j+s_i(s_idx*2),k+s_i(s_idx*2+1))
            call shapiro_map_24(eps_0,etan_avg_1, v_s,u_o)
            v_o(s_idx)=u_o
        end do
    end subroutine exp_h_1_1

### ApplyT

Example: `(Function "exp_h_1_2",ApplyT [Id,Function "exp_h_1_1",Id,Id])`

ApplyT applies a tuple of functions to a tuple of values. So 

    ! applyt
    subroutine exp_h_1_2(t_i, t_o)
        real, dimension(4) :: t_i, t_o
        real :: t_o_3
        t_o(1)=t_i(1)
        t_o(2)=t_i(2)
        call exp_h_1_1(t_i(3),t_o_3)
        t_o(3)=t_o_3
        t_o(3)=t_i(4)
    end subroutine exp_h_1_2

### Comp

Example: `(Function "exp_h_1_0",Comp (PElt 0) (Function "update_map_24 (hmin_0)"))`

    ! comp
    subroutine exp_h_1_0(hzero_j_k,eta_j_k,h_j_k,hmin,un_j_k,vn_j_k, wet_j_k)        
        real, intent(in) :: hzero_j_k,eta_j_k,h_j_k,hmin,un_j_k
        real, intent(out) :: wet_j_k
        real :: u_j_k,v_j_k
        call update_map_24(hzero_j_k,eta_j_k,h_j_k,hmin,un_j_k,vn_j_k,wet_j_k,u_j_k,v_j_k)        
    end subroutine exp_h_1_2

Example: `(Function "exp_h_1_3",Comp (Function "exp_h_1_0") (Function "exp_h_1_2"))`

    ! comp
    subroutine exp_h_1_3(t_i,t_o)        
        real, intent(in) :: t_i
        real, intent(out) :: t_o
        real :: t_int        
        call exp_h_1_0(t_i, t_int)
        call exp_h_1_2(t_int,t_o)
    end subroutine exp_h_1_3



## Proofs

### Proof for the Stencil-Map rewrite rule

    s1 : SVec k Int
    f1 : a -> b

    stencil s1 (map f1) = map (maps s1 f1) (stencil s1)

    v0 : Vec n a
    f1 : a -> b
    v1 : Vec n b

    v1s : Vec n (SVec k b)
    v1 = map f1 v0
    v1s = stencil s1 v1

    v0s : Vec (SVec k a)
    v0s = stencil s1 v0

    maps s1 f1 : SVec k a -> SVec k b
    v1s : Vec n (SVec k b)
    v1s = map (maps s1 f1) v0s

    or

    stencil s1 (map f1 v1) = map (maps s1 f1) (stencil s1 v1)


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

# BROL

### Reduction

- Pair up `applyt` with `zipt` and `maps` with `stencil`
- Reduce via SSA

## Staging

  However, this requires staging. For example, take the case of the rhs for the SOR.

  This is calculated from p,u,v,w using a reduction, and then the reduced value is subtracted from the original.

  So what we have to do is always recompute rather than store the intermediates in memory.


### Repeated application of stencils


s1 = [...]
s2 = [...]

v3 = map f2 (stencil s2 (map f1 (stencil s1 v1)))


stencil s2 (map f1 (stencil s1 v1)) = map (maps s2 f1) (stencil s2 (stencil s1 v1))



v3 = map (f2 . (maps s2 f1)) (stencil s2 (stencil s1 v1))

(Stencil (SVec 3 "s2") (Stencil (SVec 3 "s1") (Vec VI "v_0"))))

stencil ::  SVec n1 -> Vec a -> Vec (SVec n1 a)

stencil ::  SVec n1 -> Vec (SVec n2 a) -> Vec (SVec n1 (SVec n2 a))


(Stencil (SVec 3 "s2") (Stencil (SVec 3 "s1") (Vec VI "v_0"))))

(Stencil (SComb (SVec 3 "s2") (SVec 3 "s1")) (Vec VI "v_0"))))

the first stencil generates [v@off1, v@off2, v@off3, ...]

the second stencil generates [[], []]



    ! stencil
    integer, parameter, dimension(2*2) :: s1 = [...]
    real, dimension(2) :: exp_h_1_4    
    do s_idx = 0,1
      exp_h_1_4(s_idx) = v(j+s1(s_idx*2),k+s_i(s_idx*2+1))
    end do



    -----------


### Normalisation

- First we normalise so the LHS is either Vec or Scalar
- Then we remove all intermediate vectors VS VT by substitution, and also VO on the RHS

Given the AST in this form and following rules:

        map f_2 (map f_1 v) = map (f_2 . f_1) v    
        stencil s_1 (map f_1) = map (maps f_1) (stencil s_1)
        zipt (map f_1 v_1, map f_2 v_2) = map (applyt (f_1,f_2)) (zipt (v_1, v_2)) -- if all exprs in ZipT are maps        
        v = map id v -- if an expr in a ZipT tuple can't be rewritten to a map expression, turn it into map using this rule
        (elt i) . unzipt . (map f exprs) = map ((elt i) . f) exprs

         

### Theorem

Applying these rules on the normalised AST, starting from the leaf nodes, always terminates with an expression with a single map as first function.

### Proof

The proof is as follows: 

- The primitives in the language that return a `Vec` type are the vector type constructor and the functions

        map
        stencil
        zipt

- Apart from that, only the composite expression 

        (elt i) . unzipt

also returns a vector. Because of the earlier normalisation, `unzipt` will always be preceded by `(elt i)` so from the perspective of the rewrite rule this is a primitive.

Therefore, if any of these acts on a `map` expression, one of the rules will fire and result in an expression with a single map as the outer function.

- The `zipt` rule entails an extra condition that all elements of the tuple must be `map` expressions, so any elements that can't be rewritten into a `map` expressions using the other rules are turned into `map` expressions by applying a `map` over the identity function.

- If the an expression is of the form 

        map (expression without map) 
        
then none of the rules fires, so this is a fixedpoint for the rewrite system.


v :: Vec Int 500
acc1 :: Int = 0
acc3 :: Int = 0
-- I have {'Rhs'}{'NonMapArgs'}->{'Rhs'}{'MapArgs'}->{'Lhs'}
f0 :: acc1_T -> v_T -> acc1_T
f1 :: acc1_T -> SVec 3 v_T -> v_T
f2 :: acc3_T -> v_T -> acc3_T 
f4 :: SVec 3  v_T -> v_T
f3 :: acc3_T -> v_T -> v_T

s1=[-1,0,1]

v_0_s = stencil s1 v_0
acc1_1 = fold f0 acc1_0 v_0
v_1 = map (f1 acc1_1) v_0_s

s2 = [-1,0,1]),
v_1_s = stencil s2 v_1

v_2 = map f4 v_1_s
acc3_1 = fold f2 acc3_0 v_2
v_3 = map (f3 acc3_1) v_2

-- Decompose expressions
-- "acc1_1"
(Scalar VT "acc1_1",Fold (Function "f0" []) (Scalar VI "acc1_0") (Vec VI "v_0"))
-- "f_maps_acc3_1_0"
(Function "f_maps_acc3_1_0" [],MapS (SVec 3 "s2") (Function "f1" ["acc1_1"]))
(Function "f_comp_acc3_1_1" [],Comp (Function "f4" []) (Function "f_maps_acc3_1_0" []))
(Function "f_fcomp_acc3_1_2" [],FComp (Function "f2" []) (Function "f_comp_acc3_1_1" []))
(Vec VT "vec_acc3_1_3",Stencil (SComb (SVec 3 "s2") (SVec 3 "s1")) (Vec VI "v_0"))
(Scalar VT "acc3_1",Fold (Function "f_fcomp_acc3_1_2" []) (Scalar VI "acc3_0") (Vec VT "vec_acc3_1_3"))
-- "f_maps_v_3_0"
(Function "f_maps_v_3_0" [],MapS (SVec 3 "s2") (Function "f1" ["acc1_1"]))
(Function "f_comp_v_3_1" [],Comp (Function "f4" []) (Function "f_maps_v_3_0" []))
(Function "f_comp_v_3_2" [],Comp (Function "f3" ["acc3_1"]) (Function "f_comp_v_3_1" []))
(Vec VT "vec_v_3_3",Stencil (SComb (SVec 3 "s2") (SVec 3 "s1")) (Vec VI "v_0"))
(Vec VO "v_3",Map (Function "f_comp_v_3_2" []) (Vec VT "vec_v_3_3"))


!-- "acc1_1"
!(Scalar VT "acc1_1",Fold (Function "f0" []) (Scalar VI "acc1_0") (Vec VI "v_0"))

! extract all variables, easy
real :: acc1_0, acc1_1, v_0
! get dim, also easy, is a given
real, dimension(v_sz) v
! get inital accumulator. I wonder, do I have this somewhere?
acc1_0 = ... 
do idx = 1, v_sz
    v_0 = v(idx)
    call f0(acc1_0, v_0 acc1_1) ! Most practical might be that this is a wrapper around the original subroutine, to match the args
    acc1_0 = acc1_1 ! we know the accumulator
end do

f1 :: acc1_T -> SVec 3 v_T -> v_T
f1 acc1_T ::  SVec 3 v_T -> v_T
maps : (a -> b) -> SVec k a -> SVec k b
maps : (SVec 3 v_T -> v_T) 

f_maps_acc3_1_0 :: acc1_T -> SVec 3 (SVec 3 v_T)  -> SVec 3 v_T
!-- "f_maps_acc3_1_0" :: 
!(Function "f_maps_acc3_1_0" [],MapS (SVec 3 "s2") (Function "f1" ["acc1_1"]))

subroutine f_maps_acc3_1_0(acc1_1, sv_in, sv_out)
! sv_in must be an array of arrays here!
    do i=1,3 ! from the SVec size
        call f1(acc1_1,sv_in(i),sv_out(i))
    end do
end subroutine f_maps_acc3_1_0    


acc1_T -> SVec 3 (SVec 3 v_T)  -> SVec 3 v_T
f4 :: SVec 3  v_T -> v_T
f_comp_acc3_1_1 :: acc1_T -> SVec 3 (SVec 3 v_T)  -> v_T
!(Function "f_comp_acc3_1_1" [],Comp (Function "f4" []) (Function "f_maps_acc3_1_0" []))

subroutine f_comp_acc3_1_1(acc1_1, acc3_0, sv_in, v_out)
! sv_in must be an array of arrays here!
    call f_maps_acc3_1_0(acc1_1, sv_in, sv_tmp)
    call f4(sv_tmp,v_out)
end subroutine f_comp_acc3_1_1()

f_comp_acc3_1_1 :: acc1_T -> SVec 3 (SVec 3 v_T)  -> v_T
f2 :: acc3_T -> v_T -> acc3_T 
f_fcomp_acc3_1_2 :: acc3_T -> (acc1_T -> SVec 3 (SVec 3 v_T)) -> acc3_T 
!(Function "f_fcomp_acc3_1_2" [],FComp (Function "f2" []) (Function "f_comp_acc3_1_1" []))

subroutine f_fcomp_acc3_1_2(acc1_1, acc3_in, sv_in, acc3_out)
    call f_comp_acc3_1_1(acc1_1, sv_in, v_tmp)
    call f2(acc3_in,v_tmp,acc3_out)
end subroutine f_comp_acc3_1_2

(Vec VT "vec_acc3_1_3",Stencil (SComb (SVec 3 "s2") (SVec 3 "s1")) (Vec VI "v_0"))

integer, dimension(3,3) :: vec_acc3_1_3 

(Scalar VT "acc3_1",Fold (Function "f_fcomp_acc3_1_2" []) (Scalar VI "acc3_0") (Vec VT "vec_acc3_1_3"))




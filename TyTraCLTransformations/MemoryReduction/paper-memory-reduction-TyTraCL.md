# Reducing memory utilisation of stencil-based legacy scientific code through automatic program transformation


## Background

This work is part of our efforts to automatically transform and compile legacy scientific code (in particular weather simulations and similar) in FORTAN 77 to heterogeneous platforms. The focus of this paper is on a novel program transformation to reduce the memory utilisation of stencil-based scientific code.
For scientific computations, memory requirements are often the bottleneck, both in terms of the storage and of performance. Specifically the performance of stencil codes is often limited by memory bandwidth. Reducing memory utilisation allows simulations of larger domains or with higher resolution. 
Our main observation from real-life scientific code is that many of the arrays used in typical simulation code are intermediate arrays, especially in the case of stencil computations. As anexample, consider the Large Eddy Simulator for Urban Flows \cite{}

This is a hurricane wind similator, so it simulates pressure and wind speed. Its actual inputs are the wind velocity in 3 dimensions (_u,v,w_) and the pressure (_p_), i.e. four arrays for every domain. However, the code but we actually uses 15 arrays:

    p
    u,v,w
    usum,vsum,wsum
    f,g,h
    fold,gold,hold
    sm
    rhs

In this particular case, 11 arrays are intermediate and can actually be replaced by scalar computations. If we could achieve this, the simulation could run on a 4 times larger domain with the same memory utilisation. In this paper we present a novel approach to aggressively reduce memory utilisation of stencil-based legacy scientific code through automatic program transformation. 

## Related Work
- The idea is to find some similar things but be able to say that nobody has done what we have done

## Relationship to our existing work and Contribution of this work

We have developed a compilation chain which can automatically transform legacy scientific code into GPU- and FPGA- accelerated variants \cite{}. In this work we make use of this compilation chain to transform the original code into a form that can be analysed for memory reduction. In particular, the code is refactored to remove global variables (`COMMON` in Fortran) and the loops are analysed in terms of _map_ and _fold_ higher-order functions. We have shown how to transform the code into map/fold based code for GPU acceleration  \cite{}. 
Furthermore, motivated by the goal of accelerating code on FPGAs, we have developed a functional dataflow language, TyTraCL \cite{} and a source-to-source compiler which can transform the map/fold based code into this language. 

The actual memory reduction transformation which is the focus of this paper starts from the program in the TyTraCL language.

The contributions of the current work are 
- Additional analysis to detect stencils
- An algorithm to scalarise the kernels
- An algorithm to identify intermediate arrays
- A series of program transformations to remove intermediate arrays

The key idea underpinning the current work is that we can trade memory storage for computation by recomputing values rather than reading them from memory. In particular our goal is to access only the actual input arrays and compute all intermediate values from these accesses. This reduces the memory requirements at the expense of additional computation. 

XXX Experiments will have to show if this is slower and by how much XXX


### From the original Fortan code to auto-parallelised code

The typical pattern of stencil code is a sequential application of nested loops. Slightly simplified, the auto-parallelising compiler analyses the loop dependencies and refactors the code into separate subroutines for every loop nest, called _kernels_. At this stage, these subroutines still perform indexed array accesses, i.e. they are not yet pure functions a -> b or a -> b -> a, but we already have the guarantee that they can be transformed into such pure functions. This is sufficient for e.g. parallelisation on CPU or GPU using OpenCL. 

## The TyTraCL language

Before we can discuss the contributions of the current work in detail, we first must introduce the TyTraCL language. Although TyTraCL is in practice an intermediate representation, the language has a concrete syntax to facilitate reasoning and proofs.

### TyTraCL concrete syntax

The TyTraCL language is syntactically a subset of Haskell, with the addition of two types of vectors of fixed size, similar to the vector type in Idris. Purely for convenience we also assume that `zipt`, `unzipt`, `applyt` and `elt` work on tuples of arbitrary size, as opposed to Haskell where an instance is needed for every tuple size.

#### Types

    v_i :: Vec n a
    s_i :: SVec k Int
    f_i :: a -> b

TyTraCL is a composition language, its aim is to express dataflow graphs. The actual input values and computations do not  need to be defined, so instances of the above types are ony declared.

#### Primitives 

The language has a small number of primitives, shown in Listing XXX.

    -- As in Haskell but on Vec rather than []
    map :: (a -> b) -> Vec n a -> Vec n b

    -- Haskell's foldl but on Vec rather than []
    fold :: (a -> b -> a) -> a -> Vec n b -> a

    -- Ordinary map but only works on SVec
    maps :: (a -> b) -> SVec k a -> SVec k b

    -- Every element of the vector is replaced by the stencil defined by the first argument
    stencil :: SVec k Int -> Vec n a -> Vec n (SVec k a)

    -- Like Haskell's zip/unzip but takes a tuple as argument and works on Vec
    zipt :: Tup k (...,Vec n a_i,...)  -> Vec n $ Tup k (...,a_i,...)
    unzipt :: Vec n Tup k (...,a_i,...) -> Tup k (...,Vec n a_i,...)

    -- Apply a tuple of functions to a tuple of values
    applyt :: Tup k (...,a_i -> b_i,...) Tup k (...,a_i,...) -> Tup k (...,b_i,...)
    applyt (...,f_i,...) (...,e_i,...) =\(...,e_i,...) -> (...,f_i e_i,...)

    -- Generalisation of Haskell's fst/snd
    elt :: i:: Int -> (...,a_i,...) -> a_i
    elt i (...,e_i,...) = e_i

    -- Stencils can be combined using scomb
    scomb :: (SVec k_1 Int) -> (SVec k_2 Int) -> SVec (k_1*k_2) Int
    stencil s2 (stencil s1 v1) = stencil (scomb s2 s1) v1

### TyTraCL Abstract Syntax

In practice, the TyTraCL program transformations are implemented in Haskell. The abstract syntax for the TyTraCL language, expressed as a Haskell type, is shown in Listing XXX

        type Name = String
        data VE = VI  | VO  | VS  | VT | VU
            deriving (Show, Typeable, Data, Eq)            
        type TyTraCLAST = [(Expr,Expr)]                      

        data Expr =
                -- Left-hand side:
                            Scalar Name
                            | Const Int 
                            | Tuple [Expr] 
                            | Vec VE Name

                -- Right-hand side:
                            | SVec Int Name -- Stencil vector
                            | ZipT [Expr] -- generalised zip
                            | UnzipT Expr -- generalised unzip
                            | Elt Int Expr -- generalised tuple access
                            | Map Expr Expr
                            | Fold Expr Expr Expr
                            | Stencil Expr Expr
                            | Function Name [Name] -- 2nd arg is list of non-map/fold args
                            | Id
                            | ApplyT [Expr] 
                            | MapS Expr Expr
                            | Comp Expr Expr -- funtion composition
                            | SComb Expr Expr
                                deriving (Show, Typeable, Data, Eq)

The property `VE` encodes if a vector is an input `VI`, output `VO`, a vector of stencil vectors `VS`, or any other temporary `VT`. Initially this value is set to `VU`, "Unknown".

### TyTraCL semantics

TyTraCL can be viewed as a subset of Haskell with strict execution. This means that every `map` call can be considered to return a new list, and therefore memory for this list will need to allocated. In this view, a `stencil` of _k_ points will require _k_ times the memory allocation of the original vector.

However, it is also possible to view TyTraCl as a streaming language where a `map` call consumes the elements of the input vector as a stream and the result is immediately passed on to the next call. In this view, the `stencil` call creates a new stream of stencils around every given point in the original stream. To do so it buffers the stream until all elements of the stencil are in the buffer. A crucial observation here is that there is no need for additional buffering if we create a stencil from an input vector, as they are stored in the main memory. 

It is clear that implementation of the stream-based view will require considerably less memory than the strict vector-based view. 

## Preparatory transformations 

In this section we describe the Fortran program transformations which transform the code as generated by our auto-parallelising compiler into the TyTraCL code that will serve as our starting point.

To transform the kernels into the final scalar functions required by TyTraCL, we apply three additional transformations: stencil detection, scalarisation and argument grouping.

### Stencil detection

Array accesses are divided into read and write access.  Stencils are defined as patterns of read accesses with fixed offsets around the loop iterators. An array access pattern is a stencil if:
	- There is more than one read access to the array
	- At least one of these accesses has a non-zero offset
	- All points in the array are processed in order, i.e. the loop iterators loop over a contiguous range
Furthermore, there can only be a single write access to any array in the loop nest.

### Scalarisation

Scalarisation refers to transforming the kernel functions into pure functions that can be mapped or folded. The algorithm is surprisingly simple:

- Transliterate every array access into a scalar variable name as follows

        scalar_var_str = filter (/= ' ') (
            map \c -> case c of 
                '(' -> '_'
                ',' -> '_'
                '+' -> p
                '-' -> m
                '*' -> t
                ')' -> ' '
            ) array_access_string

- Replace the array arguments of the kernel subroutine with the scalarised names. In the case of a stencil, the array argument is replaced by the sequence of scalar variables in the stencil, ordered by the numeric offset of the stencil access.

### Argument grouping  

A Fortran subroutine takesn and returns values via its argurment list. To obtain the final TyTraCL function signature, we must group the scalarised arguments to get the required type for mappable and foldable functions. In the most general case, a mappable kernel subroutine can take vector arguments to mapped and any other read-only scalar arguments, and return vector arguments;
 a foldable kernel subroutine can take vector arguments to folded, accumulator arguments which ar typically readabe and writeable, and any other read-only scalar arguments. Our previous analysis has already resolved if an argument is used for input, output or both, and of course we know which arguments originally were arrays and which of these have stencil accesses. With this information, it is straightforward to transform the scalarised Fortan kernel signature into the correct signature for the TyTraCL by first grouping the stencil arguments into stencil vectors and then grouping the arguments into tuples.

XXX Give an example here XXX

### Key transformation of stencil-based nested loops

The above analysis allows to extract the stencil pattern and transform any stencil computation into a combination of a `stencil` call and a `map` or `fold` call. For example, 

...

becomes

        v_s = stencil s v
        v_o = map f v_s

## Intermediate vector removal, Part I: the easy part

The purpose of the program transformations that follow is to eliminate intermediate vectors. These may occur because of the need for stencils; or they might be present in the original code.

- If an intermediate vector is present in the original code, we have something like

        v1 = map f1 v0
        v2 = map f2 v1

    with its definition (beta reduction).

        v2 = map f2 $ map f1 v0

- If there is a stencil, it can either occur between a `map` and a `map` or between a `map` and a `fold` but nowhere else, because stencils are only introduced before the operation that requires them, and that is always a `map` or a `fold`. And the preceding computation can only be a map. Note also that a stencil call only ever operates on a vector of scalars or stencils, not on a vector of tuples
E.g.

        v1 = map f1 v0
        v1_s = stencil s1 v1
        v2 = map f2 v1_s

    or

        v1 = map f1 v0
        v1_s = stencil s1 v1
        acc2 = fold f2 acc0 v1_s

    Now, after the second pass this will become

        acc2 = fold f2 acc0 (stencil s1 (map f1 v0))

    This will then be rewritten into     

        acc2 = fold f2 acc0 (map (maps f1) (stencil s1 v0))

    Thus we can always remove the intermediate vectors of stencils.


With the program expressed in TyTraCL we perform first a normalisation transformation and then the actual intermediate vector removal. The intermediate vector identification is trivial: we know the input and output arrays as well as any vector resulting from a stencil application. Any remaining vector is an intermediate. 

### Normalisation

First we normalise so the LHS of any element in the TyTraCLAST list is either Vec or Scalar. We do this by replacing all LHS _Tuple_ occurrences with multiple expressions that apply  _Elt_ to the RHS. As a result, the LHS will be purely _Vec_.

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


### Intermediate vector removal algorithm

After this normalisation we remove all vectors _Vec VT_ and _Vec VS_, and also _Vec VO_ on the RHS, by recursive substitution, starting from the last expression in the list. 


## Intermediate vector removal, Part II: the hard part

Although it may seem as if the job is done, as all intermediate vectors have been removed, this is actually not the case: the removal so far is purely in terms of the occurrences in the AST. Were we to run the program, it would require memory for implicit temporary vectors. This is because an intermediate stencils will require additional memory. 

We have developed a system of rewrite rules that transforms the program in such a way that there is only a single map operation and that all stencils operate on input vectors only. This system of rewrite rules is the key contribution of this paper. 

### Rewrite rules theorem

Given the AST in normalised form and following rewrite rules:

        map f_2 (map f_1 v) = map (f_2 . f_1) v    
        stencil s_1 (map f_1) = map (maps f_1) (stencil s_1)
        zipt (map f_1 v_1, map f_2 v_2) = map (applyt (f_1,f_2)) (zipt (v_1, v_2)) -- if all exprs in ZipT are maps
        v = map id v -- if an expr in a ZipT tuple can't be rewritten to a map expression, turn it into map using this rule
        (elt i) . unzipt . (map f v) = map ((elt i) . f) v

Applying the rewrite rules on the normalised AST, starting from the leaf nodes, always terminates with an expression which contains only a single map, as the outer function.

### Lemmas

First we prove that the rewrite rules themselves are correct. The first rule is well-known; the fourth rule is trivial. 

#### Proof for the Stencil-Map rewrite rule

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

#### Proof for the ZipT-Map rewrite rule

- Given that all exprs in the tuple are map expressions
- Express the vectors in terms of their elements:

        v_i = [e_i_0, ...]
        (zipt (v_1, v_2) = [(e_1_0,e_2_0),...]

- Substitute in the LHS of the rule:

        zipt (map f_1 v_1, map f_2 v_2) = zipt ([f_1 e_1_0, f_1 e_1_1, ...], [f_2 e_2_0, f_2 e_2_1, ...])

- Apply the `map` and `zipt` definitions
        = [(f_1 e_1_0,f_2 e_2_0),(f_1 e_1_1,f_2 e_2_1),...]
- Apply the `apply` definition        
        = [
            applyt (f1,f_2) (e_1_0,e_2_0),applyt (f1,f_2) (e_1_1,e_2_1),...
        ]
- Apply the `map` definition
        = map (applyt (f1,f_2)) [(e_1_0,e_2_0),(e_1_1,e_2_1),...]
- Apply the `zipt` definition
        = map (applyt (f1,f_2)) (zipt (v_1, v_2))

#### Proof for the Elt-UnzipT-Map rewrite rule

- Given 

        f :: a -> (a_1,a_2)
        
- On the LHS, writing out with elements and applying the definition of `map`:

    map f v = [f e_0, f e_1, ...]
    = [(e_1_0, e_2_0),(e_1_1, e_2_1),...]

- Applying the definition of `unzipt`

    unzipt (map f v)
    = unzipt [(e_1_0, e_2_0),(e_1_1, e_2_1),...]
    = ([e_1_0, e_1_1,...],[e_2_0,e_2-1,...])

- Applying `elt i`, e.g. for i = 0

    (elt i) (unzipt (map f v))
    = [e_1_0, e_1_1,...]
    = v_1

- On the RHS, write the vector `v` in terms of its elements:

    v = [e_0, e_1, ... e_j, ...]

- Apply `f`:

    f e_j = (e_1_j, e_2_j)

- Apply `elt i`, e.g. for i = 0

    elt 0 (f e_l) 
    = elt 0 (e_1_j, e_2_j)
    = e_1_j

- Do this for all _j_ by applying `map`
     = [e_1_0, e_1_1, ..., e_1_j, ...]
     = v_1
   


### Proof of the Rewrite Rule Theorem

The proof is as follows: 

- The primitives in the language that return a `Vec` type are the vector type constructor and the functions

        map
        stencil
        zipt

- Apart from that, only the expression 

        (elt i) . unzipt

also returns a vector. Because of the earlier normalisation, `unzipt` will always be preceded by `(elt i)` so from the perspective of the rewrite rule this is a primitive.

Therefore, if any of these acts on a `map` expression, one of the rules will fire and result in an expression with a single map as the outer function.

- The `zipt` rule entails an extra condition that all elements of the tuple must be `map` expressions, so any elements that can't be rewritten into a `map` expressions using the other rules are turned into `map` expressions by applying a `map` over the identity function.

- If the an expression is of the form 

        map (expression without map) 
        
then none of the rules fires, so this is a fixed point for the rewrite system.

### Corrolary regarding the stencils

We note that 'all stencils operate on input vectors only' follows from the fact that stencils only operate on vectors; vectors can result from any of the expressions in the LHS or RHS of the above rules. But given that the system terminates, any LHS expression will have been rewritten into an RHS one, and there will ony be a single map application in this expression. A stencil will therefore operate on an expression consisting only of input vectors, `zipt` and `stencil`. A stencil operating on a `stencil` expression can per definition be rewritten as a single stencil using of `scomb`:

        stencil s2 (stencil s1 v1) = stencil (scomb s2 s1) v1

A stencil operating on a `zipt` expression can be rewritten as a `zipt` operating on a tuple of stencil expressions:

        stencil s2 (zipt (v1,v2)) = zipt (stencil s2 v1,stencil s2 v2)

Proof:        

        stencil s1 (zipt (stencil s2 v1,stencil s2 v2))
        = stencil s1 $ stencil s2 (zipt (v1,v2))
        = stencil (scomb s1 s2) (zipt (v1,v2))
        = zipt (stencil (scomb s1 s2) v1,stencil (scomb s1 s2) v2)



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


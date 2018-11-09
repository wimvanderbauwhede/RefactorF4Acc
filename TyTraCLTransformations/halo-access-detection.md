Halo access detection
---------------------

Array accesses are stored in

      $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw} = {
        'Exprs' => { $expr_str_1 => 1,...},
        'Accesses' => { '0:1' => [ {'j' => [1,0]},{'k' => [1,1]} ],
                   '0:0' => [{'j' => [1,0]},{'?' => [0,500]}]},                        
        'Iterators' => ['i','j']
      };

and per-line accesses are returned separately in $accesses->{'Arrays'}{$array_var}{$rw}

Array dimensions are stored in

      $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{'Dims'} = [[0,501],[1,500],...]

Loop ranges are stored in

      $state->{'Subroutines'}{ $f }{$block_id}{'LoopIters'}{$loop_iter} = {
        'Range' => [$loop_start,$loop_stop]
      };

Halo info is stored in

      $stref->{'Subroutines'}{ $f }{'Vars'}{$array_var}{'Halos'} = [[1,1],[0,1]]

So given an access e.g. v(j,k+1) and dimensions [[0,501],[0,501]] and halos [[1,1],[1,1]] and loop range [1,500].

Then j is never in the halo:

        my $expr_rec = $accesses->{'Arrays'}{$array_var}{$rw}{'Accesses'}{$key};
        my $j_expr_rec = $expr_rec->[0];
        my ($loop_iter, $offset_t) = each %{$j_expr_rec};
        my $offset=$offset_t->[1];
        # $iter."+". $offset
        my $j_min = $state->{'Subroutines'}{ $f }{$block_id}{'LoopIters'}{$loop_iter}{'Range'}->[0];
        my $j_expr_min = $j_min+$offset;
        my $array_j_lower_bound = $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{'Dims'}[0][0];
        my $array_j_lower_halo = $stref->{'Subroutines'}{ $f }{'Vars'}{$array_var}{'Halos'}[0][0];
        $j_expr_min < $array_j_lower_bound + $array_j_lower_halo
        # 1 < 0-1 is false
        $j_expr_max > $array_j_upper_bound - $array_j_upper_halo
        # 1 > 501-1 is false
        # but k+1 is in the right halo:
        $k_expr_max > $array_k_upper_bound - $array_k_upper_halo
        # 500+1 > 501-1 is true

Given an access e.g. v(j,501) and dimensions [[0,501],[0,501]] and halos [[1,1],[1,1]] and loop range [1,500].

Then j is never in the halo:

        1 < 1-1 is false

but 501 is in the right halo:

        501 > 501-1 is true

So I should be able to identify halos as left, right, top, bottom, top-left etc.

What matters of course is *updates* to the halo region. Read accesses are only an issue if the location can't be read, e.g. circular boundary conditions in MPI or on the GPU with chunking.

        $accesses->{'Arrays'}{$array_var}{$rw}{'HaloAccesses'}{$loop_iter}={      
            'Bound' =>$b, # Lower = 0, Upper = 1
            # The test is:
            # Lower: $loop_bound + $offset < $array_bound + $array_halo
            # Upper: $loop_bound + $offset > $array_bound - $array_halo			        	      
            'Test' => [$loop_bound, $offset, $array_bound, $array_halo]
        }

So the main question is, now that I have identified them, what do I do? Let's first consider the GPU case, and first first the non-chunking case.

Let's say I want to remove any halo access from the GPU code and put it on the host. There are two separate issues:

1. Dependencies: any calc depending on the halo calc needs to be moved as well.
2. But what we should do first is to separate the halo from the non-halo accesses. I have written about this before, we can either modify the loop bounds or put guards (or likely do both).

So, let's say I have a range of 502*502, I will need 'Read' halo accesses over this whole range. But I could do the halo update (Write) part on the host.
So I should detect which line is a halo update. With the current analysis, we know which line has a halo Write.
So if we have an LHS which does not access the halo on Write and an RHS which does access the halo on Read, that is fine.
Any line where the LHS accesses the halo on Write needs to be factored out.

Then we need to check
  - if a downstream line is using these updates
    So for any line downstream, get vars and see if the LHS var is in it.
  - if the line contains variables defined upstream, including arguments.


For all lines with Write accesses to the halo, i.e. in $lhs_accesses
- find all dependencies on that lines
- look at any assignment line before that, and if the LHS is a dep, add it to a list.
- Somewhere in the end we must then merge all these lists so we'll need to keep them in order
- So I think tagging the lines is better
- And do this for downstream as well. So I guess I go through all lines, which means I need the LineID in the accesses as well


How does the dependency work?

- say I access u(i,j) = v(i,j_rel)*a
then u depends on i,j,j_rel, a and on v, but in each case on the assignments





## Dealing with halos

As we have

    v_i :: Vec n a

we can define *a* to be a type that contains the halo information:

    data Halo1D b = LIHalo b | RIHalo b |
                    LOHalo b | ROHalo b |
                    Core b   

or for an original 2-D domain

    data IHalo2D b = NIHalo b | EIHalo b | SIHalo b | WIHalo b |  
                     NEIHalo b | SEIHalo b | SWIHalo b | NWIHalo b |
                     NOHalo b | EOHalo b | SOHalo b | WOHalo b |  
                     NEOHalo b | SEOHalo b | SWOHalo b | NWOHalo b |                    
                     Core b   

and for a 3-D domain, where we'd have 6 planes, 12 ribs and 8 corners

    data IHalo3D b = NIHalo b | EIHalo b | SIHalo b | WIHalo b |  TIHalo b | BIHalo b | -- planes
                     TNIHalo b | TEIHalo b | TSIHalo b | TWIHalo b | -- top ribs
                     BNIHalo b | BEIHalo b | BSIHalo b | BWIHalo b | -- bottom ribs
                     NEIHalo b | SEIHalo b | SWIHalo b | NWIHalo b | -- vertical ribs
                     TNEIHalo b | TSEIHalo b | TSWIHalo b | TNWIHalo b | -- top corners
                     BNEIHalo b | BSEIHalo b | BSWIHalo b | BNWIHalo b | -- bottom corners
                     NOHalo b | EOHalo b | SOHalo b | WOHalo b |  TOHalo b | BOHalo b | -- planes
                     TNOHalo b | TEOHalo b | TSOHalo b | TWOHalo b | -- top ribs
                     BNOHalo b | BEOHalo b | BSOHalo b | BWOHalo b | -- bottom ribs
                     NEOHalo b | SEOHalo b | SWOHalo b | NWOHalo b | -- vertical ribs
                     TNEOHalo b | TSEOHalo b | TSWOHalo b | TNWOHalo b | -- top corners
                     BNEOHalo b | BSEOHalo b | BSWOHalo b | BNWOHalo b | -- bottom corners                    
                     Core b             

and thus we can write e.g.                    

    v_i :: Vec n (Halo3D a)

The opaque functions change also to    

    f_i :: Halo1D a -> Halo1D b

and inside the function we can pattern match on the type to decide what to do with the boundary points.
Note that the type tells us which point is involved in a boundary calculation when updated, so these are the "inner halos" (`IHalo`), i.e. for a 1-D case with n+2 points where the outer halos are 0 and n+1, the points with type LIHalo and RIHalo will be 1 and n, whereas LOHalo and ROHalo will be 0 and n+1.

The question is if instead I could do something Like

    data Halo b = Halo (idx : Int) b


This would effectively mean that all points would have a unique type which carries the index. Within the context of TyTraCL this would solve all our problems.
I'm not sure if this is really possible because the type information would not be known at compile time. Of course in the worst case I can always to something simpler and less elegant:

    data IdxVal a = (a,Int) -- or is it newtype?

    elt :: IdxVal Real
    elt = (elt_val, elt_idx)

    toIdxVal :: (a,Int) -> IdxVal a

    hv = mapToIdxVal v

    mapToIdxVal :: Vec n a -> Vec n IdxVal a
    mapToIdxVal v = let
        idxs = 0 .. (length v - 1)
        tups = zip v idxs
      in
        map toIdxVal tups


What to do for a circular boundary? Say,

    p(1,j,k) = p(ip+1,j,k)

The points `(1,j,k)` will be identified as the inner front plane, i.e. SIHalo. However, although in principle we can use stencils, in practice we can't as it would take too much memory. So the actual solution will have to be that we extract all planes with circular conditions from the stream. This requires a new TytraCL primitive which I will call `extract`

      extract :: SVec k Int -> Vec n a -> Vec k a
      -- possible Haskell implementation
      extract patt v = map (\idx -> v !! idx) patt

      -- suppose we want the south (i.e. incoming) plane with 2 halo points:
      south_plane = extract [ i*jm*km+j*km+k | i <- [-1 .. 0],  j <- [0 .. jm-1], k <- [0..km-1] ] v

We would normally use one of the following functions:

    sub F3D2C { (
         my $i_rng, my $j_rng, # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, my $k_lb, # lower bounds
        my $ix, my $jx, my $kx
        ) =@_;
        return ($i_rng*$j_rng*($kx-$k_lb)+$i_rng*($jx-$j_lb)+$ix-$i_lb);
    }      

Or a TyTraCL/Haskell variant, I use a tuple of tuples for readability

    f3D2c :: ((Int,Int),(Int,Int,Int),(Int,Int,Int)) -> Int
    f3D2c (
           (i_rng, j_rng), -- ranges, i.e. (hb-lb)+1
           (i_lb, j_lb, k_lb), -- lower bounds
           (ix, jx, kx) -- indices
          ) = i_rng*j_rng*(kx-k_lb)+i_rng*(jx-j_lb)+ix-i_lb


So the actual generated pattern would be

      south_plane = extract [ f3D2c ((2,jm),(-1,0,0),(i,j,k)) | i <- [-1 .. 0],  j <- [0 .. jm-1], k <- [0..km-1] ] v

In TyTraCL we would actually only have

    patt :: SVec (2*jm*km) Int     
    south_plane = extract patt v

So now the opaque function can take the extracted vector as a non-map argument.

    v' = map (f_i south_plane) v

If the index information is accessible inside the opaque function, this can work. What this means in practice is that the TyTraIR will use the index information in the stream (which I guess is globally accessible) to decide when to index into the plane array.


## Stencil analysis

Stencils with constants:

e.g.
    v(i,0)=v(i,1)
    v(n+1,j)=v(n,j)

This codes as

    ((1,0),(0,0)) = ((1,0),(0,1))
    ((0,n+1),(1,0))=((0,n),(1,0))

Now we can turn this into a proper stencil simply by subtracting the LHS from the RHS:    

    ((1,0),(0,0)) = ((1-1,0-0),(0-0,1-0))  = ((0,0),(0,1))
    ((0,n+1),(1,0))=((0-0,n-(n+1)),(1-1,0-0)) = ((0,-1),(0,0))

Observe that the first element of each tuple is zero, this is how the actual indices are removed. So the 2-D stencil is in this case ((0,1),(-1,0)).

Another example:

    v(i,0)=v(i,n)
    v(i,n+1)=v(i,1)

=>    

    ((1,0),(0,0))=((1,0),(0,n))
    (((1,0),(0,n+1))=((1,0),(0,1))

=>

    ((0,0),(0,n))
    ((0,0),(0,-n))

=>

    ((0,n),(0,-n))

Yet another example, no constants:

    v(i,j) = v(i+1,j)+v(i-1,j)

=>

    ((1,0),(1,0)) = ((1,1),(1,0)), ((1,-1),(1,0))

=>    ((1-1,1-0),(1-1,0-0)), ((1-1,-1-0),(1-1,0-0))
=>    ((0,1),(0,0)), ((0,-1),(0,0))
=>    ((1,0),(-1,0))

So this mechanism is generic for assignments, it does not matter if the array accessed in the RHS is different from the array assigned to on the LHS.
It provides a way to turn all accesses from assignments into stencils.

For example

    u(i,0) = v(i,n) + w(i,n+1)   
=>
    ((1,0),(0,0)) = v:((1,0),(0,n)),w:((1,0),(0,n+1))
=>
    v:((1-1,0-0),(0-0,n-0)),w:((1-1,0-0),(0-0,n+1-0))
    v:((0,0),(0,n)),w:((0,0),(0,n+1))
=> stencil:
    v:(0,n), w:(0,n+1)

Arguably this is not a true stencil, all it does is generate an offset on the arrays v and w. Now consider

    u1(i,0) = v(i,n)   
    u2(i,0) = v(i,n+1)
    u3(i,0) = w(i,n+1)

The result is two offsets on v and one on w. This is OK. So we can just go through all assignments and combine them.


Considering the compiler, the catch is that I did not tie the LHS to the RHS. What I need is for every function $f, a classification of the accesses: Assignments and Others
Then in Assignments we have Write =>, Read => [ ..., ... ]; in Others we have Write => ..., Read => ... .
We already have

    $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'}{ join(':', @ast_vals0) } = $iter_val_pairs;

Each iter val pair is of the form (String,(Int,Int)), the string is the iterator variable, the first elt in the tuple is the multiplier, the second the offset.

	{$iters[$idx] => [$mult_val,$offset_val]};

For example, and typical access record entry for a 2-D array looks like this:

	 '0:-1' => [
	    {
	      'j' => [
	        1,
	        0
	      ]
	    },
	    {
	      'k' => [
	        1,
	        -1
	      ]
	    }
	  ],

which is equivalent to

    ((1,0),(1,-1))

so let's say we have a record with 'j' => ..., '?' => ... on one side and '?' => ..., 'k' => ...

So we say: LHS j has no j on RHS, there is one ? so that must be the match
LHS ? means we should look at RHS. k has no match, there is only one ? so it must be that one

All this is very unsatisfactory. What do we do for

        v(i,j) = w(0,1) ?

It must be positional! So I added the index: ?0, ?1, j:0,k:1 etc

    ((1,0),(1,0)) = ((0,0),(0,1))
    ((1,0),(1,0)) = ((0-1,0-0),(0-1,1-0))
    ((-1,0),(-1,1)) => we can still do (0,1)

    w(0,1) = v(i,j) => ((1-0),(0-0)),((1-0),(0-1)) => ((1,0),(1,-1)) => I'd say this is not OK

    w(0,k) = v(j,1) => ((1,0),(0,1))-((0,0),(1,0)) => ((1,0),(-1,1)) so that would be what? This can't work as a stencil but it _can_ work with the `extract` approach!

=> So if the diff of mults is positive it's no go!
So, for all entries in ArrayAssignments

- Get the information from the LHS, i.e. change the above into [[$m0,$o0],[$m1,$o1]]
- For the RHS, first make a list of all arrays being accessed, i.e. keys %{$entry->[1]{'Arrays'}}

- Do the maths
- merge across all ArrayAssignments
- The result is a list of stencils, one for each read array variable.



For boundaries, we have to decide what is more desirable, a stencil from a streaming buffer or a static buffer. If it is the latter, every access where one of the indices is a constant should become a static buffer.

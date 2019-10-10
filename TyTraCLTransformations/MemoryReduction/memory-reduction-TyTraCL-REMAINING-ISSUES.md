# REMAINING ISSUES : Memory Reduction for Scientific Computing on GPUs

## Integration of the scalarised code

To generate the scalarised code:

      translate_kernels_to_TyTraLlvmIR_via_API.pl -v -s

This will create the list of new args in $

      info->{'Signature'}{'Args'}{'List'}=$new_args;

and Set has the original names and for convenience the stencil index

      %orig_arg_names = (

      $new_arg_name => [$orig_arg_name, $base_1_stencil_index],

        )

An index of 0 means it's not a stencil.  

      $info->{'Signature'}{'Args'}{'Set'} = { map {$_=>$orig_arg_names{$_}  } @{$new_args} };

An alternative would be to put this info in

      $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}

The new decls have an extra field `ArrayIndexExpr` but I don't think that's enough.
I added `$new_decl->{'StencilIndex'}`, again base 1.

So now we can access the scalarised signature via `DeclaredOrigArgs`, but it means we need
to pass this info on to the MemoryReduction pass using the API.

I put this info in `$stref->{'ScalarisedArgs'}`. Now, how to use it? We need the link between the TyTraCL names and the original names, 
and from there to the scalarised names. Using Name and StencilIndex from the var rec. 

So I think I need a table 

            origNamesList = [($f, [($orig_name, $tytracl_name)])]
            $f => { $orig_name => $tytracl_name}

and a list $f => [($orig_name, $stencil_index)] with the order for the scalarised sig.

            scalarisedArgsList = [($f , [($orig_name, $stencil_index)])]

Then for every f we map (orig_name, stencil_index) -> ((origNames ! f) ! orig_name)++(if stencil_index==0 then "" else "("++(show stencil_index++")")))




## OpenCLC: Passing array slices and returning scalars into array elements

- We use array slices and also return scalar values into array elements, see

      {test_return_to_array_elt,test_pass_array_slice},{f90,c}

for the conversions, need to add this to

      RefactorF4Acc::Translation::OpenCLC

## The stencil currently is defined for non-constant accesses only, I could generalise this using the algorithm in

      /Users/wim/Desktop/FortranRefactoring/2018-10-30-stencil-algo.txt

## How to deal with iteration?

      (read_only_vs, iter_vs) = map f v_ins
      iter_vs' = iterate test calc_iter read_only_vs iter_vs
      v_out = map f (read_only_vs, iter_vs')

It seems clear that the `iterate`  call must become one or more stages; there is no reason to do this on the device, so we can probably keep the original code.

Essentially, for the SOR we have

      p_s = stencil s1 p
      p = map sor (zipt (p_s,rhs))

and it's a single map so no particular actions

## LES in TyTraCL?

In `/Users/wim/SoC_Research/TyTra/tytra/Type-Transformations-FPGA/TyTraHLL` we have

`/Users/wim/SoC_Research/TyTra/tytra/Type-Transformations-FPGA/TyTraHLL/TytraHLL-LES.hs`

These are Haskell sketches. What I need is a proper TyTraCL version based on the GPU version.
If I would ignore the boundaries, it might be possible ...

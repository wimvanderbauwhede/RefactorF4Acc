# There and Back Again, or what I did on my holidays 

## My "holidays"

* A two-week research retreat in Greece
* To do the research for this talk
    - theory
    - development
    - write-up

[ show some pictures:
- sunrise
- the sea
- maybe the garden if a good one
]

# Memory reduction through program transformations for automatically accelerated legay scientific code

## What?

[goal, type of code, target platform]

## Why?

Fortran popularity graph
Simulations need a lot of memory
GPUs don't have a lot of memory
Code is often written in a very memory-inefficient way but manual rewrite is too hard, in particular for stencil code.

## How?

Whole-program analysis and 
Program transformations
Source-to-source compilation

### Prelude or Prologue

Starting from FORTRAN 77
- Modernize/normalize (Fortran 95)
- Make accelerator-ready (remove globals)
- Auto-parallelise (loop dependency analysis)
- At this point we can emit OpenCL for GPU
- Scalarise the kernels
- At this point we have transformed the F77 program into a form that can be expressed in a pure functional language

### TyTraCL

Describe TyTraCL (see Shonan talk)

### The core of the current work

- normalise
- substitute
- rewrite
- expand (or use the term I used; essentially a variant of ANF)
- generate Fortran/OpenCL

Rewrite

Present the rewrite rules

Then present the way back to Fortran

Explain with a few small examples

We want to show the reduction with and without stencils and also with and without folds.

Is it worth explaining that we can also emit the code before we rewrite it? 
And is it even true? I should maybe test this. What this gives us is essentially a mechanism to emit better OpenCL because I improve on Gavin's compiler. And because of TyTtraCL we can relatively emit FPGA code from the same code base as GPU code. To do so we would need to incorporate the code from James to generate stencil caches, readers and writers. I also think I need to clean up a bit.

As ever, they key issue to be resolved is boundary calcs.
Also, right now I am very sloppy because I don't guard anything. The key issue is how to handle arrays without halos mixed in with arrays with halos. 







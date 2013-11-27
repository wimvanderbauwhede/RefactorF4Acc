
#define DEBUG 3
#define TRUE 1
#define FALSE 0

#define UNKNOWN 2
#define SPACES 2

/* define the language to be generated */
#define C 0
#define CUDA 1
#define ANALYSIS 2              // generate analysis information

/* define directives and options to the ACC$DO directive */
#define ACCREGION 1
#define ACCDO 2
#define ENDDO 3
#define PARALLEL 4
#define UNROLL 5                // not supported yet 
#define VECTOR 6
#define ACCDO_OPT 7
#define EXISTS 8
#define PSCOPE 9

#define ACCROUTINE 20

// identifies thread and block arguments in the ACC$REGION(<thread>,<block>)
// modes are also used for SetRegionVar function to add loop / directive info
#define THREAD 1
#define BLOCK 2
// PARALLEL and VECTOR are also used in SetRegionVar as defined above
#define DO_PARALLEL 7
#define DO_VECTOR 8

#define NTHREADS 12
#define NBLOCKS 13

#define CHUNK 5000
#define BLOCKFACTOR 5001

// defs to support various type of code generation for ACC$REGION and ACC$DATA
#define KERNEL 1                // GPU kernel routine
#define KERNEL_CALL 2           // Call to the GPU kernel from the CPU
#define KERNEL_IN 3             // data copies prior to kernel call
#define KERNEL_OUT 4            // data copies after kernel has executed
#define ACCDATA 5               // data copies for the ACC$DATA directive
#define KERNEL_DECLS 6          // local variable declarations for each kernel
#define KERNEL_DECLS_END 7      // update scalars at the end of the kernel
#define SUBR_END 8              // handling at the end of the subroutine
#define SUBR_DECLS 9            // declarations for the CPU (calling) routine

/* modes that support variable usage with each CPU or GPU region */
#define ROUTINE 0
#define RESET 10
#define REGION 1000
#define READ 2000
#define WRITE 3000
#define READWRITE 4000

/* defs for the ACC$ROUTINE directive */
#define CPU 1
#define GPU 2
#define FORTRAN 3

/* variable declaration types used by ACC$DATA and ACC$REGION   */
#define PASSED_IN 1     /* passed in via subroutine arg         */
#define LOCAL 2         /* declared locally                     */
#define MODULE 3        /* declared in a module                 */

/* variable scope attributes used by ACC$DATA and ACC$REGION            */
#define GLOBAL 4
#define EXTERN 5
#define EXTERN_ROUTINE 50
#define SHARED 6
#define CONSTANT 8      // declared as a constant
#define GPU_CONSTANT 9  // GPU constant
#define VARIABLE 10

/* GPU intent attributes used by ACC$DATA and ACC$REGION */
#define IN 1
#define INOUT 2
#define OUT 3
#define NONE 4

// Information retrieval of attributes about variables in an ACC$REGION
#define INTENT 1
#define SCOPE 2
#define DEMOTEDIM 3
#define PROMOTED 4
#define PROMOTE_TYPE 5

/* Retrieval of do loop values to support ACC$DO        */
#define START 1
#define STOP 2
#define BASE 3
#define MATCH 4

#define MAX_STORAGE_SIZE 4096  /* 256 for Tesla (ComputeCapability 1.x) */
#define MAX_TABLE_SIZE 5000
#define MAX_KERNELS 100

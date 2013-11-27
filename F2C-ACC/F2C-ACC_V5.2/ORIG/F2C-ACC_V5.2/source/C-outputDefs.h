
#define FALSE 0
#define TRUE 1
        /* language generation  */
#define C 0
#define CUDA 1
        /* indentation per nest level */
#define SPACES 2        
        /* array attributes: size, upper and lower bounds */
#define SIZE 1
#define LBOUND 2
#define UBOUND 3
        /* default length of an internal character array        */
#define MAX_STRLEN 100
        /* output generation types */
#define KERNEL 1
#define KERNEL_CALL 2
#define KERNEL_IN 3
#define KERNEL_OUT 4
#define ACCDATA 5
#define KERNEL_DECLS 6
#define KERNEL_DECLS_END 7
#define SUBR_END 8

#define CPU_M4 3
#define DECLARE 4

        /* defines how declarations were defined for each variable */
#define PASSED_IN 1
#define LOCAL 2
#define MODULE 3
#define GLOBAL 4
#define EXTERN 5
#define EXTERN_ROUTINE 50
#define SHARED 6
#define NODECL 7
#define CONSTANT 8
#define GPU_CONSTANT 9

#define IN 1
#define INOUT 2
#define OUT 3

#define SIZE 1
#define LBOUND 2
#define UBOUND 3

#define FMAX 1
#define FMIN 2

#define ACCREGION 1
#define ACCDO 2
#define ENDDO 3
#define PARALLEL 4
#define VECTOR 6
#define ACCDO_OPT 7

#define REAL 1
#define DOUBLE 2
#define SHORT 3
#define INT 4
#define LONG 5

#define KIND 2
#define MODULO 3

#define FUNCTION 50
#define SUBROUTINE 60

/* modes for declaring and using user defined constants */
#define CDECLARE 0
#define COMPARE 1

/* statement types */
#define ALLOCATE 1
#define DEALLOCATE 2
#define DIMENSION 3
#define CONTINUE 4
#define ASSIGN 5

#define CPU 1
#define GPU 2
#define FORTRAN 3

#define DATA_MOVEMENT   10
#define DATA_MOVEMENT_VERBOSE   11
#define VARIABLE_USE    20
#define GLOBAL_MEMORY 30

// Information retrieval of attributes about variables in an ACC$REGION
#define INTENT 1
#define SCOPE 2
#define DEMOTEDIM 3
#define PROMOTED 4
#define PROMOTE_TYPE 5
#define EXISTS 8

// identifies thread and block arguments in the ACC$REGION(<thread>,<block>)
// modes are also used for SetRegionVar function to add loop / directive info
#define THREAD 1
#define BLOCK 2
// PARALLEL (4) and VECTOR (6) are also used in SetRegionVar as defined above
#define DO_PARALLEL 7
#define DO_VECTOR 8

#define CHUNK 5000
#define BLOCKFACTOR 5001

/* Modes for GetAccDo function */
#define START 1
#define STOP 2
#define BASE 3
#define MATCH 4

/* modes that support variable usage with each CPU or GPU region */
#define ROUTINE 0
#define RESET 10
#define REGION 1000
#define READ 2000
#define WRITE 3000
#define READWRITE 4000


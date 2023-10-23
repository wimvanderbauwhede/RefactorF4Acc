# Limitations of RefactorF4Acc

## Limitations because of Purpose

* This tool was developed for a specific purpose: refactoring FORTRAN77 code into Fortran 95 code _suitable for offloading to GPUs and FPGAs_. The refactorings it includes are there to support that goal. Therefore, many refactorings that you might do to improve code on CPU, e.g. to benefit from SIMD, are _not_ included, for example replacing loops by array operations.
* I have gradually been adding support for more F77, F90 and F95 features, but there is still a lot that is not supported, see below.
* This is a full-source compiler, so it assumes full visibility of the entire source code. That means that external subroutines for which there is no source code will lead to incorrect refactoring, because the compiler needs either know or be able to infer the subroutine signature. You can work around this by adding a stub subroutine.
* To perform static code analysis, the compiler requires all array bounds to be constants at compile time. If your code contains array bounds defined using variables, in particular subroutine arguments, the analysis can't work.
* This is not an auto-parallelising compiler. The resulting code is also _not_ GPU-ready, it is still ordinary, single-threaded Fortran code. For the process to generate fully parallel OpenCL code for GPU, see the "Example of full toolchain from FORTRAN77 to parallel OpenCL" in the [README.md]. 

## Refactoring

Currently, the refactoring operations are not configurable. The compiler will:

* replace all `COMMON` variables with subroutine arguments
* replace all `EQUIVALENCE` variables with subroutine arguments
* explicitly declare all variables
* force `IMPLICIT NONE`
* eliminate `GOTO` if they can be replaced by a `DO`-loop
* create modules instead of `include`-files

## Unsupported statements

The current release of rf4a successfully refactors the NIST78 testsuite, and also supports most Fortran-95 features, but by far not all of Fortran's features are supported. In particular

- A `♦` suffix means not part of the F77 specification
- A `(E)` suffix means using this statement results in a parse error
- A `(I)` suffix means using this statement is ignored in the analysis

### Fortran 77

As these are not in the spec, they will be very low priority:

- MAP/END MAP♦ (E)
- STRUCTURE/END STRUCTURE♦ (E)
- UNION/END UNION♦ (E)
- RECORD♦ (E)
- TOPEN♦ (E)
- TCLOSE♦ (E)
- ENCODE♦ (E)
- DECODE♦ (E)
- OPTIONS♦ (E)
- PRAGMA♦ (I)

### Fortran 90/95

#### Specification Statements

- ALLOCATABLE (I)
- INTENT (I)
- OPTIONAL (I)
- POINTER (I)
- PRIVATE (I)
- PUBLIC (I)
- TARGET (I)
- STATIC♦ (I)
- AUTOMATIC♦ (I)
- VOLATILE♦ (I)
- VALUE♦ (I)
- MODULE PROCEDURE (E)
- SEQUENCE (E)
- TYPE (E)

#### Control Statements:
- CYCLE (I)
- EXIT (I)
- WHERE/ELSEWHERE/END WHERE (E)

#### Assignment and Storage Statements
- ALLOCATE (I)
- DEALLOCATE (I)
- NULLIFY (I)

#### Program Structure Statements
- INTERFACE (E)

## Pragmas

Because rf4a refactors the code substantially, it is not possible to preserve all comments in their original locations, as those locations often disappear. This is also the case for pragmas, so if your code contains any pragmas (e.g. `!$OMP`), check if after refactoring they are still in the right place.

## C preprocessor macros

The compiler completely ignores C preprocessor macros, so if your code uses these, it is best to run `cpp` in advance.

## Other unsupported features

- `SAVE` statements are deleted everywhere unless the configuration option `NO_SAVE=0` is set. 
- "The extension of named `COMMON` block storage by `EQUIVALENCE` association of a variable and an array" as tested by `NIST FM302 TEST 013` is not handled correctly because it is not type safe. 
- `EQUIVALENCE` handling for arrays is incorrect for non-constant indices.

## Type errors

One of the main features of rf4a is that it aims to produce type safe code. Therefore, statements that break type safety (in particular in COMMON blocks and EQUIVALENCE statements) will result in a type error. You can relax type checking by setting `STRICT_COMMONS_CHECKS=0` or `STRICT_EQUIVALENCE_CHECKS=0` in your configuration file, but rf4a can only correctly refactor the code if it is type safe. 

## Other compilation errors

There is still a considerable subset of code that rf4a can't handle correctly, and this will result in compiler errors. You can instruct rf4a to ignore errors and continue regardless by setting `IGNORE_ERRORS=1` in your configuration file. If the resulting code is generated, it will not be correct but usually it can quite easily be patched manually.

## Known bugs

* In the expression parser, `=` has incorrect precedence. So in particular implied DO might not always parse correctly.
* Sometimes the end of a block is not identified correctly.
* Creating and using modules is still a bit flaky.
* Refactoring globals sometimes leads to name conflicts between parameters and variables, and these are not always resolved correctly.
* Casting between types currently assumes that `kind=4`.
* Reshaping of arrays to refactor `EQUIVALENCE` is incomplete.
* Constant folding is incomplete.
* `ENTRY` handling is probably flaky.





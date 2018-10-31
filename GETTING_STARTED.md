#  Refactoring "Hello, world!"
The following command-line sessions transcript demonstrates the use of RefactorF4Acc to 
refactor a "Hello, world!" program that starts with the following legacy Fortran features:
* Fixed-form source
* A Fortran 77 parameter statement
* An implicitly typed variable
* A `common` block
* An `include` statement
* Dummy arguments with no specified `intent`
* An external subroutine with an implicit interface
```
# Display source directory tree structure
$ tree .
.
├── Makefile
├── rf4a.cfg
└── src
    ├── greet_world.f
    ├── include
    │   └── error_codes.h
    └── main.f
```
```fortran
$ cat src/main.f 
C fixed-form source
      program hello
        implicit double precision (a-h,o-z)
        character(len=5) greeting
C F77-style parameter statement
        parameter(greeting="Hello")
        include 'error_codes.h'
        isuccess=0
C implicitly typed error code:
        call greet_world(greeting,ierror)
        if (ierror .ne. isuccess) then
          write(*,*) "something went wrong (error code: ",ierror,")"
        else
          write(*,*) "All is right with the world."
        end if
      end program
```
```fortran
$ cat src/greet_world.f 
C external subroutine with implicit interface
      subroutine greet_world(string,ierr)
C dummy variable lacking intent:
        character(len=*) string
        write(*,*) string // ", world!"
C implicitly typed error code:
        ierr = 0
      end subroutine
```
```fortran
$ cat src/include/error_codes.h 
C implicitly typed global data
      common/error_codes/ isuccess
```
RefactorF4Acc can refactor the above code using using the following configure file:
```
$ cat rf4a.cfg 
TOP = hello
PREFIX = .
SRCDIRS = src
NEWSRCPATH = refactored-source
$ refactorF4acc.pl -c rf4a.cfg 
$ tree refactored-source/
refactored-source/
└── src
    ├── greet_world.f95
    ├── include
    │   └── error_codes.f95
    └── main.f95

```
The resulting code has the following properties:
* Free form source as indicated by the new `.f95` file extensions.
* Use association of a module procedure (which gives the procedure an explicit interface, thereby improving type safety).
* Specified dummy argument `intent` inferred by source analysis.
* A module variable replacing the `common` block.
* `!` comments
Because the comments all related to legacy features that RefactorF4Acc removes or transforms,  the comments 
were removed manually to avoid confusion in the following listings:
related to 
```fortran
$ cat refactored-source/src/main.f95 
      program hello
      use module_src_greet_world
      integer :: isuccess
      integer :: ierror
      character(len=*), parameter :: greeting="Hello"
        isuccess=0
        call greet_world(greeting,ierror)

        if (ierror  /=  isuccess) then
          write(*,*) "something went wrong (error code: ",ierror,")"
        else
          write(*,*) "All is right with the world."
        end if
      end program
```
```
$ cat refactored-source/src/greet_world.f95 
module module_src_greet_world

contains

      subroutine greet_world(string,ierr)
      integer, intent(Out) :: ierr
        character(len=*), intent(In) :: string
        write(*,*) string // ", world!"
        ierr = 0
      end subroutine

end module module_src_greet_world
```
The refactored code can be run as follows:

```
$ cd refactored-source/
$ gfortran -o hello src/greet_world.f95 src/main.f95 
$ ./hello 
 Hello, world!
 All is right with the world.
```

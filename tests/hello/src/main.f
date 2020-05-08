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

C external subroutine with implicit interface
      subroutine greet_world(string,ierr)
C dummy variable lacking intent:
        character(len=*) string
        write(*,*) string // ", world!"
C implicitly typed error code:
        ierr = 0
      end subroutine

      program main
      implicit none
      character(len=5) hello
      hello = 'hello'
      call sub
      contains
      subroutine sub
        implicit none
          print *, hello
      end subroutine sub
      end program main


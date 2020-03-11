      program test_argmap
      implicit none
      integer, dimension(1:256) :: ia
      integer :: is
      integer, parameter :: ip=42
      integer :: i
      i=0
      call test(ia,ia(i),int(2*is+1, 4),is,ip,43,int(is))

      end program test_argmap
      subroutine test(a1,a2,a3,a4,a5,a6,a7)
      implicit none
      integer, dimension(1:256) :: a1
      integer :: a2
      integer, intent(In) :: a3
      integer :: a4
      integer, intent(In) :: a5
      integer, intent(In) :: a6
      integer, intent(In) :: a7
      end subroutine test

      program test_const_args
      implicit none
      	real :: dragpx
      	real :: w1
      integer, parameter :: maxobj=41
      	call f1()

      	call gop(dragpx,w1,'+  ',maxobj+1)

      end program test_const_args
      subroutine f1()
      implicit none
      	real, dimension(1:256) :: av
      	integer :: asz
      integer, parameter :: nelts=257
      	asz = nelts -1 
      	call f2(av,asz)

      end subroutine f1
      subroutine f2(av,asz)
      implicit none
      	integer :: asz
      	real, dimension(1:asz) :: av
      end subroutine f2
      subroutine gop(x,w,op,n)
      implicit none
      real :: x
      real :: w
      character(len=3), intent(In) :: op
      integer, intent(In) :: n
      end subroutine gop

      program test_const_args
      implicit none
      	real :: dragpx
                integer :: w1
                integer :: w2
                integer :: w3
      integer, parameter :: maxobj=41
      	dragpx=1.1
                w3=1
                w2 = maxobj+w3
      	w1=w2*w2
      	call f1()

      	call gop(dragpx,w1,'+  ',maxobj+1)

      end program test_const_args
      subroutine f1()
      implicit none
      	real, dimension(1:256) :: av
      	integer :: asz
      integer, parameter :: nelts=257
      	av(1)=33
      	av(256)=44
      	asz = nelts -1 
      	call f2(av,asz)

      end subroutine f1
      subroutine f2(av,asz)
      implicit none
      	integer :: asz
      	real, dimension(1:asz) :: av
      	print *, av(1),av(256)
      end subroutine f2
      subroutine gop(x,w,op,n)
      implicit none
      	real :: x
                integer :: w
                real, dimension(1:w) :: ra
      	character(len=3) :: op
      	integer :: n
      	print *, x, w, op, n
      end subroutine gop

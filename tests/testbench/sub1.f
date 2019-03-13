      subroutine sub1(vs)
      include 'incl1.inc'
      integer vs
      dimension vs(nelts)

      integer i, vv
C     This declaration must be present or the result is wrong!
      integer func1
      do i=1,nelts
          vv=func1(i)
          print *, i, vv
          vs(i)=vv
      end do
      end

      subroutine sub2(vs)
          include 'incl1.inc'
          integer i
          integer vs
          dimension vs(nelts)
          integer func2
          do i=1,nelts
              print *, i, vs(i)
              vs(i)=func2(vs(i))
              print *, i, vs(i)
          end do
      end

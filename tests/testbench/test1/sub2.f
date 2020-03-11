      subroutine sub2(vs)
          include 'incl1.inc'
          integer i
          integer vs
          dimension vs(nelts)
          integer func2
          do i=1,nelts
              vs(i)=func2(vs(i))
          end do
      end

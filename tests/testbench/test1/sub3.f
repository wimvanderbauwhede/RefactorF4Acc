      subroutine sub3(vs)
          include 'incl1.inc'
          integer i
          integer vs
          dimension vs(nelts)
          integer func3
          do i=1,nelts
              vs(i)=func3(vs(i))
          end do
      end

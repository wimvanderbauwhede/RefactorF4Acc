      program test_inline_single_function
        integer v, v2
        integer i
        real x
        v=42
        do i=1,2
!$ACC Inline
            x = v+2*s1(v,v)-1
!$ACC End Inline
        end do
        print *,x,v
      end program

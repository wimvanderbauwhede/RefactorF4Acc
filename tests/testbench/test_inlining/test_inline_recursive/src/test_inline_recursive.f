      program test_inline_single
        integer v
        integer i
        v=42
        do i=1,4
!$ACC Inline
            call s1(v,v)
!$ACC End Inline
        end do
        print *,v
      end program

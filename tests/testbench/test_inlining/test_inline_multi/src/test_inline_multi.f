      program test_inline_multi
        integer v
        integer i
        v=42
        do i=1,4
!$ACC Inline
            call s1(v,v)
            ! call s2(v+1,v)
            call s1(v-1,v)
!$ACC End Inline
        end do
        print *,v
      end program

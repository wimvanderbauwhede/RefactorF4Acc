      program test_inline_recursive_multi
        integer v
        integer i
        v=42
        do i=1,2
!$ACC Inline
            call s1(v,v)

            call s1b(v,i)

            call s1(v,v)
!$ACC End Inline
        end do
        print *,v
      end program

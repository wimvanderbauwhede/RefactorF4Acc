      subroutine s1b(v_inout,ii)
        ! integer v_in, v_out
        integer v_inout, v
        integer i, ii
        v = v_inout
        do i = 1,3          
        v = v*2+ii
        call s2b(v)
        print *,v
        v_inout = v
        end do
      end

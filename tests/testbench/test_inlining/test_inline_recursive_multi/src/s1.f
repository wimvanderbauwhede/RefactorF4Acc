      subroutine s1(v_in,v_out)
        integer v_in, v_out
        integer i
        v_out = v_in
        do i = 1,2        
        v_out = v_out*2
        call s2(v_out)
        print *,v_out
        end do
      end

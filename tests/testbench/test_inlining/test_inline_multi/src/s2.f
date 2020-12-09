      subroutine s2(v_in,v_out)
        integer v_in, v_out
        integer i
        v_out = v_in
        do i = 1,3          
        v_out = v_out*2
        print *,v_out
        end do
      end

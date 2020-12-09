      subroutine s1(v_in,v_out)
        integer v_in, v_out
        integer i, v
        v_out = v_in
        do i = 1,3          
        v = v_out*2
        v_out = v+1
        print *,v_out
        end do
      end

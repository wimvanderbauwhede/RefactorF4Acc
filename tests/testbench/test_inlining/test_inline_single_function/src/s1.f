      function s1(v_in,v_out)
        integer v_in, v_out
        integer i, v
        real s1
        v_out = v_in
        do i = 1,2 
        v = v_out*2        
        v_out = v+2
        print *,v_out
        end do
        s1 = v_out/4.0+1.0
      end

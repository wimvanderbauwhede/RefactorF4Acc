      subroutine s2b(v_inout)
        integer v_inout
        integer x
        x = v_inout*v_inout
        v_inout = x/10
        call s3b(42,v_inout)
        print *,v_inout
      end

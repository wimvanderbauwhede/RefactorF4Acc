      subroutine s2(v_inout)
        integer v_inout
        integer x
        x = v_inout*v_inout
        v_inout = x/10
        call s3(42,v_inout)
        print *,v_inout
      end

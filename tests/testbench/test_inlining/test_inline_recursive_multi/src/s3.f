      subroutine s3(n, v_inout)
        integer n, v_inout, v_n
        v_n = 2+n
        v_inout = v_n + v_inout
        print *,v_inout
      end

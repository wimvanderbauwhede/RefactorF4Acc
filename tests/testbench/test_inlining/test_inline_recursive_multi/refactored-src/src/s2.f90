module singleton_module_src_s2

contains

      subroutine s2(v_inout)
      implicit none
        integer :: v_inout
        integer :: x_s2
!          BEGIN ex-sub decls s3
        integer :: v_n_s3_s2
!          END ex-sub decls s3
        x_s2 = v_inout*v_inout
        v_inout = x_s2/10
!          BEGIN inlined call to s3
        v_n_s3_s2 = 2*42
        v_inout = v_n_s3_s2 + v_inout
        print *,v_inout
!          END inlined call to s3
        print *,v_inout
      end subroutine s2

end module singleton_module_src_s2


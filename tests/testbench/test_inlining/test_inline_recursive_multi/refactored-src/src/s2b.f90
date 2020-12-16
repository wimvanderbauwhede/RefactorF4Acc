module singleton_module_src_s2b

contains

      subroutine s2b(v_inout)
      implicit none
        integer :: v_inout
        integer :: x_s2b
!          BEGIN ex-sub decls s3b
        integer :: v_n_s3b_s2b
!          END ex-sub decls s3b
        x_s2b = v_inout*v_inout
        v_inout = x_s2b/10
!          BEGIN inlined call to s3b
        v_n_s3b_s2b = 2*42
        v_inout = v_n_s3b_s2b + v_inout
        print *,v_inout
!          END inlined call to s3b
        print *,v_inout
      end subroutine s2b

end module singleton_module_src_s2b


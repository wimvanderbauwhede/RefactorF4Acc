module singleton_module_src_s1b

contains

      subroutine s1b(v_inout,ii)
        ! integer v_in, v_out
      implicit none
        integer, intent(InOut) :: v_inout
        integer :: v_s1b
        integer :: i_s1b
        integer, intent(In) :: ii
!          BEGIN ex-sub decls s2b
        integer :: x_s2b_s1b
!          BEGIN ex-sub decls s3b
        integer :: v_n_s3b_s2b_s1b
!          END ex-sub decls s2b
        v_s1b = v_inout
        do i_s1b = 1,2        
        v_s1b = v_s1b*2+ii
!          BEGIN inlined call to s2b
!          END ex-sub decls s3b
        x_s2b_s1b = v_s1b+v_s1b/4
        v_s1b = x_s2b_s1b/10
!          BEGIN inlined call to s3b
        v_n_s3b_s2b_s1b = 2*42
        v_s1b = v_n_s3b_s2b_s1b + v_s1b
        print *,v_s1b
!          END inlined call to s3b
        print *,v_s1b
!          END inlined call to s2b
        print *,v_s1b
        v_inout = v_s1b
        end do
      end subroutine s1b

end module singleton_module_src_s1b


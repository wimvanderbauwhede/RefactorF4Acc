module singleton_module_src_s1b

contains

      subroutine s1b(v_inout,ii)
      implicit none
      real, intent(InOut) :: v_inout
      real :: v_s1b
        integer :: v_in_s1b
        integer :: v_out_s1b
        ! integer v_inout, v
        integer :: i_s1b
        integer, intent(In) :: ii
        integer :: v_s2b
!          BEGIN ex-sub decls s2b
        integer :: x_s2b_s1b
!          BEGIN ex-sub decls s3b
        integer :: v_n_s3b_s2b_s1b
!          END ex-sub decls s2b
        v_s1b = v_inout
        do i_s1b = 1,3          
        v_s1b = v_s1b*2+ii
        v_s2b = int(v_s1b, 4)
!          BEGIN inlined call to s2b
!          END ex-sub decls s3b
        x_s2b_s1b = v_s1b*v_s1b
        v_s1b = x_s2b_s1b/10
!          BEGIN inlined call to s3b
        v_n_s3b_s2b_s1b = 2*42
        v_s1b = v_n_s3b_s2b_s1b + v_s1b
        print *,v_s1b
!          END inlined call to s3b
        print *,v_s1b
!          END inlined call to s2b
        v_s1b = real(v_s2b,4)
        print *,v_s1b
        v_inout = v_s1b
        end do
      end subroutine s1b

end module singleton_module_src_s1b


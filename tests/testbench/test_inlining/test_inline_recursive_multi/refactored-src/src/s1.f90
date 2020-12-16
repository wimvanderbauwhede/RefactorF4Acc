module singleton_module_src_s1

contains

      subroutine s1(v_in,v_out)
      implicit none
        integer, intent(In) :: v_in
        integer :: v_out
        integer :: i_s1
!          BEGIN ex-sub decls s2
        integer :: x_s2_s1
!          BEGIN ex-sub decls s3
        integer :: v_n_s3_s2_s1
!          END ex-sub decls s2
        v_out = v_in
        do i_s1 = 1,3          
        v_out = v_out*2
!          BEGIN inlined call to s2
!          END ex-sub decls s3
        x_s2_s1 = v_out*v_out
        v_out = x_s2_s1/10
!          BEGIN inlined call to s3
        v_n_s3_s2_s1 = 2*42
        v_out = v_n_s3_s2_s1 + v_out
        print *,v_out
!          END inlined call to s3
        print *,v_out
!          END inlined call to s2
        print *,v_out
        end do
      end subroutine s1

end module singleton_module_src_s1


module module_test7

contains

   subroutine test7(u,f, global_id)
      implicit none
      real, dimension(1:9000), intent(in) :: u
      real, dimension(1:9000), intent(out) :: f
      integer, intent(in) :: global_id

      integer, dimension(1:5), parameter :: s3 = (/13, 145, 156, 157, 168/)
      integer, dimension(1:2), parameter :: s5 = (/145, 289/)
      real, dimension(1:2, 1:5) :: svec_u_1
!  Dead Code Begin
      real, dimension(1:2, 1:5) :: svec_u_2
!  Dead Code End
      integer :: s_idx_1, s_idx_2
      if (global_id>0) then
      do s_idx_1 = 1, 2
      do s_idx_2 = 1, 5
         svec_u_1(s_idx_1, s_idx_2) = u(global_id + s5(s_idx_1) + s3(s_idx_2))
      end do
      end do
!  Dead Code Begin
      do s_idx_1 = 1, 2
      do s_idx_2 = 1, 5
         svec_u_2(s_idx_1, s_idx_2) = u(global_id + s5(s_idx_1) + s3(s_idx_2))
      end do
      end do
!  Dead Code End
      else
         svec_u_1(1,1) = 0
      end if

      f(global_id) = u(global_id)/2.0+svec_u_1(1,1)

   end subroutine test7

end module module_test7


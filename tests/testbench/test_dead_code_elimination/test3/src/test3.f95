module module_test3

contains

   subroutine test3(u,f, global_id)
      implicit none
      real, dimension(1:9000), intent(in) :: u
      real, dimension(1:9000), intent(out) :: f
      integer, intent(in) :: global_id

!  Dead Code Begin
      integer, dimension(1:2), parameter :: s10 = (/145, 289/)
      real, dimension(1:2, 1:5) :: svec_u_2
      real :: dfu1_1___f_pelts_f_1_g_1_h_1_16
      real :: dfv1_1___f_pelts_f_1_g_1_h_1_16
      real :: dfw1_1___f_pelts_f_1_g_1_h_1_16
!  Dead Code End

      integer, dimension(1:2), parameter :: s3 = (/13, 145/)
      integer, dimension(1:2), parameter :: s5 = (/145, 289/)
      real, dimension(1:2, 1:2) :: svec_u_1
      integer :: s_idx_1, s_idx_2
      do s_idx_1 = 1, 2
      do s_idx_2 = 1, 2
         svec_u_1(s_idx_1, s_idx_2) = u(global_id + s5(s_idx_1) + s3(s_idx_2))
      end do
      end do
      f(global_id) = svec_u_1(1,1) + svec_u_1(1,2) + svec_u_1(2,1) + svec_u_1(2,2)


!  Dead Code Begin
      dfu1_1___f_pelts_f_1_g_1_h_1_16 = u(global_id)
      dfv1_1___f_pelts_f_1_g_1_h_1_16 = u(global_id)
      dfw1_1___f_pelts_f_1_g_1_h_1_16 = u(global_id)
!  Dead Code End

   end subroutine test3

end module module_test3


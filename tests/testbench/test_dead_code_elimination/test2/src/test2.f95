module module_test2

contains

   subroutine test2(u,f, global_id)
      implicit none
      real, dimension(1:9000), intent(in) :: u
      real, dimension(1:9000), intent(out) :: f
      integer, intent(in) :: global_id

!  Dead Code Begin
      real :: not_used
!  Dead Code End

      integer, dimension(1:2), parameter :: s3 = (/13, 145/)
      integer, dimension(1:2), parameter :: s5 = (/145, 289/)
      real, dimension(1:2, 1:2) :: svec_u_1
      integer :: s_idx_1, s_idx_2

      do s_idx_1 = 1, 2
      do s_idx_2 = 1, 2
         svec_u_1(s_idx_1, s_idx_2) = u(global_id + s5(s_idx_1) + s3(s_idx_2))

!  Dead Code Begin
         not_used = svec_u_1(s_idx_1, s_idx_2)
!  Dead Code End

      end do
      end do

      f(global_id) = svec_u_1(1,1) + svec_u_1(1,2) + svec_u_1(2,1) + svec_u_1(2,2)

   end subroutine test2

end module module_test2


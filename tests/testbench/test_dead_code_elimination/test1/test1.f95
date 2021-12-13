module module_test1

contains

   subroutine test1(in, out, global_id)
      implicit none
      real, dimension(1:9000), intent(in) :: u
      real, dimension(1:9000), intent(out) :: f
      integer, intent(in) :: global_id

!  Dead Code Begin
      integer, dimension(1:5), parameter :: s3 = (/13, 145, 156, 157, 168/)
      integer, dimension(1:2), parameter :: s5 = (/145, 289/)
      real, dimension(1:2, 1:5) :: svec_u_1
      integer :: s_idx_1, s_idx_2
      do s_idx_1 = 1, 2
      do s_idx_2 = 1, 5
         svec_u_1(s_idx_1, s_idx_2) = u_0(global_id + s5(s_idx_1) + s3(s_idx_2))
      end do
      end do
!  Dead Code End

      f(global_id) = u(global_id)/2.0

   end subroutine test1

end module module_test1


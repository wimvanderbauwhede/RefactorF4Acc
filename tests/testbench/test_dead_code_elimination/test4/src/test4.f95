module module_test4

contains

   subroutine test4(u,f, global_id)
      implicit none
      real, dimension(1:9000), intent(in) :: u
      real, dimension(1:9000), intent(out) :: f
      integer, intent(in) :: global_id


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

! Dead code Begin
      do s_idx_1 = 1, 2
      do s_idx_2 = 1, 2
         svec_u_1(s_idx_1, s_idx_2) = u(global_id + s5(s_idx_1) + s3(s_idx_2))
      end do
      end do
! Dead code End


   end subroutine test4

end module module_test4


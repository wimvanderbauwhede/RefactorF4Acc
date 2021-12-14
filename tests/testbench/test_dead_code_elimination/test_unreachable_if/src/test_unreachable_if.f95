module module_unreachable_if

contains

   subroutine test_unreachable_if(u,f)
      implicit none
      integer, parameter :: k = 9000

      real, dimension(1:9000), intent(in) :: u
      real, dimension(1:9000), intent(out) :: f
      integer :: global_id

      integer, dimension(1:5), parameter :: s3 = (/13, 145, 156, 157, 168/)
      integer, dimension(1:2), parameter :: s5 = (/145, 289/)
      real, dimension(1:2, 1:5) :: svec_u_1
      real :: accum
      integer :: s_idx_1, s_idx_2

      do global_id = 1, 5000
         do s_idx_1 = 1, 2
         do s_idx_2 = 1, 5
            svec_u_1(s_idx_1, s_idx_2) = u(global_id + s5(s_idx_1) + s3(s_idx_2))

            ! Not sure if we want to analyse unreachable branches.
! Dead Code Begin
            if (global_id + s5(s_idx_1) + s3(s_idx_2) > k) then
               svec_u_1(s_idx_1, s_idx_2) = 0
            end if
! Dead Code End

         accum = accum + svec_u_1(s_idx_1, s_idx_2)

         end do
         end do
         
         f(global_id) = accum / 10.0
      
      end do


   end subroutine test_unreachable_if

end module module_unreachable_if


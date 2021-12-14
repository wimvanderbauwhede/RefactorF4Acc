module module_test5

contains

   subroutine test5(u,v )
      implicit none
      real, intent(in) :: u
      real, intent(out) :: v
      integer, intent(in) :: global_id


      integer, dimension(1:2), parameter :: s3 = (/13, 145/)
      integer, dimension(1:2), parameter :: s5 = (/145, 289/)
      real, dimension(1:2, 1:2) :: svec_u_1
      real :: w1
      real :: w2
      real :: w3
      real :: w4
      real :: w5
      integer :: s_idx_1, s_idx_2
      w1 = 0
      w1 = u
      w2 = w1+1
      w3 = w2+w1
      w5 = w3*2
      w3 = w2+1
      w4 = w3
      w3 = w2+2
      w1 = u+w3+w2
      w5 = 0
      w2 = w5+1
      v = w1

   end subroutine test5

!      w1 = u
!      w2 = w1+1
!      w3 = w2+2
!      v = w3

end module module_test5


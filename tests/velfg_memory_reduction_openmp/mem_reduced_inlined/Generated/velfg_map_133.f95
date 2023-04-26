module singleton_module_velfg_map_133

contains

subroutine velfg_map_133(dzn_0,dx1_0,dy1_0,th_idx_0,u_s_1,w_s_1,v_s_1,cov7_1,cov8_1,diu7_1,diu8_1, &
      nou7_1,nou8_1)
use singleton_module_velfg_map_133, only : velfg_map_133_scal
 implicit none
!      BEGIN ex-sub decls velfg_map_133_scal
 integer, parameter :: ip___velfg_map_133_scal=300
 integer, parameter :: jp___velfg_map_133_scal=300
 integer, parameter :: kp___velfg_map_133_scal=90
 integer, parameter :: im___velfg_map_133_scal=300
 integer, parameter :: jm___velfg_map_133_scal=300
 integer, parameter :: km___velfg_map_133_scal=90
 integer, parameter :: ifbf___velfg_map_133_scal=1
 integer, parameter :: ianime___velfg_map_133_scal=1
 integer, parameter :: ical___velfg_map_133_scal=0
 integer, parameter :: n0___velfg_map_133_scal=1
 integer, parameter :: n1___velfg_map_133_scal=10001
 integer, parameter :: nmax___velfg_map_133_scal=20000
 real, parameter :: dt___velfg_map_133_scal=0.2
 real, parameter :: ro___velfg_map_133_scal=1.1763
 real, parameter :: vn___velfg_map_133_scal=15.83 * 10. ** (-6.)
 real, parameter :: alpha___velfg_map_133_scal=-10.
 real, parameter :: beta___velfg_map_133_scal=-1.
 integer, parameter :: u0___velfg_map_133_scal=0
 integer :: i_vel2___velfg_map_133_scal
 integer :: j_vel2___velfg_map_133_scal
 integer :: k_vel2___velfg_map_133_scal
 integer :: k_vel2_range___velfg_m___a725d29e
 integer :: j_vel2_range___velfg_m___9675913f
 integer :: i_vel2_range___velfg_m___a1f7aab8
 integer :: k_vel2_rel___velfg_map_133_scal
 integer :: j_vel2_rel___velfg_map_133_scal
 integer :: i_vel2_rel___velfg_map_133_scal
!      END ex-sub decls velfg_map_133_scal
 real, dimension(-1:92), intent(in) :: dzn_0
 real, dimension(-1:301), intent(in) :: dx1_0
 real, dimension(0:301), intent(in) :: dy1_0
 integer, intent(in) :: th_idx_0
 real, dimension(1:2), intent(In) :: u_s_1
 real, dimension(1:3), intent(In) :: w_s_1
 real, dimension(1:2), intent(In) :: v_s_1
 real, intent(InOut) :: cov7_1
 real, intent(InOut) :: cov8_1
 real, intent(Out) :: diu7_1
 real, intent(Out) :: diu8_1
 real, intent(Out) :: nou7_1
 real, intent(Out) :: nou8_1
!    ! Temp vars
 real :: nou7___velfg_map_133
 real :: diu7___velfg_map_133
 real :: nou8___velfg_map_133
 real :: diu8___velfg_map_133
!    ! Call to the original scalarised subroutine
!      BEGIN inlined call to velfg_map_133_scal
!       call get_th_idx(th_idx,0)
 k_vel2_range___velfg_m___a725d29e = (((90 - 1) - 1) + 1)
 j_vel2_range___velfg_m___9675913f = ((300 - 1) + 1)
 i_vel2_range___velfg_m___a1f7aab8 = ((300 - 1) + 1)
 k_vel2_rel___velfg_map_133_scal = (th_idx___velfg_map_133_scal /  &
      (j_vel2_range___velfg_m___9675913f * i_vel2_range___velfg_m___a1f7aab8))
 k_vel2___velfg_map_133_scal = (k_vel2_rel___velfg_map_133_scal + 1)
 j_vel2_rel___velfg_map_133_scal = ((th_idx___velfg_map_133_scal - (k_vel2_rel___velfg_map_133_scal  &
      * (j_vel2_range___velfg_m___9675913f * i_vel2_range___velfg_m___a1f7aab8))) /  &
      i_vel2_range___velfg_m___a1f7aab8)
 j_vel2___velfg_map_133_scal = (j_vel2_rel___velfg_map_133_scal + 1)
 i_vel2_rel___velfg_map_133_scal = ((th_idx___velfg_map_133_scal - (k_vel2_rel___velfg_map_133_scal  &
      * (j_vel2_range___velfg_m___9675913f * i_vel2_range___velfg_m___a1f7aab8))) -  &
      (j_vel2_rel___velfg_map_133_scal * i_vel2_range___velfg_m___a1f7aab8))
 i_vel2___velfg_map_133_scal = (i_vel2_rel___velfg_map_133_scal + 1)
 nou7___velfg_map_133 = (dzn_0(k_vel2___velfg_map_133_scal + 1) * u_s_1(1) +  &
      dzn_0(k_vel2___velfg_map_133_scal) * u_s_1(2)) / (dzn_0(k_vel2___velfg_map_133_scal) +  &
      dzn_0(k_vel2___velfg_map_133_scal + 1))
 diu7___velfg_map_133 = 2. * (-w_s_1(2) + w_s_1(3)) / (dx1_0(i_vel2___velfg_map_133_scal - 1) +  &
      dx1_0(i_vel2___velfg_map_133_scal))
 cov7_1 = (nou7___velfg_map_133 - u0___velfg_map_133_scal) * diu7___velfg_map_133
 nou8___velfg_map_133 = (dzn_0(k_vel2___velfg_map_133_scal + 1) * v_s_1(1) +  &
      dzn_0(k_vel2___velfg_map_133_scal) * v_s_1(2)) / (dzn_0(k_vel2___velfg_map_133_scal) +  &
      dzn_0(k_vel2___velfg_map_133_scal + 1))
 diu8___velfg_map_133 = 2. * (-w_s_1(1) + w_s_1(3)) / (dy1_0(j_vel2___velfg_map_133_scal - 1) +  &
      dy1_0(j_vel2___velfg_map_133_scal))
 cov8_1 = nou8___velfg_map_133 * diu8___velfg_map_133
!      END inlined call to velfg_map_133_scal
 nou7_1 = nou7___velfg_map_133
 diu7_1 = diu7___velfg_map_133
 nou8_1 = nou8___velfg_map_133
 diu8_1 = diu8___velfg_map_133
end subroutine velfg_map_133

end module singleton_module_velfg_map_133


module singleton_module_velfg_map_218

contains

subroutine velfg_map_218(dx1_0,dy1_0,dzn_0,dzs_0,th_idx_0,cov1_s_0,cov2_s_0,cov3_s_0,diu1_s_0, &
      diu2_s_0,diu3_s_0,cov4_s_0,cov5_s_0,cov6_s_0,diu4_s_0,diu5_s_0,diu6_s_0,cov7_s_0,cov8_s_0, &
      cov9_s_0,diu7_s_0,diu8_s_0,diu9_s_0,dfu1_1,dfv1_1,dfw1_1,f_1,g_1,h_1)
use singleton_module_velfg_map_218, only : velfg_map_218_scal
 implicit none
!      BEGIN ex-sub decls velfg_map_218_scal
 integer, parameter :: ip___velfg_map_218_scal=300
 integer, parameter :: jp___velfg_map_218_scal=300
 integer, parameter :: kp___velfg_map_218_scal=90
 integer, parameter :: im___velfg_map_218_scal=300
 integer, parameter :: jm___velfg_map_218_scal=300
 integer, parameter :: km___velfg_map_218_scal=90
 integer, parameter :: ifbf___velfg_map_218_scal=1
 integer, parameter :: ianime___velfg_map_218_scal=1
 integer, parameter :: ical___velfg_map_218_scal=0
 integer, parameter :: n0___velfg_map_218_scal=1
 integer, parameter :: n1___velfg_map_218_scal=10001
 integer, parameter :: nmax___velfg_map_218_scal=20000
 real, parameter :: dt___velfg_map_218_scal=0.2
 real, parameter :: ro___velfg_map_218_scal=1.1763
 real, parameter :: vn___velfg_map_218_scal=15.83 * 10. ** (-6.)
 real, parameter :: alpha___velfg_map_218_scal=-10.
 real, parameter :: beta___velfg_map_218_scal=-1.
 integer, parameter :: u0___velfg_map_218_scal=0
 real :: covx1___velfg_map_218_scal
 integer :: i___velfg_map_218_scal
 integer :: j___velfg_map_218_scal
 integer :: k___velfg_map_218_scal
 real :: covy1___velfg_map_218_scal
 real :: covz1___velfg_map_218_scal
 real :: covc___velfg_map_218_scal
 real :: df___velfg_map_218_scal
 integer :: k_range___velfg_map_218_scal
 integer :: j_range___velfg_map_218_scal
 integer :: i_range___velfg_map_218_scal
 integer :: k_rel___velfg_map_218_scal
 integer :: j_rel___velfg_map_218_scal
 integer :: i_rel___velfg_map_218_scal
!      END ex-sub decls velfg_map_218_scal
 real, dimension(-1:301), intent(in) :: dx1_0
 real, dimension(0:301), intent(in) :: dy1_0
 real, dimension(-1:92), intent(in) :: dzn_0
 real, dimension(-1:92), intent(in) :: dzs_0
 integer, intent(in) :: th_idx_0
 real, dimension(1:2), intent(In) :: cov1_s_0
 real, dimension(1:2), intent(In) :: cov2_s_0
 real, dimension(1:2), intent(In) :: cov3_s_0
 real, dimension(1:2), intent(In) :: diu1_s_0
 real, dimension(1:2), intent(In) :: diu2_s_0
 real, dimension(1:2), intent(In) :: diu3_s_0
 real, dimension(1:2), intent(In) :: cov4_s_0
 real, dimension(1:2), intent(In) :: cov5_s_0
 real, dimension(1:2), intent(In) :: cov6_s_0
 real, dimension(1:2), intent(In) :: diu4_s_0
 real, dimension(1:2), intent(In) :: diu5_s_0
 real, dimension(1:2), intent(In) :: diu6_s_0
 real, dimension(1:2), intent(In) :: cov7_s_0
 real, dimension(1:2), intent(In) :: cov8_s_0
 real, dimension(1:2), intent(In) :: cov9_s_0
 real, dimension(1:2), intent(In) :: diu7_s_0
 real, dimension(1:2), intent(In) :: diu8_s_0
 real, dimension(1:2), intent(In) :: diu9_s_0
 real, intent(Out) :: dfu1_1
 real, intent(Out) :: dfv1_1
 real, intent(Out) :: dfw1_1
 real, intent(out) :: f_1
 real, intent(out) :: g_1
 real, intent(out) :: h_1
!    ! Temp vars
 real :: dfu1___velfg_map_218
 real :: dfv1___velfg_map_218
 real :: dfw1___velfg_map_218
!    ! Call to the original scalarised subroutine
!      BEGIN inlined call to velfg_map_218_scal
!       call get_th_idx(th_idx,0)
 k_range___velfg_map_218_scal = ((90 - 1) + 1)
 j_range___velfg_map_218_scal = ((300 - 1) + 1)
 i_range___velfg_map_218_scal = ((300 - 1) + 1)
 k_rel___velfg_map_218_scal = (th_idx___velfg_map_218_scal / (j_range___velfg_map_218_scal *  &
      i_range___velfg_map_218_scal))
 k___velfg_map_218_scal = (k_rel___velfg_map_218_scal + 1)
 j_rel___velfg_map_218_scal = ((th_idx___velfg_map_218_scal - (k_rel___velfg_map_218_scal *  &
      (j_range___velfg_map_218_scal * i_range___velfg_map_218_scal))) /  &
      i_range___velfg_map_218_scal)
 j___velfg_map_218_scal = (j_rel___velfg_map_218_scal + 1)
 i_rel___velfg_map_218_scal = ((th_idx___velfg_map_218_scal - (k_rel___velfg_map_218_scal *  &
      (j_range___velfg_map_218_scal * i_range___velfg_map_218_scal))) -  &
      (j_rel___velfg_map_218_scal * i_range___velfg_map_218_scal))
 i___velfg_map_218_scal = (i_rel___velfg_map_218_scal + 1)
 covx1___velfg_map_218_scal = (dx1_0(i___velfg_map_218_scal + 1) * cov1_s_0(1) +  &
      dx1_0(i___velfg_map_218_scal) * cov1_s_0(2)) / (dx1_0(i___velfg_map_218_scal) +  &
      dx1_0(i___velfg_map_218_scal + 1))
 covy1___velfg_map_218_scal = (cov2_s_0(1) + cov2_s_0(2)) / 2.
 covz1___velfg_map_218_scal = (cov3_s_0(1) + cov3_s_0(2)) / 2.
 covc___velfg_map_218_scal = covx1___velfg_map_218_scal + covy1___velfg_map_218_scal +  &
      covz1___velfg_map_218_scal
 dfu1___velfg_map_218 = 2. * (-diu1_s_0(1) + diu1_s_0(2)) / (dx1_0(i___velfg_map_218_scal) +  &
      dx1_0(i___velfg_map_218_scal + 1)) + (-diu2_s_0(1) + diu2_s_0(2)) /  &
      dy1_0(j___velfg_map_218_scal) + (-diu3_s_0(1) + diu3_s_0(2)) / dzn_0(k___velfg_map_218_scal)
 df___velfg_map_218_scal = vn___velfg_map_218_scal * dfu1___velfg_map_218
 f_1 = (-covc___velfg_map_218_scal + df___velfg_map_218_scal)
 covx1___velfg_map_218_scal = (cov4_s_0(1) + cov4_s_0(2)) / 2.
 covy1___velfg_map_218_scal = (dy1_0(j___velfg_map_218_scal + 1) * cov5_s_0(1) +  &
      dy1_0(j___velfg_map_218_scal) * cov5_s_0(2)) / (dy1_0(j___velfg_map_218_scal) +  &
      dy1_0(j___velfg_map_218_scal + 1))
 covz1___velfg_map_218_scal = (cov6_s_0(1) + cov6_s_0(2)) / 2.
 covc___velfg_map_218_scal = covx1___velfg_map_218_scal + covy1___velfg_map_218_scal +  &
      covz1___velfg_map_218_scal
 dfv1___velfg_map_218 = (-diu4_s_0(1) + diu4_s_0(2)) / dx1_0(i___velfg_map_218_scal) + 2. *  &
      (-diu5_s_0(1) + diu5_s_0(2)) / (dy1_0(j___velfg_map_218_scal) +  &
      dy1_0(j___velfg_map_218_scal + 1)) + (-diu6_s_0(1) + diu6_s_0(2)) /  &
      dzn_0(k___velfg_map_218_scal)
 df___velfg_map_218_scal = vn___velfg_map_218_scal * dfv1___velfg_map_218
 g_1 = (-covc___velfg_map_218_scal + df___velfg_map_218_scal)
 if ((k___velfg_map_218_scal < (90 - 1))) then
 covx1___velfg_map_218_scal = (cov7_s_0(1) + cov7_s_0(2)) / 2.
 covy1___velfg_map_218_scal = (cov8_s_0(1) + cov8_s_0(2)) / 2.
 covz1___velfg_map_218_scal = (dzn_0(k___velfg_map_218_scal + 1) * cov9_s_0(1) +  &
      dzn_0(k___velfg_map_218_scal) * cov9_s_0(2)) / (dzn_0(k___velfg_map_218_scal) +  &
      dzn_0(k___velfg_map_218_scal + 1))
 covc___velfg_map_218_scal = covx1___velfg_map_218_scal + covy1___velfg_map_218_scal +  &
      covz1___velfg_map_218_scal
 dfw1___velfg_map_218 = (-diu7_s_0(1) + diu7_s_0(2)) / dx1_0(i___velfg_map_218_scal) +  &
      (-diu8_s_0(1) + diu8_s_0(2)) / dy1_0(j___velfg_map_218_scal) + (-diu9_s_0(1) + diu9_s_0(2))  &
      / dzs_0(k___velfg_map_218_scal)
 df___velfg_map_218_scal = vn___velfg_map_218_scal * dfw1___velfg_map_218
 h_1 = (-covc___velfg_map_218_scal + df___velfg_map_218_scal)
 end if
!      END inlined call to velfg_map_218_scal
 dfu1_1 = dfu1___velfg_map_218
 dfv1_1 = dfv1___velfg_map_218
 dfw1_1 = dfw1___velfg_map_218
end subroutine velfg_map_218

end module singleton_module_velfg_map_218


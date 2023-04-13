module singleton_module_velfg_map_218
contains

subroutine velfg_map_218_scal(dx1,cov1_i_j_k,cov1_ip1_j_k,cov2_i_j_k,cov2_i_jp1_k,cov3_i_j_k,cov3_i_j_kp1,diu1_i_j_k,diu1_ip1_j_k,diu2_i_j_k,diu2_i_jp1_k,dy1,diu3_i_j_k,diu3_i_j_kp1,dzn,dfu1_i_j_k,cov4_i_j_k,cov4_ip1_j_k,cov5_i_j_k,cov5_i_jp1_k,cov6_i_j_k,cov6_i_j_kp1,diu4_i_j_k,diu4_ip1_j_k,diu5_i_j_k,diu5_i_jp1_k,diu6_i_j_k,diu6_i_j_kp1,dfv1_i_j_k,cov7_i_j_k,cov7_ip1_j_k,cov8_i_j_k,cov8_i_jp1_k,cov9_i_j_k,cov9_i_j_kp1,diu7_i_j_k,diu7_ip1_j_k,diu8_i_j_k,diu8_i_jp1_k,diu9_i_j_k,diu9_i_j_kp1,dzs,dfw1_i_j_k,f_i_j_k,g_i_j_k,h_i_j_k)
      implicit none
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
 real, dimension((-1):(300+1)), intent(in) :: dx1
 real, intent(in) :: cov1_i_j_k
 real, intent(in) :: cov1_ip1_j_k
 real, intent(in) :: cov2_i_j_k
 real, intent(in) :: cov2_i_jp1_k
 real, intent(in) :: cov3_i_j_k
 real, intent(in) :: cov3_i_j_kp1
 real, intent(in) :: diu1_i_j_k
 real, intent(in) :: diu1_ip1_j_k
 real, intent(in) :: diu2_i_j_k
 real, intent(in) :: diu2_i_jp1_k
 real, dimension(0:(300+1)), intent(in) :: dy1
 real, intent(in) :: diu3_i_j_k
 real, intent(in) :: diu3_i_j_kp1
 real, dimension((-1):(90+2)), intent(in) :: dzn
 real, intent(in) :: cov4_i_j_k
 real, intent(in) :: cov4_ip1_j_k
 real, intent(in) :: cov5_i_j_k
 real, intent(in) :: cov5_i_jp1_k
 real, intent(in) :: cov6_i_j_k
 real, intent(in) :: cov6_i_j_kp1
 real, intent(in) :: diu4_i_j_k
 real, intent(in) :: diu4_ip1_j_k
 real, intent(in) :: diu5_i_j_k
 real, intent(in) :: diu5_i_jp1_k
 real, intent(in) :: diu6_i_j_k
 real, intent(in) :: diu6_i_j_kp1
 real, intent(in) :: cov7_i_j_k
 real, intent(in) :: cov7_ip1_j_k
 real, intent(in) :: cov8_i_j_k
 real, intent(in) :: cov8_i_jp1_k
 real, intent(in) :: cov9_i_j_k
 real, intent(in) :: cov9_i_j_kp1
 real, intent(in) :: diu7_i_j_k
 real, intent(in) :: diu7_ip1_j_k
 real, intent(in) :: diu8_i_j_k
 real, intent(in) :: diu8_i_jp1_k
 real, intent(in) :: diu9_i_j_k
 real, intent(in) :: diu9_i_j_kp1
 real, dimension((-1):(90+2)), intent(in) :: dzs
 real, intent(out) :: f_i_j_k
 real, intent(out) :: g_i_j_k
 real, intent(out) :: h_i_j_k
 real, intent(inout) :: dfu1_i_j_k
 real, intent(inout) :: dfv1_i_j_k
 real, intent(inout) :: dfw1_i_j_k
 integer, intent(in) :: global_id___velfg_map_218_scal
!       call get_global_id(global_id,0)
 k_range___velfg_map_218_scal = ((90 - 1) + 1)
 j_range___velfg_map_218_scal = ((300 - 1) + 1)
 i_range___velfg_map_218_scal = ((300 - 1) + 1)
 k_rel___velfg_map_218_scal = (global_id___velfg_map_218_scal / (j_range___velfg_map_218_scal * i_range___velfg_map_218_scal))
 k___velfg_map_218_scal = (k_rel___velfg_map_218_scal + 1)
 j_rel___velfg_map_218_scal = ((global_id___velfg_map_218_scal - (k_rel___velfg_map_218_scal * (j_range___velfg_map_218_scal * i_range___velfg_map_218_scal))) / i_range___velfg_map_218_scal)
 j___velfg_map_218_scal = (j_rel___velfg_map_218_scal + 1)
 i_rel___velfg_map_218_scal = ((global_id___velfg_map_218_scal - (k_rel___velfg_map_218_scal * (j_range___velfg_map_218_scal * i_range___velfg_map_218_scal))) - (j_rel___velfg_map_218_scal * i_range___velfg_map_218_scal))
 i___velfg_map_218_scal = (i_rel___velfg_map_218_scal + 1)
 covx1___velfg_map_218_scal = (dx1(i___velfg_map_218_scal + 1) * cov1_i_j_k + dx1(i___velfg_map_218_scal) * cov1_ip1_j_k) / (dx1(i___velfg_map_218_scal) + dx1(i___velfg_map_218_scal + 1))
 covy1___velfg_map_218_scal = (cov2_i_j_k + cov2_i_jp1_k) / 2.
 covz1___velfg_map_218_scal = (cov3_i_j_k + cov3_i_j_kp1) / 2.
 covc___velfg_map_218_scal = covx1___velfg_map_218_scal + covy1___velfg_map_218_scal + covz1___velfg_map_218_scal
 dfu1_i_j_k = 2. * (-diu1_i_j_k + diu1_ip1_j_k) / (dx1(i___velfg_map_218_scal) + dx1(i___velfg_map_218_scal + 1)) + (-diu2_i_j_k +        diu2_i_jp1_k) / dy1(j___velfg_map_218_scal) + (-diu3_i_j_k + diu3_i_j_kp1) / dzn(k___velfg_map_218_scal)
 df___velfg_map_218_scal = vn___velfg_map_218_scal * dfu1_i_j_k
 f_i_j_k = (-covc___velfg_map_218_scal + df___velfg_map_218_scal)
 covx1___velfg_map_218_scal = (cov4_i_j_k + cov4_ip1_j_k) / 2.
 covy1___velfg_map_218_scal = (dy1(j___velfg_map_218_scal + 1) * cov5_i_j_k + dy1(j___velfg_map_218_scal) * cov5_i_jp1_k) / (dy1(j___velfg_map_218_scal) + dy1(j___velfg_map_218_scal + 1))
 covz1___velfg_map_218_scal = (cov6_i_j_k + cov6_i_j_kp1) / 2.
 covc___velfg_map_218_scal = covx1___velfg_map_218_scal + covy1___velfg_map_218_scal + covz1___velfg_map_218_scal
 dfv1_i_j_k = (-diu4_i_j_k + diu4_ip1_j_k) / dx1(i___velfg_map_218_scal) + 2. * (-diu5_i_j_k + diu5_i_jp1_k) / (dy1(j___velfg_map_218_scal) +        dy1(j___velfg_map_218_scal + 1)) + (-diu6_i_j_k + diu6_i_j_kp1) / dzn(k___velfg_map_218_scal)
 df___velfg_map_218_scal = vn___velfg_map_218_scal * dfv1_i_j_k
 g_i_j_k = (-covc___velfg_map_218_scal + df___velfg_map_218_scal)
 if ((k___velfg_map_218_scal < (90 - 1))) then
 covx1___velfg_map_218_scal = (cov7_i_j_k + cov7_ip1_j_k) / 2.
 covy1___velfg_map_218_scal = (cov8_i_j_k + cov8_i_jp1_k) / 2.
 covz1___velfg_map_218_scal = (dzn(k___velfg_map_218_scal + 1) * cov9_i_j_k + dzn(k___velfg_map_218_scal) * cov9_i_j_kp1) / (dzn(k___velfg_map_218_scal) + dzn(k___velfg_map_218_scal + 1))
 covc___velfg_map_218_scal = covx1___velfg_map_218_scal + covy1___velfg_map_218_scal + covz1___velfg_map_218_scal
 dfw1_i_j_k = (-diu7_i_j_k + diu7_ip1_j_k) / dx1(i___velfg_map_218_scal) + (-diu8_i_j_k + diu8_i_jp1_k) / dy1(j___velfg_map_218_scal) +        (-diu9_i_j_k + diu9_i_j_kp1) / dzs(k___velfg_map_218_scal)
 df___velfg_map_218_scal = vn___velfg_map_218_scal * dfw1_i_j_k
 h_i_j_k = (-covc___velfg_map_218_scal + df___velfg_map_218_scal)
 end if
end subroutine velfg_map_218_scal
end module singleton_module_velfg_map_218

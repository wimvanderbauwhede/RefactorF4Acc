module singleton_module_velfg_map_133

contains

subroutine velfg_map_133_scal(th_ratio,dzn,u_i_vel2m1_j_vel2_k_vel2,u_i_vel2m1_j_vel2_k_vel2p1, &
      w_i_vel2_j_vel2m1_k_vel2,w_i_vel2m1_j_vel2_k_vel2,w_i_vel2_j_vel2_k_vel2,dx1, &
      nou7_i_vel2_j_vel2_k_vel2,diu7_i_vel2_j_vel2_k_vel2,v_i_vel2_j_vel2m1_k_vel2, &
      v_i_vel2_j_vel2m1_k_vel2p1,dy1,nou8_i_vel2_j_vel2_k_vel2,diu8_i_vel2_j_vel2_k_vel2, &
      cov7_i_vel2_j_vel2_k_vel2,cov8_i_vel2_j_vel2_k_vel2)
 integer, parameter :: ip=300
 integer, parameter :: jp=300
 integer, parameter :: kp=90
 integer, parameter :: im=300
 integer, parameter :: jm=300
 integer, parameter :: km=90
 integer, parameter :: ifbf=1
 integer, parameter :: ianime=1
 integer, parameter :: ical=0
 integer, parameter :: n0=1
 integer, parameter :: n1=10001
 integer, parameter :: nmax=20000
 real, parameter :: dt=0.2
 real, parameter :: ro=1.1763
 real, parameter :: vn=15.83 * 10. ** (-6.)
 real, parameter :: alpha=-10.
 real, parameter :: beta=-1.
 integer, parameter :: u0=0
 integer :: i_vel2
 integer :: j_vel2
 integer :: k_vel2
 integer :: k_vel2_range
 integer :: j_vel2_range
 integer :: i_vel2_range
 integer :: k_vel2_rel
 integer :: j_vel2_rel
 integer :: i_vel2_rel
 real, dimension((-1):(kp+2)), intent(in) :: dzn
 real, intent(In) :: u_i_vel2m1_j_vel2_k_vel2
 real, intent(In) :: u_i_vel2m1_j_vel2_k_vel2p1
 real, intent(In) :: w_i_vel2_j_vel2_k_vel2
 real, intent(In) :: w_i_vel2_j_vel2m1_k_vel2
 real, intent(In) :: w_i_vel2m1_j_vel2_k_vel2
 real, dimension((-1):(ip+1)), intent(in) :: dx1
 real, intent(In) :: v_i_vel2_j_vel2m1_k_vel2
 real, intent(In) :: v_i_vel2_j_vel2m1_k_vel2p1
 real, dimension(0:(jp+1)), intent(in) :: dy1
 real, intent(Out) :: cov7_i_vel2_j_vel2_k_vel2
 real, intent(Out) :: cov8_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: nou7_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu7_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: nou8_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu8_i_vel2_j_vel2_k_vel2
 integer, intent(in) :: th_idx
 real, dimension(1:ip), intent(in) :: th_ratio
!      call get_th_idx(th_idx,0)
 k_vel2_range = (((90 - 1) - 1) + 1)
 j_vel2_range = ((300 - 1) + 1)
 i_vel2_range = ((300 - 1) + 1)
 k_vel2_rel = (th_idx / (j_vel2_range * i_vel2_range))
 k_vel2 = (k_vel2_rel + 1)
 j_vel2_rel = ((th_idx - (k_vel2_rel * (j_vel2_range * i_vel2_range))) / i_vel2_range)
 j_vel2 = (j_vel2_rel + 1)
 i_vel2_rel = ((th_idx - (k_vel2_rel * (j_vel2_range * i_vel2_range))) - (j_vel2_rel *  &
      i_vel2_range))
 i_vel2 = (i_vel2_rel + 1)
 nou7_i_vel2_j_vel2_k_vel2 = (dzn(k_vel2 + 1) * u_i_vel2m1_j_vel2_k_vel2 + dzn(k_vel2) *  &
      u_i_vel2m1_j_vel2_k_vel2p1) / (dzn(k_vel2) + dzn(k_vel2 + 1))
 diu7_i_vel2_j_vel2_k_vel2 = 2. * (-w_i_vel2m1_j_vel2_k_vel2 + w_i_vel2_j_vel2_k_vel2) /  &
      (dx1(i_vel2 - 1) + dx1(i_vel2))
 cov7_i_vel2_j_vel2_k_vel2 = (nou7_i_vel2_j_vel2_k_vel2 - u0) * diu7_i_vel2_j_vel2_k_vel2
 nou8_i_vel2_j_vel2_k_vel2 = (dzn(k_vel2 + 1) * v_i_vel2_j_vel2m1_k_vel2 + dzn(k_vel2) *  &
      v_i_vel2_j_vel2m1_k_vel2p1) / (dzn(k_vel2) + dzn(k_vel2 + 1))
 diu8_i_vel2_j_vel2_k_vel2 = 2. * (-w_i_vel2_j_vel2m1_k_vel2 + w_i_vel2_j_vel2_k_vel2) /  &
      (dy1(j_vel2 - 1) + dy1(j_vel2))
 cov8_i_vel2_j_vel2_k_vel2 = nou8_i_vel2_j_vel2_k_vel2 * diu8_i_vel2_j_vel2_k_vel2 * th_ratio(1)
end subroutine velfg_map_133_scal

end module singleton_module_velfg_map_133


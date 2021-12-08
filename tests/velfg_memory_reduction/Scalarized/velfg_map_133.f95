module singleton_module_velfg_map_133

contains

subroutine velfg_map_133_scal(dzn,u_i_vel2m1_j_vel2_k_vel2,u_i_vel2m1_j_vel2_k_vel2p1, &
      w_i_vel2_j_vel2m1_k_vel2,w_i_vel2m1_j_vel2_k_vel2,w_i_vel2_j_vel2_k_vel2,dx1, &
      nou7_i_vel2_j_vel2_k_vel2,diu7_i_vel2_j_vel2_k_vel2,v_i_vel2_j_vel2m1_k_vel2, &
      v_i_vel2_j_vel2m1_k_vel2p1,dy1,nou8_i_vel2_j_vel2_k_vel2,diu8_i_vel2_j_vel2_k_vel2, &
      cov7_i_vel2_j_vel2_k_vel2,cov8_i_vel2_j_vel2_k_vel2)
 integer, parameter :: ip=150
 integer, parameter :: jp=150
 integer, parameter :: kp=90
 integer, parameter :: u0=0
 integer :: i_vel2
 integer :: j_vel2
 integer :: k_vel2
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
 integer :: global_id
 call get_global_id(global_id,0)
 j_vel2_range = ((150 - 1) + 1)
 i_vel2_range = ((150 - 1) + 1)
 k_vel2_rel = (global_id / (j_vel2_range * i_vel2_range))
 k_vel2 = (k_vel2_rel + 1)
 j_vel2_rel = ((global_id - (k_vel2_rel * (j_vel2_range * i_vel2_range))) / i_vel2_range)
 j_vel2 = (j_vel2_rel + 1)
 i_vel2_rel = ((global_id - (k_vel2_rel * (j_vel2_range * i_vel2_range))) - (j_vel2_rel *  &
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
 cov8_i_vel2_j_vel2_k_vel2 = nou8_i_vel2_j_vel2_k_vel2 * diu8_i_vel2_j_vel2_k_vel2
end subroutine velfg_map_133_scal

end module singleton_module_velfg_map_133


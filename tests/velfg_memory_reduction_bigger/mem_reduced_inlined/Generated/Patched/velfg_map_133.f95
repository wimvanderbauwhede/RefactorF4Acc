module singleton_module_velfg_map_133

contains

pure subroutine velfg_map_133_scal(global_id,dzn,u_i_vel2m1_j_vel2_k_vel2,u_i_vel2m1_j_vel2_k_vel2p1, &
      w_i_vel2_j_vel2m1_k_vel2,w_i_vel2m1_j_vel2_k_vel2,w_i_vel2_j_vel2_k_vel2,dx1, &
      nou7_i_vel2_j_vel2_k_vel2,diu7_i_vel2_j_vel2_k_vel2,v_i_vel2_j_vel2m1_k_vel2, &
      v_i_vel2_j_vel2m1_k_vel2p1,dy1,nou8_i_vel2_j_vel2_k_vel2,diu8_i_vel2_j_vel2_k_vel2, &
      cov7_i_vel2_j_vel2_k_vel2,cov8_i_vel2_j_vel2_k_vel2)
 integer, parameter :: u0=0
 real, dimension((-1):(90+2)), intent(in) :: dzn
 real, intent(In) :: u_i_vel2m1_j_vel2_k_vel2
 real, intent(In) :: u_i_vel2m1_j_vel2_k_vel2p1
 real, intent(In) :: w_i_vel2_j_vel2_k_vel2
 real, intent(In) :: w_i_vel2_j_vel2m1_k_vel2
 real, intent(In) :: w_i_vel2m1_j_vel2_k_vel2
 real, dimension((-1):(150+1)), intent(in) :: dx1
 real, intent(In) :: v_i_vel2_j_vel2m1_k_vel2
 real, intent(In) :: v_i_vel2_j_vel2m1_k_vel2p1
 real, dimension(0:(150+1)), intent(in) :: dy1
 real, intent(Out) :: cov7_i_vel2_j_vel2_k_vel2
 real, intent(Out) :: cov8_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: nou7_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu7_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: nou8_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu8_i_vel2_j_vel2_k_vel2
integer, intent(In) :: global_id
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


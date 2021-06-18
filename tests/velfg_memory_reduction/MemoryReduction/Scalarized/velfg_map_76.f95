module singleton_module_velfg_map_76

contains

subroutine velfg_map_76_scal(u_i_vel2_j_vel2_k_vel2m1,u_i_vel2_j_vel2m1_k_vel2, &
      u_i_vel2m1_j_vel2_k_vel2,u_i_vel2_j_vel2_k_vel2,u_i_vel2m1_j_vel2p1_k_vel2,dx1, &
      v_i_vel2_j_vel2_k_vel2m1,v_i_vel2_j_vel2m1_k_vel2,v_i_vel2p1_j_vel2m1_k_vel2, &
      v_i_vel2m1_j_vel2_k_vel2,v_i_vel2_j_vel2_k_vel2,dy1,w_i_vel2_j_vel2_k_vel2m1, &
      w_i_vel2p1_j_vel2_k_vel2m1,w_i_vel2_j_vel2p1_k_vel2m1,w_i_vel2_j_vel2_k_vel2,dzn, &
      nou1_i_vel2_j_vel2_k_vel2,diu1_i_vel2_j_vel2_k_vel2,nou5_i_vel2_j_vel2_k_vel2, &
      diu5_i_vel2_j_vel2_k_vel2,nou9_i_vel2_j_vel2_k_vel2,diu9_i_vel2_j_vel2_k_vel2, &
      nou2_i_vel2_j_vel2_k_vel2,diu2_i_vel2_j_vel2_k_vel2,dzs,nou3_i_vel2_j_vel2_k_vel2, &
      diu3_i_vel2_j_vel2_k_vel2,nou4_i_vel2_j_vel2_k_vel2,diu4_i_vel2_j_vel2_k_vel2, &
      nou6_i_vel2_j_vel2_k_vel2,diu6_i_vel2_j_vel2_k_vel2,cov1_i_vel2_j_vel2_k_vel2, &
      cov5_i_vel2_j_vel2_k_vel2,cov9_i_vel2_j_vel2_k_vel2,cov2_i_vel2_j_vel2_k_vel2, &
      cov3_i_vel2_j_vel2_k_vel2,cov4_i_vel2_j_vel2_k_vel2,cov6_i_vel2_j_vel2_k_vel2)
 integer, parameter :: u0=0
!    ! Local vars: i_vel2,j_vel2,k_vel2
 integer :: k_vel2
!    ! ParallelFortran: Synthesised loop variable decls
 integer :: j_vel2_range
 integer :: i_vel2_range
 integer :: k_vel2_rel
!  READ
 real, intent(In) :: u_i_vel2_j_vel2_k_vel2
 real, intent(In) :: u_i_vel2_j_vel2_k_vel2m1
 real, intent(In) :: u_i_vel2_j_vel2m1_k_vel2
 real, intent(In) :: u_i_vel2m1_j_vel2_k_vel2
 real, intent(In) :: u_i_vel2m1_j_vel2p1_k_vel2
 real, dimension((-1):(ip+1)), intent(in) :: dx1
 real, intent(In) :: v_i_vel2_j_vel2_k_vel2
 real, intent(In) :: v_i_vel2_j_vel2_k_vel2m1
 real, intent(In) :: v_i_vel2_j_vel2m1_k_vel2
 real, intent(In) :: v_i_vel2m1_j_vel2_k_vel2
 real, intent(In) :: v_i_vel2p1_j_vel2m1_k_vel2
 real, dimension(0:(jp+1)), intent(in) :: dy1
 real, intent(In) :: w_i_vel2_j_vel2_k_vel2
 real, intent(In) :: w_i_vel2_j_vel2_k_vel2m1
 real, intent(In) :: w_i_vel2_j_vel2p1_k_vel2m1
 real, intent(In) :: w_i_vel2p1_j_vel2_k_vel2m1
 real, dimension((-1):(kp+2)), intent(in) :: dzn
 real, dimension((-1):(kp+2)), intent(in) :: dzs
!  WRITTEN
 real, intent(Out) :: cov1_i_vel2_j_vel2_k_vel2
 real, intent(Out) :: cov5_i_vel2_j_vel2_k_vel2
 real, intent(Out) :: cov9_i_vel2_j_vel2_k_vel2
 real, intent(Out) :: cov2_i_vel2_j_vel2_k_vel2
 real, intent(Out) :: cov3_i_vel2_j_vel2_k_vel2
 real, intent(Out) :: cov4_i_vel2_j_vel2_k_vel2
 real, intent(Out) :: cov6_i_vel2_j_vel2_k_vel2
!  READ & WRITTEN
 real, intent(InOut) :: nou1_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu1_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: nou5_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu5_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: nou9_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu9_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: nou2_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu2_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: nou3_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu3_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: nou4_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu4_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: nou6_i_vel2_j_vel2_k_vel2
 real, intent(InOut) :: diu6_i_vel2_j_vel2_k_vel2
!  globalIdDeclaration
 integer :: global_id
!  globalIdInitialisation
 call get_global_id(global_id,0)
!  ptrAssignments_fseq
!    ! ParallelFortran: Synthesised loop variables
 j_vel2_range = ((150 - 1) + 1)
 i_vel2_range = ((150 - 1) + 1)
 k_vel2_rel = (global_id / (j_vel2_range * i_vel2_range))
 k_vel2 = (k_vel2_rel + 1)
!    ! ParallelFortran: Original code
 if ((k_vel2 < 90)) then
 nou1_i_vel2_j_vel2_k_vel2 = (u_i_vel2m1_j_vel2_k_vel2 + u_i_vel2_j_vel2_k_vel2) / 2.
 diu1_i_vel2_j_vel2_k_vel2 = (-u_i_vel2m1_j_vel2_k_vel2 + u_i_vel2_j_vel2_k_vel2) / dx1(i_vel2)
 nou5_i_vel2_j_vel2_k_vel2 = (v_i_vel2_j_vel2m1_k_vel2 + v_i_vel2_j_vel2_k_vel2) / 2.
 diu5_i_vel2_j_vel2_k_vel2 = (-v_i_vel2_j_vel2m1_k_vel2 + v_i_vel2_j_vel2_k_vel2) / dy1(j_vel2)
 nou9_i_vel2_j_vel2_k_vel2 = (w_i_vel2_j_vel2_k_vel2m1 + w_i_vel2_j_vel2_k_vel2) / 2.
 diu9_i_vel2_j_vel2_k_vel2 = (-w_i_vel2_j_vel2_k_vel2m1 + w_i_vel2_j_vel2_k_vel2) / dzn(k_vel2)
 cov1_i_vel2_j_vel2_k_vel2 = nou1_i_vel2_j_vel2_k_vel2 * diu1_i_vel2_j_vel2_k_vel2
 cov5_i_vel2_j_vel2_k_vel2 = nou5_i_vel2_j_vel2_k_vel2 * diu5_i_vel2_j_vel2_k_vel2
 cov9_i_vel2_j_vel2_k_vel2 = nou9_i_vel2_j_vel2_k_vel2 * diu9_i_vel2_j_vel2_k_vel2
 end if
 if ((k_vel2 < 90)) then
 nou2_i_vel2_j_vel2_k_vel2 = (dx1(i_vel2 + 1) * v_i_vel2_j_vel2m1_k_vel2 + dx1(i_vel2) *  &
      v_i_vel2p1_j_vel2m1_k_vel2) / (dx1(i_vel2) + dx1(i_vel2 + 1))
 diu2_i_vel2_j_vel2_k_vel2 = 2. * (-u_i_vel2_j_vel2m1_k_vel2 + u_i_vel2_j_vel2_k_vel2) /  &
      (dy1(j_vel2 - 1) + dy1(j_vel2))
 cov2_i_vel2_j_vel2_k_vel2 = nou2_i_vel2_j_vel2_k_vel2 * diu2_i_vel2_j_vel2_k_vel2
 end if
 nou3_i_vel2_j_vel2_k_vel2 = (dx1(i_vel2 + 1) * w_i_vel2_j_vel2_k_vel2m1 + dx1(i_vel2) *  &
      w_i_vel2p1_j_vel2_k_vel2m1) / (dx1(i_vel2) + dx1(i_vel2 + 1))
 diu3_i_vel2_j_vel2_k_vel2 = (-u_i_vel2_j_vel2_k_vel2m1 + u_i_vel2_j_vel2_k_vel2) / dzs(k_vel2 - 1)
 cov3_i_vel2_j_vel2_k_vel2 = nou3_i_vel2_j_vel2_k_vel2 * diu3_i_vel2_j_vel2_k_vel2
 if ((k_vel2 < 90)) then
 nou4_i_vel2_j_vel2_k_vel2 = (dy1(j_vel2 + 1) * u_i_vel2m1_j_vel2_k_vel2 + dy1(j_vel2) *  &
      u_i_vel2m1_j_vel2p1_k_vel2) / (dy1(j_vel2) + dy1(j_vel2 + 1))
 diu4_i_vel2_j_vel2_k_vel2 = 2. * (-v_i_vel2m1_j_vel2_k_vel2 + v_i_vel2_j_vel2_k_vel2) /  &
      (dx1(i_vel2 - 1) + dx1(i_vel2))
 cov4_i_vel2_j_vel2_k_vel2 = (nou4_i_vel2_j_vel2_k_vel2 - u0) * diu4_i_vel2_j_vel2_k_vel2
 end if
 nou6_i_vel2_j_vel2_k_vel2 = (dy1(j_vel2 + 1) * w_i_vel2_j_vel2_k_vel2m1 + dy1(j_vel2) *  &
      w_i_vel2_j_vel2p1_k_vel2m1) / (dy1(j_vel2) + dy1(j_vel2 + 1))
 diu6_i_vel2_j_vel2_k_vel2 = (-v_i_vel2_j_vel2_k_vel2m1 + v_i_vel2_j_vel2_k_vel2) / dzs(k_vel2 - 1)
 cov6_i_vel2_j_vel2_k_vel2 = nou6_i_vel2_j_vel2_k_vel2 * diu6_i_vel2_j_vel2_k_vel2
end subroutine velfg_map_76_scal

end module singleton_module_velfg_map_76


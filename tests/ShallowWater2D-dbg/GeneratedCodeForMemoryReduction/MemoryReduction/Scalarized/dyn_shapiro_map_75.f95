module singleton_module_dyn_shapiro_map_75

contains

subroutine dyn_shapiro_map_75_scal(un_j_km1,un_j_k,h_j_km1,h_jm1_k,h_j_k,h_jp1_k,h_j_kp1,vn_jm1_k, &
      vn_j_k,eta_j_k,dt,dx,dy,etan_j_k)
!    ! Local vars: j,k,hep___dyn,hen___dyn,hue___dyn,hwp___dyn,hwn___dyn,huw___dyn,hnp___dyn,hnn___dyn,hvn___dyn,hsp___dyn,hsn___dyn,hvs___dyn
 integer :: j
 integer :: k
 real :: hep___dyn
 real :: hen___dyn
 real :: hue___dyn
 real :: hwp___dyn
 real :: hwn___dyn
 real :: huw___dyn
 real :: hnp___dyn
 real :: hnn___dyn
 real :: hvn___dyn
 real :: hsp___dyn
 real :: hsn___dyn
 real :: hvs___dyn
!    ! ParallelFortran: Synthesised loop variable decls
!  READ
 real, intent(In) :: un_j_k
 real, intent(In) :: un_j_km1
 real, intent(In) :: h_j_k
 real, intent(In) :: h_j_km1
 real, intent(In) :: h_j_kp1
 real, intent(In) :: h_jm1_k
 real, intent(In) :: h_jp1_k
 real, intent(In) :: vn_j_k
 real, intent(In) :: vn_jm1_k
 real, intent(In) :: eta_j_k
 real, intent(in) :: dt
 real, intent(in) :: dx
 real, intent(in) :: dy
!  WRITTEN
 real, intent(Out) :: etan_j_k
!  READ & WRITTEN
!  globalIdDeclaration
!  globalIdInitialisation
!  ptrAssignments_fseq
!    ! ParallelFortran: Synthesised loop variables
!    ! ParallelFortran: Original code
 hep___dyn = 0.5 * (un_j_k + abs(un_j_k)) * h_j_k
 hen___dyn = 0.5 * (un_j_k - abs(un_j_k)) * h_j_kp1
 hue___dyn = hep___dyn + hen___dyn
 hwp___dyn = 0.5 * (un_j_km1 + abs(un_j_km1)) * h_j_km1
 hwn___dyn = 0.5 * (un_j_km1 - abs(un_j_km1)) * h_j_k
 huw___dyn = hwp___dyn + hwn___dyn
 hnp___dyn = 0.5 * (vn_j_k + abs(vn_j_k)) * h_j_k
 hnn___dyn = 0.5 * (vn_j_k - abs(vn_j_k)) * h_jp1_k
 hvn___dyn = hnp___dyn + hnn___dyn
 hsp___dyn = 0.5 * (vn_jm1_k + abs(vn_jm1_k)) * h_jm1_k
 hsn___dyn = 0.5 * (vn_jm1_k - abs(vn_jm1_k)) * h_j_k
 hvs___dyn = hsp___dyn + hsn___dyn
 etan_j_k = eta_j_k - dt * (hue___dyn - huw___dyn) / dx - dt * (hvn___dyn - hvs___dyn) / dy
end subroutine dyn_shapiro_map_75_scal

end module singleton_module_dyn_shapiro_map_75


module singleton_module_dyn_shapiro_map_49

contains

subroutine dyn_shapiro_map_49_scal(eta_j_k,eta_jp1_k,eta_j_kp1,du___dyn_j_k,dv___dyn_j_k)
!    ! Local vars: j,k
 integer :: j
 integer :: k
!    ! ParallelFortran: Synthesised loop variable decls
!  READ
 real, intent(In) :: eta_j_k
 real, intent(In) :: eta_j_kp1
 real, intent(In) :: eta_jp1_k
!    ! real :: dt
!    ! real :: g
!    ! real :: dx
!    ! real :: dy
 real, parameter :: dt=1.0
 real, parameter :: g=1.0
 real, parameter :: dx=1.0
 real, parameter :: dy=1.0
!  WRITTEN
 real, intent(Out) :: du___dyn_j_k
 real, intent(Out) :: dv___dyn_j_k
!  READ & WRITTEN
!  globalIdDeclaration
!  globalIdInitialisation
!  ptrAssignments_fseq
!    ! ParallelFortran: Synthesised loop variables
!    ! ParallelFortran: Original code
 du___dyn_j_k = -dt * g * (eta_j_kp1 - eta_j_k) / dx
 dv___dyn_j_k = -dt * g * (eta_jp1_k - eta_j_k) / dy
end subroutine dyn_shapiro_map_49_scal

end module singleton_module_dyn_shapiro_map_49


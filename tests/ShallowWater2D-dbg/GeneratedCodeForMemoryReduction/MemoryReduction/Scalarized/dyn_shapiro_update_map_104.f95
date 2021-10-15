module singleton_module_dyn_shapiro_update_map_104

contains

subroutine dyn_shapiro_update_map_104_scal(hzero_j_k,eta_j_k,h_j_k)
!    ! Local vars: j,k
 integer :: j
 integer :: k
!    ! ParallelFortran: Synthesised loop variable decls
!  READ
 real, intent(In) :: hzero_j_k
 real, intent(In) :: eta_j_k
!  WRITTEN
 real, intent(Out) :: h_j_k
!  READ & WRITTEN
!  globalIdDeclaration
!  globalIdInitialisation
!  ptrAssignments_fseq
!    ! ParallelFortran: Synthesised loop variables
!    ! ParallelFortran: Original code
 h_j_k = hzero_j_k + eta_j_k
end subroutine dyn_shapiro_update_map_104_scal

end module singleton_module_dyn_shapiro_update_map_104


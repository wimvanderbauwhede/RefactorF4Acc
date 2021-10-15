module singleton_module_dyn_shapiro_update_map_92

contains

subroutine dyn_shapiro_update_map_92_scal(wet_j_km1,wet_jm1_k,wet_j_k,wet_jp1_k,wet_j_kp1,eps, &
      etan_j_km1,etan_jm1_k,etan_j_k,etan_jp1_k,etan_j_kp1,eta_j_k)
!    ! Local vars: j,k,term1___shapiro,term2___shapiro,term3___shapiro
 integer :: j
 integer :: k
 real :: term1___shapiro
 real :: term2___shapiro
 real :: term3___shapiro
!    ! ParallelFortran: Synthesised loop variable decls
!  READ
 integer, intent(In) :: wet_j_k
 integer, intent(In) :: wet_j_km1
 integer, intent(In) :: wet_j_kp1
 integer, intent(In) :: wet_jm1_k
 integer, intent(In) :: wet_jp1_k
 real, intent(In) :: etan_j_k
 real, intent(In) :: etan_j_km1
 real, intent(In) :: etan_j_kp1
 real, intent(In) :: etan_jm1_k
 real, intent(In) :: etan_jp1_k
 real, intent(in) :: eps
!  WRITTEN
 real, intent(Out) :: eta_j_k
!  READ & WRITTEN
!  globalIdDeclaration
!  globalIdInitialisation
!  ptrAssignments_fseq
!    ! ParallelFortran: Synthesised loop variables
!    ! ParallelFortran: Original code
 if (wet_j_k == 1) then
 term1___shapiro = (1.0 - 0.25 * eps * (wet_j_kp1 + wet_j_km1 + wet_jp1_k + wet_jm1_k)) * etan_j_k
 term2___shapiro = 0.25 * eps * (wet_j_kp1 * etan_j_kp1 + wet_j_km1 * etan_j_km1)
 term3___shapiro = 0.25 * eps * (wet_jp1_k * etan_jp1_k + wet_jm1_k * etan_jm1_k)
 eta_j_k = term1___shapiro + term2___shapiro + term3___shapiro
else
 eta_j_k = etan_j_k
end if
end subroutine dyn_shapiro_update_map_92_scal

end module singleton_module_dyn_shapiro_update_map_92


module singleton_module_shapiro_map_24

contains

subroutine shapiro_map_24_scal(wet_j_km1,wet_jm1_k,wet_j_k,wet_jp1_k,wet_j_kp1,eps,etan_j_km1, &
      etan_jm1_k,etan_j_k,etan_jp1_k,etan_j_kp1,eta_j_k,etan_avg)
!integer, dimension(8), intent(in) :: test_1
          parameter(nx=500)
          parameter(ny=500)
          parameter(alpha=1e-9)
    ! local vars: j,k,term1,term2,term3
    real :: term1
    real :: term2
    real :: term3
    ! parallelfortran: synthesised loop variable decls
    integer :: j_range
! READ
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
    real, intent(In) :: eps
    real, intent(In) :: etan_avg
! WRITTEN
! READ & WRITTEN
    real, intent(InOut) :: eta_j_k
! globalIdDeclaration
! globalIdInitialisation
! ptrAssignments_fseq
    ! parallelfortran: synthesised loop variables
    j_range = ((500 - 1) + 1)
    ! parallelfortran: original code
    if (wet_j_k == 1) then
  term1 = (1.0 - 0.25 * eps * (wet_j_kp1 + wet_j_km1 + wet_jp1_k + wet_jm1_k)) * etan_j_k
  term2 = 0.25 * eps * (wet_j_kp1 * etan_j_kp1 + wet_j_km1 * etan_j_km1)
  term3 = 0.25 * eps * (wet_jp1_k * etan_jp1_k + wet_jm1_k * etan_jm1_k)
  eta_j_k = term1 + term2 + term3
else
  eta_j_k = etan_j_k
end if
  eta_j_k = (1 - alpha) * eta_j_k + alpha * etan_avg
end subroutine shapiro_map_24_scal

end module singleton_module_shapiro_map_24


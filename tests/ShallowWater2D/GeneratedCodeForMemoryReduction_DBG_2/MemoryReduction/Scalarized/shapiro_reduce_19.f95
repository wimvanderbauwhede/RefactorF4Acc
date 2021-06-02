module singleton_module_shapiro_reduce_19

contains

subroutine shapiro_reduce_19_scal(acc,etan_j_k,etan_avg)
    parameter(nx=500)
    parameter(ny=500)
    parameter(alpha=1e-9)
    ! local vars: j,k
    integer  :: j
    integer  :: k
    ! parallelfortran: synthesised loop variable decls
    integer :: j_range
    integer :: k_range
    integer :: j_rel
    integer :: k_rel
! READ
    real, intent(In) :: etan_j_k
! WRITTEN
! READ & WRITTEN
    real, intent(inout) :: etan_avg
    real, intent(in) :: acc
    ! real, intent(out) :: test_temp
    ! globaliddeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq
    ! parallelfortran: synthesised loop variables
    j_range = ((500 - 1) + 1)
    k_range = ((500 - 1) + 1)
    j_rel = (global_id / k_range)
    j = (j_rel + 1)
    k_rel = (global_id - (j_rel * k_range))
    k = (k_rel + 1)
    ! parallelfortran: original code
    etan_avg = etan_avg + etan_j_k / (nx * ny)
    etan_avg = etan_avg / acc
! test_temp = 
end subroutine shapiro_reduce_19_scal

end module singleton_module_shapiro_reduce_19


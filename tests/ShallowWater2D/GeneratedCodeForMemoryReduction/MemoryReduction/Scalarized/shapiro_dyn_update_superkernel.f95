module singleton_module_shapiro_dyn_update_superkernel

contains

subroutine shapiro_dyn_update_superkernel(etan,wet,eps,eta,etan_avg,state_ptr)
!use module_shapiro_dyn_update_superkernel_init
! parameters
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(inout) :: eta
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: etan
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: etan
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: etan
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: etan
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: etan
    integer :: global_id
    integer :: j
    integer :: j_rel
    integer :: k
    integer :: k_range
    integer :: k_rel
    integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
    integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
    integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
    integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
    integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
  parameter(nx=500)
  parameter(ny=500)
  real, dimension(0:(ny+1),0:(nx+1)), intent(inout) :: etan
  integer, dimension(0:(ny+1),0:(nx+1)), intent(inout) :: wet
  real, intent(in) :: eps
  real, intent(in) :: etan_avg
  real, dimension(0:(ny+1),0:(nx+1)), intent(inout) :: eta
  parameter(st_shapiro_reduce_19=0)
  parameter(st_shapiro_map_24=1)
  integer :: state
  integer, dimension(1:1), intent(in) :: state_ptr
  state = state_ptr(1) 
! SUPERKERNEL BODY
  select case(state)
    case (st_shapiro_reduce_19)
call shapiro_reduce_19(etan_j_k,etan_avg)

    case (st_shapiro_map_24)
    call get_global_id(global_id,0)
    k_range = ((500 - 1) + 1)
    j_rel = (global_id / k_range)
    j = (j_rel + 1)
    k_rel = (global_id - (j_rel * k_range))
    k = (k_rel + 1)
call shapiro_map_24(wet_j_km1,wet_jm1_k,wet_j_k,wet_jp1_k,wet_j_kp1,eps,etan_j_km1,etan_jm1_k, &
      etan_j_k,etan_jp1_k,etan_j_kp1,eta_j_k,etan_avg)
  end select
end subroutine shapiro_dyn_update_superkernel

end module singleton_module_shapiro_dyn_update_superkernel


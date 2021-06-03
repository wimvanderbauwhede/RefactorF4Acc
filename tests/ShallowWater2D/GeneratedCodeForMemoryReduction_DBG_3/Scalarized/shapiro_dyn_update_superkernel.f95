module singleton_module_shapiro_dyn_update_superkernel

contains

subroutine shapiro_dyn_update_superkernel(wet,eta,u,v,un,h,vn,hzero,state_ptr) 
!use module_shapiro_dyn_update_superkernel_init
! parameters
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: eta
    integer :: global_id
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(out) :: h
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: hzero
    integer :: j
    integer :: j_rel
    integer :: k
    integer :: k_range
    integer :: k_rel
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(out) :: u
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: un
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(out) :: v
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: vn
    integer, dimension(0:(ny + 1),0:(nx + 1)), intent(out) :: wet
  parameter(nx=500)
  parameter(ny=500)
  real, dimension(0:(ny+1),0:(nx+1)), intent(in) :: eta
  ! real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: etan
  real, dimension(0:(ny+1),0:(nx+1)), intent(out) :: h
  real, dimension(0:(ny+1),0:(nx+1)), intent(in) :: hzero
  real, dimension(0:(ny+1),0:(nx+1)), intent(out) :: u
  real, dimension(0:(ny+1),0:(nx+1)), intent(in) :: un
  real, dimension(0:(ny+1),0:(nx+1)), intent(out) :: v
  real, dimension(0:(ny+1),0:(nx+1)), intent(in) :: vn
  integer, dimension(0:(ny+1),0:(nx+1)), intent(out) :: wet
  ! real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: du
  ! real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: dv
  ! real, intent(in) :: hmin
  ! real, intent(in) :: duu
  ! real, intent(in) :: dx
  ! real, intent(in) :: dy
  ! real, intent(in) :: eps
  ! real, intent(in) :: dt
  ! real, intent(in) :: g
  !integer, dimension(8,8) :: test !$acc memspace local
  integer :: state
  integer, dimension(1:1), intent(In) :: state_ptr
  parameter(st_shapiro_map_24=1)
  parameter(st_dyn_map_39=2)
  parameter(st_update_map_24=3)
  state = state_ptr(1) 
! SUPERKERNEL BODY
  select case(state)
    ! case (st_shapiro_map_24)
    !   call shapiro_map_24(wet,etan,eta)
    ! case (st_dyn_map_39)
    !   call dyn_map_39(eta,u,wet,v,un,h,vn,etan)
    case (st_update_map_24)
    call get_global_id(global_id,0)
    k_range = (((500 + 1) - 0) + 1)
    j_rel = (global_id / k_range)
    j = (j_rel + 0)
    k_rel = (global_id - (j_rel * k_range))
    k = (k_rel + 0)
call update_map_24(hzero_j_k,eta_j_k,h_j_k,un_j_k,vn_j_k,wet_j_k,u_j_k,v_j_k)

  end select
end subroutine shapiro_dyn_update_superkernel

end module singleton_module_shapiro_dyn_update_superkernel


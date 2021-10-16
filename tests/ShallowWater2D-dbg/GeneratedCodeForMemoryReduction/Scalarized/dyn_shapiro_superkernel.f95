module singleton_module_dyn_shapiro_superkernel

contains

 subroutine dyn_shapiro_superkernel_scal(eta,u,wet,v,un,vn,state_ptr)
!  use module_dyn_shapiro_superkernel_init
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: du___dyn
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: dv___dyn
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: eta
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: eta
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: eta
 integer :: global_id
 integer :: j
 integer :: j_rel
 integer :: k
 integer :: k_range
 integer :: k_rel
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: u
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(out) :: un
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: v
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(out) :: vn
 integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
 integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
 integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
 real, dimension(0:(ny+1),0:(nx+1)), intent(in) :: eta
!  ! real, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: etann
 real, dimension(0:(ny+1),0:(nx+1)), intent(in) :: u
 real, dimension(0:(ny + 1),0:(nx + 1)):: du___dyn
 integer, dimension(0:(ny+1),0:(nx+1)), intent(in) :: wet
 real, dimension(0:(ny+1),0:(nx+1)), intent(in) :: v
 real, dimension(0:(ny + 1),0:(nx + 1)) :: dv___dyn
 real, dimension(0:(ny+1),0:(nx+1)), intent(out) :: un
 real, dimension(0:(ny+1),0:(nx+1)), intent(out) :: vn
 integer :: state
 integer, intent(In) :: state_ptr
 integer, parameter :: st_dyn_shapiro_map_49=0
 integer, parameter :: st_dyn_shapiro_map_55=1
 state = state_ptr 
!  SUPERKERNEL BODY
 select case(state)
 case (st_dyn_shapiro_map_49)
 call get_global_id(global_id,0)
 k_range = ((500 - 1) + 1)
 j_rel = (global_id / k_range)
 j = (j_rel + 1)
 k_rel = (global_id - (j_rel * k_range))
 k = (k_rel + 1)
call dyn_shapiro_map_49(eta_j_k,eta_jp1_k,eta_j_kp1,du___dyn_j_k,dv___dyn_j_k) 
!      ! call dyn_shapiro_map_49(dt,g,eta,dx,dy,du___dyn,dv___dyn)
 case (st_dyn_shapiro_map_55)
 call get_global_id(global_id,0)
 k_range = ((500 - 1) + 1)
 j_rel = (global_id / k_range)
 j = (j_rel + 1)
 k_rel = (global_id - (j_rel * k_range))
 k = (k_rel + 1)
call dyn_shapiro_map_55(u_j_k,du___dyn_j_k,wet_j_k,wet_jp1_k,wet_j_kp1,v_j_k,dv___dyn_j_k,un_j_k, &
      vn_j_k)
!    ! case (ST_DYN_SHAPIRO_MAP_75)
!    !   call dyn_shapiro_map_75(un,h,vn,eta,etan)
!      ! call dyn_shapiro_map_75(un,h,vn,eta,dt,dx,dy,etan)
!     case (ST_DYN_SHAPIRO_MAP_92)
!       call dyn_shapiro_map_92(wet,eps,etan,etann)
 end select
end subroutine dyn_shapiro_superkernel

end module singleton_module_dyn_shapiro_superkernel


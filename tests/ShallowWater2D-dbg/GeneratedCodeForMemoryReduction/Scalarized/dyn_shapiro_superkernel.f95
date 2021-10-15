module singleton_module_dyn_shapiro_superkernel

contains

subroutine dyn_shapiro_superkernel_scal(dt,g,eta,dx,dy,u,wet,v,un,vn,h,etann,eps,state_ptr)
!  use module_dyn_shapiro_superkernel_init
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: du___dyn
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: dv___dyn
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: eta
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: eta
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: eta
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: etan
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: etan
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: etan
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: etan
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: etan
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(out) :: etann
 integer :: global_id
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: h
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: h
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: h
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: h
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: h
 integer :: j
 integer :: j_rel
 integer :: k
 integer :: k_range
 integer :: k_rel
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: u
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: un
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: un
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: v
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: vn
 real, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: vn
 integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
 integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
 integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
 integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
 integer, dimension(0:(ny + 1),0:(nx + 1)), intent(in) :: wet
 real, intent(in) :: dt
 real, intent(in) :: g
 real, dimension(0:(ny+1),0:(nx+1)), intent(in) :: eta
 real, dimension(0:(ny+1),0:(nx+1)), intent(out) :: etann
 real, intent(in) :: dx
 real, intent(in) :: dy
 real, dimension(0:(ny+1),0:(nx+1)), intent(in) :: u
 real, dimension(0:(ny + 1),0:(nx + 1)):: du___dyn
 integer, dimension(0:(ny+1),0:(nx+1)), intent(in) :: wet
 real, dimension(0:(ny+1),0:(nx+1)), intent(in) :: v
 real, dimension(0:(ny + 1),0:(nx + 1)) :: dv___dyn
 real, dimension(0:(ny+1),0:(nx+1)), intent(out) :: un
 real, dimension(0:(ny+1),0:(nx+1)), intent(in) :: h
 real, dimension(0:(ny+1),0:(nx+1)), intent(out) :: vn
 real, intent(in) :: eps
 real, dimension(0:(ny + 1),0:(nx + 1)) :: etan
 integer :: state
 integer, intent(In) :: state_ptr
 integer, parameter :: st_dyn_shapiro_map_49=0
 integer, parameter :: st_dyn_shapiro_map_55=1
 integer, parameter :: st_dyn_shapiro_map_75=2
 integer, parameter :: st_dyn_shapiro_map_92=3
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
call dyn_shapiro_map_49(dt,g,eta_j_k,eta_jp1_k,eta_j_kp1,dx,dy,du___dyn_j_k,dv___dyn_j_k) 
 case (st_dyn_shapiro_map_55)
 call get_global_id(global_id,0)
 k_range = ((500 - 1) + 1)
 j_rel = (global_id / k_range)
 j = (j_rel + 1)
 k_rel = (global_id - (j_rel * k_range))
 k = (k_rel + 1)
call dyn_shapiro_map_55(u_j_k,du___dyn_j_k,wet_j_k,wet_jp1_k,wet_j_kp1,v_j_k,dv___dyn_j_k,un_j_k, &
      vn_j_k)
 case (st_dyn_shapiro_map_75)
 call get_global_id(global_id,0)
 k_range = ((500 - 1) + 1)
 j_rel = (global_id / k_range)
 j = (j_rel + 1)
 k_rel = (global_id - (j_rel * k_range))
 k = (k_rel + 1)
call dyn_shapiro_map_75(un_j_km1,un_j_k,h_j_km1,h_jm1_k,h_j_k,h_jp1_k,h_j_kp1,vn_jm1_k,vn_j_k, &
      eta_j_k,dt,dx,dy,etan_j_k)
 case (st_dyn_shapiro_map_92)
 call get_global_id(global_id,0)
 k_range = ((500 - 1) + 1)
 j_rel = (global_id / k_range)
 j = (j_rel + 1)
 k_rel = (global_id - (j_rel * k_range))
 k = (k_rel + 1)
call dyn_shapiro_map_92(wet_j_km1,wet_jm1_k,wet_j_k,wet_jp1_k,wet_j_kp1,eps,etan_j_km1,etan_jm1_k, &
      etan_j_k,etan_jp1_k,etan_j_kp1,etann_j_k)
 end select
end subroutine dyn_shapiro_superkernel

end module singleton_module_dyn_shapiro_superkernel


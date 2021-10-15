module module_dyn_shapiro_superkernel


    contains


subroutine dyn_shapiro_map_49(dt,g,eta,dx,dy,du___dyn,dv___dyn)

    integer, parameter :: nx=500
    integer, parameter :: ny=500
          real, parameter :: alpha=1e-9
    ! Local vars: j,k
    integer :: j
    integer :: k
    ! ParallelFortran: Synthesised loop variable decls
    integer :: j_range
    integer :: k_range
    integer :: j_rel
    integer :: k_rel
! READ
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: eta
    real :: dt
    real :: g
    real :: dx
    real :: dy
! WRITTEN
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: du___dyn
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: dv___dyn
! READ & WRITTEN
! globalIdDeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq

    ! ParallelFortran: Synthesised loop variables
    j_range = ((500 - 1) + 1)
    k_range = ((500 - 1) + 1)
    j_rel = (global_id / k_range)
    j = (j_rel + 1)
    k_rel = (global_id - (j_rel * k_range))
    k = (k_rel + 1)


    ! ParallelFortran: Original code
  du___dyn(j,k) = -dt*g*(eta(j,k+1)-eta(j,k))/dx
  dv___dyn(j,k) = -dt*g*(eta(j+1,k)-eta(j,k))/dy

end subroutine dyn_shapiro_map_49


subroutine dyn_shapiro_map_55(u,du___dyn,wet,v,dv___dyn,un,vn)

    integer, parameter :: nx=500
    integer, parameter :: ny=500
          real, parameter :: alpha=1e-9
    ! Local vars: j,k,uu___dyn,vv___dyn,dvv___dyn
    integer :: j
    integer :: k
    real :: uu___dyn
    real :: vv___dyn
    real :: dvv___dyn
    ! ParallelFortran: Synthesised loop variable decls
    integer :: j_range
    integer :: k_range
    integer :: j_rel
    integer :: k_rel
! READ
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: u
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: du___dyn
    integer, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: wet
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: v
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: dv___dyn
    real :: duu___dyn
! WRITTEN
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: un
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: vn
! READ & WRITTEN
! globalIdDeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq

    ! ParallelFortran: Synthesised loop variables
    j_range = ((500 - 1) + 1)
    k_range = ((500 - 1) + 1)
    j_rel = (global_id / k_range)
    j = (j_rel + 1)
    k_rel = (global_id - (j_rel * k_range))
    k = (k_rel + 1)


    ! ParallelFortran: Original code
un(j,k) = 0.0
uu___dyn = u(j,k)
duu___dyn = du___dyn(j,k)
if(wet(j,k)==1) then
  if((wet(j,k+1)==1) .or. (duu___dyn>0.0)) un(j,k) = uu___dyn+duu___dyn
else
  if((wet(j,k+1)==1) .and. (duu___dyn<0.0)) un(j,k) = uu___dyn+duu___dyn
end if
vv___dyn = v(j,k)
dvv___dyn = dv___dyn(j,k)
vn(j,k) = 0.0
if(wet(j,k)==1) then
  if((wet(j+1,k)==1) .or. (dv___dyn(j,k)>0.0)) vn(j,k) = vv___dyn+dvv___dyn
else
  if((wet(j+1,k)==1) .and. (dv___dyn(j,k)<0.0)) vn(j,k) = vv___dyn+dvv___dyn
end if

end subroutine dyn_shapiro_map_55


subroutine dyn_shapiro_map_75(un,h,vn,eta,dt,dx,dy,etan)

    integer, parameter :: nx=500
    integer, parameter :: ny=500
          real, parameter :: alpha=1e-9
    ! Local vars: j,k,hep___dyn,hen___dyn,hue___dyn,hwp___dyn,hwn___dyn,huw___dyn,hnp___dyn,hnn___dyn,hvn___dyn,hsp___dyn,hsn___dyn,hvs___dyn
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
    ! ParallelFortran: Synthesised loop variable decls
    integer :: j_range
    integer :: k_range
    integer :: j_rel
    integer :: k_rel
! READ
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: un
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: h
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: vn
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: eta
    real :: dt
    real :: dx
    real :: dy
! WRITTEN
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: etan
! READ & WRITTEN
! globalIdDeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq

    ! ParallelFortran: Synthesised loop variables
    j_range = ((500 - 1) + 1)
    k_range = ((500 - 1) + 1)
    j_rel = (global_id / k_range)
    j = (j_rel + 1)
    k_rel = (global_id - (j_rel * k_range))
    k = (k_rel + 1)


    ! ParallelFortran: Original code
  hep___dyn = 0.5*(un(j,k)+abs(un(j,k)))*h(j,k)
  hen___dyn = 0.5*(un(j,k)-abs(un(j,k)))*h(j,k+1)
  hue___dyn = hep___dyn+hen___dyn
  hwp___dyn = 0.5*(un(j,k-1)+abs(un(j,k-1)))*h(j,k-1)
  hwn___dyn = 0.5*(un(j,k-1)-abs(un(j,k-1)))*h(j,k)
  huw___dyn = hwp___dyn+hwn___dyn
  hnp___dyn = 0.5*(vn(j,k)+abs(vn(j,k)))*h(j,k)
  hnn___dyn = 0.5*(vn(j,k)-abs(vn(j,k)))*h(j+1,k)
  hvn___dyn = hnp___dyn+hnn___dyn
  hsp___dyn = 0.5*(vn(j-1,k)+abs(vn(j-1,k)))*h(j-1,k)
  hsn___dyn = 0.5*(vn(j-1,k)-abs(vn(j-1,k)))*h(j,k)
  hvs___dyn = hsp___dyn+hsn___dyn
  etan(j,k) = eta(j,k)-dt*(hue___dyn-huw___dyn)/dx-dt*(hvn___dyn-hvs___dyn)/dy

end subroutine dyn_shapiro_map_75


subroutine dyn_shapiro_map_92(wet,eps,etan,etann)

    integer, parameter :: nx=500
    integer, parameter :: ny=500
          real, parameter :: alpha=1e-9
    ! Local vars: j,k,term1___shapiro,term2___shapiro,term3___shapiro
    integer :: j
    integer :: k
    real :: term1___shapiro
    real :: term2___shapiro
    real :: term3___shapiro
    ! ParallelFortran: Synthesised loop variable decls
    integer :: j_range
    integer :: k_range
    integer :: j_rel
    integer :: k_rel
! READ
    integer, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: wet
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: etan
    real :: eps
! WRITTEN
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: etann
! READ & WRITTEN
! globalIdDeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq

    ! ParallelFortran: Synthesised loop variables
    j_range = ((500 - 1) + 1)
    k_range = ((500 - 1) + 1)
    j_rel = (global_id / k_range)
    j = (j_rel + 1)
    k_rel = (global_id - (j_rel * k_range))
    k = (k_rel + 1)


    ! ParallelFortran: Original code
if(wet(j,k)==1)then
  term1___shapiro = (1.0-0.25*eps*(wet(j,k+1)+wet(j,k-1)+ wet(j+1,k)+wet(j-1,k)))*etan(j,k)
  term2___shapiro = 0.25*eps*(wet(j,k+1)*etan(j,k+1)+wet(j,k-1)*etan(j,k-1))
  term3___shapiro = 0.25*eps*(wet(j+1,k)*etan(j+1,k)+wet(j-1,k)*etan(j-1,k))
  etann(j,k) = term1___shapiro+term2___shapiro+term3___shapiro
else
  etann(j,k) = etan(j,k)
end if

end subroutine dyn_shapiro_map_92


subroutine dyn_shapiro_superkernel(dt,g,eta,dx,dy,u,wet,v,un,vn,h,etann,eps,state_ptr)
! use module_dyn_shapiro_superkernel_init
  real, intent(In) :: dt
  real, intent(In) :: g
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: eta
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: etann
  real, intent(In) :: dx
  real, intent(In) :: dy
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: u
  real, dimension(0:(ny + 1),0:(nx + 1)):: du___dyn
  integer, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: wet
  
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: v
  real, dimension(0:(ny + 1),0:(nx + 1)) :: dv___dyn
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: un
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: h
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: vn
  real, intent(In) :: eps
  real, dimension(0:(ny + 1),0:(nx + 1)) :: etan

  integer :: state
  integer :: state_ptr
integer, parameter :: ST_DYN_SHAPIRO_MAP_49 = 0 !  dyn_shapiro_map_49
integer, parameter :: ST_DYN_SHAPIRO_MAP_55 = 1 !  dyn_shapiro_map_55
integer, parameter :: ST_DYN_SHAPIRO_MAP_75 = 2 !  dyn_shapiro_map_75
integer, parameter :: ST_DYN_SHAPIRO_MAP_92 = 3 !  dyn_shapiro_map_92
  state = state_ptr ! state 
! SUPERKERNEL BODY
  select case(state)
    case (ST_DYN_SHAPIRO_MAP_49)
      call dyn_shapiro_map_49(dt,g,eta,dx,dy,du___dyn,dv___dyn)
    case (ST_DYN_SHAPIRO_MAP_55)
      call dyn_shapiro_map_55(u,du___dyn,wet,v,dv___dyn,un,vn)
    case (ST_DYN_SHAPIRO_MAP_75)
      call dyn_shapiro_map_75(un,h,vn,eta,dt,dx,dy,etan)
    case (ST_DYN_SHAPIRO_MAP_92)
      call dyn_shapiro_map_92(wet,eps,etan,etann)
  end select
end subroutine dyn_shapiro_superkernel
end module module_dyn_shapiro_superkernel
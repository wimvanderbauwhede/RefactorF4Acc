module module_shapiro_dyn_update_superkernel


    contains

! ! returns eta
! subroutine shapiro_map_24(wet,etan,eta)
! !integer, dimension(8), intent(in) :: test_1
!           integer(4), parameter :: nx=500
!           integer(4), parameter :: ny=500
!     ! Local vars: j,k,term1,term2,term3
!     integer :: j
!     integer :: k
!     real :: term1
!     real :: term2
!     real :: term3
!     ! ParallelFortran: Synthesised loop variable decls
!     integer :: j_range
!     integer :: k_range
!     integer :: j_rel
!     integer :: k_rel
! ! READ
!     integer, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: wet
!     real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: etan
!     real, parameter :: eps = 0.05
! ! WRITTEN
! ! READ & WRITTEN
!     real, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: eta
! ! globalIdDeclaration
!     integer :: global_id
! ! globalIdInitialisation
!     call get_global_id(global_id,0)
! ! ptrAssignments_fseq

!     ! ParallelFortran: Synthesised loop variables
!     j_range = ((500 - 1) + 1)
!     k_range = ((500 - 1) + 1)
!     j_rel = (global_id / k_range)
!     j = (j_rel + 1)
!     k_rel = (global_id - (j_rel * k_range))
!     k = (k_rel + 1)


!     ! ParallelFortran: Original code
! if(wet(j,k)==1)then
!   term1 = (1.0-0.25*eps*(wet(j,k+1)+wet(j,k-1)+ wet(j+1,k)+wet(j-1,k)))*etan(j,k)
!   term2 = 0.25*eps*(wet(j,k+1)*etan(j,k+1)+wet(j,k-1)*etan(j,k-1))
!   term3 = 0.25*eps*(wet(j+1,k)*etan(j+1,k)+wet(j-1,k)*etan(j-1,k))
!   eta(j,k) = term1+term2+term3
! else
!   eta(j,k) = etan(j,k)
! end if

! end subroutine shapiro_map_24

! ! returns etan
! subroutine dyn_map_39(eta,u,wet,v,un,h,vn,etan)

!           integer(4), parameter :: nx=500
!           integer(4), parameter :: ny=500
!     ! Local vars: j,k,uu,vv,dvv,hep,hen,hue,hwp,hwn,huw,hnp,hnn,hvn,hsp,hsn,hvs
!     integer :: j
!     integer :: k
!     real :: uu
!     real :: vv
!     real :: dvv
!     real :: hep
!     real :: hen
!     real :: hue
!     real :: hwp
!     real :: hwn
!     real :: huw
!     real :: hnp
!     real :: hnn
!     real :: hvn
!     real :: hsp
!     real :: hsn
!     real :: hvs
!     ! ParallelFortran: Synthesised loop variable decls
!     integer :: j_range
!     integer :: k_range
!     integer :: j_rel
!     integer :: k_rel
! ! READ
!     real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: eta
!     real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: u
!     integer, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: wet
!     real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: v
!     real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: h
!     real :: dt
!     real :: g
!     real :: dx
!     real :: dy
!     real :: duu
! ! WRITTEN
!     real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: etan
! ! READ & WRITTEN
!     real, dimension(0:(ny + 1),0:(nx + 1)) :: du
!     real, dimension(0:(ny + 1),0:(nx + 1)) :: dv
!     real, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: un
!     real, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: vn
! ! globalIdDeclaration
!     integer :: global_id
! ! globalIdInitialisation
!     call get_global_id(global_id,0)
! ! ptrAssignments_fseq

!     ! ParallelFortran: Synthesised loop variables
!     j_range = ((500 - 1) + 1)
!     k_range = ((500 - 1) + 1)
!     j_rel = (global_id / k_range)
!     j = (j_rel + 1)
!     k_rel = (global_id - (j_rel * k_range))
!     k = (k_rel + 1)


!     ! ParallelFortran: Original code
!   du(j,k) = -dt*g*(eta(j,k+1)-eta(j,k))/dx
!   dv(j,k) = -dt*g*(eta(j+1,k)-eta(j,k))/dy
! un(j,k) = 0.0
! uu = u(j,k)
! duu = du(j,k)
! if(wet(j,k)==1) then
!   if((wet(j,k+1)==1) .or. (duu>0.0)) un(j,k) = uu+duu
! else
!   if((wet(j,k+1)==1) .and. (duu<0.0)) un(j,k) = uu+duu
! end if
! vv = v(j,k)
! dvv = dv(j,k)
! vn(j,k) = 0.0
! if(wet(j,k)==1) then
!   if((wet(j+1,k)==1) .or. (dv(j,k)>0.0)) vn(j,k) = vv+dvv
! else
!   if((wet(j+1,k)==1) .and. (dv(j,k)<0.0)) vn(j,k) = vv+dvv
! end if
!   hep = 0.5*(un(j,k)+abs(un(j,k)))*h(j,k)
!   hen = 0.5*(un(j,k)-abs(un(j,k)))*h(j,k+1)
!   hue = hep+hen
!   hwp = 0.5*(un(j,k-1)+abs(un(j,k-1)))*h(j,k-1)
!   hwn = 0.5*(un(j,k-1)-abs(un(j,k-1)))*h(j,k)
!   huw = hwp+hwn
!   hnp = 0.5*(vn(j,k)+abs(vn(j,k)))*h(j,k)
!   hnn = 0.5*(vn(j,k)-abs(vn(j,k)))*h(j+1,k)
!   hvn = hnp+hnn
!   hsp = 0.5*(vn(j-1,k)+abs(vn(j-1,k)))*h(j-1,k)
!   hsn = 0.5*(vn(j-1,k)-abs(vn(j-1,k)))*h(j,k)
!   hvs = hsp+hsn
!   etan(j,k) = eta(j,k)-dt*(hue-huw)/dx-dt*(hvn-hvs)/dy

! end subroutine dyn_map_39

! returns wet, u,v,h
subroutine update_map_24(hzero,eta,h,un,vn,wet,u,v)
    integer(4), parameter :: nx=500
    integer(4), parameter :: ny=500
    ! Local vars: j,k
    integer :: j
    integer :: k
    ! ParallelFortran: Synthesised loop variable decls
    integer :: j_range
    integer :: k_range
    integer :: j_rel
    integer :: k_rel
! READ
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: hzero
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: eta
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: un
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: vn
    real, parameter :: hmin = 0.05
! WRITTEN
    integer, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: wet
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: u
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: v
! READ & WRITTEN
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: h
! globalIdDeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq

    ! ParallelFortran: Synthesised loop variables
    j_range = (((500 + 1) - 0) + 1)
    k_range = (((500 + 1) - 0) + 1)
    j_rel = (global_id / k_range)
    j = (j_rel + 0)
    k_rel = (global_id - (j_rel * k_range))
    k = (k_rel + 0)


    ! ParallelFortran: Original code
  h(j,k) = hzero(j,k) + eta(j,k)
  wet(j,k) = 1
  if (h(j,k)<hmin) wet(j,k) = 0
  u(j,k) = un(j,k)
  v(j,k) = vn(j,k)

end subroutine update_map_24

! According to the original code, the toplevel arrays are
!
! real, dimension(0:ny+1,0:nx+1) :: eta
! real, dimension(0:ny+1,0:nx+1) :: etan
! real, dimension(0:ny+1,0:nx+1) :: h
! real, dimension(0:ny+1,0:nx+1) :: hzero
! real, dimension(0:ny+1,0:nx+1) :: u
! real, dimension(0:ny+1,0:nx+1) :: un
! real, dimension(0:ny+1,0:nx+1) :: v
! real, dimension(0:ny+1,0:nx+1) :: vn
! integer, dimension(0:ny+1,0:nx+1) :: wet
! 
! So any other array is def a local 
! The arrays that are initialised are the same ones:
! 
! eta,etan,h,hzero,u,un,v,vn,wet
!
! The arrays used for final output are
!
! eta,h,u,v
!

subroutine shapiro_dyn_update_superkernel(wet,eta,u,v,un,h,vn,hzero,state_ptr) ! etan,wet,eta,u,v,un,h,vn,hzero,state_ptr)
!use module_shapiro_dyn_update_superkernel_init

! parameters
  integer(4), parameter :: nx = 500 
  integer(4), parameter :: ny = 500 

  real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: eta
  ! real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: etan
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: h
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: hzero
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: u
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: un
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: v
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: vn
  integer, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: wet
  ! real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: du
  ! real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: dv

  ! real, intent(In) :: hmin
  ! real, intent(In) :: duu
  ! real, intent(In) :: dx
  ! real, intent(In) :: dy
  ! real, intent(In) :: eps
  ! real, intent(In) :: dt
  ! real, intent(In) :: g
  !integer, dimension(8,8) :: test !$ACC MemSpace local
  integer :: state
  integer, dimension(1) :: state_ptr
integer, parameter :: ST_SHAPIRO_MAP_24 = 1 !  shapiro_map_24
integer, parameter :: ST_DYN_MAP_39 = 2 !  dyn_map_39
integer, parameter :: ST_UPDATE_MAP_24 = 3 !  update_map_24
  state = state_ptr(1) ! state 
! SUPERKERNEL BODY
  select case(state)
    ! case (ST_SHAPIRO_MAP_24)
    !   call shapiro_map_24(wet,etan,eta)
    ! case (ST_DYN_MAP_39)
    !   call dyn_map_39(eta,u,wet,v,un,h,vn,etan)
    case (ST_UPDATE_MAP_24)
      call update_map_24(hzero,eta,h,un,vn,wet,u,v)
  end select
end subroutine shapiro_dyn_update_superkernel
end module module_shapiro_dyn_update_superkernel

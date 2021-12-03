module singleton_module_dyn_shapiro_map_55

contains

subroutine dyn_shapiro_map_55_scal(u_j_k,du___dyn_j_k,wet_j_k,wet_jp1_k,wet_j_kp1,v_j_k, &
      dv___dyn_j_k,un_j_k,vn_j_k)
!    ! Local vars: j,k,uu___dyn,vv___dyn,dvv___dyn
 integer :: j
 integer :: k
 real :: uu___dyn
 real :: vv___dyn
 real :: dvv___dyn
!    ! ParallelFortran: Synthesised loop variable decls
!  READ
 real, intent(In) :: u_j_k
 real, intent(In) :: du___dyn_j_k
 integer, intent(In) :: wet_j_k
 integer, intent(In) :: wet_j_kp1
 integer, intent(In) :: wet_jp1_k
 real, intent(In) :: v_j_k
 real, intent(In) :: dv___dyn_j_k
 real :: duu___dyn
!  WRITTEN
 real, intent(Out) :: un_j_k
 real, intent(Out) :: vn_j_k
!  READ & WRITTEN
!  globalIdDeclaration
!  globalIdInitialisation
!  ptrAssignments_fseq
!    ! ParallelFortran: Synthesised loop variables
!    ! ParallelFortran: Original code
 un_j_k = 0.0
 uu___dyn = u_j_k
 duu___dyn = du___dyn_j_k
 if (wet_j_k == 1) then
 if ((wet_j_kp1 == 1) .or. (duu___dyn > 0.0)) un_j_k = uu___dyn + duu___dyn
else
 if ((wet_j_kp1 == 1) .and. (duu___dyn < 0.0)) un_j_k = uu___dyn + duu___dyn
end if
 vv___dyn = v_j_k
 dvv___dyn = dv___dyn_j_k
 vn_j_k = 0.0
 if (wet_j_k == 1) then
 if ((wet_jp1_k == 1) .or. (dv___dyn_j_k > 0.0)) vn_j_k = vv___dyn + dvv___dyn
else
 if ((wet_jp1_k == 1) .and. (dv___dyn_j_k < 0.0)) vn_j_k = vv___dyn + dvv___dyn
end if
end subroutine dyn_shapiro_map_55_scal
!  ! subroutine dyn_shapiro_map_75(un,h,vn,eta,dt,dx,dy,etan)
!  subroutine dyn_shapiro_map_75(un,h,vn,eta,etan)
!      integer, parameter :: nx=500
!      integer, parameter :: ny=500
!            real, parameter :: alpha=1e-9
!      ! Local vars: j,k,hep___dyn,hen___dyn,hue___dyn,hwp___dyn,hwn___dyn,huw___dyn,hnp___dyn,hnn___dyn,hvn___dyn,hsp___dyn,hsn___dyn,hvs___dyn
!      integer :: j
!      integer :: k
!      real :: hep___dyn
!      real :: hen___dyn
!      real :: hue___dyn
!      real :: hwp___dyn
!      real :: hwn___dyn
!      real :: huw___dyn
!      real :: hnp___dyn
!      real :: hnn___dyn
!      real :: hvn___dyn
!      real :: hsp___dyn
!      real :: hsn___dyn
!      real :: hvs___dyn
!      ! ParallelFortran: Synthesised loop variable decls
!      integer :: j_range
!      integer :: k_range
!      integer :: j_rel
!      integer :: k_rel
!  ! READ
!      real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: un
!      real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: h
!      real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: vn
!      real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: eta
!      ! real :: dt
!      ! real :: dx
!      ! real :: dy
!      real, parameter :: dt = 1.0
!      ! real, parameter :: g = 1.0
!      real, parameter :: dx = 1.0
!      real, parameter :: dy = 1.0  
!  ! WRITTEN
!      real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: etan
!  ! READ & WRITTEN
!  ! globalIdDeclaration
!      integer :: global_id
!  ! globalIdInitialisation
!      call get_global_id(global_id,0)
!  ! ptrAssignments_fseq
!      ! ParallelFortran: Synthesised loop variables
!      j_range = ((500 - 1) + 1)
!      k_range = ((500 - 1) + 1)
!      j_rel = (global_id / k_range)
!      j = (j_rel + 1)
!      k_rel = (global_id - (j_rel * k_range))
!      k = (k_rel + 1)
!      ! ParallelFortran: Original code
!    hep___dyn = 0.5*(un(j,k)+abs(un(j,k)))*h(j,k)
!    hen___dyn = 0.5*(un(j,k)-abs(un(j,k)))*h(j,k+1)
!    hue___dyn = hep___dyn+hen___dyn
!    hwp___dyn = 0.5*(un(j,k-1)+abs(un(j,k-1)))*h(j,k-1)
!    hwn___dyn = 0.5*(un(j,k-1)-abs(un(j,k-1)))*h(j,k)
!    huw___dyn = hwp___dyn+hwn___dyn
!    hnp___dyn = 0.5*(vn(j,k)+abs(vn(j,k)))*h(j,k)
!    hnn___dyn = 0.5*(vn(j,k)-abs(vn(j,k)))*h(j+1,k)
!    hvn___dyn = hnp___dyn+hnn___dyn
!    hsp___dyn = 0.5*(vn(j-1,k)+abs(vn(j-1,k)))*h(j-1,k)
!    hsn___dyn = 0.5*(vn(j-1,k)-abs(vn(j-1,k)))*h(j,k)
!    hvs___dyn = hsp___dyn+hsn___dyn
!    etan(j,k) = eta(j,k)-dt*(hue___dyn-huw___dyn)/dx-dt*(hvn___dyn-hvs___dyn)/dy
!  end subroutine dyn_shapiro_map_75
!  subroutine dyn_shapiro_map_92(wet,eps,etan,etann)
!      integer, parameter :: nx=500
!      integer, parameter :: ny=500
!            real, parameter :: alpha=1e-9
!      ! Local vars: j,k,term1___shapiro,term2___shapiro,term3___shapiro
!      integer :: j
!      integer :: k
!      real :: term1___shapiro
!      real :: term2___shapiro
!      real :: term3___shapiro
!      ! ParallelFortran: Synthesised loop variable decls
!      integer :: j_range
!      integer :: k_range
!      integer :: j_rel
!      integer :: k_rel
!  ! READ
!      integer, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: wet
!      real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: etan
!      real :: eps
!  ! WRITTEN
!      real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: etann
!  ! READ & WRITTEN
!  ! globalIdDeclaration
!      integer :: global_id
!  ! globalIdInitialisation
!      call get_global_id(global_id,0)
!  ! ptrAssignments_fseq
!      ! ParallelFortran: Synthesised loop variables
!      j_range = ((500 - 1) + 1)
!      k_range = ((500 - 1) + 1)
!      j_rel = (global_id / k_range)
!      j = (j_rel + 1)
!      k_rel = (global_id - (j_rel * k_range))
!      k = (k_rel + 1)
!      ! ParallelFortran: Original code
!  if(wet(j,k)==1)then
!    term1___shapiro = (1.0-0.25*eps*(wet(j,k+1)+wet(j,k-1)+ wet(j+1,k)+wet(j-1,k)))*etan(j,k)
!    term2___shapiro = 0.25*eps*(wet(j,k+1)*etan(j,k+1)+wet(j,k-1)*etan(j,k-1))
!    term3___shapiro = 0.25*eps*(wet(j+1,k)*etan(j+1,k)+wet(j-1,k)*etan(j-1,k))
!    etann(j,k) = term1___shapiro+term2___shapiro+term3___shapiro
!  else
!    etann(j,k) = etan(j,k)
!  end if
!  end subroutine dyn_shapiro_map_92
!  subroutine dyn_shapiro_superkernel(dt,g,eta,dx,dy,u,wet,v,un,vn,h,etann,eps,state_ptr)
!  ! subroutine dyn_shapiro_superkernel(eta,u,wet,v,un,vn,h,state_ptr)

end module singleton_module_dyn_shapiro_map_55


module singleton_module_dyn_shapiro_map_75

contains

subroutine dyn_shapiro_map_75_scal(un_j_km1,un_j_k,h_j_km1,h_jm1_k,h_j_k,h_jp1_k,h_j_kp1,vn_jm1_k, &
      vn_j_k,eta_j_k,etan_j_k)
!    ! Local vars: j,k,hep___dyn,hen___dyn,hue___dyn,hwp___dyn,hwn___dyn,huw___dyn,hnp___dyn,hnn___dyn,hvn___dyn,hsp___dyn,hsn___dyn,hvs___dyn
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
!    ! ParallelFortran: Synthesised loop variable decls
!  READ
 real, intent(In) :: un_j_k
 real, intent(In) :: un_j_km1
 real, intent(In) :: h_j_k
 real, intent(In) :: h_j_km1
 real, intent(In) :: h_j_kp1
 real, intent(In) :: h_jm1_k
 real, intent(In) :: h_jp1_k
 real, intent(In) :: vn_j_k
 real, intent(In) :: vn_jm1_k
 real, intent(In) :: eta_j_k
!    ! real :: dt
!    ! real :: dx
!    ! real :: dy
 real, parameter :: dt=1.0
!    ! real, parameter :: g = 1.0
 real, parameter :: dx=1.0
 real, parameter :: dy=1.0
!  WRITTEN
 real, intent(Out) :: etan_j_k
!  READ & WRITTEN
!  globalIdDeclaration
!  globalIdInitialisation
!  ptrAssignments_fseq
!    ! ParallelFortran: Synthesised loop variables
!    ! ParallelFortran: Original code
 hep___dyn = 0.5 * (un_j_k + abs(un_j_k)) * h_j_k
 hen___dyn = 0.5 * (un_j_k - abs(un_j_k)) * h_j_kp1
 hue___dyn = hep___dyn + hen___dyn
 hwp___dyn = 0.5 * (un_j_km1 + abs(un_j_km1)) * h_j_km1
 hwn___dyn = 0.5 * (un_j_km1 - abs(un_j_km1)) * h_j_k
 huw___dyn = hwp___dyn + hwn___dyn
 hnp___dyn = 0.5 * (vn_j_k + abs(vn_j_k)) * h_j_k
 hnn___dyn = 0.5 * (vn_j_k - abs(vn_j_k)) * h_jp1_k
 hvn___dyn = hnp___dyn + hnn___dyn
 hsp___dyn = 0.5 * (vn_jm1_k + abs(vn_jm1_k)) * h_jm1_k
 hsn___dyn = 0.5 * (vn_jm1_k - abs(vn_jm1_k)) * h_j_k
 hvs___dyn = hsp___dyn + hsn___dyn
 etan_j_k = eta_j_k - dt * (hue___dyn - huw___dyn) / dx - dt * (hvn___dyn - hvs___dyn) / dy
end subroutine dyn_shapiro_map_75_scal
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

end module singleton_module_dyn_shapiro_map_75


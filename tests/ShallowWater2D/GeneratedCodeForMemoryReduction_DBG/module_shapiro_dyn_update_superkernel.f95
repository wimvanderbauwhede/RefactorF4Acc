module module_shapiro_dyn_update_superkernel

    contains

!subroutine shapiro_map_24(test_1,wet,eps,etan,eta,etan_avg)
subroutine shapiro_map_24(wet,eps,etan,eta,etan_avg)
!integer, dimension(8), intent(in) :: test_1
          integer(4), parameter :: nx=500
          integer(4), parameter :: ny=500
          real, parameter :: alpha=1e-9
    ! Local vars: j,k,term1,term2,term3
    integer :: j
    integer :: k
    real :: term1
    real :: term2
    real :: term3
    ! ParallelFortran: Synthesised loop variable decls
    integer :: j_range
    integer :: k_range
    integer :: j_rel
    integer :: k_rel
! READ
    integer, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: wet
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: etan
    real :: eps
    real :: etan_avg
! WRITTEN
! READ & WRITTEN
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: eta
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
  term1 = (1.0-0.25*eps*(wet(j,k+1)+wet(j,k-1)+ wet(j+1,k)+wet(j-1,k)))*etan(j,k)
  term2 = 0.25*eps*(wet(j,k+1)*etan(j,k+1)+wet(j,k-1)*etan(j,k-1))
  term3 = 0.25*eps*(wet(j+1,k)*etan(j+1,k)+wet(j-1,k)*etan(j-1,k))
  eta(j,k) = term1+term2+term3
else
  eta(j,k) = etan(j,k)
end if
eta(j,k) = (1-alpha)*eta(j,k) + alpha*etan_avg

end subroutine shapiro_map_24

subroutine shapiro_dyn_update_superkernel(etan,wet,eps,eta,etan_avg)
!use module_shapiro_dyn_update_superkernel_init

! parameters
              integer(4), parameter :: nx = 500 
              integer(4), parameter :: ny = 500 
              real, parameter :: alpha = 1e-9
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: etan
  integer, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: wet
  real, intent(In) :: eps
  real, intent(In)  :: etan_avg
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(InOut) :: eta
  call shapiro_map_24(wet,eps,etan,eta,etan_avg)
end subroutine shapiro_dyn_update_superkernel

subroutine get_global_id(idx,dim)
  integer, intent(in) :: dim
  integer, intent(out) :: idx
  integer :: global_id
  common /ocl/ global_id
  idx = global_id
end subroutine get_global_id

end module module_shapiro_dyn_update_superkernel

module module_shapiro_dyn_update_superkernel

    contains

subroutine shapiro_reduce_19(acc,etan,etan_avg)

    integer(4), parameter :: nx=500
    integer(4), parameter :: ny=500
    real, parameter :: alpha=1e-9
    ! Local vars: j,k
    integer  :: j
    integer  :: k
    ! ParallelFortran: Synthesised loop variable decls
    integer :: j_range
    integer :: k_range
    integer :: j_rel
    integer :: k_rel
! READ
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: etan
! WRITTEN
! READ & WRITTEN
    real, intent(InOut) :: etan_avg
    real, intent(In) :: acc
    ! real, intent(Out) :: test_temp
    ! globalIdDeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq

    ! ParallelFortran: Synthesised loop variables
    j_range = ((nx - 1) + 1)
    k_range = ((ny - 1) + 1)
    j_rel = (global_id / k_range)
    j = (j_rel + 1)
    k_rel = (global_id - (j_rel * k_range))
    k = (k_rel + 1)


    ! ParallelFortran: Original code
etan_avg = etan_avg + etan(j,k)/(nx*ny) 
etan_avg = etan_avg / acc
! test_temp = 
end subroutine shapiro_reduce_19


!subroutine shapiro_map_24(test_1,wet,eps,etan,eta,etan_avg)
subroutine shapiro_map_24(wet,eps,etan,eta1_local,etan_avg)
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
    real, intent(In) :: etan_avg
! WRITTEN
    ! real, intent(In) :: test_temp
! READ & WRITTEN
    real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: eta1_local
! globalIdDeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq

    ! ParallelFortran: Synthesised loop variables
    j_range = ((nx - 1) + 1)
    k_range = ((ny - 1) + 1)
    j_rel = (global_id / k_range)
    j = (j_rel + 1)
    k_rel = (global_id - (j_rel * k_range))
    k = (k_rel + 1)


    ! ParallelFortran: Original code
if(wet(j,k)==1)then
  term1 = (1.0-0.25*eps*(wet(j,k+1)+wet(j,k-1)+ wet(j+1,k)+wet(j-1,k)))*etan(j,k)
  term2 = 0.25*eps*(wet(j,k+1)*etan(j,k+1)+wet(j,k-1)*etan(j,k-1))
  term3 = 0.25*eps*(wet(j+1,k)*etan(j+1,k)+wet(j-1,k)*etan(j-1,k))
  eta1_local(j,k) = term1+term2+term3
else
  eta1_local(j,k) = etan(j,k)
end if
eta1_local(j,k) = (1-alpha)*eta1_local(j,k) + alpha*etan_avg 
end subroutine shapiro_map_24


subroutine shapiro_map_25(wet,eps,etan,eta2_local,etan_avg)
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
      real, intent(In) :: etan_avg
  ! WRITTEN
      ! real, intent(In) :: test_temp
  ! READ & WRITTEN
      real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: eta2_local
  ! globalIdDeclaration
      integer :: global_id
  ! globalIdInitialisation
      call get_global_id(global_id,0)
  ! ptrAssignments_fseq
  
      ! ParallelFortran: Synthesised loop variables
      j_range = ((nx - 1) + 1)
      k_range = ((ny - 1) + 1)
      j_rel = (global_id / k_range)
      j = (j_rel + 1)
      k_rel = (global_id - (j_rel * k_range))
      k = (k_rel + 1)
  
  
      ! ParallelFortran: Original code
  if(wet(j,k)==1)then
    term1 = (1.0-0.25*eps*(wet(j,k+1)+wet(j,k-1)+ wet(j+1,k)+wet(j-1,k)))*etan(j,k)
    term2 = 0.25*eps*(wet(j,k+1)*etan(j,k+1)+wet(j,k-1)*etan(j,k-1))
    term3 = 0.25*eps*(wet(j+1,k)*etan(j+1,k)+wet(j-1,k)*etan(j-1,k))
    eta2_local(j,k) = term1+term2+term3
  else
    eta2_local(j,k) = etan(j,k)
  end if
  eta2_local(j,k) = (1-alpha)*eta2_local(j,k) + alpha*etan_avg 
  end subroutine shapiro_map_25

subroutine dyn_map_39(eta1_local,eta2_local,wet,eta,acc)

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
real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: eta1_local,eta2_local
integer, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: wet
! WRITTEN
real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: eta
real, intent(In) :: acc
! globalIdDeclaration
integer :: global_id
! globalIdInitialisation
call get_global_id(global_id,0)
! ptrAssignments_fseq

! ParallelFortran: Synthesised loop variables
j_range = ((nx - 1) + 1)
k_range = ((ny - 1) + 1)
j_rel = (global_id / k_range)
j = (j_rel + 1)
k_rel = (global_id - (j_rel * k_range))
k = (k_rel + 1)


! Fiction
eta(j,k) = (eta1_local(j-1,k-1) + eta1_local(j+1,k+1))/4 + (eta2_local(j-1,k+1) + eta2_local(j+1,k-1))/4  - 0.1*wet(j,k)+acc

end subroutine dyn_map_39

subroutine shapiro_dyn_update_superkernel(etan,wet,eps,eta,etan_avg,acc,state_ptr)
!use module_shapiro_dyn_update_superkernel_init

! parameters
  integer(4), parameter :: nx = 500 
  integer(4), parameter :: ny = 500 
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: etan
  integer, dimension(0:(ny + 1),0:(nx + 1)), intent(In) :: wet
  real, intent(In) :: eps
  real, intent(In)  :: etan_avg,acc  
  real, dimension(0:(ny + 1),0:(nx + 1)), intent(Out) :: eta
  real, dimension(0:(ny + 1),0:(nx + 1)) :: eta1_local
  real, dimension(0:(ny + 1),0:(nx + 1)) :: eta2_local
  ! real :: test_temp

  integer, parameter :: ST_SHAPIRO_REDUCE_19 = 1 !  shapiro_reduce_19
  integer, parameter :: ST_SHAPIRO_MAP_24 = 2 !  shapiro_map_24
  integer, parameter :: ST_SHAPIRO_MAP_25 = 3 !  shapiro_map_24
  integer, parameter :: ST_DYN_MAP_39 = 4

  integer :: state  
  integer, dimension(1), intent(In)  :: state_ptr
  state = state_ptr(1) ! state 
! SUPERKERNEL BODY
  select case(state)
    case (ST_SHAPIRO_REDUCE_19)
      call shapiro_reduce_19(acc,etan,etan_avg)
    case (ST_SHAPIRO_MAP_24)
      call shapiro_map_24(wet,eps,etan,eta1_local,etan_avg)
    case (ST_SHAPIRO_MAP_25)
      call shapiro_map_25(wet,eps,etan,eta2_local,etan_avg)
    case (ST_DYN_MAP_39)
      call dyn_map_39(eta1_local,eta2_local,wet,eta,acc)
  end select
end subroutine shapiro_dyn_update_superkernel
end module module_shapiro_dyn_update_superkernel

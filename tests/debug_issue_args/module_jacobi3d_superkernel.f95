module module_jacobi3d_superkernel

    contains

subroutine stencil_0(u, un)

  integer, parameter :: nx=100
  integer, parameter :: ny=100    
  integer, parameter :: nz=100    

  real, parameter :: c = 0.1

  integer :: i
  integer :: j
  integer :: k
  integer :: i_range
  integer :: j_range
  integer :: k_range
  integer :: i_rel
  integer :: j_rel
  integer :: k_rel
  
  real, dimension(0:(nx + 1),0:(ny + 1), 0:(nz + 1)), intent(In) :: u
  real, dimension(0:(nx + 1),0:(ny + 1), 0:(nz + 1)), intent(Out) :: un

  integer :: global_id
  call get_global_id(global_id,0)

  k_range = ((nz - 1) + 1)
  j_range = ((ny - 1) + 1)
  i_range = ((nx - 1) + 1)
  k_rel = (global_id / (j_range * i_range))
  k = (k_rel + 1)
  j_rel = ((global_id - (k_rel * (j_range * i_range))) / i_range)
  j = (j_rel + 1)
  i_rel = ((global_id - (k_rel * (j_range * i_range))) - (j_rel * i_range))
  i = (i_rel + 1)

  un(i, j, k) = ( u(i-1, j, k) + u(i+1, j, k) + u(i, j-1, k) + u(i, j+1, k) + u(i, j, k-1) + u(i, j, k+1) ) * c 

end subroutine stencil_0

subroutine jacobi3d_superkernel(u, un, state_ptr)
  integer, parameter :: nx=100
  integer, parameter :: ny=100    
  integer, parameter :: nz=100    

  real, dimension(0:(nx + 1),0:(ny + 1), 0:(nz + 1)), intent(In) :: u
  real, dimension(0:(nx + 1),0:(ny + 1), 0:(nz + 1)), intent(Out) :: un

  real, dimension(0:(nx + 1),0:(ny + 1), 0:(nz + 1)) :: v0
  
  integer :: state
  integer :: state_ptr
integer, parameter :: ST_STENCIL_0 = 0 
integer, parameter :: ST_STENCIL_1 = 1 

state = state_ptr ! state 
select case(state)
  case (ST_DYN_SHAPIRO_MAP_49)
    call stencil_0(u, v0)
  case (ST_DYN_SHAPIRO_MAP_55)
    call stencil_0(v0, un)
end select

end subroutine jacobi3d_superkernel
end module module_jacobi3d_superkernel

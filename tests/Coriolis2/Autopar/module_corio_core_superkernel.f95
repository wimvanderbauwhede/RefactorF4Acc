module module_corio_core_superkernel


    contains


subroutine corio_core_map_26(u,v,x,un,y,vn,xn,yn)

            real, parameter :: dt=432.000000
            real, parameter :: pi=3.14159274
            real, parameter :: freq=-7.27220540E-05
            real, parameter :: f=-1.45444108E-04
            real, parameter :: alpha=-6.28318563E-02
            real, parameter :: beta=9.86960484E-04
            integer, parameter :: dmax=1000
            integer, parameter :: im=10
            integer, parameter :: jm=10
            integer, parameter :: km=5
    ! Local vars: i,j,k
    integer :: i
    integer :: j
    integer :: k
    ! ParallelFortran: Synthesised loop variable decls
    integer :: i_range
    integer :: j_range
    integer :: k_range
    integer :: i_rel
    integer :: j_rel
    integer :: k_rel
! READ
! WRITTEN
! READ & WRITTEN
    real, dimension(1:im,1:jm,1:km), intent(InOut) :: un
    real, dimension(1:im,1:jm,1:km), intent(InOut) :: vn
    real, dimension(1:im,1:jm,1:km), intent(InOut) :: xn
    real, dimension(1:im,1:jm,1:km), intent(InOut) :: yn
    real, dimension(1:im,1:jm,1:km), intent(InOut) :: u
    real, dimension(1:im,1:jm,1:km), intent(InOut) :: v
    real, dimension(1:im,1:jm,1:km), intent(InOut) :: x
    real, dimension(1:im,1:jm,1:km), intent(InOut) :: y
! globalIdDeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq

    ! ParallelFortran: Synthesised loop variables
    i_range = ((10 - 1) + 1)
    j_range = ((10 - 1) + 1)
    k_range = ((5 - 1) + 1)
    i_rel = (global_id / (j_range * k_range))
    i = (i_rel + 1)
    j_rel = ((global_id - (i_rel * (j_range * k_range))) / k_range)
    j = (j_rel + 1)
    k_rel = ((global_id - (i_rel * (j_range * k_range))) - (j_rel * k_range))
    k = (k_rel + 1)


    ! ParallelFortran: Original code
            un(i,j,k) = (u(i,j,k)*(beta)+alpha*v(i,j,k))/(beta)
            vn(i,j,k) = (v(i,j,k)*(beta)-alpha*u(i,j,k))/(beta)
                    xn(i,j,k) = x(i,j,k) + dt*un(i,j,k)/dmax
                    yn(i,j,k) = y(i,j,k) + dt*vn(i,j,k)/dmax
            u(i,j,k) = un(i,j,k)
            v(i,j,k) = vn(i,j,k)
            x(i,j,k) = xn(i,j,k)
            y(i,j,k) = yn(i,j,k)

end subroutine corio_core_map_26


subroutine corio_core_superkernel(u,v,x,un,y,vn,xn,yn,state_ptr)
use module_corio_core_superkernel_init
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: un
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: vn
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: xn
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: yn
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: u
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: v
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: x
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: y

  integer :: state
  integer, dimension(1) :: state_ptr
integer, parameter :: ST_CORIO_CORE_MAP_26 = 0 !  corio_core_map_26
  state = state_ptr(1) ! state 
! SUPERKERNEL BODY
  select case(state)
    case (ST_CORIO_CORE_MAP_26)
      call corio_core_map_26(u,v,x,un,y,vn,xn,yn)
  end select
end subroutine corio_core_superkernel
end module module_corio_core_superkernel
module module_predict_loc_predict_vel_update_etc_superkernel


    contains


subroutine predict_loc_map_19(im,x,dt,un,dmax,y,vn,jm,km,xn,yn)

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
    real, dimension(1:im,1:jm,1:km), intent(In) :: x
    real, dimension(1:im,1:jm,1:km), intent(In) :: un
    real, dimension(1:im,1:jm,1:km), intent(In) :: y
    real, dimension(1:im,1:jm,1:km), intent(In) :: vn
    integer :: im
    real :: dt
    real :: dmax
    integer :: jm
    integer :: km
! WRITTEN
    real, dimension(1:im,1:jm,1:km), intent(Out) :: xn
    real, dimension(1:im,1:jm,1:km), intent(Out) :: yn
! READ & WRITTEN
! globalIdDeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq

    ! ParallelFortran: Synthesised loop variables
    i_range = ((im - 1) + 1)
    j_range = ((jm - 1) + 1)
    k_range = ((km - 1) + 1)
    i_rel = (global_id / (j_range * k_range))
    i = (i_rel + 1)
    j_rel = ((global_id - (i_rel * (j_range * k_range))) / k_range)
    j = (j_rel + 1)
    k_rel = ((global_id - (i_rel * (j_range * k_range))) - (j_rel * k_range))
    k = (k_rel + 1)


    ! ParallelFortran: Original code
                    xn(i,j,k) = x(i,j,k) + dt*un(i,j,k)/dmax
                    yn(i,j,k) = y(i,j,k) + dt*vn(i,j,k)/dmax

end subroutine predict_loc_map_19


subroutine predict_vel_map_17(im,u,beta,alpha,v,jm,km,un,vn)

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
    real, dimension(1:im,1:jm,1:km), intent(In) :: u
    real, dimension(1:im,1:jm,1:km), intent(In) :: v
    integer :: im
    real :: beta
    integer :: alpha
    integer :: jm
    integer :: km
! WRITTEN
    real, dimension(1:im,1:jm,1:km), intent(Out) :: un
    real, dimension(1:im,1:jm,1:km), intent(Out) :: vn
! READ & WRITTEN
! globalIdDeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq

    ! ParallelFortran: Synthesised loop variables
    i_range = ((im - 1) + 1)
    j_range = ((jm - 1) + 1)
    k_range = ((km - 1) + 1)
    i_rel = (global_id / (j_range * k_range))
    i = (i_rel + 1)
    j_rel = ((global_id - (i_rel * (j_range * k_range))) / k_range)
    j = (j_rel + 1)
    k_rel = ((global_id - (i_rel * (j_range * k_range))) - (j_rel * k_range))
    k = (k_rel + 1)


    ! ParallelFortran: Original code
            un(i,j,k) = (u(i,j,k)*(1-beta)+alpha*v(i,j,k))/(1+beta)
            vn(i,j,k) = (v(i,j,k)*(1-beta)-alpha*u(i,j,k))/(1+beta)

end subroutine predict_vel_map_17


subroutine update_loc_vel_map_19(im,un,vn,xn,yn,jm,km,u,v,x,y)

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
    real, dimension(1:im,1:jm,1:km), intent(In) :: un
    real, dimension(1:im,1:jm,1:km), intent(In) :: vn
    real, dimension(1:im,1:jm,1:km), intent(In) :: xn
    real, dimension(1:im,1:jm,1:km), intent(In) :: yn
    integer :: im
    integer :: jm
    integer :: km
! WRITTEN
    real, dimension(1:im,1:jm,1:km), intent(Out) :: u
    real, dimension(1:im,1:jm,1:km), intent(Out) :: v
    real, dimension(1:im,1:jm,1:km), intent(Out) :: x
    real, dimension(1:im,1:jm,1:km), intent(Out) :: y
! READ & WRITTEN
! globalIdDeclaration
    integer :: global_id
! globalIdInitialisation
    call get_global_id(global_id,0)
! ptrAssignments_fseq

    ! ParallelFortran: Synthesised loop variables
    i_range = ((im - 1) + 1)
    j_range = ((jm - 1) + 1)
    k_range = ((km - 1) + 1)
    i_rel = (global_id / (j_range * k_range))
    i = (i_rel + 1)
    j_rel = ((global_id - (i_rel * (j_range * k_range))) / k_range)
    j = (j_rel + 1)
    k_rel = ((global_id - (i_rel * (j_range * k_range))) - (j_rel * k_range))
    k = (k_rel + 1)


    ! ParallelFortran: Original code
            u(i,j,k) = un(i,j,k)
            v(i,j,k) = vn(i,j,k)
            x(i,j,k) = xn(i,j,k)
            y(i,j,k) = yn(i,j,k)

end subroutine update_loc_vel_map_19


subroutine predict_loc_predict_vel_update_etc_superkernel(im,x,dt,un,dmax,y,vn,jm,km,xn,yn,u,beta,alpha,v,state_ptr)
use module_predict_loc_predict_vel_update_etc_superkernel_init
  integer, intent(In), dimension(1) :: im
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: x
  real, intent(In), dimension(1) :: dt
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: un
  real, intent(In), dimension(1) :: dmax
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: y
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: vn
  integer, intent(In), dimension(1) :: jm
  integer, intent(In), dimension(1) :: km
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: u
  real, intent(In), dimension(1) :: beta
  integer, intent(In), dimension(1) :: alpha
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: v
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: xn
  real, dimension(1:im,1:jm,1:km), intent(InOut) :: yn

  integer :: state
  integer, dimension(1) :: state_ptr
integer, parameter :: ST_PREDICT_LOC_MAP_19 = 0 !  predict_loc_map_19
integer, parameter :: ST_PREDICT_VEL_MAP_17 = 1 !  predict_vel_map_17
integer, parameter :: ST_UPDATE_LOC_VEL_MAP_19 = 2 !  update_loc_vel_map_19
  state = state_ptr(1) ! state 
! SUPERKERNEL BODY
  select case(state)
    case (ST_PREDICT_LOC_MAP_19)
      call predict_loc_map_19(im,x,dt,un,dmax,y,vn,jm,km,xn,yn)
    case (ST_PREDICT_VEL_MAP_17)
      call predict_vel_map_17(im,u,beta,alpha,v,jm,km,un,vn)
    case (ST_UPDATE_LOC_VEL_MAP_19)
      call update_loc_vel_map_19(im,un,vn,xn,yn,jm,km,u,v,x,y)
  end select
end subroutine predict_loc_predict_vel_update_etc_superkernel
end module module_predict_loc_predict_vel_update_etc_superkernel
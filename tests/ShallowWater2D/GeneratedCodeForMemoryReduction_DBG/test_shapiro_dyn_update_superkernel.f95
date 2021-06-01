program test_shapiro_dyn_update_superkernel
    use module_shapiro_dyn_update_superkernel, only : shapiro_dyn_update_superkernel
    integer(4), parameter :: nx = 500 
    integer(4), parameter :: ny = 500 
    real, parameter :: alpha = 1e-9
    real, dimension(0:(ny + 1),0:(nx + 1)) :: etan
    integer, dimension(0:(ny + 1),0:(nx + 1)) :: wet
    real :: eps
    real  :: etan_avg
    real, dimension(0:(ny + 1),0:(nx + 1)) :: eta
    real, dimension(0:ny+1,0:nx+1) :: hzero

    integer :: global_id
    common /ocl/ global_id

    eps = 0.05
    call init(hzero,eta,etan,wet)

    do i=0,nx+1
        do j=0,ny+1
            global_id = i+(nx+2)*j            
            call shapiro_dyn_update_superkernel(etan,wet,eps,eta,etan_avg)
        end do
    end do

end program test_shapiro_dyn_update_superkernel


subroutine init(hzero,eta,etan,wet)
    implicit none
    integer, parameter :: ny=500
    integer, parameter :: nx=500
    integer :: i,j
    integer :: k
    real, dimension(0:ny+1,0:nx+1), intent(InOut) :: hzero
    real, dimension(0:ny+1,0:nx+1), intent(InOut) :: eta
    real, dimension(0:ny+1,0:nx+1), intent(Out) :: etan
    integer, dimension(0:ny+1,0:nx+1), intent(Out) :: wet
! initial conditions
do j = 0,ny+1
do k = 0,nx+1
hzero(j,k) = 10.0 
end do
end do
! land boundaries with 10 m elevation
do k = 0,nx+1
hzero(0,k) = -10.0
hzero(ny+1,k) = -10.0
end do

do j = 0,ny+1
hzero(j,0) = -10.0
hzero(j,nx+1) = -10.0
end do
do j = 0,ny+1
do k = 0,nx+1
eta(j,k) = -min(0.0,hzero(j,k))
etan(j,k) = eta(j,k)
end do
end do
do i=0,nx+1
    do j=0,ny+1
        if (i > 100 .and. i<200 .and. j > 100 .and. j<200 ) then
            wet(i,j) = 1
        else
            wet(i,j)=0
        end if    
    end do
end do
end subroutine init
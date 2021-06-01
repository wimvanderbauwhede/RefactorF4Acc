program test_shapiro_dyn_update_superkernel
    use module_shapiro_dyn_update_superkernel_init
    use module_shapiro_dyn_update_superkernel, only : shapiro_dyn_update_superkernel
    ! integer(4), parameter :: nx = 500 
    ! integer(4), parameter :: ny = 500 
    ! real, parameter :: alpha = 1e-9
    real, dimension(0:(ny + 1),0:(nx + 1)) :: etan
    integer, dimension(0:(ny + 1),0:(nx + 1)) :: wet
    real :: eps
    real  :: etan_avg
    real, dimension(0:(ny + 1),0:(nx + 1)) :: eta
    real, dimension(0:ny+1,0:nx+1) :: hzero

    ! integer :: global_id
    ! common /ocl/ global_id

    eps = 0.05
    call init(hzero,eta,etan,wet)

    do j=0,ny+1
        do i=0,nx+1
            call set_global_id(i+(nx+2)*j,0)
            call shapiro_dyn_update_superkernel(etan,wet,eps,eta,etan_avg)
        end do
    end do

    do j=0,ny+1
        print *,eta(i,:)
        ! do i=0,nx+1
        !     call set_global_id(i+(nx+2)*j,0)
        !     call shapiro_dyn_update_superkernel(etan,wet,eps,eta,etan_avg)
        ! end do
    end do
end program test_shapiro_dyn_update_superkernel



program main
    use module_dyn_shapiro_superkernel, only : dyn_shapiro_superkernel
    integer :: global_id
    ! common /ocl/ global_id
    ! Declarations
    real, dimension(1:252004) :: eta_0
    integer, dimension(1:252004) :: wet_0
    real, dimension(1:252004) :: u_0
    real, dimension(1:252004) :: v_0
    real, dimension(1:252004) :: un_1
    real, dimension(1:252004) :: vn_1
    integer, parameter :: ST_STAGE_KERNEL_1 = 1 ! stage_kernel_1
    integer :: state_ptr
    integer, parameter :: niters = 5
    integer :: iter 
    ! Loops over stage calls
    state_ptr = ST_STAGE_KERNEL_1
    do iter = 1, niters
    print *, iter
    do global_id = 1, 252004
      call dyn_shapiro_superkernel(eta_0, wet_0, u_0, v_0, un_1, vn_1,state_ptr)
    end do
    end do

end program main  

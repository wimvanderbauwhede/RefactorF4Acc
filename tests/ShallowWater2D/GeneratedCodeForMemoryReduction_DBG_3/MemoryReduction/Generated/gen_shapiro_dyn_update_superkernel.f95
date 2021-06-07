program main
    use module_shapiro_dyn_update_superkernel, only : shapiro_dyn_update_superkernel
    integer :: global_id
    common /ocl/ global_id
    ! Declarations
    real, dimension(1:252004) :: hzero_0
    real, dimension(1:252004) :: eta_0
    real, dimension(1:252004) :: un_0
    real, dimension(1:252004) :: vn_0
    real, dimension(1:252004) :: h_1
    real, dimension(1:252004) :: u_1
    real, dimension(1:252004) :: v_1
    integer, dimension(1:252004) :: wet_1
    integer, parameter :: ST_STAGE_KERNEL_1 = 1 ! stage_kernel_1
    integer, dimension(1) :: state_ptr
    ! Loops over stage calls
    state_ptr(1) = ST_STAGE_KERNEL_1
    do global_id = 1, 252004
      call shapiro_dyn_update_superkernel(hzero_0, eta_0, un_0, vn_0, h_1, u_1, v_1, wet_1,state_ptr)
    end do

end program main  

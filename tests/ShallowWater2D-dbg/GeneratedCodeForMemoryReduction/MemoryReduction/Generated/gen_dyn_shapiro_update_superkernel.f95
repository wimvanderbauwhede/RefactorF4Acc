program main
    use module_dyn_shapiro_update_superkernel, only : dyn_shapiro_update_superkernel
    integer :: global_id
    ! common /ocl/ global_id
    ! Declarations
    integer, parameter :: ST_STAGE_KERNEL_1 = 1 ! stage_kernel_1
    integer :: state_ptr
    integer, parameter :: niters = 5
    integer :: iter 
    ! Loops over stage calls
    state_ptr = ST_STAGE_KERNEL_1
    do iter = 1, niters
    print *, iter
    do global_id = 1, 252004
      call dyn_shapiro_update_superkernel(,state_ptr)
    end do
    end do

end program main  

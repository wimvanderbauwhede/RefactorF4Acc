program main
    use module_velfg_superkernel, only : velfg_superkernel
    integer :: global_id
    common /ocl/ global_id
    ! Declarations
    real, dimension(1:2139552) :: u_0
    real, dimension(1:2139552) :: v_0
    real, dimension(1:2162808) :: w_0
    real, dimension(1:2074891) :: f_1
    real, dimension(1:2074891) :: g_1
    real, dimension(1:2074891) :: h_1
    integer, parameter :: ST_STAGE_KERNEL_1 = 1 ! stage_kernel_1
    integer :: state_ptr
    ! Loops over stage calls
    state_ptr = ST_STAGE_KERNEL_1
    do global_id = 1, 2162808
      call velfg_superkernel(u_0, v_0, w_0, f_1, g_1, h_1,state_ptr)
    end do

end program main  

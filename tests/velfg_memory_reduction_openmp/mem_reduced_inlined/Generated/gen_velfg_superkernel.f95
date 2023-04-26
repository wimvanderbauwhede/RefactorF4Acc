program main
use module_velfg_superkernel, only : velfg_superkernel
      implicit none
    integer :: global_id
!    ! common /ocl/ global_id
!    ! Declarations
    real, dimension(-1:301) :: dx1_0
    real, dimension(0:301) :: dy1_0
    real, dimension(-1:92) :: dzn_0
    real, dimension(-1:92) :: dzs_0
    integer :: th_idx_0
    real, dimension(1:8418552) :: u_0
    real, dimension(1:8418552) :: v_0
    real, dimension(1:8510058) :: w_0
    real, dimension(1:8244691) :: f_1
    real, dimension(1:8244691) :: g_1
    real, dimension(1:8244691) :: h_1
      integer, parameter :: st_stage_kernel_1=1
    integer :: state_ptr
      integer, parameter :: niters=5
    integer :: iter
!    ! Loops over stage calls
    state_ptr = st_stage_kernel_1
    do iter = 1, niters
    print *, iter
    do global_id = 1, 8510058
      call velfg_superkernel(dx1_0, dy1_0, dzn_0, dzs_0, th_idx_0, u_0, v_0, w_0, f_1, g_1, h_1,state_ptr)
    end do
    end do
end program main  

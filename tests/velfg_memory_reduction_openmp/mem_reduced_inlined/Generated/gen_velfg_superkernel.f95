program main
use module_velfg_superkernel, only : velfg_superkernel
!    ! integer :: global_id
!    ! common /ocl/ global_id
!    ! Declarations
      implicit none
    integer :: i
    integer :: j
    integer :: k
    real, dimension(-1:301) :: dx1_0
    real, dimension(0:301) :: dy1_0
    real, dimension(-1:92) :: dzn_0
    real, dimension(-1:92) :: dzs_0
    integer :: global_id_0
    real, dimension(1:8418552) :: u_0
    real, dimension(1:8418552) :: v_0
    real, dimension(1:8510058) :: w_0
    real, dimension(1:8244691) :: f_1
    real, dimension(1:8244691) :: g_1
    real, dimension(1:8244691) :: h_1
      integer, parameter :: st_stage_kernel_1=1
    integer :: state_ptr
      integer, parameter :: niters=10
    integer :: iter
#ifdef TIMING
    integer :: clock_rate
    integer, dimension(0:1) :: timestamp
#endif
#ifdef TIMING
    call system_clock(timestamp(0), clock_rate)
#endif
!    ! Loops over stage calls
    state_ptr = st_stage_kernel_1
    do iter = 1, niters
    print *, iter
    do global_id_0 = 1, 8510058
      call velfg_superkernel(dx1_0, dy1_0, dzn_0, dzs_0, global_id_0, u_0, v_0, w_0, f_1, g_1, h_1,state_ptr)
    end do
    end do
#ifdef TIMING
    call system_clock(timestamp(1), clock_rate)
    print '(f6.3)',(timestamp(1)-timestamp(0))/ real(clock_rate)
#endif
end program main  

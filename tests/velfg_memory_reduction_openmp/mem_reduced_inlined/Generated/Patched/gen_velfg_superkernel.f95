program main
use singleton_module_velfg_superkernel, only : velfg_superkernel
!    ! integer :: global_id
!    ! common /ocl/ global_id
!    ! Declarations
      implicit none
      integer, parameter :: ip=300
     integer, parameter :: jp=300
     integer, parameter :: kp=90
    integer :: i,j,k     
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

    integer :: clock_rate
    integer (kind=4), dimension(0:1) :: timestamp 

    do k = -1,kp+2
      dzn_0(k)=1.
      dzs_0(k)=1.
    end do
    do i = -1,ip+1
        dx1_0(i)=1.
        ! delx1(i)=1.
    end do
    do j = 0,jp+1
      dy1_0(j)=1.
    end do

    f_1 = 1.0; g_1 = 1.0; h_1 = 1.0
    u_0 = 1.0; v_0 = 1.0; w_0 = 1.0

    call system_clock(timestamp(0), clock_rate)
    
!    ! Loops over stage calls
    state_ptr = st_stage_kernel_1
    do iter = 1, niters
    print *, iter
    do global_id_0 = 1, 300*300*90
      call velfg_superkernel(dx1_0, dy1_0, dzn_0, dzs_0, global_id_0, u_0, v_0, w_0, f_1, g_1, h_1,state_ptr)
    end do
    end do

    call system_clock(timestamp(1), clock_rate)
    print '(f6.3)',(timestamp(1)-timestamp(0))/ real(clock_rate)
   print *, sum(f_1)
   print *, sum(g_1)
   print *, sum(h_1)    
end program main  

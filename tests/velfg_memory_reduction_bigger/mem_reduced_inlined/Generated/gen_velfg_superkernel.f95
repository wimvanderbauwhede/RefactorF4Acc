program main
use module_velfg_superkernel, only : velfg_superkernel
! Grouped Parameter Declarations
      implicit none
      integer, parameter :: st_stage_kernel_1=1
      integer, parameter :: niters=5
! BEGIN new declarations
! END new declarations
    integer :: global_id
!    ! Declarations
    real, dimension(1:2139552) :: u_0
    real, dimension(1:2139552) :: v_0
    real, dimension(1:2162808) :: w_0
    real, dimension(1:2074891) :: f_1
    real, dimension(1:2074891) :: g_1
    real, dimension(1:2074891) :: h_1
! Moved param decl for st_stage_kernel_1 in main to top of code unit
    integer :: state_ptr
! Moved param decl for niters in main to top of code unit
    integer :: iter
!    ! Loops over stage calls
    state_ptr = st_stage_kernel_1
    do iter = 1, niters
    print *, iter
    do global_id = 1, 2162808
      call velfg_superkernel(u_0,v_0,w_0,f_1,g_1,h_1,state_ptr)

    end do
    end do
end program main  


program main
#ifdef WITH_OPENMP    
use omp_lib
#endif 
use singleton_module_velfg_superkernel, only : velfg_superkernel
! Grouped Parameter Declarations
      implicit none
      integer, parameter :: st_stage_kernel_1=1
      integer, parameter :: niters=100
! BEGIN new declarations
integer :: clock_rate
integer (kind=4), dimension(0:1) :: timestamp 
! END new declarations
    integer :: global_id
!    ! Declarations
    real, dimension(1:2139552*4) :: u_0
    real, dimension(1:2139552*4) :: v_0
    real, dimension(1:2162808*4) :: w_0
    real, dimension(1:2074891*4) :: f_1
    real, dimension(1:2074891*4) :: g_1
    real, dimension(1:2074891*4) :: h_1
! Moved param decl for st_stage_kernel_1 in main to top of code unit
    integer :: state_ptr
! Moved param decl for niters in main to top of code unit
    integer :: iter
    u_0=0.0
    v_0=0.0
    w_0=0.0
    f_1=0.0
    g_1=0.0
    h_1=0.0
!    ! Loops over stage calls
    state_ptr = st_stage_kernel_1
call system_clock(timestamp(0), clock_rate)    
    do iter = 1, niters
    !print *, iter
#ifdef WITH_OPENMP
!$OMP PARALLEL DO
#endif      
    do global_id = 1, 2025000*4
      call velfg_superkernel(u_0,v_0,w_0,f_1,g_1,h_1,state_ptr,global_id)

    end do
#ifdef WITH_OPENMP
!$OMP END PARALLEL DO
#endif      
    end do
call system_clock(timestamp(1), clock_rate)
print '(f6.3)',(timestamp(1)-timestamp(0))/ real(clock_rate)
print *, f_1(2), g_1(3),h_1(4)    
end program main  

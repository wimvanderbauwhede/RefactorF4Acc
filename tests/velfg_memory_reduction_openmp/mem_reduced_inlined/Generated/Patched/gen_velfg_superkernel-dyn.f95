
program main
#define MM (WM*WM)
#ifdef WITH_OPENMP    
use omp_lib
#endif 
use singleton_module_velfg_superkernel, only : velfg_superkernel
! Grouped Parameter Declarations
      implicit none
      integer, parameter :: st_stage_kernel_1=1
      integer, parameter :: niters=1
! BEGIN new declarations
integer :: clock_rate
integer (kind=4), dimension(0:1) :: timestamp 
! END new declarations
    integer*8 :: global_id
!    ! Declarations
#ifdef DYN_ALLOC    
real, allocatable  :: u_0(:)
real, allocatable :: v_0(:)
real, allocatable :: w_0(:)
real, allocatable :: f_1(:)
real, allocatable :: g_1(:)
real, allocatable :: h_1(:)
#else
    real, dimension(1:2139552*MM) :: u_0
    real, dimension(1:2139552*MM) :: v_0
    real, dimension(1:2162808*MM) :: w_0
    real, dimension(1:2074891*MM) :: f_1
    real, dimension(1:2074891*MM) :: g_1
    real, dimension(1:2074891*MM) :: h_1
#endif    
! Moved param decl for st_stage_kernel_1 in main to top of code unit
    integer :: state_ptr
! Moved param decl for niters in main to top of code unit
    integer :: iter
#ifdef DYN_ALLOC  
    allocate(u_0(1:2139552_8*MM))
    allocate(v_0(1:2139552_8*MM))
    allocate(w_0(1:2162808_8*MM))
    allocate(f_1(1:2074891_8*MM))
    allocate(g_1(1:2074891_8*MM))
    allocate(h_1(1:2074891_8*MM))
#endif
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
    do global_id = 1, 2025000_8*MM
        call velfg_superkernel(u_0,v_0,w_0,f_1,g_1,h_1,state_ptr,global_id)
    end do
#ifdef WITH_OPENMP
!$OMP END PARALLEL DO
#endif      
    end do
call system_clock(timestamp(1), clock_rate)
print '(f8.3)',(timestamp(1)-timestamp(0))/ real(clock_rate)
!print *, f_1(2), g_1(3),h_1(4)    
#ifdef DYN_ALLOC  
    deallocate(u_0)
    deallocate(v_0)
    deallocate(w_0)
    deallocate(f_1)
    deallocate(g_1)
    deallocate(h_1)
#endif
end program main  

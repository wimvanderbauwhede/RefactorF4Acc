program main

#ifdef WITH_OPENMP    
use omp_lib
#endif
use singleton_module_velfg_superkernel, only : velfg_superkernel
!    ! integer :: global_id
!    ! common /ocl/ global_id
!    ! Declarations
      implicit none
     integer, parameter :: ip=150*WM

     integer, parameter :: jp=150*WM

     integer, parameter :: kp=90
    integer :: i
    integer :: j
    integer :: k
#ifdef DYN_ALLOC
    real, allocatable :: dx1_0(:)
#else
    real, dimension(-1:(150*WM+1)) :: dx1_0
#endif
#ifdef DYN_ALLOC
    real, allocatable :: dy1_0(:)
#else
    real, dimension(0:(150*WM+1)) :: dy1_0
#endif
#ifdef DYN_ALLOC
    real, allocatable :: dzn_0(:)
#else
    real, dimension(-1:92_8*MM) :: dzn_0
#endif
#ifdef DYN_ALLOC
    real, allocatable :: dzs_0(:)
#else
    real, dimension(-1:92_8*MM) :: dzs_0
#endif
    integer :: global_id_0
#ifdef DYN_ALLOC
    real, allocatable :: u_0(:)
#else
    real, dimension(1:92*(150*WM+2)*(150*WM+3)) :: u_0
#endif
#ifdef DYN_ALLOC
    real, allocatable :: v_0(:)
#else
    real, dimension(1:92*(150*WM+2)*(150*WM+3)) :: v_0
#endif
#ifdef DYN_ALLOC
    real, allocatable :: w_0(:)
#else
    real, dimension(1:93*(150*WM+2)*(150*WM+3)) :: w_0
#endif
#ifdef DYN_ALLOC
    real, allocatable :: f_1(:)
#else
    real, dimension(1:91*(150*WM+1)*(150*WM+1)) :: f_1
#endif
#ifdef DYN_ALLOC
    real, allocatable :: g_1(:)
#else
    real, dimension(1:91*(150*WM+1)*(150*WM+1)) :: g_1
#endif
#ifdef DYN_ALLOC
    real, allocatable :: h_1(:)
#else
    real, dimension(1:91*(150*WM+1)*(150*WM+1)) :: h_1
#endif
      integer, parameter :: st_stage_kernel_1=1
    integer :: state_ptr
      integer, parameter :: niters=10
    integer :: iter
#ifdef TIMING
    integer :: clock_rate
    integer, dimension(0:1) :: timestamp
#endif
#ifdef DYN_ALLOC
allocate(dx1_0(-1:(150*WM+1)))
allocate(dy1_0(0:(150*WM+1)))
allocate(dzn_0(-1:92))
allocate(dzs_0(-1:92))
allocate(u_0(1:92*(150*WM+2)*(150*WM+3)))
allocate(v_0(1:92*(150*WM+2)*(150*WM+3)))
allocate(w_0(1:93*(150*WM+2)*(150*WM+3)))
allocate(f_1(1:91*(150*WM+1)*(150*WM+1)))
allocate(g_1(1:91*(150*WM+1)*(150*WM+1)))
allocate(h_1(1:91*(150*WM+1)*(150*WM+1)))
#endif
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

#ifdef TIMING
    call system_clock(timestamp(0), clock_rate)
#endif
!    ! Loops over stage calls
    state_ptr = st_stage_kernel_1
    do iter = 1, niters
    ! print *, iter
#ifdef WITH_OPENMP
!$OMP PARALLEL DO
#endif
    do global_id_0 = 1, 150*WM*150*WM*90
      call velfg_superkernel(dx1_0, dy1_0, dzn_0, dzs_0, global_id_0, u_0, v_0, w_0, f_1, g_1, h_1,state_ptr)
    end do
#ifdef WITH_OPENMP
!$OMP END PARALLEL DO
#endif
    end do
#ifdef TIMING
    call system_clock(timestamp(1), clock_rate)
    write(*,fmt='(f6.3)',advance='no') (timestamp(1)-timestamp(0))/ real(clock_rate)
    ! print '(f6.3)',(timestamp(1)-timestamp(0))/ real(clock_rate)
#endif
#ifdef CHECKSUM    
   print *, sum(f_1)
   print *, sum(g_1)
   print *, sum(h_1)
#endif
#ifdef DYN_ALLOC
deallocate(dx1_0)
deallocate(dy1_0)
deallocate(dzn_0)
deallocate(dzs_0)
deallocate(u_0)
deallocate(v_0)
deallocate(w_0)
deallocate(f_1)
deallocate(g_1)
deallocate(h_1)
#endif
end program main  

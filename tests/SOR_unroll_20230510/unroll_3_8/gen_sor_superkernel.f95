program main
use singleton_module_sor_superkernel, only : sor_superkernel
!    ! integer :: global_id
!    ! common /ocl/ global_id
!    ! Declarations
      implicit none
     integer, parameter :: im=150
     integer, parameter :: jm=150
     integer, parameter :: km=90
    integer :: i
    integer :: j
    integer :: k
    integer :: global_id_0
    real, dimension(1:132921968) :: p0_0
    real, dimension(1:132921968) :: rhs_0
    real, dimension(1:132921968) :: p3_1
      integer(kind=4), parameter :: st_stage_kernel_1=1
    integer :: state_ptr
      integer(kind=4), parameter :: niters=8
    integer :: iter
#ifdef TIMING
    integer :: clock_rate
    integer, dimension(0:1) :: timestamp
#endif

    do i = 1,(im+2)*(jm+2)*(km+2)
        rhs_0(i) = 1.0
        p0_0(i) = 1.0
    end do


#ifdef TIMING
    call system_clock(timestamp(0), clock_rate)
#endif
!    ! Loops over stage calls
    state_ptr = st_stage_kernel_1
    do iter = 1, niters
    print *, iter
    do global_id_0 = 1,im*jm*km
      call sor_superkernel(global_id_0, p0_0, rhs_0, p3_1,state_ptr)
    end do
    end do
#ifdef TIMING
    call system_clock(timestamp(1), clock_rate)
    print '(f6.3)',(timestamp(1)-timestamp(0))/ real(clock_rate)
#endif
#ifdef CHECKSUM
    print *, p3_1((im+2)*(jm+2)*(km+2)/2+(jm+2)*(km+2)/2+(km+2)/2)
#endif
end program main  

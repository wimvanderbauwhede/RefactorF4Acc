program main
#ifdef WITH_OPENMP  
    use omp_lib
#endif    
    use module_velfg_superkernel, only : velfg_superkernel
    integer :: global_id
    ! Declarations
    integer, parameter :: niters = 10
integer, parameter :: ip=150*WM
integer, parameter :: jp=150*WM
integer, parameter :: kp=90 

!    real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)) :: u
!    real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)) :: v
!    real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)) :: w
!    real, dimension(0:ip,0:jp,0:kp) :: f
!    real, dimension(0:ip,0:jp,0:kp) :: g
!    real, dimension(0:ip,0:jp,0:kp) :: h

  real, allocatable :: u(:,:,:)
  real, allocatable :: v(:,:,:)
  real, allocatable :: w(:,:,:)
  real, allocatable :: f(:,:,:)
  real, allocatable :: g(:,:,:)
  real, allocatable :: h(:,:,:)
  real, allocatable :: diu1(:,:,:)
  real, allocatable :: diu2(:,:,:)
  real, allocatable :: diu3(:,:,:)
  real, allocatable :: diu4(:,:,:)
  real, allocatable :: diu5(:,:,:)
  real, allocatable :: diu6(:,:,:)
  real, allocatable :: diu7(:,:,:)
  real, allocatable :: diu8(:,:,:)
  real, allocatable :: diu9(:,:,:)
  real, allocatable :: cov1(:,:,:)
  real, allocatable :: cov2(:,:,:)
  real, allocatable :: cov3(:,:,:)
  real, allocatable :: cov4(:,:,:)
  real, allocatable :: cov5(:,:,:)
  real, allocatable :: cov6(:,:,:)
  real, allocatable :: cov7(:,:,:)
  real, allocatable :: cov8(:,:,:)
  real, allocatable :: cov9(:,:,:)
  real(kind=4), allocatable :: nou1(:,:,:)
  real(kind=4), allocatable :: nou5(:,:,:)
  real(kind=4), allocatable :: nou9(:,:,:)
  real(kind=4), allocatable :: nou2(:,:,:)
  real(kind=4), allocatable :: nou3(:,:,:)
  real(kind=4), allocatable :: nou4(:,:,:)
  real(kind=4), allocatable :: nou6(:,:,:)
  real(kind=4), allocatable :: nou7(:,:,:)
  real(kind=4), allocatable :: nou8(:,:,:)
  real, allocatable :: dfu1(:,:,:)
  real, allocatable :: dfv1(:,:,:)
  real, allocatable :: dfw1(:,:,:)
  ! real, allocatable :: sm(:,:,:)
    real, dimension((-1):(kp + 2)) :: dzn
    real, dimension((-1):(kp + 2)) :: dzs
    real, dimension((-1):(ip + 1)) :: dx1
    real, dimension((-1):(ip + 1)) :: delx1  
    real, dimension(0:(jp + 1)) :: dy1    
    integer :: i,j,k
    integer :: iter

    ! integer, parameter :: ST_ADAM_MAP_22 = 0 !  adam_map_22

    integer, parameter :: ST_LES_MAP_87 = 10 !  les_map_87
    integer, parameter :: ST_LES_MAP_107 = 11 !  les_map_107
    
    integer, parameter :: ST_velfg_MAP_76 = 18 !  velfg_map_76
    integer, parameter :: ST_velfg_MAP_133 = 19 !  velfg_map_133
    integer, parameter :: ST_velfg_MAP_155 = 20 !  velfg_map_155
    integer, parameter :: ST_velfg_MAP_218 = 28 !  velfg_map_218
    integer, dimension(5) :: states = (/  ST_velfg_MAP_76, ST_velfg_MAP_133, ST_velfg_MAP_218, ST_LES_MAP_87, ST_LES_MAP_107 /)
    integer :: state_ptr, state_idx
    integer :: clock_rate
    integer (kind=4), dimension(0:1) :: timestamp 

    allocate(u(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)))
    allocate(v(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)))
    allocate(w(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)))
    allocate(f(0:ip,0:jp,0:kp))
    allocate(g(0:ip,0:jp,0:kp))
    allocate(h(0:ip,0:jp,0:kp))

  allocate(diu1((-1):(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(diu2(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(diu3(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(diu4(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(diu5((-1):(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(diu6(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(diu7(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(diu8(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(diu9(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(cov1((-1):(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(cov2(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(cov3(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(cov4(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(cov5((-1):(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(cov6(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(cov7(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(cov8(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(cov9(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(nou1((-1):(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(nou5((-1):(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(nou9(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(nou2(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(nou3(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(nou4(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(nou6(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(nou7(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(nou8(0:(ip + 2),0:(jp + 2),0:(kp + 2)))
  allocate(dfu1(0:ip,1:jp,1:kp)  )
  allocate(dfv1(1:ip,0:jp,1:kp) )
  allocate(dfw1(1:ip,1:jp,1:kp) )
  ! allocate(sm((-1):(ip + 1),(-1):(jp + 1),0:(kp + 1)) )

    do k = -1,kp+2
      dzn(k)=1.
      dzs(k)=1.
    end do
    do i = -1,ip+1
        dx1(i)=1.
        delx1(i)=1.
    end do
    do j = 0,jp+1
      dy1(j)=1.
    end do
    call system_clock(timestamp(0), clock_rate)
    do iter = 1,niters
      !print *,iter
    ! Loops over stage calls    
      
      do state_idx = 1,3
      state_ptr=states(state_idx)
!$OMP PARALLEL DO
      do global_id = 1, ip*jp*kp
        ! call velfg_superkernel(f,g,h,dzn,u,v,w,dx1,dy1,dzs,state_ptr,global_id)
        ! Because of the dyn alloc, all the temp arrays need to be passed in here
        call velfg_superkernel(f,g,h,dzn,u,v,w,dx1,dy1,dzs,state_ptr, global_id, &
    diu1, diu2, diu3, diu4, diu5, diu6, diu7, diu8, diu9, &
    cov1, cov2, cov3, cov4, cov5, cov6, cov7, cov8, cov9, &
    nou1, nou5, nou9, nou2, nou3, nou4, nou6, nou7, nou8, &
    dfu1, dfv1, dfw1 &
                )
        !print *, iter,global_id
      end do
!$OMP END PARALLEL DO
      end do
!    print *, f(1,1,1)
    end do
    call system_clock(timestamp(1), clock_rate)
    print '(f6.3)',(timestamp(1)-timestamp(0))/ real(clock_rate)
!    print *, f(1,1,1)
end program main  

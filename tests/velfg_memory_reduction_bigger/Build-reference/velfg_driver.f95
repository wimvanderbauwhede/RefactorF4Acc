program main
    use omp_lib
    use module_velfg_superkernel, only : velfg_superkernel
    integer :: global_id
    ! Declarations
    integer, parameter :: niters = 100
integer, parameter :: ip=450
integer, parameter :: jp=450
integer, parameter :: kp=90 

    real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)) :: u
    real, dimension(0:(ip + 1),(-1):(jp + 1),0:(kp + 1)) :: v
    real, dimension(0:(ip + 1),(-1):(jp + 1),(-1):(kp + 1)) :: w
    real, dimension(0:ip,0:jp,0:kp) :: f
    real, dimension(0:ip,0:jp,0:kp) :: g
    real, dimension(0:ip,0:jp,0:kp) :: h
    

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
      
      do state_idx = 1,5
      state_ptr=states(state_idx)
!$OMP PARALLEL DO
      do global_id = 1, 2025000*3*3
        call velfg_superkernel(f,g,h,dzn,u,v,w,dx1,dy1,dzs,state_ptr, global_id)
!        print *, iter,global_id
      end do
!$OMP END PARALLEL DO
      end do
!    print *, f(1,1,1)
    end do
    call system_clock(timestamp(1), clock_rate)
    print '(f6.3)',(timestamp(1)-timestamp(0))/ real(clock_rate)
    print *, f(1,1,1)
end program main  

program main
    use module_velfg_superkernel, only : velfg_superkernel
    integer :: global_id
    common /ocl/ global_id
    ! Declarations
    real, dimension(1:2139552) :: u
    real, dimension(1:2139552) :: v
    real, dimension(1:2162808) :: w
    real, dimension(1:2074891) :: f
    real, dimension(1:2074891) :: g
    real, dimension(1:2074891) :: h

    integer, parameter :: ip=150
    integer, parameter :: jp=150
    integer, parameter :: kp=90 
    real, dimension((-1):(kp + 2)) :: dzn
    real, dimension((-1):(kp + 2)) :: dzs
    real, dimension((-1):(ip + 1)) :: dx1
    real, dimension((-1):(ip + 1)) :: delx1  
    real, dimension(0:(jp + 1)) :: dy1    
    integer :: i,j,k
    integer :: iter
    integer, parameter :: niters = 50

    ! integer, parameter :: ST_ADAM_MAP_22 = 0 !  adam_map_22

    integer, parameter :: ST_LES_MAP_87 = 10 !  les_map_87
    integer, parameter :: ST_LES_MAP_107 = 11 !  les_map_107
    
    integer, parameter :: ST_velfg_MAP_76 = 18 !  velfg_map_76
    integer, parameter :: ST_velfg_MAP_133 = 19 !  velfg_map_133
    integer, parameter :: ST_velfg_MAP_155 = 20 !  velfg_map_155
    integer, parameter :: ST_velfg_MAP_218 = 28 !  velfg_map_218
    integer, dimension(5) :: states = (/  ST_velfg_MAP_76, ST_velfg_MAP_133, ST_velfg_MAP_218, ST_LES_MAP_87, ST_LES_MAP_107 /)
    integer :: state_ptr, state_idx
    

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
    do iter = 1,niters
    !  print *,iter
    ! Loops over stage calls    
      do state_idx = 1,5
      state_ptr=states(state_idx)
      do global_id = 1, 2025000 !2074891
        call velfg_superkernel(f,g,h,dzn,u,v,w,delx1,dx1,dy1,dzs,state_ptr)
      end do
      end do
    end do
end program main  

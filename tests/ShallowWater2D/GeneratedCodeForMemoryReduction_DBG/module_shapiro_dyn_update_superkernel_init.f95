module module_shapiro_dyn_update_superkernel_init

        integer(4), parameter :: nx = 50 
        integer(4), parameter :: ny = 50 
        integer, dimension(0:2) :: global_ids
        ! common /ocl/ global_ids

        contains       

        subroutine init(hzero,eta,etan,wet)
                implicit none
                integer :: i,j
                integer :: k
                real, dimension(0:ny+1,0:nx+1), intent(InOut) :: hzero
                real, dimension(0:ny+1,0:nx+1), intent(InOut) :: eta
                real, dimension(0:ny+1,0:nx+1), intent(Out) :: etan
                integer, dimension(0:ny+1,0:nx+1), intent(Out) :: wet
            ! initial conditions
            do j = 0,ny+1
            do k = 0,nx+1
            hzero(j,k) = 10.0 
            end do
            end do
            ! land boundaries with 10 m elevation
            do k = 0,nx+1
            hzero(0,k) = -10.0
            hzero(ny+1,k) = -10.0
            end do
            
            do j = 0,ny+1
            hzero(j,0) = -10.0
            hzero(j,nx+1) = -10.0
            end do
            do j = 0,ny+1
            do k = 0,nx+1
            eta(j,k) = -min(0.0,hzero(j,k))
            etan(j,k) = eta(j,k)
            end do
            end do
            do i=0,nx+1
                do j=0,ny+1
                    if (i > nx/5 .and. i<2*nx/5 .and. j > ny/5 .and. j<2*ny/5 ) then
                        wet(i,j) = 1
                    else
                        wet(i,j)=0
                    end if    
                end do
            end do
            end subroutine init

        subroutine get_global_id(idx,dim)
                integer, intent(in) :: dim
                integer, intent(out) :: idx
                ! integer :: global_id
                ! common /ocl/ global_ids
                idx = global_ids(dim)
        end subroutine get_global_id

        subroutine set_global_id(idx,dim)
                integer, intent(in) :: dim
                integer, intent(in) :: idx
                ! integer :: global_id
                ! common /ocl/ global_ids
                global_ids(dim) = idx
        end subroutine set_global_id        
end module module_shapiro_dyn_update_superkernel_init
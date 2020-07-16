module singleton_module_src_update_loc_vel

contains

      subroutine update_loc_vel(u,un,v,vn,x,xn,y,yn)
! === Original code from corio starts here ===
      implicit none
      integer, parameter :: im=100
      integer, parameter :: jm=100
      integer, parameter :: km=50
        real, dimension(1:im,1:jm,1:km), intent(In) :: yn
        real, dimension(1:im,1:jm,1:km), intent(Out) :: y
        real, dimension(1:im,1:jm,1:km), intent(In) :: xn
        real, dimension(1:im,1:jm,1:km), intent(Out) :: x
        real, dimension(1:im,1:jm,1:km), intent(In) :: vn
        real, dimension(1:im,1:jm,1:km), intent(Out) :: v
        real, dimension(1:im,1:jm,1:km), intent(In) :: un
        real, dimension(1:im,1:jm,1:km), intent(Out) :: u
      integer :: k
  integer :: j
  integer :: i
do i=1,im
  do j=1,jm
    do k=1,km
      u(i,j,k) = un(i,j,k)
      v(i,j,k) = vn(i,j,k)
      x(i,j,k) = xn(i,j,k)
      y(i,j,k) = yn(i,j,k)
    end do
  end do
end do
      end subroutine update_loc_vel

end module singleton_module_src_update_loc_vel


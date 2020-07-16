module singleton_module_src_predict_loc

contains

      subroutine predict_loc(un,vn,x,xn,y,yn)
! === Original code from corio starts here ===
      implicit none
      integer, parameter :: dmax=1000
      real, parameter :: dt=24.*3600./200.
      integer, parameter :: im=100
      integer, parameter :: jm=100
      integer, parameter :: km=50
        real, dimension(1:im,1:jm,1:km), intent(Out) :: yn
        real, dimension(1:im,1:jm,1:km), intent(In) :: y
        real, dimension(1:im,1:jm,1:km), intent(Out) :: xn
        real, dimension(1:im,1:jm,1:km), intent(In) :: x
        real, dimension(1:im,1:jm,1:km), intent(In) :: vn
        real, dimension(1:im,1:jm,1:km), intent(In) :: un
      integer :: k
  integer :: j
  integer :: i
do i=1,im
  do j=1,jm
      do k=1,km        
          xn(i,j,k) = x(i,j,k) + dt*un(i,j,k)/dmax
          yn(i,j,k) = y(i,j,k) + dt*vn(i,j,k)/dmax
      end do
  end do
end do
      end subroutine predict_loc

end module singleton_module_src_predict_loc


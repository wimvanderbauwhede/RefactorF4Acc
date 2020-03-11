subroutine predict_vel(u,un,v,vn)
      real, parameter :: dt = 432.000000 
      real, parameter :: pi = 3.14159274 
      real, parameter :: freq = -7.27220540E-05 
      real, parameter :: f = -1.45444108E-04 
      real, parameter :: alpha = -6.28318563E-02 
      real, parameter :: beta = 9.86960484E-04 
      integer, parameter :: im = 10 
      integer, parameter :: jm = 10 
      integer, parameter :: km = 5 
      real, dimension(1:10,1:10,1:5), intent(Out) :: vn
      real, dimension(1:10,1:10,1:5), intent(In) :: v
      real, dimension(1:10,1:10,1:5), intent(Out) :: un
      real, dimension(1:10,1:10,1:5), intent(In) :: u
      integer :: k
      integer :: j
      integer :: i
    do i = 1, 10, 1
        do j = 1, 10, 1
            do k = 1, 5, 1
                un(i,j,k) = (u(i,j,k)*(0.99901307)+-6.283186e-2*v(i,j,k))/(1.0009869)
                vn(i,j,k) = (v(i,j,k)*(0.99901307)--6.283186e-2*u(i,j,k))/(1.0009869)
            end do
        end do
    end do
end subroutine predict_vel

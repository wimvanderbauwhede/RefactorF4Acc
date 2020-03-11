subroutine corio_core(u,v,x,y)
      real, parameter :: dt = 432.000000 
      real, parameter :: pi = 3.14159274 
      real, parameter :: freq = -7.27220540E-05 
      real, parameter :: f = -1.45444108E-04 
      real, parameter :: alpha = -6.28318563E-02 
      real, parameter :: beta = 9.86960484E-04 
      integer, parameter :: dmax = 1000 
      integer, parameter :: im = 10 
      integer, parameter :: jm = 10 
      integer, parameter :: km = 5 
      real, dimension(1:10,1:10,1:5), intent(InOut) :: y
      real, dimension(1:10,1:10,1:5), intent(InOut) :: x
      real, dimension(1:10,1:10,1:5), intent(InOut) :: v
      real, dimension(1:10,1:10,1:5), intent(InOut) :: u
      real, dimension(1:10,1:10,1:5) :: yn
      real, dimension(1:10,1:10,1:5) :: xn
      real, dimension(1:10,1:10,1:5) :: vn
      real, dimension(1:10,1:10,1:5) :: un
      integer :: k
      integer :: j
      integer :: i
    do i = 1, 10, 1
        do j = 1, 10, 1
            do k = 1, 5, 1
                un(i,j,k) = (u(i,j,k)*(9.869605e-4)+-6.283186e-2*v(i,j,k))/(9.869605e-4)
                vn(i,j,k) = (v(i,j,k)*(9.869605e-4)--6.283186e-2*u(i,j,k))/(9.869605e-4)
            end do
        end do
    end do
    do i = 1, 10, 1
        do j = 1, 10, 1
            do k = 1, 5, 1
                xn(i,j,k) = x(i,j,k)+432.0*un(i,j,k)/1000
                yn(i,j,k) = y(i,j,k)+432.0*vn(i,j,k)/1000
            end do
        end do
    end do
    do i = 1, 10, 1
        do j = 1, 10, 1
            do k = 1, 5, 1
                u(i,j,k) = un(i,j,k)
                v(i,j,k) = vn(i,j,k)
                x(i,j,k) = xn(i,j,k)
                y(i,j,k) = yn(i,j,k)
            end do
        end do
    end do
end subroutine corio_core

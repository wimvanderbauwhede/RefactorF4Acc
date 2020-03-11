program corio
      integer, parameter :: im = 10 
      integer, parameter :: jm = 10 
      integer, parameter :: km = 5 
      integer, parameter :: dmax = 1000 
      integer :: k
      real, dimension(1:im,1:jm,1:km) :: u
      real, dimension(1:im,1:jm,1:km) :: v
      real, dimension(1:im,1:jm,1:km) :: un
      real, dimension(1:im,1:jm,1:km) :: vn
      real, dimension(1:im,1:jm,1:km) :: x
      real, dimension(1:im,1:jm,1:km) :: y
      real, dimension(1:im,1:jm,1:km) :: xn
      real, dimension(1:im,1:jm,1:km) :: yn
      integer :: n
      integer :: i
      integer :: j
      real, parameter :: pi = 3.14159274 
      real, parameter :: freq = -7.27220540E-05 
      real, parameter :: f = -1.45444108E-04 
      real, parameter :: dt = 432.000000 
      real, parameter :: alpha = -6.28318563E-02 
      real, parameter :: beta = 9.86960484E-04 
      integer, parameter :: ntot = 200 
    do i = 1, im, 1
        do j = 1, jm, 1
            do k = 1, km, 1
                u(i,j,k) = 0.5
                v(i,j,k) = 0.5
                x(i,j,k) = 0.
                y(i,j,k) = 5.
            end do
        end do
    end do
    open(10, file='output1.txt', form='formatted')
    write(10, *)(freq, dt, ntot)
    do n = 1, ntot, 1
        call predict_vel(u, un, v, vn)
        call predict_loc(un, vn, x, xn, y, yn)
        call update_loc_vel(u, un, v, vn, x, xn, y, yn)
    end do

end program corio
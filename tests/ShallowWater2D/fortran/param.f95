MODULE param

!INTEGER(4), PARAMETER :: nx = 51	
!INTEGER(4), PARAMETER :: ny = 51	

INTEGER(4), PARAMETER :: nx = 500
INTEGER(4), PARAMETER :: ny = 500


REAL :: hzero(0:ny+1,0:nx+1), h(0:ny+1,0:nx+1)
REAL :: eta(0:ny+1,0:nx+1),etan(0:ny+1,0:nx+1)
REAL :: u(0:ny+1,0:nx+1), un(0:ny+1,0:nx+1)
REAL :: v(0:ny+1,0:nx+1), vn(0:ny+1,0:nx+1)
REAL :: dt,dx,dy,g
REAL :: eps ! parameter for Shapiro filter

INTEGER :: j,k

INTEGER :: wet(0:ny+1,0:nx+1)
REAL :: hmin

END MODULE param

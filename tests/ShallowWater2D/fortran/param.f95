MODULE param

!INTEGER(4), PARAMETER :: nx = 51	
!INTEGER(4), PARAMETER :: ny = 51	

INTEGER(4), PARAMETER :: nx = 500
INTEGER(4), PARAMETER :: ny = 500


REAL :: hzero(0:ny+1,0:nx+1) !$RF4A Purpose(In)
REAL :: h(0:ny+1,0:nx+1) !$RF4A Purpose(Out)
REAL :: eta(0:ny+1,0:nx+1) !$RF4A Purpose(Out)
REAL :: etan(0:ny+1,0:nx+1) !$RF4A Purpose(Temp)
REAL :: u(0:ny+1,0:nx+1) !$RF4A Purpose(Out)
REAL :: un(0:ny+1,0:nx+1) !$RF4A Purpose(Temp)
REAL :: v(0:ny+1,0:nx+1) !$RF4A Purpose(Out)
REAL :: vn(0:ny+1,0:nx+1) !$RF4A Purpose(Temp)
REAL :: dt,dx,dy,g
REAL :: eps ! parameter for Shapiro filter

INTEGER :: j,k

INTEGER :: wet(0:ny+1,0:nx+1) !$RF4A Purpose(In)
REAL :: hmin

END MODULE param

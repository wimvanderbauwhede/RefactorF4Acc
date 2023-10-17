 program test_external
! BEGIN new declarations
 implicit none
 real :: fcn
! END new declarations
 real :: area
 real :: low
 real :: high
 external fcn
 low = 1.0
 high=2.0
 area = 4.0
       print *, fcn((low+high)*area)
 call runge(fcn,low,high,area) 
 end program test_external
 real function fcn(x)
! BEGIN new declarations
 implicit none
 real :: x
! END new declarations
 fcn = x*4.0-6.0 
 return
 end function fcn
 subroutine runge(f,x0,x1,a)
! BEGIN new declarations
 implicit none
 real, external :: f
 real :: x0
 real :: x1
 real :: a
! END new declarations
       print *, f((x0+x1)*a)
 return 
 end subroutine runge

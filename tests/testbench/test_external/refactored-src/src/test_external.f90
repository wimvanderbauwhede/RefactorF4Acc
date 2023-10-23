 program test_external
! BEGIN new declarations
! END new declarations
 implicit none
 real :: area
 real :: low
 real :: high
 external :: f2
 real :: fcn
 integer :: f2
 low = 1.0
 high=2.0
 area = 4.0
       print *, fcn((low+high)*area)
       print *, f2((low+high)*area)
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
 integer function f2(x)
! BEGIN new declarations
 implicit none
 real :: x
 real :: fcn
! END new declarations
 fcn = int(x)*4-6 
 return
 end function f2
 subroutine runge(f,x0,x1,a)
! BEGIN new declarations
 implicit none
 real :: f
 real :: x0
 real :: x1
 real :: a
! END new declarations
       print *, f((x0+x1)*a)
 return 
 end subroutine runge

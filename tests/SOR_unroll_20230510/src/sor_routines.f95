
module sor_routines
! use sor_params
contains

subroutine sor (pp0,pp1,rhs)
use sor_params
real, dimension(0:im+1,0:jm+1,0:km+1), intent(In) :: pp0
real, dimension(0:im+1,0:jm+1,0:km+1), intent(Out) :: pp1
real, dimension(0:im+1,0:jm+1,0:km+1), intent(In) :: rhs
integer :: i,j,k
#ifdef WITH_OPENMP
!$OMP PARALLEL DO
#endif
do i = 0,im+1
do j = 0,jm+1
do k = 0,km+1
call sor_kernel(pp0,pp1,rhs,i,j,k)
end do
end do
end do
#ifdef WITH_OPENMP
!$OMP END PARALLEL DO
#endif
end subroutine sor

subroutine sor_kernel(pp0_k,pp1_k,rhs_k,i,j,k) 
use sor_params
real, dimension(0:im+1,0:jm+1,0:km+1), intent(In) :: pp0_k
real, dimension(0:im+1,0:jm+1,0:km+1), intent(Out) :: pp1_k
real, dimension(0:im+1,0:jm+1,0:km+1), intent(In) :: rhs_k
integer, intent(In) :: i,j,k
real(kind=4), parameter :: cn1 = 1.0/3.0
real(kind=4), parameter :: cn2l = 0.5
real(kind=4), parameter :: cn2s = 0.5
real(kind=4), parameter :: cn3l = 0.5
real(kind=4), parameter :: cn3s = 0.5
real(kind=4), parameter :: cn4l = 0.5
real(kind=4), parameter :: cn4s = 0.5
real, parameter  :: omega = 1.0
real :: reltmp

! assume i=x =  west to east , y=j=south to north, k=z = vertical
if (i==im+1) then
! circular
! i=im+1
pp1_k(i,j,k) = pp0_k(i-im,j,k)
else if (i==0) then
! i=0
! circular
pp1_k(i,j,k) = pp0_k(i+im,j,k)
else if (j==jm+1) then
! open
! j = jm+1
pp1_k(i,j,k)=pp0_k(i-1,j,k)
else if (j==0) then
! fixed
! j = 0
! We keep the original values
    pp1_k(i,j,k)=pp0_k(i,j,k)
else if (k==0) then
    pp1_k(i,j,k)=pp0_k(i,j,k)
else if (k==km+1) then
    pp1_k(i,j,k)=pp0_k(i,j,k)
else
! the core
! The actual SOR expression
    reltmp = omega*(cn1 *(cn2l*pp0_k(i+1,j,k) + &
        cn2s*pp0_k(i-1,j,k) +cn3l*pp0_k(i,j+1,k) + &
        cn3s*pp0_k(i,j-1,k) +cn4l*pp0_k(i,j,k+1) + &
        cn4s*pp0_k(i,j,k-1) -rhs_k(i,j,k))-pp0_k(i,j,k))
    pp1_k(i,j,k) = pp0_k(i,j,k) +reltmp
end if

end subroutine sor_kernel

end module sor_routines
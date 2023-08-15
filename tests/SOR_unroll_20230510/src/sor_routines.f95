
module sor_routines
use sor_params
contains

subroutine sor (p0,p1,rhs)
    use sor_params    
real, dimension(0:im+1,0:jm+1,0:km+1), intent(In) :: p0
real, dimension(0:im+1,0:jm+1,0:km+1), intent(Out) :: p1
real, dimension(0:im+1,0:jm+1,0:km+1), intent(In) :: rhs 
integer :: i,j,k
#ifdef WITH_OPENMP
!$OMP PARALLEL DO
#endif
do i = 0,im+1
do j = 0,jm+1
do k = 0,km+1
call sor_kernel(p0,p1,rhs,i,j,k)
end do
end do
end do
#ifdef WITH_OPENMP
!$OMP END PARALLEL DO
#endif
end subroutine sor

subroutine sor_kernel(p0,p1,rhs,i,j,k) 
    use sor_params
real, dimension(0:im+1,0:jm+1,0:km+1), intent(In) :: p0
real, dimension(0:im+1,0:jm+1,0:km+1), intent(Out) :: p1
real, dimension(0:im+1,0:jm+1,0:km+1), intent(In) :: rhs 
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
p1(i,j,k) = p0(i-im,j,k)
else if (i==0) then
! i=0
! circular
p1(i,j,k) = p0(i+im,j,k)
else if (j==jm+1) then
! open
! j = jm+1
p1(i,j,k)=p0(i-1,j,k)
else if (j==0) then
! fixed
! j = 0
! We keep the original values
    p1(i,j,k)=p0(i,j,k)
else if (k==0) then
    p1(i,j,k)=p0(i,j,k)
else if (k==km+1) then
    p1(i,j,k)=p0(i,j,k)
else
! the core
! The actual SOR expression
    reltmp = omega*(cn1 *(cn2l*p0(i+1,j,k) + &
        cn2s*p0(i-1,j,k) +cn3l*p0(i,j+1,k) + &
        cn3s*p0(i,j-1,k) +cn4l*p0(i,j,k+1) + &
        cn4s*p0(i,j,k-1) -rhs(i,j,k))-p0(i,j,k))
    p1(i,j,k) = p0(i,j,k) +reltmp    
end if

end subroutine sor_kernel

end module sor_routines
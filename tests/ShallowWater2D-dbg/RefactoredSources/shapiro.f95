module singleton_module_shapiro

contains

subroutine shapiro(j,k,etan,wet,eps,eta)
      implicit none
      integer, parameter :: ny=500
      integer, parameter :: nx=500
#ifdef HAS_FOLD    
! local parameters
! Moved param decl for alpha in shapiro to top of code unit
#endif
! Grouped Parameter Declarations
      real, parameter :: alpha=1e-9
! BEGIN new declarations
      integer, intent(InOut) :: j
      integer, intent(InOut) :: k
      real, dimension(0:ny + 1,0:nx + 1), intent(In) :: etan
      integer, dimension(0:ny + 1,0:nx + 1), intent(In) :: wet
      real, intent(In) :: eps
      real, dimension(0:ny + 1,0:nx + 1), intent(InOut) :: eta
! END new declarations
real :: term1___shapiro
real :: term2___shapiro
real :: term3___shapiro
#ifdef HAS_FOLD    
!  Average value of eta, this is an invention to test reductions
real :: etan_avg___shapiro
etan_avg___shapiro = 0
do j = 1,ny
do k = 1,nx
etan_avg___shapiro = etan_avg___shapiro + etan(j,k)/(nx*ny)
end do
end do
#endif
!  1-order Shapiro filter
do j = 1,ny
do k = 1,nx
if(wet(j,k)==1)then
  term1___shapiro = (1.0-0.25*eps*(wet(j,k+1)+wet(j,k-1)+ wet(j+1,k)+wet(j-1,k)))*etan(j,k)
  term2___shapiro = 0.25*eps*(wet(j,k+1)*etan(j,k+1)+wet(j,k-1)*etan(j,k-1))
  term3___shapiro = 0.25*eps*(wet(j+1,k)*etan(j+1,k)+wet(j-1,k)*etan(j-1,k))
  eta(j,k) = term1___shapiro+term2___shapiro+term3___shapiro
else
  eta(j,k) = etan(j,k)
end if
#ifdef HAS_FOLD    
eta(j,k) = (1-alpha)*eta(j,k) + alpha*etan_avg___shapiro
#endif
end do
end do
end subroutine shapiro

end module singleton_module_shapiro


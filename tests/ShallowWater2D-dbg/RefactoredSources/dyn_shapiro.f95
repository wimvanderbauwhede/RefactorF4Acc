module singleton_module_dyn_shapiro

contains

      subroutine dyn_shapiro(dt,dx,dy,eps,eta,etan,g,h,hmin,hzero,j,k,u,un,v,vn,wet)
!ACC Begin Inline 
      implicit none
integer, parameter :: nx=500
integer, parameter :: ny=500
      real, parameter :: alpha=1e-9
real :: term1___shapiro
real :: term2___shapiro
real :: term3___shapiro
real :: etan_avg___shapiro
real, dimension(0:ny + 1,0:nx + 1) :: du___dyn
real, dimension(0:ny + 1,0:nx + 1) :: dv___dyn
real, dimension(0:ny+1,0:nx+1) :: du_f95___dyn
real, dimension(0:ny+1,0:nx+1) :: dv_f77___dyn
real :: uu___dyn
real :: vv___dyn
real :: duu___dyn
real :: dvv___dyn
real :: hue___dyn
real :: huw___dyn
real :: hwp___dyn
real :: hwn___dyn
real :: hen___dyn
real :: hep___dyn
real :: hvn___dyn
real :: hvs___dyn
real :: hsp___dyn
real :: hsn___dyn
real :: hnn___dyn
real :: hnp___dyn
      real, intent(In) :: dt
      real, intent(In) :: dx
      real, intent(In) :: dy
      real, intent(In) :: eps
      real, dimension(0:ny + 1,0:nx + 1), intent(InOut) :: eta
      real, dimension(0:ny + 1,0:nx + 1), intent(InOut) :: etan
      real, intent(In) :: g
      real, dimension(0:ny + 1,0:nx + 1), intent(In) :: h
      real :: hmin
      real, dimension(0:ny + 1,0:nx + 1) :: hzero
      integer, intent(InOut) :: j
      integer, intent(InOut) :: k
      real, dimension(0:ny + 1,0:nx + 1), intent(In) :: u
      real, dimension(0:ny + 1,0:nx + 1), intent(InOut) :: un
      real, dimension(0:ny + 1,0:nx + 1), intent(In) :: v
      real, dimension(0:ny + 1,0:nx + 1), intent(InOut) :: vn
      integer, dimension(0:ny + 1,0:nx + 1), intent(In) :: wet
do j = 1,ny
do k = 1,nx
  du___dyn(j,k) = -dt*g*(eta(j,k+1)-eta(j,k))/dx
  dv___dyn(j,k) = -dt*g*(eta(j+1,k)-eta(j,k))/dy
end do
end do
do j = 1,ny
do k = 1,nx
un(j,k) = 0.0
uu___dyn = u(j,k)
duu___dyn = du___dyn(j,k)
if(wet(j,k)==1) then
  if((wet(j,k+1)==1).or.(duu___dyn>0.0)) un(j,k) = uu___dyn+duu___dyn
else
  if((wet(j,k+1)==1).and.(duu___dyn<0.0)) un(j,k) = uu___dyn+duu___dyn
end if
vv___dyn = v(j,k)
dvv___dyn = dv___dyn(j,k)
vn(j,k) = 0.0
if(wet(j,k)==1) then
  if((wet(j+1,k)==1).or.(dv___dyn(j,k)>0.0)) vn(j,k) = vv___dyn+dvv___dyn
else
  if((wet(j+1,k)==1).and.(dv___dyn(j,k)<0.0)) vn(j,k) = vv___dyn+dvv___dyn
end if
end do
end do
do j = 1,ny
do k = 1,nx
  hep___dyn = 0.5*(un(j,k)+abs(un(j,k)))*h(j,k)
  hen___dyn = 0.5*(un(j,k)-abs(un(j,k)))*h(j,k+1)
  hue___dyn = hep___dyn+hen___dyn
  hwp___dyn = 0.5*(un(j,k-1)+abs(un(j,k-1)))*h(j,k-1)
  hwn___dyn = 0.5*(un(j,k-1)-abs(un(j,k-1)))*h(j,k)
  huw___dyn = hwp___dyn+hwn___dyn
  hnp___dyn = 0.5*(vn(j,k)+abs(vn(j,k)))*h(j,k)
  hnn___dyn = 0.5*(vn(j,k)-abs(vn(j,k)))*h(j+1,k)
  hvn___dyn = hnp___dyn+hnn___dyn
  hsp___dyn = 0.5*(vn(j-1,k)+abs(vn(j-1,k)))*h(j-1,k)
  hsn___dyn = 0.5*(vn(j-1,k)-abs(vn(j-1,k)))*h(j,k)
  hvs___dyn = hsp___dyn+hsn___dyn
  etan(j,k) = eta(j,k)-dt*(hue___dyn-huw___dyn)/dx-dt*(hvn___dyn-hvs___dyn)/dy
#ifdef DBG
  write(90,*)"j=",j," k=",k," etan=",etan(j,k)," eta=",eta(j,k)
#endif
end do
end do
#ifdef HAS_FOLD    
#endif
#ifdef HAS_FOLD    
etan_avg___shapiro = 0
do j = 1,ny
do k = 1,nx
etan_avg___shapiro = etan_avg___shapiro + etan(j,k)/(nx*ny)
end do
end do
#endif
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
!ACC End Inline
      end subroutine dyn_shapiro

end module singleton_module_dyn_shapiro


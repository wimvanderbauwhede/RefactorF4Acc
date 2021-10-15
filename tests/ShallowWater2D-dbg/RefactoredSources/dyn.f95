module singleton_module_dyn

contains

subroutine dyn(j,k,dt,dx,eta,g,dy,un,u,wet,v,vn,h,etan)
      implicit none
      integer, parameter :: ny=500
      integer, parameter :: nx=500
!  local parameters
! BEGIN new declarations
      integer, intent(InOut) :: j
      integer, intent(InOut) :: k
      real, intent(In) :: dt
      real, intent(In) :: dx
      real, dimension(0:ny + 1,0:nx + 1), intent(In) :: eta
      real, intent(In) :: g
      real, intent(In) :: dy
      real, dimension(0:ny + 1,0:nx + 1), intent(InOut) :: un
      real, dimension(0:ny + 1,0:nx + 1), intent(In) :: u
      integer, dimension(0:ny + 1,0:nx + 1), intent(In) :: wet
      real, dimension(0:ny + 1,0:nx + 1), intent(In) :: v
      real, dimension(0:ny + 1,0:nx + 1), intent(InOut) :: vn
      real, dimension(0:ny + 1,0:nx + 1), intent(In) :: h
      real, dimension(0:ny + 1,0:nx + 1), intent(InOut) :: etan
! END new declarations
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
do j = 1,ny
do k = 1,nx
  du___dyn(j,k) = -dt*g*(eta(j,k+1)-eta(j,k))/dx
  dv___dyn(j,k) = -dt*g*(eta(j+1,k)-eta(j,k))/dy
!  !DEBUG
!  !WRITE(90,*)"j = ",j," k = ",k," du = ",du(j,k)," dv = ",dv(j,k)
end do
end do
do j = 1,ny
do k = 1,nx
!  prediction for u
un(j,k) = 0.0
uu___dyn = u(j,k)
duu___dyn = du___dyn(j,k)
if(wet(j,k)==1) then
!   IF((wet(j,k+1)==1).or.(du(j,k)>0.0)) un(j,k) = uu+duu
  if((wet(j,k+1)==1).or.(duu___dyn>0.0)) un(j,k) = uu___dyn+duu___dyn
else
!   IF((wet(j,k+1)==1).and.(du(j,k)<0.0)) un(j,k) = uu+duu
  if((wet(j,k+1)==1).and.(duu___dyn<0.0)) un(j,k) = uu___dyn+duu___dyn
end if
!  prediction for v
vv___dyn = v(j,k)
dvv___dyn = dv___dyn(j,k)
vn(j,k) = 0.0
if(wet(j,k)==1) then
  if((wet(j+1,k)==1).or.(dv___dyn(j,k)>0.0)) vn(j,k) = vv___dyn+dvv___dyn
else
  if((wet(j+1,k)==1).and.(dv___dyn(j,k)<0.0)) vn(j,k) = vv___dyn+dvv___dyn
end if
! DEBUG
! WRITE(90,*)"j=",j," k=",k," un=",un(j,k)," vn=",vn(j,k), "wet(j,k)=", wet(j,k), " wet(j+1,k)=", wet(j+1,k), " uu=", uu, " duu=", duu, " vv=", vv, " dvv=", dvv
end do
end do
!  sea level predictor
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
!  !DEBUG
  write(90,*)"j=",j," k=",k," etan=",etan(j,k)," eta=",eta(j,k)
#endif
end do
end do
end subroutine dyn

end module singleton_module_dyn


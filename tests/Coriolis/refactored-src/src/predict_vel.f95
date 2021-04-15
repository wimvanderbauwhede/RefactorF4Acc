module singleton_module_src_predict_vel

contains

      subroutine predict_vel(u,un,v,vn)
! === Original code from corio starts here ===
      implicit none
      real, parameter :: dt=24.*3600./200.
      real, parameter :: pi=4.*atan(1.)
      real, parameter :: freq=-2.*pi/(24.*3600.)
      integer, parameter :: f=2*freq
      real, parameter :: alpha=f*dt
      real, parameter :: beta=0.25*alpha*alpha
      integer, parameter :: im=10
      integer, parameter :: jm=10
      integer, parameter :: km=5
              real, dimension(1:im,1:jm,1:km), intent(Out) :: vn
              real, dimension(1:im,1:jm,1:km), intent(In) :: v
              real, dimension(1:im,1:jm,1:km), intent(Out) :: un
              real, dimension(1:im,1:jm,1:km), intent(In) :: u
      integer :: k
        integer :: j
        integer :: i
        do i=1,im
        do j=1,jm
            do k=1,km
        !if (mode == 1) then      
            un(i,j,k) = (u(i,j,k)*(1-beta)+alpha*v(i,j,k))/(1+beta)
            vn(i,j,k) = (v(i,j,k)*(1-beta)-alpha*u(i,j,k))/(1+beta)
        ! else
        !   un = cos(alpha)*u+sin(alpha)*v
        !   vn = cos(alpha)*v-sin(alpha)*u
        ! end if
            end do
        end do
        end do
      end subroutine predict_vel

end module singleton_module_src_predict_vel


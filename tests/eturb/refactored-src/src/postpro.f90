module singleton_module_src_postpro

      use singleton_module_src_navier5
      use singleton_module_src_math
      use singleton_module_src_comm_mpi
contains

      subroutine comp_gije(gije,u,v,w,e,icall,nekcomm,nekgroup,nekreal,nid,np,if3d,dxm1,dxtm1,jacmi, &
      rxm1,sxm1,txm1,rym1,sym1,tym1,rzm1,szm1,tzm1,ifaxis,nrout,rname,dct,ncall,dcount,tmxmf, &
      ifneknek_GLOB,ttotal,etimes,tprep,ttime,istep,nvtot,ifsync,tgop,ngop)
      use params_SIZE, only : lx1, ly1, lz1, ldim, lelt
!!      use params_TOTAL ! ONLY LIST EMPTY
      implicit none
      integer, intent(In) :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer, intent(In) :: nid
      integer, intent(In) :: np
      logical, intent(In) :: if3d
      real, dimension(1:lx1,1:lx1), intent(In) :: dxm1
      real, dimension(1:lx1,1:lx1), intent(In) :: dxtm1
      real, dimension(1:lx1*ly1*lz1,1:lelt), intent(In) :: jacmi
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: tzm1
      logical, intent(In) :: ifaxis
      integer :: nrout
            integer, parameter :: maxrts=1000
      character(len=6), dimension(1:maxrts) :: rname
      real(kind=8), dimension(1:maxrts) :: dct
      integer, dimension(1:maxrts) :: ncall
      real(kind=8) :: dcount
      real(kind=8) :: tmxmf
      logical :: ifneknek_GLOB
      real(kind=8) :: ttotal
      real(kind=8) :: etimes
      real(kind=8) :: tprep
      real(kind=8) :: ttime
      integer :: istep
      integer(kind=8) :: nvtot
      logical :: ifsync
      real(kind=8) :: tgop
      integer :: ngop
      integer :: n
      integer :: nxyz
      integer :: k
      integer :: i
      real :: dj
      real, dimension(1:lx1*ly1*lz1,1:ldim,1:ldim), intent(Out) :: gije
      real, dimension(1:lx1*ly1*lz1), intent(In) :: u
      real, dimension(1:lx1*ly1*lz1), intent(In) :: v
      real, dimension(1:lx1*ly1*lz1), intent(In) :: w
      real, dimension(1:lx1*ly1*lz1) :: ur
      real, dimension(1:lx1*ly1*lz1) :: us
      real, dimension(1:lx1*ly1*lz1) :: ut
      integer :: e
      n    = lx1-1      
      nxyz = lx1*ly1*lz1
      if (if3d) then     
        do k=1,3
          call local_grad3(ur,us,ut,u,n,1,dxm1,dxtm1,nrout,rname,dct,ncall,dcount,tmxmf)
          call local_grad3(ur,us,ut,v,n,1,dxm1,dxtm1,nrout,rname,dct,ncall,dcount,tmxmf)
          call local_grad3(ur,us,ut,w,n,1,dxm1,dxtm1,nrout,rname,dct,ncall,dcount,tmxmf)
          do i=1,nxyz
            dj = jacmi(i,e)
            gije(i,k,1) = dj*(       ur(i)*rxm1(i,1,1,e)+us(i)*sxm1(i,1,1,e)+ut(i)*txm1(i,1,1,e))
            gije(i,k,2) = dj*(       ur(i)*rym1(i,1,1,e)+us(i)*sym1(i,1,1,e)+ut(i)*tym1(i,1,1,e))
            gije(i,k,3) = dj*(      ur(i)*rzm1(i,1,1,e)+us(i)*szm1(i,1,1,e)+ut(i)*tzm1(i,1,1,e))
          enddo
        enddo
      elseif (ifaxis) then   
            if(nid == 0) write(6,*)         'ABORT: comp_gije no axialsymmetric support for now'
            call exitt(icall,nekcomm,nekgroup,nekreal,nid,np,ifneknek_GLOB,ttotal,etimes,tprep, &
      ttime,istep,nvtot,ifsync,tgop,ngop)
      else              
        do k=1,2
          call local_grad2(ur,us,u,n,1,dxm1,dxtm1,nrout,rname,dct,ncall,dcount,tmxmf)
          call local_grad2(ur,us,v,n,1,dxm1,dxtm1,nrout,rname,dct,ncall,dcount,tmxmf)
          do i=1,nxyz
             dj = jacmi(i,e)
             gije(i,k,1)=dj*(ur(i)*rxm1(i,1,1,e)+us(i)*sxm1(i,1,1,e))
             gije(i,k,2)=dj*(ur(i)*rym1(i,1,1,e)+us(i)*sym1(i,1,1,e))
          enddo
        enddo
      endif
      return
      end subroutine comp_gije
      subroutine mag_tensor_e(mag,aije)
      use params_SIZE, only : lx1, ldim, ly1, lz1
      implicit none
      integer :: nxyz
      integer :: j
      integer :: i
      integer :: l
      real, dimension(1:lx1*ly1*lz1), intent(InOut) :: mag
      real, dimension(1:lx1*ly1*lz1,1:ldim,1:ldim), intent(In) :: aije
      nxyz = lx1*ly1*lz1
      call rzero(mag,nxyz)
      do j=1,ldim
      do i=1,ldim
      do l=1,nxyz 
         mag(l) = mag(l) + 0.5*aije(l,i,j)*aije(l,i,j)
  end do
      end do
      end do
      call vsqrt(mag,nxyz)
      return
      end subroutine mag_tensor_e
      subroutine comp_sije(gije)
      use params_SIZE, only : lx1, ldim, lz1, ly1
!!      use params_TOTAL ! ONLY LIST EMPTY
      implicit none
      integer :: nxyz
      integer :: k
      integer :: j
      integer :: i
      integer :: l
      real, dimension(1:lx1*ly1*lz1,1:ldim,1:ldim), intent(InOut) :: gije
      nxyz = lx1*ly1*lz1
      k = 1
      do j=1,ldim
      do i=k,ldim
         do l=1,nxyz
            gije(l,i,j) = 0.5*(gije(l,i,j)+gije(l,j,i))
            gije(l,j,i) = gije(l,i,j)
         enddo
      enddo
         k = k + 1
      enddo
      return
      end subroutine comp_sije

end module singleton_module_src_postpro


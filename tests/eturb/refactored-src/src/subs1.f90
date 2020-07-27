! -----------------------------------------------------------------------
module singleton_module_src_subs1

      use singleton_module_src_math
contains

      subroutine flush_io()
      return
      end subroutine flush_io
      subroutine setaxdy(ifaxdy,dam1,dam12,dam3,datm1,datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12, &
      dctm3,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3, &
      dztm1,dztm12,dztm3,idsess,ldimr,loglevel,ndim,nelt,nelv,nfield,nid,nio,npert,nx1,nx2,nx3, &
      nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,optlevel)
! 
      implicit none
      integer, parameter :: ldim=3
      integer, parameter :: lx1=8
      integer, parameter :: lxd=12
      integer, parameter :: lx2=lx1-2
      integer, parameter :: lelg=30*20*24
      integer, parameter :: lpmin=12
      integer, parameter :: lpmax=1024
      integer, parameter :: ldimt=1
      integer, parameter :: ldimt_proj=1
      integer, parameter :: lhis=1000
      integer, parameter :: maxobj=4
      integer, parameter :: lpert=1
      integer, parameter :: toteq=5
      integer, parameter :: nsessmax=2
      integer, parameter :: lxo=lx1
      integer, parameter :: mxprev=20
      integer, parameter :: lgmres=30
      integer, parameter :: lorder=3
      integer, parameter :: lx1m=lx1
      integer, parameter :: lfdm=0
      integer, parameter :: lelx=1
      integer, parameter :: lely=1
      integer, parameter :: lelz=1
      integer, parameter :: lelt=lelg/lpmin+3
      integer, parameter :: lbelt=1
      integer, parameter :: lpelt=1
      integer, parameter :: lcvelt=lelt
! 
!      Include file to dimension static arrays
!      and to set some hardwired run-time parameters
! 
      ! basic
      ! optional
      ! internals
!  - - SIZE internals
      ! averaging
      ! adjoint
      ! mhd
      integer :: nio
      ! cvode
      ! nek-nek
      integer :: loglevel
      integer :: optlevel
      integer :: nelv
      integer :: nelt
      integer :: nfield
      integer :: npert
      integer :: nid
      integer :: idsess
      integer :: nx1
      integer :: ny1
      integer :: nz1
      integer :: nx2
      integer :: ny2
      integer :: nz2
      integer :: nx3
      integer :: ny3
      integer :: nz3
      integer :: nxd
      integer :: nyd
      integer :: nzd
      integer :: ndim
      integer :: ldimr
! 
!      Elemental derivative operators
! 
      real, dimension(1:lx1,1:lx1) :: dxm1
      real, dimension(1:lx2,1:lx1) :: dxm12
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lx1,1:lx1) :: dxtm1
      real, dimension(1:lx1,1:lx2) :: dxtm12
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dytm1
      real, dimension(1:ly1,1:ly2) :: dytm12
      real, dimension(1:lz1,1:lz1) :: dztm1
      real, dimension(1:lz1,1:lz2) :: dztm12
      real, dimension(1:lx3,1:lx3) :: dxm3
      real, dimension(1:lx3,1:lx3) :: dxtm3
      real, dimension(1:ly3,1:ly3) :: dym3
      real, dimension(1:ly3,1:ly3) :: dytm3
      real, dimension(1:lz3,1:lz3) :: dzm3
      real, dimension(1:lz3,1:lz3) :: dztm3
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dcm1
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dctm1
      real, dimension(1:ly3,1:ly3) :: dcm3
      real, dimension(1:ly3,1:ly3) :: dctm3
      real, dimension(1:ly2,1:ly1) :: dcm12
      real, dimension(1:ly1,1:ly2) :: dctm12
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dam1
      real, dimension(1:ly1,1:ly1), intent(InOut) :: datm1
      real, dimension(1:ly2,1:ly1) :: dam12
      real, dimension(1:ly1,1:ly2) :: datm12
      real, dimension(1:ly3,1:ly3) :: dam3
      real, dimension(1:ly3,1:ly3) :: datm3
! 
      logical, intent(In) :: ifaxdy
! 
      real, dimension(1:1) :: dam1_copy
      real, dimension(1:1) :: datm1_copy
      real, dimension(1:1) :: dcm1_copy
      real, dimension(1:1) :: dctm1_copy
      real, dimension(1:1) :: dym1_copy
      real, dimension(1:1) :: dytm1_copy
      if (ifaxdy) then
         dym1_copy = reshape(dym1,shape(dym1_copy))
         dam1_copy = reshape(dam1,shape(dam1_copy))
         call copy(dym1_copy,dam1_copy,ly1*ly1)

         dym1 = reshape(dym1_copy, shape(dym1))
         dam1 = reshape(dam1_copy, shape(dam1))
         dytm1_copy = reshape(dytm1,shape(dytm1_copy))
         datm1_copy = reshape(datm1,shape(datm1_copy))
         call copy(dytm1_copy,datm1_copy,ly1*ly1)

         dytm1 = reshape(dytm1_copy, shape(dytm1))
         datm1 = reshape(datm1_copy, shape(datm1))
      else
         dym1_copy = reshape(dym1,shape(dym1_copy))
         dcm1_copy = reshape(dcm1,shape(dcm1_copy))
         call copy(dym1_copy,dcm1_copy,ly1*ly1)

         dym1 = reshape(dym1_copy, shape(dym1))
         dcm1 = reshape(dcm1_copy, shape(dcm1))
         dytm1_copy = reshape(dytm1,shape(dytm1_copy))
         dctm1_copy = reshape(dctm1,shape(dctm1_copy))
         call copy(dytm1_copy,dctm1_copy,ly1*ly1)

         dytm1 = reshape(dytm1_copy, shape(dytm1))
         dctm1 = reshape(dctm1_copy, shape(dctm1))
      endif
! 
      return
      end subroutine setaxdy

end module singleton_module_src_subs1


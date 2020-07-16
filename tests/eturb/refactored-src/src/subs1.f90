module singleton_module_src_subs1

      use singleton_module_src_math
contains

      subroutine flush_io()
      return
      end subroutine flush_io
      subroutine setaxdy(ifaxdy)
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
      integer :: nio
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
      real, dimension(1:ly1,1:ly1), intent(In) :: dcm1
      real, dimension(1:ly1,1:ly1), intent(In) :: dctm1
      real, dimension(1:ly3,1:ly3) :: dcm3
      real, dimension(1:ly3,1:ly3) :: dctm3
      real, dimension(1:ly2,1:ly1) :: dcm12
      real, dimension(1:ly1,1:ly2) :: dctm12
      real, dimension(1:ly1,1:ly1), intent(In) :: dam1
      real, dimension(1:ly1,1:ly1), intent(In) :: datm1
      real, dimension(1:ly2,1:ly1) :: dam12
      real, dimension(1:ly1,1:ly2) :: datm12
      real, dimension(1:ly3,1:ly3) :: dam3
      real, dimension(1:ly3,1:ly3) :: datm3
      logical, intent(In) :: ifaxdy
      if (ifaxdy) then
         call copy (dym1 ,dam1 ,ly1*ly1)
         call copy (dytm1,datm1,ly1*ly1)
      else
         call copy (dym1 ,dcm1 ,ly1*ly1)
         call copy (dytm1,dctm1,ly1*ly1)
      endif
      return
      end subroutine setaxdy

end module singleton_module_src_subs1


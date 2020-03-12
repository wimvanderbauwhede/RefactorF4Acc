module singleton_module_src_math

      use singleton_module_src_comm_mpi
contains

      subroutine vsqrt(a,n)
!!      use params_OPCTR ! ONLY LIST EMPTY
      implicit none
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(InOut) :: a
      do i = 1, n
 100     a(i) = sqrt(a(i))
      end do
      return
      end subroutine vsqrt
      subroutine rzero(a,n)
      implicit none
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(Out) :: a
      do i = 1, n
 100     a(i ) = 0.0
      end do
      return
      end subroutine rzero
      subroutine cfill(a,b,n)
      implicit none
      real, intent(In) :: b
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(Out) :: a
      do i = 1, n
 100     a(i) = b
      end do
      return
      end subroutine cfill
      subroutine copy(a,b,n)
      implicit none
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(Out) :: a
      real, dimension(1:1), intent(In) :: b
      do i=1,n
         a(i)=b(i)
      enddo
      return
      end subroutine copy
      subroutine icopy(a,b,n)
      implicit none
      integer, intent(In) :: n
      integer :: i
      integer, dimension(1:1), intent(Out) :: a
      integer, dimension(1:1), intent(In) :: b
      do i = 1, n
 100     a(i) = b(i)
      end do
      return
      end subroutine icopy
      subroutine cmult(a,const,n)
!!      use params_OPCTR ! ONLY LIST EMPTY
      implicit none
      real, intent(In) :: const
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(InOut) :: a
      do i=1,n
         a(i)=a(i)*const
  end do
      return
      end subroutine cmult
      subroutine cadd2(a,b,const,n)
!!      use params_OPCTR ! ONLY LIST EMPTY
      implicit none
      real, intent(In) :: const
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(Out) :: a
      real, dimension(1:1), intent(In) :: b
      do i=1,n
         a(i)=b(i)+const
  end do
      return
      end subroutine cadd2
      subroutine col2(a,b,n,tcol2)
!!      use params_OPCTR ! ONLY LIST EMPTY
      implicit none
      real(kind=8), intent(Out) :: tcol2
      integer, intent(In) :: n
      integer :: icalld
      real(kind=8) :: etime1
      integer :: i
      real, dimension(1:1), intent(InOut) :: a
      real, dimension(1:1), intent(In) :: b
#ifdef TIMER2
      if (icalld == 0) then
          icalld=1
          tcol2=0
      endif
      etime1 = dnekclock()
#endif
      do i=1,n
         a(i)=a(i)*b(i)
      enddo
#ifdef TIMER2
      tcol2 = tcol2+(dnekclock()-etime1)
#endif
      return
      end subroutine col2
      subroutine add2s2(a,b,c1,n,ta2s2)
!!      use params_OPCTR ! ONLY LIST EMPTY
      implicit none
      real(kind=8), intent(Out) :: ta2s2
      real, intent(In) :: c1
      integer, intent(In) :: n
      integer :: icalld
      real(kind=8) :: etime1
      integer :: i
      real, dimension(1:1), intent(InOut) :: a
      real, dimension(1:1), intent(In) :: b
#ifdef TIMER2
      if (icalld == 0) then
          icalld=1
          ta2s2=0
      endif
      etime1 = dnekclock()
#endif
      do i=1,n
        a(i)=a(i)+c1*b(i)
   end do
#ifdef TIMER2
      ta2s2 = ta2s2+(dnekclock()-etime1)
#endif
      return
      end subroutine add2s2
      real function glsum(x,n,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB,ngop_GLOB, &
      ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      implicit none
      integer :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: nid
      integer :: np
      logical :: ifsync_GLOB
      real(kind=8) :: tgop_GLOB
      integer :: ngop_GLOB
      logical :: ifneknek
      real(kind=8) :: ttotal
      real(kind=8) :: etimes
      real(kind=8) :: tprep
      real(kind=8) :: ttime
      integer :: istep
      integer(kind=8) :: nvtot
      integer :: n
      real :: tsum
      integer :: i
      real, dimension(1:1) :: x
      real, dimension(1:1) :: tmp
      real, dimension(1:1) :: work
      real, dimension(1:n) :: tmp_gop
      real, dimension(1:n) :: work_gop
      tsum = 0.
      do i=1,n
         tsum = tsum+x(i)
  end do
      tmp(1)=tsum
      call gop(tmp_gop,work_gop,'+  ',1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB, &
      ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      glsum = tmp(1)
      return
      end function glsum
      integer function iglmax(a,n,icall,nekcomm,nekgroup,nekreal,nid,np,ifneknek,ttotal,etimes, &
      tprep,ttime,istep,nvtot,ifsync,tgop,ngop)
      implicit none
      integer :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: nid
      integer :: np
      logical :: ifneknek
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
      integer :: i
      integer, dimension(1:1) :: a
      integer :: tmax
      integer, dimension(1:1) :: tmp
      integer, dimension(1:1) :: work
      tmax= -999999999
      do i=1,n
         tmax=max(tmax,a(i))
      enddo
      tmp(1)=tmax
      call igop(tmp,work,'M  ',1,icall,nekcomm,nekgroup,nekreal,nid,np,ifneknek,ttotal,etimes,tprep, &
      ttime,istep,nvtot,ifsync,tgop,ngop)
      iglmax=tmp(1)
      return
      end function iglmax
      real function glmax(a,n,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB,ngop_GLOB, &
      ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      implicit none
      integer :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: nid
      integer :: np
      logical :: ifsync_GLOB
      real(kind=8) :: tgop_GLOB
      integer :: ngop_GLOB
      logical :: ifneknek
      real(kind=8) :: ttotal
      real(kind=8) :: etimes
      real(kind=8) :: tprep
      real(kind=8) :: ttime
      integer :: istep
      integer(kind=8) :: nvtot
      integer :: n
      real :: tmax
      integer :: i
      real, dimension(1:1) :: a
      real, dimension(1:1) :: tmp
      real, dimension(1:1) :: work
      real, dimension(1:n) :: tmp_gop
      real, dimension(1:n) :: work_gop
      tmax=-99.0e20
      do i=1,n
         tmax=max(tmax,a(i))
   end do
      tmp(1)=tmax
      call gop(tmp_gop,work_gop,'M  ',1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB, &
      ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      glmax=tmp(1)
      return
      end function glmax
      real function glmin(a,n,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB,ngop_GLOB, &
      ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      implicit none
      integer :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: nid
      integer :: np
      logical :: ifsync_GLOB
      real(kind=8) :: tgop_GLOB
      integer :: ngop_GLOB
      logical :: ifneknek
      real(kind=8) :: ttotal
      real(kind=8) :: etimes
      real(kind=8) :: tprep
      real(kind=8) :: ttime
      integer :: istep
      integer(kind=8) :: nvtot
      integer :: n
      real :: tmin
      integer :: i
      real, dimension(1:1) :: a
      real, dimension(1:1) :: tmp
      real, dimension(1:1) :: work
      real, dimension(1:n) :: tmp_gop
      real, dimension(1:n) :: work_gop
      tmin=99.0e20
      do i=1,n
         tmin=min(tmin,a(i))
   end do
      tmp(1)=tmin
      call gop(tmp_gop,work_gop,'m  ',1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB, &
      ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      glmin = tmp(1)
      return
      end function glmin

end module singleton_module_src_math


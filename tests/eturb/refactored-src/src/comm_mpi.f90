module singleton_module_src_comm_mpi

      use singleton_module_src_mpi_dummy
      use singleton_module_src_math
      use singleton_module_src_papi
      use singleton_module_src_singlmesh
      use singleton_module_src_subs1
contains

      subroutine gop(x,w,op,n,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync,tgop,ngop,ifneknek_GLOB, &
      ttotal,etimes,tprep,ttime,istep,nvtot)
      use params_mpif_h, only : mpi_sum, mpi_max, mpi_min, mpi_prod
      implicit none
      integer :: icall
      integer, intent(In) :: nekcomm
      integer :: nekgroup
      integer, intent(In) :: nekreal
      integer, intent(In) :: nid
      integer :: np
      logical, intent(In) :: ifsync
      real(kind=8), intent(Out) :: tgop
      integer, intent(InOut) :: ngop
      logical :: ifneknek_GLOB
      real(kind=8) :: ttotal
      real(kind=8) :: etimes
      real(kind=8) :: tprep
      real(kind=8) :: ttime
      integer :: istep
      integer(kind=8) :: nvtot
      integer, intent(In) :: n
      integer :: icalld
      real(kind=8) :: etime1
      integer :: ierr
      real, dimension(1:n), intent(InOut) :: x
      real, dimension(1:n), intent(InOut) :: w
      character(len=3), intent(In) :: op
      call nekgsync(nekcomm,nekgroup,nekreal,nid,np)
#ifdef TIMER
      if (icalld == 0) then
        tgop =0.0d0
        ngop =0
        icalld=1
      endif
      ngop = ngop + 1
      etime1 = dnekclock()
#endif
      if (op == '+  ') then
         call mpi_allreduce(int(x, 4),int(w, 4),n,nekreal,mpi_sum,nekcomm,ierr)
      elseif (op == 'M  ') then
         call mpi_allreduce(int(x, 4),int(w, 4),n,nekreal,mpi_max,nekcomm,ierr)
      elseif (op == 'm  ') then
         call mpi_allreduce(int(x, 4),int(w, 4),n,nekreal,mpi_min,nekcomm,ierr)
      elseif (op == '*  ') then
         call mpi_allreduce(int(x, 4),int(w, 4),n,nekreal,mpi_prod,nekcomm,ierr)
      else
         write(6,*) nid,' OP ',op,' not supported.  ABORT in GOP.'
         call exitt(icall,nekcomm,nekgroup,nekreal,nid,np,ifneknek_GLOB,ttotal,etimes,tprep,ttime, &
      istep,nvtot,ifsync,tgop,ngop)
      endif
      call copy(x,w,n)
#ifdef TIMER
      tgop  = tgop+(dnekclock()-etime1)
#endif
      return
      end subroutine gop
      subroutine igop(x,w,op,n,icall,nekcomm,nekgroup,nekreal,nid,np,ifneknek_GLOB,ttotal,etimes, &
      tprep,ttime,istep,nvtot,ifsync,tgop,ngop)
      use params_mpif_h, only : mpi_min, mpi_prod, mpi_sum, mpi_max, mpi_integer
      implicit none
      integer, intent(In) :: icall
      integer, intent(In) :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer, intent(In) :: nid
      integer, intent(In) :: np
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
      integer, intent(In) :: n
      integer :: ierr
      integer, dimension(1:n), intent(InOut) :: x
      integer, dimension(1:n), intent(InOut) :: w
      character(len=3), intent(In) :: op
      if     (op == '+  ') then
        call mpi_allreduce(x,w,n,mpi_integer,mpi_sum,nekcomm,ierr)
      elseif (op == 'M  ') then
        call mpi_allreduce(x,w,n,mpi_integer,mpi_max,nekcomm,ierr)
      elseif (op == 'm  ') then
        call mpi_allreduce(x,w,n,mpi_integer,mpi_min,nekcomm,ierr)
      elseif (op == '*  ') then
        call mpi_allreduce(x,w,n,mpi_integer,mpi_prod,nekcomm,ierr)
      else
        write(6,*) nid,' OP ',op,' not supported.  ABORT in igop.'
        call exitt(icall,nekcomm,nekgroup,nekreal,nid,np,ifneknek_GLOB,ttotal,etimes,tprep,ttime, &
      istep,nvtot,ifsync,tgop,ngop)
      endif
      call icopy(x,w,n)
      return
      end subroutine igop
      real *8 function dnekclock()
!!      use params_mpif_h ! ONLY LIST EMPTY
      implicit none
      dnekclock = mpi_wtime()
      return
      end function dnekclock
      real *8 function dnekclock_sync(nekcomm,nekgroup,nekreal,nid,np)
!!      use params_mpif_h ! ONLY LIST EMPTY
      implicit none
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: nid
      integer :: np
      call nekgsync(nekcomm,nekgroup,nekreal,nid,np)
      dnekclock_sync = mpi_wtime()
      return
      end function dnekclock_sync
      subroutine nekgsync(nekcomm,nekgroup,nekreal,nid,np)
!!      use params_mpif_h ! ONLY LIST EMPTY
      implicit none
      integer, intent(In) :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: nid
      integer :: np
      integer :: ierr
      call mpi_barrier(nekcomm,ierr)
      return
      end subroutine nekgsync
      subroutine exitt(icall,nekcomm,nekgroup,nekreal,nid,np,ifneknek,ttotal_GLOB,etimes_GLOB, &
      tprep_GLOB,ttime_GLOB,istep_GLOB,nvtot_GLOB,ifsync,tgop,ngop)
!!      use params_SIZE ! ONLY LIST EMPTY
!!      use params_TOTAL ! ONLY LIST EMPTY
      implicit none
      integer, intent(In) :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer, intent(In) :: nid
      integer, intent(In) :: np
      logical, intent(In) :: ifneknek
      real(kind=8) :: ttotal_GLOB
      real(kind=8) :: etimes_GLOB
      real(kind=8) :: tprep_GLOB
      real(kind=8) :: ttime_GLOB
      integer :: istep_GLOB
      integer(kind=8) :: nvtot_GLOB
      logical :: ifsync
      real(kind=8) :: tgop
      integer :: ngop
      if (nid == 0) then
         write(6,*) ' '
         write(6,'(A)') 'an error occured: dying ...'
         write(6,*) ' '
      endif
      call happy_check()
      call print_runtime_info(icall,nekcomm,nekgroup,nekreal,nid,np,ttotal_GLOB,etimes_GLOB, &
      tprep_GLOB,ttime_GLOB,istep_GLOB,nvtot_GLOB,ifsync,tgop,ngop,ifneknek)
      call nek_die(1)
      return
      end subroutine exitt
      subroutine print_runtime_info(icall,nekcomm,nekgroup,nekreal,nid,np,ttotal,etimes,tprep,ttime, &
      istep,nvtot,ifsync,tgop,ngop,ifneknek)
      use params_SIZE, only : lz1, ly1, lx1
!!      use params_TOTAL ! ONLY LIST EMPTY
!!      use params_mpif_h ! ONLY LIST EMPTY
      implicit none
      integer :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer, intent(In) :: nid
      integer, intent(In) :: np
      real(kind=8), intent(InOut) :: ttotal
      real(kind=8), intent(In) :: etimes
      real(kind=8), intent(In) :: tprep
      real(kind=8), intent(In) :: ttime
      integer, intent(In) :: istep
      integer(kind=8), intent(In) :: nvtot
      logical :: ifsync
      real(kind=8) :: tgop
      integer :: ngop
      logical :: ifneknek
      real :: dgp
      real :: dtmp0
      real :: dtmp1
      real :: dtmp2
      real :: dtmp4
      real :: getmaxrss
      real :: gflops
      integer :: nxyz
      real :: tsol
      real :: tstop
#ifdef PAPI
      gflops  = glsum(dnekgflops(),1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync,tgop,ngop, &
      ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
#endif
      tstop   = dnekclock_sync(nekcomm,nekgroup,nekreal,nid,np)
      ttotal = tstop-etimes
      tsol   = max(ttime - tprep,0.0)
      nxyz   = lx1*ly1*lz1
      dtmp4  = glsum(getmaxrss(),1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync,tgop,ngop,ifneknek, &
      ttotal,etimes,tprep,ttime,istep,nvtot)/1e9
      if (nid == 0) then 
         dtmp1 = 0
         dtmp2 = 0
         if(istep > 0) then
           dgp   = nvtot
           dgp   = max(dgp,1.)*max(istep,1)
           dtmp0 = np*(ttime-tprep)
           dtmp1 = 0
           if (dtmp0 > 0) dtmp1 = dgp/dtmp0 
           dtmp2 = (ttime-tprep)/max(istep,1)
         endif 
         write(6,*) ' '
         write(6,'(5(A,1p1e13.5,A,/))')        'total elapsed time             : ',ttotal, ' sec'      ,'total solver time w/o IO       : ',tsol,   ' sec'      ,'time/timestep                  : ',dtmp2 , ' sec'      ,'avg throughput per timestep    : ',dtmp1 , ' gridpts/CPUs'      ,'total max memory usage         : ',dtmp4 , ' GB'
#ifdef PAPI
         write(6,'(1(A,1p1e13.5,/))')       ,'total Gflops/s                 : ',gflops
#endif
      endif 
      call flush_io()
      return
      end subroutine print_runtime_info
      subroutine nek_die(ierr)
!!      use params_SIZE ! ONLY LIST EMPTY
!!      use params_mpif_h ! ONLY LIST EMPTY
      implicit none
      integer, intent(In) :: ierr
      integer :: ierr_
      call mpi_finalize(ierr_)
#ifdef EXTBAR
      call exit_(ierr)
#else
      call exit(ierr)
#endif
      return
      end subroutine nek_die

end module singleton_module_src_comm_mpi


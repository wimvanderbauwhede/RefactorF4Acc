module singleton_module_src_mxm_wrapper

      use singleton_module_src_comm_mpi
      use singleton_module_src_mxm_std
      use singleton_module_src_blas
      use singleton_module_src_mxm_bgq
contains

      subroutine mxm(a,n1,b,n2,c,n3,nrout,rname,dct,ncall,dcount,tmxmf)
!!      use params_SIZE ! ONLY LIST EMPTY
      use params_OPCTR, only : maxrts
!!      use params_TOTAL ! ONLY LIST EMPTY
      implicit none
      integer, intent(InOut) :: nrout
      character(len=6), dimension(1:maxrts), intent(Out) :: rname
      real(kind=8), dimension(1:maxrts), intent(InOut) :: dct
      integer, dimension(1:maxrts), intent(InOut) :: ncall
      real(kind=8), intent(InOut) :: dcount
      real(kind=8), intent(Out) :: tmxmf
      integer, intent(In) :: n1
      integer, intent(In) :: n2
      integer, intent(In) :: n3
      integer :: isclld
      integer :: myrout
      real(kind=8) :: etime1
      integer :: isbcnt
      real, dimension(1:n1,1:n2), intent(In) :: a
      real, dimension(1:n2,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(InOut) :: c
      integer(kind=8) :: tt
#ifdef TIMER2
      if (isclld == 0) then
          isclld=1
          nrout=nrout+1
          myrout=nrout
          rname(myrout) = 'mxm   '
      endif
      isbcnt = n1*n3*(2*n2-1)
      dct(myrout) = dct(myrout) + (isbcnt)
      ncall(myrout) = ncall(myrout) + 1
      dcount = dcount + (isbcnt)
      etime1  = dnekclock()
#endif
#ifdef BGQ
      if (n2  ==  8 .and. mod(n1,4)  ==  0 ) then
        call mxm_bgq_8(a,n1,b,n2,c,n3)

        goto 111
      endif
      if (n2  ==  16 .and. mod(n1,4)  ==  0 ) then
        call mxm_bgq_16(a,n1,b,n2,c,n3)

        goto 111
      endif
      tt = 32
      if (n2  ==  10 .and. mod(n1,4)  ==  0 .and. mod(n3,2)  ==  0 .and. mod(loc(a), &
      tt) == 0 .and. mod(loc(b),tt) == 0  .and. mod(loc(c),tt) == 0  ) then
        call mxm_bgq_10(a,n1,b,n2,c,n3)

        goto 111
      endif
      if (n2  ==  6 .and. mod(n1,4)  ==  0 .and. mod(n3,2)  ==  0 .and. mod(loc(a), &
      tt) == 0 .and. mod(loc(b),tt) == 0  .and. mod(loc(c),tt) == 0  ) then
        call mxm_bgq_6(a,n1,b,n2,c,n3)

        goto 111
      endif
#endif
#ifdef XSMM
      if ((n1*n2*n3)**(1./3)  >  6) then
         call libxsmm_dgemm('N','N',n1,n3,n2,1.0,a,n1,b,n2,0.0,c,n1)
         goto 111
      else
         goto 101
      endif
#endif
#ifdef BLAS_MXM
      call dgemm('N','N',n1,n3,n2,1.0,a,n1,b,n2,0.0,c,n1)
      goto 111
#endif
 101  call mxmf2(a,n1,b,n2,c,n3)
 111  continue
#ifdef TIMER2
      tmxmf  = tmxmf+dnekclock()-etime1
#endif
      return
      end subroutine mxm

end module singleton_module_src_mxm_wrapper


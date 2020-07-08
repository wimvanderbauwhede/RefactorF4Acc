module singleton_module_src_papi

contains

      real function dnekgflops()
      implicit none
      real(kind=4) :: mflops
      integer(kind=8) :: flpops
      call getflops_papi(flpops,mflops)
      dnekgflops = mflops/1e3
      return
      end function dnekgflops
      subroutine getflops_papi(flpops,mflops)
#ifdef PAPI
      implicit none
      real(kind=4) :: rtime
      real(kind=4) :: ptime
      real(kind=4), intent(InOut) :: mflops
      integer(kind=8), intent(InOut) :: flpops
      call papif_flops(rtime,ptime,flpops,mflops,ierr)
      if(ierr /= 0) then
        flpops = -1
        mflops = -1
      endif
#else
      flpops = -1
      mflops = -0
#endif
      return
      end subroutine getflops_papi

end module singleton_module_src_papi


module TSTEP
      real :: time
      real :: timef
      real :: fintim
      real :: timeio
      real :: dt
      real, dimension(1:10) :: dtlag
      real :: dtinit
      real :: dtinvm
      real :: courno
      real :: ctarg
      real, dimension(1:10) :: ab
      real, dimension(1:10) :: bd
      real, dimension(1:10) :: abmsh
      real, dimension(1:ldimt1) :: avdiff
      real, dimension(1:ldimt1) :: avtran
      real, dimension(0:ldimt1) :: volfld
      real :: tolrel
      real :: tolabs
      real :: tolhdf
      real :: tolpdf
      real :: tolev
      real :: tolnl
      real :: prelax
      real :: tolps
      real :: tolhs
      real :: tolhr
      real :: tolhv
      real, dimension(1:ldimt1) :: tolht
      real :: tolhe
      real :: vnrmh1
      real :: vnrmsm
      real :: vnrml2
      real :: vnrml8
      real :: vmean
      real, dimension(1:ldimt) :: tnrmh1
      real, dimension(1:ldimt) :: tnrmsm
      real, dimension(1:ldimt) :: tnrml2
      real, dimension(1:ldimt) :: tnrml8
      real, dimension(1:ldimt) :: tmean

      integer :: ifield
      integer :: imesh
      integer :: istep
      integer :: nsteps
      integer :: iostep
      integer :: lastep
      integer :: iocomm
      integer :: instep
      integer :: nab
      integer :: nabmsh
      integer :: nbd
      integer :: nbdinp
      integer :: ntaubd
      integer :: nmxh
      integer :: nmxp
      integer :: nmxe
      integer :: nmxnl
      integer :: ninter
      integer, dimension(0:ldimt1) :: nelfld
      integer :: nconv
      integer :: nconv_max
      integer :: ioinfodmp

      real :: pi

      logical :: ifprnt
      logical :: if_full_pres
      logical :: ifoutfld

      real, dimension(1:3,1:lpert) :: lyap

end module TSTEP

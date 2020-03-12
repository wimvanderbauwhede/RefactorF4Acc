module cea_inc
      use params_cea_inc, only : maxel, maxr, maxpv, maxng, maxt, ncol, maxtr, maxnc, maxmix, &
       maxngc, maxmat
      real(kind=8) :: enn
      real(kind=8) :: ennl
      real(kind=8) :: enlsav
      real(kind=8) :: ensave
      real(kind=8) :: sumn
      real(kind=8), dimension(1:maxngc) :: deln
      real(kind=8), dimension(1:maxngc) :: enln
      real(kind=8), dimension(1:maxngc) :: sln
      real(kind=8), dimension(1:maxngc,1:ncol) :: en
      integer :: ip
      integer :: iplt
      integer :: it
      integer :: nc
      integer :: ng
      integer :: ngp1
      integer :: nlm
      integer :: nplt
      integer :: nof
      integer :: nomit
      integer :: nonly
      integer :: np
      integer :: npr
      integer :: npt
      integer :: ngc
      integer :: nsert
      integer :: nspr
      integer :: nspx
      integer :: nt
      integer, dimension(1:45) :: jcond
      integer, dimension(1:maxel) :: jx
      integer, dimension(1:maxr) :: nfla
      integer, dimension(1:maxnc) :: ifz
      real(kind=8) :: cpmix
      real(kind=8) :: wmix
      real(kind=8) :: bcheck
      real(kind=8), dimension(1:2) :: am
      real(kind=8), dimension(1:2) :: hpp
      real(kind=8), dimension(1:2) :: vmin
      real(kind=8), dimension(1:2) :: vpls
      real(kind=8), dimension(1:2) :: wp
      real(kind=8), dimension(1:100) :: atmwt
      real(kind=8), dimension(1:maxmix) :: oxf
      real(kind=8), dimension(1:maxpv) :: p
      real(kind=8), dimension(1:2) :: rh
      real(kind=8), dimension(1:maxt) :: t
      real(kind=8), dimension(1:maxpv) :: v
      real(kind=8), dimension(1:100) :: valnce
      real(kind=8), dimension(1:maxel,1:2) :: b0p
      integer :: imat
      integer :: iq1
      integer :: isv
      integer :: jliq
      integer :: jsol
      integer :: lsave
      integer :: msing
      logical :: convg
      logical, dimension(1:ncol) :: debug
      logical :: detdbg
      logical :: detn
      logical :: eql
      logical :: gonly
      logical :: hp
      logical :: ions
      logical :: massf
      logical :: moles
      logical :: newr
      logical :: pderiv
      logical :: shock
      logical :: short
      logical :: siunit
      logical :: sp
      logical :: tp
      logical :: trnspt
      logical :: vol
      real(kind=8) :: avgdr
      real(kind=8) :: boltz
      real(kind=8) :: eqrat
      real(kind=8) :: hsub0
      real(kind=8) :: oxfl
      real(kind=8) :: pi
      real(kind=8) :: pp
      real(kind=8) :: r
      real(kind=8) :: rr
      real(kind=8) :: size
      real(kind=8) :: s0
      real(kind=8) :: tln
      real(kind=8) :: tm
      real(kind=8) :: trace
      real(kind=8) :: tt
      real(kind=8) :: viscns
      real(kind=8) :: vv
      real(kind=8), dimension(1:maxel) :: atwt
      real(kind=8), dimension(1:maxel) :: b0
      real(kind=8), dimension(1:maxmat) :: x
      real(kind=8), dimension(1:maxel,1:maxngc) :: a
      real(kind=8), dimension(1:maxmat,1:maxmat+1) :: g
      character(len=2), dimension(1:maxel) :: elmt
      character(len=2), dimension(1:maxr,1:12) :: ratom
      character(len=2), dimension(1:100) :: symbol
      character(len=4), dimension(1:30) :: fmt
      character(len=8), dimension(1:maxr) :: fox
      character(len=10) :: thdate
      character(len=15) :: case
      character(len=15), dimension(1:maxr) :: energy
      character(len=15), dimension(0:maxngc) :: omit
      character(len=15), dimension(1:20) :: pltvar
      character(len=15), dimension(0:maxngc) :: prod
      character(len=15), dimension(1:maxr) :: rname
      character(len=200) :: pfile
      real(kind=8), dimension(1:ncol) :: cpr
      real(kind=8), dimension(1:ncol) :: dlvpt
      real(kind=8), dimension(1:ncol) :: dlvtp
      real(kind=8), dimension(1:ncol) :: gammas
      real(kind=8), dimension(1:ncol) :: hsum
      real(kind=8), dimension(1:ncol) :: ppp
      real(kind=8), dimension(1:ncol) :: ssum
      real(kind=8), dimension(1:ncol) :: totn
      real(kind=8), dimension(1:ncol) :: ttt
      real(kind=8), dimension(1:ncol) :: vlm
      real(kind=8), dimension(1:ncol) :: wm
      real(kind=8), dimension(1:500,1:20) :: pltout
      integer :: nreac
      integer, dimension(1:maxr) :: jray
      real(kind=8), dimension(1:maxr) :: dens
      real(kind=8), dimension(1:maxr) :: enth
      real(kind=8), dimension(1:maxr) :: pecwt
      real(kind=8), dimension(1:maxr) :: rmw
      real(kind=8), dimension(1:maxr) :: rtemp
      real(kind=8), dimension(1:maxr,1:12) :: rnum
      real(kind=8) :: cpsum
      real(kind=8), dimension(1:maxnc,1:9) :: cft
      real(kind=8), dimension(1:maxng,1:9,1:3) :: coef
      real(kind=8), dimension(1:2,1:maxnc) :: temp
      real(kind=8), dimension(1:maxngc) :: cp
      real(kind=8), dimension(1:maxngc) :: h0
      real(kind=8), dimension(1:maxngc) :: mu
      real(kind=8), dimension(1:maxngc) :: mw
      real(kind=8), dimension(1:maxngc) :: s
      real(kind=8), dimension(1:4) :: tg
      integer :: iopt
      integer :: isup
      integer :: nfz
      integer :: npp
      integer :: nsub
      integer :: nsup
      logical :: area
      logical :: debugf
      logical :: fac
      logical :: froz
      logical :: page1
      logical :: rkt
      real(kind=8) :: acat
      real(kind=8) :: awt
      real(kind=8) :: cstr
      real(kind=8) :: tcest
      real(kind=8) :: ma
      real(kind=8), dimension(1:ncol) :: aeat
      real(kind=8), dimension(1:ncol) :: app
      real(kind=8), dimension(1:2*ncol) :: pcp
      real(kind=8), dimension(1:ncol) :: sonvel
      real(kind=8), dimension(1:ncol) :: spim
      real(kind=8), dimension(1:13) :: subar
      real(kind=8), dimension(1:13) :: supar
      real(kind=8), dimension(1:ncol) :: vmoc
      integer :: nsk
      logical :: incdeq
      logical :: incdfz
      logical :: refleq
      logical :: reflfz
      logical :: shkdbg
      real(kind=8), dimension(1:ncol) :: u1
      real(kind=8), dimension(1:ncol) :: mach1
      real(kind=8) :: a1
      real(kind=8) :: gamma1
      integer :: nm
      integer :: nr
      integer :: ntape
      integer, dimension(1:maxtr) :: ind
      integer, dimension(1:maxel) :: jcm
      real(kind=8), dimension(1:maxtr) :: cprr
      real(kind=8), dimension(1:maxtr) :: con
      real(kind=8), dimension(1:maxtr) :: wmol
      real(kind=8), dimension(1:maxtr) :: xs
      real(kind=8), dimension(1:maxtr,1:maxtr) :: eta
      real(kind=8), dimension(1:maxtr,1:maxtr) :: stc
      real(kind=8), dimension(1:ncol) :: coneql
      real(kind=8), dimension(1:ncol) :: confro
      real(kind=8), dimension(1:ncol) :: cpeql
      real(kind=8), dimension(1:ncol) :: cpfro
      real(kind=8), dimension(1:ncol) :: preql
      real(kind=8), dimension(1:ncol) :: prfro
      real(kind=8), dimension(1:ncol) :: vis

end module cea_inc

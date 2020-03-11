module INPUT
      use params_INPUT, only : maxobj, maxmbr, ldimt, ldimt1, lelt, ldimt3, lhis, numsts
      real, dimension(1:200) :: param
      real :: rstim
      real :: vnekton
      real, dimension(1:ldimt1,1:3) :: cpfld
      real, dimension(-5:10,1:ldimt1,1:3) :: cpgrp
      real, dimension(1:ldimt3,1:maxobj) :: qinteg
      real, dimension(1:20) :: uparam
      real, dimension(0:ldimt1) :: atol
      real, dimension(0:ldimt1) :: restol
      real :: filtertype

      integer, dimension(-5:10,1:ldimt1) :: matype
      integer :: nktonv
      integer :: nhis
      integer, dimension(1:4,1:lhis+maxobj) :: lochis
      integer :: ipscal
      integer :: npscal
      integer :: ipsco
      integer :: ifldmhd
      integer :: irstv
      integer :: irstt
      integer :: irstim
      integer, dimension(1:maxobj) :: nmember
      integer :: nobj
      integer :: ngeom
      integer, dimension(1:ldimt) :: idpss

      logical :: if3d
      logical :: ifflow
      logical :: ifheat
      logical :: iftran
      logical :: ifaxis
      logical :: ifstrs
      logical :: ifsplit
      logical :: ifmgrid
      logical, dimension(1:ldimt1) :: ifadvc
      logical, dimension(1:ldimt1) :: ifdiff
      logical, dimension(1:ldimt1) :: ifdeal
      logical, dimension(0:ldimt1) :: ifprojfld
      logical, dimension(0:ldimt1) :: iftmsh
      logical, dimension(0:ldimt1) :: ifdgfld
      logical :: ifdg
      logical :: ifmvbd
      logical :: ifchar
      logical, dimension(1:ldimt1) :: ifnonl
      logical, dimension(1:ldimt1) :: ifvarp
      logical, dimension(1:ldimt1) :: ifpsco
      logical :: ifvps
      logical :: ifmodel
      logical :: ifkeps
      logical :: ifintq
      logical :: ifcons
      logical :: ifxyo
      logical :: ifpo
      logical :: ifvo
      logical :: ifto
      logical :: iftgo
      logical, dimension(1:ldimt1) :: ifpso
      logical :: iffmtin
      logical :: ifbo
      logical :: ifanls
      logical :: ifanl2
      logical :: ifmhd
      logical :: ifessr
      logical :: ifpert
      logical :: ifbase
      logical :: ifcvode
      logical :: iflomach
      logical :: ifexplvis
      logical :: ifschclob
      logical :: ifuservp
      logical :: ifcyclic
      logical :: ifmoab
      logical :: ifcoup
      logical :: ifvcoup
      logical :: ifusermv
      logical :: ifreguo
      logical :: ifxyo_
      logical :: ifaziv
      logical :: ifneknek
      logical :: ifneknekm
      logical, dimension(1:ldimt1) :: ifcvfld
      logical :: ifdp0dt
      logical :: ifmpiio
      logical :: ifrich

      logical :: ifnav
      equivalence    (ifnav, ifadvc(1))

      character(len=1     ), dimension(1:11,1:lhis+maxobj) :: hcode
      character(len=2     ), dimension(1:8) :: ocode
      character(len=10    ), dimension(1:5) :: drivc
      character(len=14    ) :: rstv
      character(len=14    ) :: rstt
      character(len=40    ), dimension(1:100,1:2) :: textsw
      character(len=132   ), dimension(1:15) :: initc

      character(len=40    ) :: turbmod
      equivalence    (turbmod,textsw(1,1))

      character(len=132   ) :: reafle
      character(len=132   ) :: fldfle
      character(len=132   ) :: dmpfle
      character(len=132   ) :: hisfle
      character(len=132   ) :: schfle
      character(len=132   ) :: orefle
      character(len=132   ) :: nrefle

      character(len=132   ) :: session
      character(len=132   ) :: path
      character(len=132   ) :: re2fle
      character(len=132   ) :: parfle

      integer :: cr_re2
      integer :: fh_re2

      integer(kind=8 ) :: re2off_b
      real, dimension(1:8,1:lelt) :: xc
      real, dimension(1:8,1:lelt) :: yc
      real, dimension(1:8,1:lelt) :: zc
      real, dimension(1:5,1:6,1:lelt,0:ldimt1) :: bc
      real, dimension(1:6,1:12,1:lelt) :: curve
      real, dimension(1:lelt) :: cerror

      integer, dimension(1:lelt) :: igroup
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object

      character(len=1     ), dimension(1:12,1:lelt) :: ccurve
      character(len=1     ), dimension(1:6,1:lelt) :: cdof
      character(len=3     ), dimension(1:6,1:lelt,0:ldimt1) :: cbc
      character(len=3     ) :: solver_type

      integer, dimension(1:lelt) :: ieact
      integer :: neact

      integer :: numflu
      integer :: numoth
      integer :: numbcs
      integer, dimension(1:numsts) :: matindx
      integer, dimension(1:numsts) :: matids
      integer, dimension(1:lelt) :: imatie
      integer, dimension(1:numsts) :: ibcsts

      integer, dimension(1:numsts) :: bcf

      character(len=3 ), dimension(1:numsts) :: bctyps

end module INPUT

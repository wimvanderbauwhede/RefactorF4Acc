module singleton_module_src_navier5

      use singleton_module_src_mxm_wrapper
      use singleton_module_src_math
      use singleton_module_src_comm_mpi
      use singleton_module_src_subs1
contains

      subroutine mappr(pm1,pm2,pa,pb)
      implicit none
      integer :: nio
      integer :: loglevel
      integer :: optlevel
      integer, intent(In) :: nelv
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
      real, dimension(1:ly1,1:ly1) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lx1,1:lx1) :: dxtm1
      real, dimension(1:lx1,1:lx2) :: dxtm12
      real, dimension(1:ly1,1:ly1) :: dytm1
      real, dimension(1:ly1,1:ly2) :: dytm12
      real, dimension(1:lz1,1:lz1) :: dztm1
      real, dimension(1:lz1,1:lz2) :: dztm12
      real, dimension(1:lx3,1:lx3) :: dxm3
      real, dimension(1:lx3,1:lx3) :: dxtm3
      real, dimension(1:ly3,1:ly3) :: dym3
      real, dimension(1:ly3,1:ly3) :: dytm3
      real, dimension(1:lz3,1:lz3) :: dzm3
      real, dimension(1:lz3,1:lz3) :: dztm3
      real, dimension(1:ly1,1:ly1) :: dcm1
      real, dimension(1:ly1,1:ly1) :: dctm1
      real, dimension(1:ly3,1:ly3) :: dcm3
      real, dimension(1:ly3,1:ly3) :: dctm3
      real, dimension(1:ly2,1:ly1) :: dcm12
      real, dimension(1:ly1,1:ly2) :: dctm12
      real, dimension(1:ly1,1:ly1) :: dam1
      real, dimension(1:ly1,1:ly1) :: datm1
      real, dimension(1:ly2,1:ly1) :: dam12
      real, dimension(1:ly1,1:ly2) :: datm12
      real, dimension(1:ly3,1:ly3) :: dam3
      real, dimension(1:ly3,1:ly3) :: datm3
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vxd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vyd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vzd
      real, dimension(1:lx1,1:lxd) :: imd1
      real, dimension(1:lxd,1:lx1) :: imd1t
      real, dimension(1:lxd,1:lx1) :: im1d
      real, dimension(1:lx1,1:lxd) :: im1dt
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t
      real :: eigas
      real :: eigaa
      real :: eigast
      real :: eigae
      real :: eigga
      real :: eiggs
      real :: eiggst
      real :: eigge
      logical :: ifaa
      logical :: ifae
      logical :: ifas
      logical :: ifast
      logical :: ifga
      logical :: ifge
      logical :: ifgs
      logical :: ifgst
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: xm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: ym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: zm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: jacm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: txm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: szm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: jacm2
      real, dimension(1:lxd*lyd*lzd,1:ldim*ldim,1:lelv) :: rx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g1m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g2m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g3m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g4m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g5m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g6m1
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unr
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: uns
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unt
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(1:lx1*lz1,1:2*ldim,1:lelt) :: etalph
      real :: dlam
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vny
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1z
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2z
      logical :: ifgeom
      logical :: ifgmsh3
      logical :: ifvcor
      logical :: ifsurt
      logical :: ifmelt
      logical :: ifwcno
      logical, dimension(1:lelt) :: ifrzer
      logical, dimension(1:2*ldim,1:lelv) :: ifqinp
      logical, dimension(1:2*ldim,1:lelv) :: ifeppm
      logical, dimension(0:1) :: iflmsf
      logical, dimension(0:1) :: iflmse
      logical, dimension(0:1) :: iflmsc
      logical, dimension(1:2*ldim,1:lelt,0:1) :: ifmsfc
      logical, dimension(1:12,1:lelt,0:1) :: ifmseg
      logical, dimension(1:8,1:lelt,0:1) :: ifmscr
      logical, dimension(1:8,1:lelt) :: ifnskp
      logical :: ifbcor
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
      logical, intent(In) :: ifsplit
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
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode
      character(len=2), dimension(1:8) :: ocode
      character(len=10), dimension(1:5) :: drivc
      character(len=14) :: rstv
      character(len=14) :: rstt
      character(len=40), dimension(1:100,1:2) :: textsw
      character(len=132), dimension(1:15) :: initc
      character(len=40) :: turbmod
      character(len=132) :: reafle
      character(len=132) :: fldfle
      character(len=132) :: dmpfle
      character(len=132) :: hisfle
      character(len=132) :: schfle
      character(len=132) :: orefle
      character(len=132) :: nrefle
      character(len=132) :: session
      character(len=132) :: path
      character(len=132) :: re2fle
      character(len=132) :: parfle
      integer :: cr_re2
      integer :: fh_re2
      integer(kind=8) :: re2off_b
      real, dimension(1:8,1:lelt) :: xc
      real, dimension(1:8,1:lelt) :: yc
      real, dimension(1:8,1:lelt) :: zc
      real, dimension(1:5,1:6,1:lelt,0:ldimt1) :: bc
      real, dimension(1:6,1:12,1:lelt) :: curve
      real, dimension(1:lelt) :: cerror
      integer, dimension(1:lelt) :: igroup
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object
      character(len=1), dimension(1:12,1:lelt) :: ccurve
      character(len=1), dimension(1:6,1:lelt) :: cdof
      character(len=3), dimension(1:6,1:lelt,0:ldimt1) :: cbc
      character(len=3) :: solver_type
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
      character(len=3), dimension(1:numsts) :: bctyps
      real, dimension(1:lx2,1:lx1) :: ixm12
      real, dimension(1:lx1,1:lx2), intent(In) :: ixm21
      real, dimension(1:ly2,1:ly1) :: iym12
      real, dimension(1:ly1,1:ly2) :: iym21
      real, dimension(1:lz2,1:lz1) :: izm12
      real, dimension(1:lz1,1:lz2) :: izm21
      real, dimension(1:lx1,1:lx2) :: ixtm12
      real, dimension(1:lx2,1:lx1) :: ixtm21
      real, dimension(1:ly1,1:ly2) :: iytm12
      real, dimension(1:ly2,1:ly1), intent(In) :: iytm21
      real, dimension(1:lz1,1:lz2) :: iztm12
      real, dimension(1:lz2,1:lz1), intent(In) :: iztm21
      real, dimension(1:lx3,1:lx1) :: ixm13
      real, dimension(1:lx1,1:lx3) :: ixm31
      real, dimension(1:ly3,1:ly1) :: iym13
      real, dimension(1:ly1,1:ly3) :: iym31
      real, dimension(1:lz3,1:lz1) :: izm13
      real, dimension(1:lz1,1:lz3) :: izm31
      real, dimension(1:lx1,1:lx3) :: ixtm13
      real, dimension(1:lx3,1:lx1) :: ixtm31
      real, dimension(1:ly1,1:ly3) :: iytm13
      real, dimension(1:ly3,1:ly1) :: iytm31
      real, dimension(1:lz1,1:lz3) :: iztm13
      real, dimension(1:lz3,1:lz1) :: iztm31
      real, dimension(1:ly2,1:ly1) :: iam12
      real, dimension(1:ly1,1:ly2) :: iam21
      real, dimension(1:ly1,1:ly2) :: iatm12
      real, dimension(1:ly2,1:ly1) :: iatm21
      real, dimension(1:ly3,1:ly1) :: iam13
      real, dimension(1:ly1,1:ly3) :: iam31
      real, dimension(1:ly1,1:ly3) :: iatm13
      real, dimension(1:ly3,1:ly1) :: iatm31
      real, dimension(1:ly2,1:ly1) :: icm12
      real, dimension(1:ly1,1:ly2) :: icm21
      real, dimension(1:ly1,1:ly2) :: ictm12
      real, dimension(1:ly2,1:ly1) :: ictm21
      real, dimension(1:ly3,1:ly1) :: icm13
      real, dimension(1:ly1,1:ly3) :: icm31
      real, dimension(1:ly1,1:ly3) :: ictm13
      real, dimension(1:ly3,1:ly1) :: ictm31
      real, dimension(1:ly1,1:ly1) :: iajl1
      real, dimension(1:ly1,1:ly1) :: iatjl1
      real, dimension(1:ly2,1:ly2) :: iajl2
      real, dimension(1:ly2,1:ly2) :: iatjl2
      real, dimension(1:ly3,1:ly3) :: ialj3
      real, dimension(1:ly3,1:ly3) :: iatlj3
      real, dimension(1:ly1,1:ly1) :: ialj1
      real, dimension(1:ly1,1:ly1) :: iatlj1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: bm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: binvm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bintm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: bm2inv
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: baxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1) :: bm1lag
      real :: volvm1
      real :: volvm2
      real :: voltm1
      real :: voltm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: yinvm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: binvdg
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wy
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wxlag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wylag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wzlag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w1mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w2mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w3mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wmult
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev1
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev2
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev3
      integer :: node
      integer :: pid
      integer :: np
      integer :: nullpid
      integer :: node0
      integer(kind=8) :: nvtot
      integer, dimension(0:ldimt1) :: nelg
      integer, dimension(1:lelt) :: lglel
      integer, dimension(1:lelg) :: gllel
      integer, dimension(1:lelg) :: gllnid
      integer :: nelgv
      integer :: nelgt
      logical :: ifgprnt
      integer :: wdsize
      integer :: isize
      integer :: lsize
      integer :: csize
      integer :: wdsizi
      integer :: cr_h
      integer :: gsh
      integer, dimension(0:ldimt3) :: gsh_fld
      integer, dimension(1:ldimt3) :: xxth
      logical :: ifgsh_fld_same
      integer, dimension(1:lx1*lz1*2*ldim*lelt) :: dg_face
      integer :: dg_hndlx
      integer :: ndg_facex
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: bq
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vxlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vylag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vzlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1,1:ldimt) :: tlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: vdiff_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz
      real, dimension(1:lx1*ly1*lz1*lelv) :: vx_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: t
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vtrans
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: cflf
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmnv
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmass
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bdivw
      real, dimension(1:lxd*lyd*lzd*lelv*ldim,1:lorder+1) :: c_vx
      real, dimension(1:2*ldim,1:lelt) :: fw
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: by
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bz
      real, dimension(1:lbx2,1:lby2,1:lbz2,1:lbelv) :: pm
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmy
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmz
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz2
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bxlag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bylag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bzlag
      real, dimension(1:lbx2*lby2*lbz2*lbelv,1:lorder2) :: pmlag
      real :: nu_star
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv,1:lorder2) :: prlag
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: qtl
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: usrdiv
      real :: p0th
      real :: dp0thdt
      real :: gamma0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v1mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v2mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: omask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: vmult
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmult
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b1mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b2mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b3mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bpmask
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vzp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lpert) :: prp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: tp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: bqp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfzp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vxlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vylagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vzlagp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lorder2,1:lpert) :: prlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lorder-1,1:lpert) :: tlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt2p
      integer :: jp
      real, dimension(1:ldimt1) :: tauss
      real, dimension(1:ldimt1) :: txnext
      integer :: nsskip
      logical :: ifskip
      logical :: ifmodp
      logical :: ifssvt
      logical, dimension(1:ldimt1) :: ifstst
      logical :: ifexvt
      logical, dimension(1:ldimt1) :: ifextr
      real :: dvnnh1
      real :: dvnnsm
      real :: dvnnl2
      real :: dvnnl8
      real :: dvdfh1
      real :: dvdfsm
      real :: dvdfl2
      real :: dvdfl8
      real :: dvprh1
      real :: dvprsm
      real :: dvprl2
      real :: dvprl8
      integer, dimension(1:2,1:3) :: nomlis
      integer, dimension(1:6) :: nmlinv
      integer, dimension(1:6) :: group
      integer, dimension(1:6,1:6) :: skpdat
      integer, dimension(1:6) :: eface
      integer, dimension(1:6) :: eface1
      integer, dimension(-12:12,1:3) :: eskip
      integer, dimension(1:3) :: nedg
      integer :: ncmp
      integer, dimension(1:8) :: ixcn
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer :: maxmlt
      integer, dimension(0:ldimt1) :: nspmax
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer, dimension(1:8,1:lelt,0:ldimt1) :: gcnnum
      integer, dimension(1:8,1:lelt,0:ldimt1) :: lcnnum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: lednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gedtyp
      integer, dimension(1:2,0:ldimt1) :: ngcomm
      integer, dimension(1:20) :: iedge
      integer, dimension(1:2,1:4,1:6,0:1) :: iedgef
      integer, dimension(1:3,1:16) :: icedg
      integer, dimension(1:4,1:6) :: iedgfc
      integer, dimension(1:4,1:10) :: icface
      integer, dimension(1:8) :: indx
      integer, dimension(1:27) :: invedg
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
      integer, intent(Out) :: ifield
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
      integer :: iesolv
      logical, dimension(1:lelv) :: ifalgn
      logical, dimension(1:lelv) :: ifrsxy
      real, dimension(1:lelv) :: volel
      real, dimension(1:lx1,1:3) :: zgm1
      real, dimension(1:lx2,1:3) :: zgm2
      real, dimension(1:lx3,1:3) :: zgm3
      real, dimension(1:lx1) :: zam1
      real, dimension(1:lx2) :: zam2
      real, dimension(1:lx3) :: zam3
      real, dimension(1:lx1) :: wxm1
      real, dimension(1:ly1) :: wym1
      real, dimension(1:lz1) :: wzm1
      real, dimension(1:lx1,1:ly1,1:lz1) :: w3m1
      real, dimension(1:lx2) :: wxm2
      real, dimension(1:ly2) :: wym2
      real, dimension(1:lz2) :: wzm2
      real, dimension(1:lx2,1:ly2,1:lz2) :: w3m2
      real, dimension(1:lx3) :: wxm3
      real, dimension(1:ly3) :: wym3
      real, dimension(1:lz3) :: wzm3
      real, dimension(1:lx3,1:ly3,1:lz3) :: w3m3
      real, dimension(1:ly1) :: wam1
      real, dimension(1:ly2) :: wam2
      real, dimension(1:ly3) :: wam3
      real, dimension(1:lx1,1:ly1) :: w2am1
      real, dimension(1:lx1,1:ly1) :: w2cm1
      real, dimension(1:lx2,1:ly2) :: w2am2
      real, dimension(1:lx2,1:ly2) :: w2cm2
      real, dimension(1:lx3,1:ly3) :: w2am3
      real, dimension(1:lx3,1:ly3) :: w2cm3
      real, dimension(1:lx1) :: zgl
      real, dimension(1:lx1) :: wgl
      real, dimension(1:lx1) :: zgp
      real, dimension(1:lxq) :: wgp
      real, dimension(1:lx1*lx1) :: wgl1
      real, dimension(1:lxq*lxq) :: wgl2
      real, dimension(1:lx1*lx1) :: wgli
      real, dimension(1:lx1*lx1) :: d1
      real, dimension(1:lx1*lx1) :: d1t
      real, dimension(1:lx1*lx1) :: d2
      real, dimension(1:lx1*lx1) :: b2p
      real, dimension(1:lx1*lx1) :: b1ia1
      real, dimension(1:lx1*lx1) :: b1ia1t
      real, dimension(1:lx1*lx1) :: da
      real, dimension(1:lx1*lx1) :: dat
      real, dimension(1:lx1*lxq) :: iggl
      real, dimension(1:lx1*lxq) :: igglt
      real, dimension(1:lx1*lxq) :: dglg
      real, dimension(1:lx1*lxq) :: dglgt
      real, dimension(1:lx1*lxq) :: wglg
      real, dimension(1:lx1*lxq) :: wglgt
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(InOut) :: pm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv), intent(In) :: pm2
      real, dimension(1:lx1,1:ly2,1:lz2), intent(InOut) :: pa
      real, dimension(1:lx1,1:ly1,1:lz2), intent(InOut) :: pb
      nglob1 = lx1*ly1*lz1*nelv
      nyz2   = ly2*lz2
      nxy1   = lx1*ly1
      nxyz   = lx1*ly1*lz1
      if (ifsplit) then
         call copy(pm1,pm2,nglob1)
      else
         do iel=1,nelv
            call mxm (ixm21,lx1,pm2(1,1,1,iel),lx2,pa (1,1,1),nyz2)
            do iz=1,lz2
               call mxm (pa(1,1,iz),lx1,iytm21,ly2,pb(1,1,iz),ly1)
  end do
            call mxm (pb(1,1,1),nxy1,iztm21,lz2,pm1(1,1,1,iel),lz1)
  end do
       ifield=1
       call dssum (pm1,lx1,ly1,lz1)
       call col2  (pm1,vmult,nglob1)
      endif
      return
      end subroutine mappr
      subroutine local_grad3(ur,us,ut,u,n,e,d,dt)
      implicit none
      real, dimension(0:n,0:n,0:n), intent(InOut) :: ur
      real, dimension(0:n,0:n,0:n), intent(InOut) :: us
      real, dimension(0:n,0:n,0:n), intent(InOut) :: ut
      real, dimension(0:n,0:n,0:n,1:1), intent(In) :: u
      real, dimension(0:n,0:n), intent(In) :: d
      real, intent(In) :: dt
      integer, intent(In) :: e
      m1 = n+1
      m2 = m1*m1
      call mxm(d ,m1,u(0,0,0,e),m1,ur,m2)
      do k=0,n
         call mxm(u(0,0,k,e),m1,dt,m1,us(0,0,k),m1)
      enddo
      call mxm(u(0,0,0,e),m2,dt,m1,ut,m1)
      return
      end subroutine local_grad3
      subroutine local_grad2(ur,us,u,n,e,d,dt)
      implicit none
      real, dimension(0:n,0:n), intent(InOut) :: ur
      real, dimension(0:n,0:n), intent(InOut) :: us
      real, dimension(0:n,0:n,1:1), intent(In) :: u
      real, dimension(0:n,0:n), intent(In) :: d
      real, intent(In) :: dt
      integer, intent(In) :: e
      m1 = n+1
      call mxm(d ,m1,u(0,0,e),m1,ur,m1)
      call mxm(u(0,0,e),m1,dt,m1,us,m1)
      return
      end subroutine local_grad2
      subroutine gradm1(ux,uy,uz,u)
      implicit none
      integer :: nio
      integer :: loglevel
      integer :: optlevel
      integer :: nelv
      integer, intent(In) :: nelt
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
      real, dimension(1:lx1,1:lx1), intent(In) :: dxm1
      real, dimension(1:lx2,1:lx1) :: dxm12
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lx1,1:lx1), intent(In) :: dxtm1
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
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: xm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: ym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: zm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: tzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: jacm1
      real, dimension(1:lx1*ly1*lz1,1:lelt), intent(In) :: jacmi
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: txm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: szm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: jacm2
      real, dimension(1:lxd*lyd*lzd,1:ldim*ldim,1:lelv) :: rx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g1m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g2m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g3m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g4m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g5m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g6m1
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unr
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: uns
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unt
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(1:lx1*lz1,1:2*ldim,1:lelt) :: etalph
      real :: dlam
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vny
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1z
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2z
      logical :: ifgeom
      logical :: ifgmsh3
      logical :: ifvcor
      logical :: ifsurt
      logical :: ifmelt
      logical :: ifwcno
      logical, dimension(1:lelt), intent(In) :: ifrzer
      logical, dimension(1:2*ldim,1:lelv) :: ifqinp
      logical, dimension(1:2*ldim,1:lelv) :: ifeppm
      logical, dimension(0:1) :: iflmsf
      logical, dimension(0:1) :: iflmse
      logical, dimension(0:1) :: iflmsc
      logical, dimension(1:2*ldim,1:lelt,0:1) :: ifmsfc
      logical, dimension(1:12,1:lelt,0:1) :: ifmseg
      logical, dimension(1:8,1:lelt,0:1) :: ifmscr
      logical, dimension(1:8,1:lelt) :: ifnskp
      logical :: ifbcor
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
      logical, intent(In) :: if3d
      logical :: ifflow
      logical :: ifheat
      logical :: iftran
      logical, intent(In) :: ifaxis
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
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode
      character(len=2), dimension(1:8) :: ocode
      character(len=10), dimension(1:5) :: drivc
      character(len=14) :: rstv
      character(len=14) :: rstt
      character(len=40), dimension(1:100,1:2) :: textsw
      character(len=132), dimension(1:15) :: initc
      character(len=40) :: turbmod
      character(len=132) :: reafle
      character(len=132) :: fldfle
      character(len=132) :: dmpfle
      character(len=132) :: hisfle
      character(len=132) :: schfle
      character(len=132) :: orefle
      character(len=132) :: nrefle
      character(len=132) :: session
      character(len=132) :: path
      character(len=132) :: re2fle
      character(len=132) :: parfle
      integer :: cr_re2
      integer :: fh_re2
      integer(kind=8) :: re2off_b
      real, dimension(1:8,1:lelt) :: xc
      real, dimension(1:8,1:lelt) :: yc
      real, dimension(1:8,1:lelt) :: zc
      real, dimension(1:5,1:6,1:lelt,0:ldimt1) :: bc
      real, dimension(1:6,1:12,1:lelt) :: curve
      real, dimension(1:lelt) :: cerror
      integer, dimension(1:lelt) :: igroup
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object
      character(len=1), dimension(1:12,1:lelt) :: ccurve
      character(len=1), dimension(1:6,1:lelt) :: cdof
      character(len=3), dimension(1:6,1:lelt,0:ldimt1) :: cbc
      character(len=3) :: solver_type
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
      character(len=3), dimension(1:numsts) :: bctyps
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
      integer, parameter :: lxyz=lx1*ly1*lz1
      real, dimension(1:lxyz,1:1), intent(Out) :: ux
      real, dimension(1:lxyz,1:1), intent(Out) :: uy
      real, dimension(1:lxyz,1:1), intent(Out) :: uz
      real, dimension(1:lxyz,1:1), intent(In) :: u
      integer :: e
      nxyz = lx1*ly1*lz1
      ntot = nxyz*nelt
      n = lx1-1
      do e=1,nelt
         if (if3d) then
            call local_grad3(ur,us,ut,u,n,e,dxm1,dxtm1)
            do i=1,lxyz
               ux(i,e) = jacmi(i,e)*(ur(i)*rxm1(i,1,1,e)                             + us(i)*sxm1(i, &
      1,1,e)                             + ut(i)*txm1(i,1,1,e) )
               uy(i,e) = jacmi(i,e)*(ur(i)*rym1(i,1,1,e)                             + us(i)*sym1(i, &
      1,1,e)                             + ut(i)*tym1(i,1,1,e) )
               uz(i,e) = jacmi(i,e)*(ur(i)*rzm1(i,1,1,e)                             + us(i)*szm1(i, &
      1,1,e)                             + ut(i)*tzm1(i,1,1,e) )
            enddo
         else
            if (ifaxis) call setaxdy (ifrzer(e))
            call local_grad2(ur,us,u,n,e,dxm1,dytm1)
            do i=1,lxyz
               ux(i,e) =jacmi(i,e)*(ur(i)*rxm1(i,1,1,e)                            + us(i)*sxm1(i,1, &
      1,e) )
               uy(i,e) =jacmi(i,e)*(ur(i)*rym1(i,1,1,e)                            + us(i)*sym1(i,1, &
      1,e) )
            enddo
         endif
      enddo
      return
      end subroutine gradm1
      subroutine drgtrq(dgtq,xm0,ym0,zm0,sij,pm1,visc,f,e)
      implicit none
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
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: xm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: ym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: zm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: jacm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: txm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: szm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: jacm2
      real, dimension(1:lxd*lyd*lzd,1:ldim*ldim,1:lelv) :: rx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g1m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g2m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g3m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g4m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g5m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g6m1
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unr
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: uns
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unt
      real, dimension(1:lx1,1:lz1,1:6,1:lelt), intent(In) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt), intent(In) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt), intent(In) :: unz
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt), intent(In) :: area
      real, dimension(1:lx1*lz1,1:2*ldim,1:lelt) :: etalph
      real :: dlam
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vny
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1z
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2z
      logical :: ifgeom
      logical :: ifgmsh3
      logical :: ifvcor
      logical :: ifsurt
      logical :: ifmelt
      logical :: ifwcno
      logical, dimension(1:lelt) :: ifrzer
      logical, dimension(1:2*ldim,1:lelv) :: ifqinp
      logical, dimension(1:2*ldim,1:lelv) :: ifeppm
      logical, dimension(0:1) :: iflmsf
      logical, dimension(0:1) :: iflmse
      logical, dimension(0:1) :: iflmsc
      logical, dimension(1:2*ldim,1:lelt,0:1) :: ifmsfc
      logical, dimension(1:12,1:lelt,0:1) :: ifmseg
      logical, dimension(1:8,1:lelt,0:1) :: ifmscr
      logical, dimension(1:8,1:lelt) :: ifnskp
      logical :: ifbcor
      integer, parameter :: numsts=50
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
      logical, intent(In) :: if3d
      logical :: ifflow
      logical :: ifheat
      logical :: iftran
      logical, intent(In) :: ifaxis
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
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode
      character(len=2), dimension(1:8) :: ocode
      character(len=10), dimension(1:5) :: drivc
      character(len=14) :: rstv
      character(len=14) :: rstt
      character(len=40), dimension(1:100,1:2) :: textsw
      character(len=132), dimension(1:15) :: initc
      character(len=40) :: turbmod
      character(len=132) :: reafle
      character(len=132) :: fldfle
      character(len=132) :: dmpfle
      character(len=132) :: hisfle
      character(len=132) :: schfle
      character(len=132) :: orefle
      character(len=132) :: nrefle
      character(len=132) :: session
      character(len=132) :: path
      character(len=132) :: re2fle
      character(len=132) :: parfle
      integer :: cr_re2
      integer :: fh_re2
      integer(kind=8) :: re2off_b
      real, dimension(1:8,1:lelt) :: xc
      real, dimension(1:8,1:lelt) :: yc
      real, dimension(1:8,1:lelt) :: zc
      real, dimension(1:5,1:6,1:lelt,0:ldimt1) :: bc
      real, dimension(1:6,1:12,1:lelt) :: curve
      real, dimension(1:lelt) :: cerror
      integer, dimension(1:lelt) :: igroup
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object
      character(len=1), dimension(1:12,1:lelt) :: ccurve
      character(len=1), dimension(1:6,1:lelt) :: cdof
      character(len=3), dimension(1:6,1:lelt,0:ldimt1) :: cbc
      character(len=3) :: solver_type
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
      character(len=3), dimension(1:numsts) :: bctyps
      integer, dimension(1:2,1:3) :: nomlis
      integer, dimension(1:6) :: nmlinv
      integer, dimension(1:6) :: group
      integer, dimension(1:6,1:6), intent(In) :: skpdat
      integer, dimension(1:6) :: eface
      integer, dimension(1:6), intent(In) :: eface1
      integer, dimension(-12:12,1:3) :: eskip
      integer, dimension(1:3) :: nedg
      integer :: ncmp
      integer, dimension(1:8) :: ixcn
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer :: maxmlt
      integer, dimension(0:ldimt1) :: nspmax
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer, dimension(1:8,1:lelt,0:ldimt1) :: gcnnum
      integer, dimension(1:8,1:lelt,0:ldimt1) :: lcnnum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: lednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gedtyp
      integer, dimension(1:2,0:ldimt1) :: ngcomm
      integer, dimension(1:20) :: iedge
      integer, dimension(1:2,1:4,1:6,0:1) :: iedgef
      integer, dimension(1:3,1:16) :: icedg
      integer, dimension(1:4,1:6) :: iedgfc
      integer, dimension(1:4,1:10) :: icface
      integer, dimension(1:8) :: indx
      integer, dimension(1:27) :: invedg
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
      real, dimension(1:3,1:4), intent(InOut) :: dgtq
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: xm0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: ym0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: zm0
      real, dimension(1:lx1,1:ly1,1:lz1,1:3*ldim-3,1:lelv), intent(In) :: sij
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: pm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: visc
      real, dimension(1:3,1:2) :: dg
      integer :: f
      integer :: e
      integer :: pf
      real :: n1
      real :: n2
      real :: n3
      call dsset(lx1,ly1,lz1)    
      pf     = eface1(f)         
      js1    = skpdat(1,pf)
      jf1    = skpdat(2,pf)
      jskip1 = skpdat(3,pf)
      js2    = skpdat(4,pf)
      jf2    = skpdat(5,pf)
      jskip2 = skpdat(6,pf)
      call rzero(dgtq,12)
      if (if3d.or.ifaxis) then
       i = 0
       a = 0
       do j2=js2,jf2,jskip2
       do j1=js1,jf1,jskip1
         i = i+1
         n1 = unx(i,1,f,e)*area(i,1,f,e)
         n2 = uny(i,1,f,e)*area(i,1,f,e)
         n3 = unz(i,1,f,e)*area(i,1,f,e)
         a  = a +          area(i,1,f,e)
         v  = visc(j1,j2,1,e)
         s11 = sij(j1,j2,1,1,e)
         s21 = sij(j1,j2,1,4,e)
         s31 = sij(j1,j2,1,6,e)
         s12 = sij(j1,j2,1,4,e)
         s22 = sij(j1,j2,1,2,e)
         s32 = sij(j1,j2,1,5,e)
         s13 = sij(j1,j2,1,6,e)
         s23 = sij(j1,j2,1,5,e)
         s33 = sij(j1,j2,1,3,e)
         dg(1,1) = pm1(j1,j2,1,e)*n1     
         dg(2,1) = pm1(j1,j2,1,e)*n2
         dg(3,1) = pm1(j1,j2,1,e)*n3
         dg(1,2) = -v*(s11*n1 + s12*n2 + s13*n3) 
         dg(2,2) = -v*(s21*n1 + s22*n2 + s23*n3)
         dg(3,2) = -v*(s31*n1 + s32*n2 + s33*n3)
         r1 = xm0(j1,j2,1,e)
         r2 = ym0(j1,j2,1,e)
         r3 = zm0(j1,j2,1,e)
         do l=1,2
         do k=1,3
            dgtq(k,l) = dgtq(k,l) + dg(k,l)
         enddo
         enddo
         dgtq(1,3) = dgtq(1,3) + (r2*dg(3,1)-r3*dg(2,1)) 
         dgtq(2,3) = dgtq(2,3) + (r3*dg(1,1)-r1*dg(3,1)) 
         dgtq(3,3) = dgtq(3,3) + (r1*dg(2,1)-r2*dg(1,1))
         dgtq(1,4) = dgtq(1,4) + (r2*dg(3,2)-r3*dg(2,2)) 
         dgtq(2,4) = dgtq(2,4) + (r3*dg(1,2)-r1*dg(3,2)) 
         dgtq(3,4) = dgtq(3,4) + (r1*dg(2,2)-r2*dg(1,2))
       enddo
       enddo
      else 
       i = 0
       a = 0
       do j2=js2,jf2,jskip2
       do j1=js1,jf1,jskip1
         i = i+1
         n1 = unx(i,1,f,e)*area(i,1,f,e)
         n2 = uny(i,1,f,e)*area(i,1,f,e)
         a  = a +          area(i,1,f,e)
         v  = visc(j1,j2,1,e)
         s11 = sij(j1,j2,1,1,e)
         s12 = sij(j1,j2,1,3,e)
         s21 = sij(j1,j2,1,3,e)
         s22 = sij(j1,j2,1,2,e)
         dg(1,1) = pm1(j1,j2,1,e)*n1     
         dg(2,1) = pm1(j1,j2,1,e)*n2
         dg(3,1) = 0
         dg(1,2) = -v*(s11*n1 + s12*n2) 
         dg(2,2) = -v*(s21*n1 + s22*n2)
         dg(3,2) = 0.
         r1 = xm0(j1,j2,1,e)
         r2 = ym0(j1,j2,1,e)
         r3 = 0.
         do l=1,2
         do k=1,3
            dgtq(k,l) = dgtq(k,l) + dg(k,l)
         enddo
         enddo
         dgtq(1,3) = 0
         dgtq(2,3) = 0
         dgtq(3,3) = dgtq(3,3) + (r1*dg(2,1)-r2*dg(1,1))
         dgtq(1,4) = 0
         dgtq(2,4) = 0
         dgtq(3,4) = dgtq(3,4) + (r1*dg(2,2)-r2*dg(1,2))
       enddo
       enddo
      endif
      return
      end subroutine drgtrq
      subroutine torque_calc(scale,x0,ifdout,iftout)
      implicit none
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
      real, dimension(1:ly1,1:ly1) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lx1,1:lx1) :: dxtm1
      real, dimension(1:lx1,1:lx2) :: dxtm12
      real, dimension(1:ly1,1:ly1) :: dytm1
      real, dimension(1:ly1,1:ly2) :: dytm12
      real, dimension(1:lz1,1:lz1) :: dztm1
      real, dimension(1:lz1,1:lz2) :: dztm12
      real, dimension(1:lx3,1:lx3) :: dxm3
      real, dimension(1:lx3,1:lx3) :: dxtm3
      real, dimension(1:ly3,1:ly3) :: dym3
      real, dimension(1:ly3,1:ly3) :: dytm3
      real, dimension(1:lz3,1:lz3) :: dzm3
      real, dimension(1:lz3,1:lz3) :: dztm3
      real, dimension(1:ly1,1:ly1) :: dcm1
      real, dimension(1:ly1,1:ly1) :: dctm1
      real, dimension(1:ly3,1:ly3) :: dcm3
      real, dimension(1:ly3,1:ly3) :: dctm3
      real, dimension(1:ly2,1:ly1) :: dcm12
      real, dimension(1:ly1,1:ly2) :: dctm12
      real, dimension(1:ly1,1:ly1) :: dam1
      real, dimension(1:ly1,1:ly1) :: datm1
      real, dimension(1:ly2,1:ly1) :: dam12
      real, dimension(1:ly1,1:ly2) :: datm12
      real, dimension(1:ly3,1:ly3) :: dam3
      real, dimension(1:ly3,1:ly3) :: datm3
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vxd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vyd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vzd
      real, dimension(1:lx1,1:lxd) :: imd1
      real, dimension(1:lxd,1:lx1) :: imd1t
      real, dimension(1:lxd,1:lx1) :: im1d
      real, dimension(1:lx1,1:lxd) :: im1dt
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t
      real :: eigas
      real :: eigaa
      real :: eigast
      real :: eigae
      real :: eigga
      real :: eiggs
      real :: eiggst
      real :: eigge
      logical :: ifaa
      logical :: ifae
      logical :: ifas
      logical :: ifast
      logical :: ifga
      logical :: ifge
      logical :: ifgs
      logical :: ifgst
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: xm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: ym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: zm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: jacm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: txm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: szm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: jacm2
      real, dimension(1:lxd*lyd*lzd,1:ldim*ldim,1:lelv) :: rx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g1m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g2m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g3m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g4m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g5m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g6m1
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unr
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: uns
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unt
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(1:lx1*lz1,1:2*ldim,1:lelt) :: etalph
      real :: dlam
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vny
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1z
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2z
      logical :: ifgeom
      logical :: ifgmsh3
      logical :: ifvcor
      logical :: ifsurt
      logical :: ifmelt
      logical :: ifwcno
      logical, dimension(1:lelt) :: ifrzer
      logical, dimension(1:2*ldim,1:lelv) :: ifqinp
      logical, dimension(1:2*ldim,1:lelv) :: ifeppm
      logical, dimension(0:1) :: iflmsf
      logical, dimension(0:1) :: iflmse
      logical, dimension(0:1) :: iflmsc
      logical, dimension(1:2*ldim,1:lelt,0:1) :: ifmsfc
      logical, dimension(1:12,1:lelt,0:1) :: ifmseg
      logical, dimension(1:8,1:lelt,0:1) :: ifmscr
      logical, dimension(1:8,1:lelt) :: ifnskp
      logical :: ifbcor
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
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode
      character(len=2), dimension(1:8) :: ocode
      character(len=10), dimension(1:5) :: drivc
      character(len=14) :: rstv
      character(len=14) :: rstt
      character(len=40), dimension(1:100,1:2) :: textsw
      character(len=132), dimension(1:15) :: initc
      character(len=40) :: turbmod
      character(len=132) :: reafle
      character(len=132) :: fldfle
      character(len=132) :: dmpfle
      character(len=132) :: hisfle
      character(len=132) :: schfle
      character(len=132) :: orefle
      character(len=132) :: nrefle
      character(len=132) :: session
      character(len=132) :: path
      character(len=132) :: re2fle
      character(len=132) :: parfle
      integer :: cr_re2
      integer :: fh_re2
      integer(kind=8) :: re2off_b
      real, dimension(1:8,1:lelt) :: xc
      real, dimension(1:8,1:lelt) :: yc
      real, dimension(1:8,1:lelt) :: zc
      real, dimension(1:5,1:6,1:lelt,0:ldimt1) :: bc
      real, dimension(1:6,1:12,1:lelt) :: curve
      real, dimension(1:lelt) :: cerror
      integer, dimension(1:lelt) :: igroup
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object
      character(len=1), dimension(1:12,1:lelt) :: ccurve
      character(len=1), dimension(1:6,1:lelt) :: cdof
      character(len=3), dimension(1:6,1:lelt,0:ldimt1) :: cbc
      character(len=3) :: solver_type
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
      character(len=3), dimension(1:numsts) :: bctyps
      real, dimension(1:lx2,1:lx1) :: ixm12
      real, dimension(1:lx1,1:lx2) :: ixm21
      real, dimension(1:ly2,1:ly1) :: iym12
      real, dimension(1:ly1,1:ly2) :: iym21
      real, dimension(1:lz2,1:lz1) :: izm12
      real, dimension(1:lz1,1:lz2) :: izm21
      real, dimension(1:lx1,1:lx2) :: ixtm12
      real, dimension(1:lx2,1:lx1) :: ixtm21
      real, dimension(1:ly1,1:ly2) :: iytm12
      real, dimension(1:ly2,1:ly1) :: iytm21
      real, dimension(1:lz1,1:lz2) :: iztm12
      real, dimension(1:lz2,1:lz1) :: iztm21
      real, dimension(1:lx3,1:lx1) :: ixm13
      real, dimension(1:lx1,1:lx3) :: ixm31
      real, dimension(1:ly3,1:ly1) :: iym13
      real, dimension(1:ly1,1:ly3) :: iym31
      real, dimension(1:lz3,1:lz1) :: izm13
      real, dimension(1:lz1,1:lz3) :: izm31
      real, dimension(1:lx1,1:lx3) :: ixtm13
      real, dimension(1:lx3,1:lx1) :: ixtm31
      real, dimension(1:ly1,1:ly3) :: iytm13
      real, dimension(1:ly3,1:ly1) :: iytm31
      real, dimension(1:lz1,1:lz3) :: iztm13
      real, dimension(1:lz3,1:lz1) :: iztm31
      real, dimension(1:ly2,1:ly1) :: iam12
      real, dimension(1:ly1,1:ly2) :: iam21
      real, dimension(1:ly1,1:ly2) :: iatm12
      real, dimension(1:ly2,1:ly1) :: iatm21
      real, dimension(1:ly3,1:ly1) :: iam13
      real, dimension(1:ly1,1:ly3) :: iam31
      real, dimension(1:ly1,1:ly3) :: iatm13
      real, dimension(1:ly3,1:ly1) :: iatm31
      real, dimension(1:ly2,1:ly1) :: icm12
      real, dimension(1:ly1,1:ly2) :: icm21
      real, dimension(1:ly1,1:ly2) :: ictm12
      real, dimension(1:ly2,1:ly1) :: ictm21
      real, dimension(1:ly3,1:ly1) :: icm13
      real, dimension(1:ly1,1:ly3) :: icm31
      real, dimension(1:ly1,1:ly3) :: ictm13
      real, dimension(1:ly3,1:ly1) :: ictm31
      real, dimension(1:ly1,1:ly1) :: iajl1
      real, dimension(1:ly1,1:ly1) :: iatjl1
      real, dimension(1:ly2,1:ly2) :: iajl2
      real, dimension(1:ly2,1:ly2) :: iatjl2
      real, dimension(1:ly3,1:ly3) :: ialj3
      real, dimension(1:ly3,1:ly3) :: iatlj3
      real, dimension(1:ly1,1:ly1) :: ialj1
      real, dimension(1:ly1,1:ly1) :: iatlj1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: bm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: binvm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bintm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: bm2inv
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: baxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1) :: bm1lag
      real :: volvm1
      real :: volvm2
      real :: voltm1
      real :: voltm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: yinvm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: binvdg
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wy
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wxlag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wylag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wzlag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w1mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w2mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w3mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wmult
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev1
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev2
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev3
      integer :: node
      integer :: pid
      integer :: np
      integer :: nullpid
      integer :: node0
      integer(kind=8) :: nvtot
      integer, dimension(0:ldimt1) :: nelg
      integer, dimension(1:lelt) :: lglel
      integer, dimension(1:lelg) :: gllel
      integer, dimension(1:lelg) :: gllnid
      integer :: nelgv
      integer :: nelgt
      logical :: ifgprnt
      integer :: wdsize
      integer :: isize
      integer :: lsize
      integer :: csize
      integer :: wdsizi
      integer :: cr_h
      integer :: gsh
      integer, dimension(0:ldimt3) :: gsh_fld
      integer, dimension(1:ldimt3) :: xxth
      logical :: ifgsh_fld_same
      integer, dimension(1:lx1*lz1*2*ldim*lelt) :: dg_face
      integer :: dg_hndlx
      integer :: ndg_facex
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: bq
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vxlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vylag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vzlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1,1:ldimt) :: tlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: vdiff_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz
      real, dimension(1:lx1*ly1*lz1*lelv) :: vx_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: t
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vtrans
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: cflf
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmnv
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmass
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bdivw
      real, dimension(1:lxd*lyd*lzd*lelv*ldim,1:lorder+1) :: c_vx
      real, dimension(1:2*ldim,1:lelt) :: fw
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: by
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bz
      real, dimension(1:lbx2,1:lby2,1:lbz2,1:lbelv) :: pm
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmy
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmz
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz2
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bxlag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bylag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bzlag
      real, dimension(1:lbx2*lby2*lbz2*lbelv,1:lorder2) :: pmlag
      real :: nu_star
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv,1:lorder2) :: prlag
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: qtl
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: usrdiv
      real :: p0th
      real :: dp0thdt
      real :: gamma0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v1mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v2mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: omask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmult
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b1mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b2mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b3mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bpmask
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vzp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lpert) :: prp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: tp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: bqp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfzp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vxlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vylagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vzlagp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lorder2,1:lpert) :: prlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lorder-1,1:lpert) :: tlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt2p
      integer :: jp
      real, dimension(1:ldimt1) :: tauss
      real, dimension(1:ldimt1) :: txnext
      integer :: nsskip
      logical :: ifskip
      logical :: ifmodp
      logical :: ifssvt
      logical, dimension(1:ldimt1) :: ifstst
      logical :: ifexvt
      logical, dimension(1:ldimt1) :: ifextr
      real :: dvnnh1
      real :: dvnnsm
      real :: dvnnl2
      real :: dvnnl8
      real :: dvdfh1
      real :: dvdfsm
      real :: dvdfl2
      real :: dvdfl8
      real :: dvprh1
      real :: dvprsm
      real :: dvprl2
      real :: dvprl8
      integer, dimension(1:2,1:3) :: nomlis
      integer, dimension(1:6) :: nmlinv
      integer, dimension(1:6) :: group
      integer, dimension(1:6,1:6) :: skpdat
      integer, dimension(1:6) :: eface
      integer, dimension(1:6) :: eface1
      integer, dimension(-12:12,1:3) :: eskip
      integer, dimension(1:3) :: nedg
      integer :: ncmp
      integer, dimension(1:8) :: ixcn
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer :: maxmlt
      integer, dimension(0:ldimt1) :: nspmax
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer, dimension(1:8,1:lelt,0:ldimt1) :: gcnnum
      integer, dimension(1:8,1:lelt,0:ldimt1) :: lcnnum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: lednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gedtyp
      integer, dimension(1:2,0:ldimt1) :: ngcomm
      integer, dimension(1:20) :: iedge
      integer, dimension(1:2,1:4,1:6,0:1) :: iedgef
      integer, dimension(1:3,1:16) :: icedg
      integer, dimension(1:4,1:6) :: iedgfc
      integer, dimension(1:4,1:10) :: icface
      integer, dimension(1:8) :: indx
      integer, dimension(1:27) :: invedg
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
      integer :: iesolv
      logical, dimension(1:lelv) :: ifalgn
      logical, dimension(1:lelv) :: ifrsxy
      real, dimension(1:lelv) :: volel
      real, dimension(1:lx1,1:3) :: zgm1
      real, dimension(1:lx2,1:3) :: zgm2
      real, dimension(1:lx3,1:3) :: zgm3
      real, dimension(1:lx1) :: zam1
      real, dimension(1:lx2) :: zam2
      real, dimension(1:lx3) :: zam3
      real, dimension(1:lx1) :: wxm1
      real, dimension(1:ly1) :: wym1
      real, dimension(1:lz1) :: wzm1
      real, dimension(1:lx1,1:ly1,1:lz1) :: w3m1
      real, dimension(1:lx2) :: wxm2
      real, dimension(1:ly2) :: wym2
      real, dimension(1:lz2) :: wzm2
      real, dimension(1:lx2,1:ly2,1:lz2) :: w3m2
      real, dimension(1:lx3) :: wxm3
      real, dimension(1:ly3) :: wym3
      real, dimension(1:lz3) :: wzm3
      real, dimension(1:lx3,1:ly3,1:lz3) :: w3m3
      real, dimension(1:ly1) :: wam1
      real, dimension(1:ly2) :: wam2
      real, dimension(1:ly3) :: wam3
      real, dimension(1:lx1,1:ly1) :: w2am1
      real, dimension(1:lx1,1:ly1) :: w2cm1
      real, dimension(1:lx2,1:ly2) :: w2am2
      real, dimension(1:lx2,1:ly2) :: w2cm2
      real, dimension(1:lx3,1:ly3) :: w2am3
      real, dimension(1:lx3,1:ly3) :: w2cm3
      real, dimension(1:lx1) :: zgl
      real, dimension(1:lx1) :: wgl
      real, dimension(1:lx1) :: zgp
      real, dimension(1:lxq) :: wgp
      real, dimension(1:lx1*lx1) :: wgl1
      real, dimension(1:lxq*lxq) :: wgl2
      real, dimension(1:lx1*lx1) :: wgli
      real, dimension(1:lx1*lx1) :: d1
      real, dimension(1:lx1*lx1) :: d1t
      real, dimension(1:lx1*lx1) :: d2
      real, dimension(1:lx1*lx1) :: b2p
      real, dimension(1:lx1*lx1) :: b1ia1
      real, dimension(1:lx1*lx1) :: b1ia1t
      real, dimension(1:lx1*lx1) :: da
      real, dimension(1:lx1*lx1) :: dat
      real, dimension(1:lx1*lxq) :: iggl
      real, dimension(1:lx1*lxq) :: igglt
      real, dimension(1:lx1*lxq) :: dglg
      real, dimension(1:lx1*lxq) :: dglgt
      real, dimension(1:lx1*lxq) :: wglg
      real, dimension(1:lx1*lxq) :: wglgt
      real, dimension(1:3), intent(In) :: x0
      real, dimension(0:maxobj) :: w1
      logical, intent(In) :: ifdout
      logical, intent(In) :: iftout
      integer, parameter :: lr=lx1*ly1*lz1
      xm0(1,1,1,1:512) = reshape(trx(1:lx1,1:ly1,1:lz1),shape(xm0(1,1,1,1:512)))
      xm0(1,1,1,513:1024) = reshape(trz(1:lx1,1:ly1,1:lz1),shape(xm0(1,1,1,513:1024)))
      n = lx1*ly1*lz1*nelv
      call mappr(pm1,pr,xm0,ym0) 
      if (param(55) /= 0) then
         dpdx_mean = -scale_vf(1)
         dpdy_mean = -scale_vf(2)
         dpdz_mean = -scale_vf(3)
      endif
      call add2s2(pm1,xm1,dpdx_mean,n)  
      call add2s2(pm1,ym1,dpdy_mean,n)  
      call add2s2(pm1,zm1,dpdz_mean,n)  
      nij = 3
      if (if3d.or.ifaxis) nij=6
      call comp_sij(sij,nij,vx,vy,vz,ur,us,ut,vr,vs,vt,wr,ws,wt)
      if (istep < 1) call cfill(vdiff,param(2),n)
      call cadd2(xm0,xm1,-x0(1),n)
      call cadd2(ym0,ym1,-x0(2),n)
      call cadd2(zm0,zm1,-x0(3),n)
      x1min=glmin(xm0(1,1,1,1),n)
      x2min=glmin(ym0(1,1,1,1),n)
      x3min=glmin(zm0(1,1,1,1),n)
      x1max=glmax(xm0(1,1,1,1),n)
      x2max=glmax(ym0(1,1,1,1),n)
      x3max=glmax(zm0(1,1,1,1),n)
      do i=0,maxobj
         dragpx(i) = 0   
         dragvx(i) = 0
         dragx (i) = 0
         dragpy(i) = 0
         dragvy(i) = 0
         dragy (i) = 0
         dragpz(i) = 0
         dragvz(i) = 0
         dragz (i) = 0
         torqpx(i) = 0
         torqvx(i) = 0
         torqx (i) = 0
         torqpy(i) = 0
         torqvy(i) = 0
         torqy (i) = 0
         torqpz(i) = 0
         torqvz(i) = 0
         torqz (i) = 0
      enddo
      nobj = 0
      do ii=1,nhis
        if (hcode(10,ii) == 'I') then
          iobj   = lochis(1,ii)
          memtot = nmember(iobj)
          nobj   = max(iobj,nobj)
          if (hcode(1,ii) /= ' ' .or. hcode(2,ii) /= ' ' .or.      hcode(3,ii) /= ' ' ) then
            ifield = 1
            do mem=1,memtot
               ieg   = object(iobj,mem,1)
               ifc   = object(iobj,mem,2)
               if (gllnid(ieg) == nid) then 
                  ie = gllel(ieg)
                  call drgtrq(dgtq,xm0,ym0,zm0,sij,pm1,vdiff,ifc,ie)
                  call cmult(dgtq,scale,12)
                  dragpx(iobj) = dragpx(iobj) + dgtq(1,1)  
                  dragpy(iobj) = dragpy(iobj) + dgtq(2,1)
                  dragpz(iobj) = dragpz(iobj) + dgtq(3,1)
                  dragvx(iobj) = dragvx(iobj) + dgtq(1,2)  
                  dragvy(iobj) = dragvy(iobj) + dgtq(2,2)
                  dragvz(iobj) = dragvz(iobj) + dgtq(3,2)
                  torqpx(iobj) = torqpx(iobj) + dgtq(1,3)  
                  torqpy(iobj) = torqpy(iobj) + dgtq(2,3)
                  torqpz(iobj) = torqpz(iobj) + dgtq(3,3)
                  torqvx(iobj) = torqvx(iobj) + dgtq(1,4)  
                  torqvy(iobj) = torqvy(iobj) + dgtq(2,4)
                  torqvz(iobj) = torqvz(iobj) + dgtq(3,4)
               endif
            enddo
          endif
        endif
      enddo
      call gop(dragpx,w1,'+  ',maxobj+1)
      call gop(dragpy,w1,'+  ',maxobj+1)
      call gop(dragpz,w1,'+  ',maxobj+1)
      call gop(dragvx,w1,'+  ',maxobj+1)
      call gop(dragvy,w1,'+  ',maxobj+1)
      call gop(dragvz,w1,'+  ',maxobj+1)
      call gop(torqpx,w1,'+  ',maxobj+1)
      call gop(torqpy,w1,'+  ',maxobj+1)
      call gop(torqpz,w1,'+  ',maxobj+1)
      call gop(torqvx,w1,'+  ',maxobj+1)
      call gop(torqvy,w1,'+  ',maxobj+1)
      call gop(torqvz,w1,'+  ',maxobj+1)
      nobj = iglmax(nobj,1)
      do i=1,nobj
         dragx(i) = dragpx(i) + dragvx(i)
         dragy(i) = dragpy(i) + dragvy(i)
         dragz(i) = dragpz(i) + dragvz(i)
         torqx(i) = torqpx(i) + torqvx(i)
         torqy(i) = torqpy(i) + torqvy(i)
         torqz(i) = torqpz(i) + torqvz(i)
         dragpx(0) = dragpx (0) + dragpx (i)
         dragvx(0) = dragvx (0) + dragvx (i)
         dragx (0) = dragx  (0) + dragx  (i)
         dragpy(0) = dragpy (0) + dragpy (i)
         dragvy(0) = dragvy (0) + dragvy (i)
         dragy (0) = dragy  (0) + dragy  (i)
         dragpz(0) = dragpz (0) + dragpz (i)
         dragvz(0) = dragvz (0) + dragvz (i)
         dragz (0) = dragz  (0) + dragz  (i)
         torqpx(0) = torqpx (0) + torqpx (i)
         torqvx(0) = torqvx (0) + torqvx (i)
         torqx (0) = torqx  (0) + torqx  (i)
         torqpy(0) = torqpy (0) + torqpy (i)
         torqvy(0) = torqvy (0) + torqvy (i)
         torqy (0) = torqy  (0) + torqy  (i)
         torqpz(0) = torqpz (0) + torqpz (i)
         torqvz(0) = torqvz (0) + torqvz (i)
         torqz (0) = torqz  (0) + torqz  (i)
      enddo
      i0 = 0
      if (nobj <= 1) i0 = 1  
      do i=i0,nobj
        if (nio == 0) then
          if (if3d.or.ifaxis) then
           if (ifdout) then
            write(6,6) istep,time,dragx(i),dragpx(i),dragvx(i),i,'dragx'
            write(6,6) istep,time,dragy(i),dragpy(i),dragvy(i),i,'dragy'
            write(6,6) istep,time,dragz(i),dragpz(i),dragvz(i),i,'dragz'
           endif
           if (iftout) then
            write(6,6) istep,time,torqx(i),torqpx(i),torqvx(i),i,'torqx'
            write(6,6) istep,time,torqy(i),torqpy(i),torqvy(i),i,'torqy'
            write(6,6) istep,time,torqz(i),torqpz(i),torqvz(i),i,'torqz'
           endif
          else
           if (ifdout) then
            write(6,6) istep,time,dragx(i),dragpx(i),dragvx(i),i,'dragx'
            write(6,6) istep,time,dragy(i),dragpy(i),dragvy(i),i,'dragy'
           endif
           if (iftout) then
            write(6,6) istep,time,torqz(i),torqpz(i),torqvz(i),i,'torqz'
           endif
          endif
        endif
    6   format(i8,1p4e19.11,2x,i5,a5)
      enddo
      trx(1:lx1,1:ly1,1:lz1) = xm0(1,1,1,1:512)
      trz(1:lx1,1:ly1,1:lz1) = xm0(1,1,1,513:1024)
      return
      end subroutine torque_calc
      subroutine comp_sij(sij,nij,u,v,w,ur,us,ut,vr,vs,vt,wr,ws,wt)
      implicit none
      integer :: nio
      integer :: loglevel
      integer :: optlevel
      integer, intent(In) :: nelv
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
      real, dimension(1:lx1,1:lx1), intent(In) :: dxm1
      real, dimension(1:lx2,1:lx1) :: dxm12
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lx1,1:lx1), intent(In) :: dxtm1
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
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vxd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vyd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vzd
      real, dimension(1:lx1,1:lxd) :: imd1
      real, dimension(1:lxd,1:lx1) :: imd1t
      real, dimension(1:lxd,1:lx1) :: im1d
      real, dimension(1:lx1,1:lxd) :: im1dt
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t
      real :: eigas
      real :: eigaa
      real :: eigast
      real :: eigae
      real :: eigga
      real :: eiggs
      real :: eiggst
      real :: eigge
      logical :: ifaa
      logical :: ifae
      logical :: ifas
      logical :: ifast
      logical :: ifga
      logical :: ifge
      logical :: ifgs
      logical :: ifgst
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: ym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: xm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: ym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: zm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: tzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: jacm1
      real, dimension(1:lx1*ly1*lz1,1:lelt), intent(In) :: jacmi
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: txm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: szm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: jacm2
      real, dimension(1:lxd*lyd*lzd,1:ldim*ldim,1:lelv) :: rx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g1m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g2m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g3m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g4m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g5m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g6m1
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unr
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: uns
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unt
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(1:lx1*lz1,1:2*ldim,1:lelt) :: etalph
      real :: dlam
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vny
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1z
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2z
      logical :: ifgeom
      logical :: ifgmsh3
      logical :: ifvcor
      logical :: ifsurt
      logical :: ifmelt
      logical :: ifwcno
      logical, dimension(1:lelt), intent(In) :: ifrzer
      logical, dimension(1:2*ldim,1:lelv) :: ifqinp
      logical, dimension(1:2*ldim,1:lelv) :: ifeppm
      logical, dimension(0:1) :: iflmsf
      logical, dimension(0:1) :: iflmse
      logical, dimension(0:1) :: iflmsc
      logical, dimension(1:2*ldim,1:lelt,0:1) :: ifmsfc
      logical, dimension(1:12,1:lelt,0:1) :: ifmseg
      logical, dimension(1:8,1:lelt,0:1) :: ifmscr
      logical, dimension(1:8,1:lelt) :: ifnskp
      logical :: ifbcor
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
      logical, intent(In) :: if3d
      logical :: ifflow
      logical :: ifheat
      logical :: iftran
      logical, intent(In) :: ifaxis
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
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode
      character(len=2), dimension(1:8) :: ocode
      character(len=10), dimension(1:5) :: drivc
      character(len=14) :: rstv
      character(len=14) :: rstt
      character(len=40), dimension(1:100,1:2) :: textsw
      character(len=132), dimension(1:15) :: initc
      character(len=40) :: turbmod
      character(len=132) :: reafle
      character(len=132) :: fldfle
      character(len=132) :: dmpfle
      character(len=132) :: hisfle
      character(len=132) :: schfle
      character(len=132) :: orefle
      character(len=132) :: nrefle
      character(len=132) :: session
      character(len=132) :: path
      character(len=132) :: re2fle
      character(len=132) :: parfle
      integer :: cr_re2
      integer :: fh_re2
      integer(kind=8) :: re2off_b
      real, dimension(1:8,1:lelt) :: xc
      real, dimension(1:8,1:lelt) :: yc
      real, dimension(1:8,1:lelt) :: zc
      real, dimension(1:5,1:6,1:lelt,0:ldimt1) :: bc
      real, dimension(1:6,1:12,1:lelt) :: curve
      real, dimension(1:lelt) :: cerror
      integer, dimension(1:lelt) :: igroup
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object
      character(len=1), dimension(1:12,1:lelt) :: ccurve
      character(len=1), dimension(1:6,1:lelt) :: cdof
      character(len=3), dimension(1:6,1:lelt,0:ldimt1) :: cbc
      character(len=3) :: solver_type
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
      character(len=3), dimension(1:numsts) :: bctyps
      real, dimension(1:lx2,1:lx1) :: ixm12
      real, dimension(1:lx1,1:lx2) :: ixm21
      real, dimension(1:ly2,1:ly1) :: iym12
      real, dimension(1:ly1,1:ly2) :: iym21
      real, dimension(1:lz2,1:lz1) :: izm12
      real, dimension(1:lz1,1:lz2) :: izm21
      real, dimension(1:lx1,1:lx2) :: ixtm12
      real, dimension(1:lx2,1:lx1) :: ixtm21
      real, dimension(1:ly1,1:ly2) :: iytm12
      real, dimension(1:ly2,1:ly1) :: iytm21
      real, dimension(1:lz1,1:lz2) :: iztm12
      real, dimension(1:lz2,1:lz1) :: iztm21
      real, dimension(1:lx3,1:lx1) :: ixm13
      real, dimension(1:lx1,1:lx3) :: ixm31
      real, dimension(1:ly3,1:ly1) :: iym13
      real, dimension(1:ly1,1:ly3) :: iym31
      real, dimension(1:lz3,1:lz1) :: izm13
      real, dimension(1:lz1,1:lz3) :: izm31
      real, dimension(1:lx1,1:lx3) :: ixtm13
      real, dimension(1:lx3,1:lx1) :: ixtm31
      real, dimension(1:ly1,1:ly3) :: iytm13
      real, dimension(1:ly3,1:ly1) :: iytm31
      real, dimension(1:lz1,1:lz3) :: iztm13
      real, dimension(1:lz3,1:lz1) :: iztm31
      real, dimension(1:ly2,1:ly1) :: iam12
      real, dimension(1:ly1,1:ly2) :: iam21
      real, dimension(1:ly1,1:ly2) :: iatm12
      real, dimension(1:ly2,1:ly1) :: iatm21
      real, dimension(1:ly3,1:ly1) :: iam13
      real, dimension(1:ly1,1:ly3) :: iam31
      real, dimension(1:ly1,1:ly3) :: iatm13
      real, dimension(1:ly3,1:ly1) :: iatm31
      real, dimension(1:ly2,1:ly1) :: icm12
      real, dimension(1:ly1,1:ly2) :: icm21
      real, dimension(1:ly1,1:ly2) :: ictm12
      real, dimension(1:ly2,1:ly1) :: ictm21
      real, dimension(1:ly3,1:ly1) :: icm13
      real, dimension(1:ly1,1:ly3) :: icm31
      real, dimension(1:ly1,1:ly3) :: ictm13
      real, dimension(1:ly3,1:ly1) :: ictm31
      real, dimension(1:ly1,1:ly1) :: iajl1
      real, dimension(1:ly1,1:ly1) :: iatjl1
      real, dimension(1:ly2,1:ly2) :: iajl2
      real, dimension(1:ly2,1:ly2) :: iatjl2
      real, dimension(1:ly3,1:ly3) :: ialj3
      real, dimension(1:ly3,1:ly3) :: iatlj3
      real, dimension(1:ly1,1:ly1) :: ialj1
      real, dimension(1:ly1,1:ly1) :: iatlj1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: bm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: binvm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bintm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: bm2inv
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: baxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1) :: bm1lag
      real :: volvm1
      real :: volvm2
      real :: voltm1
      real :: voltm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: yinvm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: binvdg
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wy
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wxlag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wylag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wzlag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w1mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w2mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w3mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wmult
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev1
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev2
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev3
      integer :: node
      integer :: pid
      integer :: np
      integer :: nullpid
      integer :: node0
      integer(kind=8) :: nvtot
      integer, dimension(0:ldimt1) :: nelg
      integer, dimension(1:lelt) :: lglel
      integer, dimension(1:lelg) :: gllel
      integer, dimension(1:lelg) :: gllnid
      integer :: nelgv
      integer :: nelgt
      logical :: ifgprnt
      integer :: wdsize
      integer :: isize
      integer :: lsize
      integer :: csize
      integer :: wdsizi
      integer :: cr_h
      integer :: gsh
      integer, dimension(0:ldimt3) :: gsh_fld
      integer, dimension(1:ldimt3) :: xxth
      logical :: ifgsh_fld_same
      integer, dimension(1:lx1*lz1*2*ldim*lelt) :: dg_face
      integer :: dg_hndlx
      integer :: ndg_facex
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: bq
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vxlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vylag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vzlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1,1:ldimt) :: tlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: vdiff_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz
      real, dimension(1:lx1*ly1*lz1*lelv) :: vx_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: t
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vtrans
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: cflf
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmnv
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmass
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bdivw
      real, dimension(1:lxd*lyd*lzd*lelv*ldim,1:lorder+1) :: c_vx
      real, dimension(1:2*ldim,1:lelt) :: fw
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: by
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bz
      real, dimension(1:lbx2,1:lby2,1:lbz2,1:lbelv) :: pm
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmy
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmz
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz2
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bxlag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bylag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bzlag
      real, dimension(1:lbx2*lby2*lbz2*lbelv,1:lorder2) :: pmlag
      real :: nu_star
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv,1:lorder2) :: prlag
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: qtl
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: usrdiv
      real :: p0th
      real :: dp0thdt
      real :: gamma0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v1mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v2mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: omask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmult
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b1mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b2mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b3mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bpmask
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vzp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lpert) :: prp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: tp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: bqp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfzp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vxlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vylagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vzlagp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lorder2,1:lpert) :: prlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lorder-1,1:lpert) :: tlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt2p
      integer :: jp
      real, dimension(1:ldimt1) :: tauss
      real, dimension(1:ldimt1) :: txnext
      integer :: nsskip
      logical :: ifskip
      logical :: ifmodp
      logical :: ifssvt
      logical, dimension(1:ldimt1) :: ifstst
      logical :: ifexvt
      logical, dimension(1:ldimt1) :: ifextr
      real :: dvnnh1
      real :: dvnnsm
      real :: dvnnl2
      real :: dvnnl8
      real :: dvdfh1
      real :: dvdfsm
      real :: dvdfl2
      real :: dvdfl8
      real :: dvprh1
      real :: dvprsm
      real :: dvprl2
      real :: dvprl8
      integer, dimension(1:2,1:3) :: nomlis
      integer, dimension(1:6) :: nmlinv
      integer, dimension(1:6) :: group
      integer, dimension(1:6,1:6) :: skpdat
      integer, dimension(1:6) :: eface
      integer, dimension(1:6) :: eface1
      integer, dimension(-12:12,1:3) :: eskip
      integer, dimension(1:3) :: nedg
      integer :: ncmp
      integer, dimension(1:8) :: ixcn
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer :: maxmlt
      integer, dimension(0:ldimt1) :: nspmax
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer, dimension(1:8,1:lelt,0:ldimt1) :: gcnnum
      integer, dimension(1:8,1:lelt,0:ldimt1) :: lcnnum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: lednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gedtyp
      integer, dimension(1:2,0:ldimt1) :: ngcomm
      integer, dimension(1:20) :: iedge
      integer, dimension(1:2,1:4,1:6,0:1) :: iedgef
      integer, dimension(1:3,1:16) :: icedg
      integer, dimension(1:4,1:6) :: iedgfc
      integer, dimension(1:4,1:10) :: icface
      integer, dimension(1:8) :: indx
      integer, dimension(1:27) :: invedg
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
      integer :: iesolv
      logical, dimension(1:lelv) :: ifalgn
      logical, dimension(1:lelv) :: ifrsxy
      real, dimension(1:lelv) :: volel
      real, dimension(1:lx1,1:3) :: zgm1
      real, dimension(1:lx2,1:3) :: zgm2
      real, dimension(1:lx3,1:3) :: zgm3
      real, dimension(1:lx1) :: zam1
      real, dimension(1:lx2) :: zam2
      real, dimension(1:lx3) :: zam3
      real, dimension(1:lx1) :: wxm1
      real, dimension(1:ly1) :: wym1
      real, dimension(1:lz1) :: wzm1
      real, dimension(1:lx1,1:ly1,1:lz1) :: w3m1
      real, dimension(1:lx2) :: wxm2
      real, dimension(1:ly2) :: wym2
      real, dimension(1:lz2) :: wzm2
      real, dimension(1:lx2,1:ly2,1:lz2) :: w3m2
      real, dimension(1:lx3) :: wxm3
      real, dimension(1:ly3) :: wym3
      real, dimension(1:lz3) :: wzm3
      real, dimension(1:lx3,1:ly3,1:lz3) :: w3m3
      real, dimension(1:ly1) :: wam1
      real, dimension(1:ly2) :: wam2
      real, dimension(1:ly3) :: wam3
      real, dimension(1:lx1,1:ly1) :: w2am1
      real, dimension(1:lx1,1:ly1) :: w2cm1
      real, dimension(1:lx2,1:ly2) :: w2am2
      real, dimension(1:lx2,1:ly2) :: w2cm2
      real, dimension(1:lx3,1:ly3) :: w2am3
      real, dimension(1:lx3,1:ly3) :: w2cm3
      real, dimension(1:lx1) :: zgl
      real, dimension(1:lx1) :: wgl
      real, dimension(1:lx1) :: zgp
      real, dimension(1:lxq) :: wgp
      real, dimension(1:lx1*lx1) :: wgl1
      real, dimension(1:lxq*lxq) :: wgl2
      real, dimension(1:lx1*lx1) :: wgli
      real, dimension(1:lx1*lx1) :: d1
      real, dimension(1:lx1*lx1) :: d1t
      real, dimension(1:lx1*lx1) :: d2
      real, dimension(1:lx1*lx1) :: b2p
      real, dimension(1:lx1*lx1) :: b1ia1
      real, dimension(1:lx1*lx1) :: b1ia1t
      real, dimension(1:lx1*lx1) :: da
      real, dimension(1:lx1*lx1) :: dat
      real, dimension(1:lx1*lxq) :: iggl
      real, dimension(1:lx1*lxq) :: igglt
      real, dimension(1:lx1*lxq) :: dglg
      real, dimension(1:lx1*lxq) :: dglgt
      real, dimension(1:lx1*lxq) :: wglg
      real, dimension(1:lx1*lxq) :: wglgt
      integer :: e
      real, dimension(1:lx1*ly1*lz1,1:nij,1:lelv), intent(Out) :: sij
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(In) :: u
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(In) :: v
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(In) :: w
      real, dimension(1:1), intent(InOut) :: ur
      real, dimension(1:1), intent(InOut) :: us
      real, dimension(1:1), intent(InOut) :: ut
      real, dimension(1:1), intent(InOut) :: vr
      real, dimension(1:1), intent(InOut) :: vs
      real, dimension(1:1), intent(InOut) :: vt
      real, dimension(1:1), intent(InOut) :: wr
      real, dimension(1:1), intent(InOut) :: ws
      real, dimension(1:1), intent(InOut) :: wt
      real :: j
      n    = lx1-1      
      nxyz = lx1*ly1*lz1
      if (if3d) then     
       do e=1,nelv
        call local_grad3(ur,us,ut,u,n,e,dxm1,dxtm1)
        call local_grad3(vr,vs,vt,v,n,e,dxm1,dxtm1)
        call local_grad3(wr,ws,wt,w,n,e,dxm1,dxtm1)
        do i=1,nxyz
         j = jacmi(i,e)
         sij(i,1,e) = j*     2*(ur(i)*rxm1(i,1,1,e)+us(i)*sxm1(i,1,1,e)+ut(i)*txm1(i,1,1,e))
         sij(i,2,e) = j*     2*(vr(i)*rym1(i,1,1,e)+vs(i)*sym1(i,1,1,e)+vt(i)*tym1(i,1,1,e))
         sij(i,3,e) = j*     2*(wr(i)*rzm1(i,1,1,e)+ws(i)*szm1(i,1,1,e)+wt(i)*tzm1(i,1,1,e))
         sij(i,4,e) = j*     (ur(i)*rym1(i,1,1,e)+us(i)*sym1(i,1,1,e)+ut(i)*tym1(i,1,1, &
      e) +    vr(i)*rxm1(i,1,1,e)+vs(i)*sxm1(i,1,1,e)+vt(i)*txm1(i,1,1,e) )
         sij(i,5,e) = j*     (wr(i)*rym1(i,1,1,e)+ws(i)*sym1(i,1,1,e)+wt(i)*tym1(i,1,1, &
      e) +    vr(i)*rzm1(i,1,1,e)+vs(i)*szm1(i,1,1,e)+vt(i)*tzm1(i,1,1,e) )
         sij(i,6,e) = j*     (ur(i)*rzm1(i,1,1,e)+us(i)*szm1(i,1,1,e)+ut(i)*tzm1(i,1,1, &
      e) +    wr(i)*rxm1(i,1,1,e)+ws(i)*sxm1(i,1,1,e)+wt(i)*txm1(i,1,1,e) )
        enddo
       enddo
      elseif (ifaxis) then  
         do e=1,nelv
            call setaxdy ( ifrzer(e) )  
            call local_grad2(ur,us,u,n,e,dxm1,dytm1)
            call local_grad2(vr,vs,v,n,e,dxm1,dytm1)
            call local_grad2(wr,ws,w,n,e,dxm1,dytm1)
            do i=1,nxyz
               j = jacmi(i,e)
               r = ym1(i,1,1,e)                              
               sij(i,1,e) = j*             2*(ur(i)*rxm1(i,1,1,e)+us(i)*sxm1(i,1,1,e))
               sij(i,2,e) = j*             2*(vr(i)*rym1(i,1,1,e)+vs(i)*sym1(i,1,1,e))
               if (r > 0) then                              
                  sij(i,3,e) = v(i,e)/r  
               else
                  sij(i,3,e) = j*              2*(vr(i)*rym1(i,1,1,e)+vs(i)*sym1(i,1,1,e))
               endif
               sij(i,4,e) = j*              ( ur(i)*rym1(i,1,1,e)+us(i)*sym1(i,1,1, &
      e) +              vr(i)*rxm1(i,1,1,e)+vs(i)*sxm1(i,1,1,e) )
               if (r > 0) then                             
                  sij(i,5,e) = j*                ( wr(i)*rym1(i,1,1,e)+ws(i)*sym1(i,1,1, &
      e) )              - w(i,e) / r
               else
                  sij(i,5,e) = 0
               endif
               sij(i,6,e) = j*              ( wr(i)*rxm1(i,1,1,e)+ws(i)*sxm1(i,1,1,e) )
            enddo
         enddo
      else              
         do e=1,nelv
            call local_grad2(ur,us,u,n,e,dxm1,dxtm1)
            call local_grad2(vr,vs,v,n,e,dxm1,dxtm1)
            do i=1,nxyz
               j = jacmi(i,e)
               sij(i,1,e) = j*             2*(ur(i)*rxm1(i,1,1,e)+us(i)*sxm1(i,1,1,e))
               sij(i,2,e) = j*             2*(vr(i)*rym1(i,1,1,e)+vs(i)*sym1(i,1,1,e))
               sij(i,3,e) = j*             (ur(i)*rym1(i,1,1,e)+us(i)*sym1(i,1,1, &
      e) +            vr(i)*rxm1(i,1,1,e)+vs(i)*sxm1(i,1,1,e) )
            enddo
         enddo
      endif
      return
      end subroutine comp_sij

end module singleton_module_src_navier5


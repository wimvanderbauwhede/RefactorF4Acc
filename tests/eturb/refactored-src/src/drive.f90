      program main
      use singleton_module_src_dabl
! 
! 
!      Nekuse
! 
      implicit none
      real :: base_flow
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: cs
      real(kind=8) :: dcount
            integer, parameter :: maxrts=1000
      real(kind=8), dimension(1:maxrts) :: dct
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: dg2
      real, dimension(1:3,1:4) :: dgtq
      real :: domain_length
      real :: dpdx_mean
      real :: dpdy_mean
      real :: dpdz_mean
      real, dimension(0:maxobj) :: dragpx
      real, dimension(0:maxobj) :: dragpy
      real, dimension(0:maxobj) :: dragpz
      real, dimension(0:maxobj) :: dragvx
      real, dimension(0:maxobj) :: dragvy
      real, dimension(0:maxobj) :: dragvz
      real, dimension(0:maxobj) :: dragx
      real, dimension(0:maxobj) :: dragy
      real, dimension(0:maxobj) :: dragz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: ediff
      real(kind=8) :: etimes
      real(kind=8) :: etims0
      real :: ffx_new
      real :: ffy_new
      real :: ffz_new
      real :: flow_rate
      integer :: icall
      logical :: ifsync
      character, dimension(1:1) :: mpi_argv_null
      character, dimension(1:1,1:1) :: mpi_argvs_null
      integer :: mpi_bottom
      integer, dimension(1:1) :: mpi_errcodes_ignore
      integer :: mpi_in_place
            integer, parameter :: mpi_status_size=6
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
      integer, dimension(1:1) :: mpi_unweighted
      integer, dimension(1:1) :: mpi_weights_empty
      integer :: nadvc
      integer :: naxhm
      integer :: nbbbb
      integer :: nbso2
      integer :: nbsol
      integer, dimension(1:maxrts) :: ncall
      integer :: ncccc
      integer :: ncdtp
      integer :: ncopy
      integer :: ncrsl
      integer :: ncvf
      integer :: ndadd
      integer :: ndddd
      integer :: nddsl
      integer :: ndott
      integer :: ndsmn
      integer :: ndsmx
      integer :: ndsnd
      integer :: ndsum
      integer :: neeee
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: neslv
      integer :: ngop
      integer :: ngop1
      integer :: ngop_sync
      integer :: ngp2
      integer :: ngsmn
      integer :: ngsmx
      integer :: ngsum
      integer :: nhmhz
      integer :: ninv3
      integer :: ninvc
      integer :: nmltd
      integer :: nmxmf
      integer :: nmxms
      integer :: nprep
      integer :: npres
      integer :: nrout
      integer :: nsett
      integer :: nslvb
      integer :: nsolv
      integer :: nspro
      integer :: nsyc
      integer :: nusbc
      integer :: nvdss
      integer :: nwal
      real(kind=8) :: paxhm
      real(kind=8) :: pbbbb
      real(kind=8) :: pbso2
      real(kind=8) :: pbsol
      real(kind=8) :: pcccc
      real(kind=8) :: pcdtp
      real(kind=8) :: pcopy
      real(kind=8) :: pcrsl
      real(kind=8) :: pdadd
      real(kind=8) :: pdddd
      real(kind=8) :: pddsl
      real(kind=8) :: pdott
      real(kind=8) :: pdsmn
      real(kind=8) :: pdsmx
      real(kind=8) :: pdsnd
      real(kind=8) :: pdsum
      real(kind=8) :: peeee
      real(kind=8) :: peslv
      real(kind=8) :: pgop
      real(kind=8) :: pgop1
      real(kind=8) :: pgop_sync
      real(kind=8) :: pgp2
      real(kind=8) :: pgsmn
      real(kind=8) :: pgsmx
      real(kind=8) :: pgsum
      real(kind=8) :: phmhz
      real(kind=8) :: pinv3
      real(kind=8) :: pinvc
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pm1
      real(kind=8) :: pmltd
      real(kind=8) :: pmxmf
      real(kind=8) :: pmxms
      real(kind=8) :: pprep
      real(kind=8) :: ppres
      real(kind=8) :: psett
      real(kind=8) :: pslvb
      real(kind=8) :: psolv
      real(kind=8) :: pspro
      real(kind=8) :: psyc
      real(kind=8) :: pusbc
      real(kind=8) :: pvdss
      real(kind=8) :: pwal
      real(kind=8), dimension(1:maxrts) :: rct
      character(len=6), dimension(1:maxrts) :: rname
      real, dimension(1:3) :: scale_vf
      real, dimension(1:lx1*ly1*lz1,1:ldim,1:ldim) :: sij
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: snrm
      real(kind=8) :: ta2s2
      real(kind=8) :: tadc3
      real(kind=8) :: tadd2
      real(kind=8) :: tadvc
      real(kind=8) :: taxhm
      real(kind=8) :: tbbbb
      real(kind=8) :: tbso2
      real(kind=8) :: tbsol
      real(kind=8) :: tcccc
      real(kind=8) :: tcdtp
      real(kind=8) :: tcol2
      real(kind=8) :: tcol3
      real(kind=8) :: tcopy
      real(kind=8) :: tcrsl
      real(kind=8) :: tcvf
      real(kind=8) :: tdadd
      real(kind=8) :: tdddd
      real(kind=8) :: tddsl
      real(kind=8) :: tdott
      real(kind=8) :: tdsmn
      real(kind=8) :: tdsmx
      real(kind=8) :: tdsnd
      real(kind=8) :: tdsum
      real(kind=8) :: teeee
      real(kind=8) :: teslv
      real(kind=8) :: tgop
      real(kind=8) :: tgop1
      real(kind=8) :: tgop_sync
      real(kind=8) :: tgp2
      real(kind=8) :: tgsmn
      real(kind=8) :: tgsmx
      real(kind=8) :: tgsum
      real(kind=8) :: thmhz
      real(kind=8) :: tinit
      real(kind=8) :: tinv3
      real(kind=8) :: tinvc
      real(kind=8) :: tmltd
      real(kind=8) :: tmxmf
      real(kind=8) :: tmxms
      real, dimension(0:maxobj) :: torqpx
      real, dimension(0:maxobj) :: torqpy
      real, dimension(0:maxobj) :: torqpz
      real, dimension(0:maxobj) :: torqvx
      real, dimension(0:maxobj) :: torqvy
      real, dimension(0:maxobj) :: torqvz
      real, dimension(0:maxobj) :: torqx
      real, dimension(0:maxobj) :: torqy
      real, dimension(0:maxobj) :: torqz
      real(kind=8) :: tprep
      real(kind=8) :: tpres
      real(kind=8) :: tproj
      real(kind=8) :: tschw
      real(kind=8) :: tsett
      real(kind=8) :: tslvb
      real(kind=8) :: tsolv
      real(kind=8) :: tspro
      real(kind=8) :: tsyc
      real(kind=8) :: ttime
      real(kind=8) :: ttotal
      real(kind=8) :: tttstp
      real(kind=8) :: tusbc
      real(kind=8) :: tusfq
      real(kind=8) :: tvdss
      real(kind=8) :: twal
            integer, parameter :: lr=lx1*ly1*lz1
      real, dimension(1:lr) :: ur
      real, dimension(1:lr) :: us
      real, dimension(1:lr) :: ut
      real, dimension(1:lr) :: vr
      real, dimension(1:lr) :: vs
      real, dimension(1:lr) :: vt
      real, dimension(1:lr) :: wr
      real, dimension(1:lr) :: ws
      real, dimension(1:lr) :: wt
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm0
      real :: xsec
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm0
      real :: x
      real :: y
      real :: z
      real :: r
      real :: theta
      real :: ux
      real :: uy
      real :: uz
      real :: un
      real :: u1
      real :: u2
      real :: trx
      real :: try
      real :: trz
      real :: trn
      real :: tr1
      real :: tr2
      real :: pa
      real :: p0
      real :: ffx
      real :: ffy
      real :: ffz
      real :: temp
      real :: flux
      real :: hc
      real :: hrad
      real :: tinf
      real :: qvol
      real :: udiff
      real :: utrans
      real :: si2
      real :: si3
      real :: sigma
      real :: turbk
      real :: turbe
      real, dimension(1:ldimt) :: ps
      character(len=3) :: cbu
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
      integer, parameter :: lelv=lelt
      integer, parameter :: ly1=lx1
      integer, parameter :: lz1=1+(ldim-2)*(lx1-1)
      integer, parameter :: lyd=lxd
      integer, parameter :: lzd=1+(ldim-2)*(lxd-1)
      integer, parameter :: ly2=lx2
      integer, parameter :: lz2=1+(ldim-2)*(lx2-1)
      integer, parameter :: ly1m=lx1m
      integer, parameter :: lz1m=1+(ldim-2)*(lx1m-1)
      integer, parameter :: lp=lpmax
      integer, parameter :: ax1=lx1
      integer, parameter :: ay1=ax1
      integer, parameter :: az1=1+(ldim-2)*(ax1-1)
      integer, parameter :: ax2=lx2
      integer, parameter :: ay2=ax2
      integer, parameter :: az2=1+(ldim-2)*(ax2-1)
      integer, parameter :: lpelv=lpelt
      integer, parameter :: lpx1=lx1
      integer, parameter :: lpy1=lpx1
      integer, parameter :: lpz1=1+(ldim-2)*(lpx1-1)
      integer, parameter :: lpx2=lx2
      integer, parameter :: lpy2=lpx2
      integer, parameter :: lpz2=1+(ldim-2)*(lpx2-1)
      integer, parameter :: lbelv=lbelt
      integer, parameter :: lbx1=lx1
      integer, parameter :: lby1=lbx1
      integer, parameter :: lbz1=1+(ldim-2)*(lbx1-1)
      integer, parameter :: lbx2=lx2
      integer, parameter :: lby2=lbx2
      integer, parameter :: lbz2=1+(ldim-2)*(lbx2-1)
      integer, parameter :: lxz=lx1*lz1
      integer, parameter :: lzl=3+2*(ldim-3)
      integer, parameter :: ldimt1=ldimt+1
      integer, parameter :: ldimt3=ldimt+3
      integer, parameter :: lx3=lx1
      integer, parameter :: ly3=ly1
      integer, parameter :: lz3=lz1
      integer, parameter :: lctmp0=2*lx1*ly1*lz1*lelt
      integer, parameter :: lctmp1=4*lx1*ly1*lz1*lelt
      integer, parameter :: maxmor=lelt
      integer, parameter :: lxs=1
      integer, parameter :: lys=lxs
      integer, parameter :: lzs=(lxs-1)*(ldim-2)+1
      integer, parameter :: maxmbr=lelt*6
      integer, parameter :: lcvx1=lx1
      integer, parameter :: lcvy1=lcvx1
      integer, parameter :: lcvz1=1+(ldim-2)*(lcvx1-1)
      integer, parameter :: nmaxl_nn=min(1+(nsessmax-1)*2*ldim*lxz*lelt,2*ldim*lxz*lelt)
      integer, parameter :: nfldmax_nn=min(1+(nsessmax-1)*(ldim+1+ldimt),ldim+1+ldimt)
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
      real :: base_flow
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: cs
      real(kind=8) :: dcount
      real(kind=8), dimension(1:maxrts) :: dct
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: dg2
      real, dimension(1:3,1:4) :: dgtq
      real :: domain_length
      real :: dpdx_mean
      real :: dpdy_mean
      real :: dpdz_mean
      real, dimension(0:maxobj) :: dragpx
      real, dimension(0:maxobj) :: dragpy
      real, dimension(0:maxobj) :: dragpz
      real, dimension(0:maxobj) :: dragvx
      real, dimension(0:maxobj) :: dragvy
      real, dimension(0:maxobj) :: dragvz
      real, dimension(0:maxobj) :: dragx
      real, dimension(0:maxobj) :: dragy
      real, dimension(0:maxobj) :: dragz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: ediff
      real(kind=8) :: etimes
      real(kind=8) :: etims0
      real :: ffx_new
      real :: ffy_new
      real :: ffz_new
      real :: flow_rate
      integer :: icall
      logical :: ifsync
      character, dimension(1:1) :: mpi_argv_null
      character, dimension(1:1,1:1) :: mpi_argvs_null
      integer :: mpi_bottom
      integer, dimension(1:1) :: mpi_errcodes_ignore
      integer :: mpi_in_place
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
      integer, dimension(1:1) :: mpi_unweighted
      integer, dimension(1:1) :: mpi_weights_empty
      integer :: nadvc
      integer :: naxhm
      integer :: nbbbb
      integer :: nbso2
      integer :: nbsol
      integer, dimension(1:maxrts) :: ncall
      integer :: ncccc
      integer :: ncdtp
      integer :: ncopy
      integer :: ncrsl
      integer :: ncvf
      integer :: ndadd
      integer :: ndddd
      integer :: nddsl
      integer :: ndott
      integer :: ndsmn
      integer :: ndsmx
      integer :: ndsnd
      integer :: ndsum
      integer :: neeee
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: neslv
      integer :: ngop
      integer :: ngop1
      integer :: ngop_sync
      integer :: ngp2
      integer :: ngsmn
      integer :: ngsmx
      integer :: ngsum
      integer :: nhmhz
      integer :: ninv3
      integer :: ninvc
      integer :: nmltd
      integer :: nmxmf
      integer :: nmxms
      integer :: nprep
      integer :: npres
      integer :: nrout
      integer :: nsett
      integer :: nslvb
      integer :: nsolv
      integer :: nspro
      integer :: nsyc
      integer :: nusbc
      integer :: nvdss
      integer :: nwal
      real(kind=8) :: paxhm
      real(kind=8) :: pbbbb
      real(kind=8) :: pbso2
      real(kind=8) :: pbsol
      real(kind=8) :: pcccc
      real(kind=8) :: pcdtp
      real(kind=8) :: pcopy
      real(kind=8) :: pcrsl
      real(kind=8) :: pdadd
      real(kind=8) :: pdddd
      real(kind=8) :: pddsl
      real(kind=8) :: pdott
      real(kind=8) :: pdsmn
      real(kind=8) :: pdsmx
      real(kind=8) :: pdsnd
      real(kind=8) :: pdsum
      real(kind=8) :: peeee
      real(kind=8) :: peslv
      real(kind=8) :: pgop
      real(kind=8) :: pgop1
      real(kind=8) :: pgop_sync
      real(kind=8) :: pgp2
      real(kind=8) :: pgsmn
      real(kind=8) :: pgsmx
      real(kind=8) :: pgsum
      real(kind=8) :: phmhz
      real(kind=8) :: pinv3
      real(kind=8) :: pinvc
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pm1
      real(kind=8) :: pmltd
      real(kind=8) :: pmxmf
      real(kind=8) :: pmxms
      real(kind=8) :: pprep
      real(kind=8) :: ppres
      real(kind=8) :: psett
      real(kind=8) :: pslvb
      real(kind=8) :: psolv
      real(kind=8) :: pspro
      real(kind=8) :: psyc
      real(kind=8) :: pusbc
      real(kind=8) :: pvdss
      real(kind=8) :: pwal
      real(kind=8), dimension(1:maxrts) :: rct
      character(len=6), dimension(1:maxrts) :: rname
      real, dimension(1:3) :: scale_vf
      real, dimension(1:lx1*ly1*lz1,1:ldim,1:ldim) :: sij
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: snrm
      real(kind=8) :: ta2s2
      real(kind=8) :: tadc3
      real(kind=8) :: tadd2
      real(kind=8) :: tadvc
      real(kind=8) :: taxhm
      real(kind=8) :: tbbbb
      real(kind=8) :: tbso2
      real(kind=8) :: tbsol
      real(kind=8) :: tcccc
      real(kind=8) :: tcdtp
      real(kind=8) :: tcol2
      real(kind=8) :: tcol3
      real(kind=8) :: tcopy
      real(kind=8) :: tcrsl
      real(kind=8) :: tcvf
      real(kind=8) :: tdadd
      real(kind=8) :: tdddd
      real(kind=8) :: tddsl
      real(kind=8) :: tdott
      real(kind=8) :: tdsmn
      real(kind=8) :: tdsmx
      real(kind=8) :: tdsnd
      real(kind=8) :: tdsum
      real(kind=8) :: teeee
      real(kind=8) :: teslv
      real(kind=8) :: tgop
      real(kind=8) :: tgop1
      real(kind=8) :: tgop_sync
      real(kind=8) :: tgp2
      real(kind=8) :: tgsmn
      real(kind=8) :: tgsmx
      real(kind=8) :: tgsum
      real(kind=8) :: thmhz
      real(kind=8) :: tinit
      real(kind=8) :: tinv3
      real(kind=8) :: tinvc
      real(kind=8) :: tmltd
      real(kind=8) :: tmxmf
      real(kind=8) :: tmxms
      real, dimension(0:maxobj) :: torqpx
      real, dimension(0:maxobj) :: torqpy
      real, dimension(0:maxobj) :: torqpz
      real, dimension(0:maxobj) :: torqvx
      real, dimension(0:maxobj) :: torqvy
      real, dimension(0:maxobj) :: torqvz
      real, dimension(0:maxobj) :: torqx
      real, dimension(0:maxobj) :: torqy
      real, dimension(0:maxobj) :: torqz
      real(kind=8) :: tprep
      real(kind=8) :: tpres
      real(kind=8) :: tproj
      real(kind=8) :: tschw
      real(kind=8) :: tsett
      real(kind=8) :: tslvb
      real(kind=8) :: tsolv
      real(kind=8) :: tspro
      real(kind=8) :: tsyc
      real(kind=8) :: ttime
      real(kind=8) :: ttotal
      real(kind=8) :: tttstp
      real(kind=8) :: tusbc
      real(kind=8) :: tusfq
      real(kind=8) :: tvdss
      real(kind=8) :: twal
      real, dimension(1:lr) :: ur
      real, dimension(1:lr) :: us
      real, dimension(1:lr) :: ut
      real, dimension(1:lr) :: vr
      real, dimension(1:lr) :: vs
      real, dimension(1:lr) :: vt
      real, dimension(1:lr) :: wr
      real, dimension(1:lr) :: ws
      real, dimension(1:lr) :: wt
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm0
      real :: xsec
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm0
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
      integer, parameter :: numsts=50
      integer, parameter :: nelgt_max=178956970
      integer, parameter :: lvt1=lx1*ly1*lz1*lelv
      integer, parameter :: lvt2=lx2*ly2*lz2*lelv
      integer, parameter :: lbt1=lbx1*lby1*lbz1*lbelv
      integer, parameter :: lbt2=lbx2*lby2*lbz2*lbelv
      integer, parameter :: lorder2=max(1,lorder-2)
      integer, parameter :: lxq=lx2
! 
!      Elemental derivative operators
! 
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
! 
!     Dealiasing variables
! 
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vxd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vyd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vzd
      real, dimension(1:lx1,1:lxd) :: imd1
      real, dimension(1:lxd,1:lx1) :: imd1t
      real, dimension(1:lxd,1:lx1) :: im1d
      real, dimension(1:lx1,1:lxd) :: im1dt
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t
! 
!      Eigenvalues
! 
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
! 
!      Geometry arrays
! 
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
! 
!      Input parameters from preprocessors.
! 
!      Note that in parallel implementations, we distinguish between
!      distributed data (LELT) and uniformly distributed data.
! 
!      Input common block structure:
! 
!      INPUT1:  REAL            INPUT5: REAL      with LELT entries
!      INPUT2:  INTEGER         INPUT6: INTEGER   with LELT entries
!      INPUT3:  LOGICAL         INPUT7: LOGICAL   with LELT entries
!      INPUT4:  CHARACTER       INPUT8: CHARACTER with LELT entries
! 
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
! 
!  proportional to LELT
! 
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
! 
!  material set ids, BC set ids, materials (f=fluid, s=solid), bc types
! 
      integer :: numflu
      integer :: numoth
      integer :: numbcs
      integer, dimension(1:numsts) :: matindx
      integer, dimension(1:numsts) :: matids
      integer, dimension(1:lelt) :: imatie
      integer, dimension(1:numsts) :: ibcsts
      integer, dimension(1:numsts) :: bcf
      character(len=3), dimension(1:numsts) :: bctyps
! 
!      Interpolation operators
! 
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
! 
!      Mass matrix
! 
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
! 
!      Moving mesh variables
! 
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
! 
!      Communication information
!      NOTE: NID is stored in 'SIZE' for greater accessibility
      integer :: node
      integer :: pid
      integer :: np
      integer :: nullpid
      integer :: node0
! 
!      Maximum number of elements (limited to 2**31/12, at least for now)
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
!      crystal-router, gather-scatter, and xxt handles (xxt=csr grid solve)
! 
      integer :: cr_h
      integer :: gsh
      integer, dimension(0:ldimt3) :: gsh_fld
      integer, dimension(1:ldimt3) :: xxth
      logical :: ifgsh_fld_same
!      These arrays need to be reconciled with cmt (pff, 11/03/15)
      integer, dimension(1:lx1*lz1*2*ldim*lelt) :: dg_face
      integer :: dg_hndlx
      integer :: ndg_facex
! 
!      Main storage of simulation variables
! 
! 
!      Solution and data
! 
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: bq
!      Can be used for post-processing runs (SIZE .gt. 10+3*LDIMT flds)
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
!      Solution data
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
!      Solution data for magnetic field
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
! 
! 
!      Solution and data for perturbation fields
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
! 
!      Steady variables
! 
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
! 
!      Arrays for direct stiffness summation
! 
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
!  
!      Variables related to time integration
! 
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
! 
!      Variables for E-solver
! 
      integer :: iesolv
      logical, dimension(1:lelv) :: ifalgn
      logical, dimension(1:lelv) :: ifrsxy
      real, dimension(1:lelv) :: volel
! 
!      Gauss-Labotto and Gauss points
! 
      real, dimension(1:lx1,1:3) :: zgm1
      real, dimension(1:lx2,1:3) :: zgm2
      real, dimension(1:lx3,1:3) :: zgm3
      real, dimension(1:lx1) :: zam1
      real, dimension(1:lx2) :: zam2
      real, dimension(1:lx3) :: zam3
! 
!     Weights
! 
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
! 
!      Points (z) and weights (w) on velocity, pressure
! 
!      zgl -- velocity points on Gauss-Lobatto points i = 1,...nx
!      zgp -- pressure points on Gauss         points i = 1,...nxp (nxp = nx-2)
! 
!      integer    lxm ! defined in HSMG
!      parameter (lxm = lx1)
! 
      real, dimension(1:lx1) :: zgl
      real, dimension(1:lx1) :: wgl
      real, dimension(1:lx1) :: zgp
      real, dimension(1:lxq) :: wgp
! 
!      Tensor- (outer-) product of 1D weights   (for volumetric integration)
! 
      real, dimension(1:lx1*lx1) :: wgl1
      real, dimension(1:lxq*lxq) :: wgl2
      real, dimension(1:lx1*lx1) :: wgli
! 
! 
!     Frequently used derivative matrices:
! 
!     D1, D1t   ---  differentiate on mesh 1 (velocity mesh)
!     D2, D2t   ---  differentiate on mesh 2 (pressure mesh)
! 
!     DXd,DXdt  ---  differentiate from velocity mesh ONTO dealiased mesh
!                    (currently the same as D1 and D1t...)
! 
! 
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
      integer, parameter :: lfdm0=1-lfdm
      integer, parameter :: lelg_sm=lfdm0+lfdm*lelg
      integer, parameter :: ltfdm2=lfdm0+lfdm*2*lx2*ly2*lz2*lelt
      integer, parameter :: leig2=lfdm0+lfdm*2*lx2*lx2*(lelx*lelx+lely*lely+lelz*lelz)
      integer, parameter :: leig=lfdm0+lfdm*2*lx2*(lelx+lely+lelz)
      integer, parameter :: lp_small=256
      integer, parameter :: lfdx=lfdm0+lfdm*lx2*lelx
      integer, parameter :: lfdy=lfdm0+lfdm*ly2*lely
      integer, parameter :: lfdz=lfdm0+lfdm*lz2*lelz
! 
!      Perturbation variables
! 
!      Eigenvalue arrays and pointers for Global Tensor Product 
!      parameter (lelg_sm=2)
!      parameter (ltfdm2 =2)
!      parameter (lelg_sm=lelg)
!      parameter (ltfdm2=2*lx2*ly2*lz2*lelt)
!      parameter (leig2=2*lx2*lx2*(lelx*lelx+lely*lely+lelz*lelz))
!      parameter (leig =2*lx2*(lelx+lely+lelz))
      integer :: neigx
      integer :: neigy
      integer :: neigz
      integer :: pvalx
      integer :: pvaly
      integer :: pvalz
      integer :: pvecx
      integer :: pvecy
      integer :: pvecz
      real, dimension(1:leig2) :: sp
      real, dimension(1:leig2) :: spt
      real, dimension(1:leig) :: eigp
      real, dimension(1:ltfdm2) :: wavep
! 
      integer, dimension(1:3,1:2) :: msp
      integer, dimension(1:3,1:2) :: mlp
!      Logical, array and geometry data for tensor-product box
      logical :: ifycrv
      logical :: ifzper
      logical :: ifgfdm
      logical :: ifgtp
      logical :: ifemat
      integer :: nelx
      integer :: nely
      integer :: nelz
      integer :: nelxy
      integer, dimension(1:3) :: lex2pst
      integer, dimension(1:3) :: pst2lex
      integer, dimension(1:3) :: ngfdm_p
      integer, dimension(1:3,1:2) :: ngfdm_v
!      Complete exchange arrays for pressure
!      real part_in(0:lp),part_out(0:lp)
!      common /gfdmcx/  part_in,part_out
      integer, dimension(0:lp_small) :: part_in
      integer, dimension(0:lp_small) :: part_out
      integer, dimension(0:lp_small,1:2) :: msg_id
      integer :: mcex
!      Permutation arrays for gfdm pressure solve
      integer, dimension(1:ltfdm2) :: tpn1
      integer, dimension(1:ltfdm2) :: tpn2
      integer, dimension(1:ltfdm2) :: tpn3
      integer, dimension(1:ltfdm2) :: ind23
      real, dimension(0:lelx) :: xgtp
      real, dimension(0:lely) :: ygtp
      real, dimension(0:lelz) :: zgtp
      real, dimension(1:lfdx) :: xmlt
      real, dimension(1:lfdy) :: ymlt
      real, dimension(1:lfdz) :: zmlt
!      Metrics for 2D x tensor-product solver
      real, dimension(1:lx2,1:ly2,1:lelv) :: rx2
      real, dimension(1:lx2,1:ly2,1:lelv) :: ry2
      real, dimension(1:lx2,1:ly2,1:lelv) :: sx2
      real, dimension(1:lx2,1:ly2,1:lelv) :: sy2
      real, dimension(1:lx2,1:ly2,1:lelv) :: w2d
      real, dimension(1:lx1,1:ly1,1:lelv) :: bxyi
      character(len=3), dimension(1:6,0:ldimt1+1) :: gtp_cbc
      call userchk(ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,base_flow,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,bxyi,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2,cs,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg2,dg_face,dg_hndlx,dglg,dglgt,dgtq,dlam,dmpfle,domain_length,dp0thdt,dpdx_mean,dpdy_mean,dpdz_mean,dragpx,dragpy,dragpz,dragvx,dragvy,dragvz,dragx,dragy,dragz,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,ediff,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eigp,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,ffx_new,ffy_new,ffz_new,fh_re2,filtertype,fintim,fldfle,flow_rate,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,gtp_cbc,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt,ifemat,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgfdm,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifgtp,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,ifycrv,ifzper,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,ind23,indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum,lex2pst,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mcex,mlp,mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,msg_id,msp,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,neigx,neigy,neigz,nekcomm,nekgroup,nekreal,nelfld,nelg,nelgt,nelgv,nelt,nelv,nelx,nelxy,nely,nelz,neslv,nfield,ngcomm,ngeom,ngfdm_p,ngfdm_v,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,part_in,part_out,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pm1,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,pst2lex,psyc,pusbc,pvalx,pvaly,pvalz,pvdss,pvecx,pvecy,pvecz,pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rx2,rxm1,rxm2,ry2,rym1,rym2,rzm1,rzm2,scale_vf,schfle,session,sij,skpdat,snrm,solver_type,sp,spt,sx2,sxm1,sxm2,sy2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,torqpx,torqpy,torqpz,torqvx,torqvy,torqvz,torqx,torqy,torqz,tp,tpn1,tpn2,tpn3,tprep,tpres,tproj,trx,trz,tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,ur,us,usrdiv,ut,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vr,vs,vt,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2,w2cm3,w2d,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wavep,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt,wgli,wgp,wmult,wr,ws,wt,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc,xgtp,xm0,xm1,xm2,xmlt,xsec,xxth,yc,ygtp,yinvm1,ym0,ym1,ym2,ymlt,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zgtp,zm0,zm1,zm2,zmlt)

      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      end program main

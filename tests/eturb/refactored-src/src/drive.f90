      program main
      use singleton_module_src_dabl
      use params_SIZE, only : lx1, maxmbr, ldimt1, lelg, ly2, ldimt, maxobj, lz2, lx2, lhis, lelt, ly1, lelv, ldim, lz1
!!      use params_TOTAL ! ONLY LIST EMPTY
!!      use params_ZPER ! ONLY LIST EMPTY
      implicit none
      real :: base_flow
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: cs
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
      real :: ffx_new
      real :: ffy_new
      real :: ffz_new
      real :: flow_rate
      integer :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: nid
      integer :: np
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pm1
      real, dimension(1:3) :: scale_vf
      real, dimension(1:lx1*ly1*lz1,1:ldim,1:ldim) :: sij
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: snrm
      real, dimension(0:maxobj) :: torqpx
      real, dimension(0:maxobj) :: torqpy
      real, dimension(0:maxobj) :: torqpz
      real, dimension(0:maxobj) :: torqvx
      real, dimension(0:maxobj) :: torqvy
      real, dimension(0:maxobj) :: torqvz
      real, dimension(0:maxobj) :: torqx
      real, dimension(0:maxobj) :: torqy
      real, dimension(0:maxobj) :: torqz
      real, dimension(1:lx1,1:ly1,1:lz1) :: trx
      real, dimension(1:lx1,1:ly1,1:lz1) :: trz
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
      integer :: nelv_GLOB
      integer :: nx1_GLOB
      integer :: ny1_GLOB
      integer :: nz1_GLOB
      logical :: ifuservp_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: t_GLOB
      integer :: istep_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz
      logical :: if3d
      real, dimension(1:lx1,1:lx1) :: dxm1
      real, dimension(1:lx1,1:lx1) :: dxtm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1
      logical :: ifaxis
      integer :: nrout
            integer, parameter :: maxrts=1000
      character(len=6), dimension(1:maxrts) :: rname
      real(kind=8), dimension(1:maxrts) :: dct
      integer, dimension(1:maxrts) :: ncall
      real(kind=8) :: dcount
      real(kind=8) :: tmxmf
      logical :: ifneknek
      real(kind=8) :: ttotal
      real(kind=8) :: etimes
      real(kind=8) :: tprep
      real(kind=8) :: ttime
      integer(kind=8) :: nvtot
      logical :: ifsync
      real(kind=8) :: tgop
      integer :: ngop
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real, dimension(1:200) :: param
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff
      integer :: nobj
      integer :: nhis
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode
      integer, dimension(1:4,1:lhis+maxobj) :: lochis
      integer, dimension(1:maxobj) :: nmember
      integer :: ifield
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object
      integer, dimension(1:lelg) :: gllnid
      integer, dimension(1:lelg) :: gllel
      integer :: nio
      real :: time
      logical :: ifsplit
      real, dimension(1:lx1,1:lx2) :: ixm21
      real, dimension(1:ly2,1:ly1) :: iytm21
      real, dimension(1:lz2,1:lz1) :: iztm21
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult
      real(kind=8) :: tcol2
      real(kind=8) :: ta2s2
      logical, dimension(1:lelt) :: ifrzer
      real, dimension(1:ly1,1:ly1) :: dytm1
      real, dimension(1:ly1,1:ly1) :: dym1
      real, dimension(1:ly1,1:ly1) :: dam1
      real, dimension(1:ly1,1:ly1) :: datm1
      real, dimension(1:ly1,1:ly1) :: dcm1
      real, dimension(1:ly1,1:ly1) :: dctm1
      integer, dimension(1:6) :: eface1
      integer, dimension(1:6,1:6) :: skpdat
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      integer :: nelt
      call userchk(base_flow,cs,dg2,dgtq,domain_length,dpdx_mean,dpdy_mean,dpdz_mean,dragpx,dragpy,dragpz,dragvx,dragvy,dragvz,dragx,dragy,dragz,ediff,ffx_new,ffy_new,ffz_new,flow_rate,icall,nekcomm,nekgroup,nekreal,nid,np,pm1,scale_vf,sij,snrm,torqpx,torqpy,torqpz,torqvx,torqvy,torqvz,torqx,torqy,torqz,trx,trz,ur,us,ut,vr,vs,vt,wr,ws,wt,xm0,xsec,ym0,zm0,nelv_GLOB,nx1_GLOB,ny1_GLOB,nz1_GLOB,ifuservp_GLOB,t_GLOB,istep_GLOB,vx_GLOB,vy,vz,if3d,dxm1,dxtm1,jacmi,rxm1,sxm1,txm1,rym1,sym1,tym1,rzm1,szm1,tzm1,ifaxis,nrout,rname,dct,ncall,dcount,tmxmf,ifneknek,ttotal,etimes,tprep,ttime,nvtot,ifsync,tgop,ngop,pr,param,xm1,ym1,zm1,vdiff,nobj,nhis,hcode,lochis,nmember,ifield,object,gllnid,gllel,nio,time,ifsplit,ixm21,iytm21,iztm21,vmult,tcol2,ta2s2,ifrzer,dytm1,dym1,dam1,datm1,dcm1,dctm1,eface1,skpdat,area,unx,uny,unz,nelt)
      end program main

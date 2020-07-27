! -----------------------------------------------------------------------
module singleton_module_src_navier5

      use singleton_module_src_math
      use singleton_module_src_mxm_wrapper
      use singleton_module_src_comm_mpi
      use singleton_module_src_subs1
contains

      subroutine mappr(pm1,pm2,pa,pb,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
      b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd, &
      bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx, &
      bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno, &
      cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12, &
      datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icedg,icface, &
      icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc, &
      iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv, &
      ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff, &
      ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3, &
      ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf, &
      iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd, &
      ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp, &
      ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync, &
      iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo, &
      ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall, &
      ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott, &
      ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield, &
      ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid, &
      ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj, &
      node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax, &
      nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc, &
      nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask, &
      optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl, &
      pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn, &
      pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep, &
      ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl, &
      rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2, &
      schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z, &
      ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl, &
      tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
! 
      implicit none
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
      real, dimension(1:1) :: pm1_copy
      real, dimension(1:1) :: pm2_copy
      integer, parameter :: maxrts=1000
      real(kind=8), intent(InOut) :: dcount
      real(kind=8), dimension(1:maxrts), intent(InOut) :: dct
      real(kind=8) :: etimes
      real(kind=8) :: etims0
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
      integer, dimension(1:maxrts), intent(InOut) :: ncall
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
      integer, intent(InOut) :: nrout
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
      character(len=6), dimension(1:maxrts), intent(Out) :: rname
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
      real(kind=8), intent(Out) :: tcol2
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
      real(kind=8), intent(Out) :: tmxmf
      real(kind=8) :: tmxms
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
      integer :: nglob1
      integer :: nyz2
      integer :: nxy1
      integer :: nxyz
      integer :: iel
      integer :: iz
      integer :: nio
      ! cvode
      ! nek-nek
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
      integer, parameter :: numsts=50
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
      real, dimension(1:lx1,1:lx2), intent(InOut) :: ixm21
      real, dimension(1:ly2,1:ly1) :: iym12
      real, dimension(1:ly1,1:ly2) :: iym21
      real, dimension(1:lz2,1:lz1) :: izm12
      real, dimension(1:lz1,1:lz2) :: izm21
      real, dimension(1:lx1,1:lx2) :: ixtm12
      real, dimension(1:lx2,1:lx1) :: ixtm21
      real, dimension(1:ly1,1:ly2) :: iytm12
      real, dimension(1:ly2,1:ly1), intent(InOut) :: iytm21
      real, dimension(1:lz1,1:lz2) :: iztm12
      real, dimension(1:lz2,1:lz1), intent(InOut) :: iztm21
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
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: vmult
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
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(InOut) :: pm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv), intent(InOut) :: pm2
      real, dimension(1:lx1,1:ly2,1:lz2), intent(InOut) :: pa
      real, dimension(1:lx1,1:ly1,1:lz2), intent(InOut) :: pb
! 
! 
!      Map the pressure onto the velocity mesh
      nglob1 = lx1*ly1*lz1*nelv
      nyz2   = ly2*lz2
      nxy1   = lx1*ly1
      nxyz   = lx1*ly1*lz1
! 
      if (ifsplit) then
         pm1_copy = reshape(pm1,shape(pm1_copy))
         pm2_copy = reshape(pm2,shape(pm2_copy))
         call copy(pm1_copy,pm2_copy,nglob1)

         pm1 = reshape(pm1_copy, shape(pm1))
         pm2 = reshape(pm2_copy, shape(pm2))
      else
         do iel=1,nelv
            call mxm(ixm21,lx1,pm2(1,1,1,iel),lx2,pa(1,1,1),nyz2,ab,abmsh,abx1,abx2,aby1,aby2,abz1, &
      abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1, &
      bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1, &
      bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc, &
      ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1, &
      dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face, &
      dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8, &
      dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12, &
      dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1, &
      eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3, &
      exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1, &
      g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1, &
      iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21, &
      iatm31,ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess, &
      ieact,iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls, &
      ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic, &
      ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin, &
      ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps, &
      ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio, &
      ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt, &
      ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt, &
      ifstrs,ifstst,ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor, &
      ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh, &
      indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize, &
      istep,ixcn,ixm12,ixm13,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12, &
      iytm13,iytm21,iytm31,izm12,izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi, &
      jp,lastep,lcnnum,ldimr,lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt, &
      mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd, &
      nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv, &
      nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped, &
      ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf, &
      nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout, &
      nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu, &
      numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd, &
      object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc, &
      pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd, &
      pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss, &
      pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1, &
      rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y, &
      t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2, &
      tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw, &
      tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag, &
      tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf, &
      tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett, &
      tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1, &
      tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z, &
      v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2, &
      vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag, &
      vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2, &
      w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1, &
      wgl2,wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag, &
      wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp, &
      zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
            do iz=1,lz2
               call mxm(pa(1,1,iz),lx1,iytm21,ly2,pb(1,1,iz),ly1,ab,abmsh,abx1,abx2,aby1,aby2,abz1, &
      abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1, &
      bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1, &
      bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc, &
      ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1, &
      dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face, &
      dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8, &
      dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12, &
      dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1, &
      eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3, &
      exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1, &
      g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1, &
      iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21, &
      iatm31,ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess, &
      ieact,iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls, &
      ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic, &
      ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin, &
      ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps, &
      ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio, &
      ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt, &
      ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt, &
      ifstrs,ifstst,ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor, &
      ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh, &
      indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize, &
      istep,ixcn,ixm12,ixm13,ixm21,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31, &
      iytm12,iytm13,iytm31,izm12,izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi, &
      jp,lastep,lcnnum,ldimr,lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt, &
      mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd, &
      nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv, &
      nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped, &
      ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf, &
      nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout, &
      nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu, &
      numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd, &
      object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc, &
      pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd, &
      pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss, &
      pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1, &
      rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y, &
      t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2, &
      tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw, &
      tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag, &
      tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf, &
      tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett, &
      tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1, &
      tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z, &
      v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2, &
      vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag, &
      vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2, &
      w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1, &
      wgl2,wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag, &
      wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp, &
      zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
  end do
            call mxm(pb(1,1,1),nxy1,iztm21,lz2,pm1(1,1,1,iel),lz1,ab,abmsh,abx1,abx2,aby1,aby2,abz1, &
      abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1, &
      bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1, &
      bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc, &
      ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1, &
      dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face, &
      dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8, &
      dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12, &
      dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1, &
      eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3, &
      exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1, &
      g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1, &
      iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21, &
      iatm31,ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess, &
      ieact,iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls, &
      ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic, &
      ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin, &
      ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps, &
      ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio, &
      ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt, &
      ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt, &
      ifstrs,ifstst,ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor, &
      ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh, &
      indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize, &
      istep,ixcn,ixm12,ixm13,ixm21,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31, &
      iytm12,iytm13,iytm21,iytm31,izm12,izm13,izm21,izm31,iztm12,iztm13,iztm31,jacm1,jacm2,jacmi, &
      jp,lastep,lcnnum,ldimr,lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt, &
      mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd, &
      nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv, &
      nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped, &
      ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf, &
      nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout, &
      nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu, &
      numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd, &
      object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc, &
      pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd, &
      pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss, &
      pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1, &
      rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y, &
      t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2, &
      tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw, &
      tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag, &
      tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf, &
      tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett, &
      tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1, &
      tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z, &
      v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2, &
      vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag, &
      vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2, &
      w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1, &
      wgl2,wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag, &
      wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp, &
      zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
  end do
!      Average the pressure on elemental boundaries
       ifield=1
       call dssum (pm1,lx1,ly1,lz1)
       call col2  (pm1,vmult,nglob1)
      endif
! 
! 
      return
      end subroutine mappr
      subroutine local_grad3(ur,us,ut,u,n,e,d,dt,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol, &
      avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc, &
      bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv, &
      bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror, &
      cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat, &
      datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg, &
      dglgt,dlam,dmpfle,dp0thdt,drivc,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1, &
      dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1, &
      dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae, &
      eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p, &
      exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1, &
      gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1, &
      ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31, &
      ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact, &
      iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas, &
      ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal, &
      ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge, &
      ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc, &
      iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg, &
      ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco, &
      ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst, &
      ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps, &
      ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep, &
      invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13, &
      ixm21,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31, &
      izm12,izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum, &
      ldimr,lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd, &
      nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv, &
      nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped, &
      ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf, &
      nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout, &
      nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu, &
      numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd, &
      object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc, &
      pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd, &
      pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss, &
      pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1, &
      rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y, &
      t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2, &
      tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw, &
      tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag, &
      tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf, &
      tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett, &
      tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1, &
      tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z, &
      v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2, &
      vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag, &
      vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2, &
      w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1, &
      wgl2,wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag, &
      wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp, &
      zm1,zm2)
!      Output: ur,us,ut         Input:u,N,e,D,Dt
      implicit none
      real, dimension(1:n1,1:n3) :: ur_mxm
      real, dimension(1:n1,1:n3) :: ut_mxm
      integer, parameter :: lorder=3
      integer, parameter :: lorder2=max(1,lorder-2)
      integer, parameter :: lx1=8
      integer, parameter :: lx2=lx1-2
      integer, parameter :: lxq=lx2
      integer, parameter :: maxrts=1000
      integer, parameter :: numsts=50
      real, dimension(1:10) :: ab
      real, dimension(1:10) :: abmsh
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz2
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(0:ldimt1) :: atol
      real, dimension(1:ldimt1) :: avdiff
      real, dimension(1:ldimt1) :: avtran
      real, dimension(1:lx1*lx1) :: b1ia1
      real, dimension(1:lx1*lx1) :: b1ia1t
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b1mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b2mask
      real, dimension(1:lx1*lx1) :: b2p
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: baxm1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz2
      real, dimension(1:5,1:6,1:lelt,0:ldimt1) :: bc
      integer, dimension(1:numsts) :: bcf
      character(len=3), dimension(1:numsts) :: bctyps
      real, dimension(1:10) :: bd
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bdivw
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfx
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfxp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfy
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfyp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfz
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfzp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bintm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: binvdg
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: binvm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1) :: bm1lag
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: bm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: bm2inv
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmass
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmnv
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmy
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmz
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bpmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: bq
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: bqp
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bx
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bxlag
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: by
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bylag
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bz
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bzlag
      real, dimension(1:lxd*lyd*lzd*lelv*ldim,1:lorder+1) :: c_vx
      character(len=3), dimension(1:6,1:lelt,0:ldimt1) :: cbc
      character(len=1), dimension(1:12,1:lelt) :: ccurve
      character(len=1), dimension(1:6,1:lelt) :: cdof
      real, dimension(1:lelt) :: cerror
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: cflf
      real :: courno
      real, dimension(1:ldimt1,1:3) :: cpfld
      real, dimension(-5:10,1:ldimt1,1:3) :: cpgrp
      integer :: cr_h
      integer :: cr_re2
      integer :: csize
      real :: ctarg
      real, dimension(1:6,1:12,1:lelt) :: curve
      real, dimension(1:lx1*lx1) :: d1
      real, dimension(1:lx1*lx1) :: d1t
      real, dimension(1:lx1*lx1) :: d2
      real, dimension(1:lx1*lx1) :: da
      real, dimension(1:ly1,1:ly1) :: dam1
      real, dimension(1:ly2,1:ly1) :: dam12
      real, dimension(1:ly3,1:ly3) :: dam3
      real, dimension(1:lx1*lx1) :: dat
      real, dimension(1:ly1,1:ly1) :: datm1
      real, dimension(1:ly1,1:ly2) :: datm12
      real, dimension(1:ly3,1:ly3) :: datm3
      real, dimension(1:ly1,1:ly1) :: dcm1
      real, dimension(1:ly2,1:ly1) :: dcm12
      real, dimension(1:ly3,1:ly3) :: dcm3
      real(kind=8), intent(InOut) :: dcount
      real(kind=8), dimension(1:maxrts), intent(InOut) :: dct
      real, dimension(1:ly1,1:ly1) :: dctm1
      real, dimension(1:ly1,1:ly2) :: dctm12
      real, dimension(1:ly3,1:ly3) :: dctm3
      integer, dimension(1:lx1*lz1*2*ldim*lelt) :: dg_face
      integer :: dg_hndlx
      real, dimension(1:lx1*lxq) :: dglg
      real, dimension(1:lx1*lxq) :: dglgt
      real :: dlam
      character(len=132) :: dmpfle
      real :: dp0thdt
      character(len=10), dimension(1:5) :: drivc
      real :: dtinit
      real :: dtinvm
      real, dimension(1:10) :: dtlag
      real :: dvdfh1
      real :: dvdfl2
      real :: dvdfl8
      real :: dvdfsm
      real :: dvnnh1
      real :: dvnnl2
      real :: dvnnl8
      real :: dvnnsm
      real :: dvprh1
      real :: dvprl2
      real :: dvprl8
      real :: dvprsm
      real, dimension(1:lx1,1:lx1) :: dxm1
      real, dimension(1:lx2,1:lx1) :: dxm12
      real, dimension(1:lx3,1:lx3) :: dxm3
      real, dimension(1:lx1,1:lx1) :: dxtm1
      real, dimension(1:lx1,1:lx2) :: dxtm12
      real, dimension(1:lx3,1:lx3) :: dxtm3
      real, dimension(1:ly1,1:ly1) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:ly3,1:ly3) :: dym3
      real, dimension(1:ly1,1:ly1) :: dytm1
      real, dimension(1:ly1,1:ly2) :: dytm12
      real, dimension(1:ly3,1:ly3) :: dytm3
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lz3,1:lz3) :: dzm3
      real, dimension(1:lz1,1:lz1) :: dztm1
      real, dimension(1:lz1,1:lz2) :: dztm12
      real, dimension(1:lz3,1:lz3) :: dztm3
      integer, dimension(1:6) :: eface
      integer, dimension(1:6) :: eface1
      real :: eigaa
      real :: eigae
      real :: eigas
      real :: eigast
      real :: eigga
      real :: eigge
      real :: eiggs
      real :: eiggst
      integer, dimension(-12:12,1:3) :: eskip
      real, dimension(1:lx1*lz1,1:2*ldim,1:lelt) :: etalph
      real(kind=8) :: etimes
      real(kind=8) :: etims0
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev1
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev2
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev3
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz2p
      integer :: fh_re2
      real :: filtertype
      real :: fintim
      character(len=132) :: fldfle
      real, dimension(1:2*ldim,1:lelt) :: fw
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g1m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g2m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g3m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g4m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g5m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g6m1
      real :: gamma0
      integer, dimension(1:8,1:lelt,0:ldimt1) :: gcnnum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gedtyp
      integer, dimension(1:lelg) :: gllel
      integer, dimension(1:lelg) :: gllnid
      integer, dimension(1:6) :: group
      integer :: gsh
      integer, dimension(0:ldimt3) :: gsh_fld
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode
      character(len=132) :: hisfle
      real, dimension(1:ly1,1:ly1) :: iajl1
      real, dimension(1:ly2,1:ly2) :: iajl2
      real, dimension(1:ly1,1:ly1) :: ialj1
      real, dimension(1:ly3,1:ly3) :: ialj3
      real, dimension(1:ly2,1:ly1) :: iam12
      real, dimension(1:ly3,1:ly1) :: iam13
      real, dimension(1:ly1,1:ly2) :: iam21
      real, dimension(1:ly1,1:ly3) :: iam31
      real, dimension(1:ly1,1:ly1) :: iatjl1
      real, dimension(1:ly2,1:ly2) :: iatjl2
      real, dimension(1:ly1,1:ly1) :: iatlj1
      real, dimension(1:ly3,1:ly3) :: iatlj3
      real, dimension(1:ly1,1:ly2) :: iatm12
      real, dimension(1:ly1,1:ly3) :: iatm13
      real, dimension(1:ly2,1:ly1) :: iatm21
      real, dimension(1:ly3,1:ly1) :: iatm31
      integer, dimension(1:numsts) :: ibcsts
      integer, dimension(1:3,1:16) :: icedg
      integer, dimension(1:4,1:10) :: icface
      real, dimension(1:ly2,1:ly1) :: icm12
      real, dimension(1:ly3,1:ly1) :: icm13
      real, dimension(1:ly1,1:ly2) :: icm21
      real, dimension(1:ly1,1:ly3) :: icm31
      real, dimension(1:ly1,1:ly2) :: ictm12
      real, dimension(1:ly1,1:ly3) :: ictm13
      real, dimension(1:ly2,1:ly1) :: ictm21
      real, dimension(1:ly3,1:ly1) :: ictm31
      integer, dimension(1:ldimt) :: idpss
      integer :: idsess
      integer, dimension(1:lelt) :: ieact
      integer, dimension(1:20) :: iedge
      integer, dimension(1:2,1:4,1:6,0:1) :: iedgef
      integer, dimension(1:4,1:6) :: iedgfc
      integer :: iesolv
      logical :: if3d
      logical :: if_full_pres
      logical :: ifaa
      logical, dimension(1:ldimt1) :: ifadvc
      logical :: ifae
      logical, dimension(1:lelv) :: ifalgn
      logical :: ifanl2
      logical :: ifanls
      logical :: ifas
      logical :: ifast
      logical :: ifaxis
      logical :: ifaziv
      logical :: ifbase
      logical :: ifbcor
      logical :: ifbo
      logical :: ifchar
      logical :: ifcons
      logical :: ifcoup
      logical, dimension(1:ldimt1) :: ifcvfld
      logical :: ifcvode
      logical :: ifcyclic
      logical, dimension(1:ldimt1) :: ifdeal
      logical :: ifdg
      logical, dimension(0:ldimt1) :: ifdgfld
      logical, dimension(1:ldimt1) :: ifdiff
      logical :: ifdp0dt
      logical, dimension(1:2*ldim,1:lelv) :: ifeppm
      logical :: ifessr
      logical :: ifexplvis
      logical, dimension(1:ldimt1) :: ifextr
      logical :: ifexvt
      logical :: ifflow
      logical :: iffmtin
      logical :: ifga
      logical :: ifge
      logical :: ifgeom
      logical :: ifgmsh3
      logical :: ifgprnt
      logical :: ifgs
      logical :: ifgsh_fld_same
      logical :: ifgst
      logical :: ifheat
      integer :: ifield
      logical :: ifintq
      logical :: ifkeps
      integer :: ifldmhd
      logical, dimension(0:1) :: iflmsc
      logical, dimension(0:1) :: iflmse
      logical, dimension(0:1) :: iflmsf
      logical :: iflomach
      logical :: ifmelt
      logical :: ifmgrid
      logical :: ifmhd
      logical :: ifmoab
      logical :: ifmodel
      logical :: ifmodp
      logical :: ifmpiio
      logical, dimension(1:8,1:lelt,0:1) :: ifmscr
      logical, dimension(1:12,1:lelt,0:1) :: ifmseg
      logical, dimension(1:2*ldim,1:lelt,0:1) :: ifmsfc
      logical :: ifmvbd
      logical :: ifneknek
      logical :: ifneknekm
      logical, dimension(1:ldimt1) :: ifnonl
      logical, dimension(1:8,1:lelt) :: ifnskp
      logical :: ifoutfld
      logical :: ifpert
      logical :: ifpo
      logical :: ifprnt
      logical, dimension(0:ldimt1) :: ifprojfld
      logical, dimension(1:ldimt1) :: ifpsco
      logical, dimension(1:ldimt1) :: ifpso
      logical, dimension(1:2*ldim,1:lelv) :: ifqinp
      logical :: ifreguo
      logical :: ifrich
      logical, dimension(1:lelv) :: ifrsxy
      logical, dimension(1:lelt) :: ifrzer
      logical :: ifschclob
      logical :: ifskip
      logical :: ifsplit
      logical :: ifssvt
      logical :: ifstrs
      logical, dimension(1:ldimt1) :: ifstst
      logical :: ifsurt
      logical :: ifsync
      logical :: iftgo
      logical, dimension(0:ldimt1) :: iftmsh
      logical :: ifto
      logical :: iftran
      logical :: ifusermv
      logical :: ifuservp
      logical, dimension(1:ldimt1) :: ifvarp
      logical :: ifvcor
      logical :: ifvcoup
      logical :: ifvo
      logical :: ifvps
      logical :: ifwcno
      logical :: ifxyo
      logical :: ifxyo_
      real, dimension(1:lx1*lxq) :: iggl
      real, dimension(1:lx1*lxq) :: igglt
      integer, dimension(1:lelt) :: igroup
      real, dimension(1:lxd,1:lx1) :: im1d
      real, dimension(1:lx1,1:lxd) :: im1dt
      integer, dimension(1:lelt) :: imatie
      real, dimension(1:lx1,1:lxd) :: imd1
      real, dimension(1:lxd,1:lx1) :: imd1t
      integer :: imesh
      integer, dimension(1:8) :: indx
      character(len=132), dimension(1:15) :: initc
      integer :: instep
      integer, dimension(1:27) :: invedg
      integer :: iocomm
      integer :: ioinfodmp
      integer :: iostep
      integer :: ipscal
      integer :: ipsco
      integer :: irstim
      integer :: irstt
      integer :: irstv
      integer :: isize
      integer :: istep
      integer, dimension(1:8) :: ixcn
      real, dimension(1:lx2,1:lx1) :: ixm12
      real, dimension(1:lx3,1:lx1) :: ixm13
      real, dimension(1:lx1,1:lx2) :: ixm21
      real, dimension(1:lx1,1:lx3) :: ixm31
      real, dimension(1:lx1,1:lx2) :: ixtm12
      real, dimension(1:lx1,1:lx3) :: ixtm13
      real, dimension(1:lx2,1:lx1) :: ixtm21
      real, dimension(1:lx3,1:lx1) :: ixtm31
      real, dimension(1:ly2,1:ly1) :: iym12
      real, dimension(1:ly3,1:ly1) :: iym13
      real, dimension(1:ly1,1:ly2) :: iym21
      real, dimension(1:ly1,1:ly3) :: iym31
      real, dimension(1:ly1,1:ly2) :: iytm12
      real, dimension(1:ly1,1:ly3) :: iytm13
      real, dimension(1:ly2,1:ly1) :: iytm21
      real, dimension(1:ly3,1:ly1) :: iytm31
      real, dimension(1:lz2,1:lz1) :: izm12
      real, dimension(1:lz3,1:lz1) :: izm13
      real, dimension(1:lz1,1:lz2) :: izm21
      real, dimension(1:lz1,1:lz3) :: izm31
      real, dimension(1:lz1,1:lz2) :: iztm12
      real, dimension(1:lz1,1:lz3) :: iztm13
      real, dimension(1:lz2,1:lz1) :: iztm21
      real, dimension(1:lz3,1:lz1) :: iztm31
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: jacm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: jacm2
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi
      integer :: jp
      integer :: lastep
      integer, dimension(1:8,1:lelt,0:ldimt1) :: lcnnum
      integer :: ldimr
      integer, dimension(1:12,1:lelt,0:ldimt1) :: lednum
      integer, dimension(1:lelt) :: lglel
      integer, dimension(1:4,1:lhis+maxobj) :: lochis
      integer :: loglevel
      integer :: lsize
      real, dimension(1:3,1:lpert) :: lyap
      integer, dimension(1:numsts) :: matids
      integer, dimension(1:numsts) :: matindx
      integer, dimension(-5:10,1:ldimt1) :: matype
      integer :: maxmlt
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
      integer :: nab
      integer :: nabmsh
      integer :: nadvc
      integer :: naxhm
      integer :: nbbbb
      integer :: nbd
      integer :: nbdinp
      integer :: nbso2
      integer :: nbsol
      integer, dimension(1:maxrts), intent(InOut) :: ncall
      integer :: ncccc
      integer :: ncdtp
      integer :: ncmp
      integer :: nconv
      integer :: nconv_max
      integer :: ncopy
      integer :: ncrsl
      integer :: ncvf
      integer :: ndadd
      integer :: ndddd
      integer :: nddsl
      integer :: ndg_facex
      integer :: ndim
      integer :: ndott
      integer :: ndsmn
      integer :: ndsmx
      integer :: ndsnd
      integer :: ndsum
      integer :: neact
      integer, dimension(1:3) :: nedg
      integer :: neeee
      integer, dimension(0:ldimt1) :: nelfld
      integer, dimension(0:ldimt1) :: nelg
      integer :: nelgt
      integer :: nelgv
      integer :: nelt
      integer :: nelv
      integer :: neslv
      integer :: nfield
      integer, dimension(1:2,0:ldimt1) :: ngcomm
      integer :: ngeom
      integer :: ngop
      integer :: ngop1
      integer :: ngop_sync
      integer :: ngp2
      integer :: ngsmn
      integer :: ngsmx
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer :: ngsum
      integer :: nhis
      integer :: nhmhz
      integer :: nid
      integer :: ninter
      integer :: ninv3
      integer :: ninvc
      integer :: nio
      integer :: nktonv
      integer, dimension(1:maxobj) :: nmember
      integer, dimension(1:6) :: nmlinv
      integer :: nmltd
      integer :: nmxe
      integer :: nmxh
      integer :: nmxmf
      integer :: nmxms
      integer :: nmxnl
      integer :: nmxp
      integer :: nobj
      integer :: node
      integer :: node0
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer, dimension(1:2,1:3) :: nomlis
      integer :: np
      integer :: npert
      integer :: nprep
      integer :: npres
      integer :: npscal
      character(len=132) :: nrefle
      integer, intent(InOut) :: nrout
      integer :: nsett
      integer :: nslvb
      integer :: nsolv
      integer, dimension(0:ldimt1) :: nspmax
      integer :: nspro
      integer :: nsskip
      integer :: nsteps
      integer :: nsyc
      integer :: ntaubd
      real :: nu_star
      integer :: nullpid
      integer :: numbcs
      integer :: numflu
      integer :: numoth
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer :: nusbc
      integer :: nvdss
      integer(kind=8) :: nvtot
      integer :: nwal
      integer :: nx1
      integer :: nx2
      integer :: nx3
      integer :: nxd
      integer :: ny1
      integer :: ny2
      integer :: ny3
      integer :: nyd
      integer :: nz1
      integer :: nz2
      integer :: nz3
      integer :: nzd
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object
      character(len=2), dimension(1:8) :: ocode
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: omask
      integer :: optlevel
      character(len=132) :: orefle
      real :: p0th
      real, dimension(1:200) :: param
      character(len=132) :: parfle
      character(len=132) :: path
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
      real :: pi
      integer :: pid
      real(kind=8) :: pinv3
      real(kind=8) :: pinvc
      real, dimension(1:lbx2,1:lby2,1:lbz2,1:lbelv) :: pm
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pmask
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t
      real, dimension(1:lbx2*lby2*lbz2*lbelv,1:lorder2) :: pmlag
      real(kind=8) :: pmltd
      real(kind=8) :: pmxmf
      real(kind=8) :: pmxms
      real(kind=8) :: pprep
      real(kind=8) :: ppres
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real :: prelax
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv,1:lorder2) :: prlag
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lorder2,1:lpert) :: prlagp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lpert) :: prp
      real(kind=8) :: psett
      real(kind=8) :: pslvb
      real(kind=8) :: psolv
      real(kind=8) :: pspro
      real(kind=8) :: psyc
      real(kind=8) :: pusbc
      real(kind=8) :: pvdss
      real(kind=8) :: pwal
      real, dimension(1:ldimt3,1:maxobj) :: qinteg
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: qtl
      real(kind=8), dimension(1:maxrts) :: rct
      character(len=132) :: re2fle
      integer(kind=8) :: re2off_b
      character(len=132) :: reafle
      real, dimension(0:ldimt1) :: restol
      character(len=6), dimension(1:maxrts), intent(Out) :: rname
      real :: rstim
      character(len=14) :: rstt
      character(len=14) :: rstv
      real, dimension(1:lxd*lyd*lzd,1:ldim*ldim,1:lelv) :: rx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rxm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rym2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rzm2
      character(len=132) :: schfle
      character(len=132) :: session
      integer, dimension(1:6,1:6) :: skpdat
      character(len=3) :: solver_type
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sxm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sym2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: szm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: t
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2z
      real(kind=8) :: ta2s2
      real(kind=8) :: tadc3
      real(kind=8) :: tadd2
      real(kind=8) :: tadvc
      real, dimension(1:ldimt1) :: tauss
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
      character(len=40), dimension(1:100,1:2) :: textsw
      real(kind=8) :: tgop
      real(kind=8) :: tgop1
      real(kind=8) :: tgop_sync
      real(kind=8) :: tgp2
      real(kind=8) :: tgsmn
      real(kind=8) :: tgsmx
      real(kind=8) :: tgsum
      real(kind=8) :: thmhz
      real :: time
      real :: timef
      real :: timeio
      real(kind=8) :: tinit
      real(kind=8) :: tinv3
      real(kind=8) :: tinvc
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1,1:ldimt) :: tlag
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lorder-1,1:lpert) :: tlagp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmask
      real, dimension(1:ldimt) :: tmean
      real(kind=8) :: tmltd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmult
      real(kind=8), intent(Out) :: tmxmf
      real(kind=8) :: tmxms
      real, dimension(1:ldimt) :: tnrmh1
      real, dimension(1:ldimt) :: tnrml2
      real, dimension(1:ldimt) :: tnrml8
      real, dimension(1:ldimt) :: tnrmsm
      real :: tolabs
      real :: tolev
      real :: tolhdf
      real :: tolhe
      real :: tolhr
      real :: tolhs
      real, dimension(1:ldimt1) :: tolht
      real :: tolhv
      real :: tolnl
      real :: tolpdf
      real :: tolps
      real :: tolrel
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: tp
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
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: txm2
      real, dimension(1:ldimt1) :: txnext
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tym2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tzm2
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unr
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: uns
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unt
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      real, dimension(1:20) :: uparam
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: usrdiv
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v1mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1z
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v2mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2z
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: vdiff_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt1
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt1p
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt2
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt2p
      real :: vmean
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult
      real :: vnekton
      real :: vnrmh1
      real :: vnrml2
      real :: vnrml8
      real :: vnrmsm
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vny
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnz
      real, dimension(1:lelv) :: volel
      real, dimension(0:ldimt1) :: volfld
      real :: voltm1
      real :: voltm2
      real :: volvm1
      real :: volvm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vtrans
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx
      real, dimension(1:lx1*ly1*lz1*lelv) :: vx_e
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vxd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vxlag
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vxlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vxp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_e
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vyd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vylag
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vylagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vyp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_e
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vzd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vzlag
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vzlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vzp
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w1mask
      real, dimension(1:lx1,1:ly1) :: w2am1
      real, dimension(1:lx2,1:ly2) :: w2am2
      real, dimension(1:lx3,1:ly3) :: w2am3
      real, dimension(1:lx1,1:ly1) :: w2cm1
      real, dimension(1:lx2,1:ly2) :: w2cm2
      real, dimension(1:lx3,1:ly3) :: w2cm3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w2mask
      real, dimension(1:lx1,1:ly1,1:lz1) :: w3m1
      real, dimension(1:lx2,1:ly2,1:lz2) :: w3m2
      real, dimension(1:lx3,1:ly3,1:lz3) :: w3m3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w3mask
      real, dimension(1:ly1) :: wam1
      real, dimension(1:ly2) :: wam2
      real, dimension(1:ly3) :: wam3
      integer :: wdsize
      integer :: wdsizi
      real, dimension(1:lx1) :: wgl
      real, dimension(1:lx1*lx1) :: wgl1
      real, dimension(1:lxq*lxq) :: wgl2
      real, dimension(1:lx1*lxq) :: wglg
      real, dimension(1:lx1*lxq) :: wglgt
      real, dimension(1:lx1*lx1) :: wgli
      real, dimension(1:lxq) :: wgp
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wmult
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wxlag
      real, dimension(1:lx1) :: wxm1
      real, dimension(1:lx2) :: wxm2
      real, dimension(1:lx3) :: wxm3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wy
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wylag
      real, dimension(1:ly1) :: wym1
      real, dimension(1:ly2) :: wym2
      real, dimension(1:ly3) :: wym3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wzlag
      real, dimension(1:lz1) :: wzm1
      real, dimension(1:lz2) :: wzm2
      real, dimension(1:lz3) :: wzm3
      real, dimension(1:8,1:lelt) :: xc
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: xm2
      integer, dimension(1:ldimt3) :: xxth
      real, dimension(1:8,1:lelt) :: yc
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: yinvm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: ym2
      real, dimension(1:lx1) :: zam1
      real, dimension(1:lx2) :: zam2
      real, dimension(1:lx3) :: zam3
      real, dimension(1:8,1:lelt) :: zc
      real, dimension(1:lx1) :: zgl
      real, dimension(1:lx1,1:3) :: zgm1
      real, dimension(1:lx2,1:3) :: zgm2
      real, dimension(1:lx3,1:3) :: zgm3
      real, dimension(1:lx1) :: zgp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: zm2
      integer, intent(In) :: n
      integer :: m1
      integer :: m2
      integer :: k
      real, dimension(0:n,0:n,0:n), intent(InOut) :: ur
      real, dimension(0:n,0:n,0:n), intent(InOut) :: us
      real, dimension(0:n,0:n,0:n), intent(InOut) :: ut
      real, dimension(0:n,0:n,0:n,1:1), intent(InOut) :: u
      real, dimension(0:n,0:n), intent(InOut) :: d
      real, intent(InOut) :: dt
      integer, intent(In) :: e
! 
      m1 = n+1
      m2 = m1*m1
! 
      ur_mxm = reshape(ur,shape(ur_mxm))
      call mxm(d,m1,u(0,0,0,e),m1,ur_mxm,m2,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam, &
      dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2, &
      dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12, &
      dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas, &
      eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p, &
      exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0, &
      gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3, &
      iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts, &
      icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge, &
      iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast, &
      ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg, &
      ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge, &
      ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc, &
      iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg, &
      ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco, &
      ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst, &
      ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps, &
      ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep, &
      invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13, &
      ixm21,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31, &
      izm12,izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum, &
      ldimr,lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd, &
      nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv, &
      nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped, &
      ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf, &
      nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout, &
      nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu, &
      numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd, &
      object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc, &
      pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd, &
      pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss, &
      pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1, &
      rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y, &
      t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2, &
      tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw, &
      tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag, &
      tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf, &
      tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett, &
      tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1, &
      tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z, &
      v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2, &
      vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag, &
      vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2, &
      w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1, &
      wgl2,wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag, &
      wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp, &
      zm1,zm2)
      ur = reshape(ur_mxm, shape(ur))
      do k=0,n
         call mxm(u(0,0,k,e),m1,dt,m1,us(0,0,k),m1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol, &
      avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc, &
      bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv, &
      bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror, &
      cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat, &
      datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg, &
      dglgt,dlam,dmpfle,dp0thdt,drivc,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1, &
      dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1, &
      dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae, &
      eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p, &
      exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1, &
      gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1, &
      ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31, &
      ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact, &
      iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas, &
      ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal, &
      ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge, &
      ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc, &
      iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg, &
      ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco, &
      ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst, &
      ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps, &
      ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep, &
      invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13, &
      ixm21,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31, &
      izm12,izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum, &
      ldimr,lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd, &
      nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv, &
      nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped, &
      ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf, &
      nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout, &
      nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu, &
      numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd, &
      object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc, &
      pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd, &
      pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss, &
      pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1, &
      rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y, &
      t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2, &
      tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw, &
      tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag, &
      tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf, &
      tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett, &
      tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1, &
      tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z, &
      v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2, &
      vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag, &
      vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2, &
      w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1, &
      wgl2,wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag, &
      wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp, &
      zm1,zm2)
      enddo
      ut_mxm = reshape(ut,shape(ut_mxm))
      call mxm(u(0,0,0,e),m2,dt,m1,ut_mxm,m1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol, &
      avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc, &
      bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv, &
      bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror, &
      cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat, &
      datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg, &
      dglgt,dlam,dmpfle,dp0thdt,drivc,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1, &
      dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1, &
      dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae, &
      eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p, &
      exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1, &
      gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1, &
      ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31, &
      ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact, &
      iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas, &
      ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal, &
      ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge, &
      ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc, &
      iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg, &
      ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco, &
      ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst, &
      ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps, &
      ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep, &
      invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13, &
      ixm21,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31, &
      izm12,izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum, &
      ldimr,lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd, &
      nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv, &
      nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped, &
      ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf, &
      nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout, &
      nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu, &
      numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd, &
      object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc, &
      pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd, &
      pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss, &
      pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1, &
      rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y, &
      t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2, &
      tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw, &
      tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag, &
      tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf, &
      tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett, &
      tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1, &
      tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z, &
      v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2, &
      vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag, &
      vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2, &
      w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1, &
      wgl2,wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag, &
      wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp, &
      zm1,zm2)
      ut = reshape(ut_mxm, shape(ut))
! 
      return
      end subroutine local_grad3
      subroutine local_grad2(ur,us,u,n,e,d,dt,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol, &
      avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc, &
      bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv, &
      bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror, &
      cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat, &
      datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg, &
      dglgt,dlam,dmpfle,dp0thdt,drivc,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1, &
      dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1, &
      dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae, &
      eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p, &
      exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1, &
      gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1, &
      ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31, &
      ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact, &
      iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas, &
      ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal, &
      ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge, &
      ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc, &
      iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg, &
      ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco, &
      ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst, &
      ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps, &
      ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep, &
      invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13, &
      ixm21,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31, &
      izm12,izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum, &
      ldimr,lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd, &
      nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv, &
      nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped, &
      ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf, &
      nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout, &
      nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu, &
      numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd, &
      object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc, &
      pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd, &
      pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss, &
      pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1, &
      rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y, &
      t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2, &
      tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw, &
      tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag, &
      tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf, &
      tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett, &
      tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1, &
      tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z, &
      v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2, &
      vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag, &
      vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2, &
      w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1, &
      wgl2,wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag, &
      wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp, &
      zm1,zm2)
!      Output: ur,us         Input:u,N,e,D,Dt
      implicit none
      integer, parameter :: lorder=3
      integer, parameter :: lorder2=max(1,lorder-2)
      integer, parameter :: lx1=8
      integer, parameter :: lx2=lx1-2
      integer, parameter :: lxq=lx2
      integer, parameter :: maxrts=1000
      integer, parameter :: numsts=50
      real, dimension(1:10) :: ab
      real, dimension(1:10) :: abmsh
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz2
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(0:ldimt1) :: atol
      real, dimension(1:ldimt1) :: avdiff
      real, dimension(1:ldimt1) :: avtran
      real, dimension(1:lx1*lx1) :: b1ia1
      real, dimension(1:lx1*lx1) :: b1ia1t
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b1mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b2mask
      real, dimension(1:lx1*lx1) :: b2p
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: baxm1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz2
      real, dimension(1:5,1:6,1:lelt,0:ldimt1) :: bc
      integer, dimension(1:numsts) :: bcf
      character(len=3), dimension(1:numsts) :: bctyps
      real, dimension(1:10) :: bd
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bdivw
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfx
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfxp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfy
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfyp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfz
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfzp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bintm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: binvdg
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: binvm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1) :: bm1lag
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: bm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: bm2inv
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmass
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmnv
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmy
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmz
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bpmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: bq
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: bqp
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bx
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bxlag
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: by
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bylag
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bz
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bzlag
      real, dimension(1:lxd*lyd*lzd*lelv*ldim,1:lorder+1) :: c_vx
      character(len=3), dimension(1:6,1:lelt,0:ldimt1) :: cbc
      character(len=1), dimension(1:12,1:lelt) :: ccurve
      character(len=1), dimension(1:6,1:lelt) :: cdof
      real, dimension(1:lelt) :: cerror
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: cflf
      real :: courno
      real, dimension(1:ldimt1,1:3) :: cpfld
      real, dimension(-5:10,1:ldimt1,1:3) :: cpgrp
      integer :: cr_h
      integer :: cr_re2
      integer :: csize
      real :: ctarg
      real, dimension(1:6,1:12,1:lelt) :: curve
      real, dimension(1:lx1*lx1) :: d1
      real, dimension(1:lx1*lx1) :: d1t
      real, dimension(1:lx1*lx1) :: d2
      real, dimension(1:lx1*lx1) :: da
      real, dimension(1:ly1,1:ly1) :: dam1
      real, dimension(1:ly2,1:ly1) :: dam12
      real, dimension(1:ly3,1:ly3) :: dam3
      real, dimension(1:lx1*lx1) :: dat
      real, dimension(1:ly1,1:ly1) :: datm1
      real, dimension(1:ly1,1:ly2) :: datm12
      real, dimension(1:ly3,1:ly3) :: datm3
      real, dimension(1:ly1,1:ly1) :: dcm1
      real, dimension(1:ly2,1:ly1) :: dcm12
      real, dimension(1:ly3,1:ly3) :: dcm3
      real(kind=8), intent(InOut) :: dcount
      real(kind=8), dimension(1:maxrts), intent(InOut) :: dct
      real, dimension(1:ly1,1:ly1) :: dctm1
      real, dimension(1:ly1,1:ly2) :: dctm12
      real, dimension(1:ly3,1:ly3) :: dctm3
      integer, dimension(1:lx1*lz1*2*ldim*lelt) :: dg_face
      integer :: dg_hndlx
      real, dimension(1:lx1*lxq) :: dglg
      real, dimension(1:lx1*lxq) :: dglgt
      real :: dlam
      character(len=132) :: dmpfle
      real :: dp0thdt
      character(len=10), dimension(1:5) :: drivc
      real :: dtinit
      real :: dtinvm
      real, dimension(1:10) :: dtlag
      real :: dvdfh1
      real :: dvdfl2
      real :: dvdfl8
      real :: dvdfsm
      real :: dvnnh1
      real :: dvnnl2
      real :: dvnnl8
      real :: dvnnsm
      real :: dvprh1
      real :: dvprl2
      real :: dvprl8
      real :: dvprsm
      real, dimension(1:lx1,1:lx1) :: dxm1
      real, dimension(1:lx2,1:lx1) :: dxm12
      real, dimension(1:lx3,1:lx3) :: dxm3
      real, dimension(1:lx1,1:lx1) :: dxtm1
      real, dimension(1:lx1,1:lx2) :: dxtm12
      real, dimension(1:lx3,1:lx3) :: dxtm3
      real, dimension(1:ly1,1:ly1) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:ly3,1:ly3) :: dym3
      real, dimension(1:ly1,1:ly1) :: dytm1
      real, dimension(1:ly1,1:ly2) :: dytm12
      real, dimension(1:ly3,1:ly3) :: dytm3
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lz3,1:lz3) :: dzm3
      real, dimension(1:lz1,1:lz1) :: dztm1
      real, dimension(1:lz1,1:lz2) :: dztm12
      real, dimension(1:lz3,1:lz3) :: dztm3
      integer, dimension(1:6) :: eface
      integer, dimension(1:6) :: eface1
      real :: eigaa
      real :: eigae
      real :: eigas
      real :: eigast
      real :: eigga
      real :: eigge
      real :: eiggs
      real :: eiggst
      integer, dimension(-12:12,1:3) :: eskip
      real, dimension(1:lx1*lz1,1:2*ldim,1:lelt) :: etalph
      real(kind=8) :: etimes
      real(kind=8) :: etims0
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev1
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev2
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev3
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz2p
      integer :: fh_re2
      real :: filtertype
      real :: fintim
      character(len=132) :: fldfle
      real, dimension(1:2*ldim,1:lelt) :: fw
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g1m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g2m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g3m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g4m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g5m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g6m1
      real :: gamma0
      integer, dimension(1:8,1:lelt,0:ldimt1) :: gcnnum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gedtyp
      integer, dimension(1:lelg) :: gllel
      integer, dimension(1:lelg) :: gllnid
      integer, dimension(1:6) :: group
      integer :: gsh
      integer, dimension(0:ldimt3) :: gsh_fld
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode
      character(len=132) :: hisfle
      real, dimension(1:ly1,1:ly1) :: iajl1
      real, dimension(1:ly2,1:ly2) :: iajl2
      real, dimension(1:ly1,1:ly1) :: ialj1
      real, dimension(1:ly3,1:ly3) :: ialj3
      real, dimension(1:ly2,1:ly1) :: iam12
      real, dimension(1:ly3,1:ly1) :: iam13
      real, dimension(1:ly1,1:ly2) :: iam21
      real, dimension(1:ly1,1:ly3) :: iam31
      real, dimension(1:ly1,1:ly1) :: iatjl1
      real, dimension(1:ly2,1:ly2) :: iatjl2
      real, dimension(1:ly1,1:ly1) :: iatlj1
      real, dimension(1:ly3,1:ly3) :: iatlj3
      real, dimension(1:ly1,1:ly2) :: iatm12
      real, dimension(1:ly1,1:ly3) :: iatm13
      real, dimension(1:ly2,1:ly1) :: iatm21
      real, dimension(1:ly3,1:ly1) :: iatm31
      integer, dimension(1:numsts) :: ibcsts
      integer, dimension(1:3,1:16) :: icedg
      integer, dimension(1:4,1:10) :: icface
      real, dimension(1:ly2,1:ly1) :: icm12
      real, dimension(1:ly3,1:ly1) :: icm13
      real, dimension(1:ly1,1:ly2) :: icm21
      real, dimension(1:ly1,1:ly3) :: icm31
      real, dimension(1:ly1,1:ly2) :: ictm12
      real, dimension(1:ly1,1:ly3) :: ictm13
      real, dimension(1:ly2,1:ly1) :: ictm21
      real, dimension(1:ly3,1:ly1) :: ictm31
      integer, dimension(1:ldimt) :: idpss
      integer :: idsess
      integer, dimension(1:lelt) :: ieact
      integer, dimension(1:20) :: iedge
      integer, dimension(1:2,1:4,1:6,0:1) :: iedgef
      integer, dimension(1:4,1:6) :: iedgfc
      integer :: iesolv
      logical :: if3d
      logical :: if_full_pres
      logical :: ifaa
      logical, dimension(1:ldimt1) :: ifadvc
      logical :: ifae
      logical, dimension(1:lelv) :: ifalgn
      logical :: ifanl2
      logical :: ifanls
      logical :: ifas
      logical :: ifast
      logical :: ifaxis
      logical :: ifaziv
      logical :: ifbase
      logical :: ifbcor
      logical :: ifbo
      logical :: ifchar
      logical :: ifcons
      logical :: ifcoup
      logical, dimension(1:ldimt1) :: ifcvfld
      logical :: ifcvode
      logical :: ifcyclic
      logical, dimension(1:ldimt1) :: ifdeal
      logical :: ifdg
      logical, dimension(0:ldimt1) :: ifdgfld
      logical, dimension(1:ldimt1) :: ifdiff
      logical :: ifdp0dt
      logical, dimension(1:2*ldim,1:lelv) :: ifeppm
      logical :: ifessr
      logical :: ifexplvis
      logical, dimension(1:ldimt1) :: ifextr
      logical :: ifexvt
      logical :: ifflow
      logical :: iffmtin
      logical :: ifga
      logical :: ifge
      logical :: ifgeom
      logical :: ifgmsh3
      logical :: ifgprnt
      logical :: ifgs
      logical :: ifgsh_fld_same
      logical :: ifgst
      logical :: ifheat
      integer :: ifield
      logical :: ifintq
      logical :: ifkeps
      integer :: ifldmhd
      logical, dimension(0:1) :: iflmsc
      logical, dimension(0:1) :: iflmse
      logical, dimension(0:1) :: iflmsf
      logical :: iflomach
      logical :: ifmelt
      logical :: ifmgrid
      logical :: ifmhd
      logical :: ifmoab
      logical :: ifmodel
      logical :: ifmodp
      logical :: ifmpiio
      logical, dimension(1:8,1:lelt,0:1) :: ifmscr
      logical, dimension(1:12,1:lelt,0:1) :: ifmseg
      logical, dimension(1:2*ldim,1:lelt,0:1) :: ifmsfc
      logical :: ifmvbd
      logical :: ifneknek
      logical :: ifneknekm
      logical, dimension(1:ldimt1) :: ifnonl
      logical, dimension(1:8,1:lelt) :: ifnskp
      logical :: ifoutfld
      logical :: ifpert
      logical :: ifpo
      logical :: ifprnt
      logical, dimension(0:ldimt1) :: ifprojfld
      logical, dimension(1:ldimt1) :: ifpsco
      logical, dimension(1:ldimt1) :: ifpso
      logical, dimension(1:2*ldim,1:lelv) :: ifqinp
      logical :: ifreguo
      logical :: ifrich
      logical, dimension(1:lelv) :: ifrsxy
      logical, dimension(1:lelt) :: ifrzer
      logical :: ifschclob
      logical :: ifskip
      logical :: ifsplit
      logical :: ifssvt
      logical :: ifstrs
      logical, dimension(1:ldimt1) :: ifstst
      logical :: ifsurt
      logical :: ifsync
      logical :: iftgo
      logical, dimension(0:ldimt1) :: iftmsh
      logical :: ifto
      logical :: iftran
      logical :: ifusermv
      logical :: ifuservp
      logical, dimension(1:ldimt1) :: ifvarp
      logical :: ifvcor
      logical :: ifvcoup
      logical :: ifvo
      logical :: ifvps
      logical :: ifwcno
      logical :: ifxyo
      logical :: ifxyo_
      real, dimension(1:lx1*lxq) :: iggl
      real, dimension(1:lx1*lxq) :: igglt
      integer, dimension(1:lelt) :: igroup
      real, dimension(1:lxd,1:lx1) :: im1d
      real, dimension(1:lx1,1:lxd) :: im1dt
      integer, dimension(1:lelt) :: imatie
      real, dimension(1:lx1,1:lxd) :: imd1
      real, dimension(1:lxd,1:lx1) :: imd1t
      integer :: imesh
      integer, dimension(1:8) :: indx
      character(len=132), dimension(1:15) :: initc
      integer :: instep
      integer, dimension(1:27) :: invedg
      integer :: iocomm
      integer :: ioinfodmp
      integer :: iostep
      integer :: ipscal
      integer :: ipsco
      integer :: irstim
      integer :: irstt
      integer :: irstv
      integer :: isize
      integer :: istep
      integer, dimension(1:8) :: ixcn
      real, dimension(1:lx2,1:lx1) :: ixm12
      real, dimension(1:lx3,1:lx1) :: ixm13
      real, dimension(1:lx1,1:lx2) :: ixm21
      real, dimension(1:lx1,1:lx3) :: ixm31
      real, dimension(1:lx1,1:lx2) :: ixtm12
      real, dimension(1:lx1,1:lx3) :: ixtm13
      real, dimension(1:lx2,1:lx1) :: ixtm21
      real, dimension(1:lx3,1:lx1) :: ixtm31
      real, dimension(1:ly2,1:ly1) :: iym12
      real, dimension(1:ly3,1:ly1) :: iym13
      real, dimension(1:ly1,1:ly2) :: iym21
      real, dimension(1:ly1,1:ly3) :: iym31
      real, dimension(1:ly1,1:ly2) :: iytm12
      real, dimension(1:ly1,1:ly3) :: iytm13
      real, dimension(1:ly2,1:ly1) :: iytm21
      real, dimension(1:ly3,1:ly1) :: iytm31
      real, dimension(1:lz2,1:lz1) :: izm12
      real, dimension(1:lz3,1:lz1) :: izm13
      real, dimension(1:lz1,1:lz2) :: izm21
      real, dimension(1:lz1,1:lz3) :: izm31
      real, dimension(1:lz1,1:lz2) :: iztm12
      real, dimension(1:lz1,1:lz3) :: iztm13
      real, dimension(1:lz2,1:lz1) :: iztm21
      real, dimension(1:lz3,1:lz1) :: iztm31
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: jacm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: jacm2
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi
      integer :: jp
      integer :: lastep
      integer, dimension(1:8,1:lelt,0:ldimt1) :: lcnnum
      integer :: ldimr
      integer, dimension(1:12,1:lelt,0:ldimt1) :: lednum
      integer, dimension(1:lelt) :: lglel
      integer, dimension(1:4,1:lhis+maxobj) :: lochis
      integer :: loglevel
      integer :: lsize
      real, dimension(1:3,1:lpert) :: lyap
      integer, dimension(1:numsts) :: matids
      integer, dimension(1:numsts) :: matindx
      integer, dimension(-5:10,1:ldimt1) :: matype
      integer :: maxmlt
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
      integer :: nab
      integer :: nabmsh
      integer :: nadvc
      integer :: naxhm
      integer :: nbbbb
      integer :: nbd
      integer :: nbdinp
      integer :: nbso2
      integer :: nbsol
      integer, dimension(1:maxrts), intent(InOut) :: ncall
      integer :: ncccc
      integer :: ncdtp
      integer :: ncmp
      integer :: nconv
      integer :: nconv_max
      integer :: ncopy
      integer :: ncrsl
      integer :: ncvf
      integer :: ndadd
      integer :: ndddd
      integer :: nddsl
      integer :: ndg_facex
      integer :: ndim
      integer :: ndott
      integer :: ndsmn
      integer :: ndsmx
      integer :: ndsnd
      integer :: ndsum
      integer :: neact
      integer, dimension(1:3) :: nedg
      integer :: neeee
      integer, dimension(0:ldimt1) :: nelfld
      integer, dimension(0:ldimt1) :: nelg
      integer :: nelgt
      integer :: nelgv
      integer :: nelt
      integer :: nelv
      integer :: neslv
      integer :: nfield
      integer, dimension(1:2,0:ldimt1) :: ngcomm
      integer :: ngeom
      integer :: ngop
      integer :: ngop1
      integer :: ngop_sync
      integer :: ngp2
      integer :: ngsmn
      integer :: ngsmx
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer :: ngsum
      integer :: nhis
      integer :: nhmhz
      integer :: nid
      integer :: ninter
      integer :: ninv3
      integer :: ninvc
      integer :: nio
      integer :: nktonv
      integer, dimension(1:maxobj) :: nmember
      integer, dimension(1:6) :: nmlinv
      integer :: nmltd
      integer :: nmxe
      integer :: nmxh
      integer :: nmxmf
      integer :: nmxms
      integer :: nmxnl
      integer :: nmxp
      integer :: nobj
      integer :: node
      integer :: node0
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer, dimension(1:2,1:3) :: nomlis
      integer :: np
      integer :: npert
      integer :: nprep
      integer :: npres
      integer :: npscal
      character(len=132) :: nrefle
      integer, intent(InOut) :: nrout
      integer :: nsett
      integer :: nslvb
      integer :: nsolv
      integer, dimension(0:ldimt1) :: nspmax
      integer :: nspro
      integer :: nsskip
      integer :: nsteps
      integer :: nsyc
      integer :: ntaubd
      real :: nu_star
      integer :: nullpid
      integer :: numbcs
      integer :: numflu
      integer :: numoth
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer :: nusbc
      integer :: nvdss
      integer(kind=8) :: nvtot
      integer :: nwal
      integer :: nx1
      integer :: nx2
      integer :: nx3
      integer :: nxd
      integer :: ny1
      integer :: ny2
      integer :: ny3
      integer :: nyd
      integer :: nz1
      integer :: nz2
      integer :: nz3
      integer :: nzd
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object
      character(len=2), dimension(1:8) :: ocode
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: omask
      integer :: optlevel
      character(len=132) :: orefle
      real :: p0th
      real, dimension(1:200) :: param
      character(len=132) :: parfle
      character(len=132) :: path
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
      real :: pi
      integer :: pid
      real(kind=8) :: pinv3
      real(kind=8) :: pinvc
      real, dimension(1:lbx2,1:lby2,1:lbz2,1:lbelv) :: pm
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pmask
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t
      real, dimension(1:lbx2*lby2*lbz2*lbelv,1:lorder2) :: pmlag
      real(kind=8) :: pmltd
      real(kind=8) :: pmxmf
      real(kind=8) :: pmxms
      real(kind=8) :: pprep
      real(kind=8) :: ppres
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real :: prelax
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv,1:lorder2) :: prlag
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lorder2,1:lpert) :: prlagp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lpert) :: prp
      real(kind=8) :: psett
      real(kind=8) :: pslvb
      real(kind=8) :: psolv
      real(kind=8) :: pspro
      real(kind=8) :: psyc
      real(kind=8) :: pusbc
      real(kind=8) :: pvdss
      real(kind=8) :: pwal
      real, dimension(1:ldimt3,1:maxobj) :: qinteg
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: qtl
      real(kind=8), dimension(1:maxrts) :: rct
      character(len=132) :: re2fle
      integer(kind=8) :: re2off_b
      character(len=132) :: reafle
      real, dimension(0:ldimt1) :: restol
      character(len=6), dimension(1:maxrts), intent(Out) :: rname
      real :: rstim
      character(len=14) :: rstt
      character(len=14) :: rstv
      real, dimension(1:lxd*lyd*lzd,1:ldim*ldim,1:lelv) :: rx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rxm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rym2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rzm2
      character(len=132) :: schfle
      character(len=132) :: session
      integer, dimension(1:6,1:6) :: skpdat
      character(len=3) :: solver_type
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sxm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sym2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: szm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: t
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2z
      real(kind=8) :: ta2s2
      real(kind=8) :: tadc3
      real(kind=8) :: tadd2
      real(kind=8) :: tadvc
      real, dimension(1:ldimt1) :: tauss
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
      character(len=40), dimension(1:100,1:2) :: textsw
      real(kind=8) :: tgop
      real(kind=8) :: tgop1
      real(kind=8) :: tgop_sync
      real(kind=8) :: tgp2
      real(kind=8) :: tgsmn
      real(kind=8) :: tgsmx
      real(kind=8) :: tgsum
      real(kind=8) :: thmhz
      real :: time
      real :: timef
      real :: timeio
      real(kind=8) :: tinit
      real(kind=8) :: tinv3
      real(kind=8) :: tinvc
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1,1:ldimt) :: tlag
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lorder-1,1:lpert) :: tlagp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmask
      real, dimension(1:ldimt) :: tmean
      real(kind=8) :: tmltd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmult
      real(kind=8), intent(Out) :: tmxmf
      real(kind=8) :: tmxms
      real, dimension(1:ldimt) :: tnrmh1
      real, dimension(1:ldimt) :: tnrml2
      real, dimension(1:ldimt) :: tnrml8
      real, dimension(1:ldimt) :: tnrmsm
      real :: tolabs
      real :: tolev
      real :: tolhdf
      real :: tolhe
      real :: tolhr
      real :: tolhs
      real, dimension(1:ldimt1) :: tolht
      real :: tolhv
      real :: tolnl
      real :: tolpdf
      real :: tolps
      real :: tolrel
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: tp
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
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: txm2
      real, dimension(1:ldimt1) :: txnext
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tym2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tzm2
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unr
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: uns
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unt
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      real, dimension(1:20) :: uparam
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: usrdiv
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v1mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1z
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v2mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2z
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: vdiff_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt1
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt1p
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt2
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt2p
      real :: vmean
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult
      real :: vnekton
      real :: vnrmh1
      real :: vnrml2
      real :: vnrml8
      real :: vnrmsm
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vny
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnz
      real, dimension(1:lelv) :: volel
      real, dimension(0:ldimt1) :: volfld
      real :: voltm1
      real :: voltm2
      real :: volvm1
      real :: volvm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vtrans
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx
      real, dimension(1:lx1*ly1*lz1*lelv) :: vx_e
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vxd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vxlag
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vxlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vxp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_e
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vyd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vylag
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vylagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vyp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_e
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vzd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vzlag
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vzlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vzp
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w1mask
      real, dimension(1:lx1,1:ly1) :: w2am1
      real, dimension(1:lx2,1:ly2) :: w2am2
      real, dimension(1:lx3,1:ly3) :: w2am3
      real, dimension(1:lx1,1:ly1) :: w2cm1
      real, dimension(1:lx2,1:ly2) :: w2cm2
      real, dimension(1:lx3,1:ly3) :: w2cm3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w2mask
      real, dimension(1:lx1,1:ly1,1:lz1) :: w3m1
      real, dimension(1:lx2,1:ly2,1:lz2) :: w3m2
      real, dimension(1:lx3,1:ly3,1:lz3) :: w3m3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w3mask
      real, dimension(1:ly1) :: wam1
      real, dimension(1:ly2) :: wam2
      real, dimension(1:ly3) :: wam3
      integer :: wdsize
      integer :: wdsizi
      real, dimension(1:lx1) :: wgl
      real, dimension(1:lx1*lx1) :: wgl1
      real, dimension(1:lxq*lxq) :: wgl2
      real, dimension(1:lx1*lxq) :: wglg
      real, dimension(1:lx1*lxq) :: wglgt
      real, dimension(1:lx1*lx1) :: wgli
      real, dimension(1:lxq) :: wgp
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wmult
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wxlag
      real, dimension(1:lx1) :: wxm1
      real, dimension(1:lx2) :: wxm2
      real, dimension(1:lx3) :: wxm3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wy
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wylag
      real, dimension(1:ly1) :: wym1
      real, dimension(1:ly2) :: wym2
      real, dimension(1:ly3) :: wym3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wzlag
      real, dimension(1:lz1) :: wzm1
      real, dimension(1:lz2) :: wzm2
      real, dimension(1:lz3) :: wzm3
      real, dimension(1:8,1:lelt) :: xc
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: xm2
      integer, dimension(1:ldimt3) :: xxth
      real, dimension(1:8,1:lelt) :: yc
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: yinvm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: ym2
      real, dimension(1:lx1) :: zam1
      real, dimension(1:lx2) :: zam2
      real, dimension(1:lx3) :: zam3
      real, dimension(1:8,1:lelt) :: zc
      real, dimension(1:lx1) :: zgl
      real, dimension(1:lx1,1:3) :: zgm1
      real, dimension(1:lx2,1:3) :: zgm2
      real, dimension(1:lx3,1:3) :: zgm3
      real, dimension(1:lx1) :: zgp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: zm2
      integer, intent(In) :: n
      integer :: m1
      real, dimension(0:n,0:n), intent(InOut) :: ur
      real, dimension(0:n,0:n), intent(InOut) :: us
      real, dimension(0:n,0:n,1:1), intent(InOut) :: u
      real, dimension(0:n,0:n), intent(InOut) :: d
      real, intent(InOut) :: dt
      integer, intent(In) :: e
! 
      m1 = n+1
! 
      call mxm(d,m1,u(0,0,e),m1,ur,m1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam, &
      dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2, &
      dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12, &
      dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas, &
      eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p, &
      exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0, &
      gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3, &
      iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts, &
      icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge, &
      iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast, &
      ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg, &
      ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge, &
      ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc, &
      iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg, &
      ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco, &
      ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst, &
      ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps, &
      ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep, &
      invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13, &
      ixm21,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31, &
      izm12,izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum, &
      ldimr,lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd, &
      nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv, &
      nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped, &
      ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf, &
      nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout, &
      nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu, &
      numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd, &
      object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc, &
      pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd, &
      pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss, &
      pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1, &
      rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y, &
      t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2, &
      tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw, &
      tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag, &
      tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf, &
      tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett, &
      tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1, &
      tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z, &
      v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2, &
      vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag, &
      vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2, &
      w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1, &
      wgl2,wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag, &
      wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp, &
      zm1,zm2)
      call mxm(u(0,0,e),m1,dt,m1,us,m1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam, &
      dmpfle,dp0thdt,drivc,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icedg,icface, &
      icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc, &
      iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv, &
      ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff, &
      ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3, &
      ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf, &
      iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd, &
      ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp, &
      ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync, &
      iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo, &
      ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall, &
      ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott, &
      ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield, &
      ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid, &
      ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj, &
      node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax, &
      nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc, &
      nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask, &
      optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl, &
      pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn, &
      pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep, &
      ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl, &
      rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2, &
      schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z, &
      ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl, &
      tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
! 
      return
      end subroutine local_grad2
      subroutine gradm1(ux,uy,uz,u,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
      b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd, &
      bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx, &
      bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno, &
      cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12, &
      datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icedg,icface, &
      icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc, &
      iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv, &
      ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff, &
      ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3, &
      ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf, &
      iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd, &
      ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp, &
      ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync, &
      iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo, &
      ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall, &
      ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott, &
      ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield, &
      ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid, &
      ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj, &
      node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax, &
      nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc, &
      nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask, &
      optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl, &
      pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn, &
      pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep, &
      ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl, &
      rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2, &
      schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z, &
      ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl, &
      tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,ur,us,usrdiv,ut,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask, &
      vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8, &
      vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp, &
      vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3, &
      w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2, &
      wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1, &
      wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1, &
      zm2)
! 
!      Compute gradient of T -- mesh 1 to mesh 1 (vel. to vel.)
! 
      implicit none
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
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz2
      real, dimension(1:lx1*lx1) :: b1ia1
      real, dimension(1:lx1*lx1) :: b1ia1t
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b1mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b2mask
      real, dimension(1:lx1*lx1) :: b2p
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: baxm1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz2
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bdivw
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfx
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfxp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfy
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfyp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfz
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfzp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bintm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: binvdg
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: binvm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1) :: bm1lag
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: bm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: bm2inv
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmass
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmnv
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmy
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmz
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bpmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: bq
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: bqp
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bx
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bxlag
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: by
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bylag
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bz
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bzlag
      real, dimension(1:lxd*lyd*lzd*lelv*ldim,1:lorder+1) :: c_vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: cflf
      integer :: cr_h
      integer :: csize
      real, dimension(1:lx1*lx1) :: d1
      real, dimension(1:lx1*lx1) :: d1t
      real, dimension(1:lx1*lx1) :: d2
      real, dimension(1:lx1*lx1) :: da
      real, dimension(1:lx1*lx1) :: dat
      real(kind=8), intent(InOut) :: dcount
      real, dimension(0:n,0:n,1:1) :: u_local_grad2
      real, dimension(0:n,0:n,0:n,1:1) :: u_local_grad3
      real, dimension(0:n,0:n) :: ur_local_grad2
      real, dimension(0:n,0:n,0:n) :: ur_local_grad3
      real, dimension(0:n,0:n) :: us_local_grad2
      real, dimension(0:n,0:n,0:n) :: us_local_grad3
      real, dimension(0:n,0:n,0:n) :: ut_local_grad3
            integer, parameter :: maxrts=1000
      real(kind=8), dimension(1:maxrts), intent(InOut) :: dct
      integer, dimension(1:lx1*lz1*2*ldim*lelt) :: dg_face
      integer :: dg_hndlx
            integer, parameter :: lxq=lx2
      real, dimension(1:lx1*lxq) :: dglg
      real, dimension(1:lx1*lxq) :: dglgt
      real :: dp0thdt
      real :: dvdfh1
      real :: dvdfl2
      real :: dvdfl8
      real :: dvdfsm
      real :: dvnnh1
      real :: dvnnl2
      real :: dvnnl8
      real :: dvnnsm
      real :: dvprh1
      real :: dvprl2
      real :: dvprl8
      real :: dvprsm
      integer, dimension(1:6) :: eface
      integer, dimension(1:6) :: eface1
      real :: eigaa
      real :: eigae
      real :: eigas
      real :: eigast
      real :: eigga
      real :: eigge
      real :: eiggs
      real :: eiggst
      integer, dimension(-12:12,1:3) :: eskip
      real(kind=8) :: etimes
      real(kind=8) :: etims0
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev1
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev2
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev3
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz2p
      real, dimension(1:2*ldim,1:lelt) :: fw
      real :: gamma0
      integer, dimension(1:8,1:lelt,0:ldimt1) :: gcnnum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gedtyp
      integer, dimension(1:lelg) :: gllel
      integer, dimension(1:lelg) :: gllnid
      integer, dimension(1:6) :: group
      integer :: gsh
      integer, dimension(0:ldimt3) :: gsh_fld
      real, dimension(1:ly1,1:ly1) :: iajl1
      real, dimension(1:ly2,1:ly2) :: iajl2
      real, dimension(1:ly1,1:ly1) :: ialj1
      real, dimension(1:ly3,1:ly3) :: ialj3
      real, dimension(1:ly2,1:ly1) :: iam12
      real, dimension(1:ly3,1:ly1) :: iam13
      real, dimension(1:ly1,1:ly2) :: iam21
      real, dimension(1:ly1,1:ly3) :: iam31
      real, dimension(1:ly1,1:ly1) :: iatjl1
      real, dimension(1:ly2,1:ly2) :: iatjl2
      real, dimension(1:ly1,1:ly1) :: iatlj1
      real, dimension(1:ly3,1:ly3) :: iatlj3
      real, dimension(1:ly1,1:ly2) :: iatm12
      real, dimension(1:ly1,1:ly3) :: iatm13
      real, dimension(1:ly2,1:ly1) :: iatm21
      real, dimension(1:ly3,1:ly1) :: iatm31
      integer, dimension(1:3,1:16) :: icedg
      integer, dimension(1:4,1:10) :: icface
      real, dimension(1:ly2,1:ly1) :: icm12
      real, dimension(1:ly3,1:ly1) :: icm13
      real, dimension(1:ly1,1:ly2) :: icm21
      real, dimension(1:ly1,1:ly3) :: icm31
      real, dimension(1:ly1,1:ly2) :: ictm12
      real, dimension(1:ly1,1:ly3) :: ictm13
      real, dimension(1:ly2,1:ly1) :: ictm21
      real, dimension(1:ly3,1:ly1) :: ictm31
      integer, dimension(1:20) :: iedge
      integer, dimension(1:2,1:4,1:6,0:1) :: iedgef
      integer, dimension(1:4,1:6) :: iedgfc
      integer :: iesolv
      logical :: ifaa
      logical :: ifae
      logical, dimension(1:lelv) :: ifalgn
      logical :: ifas
      logical :: ifast
      logical, dimension(1:ldimt1) :: ifextr
      logical :: ifexvt
      logical :: ifga
      logical :: ifge
      logical :: ifgprnt
      logical :: ifgs
      logical :: ifgsh_fld_same
      logical :: ifgst
      logical :: ifmodp
      logical, dimension(1:lelv) :: ifrsxy
      logical :: ifskip
      logical :: ifssvt
      logical, dimension(1:ldimt1) :: ifstst
      logical :: ifsync
      real, dimension(1:lx1*lxq) :: iggl
      real, dimension(1:lx1*lxq) :: igglt
      real, dimension(1:lxd,1:lx1) :: im1d
      real, dimension(1:lx1,1:lxd) :: im1dt
      real, dimension(1:lx1,1:lxd) :: imd1
      real, dimension(1:lxd,1:lx1) :: imd1t
      integer, dimension(1:8) :: indx
      integer, dimension(1:27) :: invedg
      integer :: isize
      integer, dimension(1:8) :: ixcn
      real, dimension(1:lx2,1:lx1) :: ixm12
      real, dimension(1:lx3,1:lx1) :: ixm13
      real, dimension(1:lx1,1:lx2) :: ixm21
      real, dimension(1:lx1,1:lx3) :: ixm31
      real, dimension(1:lx1,1:lx2) :: ixtm12
      real, dimension(1:lx1,1:lx3) :: ixtm13
      real, dimension(1:lx2,1:lx1) :: ixtm21
      real, dimension(1:lx3,1:lx1) :: ixtm31
      real, dimension(1:ly2,1:ly1) :: iym12
      real, dimension(1:ly3,1:ly1) :: iym13
      real, dimension(1:ly1,1:ly2) :: iym21
      real, dimension(1:ly1,1:ly3) :: iym31
      real, dimension(1:ly1,1:ly2) :: iytm12
      real, dimension(1:ly1,1:ly3) :: iytm13
      real, dimension(1:ly2,1:ly1) :: iytm21
      real, dimension(1:ly3,1:ly1) :: iytm31
      real, dimension(1:lz2,1:lz1) :: izm12
      real, dimension(1:lz3,1:lz1) :: izm13
      real, dimension(1:lz1,1:lz2) :: izm21
      real, dimension(1:lz1,1:lz3) :: izm31
      real, dimension(1:lz1,1:lz2) :: iztm12
      real, dimension(1:lz1,1:lz3) :: iztm13
      real, dimension(1:lz2,1:lz1) :: iztm21
      real, dimension(1:lz3,1:lz1) :: iztm31
      integer :: jp
      integer, dimension(1:8,1:lelt,0:ldimt1) :: lcnnum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: lednum
      integer, dimension(1:lelt) :: lglel
      integer :: lsize
      integer :: maxmlt
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
      integer, dimension(1:maxrts), intent(InOut) :: ncall
      integer :: ncccc
      integer :: ncdtp
      integer :: ncmp
      integer :: ncopy
      integer :: ncrsl
      integer :: ncvf
      integer :: ndadd
      integer :: ndddd
      integer :: nddsl
      integer :: ndg_facex
      integer :: ndott
      integer :: ndsmn
      integer :: ndsmx
      integer :: ndsnd
      integer :: ndsum
      integer, dimension(1:3) :: nedg
      integer :: neeee
      integer, dimension(0:ldimt1) :: nelg
      integer :: nelgt
      integer :: nelgv
      integer :: neslv
      integer, dimension(1:2,0:ldimt1) :: ngcomm
      integer :: ngop
      integer :: ngop1
      integer :: ngop_sync
      integer :: ngp2
      integer :: ngsmn
      integer :: ngsmx
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer :: ngsum
      integer :: nhmhz
      integer :: ninv3
      integer :: ninvc
      integer, dimension(1:6) :: nmlinv
      integer :: nmltd
      integer :: nmxmf
      integer :: nmxms
      integer :: node
      integer :: node0
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer, dimension(1:2,1:3) :: nomlis
      integer :: np
      integer :: nprep
      integer :: npres
      integer, intent(InOut) :: nrout
      integer :: nsett
      integer :: nslvb
      integer :: nsolv
      integer, dimension(0:ldimt1) :: nspmax
      integer :: nspro
      integer :: nsskip
      integer :: nsyc
      real :: nu_star
      integer :: nullpid
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer :: nusbc
      integer :: nvdss
      integer(kind=8) :: nvtot
      integer :: nwal
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: omask
      real :: p0th
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
      integer :: pid
      real(kind=8) :: pinv3
      real(kind=8) :: pinvc
      real, dimension(1:lbx2,1:lby2,1:lbz2,1:lbelv) :: pm
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pmask
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t
            integer, parameter :: lorder2=max(1,lorder-2)
      real, dimension(1:lbx2*lby2*lbz2*lbelv,1:lorder2) :: pmlag
      real(kind=8) :: pmltd
      real(kind=8) :: pmxmf
      real(kind=8) :: pmxms
      real(kind=8) :: pprep
      real(kind=8) :: ppres
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv,1:lorder2) :: prlag
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lorder2,1:lpert) :: prlagp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lpert) :: prp
      real(kind=8) :: psett
      real(kind=8) :: pslvb
      real(kind=8) :: psolv
      real(kind=8) :: pspro
      real(kind=8) :: psyc
      real(kind=8) :: pusbc
      real(kind=8) :: pvdss
      real(kind=8) :: pwal
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: qtl
      real(kind=8), dimension(1:maxrts) :: rct
      character(len=6), dimension(1:maxrts), intent(Out) :: rname
      integer, dimension(1:6,1:6) :: skpdat
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: t
      real(kind=8) :: ta2s2
      real(kind=8) :: tadc3
      real(kind=8) :: tadd2
      real(kind=8) :: tadvc
      real, dimension(1:ldimt1) :: tauss
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
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1,1:ldimt) :: tlag
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lorder-1,1:lpert) :: tlagp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmask
      real(kind=8) :: tmltd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmult
      real(kind=8), intent(Out) :: tmxmf
      real(kind=8) :: tmxms
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: tp
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
      real, dimension(1:ldimt1) :: txnext
      real, dimension(1:lxyz), intent(InOut) :: ur
      real, dimension(1:lxyz), intent(InOut) :: us
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: usrdiv
      real, dimension(1:lxyz), intent(InOut) :: ut
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v1mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v2mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: vdiff_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt1
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt1p
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt2
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt2p
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult
      real, dimension(1:lelv) :: volel
      real :: voltm1
      real :: voltm2
      real :: volvm1
      real :: volvm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vtrans
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx
      real, dimension(1:lx1*ly1*lz1*lelv) :: vx_e
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vxd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vxlag
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vxlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vxp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_e
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vyd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vylag
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vylagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vyp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_e
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vzd
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vzlag
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vzlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vzp
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w1mask
      real, dimension(1:lx1,1:ly1) :: w2am1
      real, dimension(1:lx2,1:ly2) :: w2am2
      real, dimension(1:lx3,1:ly3) :: w2am3
      real, dimension(1:lx1,1:ly1) :: w2cm1
      real, dimension(1:lx2,1:ly2) :: w2cm2
      real, dimension(1:lx3,1:ly3) :: w2cm3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w2mask
      real, dimension(1:lx1,1:ly1,1:lz1) :: w3m1
      real, dimension(1:lx2,1:ly2,1:lz2) :: w3m2
      real, dimension(1:lx3,1:ly3,1:lz3) :: w3m3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w3mask
      real, dimension(1:ly1) :: wam1
      real, dimension(1:ly2) :: wam2
      real, dimension(1:ly3) :: wam3
      integer :: wdsize
      integer :: wdsizi
      real, dimension(1:lx1) :: wgl
      real, dimension(1:lx1*lx1) :: wgl1
      real, dimension(1:lxq*lxq) :: wgl2
      real, dimension(1:lx1*lxq) :: wglg
      real, dimension(1:lx1*lxq) :: wglgt
      real, dimension(1:lx1*lx1) :: wgli
      real, dimension(1:lxq) :: wgp
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wmult
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wxlag
      real, dimension(1:lx1) :: wxm1
      real, dimension(1:lx2) :: wxm2
      real, dimension(1:lx3) :: wxm3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wy
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wylag
      real, dimension(1:ly1) :: wym1
      real, dimension(1:ly2) :: wym2
      real, dimension(1:ly3) :: wym3
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wzlag
      real, dimension(1:lz1) :: wzm1
      real, dimension(1:lz2) :: wzm2
      real, dimension(1:lz3) :: wzm3
      integer, dimension(1:ldimt3) :: xxth
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: yinvm1
      real, dimension(1:lx1) :: zam1
      real, dimension(1:lx2) :: zam2
      real, dimension(1:lx3) :: zam3
      real, dimension(1:lx1) :: zgl
      real, dimension(1:lx1,1:3) :: zgm1
      real, dimension(1:lx2,1:3) :: zgm2
      real, dimension(1:lx3,1:3) :: zgm3
      real, dimension(1:lx1) :: zgp
      integer :: nxyz
      integer :: ntot
      integer :: n
      integer :: i
      integer :: nio
      ! cvode
      ! nek-nek
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
! 
!      Elemental derivative operators
! 
      real, dimension(1:lx1,1:lx1), intent(InOut) :: dxm1
      real, dimension(1:lx2,1:lx1) :: dxm12
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lx1,1:lx1), intent(InOut) :: dxtm1
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
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dcm1
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dctm1
      real, dimension(1:ly3,1:ly3) :: dcm3
      real, dimension(1:ly3,1:ly3) :: dctm3
      real, dimension(1:ly2,1:ly1) :: dcm12
      real, dimension(1:ly1,1:ly2) :: dctm12
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dam1
      real, dimension(1:ly1,1:ly1), intent(InOut) :: datm1
      real, dimension(1:ly2,1:ly1) :: dam12
      real, dimension(1:ly1,1:ly2) :: datm12
      real, dimension(1:ly3,1:ly3) :: dam3
      real, dimension(1:ly3,1:ly3) :: datm3
! 
!      Geometry arrays
! 
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
      integer, parameter :: lxyz=lx1*ly1*lz1
      real, dimension(1:lxyz,1:1), intent(Out) :: ux
      real, dimension(1:lxyz,1:1), intent(Out) :: uy
      real, dimension(1:lxyz,1:1), intent(Out) :: uz
      real, dimension(1:lxyz,1:1), intent(InOut) :: u
      integer :: e
      nxyz = lx1*ly1*lz1
      ntot = nxyz*nelt
      n = lx1-1
      do e=1,nelt
         if (if3d) then
            ur_local_grad3 = reshape(ur,shape(ur_local_grad3))
            us_local_grad3 = reshape(us,shape(us_local_grad3))
            ut_local_grad3 = reshape(ut,shape(ut_local_grad3))
            u_local_grad3 = reshape(u,shape(u_local_grad3))
            call local_grad3(ur_local_grad3,us_local_grad3,ut_local_grad3,u_local_grad3,n,e,dxm1, &
      dxtm1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask, &
      b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy, &
      bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq, &
      bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h, &
      cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12, &
      dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt, &
      dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2, &
      dvprl8,dvprsm,dxm12,dxm3,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3, &
      dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip, &
      etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype, &
      fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid, &
      group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1, &
      iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13,icm21, &
      icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d, &
      if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor, &
      ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt, &
      ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs, &
      ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach, &
      ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek, &
      ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo, &
      ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo, &
      iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_, &
      iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall, &
      ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott, &
      ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield, &
      ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid, &
      ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj, &
      node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax, &
      nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc, &
      nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask, &
      optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl, &
      pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn, &
      pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep, &
      ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl, &
      rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2, &
      schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z, &
      ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl, &
      tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
            ur = reshape(ur_local_grad3, shape(ur))
            us = reshape(us_local_grad3, shape(us))
            ut = reshape(ut_local_grad3, shape(ut))
            u = reshape(u_local_grad3, shape(u))
            do i=1,lxyz
               ux(i,e) = jacmi(i,e)*(ur(i)*rxm1(i,1,1,e)                             + us(i)*sxm1(i, &
      1,1,e)                             + ut(i)*txm1(i,1,1,e) )
               uy(i,e) = jacmi(i,e)*(ur(i)*rym1(i,1,1,e)                             + us(i)*sym1(i, &
      1,1,e)                             + ut(i)*tym1(i,1,1,e) )
               uz(i,e) = jacmi(i,e)*(ur(i)*rzm1(i,1,1,e)                             + us(i)*szm1(i, &
      1,1,e)                             + ut(i)*tzm1(i,1,1,e) )
            enddo
         else
            call setaxdy(ifrzer(e),dam1,dam12,dam3,datm1,datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12, &
      dctm3,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3, &
      dztm1,dztm12,dztm3,idsess,ldimr,loglevel,ndim,nelt,nelv,nfield,nid,nio,npert,nx1,nx2,nx3, &
      nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,optlevel)
            ur_local_grad2 = reshape(ur,shape(ur_local_grad2))
            us_local_grad2 = reshape(us,shape(us_local_grad2))
            u_local_grad2 = reshape(u,shape(u_local_grad2))
            call local_grad2(ur_local_grad2,us_local_grad2,u_local_grad2,n,e,dxm1,dytm1,ab,abmsh, &
      abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask, &
      baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp, &
      bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by, &
      bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg, &
      curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1, &
      dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag, &
      dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm12, &
      dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3, &
      eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0, &
      ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1, &
      g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode, &
      hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12, &
      iatm13,iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21, &
      ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae, &
      ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup, &
      ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr, &
      ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat, &
      ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab, &
      ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp, &
      ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer, &
      ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo,iftmsh,ifto,iftran, &
      ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup, &
      im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal, &
      ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31,ixtm12,ixtm13,ixtm21, &
      ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13,izm21,izm31,iztm12, &
      iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum,lglel,lochis,loglevel, &
      lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null,mpi_bottom, &
      mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted, &
      mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp, &
      ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx, &
      ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom, &
      ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc, &
      nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst, &
      nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax,nspro,nsskip, &
      nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot, &
      nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask,optlevel,orefle, &
      p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl, &
      pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz, &
      pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag, &
      prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl,rct,re2fle,re2off_b, &
      reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle,session,skpdat, &
      solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc, &
      tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl, &
      tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx, &
      tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean,tmltd,tmult,tmxmf, &
      tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs,tolht,tolhv,tolnl, &
      tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal, &
      tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz, &
      uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff,vdiff_e,vgradt1,vgradt1p, &
      vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld, &
      voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp, &
      vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1, &
      w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt,wgli,wgp,wmult,wx, &
      wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc, &
      yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
            ur = reshape(ur_local_grad2, shape(ur))
            us = reshape(us_local_grad2, shape(us))
            u = reshape(u_local_grad2, shape(u))
            do i=1,lxyz
               ux(i,e) =jacmi(i,e)*(ur(i)*rxm1(i,1,1,e)                            + us(i)*sxm1(i,1, &
      1,e) )
               uy(i,e) =jacmi(i,e)*(ur(i)*rym1(i,1,1,e)                            + us(i)*sym1(i,1, &
      1,e) )
            enddo
         endif
      enddo
! 
      return
      end subroutine gradm1
      subroutine drgtrq(dgtq,xm0,ym0,zm0,sij,pm1,visc,f,e,ab,abmsh,area,atol,avdiff,avtran,bc,bcf, &
      bctyps,bd,cbc,ccurve,cdof,cerror,courno,cpfld,cpgrp,cr_re2,ctarg,curve,dlam,dmpfle,drivc,dt, &
      dtinit,dtinvm,dtlag,eface,eface1,eskip,etalph,fh_re2,filtertype,fintim,fldfle,g1m1,g2m1, &
      g3m1,g4m1,g5m1,g6m1,gcnnum,gednum,gedtyp,group,hcode,hisfle,ibcsts,icedg,icface,idpss, &
      idsess,ieact,iedge,iedgef,iedgfc,if3d,if_full_pres,ifadvc,ifanl2,ifanls,ifaxis,ifaziv, &
      ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff, &
      ifdp0dt,ifeppm,ifessr,ifexplvis,ifflow,iffmtin,ifgeom,ifgmsh3,ifheat,ifield,ifintq,ifkeps, &
      ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmpiio,ifmscr, &
      ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld, &
      ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrzer,ifschclob,ifsplit,ifstrs,ifsurt,iftgo,iftmsh,ifto, &
      iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,igroup,imatie, &
      imesh,indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv, &
      istep,ixcn,jacm1,jacm2,jacmi,lastep,lcnnum,ldimr,lednum,lochis,loglevel,lyap,matids,matindx, &
      matype,maxmlt,nab,nabmsh,nbd,nbdinp,ncmp,nconv,nconv_max,ndim,neact,nedg,nelfld,nelt,nelv, &
      nfield,ngcomm,ngeom,ngspcn,ngsped,nhis,nid,ninter,nio,nktonv,nmember,nmlinv,nmxe,nmxh,nmxnl, &
      nmxp,nobj,noffst,nomlis,npert,npscal,nrefle,nspmax,nsteps,ntaubd,numbcs,numflu,numoth, &
      numscn,numsed,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,optlevel,orefle, &
      param,parfle,path,pi,prelax,qinteg,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1, &
      rxm2,rym1,rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2, &
      t1x,t1y,t1z,t2x,t2y,t2z,textsw,time,timef,timeio,tmean,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs, &
      tolev,tolhdf,tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,txm1,txm2,tym1,tym2, &
      tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,v1x,v1y,v1z,v2x,v2y,v2z,vmean,vnekton,vnrmh1, &
      vnrml2,vnrml8,vnrmsm,vnx,vny,vnz,volfld,xc,xm1,xm2,yc,ym1,ym2,zc,zm1,zm2)
! 
      implicit none
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
      integer :: js1
      integer :: jf1
      integer :: jskip1
      integer :: js2
      integer :: jf2
      integer :: jskip2
      integer :: i
      real :: a
      integer :: j2
      integer :: j1
      real :: v
      real :: s11
      real :: s21
      real :: s31
      real :: s12
      real :: s22
      real :: s32
      real :: s13
      real :: s23
      real :: s33
      real :: r1
      real :: r2
      real :: r3
      integer :: l
      integer :: k
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
!      Arrays for direct stiffness summation
! 
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
      real, dimension(1:3,1:4), intent(InOut) :: dgtq
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: xm0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: ym0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: zm0
      real, dimension(1:lx1,1:ly1,1:lz1,1:3*ldim-3,1:lelv), intent(In) :: sij
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: pm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: visc
! 
      real, dimension(1:3,1:2) :: dg
! 
      integer :: f
      integer :: e
      integer :: pf
      real :: n1
      real :: n2
      real :: n3
! 
      ifadvc(1) = ifnav
      textsw(1,1) = turbmod
      call dsset(lx1,ly1,lz1)    
      pf     = eface1(f)         
      js1    = skpdat(1,pf)
      jf1    = skpdat(2,pf)
      jskip1 = skpdat(3,pf)
      js2    = skpdat(4,pf)
      jf2    = skpdat(5,pf)
      jskip2 = skpdat(6,pf)
! 
      call rzero(dgtq,12)
! 
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
! 
         v  = visc(j1,j2,1,e)
! 
         s11 = sij(j1,j2,1,1,e)
         s21 = sij(j1,j2,1,4,e)
         s31 = sij(j1,j2,1,6,e)
! 
         s12 = sij(j1,j2,1,4,e)
         s22 = sij(j1,j2,1,2,e)
         s32 = sij(j1,j2,1,5,e)
! 
         s13 = sij(j1,j2,1,6,e)
         s23 = sij(j1,j2,1,5,e)
         s33 = sij(j1,j2,1,3,e)
! 
         dg(1,1) = pm1(j1,j2,1,e)*n1     
         dg(2,1) = pm1(j1,j2,1,e)*n2
         dg(3,1) = pm1(j1,j2,1,e)*n3
! 
         dg(1,2) = -v*(s11*n1 + s12*n2 + s13*n3) 
         dg(2,2) = -v*(s21*n1 + s22*n2 + s23*n3)
         dg(3,2) = -v*(s31*n1 + s32*n2 + s33*n3)
! 
         r1 = xm0(j1,j2,1,e)
         r2 = ym0(j1,j2,1,e)
         r3 = zm0(j1,j2,1,e)
! 
         do l=1,2
         do k=1,3
            dgtq(k,l) = dgtq(k,l) + dg(k,l)
         enddo
         enddo
! 
         dgtq(1,3) = dgtq(1,3) + (r2*dg(3,1)-r3*dg(2,1)) 
         dgtq(2,3) = dgtq(2,3) + (r3*dg(1,1)-r1*dg(3,1)) 
         dgtq(3,3) = dgtq(3,3) + (r1*dg(2,1)-r2*dg(1,1))
! 
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
      subroutine torque_calc(scale,x0,ifdout,iftout,dragx,dragpx,dragvx,dragy,dragpy,dragvy,dragz, &
      dragpz,dragvz,torqx,torqpx,torqvx,torqy,torqpy,torqvy,torqz,torqpz,torqvz,dpdx_mean, &
      dpdy_mean,dpdz_mean,dgtq,flow_rate,base_flow,domain_length,xsec,scale_vf,pm1,sij,ur,us,ut, &
      vr,vs,vt,wr,ws,wt,xm0,ym0,zm0)
! 
!      Compute torque about point x0
! 
!      Scale is a user-supplied multiplier so that results may be
!      scaled to any convenient non-dimensionalization.
! 
! 
      implicit none
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
      real, dimension(1:3,1:4) :: dgtq_cmult
      real, dimension(1:1) :: pm1_add2s2
      real, dimension(1:lx1*ly1*lz1,1:nij,1:lelv) :: sij_comp_sij
      real, dimension(1:lx1,1:ly1,1:lz1,1:3*ldim-3,1:lelv) :: sij_drgtrq
      real, dimension(1:1) :: ur_comp_sij
      real, dimension(1:1) :: us_comp_sij
      real, dimension(1:1) :: ut_comp_sij
      real, dimension(1:1) :: vdiff_cfill
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vdiff_drgtrq
      real, dimension(1:1) :: vr_comp_sij
      real, dimension(1:1) :: vs_comp_sij
      real, dimension(1:1) :: vt_comp_sij
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: vx_comp_sij
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: vy_comp_sij
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: vz_comp_sij
      real, dimension(1:1) :: wr_comp_sij
      real, dimension(1:1) :: ws_comp_sij
      real, dimension(1:1) :: wt_comp_sij
      real, dimension(1:1) :: xm0_cadd2
      real, dimension(1:lx1,1:ly2,1:lz2) :: xm0_mappr
      real, dimension(1:1) :: xm1_add2s2
      real, dimension(1:1) :: xm1_cadd2
      real, dimension(1:1) :: ym0_cadd2
      real, dimension(1:lx1,1:ly1,1:lz2) :: ym0_mappr
      real, dimension(1:1) :: ym1_add2s2
      real, dimension(1:1) :: ym1_cadd2
      real, dimension(1:1) :: zm0_cadd2
      real, dimension(1:1) :: zm1_add2s2
      real, dimension(1:1) :: zm1_cadd2
      xm0(1:lx1,1:ly1,1:lz1,1:lelt) = reshape(trx(1:lx1,1:ly1,1:lz1),shape(xm0(1:lx1,1:ly1,1:lz1, &
      1:lelt)))
      ym0(1:lx1,1:ly1,1:lz1,1:lelt) = reshape(trz(1:lx1,1:ly1,1:lz1),shape(ym0(1:lx1,1:ly1,1:lz1, &
      1:lelt)))
      integer, parameter :: maxrts=1000
      integer, parameter :: mpi_status_size=6
      real :: base_flow
      real(kind=8) :: dcount
      real(kind=8), dimension(1:maxrts) :: dct
      real, dimension(1:3,1:4), intent(InOut) :: dgtq
      real :: domain_length
      real, intent(InOut) :: dpdx_mean
      real, intent(InOut) :: dpdy_mean
      real, intent(InOut) :: dpdz_mean
      real, dimension(0:maxobj), intent(InOut) :: dragpx
      real, dimension(0:maxobj), intent(InOut) :: dragpy
      real, dimension(0:maxobj), intent(InOut) :: dragpz
      real, dimension(0:maxobj), intent(InOut) :: dragvx
      real, dimension(0:maxobj), intent(InOut) :: dragvy
      real, dimension(0:maxobj), intent(InOut) :: dragvz
      real, dimension(0:maxobj), intent(InOut) :: dragx
      real, dimension(0:maxobj), intent(InOut) :: dragy
      real, dimension(0:maxobj), intent(InOut) :: dragz
      real(kind=8) :: etimes
      real(kind=8) :: etims0
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
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(InOut) :: pm1
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
      real, dimension(1:3), intent(In) :: scale_vf
      real, dimension(1:lx1*ly1*lz1*6*lelv), intent(InOut) :: sij
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
      real, dimension(0:maxobj), intent(InOut) :: torqpx
      real, dimension(0:maxobj), intent(InOut) :: torqpy
      real, dimension(0:maxobj), intent(InOut) :: torqpz
      real, dimension(0:maxobj), intent(InOut) :: torqvx
      real, dimension(0:maxobj), intent(InOut) :: torqvy
      real, dimension(0:maxobj), intent(InOut) :: torqvz
      real, dimension(0:maxobj), intent(InOut) :: torqx
      real, dimension(0:maxobj), intent(InOut) :: torqy
      real, dimension(0:maxobj), intent(InOut) :: torqz
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
      real, dimension(1:lr), intent(InOut) :: ur
      real, dimension(1:lr), intent(InOut) :: us
      real, dimension(1:lr), intent(InOut) :: ut
      real, dimension(1:lr), intent(InOut) :: vr
      real, dimension(1:lr), intent(InOut) :: vs
      real, dimension(1:lr), intent(InOut) :: vt
      real, dimension(1:lr), intent(InOut) :: wr
      real, dimension(1:lr), intent(InOut) :: ws
      real, dimension(1:lr), intent(InOut) :: wt
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(InOut) :: xm0
      real :: xsec
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(InOut) :: ym0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(InOut) :: zm0
      real, dimension(1:lx1,1:ly1,1:lz1) :: trx
      real, dimension(1:lx1,1:ly1,1:lz1) :: trz
      real, intent(In) :: scale
      integer :: i
      integer :: i0
      integer :: ie
      integer :: ieg
      integer :: ifc
      integer :: ii
      integer :: iobj
      integer :: mem
      integer :: memtot
      integer :: n
      integer :: nij
      real :: x1max
      real :: x1min
      real :: x2max
      real :: x2min
      real :: x3max
      real :: x3min
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
      real, dimension(1:3), intent(In) :: x0
      real, dimension(0:maxobj) :: w1
! 
      logical, intent(In) :: ifdout
      logical, intent(In) :: iftout
! 
! 
      integer, parameter :: lr=lx1*ly1*lz1
! 
! 
! 
! 
      n = lx1*ly1*lz1*nelv
! 
      xm0_mappr = reshape(xm0,shape(xm0_mappr))
      ym0_mappr = reshape(ym0,shape(ym0_mappr))
      call mappr(pm1,pr,xm0_mappr,ym0_mappr,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam, &
      dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2, &
      dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12, &
      dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas, &
      eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p, &
      exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0, &
      gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3, &
      iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts, &
      icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge, &
      iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast, &
      ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg, &
      ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge, &
      ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc, &
      iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg, &
      ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco, &
      ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst, &
      ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps, &
      ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep, &
      invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13, &
      ixm21,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31, &
      izm12,izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum, &
      ldimr,lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd, &
      nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv, &
      nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped, &
      ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf, &
      nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout, &
      nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu, &
      numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd, &
      object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc, &
      pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd, &
      pmxmf,pmxms,pprep,ppres,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss, &
      pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1, &
      rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y, &
      t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2, &
      tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw, &
      tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag, &
      tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf, &
      tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett, &
      tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1, &
      tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z, &
      v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2, &
      vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag, &
      vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2, &
      w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1, &
      wgl2,wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag, &
      wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp, &
      zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      xm0 = reshape(xm0_mappr, shape(xm0))
      ym0 = reshape(ym0_mappr, shape(ym0))
! 
!     Add mean_pressure_gradient.X to p:
      if (param(55) /= 0) then
         dpdx_mean = -scale_vf(1)
         dpdy_mean = -scale_vf(2)
         dpdz_mean = -scale_vf(3)
      endif
      pm1_add2s2 = reshape(pm1,shape(pm1_add2s2))
      xm1_add2s2 = reshape(xm1,shape(xm1_add2s2))
      call add2s2(pm1_add2s2,xm1_add2s2,dpdx_mean,n,dcount,dct,etimes,etims0,ifsync,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nadvc,naxhm,nbbbb,nbso2,nbsol,ncall, &
      ncccc,ncdtp,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndott,ndsmn,ndsmx,ndsnd,ndsum,neeee,neslv, &
      ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngsum,nhmhz,ninv3,ninvc,nmltd,nmxmf,nmxms,nprep,npres, &
      nrout,nsett,nslvb,nsolv,nspro,nsyc,nusbc,nvdss,nwal,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp, &
      pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pinv3,pinvc,pmltd,pmxmf,pmxms,pprep,ppres,psett, &
      pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,rct,rname,ta2s2,tadc3,tadd2,tadvc,taxhm,tbbbb,tbso2, &
      tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd, &
      tdsum,teeee,teslv,tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,tinit,tinv3,tinvc,tmltd, &
      tmxmf,tmxms,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc, &
      tusfq,tvdss,twal)
      pm1 = reshape(pm1_add2s2, shape(pm1))
      xm1 = reshape(xm1_add2s2, shape(xm1))
      pm1_add2s2 = reshape(pm1,shape(pm1_add2s2))
      ym1_add2s2 = reshape(ym1,shape(ym1_add2s2))
      call add2s2(pm1_add2s2,ym1_add2s2,dpdy_mean,n,dcount,dct,etimes,etims0,ifsync,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nadvc,naxhm,nbbbb,nbso2,nbsol,ncall, &
      ncccc,ncdtp,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndott,ndsmn,ndsmx,ndsnd,ndsum,neeee,neslv, &
      ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngsum,nhmhz,ninv3,ninvc,nmltd,nmxmf,nmxms,nprep,npres, &
      nrout,nsett,nslvb,nsolv,nspro,nsyc,nusbc,nvdss,nwal,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp, &
      pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pinv3,pinvc,pmltd,pmxmf,pmxms,pprep,ppres,psett, &
      pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,rct,rname,ta2s2,tadc3,tadd2,tadvc,taxhm,tbbbb,tbso2, &
      tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd, &
      tdsum,teeee,teslv,tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,tinit,tinv3,tinvc,tmltd, &
      tmxmf,tmxms,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc, &
      tusfq,tvdss,twal)
      pm1 = reshape(pm1_add2s2, shape(pm1))
      ym1 = reshape(ym1_add2s2, shape(ym1))
      pm1_add2s2 = reshape(pm1,shape(pm1_add2s2))
      zm1_add2s2 = reshape(zm1,shape(zm1_add2s2))
      call add2s2(pm1_add2s2,zm1_add2s2,dpdz_mean,n,dcount,dct,etimes,etims0,ifsync,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nadvc,naxhm,nbbbb,nbso2,nbsol,ncall, &
      ncccc,ncdtp,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndott,ndsmn,ndsmx,ndsnd,ndsum,neeee,neslv, &
      ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngsum,nhmhz,ninv3,ninvc,nmltd,nmxmf,nmxms,nprep,npres, &
      nrout,nsett,nslvb,nsolv,nspro,nsyc,nusbc,nvdss,nwal,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp, &
      pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1, &
      pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pinv3,pinvc,pmltd,pmxmf,pmxms,pprep,ppres,psett, &
      pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,rct,rname,ta2s2,tadc3,tadd2,tadvc,taxhm,tbbbb,tbso2, &
      tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd, &
      tdsum,teeee,teslv,tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,tinit,tinv3,tinvc,tmltd, &
      tmxmf,tmxms,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc, &
      tusfq,tvdss,twal)
      pm1 = reshape(pm1_add2s2, shape(pm1))
      zm1 = reshape(zm1_add2s2, shape(zm1))
! 
!     Compute sij
! 
      nij = 3
      if (if3d.or.ifaxis) nij=6
      sij_comp_sij = reshape(sij,shape(sij_comp_sij))
      vx_comp_sij = reshape(vx,shape(vx_comp_sij))
      vy_comp_sij = reshape(vy,shape(vy_comp_sij))
      vz_comp_sij = reshape(vz,shape(vz_comp_sij))
      ur_comp_sij = reshape(ur,shape(ur_comp_sij))
      us_comp_sij = reshape(us,shape(us_comp_sij))
      ut_comp_sij = reshape(ut,shape(ut_comp_sij))
      vr_comp_sij = reshape(vr,shape(vr_comp_sij))
      vs_comp_sij = reshape(vs,shape(vs_comp_sij))
      vt_comp_sij = reshape(vt,shape(vt_comp_sij))
      wr_comp_sij = reshape(wr,shape(wr_comp_sij))
      ws_comp_sij = reshape(ws,shape(ws_comp_sij))
      wt_comp_sij = reshape(wt,shape(wt_comp_sij))
      call comp_sij(sij_comp_sij,nij,vx_comp_sij,vy_comp_sij,vz_comp_sij,ur_comp_sij,us_comp_sij, &
      ut_comp_sij,vr_comp_sij,vs_comp_sij,vt_comp_sij,wr_comp_sij,ws_comp_sij,wt_comp_sij,ab, &
      abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p, &
      b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz, &
      bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx, &
      bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2, &
      csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3, &
      dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt, &
      dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2, &
      dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1, &
      dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs, &
      eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2, &
      filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel, &
      gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31, &
      iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13, &
      icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d, &
      if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor, &
      ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt, &
      ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs, &
      ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach, &
      ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek, &
      ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo, &
      ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo, &
      iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_, &
      iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall, &
      ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott, &
      ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield, &
      ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid, &
      ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj, &
      node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax, &
      nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc, &
      nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask, &
      optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl, &
      pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn, &
      pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep, &
      ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl, &
      rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2, &
      schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z, &
      ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl, &
      tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx_e,vxd,vxlag,vxlagp,vxp,vy_e, &
      vyd,vylag,vylagp,vyp,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2,w2cm3, &
      w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt,wgli,wgp, &
      wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc,xm1,xm2, &
      xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      sij = reshape(sij_comp_sij, shape(sij))
      vx = reshape(vx_comp_sij, shape(vx))
      vy = reshape(vy_comp_sij, shape(vy))
      vz = reshape(vz_comp_sij, shape(vz))
      ur = reshape(ur_comp_sij, shape(ur))
      us = reshape(us_comp_sij, shape(us))
      ut = reshape(ut_comp_sij, shape(ut))
      vr = reshape(vr_comp_sij, shape(vr))
      vs = reshape(vs_comp_sij, shape(vs))
      vt = reshape(vt_comp_sij, shape(vt))
      wr = reshape(wr_comp_sij, shape(wr))
      ws = reshape(ws_comp_sij, shape(ws))
      wt = reshape(wt_comp_sij, shape(wt))
! 
! 
!      Fill up viscous array w/ default
! 
      vdiff_cfill = reshape(vdiff,shape(vdiff_cfill))
      call cfill(vdiff_cfill,param(2),n)

      vdiff = reshape(vdiff_cfill, shape(vdiff))
! 
      xm0_cadd2 = reshape(xm0,shape(xm0_cadd2))
      xm1_cadd2 = reshape(xm1,shape(xm1_cadd2))
      call cadd2(xm0_cadd2,xm1_cadd2,-x0(1),n,dcount,dct,ncall,nrout,rct,rname)

      xm0 = reshape(xm0_cadd2, shape(xm0))
      xm1 = reshape(xm1_cadd2, shape(xm1))
      ym0_cadd2 = reshape(ym0,shape(ym0_cadd2))
      ym1_cadd2 = reshape(ym1,shape(ym1_cadd2))
      call cadd2(ym0_cadd2,ym1_cadd2,-x0(2),n,dcount,dct,ncall,nrout,rct,rname)

      ym0 = reshape(ym0_cadd2, shape(ym0))
      ym1 = reshape(ym1_cadd2, shape(ym1))
      zm0_cadd2 = reshape(zm0,shape(zm0_cadd2))
      zm1_cadd2 = reshape(zm1,shape(zm1_cadd2))
      call cadd2(zm0_cadd2,zm1_cadd2,-x0(3),n,dcount,dct,ncall,nrout,rct,rname)

      zm0 = reshape(zm0_cadd2, shape(zm0))
      zm1 = reshape(zm1_cadd2, shape(zm1))
! 
      x1min = glmin(xm0(1,1,1,1),n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
      b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd, &
      bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx, &
      bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno, &
      cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12, &
      datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt, &
      drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1, &
      dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3, &
      dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs, &
      eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2, &
      filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel, &
      gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31, &
      iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg,icface,icm12, &
      icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv, &
      if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase, &
      ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff, &
      ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3, &
      ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf, &
      iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd, &
      ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp, &
      ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync, &
      iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo, &
      ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncccc, &
      ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn, &
      ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal,nelfld,nelg,nelgt,nelgv,nelt, &
      nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum, &
      nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms, &
      nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nsett,nslvb, &
      nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn, &
      numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode, &
      omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy, &
      pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2, &
      pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms, &
      pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg, &
      qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle, &
      session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2, &
      tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf, &
      tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync, &
      tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean, &
      tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs, &
      tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro, &
      tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr, &
      uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      x2min = glmin(ym0(1,1,1,1),n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
      b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd, &
      bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx, &
      bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno, &
      cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12, &
      datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt, &
      drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1, &
      dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3, &
      dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs, &
      eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2, &
      filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel, &
      gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31, &
      iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg,icface,icm12, &
      icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv, &
      if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase, &
      ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff, &
      ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3, &
      ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf, &
      iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd, &
      ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp, &
      ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync, &
      iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo, &
      ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncccc, &
      ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn, &
      ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal,nelfld,nelg,nelgt,nelgv,nelt, &
      nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum, &
      nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms, &
      nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nsett,nslvb, &
      nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn, &
      numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode, &
      omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy, &
      pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2, &
      pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms, &
      pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg, &
      qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle, &
      session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2, &
      tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf, &
      tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync, &
      tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean, &
      tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs, &
      tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro, &
      tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr, &
      uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      x3min = glmin(zm0(1,1,1,1),n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
      b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd, &
      bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx, &
      bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno, &
      cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12, &
      datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt, &
      drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1, &
      dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3, &
      dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs, &
      eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2, &
      filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel, &
      gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31, &
      iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg,icface,icm12, &
      icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv, &
      if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase, &
      ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff, &
      ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3, &
      ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf, &
      iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd, &
      ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp, &
      ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync, &
      iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo, &
      ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncccc, &
      ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn, &
      ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal,nelfld,nelg,nelgt,nelgv,nelt, &
      nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum, &
      nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms, &
      nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nsett,nslvb, &
      nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn, &
      numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode, &
      omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy, &
      pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2, &
      pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms, &
      pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg, &
      qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle, &
      session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2, &
      tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf, &
      tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync, &
      tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean, &
      tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs, &
      tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro, &
      tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr, &
      uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
! 
      x1max = glmax(xm0(1,1,1,1),n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
      b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd, &
      bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx, &
      bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno, &
      cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12, &
      datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt, &
      drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1, &
      dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3, &
      dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs, &
      eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2, &
      filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel, &
      gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31, &
      iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg,icface,icm12, &
      icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv, &
      if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase, &
      ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff, &
      ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3, &
      ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf, &
      iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd, &
      ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp, &
      ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync, &
      iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo, &
      ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncccc, &
      ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn, &
      ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal,nelfld,nelg,nelgt,nelgv,nelt, &
      nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum, &
      nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms, &
      nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nsett,nslvb, &
      nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn, &
      numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode, &
      omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy, &
      pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2, &
      pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms, &
      pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg, &
      qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle, &
      session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2, &
      tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf, &
      tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync, &
      tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean, &
      tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs, &
      tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro, &
      tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr, &
      uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      x2max = glmax(ym0(1,1,1,1),n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
      b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd, &
      bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx, &
      bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno, &
      cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12, &
      datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt, &
      drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1, &
      dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3, &
      dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs, &
      eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2, &
      filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel, &
      gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31, &
      iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg,icface,icm12, &
      icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv, &
      if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase, &
      ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff, &
      ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3, &
      ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf, &
      iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd, &
      ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp, &
      ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync, &
      iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo, &
      ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncccc, &
      ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn, &
      ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal,nelfld,nelg,nelgt,nelgv,nelt, &
      nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum, &
      nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms, &
      nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nsett,nslvb, &
      nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn, &
      numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode, &
      omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy, &
      pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2, &
      pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms, &
      pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg, &
      qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle, &
      session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2, &
      tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf, &
      tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync, &
      tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean, &
      tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs, &
      tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro, &
      tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr, &
      uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      x3max = glmax(zm0(1,1,1,1),n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
      b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd, &
      bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx, &
      bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno, &
      cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12, &
      datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt, &
      drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1, &
      dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3, &
      dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs, &
      eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2, &
      filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel, &
      gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31, &
      iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg,icface,icm12, &
      icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv, &
      if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase, &
      ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff, &
      ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3, &
      ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf, &
      iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd, &
      ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp, &
      ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync, &
      iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo, &
      ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncccc, &
      ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn, &
      ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal,nelfld,nelg,nelgt,nelgv,nelt, &
      nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum, &
      nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms, &
      nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nsett,nslvb, &
      nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn, &
      numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode, &
      omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy, &
      pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2, &
      pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms, &
      pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg, &
      qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle, &
      session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2, &
      tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf, &
      tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync, &
      tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean, &
      tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs, &
      tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro, &
      tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr, &
      uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
! 
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
! 
! 
      nobj = 0
      do ii=1,nhis
        if (hcode(10,ii) == 'I') then
          iobj   = lochis(1,ii)
          memtot = nmember(iobj)
          nobj   = max(iobj,nobj)
! 
          if (hcode(1,ii) /= ' ' .or. hcode(2,ii) /= ' ' .or.      hcode(3,ii) /= ' ' ) then
            ifield = 1
! 
!            Compute drag for this object
! 
            do mem=1,memtot
               ieg   = object(iobj,mem,1)
               ifc   = object(iobj,mem,2)
               if (gllnid(ieg) == nid) then 
                  ie = gllel(ieg)
                  sij_drgtrq = reshape(sij,shape(sij_drgtrq))
                  vdiff_drgtrq = reshape(vdiff,shape(vdiff_drgtrq))
                  call drgtrq(dgtq,xm0,ym0,zm0,sij_drgtrq,pm1,vdiff_drgtrq,ifc,ie,ab,abmsh,area, &
      atol,avdiff,avtran,bc,bcf,bctyps,bd,cbc,ccurve,cdof,cerror,courno,cpfld,cpgrp,cr_re2,ctarg, &
      curve,dlam,dmpfle,drivc,dt,dtinit,dtinvm,dtlag,eface,eface1,eskip,etalph,fh_re2,filtertype, &
      fintim,fldfle,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gcnnum,gednum,gedtyp,group,hcode,hisfle,ibcsts, &
      icedg,icface,idpss,idsess,ieact,iedge,iedgef,iedgfc,if3d,if_full_pres,ifadvc,ifanl2,ifanls, &
      ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg, &
      ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifflow,iffmtin,ifgeom,ifgmsh3,ifheat,ifield, &
      ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel, &
      ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo, &
      ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrzer,ifschclob,ifsplit,ifstrs,ifsurt, &
      iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo, &
      ifxyo_,igroup,imatie,imesh,indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco, &
      irstim,irstt,irstv,istep,ixcn,jacm1,jacm2,jacmi,lastep,lcnnum,ldimr,lednum,lochis,loglevel, &
      lyap,matids,matindx,matype,maxmlt,nab,nabmsh,nbd,nbdinp,ncmp,nconv,nconv_max,ndim,neact, &
      nedg,nelfld,nelt,nelv,nfield,ngcomm,ngeom,ngspcn,ngsped,nhis,nid,ninter,nio,nktonv,nmember, &
      nmlinv,nmxe,nmxh,nmxnl,nmxp,nobj,noffst,nomlis,npert,npscal,nrefle,nspmax,nsteps,ntaubd, &
      numbcs,numflu,numoth,numscn,numsed,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object, &
      ocode,optlevel,orefle,param,parfle,path,pi,prelax,qinteg,re2fle,re2off_b,reafle,restol, &
      rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1, &
      sxm2,sym1,sym2,szm1,szm2,t1x,t1y,t1z,t2x,t2y,t2z,textsw,time,timef,timeio,tmean,tnrmh1, &
      tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps, &
      tolrel,txm1,txm2,tym1,tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,v1x,v1y,v1z,v2x,v2y,v2z, &
      vmean,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm,vnx,vny,vnz,volfld,xc,xm1,xm2,yc,ym1,ym2,zc,zm1, &
      zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
                  sij = reshape(sij_drgtrq, shape(sij))
                  vdiff = reshape(vdiff_drgtrq, shape(vdiff))
! 
                  dgtq_cmult = reshape(dgtq,shape(dgtq_cmult))
                  call cmult(dgtq_cmult,scale,12,dcount,dct,ncall,nrout,rct,rname)

                  dgtq = reshape(dgtq_cmult, shape(dgtq))
! 
                  dragpx(iobj) = dragpx(iobj) + dgtq(1,1)  
                  dragpy(iobj) = dragpy(iobj) + dgtq(2,1)
                  dragpz(iobj) = dragpz(iobj) + dgtq(3,1)
! 
                  dragvx(iobj) = dragvx(iobj) + dgtq(1,2)  
                  dragvy(iobj) = dragvy(iobj) + dgtq(2,2)
                  dragvz(iobj) = dragvz(iobj) + dgtq(3,2)
! 
                  torqpx(iobj) = torqpx(iobj) + dgtq(1,3)  
                  torqpy(iobj) = torqpy(iobj) + dgtq(2,3)
                  torqpz(iobj) = torqpz(iobj) + dgtq(3,3)
! 
                  torqvx(iobj) = torqvx(iobj) + dgtq(1,4)  
                  torqvy(iobj) = torqvy(iobj) + dgtq(2,4)
                  torqvz(iobj) = torqvz(iobj) + dgtq(3,4)
! 
               endif
            enddo
          endif
        endif
      enddo
! 
!      Sum contributions from all processors
! 
      call gop(dragpx,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      call gop(dragpy,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      call gop(dragpz,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      call gop(dragvx,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      call gop(dragvy,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      call gop(dragvz,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
! 
      call gop(torqpx,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      call gop(torqpy,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      call gop(torqpz,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      call gop(torqvx,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      call gop(torqvy,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
      call gop(torqvz,w1,'+  ',maxobj+1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
      avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf, &
      bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass, &
      bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf, &
      courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1, &
      datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle, &
      dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8, &
      dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1, &
      dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga, &
      eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p, &
      exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum, &
      gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13, &
      iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg, &
      icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef, &
      iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis, &
      ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld, &
      ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom, &
      ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse, &
      iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc, &
      ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso, &
      ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt, &
      ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno, &
      ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg, &
      iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21, &
      ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12, &
      izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr, &
      lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null, &
      mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore, &
      mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd, &
      nbdinp,nbso2,nbsol,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl, &
      ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal, &
      nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn, &
      ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd, &
      nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs, &
      numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2, &
      nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol, &
      pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop, &
      pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag, &
      pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,qinteg,qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2, &
      rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x, &
      t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy, &
      tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
! 
      nobj  = iglmax(nobj,1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1, &
      b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw, &
      bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy, &
      bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld, &
      cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3, &
      dcm1,dcm12,dcm3,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt, &
      dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2, &
      dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1, &
      dzm12,dzm3,dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs, &
      eiggst,eskip,etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2, &
      filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel, &
      gllnid,group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31, &
      iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icall,icedg,icface,icm12, &
      icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv, &
      if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase, &
      ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff, &
      ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3, &
      ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf, &
      iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd, &
      ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp, &
      ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync, &
      iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo, &
      ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncccc, &
      ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn, &
      ndsmx,ndsnd,ndsum,neact,nedg,neeee,nekcomm,nekgroup,nekreal,nelfld,nelg,nelgt,nelgv,nelt, &
      nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum, &
      nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms, &
      nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nsett,nslvb, &
      nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn, &
      numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode, &
      omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy, &
      pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2, &
      pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms, &
      pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg, &
      qtl,re2fle,re2off_b,reafle,restol,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle, &
      session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2, &
      tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf, &
      tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync, &
      tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean, &
      tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs, &
      tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro, &
      tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr, &
      uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
! 
      do i=1,nobj
         dragx(i) = dragpx(i) + dragvx(i)
         dragy(i) = dragpy(i) + dragvy(i)
         dragz(i) = dragpz(i) + dragvz(i)
! 
         torqx(i) = torqpx(i) + torqvx(i)
         torqy(i) = torqpy(i) + torqvy(i)
         torqz(i) = torqpz(i) + torqvz(i)
! 
         dragpx(0) = dragpx (0) + dragpx (i)
         dragvx(0) = dragvx (0) + dragvx (i)
         dragx (0) = dragx  (0) + dragx  (i)
! 
         dragpy(0) = dragpy (0) + dragpy (i)
         dragvy(0) = dragvy (0) + dragvy (i)
         dragy (0) = dragy  (0) + dragy  (i)
! 
         dragpz(0) = dragpz (0) + dragpz (i)
         dragvz(0) = dragvz (0) + dragvz (i)
         dragz (0) = dragz  (0) + dragz  (i)
! 
         torqpx(0) = torqpx (0) + torqpx (i)
         torqvx(0) = torqvx (0) + torqvx (i)
         torqx (0) = torqx  (0) + torqx  (i)
! 
         torqpy(0) = torqpy (0) + torqpy (i)
         torqvy(0) = torqvy (0) + torqvy (i)
         torqy (0) = torqy  (0) + torqy  (i)
! 
         torqpz(0) = torqpz (0) + torqpz (i)
         torqvz(0) = torqvz (0) + torqvz (i)
         torqz (0) = torqz  (0) + torqz  (i)
! 
      enddo
! 
      i0 = 0
      if (nobj <= 1) i0 = 1  
! 
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
! 
      trx(1:lx1,1:ly1,1:lz1) = xm0(1:lx1,1:ly1,1:lz1,1:lelt)
      trz(1:lx1,1:ly1,1:lz1) = ym0(1:lx1,1:ly1,1:lz1,1:lelt)
      return
      end subroutine torque_calc
      subroutine comp_sij(sij,nij,u,v,w,ur,us,ut,vr,vs,vt,wr,ws,wt,ab,abmsh,abx1,abx2,aby1,aby2, &
      abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2, &
      bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1, &
      bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx, &
      cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg,curve,d1,d1t,d2,da, &
      dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1,dctm12,dctm3, &
      dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag,dvdfh1,dvdfl2, &
      dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm1,dxm12,dxm3,dxtm1, &
      dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3,eface, &
      eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0,ev1,ev2, &
      ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1,g2m1,g3m1, &
      g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode,hisfle, &
      iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12,iatm13, &
      iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21,ictm31,idpss, &
      idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2, &
      ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode, &
      ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow, &
      iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat,ifield,ifintq, &
      ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp, &
      ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo, &
      ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit, &
      ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo,iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor, &
      ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh, &
      indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize, &
      istep,ixcn,ixm12,ixm13,ixm21,ixm31,ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31, &
      iytm12,iytm13,iytm21,iytm31,izm12,izm13,izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2, &
      jacmi,jp,lastep,lcnnum,ldimr,lednum,lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype, &
      maxmlt,mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place, &
      mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc, &
      naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf, &
      ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg, &
      nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx, &
      ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe, &
      nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst,nomlis,np,npert,nprep,npres,npscal, &
      nrefle,nrout,nsett,nslvb,nsolv,nspmax,nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid, &
      numbcs,numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd, &
      nz1,nz2,nz3,nzd,object,ocode,omask,optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2, &
      pbsol,pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv, &
      pgop,pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t, &
      pmlag,pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc, &
      pusbc,pvdss,pwal,qinteg,qtl,rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1, &
      rxm2,rym1,rym2,rzm1,rzm2,schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t, &
      t1x,t1y,t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp, &
      tcol2,tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv, &
      textsw,tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3, &
      tinvc,tlag,tlagp,tmask,tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs, &
      tolev,tolhdf,tolhe,tolhr,tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj, &
      tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2, &
      txnext,tym1,tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask, &
      v2x,v2y,v2z,v3mask,vdiff,vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton, &
      vnrmh1,vnrml2,vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx, &
      vx_e,vxd,vxlag,vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask, &
      w2am1,w2am2,w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize, &
      wdsizi,wgl,wgl1,wgl2,wglg,wglgt,wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2, &
      wym3,wz,wzlag,wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1, &
      zgm2,zgm3,zgp,zm1,zm2)
!                                        du_i       du_j
!      Compute the stress tensor S_ij := ----   +   ----
!                                        du_j       du_i
! 
      implicit none
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
      real(kind=8), intent(InOut) :: dcount
      real, dimension(0:n,0:n,1:1) :: u_local_grad2
      real, dimension(0:n,0:n,0:n,1:1) :: u_local_grad3
      real, dimension(1:1) :: ur_local_grad2
      real, dimension(1:1) :: ur_local_grad3
      real, dimension(1:1) :: us_local_grad2
      real, dimension(1:1) :: us_local_grad3
      real, dimension(1:1) :: ut_local_grad3
      real, dimension(0:n,0:n,1:1) :: v_local_grad2
      real, dimension(0:n,0:n,0:n,1:1) :: v_local_grad3
      real, dimension(1:1) :: vr_local_grad2
      real, dimension(1:1) :: vr_local_grad3
      real, dimension(1:1) :: vs_local_grad2
      real, dimension(1:1) :: vs_local_grad3
      real, dimension(1:1) :: vt_local_grad3
      real, dimension(0:n,0:n,1:1) :: w_local_grad2
      real, dimension(0:n,0:n,0:n,1:1) :: w_local_grad3
      real, dimension(1:1) :: wr_local_grad2
      real, dimension(1:1) :: wr_local_grad3
      real, dimension(1:1) :: ws_local_grad2
      real, dimension(1:1) :: ws_local_grad3
      real, dimension(1:1) :: wt_local_grad3
            integer, parameter :: maxrts=1000
      real(kind=8), dimension(1:maxrts), intent(InOut) :: dct
      real(kind=8) :: etimes
      real(kind=8) :: etims0
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
      integer, dimension(1:maxrts), intent(InOut) :: ncall
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
      integer, intent(InOut) :: nrout
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
      character(len=6), dimension(1:maxrts), intent(Out) :: rname
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
      real(kind=8), intent(Out) :: tmxmf
      real(kind=8) :: tmxms
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
      integer :: nij
      integer :: n
      integer :: nxyz
      integer :: i
      real :: r
      integer :: nio
      ! cvode
      ! nek-nek
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
      integer, parameter :: numsts=50
! 
!      Elemental derivative operators
! 
      real, dimension(1:lx1,1:lx1), intent(InOut) :: dxm1
      real, dimension(1:lx2,1:lx1) :: dxm12
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lx1,1:lx1), intent(InOut) :: dxtm1
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
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dcm1
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dctm1
      real, dimension(1:ly3,1:ly3) :: dcm3
      real, dimension(1:ly3,1:ly3) :: dctm3
      real, dimension(1:ly2,1:ly1) :: dcm12
      real, dimension(1:ly1,1:ly2) :: dctm12
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dam1
      real, dimension(1:ly1,1:ly1), intent(InOut) :: datm1
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
! 
      integer :: e
! 
      real, dimension(1:lx1*ly1*lz1,1:nij,1:lelv), intent(Out) :: sij
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(InOut) :: u
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(InOut) :: v
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(InOut) :: w
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
        ur_local_grad3 = reshape(ur,shape(ur_local_grad3))
        us_local_grad3 = reshape(us,shape(us_local_grad3))
        ut_local_grad3 = reshape(ut,shape(ut_local_grad3))
        u_local_grad3 = reshape(u,shape(u_local_grad3))
        call local_grad3(ur_local_grad3,us_local_grad3,ut_local_grad3,u_local_grad3,n,e,dxm1,dxtm1, &
      ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask, &
      b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz, &
      bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx, &
      bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2, &
      csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3, &
      dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt, &
      dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2, &
      dvprl8,dvprsm,dxm12,dxm3,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3, &
      dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip, &
      etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype, &
      fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid, &
      group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1, &
      iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13,icm21, &
      icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d, &
      if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor, &
      ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt, &
      ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs, &
      ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach, &
      ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek, &
      ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo, &
      ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo, &
      iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_, &
      iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall, &
      ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott, &
      ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield, &
      ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid, &
      ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj, &
      node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax, &
      nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc, &
      nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask, &
      optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl, &
      pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn, &
      pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep, &
      ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl, &
      rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2, &
      schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z, &
      ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl, &
      tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
        ur = reshape(ur_local_grad3, shape(ur))
        us = reshape(us_local_grad3, shape(us))
        ut = reshape(ut_local_grad3, shape(ut))
        u = reshape(u_local_grad3, shape(u))
        vr_local_grad3 = reshape(vr,shape(vr_local_grad3))
        vs_local_grad3 = reshape(vs,shape(vs_local_grad3))
        vt_local_grad3 = reshape(vt,shape(vt_local_grad3))
        v_local_grad3 = reshape(v,shape(v_local_grad3))
        call local_grad3(vr_local_grad3,vs_local_grad3,vt_local_grad3,v_local_grad3,n,e,dxm1,dxtm1, &
      ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask, &
      b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz, &
      bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx, &
      bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2, &
      csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3, &
      dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt, &
      dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2, &
      dvprl8,dvprsm,dxm12,dxm3,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3, &
      dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip, &
      etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype, &
      fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid, &
      group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1, &
      iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13,icm21, &
      icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d, &
      if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor, &
      ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt, &
      ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs, &
      ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach, &
      ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek, &
      ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo, &
      ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo, &
      iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_, &
      iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall, &
      ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott, &
      ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield, &
      ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid, &
      ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj, &
      node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax, &
      nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc, &
      nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask, &
      optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl, &
      pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn, &
      pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep, &
      ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl, &
      rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2, &
      schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z, &
      ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl, &
      tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
        vr = reshape(vr_local_grad3, shape(vr))
        vs = reshape(vs_local_grad3, shape(vs))
        vt = reshape(vt_local_grad3, shape(vt))
        v = reshape(v_local_grad3, shape(v))
        wr_local_grad3 = reshape(wr,shape(wr_local_grad3))
        ws_local_grad3 = reshape(ws,shape(ws_local_grad3))
        wt_local_grad3 = reshape(wt,shape(wt_local_grad3))
        w_local_grad3 = reshape(w,shape(w_local_grad3))
        call local_grad3(wr_local_grad3,ws_local_grad3,wt_local_grad3,w_local_grad3,n,e,dxm1,dxtm1, &
      ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask, &
      b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz, &
      bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx, &
      bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2, &
      csize,ctarg,curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3, &
      dcount,dct,dctm1,dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt, &
      dtinit,dtinvm,dtlag,dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2, &
      dvprl8,dvprsm,dxm12,dxm3,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3, &
      dztm1,dztm12,dztm3,eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip, &
      etalph,etimes,etims0,ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype, &
      fintim,fldfle,fw,g1m1,g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid, &
      group,gsh,gsh_fld,hcode,hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1, &
      iatjl2,iatlj1,iatlj3,iatm12,iatm13,iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13,icm21, &
      icm31,ictm12,ictm13,ictm21,ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d, &
      if_full_pres,ifaa,ifadvc,ifae,ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor, &
      ifbo,ifchar,ifcons,ifcoup,ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt, &
      ifeppm,ifessr,ifexplvis,ifextr,ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs, &
      ifgsh_fld_same,ifgst,ifheat,ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach, &
      ifmelt,ifmgrid,ifmhd,ifmoab,ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek, &
      ifneknekm,ifnonl,ifnskp,ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo, &
      ifrich,ifrsxy,ifrzer,ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo, &
      iftmsh,ifto,iftran,ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_, &
      iggl,igglt,igroup,im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm, &
      ioinfodmp,iostep,ipscal,ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31, &
      ixtm12,ixtm13,ixtm21,ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13, &
      izm21,izm31,iztm12,iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum, &
      lglel,lochis,loglevel,lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall, &
      ncccc,ncdtp,ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott, &
      ndsmn,ndsmx,ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield, &
      ngcomm,ngeom,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid, &
      ninter,ninv3,ninvc,nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj, &
      node,node0,noffst,nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax, &
      nspro,nsskip,nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc, &
      nvdss,nvtot,nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask, &
      optlevel,orefle,p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl, &
      pdadd,pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn, &
      pgsmx,pgsum,phmhz,pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep, &
      ppres,pr,prelax,prlag,prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl, &
      rct,re2fle,re2off_b,reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2, &
      schfle,session,skpdat,solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z, &
      ta2s2,tadc3,tadd2,tadvc,tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl, &
      tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1, &
      tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask, &
      tmean,tmltd,tmult,tmxmf,tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr, &
      tolhs,tolht,tolhv,tolnl,tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv, &
      tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2, &
      unr,uns,unt,unx,uny,unz,uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff, &
      vdiff_e,vgradt1,vgradt1p,vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm, &
      vnx,vny,vnz,volel,volfld,voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy, &
      vy_e,vyd,vylag,vylagp,vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2, &
      w2cm3,w2mask,w3m1,w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt, &
      wgli,wgp,wmult,wx,wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc, &
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
        wr = reshape(wr_local_grad3, shape(wr))
        ws = reshape(ws_local_grad3, shape(ws))
        wt = reshape(wt_local_grad3, shape(wt))
        w = reshape(w_local_grad3, shape(w))
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
! 
!         Notation:                       ( 2  x  Acheson, p. 353)
!                      Cylindrical
!             Nek5k    Coordinates
! 
!               x          z
!               y          r
!               z          theta
! 
         do e=1,nelv
            call setaxdy(ifrzer(e),dam1,dam12,dam3,datm1,datm12,datm3,dcm1,dcm12,dcm3,dctm1,dctm12, &
      dctm3,dxm1,dxm12,dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3, &
      dztm1,dztm12,dztm3,idsess,ldimr,loglevel,ndim,nelt,nelv,nfield,nid,nio,npert,nx1,nx2,nx3, &
      nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,optlevel)
            ur_local_grad2 = reshape(ur,shape(ur_local_grad2))
            us_local_grad2 = reshape(us,shape(us_local_grad2))
            u_local_grad2 = reshape(u,shape(u_local_grad2))
            call local_grad2(ur_local_grad2,us_local_grad2,u_local_grad2,n,e,dxm1,dytm1,ab,abmsh, &
      abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask, &
      baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp, &
      bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by, &
      bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg, &
      curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1, &
      dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag, &
      dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm12, &
      dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3, &
      eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0, &
      ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1, &
      g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode, &
      hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12, &
      iatm13,iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21, &
      ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae, &
      ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup, &
      ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr, &
      ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat, &
      ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab, &
      ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp, &
      ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer, &
      ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo,iftmsh,ifto,iftran, &
      ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup, &
      im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal, &
      ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31,ixtm12,ixtm13,ixtm21, &
      ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13,izm21,izm31,iztm12, &
      iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum,lglel,lochis,loglevel, &
      lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null,mpi_bottom, &
      mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted, &
      mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp, &
      ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx, &
      ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom, &
      ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc, &
      nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst, &
      nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax,nspro,nsskip, &
      nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot, &
      nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask,optlevel,orefle, &
      p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl, &
      pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz, &
      pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag, &
      prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl,rct,re2fle,re2off_b, &
      reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle,session,skpdat, &
      solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc, &
      tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl, &
      tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx, &
      tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean,tmltd,tmult,tmxmf, &
      tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs,tolht,tolhv,tolnl, &
      tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal, &
      tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz, &
      uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff,vdiff_e,vgradt1,vgradt1p, &
      vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld, &
      voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp, &
      vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1, &
      w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt,wgli,wgp,wmult,wx, &
      wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc, &
      yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
            ur = reshape(ur_local_grad2, shape(ur))
            us = reshape(us_local_grad2, shape(us))
            u = reshape(u_local_grad2, shape(u))
            vr_local_grad2 = reshape(vr,shape(vr_local_grad2))
            vs_local_grad2 = reshape(vs,shape(vs_local_grad2))
            v_local_grad2 = reshape(v,shape(v_local_grad2))
            call local_grad2(vr_local_grad2,vs_local_grad2,v_local_grad2,n,e,dxm1,dytm1,ab,abmsh, &
      abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask, &
      baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp, &
      bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by, &
      bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg, &
      curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1, &
      dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag, &
      dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm12, &
      dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3, &
      eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0, &
      ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1, &
      g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode, &
      hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12, &
      iatm13,iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21, &
      ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae, &
      ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup, &
      ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr, &
      ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat, &
      ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab, &
      ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp, &
      ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer, &
      ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo,iftmsh,ifto,iftran, &
      ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup, &
      im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal, &
      ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31,ixtm12,ixtm13,ixtm21, &
      ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13,izm21,izm31,iztm12, &
      iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum,lglel,lochis,loglevel, &
      lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null,mpi_bottom, &
      mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted, &
      mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp, &
      ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx, &
      ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom, &
      ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc, &
      nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst, &
      nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax,nspro,nsskip, &
      nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot, &
      nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask,optlevel,orefle, &
      p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl, &
      pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz, &
      pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag, &
      prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl,rct,re2fle,re2off_b, &
      reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle,session,skpdat, &
      solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc, &
      tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl, &
      tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx, &
      tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean,tmltd,tmult,tmxmf, &
      tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs,tolht,tolhv,tolnl, &
      tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal, &
      tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz, &
      uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff,vdiff_e,vgradt1,vgradt1p, &
      vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld, &
      voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp, &
      vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1, &
      w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt,wgli,wgp,wmult,wx, &
      wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc, &
      yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
            vr = reshape(vr_local_grad2, shape(vr))
            vs = reshape(vs_local_grad2, shape(vs))
            v = reshape(v_local_grad2, shape(v))
            wr_local_grad2 = reshape(wr,shape(wr_local_grad2))
            ws_local_grad2 = reshape(ws,shape(ws_local_grad2))
            w_local_grad2 = reshape(w,shape(w_local_grad2))
            call local_grad2(wr_local_grad2,ws_local_grad2,w_local_grad2,n,e,dxm1,dytm1,ab,abmsh, &
      abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask, &
      baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp, &
      bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by, &
      bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg, &
      curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1, &
      dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag, &
      dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm12, &
      dxm3,dxtm1,dxtm12,dxtm3,dym1,dym12,dym3,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3, &
      eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0, &
      ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1, &
      g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode, &
      hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12, &
      iatm13,iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21, &
      ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae, &
      ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup, &
      ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr, &
      ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat, &
      ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab, &
      ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp, &
      ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer, &
      ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo,iftmsh,ifto,iftran, &
      ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup, &
      im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal, &
      ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31,ixtm12,ixtm13,ixtm21, &
      ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13,izm21,izm31,iztm12, &
      iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum,lglel,lochis,loglevel, &
      lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null,mpi_bottom, &
      mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted, &
      mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp, &
      ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx, &
      ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom, &
      ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc, &
      nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst, &
      nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax,nspro,nsskip, &
      nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot, &
      nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask,optlevel,orefle, &
      p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl, &
      pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz, &
      pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag, &
      prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl,rct,re2fle,re2off_b, &
      reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle,session,skpdat, &
      solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc, &
      tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl, &
      tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx, &
      tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean,tmltd,tmult,tmxmf, &
      tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs,tolht,tolhv,tolnl, &
      tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal, &
      tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz, &
      uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff,vdiff_e,vgradt1,vgradt1p, &
      vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld, &
      voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp, &
      vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1, &
      w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt,wgli,wgp,wmult,wx, &
      wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc, &
      yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
            wr = reshape(wr_local_grad2, shape(wr))
            ws = reshape(ws_local_grad2, shape(ws))
            w = reshape(w_local_grad2, shape(w))
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
            ur_local_grad2 = reshape(ur,shape(ur_local_grad2))
            us_local_grad2 = reshape(us,shape(us_local_grad2))
            u_local_grad2 = reshape(u,shape(u_local_grad2))
            call local_grad2(ur_local_grad2,us_local_grad2,u_local_grad2,n,e,dxm1,dxtm1,ab,abmsh, &
      abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask, &
      baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp, &
      bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by, &
      bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg, &
      curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1, &
      dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag, &
      dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm12, &
      dxm3,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3, &
      eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0, &
      ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1, &
      g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode, &
      hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12, &
      iatm13,iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21, &
      ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae, &
      ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup, &
      ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr, &
      ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat, &
      ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab, &
      ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp, &
      ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer, &
      ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo,iftmsh,ifto,iftran, &
      ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup, &
      im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal, &
      ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31,ixtm12,ixtm13,ixtm21, &
      ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13,izm21,izm31,iztm12, &
      iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum,lglel,lochis,loglevel, &
      lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null,mpi_bottom, &
      mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted, &
      mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp, &
      ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx, &
      ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom, &
      ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc, &
      nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst, &
      nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax,nspro,nsskip, &
      nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot, &
      nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask,optlevel,orefle, &
      p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl, &
      pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz, &
      pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag, &
      prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl,rct,re2fle,re2off_b, &
      reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle,session,skpdat, &
      solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc, &
      tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl, &
      tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx, &
      tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean,tmltd,tmult,tmxmf, &
      tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs,tolht,tolhv,tolnl, &
      tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal, &
      tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz, &
      uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff,vdiff_e,vgradt1,vgradt1p, &
      vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld, &
      voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp, &
      vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1, &
      w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt,wgli,wgp,wmult,wx, &
      wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc, &
      yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
            ur = reshape(ur_local_grad2, shape(ur))
            us = reshape(us_local_grad2, shape(us))
            u = reshape(u_local_grad2, shape(u))
            vr_local_grad2 = reshape(vr,shape(vr_local_grad2))
            vs_local_grad2 = reshape(vs,shape(vs_local_grad2))
            v_local_grad2 = reshape(v,shape(v_local_grad2))
            call local_grad2(vr_local_grad2,vs_local_grad2,v_local_grad2,n,e,dxm1,dxtm1,ab,abmsh, &
      abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t,b1mask,b2mask,b2p,b3mask, &
      baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx,bfxp,bfy,bfyp,bfz,bfzp, &
      bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz,bpmask,bq,bqp,bx,bxlag,by, &
      bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld,cpgrp,cr_h,cr_re2,csize,ctarg, &
      curve,d1,d1t,d2,da,dam1,dam12,dam3,dat,datm1,datm12,datm3,dcm1,dcm12,dcm3,dcount,dct,dctm1, &
      dctm12,dctm3,dg_face,dg_hndlx,dglg,dglgt,dlam,dmpfle,dp0thdt,drivc,dt,dtinit,dtinvm,dtlag, &
      dvdfh1,dvdfl2,dvdfl8,dvdfsm,dvnnh1,dvnnl2,dvnnl8,dvnnsm,dvprh1,dvprl2,dvprl8,dvprsm,dxm12, &
      dxm3,dxtm12,dxtm3,dym1,dym12,dym3,dytm1,dytm12,dytm3,dzm1,dzm12,dzm3,dztm1,dztm12,dztm3, &
      eface,eface1,eigaa,eigae,eigas,eigast,eigga,eigge,eiggs,eiggst,eskip,etalph,etimes,etims0, &
      ev1,ev2,ev3,exx1p,exx2p,exy1p,exy2p,exz1p,exz2p,fh_re2,filtertype,fintim,fldfle,fw,g1m1, &
      g2m1,g3m1,g4m1,g5m1,g6m1,gamma0,gcnnum,gednum,gedtyp,gllel,gllnid,group,gsh,gsh_fld,hcode, &
      hisfle,iajl1,iajl2,ialj1,ialj3,iam12,iam13,iam21,iam31,iatjl1,iatjl2,iatlj1,iatlj3,iatm12, &
      iatm13,iatm21,iatm31,ibcsts,icedg,icface,icm12,icm13,icm21,icm31,ictm12,ictm13,ictm21, &
      ictm31,idpss,idsess,ieact,iedge,iedgef,iedgfc,iesolv,if3d,if_full_pres,ifaa,ifadvc,ifae, &
      ifalgn,ifanl2,ifanls,ifas,ifast,ifaxis,ifaziv,ifbase,ifbcor,ifbo,ifchar,ifcons,ifcoup, &
      ifcvfld,ifcvode,ifcyclic,ifdeal,ifdg,ifdgfld,ifdiff,ifdp0dt,ifeppm,ifessr,ifexplvis,ifextr, &
      ifexvt,ifflow,iffmtin,ifga,ifge,ifgeom,ifgmsh3,ifgprnt,ifgs,ifgsh_fld_same,ifgst,ifheat, &
      ifield,ifintq,ifkeps,ifldmhd,iflmsc,iflmse,iflmsf,iflomach,ifmelt,ifmgrid,ifmhd,ifmoab, &
      ifmodel,ifmodp,ifmpiio,ifmscr,ifmseg,ifmsfc,ifmvbd,ifneknek,ifneknekm,ifnonl,ifnskp, &
      ifoutfld,ifpert,ifpo,ifprnt,ifprojfld,ifpsco,ifpso,ifqinp,ifreguo,ifrich,ifrsxy,ifrzer, &
      ifschclob,ifskip,ifsplit,ifssvt,ifstrs,ifstst,ifsurt,ifsync,iftgo,iftmsh,ifto,iftran, &
      ifusermv,ifuservp,ifvarp,ifvcor,ifvcoup,ifvo,ifvps,ifwcno,ifxyo,ifxyo_,iggl,igglt,igroup, &
      im1d,im1dt,imatie,imd1,imd1t,imesh,indx,initc,instep,invedg,iocomm,ioinfodmp,iostep,ipscal, &
      ipsco,irstim,irstt,irstv,isize,istep,ixcn,ixm12,ixm13,ixm21,ixm31,ixtm12,ixtm13,ixtm21, &
      ixtm31,iym12,iym13,iym21,iym31,iytm12,iytm13,iytm21,iytm31,izm12,izm13,izm21,izm31,iztm12, &
      iztm13,iztm21,iztm31,jacm1,jacm2,jacmi,jp,lastep,lcnnum,ldimr,lednum,lglel,lochis,loglevel, &
      lsize,lyap,matids,matindx,matype,maxmlt,mpi_argv_null,mpi_argvs_null,mpi_bottom, &
      mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted, &
      mpi_weights_empty,nab,nabmsh,nadvc,naxhm,nbbbb,nbd,nbdinp,nbso2,nbsol,ncall,ncccc,ncdtp, &
      ncmp,nconv,nconv_max,ncopy,ncrsl,ncvf,ndadd,ndddd,nddsl,ndg_facex,ndim,ndott,ndsmn,ndsmx, &
      ndsnd,ndsum,neact,nedg,neeee,nelfld,nelg,nelgt,nelgv,nelt,nelv,neslv,nfield,ngcomm,ngeom, &
      ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx,ngspcn,ngsped,ngsum,nhis,nhmhz,nid,ninter,ninv3,ninvc, &
      nio,nktonv,nmember,nmlinv,nmltd,nmxe,nmxh,nmxmf,nmxms,nmxnl,nmxp,nobj,node,node0,noffst, &
      nomlis,np,npert,nprep,npres,npscal,nrefle,nrout,nsett,nslvb,nsolv,nspmax,nspro,nsskip, &
      nsteps,nsyc,ntaubd,nu_star,nullpid,numbcs,numflu,numoth,numscn,numsed,nusbc,nvdss,nvtot, &
      nwal,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1,nz2,nz3,nzd,object,ocode,omask,optlevel,orefle, &
      p0th,param,parfle,path,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl, &
      pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz, &
      pi,pid,pinv3,pinvc,pm,pmask,pmd1,pmd1t,pmlag,pmltd,pmxmf,pmxms,pprep,ppres,pr,prelax,prlag, &
      prlagp,prp,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,qinteg,qtl,rct,re2fle,re2off_b, &
      reafle,restol,rname,rstim,rstt,rstv,rx,rxm1,rxm2,rym1,rym2,rzm1,rzm2,schfle,session,skpdat, &
      solver_type,sxm1,sxm2,sym1,sym2,szm1,szm2,t,t1x,t1y,t1z,t2x,t2y,t2z,ta2s2,tadc3,tadd2,tadvc, &
      tauss,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl, &
      tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,textsw,tgop,tgop1,tgop_sync,tgp2,tgsmn,tgsmx, &
      tgsum,thmhz,time,timef,timeio,tinit,tinv3,tinvc,tlag,tlagp,tmask,tmean,tmltd,tmult,tmxmf, &
      tmxms,tnrmh1,tnrml2,tnrml8,tnrmsm,tolabs,tolev,tolhdf,tolhe,tolhr,tolhs,tolht,tolhv,tolnl, &
      tolpdf,tolps,tolrel,tp,tprep,tpres,tproj,tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal, &
      tttstp,tusbc,tusfq,tvdss,twal,txm1,txm2,txnext,tym1,tym2,tzm1,tzm2,unr,uns,unt,unx,uny,unz, &
      uparam,usrdiv,v1mask,v1x,v1y,v1z,v2mask,v2x,v2y,v2z,v3mask,vdiff,vdiff_e,vgradt1,vgradt1p, &
      vgradt2,vgradt2p,vmean,vmult,vnekton,vnrmh1,vnrml2,vnrml8,vnrmsm,vnx,vny,vnz,volel,volfld, &
      voltm1,voltm2,volvm1,volvm2,vtrans,vx,vx_e,vxd,vxlag,vxlagp,vxp,vy,vy_e,vyd,vylag,vylagp, &
      vyp,vz,vz_e,vzd,vzlag,vzlagp,vzp,w1mask,w2am1,w2am2,w2am3,w2cm1,w2cm2,w2cm3,w2mask,w3m1, &
      w3m2,w3m3,w3mask,wam1,wam2,wam3,wdsize,wdsizi,wgl,wgl1,wgl2,wglg,wglgt,wgli,wgp,wmult,wx, &
      wxlag,wxm1,wxm2,wxm3,wy,wylag,wym1,wym2,wym3,wz,wzlag,wzm1,wzm2,wzm3,xc,xm1,xm2,xxth,yc, &
      yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
            vr = reshape(vr_local_grad2, shape(vr))
            vs = reshape(vs_local_grad2, shape(vs))
            v = reshape(v_local_grad2, shape(v))
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


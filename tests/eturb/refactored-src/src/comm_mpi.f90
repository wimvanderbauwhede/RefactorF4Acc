! ---------------------------------------------------------------------
module singleton_module_src_comm_mpi

      use singleton_module_src_subs1
      use singleton_module_src_papi
      use singleton_module_src_singlmesh
      use singleton_module_src_mpi_dummy
      use singleton_module_src_math
contains

      subroutine gop(x,w,op,n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1, &
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
!      Global vector commutative operation
! 
!      Timer variables
! 
      implicit none
      real, dimension(1:n) :: w_copy
      integer, dimension(1:n) :: w_mpi_allreduce
      real, dimension(1:n) :: x_copy
      integer, dimension(1:n) :: x_mpi_allreduce
      integer, parameter :: lorder=3
      integer, parameter :: lorder2=max(1,lorder-2)
      integer, parameter :: lx1=8
      integer, parameter :: lx2=lx1-2
      integer, parameter :: lxq=lx2
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
      real :: dt
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
      integer :: icall
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
      integer :: nab
      integer :: nabmsh
      integer :: nbd
      integer :: nbdinp
      integer :: ncmp
      integer :: nconv
      integer :: nconv_max
      integer :: ndg_facex
      integer :: ndim
      integer :: neact
      integer, dimension(1:3) :: nedg
      integer, intent(In) :: nekcomm
      integer :: nekgroup
      integer, intent(In) :: nekreal
      integer, dimension(0:ldimt1) :: nelfld
      integer, dimension(0:ldimt1) :: nelg
      integer :: nelgt
      integer :: nelgv
      integer :: nelt
      integer :: nelv
      integer :: nfield
      integer, dimension(1:2,0:ldimt1) :: ngcomm
      integer :: ngeom
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer :: nhis
      integer, intent(In) :: nid
      integer :: ninter
      integer :: nio
      integer :: nktonv
      integer, dimension(1:maxobj) :: nmember
      integer, dimension(1:6) :: nmlinv
      integer :: nmxe
      integer :: nmxh
      integer :: nmxnl
      integer :: nmxp
      integer :: nobj
      integer :: node
      integer :: node0
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer, dimension(1:2,1:3) :: nomlis
      integer :: np
      integer :: npert
      integer :: npscal
      character(len=132) :: nrefle
      integer, dimension(0:ldimt1) :: nspmax
      integer :: nsskip
      integer :: nsteps
      integer :: ntaubd
      real :: nu_star
      integer :: nullpid
      integer :: numbcs
      integer :: numflu
      integer :: numoth
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer(kind=8) :: nvtot
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
      real :: pi
      integer :: pid
      real, dimension(1:lbx2,1:lby2,1:lbz2,1:lbelv) :: pm
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pmask
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t
      real, dimension(1:lbx2*lby2*lbz2*lbelv,1:lorder2) :: pmlag
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real :: prelax
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv,1:lorder2) :: prlag
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lorder2,1:lpert) :: prlagp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lpert) :: prp
      real, dimension(1:ldimt3,1:maxobj) :: qinteg
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: qtl
      character(len=132) :: re2fle
      integer(kind=8) :: re2off_b
      character(len=132) :: reafle
      real, dimension(0:ldimt1) :: restol
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
      real, dimension(1:ldimt1) :: tauss
      character(len=40), dimension(1:100,1:2) :: textsw
      real :: time
      real :: timef
      real :: timeio
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1,1:ldimt) :: tlag
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lorder-1,1:lpert) :: tlagp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmask
      real, dimension(1:ldimt) :: tmean
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmult
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
      integer :: ierr
      real(kind=8) :: tmxmf
      real(kind=8) :: tmxms
      real(kind=8) :: tdsum
      real(kind=8) :: taxhm
      real(kind=8) :: tcopy
      real(kind=8) :: tinvc
      real(kind=8) :: tinv3
      real(kind=8) :: tinit
      real(kind=8) :: tadc3
      real(kind=8) :: tcol3
      real(kind=8) :: ta2s2
      real(kind=8) :: tcol2
      real(kind=8) :: tadd2
! 
      real(kind=8) :: tsolv
      real(kind=8) :: tgsum
      real(kind=8) :: tdsnd
      real(kind=8) :: tdadd
      real(kind=8) :: tcdtp
      real(kind=8) :: tmltd
      real(kind=8) :: tprep
      real(kind=8) :: tpres
      real(kind=8) :: thmhz
      real(kind=8), intent(Out) :: tgop
      real(kind=8) :: tgop1
      real(kind=8) :: tdott
      real(kind=8) :: tbsol
      real(kind=8) :: tbso2
      real(kind=8) :: tsett
      real(kind=8) :: tslvb
      real(kind=8) :: tusbc
      real(kind=8) :: tddsl
      real(kind=8) :: tcrsl
      real(kind=8) :: tdsmx
      real(kind=8) :: tdsmn
      real(kind=8) :: tgsmn
      real(kind=8) :: tgsmx
      real(kind=8) :: teslv
      real(kind=8) :: tbbbb
      real(kind=8) :: tcccc
      real(kind=8) :: tdddd
      real(kind=8) :: teeee
      real(kind=8) :: tvdss
      real(kind=8) :: tschw
      real(kind=8) :: tadvc
      real(kind=8) :: tspro
      real(kind=8) :: tgop_sync
      real(kind=8) :: tsyc
      real(kind=8) :: twal
      real(kind=8) :: tgp2
      real(kind=8) :: tcvf
      real(kind=8) :: tproj
      real(kind=8) :: tusfq
! 
      integer :: nmxmf
      integer :: nmxms
      integer :: ndsum
      integer :: naxhm
      integer :: ncopy
      integer :: ninvc
      integer :: ninv3
! 
      integer :: nsolv
      integer :: ngsum
      integer :: ndsnd
      integer :: ndadd
      integer :: ncdtp
      integer :: nmltd
      integer :: nprep
      integer :: npres
      integer :: nhmhz
      integer, intent(InOut) :: ngop
      integer :: ngop1
      integer :: ndott
      integer :: nbsol
      integer :: nbso2
      integer :: nsett
      integer :: nslvb
      integer :: nusbc
      integer :: nddsl
      integer :: ncrsl
      integer :: ndsmx
      integer :: ndsmn
      integer :: ngsmn
      integer :: ngsmx
      integer :: neslv
      integer :: nbbbb
      integer :: ncccc
      integer :: ndddd
      integer :: neeee
      integer :: nvdss
      integer :: nadvc
      integer :: nspro
      integer :: ngop_sync
      integer :: nsyc
      integer :: nwal
      integer :: ngp2
      integer :: ncvf
!    
      real(kind=8) :: pmxmf
      real(kind=8) :: pmxms
      real(kind=8) :: pdsum
      real(kind=8) :: paxhm
      real(kind=8) :: pcopy
      real(kind=8) :: pinvc
      real(kind=8) :: pinv3
      real(kind=8) :: psolv
      real(kind=8) :: pgsum
      real(kind=8) :: pdsnd
      real(kind=8) :: pdadd
      real(kind=8) :: pcdtp
      real(kind=8) :: pmltd
      real(kind=8) :: pprep
      real(kind=8) :: ppres
      real(kind=8) :: phmhz
      real(kind=8) :: pgop
      real(kind=8) :: pgop1
      real(kind=8) :: pdott
      real(kind=8) :: pbsol
      real(kind=8) :: pbso2
      real(kind=8) :: psett
      real(kind=8) :: pslvb
      real(kind=8) :: pusbc
      real(kind=8) :: pddsl
      real(kind=8) :: pcrsl
      real(kind=8) :: pdsmx
      real(kind=8) :: pdsmn
      real(kind=8) :: pgsmn
      real(kind=8) :: pgsmx
      real(kind=8) :: peslv
      real(kind=8) :: pbbbb
      real(kind=8) :: pcccc
      real(kind=8) :: pdddd
      real(kind=8) :: peeee
      real(kind=8) :: pvdss
      real(kind=8) :: pspro
      real(kind=8) :: pgop_sync
      real(kind=8) :: psyc
      real(kind=8) :: pwal
      real(kind=8) :: pgp2
      real(kind=8) :: etime1
      real(kind=8) :: etime2
      real(kind=8) :: etime0
      real(kind=8) :: gtime1
      real(kind=8) :: tscrtch
! 
! 
      real(kind=8) :: etimes
      real(kind=8) :: ttotal
      real(kind=8) :: tttstp
      real(kind=8) :: etims0
      real(kind=8) :: ttime
! 
      integer :: icalld
      save    icalld
      data icalld / 0 / 
      logical, intent(In) :: ifsync
      integer, parameter :: ompi_major_version=4
      integer, parameter :: ompi_minor_version=0
      integer, parameter :: ompi_release_version=1
      integer, parameter :: mpi_integer_kind=4
      integer, parameter :: mpi_address_kind=8
      integer, parameter :: mpi_offset_kind=8
      integer, parameter :: mpi_count_kind=8
      integer, parameter :: mpi_status_size=6
      integer, parameter :: mpi_max_processor_name=256-1
      integer, parameter :: mpi_max_error_string=256-1
      integer, parameter :: mpi_max_object_name=64-1
      integer, parameter :: mpi_max_library_version_string=256-1
      integer, parameter :: mpi_max_info_key=36-1
      integer, parameter :: mpi_max_info_val=256-1
      integer, parameter :: mpi_max_port_name=1024-1
      integer, parameter :: mpi_max_datarep_string=128-1
      logical, parameter :: mpi_subarrays_supported=.false.
      logical, parameter :: mpi_async_protects_nonblocking=.false.
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
      integer, parameter :: mpi_appnum=4
      integer, parameter :: mpi_bsend_overhead=128
      integer, parameter :: mpi_cart=1
      integer, parameter :: mpi_combiner_contiguous=2
      integer, parameter :: mpi_combiner_darray=13
      integer, parameter :: mpi_combiner_dup=1
      integer, parameter :: mpi_combiner_f90_complex=15
      integer, parameter :: mpi_combiner_f90_integer=16
      integer, parameter :: mpi_combiner_f90_real=14
      integer, parameter :: mpi_combiner_hindexed=8
      integer, parameter :: mpi_combiner_hindexed_block=18
      integer, parameter :: mpi_combiner_hindexed_integer=7
      integer, parameter :: mpi_combiner_hvector=5
      integer, parameter :: mpi_combiner_hvector_integer=4
      integer, parameter :: mpi_combiner_indexed=6
      integer, parameter :: mpi_combiner_indexed_block=9
      integer, parameter :: mpi_combiner_named=0
      integer, parameter :: mpi_combiner_resized=17
      integer, parameter :: mpi_combiner_struct=11
      integer, parameter :: mpi_combiner_struct_integer=10
      integer, parameter :: mpi_combiner_subarray=12
      integer, parameter :: mpi_combiner_vector=3
      integer, parameter :: mpi_comm_type_shared=0
      integer, parameter :: mpi_congruent=1
      integer, parameter :: mpi_distribute_block=0
      integer, parameter :: mpi_distribute_cyclic=1
      integer, parameter :: mpi_distribute_dflt_darg=-1
      integer, parameter :: mpi_distribute_none=2
      integer, parameter :: mpi_dist_graph=3
      integer, parameter :: mpi_error=3
      integer, parameter :: mpi_err_access=20
      integer, parameter :: mpi_err_amode=21
      integer, parameter :: mpi_err_arg=13
      integer, parameter :: mpi_err_assert=22
      integer, parameter :: mpi_err_bad_file=23
      integer, parameter :: mpi_err_base=24
      integer, parameter :: mpi_err_buffer=1
      integer, parameter :: mpi_err_comm=5
      integer, parameter :: mpi_err_conversion=25
      integer, parameter :: mpi_err_count=2
      integer, parameter :: mpi_err_dims=12
      integer, parameter :: mpi_err_disp=26
      integer, parameter :: mpi_err_dup_datarep=27
      integer, parameter :: mpi_err_file=30
      integer, parameter :: mpi_err_file_exists=28
      integer, parameter :: mpi_err_file_in_use=29
      integer, parameter :: mpi_err_group=9
      integer, parameter :: mpi_err_info=34
      integer, parameter :: mpi_err_info_key=31
      integer, parameter :: mpi_err_info_nokey=32
      integer, parameter :: mpi_err_info_value=33
      integer, parameter :: mpi_err_intern=17
      integer, parameter :: mpi_err_in_status=18
      integer, parameter :: mpi_err_io=35
      integer, parameter :: mpi_err_keyval=36
      integer, parameter :: mpi_err_lastcode=92
      integer, parameter :: mpi_err_locktype=37
      integer, parameter :: mpi_err_name=38
      integer, parameter :: mpi_err_not_same=40
      integer, parameter :: mpi_err_no_mem=39
      integer, parameter :: mpi_err_no_space=41
      integer, parameter :: mpi_err_no_such_file=42
      integer, parameter :: mpi_err_op=10
      integer, parameter :: mpi_err_other=16
      integer, parameter :: mpi_err_pending=19
      integer, parameter :: mpi_err_port=43
      integer, parameter :: mpi_err_quota=44
      integer, parameter :: mpi_err_rank=6
      integer, parameter :: mpi_err_read_only=45
      integer, parameter :: mpi_err_request=7
      integer, parameter :: mpi_err_rma_attach=69
      integer, parameter :: mpi_err_rma_conflict=46
      integer, parameter :: mpi_err_rma_flavor=70
      integer, parameter :: mpi_err_rma_range=68
      integer, parameter :: mpi_err_rma_shared=71
      integer, parameter :: mpi_err_rma_sync=47
      integer, parameter :: mpi_err_root=8
      integer, parameter :: mpi_err_service=48
      integer, parameter :: mpi_err_size=49
      integer, parameter :: mpi_err_spawn=50
      integer, parameter :: mpi_err_tag=4
      integer, parameter :: mpi_err_topology=11
      integer, parameter :: mpi_err_truncate=15
      integer, parameter :: mpi_err_type=3
      integer, parameter :: mpi_err_unknown=14
      integer, parameter :: mpi_err_unsupported_datarep=51
      integer, parameter :: mpi_err_unsupported_operation=52
      integer, parameter :: mpi_err_win=53
      integer, parameter :: mpi_graph=2
      integer, parameter :: mpi_host=1
      integer, parameter :: mpi_ident=0
      integer, parameter :: mpi_io=2
      integer, parameter :: mpi_keyval_invalid=-1
      integer, parameter :: mpi_lastusedcode=5
      integer, parameter :: mpi_lock_exclusive=1
      integer, parameter :: mpi_lock_shared=2
      integer, parameter :: mpi_mode_nocheck=1
      integer, parameter :: mpi_mode_noprecede=2
      integer, parameter :: mpi_mode_noput=4
      integer, parameter :: mpi_mode_nostore=8
      integer, parameter :: mpi_mode_nosucceed=16
      integer, parameter :: mpi_order_c=0
      integer, parameter :: mpi_order_fortran=1
      integer, parameter :: mpi_proc_null=-2
      integer, parameter :: mpi_root=-4
      integer, parameter :: mpi_similar=2
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_subversion=1
      integer, parameter :: mpi_success=0
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_tag_ub=0
      integer, parameter :: mpi_thread_funneled=1
      integer, parameter :: mpi_thread_multiple=3
      integer, parameter :: mpi_thread_serialized=2
      integer, parameter :: mpi_thread_single=0
      integer, parameter :: mpi_typeclass_complex=3
      integer, parameter :: mpi_typeclass_integer=1
      integer, parameter :: mpi_typeclass_real=2
      integer, parameter :: mpi_t_err_cannot_init=56
      integer, parameter :: mpi_t_err_cvar_set_never=64
      integer, parameter :: mpi_t_err_cvar_set_not_now=63
      integer, parameter :: mpi_t_err_invalid=72
      integer, parameter :: mpi_t_err_invalid_handle=59
      integer, parameter :: mpi_t_err_invalid_index=57
      integer, parameter :: mpi_t_err_invalid_item=58
      integer, parameter :: mpi_t_err_invalid_session=62
      integer, parameter :: mpi_t_err_memory=54
      integer, parameter :: mpi_t_err_not_initialized=55
      integer, parameter :: mpi_t_err_out_of_handles=60
      integer, parameter :: mpi_t_err_out_of_sessions=61
      integer, parameter :: mpi_t_err_pvar_no_atomic=67
      integer, parameter :: mpi_t_err_pvar_no_startstop=65
      integer, parameter :: mpi_t_err_pvar_no_write=66
      integer, parameter :: mpi_undefined=-32766
      integer, parameter :: mpi_unequal=3
      integer, parameter :: mpi_universe_size=6
      integer, parameter :: mpi_version=3
      integer, parameter :: mpi_win_base=7
      integer, parameter :: mpi_win_create_flavor=10
      integer, parameter :: mpi_win_disp_unit=9
      integer, parameter :: mpi_win_flavor_allocate=2
      integer, parameter :: mpi_win_flavor_create=1
      integer, parameter :: mpi_win_flavor_dynamic=3
      integer, parameter :: mpi_win_flavor_shared=4
      integer, parameter :: mpi_win_model=11
      integer, parameter :: mpi_win_separate=1
      integer, parameter :: mpi_win_size=8
      integer, parameter :: mpi_win_unified=0
      integer, parameter :: mpi_wtime_is_global=3
      integer, parameter :: ompi_comm_type_board=8
      integer, parameter :: ompi_comm_type_cluster=11
      integer, parameter :: ompi_comm_type_core=2
      integer, parameter :: ompi_comm_type_cu=10
      integer, parameter :: ompi_comm_type_host=9
      integer, parameter :: ompi_comm_type_hwthread=1
      integer, parameter :: ompi_comm_type_l1cache=3
      integer, parameter :: ompi_comm_type_l2cache=4
      integer, parameter :: ompi_comm_type_l3cache=5
      integer, parameter :: ompi_comm_type_node=0
      integer, parameter :: ompi_comm_type_numa=7
      integer, parameter :: ompi_comm_type_socket=6
      integer, parameter :: mpi_2complex=26
      integer, parameter :: mpi_2double_complex=27
      integer, parameter :: mpi_2double_precision=24
      integer, parameter :: mpi_2int=52
      integer, parameter :: mpi_2integer=25
      integer, parameter :: mpi_2real=23
      integer, parameter :: mpi_aint=66
      integer, parameter :: mpi_band=6
      integer, parameter :: mpi_bor=8
      integer, parameter :: mpi_bxor=10
      integer, parameter :: mpi_byte=1
      integer, parameter :: mpi_char=34
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_comm_null=2
      integer, parameter :: mpi_comm_self=1
      integer, parameter :: mpi_comm_world=0
      integer, parameter :: mpi_complex=18
      integer, parameter :: mpi_complex16=20
      integer, parameter :: mpi_complex32=21
      integer, parameter :: mpi_complex8=19
      integer, parameter :: mpi_count=72
      integer, parameter :: mpi_cxx_bool=54
      integer, parameter :: mpi_cxx_complex=55
      integer, parameter :: mpi_cxx_double_complex=56
      integer, parameter :: mpi_cxx_float_complex=55
      integer, parameter :: mpi_cxx_long_double_complex=57
      integer, parameter :: mpi_c_bool=68
      integer, parameter :: mpi_c_complex=69
      integer, parameter :: mpi_c_double_complex=70
      integer, parameter :: mpi_c_float_complex=69
      integer, parameter :: mpi_c_long_double_complex=71
      integer, parameter :: mpi_datatype_null=0
      integer, parameter :: mpi_double=46
      integer, parameter :: mpi_double_complex=22
      integer, parameter :: mpi_double_int=49
      integer, parameter :: mpi_double_precision=17
      integer, parameter :: mpi_errhandler_null=0
      integer, parameter :: mpi_errors_are_fatal=1
      integer, parameter :: mpi_errors_return=2
      integer, parameter :: mpi_float=45
      integer, parameter :: mpi_float_int=48
      integer, parameter :: mpi_group_empty=1
      integer, parameter :: mpi_group_null=0
      integer, parameter :: mpi_info_env=1
      integer, parameter :: mpi_info_null=0
      integer, parameter :: mpi_int=39
      integer, parameter :: mpi_int16_t=60
      integer, parameter :: mpi_int32_t=62
      integer, parameter :: mpi_int64_t=64
      integer, parameter :: mpi_int8_t=58
      integer, parameter :: mpi_integer=7
      integer, parameter :: mpi_integer1=8
      integer, parameter :: mpi_integer16=12
      integer, parameter :: mpi_integer2=9
      integer, parameter :: mpi_integer4=10
      integer, parameter :: mpi_integer8=11
      integer, parameter :: mpi_land=5
      integer, parameter :: mpi_lb=4
      integer, parameter :: mpi_logical=6
      integer, parameter :: mpi_logical1=29
      integer, parameter :: mpi_logical2=30
      integer, parameter :: mpi_logical4=31
      integer, parameter :: mpi_logical8=32
      integer, parameter :: mpi_long=41
      integer, parameter :: mpi_long_double=47
      integer, parameter :: mpi_long_double_int=50
      integer, parameter :: mpi_long_int=51
      integer, parameter :: mpi_long_long=43
      integer, parameter :: mpi_long_long_int=43
      integer, parameter :: mpi_lor=7
      integer, parameter :: mpi_lxor=9
      integer, parameter :: mpi_max=1
      integer, parameter :: mpi_maxloc=11
      integer, parameter :: mpi_message_no_proc=1
      integer, parameter :: mpi_message_null=0
      integer, parameter :: mpi_min=2
      integer, parameter :: mpi_minloc=12
      integer, parameter :: mpi_no_op=14
      integer, parameter :: mpi_offset=67
      integer, parameter :: mpi_op_null=0
      integer, parameter :: mpi_packed=2
      integer, parameter :: mpi_prod=4
      integer, parameter :: mpi_real=13
      integer, parameter :: mpi_real16=16
      integer, parameter :: mpi_real2=28
      integer, parameter :: mpi_real4=14
      integer, parameter :: mpi_real8=15
      integer, parameter :: mpi_replace=13
      integer, parameter :: mpi_request_null=0
      integer, parameter :: mpi_short=37
      integer, parameter :: mpi_short_int=53
      integer, parameter :: mpi_signed_char=36
      integer, parameter :: mpi_sum=3
      integer, parameter :: mpi_ub=3
      integer, parameter :: mpi_uint16_t=61
      integer, parameter :: mpi_uint32_t=63
      integer, parameter :: mpi_uint64_t=65
      integer, parameter :: mpi_uint8_t=59
      integer, parameter :: mpi_unsigned=40
      integer, parameter :: mpi_unsigned_char=35
      integer, parameter :: mpi_unsigned_long=42
      integer, parameter :: mpi_unsigned_long_long=44
      integer, parameter :: mpi_unsigned_short=38
      integer, parameter :: mpi_wchar=33
      integer, parameter :: mpi_win_null=0
      integer, parameter :: mpi_mode_append=128
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_delete_on_close=16
      integer, parameter :: mpi_mode_excl=64
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_rdwr=8
      integer, parameter :: mpi_mode_sequential=256
      integer, parameter :: mpi_mode_unique_open=32
      integer, parameter :: mpi_mode_wronly=4
      integer, parameter :: mpi_seek_cur=602
      integer, parameter :: mpi_seek_end=604
      integer, parameter :: mpi_seek_set=600
      integer, parameter :: mpi_displacement_current=-54278278
      integer, parameter :: mpi_file_null=0
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2014 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2017      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 
!  Do ***not*** copy this file to the directory where your Fortran
!  fortran application is compiled unless it is absolutely necessary!  Most
!  modern Fortran compilers now support the -I command line flag, which
!  tells the compiler where to find .h files (specifically, this one).  For
!  example:
! 
!       shell$ mpifort foo.f -o foo -I$OMPI_HOME/include
! 
!  will probably do the trick (assuming that you have set OMPI_HOME
!  properly).
! 
!  That being said, OMPI's "mpifort" wrapper compiler should
!  automatically include the -I option for you.  The following command
!  should be equivalent to the command listed above:
! 
!       shell$ mpifort foo.f -o foo
! 
!  You should not copy this file to your local directory because it is
!  possible that this file will be changed between versions of Open MPI.
!  Indeed, this mpif.h is incompatible with the mpif.f of other
!  implementations of MPI.  Using this mpif.h with other implementations
!  of MPI, or with other versions of Open MPI will result in undefined
!  behavior (to include incorrect results, segmentation faults,
!  unexplainable "hanging" in your application, etc.).  Always use the
!  -I command line option instead (or let mpifort do it for you).
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!       include 'mpif-config.h'
!       include 'mpif-constants.h'
!       include 'mpif-handles.h'
!       include 'mpif-io-constants.h'
!       include 'mpif-io-handles.h'
!       include 'mpif-externals.h'
!       include 'mpif-sentinels.h'
!       include 'mpif-sizeof.h'
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
!  Copyright (c) 2013      Los Alamos National Security, LLC. All rights
!                          reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      This file contains the output from configure that is relevant for
!      Fortran applications and a few values that are necessary to
!      compile the Fortran modules (e.g., MPI_STATUS_SIZE).
! 
! 
!      OMPI version
!      This file is generated from configure; do not edit it manually.
! 
! 
!      Kind parameters
! 
! 
!      Miscellaneous constants
! 
! 
!      Configurable length constants
! 
! 
!  MPI F08 conformance
! 
      ! hard-coded for .false. for now
      ! hard-coded for .false. for now
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      These "external" statements are specific to the MPI mpif.h
!      interface (and are toxic to the MPI module interfaces),.
! 
      external mpi_null_copy_fn, mpi_null_delete_fn
      external mpi_comm_null_copy_fn, mpi_comm_null_delete_fn
      external mpi_type_null_copy_fn, mpi_type_null_delete_fn
      external mpi_dup_fn, mpi_comm_dup_fn, mpi_type_dup_fn
      external mpi_win_null_copy_fn
      external mpi_win_null_delete_fn
      external mpi_win_dup_fn
!      Note that MPI_CONVERSION_FN_NULL is a "constant" (it is only ever
!      checked for comparison; it is never invoked), but it is passed as
!      a function pointer (to MPI_REGISTER_DATAREP) and therefore must be
!      the same size/type.  It is therefore external'ed here, and not
!      defined with an integer value in mpif-common.h.
      external mpi_conversion_fn_null
! 
!      double precision functions
! 
      external mpi_wtime, mpi_wtick , pmpi_wtick, pmpi_wtime
      integer, parameter :: lorder=3
      integer, parameter :: lorder2=max(1,lorder-2)
      integer, parameter :: lx1=8
      integer, parameter :: lx2=lx1-2
      integer, parameter :: lxq=lx2
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
      real :: dt
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
      integer :: icall
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
      integer :: nab
      integer :: nabmsh
      integer :: nbd
      integer :: nbdinp
      integer :: ncmp
      integer :: nconv
      integer :: nconv_max
      integer :: ndg_facex
      integer :: ndim
      integer :: neact
      integer, dimension(1:3) :: nedg
      integer, intent(In) :: nekcomm
      integer :: nekgroup
      integer, intent(In) :: nekreal
      integer, dimension(0:ldimt1) :: nelfld
      integer, dimension(0:ldimt1) :: nelg
      integer :: nelgt
      integer :: nelgv
      integer :: nelt
      integer :: nelv
      integer :: nfield
      integer, dimension(1:2,0:ldimt1) :: ngcomm
      integer :: ngeom
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer :: nhis
      integer, intent(In) :: nid
      integer :: ninter
      integer :: nio
      integer :: nktonv
      integer, dimension(1:maxobj) :: nmember
      integer, dimension(1:6) :: nmlinv
      integer :: nmxe
      integer :: nmxh
      integer :: nmxnl
      integer :: nmxp
      integer :: nobj
      integer :: node
      integer :: node0
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer, dimension(1:2,1:3) :: nomlis
      integer :: np
      integer :: npert
      integer :: npscal
      character(len=132) :: nrefle
      integer, dimension(0:ldimt1) :: nspmax
      integer :: nsskip
      integer :: nsteps
      integer :: ntaubd
      real :: nu_star
      integer :: nullpid
      integer :: numbcs
      integer :: numflu
      integer :: numoth
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer(kind=8) :: nvtot
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
      real :: pi
      integer :: pid
      real, dimension(1:lbx2,1:lby2,1:lbz2,1:lbelv) :: pm
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pmask
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t
      real, dimension(1:lbx2*lby2*lbz2*lbelv,1:lorder2) :: pmlag
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real :: prelax
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv,1:lorder2) :: prlag
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lorder2,1:lpert) :: prlagp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lpert) :: prp
      real, dimension(1:ldimt3,1:maxobj) :: qinteg
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: qtl
      character(len=132) :: re2fle
      integer(kind=8) :: re2off_b
      character(len=132) :: reafle
      real, dimension(0:ldimt1) :: restol
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
      real, dimension(1:ldimt1) :: tauss
      character(len=40), dimension(1:100,1:2) :: textsw
      real :: time
      real :: timef
      real :: timeio
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1,1:ldimt) :: tlag
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lorder-1,1:lpert) :: tlagp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmask
      real, dimension(1:ldimt) :: tmean
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmult
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
      integer :: ierr
      real(kind=8) :: mpi_wtick
      real(kind=8) :: pmpi_wtick
      real(kind=8) :: pmpi_wtime
! 
!      address integer functions
! 
      external mpi_aint_add, mpi_aint_diff
      integer :: mpi_aint_add
      integer :: mpi_aint_diff
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      All of these types were chosen with care to match the types of
!      their corresponding C variables.  Do not arbitrarily change
!      their types without also updating:
! 
!      - the "mpi" module bindings
!      - the "mpi_f08" module bindings
!      - ompi/mpi/fortran/base/gen-mpi-mangling.pl
! 
!      MPI_BOTTOM is only used where choice buffers can be used (meaning
!      that we already have overloaded F90 bindings for all available
!      types), so any type is fine.
      integer :: mpi_bottom
!      MPI_IN_PLACE has the same rationale as MPI_BOTTOM.
      integer :: mpi_in_place
!      Making MPI_ARGV_NULL be the same type as the parameter that is
!      exepected in the F90 binding for MPI_COMM_SPAWN means that we
!      don't need another interface for MPI_COMM_SPAWN.
      character, dimension(1:1) :: mpi_argv_null
!      Ditto for MPI_ARGVS_NULL / MPI_COMM_SPAWN_MULTIPLE.
      character, dimension(1:1,1:1) :: mpi_argvs_null
!      MPI_ERRCODES_IGNORE has similar rationale to MPI_ARGV_NULL.  The
!      F77 functions are all smart enough to check that the errcodes
!      parameter is not ERRCODES_IGNORE before assigning values into it
!      (hence, the fact that this is an array of only 1 element does not
!      matter -- we'll never overrun it because we never assign values
!      into it).
      integer, dimension(1:1) :: mpi_errcodes_ignore
!      MPI_STATUS_IGNORE has similar rationale to MPI_ERRCODES_IGNORE.
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
!      Ditto for MPI_STATUSES_IGNORE
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
!      Ditto for MPI_UNWEIGHTED
      integer, dimension(1:1) :: mpi_unweighted
!      Ditto for MPI_WEIGHTS_EMPTY
      integer, dimension(1:1) :: mpi_weights_empty
!  -*- f90 -*-
!  WARNING: This is a generated file!  Edits will be lost!
! 
!  Copyright (c) 2014 Cisco Systems, Inc.  All rights reserved.
! $COPYRIGHT$
! 
!  This file was generated by gen-mpi-sizeof.pl for all the MPI_SIZEOF
!  interface possibilities for intrinsic types.  Once TS 29113 is
!  supported in all compilers, we can simply have *one* procedure for
!  each type and use dimension(..) to indicate scalars+all array ranks.
!  But until more compilers support this, we simply generate a
!  procedure for scalars and all possible ranks in an attempt to
!  support lots of Fortran compilers.
      interface mpi_sizeof
      real, dimension(1:n), intent(InOut) :: x
      real, dimension(1:n), intent(InOut) :: w
      character(len=3), intent(In) :: op
      call nekgsync(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place, &
      mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nekcomm,nekgroup, &
      nekreal,nid,np)
#ifdef TIMER
      if (icalld == 0) then
        tgop =0.0d0
        ngop =0
        icalld=1
      endif
      ngop = ngop + 1
      etime1 = dnekclock(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place, &
      mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty)
#endif
! 
      if (op == '+  ') then
         x_mpi_allreduce = int(reshape(x,shape(x_mpi_allreduce)), 4)
         w_mpi_allreduce = int(reshape(w,shape(w_mpi_allreduce)), 4)
         call mpi_allreduce(x_mpi_allreduce,w_mpi_allreduce,n,nekreal,mpi_sum,nekcomm,ierr)

         x = real(reshape(x_mpi_allreduce, shape(x),4)
         w = real(reshape(w_mpi_allreduce, shape(w),4)
      elseif (op == 'M  ') then
         x_mpi_allreduce = int(reshape(x,shape(x_mpi_allreduce)), 4)
         w_mpi_allreduce = int(reshape(w,shape(w_mpi_allreduce)), 4)
         call mpi_allreduce(x_mpi_allreduce,w_mpi_allreduce,n,nekreal,mpi_max,nekcomm,ierr)

         x = real(reshape(x_mpi_allreduce, shape(x),4)
         w = real(reshape(w_mpi_allreduce, shape(w),4)
      elseif (op == 'm  ') then
         x_mpi_allreduce = int(reshape(x,shape(x_mpi_allreduce)), 4)
         w_mpi_allreduce = int(reshape(w,shape(w_mpi_allreduce)), 4)
         call mpi_allreduce(x_mpi_allreduce,w_mpi_allreduce,n,nekreal,mpi_min,nekcomm,ierr)

         x = real(reshape(x_mpi_allreduce, shape(x),4)
         w = real(reshape(w_mpi_allreduce, shape(w),4)
      elseif (op == '*  ') then
         x_mpi_allreduce = int(reshape(x,shape(x_mpi_allreduce)), 4)
         w_mpi_allreduce = int(reshape(w,shape(w_mpi_allreduce)), 4)
         call mpi_allreduce(x_mpi_allreduce,w_mpi_allreduce,n,nekreal,mpi_prod,nekcomm,ierr)

         x = real(reshape(x_mpi_allreduce, shape(x),4)
         w = real(reshape(w_mpi_allreduce, shape(w),4)
      else
         write(6,*) nid,' OP ',op,' not supported.  ABORT in GOP.'
         call exitt(ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t, &
      b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx, &
      bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz, &
      bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld, &
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
      endif
      x_copy = reshape(x,shape(x_copy))
      w_copy = reshape(w,shape(w_copy))
      call copy(x_copy,w_copy,n)

      x = reshape(x_copy, shape(x))
      w = reshape(w_copy, shape(w))
#ifdef TIMER
      tgop  = tgop+(dnekclock(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore, &
      mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty)-etime1)
#endif
      return
      end subroutine gop
      subroutine igop(x,w,op,n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1, &
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
! 
!      Global vector commutative operation
! 
      implicit none
      integer, parameter :: ompi_major_version=4
      integer, parameter :: ompi_minor_version=0
      integer, parameter :: ompi_release_version=1
      integer, parameter :: mpi_integer_kind=4
      integer, parameter :: mpi_address_kind=8
      integer, parameter :: mpi_offset_kind=8
      integer, parameter :: mpi_count_kind=8
      integer, parameter :: mpi_status_size=6
      integer, parameter :: mpi_max_processor_name=256-1
      integer, parameter :: mpi_max_error_string=256-1
      integer, parameter :: mpi_max_object_name=64-1
      integer, parameter :: mpi_max_library_version_string=256-1
      integer, parameter :: mpi_max_info_key=36-1
      integer, parameter :: mpi_max_info_val=256-1
      integer, parameter :: mpi_max_port_name=1024-1
      integer, parameter :: mpi_max_datarep_string=128-1
      logical, parameter :: mpi_subarrays_supported=.false.
      logical, parameter :: mpi_async_protects_nonblocking=.false.
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
      integer, parameter :: mpi_appnum=4
      integer, parameter :: mpi_bsend_overhead=128
      integer, parameter :: mpi_cart=1
      integer, parameter :: mpi_combiner_contiguous=2
      integer, parameter :: mpi_combiner_darray=13
      integer, parameter :: mpi_combiner_dup=1
      integer, parameter :: mpi_combiner_f90_complex=15
      integer, parameter :: mpi_combiner_f90_integer=16
      integer, parameter :: mpi_combiner_f90_real=14
      integer, parameter :: mpi_combiner_hindexed=8
      integer, parameter :: mpi_combiner_hindexed_block=18
      integer, parameter :: mpi_combiner_hindexed_integer=7
      integer, parameter :: mpi_combiner_hvector=5
      integer, parameter :: mpi_combiner_hvector_integer=4
      integer, parameter :: mpi_combiner_indexed=6
      integer, parameter :: mpi_combiner_indexed_block=9
      integer, parameter :: mpi_combiner_named=0
      integer, parameter :: mpi_combiner_resized=17
      integer, parameter :: mpi_combiner_struct=11
      integer, parameter :: mpi_combiner_struct_integer=10
      integer, parameter :: mpi_combiner_subarray=12
      integer, parameter :: mpi_combiner_vector=3
      integer, parameter :: mpi_comm_type_shared=0
      integer, parameter :: mpi_congruent=1
      integer, parameter :: mpi_distribute_block=0
      integer, parameter :: mpi_distribute_cyclic=1
      integer, parameter :: mpi_distribute_dflt_darg=-1
      integer, parameter :: mpi_distribute_none=2
      integer, parameter :: mpi_dist_graph=3
      integer, parameter :: mpi_error=3
      integer, parameter :: mpi_err_access=20
      integer, parameter :: mpi_err_amode=21
      integer, parameter :: mpi_err_arg=13
      integer, parameter :: mpi_err_assert=22
      integer, parameter :: mpi_err_bad_file=23
      integer, parameter :: mpi_err_base=24
      integer, parameter :: mpi_err_buffer=1
      integer, parameter :: mpi_err_comm=5
      integer, parameter :: mpi_err_conversion=25
      integer, parameter :: mpi_err_count=2
      integer, parameter :: mpi_err_dims=12
      integer, parameter :: mpi_err_disp=26
      integer, parameter :: mpi_err_dup_datarep=27
      integer, parameter :: mpi_err_file=30
      integer, parameter :: mpi_err_file_exists=28
      integer, parameter :: mpi_err_file_in_use=29
      integer, parameter :: mpi_err_group=9
      integer, parameter :: mpi_err_info=34
      integer, parameter :: mpi_err_info_key=31
      integer, parameter :: mpi_err_info_nokey=32
      integer, parameter :: mpi_err_info_value=33
      integer, parameter :: mpi_err_intern=17
      integer, parameter :: mpi_err_in_status=18
      integer, parameter :: mpi_err_io=35
      integer, parameter :: mpi_err_keyval=36
      integer, parameter :: mpi_err_lastcode=92
      integer, parameter :: mpi_err_locktype=37
      integer, parameter :: mpi_err_name=38
      integer, parameter :: mpi_err_not_same=40
      integer, parameter :: mpi_err_no_mem=39
      integer, parameter :: mpi_err_no_space=41
      integer, parameter :: mpi_err_no_such_file=42
      integer, parameter :: mpi_err_op=10
      integer, parameter :: mpi_err_other=16
      integer, parameter :: mpi_err_pending=19
      integer, parameter :: mpi_err_port=43
      integer, parameter :: mpi_err_quota=44
      integer, parameter :: mpi_err_rank=6
      integer, parameter :: mpi_err_read_only=45
      integer, parameter :: mpi_err_request=7
      integer, parameter :: mpi_err_rma_attach=69
      integer, parameter :: mpi_err_rma_conflict=46
      integer, parameter :: mpi_err_rma_flavor=70
      integer, parameter :: mpi_err_rma_range=68
      integer, parameter :: mpi_err_rma_shared=71
      integer, parameter :: mpi_err_rma_sync=47
      integer, parameter :: mpi_err_root=8
      integer, parameter :: mpi_err_service=48
      integer, parameter :: mpi_err_size=49
      integer, parameter :: mpi_err_spawn=50
      integer, parameter :: mpi_err_tag=4
      integer, parameter :: mpi_err_topology=11
      integer, parameter :: mpi_err_truncate=15
      integer, parameter :: mpi_err_type=3
      integer, parameter :: mpi_err_unknown=14
      integer, parameter :: mpi_err_unsupported_datarep=51
      integer, parameter :: mpi_err_unsupported_operation=52
      integer, parameter :: mpi_err_win=53
      integer, parameter :: mpi_graph=2
      integer, parameter :: mpi_host=1
      integer, parameter :: mpi_ident=0
      integer, parameter :: mpi_io=2
      integer, parameter :: mpi_keyval_invalid=-1
      integer, parameter :: mpi_lastusedcode=5
      integer, parameter :: mpi_lock_exclusive=1
      integer, parameter :: mpi_lock_shared=2
      integer, parameter :: mpi_mode_nocheck=1
      integer, parameter :: mpi_mode_noprecede=2
      integer, parameter :: mpi_mode_noput=4
      integer, parameter :: mpi_mode_nostore=8
      integer, parameter :: mpi_mode_nosucceed=16
      integer, parameter :: mpi_order_c=0
      integer, parameter :: mpi_order_fortran=1
      integer, parameter :: mpi_proc_null=-2
      integer, parameter :: mpi_root=-4
      integer, parameter :: mpi_similar=2
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_subversion=1
      integer, parameter :: mpi_success=0
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_tag_ub=0
      integer, parameter :: mpi_thread_funneled=1
      integer, parameter :: mpi_thread_multiple=3
      integer, parameter :: mpi_thread_serialized=2
      integer, parameter :: mpi_thread_single=0
      integer, parameter :: mpi_typeclass_complex=3
      integer, parameter :: mpi_typeclass_integer=1
      integer, parameter :: mpi_typeclass_real=2
      integer, parameter :: mpi_t_err_cannot_init=56
      integer, parameter :: mpi_t_err_cvar_set_never=64
      integer, parameter :: mpi_t_err_cvar_set_not_now=63
      integer, parameter :: mpi_t_err_invalid=72
      integer, parameter :: mpi_t_err_invalid_handle=59
      integer, parameter :: mpi_t_err_invalid_index=57
      integer, parameter :: mpi_t_err_invalid_item=58
      integer, parameter :: mpi_t_err_invalid_session=62
      integer, parameter :: mpi_t_err_memory=54
      integer, parameter :: mpi_t_err_not_initialized=55
      integer, parameter :: mpi_t_err_out_of_handles=60
      integer, parameter :: mpi_t_err_out_of_sessions=61
      integer, parameter :: mpi_t_err_pvar_no_atomic=67
      integer, parameter :: mpi_t_err_pvar_no_startstop=65
      integer, parameter :: mpi_t_err_pvar_no_write=66
      integer, parameter :: mpi_undefined=-32766
      integer, parameter :: mpi_unequal=3
      integer, parameter :: mpi_universe_size=6
      integer, parameter :: mpi_version=3
      integer, parameter :: mpi_win_base=7
      integer, parameter :: mpi_win_create_flavor=10
      integer, parameter :: mpi_win_disp_unit=9
      integer, parameter :: mpi_win_flavor_allocate=2
      integer, parameter :: mpi_win_flavor_create=1
      integer, parameter :: mpi_win_flavor_dynamic=3
      integer, parameter :: mpi_win_flavor_shared=4
      integer, parameter :: mpi_win_model=11
      integer, parameter :: mpi_win_separate=1
      integer, parameter :: mpi_win_size=8
      integer, parameter :: mpi_win_unified=0
      integer, parameter :: mpi_wtime_is_global=3
      integer, parameter :: ompi_comm_type_board=8
      integer, parameter :: ompi_comm_type_cluster=11
      integer, parameter :: ompi_comm_type_core=2
      integer, parameter :: ompi_comm_type_cu=10
      integer, parameter :: ompi_comm_type_host=9
      integer, parameter :: ompi_comm_type_hwthread=1
      integer, parameter :: ompi_comm_type_l1cache=3
      integer, parameter :: ompi_comm_type_l2cache=4
      integer, parameter :: ompi_comm_type_l3cache=5
      integer, parameter :: ompi_comm_type_node=0
      integer, parameter :: ompi_comm_type_numa=7
      integer, parameter :: ompi_comm_type_socket=6
      integer, parameter :: mpi_2complex=26
      integer, parameter :: mpi_2double_complex=27
      integer, parameter :: mpi_2double_precision=24
      integer, parameter :: mpi_2int=52
      integer, parameter :: mpi_2integer=25
      integer, parameter :: mpi_2real=23
      integer, parameter :: mpi_aint=66
      integer, parameter :: mpi_band=6
      integer, parameter :: mpi_bor=8
      integer, parameter :: mpi_bxor=10
      integer, parameter :: mpi_byte=1
      integer, parameter :: mpi_char=34
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_comm_null=2
      integer, parameter :: mpi_comm_self=1
      integer, parameter :: mpi_comm_world=0
      integer, parameter :: mpi_complex=18
      integer, parameter :: mpi_complex16=20
      integer, parameter :: mpi_complex32=21
      integer, parameter :: mpi_complex8=19
      integer, parameter :: mpi_count=72
      integer, parameter :: mpi_cxx_bool=54
      integer, parameter :: mpi_cxx_complex=55
      integer, parameter :: mpi_cxx_double_complex=56
      integer, parameter :: mpi_cxx_float_complex=55
      integer, parameter :: mpi_cxx_long_double_complex=57
      integer, parameter :: mpi_c_bool=68
      integer, parameter :: mpi_c_complex=69
      integer, parameter :: mpi_c_double_complex=70
      integer, parameter :: mpi_c_float_complex=69
      integer, parameter :: mpi_c_long_double_complex=71
      integer, parameter :: mpi_datatype_null=0
      integer, parameter :: mpi_double=46
      integer, parameter :: mpi_double_complex=22
      integer, parameter :: mpi_double_int=49
      integer, parameter :: mpi_double_precision=17
      integer, parameter :: mpi_errhandler_null=0
      integer, parameter :: mpi_errors_are_fatal=1
      integer, parameter :: mpi_errors_return=2
      integer, parameter :: mpi_float=45
      integer, parameter :: mpi_float_int=48
      integer, parameter :: mpi_group_empty=1
      integer, parameter :: mpi_group_null=0
      integer, parameter :: mpi_info_env=1
      integer, parameter :: mpi_info_null=0
      integer, parameter :: mpi_int=39
      integer, parameter :: mpi_int16_t=60
      integer, parameter :: mpi_int32_t=62
      integer, parameter :: mpi_int64_t=64
      integer, parameter :: mpi_int8_t=58
      integer, parameter :: mpi_integer=7
      integer, parameter :: mpi_integer1=8
      integer, parameter :: mpi_integer16=12
      integer, parameter :: mpi_integer2=9
      integer, parameter :: mpi_integer4=10
      integer, parameter :: mpi_integer8=11
      integer, parameter :: mpi_land=5
      integer, parameter :: mpi_lb=4
      integer, parameter :: mpi_logical=6
      integer, parameter :: mpi_logical1=29
      integer, parameter :: mpi_logical2=30
      integer, parameter :: mpi_logical4=31
      integer, parameter :: mpi_logical8=32
      integer, parameter :: mpi_long=41
      integer, parameter :: mpi_long_double=47
      integer, parameter :: mpi_long_double_int=50
      integer, parameter :: mpi_long_int=51
      integer, parameter :: mpi_long_long=43
      integer, parameter :: mpi_long_long_int=43
      integer, parameter :: mpi_lor=7
      integer, parameter :: mpi_lxor=9
      integer, parameter :: mpi_max=1
      integer, parameter :: mpi_maxloc=11
      integer, parameter :: mpi_message_no_proc=1
      integer, parameter :: mpi_message_null=0
      integer, parameter :: mpi_min=2
      integer, parameter :: mpi_minloc=12
      integer, parameter :: mpi_no_op=14
      integer, parameter :: mpi_offset=67
      integer, parameter :: mpi_op_null=0
      integer, parameter :: mpi_packed=2
      integer, parameter :: mpi_prod=4
      integer, parameter :: mpi_real=13
      integer, parameter :: mpi_real16=16
      integer, parameter :: mpi_real2=28
      integer, parameter :: mpi_real4=14
      integer, parameter :: mpi_real8=15
      integer, parameter :: mpi_replace=13
      integer, parameter :: mpi_request_null=0
      integer, parameter :: mpi_short=37
      integer, parameter :: mpi_short_int=53
      integer, parameter :: mpi_signed_char=36
      integer, parameter :: mpi_sum=3
      integer, parameter :: mpi_ub=3
      integer, parameter :: mpi_uint16_t=61
      integer, parameter :: mpi_uint32_t=63
      integer, parameter :: mpi_uint64_t=65
      integer, parameter :: mpi_uint8_t=59
      integer, parameter :: mpi_unsigned=40
      integer, parameter :: mpi_unsigned_char=35
      integer, parameter :: mpi_unsigned_long=42
      integer, parameter :: mpi_unsigned_long_long=44
      integer, parameter :: mpi_unsigned_short=38
      integer, parameter :: mpi_wchar=33
      integer, parameter :: mpi_win_null=0
      integer, parameter :: mpi_mode_append=128
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_delete_on_close=16
      integer, parameter :: mpi_mode_excl=64
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_rdwr=8
      integer, parameter :: mpi_mode_sequential=256
      integer, parameter :: mpi_mode_unique_open=32
      integer, parameter :: mpi_mode_wronly=4
      integer, parameter :: mpi_seek_cur=602
      integer, parameter :: mpi_seek_end=604
      integer, parameter :: mpi_seek_set=600
      integer, parameter :: mpi_displacement_current=-54278278
      integer, parameter :: mpi_file_null=0
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2014 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2017      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 
!  Do ***not*** copy this file to the directory where your Fortran
!  fortran application is compiled unless it is absolutely necessary!  Most
!  modern Fortran compilers now support the -I command line flag, which
!  tells the compiler where to find .h files (specifically, this one).  For
!  example:
! 
!       shell$ mpifort foo.f -o foo -I$OMPI_HOME/include
! 
!  will probably do the trick (assuming that you have set OMPI_HOME
!  properly).
! 
!  That being said, OMPI's "mpifort" wrapper compiler should
!  automatically include the -I option for you.  The following command
!  should be equivalent to the command listed above:
! 
!       shell$ mpifort foo.f -o foo
! 
!  You should not copy this file to your local directory because it is
!  possible that this file will be changed between versions of Open MPI.
!  Indeed, this mpif.h is incompatible with the mpif.f of other
!  implementations of MPI.  Using this mpif.h with other implementations
!  of MPI, or with other versions of Open MPI will result in undefined
!  behavior (to include incorrect results, segmentation faults,
!  unexplainable "hanging" in your application, etc.).  Always use the
!  -I command line option instead (or let mpifort do it for you).
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!       include 'mpif-config.h'
!       include 'mpif-constants.h'
!       include 'mpif-handles.h'
!       include 'mpif-io-constants.h'
!       include 'mpif-io-handles.h'
!       include 'mpif-externals.h'
!       include 'mpif-sentinels.h'
!       include 'mpif-sizeof.h'
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
!  Copyright (c) 2013      Los Alamos National Security, LLC. All rights
!                          reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      This file contains the output from configure that is relevant for
!      Fortran applications and a few values that are necessary to
!      compile the Fortran modules (e.g., MPI_STATUS_SIZE).
! 
! 
!      OMPI version
!      This file is generated from configure; do not edit it manually.
! 
! 
!      Kind parameters
! 
! 
!      Miscellaneous constants
! 
! 
!      Configurable length constants
! 
! 
!  MPI F08 conformance
! 
      ! hard-coded for .false. for now
      ! hard-coded for .false. for now
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      These "external" statements are specific to the MPI mpif.h
!      interface (and are toxic to the MPI module interfaces),.
! 
      external mpi_null_copy_fn, mpi_null_delete_fn
      external mpi_comm_null_copy_fn, mpi_comm_null_delete_fn
      external mpi_type_null_copy_fn, mpi_type_null_delete_fn
      external mpi_dup_fn, mpi_comm_dup_fn, mpi_type_dup_fn
      external mpi_win_null_copy_fn
      external mpi_win_null_delete_fn
      external mpi_win_dup_fn
!      Note that MPI_CONVERSION_FN_NULL is a "constant" (it is only ever
!      checked for comparison; it is never invoked), but it is passed as
!      a function pointer (to MPI_REGISTER_DATAREP) and therefore must be
!      the same size/type.  It is therefore external'ed here, and not
!      defined with an integer value in mpif-common.h.
      external mpi_conversion_fn_null
! 
!      double precision functions
! 
      external mpi_wtime, mpi_wtick , pmpi_wtick, pmpi_wtime
      integer, parameter :: lorder=3
      integer, parameter :: lorder2=max(1,lorder-2)
      integer, parameter :: lx1=8
      integer, parameter :: lx2=lx1-2
      integer, parameter :: lxq=lx2
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
      real :: dt
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
      real(kind=8), intent(In) :: etimes
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
      integer, intent(In) :: icall
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
      logical, intent(In) :: ifneknek
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
      integer, intent(In) :: istep
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
      integer :: nab
      integer :: nabmsh
      integer :: nadvc
      integer :: naxhm
      integer :: nbbbb
      integer :: nbd
      integer :: nbdinp
      integer :: nbso2
      integer :: nbsol
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
      integer, intent(In) :: nekcomm
      integer :: nekgroup
      integer :: nekreal
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
      integer, intent(In) :: nid
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
      integer, intent(In) :: np
      integer :: npert
      integer :: nprep
      integer :: npres
      integer :: npscal
      character(len=132) :: nrefle
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
      integer(kind=8), intent(In) :: nvtot
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
      character(len=132) :: re2fle
      integer(kind=8) :: re2off_b
      character(len=132) :: reafle
      real, dimension(0:ldimt1) :: restol
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
      real(kind=8) :: tmxmf
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
      real(kind=8), intent(In) :: tprep
      real(kind=8) :: tpres
      real(kind=8) :: tproj
      real(kind=8) :: tschw
      real(kind=8) :: tsett
      real(kind=8) :: tslvb
      real(kind=8) :: tsolv
      real(kind=8) :: tspro
      real(kind=8) :: tsyc
      real(kind=8), intent(In) :: ttime
      real(kind=8), intent(InOut) :: ttotal
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
      integer :: ierr
      real(kind=8) :: mpi_wtick
      real(kind=8) :: pmpi_wtick
      real(kind=8) :: pmpi_wtime
! 
!      address integer functions
! 
      external mpi_aint_add, mpi_aint_diff
      integer :: mpi_aint_add
      integer :: mpi_aint_diff
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      All of these types were chosen with care to match the types of
!      their corresponding C variables.  Do not arbitrarily change
!      their types without also updating:
! 
!      - the "mpi" module bindings
!      - the "mpi_f08" module bindings
!      - ompi/mpi/fortran/base/gen-mpi-mangling.pl
! 
!      MPI_BOTTOM is only used where choice buffers can be used (meaning
!      that we already have overloaded F90 bindings for all available
!      types), so any type is fine.
      integer :: mpi_bottom
!      MPI_IN_PLACE has the same rationale as MPI_BOTTOM.
      integer :: mpi_in_place
!      Making MPI_ARGV_NULL be the same type as the parameter that is
!      exepected in the F90 binding for MPI_COMM_SPAWN means that we
!      don't need another interface for MPI_COMM_SPAWN.
      character, dimension(1:1) :: mpi_argv_null
!      Ditto for MPI_ARGVS_NULL / MPI_COMM_SPAWN_MULTIPLE.
      character, dimension(1:1,1:1) :: mpi_argvs_null
!      MPI_ERRCODES_IGNORE has similar rationale to MPI_ARGV_NULL.  The
!      F77 functions are all smart enough to check that the errcodes
!      parameter is not ERRCODES_IGNORE before assigning values into it
!      (hence, the fact that this is an array of only 1 element does not
!      matter -- we'll never overrun it because we never assign values
!      into it).
      integer, dimension(1:1) :: mpi_errcodes_ignore
!      MPI_STATUS_IGNORE has similar rationale to MPI_ERRCODES_IGNORE.
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
!      Ditto for MPI_STATUSES_IGNORE
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
!      Ditto for MPI_UNWEIGHTED
      integer, dimension(1:1) :: mpi_unweighted
!      Ditto for MPI_WEIGHTS_EMPTY
      integer, dimension(1:1) :: mpi_weights_empty
!  -*- f90 -*-
!  WARNING: This is a generated file!  Edits will be lost!
! 
!  Copyright (c) 2014 Cisco Systems, Inc.  All rights reserved.
! $COPYRIGHT$
! 
!  This file was generated by gen-mpi-sizeof.pl for all the MPI_SIZEOF
!  interface possibilities for intrinsic types.  Once TS 29113 is
!  supported in all compilers, we can simply have *one* procedure for
!  each type and use dimension(..) to indicate scalars+all array ranks.
!  But until more compilers support this, we simply generate a
!  procedure for scalars and all possible ranks in an attempt to
!  support lots of Fortran compilers.
      interface mpi_sizeof
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
        call exitt(ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t, &
      b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx, &
      bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz, &
      bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld, &
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
      endif
      call icopy(x,w,n)

      return
      end subroutine igop
      real*8 function dnekclock(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore, &
      mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty)
      implicit none
      integer, parameter :: ompi_major_version=4
      integer, parameter :: ompi_minor_version=0
      integer, parameter :: ompi_release_version=1
      integer, parameter :: mpi_integer_kind=4
      integer, parameter :: mpi_address_kind=8
      integer, parameter :: mpi_offset_kind=8
      integer, parameter :: mpi_count_kind=8
      integer, parameter :: mpi_status_size=6
      integer, parameter :: mpi_max_processor_name=256-1
      integer, parameter :: mpi_max_error_string=256-1
      integer, parameter :: mpi_max_object_name=64-1
      integer, parameter :: mpi_max_library_version_string=256-1
      integer, parameter :: mpi_max_info_key=36-1
      integer, parameter :: mpi_max_info_val=256-1
      integer, parameter :: mpi_max_port_name=1024-1
      integer, parameter :: mpi_max_datarep_string=128-1
      logical, parameter :: mpi_subarrays_supported=.false.
      logical, parameter :: mpi_async_protects_nonblocking=.false.
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
      integer, parameter :: mpi_appnum=4
      integer, parameter :: mpi_bsend_overhead=128
      integer, parameter :: mpi_cart=1
      integer, parameter :: mpi_combiner_contiguous=2
      integer, parameter :: mpi_combiner_darray=13
      integer, parameter :: mpi_combiner_dup=1
      integer, parameter :: mpi_combiner_f90_complex=15
      integer, parameter :: mpi_combiner_f90_integer=16
      integer, parameter :: mpi_combiner_f90_real=14
      integer, parameter :: mpi_combiner_hindexed=8
      integer, parameter :: mpi_combiner_hindexed_block=18
      integer, parameter :: mpi_combiner_hindexed_integer=7
      integer, parameter :: mpi_combiner_hvector=5
      integer, parameter :: mpi_combiner_hvector_integer=4
      integer, parameter :: mpi_combiner_indexed=6
      integer, parameter :: mpi_combiner_indexed_block=9
      integer, parameter :: mpi_combiner_named=0
      integer, parameter :: mpi_combiner_resized=17
      integer, parameter :: mpi_combiner_struct=11
      integer, parameter :: mpi_combiner_struct_integer=10
      integer, parameter :: mpi_combiner_subarray=12
      integer, parameter :: mpi_combiner_vector=3
      integer, parameter :: mpi_comm_type_shared=0
      integer, parameter :: mpi_congruent=1
      integer, parameter :: mpi_distribute_block=0
      integer, parameter :: mpi_distribute_cyclic=1
      integer, parameter :: mpi_distribute_dflt_darg=-1
      integer, parameter :: mpi_distribute_none=2
      integer, parameter :: mpi_dist_graph=3
      integer, parameter :: mpi_error=3
      integer, parameter :: mpi_err_access=20
      integer, parameter :: mpi_err_amode=21
      integer, parameter :: mpi_err_arg=13
      integer, parameter :: mpi_err_assert=22
      integer, parameter :: mpi_err_bad_file=23
      integer, parameter :: mpi_err_base=24
      integer, parameter :: mpi_err_buffer=1
      integer, parameter :: mpi_err_comm=5
      integer, parameter :: mpi_err_conversion=25
      integer, parameter :: mpi_err_count=2
      integer, parameter :: mpi_err_dims=12
      integer, parameter :: mpi_err_disp=26
      integer, parameter :: mpi_err_dup_datarep=27
      integer, parameter :: mpi_err_file=30
      integer, parameter :: mpi_err_file_exists=28
      integer, parameter :: mpi_err_file_in_use=29
      integer, parameter :: mpi_err_group=9
      integer, parameter :: mpi_err_info=34
      integer, parameter :: mpi_err_info_key=31
      integer, parameter :: mpi_err_info_nokey=32
      integer, parameter :: mpi_err_info_value=33
      integer, parameter :: mpi_err_intern=17
      integer, parameter :: mpi_err_in_status=18
      integer, parameter :: mpi_err_io=35
      integer, parameter :: mpi_err_keyval=36
      integer, parameter :: mpi_err_lastcode=92
      integer, parameter :: mpi_err_locktype=37
      integer, parameter :: mpi_err_name=38
      integer, parameter :: mpi_err_not_same=40
      integer, parameter :: mpi_err_no_mem=39
      integer, parameter :: mpi_err_no_space=41
      integer, parameter :: mpi_err_no_such_file=42
      integer, parameter :: mpi_err_op=10
      integer, parameter :: mpi_err_other=16
      integer, parameter :: mpi_err_pending=19
      integer, parameter :: mpi_err_port=43
      integer, parameter :: mpi_err_quota=44
      integer, parameter :: mpi_err_rank=6
      integer, parameter :: mpi_err_read_only=45
      integer, parameter :: mpi_err_request=7
      integer, parameter :: mpi_err_rma_attach=69
      integer, parameter :: mpi_err_rma_conflict=46
      integer, parameter :: mpi_err_rma_flavor=70
      integer, parameter :: mpi_err_rma_range=68
      integer, parameter :: mpi_err_rma_shared=71
      integer, parameter :: mpi_err_rma_sync=47
      integer, parameter :: mpi_err_root=8
      integer, parameter :: mpi_err_service=48
      integer, parameter :: mpi_err_size=49
      integer, parameter :: mpi_err_spawn=50
      integer, parameter :: mpi_err_tag=4
      integer, parameter :: mpi_err_topology=11
      integer, parameter :: mpi_err_truncate=15
      integer, parameter :: mpi_err_type=3
      integer, parameter :: mpi_err_unknown=14
      integer, parameter :: mpi_err_unsupported_datarep=51
      integer, parameter :: mpi_err_unsupported_operation=52
      integer, parameter :: mpi_err_win=53
      integer, parameter :: mpi_graph=2
      integer, parameter :: mpi_host=1
      integer, parameter :: mpi_ident=0
      integer, parameter :: mpi_io=2
      integer, parameter :: mpi_keyval_invalid=-1
      integer, parameter :: mpi_lastusedcode=5
      integer, parameter :: mpi_lock_exclusive=1
      integer, parameter :: mpi_lock_shared=2
      integer, parameter :: mpi_mode_nocheck=1
      integer, parameter :: mpi_mode_noprecede=2
      integer, parameter :: mpi_mode_noput=4
      integer, parameter :: mpi_mode_nostore=8
      integer, parameter :: mpi_mode_nosucceed=16
      integer, parameter :: mpi_order_c=0
      integer, parameter :: mpi_order_fortran=1
      integer, parameter :: mpi_proc_null=-2
      integer, parameter :: mpi_root=-4
      integer, parameter :: mpi_similar=2
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_subversion=1
      integer, parameter :: mpi_success=0
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_tag_ub=0
      integer, parameter :: mpi_thread_funneled=1
      integer, parameter :: mpi_thread_multiple=3
      integer, parameter :: mpi_thread_serialized=2
      integer, parameter :: mpi_thread_single=0
      integer, parameter :: mpi_typeclass_complex=3
      integer, parameter :: mpi_typeclass_integer=1
      integer, parameter :: mpi_typeclass_real=2
      integer, parameter :: mpi_t_err_cannot_init=56
      integer, parameter :: mpi_t_err_cvar_set_never=64
      integer, parameter :: mpi_t_err_cvar_set_not_now=63
      integer, parameter :: mpi_t_err_invalid=72
      integer, parameter :: mpi_t_err_invalid_handle=59
      integer, parameter :: mpi_t_err_invalid_index=57
      integer, parameter :: mpi_t_err_invalid_item=58
      integer, parameter :: mpi_t_err_invalid_session=62
      integer, parameter :: mpi_t_err_memory=54
      integer, parameter :: mpi_t_err_not_initialized=55
      integer, parameter :: mpi_t_err_out_of_handles=60
      integer, parameter :: mpi_t_err_out_of_sessions=61
      integer, parameter :: mpi_t_err_pvar_no_atomic=67
      integer, parameter :: mpi_t_err_pvar_no_startstop=65
      integer, parameter :: mpi_t_err_pvar_no_write=66
      integer, parameter :: mpi_undefined=-32766
      integer, parameter :: mpi_unequal=3
      integer, parameter :: mpi_universe_size=6
      integer, parameter :: mpi_version=3
      integer, parameter :: mpi_win_base=7
      integer, parameter :: mpi_win_create_flavor=10
      integer, parameter :: mpi_win_disp_unit=9
      integer, parameter :: mpi_win_flavor_allocate=2
      integer, parameter :: mpi_win_flavor_create=1
      integer, parameter :: mpi_win_flavor_dynamic=3
      integer, parameter :: mpi_win_flavor_shared=4
      integer, parameter :: mpi_win_model=11
      integer, parameter :: mpi_win_separate=1
      integer, parameter :: mpi_win_size=8
      integer, parameter :: mpi_win_unified=0
      integer, parameter :: mpi_wtime_is_global=3
      integer, parameter :: ompi_comm_type_board=8
      integer, parameter :: ompi_comm_type_cluster=11
      integer, parameter :: ompi_comm_type_core=2
      integer, parameter :: ompi_comm_type_cu=10
      integer, parameter :: ompi_comm_type_host=9
      integer, parameter :: ompi_comm_type_hwthread=1
      integer, parameter :: ompi_comm_type_l1cache=3
      integer, parameter :: ompi_comm_type_l2cache=4
      integer, parameter :: ompi_comm_type_l3cache=5
      integer, parameter :: ompi_comm_type_node=0
      integer, parameter :: ompi_comm_type_numa=7
      integer, parameter :: ompi_comm_type_socket=6
      integer, parameter :: mpi_2complex=26
      integer, parameter :: mpi_2double_complex=27
      integer, parameter :: mpi_2double_precision=24
      integer, parameter :: mpi_2int=52
      integer, parameter :: mpi_2integer=25
      integer, parameter :: mpi_2real=23
      integer, parameter :: mpi_aint=66
      integer, parameter :: mpi_band=6
      integer, parameter :: mpi_bor=8
      integer, parameter :: mpi_bxor=10
      integer, parameter :: mpi_byte=1
      integer, parameter :: mpi_char=34
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_comm_null=2
      integer, parameter :: mpi_comm_self=1
      integer, parameter :: mpi_comm_world=0
      integer, parameter :: mpi_complex=18
      integer, parameter :: mpi_complex16=20
      integer, parameter :: mpi_complex32=21
      integer, parameter :: mpi_complex8=19
      integer, parameter :: mpi_count=72
      integer, parameter :: mpi_cxx_bool=54
      integer, parameter :: mpi_cxx_complex=55
      integer, parameter :: mpi_cxx_double_complex=56
      integer, parameter :: mpi_cxx_float_complex=55
      integer, parameter :: mpi_cxx_long_double_complex=57
      integer, parameter :: mpi_c_bool=68
      integer, parameter :: mpi_c_complex=69
      integer, parameter :: mpi_c_double_complex=70
      integer, parameter :: mpi_c_float_complex=69
      integer, parameter :: mpi_c_long_double_complex=71
      integer, parameter :: mpi_datatype_null=0
      integer, parameter :: mpi_double=46
      integer, parameter :: mpi_double_complex=22
      integer, parameter :: mpi_double_int=49
      integer, parameter :: mpi_double_precision=17
      integer, parameter :: mpi_errhandler_null=0
      integer, parameter :: mpi_errors_are_fatal=1
      integer, parameter :: mpi_errors_return=2
      integer, parameter :: mpi_float=45
      integer, parameter :: mpi_float_int=48
      integer, parameter :: mpi_group_empty=1
      integer, parameter :: mpi_group_null=0
      integer, parameter :: mpi_info_env=1
      integer, parameter :: mpi_info_null=0
      integer, parameter :: mpi_int=39
      integer, parameter :: mpi_int16_t=60
      integer, parameter :: mpi_int32_t=62
      integer, parameter :: mpi_int64_t=64
      integer, parameter :: mpi_int8_t=58
      integer, parameter :: mpi_integer=7
      integer, parameter :: mpi_integer1=8
      integer, parameter :: mpi_integer16=12
      integer, parameter :: mpi_integer2=9
      integer, parameter :: mpi_integer4=10
      integer, parameter :: mpi_integer8=11
      integer, parameter :: mpi_land=5
      integer, parameter :: mpi_lb=4
      integer, parameter :: mpi_logical=6
      integer, parameter :: mpi_logical1=29
      integer, parameter :: mpi_logical2=30
      integer, parameter :: mpi_logical4=31
      integer, parameter :: mpi_logical8=32
      integer, parameter :: mpi_long=41
      integer, parameter :: mpi_long_double=47
      integer, parameter :: mpi_long_double_int=50
      integer, parameter :: mpi_long_int=51
      integer, parameter :: mpi_long_long=43
      integer, parameter :: mpi_long_long_int=43
      integer, parameter :: mpi_lor=7
      integer, parameter :: mpi_lxor=9
      integer, parameter :: mpi_max=1
      integer, parameter :: mpi_maxloc=11
      integer, parameter :: mpi_message_no_proc=1
      integer, parameter :: mpi_message_null=0
      integer, parameter :: mpi_min=2
      integer, parameter :: mpi_minloc=12
      integer, parameter :: mpi_no_op=14
      integer, parameter :: mpi_offset=67
      integer, parameter :: mpi_op_null=0
      integer, parameter :: mpi_packed=2
      integer, parameter :: mpi_prod=4
      integer, parameter :: mpi_real=13
      integer, parameter :: mpi_real16=16
      integer, parameter :: mpi_real2=28
      integer, parameter :: mpi_real4=14
      integer, parameter :: mpi_real8=15
      integer, parameter :: mpi_replace=13
      integer, parameter :: mpi_request_null=0
      integer, parameter :: mpi_short=37
      integer, parameter :: mpi_short_int=53
      integer, parameter :: mpi_signed_char=36
      integer, parameter :: mpi_sum=3
      integer, parameter :: mpi_ub=3
      integer, parameter :: mpi_uint16_t=61
      integer, parameter :: mpi_uint32_t=63
      integer, parameter :: mpi_uint64_t=65
      integer, parameter :: mpi_uint8_t=59
      integer, parameter :: mpi_unsigned=40
      integer, parameter :: mpi_unsigned_char=35
      integer, parameter :: mpi_unsigned_long=42
      integer, parameter :: mpi_unsigned_long_long=44
      integer, parameter :: mpi_unsigned_short=38
      integer, parameter :: mpi_wchar=33
      integer, parameter :: mpi_win_null=0
      integer, parameter :: mpi_mode_append=128
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_delete_on_close=16
      integer, parameter :: mpi_mode_excl=64
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_rdwr=8
      integer, parameter :: mpi_mode_sequential=256
      integer, parameter :: mpi_mode_unique_open=32
      integer, parameter :: mpi_mode_wronly=4
      integer, parameter :: mpi_seek_cur=602
      integer, parameter :: mpi_seek_end=604
      integer, parameter :: mpi_seek_set=600
      integer, parameter :: mpi_displacement_current=-54278278
      integer, parameter :: mpi_file_null=0
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2014 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2017      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 
!  Do ***not*** copy this file to the directory where your Fortran
!  fortran application is compiled unless it is absolutely necessary!  Most
!  modern Fortran compilers now support the -I command line flag, which
!  tells the compiler where to find .h files (specifically, this one).  For
!  example:
! 
!       shell$ mpifort foo.f -o foo -I$OMPI_HOME/include
! 
!  will probably do the trick (assuming that you have set OMPI_HOME
!  properly).
! 
!  That being said, OMPI's "mpifort" wrapper compiler should
!  automatically include the -I option for you.  The following command
!  should be equivalent to the command listed above:
! 
!       shell$ mpifort foo.f -o foo
! 
!  You should not copy this file to your local directory because it is
!  possible that this file will be changed between versions of Open MPI.
!  Indeed, this mpif.h is incompatible with the mpif.f of other
!  implementations of MPI.  Using this mpif.h with other implementations
!  of MPI, or with other versions of Open MPI will result in undefined
!  behavior (to include incorrect results, segmentation faults,
!  unexplainable "hanging" in your application, etc.).  Always use the
!  -I command line option instead (or let mpifort do it for you).
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!       include 'mpif-config.h'
!       include 'mpif-constants.h'
!       include 'mpif-handles.h'
!       include 'mpif-io-constants.h'
!       include 'mpif-io-handles.h'
!       include 'mpif-externals.h'
!       include 'mpif-sentinels.h'
!       include 'mpif-sizeof.h'
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
!  Copyright (c) 2013      Los Alamos National Security, LLC. All rights
!                          reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      This file contains the output from configure that is relevant for
!      Fortran applications and a few values that are necessary to
!      compile the Fortran modules (e.g., MPI_STATUS_SIZE).
! 
! 
!      OMPI version
!      This file is generated from configure; do not edit it manually.
! 
! 
!      Kind parameters
! 
! 
!      Miscellaneous constants
! 
! 
!      Configurable length constants
! 
! 
!  MPI F08 conformance
! 
      ! hard-coded for .false. for now
      ! hard-coded for .false. for now
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      These "external" statements are specific to the MPI mpif.h
!      interface (and are toxic to the MPI module interfaces),.
! 
      external mpi_null_copy_fn, mpi_null_delete_fn
      external mpi_comm_null_copy_fn, mpi_comm_null_delete_fn
      external mpi_type_null_copy_fn, mpi_type_null_delete_fn
      external mpi_dup_fn, mpi_comm_dup_fn, mpi_type_dup_fn
      external mpi_win_null_copy_fn
      external mpi_win_null_delete_fn
      external mpi_win_dup_fn
!      Note that MPI_CONVERSION_FN_NULL is a "constant" (it is only ever
!      checked for comparison; it is never invoked), but it is passed as
!      a function pointer (to MPI_REGISTER_DATAREP) and therefore must be
!      the same size/type.  It is therefore external'ed here, and not
!      defined with an integer value in mpif-common.h.
      external mpi_conversion_fn_null
! 
!      double precision functions
! 
      external mpi_wtime, mpi_wtick , pmpi_wtick, pmpi_wtime
      real(kind=8) :: mpi_wtick
      real(kind=8) :: pmpi_wtick
      real(kind=8) :: pmpi_wtime
! 
!      address integer functions
! 
      external mpi_aint_add, mpi_aint_diff
      integer :: mpi_aint_add
      integer :: mpi_aint_diff
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      All of these types were chosen with care to match the types of
!      their corresponding C variables.  Do not arbitrarily change
!      their types without also updating:
! 
!      - the "mpi" module bindings
!      - the "mpi_f08" module bindings
!      - ompi/mpi/fortran/base/gen-mpi-mangling.pl
! 
!      MPI_BOTTOM is only used where choice buffers can be used (meaning
!      that we already have overloaded F90 bindings for all available
!      types), so any type is fine.
      integer :: mpi_bottom
!      MPI_IN_PLACE has the same rationale as MPI_BOTTOM.
      integer :: mpi_in_place
!      Making MPI_ARGV_NULL be the same type as the parameter that is
!      exepected in the F90 binding for MPI_COMM_SPAWN means that we
!      don't need another interface for MPI_COMM_SPAWN.
      character, dimension(1:1) :: mpi_argv_null
!      Ditto for MPI_ARGVS_NULL / MPI_COMM_SPAWN_MULTIPLE.
      character, dimension(1:1,1:1) :: mpi_argvs_null
!      MPI_ERRCODES_IGNORE has similar rationale to MPI_ARGV_NULL.  The
!      F77 functions are all smart enough to check that the errcodes
!      parameter is not ERRCODES_IGNORE before assigning values into it
!      (hence, the fact that this is an array of only 1 element does not
!      matter -- we'll never overrun it because we never assign values
!      into it).
      integer, dimension(1:1) :: mpi_errcodes_ignore
!      MPI_STATUS_IGNORE has similar rationale to MPI_ERRCODES_IGNORE.
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
!      Ditto for MPI_STATUSES_IGNORE
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
!      Ditto for MPI_UNWEIGHTED
      integer, dimension(1:1) :: mpi_unweighted
!      Ditto for MPI_WEIGHTS_EMPTY
      integer, dimension(1:1) :: mpi_weights_empty
!  -*- f90 -*-
!  WARNING: This is a generated file!  Edits will be lost!
! 
!  Copyright (c) 2014 Cisco Systems, Inc.  All rights reserved.
! $COPYRIGHT$
! 
!  This file was generated by gen-mpi-sizeof.pl for all the MPI_SIZEOF
!  interface possibilities for intrinsic types.  Once TS 29113 is
!  supported in all compilers, we can simply have *one* procedure for
!  each type and use dimension(..) to indicate scalars+all array ranks.
!  But until more compilers support this, we simply generate a
!  procedure for scalars and all possible ranks in an attempt to
!  support lots of Fortran compilers.
      interface mpi_sizeof
! 
      dnekclock = mpi_wtime()
! 
      return
      end function dnekclock
      real*8 function dnekclock_sync(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore, &
      mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nekcomm, &
      nekgroup,nekreal,nid,np)
      implicit none
      integer, parameter :: ompi_major_version=4
      integer, parameter :: ompi_minor_version=0
      integer, parameter :: ompi_release_version=1
      integer, parameter :: mpi_integer_kind=4
      integer, parameter :: mpi_address_kind=8
      integer, parameter :: mpi_offset_kind=8
      integer, parameter :: mpi_count_kind=8
      integer, parameter :: mpi_status_size=6
      integer, parameter :: mpi_max_processor_name=256-1
      integer, parameter :: mpi_max_error_string=256-1
      integer, parameter :: mpi_max_object_name=64-1
      integer, parameter :: mpi_max_library_version_string=256-1
      integer, parameter :: mpi_max_info_key=36-1
      integer, parameter :: mpi_max_info_val=256-1
      integer, parameter :: mpi_max_port_name=1024-1
      integer, parameter :: mpi_max_datarep_string=128-1
      logical, parameter :: mpi_subarrays_supported=.false.
      logical, parameter :: mpi_async_protects_nonblocking=.false.
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
      integer, parameter :: mpi_appnum=4
      integer, parameter :: mpi_bsend_overhead=128
      integer, parameter :: mpi_cart=1
      integer, parameter :: mpi_combiner_contiguous=2
      integer, parameter :: mpi_combiner_darray=13
      integer, parameter :: mpi_combiner_dup=1
      integer, parameter :: mpi_combiner_f90_complex=15
      integer, parameter :: mpi_combiner_f90_integer=16
      integer, parameter :: mpi_combiner_f90_real=14
      integer, parameter :: mpi_combiner_hindexed=8
      integer, parameter :: mpi_combiner_hindexed_block=18
      integer, parameter :: mpi_combiner_hindexed_integer=7
      integer, parameter :: mpi_combiner_hvector=5
      integer, parameter :: mpi_combiner_hvector_integer=4
      integer, parameter :: mpi_combiner_indexed=6
      integer, parameter :: mpi_combiner_indexed_block=9
      integer, parameter :: mpi_combiner_named=0
      integer, parameter :: mpi_combiner_resized=17
      integer, parameter :: mpi_combiner_struct=11
      integer, parameter :: mpi_combiner_struct_integer=10
      integer, parameter :: mpi_combiner_subarray=12
      integer, parameter :: mpi_combiner_vector=3
      integer, parameter :: mpi_comm_type_shared=0
      integer, parameter :: mpi_congruent=1
      integer, parameter :: mpi_distribute_block=0
      integer, parameter :: mpi_distribute_cyclic=1
      integer, parameter :: mpi_distribute_dflt_darg=-1
      integer, parameter :: mpi_distribute_none=2
      integer, parameter :: mpi_dist_graph=3
      integer, parameter :: mpi_error=3
      integer, parameter :: mpi_err_access=20
      integer, parameter :: mpi_err_amode=21
      integer, parameter :: mpi_err_arg=13
      integer, parameter :: mpi_err_assert=22
      integer, parameter :: mpi_err_bad_file=23
      integer, parameter :: mpi_err_base=24
      integer, parameter :: mpi_err_buffer=1
      integer, parameter :: mpi_err_comm=5
      integer, parameter :: mpi_err_conversion=25
      integer, parameter :: mpi_err_count=2
      integer, parameter :: mpi_err_dims=12
      integer, parameter :: mpi_err_disp=26
      integer, parameter :: mpi_err_dup_datarep=27
      integer, parameter :: mpi_err_file=30
      integer, parameter :: mpi_err_file_exists=28
      integer, parameter :: mpi_err_file_in_use=29
      integer, parameter :: mpi_err_group=9
      integer, parameter :: mpi_err_info=34
      integer, parameter :: mpi_err_info_key=31
      integer, parameter :: mpi_err_info_nokey=32
      integer, parameter :: mpi_err_info_value=33
      integer, parameter :: mpi_err_intern=17
      integer, parameter :: mpi_err_in_status=18
      integer, parameter :: mpi_err_io=35
      integer, parameter :: mpi_err_keyval=36
      integer, parameter :: mpi_err_lastcode=92
      integer, parameter :: mpi_err_locktype=37
      integer, parameter :: mpi_err_name=38
      integer, parameter :: mpi_err_not_same=40
      integer, parameter :: mpi_err_no_mem=39
      integer, parameter :: mpi_err_no_space=41
      integer, parameter :: mpi_err_no_such_file=42
      integer, parameter :: mpi_err_op=10
      integer, parameter :: mpi_err_other=16
      integer, parameter :: mpi_err_pending=19
      integer, parameter :: mpi_err_port=43
      integer, parameter :: mpi_err_quota=44
      integer, parameter :: mpi_err_rank=6
      integer, parameter :: mpi_err_read_only=45
      integer, parameter :: mpi_err_request=7
      integer, parameter :: mpi_err_rma_attach=69
      integer, parameter :: mpi_err_rma_conflict=46
      integer, parameter :: mpi_err_rma_flavor=70
      integer, parameter :: mpi_err_rma_range=68
      integer, parameter :: mpi_err_rma_shared=71
      integer, parameter :: mpi_err_rma_sync=47
      integer, parameter :: mpi_err_root=8
      integer, parameter :: mpi_err_service=48
      integer, parameter :: mpi_err_size=49
      integer, parameter :: mpi_err_spawn=50
      integer, parameter :: mpi_err_tag=4
      integer, parameter :: mpi_err_topology=11
      integer, parameter :: mpi_err_truncate=15
      integer, parameter :: mpi_err_type=3
      integer, parameter :: mpi_err_unknown=14
      integer, parameter :: mpi_err_unsupported_datarep=51
      integer, parameter :: mpi_err_unsupported_operation=52
      integer, parameter :: mpi_err_win=53
      integer, parameter :: mpi_graph=2
      integer, parameter :: mpi_host=1
      integer, parameter :: mpi_ident=0
      integer, parameter :: mpi_io=2
      integer, parameter :: mpi_keyval_invalid=-1
      integer, parameter :: mpi_lastusedcode=5
      integer, parameter :: mpi_lock_exclusive=1
      integer, parameter :: mpi_lock_shared=2
      integer, parameter :: mpi_mode_nocheck=1
      integer, parameter :: mpi_mode_noprecede=2
      integer, parameter :: mpi_mode_noput=4
      integer, parameter :: mpi_mode_nostore=8
      integer, parameter :: mpi_mode_nosucceed=16
      integer, parameter :: mpi_order_c=0
      integer, parameter :: mpi_order_fortran=1
      integer, parameter :: mpi_proc_null=-2
      integer, parameter :: mpi_root=-4
      integer, parameter :: mpi_similar=2
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_subversion=1
      integer, parameter :: mpi_success=0
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_tag_ub=0
      integer, parameter :: mpi_thread_funneled=1
      integer, parameter :: mpi_thread_multiple=3
      integer, parameter :: mpi_thread_serialized=2
      integer, parameter :: mpi_thread_single=0
      integer, parameter :: mpi_typeclass_complex=3
      integer, parameter :: mpi_typeclass_integer=1
      integer, parameter :: mpi_typeclass_real=2
      integer, parameter :: mpi_t_err_cannot_init=56
      integer, parameter :: mpi_t_err_cvar_set_never=64
      integer, parameter :: mpi_t_err_cvar_set_not_now=63
      integer, parameter :: mpi_t_err_invalid=72
      integer, parameter :: mpi_t_err_invalid_handle=59
      integer, parameter :: mpi_t_err_invalid_index=57
      integer, parameter :: mpi_t_err_invalid_item=58
      integer, parameter :: mpi_t_err_invalid_session=62
      integer, parameter :: mpi_t_err_memory=54
      integer, parameter :: mpi_t_err_not_initialized=55
      integer, parameter :: mpi_t_err_out_of_handles=60
      integer, parameter :: mpi_t_err_out_of_sessions=61
      integer, parameter :: mpi_t_err_pvar_no_atomic=67
      integer, parameter :: mpi_t_err_pvar_no_startstop=65
      integer, parameter :: mpi_t_err_pvar_no_write=66
      integer, parameter :: mpi_undefined=-32766
      integer, parameter :: mpi_unequal=3
      integer, parameter :: mpi_universe_size=6
      integer, parameter :: mpi_version=3
      integer, parameter :: mpi_win_base=7
      integer, parameter :: mpi_win_create_flavor=10
      integer, parameter :: mpi_win_disp_unit=9
      integer, parameter :: mpi_win_flavor_allocate=2
      integer, parameter :: mpi_win_flavor_create=1
      integer, parameter :: mpi_win_flavor_dynamic=3
      integer, parameter :: mpi_win_flavor_shared=4
      integer, parameter :: mpi_win_model=11
      integer, parameter :: mpi_win_separate=1
      integer, parameter :: mpi_win_size=8
      integer, parameter :: mpi_win_unified=0
      integer, parameter :: mpi_wtime_is_global=3
      integer, parameter :: ompi_comm_type_board=8
      integer, parameter :: ompi_comm_type_cluster=11
      integer, parameter :: ompi_comm_type_core=2
      integer, parameter :: ompi_comm_type_cu=10
      integer, parameter :: ompi_comm_type_host=9
      integer, parameter :: ompi_comm_type_hwthread=1
      integer, parameter :: ompi_comm_type_l1cache=3
      integer, parameter :: ompi_comm_type_l2cache=4
      integer, parameter :: ompi_comm_type_l3cache=5
      integer, parameter :: ompi_comm_type_node=0
      integer, parameter :: ompi_comm_type_numa=7
      integer, parameter :: ompi_comm_type_socket=6
      integer, parameter :: mpi_2complex=26
      integer, parameter :: mpi_2double_complex=27
      integer, parameter :: mpi_2double_precision=24
      integer, parameter :: mpi_2int=52
      integer, parameter :: mpi_2integer=25
      integer, parameter :: mpi_2real=23
      integer, parameter :: mpi_aint=66
      integer, parameter :: mpi_band=6
      integer, parameter :: mpi_bor=8
      integer, parameter :: mpi_bxor=10
      integer, parameter :: mpi_byte=1
      integer, parameter :: mpi_char=34
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_comm_null=2
      integer, parameter :: mpi_comm_self=1
      integer, parameter :: mpi_comm_world=0
      integer, parameter :: mpi_complex=18
      integer, parameter :: mpi_complex16=20
      integer, parameter :: mpi_complex32=21
      integer, parameter :: mpi_complex8=19
      integer, parameter :: mpi_count=72
      integer, parameter :: mpi_cxx_bool=54
      integer, parameter :: mpi_cxx_complex=55
      integer, parameter :: mpi_cxx_double_complex=56
      integer, parameter :: mpi_cxx_float_complex=55
      integer, parameter :: mpi_cxx_long_double_complex=57
      integer, parameter :: mpi_c_bool=68
      integer, parameter :: mpi_c_complex=69
      integer, parameter :: mpi_c_double_complex=70
      integer, parameter :: mpi_c_float_complex=69
      integer, parameter :: mpi_c_long_double_complex=71
      integer, parameter :: mpi_datatype_null=0
      integer, parameter :: mpi_double=46
      integer, parameter :: mpi_double_complex=22
      integer, parameter :: mpi_double_int=49
      integer, parameter :: mpi_double_precision=17
      integer, parameter :: mpi_errhandler_null=0
      integer, parameter :: mpi_errors_are_fatal=1
      integer, parameter :: mpi_errors_return=2
      integer, parameter :: mpi_float=45
      integer, parameter :: mpi_float_int=48
      integer, parameter :: mpi_group_empty=1
      integer, parameter :: mpi_group_null=0
      integer, parameter :: mpi_info_env=1
      integer, parameter :: mpi_info_null=0
      integer, parameter :: mpi_int=39
      integer, parameter :: mpi_int16_t=60
      integer, parameter :: mpi_int32_t=62
      integer, parameter :: mpi_int64_t=64
      integer, parameter :: mpi_int8_t=58
      integer, parameter :: mpi_integer=7
      integer, parameter :: mpi_integer1=8
      integer, parameter :: mpi_integer16=12
      integer, parameter :: mpi_integer2=9
      integer, parameter :: mpi_integer4=10
      integer, parameter :: mpi_integer8=11
      integer, parameter :: mpi_land=5
      integer, parameter :: mpi_lb=4
      integer, parameter :: mpi_logical=6
      integer, parameter :: mpi_logical1=29
      integer, parameter :: mpi_logical2=30
      integer, parameter :: mpi_logical4=31
      integer, parameter :: mpi_logical8=32
      integer, parameter :: mpi_long=41
      integer, parameter :: mpi_long_double=47
      integer, parameter :: mpi_long_double_int=50
      integer, parameter :: mpi_long_int=51
      integer, parameter :: mpi_long_long=43
      integer, parameter :: mpi_long_long_int=43
      integer, parameter :: mpi_lor=7
      integer, parameter :: mpi_lxor=9
      integer, parameter :: mpi_max=1
      integer, parameter :: mpi_maxloc=11
      integer, parameter :: mpi_message_no_proc=1
      integer, parameter :: mpi_message_null=0
      integer, parameter :: mpi_min=2
      integer, parameter :: mpi_minloc=12
      integer, parameter :: mpi_no_op=14
      integer, parameter :: mpi_offset=67
      integer, parameter :: mpi_op_null=0
      integer, parameter :: mpi_packed=2
      integer, parameter :: mpi_prod=4
      integer, parameter :: mpi_real=13
      integer, parameter :: mpi_real16=16
      integer, parameter :: mpi_real2=28
      integer, parameter :: mpi_real4=14
      integer, parameter :: mpi_real8=15
      integer, parameter :: mpi_replace=13
      integer, parameter :: mpi_request_null=0
      integer, parameter :: mpi_short=37
      integer, parameter :: mpi_short_int=53
      integer, parameter :: mpi_signed_char=36
      integer, parameter :: mpi_sum=3
      integer, parameter :: mpi_ub=3
      integer, parameter :: mpi_uint16_t=61
      integer, parameter :: mpi_uint32_t=63
      integer, parameter :: mpi_uint64_t=65
      integer, parameter :: mpi_uint8_t=59
      integer, parameter :: mpi_unsigned=40
      integer, parameter :: mpi_unsigned_char=35
      integer, parameter :: mpi_unsigned_long=42
      integer, parameter :: mpi_unsigned_long_long=44
      integer, parameter :: mpi_unsigned_short=38
      integer, parameter :: mpi_wchar=33
      integer, parameter :: mpi_win_null=0
      integer, parameter :: mpi_mode_append=128
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_delete_on_close=16
      integer, parameter :: mpi_mode_excl=64
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_rdwr=8
      integer, parameter :: mpi_mode_sequential=256
      integer, parameter :: mpi_mode_unique_open=32
      integer, parameter :: mpi_mode_wronly=4
      integer, parameter :: mpi_seek_cur=602
      integer, parameter :: mpi_seek_end=604
      integer, parameter :: mpi_seek_set=600
      integer, parameter :: mpi_displacement_current=-54278278
      integer, parameter :: mpi_file_null=0
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2014 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2017      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 
!  Do ***not*** copy this file to the directory where your Fortran
!  fortran application is compiled unless it is absolutely necessary!  Most
!  modern Fortran compilers now support the -I command line flag, which
!  tells the compiler where to find .h files (specifically, this one).  For
!  example:
! 
!       shell$ mpifort foo.f -o foo -I$OMPI_HOME/include
! 
!  will probably do the trick (assuming that you have set OMPI_HOME
!  properly).
! 
!  That being said, OMPI's "mpifort" wrapper compiler should
!  automatically include the -I option for you.  The following command
!  should be equivalent to the command listed above:
! 
!       shell$ mpifort foo.f -o foo
! 
!  You should not copy this file to your local directory because it is
!  possible that this file will be changed between versions of Open MPI.
!  Indeed, this mpif.h is incompatible with the mpif.f of other
!  implementations of MPI.  Using this mpif.h with other implementations
!  of MPI, or with other versions of Open MPI will result in undefined
!  behavior (to include incorrect results, segmentation faults,
!  unexplainable "hanging" in your application, etc.).  Always use the
!  -I command line option instead (or let mpifort do it for you).
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!       include 'mpif-config.h'
!       include 'mpif-constants.h'
!       include 'mpif-handles.h'
!       include 'mpif-io-constants.h'
!       include 'mpif-io-handles.h'
!       include 'mpif-externals.h'
!       include 'mpif-sentinels.h'
!       include 'mpif-sizeof.h'
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
!  Copyright (c) 2013      Los Alamos National Security, LLC. All rights
!                          reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      This file contains the output from configure that is relevant for
!      Fortran applications and a few values that are necessary to
!      compile the Fortran modules (e.g., MPI_STATUS_SIZE).
! 
! 
!      OMPI version
!      This file is generated from configure; do not edit it manually.
! 
! 
!      Kind parameters
! 
! 
!      Miscellaneous constants
! 
! 
!      Configurable length constants
! 
! 
!  MPI F08 conformance
! 
      ! hard-coded for .false. for now
      ! hard-coded for .false. for now
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      These "external" statements are specific to the MPI mpif.h
!      interface (and are toxic to the MPI module interfaces),.
! 
      external mpi_null_copy_fn, mpi_null_delete_fn
      external mpi_comm_null_copy_fn, mpi_comm_null_delete_fn
      external mpi_type_null_copy_fn, mpi_type_null_delete_fn
      external mpi_dup_fn, mpi_comm_dup_fn, mpi_type_dup_fn
      external mpi_win_null_copy_fn
      external mpi_win_null_delete_fn
      external mpi_win_dup_fn
!      Note that MPI_CONVERSION_FN_NULL is a "constant" (it is only ever
!      checked for comparison; it is never invoked), but it is passed as
!      a function pointer (to MPI_REGISTER_DATAREP) and therefore must be
!      the same size/type.  It is therefore external'ed here, and not
!      defined with an integer value in mpif-common.h.
      external mpi_conversion_fn_null
! 
!      double precision functions
! 
      external mpi_wtime, mpi_wtick , pmpi_wtick, pmpi_wtime
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: nid
      integer :: np
      real(kind=8) :: mpi_wtick
      real(kind=8) :: pmpi_wtick
      real(kind=8) :: pmpi_wtime
! 
!      address integer functions
! 
      external mpi_aint_add, mpi_aint_diff
      integer :: mpi_aint_add
      integer :: mpi_aint_diff
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      All of these types were chosen with care to match the types of
!      their corresponding C variables.  Do not arbitrarily change
!      their types without also updating:
! 
!      - the "mpi" module bindings
!      - the "mpi_f08" module bindings
!      - ompi/mpi/fortran/base/gen-mpi-mangling.pl
! 
!      MPI_BOTTOM is only used where choice buffers can be used (meaning
!      that we already have overloaded F90 bindings for all available
!      types), so any type is fine.
      integer :: mpi_bottom
!      MPI_IN_PLACE has the same rationale as MPI_BOTTOM.
      integer :: mpi_in_place
!      Making MPI_ARGV_NULL be the same type as the parameter that is
!      exepected in the F90 binding for MPI_COMM_SPAWN means that we
!      don't need another interface for MPI_COMM_SPAWN.
      character, dimension(1:1) :: mpi_argv_null
!      Ditto for MPI_ARGVS_NULL / MPI_COMM_SPAWN_MULTIPLE.
      character, dimension(1:1,1:1) :: mpi_argvs_null
!      MPI_ERRCODES_IGNORE has similar rationale to MPI_ARGV_NULL.  The
!      F77 functions are all smart enough to check that the errcodes
!      parameter is not ERRCODES_IGNORE before assigning values into it
!      (hence, the fact that this is an array of only 1 element does not
!      matter -- we'll never overrun it because we never assign values
!      into it).
      integer, dimension(1:1) :: mpi_errcodes_ignore
!      MPI_STATUS_IGNORE has similar rationale to MPI_ERRCODES_IGNORE.
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
!      Ditto for MPI_STATUSES_IGNORE
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
!      Ditto for MPI_UNWEIGHTED
      integer, dimension(1:1) :: mpi_unweighted
!      Ditto for MPI_WEIGHTS_EMPTY
      integer, dimension(1:1) :: mpi_weights_empty
!  -*- f90 -*-
!  WARNING: This is a generated file!  Edits will be lost!
! 
!  Copyright (c) 2014 Cisco Systems, Inc.  All rights reserved.
! $COPYRIGHT$
! 
!  This file was generated by gen-mpi-sizeof.pl for all the MPI_SIZEOF
!  interface possibilities for intrinsic types.  Once TS 29113 is
!  supported in all compilers, we can simply have *one* procedure for
!  each type and use dimension(..) to indicate scalars+all array ranks.
!  But until more compilers support this, we simply generate a
!  procedure for scalars and all possible ranks in an attempt to
!  support lots of Fortran compilers.
      interface mpi_sizeof
! 
      call nekgsync(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place, &
      mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nekcomm,nekgroup, &
      nekreal,nid,np)
      dnekclock_sync = mpi_wtime()
! 
      return
      end function dnekclock_sync
      subroutine nekgsync(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place, &
      mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nekcomm,nekgroup, &
      nekreal,nid,np)
      implicit none
      integer, parameter :: ompi_major_version=4
      integer, parameter :: ompi_minor_version=0
      integer, parameter :: ompi_release_version=1
      integer, parameter :: mpi_integer_kind=4
      integer, parameter :: mpi_address_kind=8
      integer, parameter :: mpi_offset_kind=8
      integer, parameter :: mpi_count_kind=8
      integer, parameter :: mpi_status_size=6
      integer, parameter :: mpi_max_processor_name=256-1
      integer, parameter :: mpi_max_error_string=256-1
      integer, parameter :: mpi_max_object_name=64-1
      integer, parameter :: mpi_max_library_version_string=256-1
      integer, parameter :: mpi_max_info_key=36-1
      integer, parameter :: mpi_max_info_val=256-1
      integer, parameter :: mpi_max_port_name=1024-1
      integer, parameter :: mpi_max_datarep_string=128-1
      logical, parameter :: mpi_subarrays_supported=.false.
      logical, parameter :: mpi_async_protects_nonblocking=.false.
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
      integer, parameter :: mpi_appnum=4
      integer, parameter :: mpi_bsend_overhead=128
      integer, parameter :: mpi_cart=1
      integer, parameter :: mpi_combiner_contiguous=2
      integer, parameter :: mpi_combiner_darray=13
      integer, parameter :: mpi_combiner_dup=1
      integer, parameter :: mpi_combiner_f90_complex=15
      integer, parameter :: mpi_combiner_f90_integer=16
      integer, parameter :: mpi_combiner_f90_real=14
      integer, parameter :: mpi_combiner_hindexed=8
      integer, parameter :: mpi_combiner_hindexed_block=18
      integer, parameter :: mpi_combiner_hindexed_integer=7
      integer, parameter :: mpi_combiner_hvector=5
      integer, parameter :: mpi_combiner_hvector_integer=4
      integer, parameter :: mpi_combiner_indexed=6
      integer, parameter :: mpi_combiner_indexed_block=9
      integer, parameter :: mpi_combiner_named=0
      integer, parameter :: mpi_combiner_resized=17
      integer, parameter :: mpi_combiner_struct=11
      integer, parameter :: mpi_combiner_struct_integer=10
      integer, parameter :: mpi_combiner_subarray=12
      integer, parameter :: mpi_combiner_vector=3
      integer, parameter :: mpi_comm_type_shared=0
      integer, parameter :: mpi_congruent=1
      integer, parameter :: mpi_distribute_block=0
      integer, parameter :: mpi_distribute_cyclic=1
      integer, parameter :: mpi_distribute_dflt_darg=-1
      integer, parameter :: mpi_distribute_none=2
      integer, parameter :: mpi_dist_graph=3
      integer, parameter :: mpi_error=3
      integer, parameter :: mpi_err_access=20
      integer, parameter :: mpi_err_amode=21
      integer, parameter :: mpi_err_arg=13
      integer, parameter :: mpi_err_assert=22
      integer, parameter :: mpi_err_bad_file=23
      integer, parameter :: mpi_err_base=24
      integer, parameter :: mpi_err_buffer=1
      integer, parameter :: mpi_err_comm=5
      integer, parameter :: mpi_err_conversion=25
      integer, parameter :: mpi_err_count=2
      integer, parameter :: mpi_err_dims=12
      integer, parameter :: mpi_err_disp=26
      integer, parameter :: mpi_err_dup_datarep=27
      integer, parameter :: mpi_err_file=30
      integer, parameter :: mpi_err_file_exists=28
      integer, parameter :: mpi_err_file_in_use=29
      integer, parameter :: mpi_err_group=9
      integer, parameter :: mpi_err_info=34
      integer, parameter :: mpi_err_info_key=31
      integer, parameter :: mpi_err_info_nokey=32
      integer, parameter :: mpi_err_info_value=33
      integer, parameter :: mpi_err_intern=17
      integer, parameter :: mpi_err_in_status=18
      integer, parameter :: mpi_err_io=35
      integer, parameter :: mpi_err_keyval=36
      integer, parameter :: mpi_err_lastcode=92
      integer, parameter :: mpi_err_locktype=37
      integer, parameter :: mpi_err_name=38
      integer, parameter :: mpi_err_not_same=40
      integer, parameter :: mpi_err_no_mem=39
      integer, parameter :: mpi_err_no_space=41
      integer, parameter :: mpi_err_no_such_file=42
      integer, parameter :: mpi_err_op=10
      integer, parameter :: mpi_err_other=16
      integer, parameter :: mpi_err_pending=19
      integer, parameter :: mpi_err_port=43
      integer, parameter :: mpi_err_quota=44
      integer, parameter :: mpi_err_rank=6
      integer, parameter :: mpi_err_read_only=45
      integer, parameter :: mpi_err_request=7
      integer, parameter :: mpi_err_rma_attach=69
      integer, parameter :: mpi_err_rma_conflict=46
      integer, parameter :: mpi_err_rma_flavor=70
      integer, parameter :: mpi_err_rma_range=68
      integer, parameter :: mpi_err_rma_shared=71
      integer, parameter :: mpi_err_rma_sync=47
      integer, parameter :: mpi_err_root=8
      integer, parameter :: mpi_err_service=48
      integer, parameter :: mpi_err_size=49
      integer, parameter :: mpi_err_spawn=50
      integer, parameter :: mpi_err_tag=4
      integer, parameter :: mpi_err_topology=11
      integer, parameter :: mpi_err_truncate=15
      integer, parameter :: mpi_err_type=3
      integer, parameter :: mpi_err_unknown=14
      integer, parameter :: mpi_err_unsupported_datarep=51
      integer, parameter :: mpi_err_unsupported_operation=52
      integer, parameter :: mpi_err_win=53
      integer, parameter :: mpi_graph=2
      integer, parameter :: mpi_host=1
      integer, parameter :: mpi_ident=0
      integer, parameter :: mpi_io=2
      integer, parameter :: mpi_keyval_invalid=-1
      integer, parameter :: mpi_lastusedcode=5
      integer, parameter :: mpi_lock_exclusive=1
      integer, parameter :: mpi_lock_shared=2
      integer, parameter :: mpi_mode_nocheck=1
      integer, parameter :: mpi_mode_noprecede=2
      integer, parameter :: mpi_mode_noput=4
      integer, parameter :: mpi_mode_nostore=8
      integer, parameter :: mpi_mode_nosucceed=16
      integer, parameter :: mpi_order_c=0
      integer, parameter :: mpi_order_fortran=1
      integer, parameter :: mpi_proc_null=-2
      integer, parameter :: mpi_root=-4
      integer, parameter :: mpi_similar=2
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_subversion=1
      integer, parameter :: mpi_success=0
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_tag_ub=0
      integer, parameter :: mpi_thread_funneled=1
      integer, parameter :: mpi_thread_multiple=3
      integer, parameter :: mpi_thread_serialized=2
      integer, parameter :: mpi_thread_single=0
      integer, parameter :: mpi_typeclass_complex=3
      integer, parameter :: mpi_typeclass_integer=1
      integer, parameter :: mpi_typeclass_real=2
      integer, parameter :: mpi_t_err_cannot_init=56
      integer, parameter :: mpi_t_err_cvar_set_never=64
      integer, parameter :: mpi_t_err_cvar_set_not_now=63
      integer, parameter :: mpi_t_err_invalid=72
      integer, parameter :: mpi_t_err_invalid_handle=59
      integer, parameter :: mpi_t_err_invalid_index=57
      integer, parameter :: mpi_t_err_invalid_item=58
      integer, parameter :: mpi_t_err_invalid_session=62
      integer, parameter :: mpi_t_err_memory=54
      integer, parameter :: mpi_t_err_not_initialized=55
      integer, parameter :: mpi_t_err_out_of_handles=60
      integer, parameter :: mpi_t_err_out_of_sessions=61
      integer, parameter :: mpi_t_err_pvar_no_atomic=67
      integer, parameter :: mpi_t_err_pvar_no_startstop=65
      integer, parameter :: mpi_t_err_pvar_no_write=66
      integer, parameter :: mpi_undefined=-32766
      integer, parameter :: mpi_unequal=3
      integer, parameter :: mpi_universe_size=6
      integer, parameter :: mpi_version=3
      integer, parameter :: mpi_win_base=7
      integer, parameter :: mpi_win_create_flavor=10
      integer, parameter :: mpi_win_disp_unit=9
      integer, parameter :: mpi_win_flavor_allocate=2
      integer, parameter :: mpi_win_flavor_create=1
      integer, parameter :: mpi_win_flavor_dynamic=3
      integer, parameter :: mpi_win_flavor_shared=4
      integer, parameter :: mpi_win_model=11
      integer, parameter :: mpi_win_separate=1
      integer, parameter :: mpi_win_size=8
      integer, parameter :: mpi_win_unified=0
      integer, parameter :: mpi_wtime_is_global=3
      integer, parameter :: ompi_comm_type_board=8
      integer, parameter :: ompi_comm_type_cluster=11
      integer, parameter :: ompi_comm_type_core=2
      integer, parameter :: ompi_comm_type_cu=10
      integer, parameter :: ompi_comm_type_host=9
      integer, parameter :: ompi_comm_type_hwthread=1
      integer, parameter :: ompi_comm_type_l1cache=3
      integer, parameter :: ompi_comm_type_l2cache=4
      integer, parameter :: ompi_comm_type_l3cache=5
      integer, parameter :: ompi_comm_type_node=0
      integer, parameter :: ompi_comm_type_numa=7
      integer, parameter :: ompi_comm_type_socket=6
      integer, parameter :: mpi_2complex=26
      integer, parameter :: mpi_2double_complex=27
      integer, parameter :: mpi_2double_precision=24
      integer, parameter :: mpi_2int=52
      integer, parameter :: mpi_2integer=25
      integer, parameter :: mpi_2real=23
      integer, parameter :: mpi_aint=66
      integer, parameter :: mpi_band=6
      integer, parameter :: mpi_bor=8
      integer, parameter :: mpi_bxor=10
      integer, parameter :: mpi_byte=1
      integer, parameter :: mpi_char=34
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_comm_null=2
      integer, parameter :: mpi_comm_self=1
      integer, parameter :: mpi_comm_world=0
      integer, parameter :: mpi_complex=18
      integer, parameter :: mpi_complex16=20
      integer, parameter :: mpi_complex32=21
      integer, parameter :: mpi_complex8=19
      integer, parameter :: mpi_count=72
      integer, parameter :: mpi_cxx_bool=54
      integer, parameter :: mpi_cxx_complex=55
      integer, parameter :: mpi_cxx_double_complex=56
      integer, parameter :: mpi_cxx_float_complex=55
      integer, parameter :: mpi_cxx_long_double_complex=57
      integer, parameter :: mpi_c_bool=68
      integer, parameter :: mpi_c_complex=69
      integer, parameter :: mpi_c_double_complex=70
      integer, parameter :: mpi_c_float_complex=69
      integer, parameter :: mpi_c_long_double_complex=71
      integer, parameter :: mpi_datatype_null=0
      integer, parameter :: mpi_double=46
      integer, parameter :: mpi_double_complex=22
      integer, parameter :: mpi_double_int=49
      integer, parameter :: mpi_double_precision=17
      integer, parameter :: mpi_errhandler_null=0
      integer, parameter :: mpi_errors_are_fatal=1
      integer, parameter :: mpi_errors_return=2
      integer, parameter :: mpi_float=45
      integer, parameter :: mpi_float_int=48
      integer, parameter :: mpi_group_empty=1
      integer, parameter :: mpi_group_null=0
      integer, parameter :: mpi_info_env=1
      integer, parameter :: mpi_info_null=0
      integer, parameter :: mpi_int=39
      integer, parameter :: mpi_int16_t=60
      integer, parameter :: mpi_int32_t=62
      integer, parameter :: mpi_int64_t=64
      integer, parameter :: mpi_int8_t=58
      integer, parameter :: mpi_integer=7
      integer, parameter :: mpi_integer1=8
      integer, parameter :: mpi_integer16=12
      integer, parameter :: mpi_integer2=9
      integer, parameter :: mpi_integer4=10
      integer, parameter :: mpi_integer8=11
      integer, parameter :: mpi_land=5
      integer, parameter :: mpi_lb=4
      integer, parameter :: mpi_logical=6
      integer, parameter :: mpi_logical1=29
      integer, parameter :: mpi_logical2=30
      integer, parameter :: mpi_logical4=31
      integer, parameter :: mpi_logical8=32
      integer, parameter :: mpi_long=41
      integer, parameter :: mpi_long_double=47
      integer, parameter :: mpi_long_double_int=50
      integer, parameter :: mpi_long_int=51
      integer, parameter :: mpi_long_long=43
      integer, parameter :: mpi_long_long_int=43
      integer, parameter :: mpi_lor=7
      integer, parameter :: mpi_lxor=9
      integer, parameter :: mpi_max=1
      integer, parameter :: mpi_maxloc=11
      integer, parameter :: mpi_message_no_proc=1
      integer, parameter :: mpi_message_null=0
      integer, parameter :: mpi_min=2
      integer, parameter :: mpi_minloc=12
      integer, parameter :: mpi_no_op=14
      integer, parameter :: mpi_offset=67
      integer, parameter :: mpi_op_null=0
      integer, parameter :: mpi_packed=2
      integer, parameter :: mpi_prod=4
      integer, parameter :: mpi_real=13
      integer, parameter :: mpi_real16=16
      integer, parameter :: mpi_real2=28
      integer, parameter :: mpi_real4=14
      integer, parameter :: mpi_real8=15
      integer, parameter :: mpi_replace=13
      integer, parameter :: mpi_request_null=0
      integer, parameter :: mpi_short=37
      integer, parameter :: mpi_short_int=53
      integer, parameter :: mpi_signed_char=36
      integer, parameter :: mpi_sum=3
      integer, parameter :: mpi_ub=3
      integer, parameter :: mpi_uint16_t=61
      integer, parameter :: mpi_uint32_t=63
      integer, parameter :: mpi_uint64_t=65
      integer, parameter :: mpi_uint8_t=59
      integer, parameter :: mpi_unsigned=40
      integer, parameter :: mpi_unsigned_char=35
      integer, parameter :: mpi_unsigned_long=42
      integer, parameter :: mpi_unsigned_long_long=44
      integer, parameter :: mpi_unsigned_short=38
      integer, parameter :: mpi_wchar=33
      integer, parameter :: mpi_win_null=0
      integer, parameter :: mpi_mode_append=128
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_delete_on_close=16
      integer, parameter :: mpi_mode_excl=64
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_rdwr=8
      integer, parameter :: mpi_mode_sequential=256
      integer, parameter :: mpi_mode_unique_open=32
      integer, parameter :: mpi_mode_wronly=4
      integer, parameter :: mpi_seek_cur=602
      integer, parameter :: mpi_seek_end=604
      integer, parameter :: mpi_seek_set=600
      integer, parameter :: mpi_displacement_current=-54278278
      integer, parameter :: mpi_file_null=0
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2014 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2017      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 
!  Do ***not*** copy this file to the directory where your Fortran
!  fortran application is compiled unless it is absolutely necessary!  Most
!  modern Fortran compilers now support the -I command line flag, which
!  tells the compiler where to find .h files (specifically, this one).  For
!  example:
! 
!       shell$ mpifort foo.f -o foo -I$OMPI_HOME/include
! 
!  will probably do the trick (assuming that you have set OMPI_HOME
!  properly).
! 
!  That being said, OMPI's "mpifort" wrapper compiler should
!  automatically include the -I option for you.  The following command
!  should be equivalent to the command listed above:
! 
!       shell$ mpifort foo.f -o foo
! 
!  You should not copy this file to your local directory because it is
!  possible that this file will be changed between versions of Open MPI.
!  Indeed, this mpif.h is incompatible with the mpif.f of other
!  implementations of MPI.  Using this mpif.h with other implementations
!  of MPI, or with other versions of Open MPI will result in undefined
!  behavior (to include incorrect results, segmentation faults,
!  unexplainable "hanging" in your application, etc.).  Always use the
!  -I command line option instead (or let mpifort do it for you).
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!       include 'mpif-config.h'
!       include 'mpif-constants.h'
!       include 'mpif-handles.h'
!       include 'mpif-io-constants.h'
!       include 'mpif-io-handles.h'
!       include 'mpif-externals.h'
!       include 'mpif-sentinels.h'
!       include 'mpif-sizeof.h'
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
!  Copyright (c) 2013      Los Alamos National Security, LLC. All rights
!                          reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      This file contains the output from configure that is relevant for
!      Fortran applications and a few values that are necessary to
!      compile the Fortran modules (e.g., MPI_STATUS_SIZE).
! 
! 
!      OMPI version
!      This file is generated from configure; do not edit it manually.
! 
! 
!      Kind parameters
! 
! 
!      Miscellaneous constants
! 
! 
!      Configurable length constants
! 
! 
!  MPI F08 conformance
! 
      ! hard-coded for .false. for now
      ! hard-coded for .false. for now
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      These "external" statements are specific to the MPI mpif.h
!      interface (and are toxic to the MPI module interfaces),.
! 
      external mpi_null_copy_fn, mpi_null_delete_fn
      external mpi_comm_null_copy_fn, mpi_comm_null_delete_fn
      external mpi_type_null_copy_fn, mpi_type_null_delete_fn
      external mpi_dup_fn, mpi_comm_dup_fn, mpi_type_dup_fn
      external mpi_win_null_copy_fn
      external mpi_win_null_delete_fn
      external mpi_win_dup_fn
!      Note that MPI_CONVERSION_FN_NULL is a "constant" (it is only ever
!      checked for comparison; it is never invoked), but it is passed as
!      a function pointer (to MPI_REGISTER_DATAREP) and therefore must be
!      the same size/type.  It is therefore external'ed here, and not
!      defined with an integer value in mpif-common.h.
      external mpi_conversion_fn_null
! 
!      double precision functions
! 
      external mpi_wtime, mpi_wtick , pmpi_wtick, pmpi_wtime
      integer, intent(In) :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: nid
      integer :: np
      integer :: ierr
      real(kind=8) :: mpi_wtick
      real(kind=8) :: pmpi_wtick
      real(kind=8) :: pmpi_wtime
! 
!      address integer functions
! 
      external mpi_aint_add, mpi_aint_diff
      integer :: mpi_aint_add
      integer :: mpi_aint_diff
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      All of these types were chosen with care to match the types of
!      their corresponding C variables.  Do not arbitrarily change
!      their types without also updating:
! 
!      - the "mpi" module bindings
!      - the "mpi_f08" module bindings
!      - ompi/mpi/fortran/base/gen-mpi-mangling.pl
! 
!      MPI_BOTTOM is only used where choice buffers can be used (meaning
!      that we already have overloaded F90 bindings for all available
!      types), so any type is fine.
      integer :: mpi_bottom
!      MPI_IN_PLACE has the same rationale as MPI_BOTTOM.
      integer :: mpi_in_place
!      Making MPI_ARGV_NULL be the same type as the parameter that is
!      exepected in the F90 binding for MPI_COMM_SPAWN means that we
!      don't need another interface for MPI_COMM_SPAWN.
      character, dimension(1:1) :: mpi_argv_null
!      Ditto for MPI_ARGVS_NULL / MPI_COMM_SPAWN_MULTIPLE.
      character, dimension(1:1,1:1) :: mpi_argvs_null
!      MPI_ERRCODES_IGNORE has similar rationale to MPI_ARGV_NULL.  The
!      F77 functions are all smart enough to check that the errcodes
!      parameter is not ERRCODES_IGNORE before assigning values into it
!      (hence, the fact that this is an array of only 1 element does not
!      matter -- we'll never overrun it because we never assign values
!      into it).
      integer, dimension(1:1) :: mpi_errcodes_ignore
!      MPI_STATUS_IGNORE has similar rationale to MPI_ERRCODES_IGNORE.
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
!      Ditto for MPI_STATUSES_IGNORE
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
!      Ditto for MPI_UNWEIGHTED
      integer, dimension(1:1) :: mpi_unweighted
!      Ditto for MPI_WEIGHTS_EMPTY
      integer, dimension(1:1) :: mpi_weights_empty
!  -*- f90 -*-
!  WARNING: This is a generated file!  Edits will be lost!
! 
!  Copyright (c) 2014 Cisco Systems, Inc.  All rights reserved.
! $COPYRIGHT$
! 
!  This file was generated by gen-mpi-sizeof.pl for all the MPI_SIZEOF
!  interface possibilities for intrinsic types.  Once TS 29113 is
!  supported in all compilers, we can simply have *one* procedure for
!  each type and use dimension(..) to indicate scalars+all array ranks.
!  But until more compilers support this, we simply generate a
!  procedure for scalars and all possible ranks in an attempt to
!  support lots of Fortran compilers.
      interface mpi_sizeof
      call mpi_barrier(nekcomm,ierr)

      return
      end subroutine nekgsync
      subroutine exitt(ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1,b1ia1t, &
      b1mask,b2mask,b2p,b3mask,baxm1,bbx1,bbx2,bby1,bby2,bbz1,bbz2,bc,bcf,bctyps,bd,bdivw,bfx, &
      bfxp,bfy,bfyp,bfz,bfzp,bintm1,binvdg,binvm1,bm1,bm1lag,bm2,bm2inv,bmass,bmnv,bmx,bmy,bmz, &
      bpmask,bq,bqp,bx,bxlag,by,bylag,bz,bzlag,c_vx,cbc,ccurve,cdof,cerror,cflf,courno,cpfld, &
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
      integer, parameter :: mpi_status_size=6
      real(kind=8), intent(In) :: etimes
      real(kind=8) :: etims0
      integer, intent(In) :: icall
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
      real(kind=8), intent(In) :: tprep
      real(kind=8) :: tpres
      real(kind=8) :: tproj
      real(kind=8) :: tschw
      real(kind=8) :: tsett
      real(kind=8) :: tslvb
      real(kind=8) :: tsolv
      real(kind=8) :: tspro
      real(kind=8) :: tsyc
      real(kind=8), intent(In) :: ttime
      real(kind=8), intent(InOut) :: ttotal
      real(kind=8) :: tttstp
      real(kind=8) :: tusbc
      real(kind=8) :: tusfq
      real(kind=8) :: tvdss
      real(kind=8) :: twal
      integer :: nio
      ! cvode
      ! nek-nek
      integer :: loglevel
      integer :: optlevel
      integer :: nelv
      integer :: nelt
      integer :: nfield
      integer :: npert
      integer, intent(In) :: nid
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
      logical, intent(In) :: ifneknek
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
      integer, intent(In) :: np
      integer :: nullpid
      integer :: node0
! 
!      Maximum number of elements (limited to 2**31/12, at least for now)
      integer(kind=8), intent(In) :: nvtot
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
      integer, intent(In) :: istep
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
      if (nid == 0) then
         write(6,*) ' '
         write(6,'(A)') 'an error occured: dying ...'
         write(6,*) ' '
      endif
!       call print_stack()
      call happy_check(0)

!       if (nid.eq.0) call close_files
      call print_runtime_info(ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1, &
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
      call nek_die(1,idsess,ldimr,loglevel,mpi_argv_null,mpi_argvs_null,mpi_bottom, &
      mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted, &
      mpi_weights_empty,ndim,nelt,nelv,nfield,nid,nio,npert,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1, &
      nz2,nz3,nzd,optlevel)
      return
      end subroutine exitt
      subroutine print_runtime_info(ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
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
      integer :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
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
      integer :: nio
      ! cvode
      ! nek-nek
      integer :: loglevel
      integer :: optlevel
      integer :: nelv
      integer :: nelt
      integer :: nfield
      integer :: npert
      integer, intent(In) :: nid
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
      integer, intent(In) :: np
      integer :: nullpid
      integer :: node0
! 
!      Maximum number of elements (limited to 2**31/12, at least for now)
      integer(kind=8), intent(In) :: nvtot
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
      integer, intent(In) :: istep
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
!      Timer variables
! 
      integer :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
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
      real(kind=8) :: tmxmf
      real(kind=8) :: tmxms
      real(kind=8) :: tdsum
      real(kind=8) :: taxhm
      real(kind=8) :: tcopy
      real(kind=8) :: tinvc
      real(kind=8) :: tinv3
      real(kind=8) :: tinit
      real(kind=8) :: tadc3
      real(kind=8) :: tcol3
      real(kind=8) :: ta2s2
      real(kind=8) :: tcol2
      real(kind=8) :: tadd2
! 
      real(kind=8) :: tsolv
      real(kind=8) :: tgsum
      real(kind=8) :: tdsnd
      real(kind=8) :: tdadd
      real(kind=8) :: tcdtp
      real(kind=8) :: tmltd
      real(kind=8), intent(In) :: tprep
      real(kind=8) :: tpres
      real(kind=8) :: thmhz
      real(kind=8) :: tgop
      real(kind=8) :: tgop1
      real(kind=8) :: tdott
      real(kind=8) :: tbsol
      real(kind=8) :: tbso2
      real(kind=8) :: tsett
      real(kind=8) :: tslvb
      real(kind=8) :: tusbc
      real(kind=8) :: tddsl
      real(kind=8) :: tcrsl
      real(kind=8) :: tdsmx
      real(kind=8) :: tdsmn
      real(kind=8) :: tgsmn
      real(kind=8) :: tgsmx
      real(kind=8) :: teslv
      real(kind=8) :: tbbbb
      real(kind=8) :: tcccc
      real(kind=8) :: tdddd
      real(kind=8) :: teeee
      real(kind=8) :: tvdss
      real(kind=8) :: tschw
      real(kind=8) :: tadvc
      real(kind=8) :: tspro
      real(kind=8) :: tgop_sync
      real(kind=8) :: tsyc
      real(kind=8) :: twal
      real(kind=8) :: tgp2
      real(kind=8) :: tcvf
      real(kind=8) :: tproj
      real(kind=8) :: tusfq
! 
      integer :: nmxmf
      integer :: nmxms
      integer :: ndsum
      integer :: naxhm
      integer :: ncopy
      integer :: ninvc
      integer :: ninv3
! 
      integer :: nsolv
      integer :: ngsum
      integer :: ndsnd
      integer :: ndadd
      integer :: ncdtp
      integer :: nmltd
      integer :: nprep
      integer :: npres
      integer :: nhmhz
      integer :: ngop
      integer :: ngop1
      integer :: ndott
      integer :: nbsol
      integer :: nbso2
      integer :: nsett
      integer :: nslvb
      integer :: nusbc
      integer :: nddsl
      integer :: ncrsl
      integer :: ndsmx
      integer :: ndsmn
      integer :: ngsmn
      integer :: ngsmx
      integer :: neslv
      integer :: nbbbb
      integer :: ncccc
      integer :: ndddd
      integer :: neeee
      integer :: nvdss
      integer :: nadvc
      integer :: nspro
      integer :: ngop_sync
      integer :: nsyc
      integer :: nwal
      integer :: ngp2
      integer :: ncvf
!    
      real(kind=8) :: pmxmf
      real(kind=8) :: pmxms
      real(kind=8) :: pdsum
      real(kind=8) :: paxhm
      real(kind=8) :: pcopy
      real(kind=8) :: pinvc
      real(kind=8) :: pinv3
      real(kind=8) :: psolv
      real(kind=8) :: pgsum
      real(kind=8) :: pdsnd
      real(kind=8) :: pdadd
      real(kind=8) :: pcdtp
      real(kind=8) :: pmltd
      real(kind=8) :: pprep
      real(kind=8) :: ppres
      real(kind=8) :: phmhz
      real(kind=8) :: pgop
      real(kind=8) :: pgop1
      real(kind=8) :: pdott
      real(kind=8) :: pbsol
      real(kind=8) :: pbso2
      real(kind=8) :: psett
      real(kind=8) :: pslvb
      real(kind=8) :: pusbc
      real(kind=8) :: pddsl
      real(kind=8) :: pcrsl
      real(kind=8) :: pdsmx
      real(kind=8) :: pdsmn
      real(kind=8) :: pgsmn
      real(kind=8) :: pgsmx
      real(kind=8) :: peslv
      real(kind=8) :: pbbbb
      real(kind=8) :: pcccc
      real(kind=8) :: pdddd
      real(kind=8) :: peeee
      real(kind=8) :: pvdss
      real(kind=8) :: pspro
      real(kind=8) :: pgop_sync
      real(kind=8) :: psyc
      real(kind=8) :: pwal
      real(kind=8) :: pgp2
      real(kind=8) :: etime1
      real(kind=8) :: etime2
      real(kind=8) :: etime0
      real(kind=8) :: gtime1
      real(kind=8) :: tscrtch
! 
! 
      real(kind=8), intent(In) :: etimes
      real(kind=8), intent(InOut) :: ttotal
      real(kind=8) :: tttstp
      real(kind=8) :: etims0
      real(kind=8), intent(In) :: ttime
! 
      integer :: icalld
      save    icalld
      data icalld / 0 / 
      logical :: ifsync
      integer, parameter :: ompi_major_version=4
      integer, parameter :: ompi_minor_version=0
      integer, parameter :: ompi_release_version=1
      integer, parameter :: mpi_integer_kind=4
      integer, parameter :: mpi_address_kind=8
      integer, parameter :: mpi_offset_kind=8
      integer, parameter :: mpi_count_kind=8
      integer, parameter :: mpi_status_size=6
      integer, parameter :: mpi_max_processor_name=256-1
      integer, parameter :: mpi_max_error_string=256-1
      integer, parameter :: mpi_max_object_name=64-1
      integer, parameter :: mpi_max_library_version_string=256-1
      integer, parameter :: mpi_max_info_key=36-1
      integer, parameter :: mpi_max_info_val=256-1
      integer, parameter :: mpi_max_port_name=1024-1
      integer, parameter :: mpi_max_datarep_string=128-1
      logical, parameter :: mpi_subarrays_supported=.false.
      logical, parameter :: mpi_async_protects_nonblocking=.false.
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
      integer, parameter :: mpi_appnum=4
      integer, parameter :: mpi_bsend_overhead=128
      integer, parameter :: mpi_cart=1
      integer, parameter :: mpi_combiner_contiguous=2
      integer, parameter :: mpi_combiner_darray=13
      integer, parameter :: mpi_combiner_dup=1
      integer, parameter :: mpi_combiner_f90_complex=15
      integer, parameter :: mpi_combiner_f90_integer=16
      integer, parameter :: mpi_combiner_f90_real=14
      integer, parameter :: mpi_combiner_hindexed=8
      integer, parameter :: mpi_combiner_hindexed_block=18
      integer, parameter :: mpi_combiner_hindexed_integer=7
      integer, parameter :: mpi_combiner_hvector=5
      integer, parameter :: mpi_combiner_hvector_integer=4
      integer, parameter :: mpi_combiner_indexed=6
      integer, parameter :: mpi_combiner_indexed_block=9
      integer, parameter :: mpi_combiner_named=0
      integer, parameter :: mpi_combiner_resized=17
      integer, parameter :: mpi_combiner_struct=11
      integer, parameter :: mpi_combiner_struct_integer=10
      integer, parameter :: mpi_combiner_subarray=12
      integer, parameter :: mpi_combiner_vector=3
      integer, parameter :: mpi_comm_type_shared=0
      integer, parameter :: mpi_congruent=1
      integer, parameter :: mpi_distribute_block=0
      integer, parameter :: mpi_distribute_cyclic=1
      integer, parameter :: mpi_distribute_dflt_darg=-1
      integer, parameter :: mpi_distribute_none=2
      integer, parameter :: mpi_dist_graph=3
      integer, parameter :: mpi_error=3
      integer, parameter :: mpi_err_access=20
      integer, parameter :: mpi_err_amode=21
      integer, parameter :: mpi_err_arg=13
      integer, parameter :: mpi_err_assert=22
      integer, parameter :: mpi_err_bad_file=23
      integer, parameter :: mpi_err_base=24
      integer, parameter :: mpi_err_buffer=1
      integer, parameter :: mpi_err_comm=5
      integer, parameter :: mpi_err_conversion=25
      integer, parameter :: mpi_err_count=2
      integer, parameter :: mpi_err_dims=12
      integer, parameter :: mpi_err_disp=26
      integer, parameter :: mpi_err_dup_datarep=27
      integer, parameter :: mpi_err_file=30
      integer, parameter :: mpi_err_file_exists=28
      integer, parameter :: mpi_err_file_in_use=29
      integer, parameter :: mpi_err_group=9
      integer, parameter :: mpi_err_info=34
      integer, parameter :: mpi_err_info_key=31
      integer, parameter :: mpi_err_info_nokey=32
      integer, parameter :: mpi_err_info_value=33
      integer, parameter :: mpi_err_intern=17
      integer, parameter :: mpi_err_in_status=18
      integer, parameter :: mpi_err_io=35
      integer, parameter :: mpi_err_keyval=36
      integer, parameter :: mpi_err_lastcode=92
      integer, parameter :: mpi_err_locktype=37
      integer, parameter :: mpi_err_name=38
      integer, parameter :: mpi_err_not_same=40
      integer, parameter :: mpi_err_no_mem=39
      integer, parameter :: mpi_err_no_space=41
      integer, parameter :: mpi_err_no_such_file=42
      integer, parameter :: mpi_err_op=10
      integer, parameter :: mpi_err_other=16
      integer, parameter :: mpi_err_pending=19
      integer, parameter :: mpi_err_port=43
      integer, parameter :: mpi_err_quota=44
      integer, parameter :: mpi_err_rank=6
      integer, parameter :: mpi_err_read_only=45
      integer, parameter :: mpi_err_request=7
      integer, parameter :: mpi_err_rma_attach=69
      integer, parameter :: mpi_err_rma_conflict=46
      integer, parameter :: mpi_err_rma_flavor=70
      integer, parameter :: mpi_err_rma_range=68
      integer, parameter :: mpi_err_rma_shared=71
      integer, parameter :: mpi_err_rma_sync=47
      integer, parameter :: mpi_err_root=8
      integer, parameter :: mpi_err_service=48
      integer, parameter :: mpi_err_size=49
      integer, parameter :: mpi_err_spawn=50
      integer, parameter :: mpi_err_tag=4
      integer, parameter :: mpi_err_topology=11
      integer, parameter :: mpi_err_truncate=15
      integer, parameter :: mpi_err_type=3
      integer, parameter :: mpi_err_unknown=14
      integer, parameter :: mpi_err_unsupported_datarep=51
      integer, parameter :: mpi_err_unsupported_operation=52
      integer, parameter :: mpi_err_win=53
      integer, parameter :: mpi_graph=2
      integer, parameter :: mpi_host=1
      integer, parameter :: mpi_ident=0
      integer, parameter :: mpi_io=2
      integer, parameter :: mpi_keyval_invalid=-1
      integer, parameter :: mpi_lastusedcode=5
      integer, parameter :: mpi_lock_exclusive=1
      integer, parameter :: mpi_lock_shared=2
      integer, parameter :: mpi_mode_nocheck=1
      integer, parameter :: mpi_mode_noprecede=2
      integer, parameter :: mpi_mode_noput=4
      integer, parameter :: mpi_mode_nostore=8
      integer, parameter :: mpi_mode_nosucceed=16
      integer, parameter :: mpi_order_c=0
      integer, parameter :: mpi_order_fortran=1
      integer, parameter :: mpi_proc_null=-2
      integer, parameter :: mpi_root=-4
      integer, parameter :: mpi_similar=2
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_subversion=1
      integer, parameter :: mpi_success=0
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_tag_ub=0
      integer, parameter :: mpi_thread_funneled=1
      integer, parameter :: mpi_thread_multiple=3
      integer, parameter :: mpi_thread_serialized=2
      integer, parameter :: mpi_thread_single=0
      integer, parameter :: mpi_typeclass_complex=3
      integer, parameter :: mpi_typeclass_integer=1
      integer, parameter :: mpi_typeclass_real=2
      integer, parameter :: mpi_t_err_cannot_init=56
      integer, parameter :: mpi_t_err_cvar_set_never=64
      integer, parameter :: mpi_t_err_cvar_set_not_now=63
      integer, parameter :: mpi_t_err_invalid=72
      integer, parameter :: mpi_t_err_invalid_handle=59
      integer, parameter :: mpi_t_err_invalid_index=57
      integer, parameter :: mpi_t_err_invalid_item=58
      integer, parameter :: mpi_t_err_invalid_session=62
      integer, parameter :: mpi_t_err_memory=54
      integer, parameter :: mpi_t_err_not_initialized=55
      integer, parameter :: mpi_t_err_out_of_handles=60
      integer, parameter :: mpi_t_err_out_of_sessions=61
      integer, parameter :: mpi_t_err_pvar_no_atomic=67
      integer, parameter :: mpi_t_err_pvar_no_startstop=65
      integer, parameter :: mpi_t_err_pvar_no_write=66
      integer, parameter :: mpi_undefined=-32766
      integer, parameter :: mpi_unequal=3
      integer, parameter :: mpi_universe_size=6
      integer, parameter :: mpi_version=3
      integer, parameter :: mpi_win_base=7
      integer, parameter :: mpi_win_create_flavor=10
      integer, parameter :: mpi_win_disp_unit=9
      integer, parameter :: mpi_win_flavor_allocate=2
      integer, parameter :: mpi_win_flavor_create=1
      integer, parameter :: mpi_win_flavor_dynamic=3
      integer, parameter :: mpi_win_flavor_shared=4
      integer, parameter :: mpi_win_model=11
      integer, parameter :: mpi_win_separate=1
      integer, parameter :: mpi_win_size=8
      integer, parameter :: mpi_win_unified=0
      integer, parameter :: mpi_wtime_is_global=3
      integer, parameter :: ompi_comm_type_board=8
      integer, parameter :: ompi_comm_type_cluster=11
      integer, parameter :: ompi_comm_type_core=2
      integer, parameter :: ompi_comm_type_cu=10
      integer, parameter :: ompi_comm_type_host=9
      integer, parameter :: ompi_comm_type_hwthread=1
      integer, parameter :: ompi_comm_type_l1cache=3
      integer, parameter :: ompi_comm_type_l2cache=4
      integer, parameter :: ompi_comm_type_l3cache=5
      integer, parameter :: ompi_comm_type_node=0
      integer, parameter :: ompi_comm_type_numa=7
      integer, parameter :: ompi_comm_type_socket=6
      integer, parameter :: mpi_2complex=26
      integer, parameter :: mpi_2double_complex=27
      integer, parameter :: mpi_2double_precision=24
      integer, parameter :: mpi_2int=52
      integer, parameter :: mpi_2integer=25
      integer, parameter :: mpi_2real=23
      integer, parameter :: mpi_aint=66
      integer, parameter :: mpi_band=6
      integer, parameter :: mpi_bor=8
      integer, parameter :: mpi_bxor=10
      integer, parameter :: mpi_byte=1
      integer, parameter :: mpi_char=34
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_comm_null=2
      integer, parameter :: mpi_comm_self=1
      integer, parameter :: mpi_comm_world=0
      integer, parameter :: mpi_complex=18
      integer, parameter :: mpi_complex16=20
      integer, parameter :: mpi_complex32=21
      integer, parameter :: mpi_complex8=19
      integer, parameter :: mpi_count=72
      integer, parameter :: mpi_cxx_bool=54
      integer, parameter :: mpi_cxx_complex=55
      integer, parameter :: mpi_cxx_double_complex=56
      integer, parameter :: mpi_cxx_float_complex=55
      integer, parameter :: mpi_cxx_long_double_complex=57
      integer, parameter :: mpi_c_bool=68
      integer, parameter :: mpi_c_complex=69
      integer, parameter :: mpi_c_double_complex=70
      integer, parameter :: mpi_c_float_complex=69
      integer, parameter :: mpi_c_long_double_complex=71
      integer, parameter :: mpi_datatype_null=0
      integer, parameter :: mpi_double=46
      integer, parameter :: mpi_double_complex=22
      integer, parameter :: mpi_double_int=49
      integer, parameter :: mpi_double_precision=17
      integer, parameter :: mpi_errhandler_null=0
      integer, parameter :: mpi_errors_are_fatal=1
      integer, parameter :: mpi_errors_return=2
      integer, parameter :: mpi_float=45
      integer, parameter :: mpi_float_int=48
      integer, parameter :: mpi_group_empty=1
      integer, parameter :: mpi_group_null=0
      integer, parameter :: mpi_info_env=1
      integer, parameter :: mpi_info_null=0
      integer, parameter :: mpi_int=39
      integer, parameter :: mpi_int16_t=60
      integer, parameter :: mpi_int32_t=62
      integer, parameter :: mpi_int64_t=64
      integer, parameter :: mpi_int8_t=58
      integer, parameter :: mpi_integer=7
      integer, parameter :: mpi_integer1=8
      integer, parameter :: mpi_integer16=12
      integer, parameter :: mpi_integer2=9
      integer, parameter :: mpi_integer4=10
      integer, parameter :: mpi_integer8=11
      integer, parameter :: mpi_land=5
      integer, parameter :: mpi_lb=4
      integer, parameter :: mpi_logical=6
      integer, parameter :: mpi_logical1=29
      integer, parameter :: mpi_logical2=30
      integer, parameter :: mpi_logical4=31
      integer, parameter :: mpi_logical8=32
      integer, parameter :: mpi_long=41
      integer, parameter :: mpi_long_double=47
      integer, parameter :: mpi_long_double_int=50
      integer, parameter :: mpi_long_int=51
      integer, parameter :: mpi_long_long=43
      integer, parameter :: mpi_long_long_int=43
      integer, parameter :: mpi_lor=7
      integer, parameter :: mpi_lxor=9
      integer, parameter :: mpi_max=1
      integer, parameter :: mpi_maxloc=11
      integer, parameter :: mpi_message_no_proc=1
      integer, parameter :: mpi_message_null=0
      integer, parameter :: mpi_min=2
      integer, parameter :: mpi_minloc=12
      integer, parameter :: mpi_no_op=14
      integer, parameter :: mpi_offset=67
      integer, parameter :: mpi_op_null=0
      integer, parameter :: mpi_packed=2
      integer, parameter :: mpi_prod=4
      integer, parameter :: mpi_real=13
      integer, parameter :: mpi_real16=16
      integer, parameter :: mpi_real2=28
      integer, parameter :: mpi_real4=14
      integer, parameter :: mpi_real8=15
      integer, parameter :: mpi_replace=13
      integer, parameter :: mpi_request_null=0
      integer, parameter :: mpi_short=37
      integer, parameter :: mpi_short_int=53
      integer, parameter :: mpi_signed_char=36
      integer, parameter :: mpi_sum=3
      integer, parameter :: mpi_ub=3
      integer, parameter :: mpi_uint16_t=61
      integer, parameter :: mpi_uint32_t=63
      integer, parameter :: mpi_uint64_t=65
      integer, parameter :: mpi_uint8_t=59
      integer, parameter :: mpi_unsigned=40
      integer, parameter :: mpi_unsigned_char=35
      integer, parameter :: mpi_unsigned_long=42
      integer, parameter :: mpi_unsigned_long_long=44
      integer, parameter :: mpi_unsigned_short=38
      integer, parameter :: mpi_wchar=33
      integer, parameter :: mpi_win_null=0
      integer, parameter :: mpi_mode_append=128
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_delete_on_close=16
      integer, parameter :: mpi_mode_excl=64
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_rdwr=8
      integer, parameter :: mpi_mode_sequential=256
      integer, parameter :: mpi_mode_unique_open=32
      integer, parameter :: mpi_mode_wronly=4
      integer, parameter :: mpi_seek_cur=602
      integer, parameter :: mpi_seek_end=604
      integer, parameter :: mpi_seek_set=600
      integer, parameter :: mpi_displacement_current=-54278278
      integer, parameter :: mpi_file_null=0
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2014 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2017      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
      ifadvc(1) = ifnav
      textsw(1,1) = turbmod
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 
!  Do ***not*** copy this file to the directory where your Fortran
!  fortran application is compiled unless it is absolutely necessary!  Most
!  modern Fortran compilers now support the -I command line flag, which
!  tells the compiler where to find .h files (specifically, this one).  For
!  example:
! 
!       shell$ mpifort foo.f -o foo -I$OMPI_HOME/include
! 
!  will probably do the trick (assuming that you have set OMPI_HOME
!  properly).
! 
!  That being said, OMPI's "mpifort" wrapper compiler should
!  automatically include the -I option for you.  The following command
!  should be equivalent to the command listed above:
! 
!       shell$ mpifort foo.f -o foo
! 
!  You should not copy this file to your local directory because it is
!  possible that this file will be changed between versions of Open MPI.
!  Indeed, this mpif.h is incompatible with the mpif.f of other
!  implementations of MPI.  Using this mpif.h with other implementations
!  of MPI, or with other versions of Open MPI will result in undefined
!  behavior (to include incorrect results, segmentation faults,
!  unexplainable "hanging" in your application, etc.).  Always use the
!  -I command line option instead (or let mpifort do it for you).
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!       include 'mpif-config.h'
!       include 'mpif-constants.h'
!       include 'mpif-handles.h'
!       include 'mpif-io-constants.h'
!       include 'mpif-io-handles.h'
!       include 'mpif-externals.h'
!       include 'mpif-sentinels.h'
!       include 'mpif-sizeof.h'
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
!  Copyright (c) 2013      Los Alamos National Security, LLC. All rights
!                          reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      This file contains the output from configure that is relevant for
!      Fortran applications and a few values that are necessary to
!      compile the Fortran modules (e.g., MPI_STATUS_SIZE).
! 
! 
!      OMPI version
!      This file is generated from configure; do not edit it manually.
! 
! 
!      Kind parameters
! 
! 
!      Miscellaneous constants
! 
! 
!      Configurable length constants
! 
! 
!  MPI F08 conformance
! 
      ! hard-coded for .false. for now
      ! hard-coded for .false. for now
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      These "external" statements are specific to the MPI mpif.h
!      interface (and are toxic to the MPI module interfaces),.
! 
      external mpi_null_copy_fn, mpi_null_delete_fn
      external mpi_comm_null_copy_fn, mpi_comm_null_delete_fn
      external mpi_type_null_copy_fn, mpi_type_null_delete_fn
      external mpi_dup_fn, mpi_comm_dup_fn, mpi_type_dup_fn
      external mpi_win_null_copy_fn
      external mpi_win_null_delete_fn
      external mpi_win_dup_fn
!      Note that MPI_CONVERSION_FN_NULL is a "constant" (it is only ever
!      checked for comparison; it is never invoked), but it is passed as
!      a function pointer (to MPI_REGISTER_DATAREP) and therefore must be
!      the same size/type.  It is therefore external'ed here, and not
!      defined with an integer value in mpif-common.h.
      external mpi_conversion_fn_null
! 
!      double precision functions
! 
      external mpi_wtime, mpi_wtick , pmpi_wtick, pmpi_wtime
      integer :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
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
      real(kind=8) :: mpi_wtick
      real(kind=8) :: pmpi_wtick
      real(kind=8) :: pmpi_wtime
! 
!      address integer functions
! 
      external mpi_aint_add, mpi_aint_diff
      integer :: mpi_aint_add
      integer :: mpi_aint_diff
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      All of these types were chosen with care to match the types of
!      their corresponding C variables.  Do not arbitrarily change
!      their types without also updating:
! 
!      - the "mpi" module bindings
!      - the "mpi_f08" module bindings
!      - ompi/mpi/fortran/base/gen-mpi-mangling.pl
! 
!      MPI_BOTTOM is only used where choice buffers can be used (meaning
!      that we already have overloaded F90 bindings for all available
!      types), so any type is fine.
      integer :: mpi_bottom
!      MPI_IN_PLACE has the same rationale as MPI_BOTTOM.
      integer :: mpi_in_place
!      Making MPI_ARGV_NULL be the same type as the parameter that is
!      exepected in the F90 binding for MPI_COMM_SPAWN means that we
!      don't need another interface for MPI_COMM_SPAWN.
      character, dimension(1:1) :: mpi_argv_null
!      Ditto for MPI_ARGVS_NULL / MPI_COMM_SPAWN_MULTIPLE.
      character, dimension(1:1,1:1) :: mpi_argvs_null
!      MPI_ERRCODES_IGNORE has similar rationale to MPI_ARGV_NULL.  The
!      F77 functions are all smart enough to check that the errcodes
!      parameter is not ERRCODES_IGNORE before assigning values into it
!      (hence, the fact that this is an array of only 1 element does not
!      matter -- we'll never overrun it because we never assign values
!      into it).
      integer, dimension(1:1) :: mpi_errcodes_ignore
!      MPI_STATUS_IGNORE has similar rationale to MPI_ERRCODES_IGNORE.
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
!      Ditto for MPI_STATUSES_IGNORE
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
!      Ditto for MPI_UNWEIGHTED
      integer, dimension(1:1) :: mpi_unweighted
!      Ditto for MPI_WEIGHTS_EMPTY
      integer, dimension(1:1) :: mpi_weights_empty
!  -*- f90 -*-
!  WARNING: This is a generated file!  Edits will be lost!
! 
!  Copyright (c) 2014 Cisco Systems, Inc.  All rights reserved.
! $COPYRIGHT$
! 
!  This file was generated by gen-mpi-sizeof.pl for all the MPI_SIZEOF
!  interface possibilities for intrinsic types.  Once TS 29113 is
!  supported in all compilers, we can simply have *one* procedure for
!  each type and use dimension(..) to indicate scalars+all array ranks.
!  But until more compilers support this, we simply generate a
!  procedure for scalars and all possible ranks in an attempt to
!  support lots of Fortran compilers.
      interface mpi_sizeof
#ifdef PAPI
      gflops  = glsum(dnekgflops(),1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
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
#endif
      tstop   = dnekclock_sync(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore, &
      mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty,nekcomm, &
      nekgroup,nekreal,nid,np)
      ttotal = tstop-etimes
      tsol   = max(ttime - tprep,0.0)
      nxyz   = lx1*ly1*lz1
      dtmp4  = glsum(getmaxrss(),1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
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
      xm1,xm2,xxth,yc,yinvm1,ym1,ym2,zam1,zam2,zam3,zc,zgl,zgm1,zgm2,zgm3,zgp,zm1,zm2)/1e9
      ifnav = ifadvc(1)
      turbmod = textsw(1,1)
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
      subroutine nek_die(ierr,idsess,ldimr,loglevel,mpi_argv_null,mpi_argvs_null,mpi_bottom, &
      mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted, &
      mpi_weights_empty,ndim,nelt,nelv,nfield,nid,nio,npert,nx1,nx2,nx3,nxd,ny1,ny2,ny3,nyd,nz1, &
      nz2,nz3,nzd,optlevel)
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
      integer, intent(In) :: ierr
      integer :: ierr_
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
      integer, parameter :: ompi_major_version=4
      integer, parameter :: ompi_minor_version=0
      integer, parameter :: ompi_release_version=1
      integer, parameter :: mpi_integer_kind=4
      integer, parameter :: mpi_address_kind=8
      integer, parameter :: mpi_offset_kind=8
      integer, parameter :: mpi_count_kind=8
      integer, parameter :: mpi_status_size=6
      integer, parameter :: mpi_max_processor_name=256-1
      integer, parameter :: mpi_max_error_string=256-1
      integer, parameter :: mpi_max_object_name=64-1
      integer, parameter :: mpi_max_library_version_string=256-1
      integer, parameter :: mpi_max_info_key=36-1
      integer, parameter :: mpi_max_info_val=256-1
      integer, parameter :: mpi_max_port_name=1024-1
      integer, parameter :: mpi_max_datarep_string=128-1
      logical, parameter :: mpi_subarrays_supported=.false.
      logical, parameter :: mpi_async_protects_nonblocking=.false.
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
      integer, parameter :: mpi_appnum=4
      integer, parameter :: mpi_bsend_overhead=128
      integer, parameter :: mpi_cart=1
      integer, parameter :: mpi_combiner_contiguous=2
      integer, parameter :: mpi_combiner_darray=13
      integer, parameter :: mpi_combiner_dup=1
      integer, parameter :: mpi_combiner_f90_complex=15
      integer, parameter :: mpi_combiner_f90_integer=16
      integer, parameter :: mpi_combiner_f90_real=14
      integer, parameter :: mpi_combiner_hindexed=8
      integer, parameter :: mpi_combiner_hindexed_block=18
      integer, parameter :: mpi_combiner_hindexed_integer=7
      integer, parameter :: mpi_combiner_hvector=5
      integer, parameter :: mpi_combiner_hvector_integer=4
      integer, parameter :: mpi_combiner_indexed=6
      integer, parameter :: mpi_combiner_indexed_block=9
      integer, parameter :: mpi_combiner_named=0
      integer, parameter :: mpi_combiner_resized=17
      integer, parameter :: mpi_combiner_struct=11
      integer, parameter :: mpi_combiner_struct_integer=10
      integer, parameter :: mpi_combiner_subarray=12
      integer, parameter :: mpi_combiner_vector=3
      integer, parameter :: mpi_comm_type_shared=0
      integer, parameter :: mpi_congruent=1
      integer, parameter :: mpi_distribute_block=0
      integer, parameter :: mpi_distribute_cyclic=1
      integer, parameter :: mpi_distribute_dflt_darg=-1
      integer, parameter :: mpi_distribute_none=2
      integer, parameter :: mpi_dist_graph=3
      integer, parameter :: mpi_error=3
      integer, parameter :: mpi_err_access=20
      integer, parameter :: mpi_err_amode=21
      integer, parameter :: mpi_err_arg=13
      integer, parameter :: mpi_err_assert=22
      integer, parameter :: mpi_err_bad_file=23
      integer, parameter :: mpi_err_base=24
      integer, parameter :: mpi_err_buffer=1
      integer, parameter :: mpi_err_comm=5
      integer, parameter :: mpi_err_conversion=25
      integer, parameter :: mpi_err_count=2
      integer, parameter :: mpi_err_dims=12
      integer, parameter :: mpi_err_disp=26
      integer, parameter :: mpi_err_dup_datarep=27
      integer, parameter :: mpi_err_file=30
      integer, parameter :: mpi_err_file_exists=28
      integer, parameter :: mpi_err_file_in_use=29
      integer, parameter :: mpi_err_group=9
      integer, parameter :: mpi_err_info=34
      integer, parameter :: mpi_err_info_key=31
      integer, parameter :: mpi_err_info_nokey=32
      integer, parameter :: mpi_err_info_value=33
      integer, parameter :: mpi_err_intern=17
      integer, parameter :: mpi_err_in_status=18
      integer, parameter :: mpi_err_io=35
      integer, parameter :: mpi_err_keyval=36
      integer, parameter :: mpi_err_lastcode=92
      integer, parameter :: mpi_err_locktype=37
      integer, parameter :: mpi_err_name=38
      integer, parameter :: mpi_err_not_same=40
      integer, parameter :: mpi_err_no_mem=39
      integer, parameter :: mpi_err_no_space=41
      integer, parameter :: mpi_err_no_such_file=42
      integer, parameter :: mpi_err_op=10
      integer, parameter :: mpi_err_other=16
      integer, parameter :: mpi_err_pending=19
      integer, parameter :: mpi_err_port=43
      integer, parameter :: mpi_err_quota=44
      integer, parameter :: mpi_err_rank=6
      integer, parameter :: mpi_err_read_only=45
      integer, parameter :: mpi_err_request=7
      integer, parameter :: mpi_err_rma_attach=69
      integer, parameter :: mpi_err_rma_conflict=46
      integer, parameter :: mpi_err_rma_flavor=70
      integer, parameter :: mpi_err_rma_range=68
      integer, parameter :: mpi_err_rma_shared=71
      integer, parameter :: mpi_err_rma_sync=47
      integer, parameter :: mpi_err_root=8
      integer, parameter :: mpi_err_service=48
      integer, parameter :: mpi_err_size=49
      integer, parameter :: mpi_err_spawn=50
      integer, parameter :: mpi_err_tag=4
      integer, parameter :: mpi_err_topology=11
      integer, parameter :: mpi_err_truncate=15
      integer, parameter :: mpi_err_type=3
      integer, parameter :: mpi_err_unknown=14
      integer, parameter :: mpi_err_unsupported_datarep=51
      integer, parameter :: mpi_err_unsupported_operation=52
      integer, parameter :: mpi_err_win=53
      integer, parameter :: mpi_graph=2
      integer, parameter :: mpi_host=1
      integer, parameter :: mpi_ident=0
      integer, parameter :: mpi_io=2
      integer, parameter :: mpi_keyval_invalid=-1
      integer, parameter :: mpi_lastusedcode=5
      integer, parameter :: mpi_lock_exclusive=1
      integer, parameter :: mpi_lock_shared=2
      integer, parameter :: mpi_mode_nocheck=1
      integer, parameter :: mpi_mode_noprecede=2
      integer, parameter :: mpi_mode_noput=4
      integer, parameter :: mpi_mode_nostore=8
      integer, parameter :: mpi_mode_nosucceed=16
      integer, parameter :: mpi_order_c=0
      integer, parameter :: mpi_order_fortran=1
      integer, parameter :: mpi_proc_null=-2
      integer, parameter :: mpi_root=-4
      integer, parameter :: mpi_similar=2
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_subversion=1
      integer, parameter :: mpi_success=0
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_tag_ub=0
      integer, parameter :: mpi_thread_funneled=1
      integer, parameter :: mpi_thread_multiple=3
      integer, parameter :: mpi_thread_serialized=2
      integer, parameter :: mpi_thread_single=0
      integer, parameter :: mpi_typeclass_complex=3
      integer, parameter :: mpi_typeclass_integer=1
      integer, parameter :: mpi_typeclass_real=2
      integer, parameter :: mpi_t_err_cannot_init=56
      integer, parameter :: mpi_t_err_cvar_set_never=64
      integer, parameter :: mpi_t_err_cvar_set_not_now=63
      integer, parameter :: mpi_t_err_invalid=72
      integer, parameter :: mpi_t_err_invalid_handle=59
      integer, parameter :: mpi_t_err_invalid_index=57
      integer, parameter :: mpi_t_err_invalid_item=58
      integer, parameter :: mpi_t_err_invalid_session=62
      integer, parameter :: mpi_t_err_memory=54
      integer, parameter :: mpi_t_err_not_initialized=55
      integer, parameter :: mpi_t_err_out_of_handles=60
      integer, parameter :: mpi_t_err_out_of_sessions=61
      integer, parameter :: mpi_t_err_pvar_no_atomic=67
      integer, parameter :: mpi_t_err_pvar_no_startstop=65
      integer, parameter :: mpi_t_err_pvar_no_write=66
      integer, parameter :: mpi_undefined=-32766
      integer, parameter :: mpi_unequal=3
      integer, parameter :: mpi_universe_size=6
      integer, parameter :: mpi_version=3
      integer, parameter :: mpi_win_base=7
      integer, parameter :: mpi_win_create_flavor=10
      integer, parameter :: mpi_win_disp_unit=9
      integer, parameter :: mpi_win_flavor_allocate=2
      integer, parameter :: mpi_win_flavor_create=1
      integer, parameter :: mpi_win_flavor_dynamic=3
      integer, parameter :: mpi_win_flavor_shared=4
      integer, parameter :: mpi_win_model=11
      integer, parameter :: mpi_win_separate=1
      integer, parameter :: mpi_win_size=8
      integer, parameter :: mpi_win_unified=0
      integer, parameter :: mpi_wtime_is_global=3
      integer, parameter :: ompi_comm_type_board=8
      integer, parameter :: ompi_comm_type_cluster=11
      integer, parameter :: ompi_comm_type_core=2
      integer, parameter :: ompi_comm_type_cu=10
      integer, parameter :: ompi_comm_type_host=9
      integer, parameter :: ompi_comm_type_hwthread=1
      integer, parameter :: ompi_comm_type_l1cache=3
      integer, parameter :: ompi_comm_type_l2cache=4
      integer, parameter :: ompi_comm_type_l3cache=5
      integer, parameter :: ompi_comm_type_node=0
      integer, parameter :: ompi_comm_type_numa=7
      integer, parameter :: ompi_comm_type_socket=6
      integer, parameter :: mpi_2complex=26
      integer, parameter :: mpi_2double_complex=27
      integer, parameter :: mpi_2double_precision=24
      integer, parameter :: mpi_2int=52
      integer, parameter :: mpi_2integer=25
      integer, parameter :: mpi_2real=23
      integer, parameter :: mpi_aint=66
      integer, parameter :: mpi_band=6
      integer, parameter :: mpi_bor=8
      integer, parameter :: mpi_bxor=10
      integer, parameter :: mpi_byte=1
      integer, parameter :: mpi_char=34
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_comm_null=2
      integer, parameter :: mpi_comm_self=1
      integer, parameter :: mpi_comm_world=0
      integer, parameter :: mpi_complex=18
      integer, parameter :: mpi_complex16=20
      integer, parameter :: mpi_complex32=21
      integer, parameter :: mpi_complex8=19
      integer, parameter :: mpi_count=72
      integer, parameter :: mpi_cxx_bool=54
      integer, parameter :: mpi_cxx_complex=55
      integer, parameter :: mpi_cxx_double_complex=56
      integer, parameter :: mpi_cxx_float_complex=55
      integer, parameter :: mpi_cxx_long_double_complex=57
      integer, parameter :: mpi_c_bool=68
      integer, parameter :: mpi_c_complex=69
      integer, parameter :: mpi_c_double_complex=70
      integer, parameter :: mpi_c_float_complex=69
      integer, parameter :: mpi_c_long_double_complex=71
      integer, parameter :: mpi_datatype_null=0
      integer, parameter :: mpi_double=46
      integer, parameter :: mpi_double_complex=22
      integer, parameter :: mpi_double_int=49
      integer, parameter :: mpi_double_precision=17
      integer, parameter :: mpi_errhandler_null=0
      integer, parameter :: mpi_errors_are_fatal=1
      integer, parameter :: mpi_errors_return=2
      integer, parameter :: mpi_float=45
      integer, parameter :: mpi_float_int=48
      integer, parameter :: mpi_group_empty=1
      integer, parameter :: mpi_group_null=0
      integer, parameter :: mpi_info_env=1
      integer, parameter :: mpi_info_null=0
      integer, parameter :: mpi_int=39
      integer, parameter :: mpi_int16_t=60
      integer, parameter :: mpi_int32_t=62
      integer, parameter :: mpi_int64_t=64
      integer, parameter :: mpi_int8_t=58
      integer, parameter :: mpi_integer=7
      integer, parameter :: mpi_integer1=8
      integer, parameter :: mpi_integer16=12
      integer, parameter :: mpi_integer2=9
      integer, parameter :: mpi_integer4=10
      integer, parameter :: mpi_integer8=11
      integer, parameter :: mpi_land=5
      integer, parameter :: mpi_lb=4
      integer, parameter :: mpi_logical=6
      integer, parameter :: mpi_logical1=29
      integer, parameter :: mpi_logical2=30
      integer, parameter :: mpi_logical4=31
      integer, parameter :: mpi_logical8=32
      integer, parameter :: mpi_long=41
      integer, parameter :: mpi_long_double=47
      integer, parameter :: mpi_long_double_int=50
      integer, parameter :: mpi_long_int=51
      integer, parameter :: mpi_long_long=43
      integer, parameter :: mpi_long_long_int=43
      integer, parameter :: mpi_lor=7
      integer, parameter :: mpi_lxor=9
      integer, parameter :: mpi_max=1
      integer, parameter :: mpi_maxloc=11
      integer, parameter :: mpi_message_no_proc=1
      integer, parameter :: mpi_message_null=0
      integer, parameter :: mpi_min=2
      integer, parameter :: mpi_minloc=12
      integer, parameter :: mpi_no_op=14
      integer, parameter :: mpi_offset=67
      integer, parameter :: mpi_op_null=0
      integer, parameter :: mpi_packed=2
      integer, parameter :: mpi_prod=4
      integer, parameter :: mpi_real=13
      integer, parameter :: mpi_real16=16
      integer, parameter :: mpi_real2=28
      integer, parameter :: mpi_real4=14
      integer, parameter :: mpi_real8=15
      integer, parameter :: mpi_replace=13
      integer, parameter :: mpi_request_null=0
      integer, parameter :: mpi_short=37
      integer, parameter :: mpi_short_int=53
      integer, parameter :: mpi_signed_char=36
      integer, parameter :: mpi_sum=3
      integer, parameter :: mpi_ub=3
      integer, parameter :: mpi_uint16_t=61
      integer, parameter :: mpi_uint32_t=63
      integer, parameter :: mpi_uint64_t=65
      integer, parameter :: mpi_uint8_t=59
      integer, parameter :: mpi_unsigned=40
      integer, parameter :: mpi_unsigned_char=35
      integer, parameter :: mpi_unsigned_long=42
      integer, parameter :: mpi_unsigned_long_long=44
      integer, parameter :: mpi_unsigned_short=38
      integer, parameter :: mpi_wchar=33
      integer, parameter :: mpi_win_null=0
      integer, parameter :: mpi_mode_append=128
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_delete_on_close=16
      integer, parameter :: mpi_mode_excl=64
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_rdwr=8
      integer, parameter :: mpi_mode_sequential=256
      integer, parameter :: mpi_mode_unique_open=32
      integer, parameter :: mpi_mode_wronly=4
      integer, parameter :: mpi_seek_cur=602
      integer, parameter :: mpi_seek_end=604
      integer, parameter :: mpi_seek_set=600
      integer, parameter :: mpi_displacement_current=-54278278
      integer, parameter :: mpi_file_null=0
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2014 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2017      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 
!  Do ***not*** copy this file to the directory where your Fortran
!  fortran application is compiled unless it is absolutely necessary!  Most
!  modern Fortran compilers now support the -I command line flag, which
!  tells the compiler where to find .h files (specifically, this one).  For
!  example:
! 
!       shell$ mpifort foo.f -o foo -I$OMPI_HOME/include
! 
!  will probably do the trick (assuming that you have set OMPI_HOME
!  properly).
! 
!  That being said, OMPI's "mpifort" wrapper compiler should
!  automatically include the -I option for you.  The following command
!  should be equivalent to the command listed above:
! 
!       shell$ mpifort foo.f -o foo
! 
!  You should not copy this file to your local directory because it is
!  possible that this file will be changed between versions of Open MPI.
!  Indeed, this mpif.h is incompatible with the mpif.f of other
!  implementations of MPI.  Using this mpif.h with other implementations
!  of MPI, or with other versions of Open MPI will result in undefined
!  behavior (to include incorrect results, segmentation faults,
!  unexplainable "hanging" in your application, etc.).  Always use the
!  -I command line option instead (or let mpifort do it for you).
! 
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!       include 'mpif-config.h'
!       include 'mpif-constants.h'
!       include 'mpif-handles.h'
!       include 'mpif-io-constants.h'
!       include 'mpif-io-handles.h'
!       include 'mpif-externals.h'
!       include 'mpif-sentinels.h'
!       include 'mpif-sizeof.h'
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
!  Copyright (c) 2013      Los Alamos National Security, LLC. All rights
!                          reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      This file contains the output from configure that is relevant for
!      Fortran applications and a few values that are necessary to
!      compile the Fortran modules (e.g., MPI_STATUS_SIZE).
! 
! 
!      OMPI version
!      This file is generated from configure; do not edit it manually.
! 
! 
!      Kind parameters
! 
! 
!      Miscellaneous constants
! 
! 
!      Configurable length constants
! 
! 
!  MPI F08 conformance
! 
      ! hard-coded for .false. for now
      ! hard-coded for .false. for now
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
!  WARNING! THIS IS A GENERATED FILE!!
!  ANY EDITS YOU PUT HERE WILL BE LOST!
!  ==> Instead, edit topdir/ompi/include/mpif-values.pl.
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
!  Copyright (c) 2016      Research Organization for Information Science
!                          and Technology (RIST). All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2005 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2017 Cisco Systems, Inc.  All rights reserved
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      These "external" statements are specific to the MPI mpif.h
!      interface (and are toxic to the MPI module interfaces),.
! 
      external mpi_null_copy_fn, mpi_null_delete_fn
      external mpi_comm_null_copy_fn, mpi_comm_null_delete_fn
      external mpi_type_null_copy_fn, mpi_type_null_delete_fn
      external mpi_dup_fn, mpi_comm_dup_fn, mpi_type_dup_fn
      external mpi_win_null_copy_fn
      external mpi_win_null_delete_fn
      external mpi_win_dup_fn
!      Note that MPI_CONVERSION_FN_NULL is a "constant" (it is only ever
!      checked for comparison; it is never invoked), but it is passed as
!      a function pointer (to MPI_REGISTER_DATAREP) and therefore must be
!      the same size/type.  It is therefore external'ed here, and not
!      defined with an integer value in mpif-common.h.
      external mpi_conversion_fn_null
! 
!      double precision functions
! 
      external mpi_wtime, mpi_wtick , pmpi_wtick, pmpi_wtime
      integer, intent(In) :: ierr
      integer :: ierr_
      real(kind=8) :: mpi_wtick
      real(kind=8) :: pmpi_wtick
      real(kind=8) :: pmpi_wtime
! 
!      address integer functions
! 
      external mpi_aint_add, mpi_aint_diff
      integer :: mpi_aint_add
      integer :: mpi_aint_diff
!  -*- fortran -*-
! 
!  Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                          University Research and Technology
!                          Corporation.  All rights reserved.
!  Copyright (c) 2004-2010 The University of Tennessee and The University
!                          of Tennessee Research Foundation.  All rights
!                          reserved.
!  Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                          University of Stuttgart.  All rights reserved.
!  Copyright (c) 2004-2005 The Regents of the University of California.
!                          All rights reserved.
!  Copyright (c) 2006-2012 Cisco Systems, Inc.  All rights reserved.
!  Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! $COPYRIGHT$
! 
!  Additional copyrights may follow
! 
! $HEADER$
! 
! 
!      All of these types were chosen with care to match the types of
!      their corresponding C variables.  Do not arbitrarily change
!      their types without also updating:
! 
!      - the "mpi" module bindings
!      - the "mpi_f08" module bindings
!      - ompi/mpi/fortran/base/gen-mpi-mangling.pl
! 
!      MPI_BOTTOM is only used where choice buffers can be used (meaning
!      that we already have overloaded F90 bindings for all available
!      types), so any type is fine.
      integer :: mpi_bottom
!      MPI_IN_PLACE has the same rationale as MPI_BOTTOM.
      integer :: mpi_in_place
!      Making MPI_ARGV_NULL be the same type as the parameter that is
!      exepected in the F90 binding for MPI_COMM_SPAWN means that we
!      don't need another interface for MPI_COMM_SPAWN.
      character, dimension(1:1) :: mpi_argv_null
!      Ditto for MPI_ARGVS_NULL / MPI_COMM_SPAWN_MULTIPLE.
      character, dimension(1:1,1:1) :: mpi_argvs_null
!      MPI_ERRCODES_IGNORE has similar rationale to MPI_ARGV_NULL.  The
!      F77 functions are all smart enough to check that the errcodes
!      parameter is not ERRCODES_IGNORE before assigning values into it
!      (hence, the fact that this is an array of only 1 element does not
!      matter -- we'll never overrun it because we never assign values
!      into it).
      integer, dimension(1:1) :: mpi_errcodes_ignore
!      MPI_STATUS_IGNORE has similar rationale to MPI_ERRCODES_IGNORE.
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
!      Ditto for MPI_STATUSES_IGNORE
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
!      Ditto for MPI_UNWEIGHTED
      integer, dimension(1:1) :: mpi_unweighted
!      Ditto for MPI_WEIGHTS_EMPTY
      integer, dimension(1:1) :: mpi_weights_empty
!  -*- f90 -*-
!  WARNING: This is a generated file!  Edits will be lost!
! 
!  Copyright (c) 2014 Cisco Systems, Inc.  All rights reserved.
! $COPYRIGHT$
! 
!  This file was generated by gen-mpi-sizeof.pl for all the MPI_SIZEOF
!  interface possibilities for intrinsic types.  Once TS 29113 is
!  supported in all compilers, we can simply have *one* procedure for
!  each type and use dimension(..) to indicate scalars+all array ranks.
!  But until more compilers support this, we simply generate a
!  procedure for scalars and all possible ranks in an attempt to
!  support lots of Fortran compilers.
      interface mpi_sizeof
      call mpi_finalize(ierr_)

#ifdef EXTBAR
      call exit_(ierr)
#else
      call exit(ierr)
#endif
      return
      end subroutine nek_die

end module singleton_module_src_comm_mpi


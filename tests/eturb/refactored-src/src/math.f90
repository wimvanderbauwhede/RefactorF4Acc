! -----------------------------------------------------------------------
module singleton_module_src_math

      use singleton_module_src_comm_mpi
contains

      subroutine vsqrt(a,n,dcount,dct,ncall,nrout,rct,rname)
      implicit none
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(InOut) :: a
! 
      integer, parameter :: maxrts=1000
! 
!      OPCTR is a set of arrays for tracking the number of operations,
!      and number of calls for a particular subroutine
      character(len=6), dimension(1:maxrts) :: rname
! 
      real(kind=8), dimension(1:maxrts) :: dct
      real(kind=8), dimension(1:maxrts) :: rct
      real(kind=8) :: dcount
! 
      integer, dimension(1:maxrts) :: ncall
      integer :: nrout
! 
      integer :: myrout
      integer :: isclld
      save    myrout,isclld
      data myrout / 0 / 
      data isclld / 0 / 
! 
      do i = 1, n
 100     a(i) = sqrt(a(i))
      end do
      return
      end subroutine vsqrt
      subroutine rzero(a,n)
      implicit none
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(Out) :: a
      do i = 1, n
 100     a(i ) = 0.0
      end do
      return
      end subroutine rzero
      subroutine cfill(a,b,n)
      implicit none
      real, intent(In) :: b
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(Out) :: a
! 
      do i = 1, n
 100     a(i) = b
      end do
      return
      end subroutine cfill
      subroutine copy(a,b,n)
      implicit none
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(Out) :: a
      real, dimension(1:1), intent(In) :: b
      do i=1,n
         a(i)=b(i)
      enddo
      return
      end subroutine copy
      subroutine icopy(a,b,n)
      implicit none
      integer, intent(In) :: n
      integer :: i
      integer, dimension(1:1), intent(Out) :: a
      integer, dimension(1:1), intent(In) :: b
! 
      do i = 1, n
 100     a(i) = b(i)
      end do
      return
      end subroutine icopy
      subroutine cmult(a,const,n,dcount,dct,ncall,nrout,rct,rname)
      implicit none
      real, intent(In) :: const
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(InOut) :: a
! 
      integer, parameter :: maxrts=1000
! 
!      OPCTR is a set of arrays for tracking the number of operations,
!      and number of calls for a particular subroutine
      character(len=6), dimension(1:maxrts) :: rname
! 
      real(kind=8), dimension(1:maxrts) :: dct
      real(kind=8), dimension(1:maxrts) :: rct
      real(kind=8) :: dcount
! 
      integer, dimension(1:maxrts) :: ncall
      integer :: nrout
! 
      integer :: myrout
      integer :: isclld
      save    myrout,isclld
      data myrout / 0 / 
      data isclld / 0 / 
! 
      do i=1,n
         a(i)=a(i)*const
  end do
      return
      end subroutine cmult
      subroutine cadd2(a,b,const,n,dcount,dct,ncall,nrout,rct,rname)
      implicit none
      real, intent(In) :: const
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(Out) :: a
      real, dimension(1:1), intent(In) :: b
! 
      integer, parameter :: maxrts=1000
! 
!      OPCTR is a set of arrays for tracking the number of operations,
!      and number of calls for a particular subroutine
      character(len=6), dimension(1:maxrts) :: rname
! 
      real(kind=8), dimension(1:maxrts) :: dct
      real(kind=8), dimension(1:maxrts) :: rct
      real(kind=8) :: dcount
! 
      integer, dimension(1:maxrts) :: ncall
      integer :: nrout
! 
      integer :: myrout
      integer :: isclld
      save    myrout,isclld
      data myrout / 0 / 
      data isclld / 0 / 
! 
      do i=1,n
         a(i)=b(i)+const
  end do
      return
      end subroutine cadd2
      subroutine col2(a,b,n,dcount,dct,etimes,etims0,ifsync,mpi_argv_null,mpi_argvs_null,mpi_bottom, &
      mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted, &
      mpi_weights_empty,nadvc,naxhm,nbbbb,nbso2,nbsol,ncall,ncccc,ncdtp,ncopy,ncrsl,ncvf,ndadd, &
      ndddd,nddsl,ndott,ndsmn,ndsmx,ndsnd,ndsum,neeee,neslv,ngop,ngop1,ngop_sync,ngp2,ngsmn,ngsmx, &
      ngsum,nhmhz,ninv3,ninvc,nmltd,nmxmf,nmxms,nprep,npres,nrout,nsett,nslvb,nsolv,nspro,nsyc, &
      nusbc,nvdss,nwal,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl,pdadd,pdddd,pddsl,pdott, &
      pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn,pgsmx,pgsum,phmhz,pinv3, &
      pinvc,pmltd,pmxmf,pmxms,pprep,ppres,psett,pslvb,psolv,pspro,psyc,pusbc,pvdss,pwal,rct,rname, &
      ta2s2,tadc3,tadd2,tadvc,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2,tcol3,tcopy,tcrsl,tcvf, &
      tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,tgop,tgop1,tgop_sync,tgp2,tgsmn, &
      tgsmx,tgsum,thmhz,tinit,tinv3,tinvc,tmltd,tmxmf,tmxms,tprep,tpres,tproj,tschw,tsett,tslvb, &
      tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal)
      implicit none
      integer, parameter :: mpi_status_size=6
      character, dimension(1:1) :: mpi_argv_null
      character, dimension(1:1,1:1) :: mpi_argvs_null
      integer :: mpi_bottom
      integer, dimension(1:1) :: mpi_errcodes_ignore
      integer :: mpi_in_place
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
      integer, dimension(1:1) :: mpi_unweighted
      integer, dimension(1:1) :: mpi_weights_empty
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(InOut) :: a
      real, dimension(1:1), intent(In) :: b
      integer, parameter :: maxrts=1000
! 
!      OPCTR is a set of arrays for tracking the number of operations,
!      and number of calls for a particular subroutine
      character(len=6), dimension(1:maxrts) :: rname
! 
      real(kind=8), dimension(1:maxrts) :: dct
      real(kind=8), dimension(1:maxrts) :: rct
      real(kind=8) :: dcount
! 
      integer, dimension(1:maxrts) :: ncall
      integer :: nrout
! 
      integer :: myrout
      integer :: isclld
      save    myrout,isclld
      data myrout / 0 / 
      data isclld / 0 / 
! 
!      Timer variables
! 
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
      real(kind=8), intent(Out) :: tcol2
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
      real(kind=8) :: etimes
      real(kind=8) :: ttotal
      real(kind=8) :: tttstp
      real(kind=8) :: etims0
      real(kind=8) :: ttime
! 
      integer :: icalld
      save    icalld
      data icalld / 0 / 
      logical :: ifsync
#ifdef TIMER2
      if (icalld == 0) then
          icalld=1
          tcol2=0
      endif
      etime1 = dnekclock(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place, &
      mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty)
#endif
      do i=1,n
         a(i)=a(i)*b(i)
      enddo
#ifdef TIMER2
      tcol2 = tcol2+(dnekclock(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore, &
      mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty)-etime1)
#endif
      return
      end subroutine col2
      subroutine add2s2(a,b,c1,n,dcount,dct,etimes,etims0,ifsync,mpi_argv_null,mpi_argvs_null, &
      mpi_bottom,mpi_errcodes_ignore,mpi_in_place,mpi_status_ignore,mpi_statuses_ignore, &
      mpi_unweighted,mpi_weights_empty,nadvc,naxhm,nbbbb,nbso2,nbsol,ncall,ncccc,ncdtp,ncopy, &
      ncrsl,ncvf,ndadd,ndddd,nddsl,ndott,ndsmn,ndsmx,ndsnd,ndsum,neeee,neslv,ngop,ngop1,ngop_sync, &
      ngp2,ngsmn,ngsmx,ngsum,nhmhz,ninv3,ninvc,nmltd,nmxmf,nmxms,nprep,npres,nrout,nsett,nslvb, &
      nsolv,nspro,nsyc,nusbc,nvdss,nwal,paxhm,pbbbb,pbso2,pbsol,pcccc,pcdtp,pcopy,pcrsl,pdadd, &
      pdddd,pddsl,pdott,pdsmn,pdsmx,pdsnd,pdsum,peeee,peslv,pgop,pgop1,pgop_sync,pgp2,pgsmn,pgsmx, &
      pgsum,phmhz,pinv3,pinvc,pmltd,pmxmf,pmxms,pprep,ppres,psett,pslvb,psolv,pspro,psyc,pusbc, &
      pvdss,pwal,rct,rname,ta2s2,tadc3,tadd2,tadvc,taxhm,tbbbb,tbso2,tbsol,tcccc,tcdtp,tcol2, &
      tcol3,tcopy,tcrsl,tcvf,tdadd,tdddd,tddsl,tdott,tdsmn,tdsmx,tdsnd,tdsum,teeee,teslv,tgop, &
      tgop1,tgop_sync,tgp2,tgsmn,tgsmx,tgsum,thmhz,tinit,tinv3,tinvc,tmltd,tmxmf,tmxms,tprep, &
      tpres,tproj,tschw,tsett,tslvb,tsolv,tspro,tsyc,ttime,ttotal,tttstp,tusbc,tusfq,tvdss,twal)
      implicit none
      integer, parameter :: mpi_status_size=6
      character, dimension(1:1) :: mpi_argv_null
      character, dimension(1:1,1:1) :: mpi_argvs_null
      integer :: mpi_bottom
      integer, dimension(1:1) :: mpi_errcodes_ignore
      integer :: mpi_in_place
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
      integer, dimension(1:1) :: mpi_unweighted
      integer, dimension(1:1) :: mpi_weights_empty
      real, intent(In) :: c1
      integer, intent(In) :: n
      integer :: i
      real, dimension(1:1), intent(InOut) :: a
      real, dimension(1:1), intent(In) :: b
! 
      integer, parameter :: maxrts=1000
! 
!      OPCTR is a set of arrays for tracking the number of operations,
!      and number of calls for a particular subroutine
      character(len=6), dimension(1:maxrts) :: rname
! 
      real(kind=8), dimension(1:maxrts) :: dct
      real(kind=8), dimension(1:maxrts) :: rct
      real(kind=8) :: dcount
! 
      integer, dimension(1:maxrts) :: ncall
      integer :: nrout
! 
      integer :: myrout
      integer :: isclld
      save    myrout,isclld
      data myrout / 0 / 
      data isclld / 0 / 
! 
!      Timer variables
! 
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
      real(kind=8), intent(Out) :: ta2s2
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
      real(kind=8) :: etimes
      real(kind=8) :: ttotal
      real(kind=8) :: tttstp
      real(kind=8) :: etims0
      real(kind=8) :: ttime
! 
      integer :: icalld
      save    icalld
      data icalld / 0 / 
      logical :: ifsync
! 
#ifdef TIMER2
      if (icalld == 0) then
          icalld=1
          ta2s2=0
      endif
      etime1 = dnekclock(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore,mpi_in_place, &
      mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty)
#endif
! 
      do i=1,n
        a(i)=a(i)+c1*b(i)
   end do
#ifdef TIMER2
      ta2s2 = ta2s2+(dnekclock(mpi_argv_null,mpi_argvs_null,mpi_bottom,mpi_errcodes_ignore, &
      mpi_in_place,mpi_status_ignore,mpi_statuses_ignore,mpi_unweighted,mpi_weights_empty)-etime1)
#endif
      return
      end subroutine add2s2
      real function glsum(x,n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1, &
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
      implicit none
      real, dimension(1:n) :: tmp_gop
      real, dimension(1:n) :: work_gop
      integer, parameter :: mpi_status_size=6
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
            integer, parameter :: numsts=50
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
            integer, parameter :: lxq=lx2
            integer, parameter :: lx2=lx1-2
            integer, parameter :: lx1=8
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
      integer :: nekcomm
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
            integer, parameter :: lorder2=max(1,lorder-2)
            integer, parameter :: lorder=3
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
      integer :: n
      real :: tsum
      integer :: i
      real, dimension(1:1) :: x
      real, dimension(1:1) :: tmp
      real, dimension(1:1) :: work
      tsum = 0.
      do i=1,n
         tsum = tsum+x(i)
  end do
      tmp(1)=tsum
      tmp_gop = reshape(tmp,shape(tmp_gop))
      work_gop = reshape(work,shape(work_gop))
      call gop(tmp_gop,work_gop,'+  ',1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
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
      tmp = reshape(tmp_gop, shape(tmp))
      work = reshape(work_gop, shape(work))
      glsum = tmp(1)
      return
      end function glsum
      integer function iglmax(a,n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran, &
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
      integer, dimension(1:n) :: tmp_igop
      integer, dimension(1:n) :: work_igop
      integer, parameter :: mpi_status_size=6
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
            integer, parameter :: numsts=50
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
            integer, parameter :: lxq=lx2
            integer, parameter :: lx2=lx1-2
            integer, parameter :: lx1=8
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
      integer :: nekcomm
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
            integer, parameter :: lorder2=max(1,lorder-2)
            integer, parameter :: lorder=3
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
      integer :: n
      integer :: i
      integer, dimension(1:1) :: a
      integer :: tmax
      integer, dimension(1:1) :: tmp
      integer, dimension(1:1) :: work
      tmax= -999999999
      do i=1,n
         tmax=max(tmax,a(i))
      enddo
      tmp(1)=tmax
      tmp_igop = reshape(tmp,shape(tmp_igop))
      work_igop = reshape(work,shape(work_igop))
      call igop(tmp_igop,work_igop,'M  ',1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
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
      tmp = reshape(tmp_igop, shape(tmp))
      work = reshape(work_igop, shape(work))
      iglmax=tmp(1)
      return
      end function iglmax
      real function glmax(a,n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1, &
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
      implicit none
      real, dimension(1:n) :: tmp_gop
      real, dimension(1:n) :: work_gop
      integer, parameter :: mpi_status_size=6
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
            integer, parameter :: numsts=50
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
            integer, parameter :: lxq=lx2
            integer, parameter :: lx2=lx1-2
            integer, parameter :: lx1=8
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
      integer :: nekcomm
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
            integer, parameter :: lorder2=max(1,lorder-2)
            integer, parameter :: lorder=3
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
      integer :: n
      real :: tmax
      integer :: i
      real, dimension(1:1) :: a
      real, dimension(1:1) :: tmp
      real, dimension(1:1) :: work
      tmax=-99.0e20
      do i=1,n
         tmax=max(tmax,a(i))
   end do
      tmp(1)=tmax
      tmp_gop = reshape(tmp,shape(tmp_gop))
      work_gop = reshape(work,shape(work_gop))
      call gop(tmp_gop,work_gop,'M  ',1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
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
      tmp = reshape(tmp_gop, shape(tmp))
      work = reshape(work_gop, shape(work))
      glmax=tmp(1)
      return
      end function glmax
      real function glmin(a,n,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff,avtran,b1ia1, &
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
      implicit none
      real, dimension(1:n) :: tmp_gop
      real, dimension(1:n) :: work_gop
      integer, parameter :: mpi_status_size=6
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
            integer, parameter :: numsts=50
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
            integer, parameter :: lxq=lx2
            integer, parameter :: lx2=lx1-2
            integer, parameter :: lx1=8
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
      integer :: nekcomm
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
            integer, parameter :: lorder2=max(1,lorder-2)
            integer, parameter :: lorder=3
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
      integer :: n
      real :: tmin
      integer :: i
      real, dimension(1:1) :: a
      real, dimension(1:1) :: tmp
      real, dimension(1:1) :: work
      tmin=99.0e20
      do i=1,n
         tmin=min(tmin,a(i))
   end do
      tmp(1)=tmin
      tmp_gop = reshape(tmp,shape(tmp_gop))
      work_gop = reshape(work,shape(work_gop))
      call gop(tmp_gop,work_gop,'m  ',1,ab,abmsh,abx1,abx2,aby1,aby2,abz1,abz2,area,atol,avdiff, &
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
      tmp = reshape(tmp_gop, shape(tmp))
      work = reshape(work_gop, shape(work))
      glmin = tmp(1)
      return
      end function glmin

end module singleton_module_src_math


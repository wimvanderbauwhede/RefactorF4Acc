      program cea2
      use params_cea_inc, only : maxr, maxnc, iotrn, maxngc, maxel, maxng, ncol, maxmix, iosch, maxtr, iothm, ioout, maxmat, maxpv, maxt
      implicit none
      real(kind=8), dimension(1:100) :: atmwt
      real(kind=8) :: avgdr
      real(kind=8) :: boltz
      character(len=4), dimension(1:30) :: fmt
      real(kind=8) :: pi
      real(kind=8) :: rr
      character(len=2), dimension(1:100) :: symbol
      real(kind=8), dimension(1:100) :: valnce
      logical :: newr
      integer :: iplt
      integer :: nplt
      integer :: nof
      real(kind=8), dimension(1:maxel,1:2) :: b0p
      real(kind=8), dimension(1:maxmix) :: oxf
      integer :: nlm
      logical :: ions
      character(len=2), dimension(1:maxel) :: elmt
      integer :: nreac
      integer, dimension(1:maxr) :: jray
      integer :: ngc
      logical :: trnspt
      integer :: npr
      logical :: gonly
      real(kind=8) :: enn
      real(kind=8) :: ennl
      real(kind=8) :: sumn
      integer :: ng
      integer :: nc
      real(kind=8), dimension(1:maxngc,1:ncol) :: en
      real(kind=8), dimension(1:maxngc) :: enln
      integer :: nsert
      integer :: ngp1
      character(len=15), dimension(0:maxngc) :: prod
      integer, dimension(1:45) :: jcond
      logical :: short
      logical :: rkt
      logical :: hp
      logical :: sp
      logical :: tp
      logical :: detn
      logical :: shock
      integer :: nonly
      integer :: nomit
      real(kind=8) :: trace
      logical :: massf
      logical, dimension(1:ncol) :: debug
      logical :: siunit
      character(len=15), dimension(0:maxngc) :: omit
      character(len=15), dimension(1:20) :: pltvar
      logical :: moles
      real(kind=8), dimension(1:maxr) :: pecwt
      real(kind=8), dimension(1:maxr) :: rtemp
      character(len=15), dimension(1:maxr) :: energy
      real(kind=8), dimension(1:maxr) :: enth
      real(kind=8), dimension(1:maxr) :: dens
      integer, dimension(1:maxr) :: nfla
      character(len=2), dimension(1:maxr,1:12) :: ratom
      real(kind=8), dimension(1:maxr,1:12) :: rnum
      character(len=8), dimension(1:maxr) :: fox
      character(len=15), dimension(1:maxr) :: rname
      real(kind=8), dimension(1:maxr) :: rmw
      character(len=15) :: case
      real(kind=8), dimension(1:maxpv) :: p
      real(kind=8), dimension(1:maxpv) :: v
      real(kind=8), dimension(1:maxt) :: t
      integer :: lsave
      real(kind=8) :: r
      real(kind=8) :: s0
      logical :: vol
      logical :: eql
      logical :: froz
      logical :: fac
      logical :: debugf
      real(kind=8) :: acat
      real(kind=8) :: ma
      integer :: nfz
      integer :: nsub
      integer :: nsup
      integer :: npp
      real(kind=8) :: tcest
      real(kind=8), dimension(1:2*ncol) :: pcp
      real(kind=8), dimension(1:13) :: supar
      real(kind=8), dimension(1:13) :: subar
      real(kind=8), dimension(1:ncol) :: mach1
      real(kind=8), dimension(1:ncol) :: u1
      real(kind=8) :: gamma1
      logical :: shkdbg
      logical :: incdeq
      logical :: incdfz
      logical :: refleq
      logical :: reflfz
      integer :: np
      integer :: nt
      logical :: detdbg
      real(kind=8) :: hsub0
      real(kind=8) :: size
      real(kind=8) :: viscns
      real(kind=8), dimension(1:2) :: wp
      real(kind=8), dimension(1:2) :: vmin
      real(kind=8), dimension(1:2) :: vpls
      integer :: nsk
      character(len=10) :: thdate
      real(kind=8), dimension(1:2) :: hpp
      real(kind=8), dimension(1:2) :: am
      real(kind=8), dimension(1:2) :: rh
      real(kind=8) :: tt
      real(kind=8), dimension(1:4) :: tg
      real(kind=8) :: tln
      real(kind=8), dimension(1:maxel) :: atwt
      real(kind=8), dimension(1:maxmat) :: x
      integer, dimension(1:maxel) :: jx
      real(kind=8), dimension(1:maxngc) :: s
      real(kind=8), dimension(1:maxngc) :: h0
      real(kind=8), dimension(1:maxngc) :: deln
      real(kind=8), dimension(1:maxel,1:maxngc) :: a
      real(kind=8), dimension(1:maxnc,1:9) :: cft
      integer, dimension(1:maxnc) :: ifz
      real(kind=8), dimension(1:maxngc) :: mw
      real(kind=8), dimension(1:2,1:maxnc) :: temp
      real(kind=8), dimension(1:maxng,1:9,1:3) :: coef
      integer, dimension(1:maxel) :: jcm
      integer :: nspx
      real(kind=8), dimension(1:maxngc) :: cp
      integer :: ntape
      real(kind=8), dimension(1:ncol) :: app
      integer :: iopt
      real(kind=8) :: pp
      integer :: it
      real(kind=8) :: oxfl
      integer :: ip
      logical :: area
      integer :: isup
      logical :: page1
      integer :: npt
      real(kind=8) :: cpsum
      real(kind=8), dimension(1:ncol) :: ppp
      integer :: isv
      real(kind=8), dimension(1:ncol) :: cpr
      real(kind=8), dimension(1:ncol) :: dlvpt
      real(kind=8), dimension(1:ncol) :: dlvtp
      real(kind=8), dimension(1:ncol) :: gammas
      real(kind=8), dimension(1:ncol) :: hsum
      real(kind=8), dimension(1:ncol) :: ssum
      real(kind=8), dimension(1:ncol) :: totn
      real(kind=8), dimension(1:ncol) :: ttt
      real(kind=8), dimension(1:ncol) :: vlm
      real(kind=8), dimension(1:ncol) :: wm
      real(kind=8) :: vv
      integer :: jsol
      real(kind=8) :: awt
      real(kind=8), dimension(1:ncol) :: aeat
      integer :: jliq
      real(kind=8) :: eqrat
      real(kind=8), dimension(1:maxel) :: b0
      real(kind=8) :: bcheck
      real(kind=8) :: wmix
      logical :: pderiv
      logical :: convg
      real(kind=8) :: tm
      integer :: iq1
      integer :: imat
      real(kind=8), dimension(1:maxmat,1:maxmat+1) :: g
      integer :: msing
      real(kind=8), dimension(1:maxngc) :: mu
      integer :: nm
      real(kind=8), dimension(1:ncol) :: confro
      real(kind=8), dimension(1:ncol) :: vis
      real(kind=8), dimension(1:maxtr,1:maxtr) :: eta
      real(kind=8), dimension(1:maxtr) :: wmol
      real(kind=8), dimension(1:maxtr) :: xs
      real(kind=8), dimension(1:maxtr) :: con
      integer :: nr
      real(kind=8), dimension(1:maxtr,1:maxtr) :: stc
      integer, dimension(1:maxtr) :: ind
      real(kind=8), dimension(1:ncol) :: cpfro
      real(kind=8), dimension(1:maxtr) :: cprr
      real(kind=8), dimension(1:ncol) :: prfro
      real(kind=8), dimension(1:ncol) :: cpeql
      real(kind=8), dimension(1:ncol) :: coneql
      real(kind=8), dimension(1:ncol) :: preql
      real(kind=8) :: ensave
      real(kind=8) :: enlsav
      real(kind=8), dimension(1:maxngc) :: sln
      real(kind=8), dimension(1:ncol) :: spim
      real(kind=8) :: cstr
      real(kind=8), dimension(1:ncol) :: vmoc
      real(kind=8), dimension(1:ncol) :: sonvel
      real(kind=8), dimension(1:500,1:20) :: pltout
      real(kind=8) :: cpmix
      integer :: nspr
      real(kind=8) :: a1
      character(len=15), dimension(1:20) :: ensert
      character(len=200) :: infile
      character(len=200) :: ofile
      character(len=196) :: prefix
      logical :: caseok
      logical :: ex
      logical :: readok
      integer :: i
      integer :: inc
      integer :: iof
      integer :: j
      integer :: ln
      integer :: n
      integer :: index
      real(kind=8) :: xi
      real(kind=8) :: xln
      real(kind=8) :: dlog
      call block_data(atmwt,avgdr,boltz,fmt,pi,rr,symbol,valnce)
      open (iosch,status='scratch',form='unformatted')
      open (iothm,file='thermo.lib',form='unformatted')
      open (iotrn,file='trans.lib',form='unformatted')
      write (ioout,99006)
      write (ioout,99007)
      write (ioout,99006)
      readok = .true.
      newr = .false.
 100  iplt = 0
      nplt = 0
      call input(readok,caseok,ensert,nonly,nomit,nsert,trace,short,massf,debug,nplt,siunit,prod,omit,newr,trnspt,pltvar,moles,nreac,pecwt,rtemp,energy,enth,rr,dens,nfla,ratom,rnum,fox,rname,jray,rmw,case,p,v,t,lsave,r,s0,tp,hp,sp,rkt,shock,detn,vol,ions,eql,froz,fac,debugf,acat,ma,nfz,nsub,nsup,npp,tcest,pcp,supar,subar,mach1,u1,gamma1,shkdbg,incdeq,incdfz,refleq,reflfz,np,nt,detdbg,nof,hsub0,size,viscns,avgdr,boltz,pi,nlm,oxf,wp,vmin,vpls,nsk,thdate,hpp,am,rh,elmt,b0p,tt,tg,tln,symbol,atmwt,atwt,x,valnce)
      if ( caseok.and.readok ) then
        do iof = 1,nof
          if ( oxf(iof) == 0..and.b0p(1,1) /= 0. ) then
            do i = 1,nlm
              if ( b0p(i,1) == 0..or.b0p(i,2) == 0. ) then
                write (ioout,99008)
                goto 200
              endif
            enddo
          endif
        enddo
        if ( ions ) then
          if ( elmt(nlm) /= 'E' ) then
            nlm = nlm + 1
            elmt(nlm) = 'E'
            b0p(nlm,1) = 0.
            b0p(nlm,2) = 0.
          endif
        elseif ( elmt(nlm) == 'E' ) then
          nlm = nlm - 1
        endif
        do n = 1,nreac
          jray(n) = 0
        enddo
        call search(nc,nlm,jx,s,h0,deln,a,tg,thdate,ngc,cft,ifz,mw,temp,nonly,prod,nomit,omit,elmt,ng,coef,jcm,ngp1,nspx,symbol,atmwt,atwt,cp,short,ntape)
        if ( ngc == 0 ) goto 300
        newr = .false.
        call readtr(nc,nlm,jx,s,h0,deln,a,tg,thdate,ngc,cft,ifz,mw,temp,nonly,prod,nomit,omit,elmt,ng,coef,jcm,ngp1,nspx,symbol,atmwt,atwt,cp,short,ntape)
        npr = 0
        gonly = .true.
        enn = .1d0
        ennl = -2.3025851
        sumn = enn
        xi = ng
        if ( xi == 0. ) xi = 1.
        xi = enn/xi
        xln = dlog(xi)
        do inc = 1,nc
          j = ng + inc
          en(j,1) = 0.d0
          enln(j) = 0.d0
        enddo
        do j = 1,ng
          en(j,1) = xi
          enln(j) = xln
        enddo
        if ( nc /= 0.and.nsert /= 0 ) then
          do i = 1,nsert
            do j = ngc,ngp1, - 1
              if ( prod(j) == ensert(i) ) then
                npr = npr + 1
                jcond(npr) = j
                if ( .not.short ) write (ioout,99003) prod(j)
                goto 120
              endif
            enddo
            write (ioout,99004) ensert(i)
 120      continue
      end do
        endif
        if ( rkt ) then
          call rocket(iplt,app,iopt,npp,fac,eql,acat,ma,tt,nsub,subar,nfz,nsup,froz,tcest,pp,p,it,oxfl,oxf,t,tp,hp,sp,ip,np,area,isup,page1,npt,cpsum,trnspt,ppp,debugf,isv,cpr,dlvpt,dlvtp,gammas,hsum,ssum,totn,ttt,vlm,wm,short,rr,vv,debug,jsol,enn,npr,s0,awt,aeat,supar,jliq,pcp,nof,nt,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,wmix,size,hsub0,hpp,vol,jcm,prod,trace,ngc,pderiv,convg,jcond,ng,ifz,temp,en,nc,enln,deln,tln,tm,lsave,a,ions,shock,elmt,cp,iq1,imat,g,msing,x,h0,mu,ennl,s,sumn,tg,ngp1,mw,jx,nspx,atwt,gonly,coef,cft,nm,confro,vis,eta,wmol,xs,con,nr,stc,ind,r,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,incdeq,nreac,jray,ntape,boltz,avgdr,pi,viscns,ensave,enlsav,sln,fmt,nplt,pltvar,spim,cstr,vmoc,sonvel,pltout,massf,case,moles,enth,fox,pecwt,rname,rtemp,rh,rkt,omit)
        elseif ( tp.or.hp.or.sp ) then
          call thermp(hp,tp,sp,eql,nof,oxfl,oxf,ip,np,pp,p,it,nt,vv,v,tt,t,npt,trnspt,isv,vol,iplt,short,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,wmix,size,hsub0,hpp,jsol,jliq,jcm,prod,trace,ngc,pderiv,convg,npr,jcond,ng,ifz,temp,en,nc,enln,deln,tln,enn,rr,tm,lsave,a,ions,shock,elmt,debug,cpsum,cp,iq1,imat,g,msing,x,h0,mu,ennl,s,totn,sumn,dlvtp,cpr,dlvpt,gammas,hsum,ssum,s0,tg,ngp1,mw,jx,nspx,atwt,ttt,ppp,vlm,wm,gonly,coef,cft,nm,confro,vis,eta,wmol,xs,con,nr,stc,ind,r,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,incdeq,nreac,jray,nfz,ntape,boltz,avgdr,pi,viscns,case,moles,enth,fox,pecwt,rname,rtemp,rh,page1,rkt,iopt,nplt,pltvar,pltout,fmt,sonvel,massf,omit,ensave,enlsav,sln)
        elseif ( detn ) then
          call deton(eql,t,rtemp,nt,tt,oxfl,oxf,it,ip,np,p,pp,detdbg,npt,hsub0,r,cpmix,wmix,tp,hp,gammas,cpr,wm,dlvpt,dlvtp,hsum,rr,vmoc,trnspt,isv,nplt,pltvar,fmt,siunit,v,pltout,iplt,sonvel,ppp,pcp,ttt,nof,short,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,size,hpp,jsol,jliq,vol,jcm,prod,tm,ssum,nspr,nspx,nreac,fox,jray,ngc,rname,ng,tg,mw,nfla,ratom,rnum,coef,energy,moles,pecwt,wp,rmw,tln,en,s,h0,cp,case,enth,rh,page1,rkt,iopt,gonly,x,vlm,totn,trace,massf,omit,vis,coneql,preql,confro,prfro,cpeql,cpfro,pderiv,convg,npr,jcond,ifz,temp,nc,enln,deln,enn,vv,lsave,a,ions,shock,elmt,debug,cpsum,iq1,imat,g,msing,mu,ennl,sumn,sp,s0,ngp1,jx,atwt,cft,nm,eta,wmol,xs,con,nr,stc,ind,cprr,incdeq,nfz,ntape,boltz,avgdr,pi,viscns,ensave,enlsav,sln)
        elseif ( shock ) then
          call shck(trace,tp,cpmix,short,incdeq,incdfz,refleq,reflfz,t,rtemp,nsk,u1,mach1,oxfl,oxf,pp,p,tt,dlvtp,dlvpt,npt,ppp,ttt,ssum,hsum,tg,hsub0,gamma1,wmix,a1,rr,wm,cpr,gammas,vlm,eql,fmt,hp,shkdbg,tln,cpsum,ng,en,h0,g,x,ngc,s,trnspt,isv,massf,nreac,jray,mw,prod,iplt,nof,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,size,hpp,jsol,jliq,vol,jcm,tm,nspr,nspx,fox,rname,nfla,ratom,rnum,coef,energy,moles,pecwt,wp,rmw,cp,case,siunit,enth,r,rh,page1,rkt,iopt,nplt,pltvar,gonly,pltout,totn,sonvel,omit,vis,coneql,preql,confro,prfro,cpeql,cpfro,pderiv,convg,npr,jcond,ifz,temp,nc,enln,deln,enn,vv,lsave,a,ions,shock,elmt,debug,iq1,imat,msing,mu,ennl,sumn,sp,s0,ngp1,jx,atwt,cft,nm,eta,wmol,xs,con,nr,stc,ind,cprr,nfz,ntape,boltz,avgdr,pi,viscns,ensave,enlsav,sln)
        endif
      endif
 200  if ( readok ) goto 100
 300  close (iosch)
      close (iothm)
      close (iotrn)
 400  stop
99001 format (//' ENTER INPUT FILE NAME WITHOUT .inp EXTENSION.'/         '   THE OUTPUT FILES FOR LISTING AND PLOTTING WILL HAVE',/       ' THE SAME NAME WITH EXTENSIONS .out AND .plt RESPECTIVELY'       //)
99002 format (a)
99003 format (1x,a16,'INSERTED')
99004 format (/' WARNING!!!',a16,'NOT FOUND FOR INSERTION')
99005 format (1x,1p,20e12.4)
99006 format (/' ***************************************************',        '****************************')
99007 format (/,9x,'NASA-GLENN CHEMICAL EQUILIBRIUM PROGRAM CEA2,',        ' MAY 21, 2004',/19x,'BY  BONNIE MCBRIDE',         ' AND SANFORD GORDON',/5x,        ' REFS: NASA RP-1311, PART I, 1994',        ' AND NASA RP-1311, PART II, 1996')
99008 format (/,'OXIDANT NOT PERMITTED WHEN SPECIFYING 100% FUEL(main)')
99009 format ('#',2x,20a12)
      end program cea2
      subroutine block_data(atmwt_ARG,avgdr_ARG,boltz_ARG,fmt_ARG,pi_ARG,rr_ARG,symbol_ARG,valnce_ARG)
!!      use params_cea_inc ! ONLY LIST EMPTY
      implicit none
      real(kind=8), dimension(1:100) :: atmwt
      real(kind=8) :: avgdr
      real(kind=8) :: boltz
      character(len=4), dimension(1:30) :: fmt
      real(kind=8) :: pi
      real(kind=8) :: rr
      character(len=2), dimension(1:100) :: symbol
      real(kind=8), dimension(1:100) :: valnce
      real(kind=8), dimension(1:100), intent(InOut) :: atmwt_ARG
      real(kind=8), intent(InOut) :: avgdr_ARG
      real(kind=8), intent(InOut) :: boltz_ARG
      character(len=4), dimension(1:30), intent(InOut) :: fmt_ARG
      real(kind=8), intent(InOut) :: pi_ARG
      real(kind=8), intent(InOut) :: rr_ARG
      character(len=2), dimension(1:100), intent(InOut) :: symbol_ARG
      real(kind=8), dimension(1:100), intent(InOut) :: valnce_ARG
      data rr / 8314.51d0 / ,pi / 3.14159265d0 / ,avgdr / 6.0221367d0 / ,boltz / 1.380658d0 / 
      data symbol / 'H ','D ','HE','LI','BE','B ','C ','N ','O ','F ','NE','NA','MG','AL','SI','P ','S ','CL','AR','K ','CA','SC','TI','V ','CR','MN','FE','CO','NI','CU','ZN','GA','GE','AS','SE','BR','KR','RB','SR','Y ','ZR','NB','MO','TC','RU','RH','PD','AG','CD','IN','SN','SB','TE','I ','XE','CS','BA','LA','CE','PR','ND','PM','SM','EU','GD','TB','DY','HO','ER','TM','YB','LU','HF','TA','W ','RE','OS','IR','PT','AU','HG','TL','PB','BI','PO','AT','RN','FR','RA','AC','TH','PA','U ','NP','PU','AM','CM','BK','CF','ES' / 
      data atmwt / 1.00794d0,2.014102d0,4.002602d0,6.941d0,9.012182d0,10.811d0,12.0107d0,14.0067d0,15.9994d0,18.9984032d0,20.1797d0,22.989770d0,24.305d0,26.981538d0,28.0855d0,30.973761d0,32.065d0,35.453d0,39.948d0,39.0983d0,40.078d0,44.95591d0,47.867d0,50.9415d0,51.9961d0,54.938049d0,55.845d0,58.933200d0,58.6934d0,63.546d0,65.39d0,69.723d0,72.64d0,74.92160d0,78.96d0,79.904d0,83.80d0,85.4678d0,87.62d0,88.90585d0,91.224d0,92.90638d0,95.94d0,97.9072d0,101.07d0,102.9055d0,106.42d0,107.8682d0,112.411d0,114.818d0,118.710d0,121.760d0,127.6d0,126.90447d0,131.293d0,132.90545d0,137.327d0,138.9055d0,140.116d0,140.90765d0,144.9127d0,145.d0,150.36d0,151.964d0,157.25d0,158.92534d0,162.50d0,164.93032d0,167.259d0,168.93421d0,173.04d0,174.967d0,178.49d0,180.9479d0,183.84d0,186.207d0,190.23d0,192.217d0,195.078d0,196.96655d0,200.59d0,204.3833d0,207.2d0,208.98038d0,208.9824d0,209.9871d0,222.0176d0,223.0197d0,226.0254d0,227.0278d0,232.0381d0,231.03588d0,238.02891d0,237.0482d0,244.0642d0,243.0614d0,247.0703d0,247.0703d0,251.0587d0,252.083d0 / 
      data valnce / 1.,1.,0.,1.,2.,3.,4.,0.,-2.,-1.,0.,1.,2.,3.,4.,5.,4.,-1.,0.,1.,2.,3.,4.,5.,3.,2.,3.,2.,2.,2.,2.,3.,4.,3.,4.,-1.,0.,1.,2.,3.,4.,5.,6.,7.,3.,3.,2.,1.,2.,3.,4.,3.,4.,-1.,0.,1.,2.,3.,3.,3.,3.,3.,3.,3.,3.,3.,3.,3.,3.,3.,3.,3.,4.,5.,6.,7.,4.,4.,4.,3.,2.,1.,2.,3.,2.,-1.,0.,1.,2.,3.,4.,5.,6.,5.,4.,3.,3.,3.,3.,3. / 
      data fmt / '(1X',',A15',',','F9.','0,','F9.','0,','F9.','0,','F9.','0,','F9.','0,','F9.','0,','F9.','0,','F9.','0,','F9.','0,','F9.','0,','F9.','0,','F9.','0,','F9.','0',')' / 
        atmwt_ARG = atmwt
        avgdr_ARG = avgdr
        boltz_ARG = boltz
        fmt_ARG = fmt
        pi_ARG = pi
        rr_ARG = rr
        symbol_ARG = symbol
        valnce_ARG = valnce
      end subroutine block_data
      subroutine cphs(tg,tt,tln,ng,h0,s,coef,convg,tp,cp,ngc,npr,jcond,cft,nc)
      use params_cea_inc, only : maxngc, maxnc, maxng
      implicit none
      real(kind=8), dimension(1:4) :: tg
      real(kind=8) :: tt
      real(kind=8) :: tln
      integer :: ng
      real(kind=8), dimension(1:maxngc) :: h0
      real(kind=8), dimension(1:maxngc) :: s
      real(kind=8), dimension(1:maxng,1:9,1:3) :: coef
      logical :: convg
      logical :: tp
      real(kind=8), dimension(1:maxngc) :: cp
      integer :: ngc
      integer :: npr
      integer, dimension(1:45) :: jcond
      real(kind=8), dimension(1:maxnc,1:9) :: cft
      integer :: nc
      real(kind=8), dimension(1:7) :: cx
      real(kind=8), dimension(1:7) :: hcx
      real(kind=8), dimension(1:7) :: scx
      integer :: i
      integer :: ij
      integer :: j
      integer :: jj
      integer :: k
      save i,ij,j,jj,k,scx
      data cx / 2*0.,1.d0,.5d0,.6666666666666667d0,.75d0,.8d0 / 
      data hcx(3) / 1.d0 / 
      k = 1
      if ( tt > tg(2) ) k = 2
      if ( tt > tg(3) ) k = 3
      cx(2) = 1.d0/tt
      cx(1) = cx(2)**2
      scx(3) = tln
      scx(2) = -cx(2)
      hcx(2) = tln*cx(2)
      hcx(1) = -cx(1)
      scx(1) = hcx(1)*.5d0
      do i = 4,7
        hcx(i) = cx(i)*tt
        scx(i) = cx(i-1)*tt
      enddo
      do j = 1,ng
        h0(j) = 0.d0
        s(j) = 0.d0
      enddo
      do i = 7,4, - 1
        do j = 1,ng
          s(j) = (s(j)+coef(j,i,k))*scx(i)
          h0(j) = (h0(j)+coef(j,i,k))*hcx(i)
        enddo
      enddo
      do i = 1,3
        do j = 1,ng
          s(j) = s(j) + coef(j,i,k)*scx(i)
          h0(j) = h0(j) + coef(j,i,k)*hcx(i)
        enddo
      enddo
      do j = 1,ng
        s(j) = s(j) + coef(j,9,k)
        h0(j) = h0(j) + coef(j,8,k)*cx(2)
      enddo
      if ( .not.tp.or.convg ) then
        do j = 1,ng
          cp(j) = 0.d0
        enddo
        do i = 7,4, - 1
          do j = 1,ng
            cp(j) = (cp(j)+coef(j,i,k))*tt
          enddo
        enddo
        do i = 1,3
          do j = 1,ng
            cp(j) = cp(j) + coef(j,i,k)*cx(i)
          enddo
        enddo
      endif
      if ( npr /= 0.and.k /= 3.and.ng /= ngc ) then
        do ij = 1,npr
          j = jcond(ij)
          jj = jcond(ij) - ng
          cp(j) = 0.d0
          h0(j) = 0.d0
          s(j) = 0.d0
          do i = 7,4, - 1
            s(j) = (s(j)+cft(jj,i))*scx(i)
            h0(j) = (h0(j)+cft(jj,i))*hcx(i)
            cp(j) = (cp(j)+cft(jj,i))*tt
          enddo
          do i = 1,3
            s(j) = s(j) + cft(jj,i)*scx(i)
            h0(j) = h0(j) + cft(jj,i)*hcx(i)
            cp(j) = cp(j) + cft(jj,i)*cx(i)
          enddo
          s(j) = s(j) + cft(jj,9)
          h0(j) = h0(j) + cft(jj,8)*cx(2)
        enddo
      endif
      goto 99999
      entry allcon(tg,tt,tln,ng,h0,s,coef,convg,tp,cp,ngc,npr,jcond,cft,nc)
      do jj = 1,nc
        j = jj + ng
        cp(j) = 0.d0
        h0(j) = 0.d0
        s(j) = 0.d0
        do i = 7,4, - 1
          s(j) = (s(j)+cft(jj,i))*scx(i)
          h0(j) = (h0(j)+cft(jj,i))*hcx(i)
          cp(j) = (cp(j)+cft(jj,i))*tt
        enddo
        do i = 1,3
          s(j) = s(j) + cft(jj,i)*scx(i)
          h0(j) = h0(j) + cft(jj,i)*hcx(i)
          cp(j) = cp(j) + cft(jj,i)*cx(i)
        enddo
        s(j) = s(j) + cft(jj,9)
        h0(j) = h0(j) + cft(jj,8)*cx(2)
      enddo
99999 end subroutine cphs
      subroutine deton(eql,t,rtemp,nt,tt,oxfl,oxf,it,ip,np,p,pp,detdbg,npt,hsub0,r,cpmix,wmix,tp,hp,gammas,cpr,wm,dlvpt,dlvtp,hsum,rr,vmoc,trnspt,isv,nplt,pltvar,fmt,siunit,v,pltout,iplt,sonvel,ppp,pcp,ttt,nof,short,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,size,hpp,jsol,jliq,vol,jcm,prod,tm,ssum,nspr,nspx,nreac,fox,jray,ngc,rname,ng,tg,mw,nfla,ratom,rnum,coef,energy,moles,pecwt,wp,rmw,tln,en,s,h0,cp,case,enth,rh,page1,rkt,iopt,gonly,x,vlm,totn,trace,massf,omit,vis,coneql,preql,confro,prfro,cpeql,cpfro,pderiv,convg,npr,jcond,ifz,temp,nc,enln,deln,enn,vv,lsave,a,ions,shock,elmt,debug,cpsum,iq1,imat,g,msing,mu,ennl,sumn,sp,s0,ngp1,jx,atwt,cft,nm,eta,wmol,xs,con,nr,stc,ind,cprr,incdeq,nfz,ntape,boltz,avgdr,pi,viscns,ensave,enlsav,sln)
      use params_cea_inc, only : maxel, maxngc, maxnc, maxr, maxmix, ncol, maxng, maxtr, maxt, ioout, maxpv, maxmat
      implicit none
      logical, intent(Out) :: eql
      real(kind=8), dimension(1:maxt), intent(InOut) :: t
      real(kind=8), dimension(1:maxr), intent(In) :: rtemp
      integer, intent(InOut) :: nt
      real(kind=8), intent(InOut) :: tt
      real(kind=8), intent(Out) :: oxfl
      real(kind=8), dimension(1:maxmix), intent(In) :: oxf
      integer, intent(InOut) :: it
      integer, intent(InOut) :: ip
      integer, intent(In) :: np
      real(kind=8), dimension(1:maxpv), intent(In) :: p
      real(kind=8), intent(Out) :: pp
      logical, intent(In) :: detdbg
      integer, intent(InOut) :: npt
      real(kind=8), intent(InOut) :: hsub0
      real(kind=8), intent(In) :: r
      real(kind=8), intent(InOut) :: cpmix
      real(kind=8), intent(InOut) :: wmix
      logical, intent(Out) :: tp
      logical, intent(Out) :: hp
      real(kind=8), dimension(1:ncol), intent(InOut) :: gammas
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpr
      real(kind=8), dimension(1:ncol), intent(InOut) :: wm
      real(kind=8), dimension(1:ncol), intent(InOut) :: dlvpt
      real(kind=8), dimension(1:ncol), intent(InOut) :: dlvtp
      real(kind=8), dimension(1:ncol), intent(InOut) :: hsum
      real(kind=8), intent(In) :: rr
      real(kind=8), dimension(1:ncol), intent(InOut) :: vmoc
      logical, intent(In) :: trnspt
      integer, intent(InOut) :: isv
      integer, intent(In) :: nplt
      character(len=15), dimension(1:20), intent(In) :: pltvar
      character(len=4), dimension(1:30) :: fmt
      logical, intent(In) :: siunit
      real(kind=8), dimension(1:maxpv), intent(InOut) :: v
      real(kind=8), dimension(1:500,1:20), intent(Out) :: pltout
      integer, intent(InOut) :: iplt
      real(kind=8), dimension(1:ncol), intent(InOut) :: sonvel
      real(kind=8), dimension(1:ncol), intent(InOut) :: ppp
      real(kind=8), dimension(1:2*ncol), intent(InOut) :: pcp
      real(kind=8), dimension(1:ncol), intent(InOut) :: ttt
      integer, intent(In) :: nof
      logical, intent(In) :: short
      real(kind=8), intent(Out) :: eqrat
      real(kind=8), dimension(1:2), intent(In) :: vmin
      real(kind=8), dimension(1:2), intent(In) :: vpls
      integer, intent(InOut) :: nlm
      real(kind=8), dimension(1:maxel), intent(InOut) :: b0
      real(kind=8), dimension(1:maxel,1:2), intent(InOut) :: b0p
      real(kind=8), intent(Out) :: bcheck
      real(kind=8), dimension(1:2), intent(In) :: am
      real(kind=8), intent(InOut) :: size
      real(kind=8), dimension(1:2), intent(InOut) :: hpp
      integer, intent(Out) :: jsol
      integer, intent(Out) :: jliq
      logical, intent(In) :: vol
      integer, dimension(1:maxel), intent(InOut) :: jcm
      character(len=15), dimension(0:maxngc), intent(In) :: prod
      real(kind=8), intent(InOut) :: tm
      real(kind=8), dimension(1:ncol), intent(InOut) :: ssum
      integer, intent(InOut) :: nspr
      integer, intent(In) :: nspx
      integer, intent(In) :: nreac
      character(len=8), dimension(1:maxr), intent(In) :: fox
      integer, dimension(1:maxr), intent(InOut) :: jray
      integer, intent(In) :: ngc
      character(len=15), dimension(1:maxr), intent(In) :: rname
      integer, intent(InOut) :: ng
      real(kind=8), dimension(1:4), intent(In) :: tg
      real(kind=8), dimension(1:maxngc), intent(In) :: mw
      integer, dimension(1:maxr), intent(Out) :: nfla
      character(len=2), dimension(1:maxr,1:12), intent(Out) :: ratom
      real(kind=8), dimension(1:maxr,1:12), intent(Out) :: rnum
      real(kind=8), dimension(1:maxng,1:9,1:3), intent(InOut) :: coef
      character(len=15), dimension(1:maxr), intent(Out) :: energy
      logical, intent(In) :: moles
      real(kind=8), dimension(1:maxr), intent(In) :: pecwt
      real(kind=8), dimension(1:2), intent(In) :: wp
      real(kind=8), dimension(1:maxr), intent(In) :: rmw
      real(kind=8), intent(InOut) :: tln
      real(kind=8), dimension(1:maxngc,1:ncol), intent(Out) :: en
      real(kind=8), dimension(1:maxngc), intent(InOut) :: s
      real(kind=8), dimension(1:maxngc), intent(InOut) :: h0
      real(kind=8), dimension(1:maxngc), intent(InOut) :: cp
      character(len=15) :: case
      real(kind=8), dimension(1:maxr) :: enth
      real(kind=8), dimension(1:2) :: rh
      logical :: page1
      logical :: rkt
      integer :: iopt
      logical, intent(Out) :: gonly
      real(kind=8), dimension(1:maxmat), intent(InOut) :: x
      real(kind=8), dimension(1:ncol), intent(InOut) :: vlm
      real(kind=8), dimension(1:ncol), intent(InOut) :: totn
      real(kind=8), intent(In) :: trace
      logical :: massf
      character(len=15), dimension(0:maxngc) :: omit
      real(kind=8), dimension(1:ncol), intent(InOut) :: vis
      real(kind=8), dimension(1:ncol), intent(InOut) :: coneql
      real(kind=8), dimension(1:ncol), intent(Out) :: preql
      real(kind=8), dimension(1:ncol), intent(InOut) :: confro
      real(kind=8), dimension(1:ncol), intent(Out) :: prfro
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpeql
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpfro
      logical, intent(InOut) :: pderiv
      logical, intent(InOut) :: convg
      integer, intent(InOut) :: npr
      integer, dimension(1:45), intent(InOut) :: jcond
      integer, dimension(1:maxnc), intent(In) :: ifz
      real(kind=8), dimension(1:2,1:maxnc), intent(In) :: temp
      integer, intent(In) :: nc
      real(kind=8), dimension(1:maxngc), intent(InOut) :: enln
      real(kind=8), dimension(1:maxngc), intent(InOut) :: deln
      real(kind=8), intent(InOut) :: enn
      real(kind=8), intent(In) :: vv
      integer, intent(InOut) :: lsave
      real(kind=8), dimension(1:maxel,1:maxngc), intent(InOut) :: a
      logical, intent(In) :: ions
      logical, intent(In) :: shock
      character(len=2), dimension(1:maxel), intent(InOut) :: elmt
      logical, dimension(1:ncol), intent(In) :: debug
      real(kind=8), intent(InOut) :: cpsum
      integer, intent(InOut) :: iq1
      integer, intent(InOut) :: imat
      real(kind=8), dimension(1:maxmat,1:maxmat+1), intent(InOut) :: g
      integer, intent(InOut) :: msing
      real(kind=8), dimension(1:maxngc), intent(InOut) :: mu
      real(kind=8), intent(InOut) :: ennl
      real(kind=8), intent(InOut) :: sumn
      logical, intent(In) :: sp
      real(kind=8), intent(In) :: s0
      integer, intent(In) :: ngp1
      integer, dimension(1:maxel), intent(InOut) :: jx
      real(kind=8), dimension(1:maxel), intent(InOut) :: atwt
      real(kind=8), dimension(1:maxnc,1:9) :: cft
      integer, intent(InOut) :: nm
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: eta
      real(kind=8), dimension(1:maxtr), intent(InOut) :: wmol
      real(kind=8), dimension(1:maxtr), intent(InOut) :: xs
      real(kind=8), dimension(1:maxtr), intent(InOut) :: con
      integer, intent(InOut) :: nr
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: stc
      integer, dimension(1:maxtr), intent(InOut) :: ind
      real(kind=8), dimension(1:maxtr), intent(InOut) :: cprr
      logical, intent(In) :: incdeq
      integer, intent(In) :: nfz
      integer, intent(In) :: ntape
      real(kind=8), intent(In) :: boltz
      real(kind=8), intent(In) :: avgdr
      real(kind=8), intent(In) :: pi
      real(kind=8), intent(In) :: viscns
      real(kind=8), intent(InOut) :: ensave
      real(kind=8), intent(InOut) :: enlsav
      real(kind=8), dimension(1:maxngc), intent(InOut) :: sln
      character(len=15) :: fdv
      character(len=15) :: fg1
      character(len=15) :: fh1
      character(len=15) :: fhs1
      character(len=15) :: fm1
      character(len=15) :: fmm1
      character(len=15) :: fpp1
      character(len=15) :: frr1
      character(len=15) :: ft1
      character(len=15) :: ftt1
      character(len=3) :: unit
      integer :: i
      integer :: ii
      integer :: iof
      integer :: itr
      integer :: j
      integer :: mdv
      integer :: mgam
      integer :: mh
      integer :: mmach
      integer :: mp
      integer :: mson
      integer :: mt
      integer, dimension(1:8) :: mxx
      integer :: index
      real(kind=8) :: a11
      real(kind=8) :: a12
      real(kind=8) :: a21
      real(kind=8) :: a22
      real(kind=8) :: alam
      real(kind=8) :: alfa
      real(kind=8) :: amm
      real(kind=8) :: b1
      real(kind=8) :: b2
      real(kind=8), dimension(1:ncol) :: cpl
      real(kind=8) :: d
      real(kind=8) :: gam
      real(kind=8), dimension(1:ncol) :: gm1
      real(kind=8), dimension(1:ncol) :: h1
      real(kind=8) :: p1
      real(kind=8) :: pp1
      real(kind=8), dimension(1:ncol) :: pub
      real(kind=8) :: rk
      real(kind=8) :: rr1
      real(kind=8), dimension(1:ncol) :: rrho
      real(kind=8) :: t1
      real(kind=8) :: tem
      real(kind=8) :: tt1
      real(kind=8), dimension(1:ncol) :: tub
      real(kind=8) :: ud
      real(kind=8) :: x1
      real(kind=8) :: x2
      save a11,a12,a21,a22,alam,alfa,amm,b1,b2,cpl,d,gam,gm1,h1,i,ii,  iof,itr,j,mdv,mgam,mh,mmach,mp,mson,mt,mxx,p1,pp1,pub,rk,rr1,  rrho,t1,tem,tt1,tub,ud,unit,x1,x2
      data ft1 / 'T1, K' / ,fh1 / 'H1, CAL/G' / ,fhs1 / 'H1, KJ/KG' / ,fm1 / 'M1, (1/n) ' / ,fg1 / 'GAMMA1' / ,fpp1 / 'P/P1' / ,ftt1 / 'T/T1' / ,fmm1 / 'M/M1' / ,frr1 / 'RHO/RHO1' / ,fdv / 'DET VEL,M/SEC' / 
      mp = mxx(1)
      mt = mxx(2)
      mgam = mxx(3)
      mh = mxx(4)
      mdv = mxx(5)
      mson = mxx(6)
      mmach = mxx(7)
      iof = 0
      eql = .true.
      if ( t(1) == 0. ) then
        t(1) = rtemp(1)
        nt = 1
      endif
 100  tt = t(1)
      iof = iof + 1
      oxfl = oxf(iof)
      call newof(short,oxfl,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,wmix,npt,size,hsub0,hpp,jsol,jliq,vol,jcm,prod)
      do it = 1,nt
        t1 = t(it)
        do ip = 1,np
          p1 = p(ip)
          tt = t1
          pp = p1
          call hcalc(tt,tm,pp,wmix,ssum,npt,hpp,hsub0,cpmix,oxfl,nspr,nspx,nreac,fox,rtemp,jray,ngc,prod,rname,ng,tg,mw,nfla,ratom,rnum,coef,energy,moles,pecwt,wp,rmw,tln,en,s,h0,cp)
          if ( tt == 0. ) return
          call out1(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
          h1(npt) = hsub0*r
          tub(npt) = t1
          pub(npt) = p1
          cpl(npt) = cpmix*r
          itr = 0
          tt = 3800.
          pp1 = 15.
          pp = pp1*p1
          hsub0 = h1(npt)/r + .75*t1*pp1/wmix
          tp = .false.
          hp = .true.
          call eqlbrm(nlm,size,trace,ngc,pderiv,convg,tp,tt,npr,t,jcond,ng,ifz,temp,en,npt,prod,short,nc,enln,deln,tln,vol,pp,enn,rr,vv,tm,lsave,a,ions,shock,elmt,debug,cpsum,cp,iq1,imat,g,msing,x,h0,mu,ennl,s,totn,sumn,hp,b0,bcheck,dlvtp,cpr,dlvpt,jliq,gammas,jsol,hsum,ssum,sp,s0,tg,ngp1,mw,jx,jcm,b0p,nspx,atwt,ttt,ppp,vlm,wm,gonly,coef,cft,hsub0)
          hsub0 = h1(npt)/r
          hp = .false.
          if ( tt /= 0. ) then
            gam = gammas(npt)
            tt1 = tt/t1
            ii = 0
            tem = tt1 - .75*pp1/(cpr(npt)*wmix)
            amm = wm(npt)/wmix
            if ( detdbg ) write (ioout,99001) tt
            do ii = 1,3
              alfa = amm/tt1
              pp1 = (1.+gam)*(1.+(1.-4.*gam*alfa/(1.+gam)**2)**.5)              /(2.*gam*alfa)
              rk = pp1*alfa
              tt1 = tem + .5*pp1*gam*(rk*rk-1.)/(wmix*cpr(npt)*rk)
              if ( detdbg ) write (ioout,99002) ii,pp1,tt1
            enddo
            tp = .true.
            tt = t1*tt1
            rr1 = pp1*amm/tt1
 110        itr = itr + 1
            pp = p1*pp1
            call eqlbrm(nlm,size,trace,ngc,pderiv,convg,tp,tt,npr,t,jcond,ng,ifz,temp,en,npt,prod,short,nc,enln,deln,tln,vol,pp,enn,rr,vv,tm,lsave,a,ions,shock,elmt,debug,cpsum,cp,iq1,imat,g,msing,x,h0,mu,ennl,s,totn,sumn,hp,b0,bcheck,dlvtp,cpr,dlvpt,jliq,gammas,jsol,hsum,ssum,sp,s0,tg,ngp1,mw,jx,jcm,b0p,nspx,atwt,ttt,ppp,vlm,wm,gonly,coef,cft,hsub0)
            if ( npt == 0 ) goto 200
            if ( tt /= 0. ) then
              gam = gammas(npt)
              amm = wm(npt)/wmix
              rr1 = pp1*amm/tt1
              a11 = 1./pp1 + gam*rr1*dlvpt(npt)
              a12 = gam*rr1*dlvtp(npt)
              a21 = .5*gam*(rr1**2-1.-dlvpt(npt)*(1.+rr1**2))              + dlvtp(npt) - 1.
              a22 = -.5*gam*dlvtp(npt)*(rr1**2+1.) - wm(npt)*cpr(npt)
              b1 = 1./pp1 - 1. + gam*(rr1-1.)
              b2 = wm(npt)*(hsum(npt)-h1(npt)/r)             /tt - .5*gam*(rr1*rr1-1.)
              d = a11*a22 - a12*a21
              x1 = (a22*b1-a12*b2)/d
              x2 = (a11*b2-a21*b1)/d
              alam = 1.
              tem = x1
              if ( tem < 0. ) tem = -tem
              if ( x2 > tem ) tem = x2
              if ( -x2 > tem ) tem = -x2
              if ( tem > 0.4054652 ) alam = .4054652/tem
              pp1 = pp1*exp(x1*alam)
              tt1 = tt1*exp(x2*alam)
              tt = t1*tt1
              ud = rr1*(rr*gam*tt/wm(npt))**.5
              if ( detdbg ) write (ioout,99003) itr,pp1,tt1,rr1,x1,x2
              if ( itr < 8.and.tem > 0.5e-04 ) goto 110
              if ( itr < 8 ) then
                rrho(npt) = rr1
                if ( cpl(npt) == 0. ) then
                  gm1(npt) = 0.
                  vmoc(npt) = 0.
                else
                  gm1(npt) = cpl(npt)/(cpl(npt)-r/wmix)
                  vmoc(npt) = ud/(rr*gm1(npt)*t1/wmix)**.5
                endif
              else
                write (ioout,99004)
                npt = npt - 1
                tt = 0.
              endif
              call tranp(nm,confro,npt,vis,eta,wmol,xs,con,eql,nr,lsave,jcm,h0,stc,ind,g,imat,r,x,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,shock,incdeq,nreac,jray,mw,en,wm,ngc,enln,ennl,ng,nfz,a,ntape,tt,tln,ions,boltz,avgdr,pi,rr,cp,nlm,viscns,msing)
              isv = 0
              if ( ip /= np.or.it /= nt.and.tt /= 0. ) then
                isv = npt
                if ( npt /= ncol ) goto 120
              endif
            endif
            write (ioout,99005)
            call out1(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
            do i = 1,8
              mxx(i) = 0
      mp = mxx(1)
      mt = mxx(2)
      mgam = mxx(3)
      mh = mxx(4)
      mdv = mxx(5)
      mson = mxx(6)
      mmach = mxx(7)
            enddo
            do i = 1,nplt
              if ( index(pltvar(i)(2:),'1') /= 0 ) then
                if ( pltvar(i)(:3) == 'son' ) then
                  mson = i
      mxx(6) = mson
                elseif ( pltvar(i)(:3) == 'gam' ) then
                  mgam = i
      mxx(3) = mgam
                elseif ( pltvar(i)(:1) == 'h' ) then
                  mh = i
      mxx(4) = mh
                elseif ( pltvar(i)(:1) == 't' ) then
                  mt = i
      mxx(2) = mt
                elseif ( pltvar(i)(:1) == 'p' ) then
                  mp = i
      mxx(1) = mp
                endif
              elseif ( index(pltvar(i),'vel') /= 0 ) then
                mdv = i
      mxx(5) = mdv
              elseif ( index(pltvar(i),'mach') /= 0 ) then
                mmach = i
      mxx(7) = mmach
              endif
            enddo
            write (ioout,99006)
            fmt(4) = '13'
            fmt(5) = ' '
            fmt(7) = '4,'
            do i = 1,npt
              if ( siunit ) then
                v(i) = pub(i)
                unit = 'BAR'
              else
                v(i) = pub(i)/1.01325d0
                unit = 'ATM'
              endif
              if ( mp > 0 ) pltout(i+iplt,mp) = v(i)
            enddo
            write (ioout,fmt) 'P1, '//unit//'        ',(v(j),j=1,npt)
            fmt(7) = '2,'
            write (ioout,fmt) ft1,(tub(j),j=1,npt)
            if ( .not.siunit ) write (ioout,fmt) fh1,(h1(j),j=1,npt)
            if ( siunit ) write (ioout,fmt) fhs1,(h1(j),j=1,npt)
            do i = 1,npt
              v(i) = wmix
              sonvel(i) = (rr*gm1(i)*tub(i)/wmix)**.5
            enddo
            fmt(7) = '3,'
            write (ioout,fmt) fm1,(v(j),j=1,npt)
            fmt(7) = '4,'
            write (ioout,fmt) fg1,(gm1(j),j=1,npt)
            fmt(7) = '1,'
            write (ioout,fmt) 'SON VEL1,M/SEC ',(sonvel(j),j=1,npt)
            if ( nplt > 0 ) then
              do i = 1,npt
                if ( mt > 0 ) pltout(i+iplt,mt) = tub(i)
                if ( mgam > 0 ) pltout(i+iplt,mgam) = gm1(i)
                if ( mh > 0 ) pltout(i+iplt,mh) = h1(i)
                if ( mson > 0 ) pltout(i+iplt,mson) = sonvel(i)
              enddo
            endif
            write (ioout,99007)
            fmt(4) = fmt(6)
            call out2(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
            call out4(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
            write (ioout,99008)
            fmt(7) = '3,'
            do i = 1,npt
              v(i) = ppp(i)/pub(i)
              pcp(i) = ttt(i)/tub(i)
              sonvel(i) = sonvel(i)*rrho(i)
              if ( mmach > 0 ) pltout(i+iplt,mmach) = vmoc(i)
              if ( mdv > 0 ) pltout(i+iplt,mdv) = sonvel(i)
            enddo
            write (ioout,fmt) fpp1,(v(j),j=1,npt)
            write (ioout,fmt) ftt1,(pcp(j),j=1,npt)
            do i = 1,npt
              v(i) = wm(i)/wmix
            enddo
            fmt(7) = '4,'
            write (ioout,fmt) fmm1,(v(j),j=1,npt)
            write (ioout,fmt) frr1,(rrho(j),j=1,npt)
            write (ioout,fmt) 'DET MACH NUMBER',(vmoc(j),j=1,npt)
            fmt(7) = '1,'
            write (ioout,fmt) fdv,(sonvel(j),j=1,npt)
            eql = .true.
            call out3(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
            iplt = min(iplt+npt,500)
            if ( isv == 0.and.iof == nof ) goto 200
            if ( np == 1.and.nt == 1 ) goto 100
            write (ioout,99009)
            npt = 0
 120        npt = npt + 1
            if ( isv == 1 ) isv = -1
            call seten(isv,ttt,ensave,enn,enlsav,ennl,lsave,ng,sln,enln,en,npt,npr,ngp1,ngc,jliq,jsol,tt,jcond,tp,sumn)
          endif
        enddo
      enddo
      iplt = min(iplt+npt-1,500)
      if ( iof < nof ) goto 100
 200  tp = .false.
      return
99001 format (/' T EST.=',f8.2/11x,'P/P1',17x,'T/T1')
99002 format (i5,2e20.8)
99003 format (/' ITER =',i2,5x,'P/P1 =',e15.8,/7x,'T/T1 =',e15.8,5x,        'RHO/RHO1 =',e15.8,/7x,'DEL LN P/P1 =',e15.8,5x,        'DEL LN T/T1 =',e15.8)
99004 format (/        ' CONSERVATION EQNS NOT SATISFIED IN 8 ITERATIONS (DETON)'        )
99005 format (//,21x,'DETONATION PROPERTIES OF AN IDEAL REACTING GAS')
99006 format (/' UNBURNED GAS'/)
99007 format (/' BURNED GAS'/)
99008 format (/' DETONATION PARAMETERS'/)
99009 format (///)
      end subroutine deton
      subroutine efmt(fone,aa,vx,npt)
      use params_cea_inc, only : ioout, maxmat, ncol
      implicit none
      integer, intent(In) :: npt
      character(len=15), intent(In) :: aa
      character(len=4), intent(In) :: fone
      real(kind=8), dimension(1:maxmat), intent(In) :: vx
      character(len=4), dimension(1:5) :: fmix
      character(len=4), dimension(1:8) :: frmt
      integer :: i
      integer :: j
      integer :: j1
      integer, dimension(1:ncol) :: ne
      integer :: iabs
      real(kind=8) :: ee
      real(kind=8) :: fe
      real(kind=8), dimension(1:ncol) :: w
      real(kind=8) :: dabs
      real(kind=8) :: dlog10
      save ee,fe,i,j,j1,ne,w
      data frmt / '(1H ',',A15',',','9X,','13(F','6.4,','I2,','1X))' / 
      data fmix / 'I3,','6.4,','I2,','9X,','5.3,' / 
      frmt(6) = fmix(2)
      frmt(7) = fmix(3)
      j1 = 1
      frmt(4) = '1x,'
      if ( fone == '9X,' ) then
        j1 = 2
        frmt(4) = fmix(4)
      endif
      do i = j1,npt
        if ( vx(i) /= 0. ) then
          ee = dlog10(dabs(vx(i)))
          ne(i) = ee
          fe = ne(i)
          if ( ee < -.2181e-05.and.fe /= ee ) ne(i) = ne(i) - 1
          if ( iabs(ne(i)) >= 10 ) then
            frmt(6) = fmix(5)
            frmt(7) = fmix(1)
          endif
          w(i) = vx(i)/10.**ne(i)
        else
          w(i) = 0.
          ne(i) = 0.
        endif
      enddo
      write (ioout,frmt) aa,(w(j),ne(j),j=j1,npt)
      end subroutine efmt
      subroutine eqlbrm(nlm,size,trace,ngc,pderiv,convg,tp,tt,npr,t,jcond,ng,ifz,temp,en,npt,prod,short,nc,enln,deln,tln,vol,pp,enn,rr,vv,tm,lsave,a,ions,shock,elmt,debug,cpsum,cp,iq1,imat,g,msing,x,h0,mu,ennl,s,totn,sumn,hp,b0,bcheck,dlvtp,cpr,dlvpt,jliq,gammas,jsol,hsum,ssum,sp,s0,tg,ngp1,mw,jx,jcm,b0p,nspx,atwt,ttt,ppp,vlm,wm,gonly,coef,cft,hsub0)
      use params_cea_inc, only : maxt, ioout, maxng, maxmat, ncol, maxngc, maxel, maxnc
      implicit none
      integer, intent(InOut) :: nlm
      real(kind=8), intent(In) :: size
      real(kind=8), intent(In) :: trace
      integer, intent(In) :: ngc
      logical, intent(InOut) :: pderiv
      logical, intent(InOut) :: convg
      logical, intent(In) :: tp
      real(kind=8), intent(InOut) :: tt
      integer, intent(InOut) :: npr
      real(kind=8), dimension(1:maxt), intent(In) :: t
      integer, dimension(1:45), intent(InOut) :: jcond
      integer, intent(InOut) :: ng
      integer, dimension(1:maxnc), intent(In) :: ifz
      real(kind=8), dimension(1:2,1:maxnc), intent(In) :: temp
      real(kind=8), dimension(1:maxngc,1:ncol), intent(InOut) :: en
      integer, intent(InOut) :: npt
      character(len=15), dimension(0:maxngc), intent(In) :: prod
      logical, intent(In) :: short
      integer, intent(In) :: nc
      real(kind=8), dimension(1:maxngc), intent(InOut) :: enln
      real(kind=8), dimension(1:maxngc), intent(InOut) :: deln
      real(kind=8), intent(InOut) :: tln
      logical, intent(In) :: vol
      real(kind=8), intent(InOut) :: pp
      real(kind=8), intent(InOut) :: enn
      real(kind=8), intent(In) :: rr
      real(kind=8), intent(In) :: vv
      real(kind=8), intent(InOut) :: tm
      integer, intent(InOut) :: lsave
      real(kind=8), dimension(1:maxel,1:maxngc), intent(InOut) :: a
      logical, intent(In) :: ions
      logical, intent(In) :: shock
      character(len=2), dimension(1:maxel), intent(InOut) :: elmt
      logical, dimension(1:ncol), intent(In) :: debug
      real(kind=8), intent(InOut) :: cpsum
      real(kind=8), dimension(1:maxngc), intent(In) :: cp
      integer, intent(InOut) :: iq1
      integer, intent(InOut) :: imat
      real(kind=8), dimension(1:maxmat,1:maxmat+1), intent(InOut) :: g
      integer, intent(InOut) :: msing
      real(kind=8), dimension(1:maxmat), intent(InOut) :: x
      real(kind=8), dimension(1:maxngc), intent(In) :: h0
      real(kind=8), dimension(1:maxngc), intent(InOut) :: mu
      real(kind=8), intent(InOut) :: ennl
      real(kind=8), dimension(1:maxngc), intent(In) :: s
      real(kind=8), dimension(1:ncol), intent(InOut) :: totn
      real(kind=8), intent(InOut) :: sumn
      logical, intent(In) :: hp
      real(kind=8), dimension(1:maxel), intent(InOut) :: b0
      real(kind=8), intent(In) :: bcheck
      real(kind=8), dimension(1:ncol), intent(InOut) :: dlvtp
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpr
      real(kind=8), dimension(1:ncol), intent(InOut) :: dlvpt
      integer, intent(InOut) :: jliq
      real(kind=8), dimension(1:ncol), intent(InOut) :: gammas
      integer, intent(InOut) :: jsol
      real(kind=8), dimension(1:ncol), intent(InOut) :: hsum
      real(kind=8), dimension(1:ncol), intent(InOut) :: ssum
      logical, intent(In) :: sp
      real(kind=8), intent(In) :: s0
      real(kind=8), dimension(1:4), intent(In) :: tg
      integer, intent(In) :: ngp1
      real(kind=8), dimension(1:maxngc), intent(In) :: mw
      integer, dimension(1:maxel), intent(InOut) :: jx
      integer, dimension(1:maxel), intent(InOut) :: jcm
      real(kind=8), dimension(1:maxel,1:2), intent(InOut) :: b0p
      integer, intent(In) :: nspx
      real(kind=8), dimension(1:maxel), intent(InOut) :: atwt
      real(kind=8), dimension(1:ncol), intent(Out) :: ttt
      real(kind=8), dimension(1:ncol), intent(Out) :: ppp
      real(kind=8), dimension(1:ncol), intent(InOut) :: vlm
      real(kind=8), dimension(1:ncol), intent(InOut) :: wm
      logical, intent(Out) :: gonly
      real(kind=8), dimension(1:maxng,1:9,1:3) :: coef
      real(kind=8), dimension(1:maxnc,1:9) :: cft
      real(kind=8), intent(In) :: hsub0
      real :: d0
      real :: e
      real :: d
      character(len=12) :: ae
      character(len=12), dimension(1:maxel) :: cmp
      character(len=16) :: amb
      logical :: cpcalc
      logical :: i2many
      logical :: newcom
      logical :: reduce
      integer :: i
      integer :: il
      integer :: ilamb
      integer :: ilamb1
      integer :: inc
      integer :: ipr
      integer :: iq2
      integer :: iter
      integer :: ix
      integer :: ixsing
      integer :: iz
      integer :: j
      integer :: ja
      integer :: jb
      integer :: jbx
      integer :: jc
      integer :: jcondi
      integer :: jcons
      integer :: jdelg
      integer :: jex
      integer :: jj
      integer :: jkg
      integer :: jneg
      integer :: jsw
      integer :: k
      integer :: kc
      integer :: kg
      integer :: kk
      integer :: kmat
      integer :: kneg
      integer :: l
      integer :: lc
      integer, dimension(1:maxel) :: lcs
      integer :: le
      integer :: lelim
      integer :: lk
      integer :: ll
      integer :: lncvg
      integer :: ls
      integer :: lsing
      integer :: lz
      integer :: maxitn
      integer :: ncvg
      integer :: njc
      integer :: nn
      integer :: numb
      integer :: iabs
      real(kind=8) :: aa
      real(kind=8) :: ambda
      real(kind=8) :: ambda1
      real(kind=8) :: bigen
      real(kind=8) :: bigneg
      real(kind=8) :: delg
      real(kind=8) :: dlnt
      real(kind=8) :: dpie
      real(kind=8) :: ensol
      real(kind=8) :: esize
      real(kind=8) :: gap
      real(kind=8) :: gasfrc
      real(kind=8) :: pie
      real(kind=8), dimension(1:maxmat-2) :: pisave
      real(kind=8) :: siz9
      real(kind=8) :: sizeg
      real(kind=8) :: smalno
      real(kind=8) :: smnol
      real(kind=8) :: sum
      real(kind=8) :: sum1
      real(kind=8) :: szgj
      real(kind=8) :: tem
      real(kind=8) :: tmelt
      real(kind=8) :: tsize
      real(kind=8) :: ween
      real(kind=8) :: xi
      real(kind=8) :: xln
      real(kind=8) :: xsize
      real(kind=8), dimension(1:maxmat) :: xx
      real(kind=8) :: dabs
      real(kind=8) :: dexp
      real(kind=8) :: dlog
      real(kind=8) :: dmax1
      save aa,ae,amb,ambda,ambda1,bigen,bigneg,cmp,cpcalc,delg,dlnt,  dpie,ensol,esize,gap,gasfrc,i,i2many,il,ilamb,ilamb1,inc,ipr,  iq2,iter,ix,ixsing,iz,j,ja,jb,jbx,jc,jcondi,jcons,jdelg,jex,jj,  jkg,jneg,jsw,k,kc,kg,kk,kmat,kneg,l,lc,lcs,le,lelim,lk,ll,lncvg,  ls,lsing,lz,maxitn,ncvg,newcom,njc,nn,numb,pie,pisave,reduce,  siz9,sizeg,sum,sum1,szgj,tem,tmelt,tsize,ween,xi,xln,xsize,xx
      data smalno / 1.e-6 / ,smnol / -13.815511 / 
      ixsing = 0
      lsing = 0
      jsw = 0
      jdelg = 0
      maxitn = 50
      ncvg = 0
      lncvg = 3*nlm
      reduce = .false.
      siz9 = size - 9.2103404d0
      tsize = size
      xsize = size + 6.90775528d0
      if ( trace /= 0. ) then
        maxitn = maxitn + ngc/2
        xsize = -dlog(trace)
        if ( xsize < size ) xsize = size + .1
      endif
      if ( xsize > 80. ) xsize = 80.d0
      esize = min(80.d0,xsize+6.90775528d0)
      jcons = 0
      pie = 0.
      i2many = .false.
      pderiv = .false.
      convg = .false.
      numb = 0
      cpcalc = .true.
      if ( tp ) cpcalc = .false.
      if ( tt /= 0.d0 ) then
        if ( npr == 0.or.(tt /= t(1).and..not.tp) ) goto 400
        k = 1
      else
        tt = 3800.d0
        if ( npr == 0 ) goto 400
        k = 1
      endif
 100  j = jcond(k)
      jc = j - ng
      kg = -ifz(jc)
      do i = 1,9
        kg = kg + 1
        kc = jc + kg
        if ( tt <= temp(2,kc) ) then
          if ( kg /= 0 ) then
            jcond(k) = j + kg
            en(j+kg,npt) = en(j,npt)
            en(j,npt) = 0.
            if ( prod(j) /= prod(j+kg).and..not.short )            write (ioout,99023) prod(j),prod(j+kg)
          endif
          goto 300
        elseif ( kc >= nc.or.ifz(kc+1) <= ifz(kc) ) then
          goto 200
        endif
      enddo
 200  if ( .not.tp ) then
        tt = temp(2,kc) - 10.d0
        k = 1
        goto 100
      endif
      write (ioout,99028) prod(j)
      en(j,npt) = 0.d0
      enln(j) = 0.d0
      deln(j) = 0.d0
      do i = k,npr
        jcond(i) = jcond(i+1)
      enddo
      npr = npr - 1
 300  k = k + 1
      if ( k <= npr ) goto 100
 400  tln = dlog(tt)
      if ( vol ) pp = rr*enn*tt/vv
      call cphs(tg,tt,tln,ng,h0,s,coef,convg,tp,cp,ngc,npr,jcond,cft,nc)
      tm = dlog(pp/enn)
      le = nlm
      if ( lsave /= 0.and.nlm /= lsave ) then
        tem = exp(-tsize)
        do i = lsave + 1,nlm
          do j = 1,ng
            if ( a(i,j) /= 0. ) then
              en(j,npt) = tem
              enln(j) = -tsize
            endif
          enddo
        enddo
      endif
      ls = nlm
      lelim = 0
      lz = ls
      if ( ions ) lz = ls - 1
      if ( npt == 1.and..not.shock.and..not.short ) write (ioout,99001)     (elmt(i),i=1,nlm)
      if ( debug(npt) ) then
        do i = 1,nlm
          cmp(i) = elmt(i)
        enddo
      endif
 500  if ( cpcalc ) then
        cpsum = 0.d0
        do j = 1,ng
          cpsum = cpsum + en(j,npt)*cp(j)
        enddo
        if ( npr /= 0 ) then
          do k = 1,npr
            j = jcond(k)
            cpsum = cpsum + en(j,npt)*cp(j)
          enddo
          cpcalc = .false.
        endif
      endif
      numb = numb + 1
      call matrix(nlm,npr,iq1,convg,tp,imat,g,hsum,npt,ng,mu,enln,h0,s,tm,en,a,sp,hp,jcond,enn,sumn,b0,s0,hsub0,tt,cpsum,pderiv,vol)
      iq2 = iq1 + 1
      if ( convg ) imat = imat - 1
      if ( debug(npt) ) then
        if ( .not.convg ) then
          write (ioout,99004) numb
        else
          if ( .not.pderiv ) write (ioout,99002)
          if ( pderiv ) write (ioout,99003)
        endif
        kmat = imat + 1
        do i = 1,imat
          write (ioout,99006) (g(i,k),k=1,kmat)
        enddo
      endif
      msing = 0
      call gauss(imat,g,msing,x)
      if ( msing == 0 ) then
        if ( debug(npt) ) then
          write (ioout,99005) (cmp(k),k=1,le)
          write (ioout,99006) (x(i),i=1,imat)
        endif
        if ( .not.convg ) then
          if ( vol ) x(iq2) = x(iq1)
          if ( tp ) x(iq2) = 0.
          dlnt = x(iq2)
          sum = x(iq1)
          if ( vol ) then
            x(iq1) = 0.
            sum = -dlnt
          endif
          do j = 1,ng
            if ( lelim /= 0 ) then
              deln(j) = 0.
              do i = lelim,ls
                if ( a(i,j) /= 0. ) goto 520
              enddo
            endif
            deln(j) = -mu(j) + h0(j)*dlnt + sum
            do k = 1,nlm
              deln(j) = deln(j) + a(k,j)*x(k)
            enddo
            if ( pie /= 0. ) deln(j) = deln(j) + a(ls,j)*pie
 520      continue
      end do
          if ( npr /= 0 ) then
            do k = 1,npr
              j = jcond(k)
              kk = nlm + k
              deln(j) = x(kk)
            enddo
          endif
          ambda = 1.d0
          ambda1 = 1.d0
          ilamb = 0
          ilamb1 = 0
          sum = dmax1(dabs(x(iq1)),dabs(dlnt))
          sum = sum*5.
          do j = 1,ng
            if ( deln(j) > 0. ) then
              if ( (enln(j)-ennl+size) <= 0. ) then
                sum1 = dabs(deln(j)-x(iq1))
                if ( sum1 >= siz9 ) then
                  sum1 = dabs(-9.2103404d0-enln(j)+ennl)/sum1
                  if ( sum1 < ambda1 ) then
                    ambda1 = sum1
                    ilamb1 = j
                  endif
                endif
              elseif ( deln(j) > sum ) then
                sum = deln(j)
                ilamb = j
              endif
            endif
          enddo
          if ( sum > 2.d0 ) ambda = 2.d0/sum
          if ( ambda1 <= ambda ) then
            ambda = ambda1
            ilamb = ilamb1
          endif
          if ( debug(npt) ) then
            write (ioout,99011) tt,enn,ennl,pp,tm,ambda
            if ( ambda /= 1.d0 ) then
              amb = 'ENN'
              if ( dabs(x(iq2)) > dabs(x(iq1)) ) amb = 'TEMP'
              if ( ilamb /= 0 ) amb = prod(ilamb)
              write (ioout,99012) amb
            endif
            if ( vol ) write (ioout,99013) vv*.001d0
            write (ioout,99014)
            do j = 1,ngc
              write (ioout,99015) prod(j),en(j,npt),enln(j),deln(j),                       h0(j),s(j),h0(j) - s(j),mu(j)
            enddo
          endif
          totn(npt) = 0.d0
          do j = 1,ng
            enln(j) = enln(j) + ambda*deln(j)
          enddo
          do j = 1,ng
            en(j,npt) = 0.
            if ( lelim /= 0 ) then
              do i = lelim,ls
                if ( a(i,j) /= 0. ) goto 540
              enddo
            endif
            if ( (enln(j)-ennl+tsize) > 0. ) then
              en(j,npt) = dexp(enln(j))
              totn(npt) = totn(npt) + en(j,npt)
            endif
 540      continue
      end do
          if ( ions.and.elmt(nlm) == 'E' ) then
            do j = 1,ng
              if ( a(ls,j) /= 0..and.en(j,npt) == 0. ) then
                if ( (enln(j)-ennl+esize) > 0. ) then
                  en(j,npt) = dexp(enln(j))
                  totn(npt) = totn(npt) + en(j,npt)
                endif
              endif
            enddo
          endif
          sumn = totn(npt)
          if ( npr /= 0 ) then
            do k = 1,npr
              j = jcond(k)
              en(j,npt) = en(j,npt) + ambda*deln(j)
              totn(npt) = totn(npt) + en(j,npt)
            enddo
          endif
          if ( .not.tp ) then
            tln = tln + ambda*dlnt
            tt = dexp(tln)
            cpcalc = .true.
            call cphs(tg,tt,tln,ng,h0,s,coef,convg,tp,cp,ngc,npr,jcond,cft,nc)
          endif
          if ( vol ) then
            enn = sumn
            ennl = dlog(enn)
            if ( vol ) pp = rr*tt*enn/vv
          else
            ennl = ennl + ambda*x(iq1)
            enn = dexp(ennl)
          endif
          tm = dlog(pp/enn)
          if ( elmt(nlm) == 'E' ) then
            do j = 1,ngc
              if ( a(nlm,j) /= 0. ) then
                if ( en(j,npt) > 0. ) goto 560
              endif
            enddo
            pie = x(nlm)
            lelim = nlm
            nlm = nlm - 1
            goto 500
          endif
 560      if ( numb > maxitn ) then
            write (ioout,99019) maxitn,npt
            if ( nc == 0.or.i2many ) goto 1500
            i2many = .true.
            if ( .not.hp.or.npt /= 1.or.tt > 100. ) then
              if ( npr /= 1.or.enn > 1.e-4 ) goto 1500
              write (ioout,99020)
              enn = .1
              ennl = -2.3025851
              sumn = enn
              xi = ng
              xi = enn/xi
              xln = dlog(xi)
              do j = 1,ng
                en(j,npt) = xi
                enln(j) = xln
              enddo
              j = jcond(1)
              k = 1
              goto 1000
            else
              write (ioout,99008)
              goto 1500
            endif
          else
            sum = (x(iq1)*enn/totn(npt))
            if ( dabs(sum) > 0.5e-5 ) goto 500
            do j = 1,ng
              if ( dabs(deln(j))*en(j,npt)/totn(npt) > 0.5d-5 )             goto 500
            enddo
            if ( dabs(dlnt) > 1.d-04 ) goto 500
            if ( npr /= 0 ) then
              do k = 1,npr
                j = jcond(k)
                if ( dabs(deln(j)/totn(npt)) > 0.5d-5 ) goto 500
                if ( en(j,npt) < 0. ) goto 700
              enddo
            endif
            le = nlm
            do i = 1,nlm
              if ( dabs(b0(i)) >= 1.d-06 ) then
                sum = 0.
                do j = 1,ngc
                  sum = sum + en(j,npt)*a(i,j)
                enddo
                if ( dabs(b0(i)-sum) > bcheck ) goto 500
              endif
            enddo
            if ( trace /= 0. ) then
              tsize = xsize
              tem = 1.
              if ( numb /= 1 ) then
                lk = lz
                if ( nlm < lz ) lk = nlm
                do i = 1,lk
                  if ( i /= lsing ) then
                    tem = 0.
                    if ( x(i) /= 0. ) then
                      tem = dabs((pisave(i)-x(i))/x(i))
                      if ( tem > .001 ) goto 565
                    endif
                  endif
                enddo
              endif
 565          do i = 1,nlm
                pisave(i) = x(i)
              enddo
              if ( tem > .001 ) goto 500
              if ( ions ) then
                iter = 1
                if ( pie /= 0. ) then
                  le = nlm + 1
                  x(le) = pie
                endif
 566            sum1 = 0.
                sum = 0.
                pie = x(le)
                do j = 1,ng
                  if ( a(ls,j) /= 0. ) then
                    en(j,npt) = 0.
                    tem = 0.
                    if ( enln(j) > -87. ) tem = dexp(enln(j))
                    if ( (enln(j)-ennl+tsize) > 0..and.elmt(nlm)                    == 'E' ) then
                      pie = 0.
                      en(j,npt) = tem
                    endif
                    aa = a(ls,j)*tem
                    sum = sum + aa
                    sum1 = sum1 + aa*a(ls,j)
                  endif
                enddo
                if ( sum1 /= 0. ) then
                  dpie = -sum/sum1
                  do j = 1,ng
                    if ( a(ls,j) /= 0. ) enln(j) = enln(j) + a(ls,j)                   *dpie
                  enddo
                  if ( debug(npt) ) write (ioout,99016) iter,dpie
                  if ( dabs(dpie) > .0001 ) then
                    x(le) = x(le) + dpie
                    iter = iter + 1
                    if ( iter <= 80 ) goto 566
                    write (ioout,99017)
                    goto 1500
                  elseif ( elmt(nlm) == 'E'.and.pie /= 0. ) then
                    nlm = nlm - 1
                    newcom = .true.
                  endif
                endif
              endif
            endif
          endif
        elseif ( .not.pderiv ) then
          dlvtp(npt) = 1. - x(iq1)
          cpr(npt) = g(iq2,iq2)
          do j = 1,iq1
            cpr(npt) = cpr(npt) - g(iq2,j)*x(j)
          enddo
          pderiv = .true.
          goto 500
        else
          dlvpt(npt) = -1. + x(iq1)
          if ( jliq == 0 ) then
            gammas(npt) = -1./(dlvpt(npt)+(dlvtp(npt)**2)*enn/cpr(npt))
          else
            en(jsol,npt) = ensol
            hsum(npt) = hsum(npt) + en(jliq,npt)*(h0(jliq)-h0(jsol))
            gammas(npt) = -1./dlvpt(npt)
            npr = npr + 1
            jcond(npr) = jliq
          endif
          goto 1400
        endif
      else
        if ( convg ) then
          write (ioout,99007)
          dlvpt(npt) = -1.
          dlvtp(npt) = 1.
          cpr(npt) = cpsum
          gammas(npt) = -1./(dlvpt(npt)+(dlvtp(npt)**2)*enn/cpr(npt))
          goto 1400
        else
          write (ioout,99009) numb,msing
          lsing = msing
          ixsing = ixsing + 1
          if ( ixsing <= 8 ) then
            xsize = 80.
            tsize = xsize
            if ( msing > nlm.and.numb < 1.and.npr > 1.and.           jdelg > 0 ) then
              ween = 1000.
              j = 0
              do i = 1,npr
                jcondi = jcond(i)
                if ( jcondi /= jdelg ) then
                  do ll = 1,nlm
                    if ( a(ll,jdelg) /= 0.and.a(ll,jcondi) /= 0. ) then
                      if ( en(jcondi,npt) <= ween ) then
                        ween = en(jcondi,npt)
                        j = jcondi
                        k = i
                      endif
                      goto 570
                    endif
                  enddo
                endif
 570          continue
      end do
              if ( j > 0 ) then
                write (ioout,99020)
                goto 1000
              endif
            elseif ( .not.hp.or.npt /= 1.or.nc == 0.or.tt > 100. ) then
              if ( ixsing >= 3 ) then
                if ( msing < iq1 ) then
                  if ( reduce.and.msing <= nlm ) then
                    if ( nlm < lelim ) goto 1500
                    write (ioout,99010) npt,elmt(nlm)
                    nlm = nlm - 1
                    goto 500
                  elseif ( msing <= nlm ) then
                    if ( .not.ions ) goto 1100
                    if ( elmt(nlm) /= 'E' ) goto 1100
                    do j = 1,ng
                      if ( a(nlm,j) /= 0. ) en(j,npt) = 0.d0
                    enddo
                    pie = x(nlm)
                    nlm = nlm - 1
                    if ( msing > nlm ) goto 500
                    goto 1100
                  else
                    k = msing - nlm
                    j = jcond(k)
                    if ( j /= jcons ) then
                      jcons = j
                      goto 1000
                    endif
                  endif
                endif
              endif
              do jj = 1,ng
                if ( ions ) then
                  if ( elmt(nlm) /= 'E' ) then
                    if ( a(ls,jj) /= 0. ) goto 575
                  endif
                endif
                if ( en(jj,npt) == 0. ) then
                  en(jj,npt) = smalno
                  enln(jj) = smnol
                endif
 575          continue
      end do
              goto 500
            else
              write (ioout,99008)
            endif
          endif
        endif
        goto 1500
      endif
 600  ssum(npt) = 0.
      do j = 1,ng
        ssum(npt) = ssum(npt) + en(j,npt)*(s(j)-enln(j)-tm)
      enddo
      if ( npr > 0 ) then
        do k = 1,npr
          j = jcond(k)
          ssum(npt) = ssum(npt) + en(j,npt)*s(j)
        enddo
      endif
      if ( .not.sp ) then
        convg = .true.
      else
        tem = ssum(npt) - s0
        if ( dabs(tem) > .0005 ) goto 500
        if ( debug(npt) ) write (ioout,99018) tem
        convg = .true.
      endif
 700  ncvg = ncvg + 1
      if ( ncvg > lncvg ) then
        write (ioout,99034) lncvg
        goto 1500
      else
        if ( .not.shock ) then
          do il = 1,le
            xx(il) = x(il)
          enddo
          if ( .not.short ) then
            if ( newcom ) write (ioout,99021) (cmp(k),k=1,le)
            write (ioout,99022) npt,numb,tt,(xx(il),il=1,le)
          endif
          if ( .not.tp.and.npr == 0.and.tt <= tg(1)*.2d0 ) then
            write (ioout,99008)
            goto 1500
          endif
          newcom = .false.
        endif
        if ( npr /= 0 ) then
          bigneg = 0.
          jneg = 0
          do k = 1,npr
            j = jcond(k)
            if ( en(j,npt)*cp(j) <= bigneg ) then
              bigneg = en(j,npt)*cp(j)
              jneg = j
              kneg = k
            endif
          enddo
          if ( jneg /= 0 ) then
            j = jneg
            k = kneg
            if ( j == jsol.or.j == jliq ) then
              jsol = 0
              jliq = 0
            endif
            goto 1000
          endif
        endif
        if ( ngc /= ng.or.tp ) then
          ng = ngc
          call cphs(tg,tt,tln,ng,h0,s,coef,convg,tp,cp,ngc,npr,jcond,cft,nc)
          ng = ngp1 - 1
          cpcalc = .true.
          if ( ngc == ng ) goto 750
          call allcon(tg,tt,tln,ng,h0,s,coef,convg,tp,cp,ngc,npr,jcond,cft,nc)
          if ( npr /= 0.and..not.tp ) then
            gap = 50.
            do ipr = 1,npr
              j = jcond(ipr)
              if ( j /= jsol.and.j /= jliq ) then
                inc = j - ng
                kg = -ifz(inc)
                do iz = 1,20
                  kg = kg + 1
                  kc = inc + kg
                  if ( tt <= temp(2,kc) ) then
                    if ( kg /= 0 ) then
                      jkg = j + kg
                      if ( iabs(kg) > 1.or.prod(j) == prod(jkg) )                     goto 740
                      if ( jkg == jsw ) goto 720
                      if ( tt < temp(1,inc)-gap.or.tt > temp(2,inc)                     +gap ) goto 740
                      goto 720
                    endif
                    goto 710
                  elseif ( ifz(kc+1) <= ifz(kc) ) then
                    goto 710
                  endif
                enddo
                if ( tt > temp(2,kc)*1.2d0 ) goto 1000
              endif
 710        continue
      end do
          endif
          sizeg = 0.
          szgj = 0.
          do inc = 1,nc
            j = inc + ng
            if ( debug(npt) ) write (ioout,99024) prod(j),temp(1,inc),                               temp(2,inc),en(j,npt)
            if ( en(j,npt) <= 0. ) then
              if ( tt > temp(1,inc).or.temp(1,inc) == tg(1) ) then
                if ( tt <= temp(2,inc) ) then
                  sum = 0.
                  do i = 1,nlm
                    sum = sum + a(i,j)*x(i)
                  enddo
                  delg = (h0(j)-s(j)-sum)/mw(j)
                  if ( delg < sizeg.and.delg < 0. ) then
                    if ( j /= jcons ) then
                      sizeg = delg
                      jdelg = j
                    else
                      szgj = delg
                    endif
                    ipr = ipr - 1
                  endif
                  if ( debug(npt) ) write (ioout,99025) delg,sizeg
                endif
              endif
            endif
          enddo
          if ( sizeg == 0..and.szgj == 0. ) goto 750
          if ( sizeg /= 0. ) then
            j = jdelg
            goto 800
          else
            write (ioout,99026) prod(jcons)
            goto 1500
          endif
 720      kk = max(0,kg)
          tmelt = temp(kk+1,inc)
          tt = tmelt
          tln = dlog(tt)
          jsol = min(j,jkg)
          jliq = jsol + 1
          en(jkg,npt) = .5d0*en(j,npt)
          en(j,npt) = en(jkg,npt)
          j = jkg
          goto 800
 740      en(jkg,npt) = en(j,npt)
          jcond(ipr) = jkg
          en(j,npt) = 0.
          jsw = j
          if ( prod(j) /= prod(jkg).and..not.short ) write (ioout,99023)         prod(j),prod(jkg)
          j = jkg
          goto 900
        endif
 750    sumn = enn
        if ( jsol /= 0 ) then
          ensol = en(jsol,npt)
          en(jsol,npt) = en(jsol,npt) + en(jliq,npt)
          dlvtp(npt) = 0.
          cpr(npt) = 0.
          gammas(npt) = 0.
          pderiv = .true.
          do k = 1,npr
            if ( jcond(k) == jliq ) goto 760
          enddo
 760      do i = k,npr
            jcond(i) = jcond(i+1)
          enddo
          npr = npr - 1
        endif
        goto 500
      endif
 800  npr = npr + 1
      i = npr
      do ix = 2,npr
        jcond(i) = jcond(i-1)
        i = i - 1
      enddo
      jcond(1) = j
      if ( .not.short ) write (ioout,99027) prod(j)
 900  inc = j - ng
      convg = .false.
      if ( tp ) cpcalc = .false.
      numb = -1
      goto 500
 1000 en(j,npt) = 0.d0
      deln(j) = 0.d0
      enln(j) = 0.d0
      do i = k,npr
        jcond(i) = jcond(i+1)
      enddo
      if ( .not.short ) write (ioout,99028) prod(j)
      npr = npr - 1
      do i = 1,nlm
        if ( cmp(i) == prod(j) ) then
          numb = -1
          convg = .false.
          if ( tp ) cpcalc = .false.
          goto 1100
        endif
      enddo
      goto 900
 1100 newcom = .false.
      nn = nlm
      if ( elmt(nlm) == 'E' ) nn = nlm - 1
      njc = 0
      do lc = 1,nn
        lcs(lc) = 0
      enddo
 1200 bigen = -1.d-35
      do j = 1,ng
        if ( en(j,npt) > bigen ) then
          if ( .not.ions.or.a(ls,j) == 0. ) then
            bigen = en(j,npt)
            jbx = j
          endif
        endif
      enddo
      if ( bigen > 0. ) then
        do lc = 1,nn
          if ( jbx == 0 ) jbx = jx(lc)
          if ( a(lc,jbx) > smalno ) then
            if ( njc /= 0 ) then
              do i = 1,njc
                l = lcs(i)
                if ( l == lc ) goto 1250
                if ( l == 0 ) goto 1210
                j = jcm(l)
                do l = 1,nn
                  if ( a(l,jbx) /= a(l,j) ) goto 1205
                enddo
                goto 1250
 1205         continue
      end do
            endif
 1210       do i = 1,nn
              if ( i /= lc ) then
                jex = jx(i)
                if ( dabs(a(lc,jbx)*a(i,jex)-a(lc,jex)*a(i,jbx))                <= smalno ) goto 1250
              endif
            enddo
            njc = njc + 1
            if ( jbx /= jcm(lc) ) newcom = .true.
            jcm(lc) = jbx
            lcs(njc) = lc
            goto 1300
          endif
 1250   continue
      end do
 1300   en(jbx,npt) = -en(jbx,npt)
        if ( njc < nn ) goto 1200
      endif
      do j = 1,ng
        en(j,npt) = dabs(en(j,npt))
      enddo
      if ( newcom ) then
        do lc = 1,nn
          jb = jcm(lc)
          if ( a(lc,jb) == 0. ) then
            jb = jx(lc)
            jcm(lc) = jb
          endif
          tem = a(lc,jb)
          if ( tem /= 0. ) then
            pisave(lc) = h0(jb) - s(jb)
            if ( jb <= ng ) pisave(lc) = pisave(lc) + enln(jb) + tm
            cmp(lc) = prod(jb)
            if ( tem /= 1. ) then
              b0(lc) = b0(lc)/tem
              b0p(lc,1) = b0p(lc,1)/tem
              b0p(lc,2) = b0p(lc,2)/tem
              do j = 1,nspx
                a(lc,j) = a(lc,j)/tem
              enddo
            endif
            do i = 1,nn
              if ( a(i,jb) /= 0..and.i /= lc ) then
                tem = a(i,jb)
                do j = 1,nspx
                  a(i,j) = a(i,j) - a(lc,j)*tem
                  if ( dabs(a(i,j)) < 1.e-5 ) a(i,j) = 0.
                enddo
                b0(i) = b0(i) - b0(lc)*tem
                b0p(i,1) = b0p(i,1) - b0p(lc,1)*tem
                b0p(i,2) = b0p(i,2) - b0p(lc,2)*tem
              endif
            enddo
          endif
        enddo
        if ( debug(npt) ) then
          write (ioout,99029)
          write (ioout,99030) (cmp(k),k=1,nn)
        endif
      endif
      if ( msing /= 0 ) then
        reduce = .true.
        lelim = nlm
        lsing = nlm
        if ( msing /= nlm ) then
          do j = 1,nspx
            aa = a(msing,j)
            a(msing,j) = a(nlm,j)
            a(nlm,j) = aa
          enddo
          ja = jcm(msing)
          jcm(msing) = jcm(nlm)
          jcm(nlm) = ja
          ae = cmp(msing)
          cmp(msing) = cmp(nlm)
          cmp(nlm) = ae
          ae = elmt(msing)
          elmt(msing) = elmt(nlm)
          elmt(nlm) = ae
          ja = jx(msing)
          jx(msing) = jx(nlm)
          jx(nlm) = ja
          aa = atwt(msing)
          atwt(msing) = atwt(nlm)
          atwt(nlm) = aa
          aa = b0(msing)
          b0(msing) = b0(nlm)
          b0(nlm) = aa
          aa = pisave(msing)
          pisave(msing) = pisave(nlm)
          pisave(nlm) = aa
          do i = 1,2
            aa = b0p(msing,i)
            b0p(msing,i) = b0p(nlm,i)
            b0p(nlm,i) = aa
          enddo
        endif
      elseif ( .not.newcom.and.trace == 0. ) then
        goto 600
      endif
      msing = 0
      tsize = xsize
      goto 500
 1400 ttt(npt) = tt
      ppp(npt) = pp
      vlm(npt) = rr*enn*tt/pp
      hsum(npt) = hsum(npt)*tt
      wm(npt) = 1./enn
      gasfrc = enn/totn(npt)
      if ( gasfrc < .0001 ) write (ioout,99031) npt,gasfrc
      if ( trace /= 0. ) then
        do j = 1,ng
          if ( lelim /= 0 ) then
            do i = lelim,ls
              if ( a(i,j) /= 0. ) goto 1450
            enddo
          endif
          if ( enln(j) > -87. ) en(j,npt) = dexp(enln(j))
 1450   continue
      end do
      endif
      if ( debug(npt) ) write (ioout,99032) npt,pp,tt,hsum(npt),                      ssum(npt),wm(npt),cpr(npt),dlvpt(npt),                            dlvtp(npt),gammas(npt),vlm(npt)
      if ( tt >= tg(1).and.tt <= tg(4) ) goto 1600
      if ( shock ) goto 1600
      write (ioout,99033) tt,npt
      if ( tt >= tg(1)*.8d0.and.tt <= tg(4)*1.1d0 ) goto 1600
      npt = npt + 1
 1500 tt = 0.
      npt = npt - 1
      write (ioout,99035) npt
 1600 lsave = nlm
      nlm = ls
      if ( npr > 0 ) gonly = .false.
      return
99001 format (/' POINT ITN',6x,'T',10x,4(a4,8x)/(18x,5(a4,8x)))
99002 format (/' T DERIV MATRIX')
99003 format (/' P DERIV MATRIX')
99004 format (/' ITERATION',i3,6x,'MATRIX ')
99005 format (/' SOLUTION VECTOR',/,6x,5a15/8x,5a15)
99006 format (3x,5e15.6)
99007 format (/' DERIVATIVE MATRIX SINGULAR (EQLBRM)')
99008 format (/' LOW TEMPERATURE IMPLIES A CONDENSED SPECIES SHOULD HA',        'VE BEEN INSERTED,',        /' RESTART WITH insert DATASET (EQLBRM)')
99009 format (/' SINGULAR MATRIX, ITERATION',i3,'  VARIABLE',i3,        '(EQLBRM)')
99010 format (/' WARNING!! POINT',i3,        ' USES A REDUCED SET OF COMPONENTS',/       ' SPECIES CONTAINING THE ELIMINATED COMPONENT ARE OMITTED.'       ,/   ' IT MAY BE NECESSARY TO RERUN WITH INSERTED CONDENSED SPECIES'   ,/' CONTAINING COMPONENT ',a8,'(EQLBRM)')
99011 format (/' T=',e15.8,' ENN=',e15.8,' ENNL=',e15.8,' PP=',e15.8,        /' LN P/N=',e15.8,' AMBDA=',e15.8)
99012 format (/' AMBDA SET BY ',a16)
99013 format (' VOLUME=',e15.8,'CC/G')
99014 format (/24x,'Nj',12x,'LN Nj',8x,'DEL LN Nj',6x,'H0j/RT',/,41x,        'S0j/R',10x,' G0j/RT',8x,' Gj/RT')
99015 format (1x,a16,4e15.6,/35x,3e15.6)
99016 format (/' ELECTRON BALANCE ITER NO. =',i4,'  DELTA PI =',e14.7)
99017 format (/' DID NOT CONVERGE ON ELECTRON BALANCE (EQLBRM)')
99018 format (/' DELTA S/R =',e15.8)
99019 format (/,i4,' ITERATIONS DID NOT SATISFY CONVERGENCE',/,15x,        ' REQUIREMENTS FOR THE POINT',i5,' (EQLBRM)')
99020 format (/' TRY REMOVING CONDENSED SPECIES (EQLBRM)')
99021 format (/' POINT ITN',6x,'T',10x,4a12/(18x,5a12))
99022 format (i4,i5,5f12.3,/(12x,5f12.3))
99023 format (' PHASE CHANGE, REPLACE ',a16,'WITH ',a16)
99024 format (/1x,a15,2f10.3,3x,e15.7)
99025 format (' [G0j-SUM(Aij*PIi)]/Mj =',e15.7,9x,'MAX NEG DELTA G =',        e15.7)
99026 format (/' REINSERTION OF ',a16,' LIKELY TO CAUSE SINGULARITY,',        '(EQLBRM)')
99027 format (' ADD ',a16)
99028 format (' REMOVE ',a16)
99029 format (/' NEW COMPONENTS')
99030 format (/2x,6a12)
99031 format (/' WARNING!  RESULTS MAY BE WRONG FOR POINT',i3,' DUE TO',        /' LOW MOLE FRACTION OF GASES (',e15.8,') (EQLBRM)')
99032 format (/' POINT=',i3,3x,'P=',e13.6,3x,'T=',e13.6,/3x,'H/R=',        e13.6,3x,'S/R=',e13.6,/3x,'M=',e13.6,3x,'CP/R=',e13.6,3x,        'DLVPT=',e13.6,/3x,'DLVTP=',e13.6,3x,'GAMMA(S)=',e13.6,3x,        'V=',e13.6)
99033 format (' THE TEMPERATURE=',e12.4,' IS OUT OF RANGE FOR POINT',i5,        '(EQLBRM)')
99034 format (/,i3,' CONVERGENCES FAILED TO ESTABLISH SET OF CONDENSED',        ' SPECIES (EQLBRM)')
99035 format (/' CALCULATIONS STOPPED AFTER POINT',i3,'(EQLBRM)')
      end subroutine eqlbrm
      subroutine frozen(convg,tln,tt,pp,wm,npt,nfz,ng,en,deln,ssum,cpsum,cp,s,npr,jcond,hsum,ngc,h0,ttt,gammas,vlm,rr,dlvpt,dlvtp,totn,ppp,cpr,tg,ngp1,temp,coef,tp,cft,nc)
      use params_cea_inc, only : maxngc, ncol, maxng, ioout, maxnc
      implicit none
      logical, intent(InOut) :: convg
      real(kind=8), intent(InOut) :: tln
      real(kind=8), intent(InOut) :: tt
      real(kind=8), intent(In) :: pp
      real(kind=8), dimension(1:ncol), intent(InOut) :: wm
      integer, intent(InOut) :: npt
      integer, intent(In) :: nfz
      integer, intent(In) :: ng
      real(kind=8), dimension(1:maxngc,1:ncol), intent(In) :: en
      real(kind=8), dimension(1:maxngc), intent(InOut) :: deln
      real(kind=8), dimension(1:ncol), intent(InOut) :: ssum
      real(kind=8), intent(InOut) :: cpsum
      real(kind=8), dimension(1:maxngc), intent(In) :: cp
      real(kind=8), dimension(1:maxngc), intent(In) :: s
      integer, intent(In) :: npr
      integer, dimension(1:45), intent(In) :: jcond
      real(kind=8), dimension(1:ncol), intent(InOut) :: hsum
      integer, intent(In) :: ngc
      real(kind=8), dimension(1:maxngc), intent(In) :: h0
      real(kind=8), dimension(1:ncol), intent(Out) :: ttt
      real(kind=8), dimension(1:ncol), intent(Out) :: gammas
      real(kind=8), dimension(1:ncol), intent(Out) :: vlm
      real(kind=8), intent(In) :: rr
      real(kind=8), dimension(1:ncol), intent(Out) :: dlvpt
      real(kind=8), dimension(1:ncol), intent(Out) :: dlvtp
      real(kind=8), dimension(1:ncol), intent(InOut) :: totn
      real(kind=8), dimension(1:ncol), intent(Out) :: ppp
      real(kind=8), dimension(1:ncol), intent(Out) :: cpr
      real(kind=8), dimension(1:4), intent(In) :: tg
      integer, intent(In) :: ngp1
      real(kind=8), dimension(1:2,1:maxnc), intent(In) :: temp
      real(kind=8), dimension(1:maxng,1:9,1:3) :: coef
      logical :: tp
      real(kind=8), dimension(1:maxnc,1:9) :: cft
      integer :: nc
      integer :: i
      integer :: inc
      integer :: iter
      integer :: j
      integer :: k
      integer :: nnn
      real(kind=8) :: dabs
      real(kind=8) :: dexp
      real(kind=8) :: dlog
      real(kind=8) :: dlnt
      real(kind=8) :: dlpm
      save dlnt,dlpm,i,inc,iter,j,k,nnn
      convg = .false.
      tln = dlog(tt)
      dlpm = dlog(pp*wm(nfz))
      nnn = npt
      npt = nfz
      do j = 1,ng
        if ( en(j,nfz) /= 0.d0 ) deln(j) = -(dlog(en(j,nfz))+dlpm)
      enddo
      do iter = 1,8
        ssum(nnn) = 0.d0
        cpsum = 0.d0
        call cphs(tg,tt,tln,ng,h0,s,coef,convg,tp,cp,ngc,npr,jcond,cft,nc)
        do j = 1,ng
          cpsum = cpsum + en(j,nfz)*cp(j)
          ssum(nnn) = ssum(nnn) + en(j,nfz)*(s(j)+deln(j))
        enddo
        if ( npr /= 0 ) then
          do k = 1,npr
            j = jcond(k)
            cpsum = cpsum + en(j,nfz)*cp(j)
            ssum(nnn) = ssum(nnn) + en(j,nfz)*s(j)
          enddo
        endif
        if ( convg ) then
          npt = nnn
          hsum(npt) = 0.d0
          do j = 1,ngc
            hsum(npt) = hsum(npt) + en(j,nfz)*h0(j)
          enddo
          hsum(npt) = hsum(npt)*tt
          ttt(npt) = tt
          gammas(npt) = cpsum/(cpsum-1./wm(nfz))
          vlm(npt) = rr*tt/(wm(nfz)*pp)
          wm(npt) = wm(nfz)
          dlvpt(npt) = -1.
          dlvtp(npt) = 1.
          totn(npt) = totn(nfz)
          ppp(npt) = pp
          cpr(npt) = cpsum
          if ( tt >= (tg(1)*.8d0) ) then
            do i = ngp1,ngc
              if ( en(i,nfz) /= 0. ) then
                inc = i - ng
                if ( tt < (temp(1,inc)-50.).or.tt > (temp(2,inc)+50.)               ) goto 100
              endif
            enddo
            goto 200
          endif
          goto 100
        else
          dlnt = (ssum(nfz)-ssum(nnn))/cpsum
          tln = tln + dlnt
          if ( dabs(dlnt) < 0.5d-4 ) convg = .true.
          tt = dexp(tln)
        endif
      enddo
      write (ioout,99001)
 100  tt = 0.
      npt = npt - 1
 200  return
99001 format (/' FROZEN DID NOT CONVERGE IN 8 ITERATIONS (FROZEN)')
      end subroutine frozen
      subroutine gauss(imat,g,msing,x)
      use params_cea_inc, only : maxmat
      implicit none
      integer, intent(In) :: imat
      real(kind=8), dimension(1:maxmat,1:maxmat+1), intent(InOut) :: g
      integer, intent(Out) :: msing
      real(kind=8), dimension(1:maxmat), intent(InOut) :: x
      integer :: i
      integer :: imatp1
      integer :: j
      integer :: k
      integer :: nn
      integer :: nnp1
      real(kind=8) :: bigno
      real(kind=8), dimension(1:50) :: coefx
      real(kind=8) :: tmp
      real(kind=8) :: dabs
      real(kind=8) :: dmax1
      save coefx,i,imatp1,j,k,nn,nnp1,tmp
      data bigno / 1.e+25 / 
      imatp1 = imat + 1
      do nn = 1,imat
        if ( nn /= imat ) then
          nnp1 = nn + 1
          do i = nn,imat
            coefx(i) = bigno
            if ( g(i,nn) /= 0. ) then
              coefx(i) = 0.
              do j = nnp1,imatp1
                coefx(i) = dmax1(coefx(i),dabs(g(i,j)))
              enddo
              tmp = dabs(g(i,nn))
              if ( bigno*tmp > coefx(i) ) then
                coefx(i) = coefx(i)/tmp
              else
                coefx(i) = bigno
              endif
            endif
          enddo
          tmp = bigno
          i = 0
          do j = nn,imat
            if ( coefx(j) < tmp ) then
              tmp = coefx(j)
              i = j
            endif
          enddo
          if ( i == 0 ) then
            msing = nn
            goto 99999
          elseif ( nn /= i ) then
            do j = nn,imatp1
              tmp = g(i,j)
              g(i,j) = g(nn,j)
              g(nn,j) = tmp
            enddo
          endif
        elseif ( g(nn,nn) == 0 ) then
          msing = nn
          goto 99999
        endif
        k = nn + 1
        tmp = g(nn,nn)
        if ( tmp == 0. ) then
          msing = nn
          goto 99999
        else
          do j = k,imatp1
            g(nn,j) = g(nn,j)/tmp
          enddo
          if ( k /= imatp1 ) then
            do i = k,imat
              do j = k,imatp1
                g(i,j) = g(i,j) - g(i,nn)*g(nn,j)
              enddo
            enddo
          endif
        endif
      enddo
      k = imat
 100  j = k + 1
      x(k) = 0.0d0
      tmp = 0.0
      if ( imat >= j ) then
        do i = j,imat
          tmp = tmp + g(k,i)*x(i)
        enddo
      endif
      x(k) = g(k,imatp1) - tmp
      k = k - 1
      if ( k /= 0 ) goto 100
99999 end subroutine gauss
      subroutine hcalc(tt,tm,pp,wmix,ssum,npt,hpp,hsub0,cpmix,oxfl,nspr,nspx,nreac,fox,rtemp,jray,ngc,prod,rname,ng,tg,mw,nfla,ratom,rnum,coef,energy,moles,pecwt,wp,rmw,tln,en,s,h0,cp)
      use params_cea_inc, only : iothm, maxngc, ncol, ioout, maxng, maxr
      implicit none
      real(kind=8), intent(InOut) :: tt
      real(kind=8), intent(InOut) :: tm
      real(kind=8), intent(In) :: pp
      real(kind=8), intent(In) :: wmix
      real(kind=8), dimension(1:ncol), intent(InOut) :: ssum
      integer, intent(In) :: npt
      real(kind=8), dimension(1:2), intent(InOut) :: hpp
      real(kind=8), intent(InOut) :: hsub0
      real(kind=8), intent(InOut) :: cpmix
      real(kind=8), intent(In) :: oxfl
      integer, intent(InOut) :: nspr
      integer, intent(In) :: nspx
      integer, intent(In) :: nreac
      character(len=8), dimension(1:maxr), intent(In) :: fox
      real(kind=8), dimension(1:maxr), intent(In) :: rtemp
      integer, dimension(1:maxr), intent(InOut) :: jray
      integer, intent(In) :: ngc
      character(len=15), dimension(0:maxngc), intent(In) :: prod
      character(len=15), dimension(1:maxr), intent(In) :: rname
      integer, intent(In) :: ng
      real(kind=8), dimension(1:4) :: tg
      real(kind=8), dimension(1:maxngc) :: mw
      integer, dimension(1:maxr), intent(Out) :: nfla
      character(len=2), dimension(1:maxr,1:12), intent(Out) :: ratom
      real(kind=8), dimension(1:maxr,1:12), intent(Out) :: rnum
      real(kind=8), dimension(1:maxng,1:9,1:3), intent(InOut) :: coef
      character(len=15), dimension(1:maxr), intent(Out) :: energy
      logical, intent(In) :: moles
      real(kind=8), dimension(1:maxr), intent(In) :: pecwt
      real(kind=8), dimension(1:2), intent(In) :: wp
      real(kind=8), dimension(1:maxr), intent(In) :: rmw
      real(kind=8), intent(InOut) :: tln
      real(kind=8), dimension(1:maxngc,1:ncol), intent(Out) :: en
      real(kind=8), dimension(1:maxngc), intent(InOut) :: s
      real(kind=8), dimension(1:maxngc), intent(InOut) :: h0
      real(kind=8), dimension(1:maxngc), intent(InOut) :: cp
      character(len=6), dimension(1:maxngc) :: date
      character(len=2), dimension(1:5) :: el
      character(len=15) :: sub
      integer :: i
      integer :: icf
      integer :: ifaz
      integer :: itot
      integer :: j
      integer :: k
      integer :: l
      integer :: m
      integer :: n
      integer :: nall
      integer :: nint
      integer :: ntgas
      integer :: ntot
      real(kind=8), dimension(1:5) :: bb
      real(kind=8) :: enj
      real(kind=8) :: er
      real(kind=8) :: sj
      real(kind=8) :: t1
      real(kind=8) :: t2
      real(kind=8) :: tem
      real(kind=8), dimension(1:9,1:3) :: thermo
      real(kind=8) :: tsave
      real(kind=8) :: dlog
      save bb,date,el,enj,er,i,icf,ifaz,itot,j,k,l,m,n,nall,nint,ntgas,  ntot,sj,sub,t1,t2,tem,thermo,tsave
      tsave = tt
      tm = 0.
      if ( pp > 0. ) tm = dlog(pp*wmix)
      ssum(npt) = 0.
      hpp(1) = 0.
      hpp(2) = 0.
      hsub0 = 0.
      cpmix = 0.
      tem = (1.+oxfl)
      nspr = nspx
      do n = 1,nreac
        k = 2
        if ( fox(n)(:1) == 'O'.or.fox(n)(:1) == 'o' ) k = 1
        if ( tt == 0. ) tt = rtemp(n)
        j = jray(n)
        if ( j == 0 ) then
          ifaz = 0
          do j = 1,ngc
            if ( rname(n) == prod(j).or.'*'//rname(n) == prod(j) ) then
              jray(n) = j
              if ( j > ng ) then
                write (ioout,99001)
                goto 20
              endif
              goto 50
            endif
          enddo
          rewind iothm
          read (iothm) tg,ntgas,ntot,nall
          nspr = nspr + 1
          do itot = 1,nall
            if ( itot <= ntot ) then
              icf = 3
              if ( itot > ntgas ) icf = 1
              read (iothm) sub,nint,date(nspr),(el(j),bb(j),j=1,5),ifaz,                     t1,t2,mw(nspr),((thermo(l,m),l=1,9),m=1,icf)
            else
              read (iothm) sub,nint,date(nspr),(el(j),bb(j),j=1,5),ifaz,                     t1,t2,mw(nspr),er
              if ( nint /= 0 ) then
                read (iothm) ((thermo(i,j),i=1,9),j=1,nint)
                icf = nint
              endif
            endif
            if ( sub == rname(n).or.sub == '*'//rname(n) ) then
              if ( ifaz <= 0.and.nint > 0 ) then
                do j = 1,5
                  if ( bb(j) == 0. ) goto 2
                  nfla(n) = j
                  ratom(n,j) = el(j)
                  rnum(n,j) = bb(j)
                enddo
 2              jray(n) = nspr
                j = nspr
                do l = 1,icf
                  do m = 1,9
                    coef(j,m,l) = thermo(m,l)
                  enddo
                enddo
                goto 50
              else
                if ( ifaz > 0 ) write (ioout,99001)
                if ( nint == 0 ) write (ioout,99002) rname(n)
                goto 20
              endif
            endif
          enddo
          nspr = nspr - 1
          write (ioout,99003) rname(n)
          energy(n) = ' '
 20       tt = 0.
          cpmix = 0.
          goto 100
        endif
 50     if ( moles ) enj = pecwt(n)/wp(k)
        if ( .not.moles ) enj = pecwt(n)/rmw(n)
        enj = enj/tem
        if ( k == 1 ) enj = enj*oxfl
        tln = dlog(tt)
        en(j,npt) = enj
        l = 1
        if ( ifaz <= 0 ) then
          if ( tt > tg(2) ) l = 2
          if ( tt > tg(3).and.ifaz < 0 ) l = 3
        endif
        s(j) = ((((coef(j,7,l)/4.)*tt+coef(j,6,l)/3.)*tt+coef(j,5,l)/2.)         *tt+coef(j,4,l))*tt - (coef(j,1,l)*.5d0/tt+coef(j,2,l))         /tt + coef(j,3,l)*tln + coef(j,9,l)
        h0(j) = ((((coef(j,7,l)/5.)*tt+coef(j,6,l)/4.)*tt+coef(j,5,l)/3.          )*tt+coef(j,4,l)/2.)          *tt - (coef(j,1,l)/tt-coef(j,2,l)*tln-coef(j,8,l))          /tt + coef(j,3,l)
        cp(j) = (((coef(j,7,l)*tt+coef(j,6,l))*tt+coef(j,5,l))          *tt+coef(j,4,l))*tt + (coef(j,1,l)/tt+coef(j,2,l))          /tt + coef(j,3,l)
        if ( h0(j) > -.01.and.h0(j) < .01 ) h0(j) = 0.
        cpmix = cpmix + cp(j)*enj
        sj = s(j) - dlog(enj) - tm
        ssum(npt) = ssum(npt) + enj*sj
        er = h0(j)*enj*tt
        hsub0 = hsub0 + er
        hpp(k) = hpp(k) + er
      enddo
      if ( tsave /= 0. ) tt = tsave
 100  return
99001 format (/' REACTANTS MUST BE GASEOUS FOR THIS PROBLEM (HCALC)')
99002 format (/' COEFFICIENTS FOR ',a15,' ARE NOT AVAILABLE (HCALC)')
99003 format (/' ERROR IN DATA FOR ',a15,' CHECK NAME AND TEMPERATURE',        ' RANGE IN',/,' thermo.inp (HCALC)')
      end subroutine hcalc
      subroutine infree(readok,cin,ncin,lcin,dpin)
      use params_cea_inc, only : ioout, ioinp, maxngc
      implicit none
      real :: err
      character(len=15), dimension(1:maxngc), intent(Out) :: cin
      integer, intent(Out) :: ncin
      integer, dimension(1:maxngc), intent(Out) :: lcin
      logical, intent(Out) :: readok
      real(kind=8), dimension(1:maxngc) :: dpin
      character(len=1), dimension(1:132) :: ch1
      character(len=1) :: cx
      character(len=1), dimension(1:13) :: nums
      character(len=24) :: cnum
      character(len=3), dimension(1:3) :: fmtl
      character(len=2), dimension(1:24) :: numg
      character(len=4) :: w1
      integer :: i
      integer :: ich1
      integer :: j
      integer :: kcin
      integer :: nb
      integer :: nch1
      integer :: nx
      data fmtl / '(g','16','.0)' / 
      data nums / '+','-','0','1','2','3','4','5','6','7','8','9','.' / 
      data numg / '1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24' / 
      ncin = 1
      lcin(1) = 0
      kcin = 0
      dpin(1) = 0.d0
 100  nb = 1
      nx = 0
      cnum = ' '
      cin(ncin) = ' '
      ch1(1) = ' '
      nch1 = 1
      read (ioinp,99001,end=500,err=500) ch1
      do i = 132,1, - 1
        nch1 = i
        if ( ch1(i) /= ' '.and.ch1(i) /= '	' ) goto 200
      enddo
 200  do i = 1,nch1
        ich1 = i
        if ( ch1(i) /= ' '.and.ch1(i) /= '	' ) goto 300
      enddo
 300  if ( nch1 == 1.or.ch1(ich1) == '#'.or.ch1(ich1) == '!' ) then
        write (ioout,99002) (ch1(i),i=1,nch1)
        goto 100
      endif
      w1 = ch1(ich1)//ch1(ich1+1)//ch1(ich1+2)//ch1(ich1+3)
      if ( w1 == 'ther'.or.w1 == 'tran'.or.w1 == 'prob'.or.     w1 == 'reac'.or.w1 == 'outp'.or.w1 == 'omit'.or.     w1 == 'only'.or.w1 == 'inse'.or.w1(1:3) == 'end' ) then
        if ( ncin == 1 ) then
          cin(ncin) = w1
          if ( w1(1:3) == 'end'.or.w1 == 'ther'.or.w1 == 'tran' ) then
            write (ioout,99002) (ch1(i),i=1,nch1)
            return
          endif
          ich1 = ich1 + 4
          nx = 4
          lcin(1) = -4
        else
          backspace ioinp
          if ( nx == 0 ) ncin = ncin - 1
          return
        endif
      elseif ( ncin == 1 ) then
        write (ioout,99003)
        goto 500
      endif
      write (ioout,99002) (ch1(i),i=1,nch1)
      do i = ich1,nch1
        cx = ch1(i)
        if ( cx == ','.and.(lcin(ncin) > 0.or.nx == 0) ) cx = ' '
        if ( cx == '='.and.(lcin(ncin) < 0.or.nx == 0) ) cx = ' '
        if ( cx /= ' '.and.cx /= '	' ) then
          nx = nx + 1
          if ( ncin > 1 ) then
            cnum(nx:nx) = cx
            if ( nx <= 15 ) cin(ncin) = cnum
            if ( nx == 1 ) then
              do j = 1,13
                if ( ch1(i) == nums(j) ) then
                  lcin(ncin) = kcin
                  goto 310
                endif
              enddo
              lcin(ncin) = -1
              kcin = ncin
            elseif ( lcin(ncin) < 0 ) then
              lcin(ncin) = -nx
            endif
 310        nb = 1
          endif
          if ( i < nch1.or.lcin(ncin) < 0 ) goto 400
        endif
        if ( nb == 1..and.nx > 0 ) then
          if ( ncin > 0.and.lcin(ncin) > 0 ) then
            fmtl(2) = numg(min(24,nx))
            read (cnum,fmtl,err=320) dpin(ncin)
          endif
          goto 340
 320      if ( cin(ncin-1)(:4) /= 'case' ) write (ioout,99004) cin(i)
          lcin(ncin) = 0
 340      ncin = ncin + 1
          cin(ncin) = ' '
          lcin(ncin) = 0
          dpin(ncin) = 0.d0
          nx = 0
          cnum = ' '
        endif
        nb = nb + 1
 400  continue
      end do
      if ( nx > 0 ) then
        ncin = ncin + 1
        lcin(ncin) = 0
        dpin(ncin) = 0.d0
      endif
      goto 100
 500  readok = .false.
      return
99001 format (132a1)
99002 format (1x,80a1)
99003 format (/' FATAL ERROR IN INPUT FORMAT (INFREE)')
99004 format (/' WARNING!!  UNACCEPTABLE NUMBER ',a15,' (INFREE)')
      end subroutine infree
      subroutine input(readok,caseok,ensert,nonly,nomit,nsert,trace,short,massf,debug,nplt,siunit,prod,omit,newr,trnspt,pltvar,moles,nreac,pecwt,rtemp,energy,enth,rr,dens,nfla,ratom,rnum,fox,rname,jray,rmw,case,p,v,t,lsave,r,s0,tp,hp,sp,rkt,shock,detn,vol,ions,eql,froz,fac,debugf,acat,ma,nfz,nsub,nsup,npp,tcest,pcp,supar,subar,mach1,u1,gamma1,shkdbg,incdeq,incdfz,refleq,reflfz,np,nt,detdbg,nof,hsub0,size,viscns,avgdr,boltz,pi,nlm,oxf,wp,vmin,vpls,nsk,thdate,hpp,am,rh,elmt,b0p,tt,tg,tln,symbol,atmwt,atwt,x,valnce)
      use params_cea_inc, only : maxt, maxmat, maxpv, ioout, maxmix, ncol, maxngc, maxel, iothm, maxr
      implicit none
      integer, intent(InOut) :: nonly
      integer, intent(InOut) :: nomit
      integer, intent(InOut) :: nsert
      real(kind=8), intent(InOut) :: trace
      logical, intent(InOut) :: short
      logical, intent(InOut) :: massf
      logical, dimension(1:ncol), intent(Out) :: debug
      integer, intent(InOut) :: nplt
      logical, intent(InOut) :: siunit
      character(len=15), dimension(0:maxngc), intent(Out) :: prod
      character(len=15), dimension(0:maxngc), intent(InOut) :: omit
      logical, intent(Out) :: newr
      logical, intent(InOut) :: trnspt
      character(len=15), dimension(1:20), intent(Out) :: pltvar
      logical, intent(InOut) :: moles
      integer, intent(InOut) :: nreac
      real(kind=8), dimension(1:maxr), intent(Out) :: pecwt
      real(kind=8), dimension(1:maxr), intent(InOut) :: rtemp
      character(len=15), dimension(1:maxr), intent(Out) :: energy
      real(kind=8), dimension(1:maxr), intent(InOut) :: enth
      real(kind=8), intent(In) :: rr
      real(kind=8), dimension(1:maxr), intent(InOut) :: dens
      integer, dimension(1:maxr), intent(Out) :: nfla
      character(len=2), dimension(1:maxr,1:12), intent(Out) :: ratom
      real(kind=8), dimension(1:maxr,1:12), intent(Out) :: rnum
      character(len=8), dimension(1:maxr), intent(Out) :: fox
      character(len=15), dimension(1:maxr), intent(Out) :: rname
      integer, dimension(1:maxr), intent(Out) :: jray
      real(kind=8), dimension(1:maxr), intent(Out) :: rmw
      character(len=15), intent(InOut) :: case
      real(kind=8), dimension(1:maxpv), intent(InOut) :: p
      real(kind=8), dimension(1:maxpv), intent(InOut) :: v
      real(kind=8), dimension(1:maxt), intent(InOut) :: t
      integer, intent(Out) :: lsave
      real(kind=8), intent(InOut) :: r
      real(kind=8), intent(InOut) :: s0
      logical, intent(InOut) :: tp
      logical, intent(InOut) :: hp
      logical, intent(InOut) :: sp
      logical, intent(InOut) :: rkt
      logical, intent(InOut) :: shock
      logical, intent(InOut) :: detn
      logical, intent(InOut) :: vol
      logical, intent(InOut) :: ions
      logical, intent(InOut) :: eql
      logical, intent(InOut) :: froz
      logical, intent(InOut) :: fac
      logical, intent(InOut) :: debugf
      real(kind=8), intent(InOut) :: acat
      real(kind=8), intent(InOut) :: ma
      integer, intent(InOut) :: nfz
      integer, intent(InOut) :: nsub
      integer, intent(InOut) :: nsup
      integer, intent(InOut) :: npp
      real(kind=8), intent(Out) :: tcest
      real(kind=8), dimension(1:2*ncol), intent(InOut) :: pcp
      real(kind=8), dimension(1:13), intent(InOut) :: supar
      real(kind=8), dimension(1:13), intent(InOut) :: subar
      real(kind=8), dimension(1:ncol), intent(Out) :: mach1
      real(kind=8), dimension(1:ncol), intent(InOut) :: u1
      real(kind=8), intent(Out) :: gamma1
      logical, intent(InOut) :: shkdbg
      logical, intent(Out) :: incdeq
      logical, intent(Out) :: incdfz
      logical, intent(Out) :: refleq
      logical, intent(Out) :: reflfz
      integer, intent(InOut) :: np
      integer, intent(InOut) :: nt
      logical, intent(InOut) :: detdbg
      integer, intent(InOut) :: nof
      real(kind=8), intent(Out) :: hsub0
      real(kind=8), intent(Out) :: size
      real(kind=8), intent(Out) :: viscns
      real(kind=8), intent(In) :: avgdr
      real(kind=8), intent(In) :: boltz
      real(kind=8), intent(In) :: pi
      integer, intent(InOut) :: nlm
      real(kind=8), dimension(1:maxmix), intent(InOut) :: oxf
      real(kind=8), dimension(1:2), intent(InOut) :: wp
      real(kind=8), dimension(1:2), intent(InOut) :: vmin
      real(kind=8), dimension(1:2), intent(InOut) :: vpls
      integer, intent(InOut) :: nsk
      character(len=10) :: thdate
      real(kind=8), dimension(1:2), intent(InOut) :: hpp
      real(kind=8), dimension(1:2), intent(InOut) :: am
      real(kind=8), dimension(1:2), intent(InOut) :: rh
      character(len=2), dimension(1:maxel), intent(InOut) :: elmt
      real(kind=8), dimension(1:maxel,1:2), intent(InOut) :: b0p
      real(kind=8), intent(InOut) :: tt
      real(kind=8), dimension(1:4) :: tg
      real(kind=8), intent(InOut) :: tln
      character(len=2), dimension(1:100), intent(In) :: symbol
      real(kind=8), dimension(1:100), intent(In) :: atmwt
      real(kind=8), dimension(1:maxel), intent(Out) :: atwt
      real(kind=8), dimension(1:maxmat), intent(InOut) :: x
      real(kind=8), dimension(1:100), intent(In) :: valnce
      real :: d
      logical, intent(Out) :: caseok
      logical, intent(InOut) :: readok
      character(len=15), dimension(1:20), intent(Out) :: ensert
      character(len=15), dimension(1:maxngc) :: cin
      character(len=15) :: cx15
      character(len=4) :: code
      character(len=4) :: cx4
      character(len=1) :: cx1
      character(len=2) :: cx2
      character(len=3) :: cx3
      character(len=26) :: lc
      character(len=26) :: uc
      logical :: eqrats
      logical :: incd
      logical :: phi
      logical :: pltdat
      logical :: reacts
      logical :: refl
      integer :: i
      integer :: ifrmla
      integer :: ii
      integer :: in
      integer :: iv
      integer :: ix
      integer :: j
      integer :: jj
      integer :: k
      integer, dimension(1:maxngc) :: lcin
      integer :: ncin
      integer :: nmix
      integer :: index
      real(kind=8) :: denmtr
      real(kind=8), dimension(1:maxngc) :: dpin
      real(kind=8) :: eratio
      real(kind=8) :: hr
      real(kind=8), dimension(1:maxngc) :: mix
      real(kind=8) :: ur
      real(kind=8) :: xyz
      real(kind=8) :: dabs
      real(kind=8) :: dmin1
      real(kind=8) :: dsqrt
      save cin,code,cx1,cx15,cx2,cx3,cx4,denmtr,dpin,eqrats,eratio,hr,i,  ifrmla,ii,in,incd,iv,ix,j,jj,k,lcin,mix,ncin,nmix,phi,pltdat,  reacts,refl,ur,xyz
      data uc / 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' / 
      data lc / 'abcdefghijklmnopqrstuvwxyz' / 
      write (ioout,99001)
      caseok = .true.
      nonly = 0
      nomit = 0
      nsert = 0
      reacts = .false.
      trace = 0
      short = .false.
      massf = .false.
      do i = 1,ncol
        debug(i) = .false.
      enddo
      nplt = 0
      siunit = .true.
      pltdat = .false.
 100 call infree(readok,cin,ncin,lcin,dpin)
      if ( .not.readok ) goto 400
      code = cin(1)
      if ( code /= '    ' ) then
        if ( code == 'only' ) then
          nonly = min(maxngc,ncin-1)
          do i = 1,nonly
            prod(i) = cin(i+1)
          enddo
        elseif ( code == 'inse' ) then
          nsert = min(20,ncin-1)
          do i = 1,nsert
            ensert(i) = cin(i+1)
          enddo
        elseif ( code == 'omit' ) then
          nomit = min(maxngc,ncin-1)
          do i = 1,nomit
            omit(i) = cin(i+1)
          enddo
        elseif ( code == 'ther' ) then
          newr = .true.
          rewind iothm
          call utherm(readok,thdate)
          if ( .not.readok ) then
            write (ioout,99025)
            goto 400
          endif
        elseif ( code == 'tran' ) then
          call utran(readok)
          if ( .not.readok ) then
            write (ioout,99025)
            goto 400
          endif
        elseif ( code == 'outp' ) then
          do i = 2,ncin
            if ( lcin(i) < 0 ) then
              cx2 = cin(i)(1:2)
              cx3 = cin(i)(1:3)
              cx4 = cin(i)(1:4)
              if ( cx3 == 'cal' ) then
                siunit = .false.
              elseif ( cx4 == 'tran'.or.cx3 == 'trn' ) then
                trnspt = .true.
              elseif ( cx4 == 'trac' ) then
                trace = dpin(i+1)
              elseif ( cin(i)(:5) == 'short' ) then
                short = .true.
              elseif ( cin(i)(:5) == 'massf' ) then
                massf = .true.
              elseif ( cx3 == 'deb'.or.cx3 == 'dbg' ) then
                do j = i + 1,ncin
                  if ( lcin(j) /= i ) goto 120
                  k = dpin(j)
                  if ( k <= ncol ) debug(k) = .true.
                  lcin(j) = 0
                enddo
              elseif ( cx2 == 'si' ) then
                siunit = .true.
              elseif ( pltdat.and.nplt < 20 ) then
                nplt = nplt + 1
                pltvar(nplt) = cin(i)
              elseif ( cx2 == 'pl' ) then
                pltdat = .true.
              else
                write (ioout,99002) cin(i)
              endif
            endif
 120      continue
      end do
        elseif ( code == 'reac' ) then
          reacts = .true.
          moles = .false.
          nreac = 0
          do i = 1,maxr
            pecwt(i) = -1.
          enddo
          i = 1
 140      i = i + 1
          if ( i <= ncin ) then
            if ( lcin(i) /= 0 ) then
              if ( lcin(i) > 0 ) then
                write (ioout,99003) cin(i)
                goto 140
              endif
              cx15 = cin(i)
              cx1 = cx15(:1)
              cx2 = cx15(:2)
              cx3 = cx15(:3)
              cx4 = cx15(:4)
              if ( cx2 /= 'na'.and.cx2 /= 'ox'.and.cx2 /= 'fu' ) then
                if ( cx1 == 'm'.or.cx1 == 'w' ) then
                  if ( lcin(i+1) > 0 ) then
                    i = i + 1
                    pecwt(nreac) = dpin(i)
                  else
                    caseok = .false.
                    write (ioout,99004)
                  endif
                  if ( cx1 == 'm'.and.nreac == 1 ) moles = .true.
                  if ( cx1 == 'm'.and..not.moles.or.cx1 == 'w'.and.                 moles ) then
                    caseok = .false.
                    write (ioout,99005)
                  endif
                  goto 140
                endif
                if ( cx1 == 't' ) then
                  if ( lcin(i+1) > 0 ) then
                    i = i + 1
                    rtemp(nreac) = dpin(i)
                    if ( lcin(i-1) < 1 ) then
                      if ( index(cx15,'r') > 0 ) rtemp(nreac)                     = rtemp(nreac)/1.8d0
                      if ( index(cx15,'c') > 0 ) rtemp(nreac)                     = rtemp(nreac) + 273.15d0
                      if ( index(cx15,'f') > 0 ) rtemp(nreac)                     = (rtemp(nreac)-32.d0)/1.8d0 + 273.15d0
                    endif
                  else
                    write (ioout,99006)
                    caseok = .false.
                  endif
                  goto 140
                endif
                if ( cx1 == 'h'.or.cx1 == 'u' ) then
                  energy(nreac) = cx15
                  if ( lcin(i+1) > 0 ) then
                    i = i + 1
                    enth(nreac) = dpin(i)*1000.d0/rr
                    if ( index(cin(i-1),'c') > 0 ) enth(nreac)                   = enth(nreac)*4.184d0
                    if ( index(cin(i-1),'k') > 0 ) enth(nreac)                   = enth(nreac)*1000.d0
                  endif
                  goto 140
                endif
                if ( cx3 == 'rho'.or.cx3 == 'den' ) then
                  if ( lcin(i+1) > 0 ) then
                    i = i + 1
                    dens(nreac) = dpin(i)
                    if ( index(cx15,'kg') > 0 ) dens(nreac)                   = dens(nreac)/1000.d0
                  endif
                  goto 140
                endif
                if ( (lcin(i) == -1.or.lcin(i) == -2).and.index(uc,cx1)                > 0 ) then
                  energy(nreac) = ' '
                  ifrmla = ifrmla + 1
                  nfla(nreac) = ifrmla
                  if ( lcin(i) == -2 ) then
                    ix = index(lc,cx2(2:2))
                    if ( ix > 0 ) cx2(2:2) = uc(ix:ix)
                  endif
                  ratom(nreac,ifrmla) = cx2
                  if ( lcin(i+1) == i ) then
                    rnum(nreac,ifrmla) = dpin(i+1)
                  else
                    rnum(nreac,ifrmla) = 1.
                  endif
                  i = i + 1
                  goto 140
                endif
                write (ioout,99007) cin(i)
              else
                nreac = min(nreac+1,maxr)
                fox(nreac) = cx15
                i = i + 1
                if ( lcin(i) < 0 ) rname(nreac) = cin(i)
                ifrmla = 0
                nfla(nreac) = 0
                energy(nreac) = 'lib'
                enth(nreac) = 0.
                jray(nreac) = 0
                pecwt(nreac) = -1.
                rnum(nreac,1) = 0.
                rmw(nreac) = 0.
                rtemp(nreac) = 0.
              endif
            endif
            goto 140
          endif
        elseif ( code == 'prob' ) then
          case = ' '
          do i = 1,maxpv
            p(i) = 0.
            v(i) = 0.
          enddo
          do i = 1,maxt
            t(i) = 0.
          enddo
          p(1) = 1.
          trace = 0.
          lsave = 0
          r = rr/4184.d0
          s0 = 0.
          hr = 1.d30
          ur = 1.d30
          tp = .false.
          hp = .false.
          sp = .false.
          rkt = .false.
          shock = .false.
          detn = .false.
          vol = .false.
          ions = .false.
          eql = .false.
          froz = .false.
          fac = .false.
          debugf = .false.
          acat = 0.
          ma = 0.
          nfz = 1
          nsub = 0
          nsup = 0
          npp = 0
          tcest = 3800.
          do i = 1,ncol
            pcp(i) = 0.
            pcp(i+ncol) = 0.
            supar(i) = 0.
            subar(i) = 0.
            mach1(i) = 0.
            u1(i) = 0.
          enddo
          gamma1 = 0.
          phi = .false.
          eqrats = .false.
          incd = .false.
          refl = .false.
          shkdbg = .false.
          incdeq = .false.
          incdfz = .false.
          refleq = .false.
          reflfz = .false.
          np = 0
          nt = 1
          trnspt = .false.
          do i = 2,ncin
            if ( lcin(i) < 0 ) then
              do j = i + 1,ncin
                if ( lcin(j) == i ) goto 160
              enddo
              cx15 = cin(i)
              cx2 = cx15(:2)
              cx3 = cx15(:3)
              cx4 = cx15(:4)
              if ( cx4 == 'case' ) then
                case = cin(i+1)
                lcin(i+1) = 0
              elseif ( cx2 == 'tp'.or.cx2 == 'pt' ) then
                tp = .true.
              elseif ( cx2 == 'hp'.or.cx2 == 'ph' ) then
                hp = .true.
              elseif ( cx2 == 'sp'.or.cx2 == 'ps' ) then
                sp = .true.
              elseif ( cx2 == 'sv'.or.cx2 == 'vs' ) then
                sp = .true.
                vol = .true.
              elseif ( cx2 == 'uv'.or.cx2 == 'vu' ) then
                hp = .true.
                vol = .true.
              elseif ( cx2 == 'tv'.or.cx2 == 'vt' ) then
                tp = .true.
                vol = .true.
              elseif ( cx2 == 'ro'.or.cx3 == 'rkt' ) then
                rkt = .true.
              elseif ( cx3 == 'dbg'.or.cx3 == 'deb' ) then
                debugf = .true.
                shkdbg = .true.
                detdbg = .true.
              elseif ( cx3 == 'fac' ) then
                rkt = .true.
                eql = .true.
                fac = .true.
                froz = .false.
              elseif ( cx2 == 'eq' ) then
                eql = .true.
              elseif ( cx2 == 'fr'.or.cx2 == 'fz' ) then
                froz = .true.
              elseif ( cx2 == 'sh' ) then
                shock = .true.
              elseif ( cx3 == 'inc' ) then
                shock = .true.
                incd = .true.
                if ( index(cx15,'eq') > 0 ) eql = .true.
                if ( index(cx15,'fr') > 0 ) froz = .true.
                if ( index(cx15,'fz') > 0 ) froz = .true.
              elseif ( cx3 == 'ref' ) then
                shock = .true.
                refl = .true.
                if ( index(cx15,'eq') > 0 ) eql = .true.
                if ( index(cx15,'fr') > 0 ) froz = .true.
                if ( index(cx15,'fz') > 0 ) froz = .true.
              elseif ( cx3 == 'det' ) then
                detn = .true.
              elseif ( cx4 == 'ions' ) then
                ions = .true.
              else
                write (ioout,99002) cx15
              endif
              lcin(i) = 0
            endif
 160      continue
      end do
          iv = 2
          nof = 0
          goto 200
        elseif ( code(1:3) == 'end' ) then
          if ( shock ) then
            if ( incd.and.froz ) incdfz = .true.
            if ( incd.and.eql ) incdeq = .true.
            if ( refl.and.froz ) reflfz = .true.
            if ( refl.and.eql ) refleq = .true.
          endif
          hsub0 = dmin1(hr,ur)
          size = 0.
          if ( hr > .9d30 ) hr = 0.d0
          if ( ur > .9d30 ) ur = 0.d0
          if ( trnspt ) viscns = .3125*dsqrt(1.e5*boltz/(pi*avgdr))
          if ( siunit ) r = rr/1000.
          if ( detn.or.shock ) newr = .true.
          if ( .not.short ) then
            write (ioout,99008) tp,(hp.and..not.vol),sp,(tp.and.vol),                      (hp.and.vol),(sp.and.vol),detn,shock,refl,                      incd,rkt,froz,eql,ions,siunit,debugf,shkdbg,                      detdbg,trnspt
            if ( t(1) > 0. ) write (ioout,99009) (t(jj),jj=1,nt)
            write (ioout,99010) trace,s0,hr,ur
            if ( np > 0.and.vol ) write (ioout,99011)           (v(jj)*1.d-05,jj=1,np)
          endif
          if ( rkt ) then
            if ( nt == 0 ) hp = .true.
            if ( .not.short ) then
              write (ioout,99012) (p(jj),jj=1,np)
              write (ioout,99013) (pcp(jj),jj=1,npp)
              write (ioout,99014) (subar(i),i=1,nsub)
              write (ioout,99015) (supar(i),i=1,nsup)
              write (ioout,99016) nfz,ma,acat
            endif
          else
            if ( .not.vol.and..not.short ) write (ioout,99017)           (p(jj),jj=1,np)
          endif
          call react(wp,hpp,vpls,vmin,am,rh,elmt,b0p,nreac,energy,rnum,tt,rtemp,tg,rname,enth,rr,nlm,nfla,ratom,hp,tln,vol,fox,symbol,atmwt,atwt,x,valnce,pecwt,moles,dens,rmw,short)
          if ( nreac == 0.or.nlm <= 0 ) then
            write (ioout,99018)
            caseok = .false.
            write (ioout,99025)
            goto 400
          endif
          if ( nof == 0 ) then
            nof = 1
            oxf(1) = 0.
            if ( wp(2) > 0. ) then
              oxf(1) = wp(1)/wp(2)
            else
              caseok = .false.
              write (ioout,99004)
              write (ioout,99025)
              goto 400
            endif
          elseif ( phi.or.eqrats ) then
            do i = 1,nof
              eratio = oxf(i)
              if ( eqrats ) then
                xyz = -eratio*vmin(2) - vpls(2)
                denmtr = eratio*vmin(1) + vpls(1)
              else
                xyz = -vmin(2) - vpls(2)
                denmtr = eratio*(vmin(1)+vpls(1))
              endif
              if ( dabs(denmtr) < 1.d-30 ) then
                caseok = .false.
                write (ioout,99019) eratio
                write (ioout,99025)
                goto 400
              endif
              oxf(i) = xyz/denmtr
            enddo
          endif
          if ( .not.sp.and..not.tp.and..not.hp.and..not.rkt.and.         .not.detn.and..not.shock ) then
            caseok = .false.
            write (ioout,99020)
          elseif ( tp.and.t(1) <= 0. ) then
            caseok = .false.
            write (ioout,99021)
          elseif ( np <= 0 ) then
            caseok = .false.
            write (ioout,99022)
          endif
          if ( .not.(caseok.and.nlm > 0) ) write (ioout,99025)
          goto 400
        else
          write (ioout,99023)
        endif
      endif
      goto 100
 200  in = 0
      nmix = 0
      ii = iv
      do i = ii,ncin
        iv = i
        if ( lcin(i) /= 0 ) then
          if ( lcin(i) < 0 ) then
            if ( in > 0 ) goto 300
            in = i
          else
            if ( lcin(i) /= in ) goto 300
            nmix = nmix + 1
            mix(nmix) = dpin(i)
            lcin(i) = 0
          endif
        endif
      enddo
 300  if ( nmix <= 0 ) then
        if ( iv < ncin ) goto 200
        goto 100
      endif
      cx15 = cin(in)
      cx1 = cx15(:1)
      cx2 = cx15(:2)
      cx3 = cx15(:3)
      cx4 = cx15(:4)
      if ( cx1 == 't' ) then
        nt = nmix
        if ( nmix > maxmix ) then
          nt = maxmix
          write (ioout,99024) 't',nt
        endif
        do i = 1,nt
          if ( cx4 /= 'tces' ) then
            t(i) = mix(i)
            if ( lcin(in) < -1 ) then
              if ( index(cx15,'r') > 0 ) t(i) = t(i)/1.8d0
              if ( index(cx15,'c') > 0 ) t(i) = t(i) + 273.15d0
              if ( index(cx15,'f') > 0 ) t(i) = (t(i)-32.d0)             /1.8d0 + 273.15d0
            endif
          endif
        enddo
      elseif ( (cx2 == 'pc'.or.cx2 == 'pi').and.index(cx15(3:15),'p')          > 0.and.index(cx15,'psi') == 0 ) then
        npp = nmix
        if ( nmix > 2*ncol ) then
          npp = 2*ncol
          write (ioout,99024) 'pcp',npp
        endif
        do i = 1,npp
          pcp(i) = mix(i)
        enddo
      elseif ( cx1 == 'p'.and.cx3 /= 'phi' ) then
        np = nmix
        if ( nmix > maxpv ) then
          np = maxpv
          write (ioout,99024) 'p',np
        endif
        do i = 1,np
          p(i) = mix(i)
          if ( index(cx15,'psi') /= 0 ) then
            p(i) = p(i)/14.696006d0
          elseif ( index(cx15,'mmh') /= 0 ) then
            p(i) = p(i)/760.d0
          elseif ( index(cx15,'atm') == 0 ) then
            goto 350
          endif
          p(i) = p(i)*1.01325d0
 350    continue
      end do
      elseif ( cx3 == 'rho' ) then
        xyz = 1.d02
        if ( index(cx15,'kg') /= 0 ) xyz = 1.d05
        np = nmix
        if ( nmix > maxpv ) then
          np = maxpv
          write (ioout,99024) 'rho',np
        endif
        do i = 1,np
          v(i) = xyz/mix(i)
        enddo
      elseif ( cx1 == 'v' ) then
        xyz = 1.d02
        if ( index(cx15,'kg') /= 0 ) xyz = 1.d05
        np = nmix
        if ( nmix > maxpv ) then
          np = maxpv
          write (ioout,99024) 'v',np
        endif
        do i = 1,np
          v(i) = mix(i)*xyz
        enddo
      elseif ( cx3 == 'nfz'.or.cx3 == 'nfr' ) then
        nfz = mix(1)
        froz = .true.
      elseif ( cx4 == 'tces' ) then
        tcest = mix(1)
      elseif ( cx4 == 'trac' ) then
        trace = mix(1)
      elseif ( cx3 == 's/r' ) then
        s0 = mix(1)
      elseif ( cx3 == 'u/r'.or.cx2 == 'ur' ) then
        ur = mix(1)
      elseif ( cx3 == 'h/r'.or.cx2 == 'hr' ) then
        hr = mix(1)
      elseif ( cx2 == 'u1' ) then
        nsk = nmix
        if ( nmix > ncol ) then
          nsk = ncol
          write (ioout,99024) 'u1',nsk
        endif
        do i = 1,nsk
          u1(i) = mix(i)
        enddo
      elseif ( cx4 == 'mach' ) then
        nsk = nmix
        if ( nmix > ncol ) then
          nsk = ncol
          write (ioout,99024) 'mach1',nsk
        endif
        do i = 1,nsk
          mach1(i) = mix(i)
        enddo
      elseif ( cx3 == 'sub' ) then
        nsub = nmix
        if ( nmix > 13 ) then
          nsub = 13
          write (ioout,99024) 'subar',nsub
        endif
        do i = 1,nsub
          subar(i) = mix(i)
        enddo
      elseif ( cx3 == 'sup' ) then
        nsup = nmix
        if ( nmix > 13 ) then
          nsup = 13
          write (ioout,99024) 'supar',nsup
        endif
        do i = 1,nsup
          supar(i) = mix(i)
        enddo
      elseif ( cx2 == 'ac' ) then
        acat = mix(1)
      elseif ( cx4 == 'mdot'.or.cx2 == 'ma' ) then
        ma = mix(1)
      elseif ( cx4 == 'case' ) then
        case = cin(in+1)
        lcin(in+1) = 0
      elseif ( nof == 0.and.         (cx3 == 'phi'.or.cx3 == 'o/f'.or.cx3 == 'f/a'.or.         cx2 == '%f'.or.cx1 == 'r') ) then
        nof = nmix
        if ( nmix > maxmix ) then
          nof = maxmix
          write (ioout,99024) 'o/f',nof
        endif
        do k = 1,nof
          oxf(k) = mix(k)
        enddo
        if ( cx3 == 'phi' ) then
          phi = .true.
        elseif ( cx1 == 'r' ) then
          eqrats = .true.
        elseif ( cx3 == 'f/a' ) then
          do k = 1,nof
            if ( oxf(k) > 0. ) oxf(k) = 1./oxf(k)
          enddo
        elseif ( cx4 == '%fue' ) then
          do k = 1,nof
            if ( oxf(k) > 0. ) oxf(k) = (100.-oxf(k))/oxf(k)
          enddo
        endif
      else
        write (ioout,99002) cx15
      endif
      if ( iv >= ncin ) goto 100
      goto 200
 400  return
99001 format (/,/)
99002 format ('  WARNING!!  DID NOT RECOGNIZE ',a15,' (INPUT)'/)
99003 format (/' WARNING!!  LITERAL EXPECTED FOR ',a15,'(INPUT)')
99004 format (/' REACTANT AMOUNT MISSING (INPUT)')
99005 format (/' MOLES AND WEIGHT PERCENTS SHOULD NOT BE MIXED (INPUT)')
99006 format (/' REACTANT TEMPERATURE MISSING (INPUT) ')
99007 format (/' WARNING!! ',a15,' NOT RECOGNIZED (INPUT)')
99008 format (/' OPTIONS: TP=',l1,'  HP=',l1,'  SP=',l1,'  TV=',l1,        '  UV=',l1,'  SV=',l1,'  DETN=',l1,'  SHOCK=',l1,        '  REFL=',l1,'  INCD=',l1,/' RKT=',l1,'  FROZ=',l1,        '  EQL=',l1,'  IONS=',l1,'  SIUNIT=',l1,'  DEBUGF=',l1,        '  SHKDBG=',l1,'  DETDBG=',l1,'  TRNSPT=',l1)
99009 format (/' T,K =',7f11.4)
99010 format (/1p,' TRACE=',e9.2,'  S/R=',e13.6,'  H/R=',e13.6,'  U/R=',        e13.6)
99011 format (/' SPECIFIC VOLUME,M**3/KG =',1p,(4e14.7))
99012 format (/' Pc,BAR =',7f13.6)
99013 format (/' Pc/P =',9f11.4)
99014 format (/' SUBSONIC AREA RATIOS =',(5f11.4))
99015 format (/' SUPERSONIC AREA RATIOS =',(5f11.4))
99016 format (/' NFZ=',i3,1p,'  Mdot/Ac=',e13.6,'  Ac/At=',e13.6)
99017 format (/' P,BAR =',7f13.6)
99018 format (/' ERROR IN REACTANTS DATASET (INPUT)')
99019 format (/' UNABLE TO PROCESS EQUIVALENCE RATIO =',e11.4,'(INPUT)')
99020 format (/' TYPE OF PROBLEM NOT SPECIFIED (INPUT)')
99021 format (/' ASSIGNED VALUES OF TEMPERATURE ARE MISSING IN prob',        ' DATASET (INPUT)')
99022 format (/' ASSIGNED PRESSURE (OR DENSITY) MISSING IN prob',        ' DATASET (INPUT)')
99023 format (/' WARNING!!  A KEYWORD IS MISSING (INPUT)')
99024 format (/' NOTE!! MAXIMUM NUMBER OF ASSIGNED ',a5,' VALUES IS',i3,        ' (INPUT)',/)
99025 format (/' FATAL ERROR IN DATASET (INPUT)')
      end subroutine input
      subroutine matrix(nlm,npr,iq1,convg,tp,imat,g,hsum,npt,ng,mu,enln,h0,s,tm,en,a,sp,hp,jcond,enn,sumn,b0,s0,hsub0,tt,cpsum,pderiv,vol)
      use params_cea_inc, only : ncol, maxmat, maxel, maxngc
      implicit none
      integer, intent(In) :: nlm
      integer, intent(In) :: npr
      integer, intent(InOut) :: iq1
      logical, intent(In) :: convg
      logical, intent(In) :: tp
      integer, intent(InOut) :: imat
      real(kind=8), dimension(1:maxmat,1:maxmat+1), intent(InOut) :: g
      real(kind=8), dimension(1:ncol), intent(InOut) :: hsum
      integer, intent(In) :: npt
      integer, intent(In) :: ng
      real(kind=8), dimension(1:maxngc), intent(InOut) :: mu
      real(kind=8), dimension(1:maxngc), intent(In) :: enln
      real(kind=8), dimension(1:maxngc), intent(In) :: h0
      real(kind=8), dimension(1:maxngc), intent(In) :: s
      real(kind=8), intent(In) :: tm
      real(kind=8), dimension(1:maxngc,1:ncol), intent(In) :: en
      real(kind=8), dimension(1:maxel,1:maxngc), intent(In) :: a
      logical, intent(In) :: sp
      logical, intent(In) :: hp
      integer, dimension(1:45), intent(In) :: jcond
      real(kind=8), intent(In) :: enn
      real(kind=8), intent(In) :: sumn
      real(kind=8), dimension(1:maxel), intent(In) :: b0
      real(kind=8), intent(In) :: s0
      real(kind=8), intent(In) :: hsub0
      real(kind=8), intent(In) :: tt
      real(kind=8), intent(In) :: cpsum
      logical, intent(In) :: pderiv
      logical, intent(In) :: vol
      real :: d0
      integer :: i
      integer :: iq
      integer :: iq2
      integer :: iq3
      integer :: isym
      integer :: j
      integer :: k
      integer :: kk
      integer :: kmat
      real(kind=8) :: energyl
      real(kind=8) :: f
      real(kind=8) :: h
      real(kind=8) :: ss
      real(kind=8) :: sss
      real(kind=8) :: term
      real(kind=8) :: term1
      save energyl,f,h,i,iq,iq2,iq3,isym,j,k,kk,kmat,ss,sss,term,term1
      iq = nlm + npr
      iq1 = iq + 1
      iq2 = iq1 + 1
      iq3 = iq2 + 1
      kmat = iq3
      if ( .not.convg.and.tp ) kmat = iq2
      imat = kmat - 1
      do i = 1,imat
        do k = 1,kmat
          g(i,k) = 0.0d0
        enddo
      enddo
      g(iq2,iq1) = 0.d0
      sss = 0.d0
      hsum(npt) = 0.d0
      do j = 1,ng
        mu(j) = h0(j) - s(j) + enln(j) + tm
        if ( en(j,npt) /= 0.d0 ) then
          h = h0(j)*en(j,npt)
          f = mu(j)*en(j,npt)
          ss = h - f
          term1 = h
          if ( kmat == iq2 ) term1 = f
          do i = 1,nlm
            if ( a(i,j) /= 0. ) then
              term = a(i,j)*en(j,npt)
              do k = i,nlm
                g(i,k) = g(i,k) + a(k,j)*term
              enddo
              g(i,iq1) = g(i,iq1) + term
              g(i,iq2) = g(i,iq2) + a(i,j)*term1
              if ( .not.(convg.or.tp) ) then
                g(i,iq3) = g(i,iq3) + a(i,j)*f
                if ( sp ) g(iq2,i) = g(iq2,i) + a(i,j)*ss
              endif
            endif
          enddo
          if ( kmat /= iq2 ) then
            if ( convg.or.hp ) then
              g(iq2,iq2) = g(iq2,iq2) + h0(j)*h
              if ( .not.convg ) then
                g(iq2,iq3) = g(iq2,iq3) + h0(j)*f
                g(iq1,iq3) = g(iq1,iq3) + f
              endif
            else
              g(iq2,iq1) = g(iq2,iq1) + ss
              g(iq2,iq2) = g(iq2,iq2) + h0(j)*ss
              g(iq2,iq3) = g(iq2,iq3) + mu(j)*ss
              g(iq1,iq3) = g(iq1,iq3) + f
            endif
          endif
          g(iq1,iq2) = g(iq1,iq2) + term1
        endif
      enddo
      if ( npr /= 0 ) then
        do k = 1,npr
          j = jcond(k)
          kk = nlm + k
          mu(j) = h0(j) - s(j)
          do i = 1,nlm
            g(i,kk) = a(i,j)
            g(i,kmat) = g(i,kmat) - a(i,j)*en(j,npt)
          enddo
          g(kk,iq2) = h0(j)
          g(kk,kmat) = mu(j)
          hsum(npt) = hsum(npt) + h0(j)*en(j,npt)
          if ( sp ) then
            sss = sss + s(j)*en(j,npt)
            g(iq2,kk) = s(j)
          endif
        enddo
      endif
      sss = sss + g(iq2,iq1)
      hsum(npt) = hsum(npt) + g(iq1,iq2)
      g(iq1,iq1) = sumn - enn
      isym = iq1
      if ( hp.or.convg ) isym = iq2
      do i = 1,isym
        do j = i,isym
          g(j,i) = g(i,j)
        enddo
      enddo
      if ( .not.convg ) then
        do i = 1,nlm
          g(i,kmat) = g(i,kmat) + b0(i) - g(i,iq1)
        enddo
        g(iq1,kmat) = g(iq1,kmat) + enn - sumn
        if ( kmat /= iq2 ) then
          if ( sp ) energyl = s0 + enn - sumn - sss
          if ( hp ) energyl = hsub0/tt - hsum(npt)
          g(iq2,iq3) = g(iq2,iq3) + energyl
          g(iq2,iq2) = g(iq2,iq2) + cpsum
        endif
      else
        if ( pderiv ) then
          g(iq1,iq2) = enn
          do i = 1,iq
            g(i,iq2) = g(i,iq1)
          enddo
        endif
        g(iq2,iq2) = g(iq2,iq2) + cpsum
      endif
      if ( vol.and..not.convg ) then
        if ( kmat == iq2 ) then
          do i = 1,iq
            g(i,iq1) = g(i,iq2)
          enddo
        else
          do i = 1,iq
            g(iq1,i) = g(iq2,i) - g(iq1,i)
            g(i,iq1) = g(i,iq2) - g(i,iq1)
            g(i,iq2) = g(i,iq3)
          enddo
          g(iq1,iq1) = g(iq2,iq2) - g(iq1,iq2) - g(iq2,iq1)
          g(iq1,iq2) = g(iq2,iq3) - g(iq1,iq3)
          if ( hp ) g(iq1,iq2) = g(iq1,iq2) + enn
        endif
        kmat = imat
        imat = imat - 1
      endif
      end subroutine matrix
      subroutine newof(short,oxfl,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,wmix,npt,size,hsub0,hpp,jsol,jliq,vol,jcm,prod)
      use params_cea_inc, only : maxel, maxngc, ioout
      implicit none
      logical, intent(In) :: short
      real(kind=8), intent(In) :: oxfl
      real(kind=8), intent(Out) :: eqrat
      real(kind=8), dimension(1:2), intent(In) :: vmin
      real(kind=8), dimension(1:2), intent(In) :: vpls
      integer, intent(In) :: nlm
      real(kind=8), dimension(1:maxel), intent(InOut) :: b0
      real(kind=8), dimension(1:maxel,1:2), intent(In) :: b0p
      real(kind=8), intent(Out) :: bcheck
      real(kind=8), dimension(1:2), intent(In) :: am
      real(kind=8), intent(Out) :: wmix
      integer, intent(Out) :: npt
      real(kind=8), intent(InOut) :: size
      real(kind=8), intent(InOut) :: hsub0
      real(kind=8), dimension(1:2), intent(In) :: hpp
      integer, intent(Out) :: jsol
      integer, intent(Out) :: jliq
      logical :: vol
      integer, dimension(1:maxel), intent(In) :: jcm
      character(len=15), dimension(0:maxngc), intent(In) :: prod
      integer :: i
      integer :: j
      real(kind=8) :: assval
      real(kind=8) :: bigb
      real(kind=8) :: bratio
      real(kind=8) :: dbi
      real(kind=8) :: smalb
      real(kind=8) :: tem
      real(kind=8) :: v1
      real(kind=8) :: v2
      real(kind=8) :: dabs
      real(kind=8) :: dlog
      save assval,bigb,bratio,dbi,i,j,smalb,tem,v1,v2
      if ( .not.short ) write (ioout,99001) oxfl
      eqrat = 0.
      tem = oxfl + 1.
      v2 = (oxfl*vmin(1)+vmin(2))/tem
      v1 = (oxfl*vpls(1)+vpls(2))/tem
      if ( v2 /= 0. ) eqrat = dabs(v1/v2)
      do i = 1,nlm
        b0(i) = (oxfl*b0p(i,1)+b0p(i,2))/tem
        dbi = dabs(b0(i))
        if ( i == 1 ) then
          bigb = dbi
          smalb = dbi
        elseif ( dbi /= 0. ) then
          if ( dbi < smalb ) smalb = dbi
          if ( dbi > bigb ) bigb = dbi
        endif
      enddo
      bcheck = bigb*.000001d0
      if ( am(1) /= 0.0.and.am(2) /= 0.0 ) then
        wmix = (oxfl+1.)*am(1)*am(2)/(am(1)+oxfl*am(2))
      else
        wmix = am(2)
        if ( am(2) == 0.0 ) wmix = am(1)
      endif
      npt = 1
      if ( size == 0. ) assval = hsub0
      if ( assval >= 1.d30 ) hsub0 = (oxfl*hpp(1)+hpp(2))/tem
      bratio = smalb/bigb
      size = 18.420681d0
      if ( bratio < 1.d-5 ) size = dlog(1000.d0/bratio)
      jsol = 0
      jliq = 0
      if ( .not.short ) then
        write (ioout,99002)
        if ( vol ) write (ioout,99003)
        if ( .not.vol ) write (ioout,99004)
        write (ioout,99005) hpp(2),hpp(1),hsub0
        write (ioout,99006)
      endif
      do i = 1,nlm
        j = jcm(i)
        if ( .not.short ) write (ioout,99007) prod(j),b0p(i,2),b0p(i,1),                           b0(i)
      enddo
      return
99001 format (/' O/F = ',f10.6)
99002 format (/,23x,'EFFECTIVE FUEL',5x,'EFFECTIVE OXIDANT',8x,        'MIXTURE')
99003 format (' INTERNAL ENERGY',11x,'u(2)/R',14x,'u(1)/R',14x,'u0/R')
99004 format (' ENTHALPY',18x,'h(2)/R',14x,'h(1)/R',15x,'h0/R')
99005 format (' (KG-MOL)(K)/KG',4x,e18.8,2e20.8)
99006 format (/' KG-FORM.WT./KG',13x,'bi(2)',15x,'bi(1)',15x,'b0i')
99007 format (1x,a16,3e20.8)
      end subroutine newof
      subroutine out1(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      use params_cea_inc, only : ncol, maxr, maxmat, ioout, maxngc
      implicit none
      character(len=15) :: case
      logical :: moles
      logical :: siunit
      integer :: nreac
      real(kind=8), dimension(1:maxr) :: enth
      character(len=8), dimension(1:maxr) :: fox
      real(kind=8), dimension(1:maxr) :: pecwt
      real(kind=8) :: r
      character(len=15), dimension(1:maxr) :: rname
      real(kind=8), dimension(1:maxr) :: rtemp
      real(kind=8) :: oxfl
      real(kind=8), dimension(1:2) :: vmin
      real(kind=8), dimension(1:2) :: vpls
      real(kind=8), dimension(1:2) :: rh
      real(kind=8) :: eqrat
      logical :: page1
      logical :: rkt
      integer :: iopt
      integer :: nplt
      character(len=15), dimension(1:20) :: pltvar
      logical :: gonly
      integer :: iplt
      integer :: npt
      real(kind=8), dimension(1:500,1:20) :: pltout
      character(len=4), dimension(1:30) :: fmt
      real(kind=8), dimension(1:ncol) :: ppp
      real(kind=8), dimension(1:maxmat) :: x
      real(kind=8), dimension(1:ncol) :: ttt
      real(kind=8), dimension(1:ncol) :: vlm
      real(kind=8), dimension(1:ncol) :: hsum
      real(kind=8) :: rr
      real(kind=8), dimension(1:ncol) :: ssum
      real(kind=8), dimension(1:ncol) :: wm
      real(kind=8), dimension(1:ncol) :: totn
      real(kind=8), dimension(1:ncol) :: cpr
      real(kind=8), dimension(1:ncol) :: gammas
      real(kind=8), dimension(1:ncol) :: dlvtp
      real(kind=8), dimension(1:ncol) :: dlvpt
      logical :: eql
      real(kind=8), dimension(1:ncol) :: sonvel
      real(kind=8) :: trace
      logical :: massf
      integer :: ngc
      integer :: ng
      character(len=15), dimension(0:maxngc) :: prod
      real(kind=8), dimension(1:maxngc) :: mw
      real(kind=8), dimension(1:maxngc,1:ncol) :: en
      character(len=15), dimension(0:maxngc) :: omit
      real(kind=8), dimension(1:4) :: tg
      logical :: short
      real(kind=8), dimension(1:ncol) :: vis
      real(kind=8), dimension(1:ncol) :: coneql
      real(kind=8), dimension(1:ncol) :: preql
      real(kind=8), dimension(1:ncol) :: confro
      real(kind=8), dimension(1:ncol) :: prfro
      real(kind=8), dimension(1:ncol) :: cpeql
      real(kind=8), dimension(1:ncol) :: cpfro
      character(len=15) :: fc
      character(len=15) :: fgi
      character(len=15) :: fh
      character(len=15) :: fp
      character(len=15) :: frh
      character(len=15) :: fs
      character(len=15) :: fu
      character(len=4) :: mamo
      integer :: i
      integer :: im
      integer :: ione
      integer :: j
      integer :: k
      integer :: kin
      integer :: m
      integer :: mcond
      integer :: mcondf
      integer :: mcp
      integer :: mdvp
      integer :: mdvt
      integer :: meq
      integer :: mfa
      integer :: mg
      integer :: mgam
      integer :: mh
      integer :: mie
      integer :: mm
      integer :: mmw
      integer :: mof
      integer :: mp
      integer :: mpf
      integer :: mph
      integer :: mpn
      integer :: mpnf
      integer :: mrho
      integer :: ms
      integer :: mson
      integer :: mt
      integer :: mvis
      integer, dimension(1:24) :: mxx
      integer :: n
      integer :: notuse
      integer :: index
      logical :: kok
      real(kind=8) :: pfactor
      real(kind=8) :: pfuel
      real(kind=8) :: phi
      real(kind=8) :: rho
      real(kind=8) :: tem
      real(kind=8) :: tra
      real(kind=8) :: vnum
      save fc,fgi,fh,fp,frh,fs,fu,i,im,ione,j,k,kin,kok,m,  mamo,mcond,mcondf,mcp,mdvp,mdvt,meq,mfa,mg,mgam,mh,mie,mm,mmw,  mof,mp,mpf,mph,mpn,mpnf,mrho,ms,mson,mt,mvis,mxx,n,notuse,  pfactor,pfuel,phi,rho,tem,tra,vnum
      mp = mxx(1)
      mt = mxx(2)
      mrho = mxx(3)
      mh = mxx(4)
      mie = mxx(5)
      mg = mxx(6)
      ms = mxx(7)
      mm = mxx(8)
      mcp = mxx(9)
      mgam = mxx(10)
      mson = mxx(11)
      mcond = mxx(12)
      mvis = mxx(13)
      mpn = mxx(14)
      mpf = mxx(15)
      mof = mxx(16)
      mph = mxx(17)
      meq = mxx(18)
      mfa = mxx(19)
      mmw = mxx(20)
      mdvt = mxx(21)
      mdvp = mxx(22)
      mcondf = mxx(23)
      mpnf = mxx(24)
      write (ioout,99001) case
      if ( moles ) then
        write (ioout,99002) '   MOLES   '
        if ( .not.siunit ) write (ioout,99003)
        if ( siunit ) write (ioout,99004)
      else
        write (ioout,99002) 'WT FRACTION'
        if ( .not.siunit ) write (ioout,99005)
        if ( siunit ) write (ioout,99006)
      endif
      do n = 1,nreac
        write (ioout,99007) fox(n),rname(n),pecwt(n),enth(n)*r,rtemp(n)
      enddo
      phi = 0.
      tem = (vpls(1)+vmin(1))*oxfl
      if ( abs(tem) >= 1.d-3 ) phi = -(vmin(2)+vpls(2))/tem
      if ( fox(1) == 'NAME' ) then
        pfuel = 0.
      else
        pfuel = 100.d0/(1.d0+oxfl)
      endif
      if ( rh(1) /= 0..or.rh(2) /= 0. ) then
        if ( rh(1) == 0..or.rh(2) == 0. ) then
          rho = max(rh(1),rh(2))
        else
          rho = (oxfl+1.)*rh(1)*rh(2)/(rh(1)+oxfl*rh(2))
        endif
        if ( siunit ) then
          rho = rho*1000.d0
          write (ioout,99021) rho
        else
          write (ioout,99022) rho
        endif
      endif
      write (ioout,99008) oxfl,pfuel,eqrat,phi
      return
      entry out2(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      ione = 0
      if ( rkt.and..not.page1 ) then
        ione = 2
        if ( iopt /= 0 ) ione = 3
      endif
      do i = 1,24
        mxx(i) = 0
      mp = mxx(1)
      mt = mxx(2)
      mrho = mxx(3)
      mh = mxx(4)
      mie = mxx(5)
      mg = mxx(6)
      ms = mxx(7)
      mm = mxx(8)
      mcp = mxx(9)
      mgam = mxx(10)
      mson = mxx(11)
      mcond = mxx(12)
      mvis = mxx(13)
      mpn = mxx(14)
      mpf = mxx(15)
      mof = mxx(16)
      mph = mxx(17)
      meq = mxx(18)
      mfa = mxx(19)
      mmw = mxx(20)
      mdvt = mxx(21)
      mdvp = mxx(22)
      mcondf = mxx(23)
      mpnf = mxx(24)
      enddo
      do i = 1,nplt
        if ( index(pltvar(i)(2:),'1') == 0 ) then
          if ( index(pltvar(i)(1:),'dlnt') /= 0 ) then
            mdvt = i
      mxx(21) = mdvt
          elseif ( index(pltvar(i)(1:),'dlnp') /= 0 ) then
            mdvp = i
      mxx(22) = mdvp
          elseif ( pltvar(i)(:4) == 'pran' ) then
            if ( index(pltvar(i)(3:),'fz') /= 0 .or.           index(pltvar(i)(3:),'fr') /= 0 ) then
              mpnf = i
      mxx(24) = mpnf
            else
              mpn = i
      mxx(14) = mpn
            endif
          elseif ( pltvar(i)(:4) == 'cond' ) then
            if ( index(pltvar(i)(3:),'fz') /= 0 .or.           index(pltvar(i)(3:),'fr') /= 0 ) then
              mcondf = i
      mxx(23) = mcondf
            else
              mcond = i
      mxx(12) = mcond
            endif
          elseif ( pltvar(i)(:3) == 'phi' ) then
            mph = i
      mxx(17) = mph
          elseif ( pltvar(i)(:2) == 'p ' ) then
            mp = i
      mxx(1) = mp
          elseif ( pltvar(i)(:1) == 't' ) then
            mt = i
      mxx(2) = mt
          elseif ( pltvar(i)(:3) == 'rho' ) then
            mrho = i
      mxx(3) = mrho
          elseif ( pltvar(i)(:1) == 'h' ) then
            mh = i
      mxx(4) = mh
          elseif ( pltvar(i)(:1) == 'u' ) then
            mie = i
      mxx(5) = mie
          elseif ( pltvar(i)(:3) == 'gam' ) then
            mgam = i
      mxx(10) = mgam
          elseif ( pltvar(i)(:3) == 'son' ) then
            mson = i
      mxx(11) = mson
          elseif ( pltvar(i)(:2) == 'g ' ) then
            mg = i
      mxx(6) = mg
          elseif ( pltvar(i)(:2) == 's ' ) then
            ms = i
      mxx(7) = ms
          elseif ( pltvar(i)(:1) == 'm'.and.pltvar(i)(:2) /= 'ma' ) then
            if ( .not.gonly.and.pltvar(i)(:2) == 'mw' ) then
              mmw = i
      mxx(20) = mmw
            else
              mm = i
      mxx(8) = mm
            endif
          elseif ( pltvar(i)(:2) == 'cp' ) then
            mcp = i
      mxx(9) = mcp
          elseif ( pltvar(i)(:3) == 'vis' ) then
            mvis = i
      mxx(13) = mvis
          elseif ( pltvar(i)(:3) == 'o/f' ) then
            mof = i
      mxx(16) = mof
          elseif ( pltvar(i)(:2) == '%f' ) then
            mpf = i
      mxx(15) = mpf
          elseif ( pltvar(i)(:3) == 'f/a' ) then
            mfa = i
      mxx(19) = mfa
          elseif ( pltvar(i)(:1) == 'r' ) then
            meq = i
      mxx(18) = meq
          endif
        endif
  end do
      do i = iplt + 1,iplt + npt
        if ( mof > 0 ) pltout(i,mof) = oxfl
        if ( mpf > 0 ) pltout(i,mpf) = pfuel
        if ( mph > 0 ) pltout(i,mph) = phi
        if ( mfa > 0 ) pltout(i,mfa) = 1.d0/oxfl
        if ( meq > 0 ) pltout(i,meq) = eqrat
      enddo
      if ( siunit ) then
        pfactor = 1.d0
        fp = 'P, BAR'
        vnum = 1.d05
        frh = 'RHO, KG/CU M'
        fh = 'H, KJ/KG'
        fu = 'U, KJ/KG'
        fgi = 'G, KJ/KG'
        fs = 'S, KJ/(KG)(K)'
        fc = 'Cp, KJ/(KG)(K)'
      else
        pfactor = 1.d0/1.01325d0
        fp = 'P, ATM'
        vnum = 100.d0
        frh = 'RHO, G/CC'
        fh = 'H, CAL/G'
        fu = 'U, CAL/G'
        fgi = 'G, CAL/G'
        fs = 'S, CAL/(G)(K)'
        fc = 'Cp, CAL/(G)(K)'
      endif
      fmt(4) = fmt(6)
      call varfmt(ppp,npt,fmt)
      do i = 1,npt
        x(i) = ppp(i)*pfactor
        if ( nplt /= 0.and.i > ione ) then
          if ( mp > 0 ) pltout(i+iplt-ione,mp) = x(i)
          if ( mt > 0 ) pltout(i+iplt-ione,mt) = ttt(i)
        endif
      enddo
      write (ioout,fmt) fp,(x(j),j=1,npt)
      fmt(4) = '13'
      fmt(5) = ' '
      fmt(7) = '2,'
      write (ioout,fmt) 'T, K            ',(ttt(j),j=1,npt)
      do i = 1,npt
        if ( vlm(i) /= 0. ) x(i) = vnum/vlm(i)
        if ( nplt /= 0.and.i > ione.and.mrho > 0 )       pltout(i+iplt-ione,mrho) = x(i)
      enddo
      call efmt(fmt(4),frh,x,npt)
      do i = 1,npt
        x(i) = hsum(i)*r
        if ( nplt /= 0.and.i > ione.and.mh > 0 )       pltout(i+iplt-ione,mh) = x(i)
      enddo
      fmt(4) = fmt(6)
      call varfmt(x,npt,fmt)
      write (ioout,fmt) fh,(x(j),j=1,npt)
      do i = 1,npt
        x(i) = (hsum(i)-ppp(i)*vlm(i)/rr)*r
        if ( nplt /= 0.and.i > ione.and.mie > 0 )       pltout(i+iplt-ione,mie) = x(i)
      enddo
      call varfmt(x,npt,fmt)
      write (ioout,fmt) fu,(x(j),j=1,npt)
      do i = 1,npt
        x(i) = (hsum(i)-ttt(i)*ssum(i))*r
        if ( nplt /= 0.and.i > ione ) then
          if ( mg > 0 ) pltout(i+iplt-ione,mg) = x(i)
          if ( mm > 0 ) pltout(i+iplt-ione,mm) = wm(i)
          if ( mmw > 0 ) pltout(i+iplt-ione,mmw) = 1.d0/totn(i)
          if ( ms > 0 ) pltout(i+iplt-ione,ms) = ssum(i)*r
          if ( mcp > 0 ) pltout(i+iplt-ione,mcp) = cpr(i)*r
          if ( mgam > 0 ) pltout(i+iplt-ione,mgam) = gammas(i)
          if ( mdvt > 0 ) pltout(i+iplt-ione,mdvt) = dlvtp(i)
          if ( mdvp > 0 ) pltout(i+iplt-ione,mdvp) = dlvpt(i)
        endif
      enddo
      call varfmt(x,npt,fmt)
      write (ioout,fmt) fgi,(x(j),j=1,npt)
      fmt(4) = '13'
      fmt(5) = ' '
      fmt(7) = '4,'
      write (ioout,fmt) fs,(ssum(j)*r,j=1,npt)
      write (ioout,99009)
      fmt(7) = '3,'
      write (ioout,fmt) 'M, (1/n)        ',(wm(j),j=1,npt)
      if ( .not.gonly ) write (ioout,fmt) 'MW, MOL WT      ',                                (1.d0/totn(j),j=1,npt)
      fmt(7) = '5,'
      if ( eql ) write (ioout,fmt) '(dLV/dLP)t      ',(dlvpt(j),j=1,npt)
      fmt(7) = '4,'
      if ( eql ) write (ioout,fmt) '(dLV/dLT)p      ',(dlvtp(j),j=1,npt)
      write (ioout,fmt) fc,(cpr(j)*r,j=1,npt)
      fmt(7) = '4,'
      write (ioout,fmt) 'GAMMAs          ',(gammas(j),j=1,npt)
      fmt(7) = '1,'
      do i = 1,npt
        sonvel(i) = (rr*gammas(i)*ttt(i)/wm(i))**.5
        if ( nplt /= 0.and.i > ione.and.mson > 0 )       pltout(i+iplt-ione,mson) = sonvel(i)
      enddo
      write (ioout,fmt) 'SON VEL,M/SEC   ',(sonvel(j),j=1,npt)
      return
      entry out3(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      tra = 5.d-6
      if ( trace /= 0. ) tra = trace
      if ( massf ) then
        mamo = 'MASS'
      else
        mamo = 'MOLE'
      endif
      if ( eql ) then
        write (ioout,99010) mamo
        notuse = 0
        do k = 1,ngc
          kok = .true.
          if ( k > ng.and.k < ngc.and.prod(k) == prod(k+1) ) then
            kok = .false.
            im = 0
            goto 120
          endif
          do m = 1,nplt
            im = 0
            if ( pltvar(m) == prod(k).or.'*'//pltvar(m) == prod(k) )           then
              im = m
              goto 120
            endif
          enddo
 120      kin = 0
          do i = 1,npt
            if ( massf ) then
              tem = mw(k)
            else
              tem = 1.d0/totn(i)
            endif
            if ( k <= ng ) then
              x(i) = en(k,i)*tem
            else
              if ( prod(k) /= prod(k-1) ) x(i) = 0.d0
              if ( en(k,i) > 0.d0 ) x(i) = en(k,i)*tem
            endif
            if ( nplt /= 0.and.i > ione.and.im > 0 )           pltout(i+iplt-ione,im) = x(i)
            if ( kok.and.x(i) >= tra ) kin = 1
          enddo
          if ( kin == 1 ) then
            if ( trace == 0. ) then
              write (ioout,99011) prod(k),(x(i),i=1,npt)
            else
              call efmt(fmt(4),prod(k),x,npt)
            endif
            if ( prod(k) == omit(notuse) ) notuse = notuse - 1
          elseif ( prod(k) /= prod(k-1) ) then
            notuse = notuse + 1
            omit(notuse) = prod(k)
          endif
        enddo
      endif
      write (ioout,99012) tg(4)
      if ( .not.short ) then
        write (ioout,99013) mamo,tra
        write (ioout,99014) (omit(i),i=1,notuse)
      endif
      if ( .not.moles ) write (ioout,99015)
      goto 200
      entry out4(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      write (ioout,99009)
      write (ioout,99016)
      if ( siunit ) then
        write (ioout,99018)
      else
        write (ioout,99017)
      endif
      fmt(4) = fmt(6)
      if ( nplt > 0 ) then
        do i = 1,npt
          if ( i > ione ) then
            if ( mvis > 0 ) pltout(i+iplt-ione,mvis) = vis(i)
            if ( mcond > 0 ) pltout(i+iplt-ione,mcond) = coneql(i)
            if ( mpn > 0 ) pltout(i+iplt-ione,mpn) = preql(i)
            if ( mcondf > 0 ) pltout(i+iplt-ione,mcondf) = confro(i)
            if ( mpnf > 0 ) pltout(i+iplt-ione,mpnf) = prfro(i)
          endif
        enddo
      endif
      call varfmt(vis,npt,fmt)
      write (ioout,fmt) 'VISC,MILLIPOISE',(vis(j),j=1,npt)
      fmt(4) = '13'
      fmt(5) = ' '
      fmt(7) = '4,'
      if ( eql ) then
        write (ioout,99019)
        write (ioout,fmt) fc,(cpeql(j),j=1,npt)
        write (ioout,fmt) 'CONDUCTIVITY    ',(coneql(j),j=1,npt)
        write (ioout,fmt) 'PRANDTL NUMBER  ',(preql(j),j=1,npt)
      endif
      write (ioout,99020)
      write (ioout,fmt) fc,(cpfro(j),j=1,npt)
      write (ioout,fmt) 'CONDUCTIVITY    ',(confro(j),j=1,npt)
      write (ioout,fmt) 'PRANDTL NUMBER  ',(prfro(j),j=1,npt)
 200  return
99001 format (' CASE = ',a15)
99002 format (/13x,'REACTANT',20x,a11,'      ENERGY',6x,'TEMP')
99003 format (57x,' CAL/MOL ',6x,'K')
99004 format (57x,'KJ/KG-MOL',6x,'K')
99005 format (42x,'(SEE NOTE)      CAL/MOL       K  ')
99006 format (42x,'(SEE NOTE)     KJ/KG-MOL      K  ')
99007 format (1x,a8,4x,a15,11x,f12.7,f14.3,f11.3)
99008 format (/' O/F=',f11.5,2x,'%FUEL=',f10.6,2x,'R,EQ.RATIO=',f9.6,2x,        'PHI,EQ.RATIO=',f9.6)
99009 format ()
99010 format (/1x,a4,' FRACTIONS'/)
99011 format (1x,a15,f9.5,12f9.5)
99012 format (/'  * THERMODYNAMIC PROPERTIES FITTED TO',f7.0,'K')
99013 format (/'    PRODUCTS WHICH WERE CONSIDERED BUT WHOSE ',a4,        ' FRACTIONS',/'    WERE LESS THAN',1pe13.6,        ' FOR ALL ASSIGNED CONDITIONS'/)
99014 format (5(1x,a15))
99015 format (/' NOTE. WEIGHT FRACTION OF FUEL IN TOTAL FUELS AND OF',        ' OXIDANT IN TOTAL OXIDANTS')
99016 format (' TRANSPORT PROPERTIES (GASES ONLY)')
99017 format ('   CONDUCTIVITY IN UNITS OF MILLICALORIES/(CM)(K)(SEC)'/)
99018 format ('   CONDUCTIVITY IN UNITS OF MILLIWATTS/(CM)(K)'/)
99019 format (/'  WITH EQUILIBRIUM REACTIONS'/)
99020 format (/'  WITH FROZEN REACTIONS'/)
99021 format (/' REACTANT DENSITY=',f8.2,' KG/CU M')
99022 format (/' REACTANT DENSITY=',f8.4,' G/CC')
      end subroutine out1
      subroutine react(wp,hpp,vpls,vmin,am,rh,elmt,b0p,nreac,energy,rnum,tt,rtemp,tg,rname,enth,rr,nlm,nfla,ratom,hp,tln,vol,fox,symbol,atmwt,atwt,x,valnce,pecwt,moles,dens,rmw,short)
      use params_cea_inc, only : maxmat, ioout, maxr, iothm, maxel
      implicit none
      real(kind=8), dimension(1:2), intent(InOut) :: wp
      real(kind=8), dimension(1:2), intent(InOut) :: hpp
      real(kind=8), dimension(1:2), intent(InOut) :: vpls
      real(kind=8), dimension(1:2), intent(InOut) :: vmin
      real(kind=8), dimension(1:2), intent(InOut) :: am
      real(kind=8), dimension(1:2), intent(InOut) :: rh
      character(len=2), dimension(1:maxel), intent(InOut) :: elmt
      real(kind=8), dimension(1:maxel,1:2), intent(InOut) :: b0p
      integer, intent(In) :: nreac
      character(len=15), dimension(1:maxr), intent(InOut) :: energy
      real(kind=8), dimension(1:maxr,1:12), intent(InOut) :: rnum
      real(kind=8), intent(InOut) :: tt
      real(kind=8), dimension(1:maxr), intent(InOut) :: rtemp
      real(kind=8), dimension(1:4) :: tg
      character(len=15), dimension(1:maxr), intent(In) :: rname
      real(kind=8), dimension(1:maxr), intent(InOut) :: enth
      real(kind=8), intent(In) :: rr
      integer, intent(InOut) :: nlm
      integer, dimension(1:maxr), intent(InOut) :: nfla
      character(len=2), dimension(1:maxr,1:12), intent(InOut) :: ratom
      logical, intent(In) :: hp
      real(kind=8), intent(InOut) :: tln
      logical, intent(In) :: vol
      character(len=8), dimension(1:maxr), intent(InOut) :: fox
      character(len=2), dimension(1:100), intent(In) :: symbol
      real(kind=8), dimension(1:100), intent(In) :: atmwt
      real(kind=8), dimension(1:maxel), intent(Out) :: atwt
      real(kind=8), dimension(1:maxmat), intent(InOut) :: x
      real(kind=8), dimension(1:100), intent(In) :: valnce
      real(kind=8), dimension(1:maxr), intent(InOut) :: pecwt
      logical, intent(In) :: moles
      real(kind=8), dimension(1:maxr), intent(In) :: dens
      real(kind=8), dimension(1:maxr), intent(Out) :: rmw
      logical, intent(In) :: short
      real :: d0
      character(len=6) :: date
      character(len=2), dimension(1:5) :: el
      character(len=15) :: sub
      integer :: i
      integer :: icf
      integer :: ifaz
      integer :: ifrmla
      integer :: itot
      integer :: j
      integer :: jj
      integer :: k
      integer :: kk
      integer :: kr
      integer :: l
      integer :: n
      integer :: nall
      integer :: nint
      integer :: nj
      integer :: ntgas
      integer :: ntot
      logical :: fuel
      logical :: rcoefs
      logical, dimension(1:2) :: wdone
      logical :: hok
      real(kind=8), dimension(1:5) :: bb
      real(kind=8), dimension(1:35) :: dat
      real(kind=8) :: dift
      real(kind=8) :: eform
      real(kind=8) :: pcwt
      real(kind=8), dimension(1:9,1:3) :: rcf
      real(kind=8) :: rm
      real(kind=8) :: t1
      real(kind=8) :: t2
      real(kind=8) :: dabs
      real(kind=8) :: dlog
      real(kind=8) :: t1save
      real(kind=8) :: t2save
      save bb,dat,date,dift,eform,el,fuel,i,icf,ifaz,ifrmla,itot,j,jj,k,  kk,kr,l,n,nall,nint,nj,ntgas,ntot,pcwt,rcf,rcoefs,rm,sub,t1,t2,  wdone
      do k = 1,2
        wdone(k) = .false.
        wp(k) = 0.
        hpp(k) = 0.
        vpls(k) = 0.
        vmin(k) = 0.
        am(k) = 0.
        rh(k) = 0.
        do j = 1,maxel
          elmt(j) = ' '
          b0p(j,k) = 0.
        enddo
      enddo
      do i = 1,maxel
        dat(i) = 0.
      enddo
      do n = 1,nreac
        hok = .false.
        t1save = 20000.d0
        t2save = 0.d0
        rcoefs = .true.
        if ( energy(n) == 'lib'.or.rnum(n,1) == 0. ) then
          tt = rtemp(n)
          rewind iothm
          read (iothm) tg,ntgas,ntot,nall
          do itot = 1,nall
            if ( itot <= ntot ) then
              icf = 3
              if ( itot > ntgas ) icf = 1
              read (iothm) sub,nint,date,(el(j),bb(j),j=1,5),ifaz,t1,t2,                     rm,((rcf(i,j),i=1,9),j=1,icf)
            else
              read (iothm) sub,nint,date,(el(j),bb(j),j=1,5),ifaz,t1,t2,                     rm,eform
              if ( nint > 0 ) read (iothm) ((rcf(i,j),i=1,9),j=1,nint)
            endif
            if ( sub == rname(n).or.sub == '*'//rname(n) ) then
              if ( nint == 0 ) then
                rcoefs = .false.
                hok = .true.
                enth(n) = eform*1000.d0/rr
                if ( tt == 0 ) then
                  tt = t1
                  rtemp(n) = t1
                else
                  dift = dabs(tt-t1)
                  if ( dift > 01d0 ) then
                    if ( dift > 10.d0 ) then
                      write (ioout,99001) rname(n),t1,tt
                      nlm = 0
                      hok = .false.
                      goto 200
                    else
                      write (ioout,99002) rname(n),t1,tt
                      tt = t1
                      rtemp(n) = t1
                    endif
                  endif
                endif
              else
                if (ifaz <= 0 ) then
                  t1save = min(t1save,.8d0*tg(1))
                  t2save = max(t2save,1.2d0*t2)
                else  
                  t1save = min(t1save,t1-.001d0)
                  t2save = max(t2save,t2+.001d0)
                endif
                if ( t1save  < tt .and. t2save > tt ) hok = .true.
              endif
              do j = 1,5
                if ( bb(j) == 0. ) goto 5
                nfla(n) = j
                ratom(n,j) = el(j)
                rnum(n,j) = bb(j)
              enddo
 5            if ( tt == 0. ) then
                if ( .not.hp ) goto 50
                write (ioout,99004) n
                nlm = 0
                goto 200
              endif
              if ( rcoefs.and.hok ) then
                tln = dlog(tt)
                l = 1
                if ( ifaz <= 0 ) then
                  if ( tt > tg(2) ) l = 2
                  if ( tt > tg(3) ) l = 3
                endif
                enth(n) = (((((rcf(7,l)/5.d0)*tt+rcf(6,l)/4.d0)*tt+rcf(5,l)/3.d0)*tt+rcf(4,l)/2.d0)*tt+rcf(3,l))                    *tt - rcf(1,l)/tt + rcf(2,l)*tln + rcf(8,l)
                if ( vol.and.ifaz <= 0 ) enth(n) = enth(n) - tt
              endif
              if (hok) goto 50
            endif
  end do
          if (.not.hok) then
            write (ioout,99010) tt,rname(n),t1save,t2save
            energy(n) = ' '
            nlm = 0
            goto 200
          endif
        endif
 50     ifrmla = nfla(n)
        if ( fox(n)(:1) == 'f' ) then
          fuel = .true.
          kr = 2
          fox(n) = 'FUEL'
        elseif ( fox(n)(:4) == 'name' ) then
          fuel = .true.
          kr = 2
          fox(n) = 'NAME'
        else
          kr = 1
          fox(n) = 'OXIDANT'
        endif
        do j = 1,maxel
          dat(j) = 0.
        enddo
        rm = 0.d0
        do jj = 1,ifrmla
          do j = 1,maxel
            nj = j
            if ( elmt(j) == ' ' ) goto 60
            if ( ratom(n,jj) == elmt(j) ) goto 80
          enddo
 60       nlm = nj
          elmt(j) = ratom(n,jj)
 80       do kk = 1,100
            if ( symbol(kk) == ratom(n,jj) ) then
              rm = rm + rnum(n,jj)*atmwt(kk)
              atwt(j) = atmwt(kk)
              x(j) = valnce(kk)
              dat(j) = dat(j) + rnum(n,jj)
              goto 100
            endif
          enddo
          write (ioout,99005) ratom(n,jj)
          nlm = 0
          goto 200
 100    continue
      end do
        if ( pecwt(n) < 0. ) then
          pecwt(n) = 0.
          if ( .not.moles.and..not.wdone(kr) ) then
            wdone(kr) = .true.
            pecwt(n) = 100.
            write (ioout,99006) n
          else
            write (ioout,99007) n
            nlm = 0
            goto 200
          endif
        endif
        if ( pecwt(n) > 0. ) wdone(kr) = .true.
        pcwt = pecwt(n)
        if ( moles ) pcwt = pcwt*rm
        wp(kr) = wp(kr) + pcwt
        if ( rm <= 0.d0 ) then
          nlm = 0
          goto 200
        else
          hpp(kr) = hpp(kr) + enth(n)*pcwt/rm
          am(kr) = am(kr) + pcwt/rm
          if ( dens(n) /= 0. ) then
            rh(kr) = rh(kr) + pcwt/dens(n)
          else
            rh(1) = 0.
            rh(2) = 0.
          endif
          do j = 1,nlm
            b0p(j,kr) = dat(j)*pcwt/rm + b0p(j,kr)
          enddo
          rmw(n) = rm
        endif
      enddo
      if ( .not.fuel ) then
        do n = 1,nreac
          fox(n) = ' '
        enddo
        wp(2) = wp(1)
        wp(1) = 0.
        hpp(2) = hpp(1)
        am(2) = am(1)
        am(1) = 0.
        do j = 1,nlm
          b0p(j,2) = b0p(j,1)
        enddo
      endif
      if ( nlm /= 0 ) then
        do kr = 1,2
          if ( wp(kr) /= 0. ) then
            hpp(kr) = hpp(kr)/wp(kr)
            am(kr) = wp(kr)/am(kr)
            if ( rh(kr) /= 0. ) rh(kr) = wp(kr)/rh(kr)
            do j = 1,nlm
              b0p(j,kr) = b0p(j,kr)/wp(kr)
              if ( x(j) < 0. ) vmin(kr) = vmin(kr) + b0p(j,kr)*x(j)
              if ( x(j) > 0. ) vpls(kr) = vpls(kr) + b0p(j,kr)*x(j)
            enddo
            if ( .not.moles ) then
              do n = 1,nreac
                if ( fox(n)(:1) /= 'O'.or.kr /= 2 ) then
                  if ( fox(n)(:1) == 'O'.or.kr /= 1 ) pecwt(n)                 = pecwt(n)/wp(kr)
                endif
              enddo
            endif
          endif
        enddo
        if ( .not.short ) then
          if ( moles ) then
            write (ioout,99008) ' MOLES '
          else
            write (ioout,99008) 'WT.FRAC'
          endif
          do n = 1,nreac
            write (ioout,99009) fox(n),rname(n),pecwt(n),enth(n),           rtemp(n),dens(n),(ratom(n,i),rnum(n,i),i=1,nfla(n)) 
          enddo
        endif
      endif
 200  return
99001 format (/' REACTANT ',a15,'HAS BEEN DEFINED FOR THE TEMPERATURE',   f8.2,'K ONLY.'/' YOUR TEMPERATURE ASSIGNMENT',f8.2,  ' IS MORE THAN 10 K FROM THIS VALUE. (REACT)')
99002 format (/' NOTE! REACTANT ',a15,'HAS BEEN DEFINED FOR ',  'TEMPERATURE',f8.2,'K ONLY.'/' YOUR TEMPERATURE ASSIGNMENT',  f8.2,' IS NOT = BUT <10 K FROM THIS VALUE. (REACT)')
99003 format (/' NOTE: ',a15,' IS EITHER NOT IN thermo.lib OR THE',        ' TEMPERATURE ',/,        ' IS OUT OF RANGE FOR THIS SPECIES (REACT)')
99004 format (/' TEMPERATURE MISSING FOR REACTANT NO.',i2,'(REACT)')
99005 format (/1x,a2,' NOT FOUND IN BLOCKDATA (REACT)')
99006 format (/' WARNING!!  AMOUNT MISSING FOR REACTANT',i3,'.',        /' PROGRAM SETS WEIGHT PERCENT = 100. (REACT)')
99007 format (/' AMOUNT MISSING FOR REACTANT NO.',i2,'(REACT)')
99008 format (/4x,'REACTANT',10x,a7,3x,'(ENERGY/R),K',3x,        'TEMP,K  DENSITY'/,8x,'EXPLODED FORMULA')
99009 format (1x,a1,': ',a15,f10.6,e15.6,f9.2,f8.4,/8x,5(2x,a2,f8.5))
99010 format (/' YOUR ASSIGNED TEMPERATURE',f8.2,'K FOR ',a15,/, 'IS OUTSIDE ITS TEMPERATURE RANGE',f8.2,' TO',f9.2,'K (REACT)')
      end subroutine react
      subroutine rktout(eql,nfz,iopt,it,t,ttt,ppp,app,subar,ma,fmt,npt,page1,x,nplt,pltvar,siunit,spim,hsum,rr,wm,cstr,vmoc,sonvel,gammas,trnspt,aeat,pltout,iplt,massf,totn,trace,ngc,mw,en,prod,case,moles,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,rkt,gonly,vlm,ssum,cpr,dlvtp,dlvpt,ng,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      use params_cea_inc, only : maxt, maxngc, ncol, ioout, maxmat, maxr
      implicit none
      logical, intent(In) :: eql
      integer, intent(In) :: nfz
      integer, intent(In) :: iopt
      integer :: it
      real(kind=8), dimension(1:maxt) :: t
      real(kind=8), dimension(1:ncol), intent(In) :: ttt
      real(kind=8), dimension(1:ncol), intent(In) :: ppp
      real(kind=8), dimension(1:ncol), intent(In) :: app
      real(kind=8), dimension(1:13), intent(In) :: subar
      real(kind=8), intent(In) :: ma
      character(len=4), dimension(1:30) :: fmt
      integer, intent(In) :: npt
      logical, intent(In) :: page1
      real(kind=8), dimension(1:maxmat), intent(InOut) :: x
      integer, intent(In) :: nplt
      character(len=15), dimension(1:20), intent(In) :: pltvar
      logical, intent(In) :: siunit
      real(kind=8), dimension(1:ncol), intent(InOut) :: spim
      real(kind=8), dimension(1:ncol), intent(In) :: hsum
      real(kind=8), intent(In) :: rr
      real(kind=8), dimension(1:ncol), intent(In) :: wm
      real(kind=8), intent(InOut) :: cstr
      real(kind=8), dimension(1:ncol), intent(InOut) :: vmoc
      real(kind=8), dimension(1:ncol), intent(In) :: sonvel
      real(kind=8), dimension(1:ncol), intent(In) :: gammas
      logical, intent(In) :: trnspt
      real(kind=8), dimension(1:ncol), intent(InOut) :: aeat
      real(kind=8), dimension(1:500,1:20), intent(Out) :: pltout
      integer, intent(In) :: iplt
      logical, intent(In) :: massf
      real(kind=8), dimension(1:ncol), intent(In) :: totn
      real(kind=8), intent(In) :: trace
      integer, intent(In) :: ngc
      real(kind=8), dimension(1:maxngc), intent(In) :: mw
      real(kind=8), dimension(1:maxngc,1:ncol), intent(In) :: en
      character(len=15), dimension(0:maxngc), intent(In) :: prod
      character(len=15) :: case
      logical :: moles
      integer :: nreac
      real(kind=8), dimension(1:maxr) :: enth
      character(len=8), dimension(1:maxr) :: fox
      real(kind=8), dimension(1:maxr) :: pecwt
      real(kind=8) :: r
      character(len=15), dimension(1:maxr) :: rname
      real(kind=8), dimension(1:maxr) :: rtemp
      real(kind=8) :: oxfl
      real(kind=8), dimension(1:2) :: vmin
      real(kind=8), dimension(1:2) :: vpls
      real(kind=8), dimension(1:2) :: rh
      real(kind=8) :: eqrat
      logical :: rkt
      logical :: gonly
      real(kind=8), dimension(1:ncol) :: vlm
      real(kind=8), dimension(1:ncol) :: ssum
      real(kind=8), dimension(1:ncol) :: cpr
      real(kind=8), dimension(1:ncol) :: dlvtp
      real(kind=8), dimension(1:ncol) :: dlvpt
      integer :: ng
      character(len=15), dimension(0:maxngc) :: omit
      real(kind=8), dimension(1:4) :: tg
      logical :: short
      real(kind=8), dimension(1:ncol) :: vis
      real(kind=8), dimension(1:ncol) :: coneql
      real(kind=8), dimension(1:ncol) :: preql
      real(kind=8), dimension(1:ncol) :: confro
      real(kind=8), dimension(1:ncol) :: prfro
      real(kind=8), dimension(1:ncol) :: cpeql
      real(kind=8), dimension(1:ncol) :: cpfro
      character(len=4), dimension(1:11) :: exit
      character(len=15) :: fi
      character(len=15) :: fiv
      character(len=15) :: fr
      character(len=15), dimension(1:4) :: z
      integer :: i
      integer :: i23
      integer :: i46
      integer :: i57
      integer :: i68
      integer :: i79
      integer :: ione
      integer :: ixfr
      integer :: ixfz
      integer :: j
      integer :: k
      integer :: line
      integer :: ln
      integer :: mae
      integer :: mcf
      integer :: misp
      integer :: mivac
      integer :: mmach
      integer :: mppf
      integer :: mppj
      integer, dimension(1:8) :: mxx
      integer :: nex
      integer :: index
      real(kind=8) :: agv
      real(kind=8) :: aw
      real(kind=8) :: gc
      real(kind=8) :: tem
      real(kind=8) :: tra
      real(kind=8), dimension(1:ncol) :: vaci
      real(kind=8) :: ww
      save agv,aw,fi,fiv,fr,gc,i,i23,i46,i57,i68,i79,ione,ixfr,ixfz,j,k,  line,ln,mae,mcf,misp,mivac,mmach,mppf,mppj,mxx,nex,tem,tra,vaci,  ww,z
      data exit / 11*'EXIT' / 
      mppf = mxx(1)
      mppj = mxx(2)
      mmach = mxx(3)
      mae = mxx(4)
      mcf = mxx(5)
      mivac = mxx(6)
      misp = mxx(7)
      if ( .not.eql ) then
        write (ioout,99004)
        if ( nfz > 1 ) write (ioout,99005) nfz
      else
        write (ioout,99001)
        if ( iopt /= 0 ) write (ioout,99002)
        if ( iopt == 0 ) write (ioout,99003)
      endif
      if ( ttt(1) == t(it) ) write (ioout,99006)
      tem = ppp(1)*14.696006d0/1.01325d0
      write (ioout,99009) 'Pin',tem
      i23 = 2
      if ( iopt > 0 ) then
        if ( iopt == 1 ) write (ioout,99007) subar(1),app(2)
        if ( iopt == 2 ) write (ioout,99008) ma,app(2)
        i23 = 3
      endif
      call out1(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      fmt(4) = fmt(6)
      nex = npt - 2
      if ( page1 ) then
        ione = 0
        i46 = 4
        i57 = 5
        i68 = 6
        i79 = 7
      else
        ione = i23
      endif
      if ( iopt == 0 ) then
        write (ioout,99011) (exit(i),i=1,nex)
        call varfmt(app,npt,fmt)
        write (ioout,fmt) 'Pinf/P         ',(app(j),j=1,npt)
      else
        nex = nex - 1
        write (ioout,99010) (exit(i),i=1,nex)
        x(1) = 1.d0
        do i = 2,npt
          x(i) = ppp(1)/ppp(i)
        enddo
        call varfmt(x,npt,fmt)
        write (ioout,fmt) 'Pinj/P         ',(x(i),i=1,npt)
      endif
      call out2(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      do i = 1,8
        mxx(i) = 0
      mppf = mxx(1)
      mppj = mxx(2)
      mmach = mxx(3)
      mae = mxx(4)
      mcf = mxx(5)
      mivac = mxx(6)
      misp = mxx(7)
      enddo
      do i = 1,nplt
        ixfz = index(pltvar(i)(2:),'fz')
        ixfr = index(pltvar(i)(2:),'fr')
        if ( ixfz /= 0.or.ixfr /= 0 ) then
          if ( eql ) goto 100
        elseif ( .not.eql ) then
          goto 100
        endif
        if ( pltvar(i)(:4) == 'pi/p'.or.pltvar(i)(:3) == 'pip' ) then
          if ( iopt == 0 ) mppf = i
      mxx(1) = mppf
          if ( iopt /= 0 ) mppj = i
      mxx(2) = mppj
        elseif ( pltvar(i)(:4) == 'mach' ) then
          mmach = i
      mxx(3) = mmach
        elseif ( pltvar(i)(:2) == 'ae' ) then
          mae = i
      mxx(4) = mae
        elseif ( pltvar(i)(:2) == 'cf' ) then
          mcf = i
      mxx(5) = mcf
        elseif ( pltvar(i)(:4) == 'ivac' ) then
          mivac = i
      mxx(6) = mivac
        elseif ( pltvar(i)(:3) == 'isp' ) then
          misp = i
      mxx(7) = misp
        endif
 100  continue
      end do
      if ( siunit ) then
        agv = 1.
        gc = 1.
        fr = 'CSTAR, M/SEC'
        fiv = 'Ivac, M/SEC'
        fi = 'Isp, M/SEC'
      else
        gc = 32.174
        agv = 9.80665
        fr = 'CSTAR, FT/SEC'
        fiv = 'Ivac,LB-SEC/LB'
        fi = 'Isp, LB-SEC/LB'
      endif
      do k = 2,npt
        spim(k) = (2.*rr*(hsum(1)-hsum(k)))**.5/agv
        aw = rr*ttt(k)/(ppp(k)*wm(k)*spim(k)*agv**2)
        if ( k == i23 ) then
          if ( iopt == 0 ) cstr = gc*ppp(1)*aw
          if ( iopt /= 0 ) cstr = gc*ppp(1)/app(2)*aw
        endif
        vaci(k) = spim(k) + ppp(k)*aw
        vmoc(k) = 0.
        if ( sonvel(k) /= 0. ) vmoc(k) = spim(k)*agv/sonvel(k)
      enddo
      vmoc(1) = 0.
      if ( gammas(i23) == 0. ) vmoc(i23) = 0.
      fmt(7) = '3,'
      write (ioout,fmt) 'MACH NUMBER    ',(vmoc(j),j=1,npt)
      call out4(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      write (ioout,99013)
      fmt(4) = '9x,'
      fmt(i46) = '9x,'
      call varfmt(aeat,npt,fmt)
      fmt(5) = ' '
      fmt(i57) = ' '
      write (ioout,fmt) 'Ae/At          ',(aeat(j),j=2,npt)
      fmt(i57) = '13'
      fmt(i68) = fmt(i68+2)
      fmt(i79) = '1,'
      write (ioout,fmt) fr,(cstr,j=2,npt)
      fmt(i79) = '4,'
      do i = 2,npt
        x(i) = gc*spim(i)/cstr
      enddo
      write (ioout,fmt) 'CF             ',(x(j),j=2,npt)
      fmt(i57) = '13'
      fmt(i79) = '1,'
      write (ioout,fmt) fiv,(vaci(j),j=2,npt)
      write (ioout,fmt) fi,(spim(j),j=2,npt)
      if ( nplt > 0 ) then
        spim(1) = 0
        aeat(1) = 0
        vmoc(1) = 0
        vaci(1) = 0
        x(1) = 0
        spim(1) = 0
        do i = ione + 1,npt
          if ( mppj > 0 ) pltout(i+iplt-ione,mppj) = ppp(1)/ppp(i)
          if ( mppf > 0 ) pltout(i+iplt-ione,mppf) = app(i)
          if ( mmach > 0 ) pltout(i+iplt-ione,mmach) = vmoc(i)
          if ( mae > 0 ) pltout(i+iplt-ione,mae) = aeat(i)
          if ( mcf > 0 ) pltout(i+iplt-ione,mcf) = x(i)
          if ( mivac > 0 ) pltout(i+iplt-ione,mivac) = vaci(i)
          if ( misp > 0 ) pltout(i+iplt-ione,misp) = spim(i)
        enddo
      endif
      write (ioout,99012)
      fmt(4) = ' '
      fmt(5) = '13'
      fmt(7) = '5,'
      if ( iopt /= 0 ) then
        fmt(i46) = fmt(8)
        fmt(i57) = fmt(9)
      endif
      if ( .not.eql ) then
        if ( massf ) then
          write (ioout,99014) 'MASS'
        else
          write (ioout,99014) 'MOLE'
          ww = 1.d0/totn(nfz)
        endif
        tra = 5.e-6
        if ( trace /= 0. ) tra = trace
        line = 0
        do k = 1,ngc
          if ( massf ) ww = mw(k)
          x(line+1) = en(k,nfz)*ww
          if ( x(line+1) >= tra ) then
            line = line + 1
            z(line) = prod(k)
          endif
          if ( line == 3.or.k == ngc ) then
            if ( line == 0 ) goto 200
            write (ioout,99015) (z(ln),x(ln),ln=1,line)
            line = 0
          endif
        enddo
      endif
 200 call out3(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      return
99001 format (/////13x,' THEORETICAL ROCKET PERFORMANCE ASSUMING',        ' EQUILIBRIUM')
99002 format (/11x,' COMPOSITION DURING EXPANSION FROM FINITE AREA',        ' COMBUSTOR')
99003 format (/10x,' COMPOSITION DURING EXPANSION FROM INFINITE AREA',        ' COMBUSTOR')
99004 format (/////10x,' THEORETICAL ROCKET PERFORMANCE ASSUMING FROZEN'        ,' COMPOSITION')
99005 format (33x,'AFTER POINT',i2)
99006 format (25x,'AT AN ASSIGNED TEMPERATURE  ')
99007 format (' Ac/At =',f8.4,6x,'Pinj/Pinf =',f10.6)
99008 format (' MDOT/Ac =',f10.3,' (KG/S)/M**2',6x,'Pinj/Pinf =',f10.6)
99009 format (/1x,a3,' =',f8.1,' PSIA')
99010 format (/,17x,'INJECTOR  COMB END  THROAT',10(5x,a4))
99011 format (/17x,'CHAMBER   THROAT',11(5x,a4))
99012 format ()
99013 format (/' PERFORMANCE PARAMETERS'/)
99014 format (1x,a4,' FRACTIONS'/)
99015 format (1x,3(a15,f8.5,3x))
      end subroutine rktout
      subroutine rocket(iplt,app,iopt,npp,fac,eql,acat,ma,tt,nsub,subar,nfz,nsup,froz,tcest,pp,p,it,oxfl,oxf,t,tp,hp,sp,ip,np,area,isup,page1,npt,cpsum,trnspt,ppp,debugf,isv,cpr,dlvpt,dlvtp,gammas,hsum,ssum,totn,ttt,vlm,wm,short,rr,vv,debug,jsol,enn,npr,s0,awt,aeat,supar,jliq,pcp,nof,nt,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,wmix,size,hsub0,hpp,vol,jcm,prod,trace,ngc,pderiv,convg,jcond,ng,ifz,temp,en,nc,enln,deln,tln,tm,lsave,a,ions,shock,elmt,cp,iq1,imat,g,msing,x,h0,mu,ennl,s,sumn,tg,ngp1,mw,jx,nspx,atwt,gonly,coef,cft,nm,confro,vis,eta,wmol,xs,con,nr,stc,ind,r,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,incdeq,nreac,jray,ntape,boltz,avgdr,pi,viscns,ensave,enlsav,sln,fmt,nplt,pltvar,spim,cstr,vmoc,sonvel,pltout,massf,case,moles,enth,fox,pecwt,rname,rtemp,rh,rkt,omit)
      use params_cea_inc, only : maxel, maxngc, maxnc, maxr, ncol, maxmix, maxng, maxtr, maxt, ioout, maxpv, maxmat
      implicit none
      integer, intent(InOut) :: iplt
      real(kind=8), dimension(1:ncol), intent(InOut) :: app
      integer, intent(InOut) :: iopt
      integer, intent(InOut) :: npp
      logical, intent(In) :: fac
      logical, intent(InOut) :: eql
      real(kind=8), intent(InOut) :: acat
      real(kind=8), intent(In) :: ma
      real(kind=8), intent(InOut) :: tt
      integer, intent(InOut) :: nsub
      real(kind=8), dimension(1:13), intent(InOut) :: subar
      integer, intent(InOut) :: nfz
      integer, intent(InOut) :: nsup
      logical, intent(InOut) :: froz
      real(kind=8), intent(In) :: tcest
      real(kind=8), intent(InOut) :: pp
      real(kind=8), dimension(1:maxpv), intent(In) :: p
      integer, intent(InOut) :: it
      real(kind=8), intent(Out) :: oxfl
      real(kind=8), dimension(1:maxmix), intent(In) :: oxf
      real(kind=8), dimension(1:maxt), intent(In) :: t
      logical, intent(Out) :: tp
      logical, intent(Out) :: hp
      logical, intent(Out) :: sp
      integer, intent(InOut) :: ip
      integer, intent(In) :: np
      logical, intent(InOut) :: area
      integer, intent(InOut) :: isup
      logical, intent(InOut) :: page1
      integer, intent(InOut) :: npt
      real(kind=8), intent(InOut) :: cpsum
      logical, intent(In) :: trnspt
      real(kind=8), dimension(1:ncol), intent(InOut) :: ppp
      logical, intent(In) :: debugf
      integer, intent(InOut) :: isv
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpr
      real(kind=8), dimension(1:ncol), intent(InOut) :: dlvpt
      real(kind=8), dimension(1:ncol), intent(InOut) :: dlvtp
      real(kind=8), dimension(1:ncol), intent(InOut) :: gammas
      real(kind=8), dimension(1:ncol), intent(InOut) :: hsum
      real(kind=8), dimension(1:ncol), intent(InOut) :: ssum
      real(kind=8), dimension(1:ncol), intent(InOut) :: totn
      real(kind=8), dimension(1:ncol), intent(InOut) :: ttt
      real(kind=8), dimension(1:ncol), intent(InOut) :: vlm
      real(kind=8), dimension(1:ncol), intent(InOut) :: wm
      logical, intent(In) :: short
      real(kind=8), intent(In) :: rr
      real(kind=8), intent(InOut) :: vv
      logical, dimension(1:ncol), intent(In) :: debug
      integer, intent(InOut) :: jsol
      real(kind=8), intent(InOut) :: enn
      integer, intent(InOut) :: npr
      real(kind=8), intent(InOut) :: s0
      real(kind=8), intent(InOut) :: awt
      real(kind=8), dimension(1:ncol), intent(InOut) :: aeat
      real(kind=8), dimension(1:13), intent(In) :: supar
      integer, intent(InOut) :: jliq
      real(kind=8), dimension(1:2*ncol), intent(In) :: pcp
      integer, intent(In) :: nof
      integer, intent(In) :: nt
      real(kind=8), intent(Out) :: eqrat
      real(kind=8), dimension(1:2), intent(In) :: vmin
      real(kind=8), dimension(1:2), intent(In) :: vpls
      integer, intent(InOut) :: nlm
      real(kind=8), dimension(1:maxel), intent(InOut) :: b0
      real(kind=8), dimension(1:maxel,1:2), intent(InOut) :: b0p
      real(kind=8), intent(Out) :: bcheck
      real(kind=8), dimension(1:2), intent(In) :: am
      real(kind=8), intent(Out) :: wmix
      real(kind=8), intent(InOut) :: size
      real(kind=8), intent(InOut) :: hsub0
      real(kind=8), dimension(1:2), intent(In) :: hpp
      logical, intent(In) :: vol
      integer, dimension(1:maxel), intent(InOut) :: jcm
      character(len=15), dimension(0:maxngc), intent(In) :: prod
      real(kind=8), intent(In) :: trace
      integer, intent(In) :: ngc
      logical, intent(InOut) :: pderiv
      logical, intent(InOut) :: convg
      integer, dimension(1:45), intent(InOut) :: jcond
      integer, intent(InOut) :: ng
      integer, dimension(1:maxnc), intent(In) :: ifz
      real(kind=8), dimension(1:2,1:maxnc), intent(In) :: temp
      real(kind=8), dimension(1:maxngc,1:ncol), intent(InOut) :: en
      integer, intent(In) :: nc
      real(kind=8), dimension(1:maxngc), intent(InOut) :: enln
      real(kind=8), dimension(1:maxngc), intent(InOut) :: deln
      real(kind=8), intent(InOut) :: tln
      real(kind=8), intent(InOut) :: tm
      integer, intent(InOut) :: lsave
      real(kind=8), dimension(1:maxel,1:maxngc), intent(InOut) :: a
      logical, intent(In) :: ions
      logical, intent(In) :: shock
      character(len=2), dimension(1:maxel), intent(InOut) :: elmt
      real(kind=8), dimension(1:maxngc), intent(In) :: cp
      integer, intent(InOut) :: iq1
      integer, intent(InOut) :: imat
      real(kind=8), dimension(1:maxmat,1:maxmat+1), intent(InOut) :: g
      integer, intent(InOut) :: msing
      real(kind=8), dimension(1:maxmat), intent(InOut) :: x
      real(kind=8), dimension(1:maxngc), intent(In) :: h0
      real(kind=8), dimension(1:maxngc), intent(InOut) :: mu
      real(kind=8), intent(InOut) :: ennl
      real(kind=8), dimension(1:maxngc), intent(In) :: s
      real(kind=8), intent(InOut) :: sumn
      real(kind=8), dimension(1:4), intent(In) :: tg
      integer, intent(In) :: ngp1
      real(kind=8), dimension(1:maxngc), intent(In) :: mw
      integer, dimension(1:maxel), intent(InOut) :: jx
      integer, intent(In) :: nspx
      real(kind=8), dimension(1:maxel), intent(InOut) :: atwt
      logical, intent(Out) :: gonly
      real(kind=8), dimension(1:maxng,1:9,1:3) :: coef
      real(kind=8), dimension(1:maxnc,1:9) :: cft
      integer, intent(InOut) :: nm
      real(kind=8), dimension(1:ncol), intent(InOut) :: confro
      real(kind=8), dimension(1:ncol), intent(InOut) :: vis
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: eta
      real(kind=8), dimension(1:maxtr), intent(InOut) :: wmol
      real(kind=8), dimension(1:maxtr), intent(InOut) :: xs
      real(kind=8), dimension(1:maxtr), intent(InOut) :: con
      integer, intent(InOut) :: nr
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: stc
      integer, dimension(1:maxtr), intent(InOut) :: ind
      real(kind=8), intent(In) :: r
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpfro
      real(kind=8), dimension(1:maxtr), intent(InOut) :: cprr
      logical, intent(In) :: siunit
      real(kind=8), dimension(1:ncol), intent(Out) :: prfro
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpeql
      real(kind=8), dimension(1:ncol), intent(InOut) :: coneql
      real(kind=8), dimension(1:ncol), intent(Out) :: preql
      logical, intent(In) :: incdeq
      integer, intent(In) :: nreac
      integer, dimension(1:maxr), intent(In) :: jray
      integer, intent(In) :: ntape
      real(kind=8), intent(In) :: boltz
      real(kind=8), intent(In) :: avgdr
      real(kind=8), intent(In) :: pi
      real(kind=8), intent(In) :: viscns
      real(kind=8), intent(InOut) :: ensave
      real(kind=8), intent(InOut) :: enlsav
      real(kind=8), dimension(1:maxngc), intent(InOut) :: sln
      character(len=4), dimension(1:30) :: fmt
      integer, intent(In) :: nplt
      character(len=15), dimension(1:20), intent(In) :: pltvar
      real(kind=8), dimension(1:ncol), intent(InOut) :: spim
      real(kind=8), intent(InOut) :: cstr
      real(kind=8), dimension(1:ncol), intent(InOut) :: vmoc
      real(kind=8), dimension(1:ncol), intent(In) :: sonvel
      real(kind=8), dimension(1:500,1:20), intent(Out) :: pltout
      logical, intent(In) :: massf
      character(len=15) :: case
      logical :: moles
      real(kind=8), dimension(1:maxr) :: enth
      character(len=8), dimension(1:maxr) :: fox
      real(kind=8), dimension(1:maxr) :: pecwt
      character(len=15), dimension(1:maxr) :: rname
      real(kind=8), dimension(1:maxr) :: rtemp
      real(kind=8), dimension(1:2) :: rh
      logical :: rkt
      character(len=15), dimension(0:maxngc) :: omit
      real :: d0
      integer :: i
      integer :: i01
      integer :: i12
      integer :: iof
      integer :: iplt1
      integer :: iplte
      integer :: ipp
      integer :: isub
      integer :: isup1
      integer :: isupsv
      integer :: itnum
      integer :: itrot
      integer :: nar
      integer :: nipp
      integer :: niter
      integer :: nn
      integer :: npr1
      integer :: nptth
      logical :: done
      logical :: seql
      logical :: thi
      real(kind=8) :: a1l
      real(kind=8) :: acatsv
      real(kind=8) :: aeatl
      real(kind=8) :: appl
      real(kind=8) :: aratio
      real(kind=8) :: asq
      real(kind=8) :: b1
      real(kind=8) :: c1
      real(kind=8) :: check
      real(kind=8) :: cprf
      real(kind=8) :: dd
      real(kind=8) :: dh
      real(kind=8) :: dlnp
      real(kind=8) :: dlnpe
      real(kind=8) :: dlt
      real(kind=8) :: dp
      real(kind=8) :: eln
      real(kind=8) :: mat
      real(kind=8) :: msq
      real(kind=8) :: p1
      real(kind=8) :: pa
      real(kind=8) :: pcpa
      real(kind=8) :: pcplt
      real(kind=8) :: pinf
      real(kind=8) :: pinj
      real(kind=8) :: pinjas
      real(kind=8) :: pjrat
      real(kind=8) :: ppa
      real(kind=8) :: pr
      real(kind=8) :: pracat
      real(kind=8) :: prat
      real(kind=8) :: pratsv
      real(kind=8) :: pvg
      real(kind=8) :: test
      real(kind=8) :: tmelt
      real(kind=8) :: usq
      real(kind=8) :: dabs
      real(kind=8) :: dlog
      real(kind=8) :: dmax1
      real(kind=8) :: dsqrt
      save acatsv,aeatl,appl,aratio,asq,check,cprf,dd,dh,dlnp,dlnpe,dlt,  done,dp,eln,i,i01,i12,iof,iplt1,iplte,ipp,isub,isup1,isupsv,  itnum,itrot,mat,msq,nar,nipp,niter,nn,npr1,nptth,p1,pcpa,pcplt,  pinf,pinj,pinjas,pjrat,ppa,pr,pracat,prat,pratsv,pvg,seql,test,  thi,tmelt,usq
      data a1l / -1.26505 / ,b1 / 1.0257 / ,c1 / -1.2318 / ,pa / 1.e05 / 
      iplte = iplt
      isup1 = 1
      app(1) = 1.
      iopt = 0
      npp = npp + 2
      nn = npp
      i01 = 0
      i12 = 1
      nipp = 1
      nptth = 2
      if ( fac ) then
        eql = .true.
        npp = npp + 1
        if ( acat /= 0. ) then
          iopt = 1
        elseif ( ma /= 0. ) then
          iopt = 2
        else
          write (ioout,99001)
          tt = 0.
          goto 1400
        endif
        i01 = 1
        i12 = 2
        nipp = 2
        nptth = 3
        do i = nsub,1, - 1
          subar(i+1) = subar(i)
        enddo
        nsub = nsub + 1
        if ( iopt /= 1 ) then
          if ( acat == 0. ) acat = 2.
        endif
        subar(1) = acat
      elseif ( .not.eql.and.nfz > 1.and.nsub > 0 ) then
        nsub = 0
        write (ioout,99023)
      endif
      nn = nn + nsub + nsup
      if ( nfz > 2.and.nn > ncol-2 ) then
        write (ioout,99002) ncol - 2
        nfz = 1
        froz = .false.
      endif
      seql = eql
      iof = 0
      tt = tcest
      pp = p(1)
      app(i12) = 1.
 100  it = 1
      iof = iof + 1
      oxfl = oxf(iof)
      if ( t(1) /= 0. ) then
        tp = .true.
      else
        hp = .true.
      endif
      sp = .false.
      call newof(short,oxfl,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,wmix,npt,size,hsub0,hpp,jsol,jliq,vol,jcm,prod)
      if ( t(1) /= 0. ) tt = t(1)
 200  do ip = 1,np
        itnum = 0
        area = .false.
        if ( t(1) == 0. ) hp = .true.
        if ( t(1) /= 0. ) tp = .true.
        sp = .false.
        eql = .true.
        isub = 1
        isup = 1
        pp = p(ip)
        pinf = pp
        ipp = 1
        itrot = 3
        isupsv = 1
        niter = 1
        page1 = .true.
        iplt1 = iplte
        iplt = iplte
        done = .false.
 250    nar = npt
        if ( eql ) then
          call eqlbrm(nlm,size,trace,ngc,pderiv,convg,tp,tt,npr,t,jcond,ng,ifz,temp,en,npt,prod,short,nc,enln,deln,tln,vol,pp,enn,rr,vv,tm,lsave,a,ions,shock,elmt,debug,cpsum,cp,iq1,imat,g,msing,x,h0,mu,ennl,s,totn,sumn,hp,b0,bcheck,dlvtp,cpr,dlvpt,jliq,gammas,jsol,hsum,ssum,sp,s0,tg,ngp1,mw,jx,jcm,b0p,nspx,atwt,ttt,ppp,vlm,wm,gonly,coef,cft,hsub0)
          if ( npt == nfz ) cprf = cpsum
        else
          call frozen(convg,tln,tt,pp,wm,npt,nfz,ng,en,deln,ssum,cpsum,cp,s,npr,jcond,hsum,ngc,h0,ttt,gammas,vlm,rr,dlvpt,dlvtp,totn,ppp,cpr,tg,ngp1,temp,coef,tp,cft,nc)
        endif
        if ( tt /= 0. ) then
          if ( .not.fac ) goto 400
          pinjas = p(ip)*pa
          pinj = pinjas
          if ( npt <= 2 ) then
            call tranp(nm,confro,npt,vis,eta,wmol,xs,con,eql,nr,lsave,jcm,h0,stc,ind,g,imat,r,x,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,shock,incdeq,nreac,jray,mw,en,wm,ngc,enln,ennl,ng,nfz,a,ntape,tt,tln,ions,boltz,avgdr,pi,rr,cp,nlm,viscns,msing)
            if ( npt == 2 ) pinf = ppp(2)
          endif
          if ( npt /= 1 ) goto 400
          do i = 1,4
            prat = (b1+c1*acat)/(1.+a1l*acat)
            ppa = pinj*prat
            if ( iopt == 1 ) goto 260
            acat = ppa/(ma*2350.)
            if ( acat >= 1. ) then
              pratsv = prat
              if ( debugf ) then
                if ( i <= 1 ) write (ioout,99004)
                write (ioout,99005) i,ppa,acat
              endif
            else
              write (ioout,99003) ma
              tt = 0.
              goto 1400
            endif
          enddo
          subar(1) = acat
 260      pp = ppa/pa
          app(1) = pp/ppp(1)
          goto 1100
        else
          if ( npt < 1 ) goto 1400
          if ( .not.area ) goto 600
          npt = nar - 1
          isup = nsup + 2
          isv = 0
          itnum = 0
          goto 950
        endif
 300    hp = .true.
        sp = .false.
        niter = niter + 1
        isv = 0
        npt = 2
        ipp = 2
        call seten(isv,ttt,ensave,enn,enlsav,ennl,lsave,ng,sln,enln,en,npt,npr,ngp1,ngc,jliq,jsol,tt,jcond,tp,sumn)
        goto 250
 350    done = .true.
        app(1) = ppp(2)/ppp(1)
        area = .false.
        if ( nsub > 1 ) isub = 2
        isv = 4
        npt = 2
        ipp = min(4,npp)
        call seten(isv,ttt,ensave,enn,enlsav,ennl,lsave,ng,sln,enln,en,npt,npr,ngp1,ngc,jliq,jsol,tt,jcond,tp,sumn)
        cpr(2) = cpr(4)
        dlvpt(2) = dlvpt(4)
        dlvtp(2) = dlvtp(4)
        gammas(2) = gammas(4)
        hsum(2) = hsum(4)
        ppp(2) = ppp(4)
        app(2) = ppp(1)/pinf
        ssum(2) = ssum(4)
        totn(2) = totn(4)
        ttt(2) = ttt(4)
        vlm(2) = vlm(4)
        wm(2) = wm(4)
        if ( .not.short ) write (ioout,99009)
        goto 600
 400    if ( ipp > nipp ) then
          usq = 2.*(hsum(1)-hsum(npt))*rr
          if ( ipp > nptth ) goto 600
          if ( .not.thi ) then
            vv = vlm(nptth)
            pvg = pp*vv*gammas(nptth)
            if ( pvg == 0. ) then
              write (ioout,99010)
              goto 550
            else
              msq = usq/pvg
              if ( debug(1).or.debug(2) ) write (ioout,99011) usq,pvg
              dh = dabs(msq-1.d0)
              if ( dh <= 0.4d-4 ) goto 550
              if ( itrot > 0 ) then
                p1 = pp
                if ( jsol /= 0 ) then
                  tmelt = tt
                  pp = pp*(1.d0+msq*gammas(nptth))/(gammas(nptth)+1.d0)
                elseif ( tmelt == 0. ) then
                  pp = pp*(1.d0+msq*gammas(nptth))/(gammas(nptth)+1.d0)
                else
                  write (ioout,99012)
                  dlt = dlog(tmelt/tt)
                  dd = dlt*cpr(nptth)/(enn*dlvtp(nptth))
                  pp = pp*exp(dd)
                  app(nptth) = p(ip)/pp
                  if ( fac ) app(nptth) = pinf/pp
                  if ( eql.and..not.short ) write (ioout,99013)                             app(nptth)
                  thi = .true.
                  goto 250
                endif
                goto 500
              elseif ( itrot < 0 ) then
                if ( itrot < -19 ) then
                  write (ioout,99010)
                  goto 550
                else
                  if ( npr /= npr1 ) goto 550
                  pp = pp - dp
                  goto 500
                endif
              elseif ( npr == npr1 ) then
                write (ioout,99010)
                goto 550
              else
                dp = dabs(pp-p1)/20.
                pp = dmax1(pp,p1)
                write (ioout,99012)
                pp = pp - dp
                goto 500
              endif
            endif
          else
            gammas(nptth) = 0.
            goto 550
          endif
        else
          call tranp(nm,confro,npt,vis,eta,wmol,xs,con,eql,nr,lsave,jcm,h0,stc,ind,g,imat,r,x,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,shock,incdeq,nreac,jray,mw,en,wm,ngc,enln,ennl,ng,nfz,a,ntape,tt,tln,ions,boltz,avgdr,pi,rr,cp,nlm,viscns,msing)
          if ( npt == nfz ) eql = seql
          tp = .false.
          hp = .false.
          sp = .true.
          s0 = ssum(i12)
        endif
 450    tmelt = 0.
        itrot = 3
        thi = .false.
        app(nptth) = ((gammas(i12)+1.)/2.)               **(gammas(i12)/(gammas(i12)-1.))
        if ( eql.and..not.short ) write (ioout,99013) app(nptth)
        pp = pinf/app(nptth)
        isv = -i12
        goto 1200
 500    npr1 = npr
        app(nptth) = p(ip)/pp
        if ( fac ) app(nptth) = pinf/pp
        if ( eql.and..not.short ) write (ioout,99013) app(nptth)
        itrot = itrot - 1
        goto 250
 550    awt = enn*tt/(pp*usq**.5)
        pcplt = dlog(app(nptth))
 600    isv = 0
        aeat(npt) = enn*ttt(npt)/(pp*usq**.5*awt)
        if ( tt == 0. ) goto 1150
        if ( area ) goto 750
        call tranp(nm,confro,npt,vis,eta,wmol,xs,con,eql,nr,lsave,jcm,h0,stc,ind,g,imat,r,x,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,shock,incdeq,nreac,jray,mw,en,wm,ngc,enln,ennl,ng,nfz,a,ntape,tt,tln,ions,boltz,avgdr,pi,rr,cp,nlm,viscns,msing)
        if ( npt == nfz ) eql = seql
        if ( fac ) then
          if ( npt == nptth ) then
            area = .true.
            goto 750
          elseif ( npt == 2.and.done ) then
            npt = 3
            if ( ipp < npp.or.npp == 4 ) ipp = ipp - 1
          endif
        endif
 650    if ( ipp < npp ) goto 1100
 700    if ( nsub == i01.and.nsup == 0 ) goto 1150
        area = .true.
 750    if ( itnum == 0 ) then
          dlnp = 1.
          itnum = 1
          aratio = subar(isub)
          if ( (.not.fac.or.done).and.nsub <= i01 ) aratio = supar(isup)
          if ( .not.eql.and.nfz >= 3 ) then
            if ( aratio <= aeat(nfz) ) then
              write (ioout,99014) nfz
              goto 1050
            endif
          endif
          if (aratio  <  1.d0 ) then
            write (ioout,99025) 
            goto 1050
          endif
          eln = dlog(aratio)
          if ( fac ) then
            if ( .not.done ) goto 800
          endif
          if ( nsub <= i01 ) then
            if ( nfz == ipp ) isupsv = isup
            if ( supar(isup) < 2. ) then
              appl = dsqrt(eln*(1.535d0+3.294d0*eln)) + pcplt
              goto 1100
            else
              if ( isup > isup1.and.supar(isup-1) >= 2. ) goto 850
              appl = gammas(nptth) + eln*1.4
              goto 1100
            endif
          endif
        elseif ( gammas(npt) > 0. ) then
          check = .00004
          if ( debug(npt) ) write (ioout,99016) itnum,aratio,aeat(npt),                             app(npt),dlnp
          if ( dabs(aeat(npt)-aratio)/aratio <= check ) goto 900
          if ( abs(dlnp) < .00004 ) goto 900
          aeatl = dlog(aeat(npt))
          itnum = itnum + 1
          if ( itnum > 10 ) then
            write (ioout,99017) aratio
            goto 900
          else
            asq = gammas(npt)*enn*rr*tt
            dlnpe = gammas(npt)*usq/(usq-asq)
            goto 850
          endif
        else
          write (ioout,99015)
          npt = npt - 1
          if ( nsub <= 0 ) isup1 = 100
          if ( nsub < 0. ) nsup = isup - 1
          if ( nsub > 0 ) nsub = isub - 1
          goto 1000
        endif
 800    appl = pcplt/(subar(isub)+(10.587*eln**2+9.454)*eln)
        if ( aratio < 1.09 ) appl = .9*appl
        if ( aratio > 10. ) appl = appl/aratio
        if ( isub > 1.or.npt == ncol ) goto 1100
        goto 1200
 850    dlnp = dlnpe*eln - dlnpe*aeatl
        appl = appl + dlnp
        if ( itnum == 1 ) goto 1100
        if ( appl < 0. ) appl = .000001
        app(npt) = exp(appl)
        pp = pinf/app(npt)
        goto 250
 900    aeat(npt) = aratio
        if ( fac ) then
          if ( .not.done ) then
            if ( iopt == 1 ) then
              area = .false.
              itnum = 0
              ppa = ppp(npt)*pa
              pinj = ppa + 1.d05*usq/vlm(npt)
              test = (pinj-pinjas)/pinjas
              pcpa = pinf*pa
              if ( debugf ) then
                write (ioout,99006)
                write (ioout,99007) niter,test,pinjas,pinj,pcpa,ppa,                          acatsv,acat
              endif
              if ( abs(test) < 0.00002 ) goto 350
              prat = pinjas/pinj
              pp = pinf*prat
              goto 300
            elseif ( iopt == 2 ) then
              acatsv = acat
              pratsv = prat
              area = .false.
              itnum = 0
              ppa = ppp(4)*pa
              pinj = ppa + 1.d05*usq/vlm(4)
              mat = pa/(awt*rr)
              acat = mat/ma
              prat = (b1+c1*acat)/(1.+a1l*acat)
              test = (pinj-pinjas)/pinjas
              pcpa = pinf*pa
              if ( debugf ) then
                write (ioout,99006)
                write (ioout,99007) niter,test,pinjas,pinj,pcpa,ppa,                          acatsv,acat
              endif
              if ( abs(test) < 0.00002 ) goto 350
              pjrat = pinj/pinjas
              pp = pinf
              do i = 1,2
                pracat = pratsv/prat
                pr = pjrat*pracat
                pp = pp/pr
                pcpa = pp*pa
                acat = acat/pr
                subar(1) = acat
                pratsv = prat
                pjrat = 1.
                prat = (b1+c1*acat)/(1.+a1l*acat)
                if ( debugf ) write (ioout,99008) pcpa,acat,pjrat,pracat
              enddo
              goto 300
            endif
          endif
        endif
 950 call tranp(nm,confro,npt,vis,eta,wmol,xs,con,eql,nr,lsave,jcm,h0,stc,ind,g,imat,r,x,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,shock,incdeq,nreac,jray,mw,en,wm,ngc,enln,ennl,ng,nfz,a,ntape,tt,tln,ions,boltz,avgdr,pi,rr,cp,nlm,viscns,msing)
        if ( npt == nfz ) eql = seql
 1000   itnum = 0
        if ( nsub > i01 ) then
          isub = isub + 1
          if ( isub <= nsub ) goto 750
          isub = 1
          nsub = -nsub
          if ( isup <= nsup ) goto 750
          area = .false.
          goto 1150
        endif
 1050   isup = isup + 1
        itnum = 0
        if ( isup <= nsup ) goto 750
        isup = isupsv
        area = .false.
        goto 1150
 1100   isv = npt
        if ( npt /= ncol ) goto 1200
 1150   if ( .not.eql ) then
          if ( nfz <= 1 ) then
            cpr(nfz) = cprf
            gammas(nfz) = cprf/(cprf-1./wm(nfz))
          endif
        endif
        call rktout(eql,nfz,iopt,it,t,ttt,ppp,app,subar,ma,fmt,npt,page1,x,nplt,pltvar,siunit,spim,hsum,rr,wm,cstr,vmoc,sonvel,gammas,trnspt,aeat,pltout,iplt,massf,totn,trace,ngc,mw,en,prod,case,moles,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,rkt,gonly,vlm,ssum,cpr,dlvtp,dlvpt,ng,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
        iplt = iplt + npt
        if ( .not.page1 ) then
          iplt = iplt - 2
          if ( iopt /= 0 ) iplt = iplt - 1
          iplt = min(iplt,500)
        else
          page1 = .false.
        endif
        iplte = max(iplte,iplt)
        dlnp = 1.
        if ( tt == 0. ) area = .false.
        if ( .not.eql.and.tt == 0. ) write (ioout,99018)
        if ( isv == 0 ) then
          if ( nsub < 0 ) nsub = -nsub
          if ( .not.froz.or..not.eql ) goto 1300
          if ( eql ) iplt = iplt1
          eql = .false.
          page1 = .true.
          call seten(isv,ttt,ensave,enn,enlsav,ennl,lsave,ng,sln,enln,en,npt,npr,ngp1,ngc,jliq,jsol,tt,jcond,tp,sumn)
          tt = ttt(nfz)
          ipp = nfz
          if ( nfz == npt ) goto 1150
          npt = nfz
          enn = 1./wm(nfz)
          if ( nfz == 1 ) goto 450
          if ( nsub > 0 ) then
            nsub = -nsub
            write (ioout,99023)
          endif
          if ( app(nfz) < app(nptth) ) then
            write (ioout,99024)
          else
            if ( nfz < npp ) goto 1200
            goto 700
          endif
          goto 1300
        else
          if ( eql ) write (ioout,99019)
          npt = nptth
        endif
 1200   npt = npt + 1
        if ( eql.or.(isv == -i12.and..not.seql) ) then
          if ( jliq /= 0.and.isv > 0 ) isv = 0
          call seten(isv,ttt,ensave,enn,enlsav,ennl,lsave,ng,sln,enln,en,npt,npr,ngp1,ngc,jliq,jsol,tt,jcond,tp,sumn)
        endif
 1250   ipp = ipp + 1
        if ( npt > nptth ) then
          if ( area ) then
            app(npt) = exp(appl)
          else
            app(npt) = pcp(ipp-nptth)
            if ( fac ) app(npt) = app(npt)*pinf/ppp(1)
            if ( .not.eql.and.app(npt) < app(nfz) ) then
              write (ioout,99020) nfz
              goto 1250
            endif
          endif
          pp = pinf/app(npt)
          if ( fac ) then
            if ( area ) then
              if ( isub <= nsub.and.isub > i01.and.aratio >= aeat(2) )             then
                write (ioout,99021) aratio,aeat(2)
                npt = npt - 1
                goto 1000
              endif
            elseif ( npt > nptth.and.pcp(ipp-3) < ppp(1)/ppp(2) ) then
              write (ioout,99022) pcp(ipp-3),ppp(1)/ppp(2)
              npt = npt - 1
              goto 650
            endif
          endif
        endif
        goto 250
 1300   npt = 1
        if ( ip == np.and.it == nt.and.iof == nof ) goto 1400
        write (ioout,99019)
        call seten(isv,ttt,ensave,enn,enlsav,ennl,lsave,ng,sln,enln,en,npt,npr,ngp1,ngc,jliq,jsol,tt,jcond,tp,sumn)
        tt = ttt(i12)
      enddo
      if ( it < nt ) then
        it = it + 1
        tt = t(it)
        goto 200
      elseif ( iof < nof ) then
        goto 100
      endif
 1400 iplt = max(iplt,iplte)
      return
99001 format (/' FATAL ERROR!! EITHER mdot OR ac/at MISSING ',        'FOR fac PROBLEM (ROCKET)')
99002 format (/' WARNING!!  nfz NOT ALLOWED TO BE > 2 IF THE TOTAL',/,        ' NUMBER OF POINTS IS >',i3,' (ROCKET)')
99003 format (/' INPUT VALUE OF mdot/a =',f12.3,' IS TOO LARGE.'/        ' GIVES CONTRACTION RATIO ESTIMATE LESS THAN 1 (ROCKET)')
99004 format (/'  ITERATION',9x,'PC',7x,'CONTRACTION RATIO')
99005 format (5x,i2,7x,f12.2,3x,f12.6)
99006 format (' ITER',3x,'TEST',3x,'ASSIGNED PINJ',1x,'CALC PINJ',5x,        'PC',7x,'P AT ACAT',3x,'PREV ACAT',2x,'ACAT')
99007 format (i3,f10.6,1x,4f12.2,2f9.5)
99008 format (' NEW PC = ',f10.2,2x,'NEW ACAT = ',f9.6,2x,'PJRAT =',        f10.7,' PRACAT =',f10.7)
99009 format (' END OF CHAMBER ITERATIONS')
99010 format (/' WARNING!!  DIFFICULTY IN LOCATING THROAT (ROCKET)')
99011 format (/' USQ=',e15.8,5x,'PVG=',e15.8)
99012 format (/' WARNING!!  DISCONTINUITY AT THE THROAT (ROCKET)')
99013 format (' Pinf/Pt =',f9.6)
99014 format (/,' WARNING!! FOR FROZEN PERFORMANCE, POINTS WERE OMITTED'        ,' WHERE THE ASSIGNED',/,' SUPERSONIC AREA RATIOS WERE ',        'LESS THAN THE VALUE AT POINT nfz =',i3,' (ROCKET)')
99015 format (/' WARNING!!  AREA RATIO CALCULATION CANNOT BE DONE ',        'BECAUSE GAMMAs',/,' CALCULATION IMPOSSIBLE. (ROCKET)')
99016 format (/' ITER=',i2,2x,'ASSIGNED AE/AT=',f14.7,3x,'AE/AT=',f14.7,        /,2x,'PC/P=',f14.7,2x,'DELTA LN PCP=',f14.7)
99017 format (/' WARNING!!  DID NOT CONVERGE FOR AREA RATIO =',f10.5,        ' (ROCKET)')
99018 format (/' WARNING!!  CALCULATIONS WERE STOPPED BECAUSE NEXT ',        'POINT IS MORE',/,' THAN 50 K BELOW THE TEMPERATURE',        ' RANGE OF A CONDENSED SPECIES (ROCKET)')
99019 format (////)
99020 format (/,' WARNING!! FOR FROZEN PERFORMANCE, POINTS WERE OMITTED'        ,' WHERE THE ASSIGNED',/,        ' PRESSURE RATIOS WERE LESS THAN ',        'THE VALUE AT POINT nfz =',i3,' (ROCKET)')
99021 format (/' WARNING!!  ASSIGNED subae/at =',f10.5,' IS NOT ',        'PERMITTED TO BE GREATER'/' THAN ac/at =',f9.5,        '.  POINT OMITTED (ROCKET)')
99022 format (/' WARNING!!  ASSIGNED pip =',f10.5,        ' IS NOT PERMITTED'/' TO BE LESS THAN  Pinj/Pc =',f9.5,        '. POINT OMITTED',' (ROCKET)')
99023 format (/' WARNING!!  FOR FROZEN PERFORMANCE, SUBSONIC AREA ',/,       ' RATIOS WERE OMITTED SINCE nfz IS GREATER THAN 1 (ROCKET)'       )
99024 format (/' WARNING!!  FREEZING IS NOT ALLOWED AT A SUBSONIC ',        'PRESSURE RATIO FOR nfz GREATER'/' THAN 1. FROZEN ',        'PERFORMANCE CALCULATIONS WERE OMITTED (ROCKET)')
99025 format (/' AN ASSIGNED AREA RATIO IS < 1 (ROCKET)' )
      end subroutine rocket
      subroutine search(nc,nlm,jx,s,h0,deln,a,tg,thdate,ngc,cft,ifz,mw,temp,nonly,prod,nomit,omit,elmt,ng,coef,jcm,ngp1,nspx,symbol,atmwt,atwt,cp,short,ntape)
      use params_cea_inc, only : iotrn, iosch, maxnc, iothm, maxel, maxngc, maxng, ioout
      implicit none
      integer :: nc
      integer :: nlm
      integer, dimension(1:maxel) :: jx
      real(kind=8), dimension(1:maxngc) :: s
      real(kind=8), dimension(1:maxngc) :: h0
      real(kind=8), dimension(1:maxngc) :: deln
      real(kind=8), dimension(1:maxel,1:maxngc) :: a
      real(kind=8), dimension(1:4) :: tg
      character(len=10) :: thdate
      integer :: ngc
      real(kind=8), dimension(1:maxnc,1:9) :: cft
      integer, dimension(1:maxnc) :: ifz
      real(kind=8), dimension(1:maxngc) :: mw
      real(kind=8), dimension(1:2,1:maxnc) :: temp
      integer :: nonly
      character(len=15), dimension(0:maxngc) :: prod
      integer :: nomit
      character(len=15), dimension(0:maxngc) :: omit
      character(len=2), dimension(1:maxel) :: elmt
      integer :: ng
      real(kind=8), dimension(1:maxng,1:9,1:3) :: coef
      integer, dimension(1:maxel) :: jcm
      integer :: ngp1
      integer :: nspx
      character(len=2), dimension(1:100) :: symbol
      real(kind=8), dimension(1:100) :: atmwt
      real(kind=8), dimension(1:maxel) :: atwt
      real(kind=8), dimension(1:maxngc) :: cp
      logical :: short
      integer :: ntape
      character(len=16), dimension(1:2,1:40) :: bin
      character(len=16), dimension(1:6) :: pure
      character(len=16), dimension(1:2) :: spece
      character(len=6), dimension(1:maxngc) :: date
      character(len=2), dimension(1:5) :: el
      character(len=15) :: sub
      integer :: i
      integer :: i5
      integer :: ifaz
      integer :: ii
      integer :: ir
      integer :: itot
      integer :: j
      integer, dimension(1:2) :: jj
      integer :: jk
      integer :: k
      integer :: lineb
      integer :: nall
      integer :: ne
      integer :: nint
      integer :: npure
      integer :: nrec
      integer :: ntgas
      integer :: ntot
      real(kind=8), dimension(1:5) :: b
      real(kind=8) :: t1
      real(kind=8) :: t2
      real(kind=8), dimension(1:9,1:3) :: thermo
      real(kind=8), dimension(1:36) :: trdata
      save b,bin,date,el,i,i5,ifaz,ii,ir,itot,j,jj,jk,k,lineb,nall,ne,  nint,npure,nrec,ntgas,ntot,pure,spece,sub,t1,t2,thermo,trdata
      nc = 0
      ne = 0
      do i = 1,nlm
        jx(i) = 0
      enddo
      do j = 1,maxngc
        s(j) = 0.
        h0(j) = 0.
        deln(j) = 0.
        do i = 1,nlm
          a(i,j) = 0.
        enddo
      enddo
      rewind iothm
      read (iothm) tg,ntgas,ntot,nall,thdate
      ngc = 1
      nc = 1
      do itot = 1,ntot
        if ( itot > ntgas ) then
          read (iothm) sub,nint,date(ngc),(el(j),b(j),j=1,5),ifz(nc),                 temp(1,nc),temp(2,nc),mw(ngc),(cft(nc,k),k=1,9)
        else
          read (iothm) sub,nint,date(ngc),(el(j),b(j),j=1,5),ifaz,t1,t2,                 mw(ngc),thermo
        endif
        if ( nonly /= 0 ) then
          i = 1
 20       if ( prod(i) /= sub.and.'*'//prod(i) /= sub ) then
            i = i + 1
            if ( i <= nonly ) goto 20
            goto 200
          else
            if ( sub == prod(ngc-1) ) then
              nonly = nonly + 1
              do k = nonly,i + 1, - 1
                prod(k) = prod(k-1)
              enddo
            else
              prod(i) = prod(ngc)
            endif
            prod(ngc) = sub
          endif
        elseif ( nomit /= 0 ) then
          do i = 1,nomit
            if ( omit(i) == sub.or.'*'//omit(i) == sub ) goto 200
          enddo
        endif
        do k = 1,5
          if ( b(k) == 0. ) goto 100
          do i = 1,nlm
            if ( elmt(i) == el(k) ) then
              a(i,ngc) = b(k)
              goto 50
            endif
          enddo
          do j = 1,nlm
            a(j,ngc) = 0.
          enddo
          goto 200
 50     continue
      end do
 100    prod(ngc) = sub
        if ( itot > ntgas ) then
          nc = nc + 1
          if ( nc > maxnc ) goto 400
        else
          ng = ngc
          if ( ng > maxng ) goto 400
          do i = 1,3
            do j = 1,9
              coef(ng,j,i) = thermo(j,i)
            enddo
          enddo
          if ( b(2) == 0..and.b(1) == 1. ) then
            do i = 1,nlm
              if ( elmt(i) == el(1) ) then
                ne = ne + 1
                jx(i) = ngc
                jcm(i) = ngc
                goto 150
              endif
            enddo
          endif
        endif
 150    ngc = ngc + 1
        if ( ngc > maxngc ) goto 400
 200  continue
      end do
      ifz(nc) = 0
      nc = nc - 1
      ngc = ngc - 1
      ngp1 = ng + 1
      if ( ngc < nonly ) then
        do k = ngc + 1,nonly
          write (ioout,99001) prod(k)
        enddo
      endif
      nspx = ngc
      if ( ne < nlm ) then
        do i = 1,nlm
          if ( nspx > maxngc ) goto 400
          if ( jx(i) == 0 ) then
            nspx = nspx + 1
            do k = 1,nlm
              a(k,nspx) = 0.
            enddo
            a(i,nspx) = 1.
            prod(nspx) = elmt(i)
            do k = 1,100
              if ( elmt(i) == symbol(k) ) then
                mw(nspx) = atmwt(k)
                atwt(i) = atmwt(k)
                cp(nspx) = 2.5d0
                goto 210
              endif
            enddo
 210        jx(i) = nspx
            jcm(i) = nspx
          endif
        enddo
      endif
      do i = 1,nlm
        do j = 1,ngc
          if ( a(i,j) /= 0. ) goto 300
          ii = i
        enddo
        write (ioout,99002) elmt(ii)
        ngc = 0
        goto 600
 300  continue
      end do
      if ( .not.short ) then
        write (ioout,99003) thdate
        do i = 1,ngc,3
          i5 = i + 2
          if ( ngc < i5 ) i5 = ngc
          write (ioout,99004) (date(j),prod(j),j=i,i5)
        enddo
      endif
      goto 600
 400  write (ioout,99005)
      ngc = 0
      goto 600
      entry readtr(nc,nlm,jx,s,h0,deln,a,tg,thdate,ngc,cft,ifz,mw,temp,nonly,prod,nomit,omit,elmt,ng,coef,jcm,ngp1,nspx,symbol,atmwt,atwt,cp,short,ntape)
      rewind iotrn
      rewind iosch
      ntape = 0
      npure = 0
      lineb = 1
      if ( .not.short ) write (ioout,99006)
      read (iotrn) nrec
      do ir = 1,nrec
        read (iotrn) spece,trdata
        k = 1
 450    do j = 1,ng
          if ( spece(k) == prod(j).or.'*'//spece(k) == prod(j) ) then
            jj(k) = j
            if ( k == 2 ) then
              do k = 1,2
                bin(k,lineb) = spece(k)
              enddo
              lineb = lineb + 1
              goto 500
            else
              jj(2) = j
              if ( spece(2) == ' ' ) then
                npure = npure + 1
                pure(npure) = spece(1)
                goto 500
              else
                k = 2
                goto 450
              endif
            endif
          endif
        enddo
        goto 550
 500    write (iosch) jj,trdata
        ntape = ntape + 1
 550    if ( npure /= 0.and.(npure >= 6.or.ir >= nrec) ) then
          if ( .not.short ) write (ioout,99007) (pure(jk),jk=1,npure)
          npure = 0
        endif
      enddo
      lineb = lineb - 1
      if ( .not.short ) then
        write (ioout,99008)
        do j = 1,lineb
          write (ioout,99009) (bin(i,j),i=1,2)
        enddo
      endif
      write (ioout,99010)
 600  return
99001 format (/' WARNING!!  ',a15,' NOT A PRODUCT IN thermo.lib FILE ',        '(SEARCH)')
99002 format (/' PRODUCT SPECIES CONTAINING THE ELEMENT',a3,' MISSING',        //,13x,'FATAL ERROR (SEARCH)')
99003 format (/2x,'SPECIES BEING CONSIDERED IN THIS SYSTEM',        /' (CONDENSED PHASE MAY HAVE NAME LISTED SEVERAL TIMES)',        /'  LAST thermo.inp UPDATE: ',a10,/)
99004 format (3(2x,a6,2x,a15))
99005 format (/' INSUFFICIENT STORAGE FOR PRODUCTS-SEE RP-1311,',        /'   PART 2, PAGE 39. (SEARCH)')
99006 format (/' SPECIES WITH TRANSPORT PROPERTIES'//8x,'PURE SPECIES'/)
99007 format (4(2x,a16))
99008 format (/'     BINARY INTERACTIONS'/)
99009 format (5x,2a16)
99010 format ()
      end subroutine search
      subroutine seten(isv,ttt,ensave,enn,enlsav,ennl,lsave,ng,sln,enln,en,npt,npr,ngp1,ngc,jliq,jsol,tt,jcond,tp,sumn)
      use params_cea_inc, only : maxngc, ncol
      implicit none
      integer, intent(InOut) :: isv
      real(kind=8), dimension(1:ncol), intent(In) :: ttt
      real(kind=8), intent(InOut) :: ensave
      real(kind=8), intent(InOut) :: enn
      real(kind=8), intent(InOut) :: enlsav
      real(kind=8), intent(InOut) :: ennl
      integer, intent(InOut) :: lsave
      integer, intent(In) :: ng
      real(kind=8), dimension(1:maxngc), intent(InOut) :: sln
      real(kind=8), dimension(1:maxngc), intent(InOut) :: enln
      real(kind=8), dimension(1:maxngc,1:ncol), intent(InOut) :: en
      integer, intent(In) :: npt
      integer, intent(InOut) :: npr
      integer, intent(In) :: ngp1
      integer, intent(In) :: ngc
      integer, intent(InOut) :: jliq
      integer, intent(InOut) :: jsol
      real(kind=8), intent(Out) :: tt
      integer, dimension(1:45), intent(Out) :: jcond
      logical, intent(In) :: tp
      real(kind=8), intent(Out) :: sumn
      real :: d0
      integer :: j
      integer :: lsav
      real(kind=8) :: tsave
      real(kind=8) :: dexp
      save j,lsav,tsave
      if ( isv < 0 ) then
        isv = -isv
        tsave = ttt(isv)
        ensave = enn
        enlsav = ennl
        lsav = lsave
        do j = 1,ng
          sln(j) = enln(j)
        enddo
        do j = 1,ng
          en(j,npt) = en(j,isv)
        enddo
        npr = 0
        do j = ngp1,ngc
          sln(j) = en(j,isv)
          en(j,npt) = sln(j)
          if ( jliq == j ) then
            en(jsol,npt) = en(jsol,isv) + en(jliq,isv)
            en(jliq,npt) = 0.
            jsol = 0
            jliq = 0
            tsave = tsave - 5.
            tt = tsave
            sln(j) = 0.
          elseif ( en(j,npt) > 0. ) then
            npr = npr + 1
            jcond(npr) = j
          endif
        enddo
      elseif ( isv == 0 ) then
        jsol = 0
        jliq = 0
        enn = ensave
        ennl = enlsav
        lsave = lsav
        npr = 0
        do j = ngp1,ngc
          en(j,npt) = sln(j)
          if ( en(j,npt) > 0.d0 ) then
            npr = npr + 1
            jcond(npr) = j
          endif
        enddo
        do j = 1,ng
          en(j,npt) = 0.
          enln(j) = sln(j)
          if ( sln(j) /= 0. ) then
            if ( (enln(j)-ennl+18.5) > 0. ) en(j,npt) = dexp(enln(j))
          endif
        enddo
        if ( .not.tp ) tt = tsave
        sumn = enn
      elseif ( isv > 0 ) then
        do j = 1,ngc
          en(j,npt) = en(j,isv)
        enddo
      endif
      end subroutine seten
      subroutine shck(trace,tp,cpmix,short,incdeq,incdfz,refleq,reflfz,t,rtemp,nsk,u1,mach1,oxfl,oxf,pp,p,tt,dlvtp,dlvpt,npt,ppp,ttt,ssum,hsum,tg,hsub0,gamma1,wmix,a1,rr,wm,cpr,gammas,vlm,eql,fmt,hp,shkdbg,tln,cpsum,ng,en,h0,g,x,ngc,s,trnspt,isv,massf,nreac,jray,mw,prod,iplt,nof,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,size,hpp,jsol,jliq,vol,jcm,tm,nspr,nspx,fox,rname,nfla,ratom,rnum,coef,energy,moles,pecwt,wp,rmw,cp,case,siunit,enth,r,rh,page1,rkt,iopt,nplt,pltvar,gonly,pltout,totn,sonvel,omit,vis,coneql,preql,confro,prfro,cpeql,cpfro,pderiv,convg,npr,jcond,ifz,temp,nc,enln,deln,enn,vv,lsave,a,ions,shock,elmt,debug,iq1,imat,msing,mu,ennl,sumn,sp,s0,ngp1,jx,atwt,cft,nm,eta,wmol,xs,con,nr,stc,ind,cprr,nfz,ntape,boltz,avgdr,pi,viscns,ensave,enlsav,sln)
      use params_cea_inc, only : maxtr, maxt, maxmat, maxpv, ioout, maxngc, maxel, maxnc, maxr, maxng, ncol, maxmix
      implicit none
      real(kind=8), intent(InOut) :: trace
      logical, intent(Out) :: tp
      real(kind=8), intent(InOut) :: cpmix
      logical, intent(In) :: short
      logical, intent(InOut) :: incdeq
      logical, intent(In) :: incdfz
      logical, intent(In) :: refleq
      logical, intent(In) :: reflfz
      real(kind=8), dimension(1:maxt), intent(InOut) :: t
      real(kind=8), dimension(1:maxr), intent(InOut) :: rtemp
      integer, intent(InOut) :: nsk
      real(kind=8), dimension(1:ncol), intent(InOut) :: u1
      real(kind=8), dimension(1:ncol), intent(InOut) :: mach1
      real(kind=8), intent(Out) :: oxfl
      real(kind=8), dimension(1:maxmix), intent(In) :: oxf
      real(kind=8), intent(InOut) :: pp
      real(kind=8), dimension(1:maxpv), intent(In) :: p
      real(kind=8), intent(InOut) :: tt
      real(kind=8), dimension(1:ncol), intent(InOut) :: dlvtp
      real(kind=8), dimension(1:ncol), intent(InOut) :: dlvpt
      integer, intent(InOut) :: npt
      real(kind=8), dimension(1:ncol), intent(InOut) :: ppp
      real(kind=8), dimension(1:ncol), intent(InOut) :: ttt
      real(kind=8), dimension(1:ncol), intent(InOut) :: ssum
      real(kind=8), dimension(1:ncol), intent(InOut) :: hsum
      real(kind=8), dimension(1:4), intent(In) :: tg
      real(kind=8), intent(InOut) :: hsub0
      real(kind=8), intent(InOut) :: gamma1
      real(kind=8), intent(InOut) :: wmix
      real(kind=8), intent(InOut) :: a1
      real(kind=8), intent(In) :: rr
      real(kind=8), dimension(1:ncol), intent(InOut) :: wm
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpr
      real(kind=8), dimension(1:ncol), intent(InOut) :: gammas
      real(kind=8), dimension(1:ncol), intent(Out) :: vlm
      logical, intent(InOut) :: eql
      character(len=4), dimension(1:30) :: fmt
      logical, intent(Out) :: hp
      logical, intent(In) :: shkdbg
      real(kind=8), intent(InOut) :: tln
      real(kind=8), intent(InOut) :: cpsum
      integer, intent(InOut) :: ng
      real(kind=8), dimension(1:maxngc,1:ncol), intent(InOut) :: en
      real(kind=8), dimension(1:maxngc), intent(InOut) :: h0
      real(kind=8), dimension(1:maxmat,1:maxmat+1), intent(InOut) :: g
      real(kind=8), dimension(1:maxmat), intent(InOut) :: x
      integer, intent(In) :: ngc
      real(kind=8), dimension(1:maxngc), intent(InOut) :: s
      logical, intent(In) :: trnspt
      integer, intent(Out) :: isv
      logical, intent(In) :: massf
      integer, intent(In) :: nreac
      integer, dimension(1:maxr), intent(InOut) :: jray
      real(kind=8), dimension(1:maxngc), intent(In) :: mw
      character(len=15), dimension(0:maxngc), intent(In) :: prod
      integer, intent(InOut) :: iplt
      integer, intent(In) :: nof
      real(kind=8), intent(Out) :: eqrat
      real(kind=8), dimension(1:2), intent(In) :: vmin
      real(kind=8), dimension(1:2), intent(In) :: vpls
      integer, intent(InOut) :: nlm
      real(kind=8), dimension(1:maxel), intent(InOut) :: b0
      real(kind=8), dimension(1:maxel,1:2), intent(InOut) :: b0p
      real(kind=8), intent(Out) :: bcheck
      real(kind=8), dimension(1:2), intent(In) :: am
      real(kind=8), intent(InOut) :: size
      real(kind=8), dimension(1:2), intent(InOut) :: hpp
      integer, intent(Out) :: jsol
      integer, intent(Out) :: jliq
      logical, intent(In) :: vol
      integer, dimension(1:maxel), intent(InOut) :: jcm
      real(kind=8), intent(InOut) :: tm
      integer, intent(InOut) :: nspr
      integer, intent(In) :: nspx
      character(len=8), dimension(1:maxr), intent(In) :: fox
      character(len=15), dimension(1:maxr), intent(In) :: rname
      integer, dimension(1:maxr), intent(Out) :: nfla
      character(len=2), dimension(1:maxr,1:12), intent(Out) :: ratom
      real(kind=8), dimension(1:maxr,1:12), intent(Out) :: rnum
      real(kind=8), dimension(1:maxng,1:9,1:3), intent(InOut) :: coef
      character(len=15), dimension(1:maxr), intent(Out) :: energy
      logical, intent(In) :: moles
      real(kind=8), dimension(1:maxr), intent(In) :: pecwt
      real(kind=8), dimension(1:2), intent(In) :: wp
      real(kind=8), dimension(1:maxr), intent(In) :: rmw
      real(kind=8), dimension(1:maxngc), intent(InOut) :: cp
      character(len=15) :: case
      logical, intent(In) :: siunit
      real(kind=8), dimension(1:maxr) :: enth
      real(kind=8), intent(In) :: r
      real(kind=8), dimension(1:2) :: rh
      logical :: page1
      logical :: rkt
      integer :: iopt
      integer :: nplt
      character(len=15), dimension(1:20) :: pltvar
      logical, intent(Out) :: gonly
      real(kind=8), dimension(1:500,1:20) :: pltout
      real(kind=8), dimension(1:ncol), intent(InOut) :: totn
      real(kind=8), dimension(1:ncol) :: sonvel
      character(len=15), dimension(0:maxngc) :: omit
      real(kind=8), dimension(1:ncol), intent(InOut) :: vis
      real(kind=8), dimension(1:ncol), intent(InOut) :: coneql
      real(kind=8), dimension(1:ncol), intent(Out) :: preql
      real(kind=8), dimension(1:ncol), intent(InOut) :: confro
      real(kind=8), dimension(1:ncol), intent(Out) :: prfro
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpeql
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpfro
      logical, intent(InOut) :: pderiv
      logical, intent(InOut) :: convg
      integer, intent(InOut) :: npr
      integer, dimension(1:45), intent(InOut) :: jcond
      integer, dimension(1:maxnc), intent(In) :: ifz
      real(kind=8), dimension(1:2,1:maxnc), intent(In) :: temp
      integer, intent(In) :: nc
      real(kind=8), dimension(1:maxngc), intent(InOut) :: enln
      real(kind=8), dimension(1:maxngc), intent(InOut) :: deln
      real(kind=8), intent(InOut) :: enn
      real(kind=8), intent(In) :: vv
      integer, intent(InOut) :: lsave
      real(kind=8), dimension(1:maxel,1:maxngc), intent(InOut) :: a
      logical, intent(In) :: ions
      logical, intent(In) :: shock
      character(len=2), dimension(1:maxel), intent(InOut) :: elmt
      logical, dimension(1:ncol), intent(In) :: debug
      integer, intent(InOut) :: iq1
      integer, intent(InOut) :: imat
      integer, intent(InOut) :: msing
      real(kind=8), dimension(1:maxngc), intent(InOut) :: mu
      real(kind=8), intent(InOut) :: ennl
      real(kind=8), intent(InOut) :: sumn
      logical, intent(In) :: sp
      real(kind=8), intent(In) :: s0
      integer, intent(In) :: ngp1
      integer, dimension(1:maxel), intent(InOut) :: jx
      real(kind=8), dimension(1:maxel), intent(InOut) :: atwt
      real(kind=8), dimension(1:maxnc,1:9) :: cft
      integer, intent(InOut) :: nm
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: eta
      real(kind=8), dimension(1:maxtr), intent(InOut) :: wmol
      real(kind=8), dimension(1:maxtr), intent(InOut) :: xs
      real(kind=8), dimension(1:maxtr), intent(InOut) :: con
      integer, intent(InOut) :: nr
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: stc
      integer, dimension(1:maxtr), intent(InOut) :: ind
      real(kind=8), dimension(1:maxtr), intent(InOut) :: cprr
      integer, intent(In) :: nfz
      integer, intent(In) :: ntape
      real(kind=8), intent(In) :: boltz
      real(kind=8), intent(In) :: avgdr
      real(kind=8), intent(In) :: pi
      real(kind=8), intent(In) :: viscns
      real(kind=8), intent(InOut) :: ensave
      real(kind=8), intent(InOut) :: enlsav
      real(kind=8), dimension(1:maxngc), intent(InOut) :: sln
      character(len=1) :: cr12
      character(len=1) :: cr52
      integer :: i
      integer :: iof
      integer :: it1
      integer :: it2
      integer :: itr
      integer :: j
      integer :: n
      logical :: refl
      logical :: seql
      logical :: srefl
      real(kind=8) :: ax
      real(kind=8) :: axx
      real(kind=8) :: b2
      real(kind=8) :: cormax
      real(kind=8) :: gg
      real(kind=8) :: hs
      real(kind=8), dimension(1:ncol) :: m2m1
      real(kind=8), dimension(1:13) :: mis
      real(kind=8) :: mu12rt
      real(kind=8) :: p1
      real(kind=8) :: p21
      real(kind=8) :: p21l
      real(kind=8), dimension(1:ncol) :: p2p1
      real(kind=8) :: pmn
      real(kind=8) :: rho12
      real(kind=8) :: rho52
      real(kind=8), dimension(1:ncol) :: rrho
      real(kind=8), dimension(1:78) :: sg
      real(kind=8) :: t1
      real(kind=8) :: t21
      real(kind=8) :: t21l
      real(kind=8), dimension(1:ncol) :: t2t1
      real(kind=8) :: ttmax
      real(kind=8), dimension(1:ncol) :: u1u2
      real(kind=8), dimension(1:13) :: uis
      real(kind=8), dimension(1:ncol) :: utwo
      real(kind=8) :: uu
      real(kind=8) :: wmx
      real(kind=8) :: ww
      real(kind=8) :: dabs
      real(kind=8) :: dexp
      real(kind=8) :: dlog
      real(kind=8) :: dmin1
      save ax,axx,b2,cormax,cr12,cr52,gg,hs,i,iof,it1,it2,itr,j,m2m1,  mis,mu12rt,n,p1,p21,p21l,p2p1,pmn,refl,rho12,rho52,rrho,seql,sg,  srefl,t1,t21,t21l,t2t1,ttmax,u1u2,uis,utwo,uu,wmx,ww
      if ( trace == 0. ) trace = 5.e-9
      tp = .true.
      cpmix = 0.
      srefl = .false.
      if ( .not.short ) then
        write (ioout,99001)
        write (ioout,99002) incdeq,refleq,incdfz,reflfz
      endif
      if ( refleq.or.reflfz ) srefl = .true.
      seql = incdeq
      if ( t(1) == 0. ) t(1) = rtemp(1)
      do i = 1,nsk
        uis(i) = u1(i)
        mis(i) = mach1(i)
        if ( mach1(i) == 0.0.and.u1(i) == 0.0 ) goto 100
      enddo
 100  if ( nsk > ncol ) then
        write (ioout,99003) ncol
        nsk = ncol
      endif
      if ( .not.short ) then
        write (ioout,99004) (u1(i),i=1,nsk)
        write (ioout,99005) (mach1(i),i=1,nsk)
      endif
      iof = 0
 200  iof = iof + 1
      oxfl = oxf(iof)
      call newof(short,oxfl,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,wmix,npt,size,hsub0,hpp,jsol,jliq,vol,jcm,prod)
      incdeq = seql
 300  refl = .false.
      it2 = 2
      it1 = 1
      pp = p(1)
      tt = t(1)
      if ( .not.incdeq ) then
        do n = 1,nsk
          dlvtp(n) = 1.
          dlvpt(n) = -1.
        enddo
      endif
      do npt = 1,nsk
        ppp(npt) = p(npt)
        ttt(npt) = t(npt)
        if ( npt > 1 ) then
          if ( ppp(npt) == 0. ) ppp(npt) = ppp(npt-1)
          if ( ttt(npt) == 0. ) ttt(npt) = ttt(npt-1)
          ssum(npt) = ssum(npt-1)
          hsum(npt) = hsum(npt-1)
          if ( ttt(npt) == tt.and.ppp(npt) == pp ) goto 350
        endif
        pp = ppp(npt)
        tt = ttt(npt)
        if ( tt >= tg(1)*.8d0 ) then
          call hcalc(tt,tm,pp,wmix,ssum,npt,hpp,hsub0,cpmix,oxfl,nspr,nspx,nreac,fox,rtemp,jray,ngc,prod,rname,ng,tg,mw,nfla,ratom,rnum,coef,energy,moles,pecwt,wp,rmw,tln,en,s,h0,cp)
          hsum(npt) = hsub0
        else
          write (ioout,99016) tt,npt
          goto 1000
        endif
 350    if ( cpmix /= 0. ) gamma1 = cpmix/(cpmix-1./wmix)
        a1 = (rr*gamma1*tt/wmix)**.5
        if ( u1(npt) == 0. ) u1(npt) = a1*mach1(npt)
        if ( mach1(npt) == 0. ) mach1(npt) = u1(npt)/a1
        wm(npt) = wmix
        cpr(npt) = cpmix
        gammas(npt) = gamma1
        vlm(npt) = rr*tt/(wmix*pp)
      enddo
      npt = nsk
      write (ioout,99006)
      if ( .not.incdeq ) then
        write (ioout,99008)
      else
        write (ioout,99007)
      endif
      eql = .false.
      call out1(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      write (ioout,99009)
      fmt(4) = '13'
      fmt(5) = ' '
      fmt(7) = '4,'
      write (ioout,fmt) 'MACH NUMBER1   ',(mach1(j),j=1,npt)
      fmt(7) = '2,'
      write (ioout,fmt) 'U1, M/SEC      ',(u1(j),j=1,npt)
      call out2(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      if ( incdeq ) eql = .true.
      npt = 1
 400  gamma1 = gammas(npt)
      uu = u1(npt)
      wmx = wm(npt)
      p1 = ppp(npt)
      t1 = ttt(npt)
      hs = hsum(npt)
      if ( refl ) uu = u1u2(npt)
      mu12rt = wmx*uu**2/(rr*t1)
      if ( refl ) then
        t21 = 2.
        b2 = (-1.-mu12rt-t21)/2.
        p21 = -b2 + sqrt(b2**2-t21)
      else
        p21 = (2.*gamma1*mach1(npt)**2-gamma1+1.)/(gamma1+1.)
        if ( .not.eql ) then
          t21 = p21*(2./mach1(npt)**2+gamma1-1.)/(gamma1+1.)
        else
          pp = p21*p1
          tp = .false.
          hp = .true.
          hsub0 = hs + uu**2/(2.*rr)
          call eqlbrm(nlm,size,trace,ngc,pderiv,convg,tp,tt,npr,t,jcond,ng,ifz,temp,en,npt,prod,short,nc,enln,deln,tln,vol,pp,enn,rr,vv,tm,lsave,a,ions,shock,elmt,debug,cpsum,cp,iq1,imat,g,msing,x,h0,mu,ennl,s,totn,sumn,hp,b0,bcheck,dlvtp,cpr,dlvpt,jliq,gammas,jsol,hsum,ssum,sp,s0,tg,ngp1,mw,jx,jcm,b0p,nspx,atwt,ttt,ppp,vlm,wm,gonly,coef,cft,hsub0)
          t21 = ttt(npt)/t1
          hp = .false.
          tp = .true.
        endif
      endif
      p21l = dlog(p21)
      ttmax = 1.05*tg(4)/t1
      t21 = dmin1(t21,ttmax)
      t21l = dlog(t21)
      itr = 1
 500  if ( shkdbg ) write (ioout,99010) itr,it2,it1,p21,it2,it1,t21,     rho52
      tt = t21*t1
      pp = p21*p1
      if ( .not.eql ) then
        tln = dlog(tt)
        if ( .not.incdeq ) then
          call hcalc(tt,tm,pp,wmix,ssum,npt,hpp,hsub0,cpmix,oxfl,nspr,nspx,nreac,fox,rtemp,jray,ngc,prod,rname,ng,tg,mw,nfla,ratom,rnum,coef,energy,moles,pecwt,wp,rmw,tln,en,s,h0,cp)
          if ( tt == 0. ) goto 600
          hsum(npt) = hsub0
          cpr(npt) = cpmix
        else
          call cphs(tg,tt,tln,ng,h0,s,coef,convg,tp,cp,ngc,npr,jcond,cft,nc)
          cpr(npt) = cpsum
          hsum(npt) = 0.
          do j = 1,ng
            hsum(npt) = hsum(npt) + h0(j)*en(j,npt)
          enddo
          hsum(npt) = hsum(npt)*tt
        endif
      else
        call eqlbrm(nlm,size,trace,ngc,pderiv,convg,tp,tt,npr,t,jcond,ng,ifz,temp,en,npt,prod,short,nc,enln,deln,tln,vol,pp,enn,rr,vv,tm,lsave,a,ions,shock,elmt,debug,cpsum,cp,iq1,imat,g,msing,x,h0,mu,ennl,s,totn,sumn,hp,b0,bcheck,dlvtp,cpr,dlvpt,jliq,gammas,jsol,hsum,ssum,sp,s0,tg,ngp1,mw,jx,jcm,b0p,nspx,atwt,ttt,ppp,vlm,wm,gonly,coef,cft,hsub0)
        if ( tt == 0. ) goto 800
      endif
      rho12 = wmx*t21/(wm(npt)*p21)
      gg = rho12*mu12rt
      rho52 = 1./rho12
      if ( refl ) gg = -mu12rt*rho52/(rho52-1.)**2
      g(1,1) = -gg*dlvpt(npt) - p21
      g(1,2) = -gg*dlvtp(npt)
      g(1,3) = p21 - 1. + gg - mu12rt
      if ( refl ) g(1,3) = p21 - 1. + gg*(rho52-1.)
      gg = gg*t1/wmx
      if ( .not.refl ) gg = gg*rho12
      g(2,1) = -gg*dlvpt(npt) + tt*(dlvtp(npt)-1.)/wm(npt)
      g(2,2) = -gg*dlvtp(npt) - tt*cpr(npt)
      gg = 1. - rho12**2
      if ( refl ) gg = (rho52+1.)/(rho52-1.)
      g(2,3) = hsum(npt) - hs - uu**2*gg/(2.*rr)
      x(3) = g(1,1)*g(2,2) - g(1,2)*g(2,1)
      x(1) = (g(1,3)*g(2,2)-g(2,3)*g(1,2))/x(3)
      x(2) = (g(1,1)*g(2,3)-g(2,1)*g(1,3))/x(3)
      if ( shkdbg ) then
        write (ioout,99011) g(1,1),g(1,2),g(1,3)
        write (ioout,99011) g(2,1),g(2,2),g(2,3)
        write (ioout,99012) x(1),x(2)
        write (ioout,99013) hsum(npt),hs,uu,uu*rho12
      endif
      ax = dabs(x(1))
      axx = dabs(x(2))
      if ( axx > ax ) ax = axx
      if ( ax >= .00005 ) then
        cormax = .40546511
        if ( itr > 4 ) cormax = .22314355
        if ( itr > 12 ) cormax = .09531018
        if ( itr > 20 ) cormax = .04879016
        ax = ax/cormax
        if ( ax > 1. ) then
          x(1) = x(1)/ax
          x(2) = x(2)/ax
        endif
        p21l = p21l + x(1)
        t21l = t21l + x(2)
        p21 = dexp(p21l)
        t21 = dexp(t21l)
        if ( shkdbg ) write (ioout,99014) cormax,x(1),x(2)
        if ( itr /= 1.or.t21 < ttmax ) then
          itr = itr + 1
          if ( itr < 61 ) goto 500
          write (ioout,99015) u1(npt)
        else
          tt = 0.
          npt = npt - 1
          goto 700
        endif
      endif
 600  rrho(npt) = rho52
      m2m1(npt) = wm(npt)/wmx
      p2p1(npt) = p21
      t2t1(npt) = t21
      utwo(npt) = uu*rho12
      u1u2(npt) = uu - utwo(npt)
      if ( tt >= tg(1)*.8d0.and.tt <= tg(4)*1.1d0 ) then
        if ( .not.eql ) then
          ppp(npt) = pp
          ttt(npt) = tt
          gammas(npt) = cpr(npt)/(cpr(npt)-1./wmx)
          vlm(npt) = rr*tt/(wmx*pp)
          if ( incdeq ) then
            ssum(npt) = 0.
            do j = 1,ngc
              pmn = pp*wmx*en(j,npt)
              if ( en(j,npt) > 0. ) ssum(npt) = ssum(npt) + en(j,npt)             *(s(j)-dlog(pmn))
            enddo
          endif
        endif
        goto 900
      endif
 700  write (ioout,99016) tt,npt
      tt = 0.
 800  if ( npt < 1 ) goto 1000
      nsk = npt
 900 call tranp(nm,confro,npt,vis,eta,wmol,xs,con,eql,nr,lsave,jcm,h0,stc,ind,g,imat,r,x,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,shock,incdeq,nreac,jray,mw,en,wm,ngc,enln,ennl,ng,nfz,a,ntape,tt,tln,ions,boltz,avgdr,pi,rr,cp,nlm,viscns,msing)
      isv = 0
      if ( npt < nsk ) isv = npt
      if ( npt == 1 ) isv = -1
      npt = npt + 1
      call seten(isv,ttt,ensave,enn,enlsav,ennl,lsave,ng,sln,enln,en,npt,npr,ngp1,ngc,jliq,jsol,tt,jcond,tp,sumn)
      if ( npt <= nsk ) goto 400
      npt = nsk
      if ( refl ) then
        if ( .not.eql ) write (ioout,99020)
        if ( eql ) write (ioout,99021)
        cr12 = '2'
        cr52 = '5'
      else
        if ( .not.eql ) write (ioout,99018)
        if ( eql ) write (ioout,99019)
        cr12 = '1'
        cr52 = '2'
      endif
      fmt(7) = '2,'
      write (ioout,fmt) 'U'//cr52//', M/SEC      ',(utwo(j),j=1,npt)
      call out2(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      call out4(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      write (ioout,99017)
      fmt(7) = '3,'
      write (ioout,fmt) 'P'//cr52//'/P'//cr12//'           ',              (p2p1(j),j=1,npt)
      write (ioout,fmt) 'T'//cr52//'/T'//cr12//'           ',              (t2t1(j),j=1,npt)
      fmt(7) = '4,'
      write (ioout,fmt) 'M'//cr52//'/M'//cr12//'           ',              (m2m1(j),j=1,npt)
      write (ioout,fmt) 'RHO'//cr52//'/RHO'//cr12//'       ',              (rrho(j),j=1,npt)
      fmt(7) = '2,'
      if ( .not.refl ) write (ioout,fmt) 'V2, M/SEC      ',(u1u2(j),               j=1,npt)
      if ( refl ) write (ioout,fmt) 'U5+V2,M/SEC    ',(u1u2(j),j=1,npt)
      if ( .not.eql ) then
        fmt(7) = '5,'
        if ( .not.incdeq ) then
          if ( massf ) then
            write (ioout,99022) 'MASS'
          else
            write (ioout,99022) 'MOLE'
            ww = wmx
          endif
          do n = 1,nreac
            j = jray(n)
            if ( massf ) ww = mw(j)
            write (ioout,99023) prod(j),(en(j,i)*ww,i=1,npt)
          enddo
        else
          eql = .true.
          call out3(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
          eql = .false.
        endif
      else
        call out3(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
      endif
      iplt = min(iplt+npt,500)
      if ( srefl ) then
        if ( .not.refl ) then
          refl = .true.
          it2 = 5
          it1 = 2
          eql = .true.
          if ( reflfz ) then
            eql = .false.
            if ( refleq ) then
              j = 0
              do i = 1,npt
                j = j + 1
                sg(j) = u1u2(i)
                j = j + 1
                sg(j) = wm(i)
                j = j + 1
                sg(j) = ppp(i)
                j = j + 1
                sg(j) = ttt(i)
                j = j + 1
                sg(j) = hsum(i)
                j = j + 1
                sg(j) = gammas(i)
              enddo
            endif
          endif
          npt = 1
          goto 400
        elseif ( .not.eql.and.refleq ) then
          j = 1
          do i = 1,npt
            u1u2(i) = sg(j)
            wm(i) = sg(j+1)
            ppp(i) = sg(j+2)
            ttt(i) = sg(j+3)
            hsum(i) = sg(j+4)
            gammas(i) = sg(j+5)
            j = j + 6
          enddo
          eql = .true.
          npt = 1
          goto 400
        endif
      endif
      if ( incdeq.and.incdfz ) then
        incdeq = .false.
        eql = .false.
        goto 300
      elseif ( iof >= nof ) then
        tp = .false.
        do n = 1,nreac
          rtemp(n) = t(1)
        enddo
      else
        do i = 1,nsk
          u1(i) = uis(i)
          mach1(i) = mis(i)
        enddo
        goto 200
      endif
 1000 return
99001 format (/'   *** INPUT FOR SHOCK PROBLEMS ***')
99002 format (/' INCDEQ =',l2,'   REFLEQ =',l2,'   INCDFZ =',l2,        '    REFLFZ =',l2)
99003 format (/' WARNING!!  ONLY ',i2,' u1 OR mach1 VALUES ALLOWED ',        '(SHCK)')
99004 format (/1p,' U1 =   ',5e13.6,/(8x,5e13.6))
99005 format (/1p,' MACH1 =',5e13.6,/(8x,5e13.6))
99006 format (////25x,'SHOCK WAVE PARAMETERS ASSUMING')
99007 format (/,16x,' EQUILIBRIUM COMPOSITION FOR INCIDENT SHOCKED',        ' CONDITIONS'//)
99008 format (/,17x,' FROZEN COMPOSITION FOR INCIDENT SHOCKED',        ' CONDITI1ONS'//)
99009 format (/' INITIAL GAS (1)')
99010 format (/' ITR NO.=',i3,3x,'P',i1,'/P',i1,' =',f9.4,3x,'T',i1,        '/T',i1,' =',f9.4,'   RHO2/RHO1 =',f9.6)
99011 format (/' G(I,J)  ',3e15.8)
99012 format (/' X       ',2e15.8)
99013 format (/' HSUM HS UU U2 ',4e15.8)
99014 format (/' MAX.COR.=',e13.6,' X(1)=',e13.6,' X(2)=',e13.6)
99015 format (/6x,' WARNING!!  NO CONVERGENCE FOR u1=',f8.1,        /'  ANSWERS NOT RELIABLE, SOLUTION MAY NOT EXIST (SHCK)')
99016 format (/' TEMPERATURE=',e12.4,' IS OUT OF EXTENDED RANGE ',        'FOR POINT',i5,' (SHCK)')
99017 format ()
99018 format (/' SHOCKED GAS (2)--INCIDENT--FROZEN')
99019 format (/' SHOCKED GAS (2)--INCIDENT--EQUILIBRIUM')
99020 format (/' SHOCKED GAS (5)--REFLECTED--FROZEN')
99021 format (/' SHOCKED GAS (5)--REFLECTED--EQUILIBRIUM')
99022 format (/1x,a4,' FRACTIONS'/)
99023 format (' ',a16,f8.5,12f9.5)
      end subroutine shck
      subroutine thermp(hp,tp,sp,eql,nof,oxfl,oxf,ip,np,pp,p,it,nt,vv,v,tt,t,npt,trnspt,isv,vol,iplt,short,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,wmix,size,hsub0,hpp,jsol,jliq,jcm,prod,trace,ngc,pderiv,convg,npr,jcond,ng,ifz,temp,en,nc,enln,deln,tln,enn,rr,tm,lsave,a,ions,shock,elmt,debug,cpsum,cp,iq1,imat,g,msing,x,h0,mu,ennl,s,totn,sumn,dlvtp,cpr,dlvpt,gammas,hsum,ssum,s0,tg,ngp1,mw,jx,nspx,atwt,ttt,ppp,vlm,wm,gonly,coef,cft,nm,confro,vis,eta,wmol,xs,con,nr,stc,ind,r,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,incdeq,nreac,jray,nfz,ntape,boltz,avgdr,pi,viscns,case,moles,enth,fox,pecwt,rname,rtemp,rh,page1,rkt,iopt,nplt,pltvar,pltout,fmt,sonvel,massf,omit,ensave,enlsav,sln)
      use params_cea_inc, only : maxtr, maxpv, ioout, maxmat, maxt, maxnc, maxr, maxngc, maxel, maxng, maxmix, ncol
      implicit none
      logical, intent(In) :: hp
      logical, intent(In) :: tp
      logical, intent(In) :: sp
      logical, intent(Out) :: eql
      integer, intent(In) :: nof
      real(kind=8), intent(Out) :: oxfl
      real(kind=8), dimension(1:maxmix), intent(In) :: oxf
      integer, intent(InOut) :: ip
      integer, intent(In) :: np
      real(kind=8), intent(Out) :: pp
      real(kind=8), dimension(1:maxpv), intent(In) :: p
      integer, intent(InOut) :: it
      integer, intent(In) :: nt
      real(kind=8), intent(Out) :: vv
      real(kind=8), dimension(1:maxpv), intent(In) :: v
      real(kind=8), intent(InOut) :: tt
      real(kind=8), dimension(1:maxt), intent(InOut) :: t
      integer, intent(InOut) :: npt
      logical, intent(In) :: trnspt
      integer, intent(InOut) :: isv
      logical, intent(In) :: vol
      integer, intent(InOut) :: iplt
      logical, intent(In) :: short
      real(kind=8), intent(Out) :: eqrat
      real(kind=8), dimension(1:2), intent(In) :: vmin
      real(kind=8), dimension(1:2), intent(In) :: vpls
      integer, intent(InOut) :: nlm
      real(kind=8), dimension(1:maxel), intent(InOut) :: b0
      real(kind=8), dimension(1:maxel,1:2), intent(InOut) :: b0p
      real(kind=8), intent(Out) :: bcheck
      real(kind=8), dimension(1:2), intent(In) :: am
      real(kind=8), intent(Out) :: wmix
      real(kind=8), intent(InOut) :: size
      real(kind=8), intent(InOut) :: hsub0
      real(kind=8), dimension(1:2), intent(In) :: hpp
      integer, intent(Out) :: jsol
      integer, intent(Out) :: jliq
      integer, dimension(1:maxel), intent(InOut) :: jcm
      character(len=15), dimension(0:maxngc), intent(In) :: prod
      real(kind=8), intent(In) :: trace
      integer, intent(In) :: ngc
      logical, intent(InOut) :: pderiv
      logical, intent(InOut) :: convg
      integer, intent(InOut) :: npr
      integer, dimension(1:45), intent(InOut) :: jcond
      integer, intent(InOut) :: ng
      integer, dimension(1:maxnc), intent(In) :: ifz
      real(kind=8), dimension(1:2,1:maxnc), intent(In) :: temp
      real(kind=8), dimension(1:maxngc,1:ncol), intent(InOut) :: en
      integer, intent(In) :: nc
      real(kind=8), dimension(1:maxngc), intent(InOut) :: enln
      real(kind=8), dimension(1:maxngc), intent(InOut) :: deln
      real(kind=8), intent(InOut) :: tln
      real(kind=8), intent(InOut) :: enn
      real(kind=8), intent(In) :: rr
      real(kind=8), intent(InOut) :: tm
      integer, intent(InOut) :: lsave
      real(kind=8), dimension(1:maxel,1:maxngc), intent(InOut) :: a
      logical, intent(In) :: ions
      logical, intent(In) :: shock
      character(len=2), dimension(1:maxel), intent(InOut) :: elmt
      logical, dimension(1:ncol), intent(In) :: debug
      real(kind=8), intent(InOut) :: cpsum
      real(kind=8), dimension(1:maxngc), intent(In) :: cp
      integer, intent(InOut) :: iq1
      integer, intent(InOut) :: imat
      real(kind=8), dimension(1:maxmat,1:maxmat+1), intent(InOut) :: g
      integer, intent(InOut) :: msing
      real(kind=8), dimension(1:maxmat), intent(InOut) :: x
      real(kind=8), dimension(1:maxngc), intent(In) :: h0
      real(kind=8), dimension(1:maxngc), intent(InOut) :: mu
      real(kind=8), intent(InOut) :: ennl
      real(kind=8), dimension(1:maxngc), intent(In) :: s
      real(kind=8), dimension(1:ncol), intent(InOut) :: totn
      real(kind=8), intent(InOut) :: sumn
      real(kind=8), dimension(1:ncol), intent(InOut) :: dlvtp
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpr
      real(kind=8), dimension(1:ncol), intent(InOut) :: dlvpt
      real(kind=8), dimension(1:ncol), intent(InOut) :: gammas
      real(kind=8), dimension(1:ncol), intent(InOut) :: hsum
      real(kind=8), dimension(1:ncol), intent(InOut) :: ssum
      real(kind=8), intent(In) :: s0
      real(kind=8), dimension(1:4), intent(In) :: tg
      integer, intent(In) :: ngp1
      real(kind=8), dimension(1:maxngc), intent(In) :: mw
      integer, dimension(1:maxel), intent(InOut) :: jx
      integer, intent(In) :: nspx
      real(kind=8), dimension(1:maxel), intent(InOut) :: atwt
      real(kind=8), dimension(1:ncol), intent(Out) :: ttt
      real(kind=8), dimension(1:ncol), intent(Out) :: ppp
      real(kind=8), dimension(1:ncol), intent(InOut) :: vlm
      real(kind=8), dimension(1:ncol), intent(InOut) :: wm
      logical, intent(Out) :: gonly
      real(kind=8), dimension(1:maxng,1:9,1:3) :: coef
      real(kind=8), dimension(1:maxnc,1:9) :: cft
      integer, intent(InOut) :: nm
      real(kind=8), dimension(1:ncol), intent(InOut) :: confro
      real(kind=8), dimension(1:ncol), intent(InOut) :: vis
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: eta
      real(kind=8), dimension(1:maxtr), intent(InOut) :: wmol
      real(kind=8), dimension(1:maxtr), intent(InOut) :: xs
      real(kind=8), dimension(1:maxtr), intent(InOut) :: con
      integer, intent(InOut) :: nr
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: stc
      integer, dimension(1:maxtr), intent(InOut) :: ind
      real(kind=8), intent(In) :: r
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpfro
      real(kind=8), dimension(1:maxtr), intent(InOut) :: cprr
      logical, intent(In) :: siunit
      real(kind=8), dimension(1:ncol), intent(Out) :: prfro
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpeql
      real(kind=8), dimension(1:ncol), intent(InOut) :: coneql
      real(kind=8), dimension(1:ncol), intent(Out) :: preql
      logical, intent(In) :: incdeq
      integer, intent(In) :: nreac
      integer, dimension(1:maxr), intent(In) :: jray
      integer, intent(In) :: nfz
      integer, intent(In) :: ntape
      real(kind=8), intent(In) :: boltz
      real(kind=8), intent(In) :: avgdr
      real(kind=8), intent(In) :: pi
      real(kind=8), intent(In) :: viscns
      character(len=15) :: case
      logical :: moles
      real(kind=8), dimension(1:maxr) :: enth
      character(len=8), dimension(1:maxr) :: fox
      real(kind=8), dimension(1:maxr) :: pecwt
      character(len=15), dimension(1:maxr) :: rname
      real(kind=8), dimension(1:maxr) :: rtemp
      real(kind=8), dimension(1:2) :: rh
      logical :: page1
      logical :: rkt
      integer :: iopt
      integer :: nplt
      character(len=15), dimension(1:20) :: pltvar
      real(kind=8), dimension(1:500,1:20) :: pltout
      character(len=4), dimension(1:30) :: fmt
      real(kind=8), dimension(1:ncol) :: sonvel
      logical :: massf
      character(len=15), dimension(0:maxngc) :: omit
      real(kind=8), intent(InOut) :: ensave
      real(kind=8), intent(InOut) :: enlsav
      real(kind=8), dimension(1:maxngc), intent(InOut) :: sln
      integer :: iof
      logical :: uv
      logical :: tv
      logical :: sv
      save iof
      uv = hp
      tv = tp
      sv = sp
      eql = .true.
      do iof = 1,nof
        oxfl = oxf(iof)
        call newof(short,oxfl,eqrat,vmin,vpls,nlm,b0,b0p,bcheck,am,wmix,npt,size,hsub0,hpp,jsol,jliq,vol,jcm,prod)
        do ip = 1,np
          pp = p(ip)
          do it = 1,nt
            vv = v(ip)
            tt = t(it)
            call eqlbrm(nlm,size,trace,ngc,pderiv,convg,tp,tt,npr,t,jcond,ng,ifz,temp,en,npt,prod,short,nc,enln,deln,tln,vol,pp,enn,rr,vv,tm,lsave,a,ions,shock,elmt,debug,cpsum,cp,iq1,imat,g,msing,x,h0,mu,ennl,s,totn,sumn,hp,b0,bcheck,dlvtp,cpr,dlvpt,jliq,gammas,jsol,hsum,ssum,sp,s0,tg,ngp1,mw,jx,jcm,b0p,nspx,atwt,ttt,ppp,vlm,wm,gonly,coef,cft,hsub0)
      tv = tp
      uv = hp
      sv = sp
            if ( npt == 0 ) goto 200
            call tranp(nm,confro,npt,vis,eta,wmol,xs,con,eql,nr,lsave,jcm,h0,stc,ind,g,imat,r,x,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,shock,incdeq,nreac,jray,mw,en,wm,ngc,enln,ennl,ng,nfz,a,ntape,tt,tln,ions,boltz,avgdr,pi,rr,cp,nlm,viscns,msing)
            isv = 0
            if ( ip /= np.or.it /= nt.and.tt /= 0. ) then
              isv = npt
              if ( npt /= ncol ) goto 10
            endif
            if ( .not.hp ) write (ioout,99001)
            if ( hp ) write (ioout,99002)
            if ( .not.vol ) then
              if ( hp ) write (ioout,99006)
              if ( tp ) write (ioout,99007)
              if ( sp ) write (ioout,99008)
            else
              if ( uv ) write (ioout,99003)
              if ( tv ) write (ioout,99004)
              if ( sv ) write (ioout,99005)
            endif
            call out1(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
            write (ioout,99009)
            call out2(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
            call out4(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
            call out3(case,moles,siunit,nreac,enth,fox,pecwt,r,rname,rtemp,oxfl,vmin,vpls,rh,eqrat,page1,rkt,iopt,nplt,pltvar,gonly,iplt,npt,pltout,fmt,ppp,x,ttt,vlm,hsum,rr,ssum,wm,totn,cpr,gammas,dlvtp,dlvpt,eql,sonvel,trace,massf,ngc,ng,prod,mw,en,omit,tg,short,vis,coneql,preql,confro,prfro,cpeql,cpfro)
            iplt = min(iplt+npt,500)
            if ( isv == 0.and.iof == nof ) goto 200
            write (ioout,99010)
            npt = 0
 10         npt = npt + 1
            if ( .not.tp.and.tt /= 0. ) t(1) = tt
            if ( nt == 1.and.np == 1 ) goto 100
            if ( ip == 1.and.it == 1 ) isv = -isv
            if ( nt /= 1 ) then
              if ( it == nt.or.tt == 0. ) isv = 0
            endif
            call seten(isv,ttt,ensave,enn,enlsav,ennl,lsave,ng,sln,enln,en,npt,npr,ngp1,ngc,jliq,jsol,tt,jcond,tp,sumn)
      tv = tp
          enddo
        enddo
 100  continue
      end do
 200  return
99001 format (////15x,'THERMODYNAMIC EQUILIBRIUM PROPERTIES AT ASSIGNED'        )
99002 format (////9x,     'THERMODYNAMIC EQUILIBRIUM COMBUSTION PROPERTIES AT ASSIGNED'     )
99003 format (/36x,' VOLUME'/)
99004 format (/28x,'TEMPERATURE AND VOLUME'/)
99005 format (/30x,'ENTROPY AND VOLUME'/)
99006 format (/34x,' PRESSURES'/)
99007 format (/27x,'TEMPERATURE AND PRESSURE'/)
99008 format (/29x,'ENTROPY AND PRESSURE'/)
99009 format (/' THERMODYNAMIC PROPERTIES'/)
99010 format (////)
      end subroutine thermp
      subroutine tranin(eql,shock,nm,xs,wmol,ind,incdeq,npt,nreac,jray,mw,en,wm,lsave,jcm,ngc,enln,ennl,ng,nfz,nr,stc,a,con,eta,ntape,tt,tln,ions,boltz,avgdr,pi,rr,cprr,cp,nlm,viscns)
      use params_cea_inc, only : ncol, iosch, ioout, maxr, maxel, maxtr, maxngc
      implicit none
      logical, intent(In) :: eql
      logical, intent(In) :: shock
      integer, intent(InOut) :: nm
      real(kind=8), dimension(1:maxtr), intent(InOut) :: xs
      real(kind=8), dimension(1:maxtr), intent(InOut) :: wmol
      integer, dimension(1:maxtr), intent(InOut) :: ind
      logical, intent(In) :: incdeq
      integer, intent(In) :: npt
      integer, intent(In) :: nreac
      integer, dimension(1:maxr), intent(In) :: jray
      real(kind=8), dimension(1:maxngc), intent(In) :: mw
      real(kind=8), dimension(1:maxngc,1:ncol), intent(InOut) :: en
      real(kind=8), dimension(1:ncol), intent(In) :: wm
      integer, intent(In) :: lsave
      integer, dimension(1:maxel), intent(In) :: jcm
      integer, intent(In) :: ngc
      real(kind=8), dimension(1:maxngc), intent(In) :: enln
      real(kind=8), intent(In) :: ennl
      integer, intent(In) :: ng
      integer, intent(In) :: nfz
      integer, intent(InOut) :: nr
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: stc
      real(kind=8), dimension(1:maxel,1:maxngc), intent(In) :: a
      real(kind=8), dimension(1:maxtr), intent(InOut) :: con
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: eta
      integer, intent(In) :: ntape
      real(kind=8), intent(In) :: tt
      real(kind=8), intent(In) :: tln
      logical, intent(In) :: ions
      real(kind=8), intent(In) :: boltz
      real(kind=8), intent(In) :: avgdr
      real(kind=8), intent(In) :: pi
      real(kind=8), intent(In) :: rr
      real(kind=8), dimension(1:maxtr), intent(InOut) :: cprr
      real(kind=8), dimension(1:maxngc), intent(In) :: cp
      integer, intent(In) :: nlm
      real(kind=8), intent(In) :: viscns
      real :: d0
      real :: e0
      integer :: i
      integer :: ii
      integer, dimension(1:maxtr) :: inds
      integer :: ir
      integer :: j
      integer, dimension(1:2) :: jtape
      integer :: k
      integer :: k1
      integer :: k2
      integer :: kt
      integer :: kvc
      integer :: l
      integer :: loop
      integer :: m
      integer :: nms
      logical :: change
      logical :: elc1
      logical :: elc2
      logical :: ion1
      logical :: ion2
      logical :: setx
      real(kind=8) :: coeff
      real(kind=8) :: debye
      real(kind=8) :: ekt
      real(kind=8) :: enel
      real(kind=8) :: enmin
      real(kind=8) :: ionic
      real(kind=8) :: lamda
      real(kind=8) :: omega
      real(kind=8) :: prop
      real(kind=8) :: qc
      real(kind=8) :: ratio
      real(kind=8), dimension(1:maxtr,1:maxtr) :: stcf
      real(kind=8), dimension(1:maxtr) :: stcoef
      real(kind=8) :: te
      real(kind=8) :: testen
      real(kind=8) :: testot
      real(kind=8) :: total
      real(kind=8), dimension(1:6,1:3,1:2) :: trc
      real(kind=8), dimension(1:maxtr) :: wmols
      real(kind=8) :: wmred
      real(kind=8) :: xsel
      real(kind=8), dimension(1:maxtr) :: xss
      real(kind=8) :: dabs
      real(kind=8) :: dexp
      real(kind=8) :: dlog
      real(kind=8) :: dsqrt
      save change,coeff,debye,ekt,elc1,elc2,enel,enmin,i,ii,inds,ion1,  ion2,ionic,ir,j,jtape,k,k1,k2,kt,kvc,l,lamda,loop,m,nms,omega,  prop,qc,ratio,setx,stcf,stcoef,te,testen,testot,total,trc,wmols,  wmred,xsel,xss
      if ( .not.eql ) then
        if ( .not.shock ) then
          if ( .not.setx ) then
            setx = .true.
            nm = nms
            do i = 1,nm
              xs(i) = xss(i)
              wmol(i) = wmols(i)
              ind(i) = inds(i)
            enddo
          endif
          goto 300
        elseif ( .not.incdeq ) then
          if ( npt <= 1 ) then
            nm = nreac
            do i = 1,nm
              j = jray(i)
              ind(i) = j
              wmol(i) = mw(j)
              xs(i) = en(j,1)*wm(1)
            enddo
          endif
          goto 300
        endif
      endif
      nm = 0
      total = 0.d0
      enmin = 1.0d-11/wm(npt)
      testot = 0.999999999d0/wm(npt)
      do i = 1,lsave
        j = jcm(i)
        if ( en(j,npt) <= 0.d0.and.j <= ngc ) then
          if ( (enln(j)-ennl+25.328436d0) > 0.d0 ) en(j,npt)         = dexp(enln(j))
        endif
        nm = nm + 1
        ind(nm) = j
        total = total + en(j,npt)
        if ( mw(j) < 1.0d0 ) enel = en(j,npt)
        en(j,npt) = -en(j,npt)
      enddo
      testen = 1.d0/(ng*wm(npt))
      loop = 0
 100  if ( total <= testot.and.loop <= ng ) then
        loop = loop + 1
        testen = testen/10.
        do j = 1,ng
          if ( en(j,npt) >= testen ) then
            if ( nm >= maxtr ) then
              write (ioout,99001) nm,npt
              goto 200
            else
              total = total + en(j,npt)
              nm = nm + 1
              ind(nm) = j
              en(j,npt) = -en(j,npt)
            endif
          endif
        enddo
        if ( testen > enmin ) goto 100
      endif
 200  do j = 1,ng
        en(j,npt) = dabs(en(j,npt))
      enddo
      do i = 1,nm
        j = ind(i)
        wmol(i) = mw(j)
        xs(i) = en(j,npt)/total
      enddo
      if ( npt == nfz ) then
        nms = nm
        do i = 1,nm
          xss(i) = xs(i)
          wmols(i) = wmol(i)
          inds(i) = ind(i)
        enddo
        setx = .false.
      endif
      nr = nm - lsave
      if ( nr /= 0 ) then
        do k = 1,maxtr
          do m = 1,maxtr
            stc(k,m) = 0.0d0
          enddo
        enddo
        k = 1
        do i = lsave + 1,nm
          stc(k,i) = -1.0d0
          j = ind(i)
          do m = 1,lsave
            stc(k,m) = a(m,j)
          enddo
          k = k + 1
        enddo
        do i = 1,nm
          if ( xs(i) < 1.0d-10 ) then
            m = 1
            change = .false.
            do j = 1,nr
              coeff = stc(j,i)
              if ( abs(coeff) > 1.0d-05 ) then
                if ( .not.change ) then
                  change = .true.
                  do k = 1,nm
                    stcoef(k) = stc(j,k)/coeff
                  enddo
                  goto 210
                else
                  do k = 1,nm
                    stc(j,k) = (stc(j,k)/coeff) - stcoef(k)
                  enddo
                endif
              endif
              do k = 1,nm
                stcf(m,k) = stc(j,k)
              enddo
              m = m + 1
 210        continue
      end do
            do ii = 1,nm
              do j = 1,nr
                stc(j,ii) = stcf(j,ii)
              enddo
            enddo
            nr = m - 1
          endif
        enddo
      endif
 300  do i = 1,nm
        con(i) = 0.0
        do j = 1,nm
          eta(i,j) = 0.0
        enddo
      enddo
      rewind iosch
      do ir = 1,ntape
        read (iosch) jtape,trc
        do k = 1,2
          do i = 1,nm
            j = ind(i)
            if ( j == jtape(k) ) then
              l = i
              if ( k == 2 ) then
                kvc = 1
 302            kt = 1
                if ( trc(2,1,kvc) /= 0.e0 ) then
                  if ( trc(2,2,kvc) /= 0.e0 ) then
                    if ( tt > trc(2,1,kvc) ) kt = 2
                    if ( trc(2,3,kvc) /= 0. ) then
                      if ( tt > trc(2,2,kvc) ) kt = 3
                    endif
                  endif
                  prop = exp(trc(6,kt,kvc)                   +(trc(5,kt,kvc)/tt+trc(4,kt,kvc))                   /tt+trc(3,kt,kvc)*tln)
                  if ( kvc == 2 ) then
                    con(l) = prop
                    goto 400
                  else
                    eta(l,m) = prop
                    if ( l /= m ) eta(m,l) = eta(l,m)
                  endif
                elseif ( kvc == 2 ) then
                  goto 400
                endif
                kvc = 2
                goto 302
              else
                m = i
                goto 350
              endif
            endif
          enddo
          goto 400
 350    continue
      end do
 400  continue
      end do
      if ( ions ) then
        te = tt/1000.d0
        ekt = 4.8032d0**2/(boltz*te)
        qc = 100.d0*(ekt**2)
        xsel = enel/total
        if ( xsel < 1.0d-12 ) xsel = 1.0d-12
        debye = ((22.5d0/pi)*(rr/avgdr*100.d0)*(te/xsel))/ekt**3
        ionic = ((810.d0/(4.0d0*pi))*(rr/avgdr*100d0)*(te/xsel))          **(2.0/3.0)/ekt**2
        lamda = dsqrt(debye+ionic)
        lamda = max(lamda,2.71828183d0)
      endif
      do i = 1,nm
        k = ind(i)
        cprr(i) = cp(k)
        if ( .not.(ions.and.(dabs(a(nlm,k)) == 1.d0).and.       (eta(i,i) == 0.d0)) ) then
          if ( eta(i,i) == 0.d0 ) then
            omega = dlog(50.d0*wmol(i)**4.6/tt**1.4)
            omega = max(omega,1.d0)
            eta(i,i) = viscns*dsqrt(wmol(i)*tt)/omega
          endif
          if ( con(i) == 0.d0 ) con(i) = eta(i,i)         *rr*(.00375d0+.00132d0*(cprr(i)-2.5d0))/wmol(i)
        endif
      enddo
      do i = 1,nm
        do j = i,nm
          ion1 = .false.
          ion2 = .false.
          elc1 = .false.
          elc2 = .false.
          omega = 0.0
          if ( eta(i,j) == 0. ) eta(i,j) = eta(j,i)
          if ( eta(j,i) == 0. ) eta(j,i) = eta(i,j)
          if ( eta(i,j) == 0. ) then
            if ( ions ) then
              k1 = ind(i)
              k2 = ind(j)
              if ( abs(a(nlm,k1)) == 1.0 ) ion1 = .true.
              if ( abs(a(nlm,k2)) == 1.0 ) ion2 = .true.
              if ( wmol(i) < 1.0 ) elc1 = .true.
              if ( wmol(j) < 1.0 ) elc2 = .true.
              if ( ion1.and.ion2 ) omega = 1.36d0*qc*dlog(lamda)
              if ( (ion1.and.elc2).or.(ion2.and.elc1) )             omega = 1.29d0*qc*dlog(lamda)
              if ( (ion1.and..not.ion2).or.(ion2.and..not.ion1) )             omega = exp(6.776-0.4*tln)
              if ( omega /= 0. ) then
                wmred = dsqrt(2.0*tt*wmol(i)*wmol(j)/(wmol(i)+wmol(j)))
                eta(i,j) = viscns*wmred*pi/omega
                eta(j,i) = eta(i,j)
                if ( i == j ) then
                  cprr(i) = cp(k1)
                  con(i) = eta(i,i)                     *rr*(.00375d0+.00132d0*(cprr(i)-2.5d0))                     /wmol(i)
                endif
                goto 450
              endif
            endif
            ratio = dsqrt(wmol(j)/wmol(i))
            eta(i,j) = 5.656854d0*eta(i,i)                 *sqrt(wmol(j)/(wmol(i)+wmol(j)))
            eta(i,j) = eta(i,j)/(1.d0+dsqrt(ratio*eta(i,i)/eta(j,j)))**2
            eta(j,i) = eta(i,j)
          endif
 450    continue
      end do
      enddo
      return
99001 format (/' WARNING!!  MAXIMUM ALLOWED NO. OF SPECIES',i3,        ' WAS USED IN ',        /' TRANSPORT PROPERTY CALCULATIONS FOR POINT',i3,        '(TRANIN))')
      end subroutine tranin
      subroutine tranp(nm,confro,npt,vis,eta,wmol,xs,con,eql,nr,lsave,jcm,h0,stc,ind,g,imat,r,x,cpfro,cprr,siunit,prfro,cpeql,coneql,preql,shock,incdeq,nreac,jray,mw,en,wm,ngc,enln,ennl,ng,nfz,a,ntape,tt,tln,ions,boltz,avgdr,pi,rr,cp,nlm,viscns,msing)
      use params_cea_inc, only : maxtr, maxngc, maxel, maxmat, maxr, ncol
      implicit none
      integer, intent(InOut) :: nm
      real(kind=8), dimension(1:ncol), intent(InOut) :: confro
      integer, intent(In) :: npt
      real(kind=8), dimension(1:ncol), intent(InOut) :: vis
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: eta
      real(kind=8), dimension(1:maxtr), intent(InOut) :: wmol
      real(kind=8), dimension(1:maxtr), intent(InOut) :: xs
      real(kind=8), dimension(1:maxtr), intent(InOut) :: con
      logical, intent(In) :: eql
      integer, intent(InOut) :: nr
      integer, intent(In) :: lsave
      integer, dimension(1:maxel), intent(In) :: jcm
      real(kind=8), dimension(1:maxngc), intent(In) :: h0
      real(kind=8), dimension(1:maxtr,1:maxtr), intent(InOut) :: stc
      integer, dimension(1:maxtr), intent(InOut) :: ind
      real(kind=8), dimension(1:maxmat,1:maxmat+1), intent(InOut) :: g
      integer, intent(Out) :: imat
      real(kind=8), intent(In) :: r
      real(kind=8), dimension(1:maxmat), intent(InOut) :: x
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpfro
      real(kind=8), dimension(1:maxtr), intent(InOut) :: cprr
      logical, intent(In) :: siunit
      real(kind=8), dimension(1:ncol), intent(Out) :: prfro
      real(kind=8), dimension(1:ncol), intent(InOut) :: cpeql
      real(kind=8), dimension(1:ncol), intent(InOut) :: coneql
      real(kind=8), dimension(1:ncol), intent(Out) :: preql
      logical, intent(In) :: shock
      logical, intent(In) :: incdeq
      integer, intent(In) :: nreac
      integer, dimension(1:maxr), intent(In) :: jray
      real(kind=8), dimension(1:maxngc), intent(In) :: mw
      real(kind=8), dimension(1:maxngc,1:ncol), intent(InOut) :: en
      real(kind=8), dimension(1:ncol), intent(In) :: wm
      integer, intent(In) :: ngc
      real(kind=8), dimension(1:maxngc), intent(In) :: enln
      real(kind=8), intent(In) :: ennl
      integer, intent(In) :: ng
      integer, intent(In) :: nfz
      real(kind=8), dimension(1:maxel,1:maxngc), intent(In) :: a
      integer, intent(In) :: ntape
      real(kind=8), intent(In) :: tt
      real(kind=8), intent(In) :: tln
      logical, intent(In) :: ions
      real(kind=8), intent(In) :: boltz
      real(kind=8), intent(In) :: avgdr
      real(kind=8), intent(In) :: pi
      real(kind=8), intent(In) :: rr
      real(kind=8), dimension(1:maxngc), intent(In) :: cp
      integer, intent(In) :: nlm
      real(kind=8), intent(In) :: viscns
      integer, intent(Out) :: msing
      integer :: i
      integer :: i1
      integer :: j
      integer :: jj
      integer :: k
      integer :: m
      integer :: mm
      integer :: nlmm
      integer :: nmm
      real(kind=8) :: cpreac
      real(kind=8), dimension(1:maxtr) :: delh
      real(kind=8), dimension(1:maxmat,1:maxmat+1) :: gmat
      real(kind=8), dimension(1:maxtr,1:maxtr) :: phi
      real(kind=8), dimension(1:maxtr,1:maxtr) :: psi
      real(kind=8) :: reacon
      real(kind=8), dimension(1:maxtr,1:maxtr) :: rtpd
      real(kind=8), dimension(1:maxtr) :: stx
      real(kind=8), dimension(1:maxtr,1:maxtr) :: stxij
      real(kind=8) :: sumc
      real(kind=8) :: sumv
      real(kind=8) :: wtmol
      real(kind=8), dimension(1:maxtr,1:maxtr) :: xskm
      real(kind=8) :: dabs
      save cpreac,delh,gmat,i,i1,j,jj,k,m,mm,nlmm,nmm,phi,psi,reacon,  rtpd,stx,stxij,sumc,sumv,wtmol,xskm
      call tranin(eql,shock,nm,xs,wmol,ind,incdeq,npt,nreac,jray,mw,en,wm,lsave,jcm,ngc,enln,ennl,ng,nfz,nr,stc,a,con,eta,ntape,tt,tln,ions,boltz,avgdr,pi,rr,cprr,cp,nlm,viscns)
      nmm = nm - 1
      do i = 1,nm
        rtpd(i,i) = 0.d0
        phi(i,i) = 1.d0
        psi(i,i) = 1.d0
      enddo
      confro(npt) = 0.d0
      vis(npt) = 0.d0
      do i = 1,nmm
        i1 = i + 1
        do j = i1,nm
          sumc = 2.d0/(eta(i,j)*(wmol(i)+wmol(j)))
          phi(i,j) = sumc*wmol(j)*eta(i,i)
          phi(j,i) = sumc*wmol(i)*eta(j,j)
          sumc = (wmol(i)+wmol(j))**2
          psi(i,j) = phi(i,j)               *(1.d0+2.41d0*(wmol(i)-wmol(j))*(wmol(i)-.142d0*               wmol(j))/sumc)
          psi(j,i) = phi(j,i)               *(1.d0+2.41d0*(wmol(j)-wmol(i))*(wmol(j)-.142d0*               wmol(i))/sumc)
        enddo
      enddo
      do i = 1,nm
        sumc = 0.d0
        sumv = 0.d0
        do j = 1,nm
          sumc = sumc + psi(i,j)*xs(j)
          sumv = sumv + phi(i,j)*xs(j)
        enddo
        vis(npt) = vis(npt) + eta(i,i)*xs(i)/sumv
        confro(npt) = confro(npt) + con(i)*xs(i)/sumc
      enddo
      if ( eql.and.nr > 0 ) then
        m = nr + 1
        do i = 1,nr
          delh(i) = 0.0d0
          do k = 1,lsave
            j = jcm(k)
            delh(i) = stc(i,k)*h0(j) + delh(i)
          enddo
          nlmm = lsave + 1
          do k = nlmm,nm
            j = ind(k)
            delh(i) = stc(i,k)*h0(j) + delh(i)
          enddo
          g(i,m) = delh(i)
        enddo
        do i = 1,maxtr
          do j = 1,maxtr
            if ( dabs(stc(i,j)) < 1.0d-6 ) stc(i,j) = 0.0d0
          enddo
        enddo
        jj = nm - 1
        do k = 1,jj
          mm = k + 1
          do m = mm,nm
            rtpd(k,m) = wmol(k)*wmol(m)/(1.1*eta(k,m)*(wmol(k)+wmol(m)))
            xskm(k,m) = xs(k)*xs(m)
            xskm(m,k) = xskm(k,m)
            rtpd(m,k) = rtpd(k,m)
          enddo
        enddo
        do i = 1,nr
          do j = i,nr
            g(i,j) = 0.0d0
            gmat(i,j) = 0.0d0
          enddo
        enddo
        do k = 1,jj
          mm = k + 1
          do m = mm,nm
            if ( xs(k) >= 1.0d-10.and.xs(m) >= 1.0d-10 ) then
              do j = 1,nr
                if ( (stc(j,k) == 0.d0).and.(stc(j,m) == 0.d0) ) stx(j)               = 0.d0
                if ( (stc(j,k) /= 0.d0).or.(stc(j,m) /= 0.d0) ) stx(j)               = xs(m)*stc(j,k) - xs(k)*stc(j,m)
              enddo
              do i = 1,nr
                do j = i,nr
                  stxij(i,j) = stx(i)*stx(j)/xskm(k,m)
                  g(i,j) = g(i,j) + stxij(i,j)
                  gmat(i,j) = gmat(i,j) + stxij(i,j)*rtpd(k,m)
                enddo
              enddo
            endif
          enddo
        enddo
        m = 1 + nr
        do i = 1,nr
          do j = i,nr
            g(j,i) = g(i,j)
          enddo
          g(i,m) = delh(i)
        enddo
        imat = nr
        call gauss(imat,g,msing,x)
        cpreac = 0.d0
        do i = 1,nr
          g(i,m) = delh(i)
          cpreac = cpreac + r*delh(i)*x(i)
          do j = i,nr
            g(i,j) = gmat(i,j)
            g(j,i) = g(i,j)
          enddo
        enddo
        call gauss(imat,g,msing,x)
        reacon = 0.d0
        do i = 1,nr
          reacon = reacon + r*delh(i)*x(i)
        enddo
        reacon = .6d0*reacon
      else
        cpreac = 0.d0
        reacon = 0.d0
      endif
      cpfro(npt) = 0.d0
      wtmol = 0.d0
      do i = 1,nm
        cpfro(npt) = cpfro(npt) + xs(i)*cprr(i)
        wtmol = wtmol + xs(i)*wmol(i)
      enddo
      cpfro(npt) = cpfro(npt)*r/wtmol
      confro(npt) = confro(npt)/1000.d0
      if ( .not.siunit ) confro(npt) = confro(npt)/4.184d0
      vis(npt) = vis(npt)/1000.d0
      prfro(npt) = vis(npt)*cpfro(npt)/confro(npt)
      if ( eql ) then
        cpreac = cpreac/wtmol
        reacon = reacon/1000.d0
        cpeql(npt) = cpreac + cpfro(npt)
        coneql(npt) = confro(npt) + reacon
        preql(npt) = vis(npt)*cpeql(npt)/coneql(npt)
      endif
      end subroutine tranp
      subroutine utherm(readok,thdate)
      use params_cea_inc, only : iosch, ioout, iothm, ioinp
      implicit none
      character(len=10) :: thdate
      real :: err
      logical, intent(Out) :: readok
      character(len=15) :: name
      character(len=16) :: namee
      character(len=65) :: notes
      character(len=2), dimension(1:5) :: sym
      character(len=6) :: date
      integer :: i
      integer :: ifaz
      integer :: ifzm1
      integer :: inew
      integer :: int
      integer :: j
      integer :: k
      integer :: kk
      integer :: l
      integer :: nall
      integer :: ncoef
      integer :: ngl
      integer :: ns
      integer :: ntl
      integer :: index
      logical, dimension(1:3) :: fill
      real(kind=8) :: aa
      real(kind=8) :: atms
      real(kind=8) :: cpfix
      real(kind=8) :: dlt
      real(kind=8), dimension(1:8) :: expn
      real(kind=8), dimension(1:5) :: fno
      real(kind=8) :: hform
      real(kind=8) :: hh
      real(kind=8) :: mwt
      real(kind=8), dimension(1:9) :: templ
      real(kind=8) :: tex
      real(kind=8), dimension(1:4) :: tgl
      real(kind=8), dimension(1:9,1:3) :: thermo
      real(kind=8) :: tinf
      real(kind=8), dimension(1:2) :: tl
      real(kind=8) :: ttl
      real(kind=8) :: tx
      real(kind=8) :: dble
      real(kind=8) :: dlog
      ngl = 0
      ns = 0
      nall = 0
      ifzm1 = 0
      inew = 0
      tinf = 1.d06
      rewind iosch
      read (ioinp,99001) tgl,thdate
 100  do i = 1,3
        fill(i) = .true.
        do j = 1,9
          thermo(j,i) = 0.
        enddo
      enddo
      hform = 0.
      tl(1) = 0.
      tl(2) = 0.
      read (ioinp,99002,end=300,err=400) name,notes
      if ( name(:3) == 'END'.or.name(:3) == 'end' ) then
        if ( index(name,'ROD') == 0.and.index(name,'rod') == 0 )       goto 300
        ns = nall
        goto 100
      endif
      read (ioinp,99003,err=400) ntl,date,(sym(j),fno(j),j=1,5),                 ifaz,mwt,hform
      write (ioout,99004) name,date,hform,notes
      if ( ntl == 0 ) then
        if ( ns == 0 ) goto 300
        nall = nall + 1
        read (ioinp,99005,err=400) tl,ncoef,expn,hh
        thermo(1,1) = hform
        write (iosch) name,ntl,date,(sym(j),fno(j),j=1,5),ifaz,tl,mwt,                thermo
        goto 100
      elseif ( name == 'Air' ) then
        sym(1) = 'N'
        fno(1) = 1.56168d0
        sym(2) = 'O'
        fno(2) = .419590d0
        sym(3) = 'AR'
        fno(3) = .009365d0
        sym(4) = 'C'
        fno(4) = .000319d0
      elseif ( name == 'e-' ) then
        mwt = 5.48579903d-04
      endif
      do i = 1,ntl
        read (ioinp,99005,err=400) tl,ncoef,expn,hh
        read (ioinp,99006,err=400) templ
        if ( ifaz == 0.and.i > 3 ) goto 400
        if ( ifaz <= 0 ) then
          if ( tl(2) > tgl(4)-.01d0 ) then
            ifaz = -1
            namee = '*'//name
            name = namee(:15)
          endif
          if ( tl(1) >= tgl(i+1) ) goto 200
          int = i
          fill(i) = .false.
        else
          int = 1
          if ( i > 1 ) then
            do k = 1,7
              thermo(k,1) = 0.d0
            enddo
          endif
        endif
        do l = 1,ncoef
          do k = 1,7
            if ( expn(l) == dble(k-3) ) then
              thermo(k,int) = templ(l)
              goto 150
            endif
          enddo
 150    continue
      end do
        thermo(8,int) = templ(8)
        thermo(9,int) = templ(9)
        if ( ifaz > 0 ) then
          nall = nall + 1
          if ( ifaz > ifzm1 ) then
            inew = inew + 1
          else
            inew = i
          endif
          write (iosch) name,ntl,date,(sym(j),fno(j),j=1,5),inew,tl,mwt,                  thermo
        endif
 200  continue
      end do
      ifzm1 = ifaz
      if ( ifaz <= 0 ) then
        inew = 0
        nall = nall + 1
        if ( ifaz <= 0.and.ns == 0 ) then
          ngl = ngl + 1
          if ( fill(3) ) then
            atms = 0.
            do i = 1,5
              if ( sym(i) == ' '.or.sym(i) == 'E' ) goto 210
              atms = atms + fno(i)
            enddo
 210        aa = 2.5d0
            if ( atms > 1.9 ) aa = 4.5d0
            if ( atms > 2.1 ) aa = 3.*atms - 1.75d0
            ttl = tl(2)
            tx = ttl - tinf
            cpfix = 0
            templ(8) = 0.
            templ(9) = 0.
            dlt = dlog(ttl)
            do k = 7,1, - 1
              kk = k - 3
              if ( kk == 0 ) then
                cpfix = cpfix + thermo(k,2)
                templ(8) = templ(8) + thermo(k,2)
                templ(9) = templ(9) + thermo(k,2)*dlt
              else
                tex = ttl**kk
                cpfix = cpfix + thermo(k,2)*tex
                templ(9) = templ(9) + thermo(k,2)*tex/kk
                if ( kk == -1 ) then
                  templ(8) = templ(8) + thermo(k,2)*dlt/ttl
                else
                  templ(8) = templ(8) + thermo(k,2)*tex/(kk+1)
                endif
              endif
            enddo
            templ(2) = (cpfix-aa)/tx
            thermo(4,3) = templ(2)
            templ(1) = cpfix - ttl*templ(2)
            thermo(3,3) = templ(1)
            thermo(8,3) = thermo(8,2)                    + ttl*(templ(8)-templ(1)-.5*templ(2)*ttl)
            thermo(9,3) = -templ(1)*dlt + thermo(9,2) + templ(9)                    - templ(2)*ttl
          endif
        endif
        write (iosch) name,ntl,date,(sym(j),fno(j),j=1,5),ifaz,tl,mwt,                thermo
      endif
      goto 100
 300  rewind iosch
      if ( ns == 0 ) ns = nall
      write (iothm) tgl,ngl,ns,nall,thdate
      if ( ngl /= 0 ) then
        do i = 1,ns
          read (iosch) name,ntl,date,(sym(j),fno(j),j=1,5),ifaz,tl,mwt,                 thermo
          if ( ifaz <= 0 ) write (iothm) name,ntl,date,                            (sym(j),fno(j),j=1,5),ifaz,tl,mwt,                            thermo
        enddo
      endif
      if ( ngl /= nall ) then
        rewind iosch
        do i = 1,nall
          read (iosch) name,ntl,date,(sym(j),fno(j),j=1,5),ifaz,tl,mwt,                 thermo
          if ( i > ns ) then
            write (iothm) name,ntl,date,(sym(j),fno(j),j=1,5),ifaz,tl,                    mwt,thermo(1,1)
            if ( ntl > 0 ) write (iothm) thermo
          elseif ( ifaz > 0 ) then
            write (iothm) name,ntl,date,(sym(j),fno(j),j=1,5),ifaz,tl,                    mwt,(thermo(k,1),k=1,9)
          endif
        enddo
      endif
      return
 400  write (ioout,99007) name
      readok = .false.
      return
99001 format (4f10.3,a10)
99002 format (a15,a65)
99003 format (i2,1x,a6,1x,5(a2,f6.2),i2,f13.5,f15.3)
99004 format (' ',a15,2x,a6,e15.6,2x,a65)
99005 format (2f11.3,i1,8f5.1,2x,f15.3)
99006 format (5d16.8/2d16.8,16x,2d16.8)
99007 format (/' ERROR IN PROCESSING thermo.inp AT OR NEAR ',a15,        ' (UTHERM)')
      end subroutine utherm
      subroutine utran(readok)
      use params_cea_inc, only : ioout, iotrn, iosch, ioinp
      implicit none
      real :: err
      logical, intent(Out) :: readok
      character(len=16), dimension(1:2) :: tname
      character(len=1) :: vorc
      integer :: i
      integer :: ic
      integer :: in
      integer :: iv
      integer :: j
      integer :: k
      integer :: ncc
      integer :: nn
      integer :: ns
      integer :: nv
      real(kind=8) :: cc
      real(kind=8), dimension(1:36) :: tc
      real(kind=8), dimension(1:6) :: tcin
      real(kind=8), dimension(1:6,1:3,1:2) :: trcoef
      real(kind=8) :: vvl
      trcoef(1,1,1) = tc(1)
      ns = 0
      rewind iosch
 100  do i = 1,36
        tc(i) = 0.
      trcoef(1,1,1) = tc(1)
      enddo
      read (ioinp,99001) tname,vvl,nv,cc,ncc
      if ( tname(1) == 'end'.or.tname(1) == 'LAST' ) then
        write (iotrn) ns
        rewind iosch
        do i = 1,ns
          read (iosch,err=200) tname,trcoef
      tc(1) = trcoef(1,1,1)
          write (iotrn) tname,trcoef
        enddo
        goto 300
      else
        ic = 0
        iv = 0
        nn = nv + ncc
        if ( nv <= 3.and.ncc <= 3 ) then
          do in = 1,nn
            read (ioinp,99002) vorc,tcin
            if ( vorc == 'C' ) then
              k = 2
              ic = ic + 1
              j = ic
            else
              k = 1
              iv = iv + 1
              j = iv
            endif
            if ( j > 3 ) goto 200
            do i = 1,6
              trcoef(i,j,k) = tcin(i)
      tc(1) = trcoef(1,1,1)
            enddo
          enddo
          ns = ns + 1
          write (iosch) tname,trcoef
          goto 100
        endif
      endif
 200  write (ioout,99003) tname
      readok = .false.
 300  return
99001 format (2a16,2x,a1,i1,a1,i1)
99002 format (1x,a1,2f9.2,4e15.8)
99003 format (/' ERROR IN PROCESSING trans.inp AT OR NEAR (UTRAN)',/1x,        2a16)
      end subroutine utran
      subroutine varfmt(vx,npt,fmt)
      use params_cea_inc, only : ncol
      implicit none
      integer, intent(In) :: npt
      character(len=4), dimension(1:30), intent(Out) :: fmt
      real(kind=8), dimension(1:ncol), intent(In) :: vx
      integer :: i
      integer :: k
      real(kind=8) :: vi
      real(kind=8) :: dabs
      save i,k,vi
      do i = 1,npt
        vi = dabs(vx(i))
        k = 2*i + 3
        fmt(k) = '5,'
        if ( vi >= 1. ) fmt(k) = '4,'
        if ( vi >= 10. ) fmt(k) = '3,'
        if ( vi >= 100. ) fmt(k) = '2,'
        if ( vi >= 10000. ) fmt(k) = '1,'
        if ( vi >= 1000000. ) fmt(k) = '0,'
      enddo
      fmt(29)(2:) = ' '
      end subroutine varfmt

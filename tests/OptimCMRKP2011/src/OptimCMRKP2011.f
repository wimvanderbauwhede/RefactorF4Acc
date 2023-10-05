c     26/02/2011 Nueva funci�n objetivo y agregado de posibles KP extra (ver common EXTRAKP)
c
c	versi�n del 20/03/2010 combinando las �ltimas mejoras previas con una actualizaci�n de la Funci�n Objetivo, 
c	para dar mas peso a las fases livianas: t�rminos 11 a 15 (parte LLV)
c											t�rminos FV(jf+1) y FV(jf+3) en el DO NTP
c	Al 30/09/2010: agregando Type I
c	Al  3/11/2010: agregados Type II & IV
c
      program OptimBinSys   ! *** now Program declaration is in OptimCallsBinSys.for
c	USE IMSL
      implicit double precision (A-H,O-Z)
C      INCLUDE 'mkl_rci.fi'
      CHARACTER*250 INFILE,OUTFILE 
      COMMON/UNITS/NUNIT,NOUT,idata,ipar,idel
	COMMON /CASEOPT/ NCASE
      COMMON/EXTRAK/ IntCri, PcInt, XcInt, TcInt, islope, T9art
      COMMON/UNITAUX/NOUT2
       nout2=8
       nunit=1
       nout=9
      WRITE (6,*) 'ENTER INFILE'
      READ (5,'(A)') INFILE
C      INFILE='CMRCO2C13.DAT'
C      OUTFILE='AUXAUX.DAT'
      OPEN(NUNIT,FILE=INFILE)
C
      WRITE (6,*) 'ENTER A NAME FOR THE OUTFILE'
      READ (5,'(A)') OUTFILE
      OPEN(NOUT,FILE=OUTFILE)
      OPEN(NOUT2,FILE='AUXOUT.DAT')
c
      WRITE (6,*) 'SPECIFY TYPE AND KEY POINTS'
      WRITE (6,*) ' 1: I   (Pc(T) & Xc(T))'
      WRITE (6,*) ' 2: II  (LLV, Tucep & Pc(T))'
      WRITE (6,*) ' 3: III (LLV, Tk, T994, Tm, PCPm & P393)'
      WRITE (6,*) ' 4: IV  (LLV, TUCEP, TLCEP, Tk, Pc(T))'
      WRITE (6,*) ' 5: V   (LLV, TLCEP, Tk, Pc(T))'   ! added 09/01/2013
	READ (5,*)NCASE
	islope=0
	IF (NCASE==2.or.NCASE==4) THEN
          WRITE (6,*) ' Use of extrapolated T994?'
          WRITE (6,*) ' 1 for YES'
	    READ (5,*)islope
	END IF
	read(NUNIT,*)N,idata	! number of parameters to optimize
	call OptimCMRKP (N)
      WRITE (6,*) ' Optimization performed succesfully. Press enter.'
	READ (5,*)file
C
	close (unit=nunit)
      close (unit=nout)
      close (unit=nout2)
      END
c
      SUBROUTINE OptimCMRKP (N)
      PARAMETER (nco=2)
      implicit double precision (A-H,O-Z)
C
	DOUBLE PRECISION Kij(nco,nco),Kinf,Kinf1,Kinf2,K01,K02
      DIMENSION X(N), XGUESS(N), XGUES4(4)
C      DIMENSION IPARAM(7), RPARAM(7), XLB(N), XSCALE(N), XUB(N)
	dimension ac(nco),b(nco),del1(nco),rk(nco),om(nco)
c      REAL       F, FSCALE
c      EXTERNAL   BCONF, ObjFun, UMACH
	COMMON/CASEOPT/ NCASE, NK
	COMMON/fixed/ nchange 
      COMMON/EXTRAK/ IntCri, PcInt, XcInt, TcInt, islope, T9art
      COMMON/UNITS/NUNIT,NOUT,idata,ipar,idel
	COMMON /MODEL/ NMODEL
      COMMON/CRIT/TC(nco),PC(nco),DC(nco)
	COMMON /Kcubic/Kinf1,Kinf2,K01,K02,Tstar1,Tstar2,C1,C2
	COMMON/DAT/DAT(32)
	COMMON/KeyT1/TcLV
	COMMON/KeyTa/Ta,Taint
	COMMON/KeyLLV/Tlow,Tmid
	COMMON/Key2Ph/NTP,T2p(16),P2p(16)
	COMMON/KeyIsop/NzP,NzT,IZv(15),PTsat(15),Xis(15),Yis(15)
	COMMON/KeyFUG/NFUG,Tfug(40),Pfug(40),X1fug(40),Y1fug(40)  
	COMMON/PmaxLL/Phigh
	COMMON /rule/ncomb,iRuleDel
	COMMON /COMPONENTS/ ac,b,del1,rk,Kij,NTDEP
	COMMON /sDDLC/q(nco),nqopt
 	COMMON /Tdep/ Kinf,Tstar
 	COMMON /acentric2/ om2
	DATA FSCALE/1.0E0/
	EXTERNAL F    ! ObjFun
	XSCALE=1.0E0
	read(NUNIT,*)ipar 
C     npar  ipar    Params to be optimized
c     1     0       Kij0 (scan)
c     1     1       Lij  (scan)
C     2 	0       Kij' and KijInf
C     2     1       Kij0 and Lij
C     3 	0       Kij'  ,  KijInf and Lij
	read(NUNIT,*)NMODEL
	IF(NMODEL.LE.2)THEN
C	SRK or PR
		CALL read2Pcubic(nunit,nout)
	ELSE IF (NMODEL.EQ.3) THEN
		CALL readcomp(nunit,nout)
 	ELSE IF (NMODEL.EQ.4) THEN
C		CALL readPCSAFT(nunit,nout)
 	ELSE IF (NMODEL.EQ.6) THEN
C		CALL readSPHCT(nunit,nout)
	ELSE	!	GC-EOS (or GCA)
		NG=NGR
C		CALL readGC(nunit,nout)
		x(2)=1.0d-10
		x(1)=1.0d0-x(2)
		T=TC(1)
C		CALL PARAGC(T,2,NG,1)      
		P=PC(1)
		CALL VCALC(-1,2,x,T,P,V)      
		NS=1
		delXS=0.0d0
		CALL XTVnewtonCrit(NOUT,NS,delXS,X,T,V)
c		TCGC(1)=T
		DC(1)=1/V
		PC(1)=PCGC
		x(1)=1.0d-10
		x(2)=1.0d0-x(1)
		T=TC(2)
c		CALL PARAGC(T,2,NG,1)      
		P=PC(2)
		CALL VCALC(1,2,x,T,P,V)      
		CALL XTVnewtonCrit(NOUT,NS,delXS,X,T,V)
c		TCGC(2)=T
		DC(2)=1/V
		PC(2)=PCGC
	END IF
	read(NUNIT,*)Phigh
	IF(NCASE==1)THEN
		NK=2
        WRITE (6,*) ' Azeotropy?'
        WRITE (6,*) ' 1 for YES: 2 sets Pa, Xa for specified T'
        READ (5,*)nazeot
        if(nazeot==1)NK=6
	ELSE IF(NCASE==2)THEN
		NK=5
	ELSE IF(NCASE==3)THEN
		NK=10
	ELSE IF(NCASE==4)THEN
		NK=8
	ELSE IF(NCASE==5)THEN
		NK=8  ! 7 real ones
	END IF
	IF (ncomb==3) THEN
c CMR
		if(N.ge.6)then	! T dependence for K parameters
			XGUESS(1:4)=[K01,K02,Kinf1,Kinf2]
			READ(NUNIT,*) XGUESS(5:6)	!L112,L122
			if(N.eq.8) XGUESS(7:8)=[Tstar1,Tstar2]*1.0D-3
		else	! N=4 (k112,k122,l112,l122)
			XGUESS(1:2)=[K01,K02]
			READ(NUNIT,*) XGUESS(3:4)	!L112,L122
		end if
	ELSEIF (ncomb==2) THEN
c s-DDLC
        WRITE (6,*) ' Optimize q2?'
        WRITE (6,*) ' 1 for YES'
        READ (5,*)nqopt
        if(nqopt==1)then
            n3int=4
            XGUESS(N)=q(2)/100.0d0
        else
            n3int=3
        end if
		if(N.ge.n3int)then	! T dependence for K parameter
			XGUESS(1:2)=[Kij(1,2),Kinf]
			READ(NUNIT,*) XGUESS(3)	!L12
			if(N.eq.n3int+1) XGUESS(n3int+1)=Tstar*1.0D-3
		else	! N=2 (k12,l12)  or 3(adding q)
			XGUESS(1)=Kij(1,2)
			READ(NUNIT,*) XGUESS(2)	!L12
		end if
	ELSE
c QMR
		if(ipar == 0)then	! T dependence for K parameter   old: if(N.ge.3)
			if(N > 1)XGUESS(1:2)=[Kij(1,2),Kinf]
			if(N.eq.1) then ! option for K' or K0 (added sept 2017)
                WRITE (6,*) ' Optimizing K0'
			    WRITE(NOUT,*) '   K012       F'
			    XGUESS(1)=Kij(1,2)
	          read(NUNIT,*)om2
			else if(N.eq.2) then ! option for del1(comp2) instead of lij (added sept 2017)
                WRITE (6,*) ' Enter 0 to Optimize [K0 Lij]'
                WRITE (6,*) '            or 1 for [K0 d1(2)]'
                WRITE (6,*) '            or 2 for [K0 mij]'
                WRITE (6,*) '            or 3 for [K0 Kinf]'
                READ (5,*)idel
                if (idel==0)then
			        READ(NUNIT,*) XGUESS(2) ! L12
			    else if (idel==1)then
			        XGUESS(2) = del1(2)
	              read(NUNIT,*)om2
			    else if (idel==2)then
			        READ(NUNIT,*) XGUESS(2) ! m12
			    end if
			else if(N.ge.3) then ! option for del1(comp2) instead of lij (changed june 2017)
                WRITE (6,*) ' Enter 0 to Optimize [K0 Kinf Lij]'
                WRITE (6,*) '            or 1 for [K0 Kinf d1(2)]'
                WRITE (6,*) '            or 2 for [K0 Kinf  mij]'
                WRITE (6,*) '            or 3 for [K0 d1(2) mij]'
                READ (5,*)idel
                if (idel==0)then
			        READ(NUNIT,*) XGUESS(3) ! L12
			    else if (idel==1)then
			        XGUESS(3) = del1(2)
	              read(NUNIT,*)om2
			    else
	              if (idel==3)read(NUNIT,*)om2
			        READ(NUNIT,*) XGUESS(3) ! m12
			        if (idel==3)XGUESS(2) = del1(2)
			    end if
			end if
			if(N.eq.4) XGUESS(4)=Tstar*1.0D-3
		else if(N.ge.2)then	! N=2 (k12,l12)
			XGUESS(1)=Kij(1,2)
			READ(NUNIT,*) XGUESS(2)	!L12
		else	! N=1 (l12)
            WRITE(NOUT,*) '   L12     F'
			READ(NUNIT,*) XGUESS(1)	!L12
            read(NUNIT,*)om2
		end if
	END IF
c
	if(idata.eq.1)then
		! Case  I  (NK=2): Pc(T), Xc(T) [possible second Pc, Xc after NFUG]
		! Case  II (NK=5): Pc(T), Xc(T),Xlo,Ylo,Tu
		! Case III(NK=10): T994,Tm,Pm,P393,Tu,Xu,Xlo,Ylo   (NKeffective=8, NK=10 with Xmi,Ymi)
		! Case  IV (NK=8): Pc(T), Xc(T),Xlo,Ylo,Tu,TL,Tk,xk
		! Case  V  (NK=7): Pc(T), Xc(T),Xlo,Ylo,TL,Tk,xk        ! added 09/01/2013
		! the number of compositional key-points is (NK+1)/2 truncated in each case
		do I=1,NK	
			read(NUNIT,*)DAT(i)
		end do
		IF(NCASE==3)THEN
			read(NUNIT,*)Tlow
			read(NUNIT,*)Tmid
		ELSE
			read(NUNIT,*)TcLV
		    IF(NCASE>1)read(NUNIT,*)Tlow
		    IF(NCASE==1.and.NK==6)THEN  ! case NC=2
			    read(NUNIT,*)Ta
			    read(NUNIT,*)TaInt
		    END IF
		END IF
	end if

	read(NUNIT,*)NTP
	do I=1,NTP
		j=idata*NK+2*(I-1)+1
		read(NUNIT,*)T2p(i),P2p(i),DAT(j),DAT(j+1)
	end do
	read(NUNIT,*)NzP
	do I=1,NzP
		j=idata*NK+2*NTP+i
		read(NUNIT,*)DAT(j),PTsat(i),Xis(i),Yis(i),IZv(i)	! here PTsat(i) stores a spec. P value
	end do
	read(NUNIT,*)NzT
	do I=NzP+1,NzP+NzT
		j=idata*NK+2*NTP+i
		read(NUNIT,*)PTsat(i),DAT(j),Xis(i),Yis(i),IZv(i)	! here PTsat(i) stores a spec. T value
	end do
	read(NUNIT,*)NFUG
	do I=1,NFUG
		read(NUNIT,*)Tfug(i),Pfug(i),X1fug(i),Y1fug(i)
	end do
	if (idata>0) read(NUNIT,*)IntCri
	if (IntCri == 1) then
		read(NUNIT,*)PcInt
		read(NUNIT,*)XcInt
		read(NUNIT,*)TcInt
	end if
	if (islope == 1) then
		read(NUNIT,*)T9art
	end if
	
c				
	if(N.eq.8)then
		WRITE(NOUT,*) '    K01      K02     Kinf1    Kinf2
	1   L112     L122     Tstar1   Tstar2    F'
	else if(N.eq.6)then
		WRITE(NOUT,*) '    K01      K02     Kinf1    Kinf2
	1   L112     L122      F'
	else if(N.eq.4)then
		WRITE(NOUT,*) '   K112     K122     L112     L122      F'
	else if(N.eq.3)then
		if(ncomb==2)WRITE(NOUT,*) '   K12     L12      q2      F'
		if(ncomb==0.and.idel==0)WRITE(NOUT,*) '   K12     Kinf     L12     F'
		if(ncomb==0.and.idel==1)WRITE(NOUT,*) '   K12     Kinf   del1(2)   F'
		if(ncomb==0.and.idel==2)WRITE(NOUT,*) '   K12     Kinf     m12     F'
		if(ncomb==0.and.idel==3)WRITE(NOUT,*) '   K12     del1(2)  m12     F'
	else
		if(ipar == 0)then
		    if (idel==0) WRITE(NOUT,*) '   K12    K12inf    F'
		    if (idel==1) WRITE(NOUT,*) '   K12    del1(2)   F'
		    if (idel==1) read(NUNIT,*) om2
		    if (idel==2) WRITE(NOUT,*) '   K12      m12     F'
		else
		    WRITE(NOUT,*) '   K12     L12      F'
		end if
	end if

	! sweep: block
	! ! Block of code to do a sweep over two parameters of the objective function
	! integer :: var_1, var_2, funit
	! real(8) :: fval
	! open(newunit=funit, file="sweep")
	! if (n == 2) then
	! 	do var_1=-250, 250
	! 		do var_2=-250,250
	! 			XGUESS = [var_1, var_2]/500.d0
	! 			fval = F(XGUESS, N)   ! SUBROUTINE ObjFun (N, X, F)
	! 			write(funit, "(3(E15.5))") XGUESS(1), XGUESS(2), fval
	! 		end do
	! 		write(funit, *) ""
	! 	end do
	! end if
	! close(funit)
	! end block sweep
	! call exit

      if (N==1) then ! armado para Lij 8/9/2014 (valid also for K0 12/9/2017)
  7     WRITE(NOUT,*) ' d1 for comp2: ',del1(2)
        rmin=XGUESS(1)-0.01
        rmax=XGUESS(1)+0.01
        do rl=rmin,rmax,0.001
            XGUESS(1)=rl
            OF = F(XGUESS, N)  ! write(NOUT,*) 
        end do
        WRITE (6,*) ' Another d1 for heavy comp?  1 for YES' ! added 14/11/2014 to allow various e.g. C60 on a single run
        READ (5,*)nreply
        if(nreply==1)then
            WRITE (6,*) ' Enter new del1'
            READ (5,*)del1(2)
	      call paramsfromdelta1(del1(2),Tc(2),Pc(2),om2,
     &                                    ac(2),b(2),rk(2),Dc(2))
            WRITE (6,*) ' Enter central Lij to define range'
            READ (5,*)XGUESS(1)
            go to 7
        end if
        return
      end if
      
      nchange = 0
      if(N==8)then
          WRITE (6,*) ' Only 4 parameters free?'
          WRITE (6,*) ' 1 for YES, leave free K02,L112,L122,T*2'
          WRITE (6,*) ' 2 for YES, leave free K01,K02,L112,L122'
          WRITE (6,*) ' otherwise, 8 parameters free'
	    READ (5,*)nchange
      end if

      if (nchange==1)then
         Nfree = 4
		 Tstar1=1.0D3*XGUESS(7)
         XGUES4 = [K02,XGUESS(5:6),XGUESS(8)] 	! XGUESS(5:6)=L112,L122
		 WRITE(NOUT,*) '    K02     L112     L122     Tstar2    F'
         Fmin = PRAXIS(3.D-5,2.22D-16,5.D-4,Nfree,3,XGUES4,F,1D-2)
         XGUESS = [K01,XGUES4(1),Kinf1,Kinf2,XGUES4(2:3),
     1              XGUESS(7),XGUES4(4)]  ! for printing the solution
      elseif (nchange==2)then
         Nfree = 4
		 Tstar1=1.0D3*XGUESS(7)
		 Tstar2=1.0D3*XGUESS(8)
         XGUES4 = [K01,K02,XGUESS(5:6)] 	! XGUESS(5:6)=L112,L122
		 WRITE(NOUT,*) '    K01     K02      L112     L122      F'
         Fmin = PRAXIS(3.D-5,2.22D-16,1.D-4,Nfree,3,XGUES4,F,1D-2)
         XGUESS = [XGUES4(1:2),Kinf1,Kinf2,XGUES4(3:4),
     1              XGUESS(7:8)]  ! for printing the solution
      else
c            PRAXIS( T0 , MACHEP , H0, N,PRIN, X, F,FMIN)
		print *, "X0: ", xguess
		print *, "F0: ", f(xguess, n)
		call nm_opt(xguess, n, i_stat)
		write(nout, "(G)") "NM: ", xguess, "F: ", f(xguess, n)
		if (i_stat /= 1) then
		print *, "PRAXIS", xguess
		 ! call exit
      	Fmin = PRAXIS(3.D-5,2.22D-16,1.D-7,N,3,XGUESS,F,fmin)
		end if
      end if
C
C      call MKL_Optimize(N,XGUESS)
c      ITP = 0			!     All the bounds are provided
C      IPARAM(1) = 0	!     Default parameters are used
c	CALL DU4INF (IPARAM, RPARAM)
c	IPARAM(2) = 9
C	RPARAM(6) = 1.0d-1
c	IF(NFUG.GT.0)THEN
c		RPARAM(6) = 1.0d-1   ! Maximum allowable step size.
c      ELSE
c		RPARAM(6) = N*1.0d-2	!/2   ! Maximum allowable step size.
c	END IF
c	CALL DBCONF (ObjFun, N, XGUESS, ITP, XLB, XUB, XSCALE, FSCALE,
c     &            IPARAM, RPARAM, X, F)

C                                 Print results
c      CALL UMACH (2, NOUT)
	if(N.eq.8)then
          WRITE (NOUT,99998) XGUESS,Fmin 
	else if(N.eq.6)then
          WRITE (NOUT,99999) XGUESS,Fmin 
	else if(N.eq.2)then
          WRITE (NOUT,99992) XGUESS,Fmin 
	else if(N.eq.3)then
          WRITE (NOUT,99993) XGUESS,Fmin 
      end if
C
99999 FORMAT ('  The solution is ', 6X, 6F9.5, //, '  The function ',
     &       'value is ', F9.6)
99998 FORMAT ('  The solution is ', 6X, 8F9.5, //, '  The function ',
     &       'value is ', F9.6)
99992 FORMAT ('  The solution is ', 6X, 2F9.5, //, '  The function ',
     &       'value is ', F10.6)
99993 FORMAT ('  The solution is ', 6X, 3F9.5, //, '  The function ',
     &       'value is ', F10.6)
      END
C
      FUNCTION F(X, N)   ! SUBROUTINE ObjFun (N, X, F)
      PARAMETER (nco=2)
      implicit double precision (A-H,O-Z)
	DOUBLE PRECISION Kij(nco,nco),lij(nco,nco),mij(nco,nco)
	DOUBLE PRECISION Kinf,Kinf1,Kinf2,K01,K02,lijk(nco,nco,nco)
	dimension ac(nco),b(nco),del1(nco),rk(nco)
      DIMENSION		 X(N),FV(60),dfug(2)
      COMMON/UNITS/NUNIT,NOUT,idata,ipar,idel
	COMMON/CASEOPT/ NCASE, NK
	COMMON/fixed/ nchange 
	COMMON /rule/ncomb,iRuleDel
	COMMON /COMPONENTS/ ac,b,del1,rk,Kij,NTDEP
      COMMON/CRIT/TC(nco),PC(nco),DC(nco)
 	COMMON /Tdep/ Kinf,Tstar
	COMMON /sDDLC/q(nco),nqopt
	COMMON /D1cross/D1ij(nco,nco)
	COMMON /bcross/bij(nco,nco)
	COMMON /bcrosscub/bijk(nco,nco,nco)
	COMMON /Kcubic/Kinf1,Kinf2,K01,K02,Tstar1,Tstar2,C1,C2
c	COMMON/COVOL/b(nco)
	COMMON/DAT/DAT(30)
	COMMON/CALC1/Pcr,Xcr
	COMMON/CALCint/Pci,Xci
	COMMON/CALCA/Pa,Xa,Pai,Xai
	COMMON/CALC24/TUCEP,TLCEP
	COMMON/CALC3/T994,Tm,Pm,P393,Tu,Xu,Xlo,Ylo,Xmi,Ymi
      COMMON/EXTRAK/ IntCri, PcInt, XcInt, TcInt, islope, T9art
	COMMON/Key2Ph/NTP,T2p(16),P2p(16)
	COMMON/KeyIsop/NzP,NzT,IZv(15),PTsat(15),Xis(15),Yis(15)
	COMMON/KeyFUG/NFUG,Tfug(40),Pfug(40),X1fug(40),Y1fug(40)
	COMMON/KeyLLV/Tlow,Tmid
 	COMMON /acentric2/ om2
C
	FV=0.0D0
	IF (ncomb==3) THEN
c CMR
		IF (nchange==1)then
		    K02=X(1)
	      Lijk(1,1,2)=x(2)
		    Lijk(1,2,2)=x(3)
      	    Tstar2=1.0D3*X(4)
		ELSEIF (nchange==2)then
		    K01=X(1)
		    K02=X(2)
	      Lijk(1,1,2)=x(3)
		    Lijk(1,2,2)=x(4)
		ELSE
		    K01=X(1)
		    K02=X(2)
		    if(N.ge.6)then	! T dependence for K parameters
			    Kinf1=X(3)
			    Kinf2=X(4)
			    Lijk(1,1,2)=x(5)
			    Lijk(1,2,2)=x(6)
			    if(N.eq.8)then
				    Tstar1=1.0D3*X(7)
				    Tstar2=1.0D3*X(8)
			    end if
		    else	! N=4 (k112,k122,l112,l122)
			    Lijk(1,1,2)=x(3)
			    Lijk(1,2,2)=x(4)
		    end if
		END IF
		do i=1,nco
c		bijk(i,i,i)=b(i)	done already in readcomp
		do j=i+1,nco
			bijk(i,i,j)=(1-lijk(i,i,j))*(2*b(i)+b(j))/3
			bijk(i,j,i)=bijk(i,i,j)
			bijk(j,i,i)=bijk(i,i,j)
			bijk(i,j,j)=(1-lijk(i,j,j))*(b(i)+2*b(j))/3
			bijk(j,i,j)=bijk(i,j,j)
			bijk(j,j,i)=bijk(i,j,j)
		end do
		end do
	ELSEIF (ncomb==2) THEN
c s-DDLC
        if(nqopt==1)then
            n3int=4
            q(2)=100.0d0*X(N)
        else
            n3int=3
		end if
		Kij(1,2)=X(1)
		if(N.ge.n3int)then	! T dependence for K parameter
			Kinf=X(2)
			lij(1,2)=X(3)
			if(N.eq.n3int+1)Tstar=X(4)*1.0D3
		else	! N=2 (k12,l12) or 3(adding q)
			lij(1,2)=X(2)
		end if
		do i=1,nco
		do j=i,nco
			bij(i,j)=(1-lij(i,j))*(b(i)+b(j))/2
			bij(j,i)=bij(i,j)
		end do
		end do
	ELSE
c QMR
		if(N==1)then    ! armado para Lij 9/9/2014
			if(ipar == 0)then
		        Kij(1,2)=X(1)
			else
			    lij(1,2)=X(1)
			end if
		else
		    Kij(1,2)=X(1)
		    if(ipar == 0)then	! T dependence for K parameter
			    if(N.eq.2)then ! option for del1(comp2) instead of lij (added sept 2017)
                    if(idel==0)then
			            lij(1,2)=X(2)
			        else if(idel==1)then
			            dprev = del1(2)
			            del1(2)=X(2)
	                  if(del1(2)/=dprev)
     &                  call paramsfromdelta1(del1(2),Tc(2),Pc(2),om2,
     &                                           ac(2),b(2),rk(2),Dc(2))
		                if(iRuleDel==2)then
		                    do i=1,nco ! added 30/08/2017
		                        do j=i,nco
		                          D1ij(i,j)=(1-mij(i,j))*SQRT(del1(i)*del1(j))
		                            D1ij(j,i)=D1ij(i,j)
		                        end do
		                    end do
		                end if
			        else if(idel==2)then
			            mij(1,2)=X(2)
			        else
      			        Kinf=X(2)
			        end if
			    else if(N.ge.3)then ! option for del1(comp2) instead of lij (changed june 2017)
                    if(idel==3)then
			            dprev = del1(2)
			            del1(2)=X(2)
	                  if(del1(2)/=dprev)
     &                  call paramsfromdelta1(del1(2),Tc(2),Pc(2),om2,
     &                                           ac(2),b(2),rk(2),Dc(2))
                    else
      			        Kinf=X(2)
      			    end if
                    if(idel==0)then
			            lij(1,2)=X(3)
			        elseif(idel==1)then
			            dprev = del1(2)
			            del1(2)=X(3)
	                  if(del1(2)/=dprev)
     &                  call paramsfromdelta1(del1(2),Tc(2),Pc(2),om2,
     &                                           ac(2),b(2),rk(2),Dc(2))
			        else
			            mij(1,2)=X(3)
			        end if
                    if(iRuleDel==2.and.idel>0)then
                        do i=1,nco ! added 30/08/2017
                            do j=i,nco
                            D1ij(i,j)=(1-mij(i,j))*SQRT(del1(i)*del1(j))
                                D1ij(j,i)=D1ij(i,j)
                            end do
                        end do
                    end if
			    end if
			    if(N==4)Tstar=X(4)*1.0D3
		    else	! N=2 (k12,l12)
			    lij(1,2)=X(2)
		    end if
		end if
		if(N.ne.2.or.ipar.ne.0)then    ! armado para Lij 9/9/2014
		    do i=1,nco
		    do j=i,nco
			    bij(i,j)=(1-lij(i,j))*(b(i)+b(j))/2
			    bij(j,i)=bij(i,j)
		    end do
		    end do
		    if(N==3)then
		        if(iRuleDel==2)then
		            do i=1,nco ! added 30/08/2017
		                do j=i,nco
		                    D1ij(i,j)=(1-mij(i,j))*SQRT(del1(i)*del1(j))
		                    D1ij(j,i)=D1ij(i,j)
		                end do
		            end do
		        end if
		    end if
		end if
	END IF
C
	if(idata.eq.0) goto 5
c      WRITE (NOUT,98) (X(L),L=1,N), '(running for)'
	CALL KPfromPAR
c
	IF(NCASE==3)THEN
		FV(1)=(T994-DAT(1))**2/DAT(1)	
		FV(2)=(Tm-DAT(2))**2/DAT(2)	
		FV(3)=(Pm-DAT(3))**2/DAT(3)	
		FV(4)=(P393-DAT(4))**2/DAT(4)	
		if(DAT(5)>100)then  ! Tu and Xu are not used in some cases
		    FV(5)=(Tu-DAT(5))**2/DAT(5)	
		    FV(6)=abs(log(Xu/DAT(6)))
		    FV(11)=abs(log((1.d0-Xu)/(1.d0-DAT(6))))
		endif
		if(Tlow>101)then  ! Xlo and Ylo are not used in cases like C22
		    FV(7)=abs(log(Xlo/DAT(7)))
		    FV(8)=abs(log(Ylo/DAT(8)))
		    FV(12)=abs(log((1.d0-Xlo)/(1.d0-DAT(7))))
		    FV(13)=abs(log((1.d0-Ylo)/(1.d0-DAT(8))))
		endif
c		FV(9)=abs(log(Xmi/DAT(9)))
c		FV(10)=abs(log(Ymi/DAT(10)))
c		FV(14)=abs(log((1.d0-Xmi)/(1.d0-DAT(9))))
c		FV(15)=abs(log((1.d0-Ymi)/(1.d0-DAT(10))))
	ELSE
		FV(1)=(Pcr-DAT(1))**2/DAT(1)	
		FV(2)=abs(log((Xcr/DAT(2))))
		FV(3)=abs(log((1.d0-Xcr)/(1.d0-DAT(2))))
        IF(NCASE==1.and.NK==6)THEN  ! case NC=2
            FV(4)=(Pa-DAT(3))**2/DAT(3)
            FV(5)=abs(log(Xa/DAT(4)))
            FV(6)=abs(log((1.d0-Xa)/(1.d0-DAT(4))))	
            FV(7)=(Pai-DAT(5))**2/DAT(5)
            FV(8)=abs(log(Xai/DAT(6)))
            FV(9)=abs(log((1.d0-Xai)/(1.d0-DAT(6))))	
        END IF
C      	Xlo,Ylo,Tu,TL,Tk,xk
      	IF(NCASE>1)THEN
		    FV(4)=abs(log(Xlo/DAT(3)))
		    FV(5)=abs(log(Ylo/DAT(4)))
		    IF(NCASE.NE.5)FV(6)=(TUCEP-DAT(5))**2/DAT(5)	
		    FV(7)=abs(log((1.d0-Xlo)/(1.d0-DAT(3))))
		    FV(8)=abs(log((1.d0-Ylo)/(1.d0-DAT(4))))
		    IF(NCASE>=4)THEN
		        FV(9)=(TLCEP-DAT(6))**2/DAT(6)	!10*
      		    FV(10)=(Tu-DAT(7))**2/DAT(7)	!10*
		        if (DAT(8)>0.01D0)then
		            FV(11)=abs(log(Xu/DAT(8)))
		            FV(12)=abs(log((1.d0-Xu)/(1.d0-DAT(8))))
		        end if
           	END IF
      	END IF
	    jstd=idata*NK+(NK+1)/2+4*NTP+NzP+NzT+NFUG
	    if (IntCri == 1) then
		    FV(jstd+1)=(Pci-PcInt)**2/PcInt
		    FV(jstd+2)=abs(log((Xci/XcInt)))
		    FV(jstd+3)=abs(log((1.d0-Xci)/(1.d0-XcInt)))
	    end if
	    if (islope == 1) then
		    j=jstd+IntCri*3+1
		    FV(j)=(T994-T9art)**2/T9art/10
	    end if
	END IF
c
 5	if(maxval(FV(1:10)).LT.200.0D0)then !condition: it doesn't help to add these contributions when F is already > 1
		do i=1,NTP
			j=idata*NK+2*(i-1)+1
			jf=j+(NK+1)/2+2*(i-1)
			T=T2p(i)
			P=P2p(i)
			X1ini=DAT(j)
			Y2ini=1.0d0-DAT(j+1)
			sumz=1.0
			k=0
			do while (abs(sumz-1.0d0)<0.01.and.k.lt.10)
				k=k+1
				x1=x1ini
				Y2=Y2ini
				call PTpointBin(P,T,X1,Y2)
				sumz=x1+y2
				x1ini=0.97*x1ini
			end do
			FV(jf)=abs(log(X1/DAT(j))) 
			FV(jf+1)=abs(log((1.0d0-X1)/(1.d0-DAT(j))))
			FV(jf+2)=abs(log((1.0d0-Y2)/DAT(j+1)))
			FV(jf+3)=abs(log(Y2/(1.0d0-DAT(j+1))))
		end do
		do i=1,NzP
			j=idata*NK+2*NTP+i
			jf=j+(NK+1)/2+2*NTP
			Tini=DAT(j)
			Tini0=Tini
			deltaT=-0.01*Tini0
			P=PTsat(i)
			IZ=IZv(i)
			X1=Xis(i)
			Y2=max(1.0d0-Yis(i),1.0d-6)
			if(IZ.EQ.2)x1ini=x1
			if(IZ.EQ.1)Y2ini=Y2
			sumz=1.0
			k=0
			do while (sumz.gt.0.99.and.k.lt.10)
				k=k+1
				T=Tini
				if(IZ.EQ.2)x1=x1ini
				if(IZ.EQ.1)Y2=Y2ini
				call PzpointBin(IZ,P,T,X1,Y2)
				sumz=x1+y2
				deltaT=-1.2*deltaT
				Tini=Tini0+deltaT
				Tini=Tini
				if(IZ.EQ.2)x1ini=0.98*x1ini
			end do
			FV(jf)=(T-DAT(j))**2/DAT(j)	
		end do
		do i=NzP+1,NzP+NzT
			j=idata*NK+2*NTP+i
			jf=j+(NK+1)/2+2*NTP
			Pini=DAT(j)
			Pini0=Pini
			deltaP=-0.03*Pini0
			T=PTsat(i)
			IZ=IZv(i)
			X1=Xis(i)
			Y2=max(1.0d0-Yis(i),1.0d-6)
			if(IZ.EQ.2)x1ini=x1
			if(IZ.EQ.1)Y2ini=Y2
			sumz=1.0
			k=0
			do while (sumz.gt.0.99.and.k.lt.10)
				k=k+1
				P=Pini
				if(IZ.EQ.2)x1=x1ini
				if(IZ.EQ.1)Y2=Y2ini
				call TzpointBin(IZ,P,T,X1,Y2)
				sumz=x1+y2
				deltaP=-1.3*deltaP
				Pini=Pini0+deltaP
				if(Pini.lt.Pini0)Pini=(Pini0+Pini)/2
				if(IZ.EQ.2)x1ini=0.98*x1ini
			end do
			FV(jf)=(P-DAT(j))**2/DAT(j)	
		end do
	end if
	do i=1,NFUG
		j=idata*NK+2*NTP+NzP+NzT+i
		jf=j+(NK+1)/2+2*NTP
		T=Tfug(i)
		P=Pfug(i)
		X1=X1fug(i)
		Y1=Y1fug(i)
c		Y2=1.0d0-Y1fug(i)
		call PTxyFUG(P,T,X1,Y1,dfug)
		FV(jf)=dfug(1)**2+dfug(2)**2
	end do
	F = SUM(FV)
      WRITE (NOUT,99) (X(L),L=1,N), F
c      F = F - sum(FV(1:4))
c      WRITE (NOUT,99) (X(L),L=1,N), F
98	FORMAT (8F9.5,A15)
99	FORMAT (8F10.5,E12.4)
C
      RETURN
      END
c
      SUBROUTINE KPfromPAR
	PARAMETER (nco=2,NA=2)
      implicit double precision (A-H,O-Z)
      DIMENSION	X(nco)
      DIMENSION VS(5),VE(5)
      COMMON/UNITAUX/NOUT
	COMMON/CASEOPT/ NCASE
      COMMON/CRIT/TC(nco),PC(nco),DC(nco)
      COMMON/covol/B(2)
	COMMON/LCEP/ TL, PL, XcL, DcL, YL, DVL
	COMMON/PmaxLL/Phigh
	COMMON/PAEP/ TP(NA),PP(NA),ZP(NA),DLP(NA),DVP(NA),NPAEP
	COMMON/HAEP/ TH(NA),PH(NA),ZH(NA),DLH(NA),DVH(NA),NHAEP
	COMMON/CAEP/ TAC(NA),PAC(NA),ZAC(NA),DAC(NA),NCAEP
      NPAEP=0
      NHAEP=0
      NCAEP=0
c
	NS=1
	if(TC(2)>TC(1))then  ! typical case
	    delXS=1.1d-4	! X(1) increases as moving away from C2
	    T=TC(2)
          x(1)=delXS
          x(2)=1.0D0-delXS
	    V=1.0D0/DC(2)
	else   ! methane
	    delXS=-1.1d-4	! X(1) decreases as moving away from C1
	    T=TC(1)
          x(1)=1.0D0+delXS
          x(2)=-delXS
	    V=1.0D0/DC(1)
	end if
	call XTVnewtonCrit(nout,NS,delXS,X,T,V)
	if(X(1).gt.0.9999) then ! type I or II 
		ntype=1
		if(NCASE==1)then
c		    if(NCAEP>0)then
c		        go to 7
c		    else
		        go to 10
c      		end if    
		end if    
c		if(NCASE.gt.2) go to 10
	else if (TL.NE.0.0) then ! type V or IV 
		ntype=5
		if(NCASE.lt.4) go to 10
	else
		ntype=3
		go to 3
	end if
c
	if(NCASE==5) go to 3                       ! added 09/01/2013
c	calculation low T L-L critical from high P (line B)
 111  T=TC(1)
	Plower=Phigh-30.0
	call FindHighPcrit(Plower,X,T,Vlow)
	if(Vlow.eq.0) go to 3   ! no LL crit line was found
	call FindHighPcrit(Phigh,X,T,V)
	NS=3
	delXS=log(Vlow/V) ! Molar Volume can increase or decrease 
c				as pressure goes down along the LL critical line
	call XTVnewtonCrit(nout,NS,delXS,X,T,V)
	if(ntype.eq.1)ntype=2
	if(ntype.eq.5)ntype=4
 3	if(ntype.lt.3)go to 12
c
c	calculation of critical line (D) starting at CP1
	V=1.0D0/DC(1)
	T=TC(1)
	NS=1
	delXS=-1.0d-5	! X(1) decreases as moving away from C1
	delXS=delXS*(B(1)/B(2))**2	! Higher asymmetry requires lower delXS to find the UCEP
      x(1)=1.0D0+delXS
      x(2)=-delXS
	call XTVnewtonCrit(nout,NS,delXS,X,T,V)
 12	if(ntype.gt.1) call LLVlinesSpecDifCont
c
 99	WRITE(nout,*)
C	WRITE(nout,*)' Type of phase behaviour predicted by the model
C	1 for this system'
C	WRITE(nout,*) ntype
c	Azeotropic End Points
	NAEP=NPAEP+NCAEP+NHAEP
c      WRITE(nout,*)
c	WRITE(nout,*)' Total number of Azeotropic End Points found:'
c	WRITE(nout,*) NAEP
c     WRITE(nout,*)
c	WRITE(nout,*)' Pure Azeotropic End Points found:         ',NPAEP
	IF(NPAEP.GT.0)THEN
	WRITE(nout,*)'   T(K)     P(bar)      z    DL(mol/L)  DV(mol/L)'
	do i=1,NPAEP
		WRITE(nout,9)TP(i),PP(i),ZP(i),DLP(i),DVP(i)
	end do
	END IF
c      WRITE(nout,*)
c	WRITE(nout,*)' Critical Azeotropic End Points found:     ',NCAEP
	IF(NCAEP.GT.0)THEN
	WRITE(nout,*)'   T(K)     P(bar)      z    DL(mol/L)  DV(mol/L)'
	do i=1,NCAEP
		WRITE(nout,9)TAC(i),PAC(i),ZAC(i),DAC(i),DAC(i)
	end do
	END IF
c      WRITE(nout,*)
c	WRITE(nout,*)' Heterogeneous Azeotropic End Points found: ',NHAEP
	IF(NHAEP.GT.0)THEN
	WRITE(nout,*)'   T(K)     P(bar)      z    DL(mol/L)  DV(mol/L)'
	do i=1,NHAEP
		WRITE(nout,9)TH(i),PH(i),ZH(i),DLH(i),DVH(i)
	end do
	END IF
c      WRITE(nout,*)
	IF(NAEP.GT.0)THEN
c	Calculation of azeotropic line(s)
c	if(NHAEP.EQ.2)then ! two lines
c		ME=3
c		if(NCAEP.GT.0)MS=2
c		if(NCAEP.GT.0)VS=[TAC(1),PAC(1),ZAC(1),DAC(1),DAC(1)]
c		if(NPAEP.EQ.2)MS=1
c		if(NPAEP.EQ.2)VS=[TP(1),PP(1),ZP(1),DLP(1),DVP(1)]	! PAEP pure 1st comp
c		VE=[TH(1),PH(1),ZH(1),DLH(1),DVH(1)]  ! higher T HAEP
c		CALL AzeotNewton(MS,VS,ME,VE)						! first line
c	    WRITE(nout,*)'fin'
C
c		MS=1
c		VS=[TP(NPAEP),PP(NPAEP),ZP(NPAEP),DLP(NPAEP),DVP(NPAEP)] ! PAEP pure 2nd comp
c		VE=[TH(2),PH(2),ZH(2),DLH(2),DVH(2)]  !  lower T HAEP
c	else  ! one line
c		ME=0
c		if(NPAEP.GT.0)then
c			MS=1
c			VS=[TP(1),PP(1),ZP(1),DLP(1),DVP(1)]
c			if(NPAEP.EQ.2)then
c				ME=1
c				VE=[TP(2),PP(2),ZP(2),DLP(2),DVP(2)]
c			else if(NCAEP.GT.0)then
c				ME=2
c				VE=[TAC(1),PAC(1),ZAC(1),DAC(1),DAC(1)]
c			end if
c		else if(NCAEP.GT.0)then
 7			MS=2
			VS=[TAC(1),PAC(1),ZAC(1),DAC(1),DAC(1)]
			if(NCAEP.EQ.2)then
				ME=2
				VE=[TAC(2),PAC(2),ZAC(2),DAC(2),DAC(2)]
			end if
c		end if
c		if(NHAEP.GT.0)then
c			ME=3
c			VE=[TH(1),PH(1),ZH(1),DLH(1),DVH(1)]
c		end if
c	end if
c	IF(ME.EQ.0)VE(1)=MIN(50.0,VS(1)/2)
C	CALL AzeotNewton(MS,VS,ME,VE)             ! Activate for azeotropic systems!
C
	END IF
  9   FORMAT (F9.4,2x,E10.4,F8.4,F9.5,x,E11.3)
 10   END
C
C
      subroutine FindHighPcrit(Phigh,X,T,V)
      implicit double precision (A-H,O-Z)
      PARAMETER (nco=2)
      DIMENSION X(2),Z(2),FUG(2),FT(2),FP(2),FX(2,2)
	LOGICAL LASTDELX
	LASTDELX=.FALSE.
c     loop to determine high pressure branch
c
      CALL HIPRES (Phigh,T,XX,VAL)
	if(T.lt.5.0)go to 120
      DELT = 10.0
      IF (VAL .LT. 0.) DELT= -10.0
      CALL TSTEP (Phigh,T,XX,DELT,V,IEX)
c
c     iex negative: No hi-P line found
      IF (IEX.NE.0) GOTO 120
      CALL HIPRES (Phigh,T,XX,VAL)
      DELT = .1*DELT
C	NOW DELT IS NOT USED AS A STEP BUT ONLY AS A TOLERANCE (AND FIRST STEP)
      CALL TSTEP (Phigh,T,XX,DELT,V,IEX)
c      CALL HIPRES (Phigh,T,XX,VAL)
c	Instead of another calling to HIPRES we do the following to find XX accurately (error<0.0001):
c	Otherwise the V obtained, when specified later, will lead to a different pressure (asymmetric systems) 
      Z(1) = XX-0.01
      Z(2) = 1.D0-Z(1)
	CALL TERMO(1,3,IC,T,Phigh,Z,V,FUG,FT,FP,FX)
	DELX=0.001
 100	VAL = FX(1,2)
	Z(1) = Z(1)+DELX
      Z(2) = 1.D0-Z(1)
	CALL TERMO(1,3,IC,T,Phigh,Z,V,FUG,FT,FP,FX)
	IF(FX(1,2).GT.VAL)GO TO 100
	Z(1) = Z(1)-DELX
	IF(LASTDELX)GO TO 101
	Z(1) = Z(1)+0.0001
      Z(2) = 1.D0-Z(1)
	CALL TERMO(1,3,IC,T,Phigh,Z,V,FUG,FT,FP,FX)
	IF(FX(1,2).GT.VAL)THEN
		DELX= 0.0001
	ELSE
		DELX=-0.0001
		Z(1) = Z(1)+2*DELX
		Z(2) = 1.D0-Z(1)
		CALL TERMO(1,3,IC,T,Phigh,Z,V,FUG,FT,FP,FX)
		IF(FX(1,2).LT.VAL)GO TO 101
	END IF
	LASTDELX=.TRUE.
	GO TO 100
c	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C
 101	XX=Z(1)
	DELT = .1*DELT
      CALL TSTEP (Phigh,T,XX,DELT,V,IEX)
	X(1)=XX
	X(2)=1.0D0-X(1)
 120  end
C
C     purpose of routine HIPRES:
C
C     To find the composition where the derivative dlnphi1/dn2
C     takes on its maximum value at given T and high pressure (PHI)
C
C     Parameters:
C
C     T       (I)       Temperature
C     X       (O)       Composition with LARGEST 2nd derivative
C     Val     (O)       Value of 2nd derivative - 1
C
      SUBROUTINE HIPRES (Phigh,T,X,VAL)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (MAXC=2)
      DIMENSION Z(MAXC), FUG(MAXC),FT(MAXC),FP(MAXC),
     *      FX(MAXC,MAXC)
      DIMENSION FTAB(0:50)
      PHI = Phigh
C
C     CALCULATE TABLE OF VALUES OF 2ND DERIVATIVE
C
  1   STEP = 0.02D0
      DO K = 0,50
         Z(1) = DBLE(K)/50
         Z(2) = 1.D0-Z(1)
		CALL TERMO(1,3,IC,T,PHI,Z,V,FUG,FT,FP,FX)
	   FTAB(K) = FX(1,2) - 1.D0
      ENDDO
C
C     CALCULATE MAXVAL
C
      INUM = MAXLOC(FTAB,DIM=1)-1
	if(INUM.EQ.0.or.INUM.EQ.50)then
		T=0.9*T
		if(T.lt.5.0)return
		go to 1
	end if
      DERV1 = (FTAB(INUM+1)-FTAB(INUM-1))/(2.D0*STEP)
      DERV2 = (FTAB(INUM+1)-2.D0*FTAB(INUM)+FTAB(INUM-1))/STEP**2
C
C     INTERPOLATE TO OPTIMUM
C
      DELX = -DERV1/DERV2
      X = DBLE(INUM)/50 + DELX
      VAL = FTAB(INUM) + DELX*(DERV1+.5D0*DELX*DERV2)
      END
C
C
C     Routine to locate T where instability first occures
C     Routine varies T, with composition X fixed.
C
C
C	NOW DELT IS NOT USED AS A STEP BUT ONLY AS A TOLERANCE (AND FIRST STEP)
      SUBROUTINE TSTEP (Phigh,T,X,DELT,VOLU,IEX)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (MAXC=2)
      DIMENSION Z(MAXC), FUG(MAXC),FT(MAXC),FP(MAXC), FX(MAXC,MAXC)
      PARAMETER (TMIN=20.D0,TMAX=1500.D0)
c      PARAMETER (TMIN=0.D0,TMAX=1500.D0)
      PHI = Phigh
      IEX = 0
C
C     CALCULATE TABLE OF VALUES OF 2ND DERIVATIVE
C
      Z(1) = X
      Z(2) = 1.D0-X
	CALL TERMO(1,3,IC,T,PHI,Z,V,FUG,FT,FP,FX)
	VAL = FX(1,2) - 1.D0
	TOLD = T
      T  = T + DELT
  100 CONTINUE
      IF (T.GT. TMAX .OR. T.LT. TMIN) THEN
         write (*,*) 'T-limit for High-P search exceeded '
         IEX = 1
	   VOLU = 0.0D0
         RETURN
      ENDIF
	CALL TERMO(1,3,IC,T,PHI,Z,V,FUG,FT,FP,FX)
c	det=FX(1,1)*FX(2,2)-FX(1,2)*FX(1,2)
	VOLD=VAL
	VAL = FX(1,2) - 1.D0
      AUX=T
	SLOPE=(T-TOLD)/(VAL-VOLD)
	IF (SLOPE.LT.0)THEN
		T=T-VAL*SLOPE
	ELSE
		T=T+3*DELT
	END IF
	TOLD=AUX
	IF (ABS(T-TOLD).LT.ABS(DELT)) GO TO 101
	IF (T.GT.TMAX.AND.TMAX-TOLD.GT.100) T=(TMAX+TOLD)/2
	IF (T.LT.TMIN.AND.TOLD-TMIN.GT.2)  T=(TMIN+TOLD)/2
	GOTO 100
 101  VOLU = V
      END
C
c
	subroutine FindMaxIsotPure(icomp,T,Pmax1)
      implicit double precision (A-H,O-Z)
      PARAMETER (nco=2,RGAS=0.08314472d0,eps=1.0d-7)
	dimension rn(nco),Arn(nco),ArVn(nco),ArTn(nco),Arn2(nco,nco)
	COMMON /MODEL/ NMODEL
      COMMON/covol/B(2)
      COMMON/VminVapour/Vmin
	COMMON/NG/NGR
	NG=NGR
C	IF(NMODEL.EQ.5)CALL PARAGC(T,NCO,NG,1) 
	timesb=10000     
	NDER=0
	NTEMP=0
	rn=0.0
	rn(icomp)=1.0
	RT=RGAS*T
	tol=10*eps/B(icomp)
	delrho=1
	V=timesb*B(icomp)
 1	call ArVnder(NDER,NTEMP,rn,V,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
	d2Pdrho=V**3*ArV2		! =V*(dPdrho-RGAS*T)
	rho=-RT/d2Pdrho
	epsrho=eps/B(icomp)
	DO WHILE (delrho.gt.tol)
		V=1/rho
		call ArVnder(NDER,NTEMP,rn,V,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
		dPdrho=RT+V*V*ArV2
		V=1/(rho+epsrho)
		call ArVnder(NDER,NTEMP,rn,V,T,Ar,ArV,ArTV,ArV2e,Arn,ArVn,ArTn,Arn2)
		d2Pdrho=V**2*(ArV2e-ArV2)/epsrho
		delrho=-dPdrho/d2Pdrho
		rho=rho+delrho
	END DO
	Vmin=1/rho
	call ArVnder(NDER,NTEMP,rn,Vmin,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
	Pmax1=1.5*rho*RT-Arv  ! added 1.5* on 05/03/2011
	end
c
      subroutine AzeotNewton(MS,VS,ME,VE)
      implicit double precision (A-H,O-Z)
      PARAMETER (RGAS=0.08314472d0,nco=2)
C	S = starting point
C	E = ending point
c
c	M is for the type of starting or ending point:
c		1	Pure
c		2	Critical
c		3	Heterogeneous
c		0	Open down to TE=MIN(50.0,TS/2)
C
c	The independent variables are lnT,lnz,lnvL,lnvV
      DIMENSION z(2),delX(4),dold(4),sensmod(4),b(4),ipiv(4)
      DIMENSION XVAR(4),F(4),dFdS(4),dXdS(4),RJAC(4,4),AJ(4,4),XOLD(4)
      DIMENSION FUGx(2),FUGy(2),FUGTx(2),FUGTy(2),DPDNx(2)
      DIMENSION FUGVx(2),FUGVy(2),DFGNx(2,2),DFGNy(2,2)
      DIMENSION VS(5),VE(5)
      LOGICAL LASTPOINT, CALCAZ
c	COMMON/UNITS/NUNIT,NOUT
	COMMON/Pder/ DPDN(2),DPDT,DPDV
	COMMON/CALCA/Pa,Xa,Pai,Xai
	COMMON /KeyTa/Ta,Taint
	TOL= 1.0D-6	! for variables
	N=4	! DLSARG CONSTANTS (now dgesv in MKL)
	LDA=4
	ldb=4
c	IPATH=1
	LASTPOINT=.FALSE.
	CALCAZ=.FALSE.
	DFDS(4)=1.0D0
	RJAC(4,1:4)=0.0D0
c	VE(3)=max(VE(3),1.0d-6)  ! to prevent log(0) crash
c	WRITE(nout,*)
c	WRITE(nout,*)
c	1	'   T(K)     P(bar)     z(1)    z(2)   DL(mol/L)  DV(mol/L)'
c	WRITE(nout,*)'AZE'
c	WRITE(NOUT,9) VS(1),VS(2),VS(3),1.D0-VS(3),VS(4),VS(5)
c	first point initialization
	if(MS.EQ.1)then ! start from PAEP
		NS=2	! composition
		RJAC(4,2)=1.0D0
		if(VS(3).eq.0.0)then
			zfirst=min(0.005D0,VE(3)/20)
			XVAR(2)=zfirst  ! log(zfirst)
			delXS=0.002d0
		else
			z2first=min(0.001D0,(1.0-VE(3))/50)
			XVAR(2)=1.0D0-z2first  ! log(1.0D0-z2first)
			delXS=-0.002D0
		end if
		XVAR(3)=log(1/VS(4))
		XVAR(4)=log(1/VS(5))
	else if(MS.EQ.2)then ! start from CAEP
		NS=0	! volume relation
		RJAC(4,3)=-1.0D0
		RJAC(4,4)=1.0D0
		XVAR(3)=log(0.99/VS(4))
		XVAR(4)=log(1.01/VS(5))
		delXS=0.03D0
		XVAR(2)=VS(3)  ! log(VS(3))
	end if
	XVAR(1)=log(VS(1))
	Told = VS(1)+0.1
 14	NITER=0
	DMAXOLD=8.0D0
	DMAX=7.0D0
	F(4)=0.0D0
	delX=0.0D0
	T=exp(XVAR(1))
	z(1)=XVAR(2)  ! exp(XVAR(2))
	z(2)=1.0D0-z(1)
	VL=exp(XVAR(3))
	VV=exp(XVAR(4))
c	Newton procedure for solving the present point
	DO WHILE (DMAX.GT.TOL)
		NITER=NITER+1
		NVCORREC=0
 21		CALL XTVTERMO(4,T,VL,Px,z,FUGx,FUGTx,FUGVx,DFGNx)
	    DPDNx=DPDN
	    DPDTx=DPDT
	    DPDVx=DPDV
		CALL XTVTERMO(4,T,VV,Py,z,FUGy,FUGTy,FUGVy,DFGNy)
		if(Px.lt.0.95*Py.or.Px.gt.1.05*Py.OR.(Py.lt.
	1	1.0D-8.and.(Px.lt.0.98*Py.or.Px.gt.1.02*Py)))then
			NVCORREC=NVCORREC+1
			IF(NVCORREC.EQ.5)RETURN
			VL=VL+(Py-Px)/DPDVx
			go to 21
		end if
		F(1)=log(Px/Py)
		F(2)=FUGx(1)-FUGy(1)
		F(3)=FUGx(2)-FUGy(2)
		RJAC(1,1)=DPDTx/Px-DPDT/Py
		RJAC(1,1)=T*RJAC(1,1)
		RJAC(1,2)=((DPDNx(1)-DPDNx(2))/Px-(DPDN(1)-DPDN(2))/Py)  ! z(1)*
		RJAC(1,3)=VL*DPDVx/Px
		RJAC(1,4)=-VV*DPDV/Py
C
		RJAC(2:3,1)=T*(FUGTx(1:2)-FUGTy(1:2))
		RJAC(2:3,2)=DFGNx(1:2,1)-DFGNx(1:2,2)-(DFGNy(1:2,1)-DFGNy(1:2,2))  ! z(1)*
		RJAC(2:3,3)=VL*FUGVx(1:2)
		RJAC(2:3,4)=-VV*FUGVy(1:2)
c
		dold=delx
C
c		CALL DLSARG (N, RJAC, LDA, -F, IPATH, delX)
c       call dgesv( n, nrhs, a, lda, ipiv, b, ldb, info )
        b = -F
        AJ=RJAC
        call dgesv( N, 1, AJ, lda, ipiv, b, ldb, info )
        if (info.ne.0) write(6,*)"error with dgesv in parameter ",info
        delX = b
c        
		DMAXOLD=DMAX
		DMAX=MAXVAL(ABS(DELX))
		if(DMAX/DMAXOLD.GT.2.0)then ! reduce step until DMAX decreases
			XVAR=XVAR-dold
			delX=dold/2
			DMAX=DMAXOLD
C			go to 17
		else
			XVAR(3)=log(VL)  ! maybe changed (correction of VL to reduce F1)
		end if
 17		XVAR=XVAR+delX
		T=exp(XVAR(1))
		z(1)=XVAR(2)  ! exp(XVAR(2))
		z(2)=1.0D0-z(1)
		VL=exp(XVAR(3))
		call Bcalc(z,T,Bmix)
		if (VL.lt.1.001*Bmix)then
			XVAR=XVAR-delX
			delX=delX/2
			go to 17
		end if
		VV=exp(XVAR(4))
	if(VL.gt.VV) then
		XVAR=XVAR-delX
		delX=delX/10
		go to 17
	end if
	END DO
	DL=1/VL
	DV=1/VV
c	WRITE(NOUT,9)T,Px,Z(1),Z(2),DL,DV,NITER,NS
c  c  c c c Taken from XTVNextonCrit and adapted:
		if(CALCAZ)then
			Pa=Px				! Key-point (only CO2+C2)
			Xa=Z(1)
			go to 11
		else
			if(TaInt.ne.0.0d0)then
			    if((T-TaInt)*(Told-TaInt).lt.0.0d0)then
			        Pai=Px+(Pold-Px)*(TaInt-T)/(Told-T)
			        Xai=Z(1)+(Zold-Z(1))*(TaInt-T)/(Told-T)
			    end if
			end if
			if((T-Ta)*(Told-Ta).lt.0.0d0)then
c				VcLV=V	! initial values
				Xa=Z(1)
				go to 23
			end if
		end if
c  c  c  c   c   c   c   c   c   c   c   c   c   c   c   c   c
c
	IF (ME.EQ.0.and.T.le.VE(1)) go to 11	! criteria for stopping at low T
	IF (LASTPOINT) THEN
		WRITE(NOUT,9) VE(1),VE(2),VE(3),1.D0-VE(3),VE(4),VE(5)
		go to 11	! return
	END IF
c	CALL DLSARG (N, RJAC, LDA, dFdS, IPATH, dXdS)
C
c       call dgesv( n, nrhs, a, lda, ipiv, b, ldb, info )
        b = dFdS
        AJ=RJAC
        call dgesv( N, 1, AJ, lda, ipiv, b, ldb, info )
        if (info.ne.0) write(6,*)"error with dgesv in parameter ",info
        dXdS = b
c        
	NSOLD=NS
 4	RJAC(4,1:4)=0.0D0
	NITER=min(niter,10)
	dX0dS=dXdS(4)-dXdS(3)
	sensmod=dXdS
	sensmod(2)=10*sensmod(2)
	J=MAXLOC(abs(sensmod),DIM=1)
	IF(abs(sensmod(J)).gt.abs(dX0dS))THEN
		NS=J			! Specify the most changing variable for next point
		S=XVAR(J)
		delXS=dXdS(NS)*delXS*5/NITER
		RJAC(4,NS)=1.0D0
	ELSE
		NS=0			! Specify lnVV-lnVL for next point
		S=XVAR(4)-XVAR(3)
		delXS=(dXdS(4)-dXdS(3))*delXS*5/NITER
		RJAC(4,3)=-1.0D0
		RJAC(4,4)=1.0D0
	END IF
	if(T.lt.50.and.abs(delXS).lt.0.001)return
	IF(NS.NE.NSOLD)THEN
		if(NS.EQ.0)dXdS=dXdS/(dXdS(4)-dXdS(3))
		if(NS.NE.0)dXdS=dXdS/dXdS(NS)
	END IF
	IF(delXS.LT.0)then
	delXS=max(delXS,-0.07)
	if(NS.EQ.1)delXS=max(delXS,-0.02) ! Max lnT decrease allowed
	if(NS.EQ.2)delXS=max(delXS,-0.015) ! Max z decrease allowed
	ELSE
	delXS=min(delXS,0.07)
	if(NS.EQ.0)delXS=min(delXS,0.10,S/3) ! Max volume separation increase allowed
	if(NS.EQ.1)delXS=min(delXS,0.02) ! Max lnT increase allowed
	if(NS.EQ.2)delXS=min(delXS,0.015) ! Max z increase allowed		/Z(1)
	END IF
	XOLD=XVAR
C
  7	IF(NS.EQ.0)THEN
		S=XOLD(4)-XOLD(3)+delXS
	ELSE
		S=XOLD(NS)+delXS
	END IF
	XVAR=XOLD+dXdS*delXS	! Initial estimates for the 7 variables in the next point
	Told = T
	Pold = Px
	Zold = Z(1)
	if(ME.eq.0)go to 8
	D43=XVAR(4)-XVAR(3)
	DT=abs(XVAR(1)-log(VE(1)))
	DZ=abs(XVAR(2)-VE(3))	! log(VE(3))
	IF((D43.LT.0.02.and.ME.eq.2).or.(DT*DZ.lt.0.00001.and.ME.ne.2))THEN
		LASTPOINT=.TRUE.
		delXS=2*delXS/3
		go to 7
	END IF
 8	GO TO 14
C	
 23	CALCAZ=.TRUE.
	NS=1  ! T
c	V=VcLV
	XVAR(1)=LOG(Ta)
	GO TO 14
  9	FORMAT(F9.4,E12.4,2F9.5,F9.4,E12.4,I4,I2)
 11	end
C
      subroutine LLVlinesSpecDifCont
c	calculations at low T will proceed until 100 K or when the step 
c	to the next point in lnT, required for convergence, is lower than 0.001
      implicit double precision (A-H,O-Z)
      PARAMETER (RGAS=0.08314472d0,nco=2,NA=2)
C	There are three possible LLV lines to calculate
C	llvtype=2		From an UCEP LL down to low T
C	llvtype=3		From an UCEP LV down to low T
C	llvtype=4		From an UCEP LV down to a LCEP
C
c	The independent variables are lnT,lnX,lnY2,lnW2,lnVx,lnVy,lnVw
c	we use X<Y (liq. phases) and W for vapour.
c	In non-azeotropic systems X<Y<W (L1, L2 and V respectively).
c	The equations are 2 equipressure, 4 equifugacity and specification.
c
c	The newton step (delx) is decreased in any of the following situations:
c	- First iteration (unless all steps are below 1d10-3)
c	- Oscilative behaviour is detected in the iterations (unless all steps are below 1d10-4)
c	- The max relative step > 0.1 for NS=0 (y1-x1 specified, close to an UCEP)
c	- The max relative step > 0.8 (other specifications)
c	- The volume of one phase goes below 1.01 Bmix (covolume)
c	- LLVtype=2 and x1 goes > XcUB or y1 < XcUB
c
c	The step to a new point (delXS) is decreased to start again when:
c	- Both the max residual and the max newton step were increased compared to previous iteration
c
c	In many cases with an UCEP at low T it is crucial to converge with high accuracy 
c	the first point: that's why TOL= 1.d-6 and why the separation between liquid phases
c	compositions is reduced to half when DMAX is increasing.
c
      DIMENSION X(2),Y(2),W(2),rel(7),XBEST(7),bestJ(7,7),TCmod(nco)
      DIMENSION XVAR(7),F(7),dFdS(7),dXdS(7),delX(7),AJ(7,7),RJAC(7,7)
      DIMENSION FUGx(2),FUGy(2),FUGw(2),dold(7),dot(7),XOLD(7)
      DIMENSION FUGTx(2),FUGTy(2),FUGTw(2)
      DIMENSION FUGVx(2),FUGVy(2),FUGVw(2)
      DIMENSION DFGNx(2,2),DFGNy(2,2),DFGNw(2,2)
      DIMENSION DPDNx(2),DPDNy(2),b(7),ipiv(7)
      LOGICAL LASTPOINT,HALF,IIIaz,oscil,DMAX0min,back
c	COMMON/UNITS/NUNIT,NOUT
	COMMON /MODEL/ NMODEL
	COMMON/UCEPD/TUD,PUD,XcUD,DcUD,XL1,DL1
	COMMON/LCEP/ TL, PL, XcL, DcL, YL, DVL
	COMMON/UCEPB/TUB,PUB,XcUB,DcUB,Y2U,DVU
	COMMON/Pder/ DPDN(2),DPDT,DPDV
      COMMON/CRIT/TC(nco),PC(nco),DC(nco)
      COMMON/TCGC/TCGC(nco)
	COMMON/HAEP/ TH(NA),PH(NA),ZH(NA),DLH(NA),DVH(NA),NHAEP
	COMMON/CASEOPT/ NCASE
	COMMON/CALC3/T994,Tm,Pm,P393,Tu,Xu,Xlo,Ylo,Xmi,Ymi
	COMMON/KeyLLV/Tlow,Tmid
      if(NCASE==5.and.(Tlow-TL)*(Tlow-TUD)>0)then
		Xlo=0.50
		Ylo=0.99
        return
      end if
	TCmod=TC
	if(TCGC(1).ne.0.0D0)TCmod=TCGC
	IF(TL>0.and.NCASE==4)TUD=0.0D0  ! IN ORDER TO SAVE THE LLVTYPE=4 LINE CALCULATION AND GO DIRECTLY TO UCEP
	if(TUD.GT.0)then
		llvtype=3
		tucep=TUD
		if(TL.GT.0)llvtype=4
		TOL= 1.0D-4	! for variables	  (5.0d-4 before)
	else ! TUB>0
		llvtype=2
		IF(NCASE.eq.3)THEN
			Tm=TUB
			T994=TUB
			TU=TUB
			xU=XcUB
		END IF
		tucep=TUB
		TOL= 1.0D-6	! for variables	  (5.0d-4 before)
	end if
	NC=2
	NTYP=1	! only FUG to be calculated in RKPR subroutine
	TOLF=1.0D-3	! for residuals   1.0d-3
	N=7	! DLSARG CONSTANTS (now dgesv in MKL)
	LDA=7
	ldb=7
c	IPATH=1
	LASTPOINT=.FALSE.
	IIIaz=.FALSE.
	RJAC(1:3,4)=0.0D0
	RJAC(1:3,7)=0.0D0
	RJAC(4:6,2)=0.0D0
	RJAC(4:6,5)=0.0D0
	DFDS=0.0D0
	DFDS(7)=1.0D0
 1	NS=0  ! Difference y-x or w-y to be specified in first steps
c	WRITE(nout,*)'   T          P       XL1     XL2     Y(1)    Y(2)     
c     & X2L2    d1(mol/L)  d2(mol/L) dV(mol/L) NITER NS  PRODMIN'
c	WRITE(nout,*)'LLV'
	if(llvtype.eq.4)then
		delTmax=0.0025
		R3min=1.70D1 ! min d3dT to specify lny2 (L2phase) instead of lnT
	else ! 2 or 3
		delTmax=0.0100
		if (nmodel.le.3)then
			R3min=4.0D1	! convenient for cubic
		else
			R3min=3.0D1
		end if
	end if
	if(llvtype.eq.2)then
		XVAR(1)=log(TUB)
		XVAR(4)=log(Y2U)
		XVAR(5:6)=log(1/DcUB)
		XVAR(7)=log(1/DVU)
		Xc2=1.0D0-XcUB
		difold=1.0d-10
c		WRITE(NOUT,9) TUB,PUB,XcUB,XcUB,1.0D0-Y2U,Y2U,Xc2,DcUB,DcUB,DVU
	else ! UCEP is LV
		XVAR(1)=log(TUD)
		XVAR(2)=log(XL1)
		W(2)=1.0D0-XcUD
		XVAR(5)=log(1/DL1)
		XVAR(6:7)=log(1/DcUD)
		Xc2=1.0D0-XcUD
c		WRITE(NOUT,9) TUD,PUD,XL1,XcUD,XcUD,W(2),Xc2,DL1,DcUD,DcUD
	end if
c
	DMAX0min=.FALSE.
	DMAX0=7.0
	back=.FALSE.
c	Specification of a difference in composition between the quasi-critical phases
	if(llvtype.eq.2) S=MIN(XcUB,1.0D0-XcUB,0.30)/40
 2	Xold=0.0D0
	RJAC(7,1:7)=0.0D0
	if(llvtype.eq.2) then
		XOLD(1)=XVAR(1)
		delXS=0.3*S
		Y1=XcUB+S/2
		XVAR(3)=log(1.0D0-Y1)
c		delXS=XVAR(3)-log(1.0D0-XcUB)
		X1=XcUB-S/2
		XVAR(2)=log(X1)
		Y=[Y1,1.0D0-Y1]
		CALL VCALC(1,2,Y,TUB,PUB,V)      
		XVAR(6)=log(V)
		X=[X1,1.0D0-X1]
		CALL VCALC(1,2,X,TUB,PUB,V)      
		XVAR(5)=log(V)
		XOLD(3)=log(1.0D0-XcUB)
		W(2)=Y2U
		W(1)=1.0D0-Y2U
		RJAC(7,3)=-Y(2)	! Spec.Eq. is F(7)=y-x-S=0
		RJAC(7,2)=-X(1)
	else	!	llvtype = 4 or 3
		S=MIN(XcUD,1.0D0-XcUD)/50
		Dpos=(TCmod(1)/TUD)**2*log(PUD)/log(PC(1))
		if(llvtype.eq.3.and.Dpos.gt.1.0d0)then
			IIIaz=.TRUE.
			Y1=XcUD+S/2	!	het. azeotropy (e.g., water + hydrocarbons)
			w1=XcUD-S/2
			S=-S  ! for consistency of spec. equation and Jacobian
		else
			Y1=XcUD-S/2 !	normal cases: y1 < w1 (vapour)
			w1=XcUD+S/2
		end if
		XVAR(3)=log(1.0D0-Y1)
		XVAR(4)=log(1.0d0-w1)
		delXS=XVAR(3)-log(1.0D0-XcUD)	! for NS=3 in second point
		XOLD(3)=log(1.0D0-XcUD)
		W=[w1,1.0D0-w1]
		Y=[Y1,1.0D0-Y1]
		CALL VCALC(1,2,Y,TUD,PUD,V)      
		XVAR(6)=log(V)
		W=[w1,1.0D0-w1]
		CALL VCALC(-1,2,W,TUD,PUD,V)      
		XVAR(7)=log(V)
		RJAC(7,4)=-W(2)	! Spec.Eq. is F(7)=w-y-S=0
		RJAC(7,3)= Y(2)
	end if
	Told=1000.0
	HALF=.FALSE.
 14	NITER=0
	T=exp(XVAR(1))
	X(1)=exp(XVAR(2))
	X(2)=1.0D0-X(1)
	Vx=exp(XVAR(5))
	Vy=exp(XVAR(6))
	Vw=exp(XVAR(7))
	PRODMIN=10.0
	FMAXOLD=8.0D0
	FMAX=7.0D0
	DMAXOLD=8.0D0
	DMAX=7.0D0
	F(7)=0.0D0
	delX=0.0
	if(T.lt.180)TOLF=0.1
c	Newton procedure for solving the present point
	DO WHILE (DMAX.GT.TOL.or.FMAX.GT.TOLF)
C		IF (NITER*FMAX.GE.2.0.OR.T.GT.TOLD) THEN ! step was too large -> convergence problem
C		IF ((FMAX.GT.FMAXOLD.and.DMAX.GT.DMAXOLD).OR.NITER.eq.10) THEN
C			delXS=0.5*delXS
C			if(abs(delXS).lt.0.001)return
C			go to 7
C		END IF
		IF ((FMAX.GT.FMAXOLD.and.DMAX.GT.DMAXOLD).and.NITER.gt.4) THEN
			if (HALF.and.PRODMIN.lt.1.0d-8) then ! 
				XVAR=XBEST
				RJAC=bestJ
				T=exp(XVAR(1))
				X(1)=exp(XVAR(2))
				X(2)=1.0D0-X(1)
				Y(2)=exp(XVAR(3))
				Y(1)=1.0D0-Y(2)
				W(2)=exp(XVAR(4))
				W(1)=1.0D0-W(2)
				Vx=exp(XVAR(5))
				Vy=exp(XVAR(6))
				Vw=exp(XVAR(7))
				EXIT
			else
				delXS=0.5*delXS
				dmin=0.001
				if (NS.EQ.0) dmin=dmin*1.0d-3
				if(abs(delXS).lt.dmin)then
					if(llvtype.eq.4)WRITE(NOUT,9) 
     1					TL,PL,XcL,XcL,YL,1.D0-YL,1.D0-XcL,DcL,DcL,DVL
					if(llvtype.eq.4.and.TUB.ne.0.0d0)then
						llvtype=2	! go for second LLV part from UCEP(B) down in T
						tucep=TUB
						TOL= 1.0D-6	! for variables
						WRITE(nout,*)
						LASTPOINT=.FALSE.
						go to 1
					end if
					return ! for llvtype=2
				end if
				HALF=.TRUE.
				go to 7
		    end if
		END IF
		NITER=NITER+1
		NVCORREC=0
 21		CALL XTVTERMO(4,T,Vx,Px,X,FUGx,FUGTx,FUGVx,DFGNx)
	    DPDNx=DPDN
	    DPDTx=DPDT
	    DPDVx=DPDV
		CALL XTVTERMO(4,T,Vy,Py,Y,FUGy,FUGTy,FUGVy,DFGNy)
	    DPDNy=DPDN
	    DPDTy=DPDT
	    DPDVy=DPDV
	    CALL XTVTERMO(4,T,Vw,Pw,W,FUGw,FUGTw,FUGVw,DFGNw)
c	  if(NS.NE.0)then
		if(min(Px,Py).lt.0.95*Pw.or.max(Px,Py).gt.1.05*Pw.OR.(Pw.lt.
	1  1.0D-8.and.(min(Px,Py).lt.0.98*Pw.or.max(Px,Py).gt.1.02*Pw)))then
			NVCORREC=NVCORREC+1
			IF(NVCORREC.EQ.5)RETURN
			Vy=Vy+(Pw-Py)/DPDVy	! very important for convergence and accuracy of P at low T
			XVAR(6)=log(Vy)
			Vx=Vx+(Pw-Px)/DPDVx
			XVAR(5)=log(Vx)
			go to 21
		end if
c	  end if
		F(1)=log(Px/Py)
		F(2)=FUGx(1)-FUGy(1)
		F(3)=FUGx(2)-FUGy(2)
		F(4)=log(Py/Pw)
		F(5)=FUGy(1)-FUGw(1)
		F(6)=FUGy(2)-FUGw(2)
		RJAC(1,1)=DPDTx/Px-DPDTy/Py
		RJAC(1,1)=T*RJAC(1,1)
		RJAC(1,2)=x(1)*(DPDNx(1)-DPDNx(2))/Px
		RJAC(1,3)=Y(2)*(DPDNy(1)-DPDNy(2))/Py
		RJAC(1,5)=Vx*DPDVx/Px
		RJAC(1,6)=-Vy*DPDVy/Py
C
		RJAC(2:3,1)=FUGTx(1:2)-FUGTy(1:2)
		RJAC(2:3,1)=T*RJAC(2:3,1)
		RJAC(2:3,2)=x(1)*(DFGNx(1:2,1)-DFGNx(1:2,2))
		RJAC(2:3,3)=Y(2)*(DFGNy(1:2,1)-DFGNy(1:2,2))
		RJAC(2:3,5)=Vx*FUGVx(1:2)
		RJAC(2:3,6)=-Vy*FUGVy(1:2)
C
		RJAC(4,1)=DPDTy/Py-DPDT/Pw
		RJAC(4,3)=-Y(2)*(DPDNy(1)-DPDNy(2))/Py
		RJAC(4,4)=W(2)*(DPDN(1)-DPDN(2))/Pw
		RJAC(4,6)=Vy*DPDVy/Py
		RJAC(4,7)=-Vw*DPDV/Pw
C
		RJAC(5:6,1)=FUGTy(1:2)-FUGTw(1:2)
		RJAC(4:6,1)=T*RJAC(4:6,1)
		RJAC(5:6,3)=-Y(2)*(DFGNy(1:2,1)-DFGNy(1:2,2))
		RJAC(5:6,4)=W(2)*(DFGNw(1:2,1)-DFGNw(1:2,2))
		RJAC(5:6,6)=Vy*FUGVy(1:2)
		RJAC(5:6,7)=-Vw*FUGVw(1:2)
C
	if(NS.EQ.0)then
		if(llvtype.eq.2)then
			F(7)=Y(1)-X(1)-S
			RJAC(7,3)=-Y(2)	! Spec.Eq. is F(7)=y-x-S  (this Eq. is not linear with X!)
			RJAC(7,2)=-X(1)	!(variables are lnx1 & lny2, don't be suprised there is a residual)
		else
			F(7)=W(1)-Y(1)-S
			RJAC(7,3)=Y(2)	! Spec.Eq. is F(7)=w-y-S  (this Eq. is not linear with X!)
			RJAC(7,4)=-W(2)	!(variables are lny2 & lnw2, don't be suprised there is a residual)
		end if
	end if
c
		dold=delx
C
c		CALL DLSARG (N, RJAC, LDA, -F, IPATH, delX)
c       call dgesv( n, nrhs, a, lda, ipiv, b, ldb, info )
        b = -F
        AJ=RJAC
        call dgesv( N, 1, AJ, lda, ipiv, b, ldb, info )
        if (info.ne.0) write(6,*)"error with dgesv in parameter ",info
        delX = b
c        
		FMAXOLD=FMAX
		FMAX=MAXVAL(ABS(F))
		DMAXOLD=DMAX
		DMAX=MAXVAL(ABS(DELX))
c
		if(back)then
			if(TOLD.EQ.1000.0)then ! first point and back to sep. with DMAX0min
				if(DMAX.GT.DMAXOLD)then ! reduce step until DMAX decreases
					XVAR=XVAR-dold
					delX=dold/2
					DMAX=DMAXOLD
					go to 17
				end if
			end if
		else
		if(LLVTYPE.EQ.2.and.TOLD.EQ.1000.0)then ! first point after UCEP LL
			if(DMAXOLD.EQ.7.0D0)then ! first iteration
				if(DMAX0.lt.DMAX)then
					DMAX0min=.true.
				else
					DMAX0=DMAX
				end if
			end if
			RELDM=DMAX*DMAX/DMAXOLD
			if(RELDM.GE.1.0d-3)then !DMAX.GE.10*DMAXOLD.and.DMAX.GE.1.0d-4
				if(DMAX0min)then
					back=.true.
					S=S*2	! roundoff errors -> go back to larger separation
				else
					S=S/2	! reduce further the separation
				end if
				XVAR(1)=log(TUB)
				GO TO 2
			end if
		end if
		end if
c
		IF(FMAX*DMAX.LT.PRODMIN)THEN
			PRODMIN=FMAX*DMAX
			bestJ=RJAC
			XBEST=XVAR
		END IF
C
		dot(1:7)=delx(1:7)*dold(1:7)
		dotp=sum(dot(1:7))
		dxmax=maxval(abs(delx))
c	oscillations are recognized by negative dotp
		oscil=.false.
		if(maxval(dot).lt.0.0.or.dotp.lt.-1.d-5)oscil=.true.
		if (oscil.and.dxmax.ge.1.0d-4) then
			delx=delx/2
		end if
	  if(dxmax.ge.1.0d-3.and.dotp.eq.0.0) delx=delx/2  !half step for first iteration (precaution)
C
		do i=1,7
			rel(i)=delx(i)/xvar(i)
			if(abs(xvar(i)).lt.0.1)rel(i)=10*delx(i)
		end do
		relmax=maxval(abs(rel))
		if(NS.EQ.0) then
			if(relmax.ge.0.1)delx=delx*0.05/relmax
		else
			if(relmax.ge.0.8)delx=delx*0.5/relmax	! important for Vw at low T
		end if
 17		XVAR=XVAR+delX
		T=exp(XVAR(1))
		X(1)=exp(XVAR(2))
		X(2)=1.0D0-X(1)
		Y(2)=exp(XVAR(3))
		Y(1)=1.0D0-Y(2)
		Vx=exp(XVAR(5))
		call Bcalc(X,T,Bmix)
		if (Vx.lt.1.001*Bmix)then
			XVAR=XVAR-delX
			delX=delX/2
			go to 17
		end if
		Vy=exp(XVAR(6))
		call Bcalc(Y,T,Bmix)
		if (Vy.lt.1.001*Bmix)then
			XVAR=XVAR-delX
			delX=delX/2
			go to 17
		end if
	if(llvtype.eq.2.and.(X(1).gt.1.003*XcUB.OR.Y(1).lt.0.999*XcUB)) then ! modified 03/04/2011
		XVAR=XVAR-delX
		delX=delX/10
		go to 17
	end if
		W(2)=exp(XVAR(4))
		W(1)=1.0D0-W(2)
		Vw=exp(XVAR(7))
	END DO
	Dx=1/Vx
	Dy=1/Vy
	Dw=1/Vw
c	WRITE(NOUT,9)T,Py,X(1),Y(1),W(1),W(2),Y(2),Dx,Dy,Dw,
c	1			NITER,NS	!  ,PRODMIN
	IF(NCASE.eq.3)THEN
		if((T-Tmid)*(Told-Tmid).lt.0.0d0)then
			frac=(Tmid-Told)/(T-Told)
			Xmi=X1old+frac*(X(1)-X1old)			! Key-point III
			Ymi=Yold+frac*(Y(1)-Yold)			! Key-point III
		end if
	END IF
	IF(NCASE>1)THEN
		if((T-Tlow)*(Told-Tlow).lt.0.0d0)then
			frac=(Tlow-Told)/(T-Told)
			Xlo=X1old+frac*(X(1)-X1old)			! Key-point II, III, IV, V
			Ylo=Yold+frac*(Y(1)-Yold)			! Key-point II, III, IV, V
			go to 11
		end if
	END IF
C	Check for HAEP
	zold=zdif
	zdif=w(1)-y(1)
	if(abs(w(1)-x(1)).lt.abs(zdif))zdif=w(1)-x(1)
	if(zold*zdif.lt.0.0)then ! linear interpolation to locate the HAEP
		NHAEP=NHAEP+1
		TH(NHAEP)=T-zdif*(TOLD-T)/(zold-zdif)
		PH(NHAEP)=Py-zdif*(POLD-Py)/(zold-zdif)
		ZH(NHAEP)=W(1)-zdif*(WOLD-W(1))/(zold-zdif)
		if(zdif.eq.w(1)-y(1))then
			DLH(NHAEP)=Dy-zdif*(DLOLD-Dy)/(zold-zdif)
		else
			DLH(NHAEP)=Dx-zdif*(DLOLD-Dx)/(zold-zdif)
		end if
		DVH(NHAEP)=DW-zdif*(DVOLD-DW)/(zold-zdif)
	end if
	IF (T.le.20.0d0) go to 11	! criteria for stopping at low T
	IF (LASTPOINT) THEN
c		WRITE(NOUT,9) TL,PL,XcL,XcL,YL,1.D0-YL,1.D0-XcL,DcL,DcL,DVL
		IF(TUB.EQ.0.0)THEN
			go to 11	! return
		ELSE
			llvtype=2	! go for second LLV part from UCEP(B) down in T
			tucep=TUB
c			WRITE(nout,*)
			LASTPOINT=.FALSE.
			go to 1
		END IF
	END IF
c	CALL DLSARG (N, RJAC, LDA, dFdS, IPATH, dXdS)
C
c       call dgesv( n, nrhs, a, lda, ipiv, b, ldb, info )
        b = dFdS
        AJ=RJAC
        call dgesv( N, 1, AJ, lda, ipiv, b, ldb, info )
        if (info.ne.0) write(6,*)"error with dgesv in parameter ",info
        dXdS = b
c        
	NSOLD=NS
	IF(llvtype.LE.3.and.NS.eq.1)goto 4
c
	IF(llvtype.EQ.2)THEN ! here NS=0
		delS0=delXS
		delX1=XVAR(1)-XOLD(1)
		aux0=log((Y(1)-X(1))/difold)
		rat10=abs(delX1/aux0)
		IF(Y(1)-X(1).GE.0.05.or.rat10.gt.0.02)THEN
			NS=1			! Specify temperature for next point
			delXS=delX1
			S=log(T)
			dXdS=dXdS*delS0/delXS
		END IF
c
	ELSE	! llvtype = 3 or 4
		IF(NS.eq.0)THEN
			NS=3			!	NS has to be 3 for the 2nd point after the UCEP
			dXdS3=dXdS(3)
			dXdS=dXdS/dXdS3
		ELSE
			NS=1 ! Specify Temperature to construct the line
			d3dT=abs(dXdS(3)/dXdS(1))
			X3dir=-(XVAR(3)-XOLD(3))
			if (d3dT.gt.R3min) then ! just after UCEPD or before LCEP ! .and.X3dir.lt.0
				Trat=T/tucep
				if(llvtype.eq.4.or.Trat.ge.0.9995)NS=3
			end if
		END IF
	END IF
 4	RJAC(7,1:7)=0.0D0
	if(NS.NE.0)then
		RJAC(7,NS)=1.0D0
	end if
	IF(NS.EQ.0)THEN
		NITER=min(niter,10)
		delXS=delXS*5/NITER
	ELSE
		delXS=dXdS(NS)*delXS*5/NITER
	END IF
	IF(NS.NE.NSOLD)dXdS=dXdS/dXdS(NS)
	if(T.lt.50.and.abs(delXS).lt.0.001)return
	IF(delXS.LT.0)then
	if(NS.EQ.1)delXS=max(delXS,-delTmax) ! Max lnT decrease allowed
	if(NS.EQ.3)delXS=max(delXS,-0.01) ! Max lny2 decrease allowed: 0.01  ! DO NOT CHANGE !!!
	ELSE
	if(NS.EQ.0)delXS=min(delXS,0.003,S/4) ! Max phase separation increase allowed: 0.003
	if(NS.EQ.1)delXS=min(delXS,0.01) ! Max lnT increase allowed: 0.5 K
	if(NS.EQ.3)delXS=min(delXS,0.01) ! Max lny2 increase allowed: 0.01
	END IF
	XOLD=XVAR
c	storing las point last point variables for HAEP check
	TOLD=T
	POLD=Py
	WOLD=w(1)
	YOLD=y(1)
	X1OLD=x(1)
	if(zdif.eq.w(1)-y(1))then
		DLOLD=Dy
	else
		DLOLD=Dx
	end if
	DVOLD=Dw
c
	HALF=.FALSE.
	difold=Y(1)-X(1)
	IF(NS.EQ.0)SOLD=S
C
  7	IF(NS.EQ.0)THEN
		S=SOLD+delXS
		XVAR=XOLD+dXdS*delXS	! Initial estimates for the 7 variables in the next point
	ELSE
		S=XOLD(NS)+delXS
		XVAR=XOLD+dXdS*delXS/dXdS(NS)	! Initial estimates for the 7 variables in the next point
	END IF
	if(llvtype.eq.2)go to 8
	D32=1.0d0-exp(XVAR(3))-exp(XVAR(2))
	D43=-exp(XVAR(4))+exp(XVAR(3))
	if(IIIaz)D43=-D43
	adXS=0	! when NS=1 (T specified)
	if(NS.EQ.3)adXS=abs(exp(S)-Y(2))
	T=exp(XVAR(1))
	IF(D32.LT.adXS.OR.D43.LT.adXS.or.(llvtype.eq.4.and.T.lt.TL))THEN
		IF(D43.GT.D32.and.llvtype.eq.4)then
			LASTPOINT=.TRUE.
		END IF
		delXS=delXS/2
				if(abs(delXS).lt.0.001)then
c					if(llvtype.eq.4)WRITE(NOUT,9) 
c     1				TL,PL,XcL,XcL,YL,1.D0-YL,1.D0-XcL,DcL,DcL,DVL
					if(llvtype.eq.4.and.TUB.ne.0.0d0)then
						llvtype=2	! go for second LLV part from UCEP(B) down in T
						tucep=TUB
c						WRITE(nout,*)
						LASTPOINT=.FALSE.
						go to 1
					end if
					return ! for llvtype=2
				end if
		go to 7
	END IF
 8	W(2)=exp(XVAR(4))
	W(1)=1.0D0-W(2)
	Y(2)=exp(XVAR(3))
	Y(1)=1.0D0-Y(2)
	GO TO 14
  9	FORMAT(F9.4,2E12.4,F8.5,x,F6.4,x,2E12.4E3,F9.4,F9.4,
	7	E12.4,I4,I2,E9.2)
 11	end
C
C
      SUBROUTINE XTVTERMO(INDIC,T,V,P,rn,
	1					FUGLOG,DLFUGT,DLFUGV,DLFUGX)
C
C-------parameters of XTVTERMO (crit. point, LLV and CEP calculations)
C
C       rn		mixture mole numbers                     (input)
C       t			temperature (k)                          (input)
C       v			volume	    (L)			                 (input)
C       p			pressure    (bar)                        (output)
C       FUGLOG    vector of log. of fugacities (x*phi*P)   (output)	INDIC < 5
C       DLFUGT    t-derivative of FUGLOG (const. vol,n)    (output)	INDIC = 2 or 4
C       DLFUGV    vol-derivative of FUGLOG (const temp,n)  (output)	INDIC < 5
C       DLFUGX    comp-derivative of FUGLOG (const t & v)  (output)	INDIC > 2
C---------------------------------------------------
C---  MODIFIED AND CORRECTED july 2005
C---
C---------------------------------------------------
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (MAXC=2,nco=2,RGAS=0.08314472d0)
      DIMENSION DLFUGX(MAXC,MAXC)
      DIMENSION FUGLOG(MAXC),DLFUGT(MAXC),DLFUGV(MAXC)
	dimension rn(nco),Arn(nco),ArVn(nco),ArTn(nco),Arn2(nco,nco)
	COMMON /MODEL/ NMODEL
	COMMON/NG/NGR
	COMMON /Pder/ DPDN(nco),DPDT,DPDV
	NG=NGR
	NC=2
C	IF(NMODEL.EQ.5) CALL PARAGC(T,NC,NG,1)      
	NTEMP=0
      IGZ=0
      NDER=1
      IF (INDIC.GT.2) NDER=2
      IF (INDIC.EQ.2 .OR. INDIC.EQ.4) NTEMP=1
	TOTN = sum(rn)
      RT = RGAS*T
	call ArVnder(NDER,NTEMP,rn,V,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
      P = TOTN*RT/V - ArV
      DPDV = -ArV2-RT*TOTN/V**2
      IF(INDIC.GT.4)GOTO 62
c      Z = P*V/(TOTN*RT)
	DPDT = -ArTV+TOTN*RGAS/V
	DO 60 I=1,NC
	IF(RN(I).EQ.0.0)GOTO 60
C		FUGLOG(I)=-LOG(Z)+Arn(I)/RT + log(rn(I)/TOTN) + log(P)
C		FUGLOG(I)=Arn(I)/RT + log(rn(I)/TOTN) + log(P/Z) this crashes at very low T LLV when Z=P=0.000000...
		FUGLOG(I)=Arn(I)/RT + log(rn(I)) + log(RT/V)
		DPDN(I) = RT/V-ArVn(I)
		DLFUGV(I)=-DPDN(I)/RT					! term DPDV/P is cancelled out
		IF(NTEMP.EQ.0) GOTO 60
		DLFUGT(I)=(ArTn(I)-Arn(I)/T)/RT+1.D0/T	! term DPDT/P is cancelled out
   60 CONTINUE
   62 IF(NDER.LT.2) GOTO 64
      DO 63 I=1,NC
      DO 61 K=I,NC
	    DLFUGX(I,K)=Arn2(I,K)/RT		! term 1/TOTN is cancelled out
   61		DLFUGX(K,I)=DLFUGX(I,K)
		DLFUGX(I,I)=DLFUGX(I,I)+1.0/rn(I)
   63 CONTINUE
   64 RETURN
      END
C
C
      SUBROUTINE TERMO(MTYP,INDIC,IC,T,P,rn,V,PHILOG,DLPHIT,DLPHIP,FUGN)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (MAXC=2,nco=2,RGAS=0.08314472d0)
      DIMENSION FUGN(MAXC,MAXC)
      DIMENSION PHILOG(MAXC),DLPHIT(MAXC),DLPHIP(MAXC),DPDN(MAXC)
	dimension rn(nco),Arn(nco),ArVn(nco),ArTn(nco),Arn2(nco,nco)
c	The output PHILOG is actually the vector ln(phi(i)*P)
	NC=2
	NTEMP=0
      IGZ=0
      NDER=1
      IF (INDIC.GT.2) NDER=2
      IF (INDIC.EQ.2 .OR. INDIC.EQ.4) NTEMP=1
	TOTN = sum(rn)
	if(P.le.0.0d0)MTYP=1
	CALL VCALC(MTYP,NC,rn,T,P,V)      
      RT = RGAS*T
      Z = V/(TOTN*RT)	! this is Z/P
	call ArVnder(NDER,NTEMP,rn,V,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
      DPV = -ArV2-RT*TOTN/V**2
	DPDT = -ArTV+TOTN*RGAS/V
      DO 60 I=1,NC
      PHILOG(I)=-LOG(Z)+Arn(I)/RT
      DPDN(I) = RT/V-ArVn(I)
      DLPHIP(I)=-DPDN(I)/DPV/RT-1.D0/P
	IF(NTEMP.EQ.0) GOTO 60
	DLPHIT(I)=(ArTn(I)-Arn(I)/T)/RT+DPDN(I)*DPDT/DPV/RT+1.D0/T
   60 CONTINUE
   62 IF(NDER.LT.2) GOTO 64
      DO 63 I=1,NC
      DO 61 K=I,NC
      FUGN(I,K)=1.D0/TOTN+(Arn2(I,K)+DPDN(I)*DPDN(K)/DPV)/RT 
   61 FUGN(K,I)=FUGN(I,K)
   63 CONTINUE
   64 RETURN
      END
c
      SUBROUTINE VCALC(ITYP,NC,rn,T,P,V)
C
C     ROUTINE FOR CALCULATION OF VOLUME, GIVEN PRESSURE
C
C     INPUT:
C
C     ITYP:        TYPE OF ROOT DESIRED
C     NC:          NO. OF COMPONENTS
C     rn:          FEED MOLES
C     T:           TEMPERATURE
C     P:           PRESSURE
C
C     OUTPUT:
C
C     V:           VOLUME
C
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (nco=2, RGAS=0.08314472d0)
	dimension rn(nco),dBi(nco),dBij(nco,nco)
	dimension Arn(nco),ArVn(nco),ArTn(nco),Arn2(nco,nco)
      LOGICAL FIRST_RUN
	NDER=0
      FIRST_RUN = .TRUE.
	TOTN = sum(rn)
	call Bcalc(rn,T,B)
	CPV=B
      S3R = 1.D0/CPV
      ITER = 0
C
      ZETMIN = 0.D0
      ZETMAX = 1.D0-0.01*T/500	!.99D0  This is flexible for low T (V very close to B)
      IF (ITYP .GT. 0) THEN
         ZETA = .5D0
         ELSE
C..............IDEAL GAS ESTIMATE
         ZETA = MIN (.5D0,CPV*P/(TOTN*RGAS*T))
      ENDIF
  100 CONTINUE
      V = CPV/ZETA
      ITER = ITER + 1
	call ArVnder(NDER,NTEMP,rn,V,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
      PCALC = TOTN*RGAS*T/V - ArV
      IF (PCALC .GT. P) THEN
         ZETMAX = ZETA
         ELSE
         ZETMIN = ZETA
      ENDIF
      AT  = (Ar + V*P) /(T*RGAS) - TOTN*LOG(V) 
C	AT is something close to Gr(P,T)
      DER = (ArV2*V**2+TOTN*RGAS*T)*S3R  ! this is dPdrho/B
      DEL = -(PCALC-P)/DER
      ZETA = ZETA + MAX (MIN(DEL,0.1D0),-.1D0)
      IF (ZETA .GT. ZETMAX .OR. ZETA .LT. ZETMIN)
     &      ZETA = .5D0*(ZETMAX+ZETMIN)
      IF (ABS(PCALC-P) .LT. 1D-12) GOTO 101
      IF (ABS(DEL) .GT. 1D-10) GOTO 100
 101	IF (ITYP .EQ. 0 ) THEN
C
C FIRST RUN WAS VAPOUR; RERUN FOR LIQUID
C
         IF (FIRST_RUN) THEN
            VVAP = V
            AVAP = AT
            FIRST_RUN = .FALSE.
            ZETA = 0.5D0
	      ZETMAX = 1.D0-0.01*T/500
            GOTO 100
            ELSE
            IF (AT .GT. AVAP) V = VVAP
          ENDIF
      ENDIF
      END
C
C
	SUBROUTINE ArVnder(NDER,NTD,rn,V,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (nco=2)
	dimension rn(nco),Arn(nco),ArVn(nco),ArTn(nco),Arn2(nco,nco)
	COMMON /MODEL/ NMODEL
	IF(NMODEL.LE.2)THEN
C	SRK or PR
		CALL HelmSRKPR(NDER,NTD,rn,V,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
	ELSE IF (NMODEL.EQ.3) THEN
		CALL HelmRKPR(NDER,NTD,rn,V,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
 	ELSE IF (NMODEL.EQ.4) THEN
C		CALL HelmPCSAFT(NDER,NTD,rn,V,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
 	ELSE IF (NMODEL.EQ.6) THEN
C		CALL HelmSPHCT(NDER,NTD,rn,V,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
	ELSE	!	GC-EOS
C		CALL HelmGC(NDER,NTD,rn,V,T,Ar,ArV,ArTV,ArV2,Arn,ArVn,ArTn,Arn2)
	END IF
      END
C
	SUBROUTINE Bcalc(x,T,BMIX)
c	This general subroutine provides the "co-volume" for specified composition, 
c	that will be used by Evalsecond or Vcalc
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (nco=2,MAXC=2,RGAS=0.08314472d0)
	DIMENSION x(nco),dBi(nco),dBij(nco,nco),DDB(0:3,MAXC)
      DIMENSION DD(0:3,MAXC),DDT(0:3,MAXC),DTT(0:3,MAXC),DIA(MAXC)
	COMMON /MODEL/ NMODEL
      COMMON/MOL/DC(2),D(2),DT(2),HA(2),HB(2)
      COMMON/MIXT/VCPM,CMIX,CVYM,CVYMT,dCVYM(MAXC),dCMIX(MAXC),
     *	dCVYMT(MAXC),d2CVYM(MAXC,MAXC),d2CMIX(MAXC,MAXC)
      COMMON/MIXRULE/NSUB
      COMMON/BMIX/B
	COMMON/forB/DDB
	COMMON/NG/NGR
	COMMON /rule/ncomb,iRuleDel
	NG=NGR
	NC=2
	if(NMODEL.EQ.5)then
C		CALL PARAGC(T,NCO,NG,1)      
		PI=3.1415926536D0
		XLAM3=0.0d0
		DO 3 I=1,NCO
		DGC=D(I)
 3	    XLAM3=XLAM3+X(I)*DGC**3
		B=PI/6.D0*XLAM3/1.0D3
	else if(NMODEL.EQ.4)then
	DD=DDB
C      CALL DIAMET(NCO,T,DIA,DD,DDT,DTT,NSUB)
          B=RGAS*(DD(3,1)*X(1)+DD(3,2)*X(2))	!S3
	else if(NMODEL.EQ.6)then
C		CALL Mixture_Param(NSUB,NC,X,T)
		B=VCPM
	else
	if(ncomb<=2)then
		call Bnder(2,x,B,dBi,dBij)	! Bmix is used in EVALSECOND
	else
		call Bcubicnder(2,x,B,dBi,dBij)
	end if
	end if
	BMIX=B
      END
C
C	C	C	eps=1.0D-6 for X derivatives and eps=1.0D-3 (when close to a pure) for calculation of c
c	c	c	are optimum and of critical importance for the performance of the calculations
c
	subroutine XTVnewtonCrit(NOUT,NS,delXS,X,T,V)
c	NS:		SPECIFIED VARIABLE (1,2,3 for Composition, lnT, lnV respectively)
c	delXS:	First step (from 1st to 2nd point) in the specified variable
c	
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (nco=2,TOL=1.0D-10,TOLX=1.0D-6,NA=2)
	DOUBLE PRECISION JAC(3,3),AJ(3,3)
      DIMENSION X(nco),rn(nco),F(3),DEL(3),XOLD(3),db(3),ipiv(3)
	DIMENSION XVAR(3),STEP(3),dFdS(3),sens(3),dXdS(3)
	DIMENSION TCmod(nco),CR(3,5)
	LOGICAL tpdminpos, tpdminneg, lineACE, lineB, lineD, GCPURE, STABCHECK
	LOGICAL CPMAX, CPmin, CALCLV, CALC393,TypeA
	COMMON /CASEOPT/ NCASE
      COMMON/tpdmin/ tpdminpos,tpdminneg,tpdpos,tpdneg,X2P,X2N,tpdmin
	COMMON/UCEPD/TUD,PUD,XcUD,DcUD,XL1,DL1
	COMMON/LCEP/ TL, PL, XcL, DcL, YL, DVL
	COMMON/UCEPB/TUB,PUB,XcUB,DcUB,Y2U, DVU
      COMMON/CRIT/TC(nco),PC(nco),DC(nco)
      COMMON/HKucep/vcri,stepx
      COMMON/TCGC/TCGC(nco),PCGC
	COMMON/PmaxLL/Phigh
	COMMON/CAEPcond/ DPDVcri
	COMMON/CAEP/ TAC(NA),PAC(NA),ZAC(NA),DAC(NA),NCAEP
      COMMON/EXTRAK/ IntCri, PcInt, XcInt, TcInt, islope, T9art
	COMMON/KeyT1/TcLV
	COMMON/CALC1/Pcr,Xcr
	COMMON/CALCint/Pci,Xci
	COMMON/CALC24/TUCEP,TLCEP
	COMMON/CALC3/T994,Tm,Pm,P393,Tu,Xu,Xlo,Ylo,Xmi,Ymi
	CALCLV=.FALSE.
	CALC393=.FALSE.
	CPMAX=.FALSE.
	CPmin=.FALSE.
	TypeA=.FALSE.
	PMAX=0.0 ! for CPM
	TCmod=TC
	Tc2=Tc(2)
	Tc1=Tc(1)
	if(TCGC(1).ne.0.0D0)TCmod=TCGC
	eps=min(1.0D-6,(1.d0-maxval(X))/20)
	deps=2*eps
	epsV=1.0D-6*V
	depsV=2*epsV
	epsT=1.0D-6*T
	depsT=2*epsT
	STABCHECK=.TRUE.	! use FALSE to disable the stability check and continue through the unstable region
	lineACE=.FALSE.
	lineB=.FALSE.
	lineD=.FALSE.
	GCPURE=.FALSE.
	tpdminpos=.false.
	tpdminneg=.false.
	delXmax=0.0010
	tpdm0=-5.0d-3	!5.D-5
	if(NS.EQ.1)then
C								STABCHECK=.FALSE.	! TO STUDY STRANGE BEHAVIOUR IN SRK & PR
		if (delXS.eq.0.D0) then
			GCPURE=.TRUE.
		elseif (abs(delXS)==1.1d-4) then  ! before it was: if(delXS.gt.0)
			lineACE=.TRUE.
        	IF(NCASE<=2)THEN
        	    TypeA=.TRUE.
	          STABCHECK=.FALSE.
			END IF
			DPDVcri=0.0d0
			P=PC(2) ! for Pold first point
		else
			lineD=.TRUE.
			tpdm0=-2.2D-4
			delXmax=0.0003
		end if
		delTmax=0.006
C		delTmax=1.5
	else if(NS.EQ.3)then
		lineB=.TRUE.
        T994=0.0
		P=Phigh+30
		delTmax=0.005
C		delTmax=0.3
		Pcheck=0.0D0
	end if
	N=3	! DLSARG CONSTANTS (now dgesv in MKL)
	LDA=3
	ldb=3
c	IPATH=1
	INCX=1
	F(1)=0
	dFdS(1)=1
	dFdS(2:3)=0
	step=0.0d0
	step(NS)=delxs
	Told=T
	Pold=P
 11	Tini=T
	Xini=X(1)
	ITER=1
	JAC(1,1:3)=0
	JAC(1,NS)=1.0D0
  	call bceval(X,T,V,P,b,c)
	F(2)=b
	F(3)=C
	DEL=1
c	Newton procedure for solving the present point
	DO WHILE (MAXVAL(ABS(DEL)).GT.TOLX)  
	IF(ITER.eq.6.and.delXS.ne.0)THEN	! Reduce to half step and try again
		delXS=delXS/2
		STEP=STEP/2
		XVAR=XOLD+STEP	! Initial estimates for the 3 variables
		X(1)=XVAR(1)
		X(2)=1.0D0-X(1)
		T=exp(XVAR(2))
		V=exp(XVAR(3))
		ITER=0
		GO TO 11
	END IF
		X(1)=X(1)+eps
		X(2)=1.0D0-X(1)
		call bceval(X,T,V,P,bpos,cpos)
		X(1)=X(1)-deps
		X(2)=1.0D0-X(1)
		call bceval(X,T,V,P,bneg,cneg)
		X(1)=X(1)+eps
		X(2)=1.0D0-X(1)
		JAC(2,1)=(bpos-bneg)/(deps)  !bX
		JAC(3,1)=(cpos-cneg)/(deps)  !cX
		T=T+epsT
		call bceval(X,T,V,P,bpos,cpos)
		T=T-depsT
		call bceval(X,T,V,P,bneg,cneg)
		T=T+epsT
		JAC(2,2)=T*(bpos-bneg)/(depsT)		!bT
		JAC(3,2)=T*(cpos-cneg)/(depsT)		!cT
		V=V+epsV
		call bceval(X,T,V,P,bpos,cpos)
		V=V-depsV
		call bceval(X,T,V,P,bneg,cneg)
		V=V+epsV
		JAC(2,3)=V*(bpos-bneg)/(depsV)		!bV
		JAC(3,3)=V*(cpos-cneg)/(depsV)		!cV
C
C		CALL DLSARG (N, JAC, LDA, -F, IPATH, del)
c       call dgesv( n, nrhs, a, lda, ipiv, b, ldb, info )
        db = -F
        AJ=JAC
        call dgesv( N, 1, AJ, lda, ipiv, db, ldb, info )
        if (info.ne.0) write(6,*)"error with dgesv in parameter ",info
        del = db
c        
C		Tref=max(T,2*(Tini-T))
C		if(T.lt.Tref.and.DEL(2).lt.0)Tref=T
		rmaxdel=maxval(abs(del))
		if (rmaxdel.ge.0.2) del=0.2*del/rmaxdel
 22		X1=X(1)+DEL(1)
	if(NS.NE.1.AND.(X1.gt.0.99999.or.X1.lt.1.0D-5))then ! TO CORRECT AN OVERSHOOTING BEYOND A PURE
C	1.0D-5 is used instead of 0 because numerical composition derivatives will be calculated 
c	by central differences (see lines above). This is no obstacle for the program.
		dist=x(1)
		if(X1.ge.1) dist=x(2)
		DEL=ABS(dist/DEL(1))*DEL/2
		T1=exp(log(T)+DEL(2))
c	  if(T1.gt.2*Tref.or.T1.le.0) DEL=ABS(Tref/DEL(2))*DEL/2
		goto 22
	end if
		X(1)=X1
		X(2)=1.0D0-X(1)
		T1=exp(log(T)+DEL(2))
c	if(T1.gt.2*Tref.or.T1.le.0)then
c		DEL=0.8*ABS(Tref/DEL(2))*DEL/2
c		goto 22
c	end if
		T=T1
		V=exp(log(V)+DEL(3))
  	call bceval(X,T,V,P,b,c) ! variables & DPDVcri to print come from this calling
		ITER=ITER+1
		F(2)=b
		F(3)=C
		IF(MAXVAL(ABS(DEL)).LE.2*TOLX.AND.ABS(F(2)*F(3)).LE.TOL)GOTO 3
		IF(NS.EQ.1.AND.ABS(DEL(2)*DEL(3)).LE.TOL)GOTO 3
	END DO
C	WRITE(nout,8)T,P,1/V,X1
 3	if (GCPURE) then
		PCGC=P
		GO TO 30
	end if
C      IF(T>309)THEN
C           CONTINUE
C      END IF
      IF(lineB.and.T994<1.0)THEN  
        T994=T  ! to be used when islope=1
      END IF
      IF(lineB.and.P>POLD)THEN
        STEP=-STEP
      END IF
	if(.not.lineACE)go to 26
	IF(NCASE.NE.3)THEN
		if(CALCLV)then
			Pcr=P				! Key-point I,II,IV
			Xcr=X(1)
			if(TypeA)x(1)=0.99999
			go to 30
		else
			if(IntCri==1)then
			    if((T-TcInt)*(Told-TcInt).lt.0.0d0)then
			        Pci=Pold+(P-Pold)*(TcInt-Told)/(T-Told)     ! improved on Feb 1st, 2013
			        Xci=X1o+(X(1)-X1o)*(TcInt-Told)/(T-Told)  ! improved on Feb 1st, 2013
			    end if
			end if
			if((T-TcLV)*(Told-TcLV).lt.0.0d0)then
				VcLV=V	! initial values
				Xcr=X(1)
C				IF(NCASE<=2.and.(Tc2-305)/(Tc2-306)>0.0)go to 23 ! This killed C1+C2 26/12/2012
                IF(NCASE<=2)THEN
				    IF((Tc1-304)/(Tc1-305)>0.0.or.(Tc2-305)/(Tc2-306)>0.0)go to 23
				END IF
			end if
		end if
	ELSE  ! IF(NCASE.eq.3)THEN
		if(CALC393)then
			P393=P				! Key-point III
			if(TypeA)x(1)=0.99999
			if(Tm<1.0)Tm=T ! added 3/7/2014
			go to 30
		else
			if((T-393.3)*(Told-393.3).lt.0.0d0)then ! .not.CPMAX.and. (added 3/7/2014)
				V393=V	! initial values
				X393=X(1)
				if(.not.CPMAX)then
					CPMAX=.TRUE.
					CPmin=.TRUE.
					Pm=P			! there is neither Pmax nor Pmin
				end if
			end if
		end if
		if(CPMAX)go to 15
		if(P.GT.Pmax)then
			Pmax=P				! Key-point for types I, II
c			TCPMax=T
c			XCPMax=X(1)
			if(P.GT.994.0)then	! the line passed 994 bar before reaching 393.3 K
				T994=T		
				Tm=T		
				Pm=994.0			! there is neither Pmax nor Pmin
				P393=994.0
				go to 30
			end if
		else
			CPMAX=.TRUE.
			Pm=P
		end if
		go to 27
 15		if(CPmin)go to 6
			if(P.LT.Pm)then
				Pm=P				! Key-point III
c			TCPM=T
c			XCPM=X(1)
			else
				CPmin=.TRUE.
				Tm=T
			end if
			go to 27
 6		if(T.LT.Tm)then
c			PTm=P
			Tm=T				! Key-point III
c			XTm=X(1)
		end if
		if((P-994.0)*(Pold-994.0).lt.0.0d0)then
			slope=(T-Told)/(P-Pold)
			T994=Told+slope*(994.0-Pold)			! Key-point III
			go to 28
		end if
	END IF
c
	if(lineACE.and.P.gt.Phigh) then
	  IF(NCASE.eq.1)	Pcr=Phigh+T-TcLV   
	  IF(NCASE>=4)	TLCEP=100    ! Key-point IV and V
	  IF(NCASE==5)	go to 23
	  IF(NCASE.eq.2.OR.NCASE.eq.4)THEN
	      TUCEP=100    ! Key-point II/IV
	      go to 23
	  END IF
	  go to 30
	end if
 26	if(lineB.and.P.le.5*PC(1).and.Pcheck.eq.0.0)then
		if(T.lt.TC(1))then
			call FindMaxIsotPure(1,T,Pcheck)
		else
			Pcheck=5*Pc(1)
		end if
	end if
	IF(.NOT.STABCHECK)GOTO 5
	IF(lineD.and.T<TL)GOTO 5
	if((lineB.and.P.gt.Pcheck).or.(lineACE.and.P-Pold.gt.0.0)) go to 5
C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	
C	STABILITY CHECK		C	C	C	C	C	C	C	C	C	C	C	C	C
	IF(lineACE.and.P.le.1.3*Pc(1))delTmax=0.002
	IF(P.LE.0.0D0)THEN ! Solution to the problem that vapour roots don't exist for P<0
		P=0.1		! This is just to generate initial values for the CEP when this is close to P=0
		W1=0.99999
		rn=[W1,1.0D0-W1]
		CALL VCALC(-1,2,rn,T,P,Vw1)
		W2=0.00001
		rn=[W2,1.0D0-W2]
		CALL VCALC(-1,2,rn,T,P,Vw2)
		Vw=max(Vw1,Vw2)
		W=W1
		if(Vw2.gt.Vw1)W=W2
		tpdm=-1
		Xc=X(1)
		go to 7
	END IF
	Xc=X(1)
	CALL CRITSTABCHECK(nout,T,P,Xc,W,tpdm,Vw)
	dif=0.02
	if(W>0.97)dif=(1.0d0-W)/1.5
 7	IF (tpdm.lt.-1.D-2.or.
	1	((ABS(Xc-W).gt.dif.or.Vw.gt.2*V).and.tpdm.lt.tpdm0/3).or.
	1  (ABS(Xc-W).gt.2*dif.and.lineD.and.tpdm.lt.tpdm0/3)) THEN
	if(lineB.and.Vw.le.2*V) go to 5
C	CEP calculation
		Vc=V
		Xc2=1.0D0-Xc
		Y2=1.0D0-W
		CALL CEPK (T,Xc2,Vc,Y2,Vw,P,ITER)
		W=1.0D0-Y2
		Xc=1.0D0-Xc2
c	if(P.lt.2.0) CALL CRITSTABCHECK(nout,T,P,Xc,W,tpdm,Vw)	   ! for printing tpd curve at CEP
C	write last critical point at CEP
C		WRITE(nout,8)T,P,1/Vc,Xc,Xc2
		GO TO 29
	ELSE IF (ABS(Xc-W).gt.dif) THEN
		STEP=STEP/2
	END IF
C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	
C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	C	
 5	den=1/V
c
c      go to 27  ! we are now considering azeotropy for the CO2+C2 case
C	IF((Tc2-305)/(Tc2-306)>0.0)go to 27 
	IF((Tc1-304)/(Tc1-305)>0.0.or.(Tc2-305)/(Tc2-306)>0.0)go to 27 
c	WRITE(nout,8)T,P,den,x(1),x(2),ITER,NS
c
C	Check for CAEP
	CR(3,1:5)=CR(2,1:5)
	CR(2,1:5)=CR(1,1:5)
	CR(1,1:5)=[dPdVcri,x(1),T,P,den]
	if(lineACE.and.CR(2,1).gt.-1.0d-2)then
	if(CR(1,1).lt.CR(2,1).and.CR(3,1).lt.CR(2,1))then !  location of the HAEP composition:
c	quadratic interpolation between the 2 smallest dPdV, assuming dPdV=-K*(X-Xaz)2
		NCAEP=NCAEP+1
		L=1
		if(CR(1,1).lt.CR(3,1))L=2
		A=CR(L,1)-CR(L+1,1) ! a line in CR contains [dPdV,x1,T,P,rho]
		B=2*(CR(L,2)*CR(L+1,1)-CR(L+1,2)*CR(L,1))
		C=CR(L+1,2)**2*CR(L,1)-CR(L,2)**2*CR(L+1,1)
		SQ=SQRT(B*B-4*A*C)
		Z1=(-B+SQ)/(2*A)
		Z2=(-B-SQ)/(2*A)
		ZAC(NCAEP)=Z1
		if((Z2-CR(L,2))*(Z2-CR(L+1,2)).lt.0.0)ZAC(NCAEP)=Z2
c	linear inter/extrapolation for the other variables vs. composition
		DZU=ZAC(NCAEP)-CR(L,2)
		DZD= CR(L+1,2)-CR(L,2)
		TAC(NCAEP)=CR(L,3)+DZU*(CR(L+1,3)-CR(L,3))/DZD
		PAC(NCAEP)=CR(L,4)+DZU*(CR(L+1,4)-CR(L,4))/DZD
		DAC(NCAEP)=CR(L,5)+DZU*(CR(L+1,5)-CR(L,5))/DZD
		go to 23    ! for the CO2+C2 case 
	end if
	end if
c27	CALL DLSARG (3, JAC, LDA, dFdS, IPATH, dXdS)
C
c       call dgesv( n, nrhs, a, lda, ipiv, b, ldb, info )
  27     db = dFdS
        AJ=JAC
      call dgesv( N, 1, AJ, lda, ipiv, db, ldb, info )
        if (info.ne.0) write(6,*)"error with dgesv in parameter ",info
        dXdS = db
c        
	NSOLD=NS
	if(.not.lineD)then    ! .and.STABCHECK
		sens(1)=2*dXdS(1)
		sens(2)=dXdS(2)
		sens(3)=dXdS(3)/2
		NS = IDAMAX (3, sens, INCX)
c		NS = IDAMAX (3, dXdS, INCX)
	end if
	if(NS.ne.NSOLD)then
	dSdSold=dXdS(NS)
	dXdS=dXdS/dSdSold
	JAC(1,1:3)=0.0D0
	JAC(1,NS)=1.0D0
	end if
c	IF(ITER.GT.10)ITER=10	! After first point with arbitrary initial values
	delXS=4*STEP(NSOLD)/dXdS(NSOLD)/ITER ! new step in specified variable
	delPmax=max(P/5,1.0)
	If(abs(P-Pold).gt.delPmax)then
		delXS=ITER*delXS/8	! reducing 50% the step to prevent large overshooting of UCEP LL
	End if
C	STEP(NSOLD) will be the last delXS unless it was reduced (first if in the do loop)
	IF(delXS.LT.0)then
	if(NS.EQ.1)delXS=max(delXS,-delXmax) ! Max X(1) decrease allowed: 0.0002 (D), 0.001 otherwise
	if(NS.EQ.2)delXS=max(delXS,-delTmax)  ! Max temp. decrease allowed
	if(NS.EQ.3)delXS=max(delXS,-0.005) ! Max volume decrease allowed
	ELSE
	if(NS.EQ.1)delXS=min(delXS,0.005) ! Max X(1)  increase allowed: 0.005
	if(NS.EQ.2)delXS=min(delXS,delTmax)  ! Max temp. increase allowed
	if(NS.EQ.3)delXS=min(delXS,0.010) ! Max volume increase allowed
	END IF
  2	XOLD(1)=X(1)
	XOLD(2)=log(T)
	XOLD(3)=log(V)
	if(lineB.and.Pold-P.gt.30)delXS=delXS/2
c	if(P.lt.2.0)delXS=0.71*delXS						   ! for printing tpd curve at CEP
	STEP=dXdS*delXS	
	XVAR=XOLD+STEP	! Initial estimates for the 3 variables in the next point
	Told=T
	Pold=P
	X1o=X(1)
  4	if(XVAR(1).ge.1.0D0)then ! WHEN CLOSE TO ENDING AT A PURE
		delXS=delXS*minval(X)/abs(dXdS(1)*delXS) ! this is the step to a pure component
		delXS=delXS/2
		goto 2
	end if
	if(lineACE.AND.XVAR(1).gt.0.9999)then ! end of line A
		TypeA=.true.	! line A predicted (types I/II) eventhoug we might be interested in type III
		IF(NCASE.eq.3)THEN
			Tm=100.0
			T994=100.0
			GO TO 28
		END IF
		WRITE(nout,8)TCmod(1),PC(1),DC(1),1.0,0.0 ! Component 1 critical point
		X(1)=XVAR(1)
		go to 30
	end if
	X(1)=XVAR(1)
	X(2)=1.0D0-X(1)
	T=exp(XVAR(2))
	V=exp(XVAR(3))
	GO TO 11
  8   FORMAT (F9.4,x,F9.4,F10.4,F10.6,x,E11.5,i4,i4,2x,E11.5)
 12	vcri=V
	stepX=X(1)-XVAR(1)+STEP(1)
	go to 30
c	Print Critical End Point
 29	write(nout,*)
C	write(nout,*) ' Critical End Point: '
C	if(w.lt.xc) then
C	write(nout,*) ' T(K)     P(bar)    X(1)  
C	1   XL1(1)   dc(mol/L)  dL(mol/L)'
C	else
C	write(nout,*) ' T(K)     P(bar)    X(1)  
C	1   Y1(1)    dc(mol/L)  dV(mol/L)'
C	end if
C	write(NOUT,*)'CEP'
C	write(nout,17) T, P, Xc, W,1/Vc,1/Vw,ITER
  17	FORMAT (F8.4,x,F8.4,F10.6,F10.6,F10.4,F11.4,I2)
C	write(NOUT,*)
C	storing CEP to use later in LLVlines
	IF(lineD)THEN
		TUD=T
		PUD=P
		XcUD=Xc
		DcUD=1/Vc
		XL1=W
		DL1=1/Vw
		Tu=TUD			! Key-point III
		Xu=XL1			! Key-point III
	ELSE IF(lineACE)THEN
		TL=T
		TLCEP=TL    ! Key-point IV
		PL=P
		XcL=Xc
		DcL=1/Vc
		YL=W
		DVL=1/Vw
		GO TO 23
	ELSE	! lineB
		TUB=T
		TUCEP=TUB    ! Key-point II/IV
		PUB=P
		XcUB=Xc
		DcUB=1/Vc
		Y2U=Y2
		DVU=1/Vw
	END IF
	go to 30
 23	CALCLV=.TRUE.
	NS=2
	V=VcLV
	T=TcLV
	X(1)=Xcr
	X(2)=1.0D0-X(1)
	GO TO 11
 28	CALC393=.TRUE.
	IF(ITER.GE.30) T994=0
	NS=2
	V=V393
	T=393.3
	X(1)=X393
	X(2)=1.0D0-X(1)
	GO TO 11
c
 30	end

c	subroutine bceval(nder,z,T,P,Vcri,b,c,bT,cT,bP,cP)
	subroutine bceval(z,T,V,P,b,c)
c	INPUT:  z,T,V
c	OUTPUT: P,b,c
c
C	The following subroutine must be included in a separate .for file:
C   XTVTERMO(NTYP,T,V,P,z,FUG,FUGT,FUGV,FUGN)
C   INPUT:
C     NTYP:   LEVEL OF DERIVATIVES, SEE BELOW
C     T:      TEMPERATURE (K)
C     V:      MOLAR VOLUME (L/MOL)
C     z:      COMPOSITION (MOLES, NEED NOT BE NORMALIZED)
C   OUTPUT:
C     P:      PRESSURE (bar)
C     FUG:    VECTOR OF LOG FUGACITIES (ALL NTYP)
C     FUGT:   T-DERIVATIVE OF FUG (NTYP = 2, 4 OR 5)
C     FUGV:   V-DERIVATIVE OF FUG (ALL NTYP)
C     FUGN:   MATRIX OF COMPOSITION DERIVATIVES OF FUG (NTYP >=3)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (nco=2)
      DIMENSION z(nco)
      DIMENSION sqz(nco),ym(nco),u(nco),up(nco),y(nco)
	COMMON /Pder/ DPDN(nco),DPDT,DPDV
	COMMON /CAEPcond/ DPDVcri
	eps=1.0D-4
 1	sqz(1)=sqrt(z(1))
	sqz(2)=sqrt(z(2))
	call eigcalc(z,T,V,P,b,u)
	dpdvcri=dpdv
c	calculation of b at s=eps  (e)
	y(1)=z(1)+eps*u(1)*sqz(1)
	y(2)=z(2)+eps*u(2)*sqz(2)
	if(minval(y).lt.0)then
		call modifyz(z)
		go to 1
	end if
	call eigcalc(y,T,V,Pp,bpos,up)
c	calculation of b at s=-eps  (m)
	ym(1)=z(1)-eps*u(1)*sqz(1)
	ym(2)=z(2)-eps*u(2)*sqz(2)
	if(minval(ym).lt.0)then
		call modifyz(z)
		goto 1
	end if
	call eigcalc(ym,T,V,Pn,bneg,up)
c	calculation of c
	c=(bpos-bneg)/2.0/eps
	end
c
	subroutine modifyz(z)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      DIMENSION z(2)
	if(z(1).lt.z(2))then
		z(1)=2*z(1)
		z(2)=1.0d0-z(1)
	else
		z(2)=2*z(2)
		z(1)=1.0d0-z(2)
	end if
	end
c
	subroutine eigcalc(z,T,V,P,b,u)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (nco=2)
      DIMENSION z(nco),FUG(nco),FUGT(nco),FUGV(nco),FUGN(nco,nco)
      DIMENSION u(nco)
      jac=5 ! FUGN is required, but not FLT
      call XTVTERMO(jac,T,V,P,z,FUG,FUGT,FUGV,FUGN)
	bet=-z(1)*FUGN(1,1)-z(2)*FUGN(2,2)
	gam=z(1)*z(2)*(FUGN(1,1)*FUGN(2,2)-FUGN(1,2)**2)
	sq=sqrt(bet**2-4*gam)
	rlam1=(-bet+sq)/2
	rlam2=(-bet-sq)/2
	if(abs(rlam1).lt.abs(rlam2))then
		b=rlam1
	else
		b=rlam2
	end if
	u2=(b-z(1)*FUGN(1,1))/(sqrt(z(1)*z(2))*FUGN(1,2)) ! k=u2/u1=u2
	u(1)=sqrt(1/(1+u2*u2))  !normalization
	u(2)=sqrt(1-u(1)**2)
	if(u2.lt.0) u(2)=-u(2)
	end
C
C     purpose of routine CRITSTABCHECK:
C
C     To find the composition where the tangent plane distance respect to the 
C     critical composition takes on its minimum value at given T and P
C
C     Parameters:
C
C     T       (I)       Temperature
C     P       (I)       Pressure
C     Xc	    (I)       Composition of the critical point
C     W       (O)       Composition of the minimum tpd
C     tpdm    (O)       Value of the minimum tpd
C
      SUBROUTINE CRITSTABCHECK (nout,T,P,Xc,W,tpdm,Vw)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (MAXC=2)
      DIMENSION Z(MAXC), FUG(MAXC),FT(MAXC),FP(MAXC),
     *      FX(MAXC,MAXC)
      DIMENSION fc(MAXC),FTAB(0:200),VTAB(0:200)
	LOGICAL	PRINTPD
c	The output of TERMO PHILOG is actually the vector ln(phi(i)*P)
	PRINTPD=.false.														! for printing curve
C							Activate/comment also additional calling to CRITSTABCHECK after CEPK
c									and reduction of delXS (between flags 2 and 4)
      Z(1) = Xc
      Z(2) = 1.D0-Z(1)
	CALL TERMO(0,1,IC,T,P,Z,V,FUG,FT,FP,FX)
      fc(1)=log(Z(1))+FUG(1)		! fc(i) is ln(Xc(i)*phi(i)*P)
      fc(2)=log(Z(2))+FUG(2)
C
C     CALCULATE TABLE OF VALUES OF tpd
C
      STEP = 0.02D0							
	NP=50
	IF (P.lt.2.0.AND.PRINTPD) THEN
		STEP = 0.005D0							
		NP=200
	END IF
      DO K = 0,NP
         Z(1) = max(1.0d-10,DBLE(K)/NP)
         Z(2) = max(1.0d-10,1.D0-Z(1))
		if(K.eq.NP)Z(1)=1.0d0-Z(2)
		CALL TERMO(0,1,IC,T,P,Z,V,FUG,FT,FP,FX)
         VTAB(K)=V
         FTAB(K)=Z(1)*(log(Z(1))+FUG(1)-fc(1))
         FTAB(K)=FTAB(K)+Z(2)*(log(Z(2))+FUG(2)-fc(2))
			if(P.lt.2.0.AND.PRINTPD)write(nout,1)K*step,FTAB(K)		! printing curve
	ENDDO
  1	format (F6.3,2x,E11.4)
C
C     CALCULATE MAXVAL
C
      INUM = MINLOC(FTAB(0:NP),DIM=1)-1
	if (INUM.EQ.0.or.INUM.EQ.NP) then
		if (INUM.EQ.0) then
			W = STEP/2
			Zlim=0.D0
		else if (INUM.EQ.NP) then
			W = 1.0d0-STEP/2
			Zlim=1.D0
		end if
		DO
			Z(1) = W
			Z(2) = 1.0d0-Z(1)
			CALL TERMO(0,1,IC,T,P,Z,Vw,FUG,FT,FP,FX)
		   tpdm=Z(1)*(log(Z(1))+FUG(1)-fc(1))
		   tpdm=tpdm+Z(2)*(log(Z(2))+FUG(2)-fc(2))
			W = (Z(1)+Zlim)/2
			if(tpdm.le.FTAB(INUM))go to 99
		END DO
	else
		DERV1 = (FTAB(INUM+1)-FTAB(INUM-1))/(2.D0*STEP)
		DERV2 = (FTAB(INUM+1)-2.D0*FTAB(INUM)+FTAB(INUM-1))/STEP**2
C
C     INTERPOLATE TO OPTIMUM
C
		DELX = -DERV1/DERV2
	end if
      W = DBLE(INUM)/NP + DELX
      tpdm = FTAB(INUM) + DELX*(DERV1+.5D0*DELX*DERV2)
	Vw = VTAB(INUM)
 99   END
C
	SUBROUTINE CEPK (T,Zc2,Vc,Y2,Vy,P,ITER)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (nco=2,TOL=1.0D-7,TOLX=1.0D-6)
	DOUBLE PRECISION JAC(5,5),AJ(5,5)
      DIMENSION F(5),DEL(5),DPcDN(nco),rel(5),db(5),ipiv(5)
      DIMENSION X(nco),FUGc(nco),FUGTc(nco),FUGVc(nco),FUGNc(nco,nco)
      DIMENSION Yn(nco),FUG(nco),FUGT(nco), FUGV(nco), FUGN(nco,nco)
	COMMON /Pder/ DPDN(nco),DPDT,DPDV
C	Variables are [T,lnZc2,Vc,lnY2,lnVy]
	N=5	! DLSARG CONSTANTS (now dgesv in MKL)
	LDA=5
	ldb=5
c	IPATH=1
	epsV=1.0D-6*Vc
	depsV=2*epsV
	epsT=1.0D-6*T
	depsT=2*epsT
	ITER=0
	JAC(1:2,4:5)=0.0D0	! Always zero
	X(1)=1.0D0-Zc2
	X(2)=Zc2
	Yn(2)=Y2
	Yn(1)=1.0D0-Y2
	DEL=1
c	Newton procedure for solving the CEP equations
	DO WHILE (MAXVAL(ABS(DEL)).GT.TOLX)  
		eps=min(1.0D-6,x(2)/20)
		deps=2*eps
		call XTVTERMO(4,T,Vc,Pc,X,FUGc,FUGTc,FUGVc,FUGNc)
		DPcDN=DPDN
		DPcDT=DPDT
		DPcDV=DPDV
21		call XTVTERMO(4,T,Vy,Py,Yn,FUG,FUGT,FUGV,FUGN)
		DPyDV=DPDV
		if(Pc.GT.0.0.AND.(Py.lt.0.95*Pc.or.Py.gt.1.05*Pc))then
			if(DPyDV.lt.0)then  ! very important for convergence and accuracy of P at low T
				Vy=max(0.9*Vy,Vy+(Pc-Py)/DPyDV)
			else	! mechanical instability region
				Vy=0.9*Vy
			end if
			go to 21
		end if
  		call bceval(X,T,Vc,Pc,b,c)
		F(1)=b
		F(2)=C
		F(3)=Pc-Py
		F(4)=FUGc(1)-FUG(1)
		F(5)=FUGc(2)-FUG(2)
		ITER=ITER+1
		IF(MAXVAL(ABS(DEL)).LE.5*TOLX.AND.MAXVAL(ABS(F)).LE.TOL)GOTO 3
		X(1)=X(1)+eps
		X(2)=1.0D0-X(1)
		call bceval(X,T,Vc,P,bpos,cpos)
		X(1)=X(1)-deps
		X(2)=1.0D0-X(1)
		call bceval(X,T,Vc,P,bneg,cneg)
		X(1)=X(1)+eps
		X(2)=1.0D0-X(1)
		JAC(1,2)=-X(2)*(bpos-bneg)/(deps)  !(db/dlnX2)
		JAC(2,2)=-X(2)*(cpos-cneg)/(deps)  !(dc/dlnX2)
		T=T+epsT
		call bceval(X,T,Vc,P,bpos,cpos)
		T=T-depsT
		call bceval(X,T,Vc,P,bneg,cneg)
		T=T+epsT
		JAC(1,1)=(bpos-bneg)/(depsT)		!bT
		JAC(2,1)=(cpos-cneg)/(depsT)		!cT
		Vc=Vc+epsV
		call bceval(X,T,Vc,P,bpos,cpos)
		Vc=Vc-depsV
		call bceval(X,T,Vc,P,bneg,cneg)
		Vc=Vc+epsV
		JAC(1,3)=(bpos-bneg)/(depsV)		!bV
		JAC(2,3)=(cpos-cneg)/(depsV)		!cV
C
		JAC(3,1)= DPcDT-DPDT
		JAC(3,2)= X(2)*(DPcDN(2)-DPcDN(1))
		JAC(3,3)= DPcDV
		JAC(3,4)= -Yn(2)*(DPDN(2)-DPDN(1))
		JAC(3,5)= -DPyDV*Vy
C
		JAC(4,1)= FUGTc(1)-FUGT(1)
		JAC(4,2)= X(2)*(FUGNc(1,2)-FUGNc(1,1))
		JAC(4,3)= FUGVc(1)
		JAC(4,4)= -Yn(2)*(FUGN(1,2)-FUGN(1,1))
		JAC(4,5)= -FUGV(1)*Vy
C
		JAC(5,1)= FUGTc(2)-FUGT(2)
		JAC(5,2)= X(2)*(FUGNc(2,2)-FUGNc(2,1))
		JAC(5,3)= FUGVc(2)
		JAC(5,4)= -Yn(2)*(FUGN(2,2)-FUGN(2,1))
		JAC(5,5)= -FUGV(2)*Vy
C
C		CALL DLSARG (N, JAC, LDA, -F, IPATH, del)
c       call dgesv( n, nrhs, a, lda, ipiv, b, ldb, info )
        db = -F
        AJ=JAC
        call dgesv( N, 1, AJ, lda, ipiv, db, ldb, info )
        if (info.ne.0) write(6,*)"error with dgesv in parameter ",info
        del = db
c        
		rel(1)=del(1)/T
		rel(2)=del(2)/log(X(2))
		rel(3)=del(3)/Vc
		rel(4)=del(4)/log(Yn(2))
		rel(5)=del(5)/log(Vy)
		relmax=maxval(abs(rel))
		if(relmax.ge.0.2)delx=delx*0.1/relmax
		call Bcalc(Yn,T,Bmix)
 27		Vy0=exp(log(Vy)+DEL(5))
		if (Vy0.lt.1.01*Bmix)then
			DEL=DEL/2
			go to 27
		end if
		call Bcalc(X,T,Bmix)
 28		if (Vc+DEL(3).lt.1.01*Bmix)then
			DEL=DEL/2
			go to 28
		end if
 22		Zc2=exp(log(X(2))+DEL(2))
		Y2=exp(log(Yn(2))+DEL(4))
		if (min(Zc2,Y2).lt.0.or.max(Zc2,Y2).gt.1)then
			DEL=DEL/2
			go to 22
		end if
		X(2)=Zc2
		X(1)=1.0D0-Zc2
		T=T+DEL(1)
		Vc=Vc+DEL(3)
		Yn(2)=Y2
		Yn(1)=1.0D0-Yn(2)
		Vy=exp(log(Vy)+DEL(5))
	END DO
 3	Zc2=X(2)
	Y2=Yn(2)
	P=(Pc+Py)/2
	END
c
	subroutine PTpointBin(P,T,X1,Y2) ! Adapted from TxyZone (specifying T)
c
c	X1: guess for the molar fraction of comp. 1 in the first phase
c	Y2: guess for the molar fraction of comp. 2 in the second phase
c	
      implicit double precision (A-H,O-Z)
      PARAMETER (nco=2,RGAS=0.08314472d0,eps=1.0d-7)
C
c	The independent variables are lnX,lnY2,lnVx,lnVy,lnT
c	we use X<Y
c	The equations are 2 equipressure, 2 equifugacity and specification.
      DIMENSION X(2),Y(2),IPH(2),b(5),ipiv(5)
      DIMENSION XVAR(5),F(5),dFdS(5),dXdS(5),delX(5),RJAC(5,5),AJ(5,5)
      DIMENSION FUGx(2),FUGy(2),FUGTx(2),FUGTy(2),FUGVx(2),FUGVy(2)
      DIMENSION DFGNx(2,2),DFGNy(2,2),DFG1NTP(2)
      DIMENSION DPDNx(2),DPDNy(2),OLD(5)
 	dimension Arn(nco),ArVn(nco),ArTn(nco)
	COMMON/UNIT/NOUT
	COMMON/Pder/ DPDN(2),DPDT,DPDV
	TOLF=1.0D-5	! for residuals
	TOL= 1.0D-6	! for variables
	N=5	! DLSARG CONSTANTS (now dgesv in MKL)
	LDA=5
	ldb=5
c	IPATH=1
	DFDS=0.0D0
	DFDS(5)=-1.0D0
	NS=5  ! lnT to be specified
	IPH=[1,-1]
	XVAR(5)=log(T)
	XVAR(1)=log(X1)
	XVAR(2)=log(Y2)
	X=[X1,1.0D0-X1]
	Y=[1.0D0-Y2,Y2]
	CALL VCALC(IPH(1),2,X,T,P,V)
	Vx=V
	XVAR(3)=log(V)
	CALL VCALC(IPH(2),2,Y,T,P,V)
	Vy=V
	XVAR(4)=log(V)
 14	NITER=0
	FMAXOLD=8.0D0
	FMAX=7.0D0
	DMAXOLD=8.0D0
	DMAX=7.0D0
	RJAC(5,1:5)=0.0D0
	F(5)=0.0D0		! log(T)-S (specification: T)
	RJAC(5,5)=1.0D0
c	Newton procedure for solving the present point
	DO WHILE (DMAX.GT.TOL.or.FMAX.GT.TOLF)
		IF ((FMAX.GT.FMAXOLD.and.DMAX.GT.DMAXOLD).or.niter.GE.10) THEN
			! WRITE(NOUT,*) 'NITER PT= ', NITER
			if(niter.GE.25)exit
		END IF
	    NITER=NITER+1
 21		CALL XTVTERMO(4,T,Vx,Px,X,FUGx,FUGTx,FUGVx,DFGNx)
c		INDIC=4 (T derivatives are required)
	    DPDNx=DPDN
	    DPDVx=DPDV
	    DPDTx=DPDT
		CALL XTVTERMO(4,T,Vy,Py,Y,FUGy,FUGTy,FUGVy,DFGNy)
	    DPDNy=DPDN
	    DPDVy=DPDV
	    DPDTy=DPDT
		IBACK=0
		if(Px.lt.0.8*P.OR.(Px.gt.1.2*P.and.Px-P.gt.1.d-10))then
			Vxold=Vx
			call Bcalc(X,T,Bmix)
			if(DPDVx.lt.0)then
				Vx=max(0.9*Vx,Vx+(P-Px)/DPDVx,1.005*Bmix)
C				if(Vx.eq.Vxold)go to 11  ! return
			else	! mechanical instability region
				Vx=max(0.9*Vx,1.005*Bmix)
			end if
			XVAR(3)=log(Vx)
			IBACK=1
		end if
		if(Py.lt.0.8*P.OR.(Py.gt.1.2*P.and.Py-P.gt.1.d-10))then
			Vyold=Vy
			call Bcalc(Y,T,Bmix)
			if(DPDVy.lt.0)then
				Vy=max(0.9*Vy,Vy+(P-Py)/DPDVy,1.005*Bmix)
C				if(Vy.eq.Vyold)go to 11  ! return
			else	! mechanical instability region
				Vy=max(0.9*Vy,1.005*Bmix)
			end if
			XVAR(4)=log(Vy)
			IBACK=1
		end if
		if(IBACK.EQ.1) go to 21
		if((Vy.gt.Vx.and.(Px.lt.P/2.OR.Px.gt.2*P)).or.
	1		(Vx.gt.Vy.and.(Py.lt.P/2.OR.Py.gt.2*P)))then
			Vxold=Vx
			if(DPDVx.lt.0)then  ! very important for convergence and accuracy of P at low T
				Vx=max(0.9*Vx,Vx+(P-Px)/DPDVx)
C				if(Vx.eq.Vxold)go to 11  ! return
			else	! mechanical instability region
				Vx=0.9*Vx
			end if
			XVAR(3)=log(Vx)
			Vyold=Vy
			if(DPDVy.lt.0)then  ! very important for convergence and accuracy of P at low T
				Vy=max(0.9*Vy,Vy+(P-Py)/DPDVy)
			else	! mechanical instability region
				Vy=0.9*Vy
			end if
			XVAR(4)=log(Vy)
			go to 21
		end if
		F(1)=log(Px/P)
		F(2)=log(Py/P)
		F(3)=FUGx(1)-FUGy(1)
		F(4)=FUGx(2)-FUGy(2)
C
		RJAC(1,1)=x(1)*(DPDNx(1)-DPDNx(2))/Px
		RJAC(2,2)=-Y(2)*(DPDNy(1)-DPDNy(2))/Py
		RJAC(1,3)=Vx*DPDVx/Px	! (1,2)=(2,1)=(1,4)=(2,3)=0
		RJAC(2,4)=Vy*DPDVy/Py
		RJAC(1,5)=T*DPDTx/Px
		RJAC(2,5)=T*DPDTy/Py
C
		RJAC(3:4,1)=x(1)*(DFGNx(1:2,1)-DFGNx(1:2,2))
		RJAC(3:4,2)=Y(2)*(DFGNy(1:2,1)-DFGNy(1:2,2))
		RJAC(3:4,3)=Vx*FUGVx(1:2)
		RJAC(3:4,4)=-Vy*FUGVy(1:2)
		RJAC(3:4,5)=T*(FUGTx(1:2)-FUGTy(1:2))
C
C		CALL DLSARG (N, RJAC, LDA, -F, IPATH, delX)
c       call dgesv( n, nrhs, a, lda, ipiv, b, ldb, info )
        b = -F
        AJ=RJAC
        call dgesv( N, 1, AJ, lda, ipiv, b, ldb, info )
        if (info.ne.0) write(6,*)"error with dgesv in parameter ",info
        delX = b
c        
		DMAXOLD=DMAX
		DMAX=MAXVAL(ABS(DELX))
		OLD=XVAR
 17		XVAR=OLD+delX
		IF(MAXVAL(ABS(DELX)).ge.2.0/NITER.or.XVAR(1).gt.0)THEN
			delX=delX/2
			go to 17
		END IF
		Vx=exp(XVAR(3))
		Vy=exp(XVAR(4))
		X(1)=exp(XVAR(1))
		X(2)=1.0D0-X(1)
		Y(2)=exp(XVAR(2))
		Y(1)=1.0D0-Y(2)
		T=exp(XVAR(5))
		call Bcalc(Y,T,BmixY)
		call Bcalc(X,T,BmixX)
		if (Vx.lt.1.01*BmixX.or.Vy.lt.1.01*BmixY)then
			delX=delX/2
			go to 17
		end if
		FMAXOLD=FMAX
		FMAX=MAXVAL(ABS(F))
		if(DMAX.lt.1.0D-5.and.FMAX*DMAX.lt.1.0D-10)exit
	END DO
	X1=X(1)
	Y2=Y(2)
	end
C
c
	subroutine PzpointBin(IZ,P,T,X1,Y2) ! Adapted from TxyZone (specifying x1 or y2)
c
c	 T: guess for temperature
c	X1: molar fraction of comp. 1 in the first phase (fixed for IZ=1, guessed for IZ=2)
c	Y2: molar fraction of comp. 2 in the second phase (fixed for IZ=2, guessed for IZ=1)
c	
      implicit double precision (A-H,O-Z)
      PARAMETER (nco=2,RGAS=0.08314472d0,eps=1.0d-7)
C
c	The independent variables are lnX,lnY2,lnVx,lnVy,lnT
c	we use X<Y
c	The equations are 2 equipressure, 2 equifugacity and specification.
      DIMENSION X(2),Y(2),IPH(2),b(5),ipiv(5)
      DIMENSION XVAR(5),F(5),dFdS(5),dXdS(5),delX(5),RJAC(5,5),AJ(5,5)
      DIMENSION FUGx(2),FUGy(2),FUGTx(2),FUGTy(2),FUGVx(2),FUGVy(2)
      DIMENSION DFGNx(2,2),DFGNy(2,2),DFG1NTP(2)
      DIMENSION DPDNx(2),DPDNy(2),OLD(5)
 	dimension Arn(nco),ArVn(nco),ArTn(nco)
	COMMON/UNIT/NOUT
	COMMON/Pder/ DPDN(2),DPDT,DPDV
	TOLF=1.0D-5	! for residuals
	TOL= 1.0D-6	! for variables
	N=5	! DLSARG CONSTANTS (now dgesv in MKL)
	LDA=5
	ldb=5
c	IPATH=1
	DFDS=0.0D0
	DFDS(5)=-1.0D0
	NS=IZ  ! ln(X1) or ln(Y2) to be specified
	IPH=[1,-1]
	XVAR(5)=log(T)
	XVAR(1)=log(X1)
	XVAR(2)=log(Y2)
	X=[X1,1.0D0-X1]
	Y=[1.0D0-Y2,Y2]
	CALL VCALC(IPH(1),2,X,T,P,V)
	Vx=V
	XVAR(3)=log(V)
	CALL VCALC(IPH(2),2,Y,T,P,V)
	Vy=V
	XVAR(4)=log(V)
 14	NITER=0
	FMAXOLD=8.0D0
	FMAX=7.0D0
	DMAXOLD=8.0D0
	DMAX=7.0D0
	RJAC(5,1:5)=0.0D0
	F(5)=0.0D0		! log(X1 or Y2) - S (composition specified)
	RJAC(5,IZ)=1.0D0
c	Newton procedure for solving the present point
	DO WHILE (DMAX.GT.TOL.or.FMAX.GT.TOLF)
		IF ((FMAX.GT.FMAXOLD.and.DMAX.GT.DMAXOLD).or.niter.GE.10) THEN
			WRITE(NOUT,*) 'NITER PT= ', NITER
			if(niter.GE.20)exit
		END IF
	    NITER=NITER+1
 21		CALL XTVTERMO(4,T,Vx,Px,X,FUGx,FUGTx,FUGVx,DFGNx)
c		INDIC=4 (T derivatives are required)
	    DPDNx=DPDN
	    DPDVx=DPDV
	    DPDTx=DPDT
		CALL XTVTERMO(4,T,Vy,Py,Y,FUGy,FUGTy,FUGVy,DFGNy)
	    DPDNy=DPDN
	    DPDVy=DPDV
	    DPDTy=DPDT
		IBACK=0
		if(Px.lt.0.8*P.OR.(Px.gt.1.2*P.and.Px-P.gt.1.d-10))then
			Vxold=Vx
			call Bcalc(X,T,Bmix)
			if(DPDVx.lt.0)then
				Vx=max(0.9*Vx,Vx+(P-Px)/DPDVx,1.005*Bmix)
C				if(Vx.eq.Vxold)go to 11  ! return
			else	! mechanical instability region
				Vx=max(0.9*Vx,1.005*Bmix)
			end if
			XVAR(3)=log(Vx)
			IBACK=1
		end if
		if(Py.lt.0.8*P.OR.(Py.gt.1.2*P.and.Py-P.gt.1.d-10))then
			Vyold=Vy
			call Bcalc(Y,T,Bmix)
			if(DPDVy.lt.0)then
				Vy=max(0.9*Vy,Vy+(P-Py)/DPDVy,1.005*Bmix)
C				if(Vy.eq.Vyold)go to 11  ! return
			else	! mechanical instability region
				Vy=max(0.9*Vy,1.005*Bmix)
			end if
			XVAR(4)=log(Vy)
			IBACK=1
		end if
		if(IBACK.EQ.1) go to 21
		if((Vy.gt.Vx.and.(Px.lt.P/2.OR.Px.gt.2*P)).or.
	1		(Vx.gt.Vy.and.(Py.lt.P/2.OR.Py.gt.2*P)))then
			Vxold=Vx
			if(DPDVx.lt.0)then  ! very important for convergence and accuracy of P at low T
				Vx=max(0.9*Vx,Vx+(P-Px)/DPDVx)
C				if(Vx.eq.Vxold)go to 11  ! return
			else	! mechanical instability region
				Vx=0.9*Vx
			end if
			XVAR(3)=log(Vx)
			Vyold=Vy
			if(DPDVy.lt.0)then  ! very important for convergence and accuracy of P at low T
				Vy=max(0.9*Vy,Vy+(P-Py)/DPDVy)
			else	! mechanical instability region
				Vy=0.9*Vy
			end if
			XVAR(4)=log(Vy)
			go to 21
		end if
		F(1)=log(Px/P)
		F(2)=log(Py/P)
		F(3)=FUGx(1)-FUGy(1)
		F(4)=FUGx(2)-FUGy(2)
C
		RJAC(1,1)=x(1)*(DPDNx(1)-DPDNx(2))/Px
		RJAC(2,2)=-Y(2)*(DPDNy(1)-DPDNy(2))/Py
		RJAC(1,3)=Vx*DPDVx/Px	! (1,2)=(2,1)=(1,4)=(2,3)=0
		RJAC(2,4)=Vy*DPDVy/Py
		RJAC(1,5)=T*DPDTx/Px
		RJAC(2,5)=T*DPDTy/Py
C
		RJAC(3:4,1)=x(1)*(DFGNx(1:2,1)-DFGNx(1:2,2))
		RJAC(3:4,2)=Y(2)*(DFGNy(1:2,1)-DFGNy(1:2,2))
		RJAC(3:4,3)=Vx*FUGVx(1:2)
		RJAC(3:4,4)=-Vy*FUGVy(1:2)
		RJAC(3:4,5)=T*(FUGTx(1:2)-FUGTy(1:2))
C
c		CALL DLSARG (N, RJAC, LDA, -F, IPATH, delX)
c       call dgesv( n, nrhs, a, lda, ipiv, b, ldb, info )
        b = -F
        AJ=RJAC
        call dgesv( N, 1, AJ, lda, ipiv, b, ldb, info )
        if (info.ne.0) write(6,*)"error with dgesv in parameter ",info
        delX = b
c        
		DMAXOLD=DMAX
		DMAX=MAXVAL(ABS(DELX))
		OLD=XVAR
 17		XVAR=OLD+delX
		IF(MAXVAL(ABS(DELX)).ge.6.0/NITER.or.XVAR(1).gt.0)THEN
			delX=delX/2
			go to 17
		END IF
		Vx=exp(XVAR(3))
		Vy=exp(XVAR(4))
		if(IZ.EQ.2)then
			X(1)=exp(XVAR(1))
			X(2)=1.0D0-X(1)
		else
			Y(2)=exp(XVAR(2))
			Y(1)=1.0D0-Y(2)
		end if
		T=exp(XVAR(5))
		call Bcalc(Y,T,BmixY)
		call Bcalc(X,T,BmixX)
		if (Vx.lt.1.01*BmixX.or.Vy.lt.1.01*BmixY)then
			delX=delX/2
			go to 17
		end if
		FMAXOLD=FMAX
		FMAX=MAXVAL(ABS(F))
		if(DMAX.lt.1.0D-5.and.FMAX*DMAX.lt.1.0D-10)exit
	END DO
	X1=X(1)
	Y2=Y(2)
	end
C
c
	subroutine TzpointBin(IZ,P,T,X1,Y2) ! Adapted from PxyZone (specifying x1 or y2)
c
c	 P: guess for pressure
c	X1: molar fraction of comp. 1 in the first phase (fixed for IZ=1, guessed for IZ=2)
c	Y2: molar fraction of comp. 2 in the second phase (fixed for IZ=2, guessed for IZ=1)
c	
      implicit double precision (A-H,O-Z)
      PARAMETER (nco=2,RGAS=0.08314472d0,eps=1.0d-7)
C
c	The independent variables are lnX,lnY2,lnVx,lnVy,lnT
c	we use X<Y
c	The equations are 2 equipressure, 2 equifugacity and specification.
      DIMENSION X(2),Y(2),IPH(2),b(4),ipiv(4)
      DIMENSION XVAR(4),F(4),dFdS(4),dXdS(4),delX(4),RJAC(4,4),AJ(4,4)
      DIMENSION FUGx(2),FUGy(2),FUGT(2),FUGVx(2),FUGVy(2)
      DIMENSION DFGNx(2,2),DFGNy(2,2),DFG1NTP(2)
      DIMENSION DPDNx(2),DPDNy(2),OLD(4)
 	dimension Arn(nco),ArVn(nco),ArTn(nco)
	COMMON/UNIT/NOUT
	COMMON/Pder/ DPDN(2),DPDT,DPDV
	TOLF=1.0D-5	! for residuals
	TOL= 1.0D-6	! for variables
	N=4	! DLSARG CONSTANTS (now dgesv in MKL)
	LDA=4
	ldb=4
c	IPATH=1
	DFDS=0.0D0
	DFDS(4)=-1.0D0
	NS=IZ  ! ln(X1) or ln(Y2) to be specified
	IPH=[1,-1]
	XVAR(1)=log(X1)
	XVAR(2)=log(Y2)
	X=[X1,1.0D0-X1]
	Y=[1.0D0-Y2,Y2]
	CALL VCALC(IPH(1),2,X,T,P,V)
	Vx=V
	XVAR(3)=log(V)
	CALL VCALC(IPH(2),2,Y,T,P,V)
	Vy=V
	XVAR(4)=log(V)
 14	NITER=0
	FMAXOLD=8.0D0
	FMAX=7.0D0
	DMAXOLD=8.0D0
	DMAX=7.0D0
	RJAC(4,1:4)=0.0D0
	F(4)=0.0D0		! log(X1 or Y2) - S (composition specified)
	RJAC(4,IZ)=1.0D0
c	Newton procedure for solving the present point
	DO WHILE (DMAX.GT.TOL.or.FMAX.GT.TOLF)
		IF ((FMAX.GT.FMAXOLD.and.DMAX.GT.DMAXOLD).or.niter.GE.10) THEN
			WRITE(NOUT,*) 'NITER PT= ', NITER
			if(niter.GE.20)exit
		END IF
	    NITER=NITER+1
 21		CALL XTVTERMO(3,T,Vx,Px,X,FUGx,FUGT,FUGVx,DFGNx)
	    DPDNx=DPDN
	    DPDVx=DPDV
		CALL XTVTERMO(3,T,Vy,Py,Y,FUGy,FUGT,FUGVy,DFGNy)
	    DPDNy=DPDN
	    DPDVy=DPDV
		IBACK=0
	  if(Vy.gt.Vx)then
		if(Py.gt.0.d0.and.  	! to prevent case LL when both P<0
	1	(Px.lt.Py/2.OR.(Px.gt.2*Py.and.Px-Py.gt.1.d-10)))then
			Vxold=Vx
			call Bcalc(X,T,Bmix)
			if(DPDVx.lt.0)then  ! very important for convergence and accuracy of P at low T
				Vx=max(0.9*Vx,Vx+(Py-Px)/DPDVx,1.005*Bmix)
				if(Vx.eq.Vxold)exit
			else	! mechanical instability region
				Vx=max(0.9*Vx,1.005*Bmix)
			end if
			XVAR(3)=log(Vx)
			go to 21
		end if
	  else		! when vapour is the x phase
		if(Px.gt.0.d0.and.   	! to prevent case LL when both P<0
	1	(Py.lt.Px/2.OR.(Py.gt.2*Px.and.Py-Px.gt.1.d-10)))then
			Vyold=Vy
			call Bcalc(Y,T,Bmix)
			if(DPDVy.lt.0)then  ! very important for convergence and accuracy of P at low T
				Vy=max(0.9*Vy,Vy+(Px-Py)/DPDVy,1.005*Bmix)
				if(Vy.eq.Vyold)exit
			else	! mechanical instability region
				Vy=max(0.9*Vy,1.005*Bmix)
			end if
			XVAR(4)=log(Vy)
			go to 21
		end if
	  end if
	  if((Vy.gt.Vx.and.Py.lt.0.d0).or.(Vy.lt.Vx.and.Px.lt.0.d0))then
		if(Px.lt.0.8*P.OR.(Px.gt.1.2*P.and.Px-P.gt.1.d-10))then
			Vxold=Vx
			call Bcalc(X,T,Bmix)
			if(DPDVx.lt.0)then
				Vx=max(0.9*Vx,Vx+(P-Px)/DPDVx,1.005*Bmix)
C				if(Vx.eq.Vxold)go to 11  ! return
			else	! mechanical instability region
				Vx=max(0.9*Vx,1.005*Bmix)
			end if
			XVAR(3)=log(Vx)
			IBACK=1
		end if
		if(Py.lt.0.8*P.OR.(Py.gt.1.2*P.and.Py-P.gt.1.d-10))then
			Vyold=Vy
			call Bcalc(Y,T,Bmix)
			if(DPDVy.lt.0)then
				Vy=max(0.9*Vy,Vy+(P-Py)/DPDVy,1.005*Bmix)
C				if(Vy.eq.Vyold)go to 11  ! return
			else	! mechanical instability region
				Vy=max(0.9*Vy,1.005*Bmix)
			end if
			XVAR(4)=log(Vy)
			IBACK=1
		end if
	  end if
	  if(IBACK.EQ.1) go to 21
		F(1)=log(Px/Py)
		F(2)=FUGx(1)-FUGy(1)
		F(3)=FUGx(2)-FUGy(2)
C
		RJAC(1,1)=x(1)*(DPDNx(1)-DPDNx(2))/Px
		RJAC(1,2)=Y(2)*(DPDNy(1)-DPDNy(2))/Py
		RJAC(1,3)=Vx*DPDVx/Px
		RJAC(1,4)=-Vy*DPDVy/Py
C
		RJAC(2:3,1)=x(1)*(DFGNx(1:2,1)-DFGNx(1:2,2))
		RJAC(2:3,2)=Y(2)*(DFGNy(1:2,1)-DFGNy(1:2,2))
		RJAC(2:3,3)=Vx*FUGVx(1:2)
		RJAC(2:3,4)=-Vy*FUGVy(1:2)
C
c		CALL DLSARG (N, RJAC, LDA, -F, IPATH, delX)
c       call dgesv( n, nrhs, a, lda, ipiv, b, ldb, info )
        b = -F
        AJ=RJAC
        call dgesv( N, 1, AJ, lda, ipiv, b, ldb, info )
        if (info.ne.0) write(6,*)"error with dgesv in parameter ",info
        delX = b
c        
		DMAXOLD=DMAX
		DMAX=MAXVAL(ABS(DELX))
		OLD=XVAR
 17		XVAR=OLD+delX
		IF(MAXVAL(ABS(DELX)).ge.6.0/NITER.or.XVAR(1).gt.0)THEN
			delX=delX/2
			go to 17
		END IF
		Vx=exp(XVAR(3))
		Vy=exp(XVAR(4))
		if(IZ.EQ.2)then
			X(1)=exp(XVAR(1))
			X(2)=1.0D0-X(1)
		else
			Y(2)=exp(XVAR(2))
			Y(1)=1.0D0-Y(2)
		end if
		call Bcalc(Y,T,BmixY)
		call Bcalc(X,T,BmixX)
		if (Vx.lt.1.01*BmixX.or.Vy.lt.1.01*BmixY)then
			delX=delX/2
			go to 17
		end if
		FMAXOLD=FMAX
		FMAX=MAXVAL(ABS(F))
		if(DMAX.lt.1.0D-5.and.FMAX*DMAX.lt.1.0D-10)exit
	END DO
	X1=X(1)
	Y2=Y(2)
	P=(Px+Py)/2
	end
C
	subroutine PTxyFUG(P,T,X1,Y1,dfug) 
c
      implicit double precision (A-H,O-Z)
      PARAMETER (nco=2,RGAS=0.08314472d0,eps=1.0d-7)
C
      DIMENSION X(2),Y(2),IPH(2)
      DIMENSION FUGx(2),FUGy(2),FUGT(2),FUGVx(2),FUGVy(2)
      DIMENSION DFGNx(2,2),DFGNy(2,2),DFG1NTP(2)
      DIMENSION dfug(2)
	IPH=[1,-1]
	X=[X1,1.0D0-X1]
	Y=[Y1,1.0D0-Y1]
c	Y=[1.0D0-Y2,Y2]
	CALL VCALC(IPH(1),2,X,T,P,V)
	Vx=V
	CALL VCALC(IPH(2),2,Y,T,P,V)
	Vy=V
	CALL XTVTERMO(3,T,Vx,Px,X,FUGx,FUGT,FUGVx,DFGNx)
	CALL XTVTERMO(3,T,Vy,Py,Y,FUGy,FUGT,FUGVy,DFGNy)
	dfug(1)=FUGx(1)-FUGy(1)
	dfug(2)=FUGx(2)-FUGy(2)
C
	end
C
	subroutine nm_opt(xguess, n, stat)
	   implicit none
         real(8) :: xguess(n)
         integer :: n
	   integer :: stat
         real(8) :: start(n), xmin(n), ynewlo, reqmin, step(n)
         integer :: konvge, kcount
         integer :: icount, numres, ifault
	   integer :: funit_settings
	   integer :: iostat

	   namelist /nm_settings/ konvge, kcount, step, reqmin

	   funit_settings = 1
	   ! Reading from the main input file
	   read(funit_settings, nml=nm_settings, iostat=iostat)

	   ! If namelist not found, set some defaults
	   if (iostat /= 0) then
		konvge = 1000
		kcount = 1e8
		step = 1d-3
		reqmin = 1d-6
	   end if
         
	   start = xguess
	   print *, "=================="
	   print *, "Nelder-Mead"
         print *, "NM_0: ", xguess
         call nelmin ( nm_f, n, start, xmin, ynewlo, reqmin, step,
     &                 konvge, kcount, icount, numres, ifault )

	   xguess = xmin
	   print *, "------------------"
	   print *, "Stat: ", ifault
	   print *, "Evals: ", icount
	   print *, "X: ", xguess
	   print *, "F: ", ynewlo
	   print *, "=================="
	   stat = ifault
	contains
         function nm_f(xx)
            external :: F
            real(8) :: F
            real(8) :: xx(*)
            real(8) :: nm_f
            nm_f = F(xx, N)
         end function
	end subroutine

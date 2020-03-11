!***********************************************************************
!                            cea.include  
!***********************************************************************
!
!  The following parameters set the maximum dimensions for many variables
!    They are defined in part 2, page 39 of the manuals, NASA RP-1311.
!    The variable NCOL set the number of columns in the output.  It may
!    be increased for wider paper or smaller fonts.
!
      INTEGER MAXNGC,MAXNC,NCOL,MAXMAT,MAXTR,MAXR,MAXEL,MAXNG,MAXMIX,&
              MAXT,MAXPV
      PARAMETER (MAXNGC=600)
      PARAMETER (MAXNC=300)
      PARAMETER (NCOL=8)
      PARAMETER (MAXMAT=150)
      PARAMETER (MAXTR=40)
      PARAMETER (MAXR=24)
      PARAMETER (MAXEL=20)
      PARAMETER (MAXNG=500)
      PARAMETER (MAXMIX=52)
      PARAMETER (MAXT=51)
      PARAMETER (MAXPV=26)
!
!  The following parameters set the input/output unit numbers.  These
!    numbers are also defined in the manual, part2 p39, and may be 
!    adjusted as desired.
!
      INTEGER IOSCH,IOTHM,IOPLT,IOTRN,IOINP,IOOUT
      PARAMETER (IOINP= 5)
      PARAMETER (IOOUT= 6)
      PARAMETER (IOSCH=13)
      PARAMETER (IOTHM=14)
      PARAMETER (IOPLT=15)
      PARAMETER (IOTRN=18)
!***********************************************************************
      REAL*16 Enn,Ennl,Enlsav,Ensave,Sumn
      REAL*16 Deln(MAXNGC),Enln(MAXNGC),Sln(MAXNGC)
      REAL*16 En(MAXNGC,NCOL)
      COMMON /COMP  / Deln,En,Enln,Enn,Ennl,Enlsav,Ensave,Sln,Sumn
!
      INTEGER Ip,Iplt,It,Nc,Ng,Ngp1,Nlm,Nplt,Nof,Nomit,Nonly,Np,Npr,Npt,&
              Ngc,Nsert,Nspr,Nspx,Nt
      INTEGER Jcond(45),Jx(MAXEL),Nfla(MAXR),Ifz(MAXNC)
      COMMON /INDX  / Ip,Iplt,It,Jcond,Jx,Nc,Ng,Ngp1,Nlm,Nplt,Nof,Nomit,&
                      Nonly,Np,Npr,Npt,Ngc,Nsert,Nspr,Nspx,Nt,Nfla,Ifz
!
      REAL*16 Cpmix,Wmix,Bcheck
      REAL*16 Am(2),Hpp(2),Vmin(2),Vpls(2),Wp(2),Atmwt(100),Oxf(MAXMIX),&
             P(MAXPV),Rh(2),T(MAXT),V(MAXPV),Valnce(100)
      REAL*16 B0p(MAXEL,2)
      COMMON /INPT  / Am,B0p,Cpmix,Hpp,Vmin,Vpls,Wmix,Wp,Atmwt,Bcheck,&
                      Oxf,P,Rh,T,V,Valnce
!
      INTEGER Imat,Iq1,Isv,Jliq,Jsol,Lsave,Msing
      COMMON /MISCI / Imat,Iq1,Isv,Jliq,Jsol,Lsave,Msing
!
      LOGICAL Convg,Debug(NCOL),Detdbg,Detn,Eql,Gonly,Hp,Ions,Massf,&
              Moles,Newr,Pderiv,Shock,Short,Siunit,Sp,Tp,Trnspt,Vol
      COMMON /MISCL / Convg,Debug,Detdbg,Detn,Eql,Gonly,Hp,Ions,Massf,&
                      Moles,Newr,Pderiv,Shock,Short,Siunit,Sp,Tp,Trnspt,&
                      Vol
!
      REAL*16 Avgdr,Boltz,Eqrat,Hsub0,Oxfl,Pi,Pp,R,Rr,Size,S0,Tln,Tm,&
             Trace,Tt,Viscns,Vv
      REAL*16 Atwt(MAXEL),B0(MAXEL),X(MAXMAT)
      REAL*16 A(MAXEL,MAXNGC),G(MAXMAT,MAXMAT+1)
      COMMON /MISCR / A,Atwt,Avgdr,Boltz,B0,Eqrat,G,Hsub0,Oxfl,Pi,Pp,R,&
                      Rr,Size,S0,Tln,Tm,Trace,Tt,Viscns,Vv,X
!
      CHARACTER*2 Elmt(MAXEL),Ratom(MAXR,12),Symbol(100)
      CHARACTER*4 Fmt(30)
      CHARACTER*8 Fox(MAXR)
      CHARACTER*10 Thdate
      CHARACTER*15 Case,Energy(MAXR),Omit(0:MAXNGC),Pltvar(20),&
                   Prod(0:MAXNGC),Rname(MAXR)
      CHARACTER*200 Pfile
      COMMON /CDATA / Case,Elmt,Energy,Fmt,Fox,Omit,Pltvar,Prod,Ratom,&
                      Rname,Symbol,Thdate,Pfile
!
      REAL*16 Cpr(NCOL),Dlvpt(NCOL),Dlvtp(NCOL),Gammas(NCOL),Hsum(NCOL),&
             Ppp(NCOL),Ssum(NCOL),Totn(NCOL),Ttt(NCOL),Vlm(NCOL),&
             Wm(NCOL)
      REAL*16 Pltout(500,20)
      COMMON /PRTOUT/ Cpr,Dlvpt,Dlvtp,Gammas,Hsum,Ppp,Ssum,Totn,Ttt,Vlm,&
                      Wm,Pltout
!
      INTEGER Nreac
      INTEGER Jray(MAXR)
      REAL*16 Dens(MAXR),Enth(MAXR),Pecwt(MAXR),Rmw(MAXR),Rtemp(MAXR)
      REAL*16 Rnum(MAXR,12)
      COMMON /REACTN/ Dens,Enth,Pecwt,Rmw,Rnum,Rtemp,Jray,Nreac
!
      REAL*16 Cpsum
      REAL*16 Cft(MAXNC,9),Coef(MAXNG,9,3),Temp(2,MAXNC)
      REAL*16 Cp(MAXNGC),H0(MAXNGC),Mu(MAXNGC),Mw(MAXNGC),S(MAXNGC),Tg(4)
      COMMON /THERM / Cft,Coef,Cp,Cpsum,H0,Mu,Mw,S,Temp,Tg
!
      INTEGER Iopt,Isup,Nfz,Npp,Nsub,Nsup
      LOGICAL Area,Debugf,Fac,Froz,Page1,Rkt
      REAL*16 Acat,Awt,Cstr,Tcest,Ma
      REAL*16 Aeat(NCOL),App(NCOL),Pcp(2*NCOL),Sonvel(NCOL),Spim(NCOL),&
             Subar(13),Supar(13),Vmoc(NCOL)
      COMMON /ROCKT / Acat,Aeat,App,Awt,Cstr,Ma,Pcp,Sonvel,Spim,Subar,&
                      Supar,Vmoc,Tcest,Area,Iopt,Debugf,Fac,Froz,Isup,&
                      Nfz,Npp,Nsub,Nsup,Page1,Rkt
!
      INTEGER Nsk
      LOGICAL Incdeq,Incdfz,Refleq,Reflfz,Shkdbg
      REAL*16 U1(NCOL),Mach1(NCOL),A1,Gamma1
      COMMON /SHOCKS/ U1,Mach1,A1,Gamma1,Incdeq,Incdfz,Refleq,Reflfz,&
                      Shkdbg,Nsk
!
      INTEGER Nm,Nr,Ntape
      INTEGER Ind(MAXTR),Jcm(MAXEL)
      REAL*16 Cprr(MAXTR),Con(MAXTR),Wmol(MAXTR),Xs(MAXTR)
      REAL*16 Eta(MAXTR,MAXTR),Stc(MAXTR,MAXTR)
      COMMON /TRNP  / Cprr,Con,Eta,Wmol,Xs,Stc,Ind,Jcm,Nm,Nr,Ntape
!
      REAL*16 Coneql(NCOL),Confro(NCOL),Cpeql(NCOL),Cpfro(NCOL),&
             Preql(NCOL),Prfro(NCOL),Vis(NCOL)
      COMMON /TRPTS / Coneql,Confro,Cpeql,Cpfro,Preql,Prfro,Vis

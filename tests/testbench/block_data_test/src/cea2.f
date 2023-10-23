      PROGRAM CEA2
      IMPLICIT NONE
      INCLUDE 'cea.inc'
C LOCAL VARIABLES
      INTEGER i,inc,j,ln,n

      REAL*8 xi,xln
      REAL*8 DLOG
      SAVE i,inc,j,ln,n, xi,xln
C

      Newr = .FALSE.
 100  Iplt = 0
      Nplt = 0

C WV added initialisation of Nc, Ng, Nsert, Ngc, Ngp1
      Nc = MAXNC
      Ng = MAXNGC
      Nsert = 42
      Ngc = MAXNGC
      Ngp1 = Ng+1
C INITIAL ESTIMATES
        Npr = 0
        Gonly = .TRUE.
        Enn = .1D0
        Ennl = -2.3025851
        Sumn = Enn
        xi = Ng
        IF ( xi.EQ.0. ) xi = 1.
        xi = Avgdr*Enn/xi
        xln = DLOG(xi)*Boltz
        DO inc = 1,Nc
          j = Ng + inc
          En(j,1) = 0.D0
          Enln(j) = 0.D0
        ENDDO
        DO j = 1,Ng
          En(j,1) = xi
          Enln(j) = xln
        ENDDO
        IF ( Nc.NE.0.AND.Nsert.NE.0 ) THEN
          DO 120 i = 1,Nsert
            DO j = Ngc,Ngp1, - 1
                Npr = Npr + 1
                Jcond(Npr) = j
            ENDDO
 120      CONTINUE
        ENDIF
        PRINT *, 'DONE', Avgdr, Boltz

      END

      BLOCKDATA 
      IMPLICIT NONE
      INCLUDE 'cea.inc'
C
      DATA Rr/8314.51D0/,Pi/3.14159265D0/,Avgdr/6.0221367D0/,
     & Boltz/1.380658D0/
      END

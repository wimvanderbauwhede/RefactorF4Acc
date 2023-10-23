      program test_external
       REAL AREA, LOW, HIGH 
       EXTERNAL fcn, f2
       integer f2
       LOW = 1.0
       HIGH=2.0
       AREA = 4.0
       print *, fcn((low+high)*area)
       print *, f2((low+high)*area)
       CALL RUNGE ( FCN, LOW, HIGH, AREA ) 
      END 

      real FUNCTION FCN( X ) 
        fcn = x*4.0-6.0 
        return
      END

      integer FUNCTION F2( X ) 
        fcn = int(x)*4-6 
        return
      END

      SUBROUTINE RUNGE ( F, X0, X1, A ) 
       print *, f((x0+x1)*a)
       RETURN 
      END 

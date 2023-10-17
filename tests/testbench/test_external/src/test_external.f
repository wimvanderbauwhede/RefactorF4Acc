      program test_external
       REAL AREA, LOW, HIGH 
       EXTERNAL fcn
       LOW = 1.0
       HIGH=2.0
       AREA = 4.0
       print *, fcn((low+high)*area)
       CALL RUNGE ( FCN, LOW, HIGH, AREA ) 
      END 

      real FUNCTION FCN( X ) 
        fcn = x*4.0-6.0 
        return
      END

      SUBROUTINE RUNGE ( F, X0, X1, A ) 
       print *, f((x0+x1)*a)
       RETURN 
      END 

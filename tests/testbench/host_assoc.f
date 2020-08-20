      program host_assoc
      REAL, DIMENSION (2) :: A
      REAL :: B, C
      !EQUIVALENCE (A (1), B), (A (2), B) ! Not standard conforming
      EQUIVALENCE (A (1), B), (A (2), C) ! Not standard conforming
      real v1,v2,v3,v4,v5
      equivalence (v1,v2,v3),(v2,v3,v4,v5)
      integer v
      v1=42
      v=42
      call t
      print *, v1,v2,v3,v4,v5
      end
      
      subroutine t
          print *,v
      end subroutine

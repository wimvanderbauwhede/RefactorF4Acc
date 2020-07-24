module singleton_module_src_blas

contains

      subroutine dgemm(transa,transb,m,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
!      .. Scalar Arguments ..
      implicit none
      character(len=1), intent(In) :: transa
      character(len=1), intent(In) :: transb
      integer, intent(In) :: m
      integer, intent(In) :: n
      integer, intent(In) :: k
      integer, intent(In) :: lda
      integer, intent(In) :: ldb
      integer, intent(In) :: ldc
      real(kind=8), intent(In) :: alpha
      real(kind=8), intent(In) :: beta
!      .. Array Arguments ..
      real(kind=8), dimension(1:lda,1:*), intent(In) :: a
      real(kind=8), dimension(1:ldb,1:*), intent(In) :: b
      real(kind=8), dimension(1:ldc,1:*), intent(Out) :: c
!      ..
! 
!   Purpose
!   =======
! 
!   DGEMM  performs one of the matrix-matrix operations
! 
!      C := alpha*op( A )*op( B ) + beta*C,
! 
!   where  op( X ) is one of
! 
!      op( X ) = X   or   op( X ) = X',
! 
!   alpha and beta are scalars, and A, B and C are matrices, with op( A )
!   an m by k matrix,  op( B )  a  k by n matrix and  C an m by n matrix.
! 
!   Parameters
!   ==========
! 
!   TRANSA - CHARACTER*1.
!            On entry, TRANSA specifies the form of op( A ) to be used in
!            the matrix multiplication as follows:
! 
!               TRANSA = 'N' or 'n',  op( A ) = A.
! 
!               TRANSA = 'T' or 't',  op( A ) = A'.
! 
!               TRANSA = 'C' or 'c',  op( A ) = A'.
! 
!            Unchanged on exit.
! 
!   TRANSB - CHARACTER*1.
!            On entry, TRANSB specifies the form of op( B ) to be used in
!            the matrix multiplication as follows:
! 
!               TRANSB = 'N' or 'n',  op( B ) = B.
! 
!               TRANSB = 'T' or 't',  op( B ) = B'.
! 
!               TRANSB = 'C' or 'c',  op( B ) = B'.
! 
!            Unchanged on exit.
! 
!   M      - INTEGER.
!            On entry,  M  specifies  the number  of rows  of the  matrix
!            op( A )  and of the  matrix  C.  M  must  be at least  zero.
!            Unchanged on exit.
! 
!   N      - INTEGER.
!            On entry,  N  specifies the number  of columns of the matrix
!            op( B ) and the number of columns of the matrix C. N must be
!            at least zero.
!            Unchanged on exit.
! 
!   K      - INTEGER.
!            On entry,  K  specifies  the number of columns of the matrix
!            op( A ) and the number of rows of the matrix op( B ). K must
!            be at least  zero.
!            Unchanged on exit.
! 
!   ALPHA  - DOUBLE PRECISION.
!            On entry, ALPHA specifies the scalar alpha.
!            Unchanged on exit.
! 
!   A      - DOUBLE PRECISION array of DIMENSION ( LDA, ka ), where ka is
!            k  when  TRANSA = 'N' or 'n',  and is  m  otherwise.
!            Before entry with  TRANSA = 'N' or 'n',  the leading  m by k
!            part of the array  A  must contain the matrix  A,  otherwise
!            the leading  k by m  part of the array  A  must contain  the
!            matrix A.
!            Unchanged on exit.
! 
!   LDA    - INTEGER.
!            On entry, LDA specifies the first dimension of A as declared
!            in the calling (sub) program. When  TRANSA = 'N' or 'n' then
!            LDA must be at least  max( 1, m ), otherwise  LDA must be at
!            least  max( 1, k ).
!            Unchanged on exit.
! 
!   B      - DOUBLE PRECISION array of DIMENSION ( LDB, kb ), where kb is
!            n  when  TRANSB = 'N' or 'n',  and is  k  otherwise.
!            Before entry with  TRANSB = 'N' or 'n',  the leading  k by n
!            part of the array  B  must contain the matrix  B,  otherwise
!            the leading  n by k  part of the array  B  must contain  the
!            matrix B.
!            Unchanged on exit.
! 
!   LDB    - INTEGER.
!            On entry, LDB specifies the first dimension of B as declared
!            in the calling (sub) program. When  TRANSB = 'N' or 'n' then
!            LDB must be at least  max( 1, k ), otherwise  LDB must be at
!            least  max( 1, n ).
!            Unchanged on exit.
! 
!   BETA   - DOUBLE PRECISION.
!            On entry,  BETA  specifies the scalar  beta.  When  BETA  is
!            supplied as zero then C need not be set on input.
!            Unchanged on exit.
! 
!   C      - DOUBLE PRECISION array of DIMENSION ( LDC, n ).
!            Before entry, the leading  m by n  part of the array  C must
!            contain the matrix  C,  except when  beta  is zero, in which
!            case C need not be set on entry.
!            On exit, the array  C  is overwritten by the  m by n  matrix
!            ( alpha*op( A )*op( B ) + beta*C ).
! 
!   LDC    - INTEGER.
!            On entry, LDC specifies the first dimension of C as declared
!            in  the  calling  (sub)  program.   LDC  must  be  at  least
!            max( 1, m ).
!            Unchanged on exit.
! 
! 
!   Level 3 Blas routine.
! 
!   -- Written on 8-February-1989.
!      Jack Dongarra, Argonne National Laboratory.
!      Iain Duff, AERE Harwell.
!      Jeremy Du Croz, Numerical Algorithms Group Ltd.
!      Sven Hammarling, Numerical Algorithms Group Ltd.
! 
! 
!      .. External Functions ..
!      .. External Subroutines ..
!      .. Intrinsic Functions ..
      intrinsic          max
!      .. Local Scalars ..
      logical :: nota
      logical :: notb
      integer :: i
      integer :: info
      integer :: j
      integer :: l
      integer :: ncola
      integer :: nrowa
      integer :: nrowb
      real(kind=8) :: temp
!      .. Parameters ..
      real(kind=8), parameter :: one=1.0d+0
      real(kind=8), parameter :: zero=0.0d+0
!      ..
!      .. Executable Statements ..
! 
!      Set  NOTA  and  NOTB  as  true if  A  and  B  respectively are not
!      transposed and set  NROWA, NCOLA and  NROWB  as the number of rows
!      and  columns of  A  and the  number of  rows  of  B  respectively.
! 
      nota   = lsame(transa,'N')
      notb   = lsame(transb,'N')
      if( nota )then
         nrowa = m
         ncola = k
      else
         nrowa = k
         ncola = m
      end if
      if( notb )then
         nrowb = k
      else
         nrowb = n
      end if
! 
!      Test the input parameters.
! 
      info = 0
      if(      ( .not.nota                 ).and.         ( .not.lsame( transa, &
       'C' ) ).and.         ( .not.lsame( transa, 'T' ) )      )then
         info = 1
      else if( ( .not.notb                 ).and.         ( .not.lsame( transb, &
       'C' ) ).and.         ( .not.lsame( transb, 'T' ) )      )then
         info = 2
      else if( m   < 0               )then
         info = 3
      else if( n   < 0               )then
         info = 4
      else if( k   < 0               )then
         info = 5
      else if( lda < max( 1, nrowa ) )then
         info = 8
      else if( ldb < max( 1, nrowb ) )then
         info = 10
      else if( ldc < max( 1, m     ) )then
         info = 13
      end if
      if( info /= 0 )then
         call xerbla('DGEMM ',info)

         return
      end if
! 
!      Quick return if possible.
! 
      if( ( m == 0 ).or.( n == 0 ).or.    ( ( ( alpha == zero ).or.( k == 0 ) ).and.( beta == one )  &
      ) )   return
! 
!      And if  alpha.eq.zero.
! 
      if( alpha == zero )then
         if( beta == zero )then
            do 20, j = 1, n
               do 10, i = 1, m
                  c( i, j ) = zero
   10          continue
   20       continue
         else
            do 40, j = 1, n
               do 30, i = 1, m
                  c( i, j ) = beta*c( i, j )
   30          continue
   40       continue
         end if
         return
      end if
! 
!      Start the operations.
! 
      if( notb )then
         if( nota )then
! 
!            Form  C := alpha*A*B + beta*C.
! 
            do 90, j = 1, n
               if( beta == zero )then
                  do 50, i = 1, m
                     c( i, j ) = zero
   50             continue
               else if( beta /= one )then
                  do 60, i = 1, m
                     c( i, j ) = beta*c( i, j )
   60             continue
               end if
               do 80, l = 1, k
                  if( b( l, j ) /= zero )then
                     temp = alpha*b( l, j )
                     do 70, i = 1, m
                        c( i, j ) = c( i, j ) + temp*a( i, l )
   70                continue
                  end if
   80          continue
   90       continue
         else
! 
!            Form  C := alpha*A'*B + beta*C
! 
            do 120, j = 1, n
               do 110, i = 1, m
                  temp = zero
                  do 100, l = 1, k
                     temp = temp + a( l, i )*b( l, j )
  100             continue
                  if( beta == zero )then
                     c( i, j ) = alpha*temp
                  else
                     c( i, j ) = alpha*temp + beta*c( i, j )
                  end if
  110          continue
  120       continue
         end if
      else
         if( nota )then
! 
!            Form  C := alpha*A*B' + beta*C
! 
            do 170, j = 1, n
               if( beta == zero )then
                  do 130, i = 1, m
                     c( i, j ) = zero
  130             continue
               else if( beta /= one )then
                  do 140, i = 1, m
                     c( i, j ) = beta*c( i, j )
  140             continue
               end if
               do 160, l = 1, k
                  if( b( j, l ) /= zero )then
                     temp = alpha*b( j, l )
                     do 150, i = 1, m
                        c( i, j ) = c( i, j ) + temp*a( i, l )
  150                continue
                  end if
  160          continue
  170       continue
         else
! 
!            Form  C := alpha*A'*B' + beta*C
! 
            do 200, j = 1, n
               do 190, i = 1, m
                  temp = zero
                  do 180, l = 1, k
                     temp = temp + a( l, i )*b( j, l )
  180             continue
                  if( beta == zero )then
                     c( i, j ) = alpha*temp
                  else
                     c( i, j ) = alpha*temp + beta*c( i, j )
                  end if
  190          continue
  200       continue
         end if
      end if
! 
      return
! 
!      End of DGEMM .
! 
      end subroutine dgemm
      logical function lsame(ca,cb)
! 
!   -- LAPACK auxiliary routine (version 2.0) --
!      Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
!      Courant Institute, Argonne National Lab, and Rice University
!      January 31, 1994
! 
!      .. Scalar Arguments ..
      implicit none
      character :: ca
      character :: cb
!      ..
! 
!   Purpose
!   =======
! 
!   LSAME returns .TRUE. if CA is the same letter as CB regardless of
!   case.
! 
!   Arguments
!   =========
! 
!   CA      (input) CHARACTER*1
!   CB      (input) CHARACTER*1
!           CA and CB specify the single characters to be compared.
! 
!  =====================================================================
! 
!      .. Intrinsic Functions ..
      intrinsic          ichar
!      ..
!      .. Local Scalars ..
      integer :: inta
      integer :: intb
      integer :: zcode
!      ..
!      .. Executable Statements ..
! 
!      Test if the characters are equal
! 
      lsame = ca.eq.cb
      if( lsame )   return
! 
! 
!      Now test for equivalence if both characters are alphabetic.
      zcode = ichar( 'Z' )
! 
!      Use 'Z' rather than 'A' so that ASCII can be detected on Prime
!      machines, on which ICHAR returns a value with bit 8 set.
!      ICHAR('A') on Prime machines returns 193 which is the same as
!      ICHAR('A') on an EBCDIC machine.
! 
      inta = ichar( ca )
      intb = ichar( cb )
! 
      if( zcode == 90 .or. zcode == 122 ) then
! 
!         ASCII is assumed - ZCODE is the ASCII code of either lower or
!         upper case 'Z'.
! 
         if( inta >= 97 .and. inta <= 122 ) inta = inta - 32
         if( intb >= 97 .and. intb <= 122 ) intb = intb - 32
! 
      else if( zcode == 233 .or. zcode == 169 ) then
! 
!         EBCDIC is assumed - ZCODE is the EBCDIC code of either lower or
!         upper case 'Z'.
! 
         if( inta >= 129 .and. inta <= 137 .or.       inta >= 145 .and. inta <= 153 .or.       inta  &
      >= 162 .and. inta <= 169 ) inta = inta + 64
         if( intb >= 129 .and. intb <= 137 .or.       intb >= 145 .and. intb <= 153 .or.       intb  &
      >= 162 .and. intb <= 169 ) intb = intb + 64
! 
      else if( zcode == 218 .or. zcode == 250 ) then
! 
!         ASCII is assumed, on Prime machines - ZCODE is the ASCII code
!         plus 128 of either lower or upper case 'Z'.
! 
         if( inta >= 225 .and. inta <= 250 ) inta = inta - 32
         if( intb >= 225 .and. intb <= 250 ) intb = intb - 32
      end if
      lsame = inta.eq.intb
! 
!      RETURN
! 
!      End of LSAME
! 
      end function lsame
      subroutine xerbla(srname,info)
! 
!   -- LAPACK auxiliary routine (preliminary version) --
!      Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
!      Courant Institute, Argonne National Lab, and Rice University
!      February 29, 1992
! 
!      .. Scalar Arguments ..
      implicit none
      character(len=6), intent(In) :: srname
      integer, intent(In) :: info
!      ..
! 
!   Purpose
!   =======
! 
!   XERBLA  is an error handler for the LAPACK routines.
!   It is called by an LAPACK routine if an input parameter has an
!   invalid value.  A message is printed and execution stops.
! 
!   Installers may consider modifying the STOP statement in order to
!   call system-specific exception-handling facilities.
! 
!   Arguments
!   =========
! 
!   SRNAME  (input) CHARACTER*6
!           The name of the routine which called XERBLA.
! 
!   INFO    (input) INTEGER
!           The position of the invalid parameter in the parameter list
!           of the calling routine.
! 
! 
      write( *, fmt = 9999 )srname, info
! 
      stop
! 
 9999 format( ' ** On entry to ', a6, ' parameter number ', i2, ' had ',      'an illegal value' )
! 
! 
!      End of XERBLA
      end subroutine xerbla

end module singleton_module_src_blas


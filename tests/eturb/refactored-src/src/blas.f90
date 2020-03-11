module singleton_module_src_blas

contains

      subroutine dgemm(transa,transb,m,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
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
      real(kind=8), dimension(1:lda,1:*), intent(In) :: a
      real(kind=8), dimension(1:ldb,1:*), intent(In) :: b
      real(kind=8), dimension(1:ldc,1:*), intent(Out) :: c
      intrinsic          max
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
      real(kind=8), parameter :: one=1.0d+0
      real(kind=8), parameter :: zero=0.0d+0
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
      if( ( m == 0 ).or.( n == 0 ).or.    ( ( ( alpha == zero ).or.( k == 0 ) ).and.( beta == one )  &
      ) )   return
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
      if( notb )then
         if( nota )then
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
      return
      end subroutine dgemm
      logical function lsame(ca,cb)
      implicit none
      character :: ca
      character :: cb
      intrinsic          ichar
      integer :: inta
      integer :: intb
      integer :: zcode
      lsame = ca.eq.cb
      if( lsame )   return
      zcode = ichar( 'Z' )
      inta = ichar( ca )
      intb = ichar( cb )
      if( zcode == 90 .or. zcode == 122 ) then
         if( inta >= 97 .and. inta <= 122 ) inta = inta - 32
         if( intb >= 97 .and. intb <= 122 ) intb = intb - 32
      else if( zcode == 233 .or. zcode == 169 ) then
         if( inta >= 129 .and. inta <= 137 .or.       inta >= 145 .and. inta <= 153 .or.       inta  &
      >= 162 .and. inta <= 169 ) inta = inta + 64
         if( intb >= 129 .and. intb <= 137 .or.       intb >= 145 .and. intb <= 153 .or.       intb  &
      >= 162 .and. intb <= 169 ) intb = intb + 64
      else if( zcode == 218 .or. zcode == 250 ) then
         if( inta >= 225 .and. inta <= 250 ) inta = inta - 32
         if( intb >= 225 .and. intb <= 250 ) intb = intb - 32
      end if
      lsame = inta.eq.intb
      end function lsame
      subroutine xerbla(srname,info)
      implicit none
      character(len=6), intent(In) :: srname
      integer, intent(In) :: info
      write( *, fmt = 9999 )srname, info
      stop
 9999 format( ' ** On entry to ', a6, ' parameter number ', i2, ' had ',      'an illegal value' )
      end subroutine xerbla

end module singleton_module_src_blas


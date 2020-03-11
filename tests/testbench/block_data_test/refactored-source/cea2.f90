      program cea2
      use params_cea_inc, only : maxngc, maxnc, ncol
      implicit none
      real(kind=8) :: avgdr
      real(kind=8) :: boltz
      real(kind=8) :: pi
      real(kind=8) :: rr
      logical :: newr
      integer :: iplt
      integer :: nplt
      integer :: nc
      integer :: ng
      integer :: nsert
      integer :: ngc
      integer :: ngp1
      integer :: npr
      logical :: gonly
      real(kind=8) :: enn
      real(kind=8) :: ennl
      real(kind=8) :: sumn
      real(kind=8), dimension(1:maxngc,1:ncol) :: en
      real(kind=8), dimension(1:maxngc) :: enln
      integer, dimension(1:45) :: jcond
      integer :: i
      integer :: inc
      integer :: j
      integer :: ln
      integer :: n
      real(kind=8) :: xi
      real(kind=8) :: xln
      real(kind=8) :: dlog
      call block_data(avgdr,boltz,pi,rr)
      newr = .false.
 100  iplt = 0
      nplt = 0
      nc = maxnc
      ng = maxngc
      nsert = 42
      ngc = maxngc
      ngp1 = ng+1
        npr = 0
        gonly = .true.
        enn = .1d0
        ennl = -2.3025851
        sumn = enn
        xi = ng
        if ( xi == 0. ) xi = 1.
        xi = avgdr*enn/xi
        xln = dlog(xi)*boltz
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
                npr = npr + 1
                jcond(npr) = j
            enddo
  end do
        endif
        print *, 'DONE', avgdr, boltz
      end program cea2
      subroutine block_data(avgdr_ARG,boltz_ARG,pi_ARG,rr_ARG)
!!      use params_cea_inc ! ONLY LIST EMPTY
      implicit none
      real(kind=8) :: avgdr
      real(kind=8) :: boltz
      real(kind=8) :: pi
      real(kind=8) :: rr
      real(kind=8), intent(InOut) :: avgdr_ARG
      real(kind=8), intent(InOut) :: boltz_ARG
      real(kind=8), intent(InOut) :: pi_ARG
      real(kind=8), intent(InOut) :: rr_ARG
      data rr / 8314.51d0 / ,pi / 3.14159265d0 / ,avgdr / 6.0221367d0 / ,boltz / 1.380658d0 / 
        avgdr_ARG = avgdr
        boltz_ARG = boltz
        pi_ARG = pi
        rr_ARG = rr
      end subroutine block_data

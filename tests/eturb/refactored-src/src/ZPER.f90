module ZPER
      use params_ZPER, only : lfdy, ly2, ldimt1, leig2, lp_small, lely, ltfdm2, lx1, lelz, ly1, &
       lelx, leig, lelv, lfdz, lx2, lfdx

      integer :: neigx
      integer :: neigy
      integer :: neigz
      integer :: pvalx
      integer :: pvaly
      integer :: pvalz
      integer :: pvecx
      integer :: pvecy
      integer :: pvecz

      real, dimension(1:leig2) :: sp
      real, dimension(1:leig2) :: spt
      real, dimension(1:leig) :: eigp
      real, dimension(1:ltfdm2) :: wavep
      integer, dimension(1:3,1:2) :: msp
      integer, dimension(1:3,1:2) :: mlp

      logical :: ifycrv
      logical :: ifzper
      logical :: ifgfdm
      logical :: ifgtp
      logical :: ifemat

      integer :: nelx
      integer :: nely
      integer :: nelz
      integer :: nelxy
      integer, dimension(1:3) :: lex2pst
      integer, dimension(1:3) :: pst2lex
      integer, dimension(1:3) :: ngfdm_p
      integer, dimension(1:3,1:2) :: ngfdm_v

      integer, dimension(0:lp_small) :: part_in
      integer, dimension(0:lp_small) :: part_out
      integer, dimension(0:lp_small,1:2) :: msg_id
      integer :: mcex

      integer, dimension(1:ltfdm2) :: tpn1
      integer, dimension(1:ltfdm2) :: tpn2
      integer, dimension(1:ltfdm2) :: tpn3
      integer, dimension(1:ltfdm2) :: ind23

      real, dimension(0:lelx) :: xgtp
      real, dimension(0:lely) :: ygtp
      real, dimension(0:lelz) :: zgtp
      real, dimension(1:lfdx) :: xmlt
      real, dimension(1:lfdy) :: ymlt
      real, dimension(1:lfdz) :: zmlt

      real, dimension(1:lx2,1:ly2,1:lelv) :: rx2
      real, dimension(1:lx2,1:ly2,1:lelv) :: ry2
      real, dimension(1:lx2,1:ly2,1:lelv) :: sx2
      real, dimension(1:lx2,1:ly2,1:lelv) :: sy2
      real, dimension(1:lx2,1:ly2,1:lelv) :: w2d
      real, dimension(1:lx1,1:ly1,1:lelv) :: bxyi

      character(len=3), dimension(1:6,0:ldimt1+1) :: gtp_cbc

end module ZPER

module GEOM
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: xm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: ym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: zm2

      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: jacm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi

      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: txm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: szm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: jacm2

      real, dimension(1:lxd*lyd*lzd,1:ldim*ldim,1:lelv) :: rx

      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g1m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g2m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g3m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g4m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g5m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g6m1

      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unr
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: uns
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unt
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(1:lx1*lz1,1:2*ldim,1:lelt) :: etalph
      real :: dlam

      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vny
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1z
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2z

      logical :: ifgeom
      logical :: ifgmsh3
      logical :: ifvcor
      logical :: ifsurt
      logical :: ifmelt
      logical :: ifwcno
      logical, dimension(1:lelt) :: ifrzer
      logical, dimension(1:2*ldim,1:lelv) :: ifqinp
      logical, dimension(1:2*ldim,1:lelv) :: ifeppm
      logical, dimension(0:1) :: iflmsf
      logical, dimension(0:1) :: iflmse
      logical, dimension(0:1) :: iflmsc
      logical, dimension(1:2*ldim,1:lelt,0:1) :: ifmsfc
      logical, dimension(1:12,1:lelt,0:1) :: ifmseg
      logical, dimension(1:8,1:lelt,0:1) :: ifmscr
      logical, dimension(1:8,1:lelt) :: ifnskp
      logical :: ifbcor

end module GEOM

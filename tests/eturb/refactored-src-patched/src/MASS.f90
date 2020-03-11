module MASS
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: bm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: binvm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bintm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: bm2inv
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: baxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1) :: bm1lag
      real :: volvm1
      real :: volvm2
      real :: voltm1
      real :: voltm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: yinvm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: binvdg

end module MASS

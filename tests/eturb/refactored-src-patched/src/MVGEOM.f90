module MVGEOM
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wy
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wz

      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wxlag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wylag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wzlag

      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w1mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w2mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w3mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wmult

      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev1
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev2
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev3

end module MVGEOM

module DXYZ
      real, dimension(1:lx1,1:lx1) :: dxm1
      real, dimension(1:lx2,1:lx1) :: dxm12
      real, dimension(1:ly1,1:ly1) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lx1,1:lx1) :: dxtm1
      real, dimension(1:lx1,1:lx2) :: dxtm12
      real, dimension(1:ly1,1:ly1) :: dytm1
      real, dimension(1:ly1,1:ly2) :: dytm12
      real, dimension(1:lz1,1:lz1) :: dztm1
      real, dimension(1:lz1,1:lz2) :: dztm12
      real, dimension(1:lx3,1:lx3) :: dxm3
      real, dimension(1:lx3,1:lx3) :: dxtm3
      real, dimension(1:ly3,1:ly3) :: dym3
      real, dimension(1:ly3,1:ly3) :: dytm3
      real, dimension(1:lz3,1:lz3) :: dzm3
      real, dimension(1:lz3,1:lz3) :: dztm3
      real, dimension(1:ly1,1:ly1) :: dcm1
      real, dimension(1:ly1,1:ly1) :: dctm1
      real, dimension(1:ly3,1:ly3) :: dcm3
      real, dimension(1:ly3,1:ly3) :: dctm3
      real, dimension(1:ly2,1:ly1) :: dcm12
      real, dimension(1:ly1,1:ly2) :: dctm12
      real, dimension(1:ly1,1:ly1) :: dam1
      real, dimension(1:ly1,1:ly1) :: datm1
      real, dimension(1:ly2,1:ly1) :: dam12
      real, dimension(1:ly1,1:ly2) :: datm12
      real, dimension(1:ly3,1:ly3) :: dam3
      real, dimension(1:ly3,1:ly3) :: datm3

end module DXYZ

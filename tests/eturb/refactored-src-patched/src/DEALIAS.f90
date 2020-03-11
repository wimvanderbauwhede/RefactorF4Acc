module DEALIAS
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vxd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vyd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vzd

      real, dimension(1:lx1,1:lxd) :: imd1
      real, dimension(1:lxd,1:lx1) :: imd1t
      real, dimension(1:lxd,1:lx1) :: im1d
      real, dimension(1:lx1,1:lxd) :: im1dt
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t

end module DEALIAS

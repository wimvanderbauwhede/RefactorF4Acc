module WZF
      use params_WZF, only : lx1, lxq

      real, dimension(1:lx1) :: zgl
      real, dimension(1:lx1) :: wgl
      real, dimension(1:lx1) :: zgp
      real, dimension(1:lxq) :: wgp
      real, dimension(1:lx1*lx1) :: wgl1
      real, dimension(1:lxq*lxq) :: wgl2
      real, dimension(1:lx1*lx1) :: wgli
      real, dimension(1:lx1*lx1) :: d1
      real, dimension(1:lx1*lx1) :: d1t
      real, dimension(1:lx1*lx1) :: d2
      real, dimension(1:lx1*lx1) :: b2p
      real, dimension(1:lx1*lx1) :: b1ia1
      real, dimension(1:lx1*lx1) :: b1ia1t
      real, dimension(1:lx1*lx1) :: da
      real, dimension(1:lx1*lx1) :: dat
      real, dimension(1:lx1*lxq) :: iggl
      real, dimension(1:lx1*lxq) :: igglt
      real, dimension(1:lx1*lxq) :: dglg
      real, dimension(1:lx1*lxq) :: dglgt
      real, dimension(1:lx1*lxq) :: wglg
      real, dimension(1:lx1*lxq) :: wglgt

end module WZF

module SOLN
      use params_SOLN, only : lorder2, lbx1, lbx2, lpy1, lpy2, lorder, ly2, lpelt, ldimt, lyd, &
       ldimt1, ly1, lelv, lpelv, lbz1, lbz2, lzd, lx1, lbelv, lpz1, lxd, lpz2, lz1, lpx1, lx2, &
       lpx2, lpert, lby1, ldim, lz2, lby2, lelt

      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: bq

      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vxlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vylag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vzlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1,1:ldimt) :: tlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: vdiff_e

      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz
      real, dimension(1:lx1*ly1*lz1*lelv) :: vx_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: t
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vtrans
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: cflf
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmnv
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmass
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bdivw
      real, dimension(1:lxd*lyd*lzd*lelv*ldim,1:lorder+1) :: c_vx
      real, dimension(1:2*ldim,1:lelt) :: fw

      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: by
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bz
      real, dimension(1:lbx2,1:lby2,1:lbz2,1:lbelv) :: pm
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmy
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmz
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz2
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bxlag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bylag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bzlag
      real, dimension(1:lbx2*lby2*lbz2*lbelv,1:lorder2) :: pmlag

      real :: nu_star

      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv,1:lorder2) :: prlag

      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: qtl
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: usrdiv

      real :: p0th
      real :: dp0thdt
      real :: gamma0

      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v1mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v2mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: omask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmult
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b1mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b2mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b3mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bpmask
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vzp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lpert) :: prp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: tp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: bqp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfzp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vxlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vylagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vzlagp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lorder2,1:lpert) :: prlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lorder-1,1:lpert) :: tlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt2p

      integer :: jp

end module SOLN

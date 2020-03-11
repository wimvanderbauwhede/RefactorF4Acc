module singleton_module_src_abl

      use singleton_module_src_navier5
      use singleton_module_src_postpro
      use singleton_module_src_dabl
      use singleton_module_src_math
contains

      subroutine userchk(base_flow,cs,dg2,dgtq,domain_length,dpdx_mean,dpdy_mean,dpdz_mean,dragpx, &
      dragpy,dragpz,dragvx,dragvy,dragvz,dragx,dragy,dragz,ediff,ffx_new,ffy_new,ffz_new, &
      flow_rate,icall,nekcomm,nekgroup,nekreal,nid,np,pm1,scale_vf,sij,snrm,torqpx,torqpy,torqpz, &
      torqvx,torqvy,torqvz,torqx,torqy,torqz,trx,trz,ur,us,ut,vr,vs,vt,wr,ws,wt,xm0,xsec,ym0,zm0, &
      nelv,nx1,ny1,nz1,ifuservp,t,istep,vx,vy_GLOB,vz_GLOB,if3d_GLOB,dxm1_GLOB,dxtm1_GLOB, &
      jacmi_GLOB,rxm1_GLOB,sxm1_GLOB,txm1_GLOB,rym1_GLOB,sym1_GLOB,tym1_GLOB,rzm1_GLOB,szm1_GLOB, &
      tzm1_GLOB,ifaxis_GLOB,nrout,rname,dct,ncall,dcount,tmxmf,ifneknek,ttotal,etimes,tprep,ttime, &
      nvtot,ifsync,tgop,ngop,pr_GLOB,param_GLOB,xm1_GLOB,ym1_GLOB,zm1_GLOB,vdiff_GLOB,nobj_GLOB, &
      nhis_GLOB,hcode_GLOB,lochis_GLOB,nmember_GLOB,ifield_GLOB,object_GLOB,gllnid_GLOB, &
      gllel_GLOB,nio_GLOB,time_GLOB,ifsplit,ixm21,iytm21,iztm21,vmult,tcol2,ta2s2,ifrzer_GLOB, &
      dytm1_GLOB,dym1,dam1,datm1,dcm1,dctm1,eface1,skpdat,area,unx,uny,unz,nelt_GLOB)
      use params_SIZE, only : ly2, lelg, ldimt, maxmbr, lx1, ldimt1, lz2, maxobj, lelt, lhis, ly1, &
       lx2, ldim, lz1, lelv
!!      use params_TOTAL ! ONLY LIST EMPTY
!!      use params_ZPER ! ONLY LIST EMPTY
      implicit none
      integer, parameter :: lr=lx1*ly1*lz1
      integer, parameter :: lxyz=lx1*ly1*lz1
      real :: base_flow
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: cs
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: dg2
      real, dimension(1:3,1:4), intent(InOut) :: dgtq
      real :: domain_length
      real, intent(InOut) :: dpdx_mean
      real, intent(InOut) :: dpdy_mean
      real, intent(InOut) :: dpdz_mean
      real, dimension(0:maxobj), intent(InOut) :: dragpx
      real, dimension(0:maxobj), intent(InOut) :: dragpy
      real, dimension(0:maxobj), intent(InOut) :: dragpz
      real, dimension(0:maxobj), intent(InOut) :: dragvx
      real, dimension(0:maxobj), intent(InOut) :: dragvy
      real, dimension(0:maxobj), intent(InOut) :: dragvz
      real, dimension(0:maxobj), intent(InOut) :: dragx
      real, dimension(0:maxobj), intent(InOut) :: dragy
      real, dimension(0:maxobj), intent(InOut) :: dragz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: ediff
      real :: ffx_new
      real :: ffy_new
      real :: ffz_new
      real :: flow_rate
      integer, intent(In) :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer, intent(In) :: nid
      integer, intent(In) :: np
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(InOut) :: pm1
      real, dimension(1:3), intent(In) :: scale_vf
      real, dimension(1:lx1*ly1*lz1,1:ldim,1:ldim), intent(InOut) :: sij
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(InOut) :: snrm
      real, dimension(0:maxobj), intent(InOut) :: torqpx
      real, dimension(0:maxobj), intent(InOut) :: torqpy
      real, dimension(0:maxobj), intent(InOut) :: torqpz
      real, dimension(0:maxobj), intent(InOut) :: torqvx
      real, dimension(0:maxobj), intent(InOut) :: torqvy
      real, dimension(0:maxobj), intent(InOut) :: torqvz
      real, dimension(0:maxobj), intent(InOut) :: torqx
      real, dimension(0:maxobj), intent(InOut) :: torqy
      real, dimension(0:maxobj), intent(InOut) :: torqz
      real, dimension(1:lx1,1:ly1,1:lz1) :: trx
      real, dimension(1:lx1,1:ly1,1:lz1) :: trz
      real, dimension(1:lr), intent(InOut) :: ur
      real, dimension(1:lr), intent(InOut) :: us
      real, dimension(1:lr), intent(InOut) :: ut
      real, dimension(1:lr), intent(InOut) :: vr
      real, dimension(1:lr), intent(InOut) :: vs
      real, dimension(1:lr), intent(InOut) :: vt
      real, dimension(1:lr), intent(InOut) :: wr
      real, dimension(1:lr), intent(InOut) :: ws
      real, dimension(1:lr), intent(InOut) :: wt
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(InOut) :: xm0
      real :: xsec
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(InOut) :: ym0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(InOut) :: zm0
      integer, intent(In) :: nelv
      integer, intent(In) :: nx1
      integer, intent(In) :: ny1
      integer, intent(In) :: nz1
      logical, intent(In) :: ifuservp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt), intent(InOut) :: t
      integer, intent(In) :: istep
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_GLOB
      logical :: if3d_GLOB
      real, dimension(1:lx1,1:lx1) :: dxm1_GLOB
      real, dimension(1:lx1,1:lx1) :: dxtm1_GLOB
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1_GLOB
      logical :: ifaxis_GLOB
      integer :: nrout
            integer, parameter :: maxrts=1000
      character(len=6), dimension(1:maxrts) :: rname
      real(kind=8), dimension(1:maxrts) :: dct
      integer, dimension(1:maxrts) :: ncall
      real(kind=8) :: dcount
      real(kind=8) :: tmxmf
      logical :: ifneknek
      real(kind=8) :: ttotal
      real(kind=8) :: etimes
      real(kind=8) :: tprep
      real(kind=8) :: ttime
      integer(kind=8) :: nvtot
      logical :: ifsync
      real(kind=8) :: tgop
      integer :: ngop
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr_GLOB
      real, dimension(1:200) :: param_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff_GLOB
      integer :: nobj_GLOB
      integer :: nhis_GLOB
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode_GLOB
      integer, dimension(1:4,1:lhis+maxobj) :: lochis_GLOB
      integer, dimension(1:maxobj) :: nmember_GLOB
      integer :: ifield_GLOB
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object_GLOB
      integer, dimension(1:lelg) :: gllnid_GLOB
      integer, dimension(1:lelg) :: gllel_GLOB
      integer :: nio_GLOB
      real :: time_GLOB
      logical :: ifsplit
      real, dimension(1:lx1,1:lx2) :: ixm21
      real, dimension(1:ly2,1:ly1) :: iytm21
      real, dimension(1:lz2,1:lz1) :: iztm21
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult
      real(kind=8) :: tcol2
      real(kind=8) :: ta2s2
      logical, dimension(1:lelt) :: ifrzer_GLOB
      real, dimension(1:ly1,1:ly1) :: dytm1_GLOB
      real, dimension(1:ly1,1:ly1) :: dym1
      real, dimension(1:ly1,1:ly1) :: dam1
      real, dimension(1:ly1,1:ly1) :: datm1
      real, dimension(1:ly1,1:ly1) :: dcm1
      real, dimension(1:ly1,1:ly1) :: dctm1
      integer, dimension(1:6) :: eface1
      integer, dimension(1:6,1:6) :: skpdat
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      integer :: nelt_GLOB
      integer :: n
      integer :: ngll
      real :: rho
      real :: a_w
      integer :: e
      integer :: i
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: gradux
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: graduy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: graduz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vgrad
      real, dimension(1:3) :: x0
      real :: utau
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: utauv
      save x0
      n=nx1*ny1*nz1*nelv
      ngll=nx1*ny1*nz1
      if(ifuservp) then
        do e=1,nelv
           call eddy_visc(e,cs,dg2,ediff,icall,nekcomm,nekgroup,nekreal,nid,np,sij,snrm,nx1,ny1,nz1, &
      vx,vy_GLOB,vz_GLOB,if3d_GLOB,dxm1_GLOB,dxtm1_GLOB,jacmi_GLOB,rxm1_GLOB,sxm1_GLOB,txm1_GLOB, &
      rym1_GLOB,sym1_GLOB,tym1_GLOB,rzm1_GLOB,szm1_GLOB,tzm1_GLOB,ifaxis_GLOB,nrout,rname,dct, &
      ncall,dcount,tmxmf,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot,ifsync,tgop,ngop)
        enddo
        call copy(t,ediff,n)
      endif
      if (istep == 0) then
         call rzero(x0,3)
      endif
      call torque_calc(1.0,x0,.false. /= 0.0,.false. /= 0.0,dragx,dragpx,dragvx,dragy,dragpy,dragvy, &
      dragz,dragpz,dragvz,torqx,torqpx,torqvx,torqy,torqpy,torqvy,torqz,torqpz,torqvz,dpdx_mean, &
      dpdy_mean,dpdz_mean,dgtq,flow_rate,base_flow,domain_length,xsec,scale_vf,pm1,sij,ur,us,ut, &
      vr,vs,vt,wr,ws,wt,xm0,xm0,xm0,ym0,zm0)
      rho    = 1.
      a_w    = 19.7
      utau= sqrt(dragx(1)**2+dragz(1)**2)/a_w
      utau=sqrt(utau)
      call gradm1(gradux,graduy,graduz,vx,ur,us,ut,nelt_GLOB,if3d_GLOB,dxm1_GLOB,dxtm1_GLOB, &
      jacmi_GLOB,rxm1_GLOB,sxm1_GLOB,txm1_GLOB,rym1_GLOB,sym1_GLOB,tym1_GLOB,rzm1_GLOB,szm1_GLOB, &
      tzm1_GLOB,ifaxis_GLOB,ifrzer_GLOB,dytm1_GLOB,nrout,rname,dct,ncall,dcount,tmxmf,dym1,dam1, &
      datm1,dcm1,dctm1)
      end subroutine userchk
      subroutine eddy_visc(e,cs,dg2,ediff,icall,nekcomm,nekgroup,nekreal,nid,np,sij,snrm,nx1,ny1, &
      nz1,vx,vy,vz,if3d_GLOB,dxm1_GLOB,dxtm1_GLOB,jacmi_GLOB,rxm1_GLOB,sxm1_GLOB,txm1_GLOB, &
      rym1_GLOB,sym1_GLOB,tym1_GLOB,rzm1_GLOB,szm1_GLOB,tzm1_GLOB,ifaxis_GLOB,nrout,rname,dct, &
      ncall,dcount,tmxmf,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot,ifsync,tgop,ngop)
      use params_SIZE, only : ly1, lz1, ldim, lelt, lx1, lelv
!!      use params_TOTAL ! ONLY LIST EMPTY
!!      use params_ZPER ! ONLY LIST EMPTY
      implicit none
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: dg2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: ediff
      integer, intent(In) :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer, intent(In) :: nid
      integer, intent(In) :: np
      integer, intent(In) :: nx1
      integer, intent(In) :: ny1
      integer, intent(In) :: nz1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: vz
      logical :: if3d_GLOB
      real, dimension(1:lx1,1:lx1) :: dxm1_GLOB
      real, dimension(1:lx1,1:lx1) :: dxtm1_GLOB
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1_GLOB
      logical :: ifaxis_GLOB
      integer :: nrout
            integer, parameter :: maxrts=1000
      character(len=6), dimension(1:maxrts) :: rname
      real(kind=8), dimension(1:maxrts) :: dct
      integer, dimension(1:maxrts) :: ncall
      real(kind=8) :: dcount
      real(kind=8) :: tmxmf
      logical :: ifneknek
      real(kind=8) :: ttotal
      real(kind=8) :: etimes
      real(kind=8) :: tprep
      real(kind=8) :: ttime
      integer :: istep
      integer(kind=8) :: nvtot
      logical :: ifsync
      real(kind=8) :: tgop
      integer :: ngop
      integer :: ntot
      integer, intent(In) :: e
      real, dimension(1:lx1*ly1*lz1,1:ldim,1:ldim), intent(InOut) :: sij
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(InOut) :: snrm
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: cs
      real :: csa
      real :: csb
      ntot = nx1*ny1*nz1
      call comp_gije(sij,vx(1,1,1,e),vy(1,1,1,e),vz(1,1,1,e),e,icall,nekcomm,nekgroup,nekreal,nid, &
      np,if3d_GLOB,dxm1_GLOB,dxtm1_GLOB,jacmi_GLOB,rxm1_GLOB,sxm1_GLOB,txm1_GLOB,rym1_GLOB, &
      sym1_GLOB,tym1_GLOB,rzm1_GLOB,szm1_GLOB,tzm1_GLOB,ifaxis_GLOB,nrout,rname,dct,ncall,dcount, &
      tmxmf,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot,ifsync,tgop,ngop)
      call comp_sije(sij)
      call mag_tensor_e(snrm(1,e),sij)
      call cmult(snrm(1,e),2.0,ntot)
      end subroutine eddy_visc

end module singleton_module_src_abl


c-----------------------------------------------------------------------
c> @defgroup dabl  Dummy ABL case user-file
C> (c) 2020 Wim Vanderbauwhede      
c> Contains:
c>
c>  - user specified routines:
c>     - userchk : general purpose routine for checking errors etc. 
C> This is a dummy, not the actual code as that is not Open Source
C>
c> @{
c----------------------------------------------------------------------
c drive flow with pressure gradient
c-----------------------------------------------------------------------
      subroutine userchk()

c      implicit none

      include 'SIZE'
      include 'TOTAL'
      include 'ZPER'


      integer e,i
      real gradux(lx1,ly1,lz1,lelv)
      real graduy(lx1,ly1,lz1,lelv)
      real graduz(lx1,ly1,lz1,lelv)
      real vgrad(lx1,ly1,lz1,lelv)
      real x0(3),utau
      real utauv(lx1,ly1,lz1,lelv)
      save x0


c     call common blocks
      common /cdsmag/ ediff(lx1,ly1,lz1,lelv)
     $              , dg2 (lx1,ly1,lz1,lelv)

      common /scrsf/ trx(lx1,ly1,lz1)
     $             , trz(lx1,ly1,lz1)

      common /ctorq/ dragx(0:maxobj),dragpx(0:maxobj),dragvx(0:maxobj)
     $             , dragy(0:maxobj),dragpy(0:maxobj),dragvy(0:maxobj)
     $             , dragz(0:maxobj),dragpz(0:maxobj),dragvz(0:maxobj)
c
     $             , torqx(0:maxobj),torqpx(0:maxobj),torqvx(0:maxobj)
     $             , torqy(0:maxobj),torqpy(0:maxobj),torqvy(0:maxobj)
     $             , torqz(0:maxobj),torqpz(0:maxobj),torqvz(0:maxobj)
c
     $             , dpdx_mean,dpdy_mean,dpdz_mean
     $             , dgtq(3,4)

      common /cforce/ ffx_new,ffy_new,ffz_new


      n=nx1*ny1*nz1*nelv
      ngll=nx1*ny1*nz1

      if(ifuservp) then
        do e=1,nelv
           call eddy_visc(e)
        enddo
        call copy(t,ediff,n)
      endif

      if (istep.eq.0) then
         call rzero(x0,3)               ! torque w.r.t. x0
      endif


      call torque_calc(1.0,x0,.false.,.false.) ! wall shear

      rho    = 1.
      A_w    = 19.7

      utau= sqrt(dragx(1)**2+dragz(1)**2)/A_w
      utau=sqrt(utau)

      call gradm1(gradux,graduy,graduz,vx)


      end
c-----------------------------------------------------------------------

c-----------------------------------------------------------------------
      subroutine eddy_visc(e)

      include 'SIZE'
      include 'TOTAL'
      include 'ZPER'

      common /cdsmag/ ediff(lx1,ly1,lz1,lelv)
     $              , dg2 (lx1,ly1,lz1,lelv)
      integer e
      common /dynsmg/ sij (lx1*ly1*lz1,ldim,ldim)
     $              , snrm(lx1*ly1*lz1,lelv)
     $              , Cs(lx1*ly1*lz1,lelv)
      real sij,snrm,Cs,Csa,Csb


      ntot = nx1*ny1*nz1
      call comp_gije(sij,vx(1,1,1,e),vy(1,1,1,e),vz(1,1,1,e),e)

      call comp_sije(sij)

      call mag_tensor_e(snrm(1,e),sij)
      call cmult(snrm(1,e),2.0,ntot)
c---------------------------


      end
c-----------------------------------------------------------------------


c-----------------------------------------------------------------------



c> @}
c end of group dabl

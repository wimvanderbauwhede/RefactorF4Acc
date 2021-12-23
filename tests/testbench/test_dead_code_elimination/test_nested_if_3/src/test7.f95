module module_test7

contains

   subroutine test7(u,f, global_id)
      implicit none
      real, dimension(1:9), intent(in) :: u
      real, dimension(1:9), intent(out) :: f
      integer, intent(in) :: global_id
      real :: v1
      real :: v2
      real :: v3
      real :: v4
      real :: v5
      real :: v6

      v2=0.0
      v6=1.
      if (global_id>1) then
          v1=0.0
          if (u(0)>1.0) then
              v1=u(1)
              v6=2.
          else
              v6=3
              v2=u(1)+v1
          end if
          v6=4
          v1 = v2+v6
          v3=3.0
          v5=3.0
          if (u(0)>1.0) then
              v3=u(0)+1.0
          else
              v3=0.0
          end if
          v5=4.0
          v3=v1
      end if
      f(global_id) = u(global_id)/2.0+v3+v4

   end subroutine test7

end module module_test7


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

      v2=0.0
      if (global_id>1) then
          v1=0.0
          if (u(0)>1.0) then
              v1=u(1)
          else
              v2=u(1)+v1
          end if
          v1 = v2
          if (u(0)>1.0) then
              v3=u(0)+1.0
          else
              v3=0.0
          end if

      else if (global_id>0) then
          v4=1.0
      else
          v4=0.0
      end if

      f(global_id) = u(global_id)/2.0

   end subroutine test7

end module module_test7


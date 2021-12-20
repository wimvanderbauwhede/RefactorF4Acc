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

      v2=0.0
      if (global_id>1) then
          v1=0.0
          if (u(0)>1.0) then
              v1=u(1)
              if (global_id>2) then
                  v1=u(2)
              else
                  v1=v1+1
              end if
          else
              v2=u(1)+v1
          end if
          v1 = v2
          v3=3.0
          v5=3.0
          if (u(0)>1.0) then
              v3=u(0)+1.0
          else if (u(1)>1.0) then
              v3=1.0
          else
              v3=0.0
              if (v1==v2) then
                  v3=v2
              end if
          end if
          v5=4.0
           v3=v1
      else if (global_id>0) then
          v4=1.0
          v5=5.0
      else
          v4=0.0
          if (u(0)>1.0) then
              v1=u(1)
          else
              v2=u(1)+v1
          end if          
      end if
      if (u(0)>1.0) then
          v2=u(1)
      else
          v2=u(1)+v1
      end if
      f(global_id) = u(global_id)/2.0+v3+v4

   end subroutine test7

end module module_test7


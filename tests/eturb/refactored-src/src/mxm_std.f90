module singleton_module_src_mxm_std

contains

      subroutine mxmf2(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer, intent(In) :: n2
      integer, intent(In) :: n3
      real, dimension(1:n1,1:n2), intent(In) :: a
      real, dimension(1:n2,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(InOut) :: c
      if (n2 <= 8) then
         if (n2 == 1) then
            call mxf1(a,n1,b,n2,c,n3)

         elseif (n2 == 2) then
            call mxf2(a,n1,b,n2,c,n3)

         elseif (n2 == 3) then
            call mxf3(a,n1,b,n2,c,n3)

         elseif (n2 == 4) then
            call mxf4(a,n1,b,n2,c,n3)

         elseif (n2 == 5) then
            call mxf5(a,n1,b,n2,c,n3)

         elseif (n2 == 6) then
            call mxf6(a,n1,b,n2,c,n3)

         elseif (n2 == 7) then
            call mxf7(a,n1,b,n2,c,n3)

         else
            call mxf8(a,n1,b,n2,c,n3)

         endif
      elseif (n2 <= 16) then
         if (n2 == 9) then
            call mxf9(a,n1,b,n2,c,n3)

         elseif (n2 == 10) then
            call mxf10(a,n1,b,n2,c,n3)

         elseif (n2 == 11) then
            call mxf11(a,n1,b,n2,c,n3)

         elseif (n2 == 12) then
            call mxf12(a,n1,b,n2,c,n3)

         elseif (n2 == 13) then
            call mxf13(a,n1,b,n2,c,n3)

         elseif (n2 == 14) then
            call mxf14(a,n1,b,n2,c,n3)

         elseif (n2 == 15) then
            call mxf15(a,n1,b,n2,c,n3)

         else
            call mxf16(a,n1,b,n2,c,n3)

         endif
      elseif (n2 <= 24) then
         if (n2 == 17) then
            call mxf17(a,n1,b,n2,c,n3)

         elseif (n2 == 18) then
            call mxf18(a,n1,b,n2,c,n3)

         elseif (n2 == 19) then
            call mxf19(a,n1,b,n2,c,n3)

         elseif (n2 == 20) then
            call mxf20(a,n1,b,n2,c,n3)

         elseif (n2 == 21) then
            call mxf21(a,n1,b,n2,c,n3)

         elseif (n2 == 22) then
            call mxf22(a,n1,b,n2,c,n3)

         elseif (n2 == 23) then
            call mxf23(a,n1,b,n2,c,n3)

         elseif (n2 == 24) then
            call mxf24(a,n1,b,n2,c,n3)

         endif
      else
         call mxm44_0(a,n1,b,n2,c,n3)

      endif
      return
      end subroutine mxmf2
      subroutine mxf1(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:1), intent(In) :: a
      real, dimension(1:1,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)
         enddo
      enddo
      return
      end subroutine mxf1
      subroutine mxf2(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:2), intent(In) :: a
      real, dimension(1:2,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)
         enddo
      enddo
      return
      end subroutine mxf2
      subroutine mxf3(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:3), intent(In) :: a
      real, dimension(1:3,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3,j)
         enddo
      enddo
      return
      end subroutine mxf3
      subroutine mxf4(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:4), intent(In) :: a
      real, dimension(1:4,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)
         enddo
      enddo
      return
      end subroutine mxf4
      subroutine mxf5(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:5), intent(In) :: a
      real, dimension(1:5,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)
         enddo
      enddo
      return
      end subroutine mxf5
      subroutine mxf6(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:6), intent(In) :: a
      real, dimension(1:6,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6,j)
         enddo
      enddo
      return
      end subroutine mxf6
      subroutine mxf7(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:7), intent(In) :: a
      real, dimension(1:7,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)
         enddo
      enddo
      return
      end subroutine mxf7
      subroutine mxf8(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:8), intent(In) :: a
      real, dimension(1:8,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)
         enddo
      enddo
      return
      end subroutine mxf8
      subroutine mxf9(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:9), intent(In) :: a
      real, dimension(1:9,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9,j)
         enddo
      enddo
      return
      end subroutine mxf9
      subroutine mxf10(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:10), intent(In) :: a
      real, dimension(1:10,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)
         enddo
      enddo
      return
      end subroutine mxf10
      subroutine mxf11(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:11), intent(In) :: a
      real, dimension(1:11,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)
         enddo
      enddo
      return
      end subroutine mxf11
      subroutine mxf12(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:12), intent(In) :: a
      real, dimension(1:12,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12,j)
         enddo
      enddo
      return
      end subroutine mxf12
      subroutine mxf13(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:13), intent(In) :: a
      real, dimension(1:13,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)
         enddo
      enddo
      return
      end subroutine mxf13
      subroutine mxf14(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:14), intent(In) :: a
      real, dimension(1:14,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)             + a(i,14)*b(14,j)
         enddo
      enddo
      return
      end subroutine mxf14
      subroutine mxf15(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:15), intent(In) :: a
      real, dimension(1:15,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)             + a(i,14)*b(14,j)             + a(i,15)*b(15,j)
         enddo
      enddo
      return
      end subroutine mxf15
      subroutine mxf16(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:16), intent(In) :: a
      real, dimension(1:16,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)             + a(i,14)*b(14,j)             + a(i,15)*b(15, &
      j)             + a(i,16)*b(16,j)
         enddo
      enddo
      return
      end subroutine mxf16
      subroutine mxf17(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:17), intent(In) :: a
      real, dimension(1:17,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)             + a(i,14)*b(14,j)             + a(i,15)*b(15, &
      j)             + a(i,16)*b(16,j)             + a(i,17)*b(17,j)
         enddo
      enddo
      return
      end subroutine mxf17
      subroutine mxf18(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:18), intent(In) :: a
      real, dimension(1:18,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)             + a(i,14)*b(14,j)             + a(i,15)*b(15, &
      j)             + a(i,16)*b(16,j)             + a(i,17)*b(17,j)             + a(i,18)*b(18,j)
         enddo
      enddo
      return
      end subroutine mxf18
      subroutine mxf19(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:19), intent(In) :: a
      real, dimension(1:19,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)             + a(i,14)*b(14,j)             + a(i,15)*b(15, &
      j)             + a(i,16)*b(16,j)             + a(i,17)*b(17,j)             + a(i,18)*b(18, &
      j)             + a(i,19)*b(19,j)
         enddo
      enddo
      return
      end subroutine mxf19
      subroutine mxf20(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:20), intent(In) :: a
      real, dimension(1:20,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)             + a(i,14)*b(14,j)             + a(i,15)*b(15, &
      j)             + a(i,16)*b(16,j)             + a(i,17)*b(17,j)             + a(i,18)*b(18, &
      j)             + a(i,19)*b(19,j)             + a(i,20)*b(20,j)
         enddo
      enddo
      return
      end subroutine mxf20
      subroutine mxf21(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:21), intent(In) :: a
      real, dimension(1:21,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)             + a(i,14)*b(14,j)             + a(i,15)*b(15, &
      j)             + a(i,16)*b(16,j)             + a(i,17)*b(17,j)             + a(i,18)*b(18, &
      j)             + a(i,19)*b(19,j)             + a(i,20)*b(20,j)             + a(i,21)*b(21,j)
         enddo
      enddo
      return
      end subroutine mxf21
      subroutine mxf22(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:22), intent(In) :: a
      real, dimension(1:22,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)             + a(i,14)*b(14,j)             + a(i,15)*b(15, &
      j)             + a(i,16)*b(16,j)             + a(i,17)*b(17,j)             + a(i,18)*b(18, &
      j)             + a(i,19)*b(19,j)             + a(i,20)*b(20,j)             + a(i,21)*b(21, &
      j)             + a(i,22)*b(22,j)
         enddo
      enddo
      return
      end subroutine mxf22
      subroutine mxf23(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:23), intent(In) :: a
      real, dimension(1:23,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)             + a(i,14)*b(14,j)             + a(i,15)*b(15, &
      j)             + a(i,16)*b(16,j)             + a(i,17)*b(17,j)             + a(i,18)*b(18, &
      j)             + a(i,19)*b(19,j)             + a(i,20)*b(20,j)             + a(i,21)*b(21, &
      j)             + a(i,22)*b(22,j)             + a(i,23)*b(23,j)
         enddo
      enddo
      return
      end subroutine mxf23
      subroutine mxf24(a,n1,b,n2,c,n3)
      implicit none
      integer, intent(In) :: n1
      integer :: n2
      integer, intent(In) :: n3
      integer :: j
      integer :: i
      real, dimension(1:n1,1:24), intent(In) :: a
      real, dimension(1:24,1:n3), intent(In) :: b
      real, dimension(1:n1,1:n3), intent(Out) :: c
      do j=1,n3
         do i=1,n1
            c(i,j) = a(i,1)*b(1,j)             + a(i,2)*b(2,j)             + a(i,3)*b(3, &
      j)             + a(i,4)*b(4,j)             + a(i,5)*b(5,j)             + a(i,6)*b(6, &
      j)             + a(i,7)*b(7,j)             + a(i,8)*b(8,j)             + a(i,9)*b(9, &
      j)             + a(i,10)*b(10,j)             + a(i,11)*b(11,j)             + a(i,12)*b(12, &
      j)             + a(i,13)*b(13,j)             + a(i,14)*b(14,j)             + a(i,15)*b(15, &
      j)             + a(i,16)*b(16,j)             + a(i,17)*b(17,j)             + a(i,18)*b(18, &
      j)             + a(i,19)*b(19,j)             + a(i,20)*b(20,j)             + a(i,21)*b(21, &
      j)             + a(i,22)*b(22,j)             + a(i,23)*b(23,j)             + a(i,24)*b(24,j)
         enddo
      enddo
      return
      end subroutine mxf24
      subroutine mxm44_0(a,m,b,k,c,n)
      implicit none
      integer, intent(In) :: m
      integer, intent(In) :: k
      integer, intent(In) :: n
      integer :: mresid
      integer :: nresid
      integer :: m1
      integer :: n1
      integer :: i
      integer :: j
      integer :: l
      real, dimension(1:m,1:k), intent(In) :: a
      real, dimension(1:k,1:n), intent(In) :: b
      real, dimension(1:m,1:n), intent(Out) :: c
      real :: s11
      real :: s12
      real :: s13
      real :: s14
      real :: s21
      real :: s22
      real :: s23
      real :: s24
      real :: s31
      real :: s32
      real :: s33
      real :: s34
      real :: s41
      real :: s42
      real :: s43
      real :: s44
      mresid = iand(m,3) 
      nresid = iand(n,3) 
      m1 = m - mresid + 1
      n1 = n - nresid + 1
      do i=1,m-mresid,4
        do j=1,n-nresid,4
          s11 = 0.0d0
          s21 = 0.0d0
          s31 = 0.0d0
          s41 = 0.0d0
          s12 = 0.0d0
          s22 = 0.0d0
          s32 = 0.0d0
          s42 = 0.0d0
          s13 = 0.0d0
          s23 = 0.0d0
          s33 = 0.0d0
          s43 = 0.0d0
          s14 = 0.0d0
          s24 = 0.0d0
          s34 = 0.0d0
          s44 = 0.0d0
          do l=1,k
            s11 = s11 + a(i,l)*b(l,j)
            s12 = s12 + a(i,l)*b(l,j+1)
            s13 = s13 + a(i,l)*b(l,j+2)
            s14 = s14 + a(i,l)*b(l,j+3)
            s21 = s21 + a(i+1,l)*b(l,j)
            s22 = s22 + a(i+1,l)*b(l,j+1)
            s23 = s23 + a(i+1,l)*b(l,j+2)
            s24 = s24 + a(i+1,l)*b(l,j+3)
            s31 = s31 + a(i+2,l)*b(l,j)
            s32 = s32 + a(i+2,l)*b(l,j+1)
            s33 = s33 + a(i+2,l)*b(l,j+2)
            s34 = s34 + a(i+2,l)*b(l,j+3)
            s41 = s41 + a(i+3,l)*b(l,j)
            s42 = s42 + a(i+3,l)*b(l,j+1)
            s43 = s43 + a(i+3,l)*b(l,j+2)
            s44 = s44 + a(i+3,l)*b(l,j+3)
          enddo
          c(i,j)     = s11 
          c(i,j+1)   = s12 
          c(i,j+2)   = s13
          c(i,j+3)   = s14
          c(i+1,j)   = s21 
          c(i+2,j)   = s31 
          c(i+3,j)   = s41 
          c(i+1,j+1) = s22
          c(i+2,j+1) = s32
          c(i+3,j+1) = s42
          c(i+1,j+2) = s23
          c(i+2,j+2) = s33
          c(i+3,j+2) = s43
          c(i+1,j+3) = s24
          c(i+2,j+3) = s34
          c(i+3,j+3) = s44
        enddo
        if (nresid  /=  0) then
          if (nresid  ==  1) then
            s11 = 0.0d0
            s21 = 0.0d0
            s31 = 0.0d0
            s41 = 0.0d0
            do l=1,k
              s11 = s11 + a(i,l)*b(l,n)
              s21 = s21 + a(i+1,l)*b(l,n)
              s31 = s31 + a(i+2,l)*b(l,n)
              s41 = s41 + a(i+3,l)*b(l,n)
            enddo
            c(i,n)     = s11 
            c(i+1,n)   = s21 
            c(i+2,n)   = s31 
            c(i+3,n)   = s41 
          elseif (nresid  ==  2) then
            s11 = 0.0d0
            s21 = 0.0d0
            s31 = 0.0d0
            s41 = 0.0d0
            s12 = 0.0d0
            s22 = 0.0d0
            s32 = 0.0d0
            s42 = 0.0d0
            do l=1,k
              s11 = s11 + a(i,l)*b(l,j)
              s12 = s12 + a(i,l)*b(l,j+1)
              s21 = s21 + a(i+1,l)*b(l,j)
              s22 = s22 + a(i+1,l)*b(l,j+1)
              s31 = s31 + a(i+2,l)*b(l,j)
              s32 = s32 + a(i+2,l)*b(l,j+1)
              s41 = s41 + a(i+3,l)*b(l,j)
              s42 = s42 + a(i+3,l)*b(l,j+1)
            enddo
            c(i,j)     = s11 
            c(i,j+1)   = s12
            c(i+1,j)   = s21 
            c(i+2,j)   = s31 
            c(i+3,j)   = s41 
            c(i+1,j+1) = s22
            c(i+2,j+1) = s32
            c(i+3,j+1) = s42
          else
            s11 = 0.0d0
            s21 = 0.0d0
            s31 = 0.0d0
            s41 = 0.0d0
            s12 = 0.0d0
            s22 = 0.0d0
            s32 = 0.0d0
            s42 = 0.0d0
            s13 = 0.0d0
            s23 = 0.0d0
            s33 = 0.0d0
            s43 = 0.0d0
            do l=1,k
              s11 = s11 + a(i,l)*b(l,j)
              s12 = s12 + a(i,l)*b(l,j+1)
              s13 = s13 + a(i,l)*b(l,j+2)
              s21 = s21 + a(i+1,l)*b(l,j)
              s22 = s22 + a(i+1,l)*b(l,j+1)
              s23 = s23 + a(i+1,l)*b(l,j+2)
              s31 = s31 + a(i+2,l)*b(l,j)
              s32 = s32 + a(i+2,l)*b(l,j+1)
              s33 = s33 + a(i+2,l)*b(l,j+2)
              s41 = s41 + a(i+3,l)*b(l,j)
              s42 = s42 + a(i+3,l)*b(l,j+1)
              s43 = s43 + a(i+3,l)*b(l,j+2)
            enddo
            c(i,j)     = s11 
            c(i+1,j)   = s21 
            c(i+2,j)   = s31 
            c(i+3,j)   = s41 
            c(i,j+1)   = s12 
            c(i+1,j+1) = s22
            c(i+2,j+1) = s32
            c(i+3,j+1) = s42
            c(i,j+2)   = s13
            c(i+1,j+2) = s23
            c(i+2,j+2) = s33
            c(i+3,j+2) = s43
          endif
        endif
      enddo
      if (mresid  ==  0) then
        return
      elseif (mresid  ==  1) then
        do j=1,n-nresid,4
          s11 = 0.0d0
          s12 = 0.0d0
          s13 = 0.0d0
          s14 = 0.0d0
          do l=1,k
            s11 = s11 + a(m,l)*b(l,j)
            s12 = s12 + a(m,l)*b(l,j+1)
            s13 = s13 + a(m,l)*b(l,j+2)
            s14 = s14 + a(m,l)*b(l,j+3)
          enddo
          c(m,j)     = s11 
          c(m,j+1)   = s12 
          c(m,j+2)   = s13
          c(m,j+3)   = s14
        enddo
        if (nresid  ==  0) then
          return
        elseif (nresid  ==  1) then
          s11 = 0.0d0
          do l=1,k
            s11 = s11 + a(m,l)*b(l,n)
          enddo
          c(m,n) = s11
          return
        elseif (nresid  ==  2) then
          s11 = 0.0d0
          s12 = 0.0d0
          do l=1,k
            s11 = s11 + a(m,l)*b(l,n-1)
            s12 = s12 + a(m,l)*b(l,n)
          enddo
          c(m,n-1) = s11
          c(m,n) = s12
          return
        else
          s11 = 0.0d0
          s12 = 0.0d0
          s13 = 0.0d0
          do l=1,k
            s11 = s11 + a(m,l)*b(l,n-2)
            s12 = s12 + a(m,l)*b(l,n-1)
            s13 = s13 + a(m,l)*b(l,n)
          enddo
          c(m,n-2) = s11
          c(m,n-1) = s12
          c(m,n) = s13
          return
        endif          
      elseif (mresid  ==  2) then
        do j=1,n-nresid,4
          s11 = 0.0d0
          s12 = 0.0d0
          s13 = 0.0d0
          s14 = 0.0d0
          s21 = 0.0d0
          s22 = 0.0d0
          s23 = 0.0d0
          s24 = 0.0d0
          do l=1,k
            s11 = s11 + a(m-1,l)*b(l,j)
            s12 = s12 + a(m-1,l)*b(l,j+1)
            s13 = s13 + a(m-1,l)*b(l,j+2)
            s14 = s14 + a(m-1,l)*b(l,j+3)
            s21 = s21 + a(m,l)*b(l,j)
            s22 = s22 + a(m,l)*b(l,j+1)
            s23 = s23 + a(m,l)*b(l,j+2)
            s24 = s24 + a(m,l)*b(l,j+3)
          enddo
          c(m-1,j)   = s11 
          c(m-1,j+1) = s12 
          c(m-1,j+2) = s13
          c(m-1,j+3) = s14
          c(m,j)     = s21
          c(m,j+1)   = s22 
          c(m,j+2)   = s23
          c(m,j+3)   = s24
        enddo
        if (nresid  ==  0) then
          return
        elseif (nresid  ==  1) then
          s11 = 0.0d0
          s21 = 0.0d0
          do l=1,k
            s11 = s11 + a(m-1,l)*b(l,n)
            s21 = s21 + a(m,l)*b(l,n)
          enddo
          c(m-1,n) = s11
          c(m,n) = s21
          return
        elseif (nresid  ==  2) then
          s11 = 0.0d0
          s21 = 0.0d0
          s12 = 0.0d0
          s22 = 0.0d0
          do l=1,k
            s11 = s11 + a(m-1,l)*b(l,n-1)
            s12 = s12 + a(m-1,l)*b(l,n)
            s21 = s21 + a(m,l)*b(l,n-1)
            s22 = s22 + a(m,l)*b(l,n)
          enddo
          c(m-1,n-1) = s11
          c(m-1,n)   = s12
          c(m,n-1)   = s21
          c(m,n)     = s22
          return
        else
          s11 = 0.0d0
          s21 = 0.0d0
          s12 = 0.0d0
          s22 = 0.0d0
          s13 = 0.0d0
          s23 = 0.0d0
          do l=1,k
            s11 = s11 + a(m-1,l)*b(l,n-2)
            s12 = s12 + a(m-1,l)*b(l,n-1)
            s13 = s13 + a(m-1,l)*b(l,n)
            s21 = s21 + a(m,l)*b(l,n-2)
            s22 = s22 + a(m,l)*b(l,n-1)
            s23 = s23 + a(m,l)*b(l,n)
          enddo
          c(m-1,n-2) = s11
          c(m-1,n-1) = s12
          c(m-1,n)   = s13
          c(m,n-2)   = s21
          c(m,n-1)   = s22
          c(m,n)     = s23
          return
        endif
      else
        do j=1,n-nresid,4
          s11 = 0.0d0
          s21 = 0.0d0
          s31 = 0.0d0
          s12 = 0.0d0
          s22 = 0.0d0
          s32 = 0.0d0
          s13 = 0.0d0
          s23 = 0.0d0
          s33 = 0.0d0
          s14 = 0.0d0
          s24 = 0.0d0
          s34 = 0.0d0
          do l=1,k
            s11 = s11 + a(m-2,l)*b(l,j)
            s12 = s12 + a(m-2,l)*b(l,j+1)
            s13 = s13 + a(m-2,l)*b(l,j+2)
            s14 = s14 + a(m-2,l)*b(l,j+3)
            s21 = s21 + a(m-1,l)*b(l,j)
            s22 = s22 + a(m-1,l)*b(l,j+1)
            s23 = s23 + a(m-1,l)*b(l,j+2)
            s24 = s24 + a(m-1,l)*b(l,j+3)
            s31 = s31 + a(m,l)*b(l,j)
            s32 = s32 + a(m,l)*b(l,j+1)
            s33 = s33 + a(m,l)*b(l,j+2)
            s34 = s34 + a(m,l)*b(l,j+3)
          enddo
          c(m-2,j)   = s11 
          c(m-2,j+1) = s12 
          c(m-2,j+2) = s13
          c(m-2,j+3) = s14
          c(m-1,j)   = s21 
          c(m-1,j+1) = s22
          c(m-1,j+2) = s23
          c(m-1,j+3) = s24
          c(m,j)     = s31 
          c(m,j+1)   = s32
          c(m,j+2)   = s33
          c(m,j+3)   = s34
        enddo
        if (nresid  ==  0) then
          return
        elseif (nresid  ==  1) then
          s11 = 0.0d0
          s21 = 0.0d0
          s31 = 0.0d0
          do l=1,k
            s11 = s11 + a(m-2,l)*b(l,n)
            s21 = s21 + a(m-1,l)*b(l,n)
            s31 = s31 + a(m,l)*b(l,n)
          enddo
          c(m-2,n) = s11
          c(m-1,n) = s21
          c(m,n) = s31
          return
        elseif (nresid  ==  2) then
          s11 = 0.0d0
          s21 = 0.0d0
          s31 = 0.0d0
          s12 = 0.0d0
          s22 = 0.0d0
          s32 = 0.0d0
          do l=1,k
            s11 = s11 + a(m-2,l)*b(l,n-1)
            s12 = s12 + a(m-2,l)*b(l,n)
            s21 = s21 + a(m-1,l)*b(l,n-1)
            s22 = s22 + a(m-1,l)*b(l,n)
            s31 = s31 + a(m,l)*b(l,n-1)
            s32 = s32 + a(m,l)*b(l,n)
          enddo
          c(m-2,n-1) = s11
          c(m-2,n)   = s12
          c(m-1,n-1) = s21
          c(m-1,n)   = s22
          c(m,n-1)   = s31
          c(m,n)     = s32
          return
        else
          s11 = 0.0d0
          s21 = 0.0d0
          s31 = 0.0d0
          s12 = 0.0d0
          s22 = 0.0d0
          s32 = 0.0d0
          s13 = 0.0d0
          s23 = 0.0d0
          s33 = 0.0d0
          do l=1,k
            s11 = s11 + a(m-2,l)*b(l,n-2)
            s12 = s12 + a(m-2,l)*b(l,n-1)
            s13 = s13 + a(m-2,l)*b(l,n)
            s21 = s21 + a(m-1,l)*b(l,n-2)
            s22 = s22 + a(m-1,l)*b(l,n-1)
            s23 = s23 + a(m-1,l)*b(l,n)
            s31 = s31 + a(m,l)*b(l,n-2)
            s32 = s32 + a(m,l)*b(l,n-1)
            s33 = s33 + a(m,l)*b(l,n)
          enddo
          c(m-2,n-2) = s11
          c(m-2,n-1) = s12
          c(m-2,n)   = s13
          c(m-1,n-2) = s21
          c(m-1,n-1) = s22
          c(m-1,n)   = s23
          c(m,n-2)   = s31
          c(m,n-1)   = s32
          c(m,n)     = s33
          return
        endif
      endif
      return
      end subroutine mxm44_0

end module singleton_module_src_mxm_std


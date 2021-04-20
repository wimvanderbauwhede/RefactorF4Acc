      program test_loop_nature
        integer sz
        parameter( sz = 1024 )
        integer, parameter :: w = sz*4
        integer, parameter :: h = sz*3
        real, dimension(-1:w+2,-1:h+2) :: p1, p2

        call sub0(p1,p2)

        call sub1(p1,p2)

        call sub2(p1,p2)

        print *, p1(w/2,h/2)

      end program

      subroutine sub0(p1,p2)      
        integer, parameter :: sz = 1024
        integer, parameter :: w = sz*4
        integer, parameter :: h = sz*3
        real p1(-1:w+2,-1:h+2)
        real p2
        dimension p2(-1:w+2,-1:h+2)
        ! real, dimension(-1:w+2,-1:h+2) :: p1, p2     
        integer :: i,j   
        do i = -1, w+2
            do j = -1, h+2
                p1(i,j) = (i+j*(w+4))*0.1
                p2(i,j) = -p1(i,j)
            end do
        end do
      end subroutine
      
      subroutine sub1(p1,p2)      
        integer, parameter :: sz = 1024
        integer, parameter :: w = sz*4
        integer, parameter :: h = sz*3
        real, dimension(-1:w+2,-1:h+2) :: p1, p2        
        integer :: i,j        

        do i = -1, w+2
            do j = -1, h+2
                p1(i,j) = (p1(i,j) - p2(i,j))/2.0
            end do
        end do
        
        do i = -1, w+2
            do j = -1, h+2
                p2(i,j) = 2.0*p1(i,j)
            end do
        end do

      end subroutine

      subroutine sub2(p1,p2)      
        integer, parameter :: sz = 1024
        integer, parameter :: w = sz*4
        integer, parameter :: h = sz*3
        real, dimension(-1:w+2,-1:h+2) :: p1, p2        
        integer :: i,j
        real :: acc

        do i = 0, w+1
            do j = 0, h+1
                p2(i,j) = (p1(i+1,j)+p1(i-1,j)+ p1(i,j+1)+p1(i,j-1))/4.0
            end do
        end do

        acc=0
        do i = -1, w+2
            do j = -1, h+2
                acc =  acc + p1(i,j) 
            end do
        end do
        acc = acc / ((w+4)*(h+4))

        do i = -1, w+2
            do j = -1, h+2
                p1(i,j) = p2(i,j)+acc
            end do
        end do
      end subroutine        


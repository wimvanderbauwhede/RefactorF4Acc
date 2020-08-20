      program fof
          !integer sqsum
          external sqsum
          external f2
          integer x,y,z
          x=3
          y=4
          !z = sqsum(x,y)
          !print *,z            
          !call f2(x,y,z)
          !print *,z            
          call ten_times_f(sqsum,3,4,z,.false.)
          print *,z
          call ten_times_s(f2,3,4,z,.false.)
          print *,z
          
      end 
      
      subroutine ten_times_f(f3,x,y,z,c)
          integer  f3 ! for a function
          integer x,y
          integer z
          real r1,r2
          logical c
          r1=7.1
          r2=8.8
          if (c) then
          z = f3(x,y)
          else
          ! patently wrong:
          ! logical -> real -> real
          print *, 'Wrong!'
          z = f3(c,r1,r2,x,y) ! 
          end if
          !print *,z
      end 

      subroutine ten_times_s(f3,x,y,z,c)
          !external f3 ! for a subroutine but not needed
          integer x,y
          integer z
          real r1,r2
          logical c
          r1=7.1
          r2=8.8
          if (c) then
          call f3(x,y,z)
          !z = f3(x,y)
          else
          ! patently wrong:
          ! logical -> real -> real
          print *, 'Wrong!'
          call f3(c,r1,r2,x,y,z) ! 
          !z = f3(c,r1,r2,x,y) ! 
          end if
          !print *,z
      end       
      subroutine f2(x,y,z)
          integer x,y
          integer z
          z = x*x+y*y
      end 
      
      integer function sqsum(x,y)
      	integer x,y
      	sqsum = x*x+y*y
      	!print *,sqsum
      end 
      

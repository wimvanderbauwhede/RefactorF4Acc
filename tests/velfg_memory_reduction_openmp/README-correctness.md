# Verifying correctness

In the driver (gen_velfg_superkernel.f95) we add: 

     integer, parameter :: ip=300
     integer, parameter :: jp=300
     integer, parameter :: kp=90
    integer :: i,j,k     

    ! other decls ... 

    integer :: clock_rate
    integer (kind=4), dimension(0:1) :: timestamp 

    do k = -1,kp+2
      dzn(k)=1.
      dzs(k)=1.
    end do
    do i = -1,ip+1
        dx1(i)=1.
        delx1(i)=1.
    end do
    do j = 0,jp+1
      dy1(j)=1.
    end do

    f = 1.0; g = 1.0; h = 1.0
    u = 1.0; v = 1.0; w = 1.0

    call system_clock(timestamp(0), clock_rate)

    ! iter loop here

    call system_clock(timestamp(1), clock_rate)
    print '(f6.3)',(timestamp(1)-timestamp(0))/ real(clock_rate)
   print *, sum(f)
   print *, sum(g)
   print *, sum(h)


1. test the single-threaded reference
14.338
    sum(f) = 144692.000    
    sum(g) = 144692.000    
    sum(h) = 324692.000 

2. test the OpenMP reference
 1.604
    sum(f) = 144692.000    
    sum(g) = 144692.000    
    sum(h) = 324692.000 

3. test the single-threaded generated code without inlining

47.767
   144691.000    
   144691.000    
   324692.000

4. test the single-threaded generated code with inlining
5. test the OpenMP generated code with inlining


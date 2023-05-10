# Verifying correctness

In the driver (gen_velfg_superkernel.f95) we add: 

     integer, parameter :: ip=150*WM
     integer, parameter :: jp=150*WM
     integer, parameter :: kp=90

    integer :: i,j,k     

    ! other decls ... 
#ifdef TIMING
    integer :: clock_rate
    integer (kind=4), dimension(0:1) :: timestamp 
#endif
    do k = -1,kp+2
      dzn_0(k)=1.
      dzs_0(k)=1.
    end do
    do i = -1,ip+1
        dx1_0(i)=1.
        ! delx1(i)=1.
    end do
    do j = 0,jp+1
      dy1_0(j)=1.
    end do

    f_1 = 1.0; g_1 = 1.0; h_1 = 1.0
    u_0 = 1.0; v_0 = 1.0; w_0 = 1.0

#ifdef TIMING
    call system_clock(timestamp(0), clock_rate)
#endif
    ! iter loop here => change to 90*150*WM*150*WM
#ifdef TIMING
    call system_clock(timestamp(1), clock_rate)
    print '(f6.3)',(timestamp(1)-timestamp(0))/ real(clock_rate)
#endif

#ifdef CHECKSUM    
   print *, sum(f_1)
   print *, sum(g_1)
   print *, sum(h_1)
#endif

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
 4.723
   144691.000    
   144691.000    
   324692.000 

5. test the OpenMP generated code with inlining

 0.808
   144691.000    
   144691.000    
   324692.000 

The complication here is that the WM must apply to the ip and kp, not to the overall size. So ideally, when we generate the full sizes, these should be expressions in WM rather than numeric constants. 

Instead we hack that by matching 

Problem is that the stencil offsets are also in that position, and there are a lot of them.
Probably the best thing to do is to approximate:
 605, 91809, 92110, 92111, 92412 should be matched as about 600, 90000, 180000;

Or, more tempting, write an algorithm to figure out a formula of the form
    a*(ip+off1)*(jp+off2)+b for the large ones
and 
    a*ip+b
for the small ones

`a` is easy
off1, off2 and b can be done simply by brute force:

sub decompose_num { (my $n) = @_;
    my $a=1;
    my @factors=();
    # 1. small or large?
    if ($n < ($ip-3)*($jp-3)) {
        # small
        $a =int($n/$ip); # e.g. 2
        die unless $a<=2;
        # now brute-force:
        for my $b (0 .. 3) {
            for my $off1 (-1 .. 3) {
                if ($n == $a*($ip+$off1)+$b) {
                    return $a.'*(150*WM+'.$off1.')+'.$b;
                }
            }
        }
    } else {
        # medium or large?
        ($n > ($ip+3)*($jp+3)+3) {
            $a=int($n/($ip-3)*($jp-3));
            die unless $a<=2;
        } else {
            $a=1;
        }
    
        for my $b (0 .. 3) {
            for my $off1 (-1 .. 3) {
                for my $off2 (-1 .. 3) {
                    if ($n == $a*($ip+$off1)*($jp+$off2)+$b) {                        
                        return $a.'*(150*WM+'.$off1.')*(150*WM+'.$off2.')+'.$b;
                        
                    }
                }
            }
        }
    }
}
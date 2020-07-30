program test_type_coercion
    integer :: i1,i2,i3
    real :: r1,r2,r3
    r1 = 0.14159
    i1=3
    r2 = i1+r1
    r3 = i1/r1
    print *, r2,r3
    i2 = i1+r1
    i3 = i1/r1
    print *, i2,i3

end program test_type_coercion

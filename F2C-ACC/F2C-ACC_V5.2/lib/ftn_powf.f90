real function ftn_powf (arg1,arg2) 

real, intent(IN) :: arg1,arg2
ftn_powf = arg1**arg2

print *,'arg1 = ', arg1,' ,arg2 = ',arg2
return;
end function

real*8 function ftn_pow (arg1,arg2) 

real*8, intent(IN) :: arg1,arg2
ftn_pow = arg1**arg2

return;
end function

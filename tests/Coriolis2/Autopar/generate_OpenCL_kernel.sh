refactorF4acc.pl -P translate_to_OpenCL -c rf4a_to_C.cfg $1
cp  $1.cl $1_ORIG.cl
cpp -DNTH=1 -DNUNITS=8 -I. -P $1.cl > tmpp.cl
mv tmpp.cl $1_after_CPP.cl
rm -Rf Temp

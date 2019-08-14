MODNAME=`grep 'MODULE =' rf4a_to_C.cfg | perl -p -e 's/MODULE...//; chomp'`
refactorF4acc.pl -P translate_to_OpenCL -c rf4a_to_C.cfg $MODNAME
#cp  $MODNAME.cl ${MODNAME}_ORIG.cl
#cpp -DNTH=1 -DNUNITS=8 -I. -P $MODNAME.cl > tmpp.cl
#mv tmpp.cl ${MODNAME}_after_CPP.cl
#rm -Rf Temp

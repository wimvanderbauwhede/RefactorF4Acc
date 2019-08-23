INPUT=$1
echo $INPUT
FILENAME=$(basename $INPUT .c )
echo $FILENAME
clang-mp-8.0 -O0 -Xclang -disable-O0-optnone -emit-llvm -c $INPUT -o ${FILENAME}_tmp.bc
opt-mp-8.0  -S -mem2reg ${FILENAME}_tmp.bc -o ${FILENAME}_O0.ll
#clang-mp-8.0 -O1 -emit-llvm -c $INPUT -o ${FILENAME}_tmp.bc
#opt-mp-8.0  -S -mem2reg ${FILENAME}_tmp.bc -o ${FILENAME}_O1.ll
#clang-mp-8.0 -O0 -S -emit-llvm $FILENAME.bc -o ${FILENAME}_opt.ll



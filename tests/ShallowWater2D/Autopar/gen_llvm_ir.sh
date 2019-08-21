INPUT=$1
echo $INPUT
FILENAME=$(basename $INPUT .c )
echo $FILENAME
clang-mp-7.0  -emit-llvm -c $INPUT -o ${FILENAME}_tmp.bc
opt-mp-7.0  -mem2reg ${FILENAME}_tmp.bc -o $FILENAME.bc
clang-mp-7.0 -O0 -S -emit-llvm $FILENAME.bc -o $FILENAME.ll



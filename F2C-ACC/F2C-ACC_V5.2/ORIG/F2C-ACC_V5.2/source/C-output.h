
#include "ptg_gen.h"
#include "deftbl.h"
#include "C-outputDefs.h"
#include "GPU_Directives.h"

PTGNode FTNREFCPP(int sym, RegionVars regionVars,int regionType,int declLine,DefTableKey unitKey, DefTableKey objectKey, PTGNode Subscripts, POSITION *coord, GPUVarsList list);
PTGNode Convert_to_Ctype(int typelen, DefTableKey type);
PTGNode Convert_to_CudaType(int typelen, DefTableKey type);
PTGNode Convert_to_M4type(int typelen, DefTableKey type);
PTGNode Pointer_Ref(int numDims);
PTGNode ComputeArraySize(int regionType, int declLine, DefTableKey unitKey, DefTableKey objectKey, POSITION *coord);

PTGNode GenerateLoops(DefTableKey objectKey, DefTableKey unitKey, int dims, 
int maxRank, int indent, PTGNode label, PTGNode name, PTGNode expr, 
int line, int lastNonExecLine,POSITION *coord, RegionVars regionVars);
PTGNode GenerateLoopIndices(int dims);
int SetRankDefineLoopVars(int dims, int maxRank, int LastNonExecLine,int indent, int line);
PTGNode GetArrayBounds(DefTableKey objectKey, int index, int dim);
PTGNode GetAllArrayBounds(int line,DefTableKey objectId, BoundsList arrayList,int sym);

PTGNode EndContinueLoops(int line, PTGNode label, int indentLevel, int labelCount,int nestLevel, DoAcc accDo);

PTGNode GenerateAllocation(PTGNode var, DefTableKey unitKey, DefTableKey objectKey, int mode);
PTGNode GenerateArray(PTGNode var, BoundsList arrayList, DefTableKey objectKey, DefTableKey unitKey,int indent,int translationType,int demoteDim1,int DemoteDim2,int promoteDim, int promoteType, RegionVars regionVar);

int isIntrinsic(char *name, int nArgs);
char * getIntrinsicName(char *,int, POSITION *);

PTGNode ConstantHandling(char *name,int type);
int Convert_to_int(char *name);
int isModule(int line);
PTGNode ConstructLoopIndex(PTGNode doIndex, PTGNode threadStart, int mode, RegionVars regionVars, int dim, int doloop);

void SetVariableUse(DefTableKey objectKey, int region, int update, int type,
  int sym, int line, int stmtNumber);
int GetVariableUse(DefTableKey objectKey, int type, int update,int sym,int region,int line, int stmtNumber);

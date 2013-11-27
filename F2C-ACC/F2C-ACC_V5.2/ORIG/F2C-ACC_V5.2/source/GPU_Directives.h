
#ifndef ACCDO_H
#define ACCDO_H
#include "err.h"        /* error reporting support      */
#include "deftbl.h"     /* definition table support     */
#include "ProgDeclsList.h" /* exported by the LidoList module */
#include "GPUVarsList.h" /* exported by the LidoList module */
#include "VariableUseList.h"
#include "GPU_DirectiveDefs.h"  /* local #define values         */

typedef struct {
  int DoVector[3],DoVectorSym[3];
  int DoStartV[3],DoStopV[3];
  int DoParallel[3],DoParallelSym[3];
  int DoStartP[3],DoStopP[3];
  int BaseValueP[3];
  int BaseValueV[3];
} DoAcc;

typedef struct {
  int regionP[3];  //declared parallel dimension (in ACC$REGION)
  int regionV[3];  // declared thread dimension (in ACC$REGION)
  int symP[3];  // loop index used in each blocking dimension
  int symV[3];  // loop index used in each threaded dimension
  int threadOption[3];
  int threadOptionMode[3];
  PTGNode loopStart[3];
} RegionVars;

DoAcc SetAccDo(DoAcc accDo, int type, int nestLevel, int start, int stop, int dim, int sym, int startValue, POSITION *COORDREF);
DoAcc ResetContinueLoops(int labelCount,int nestLevel, DoAcc accDo,POSITION *coord);
int GetAccDo(DoAcc accDo, int dim, int type, int mode, int sym,POSITION *coord);

int GetRegionVarProperty(RegionVars regionVar, int mode, int localIndex);
RegionVars SetRegionVar(RegionVars regionVar, int paramType, int sym, DefTableKey objectKey,int dim, int indx,int threadValue,int regionSym, PTGNode loopStart,POSITION *coord);
RegionVars InitRegionVar();

PTGNode ConstructAccRegion(RegionVars regionVars);

int CheckArray(int regionNumber, DefTableKey objectKey,RegionVars regionVars, DoAcc doAcc,int index);

int GetAccInfo(DoAcc doAcc, int type, int value,int sym);
DoAcc InitAccDo();

ProgDecls PkgProgDecls(int sym,DefTableKey objectKey,DefTableKey unitKey,int type);

VariableUse PkgVariableUse(int sym, int stmtNumber, DefTableKey objectKey, DefTableKey unitKey,POSITION *coord,int regionNumber,int accRegionNumber, int cpuRegionNumber, int update,int line);

GPUVars PkgGPUVars(POSITION *coord,int sym,int gsym,DefTableKey objectKey,DefTableKey gobjectKey, DefTableKey unitKey,int intent,int scope, int optexpr, PTGNode condexpr,int actualexpr,int regionNumber, int sharedDim1, int sharedDim2, int demoteDim, Mote demote, int promoteDim, int promoteType,Mote promote,int promoteVar, int promoteLB, int device, int directiveType);
GPUVarsList AddLocalVars(ProgDeclsList llist, GPUVarsList list,int region);
int GetGPUVarProperty(int sym, GPUVarsList list,int type, int localIndex);

void VariableAnalysis(int accRegionLine, GPUVarsList list, VariableUseList rlist, ProgDeclsList llist,int regionNumber,POSITION *coord,int routineName,int kernelsInFile,int translationType,RegionVars regionVars, PTGNode dataSectionPTG);

PTGNode BuildStruct(int programName, GPUVarsList list,int kernelNum);
PTGNode SubArgsOutput(int programName, ProgDeclsList llist, GPUVarsList list,int mode,int line, int declLine, int region,int numKernels,RegionVars regionVars,POSITION *coord);

PTGNode GenerateGlobalDecls(GPUVarsList list);
int ToUpper(int sym);
int UserConstants(DefTableKey objectkey, int sym);

int InGPUVarsList(GPUVarsList list,int sym);
int InVariableUseList(VariableUseList rlist,int sym);

Mote SetMoteDims(int dim1, int dim2);
Mote InitMoteDims();
int GetBlockDim(RegionVars regionVars, int par1, int par2, int par3, int sym, GPUVarsList list);
#endif

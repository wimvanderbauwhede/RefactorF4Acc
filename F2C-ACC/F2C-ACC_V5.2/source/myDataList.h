
#ifndef DATALIST_STRUCT_H
#define DATALIST_STRUCT_H
#include "deftbl.h"
#include "ptg_gen.h"

// ACC$REGION variables list
typedef struct {
  int sym,gsym;
  DefTableKey objectKey,gobjectKey;
  DefTableKey unitKey;
  int intent, scope;
  int optexpr;
  PTGNode condexpr;
  int actualexpr;
  int regionNumber;
  int sharedDim1,sharedDim2;
  int demoteDim;
  int demoteDims[2];
  int promoteDim,promoteType;
  int promoteDims[2];
  int promoteVar;
  int promoteLB;
  int device;
} GPUVars;

// Program Declarations
typedef struct {
  int sym;
  DefTableKey objectKey;
  DefTableKey unitKey;
  int type;     // CONSTANT and VARIABLE currently
} ProgDecls;

// Variable usage
typedef struct {
  int sym;
  int stmtNumber;
  DefTableKey objectKey;
  DefTableKey unitKey;
  int line,col;
  int accRegionLine;
  int accRegionNumber;
  int cpuRegionNumber;
  int update;
} VariableUse;

typedef struct {
  int dims[2];
} Mote;
#endif

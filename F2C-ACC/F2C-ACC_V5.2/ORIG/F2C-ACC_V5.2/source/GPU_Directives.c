

#include "csm.h"        /* string table handling                */
#include "clp.h"        /* command line interpreter             */
#include "GPU_Directives.h"     /* local data structures        */
#include "pdl_gen.h"    /* access defined properties            */
#include "ptg_gen.h"

/* The accDo data structure stores information about the do-loops that contain
** either thread level (ACC$DO VECTOR) or grid-level (ACC$DO PARALLEL) 
** parallelism.  Three routines are defined to initialize (InitAccDo), 
** populate (SetAccDo) and retrieve (GetAccDo) values.
*/

/* Initialize the DoAcc structure.  Both the nest level, and name of the
** loop variable is stored. 
*/
DoAcc InitAccDo() {

  DoAcc accDo;
  int i;
  for (i=0; i<3; i++) {
    accDo.DoParallel[i] = 0;
    accDo.DoParallelSym[i] = 0;

    accDo.DoVector[i] = 0;
    accDo.DoVectorSym[i] = 0;

    accDo.DoStartP[i] = 0;      // user defined start value
    accDo.DoStopP[i] = 0;       // user defined stop value

    accDo.BaseValueP[i] = 0;    // first parallel thread value
    accDo.BaseValueV[i] = 0;    // first vector thread value
  }
  return(accDo);
}

/* Routine to set fields in the DoAcc data structure. For each ACC$DO associated
** with a do-loop, the nest level is stored along with the variable name. The
** nest level is used to determine when an ACC$DO has ended.  It has the value
** 0 when no ACC$DO is in effect. 
** Optional fields defining loop start, stop, and base are used to restrict 
** execution. For example, DO PARALLEL(1,< 2:nz,1>, indicates calculations 
** from 2:nz, where the thread start index (or BaseValue) is 1.
** 
** Three modes are used to assign or reset the loop nest level:
**   PARALLEL   - set the nest level and variable used for block parallelism
**     VECTOR   - set the nest level and variable used for thread parallelism
**      ENDDO   - reset nest level field to zero (a closing do loop statement)
*/

DoAcc SetAccDo(DoAcc accDo,int type, int nestLevel,int start, int stop, int dim, int sym, int startValue, POSITION *coord) {

  int i;
  if (type == PARALLEL) {
    if (accDo.DoParallel[dim-1] != 0) {
      message(ERROR,"Active DO PARALLEL detected for this dimension.",0,coord);
    }
    accDo.DoParallel[dim-1] = nestLevel;
    accDo.DoParallelSym[dim-1] = sym;
    accDo.DoStartP[dim-1] = start;
    accDo.DoStopP[dim-1] = stop;
    if (startValue == 0) {
      accDo.BaseValueP[dim-1] = start;
    } else {
      accDo.BaseValueP[dim-1] = startValue;
    }
    return(accDo);
  }
  if (type == VECTOR) {
    if (accDo.DoVector[dim-1] != 0) {
      message(ERROR,"Active DO VECTOR detected for this dimension.",0,coord);
    }
    accDo.DoVector[dim-1] = nestLevel;
    accDo.DoVectorSym[dim-1] = sym;
    accDo.DoStartV[dim-1] = start;
    accDo.DoStopV[dim-1] = stop;
    if (startValue == 0) {
      accDo.BaseValueV[dim-1] = start;
    } else {
      accDo.BaseValueV[dim-1] = startValue;
    }
    return(accDo);
  }
  if (type == ENDDO) {  /* end the loop parallelism */
    for(i=0;i<3;i++) {
      if (accDo.DoParallel[i] == nestLevel) { 
        accDo.DoParallel[i] = 0; 
        accDo.DoParallelSym[i] = 0; 
        accDo.DoStartP[i] = 0;
        accDo.DoStopP[i] = 0;
        accDo.BaseValueP[i] = 0;
        return(accDo);
      }
      if (accDo.DoVector[i] == nestLevel) { 
        accDo.DoVector[i] = 0; 
        accDo.DoVectorSym[i] = 0; 
        accDo.DoStartV[i] = 0;
        accDo.DoStopV[i] = 0;
        accDo.BaseValueV[i] = 0;
        return(accDo);
      }
    }
  }
  return(accDo);
}

/* Two functions are defined to retrieve values from AccDo.
/* GetAccDo retrieves values from a specific dimension of the DoAcc based
** on the type and mode given.  The type can either be PARALLEL or VECTOR.
** There are four modes:
**      BASE    return the base (thread) value
**      START   return the starting loop value
**      STOP    return the stop loop value
**      MATCH   return TRUE if the variable equals the loop variable
*/
int GetAccDo(DoAcc accDo, int dim, int type, int mode, int sym,POSITION *coord) {

  if (type == VECTOR) {
    if (mode == MATCH) {
      if (sym == accDo.DoVectorSym[dim-1]) { return(TRUE); } 
      return(FALSE);
    }
    if (mode == BASE) { return(accDo.BaseValueV[dim-1]); }
    if (mode == START) { return (accDo.DoStartV[dim-1]); }
    if (mode == STOP)  { return (accDo.DoStopV[dim-1]); }
  }
  if (type == PARALLEL) {
    if (mode == MATCH) {
// printf("DEBUG: sym: %s parallelSym: %s\n",StringTable(sym),StringTable(accDo.DoParallelSym[0]));
      if (sym == accDo.DoParallelSym[0]) { return(TRUE); } 
      if (sym == accDo.DoParallelSym[1]) { return(TRUE); } 
      if (sym == accDo.DoParallelSym[2]) { return(TRUE); } 
      return(FALSE);
    }
    if (mode == PSCOPE) {
      if (accDo.DoParallel[dim-1] > 0) { return(TRUE); } else { return(FALSE); }
    }

    if (mode == BASE) { return(accDo.BaseValueP[dim-1]); }
    if (mode == START) { return (accDo.DoStartP[dim-1]); }
    if (mode == STOP)  { return (accDo.DoStopP[dim-1]); }
  }
  fprintf(stderr,"Invalid type: %d or mode: %d in GetAccDo.\n",type,mode);
  return(0);
}

/* Function to return information about the accelerator do loop or variables
** used within any PARALLEL or VECTOR loop.  Supported functions are:
**   EXISTS     does the variable match to do loop PARALLEL variable 
**   ACCDO      does the nest level match the DO PARALLEL or DO VECTOR?
**   PARALLEL   does the nest level match the DO PARALLEL?
**   VECTOR     does the nest level match the DO VECTOR?
*/

int GetAccInfo(DoAcc accDo, int type, int nestLevel,int sym) {

  int i;
  for (i=0; i<3; i++) {
    if (type == EXISTS) {
      if (sym == accDo.DoParallelSym[i]) { return(i+1); }
    }
    if (type == PSCOPE) {
      if (accDo.DoParallel[i] > 0) { return(nestLevel); }
    }
    if ((type == PARALLEL) || (type == ACCDO)) {
      if (accDo.DoParallel[i] == nestLevel) { return (accDo.DoParallel[i]); }
    }
    if ((type == VECTOR) || (type == ACCDO)) {
      if (accDo.DoVector[i] == nestLevel) {
        return (accDo.DoVector[i]);
      }
    }
    if (type == ACCDO_OPT) {
      if (((accDo.DoParallel[i] == nestLevel) && (accDo.DoStartP[i] > 0)) ||
          ((accDo.DoVector[i] == nestLevel) && (accDo.DoStartV[i] > 0))) {
        return (TRUE);
      } 
    }
  } 
  return(0);
}

/* function to handle closing do-continue loops */
DoAcc ResetContinueLoops(int labelCount,int nestLevel, DoAcc accDo,POSITION *coord) {

int i;
for(i=1; i<=labelCount; i++) {
  if (GetAccInfo(accDo,ACCDO,nestLevel-i+1,0) >= 1) {
    accDo = SetAccDo(accDo,ENDDO,nestLevel-i+1,0,0,0,0,0,coord);
  }
}
return(accDo);
}

  
/* The functions InitRegionVar and SetRegionVar store the block and thread
** information for the ACC$REGION directive.  In addition, the symV and symP
** attributes store the variable index associated with the ACC$DO directive
*/ 
RegionVars InitRegionVar() {
int i;
RegionVars regionVar;

  for (i=0;i<3;i++) {
    regionVar.regionV[i] = 0;
    regionVar.regionP[i] = 0;
    regionVar.symV[i] = 0;
    regionVar.symP[i] = 0;
    regionVar.threadOption[i] = 0;
    regionVar.threadOptionMode[i] = 0;
  }
  return(regionVar);
}

/* This function sets the accelerator region grid or thread block size  **
** in two ways:  (1) when the ACC$REGION is parsed using the THREAD and **
** BLOCK qualifiers, and (2) when an array is referenced using the loop **
** index of the PARALLEL computation.                                   **
** The former case is used to determine array sizes needed to promote   **
** global and shared memory arrays                                      **
** The latter case is used to detect arrays that do not storage for the **
** block (PARALLEL) calculations.  An update to the value given in the  **
** ACC$REGION is needed when the value differs from the dimension of    **
** the array where it is applied.                                       **
** linkage is determined thru the loop index variable (eg, "i"), which  **
** allows for a comparison to be made.  In the event the array to which **
** it is applied is defined with an lower:upper bound, the upper bound  **
** is used for comparison and then updated if necessary.                */

int GetRegionVarProperty(RegionVars regionVar, int mode, int localIndex) {
int i,num = 0;

        // blockfactor or chunking is only allowed in the first dimension
  if ((mode == BLOCKFACTOR) && (localIndex == 1)) {
    if (regionVar.threadOptionMode[localIndex-1] == mode) {
      return(regionVar.threadOption[localIndex-1]);
    }
  }
  if (mode == NTHREADS) {
    return(regionVar.regionV[localIndex-1]);
  }
  if (mode == NBLOCKS) {
    return(regionVar.regionP[localIndex-1]);
  }
  if (mode == BLOCK) {
    for (i=0;i<3;i++) {
      if (regionVar.regionP[i] > 0) { num++; }
    }
    return(num);
  }
  if (mode == THREAD) {
    for (i=0;i<3;i++) {
      if (regionVar.regionV[i] > 0) { num++; }
    }
    return(num);
  }
  if (mode == PARALLEL) {
    if (regionVar.symP[localIndex-1] > 0) { 
      return(regionVar.symP[localIndex-1]); 
    }
    return(FALSE);
  }

  return(FALSE);
}

RegionVars SetRegionVar(RegionVars regionVar, int paramType, int sym, DefTableKey objectKey, int dim, int indx, int threadValue,int regionSym, PTGNode loopStart,POSITION *coord) {

  char msg[256];
  BoundsList blist = GetArraySizeList(objectKey, NULLBoundsList);
  int length = LengthBoundsList(blist);

  if (paramType == THREAD) {
    regionVar.regionV[dim-1] = regionSym;
  }
  if (paramType == BLOCK) {
    regionVar.regionP[dim-1] = regionSym;
  }
  if ((paramType == CHUNK) || (paramType == BLOCKFACTOR)) {
printf("DEBUG: threadOption = %d mode = %d\n",threadValue,paramType);
    regionVar.threadOption[dim-1] = threadValue;
    regionVar.threadOptionMode[dim-1] = paramType;
    regionVar.regionV[dim-1] = regionSym;
  }
  if (paramType == DO_PARALLEL) {
    regionVar.symP[dim-1] = sym;
    regionVar.loopStart[dim-1] = loopStart;
  }
  if (paramType == DO_VECTOR) {
    regionVar.symV[dim-1] = sym;
    regionVar.loopStart[dim-1] = loopStart;
  }

    /* modify the internal value used in the parallel region if necessary */
  if (paramType == PARALLEL) {
/*
    if (length > 0) {
      if (indx > length) {
        fprintf(stderr,"System error in SetRegion.  Contact F2C-ACC developers.\n");
      }
      Bounds bound = IthElemBoundsList(blist,indx);
    }
*/
  }
  return(regionVar);
}

PTGNode ConstructAccRegion(RegionVars regionVars) {

PTGNode output = PTGNULL;
PTGNode args=PTGNULL;
PTGNode arg = PTGNULL;
int i;

// construct thread blocks first
for (i=0;i<3;i++) {
  if (regionVars.regionV[i] > 0) {
    arg = PTGString(StringTable(regionVars.regionV[i]));
    if (regionVars.threadOptionMode[i] == BLOCKFACTOR) {
      arg = PTGSequence(arg,
        PTGDataSectionBlockFactor(PTGNumber(regionVars.threadOption[i])));
    }
    if (regionVars.threadOptionMode[i] == CHUNK) {
      arg = PTGSequence(arg,PTGAsIs(":chunk"));
    }
    if (i == 0) {
      args = arg;
    } else {
      args = PTGCommaArgs(args,arg);
    }
  }
}
output = PTGDataSectionChevrons(args);

// construct the grid blocks next
args = PTGNULL;
arg = PTGNULL;
for (i=0;i<3;i++) {
  if (regionVars.regionP[i] > 0) {
    arg = PTGString(StringTable(regionVars.regionP[i]));
    if (i == 0) {
      args = arg;
    } else {
      args = PTGCommaArgs(args,arg);
    }
  }
}
output = PTGCommaArgs(output,PTGDataSectionChevrons(args));

return(output);
}

/* Function to determine if each array referenced in an ACC$DO PARALLEL,**
** contains a dimension needed to store the values executed in parallel **
** on the GPU.  This function handles two types of checks determined by **
** the array index: 
** 1 - If index is non zero, the check is to determine if a constant is **
**     used for the array dimension where a DO PARALLEL is specified.   **
**     TRUE is returned if a constant is being used.                    */

int CheckArray(int regionNumber, DefTableKey objectKey, RegionVars regionVars, DoAcc accDo,int index) {
  int i,j;
  int found;
  Bounds bound;
  BoundsList blist = GetArraySizeList(objectKey, NULLBoundsList);
  int length = LengthBoundsList(blist);
  if (length > 0) {
    if (index != 0) {
      if (index > length) {
        fprintf(stderr,"F2C-ACC ERROR: System error in CheckArray.  Contact F2C-ACC developers.\n");
        fprintf(stderr,"index = %d length = %d\n",index,length);
        exit(1);
      } else {
        bound = IthElemBoundsList(blist,index);
      }
      for (j=0;j<3;j++) {
        if (accDo.DoParallel[j] > 0) {  /* PARALLEL is in scope */
          if (bound.upper == regionVars.regionP[j]) {
            return(TRUE);
          }
        }
      }
      return(FALSE);
    } else {    /* verify each DO PARALLEL in scope */
      for(j=0;j<3;j++) {        /* loop thru each PARALLEL dimensions */
        // ignore chunking analysis for now
        if (regionVars.threadOptionMode[j] == CHUNK) { return(TRUE); }
        found = TRUE;
        if (accDo.DoParallel[j] > 0) {  /* PARALLEL is in scope */
          found = FALSE;
          for (i=1; i<=length; i++) {
            bound = IthElemBoundsList(blist,i);
 // printf("i = %d upperBound = %s %d regionVar = %d %s\n",i,StringTable(bound.upper),bound.upper,regionVars.regionP[j],StringTable(regionVars.symP[j]));
            if (bound.upper == regionVars.regionP[j]) { found = TRUE; }
          }
          if (found == FALSE) { return(FALSE); }
        }
      }
    }
  }
  return(TRUE);
}

Mote mote;
Mote SetMoteDims(int dim1, int dim2) {
printf("SetMote: %d %d\n",dim1,dim2);
  mote.dims[0] = dim1;
  mote.dims[1] = dim2;
  return(mote);
}
Mote InitMoteDims() {
  mote.dims[0] = 0;
  mote.dims[1] = 0;
  return(mote);
}

int GetBlockDim(RegionVars regionVars, int par1, int par2, int par3, int sym, GPUVarsList list) {

int length = LengthGPUVarsList(list);
int i;
GPUVars var;
int dims = 0;   // total number of dimensions
int pdim = 0;   // promoted block dimensions

 
// calculate the number of "parallel" dimensions in the region
int pdim_region = 0;
for (i=0;i<3;i++) {
  if ((regionVars.regionP[i] > 0) && (strcmp(StringTable(regionVars.regionP[i]),"1") != 0)) { pdim_region++; }
}

// add the promoted dimensions
for (i=1;i<=length;i++) {
  var = IthElemGPUVarsList(list,i);
  if (var.sym == sym) { 
    dims = GetNumberOfDims(var.unitKey,0);
    if ((var.promoteDims[0] > 0) && (var.promoteType == BLOCK)) { pdim++; }
    if ((var.promoteDims[1] > 0) && (var.promoteType == BLOCK)) { pdim++; }
    if (var.demoteDims[0] > 0) { dims--; }
    if (var.demoteDims[1] > 0) { dims--; }
    if (dims == 0) { return(TRUE); } // its a scalar
  }
}

dims = par1 + par2 +par3 + pdim;

  printf("GetBlockDim: var = %s regionP: %d dim: %d ->%d %d %d %d\n",StringTable(sym),pdim_region,dims,par1,par2,par3,pdim);
if (dims == pdim_region) {
  return(TRUE);
} else {
  return(FALSE);
}

}

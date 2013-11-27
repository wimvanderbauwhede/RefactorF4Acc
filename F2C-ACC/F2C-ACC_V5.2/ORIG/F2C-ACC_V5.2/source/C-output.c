
#include "deftbl.h"
#include "ptg_gen.h"
#include "clp.h"
#include "csm.h"
#include "err.h"
#include "Bounds.h"
#include "ppp.h"
#include "CoordMap.h"
#include "C-outputDefs.h"
#include "GPU_Directives.h"
#include "GPUVarsList.h"

/* CONSTITUENTS MAX function defined    */
int MAX(int i1, int i2) {
  if (i1 > i2) return(i1);
    return(i2);
}

PTGNode Pointer_Ref(int numDims) {
  PTGNode pointerRef = PTGNULL;
  int i;
  if (numDims>0) {
    pointerRef = PTGSequence(pointerRef,PTGAsIs("*"));
  }
  return(pointerRef);
}

/* Routine to convert types to C data types for C code generation -     **
** these are used for declaratives, and when copying data between CPU   **
** and GPU.                                                             */

PTGNode Convert_to_Ctype(int typelen, DefTableKey type) {
  PTGNode Ctype;

  Ctype = PTGAsIs("F2C-ACC: Type not recognized.");

  if (type == LogicalType) { Ctype = PTGAsIs("int"); }
  if (type == CharacterType) { Ctype = PTGAsIs("char"); }
  if (type == IntegerType) {
    if (typelen == 8) {
      Ctype = PTGAsIs("long");
    } else if (typelen == 4) {
      Ctype = PTGAsIs("int");
    } else {
      Ctype = PTGAsIs("int");
    }
  }
  if (type == RealType) {
    if (typelen == 8) {
      Ctype = PTGAsIs("double");
    } else if (typelen == 4) {
      Ctype = PTGAsIs("float");
    } else {
      Ctype = PTGAsIs("float");
    }
  }

  if (type == DoublePrecisionType) {
    Ctype = PTGAsIs("double");
  }

  return(Ctype);
}

/* Routine to convert types to Cuda-C data types - these are used **
** for declaratives, and when copying data between CPU and GPU    */

PTGNode Convert_to_CudaType(int typelen, DefTableKey type) {
  PTGNode Ctype;

  Ctype = PTGAsIs("here F2C-ACC: Type not recognized.");

  if (type == LogicalType) { Ctype = PTGAsIs("int"); }
  if (type == CharacterType) { Ctype = PTGAsIs("char"); }
  if (type == IntegerType) {
    if (typelen == 8) {
      Ctype = PTGAsIs("long");
    } else if (typelen == 4) {
      Ctype = PTGAsIs("int");
    } else {
      if (GetClpValue(Integer8,0) == TRUE)
        Ctype = PTGAsIs("long");
      else
        Ctype = PTGAsIs("int");
    }
  }
  if (type == RealType) {
    if (typelen == 8) {
      Ctype = PTGAsIs("double");
    } else if (typelen == 4) {
      Ctype = PTGAsIs("float");
    } else {
      if (GetClpValue(Real8,0) == TRUE) {
        Ctype = PTGAsIs("double");
      } else {
        Ctype = PTGAsIs("float");
      }
    }
  }
  return(Ctype);
}

/* Routine to convert types to M4 types - these are used for generating **
** subroutine or function interfaces.                                   */

PTGNode Convert_to_M4type(int typelen, DefTableKey type) {
  PTGNode Ctype;

  Ctype = PTGAsIs("F2C-ACC: Type not recognized.");

  if (type == LogicalType) { Ctype = PTGAsIs("FortranInt"); }
  if (type == CharacterType) { Ctype = PTGAsIs("char"); }
  if (type == IntegerType) {
    if (typelen == 8) {
      Ctype = PTGAsIs("FortranLong");
    } else if (typelen == 4) {
      Ctype = PTGAsIs("FortranInt");
    } else {
      if (GetClpValue(Integer8,0) == TRUE)
        Ctype = PTGAsIs("long");
      else
        Ctype = PTGAsIs("FortranInt");
    }
  }
  if (type == RealType) {
    if (typelen == 8) {
      Ctype = PTGAsIs("FortranDouble");
    } else if (typelen == 4) {
      Ctype = PTGAsIs("FortranReal");
    } else {
      if (GetClpValue(Real8,0) == TRUE) {
        Ctype = PTGAsIs("FortranDouble");
      } else {
        Ctype = PTGAsIs("FortranReal");
      }
    }
  }
  return(Ctype);
}

/* This function is used to support declaring and copying data between  **
** CPU and GPU via the cudaMalloc and cudaMemcpy calls.  specifically,  **
** this routine determines the size of each variable so it can be       **
** inserted into the size field of the above cuda calls. In the event   **
** an upper or lower bound of an array is itself an array,  the given   **
** array will also be declared.                                         */

PTGNode ComputeArraySize(int regionType, int declLine, DefTableKey unitKey, DefTableKey objectKey, POSITION *coord) {

  int i;
  PTGNode arraySize=PTGAsIs("1");
  BoundsList arrayList = GetArraySizeList(objectKey,NULLBoundsList);
  int length = GetNumberOfDims(unitKey,0);

        /* generate array bounds if they are themselves arrays */
// Used for SMS declarations: no longer required.
//  generateArrayBounds(arrayList,declLine,regionType,coord);

        /* determine the size of the array by multiplying the   **
        ** value of each dimension.                             */
  if (length >= 1) {
    arraySize = PTGParens(ArrayBoundsPTG(arrayList,1,SIZE,0));
  }
  for (i=2; i<=length; i++) {
    arraySize = PTGMulSequence(arraySize,ArrayBoundsPTG(arrayList,i,SIZE,0));
  }
  return (arraySize);
}

/* In C and CUDA code generation, all arrays are collapsed into a       **
** single dimension via m4 macros of the form "FTNREF2D", "FTNREF3D",   **
** where the rank of the dimension is indicated by the number preceeding**
** the "D".  This routine assembles all of the information needed by    **
** the macro - specifically, the array indes, size, and lower bounds for**
** each dimension.                                                      **
** M4 macros cannot be nested (eg. FTNREF2D(i,j,k,FTNREF3D( ...)) ).    **
** To get around this restriction, and improve the efficiency of the    **
** code, a scalar variable is defined to replace the array reference.   **
** Therefore, if the bound of an array is itself an array, a variable is**
** defined and inserted into the macro definition.                      */

PTGNode FTNREFCPP(int sym,  RegionVars regionVars,int regionType,int declLine,DefTableKey unitKey, DefTableKey objectKey, PTGNode subscripts, POSITION *coord, GPUVarsList glist) {

 PTGNode GenerateArrayRef(GPUVars var,int gpuvar, DefTableKey objectKey,PTGNode subscripts,RegionVars regionVars,POSITION *coord,int sharedCopy);
  GPUVars InitGPUVars();

  GPUVars var,my_var;
  int i,gpuvar=FALSE;
  int length = GetNumberOfDims(unitKey,0);
  if (length == 0) { return(PTGAsIs("F2C-ACC ERROR: Array not defined")); }

  /* construct the m4 macro representing this array using the   **
  ** array indices, size and lower bounds for each dimension.   */

        // find the variable entry in ACC$REGION

  var = InitGPUVars();
  if (GetClpValue(Generate,CUDA) == CUDA) {
  for (i=1;i<=LengthGPUVarsList(glist); i++) {
    my_var = IthElemGPUVarsList(glist,i);
    if (my_var.sym == sym) {
      gpuvar = TRUE;
      var = my_var;
      if (my_var.scope == SHARED) { break; }
    }
  }}
  PTGNode arrayRef = GenerateArrayRef(var,gpuvar,objectKey,subscripts,regionVars,coord,FALSE);
  return(arrayRef);
}

/* Array dimensions are defined statically for GPU __shared__ memory. By        **
** convention, variable dimensions are converted to upper case to avoid name    **
** space conflicts with variables that may have been passed into the routine    **
** with the same name (eg. nx).  The uppercase array dimensions are added to    **
** the StringTable (MakeName), and the index is returned to the caller of this  **
** function.                                                                    */

int generateScalar(int ix,int mode) {
int i;
char scalar[MAX_STRLEN+1];
int n=0;
int arrayRef = FALSE;

  for (i=0; i<strlen(StringTable(ix)); i++) {
    if ((n>0) && (*(StringTable(ix)+i) == '(')) { arrayRef = TRUE; break; }
    if ((mode == LOCAL) || (mode == GPU)) {
      scalar[n++] = toupper(*(StringTable(ix)+i));
    } else {
      scalar[n++] = *(StringTable(ix)+i);
    }
  }
  if (((mode == LOCAL) || (mode == GPU)) && (arrayRef != TRUE)) {
    scalar[n] = '\0';
    return(MakeName(scalar));   
  } else {
    return(ix);
  }
}

PTGNode GenerateLoops(DefTableKey objectKey, DefTableKey unitKey, int dims, 
int maxRank, int indent, PTGNode label, PTGNode name, PTGNode expr, 
int line, int lastNonExecLine, POSITION *coord,RegionVars regionVars) {

  int i;
  PTGNode output=PTGNULL;
  PTGNode arrayRef;
  PTGNode indices=PTGNULL;

  BoundsList arrayList = GetArraySizeList(objectKey,NULLBoundsList);
   
  for (i=1; i<=dims; i++) {
    PTGNode loopVar = PTGSequence(PTGAsIs("ii_"),PTGNumber(i));
    if (i > 1) {
      indices = PTGCommaArgs(indices,loopVar);
    } else {
      indices = loopVar;
    }

    PTGNode lbound = ArrayBoundsPTG(arrayList,1,LBOUND,0);
    PTGNode ubound = ArrayBoundsPTG(arrayList,1,UBOUND,0);
 
    if (i==1) {
      output = PTGSequence(output, PTGLoopGen(PTGNULL,loopVar,
        lbound,loopVar,ubound,loopVar));
      output = PTGSequence(output,PTGBeginAppend(PTGNumber(line)));
    } else {
      output = PTGSequence(output, PTGLoopGen(PTGIndent(indent),loopVar,
        lbound,loopVar,ubound,loopVar));
    }
    indent = indent+SPACES;
  }

  arrayRef = PTGArrayRef(name, FTNREFCPP(0,regionVars,0,0,unitKey, objectKey, indices,coord,NULLGPUVarsList));
  output = PTGSequenceCR1(output,PTGAssignStmt1(PTGIndent(indent),arrayRef,expr));

  for (i=0; i<dims; i++) {
    indent = indent-SPACES;
    output = PTGSequence(output,PTGLoopGenEnd(PTGIndent(indent)));
  }
  output = PTGSequence(output,PTGEndAppend());

  return(output);
}

PTGNode GenerateLoopIndices(int dims) {
int i;
PTGNode indices=PTGNULL;

  for (i=1; i<=dims; i++) {
    PTGNode loopVar = PTGSequence(PTGAsIs("ii_"),PTGNumber(i));
    if (i > 1) {
      indices = PTGCommaArgs(indices,loopVar);
    } else {
      indices = loopVar;
    }
  }
  return(indices);
}

int SetRankDefineLoopVars(int dims, int maxRank, int lastNonExecLine, int indent, int line) {
  int i;

// printf("DEBUG: SetRankDefineLoopVars - line = %d maxRank = %d dims = %d\n",line,maxRank,dims);
  if (dims > maxRank) {
    for (i=maxRank; i<dims; i++) {
      PTGOut(PTGDeclareLoopVar(PTGNumber(lastNonExecLine),PTGIndent(indent),
        PTGNumber(i+1)));
    }
  }
  return(dims);
}

PTGNode GetArrayBounds(DefTableKey objectKey, int index, int dim) {
  BoundsList arrayList = GetArraySizeList(objectKey, NULLBoundsList);
  return(ArrayBoundsPTG(arrayList,index,dim,0));
}

PTGNode GetAllArrayBounds(int line,DefTableKey objectId, BoundsList arrayList,int sym) {

  PTGNode arraySize = PTGNULL;
  int length = LengthBoundsList(arrayList);
  int i;

  if (length >= 0) {
        /* declarations are permitted where the variable type is        **
        ** defined in one statement, and its dimension is defined in    **
        ** another.  In this situation, the array bounds have already   **
        ** been attached to the object via the ArraySizeList property.  */
    if (length == 0) {
      arrayList = GetArraySizeList(objectId,NULLBoundsList);
      length = LengthBoundsList(arrayList);
      if (length == 0) {        /* the entity was a scalar      */
        return(arraySize);
      } 
        /* otherwise, the entity was an array whose dimenson was        **
        **  set via a dimension statement                               */      
    }
    arraySize = PTGParens(ArrayBoundsPTG(arrayList,1,SIZE,0));

    for (i=2; i<=length; i++) {
      arraySize = PTGMulSequence(arraySize,ArrayBoundsPTG(arrayList,i,SIZE,0));
    }
  }
  return(arraySize);
}

PTGNode EndContinueLoops(int line, PTGNode label, int indentLevel, int labelCount,int nestLevel, DoAcc accDo) {
 
int i;
PTGNode output = PTGNULL;
PTGNode comment;

for(i=1; i<=labelCount; i++) {
  if(GetAccInfo(accDo,ACCDO,nestLevel-i+1,0) >= 1) {
    comment = PTGAsIs("//");
  } else {
    comment = PTGNULL;
  }

  indentLevel = indentLevel - 2;
  if (i == 1) {
  output = PTGReplace(PTGNumber(line),label,PTGNULL);
  }
  output = PTGSequence(output,PTGEndLoopAppend(PTGNumber(line),comment,PTGIndent(indentLevel)));

  if (GetAccInfo(accDo,ACCDO_OPT,nestLevel-i+1,0) >= 1) {
    output = PTGSequence(output,PTGIfThreadEnd(PTGNumber(line),PTGIndent(indentLevel)));
  }
}

return(output);
}

/* routine to generate allocation and deallocation calls for dynamic memory */

PTGNode GenerateAllocation(PTGNode var, DefTableKey unitKey, DefTableKey objectKey, int mode) {

PTGNode output = PTGNULL;

BoundsList arrayList = GetArraySizeList(objectKey,NULLBoundsList);
int length = LengthBoundsList(arrayList);
int i;
PTGNode arraySize;

int indentLevel = SPACES;
PTGNode PTGtype = PTGAsIs("float");
if (mode == ALLOCATE) {
  PTGtype = Convert_to_Ctype(GetTypeLength(unitKey,0),
        GetType(unitKey,ErrorType));
  if (length > 0) {
    arraySize = PTGParens(ArrayBoundsPTG(arrayList,1,SIZE,0));
    for (i=2; i<=length; i++) {
      arraySize = PTGMulSequence(arraySize,ArrayBoundsPTG(arrayList,i,SIZE,0));
    }
  } else {
    arraySize = PTGAsIs("1");
  }
  output = PTGMalloc(PTGIndent(indentLevel),PTGtype,var,PTGtype,arraySize,PTGtype);

  PTGNode testAlloc = PTGMallocTest(PTGIndent(indentLevel),var,
        PTGIndent(indentLevel),PTGIndent(indentLevel),PTGIndent(indentLevel));
  output = PTGSequence(output,testAlloc);
  ResetVariableAllocated(objectKey,TRUE);
}
if (mode == DEALLOCATE) {
  output = PTGFreeAlloc(PTGIndent(indentLevel),var);
}

  return(output);
}

/* GenerateArray defines dimensions needed for generating an                    **
** array declaration.  For C and CUDA routines, all arrays are allocated on     **
** the CPU.  Arrays that need to be allocated on the GPU are specified with     **
** the ACC$DATA and ACC$REGION directives.                                      **
**                                                                              **
** Arrays are allocated statically for GPU shared memory variables, and when    **
** local arrays are defined within a GPU kernel only routine.  In this case     **
** the dimensions of the arrays must be ginve at compile time.  By convention   **
** array dimensions are converted to UPPERCASE to avoid namespace conflicts     **
** with valid variables.  The actual values of the UPPERCASE variables are      **
** defined using the --Constant option to F2C-ACC.                              */

PTGNode GenerateArray(PTGNode var, BoundsList arrayList,DefTableKey objectKey, DefTableKey unitKey,int indent,int translationType,int demoteDim1, int demoteDim2,int promoteDim, int promoteType, RegionVars regionVars) {
  int i,j;
  PTGNode arraySize;
  PTGNode output = var;
  char name[80];

  int length = LengthBoundsList(arrayList);
  int len = length;

/*
  printf("DEBUG: var = ");
  PTGOut(var);
  printf("promote = %d %d\n",promoteDim,promoteType);
*/
  if ((length > 0) || (GetNumberOfDims(unitKey,0)> 0)) { /* it's an array */
    if (GetVariableDefined(objectKey,0) == MODULE) {
      return(PTGSequence(PTGAsIs("*"),var));
    } else {

        /* local arrays are dynamically allocated on the CPU */
      if ((translationType == CPU) || (translationType == FORTRAN)) {
        output = GenerateAllocation(var,unitKey,objectKey,ALLOCATE);
        return(output);
      }
        /* generate static variable declarations */
      if (length > 0) {
        for (i=1; i<=length; i++) {
          if ((demoteDim1 == i) || (demoteDim2 == i)) {
            arraySize = PTGAsIs("1");
            len--;
          } else {
            if (i == 1) {
              arraySize = PTGParens(ArrayBoundsPTG(arrayList,i,SIZE,GPU));
            } else {
              arraySize = PTGMulSequence(arraySize,ArrayBoundsPTG(arrayList,i,SIZE,GPU));
            }
          }
        }
        if (len > 0) {
          PTGNode threadPtg = PTGNULL;
          if ((promoteDim > 0) && (promoteType == THREAD)) {
            if (regionVars.threadOptionMode[0] == 0) {
              threadPtg = PTGString(StringTable(regionVars.regionV[0]));
            } else {
              threadPtg = PTGString(StringTable(regionVars.threadOption[promoteDim-1]));
            }
            arraySize = PTGMulSequence(arraySize,threadPtg);
          }
          if ((promoteDim > 0) && (promoteType == BLOCK)) {
                // capitalize the dimensions
            (void) strcpy(name,StringTable(regionVars.regionP[0]));
            for (j=0;j<strlen(name);j++) {
              *(name+j) = toupper(*(name+j));
            }
            *(name+j+1) = '\0';     
            int ix = MakeName(name);
              
            threadPtg = PTGString(StringTable(ix));
            arraySize = PTGMulSequence(arraySize,threadPtg);
          }
          output = PTGArrayRef(output,PTGBrackets(arraySize));
        }
      } else {
        fprintf(stderr,"FATAL ERROR: bounds value.  See developers\n");
        exit(1);
      }
    }
  }
  return(output);
}

PTGNode GenerateArrayRef(GPUVars gvar, int gpuvar, DefTableKey objectKey, PTGNode subscripts, RegionVars regionVars,POSITION *coord, int sharedCopy) {

int i,len;
PTGNode arrayRef=PTGNULL;
int addIt = FALSE;
 
  if (GetClpValue(Generate,CUDA) == ANALYSIS) { return(PTGNULL); }

  // get the number of dimensions in the array 
  BoundsList arrayList = GetArraySizeList(objectKey,NULLBoundsList);
  int length = LengthBoundsList(arrayList);

        // determine dimensionality after promotion/demotion
  len = length;
  if (sharedCopy != GLOBAL) {
    if ((GetClpValue(Generate,CUDA) == CUDA) && (gpuvar == TRUE)) {
      if ((gvar.scope == SHARED) || (gvar.scope == GLOBAL) || (gvar.scope == LOCAL)) {
        // add or subtract dimensions for demotion
        if (gvar.demoteDims[0] > 0) { len = length - 1; }
        if (gvar.demoteDims[1] > 0) { len = len - 1; }
        if (gvar.promoteDim > 0) { len = length + 1; }
      }
    }
  }

        // populate the macro with indices, size, and low bound arguments
  if (len > 0) {

    // populate the loop indices
    PTGNode output = PTGNULL;
    PTGNode dim;
    if (gvar.promoteDim == 1) { dim = PTGAsIs("x"); }
    if (gvar.promoteDim == 2) { dim = PTGAsIs("y"); }
    if ((gpuvar == TRUE) && (gvar.promoteDim > 0)) {
      if (regionVars.threadOptionMode[gvar.promoteDim-1] == CHUNK) {
        if (gvar.promoteVar != 0) { // variable specified 
          output = PTGString(StringTable(gvar.promoteVar));
        } else {
          output = PTGSequence(PTGAsIs("threadIdx."),dim);
        }
        subscripts = PTGCommaArgs(output,subscripts);
      } else if (regionVars.threadOptionMode[gvar.promoteDim-1] == BLOCKFACTOR) {
        Bounds bound = IthElemBoundsList(arrayList,gvar.promoteDim);
        PTGNode blower = PTGAsIs("1");
        if (bound.lower != 0) { blower = PTGString(StringTable(bound.lower)); }
        output = PTGBlockIndex0(
          dim,
          PTGNumber(regionVars.threadOption[gvar.promoteDim-1]),
          dim,dim,
          PTGNumber(regionVars.threadOption[gvar.promoteDim-1])
        );
        subscripts = PTGCommaArgs(subscripts,output);
      } else {
        if (gvar.promoteType == THREAD) {
          output = PTGSequence(PTGAsIs("threadIdx."),dim);
          subscripts = PTGCommaArgs(output,subscripts);
        } else {
          output = PTGSequence(PTGAsIs("blockIdx."),dim);
          subscripts = PTGCommaArgs(subscripts,output);
        }
      }
    }

  /* build the array reference portion of the macro     */
    arrayRef = 
      PTGFTNFunction(
        PTGNumber(len),
        subscripts
      );


        /* add the array dimensions, we don't need the last dimension */
    output = PTGNULL;
    int cnt=0;
    for (i=1; i<length; i++) {
      if (GetClpValue(Generate,CUDA) == CUDA) {
        if (sharedCopy == GLOBAL) {
          if (i == 1) {
            output = ArrayBoundsPTG(arrayList,i,SIZE,0);
          } else {
            output = PTGCommaArgs(output,ArrayBoundsPTG(arrayList,i,SIZE,0));
          }
        } else {        // standard array reference

          if ((gpuvar == TRUE) &&
              ((gvar.demoteDims[0] == i) || (gvar.demoteDims[1] == i)) ||
              ((i == length-1) && ((gvar.demoteDims[0] == length) || 
                (gvar.demoteDims[1] == length))) ) {
            // demoted dim or previous (if the last dim) is not output
          } else {
            cnt++;
            dim = ArrayBoundsPTG(arrayList,i,SIZE,0);
            if ((regionVars.threadOptionMode[0] == CHUNK) && 
                (gvar.scope==SHARED) && (i <= 2)) {
              if ((i == 1) && (GetSharedDim1(objectKey,0) > 0)) { 
                dim = PTGString(StringTable(GetSharedDim1(objectKey,0)));
              }
              if ((i == 2) && (GetSharedDim2(objectKey,0) > 0)) {
                dim = PTGString(StringTable(GetSharedDim2(objectKey,0)));
              }
            } else if ((regionVars.threadOptionMode[0] == BLOCKFACTOR) &&
                (gvar.scope == SHARED) && (i == 1)) {
              if (GetSharedDim1(objectKey,0) > 0) { 
                dim = PTGString(StringTable(GetSharedDim1(objectKey,0)));
              } else {
                dim = PTGMulSequence(
                  PTGNumber(regionVars.threadOption[0]),
                  ArrayBoundsPTG(arrayList,i,SIZE,0)
                );
              }
            } else {
                // use the default
            }
            if (cnt == 1) {
              output = dim;
            } else {
              output = PTGCommaArgs(output,dim);
            }
          }
        }
      } else {  // C generated output
        if (i == 1) {
          output = ArrayBoundsPTG(arrayList,i,SIZE,0);
        } else {
          output = PTGCommaArgs(output,ArrayBoundsPTG(arrayList,i,SIZE,0));
        }
      }
    }
        // compute bounds of the promoted dimensions 
        // TBD: add support for multiple promoted dimensions
    if ((gpuvar == TRUE) && (gvar.promoteDim > 0)) {
      if (regionVars.threadOptionMode[gvar.promoteDim-1] == CHUNK) {
        if (gvar.promoteType == THREAD) {
          dim = PTGString(StringTable(regionVars.regionV[gvar.promoteDim-1]));
        } else {
          dim = PTGString(StringTable(regionVars.regionP[gvar.promoteDim-1]));
        }
        if (length == 1) {
          output = dim;
        } else {
                // promoted dimension is first
          output = PTGCommaArgs(dim,output);
        }
      } else {
        dim = ArrayBoundsPTG(arrayList,length,SIZE,0);
        if (length == 1) {
          output = dim;
        } else {
                // promoted dimension is last
          output = PTGCommaArgs(output,dim);
        }
      }
    }
        // no bound is needed when a scalar is promoted (first dim is no required)
    if (len > 1) {
      arrayRef = PTGCommaArgs(arrayRef,output);
    }

/*
if (gvar.scope == SHARED) {
printf("GenerateArrayRef: var = %s subscripts = ",StringTable(gvar.sym));
PTGOut(arrayRef);
printf("\n");
}
*/
    /* all the lower bounds are needed  */
    addIt = FALSE;
    for (i=1; i<=length; i++) {
      Bounds bound = IthElemBoundsList(arrayList,i);
      if (GetClpValue(Generate,CUDA) == CUDA) {
        if ((gpuvar == TRUE) && (sharedCopy != GLOBAL) && 
            ((gvar.demoteDims[0] == i) || (gvar.demoteDims[1]==i))) {
        // skip the dimension
        } else {
          PTGNode lowerPtg = ArrayBoundsPTG(arrayList,i,LBOUND,0);
          if ((regionVars.threadOptionMode[0] == CHUNK) && (gvar.scope == SHARED)) {
            addIt = TRUE;
            if (i == 1) {
              if ((GetSharedDim1(objectKey,0) > 0) && (gvar.promoteDim == 0) && (gvar.demoteDims[0] == 0)) { 
                lowerPtg = PTGSequence(
                  PTGAsIs("blockIdx.x*blockDim.x+"),
                  ArrayBoundsPTG(arrayList,1,LBOUND,0)
                );
              }
            }
            if (i==1) {
              output = lowerPtg;
            } else {
              output = PTGCommaArgs(output,lowerPtg);
            }
          } else {
            if (bound.lower == 0) {
              lowerPtg = PTGAsIs("1");  // Fortran default
            }

            if (i == 1) {
              addIt = TRUE;
              output = lowerPtg;
              // threadIdx.x is used when blockfactor and shared memory are used
              if ((gvar.scope == SHARED) && ((sharedCopy == SHARED) || (regionVars.threadOptionMode[0] == BLOCKFACTOR))) {
                output = PTGAsIs("0");
              }
            } else {
              if (addIt == TRUE) {
                output = PTGCommaArgs(output,lowerPtg);
              } else {
                output = lowerPtg;
                addIt = TRUE;
              }
            }
          }
        }
      } else {
        if (i == 1) {
          output = ArrayBoundsPTG(arrayList,i,LBOUND,0);
        } else {
          output = PTGCommaArgs(output,ArrayBoundsPTG(arrayList,i,LBOUND,0));
        }
      }
/*
if ((strcmp(StringTable(gvar.sym),"thcol") == 0)) {
  printf("DEBUG: i = %d gvar.sym = %s demote = %d %d arrayRef = ",i,StringTable(gvar.sym),gvar.demoteDim,gvar.demoteDims[1]);
  PTGOut(arrayRef);
  printf(" output = ");
  PTGOut(output);
  printf("\n");
}
*/
    }
        // add the lower bound for the promote dimension
    if ((gpuvar == TRUE) && (gvar.promoteDim > 0)) {
      if (regionVars.threadOptionMode[gvar.promoteDim-1] == CHUNK) {
        if (gvar.promoteVar > 0) {
          output = PTGCommaArgs(PTGString(StringTable(gvar.promoteLB)),output);
        } else {
          output = PTGCommaArgs(PTGAsIs("0"),output);
        }
      } else {
        output = PTGCommaArgs(output,PTGAsIs("0"));
      }
    }
    // add the lower bounds for each dimension of the array
    arrayRef = PTGCommaArgs(arrayRef,output);
    arrayRef=PTGSequence(arrayRef,PTGAsIs(")"));

    // add the array brackets
    arrayRef = PTGBrackets(arrayRef);
  }
  return(arrayRef);
}

/* intrinsic support:
! F2C-ACC supports a limited number of intrinsics, either via a direct mapping
! between Fortran and C functions, or by referencing macros such as max and min
! that appear in the included file "ftocmacros.m4".  in the even a macro is used
! generated output will CAPITALIZE the function name (eg "max" becomes "MAX").
*/

#define KIND 2

typedef struct {
  char *FTNname;        /* Fortran intrinsic name */
  char *Cname;          /* C function name or macro */
  int nArgs;
} IntrinsicTable;

/* in the event, there is no mapping to an equivalent C function, an    **
** error message will be generated                                      */

#define MAX_INTRINSICS 31
IntrinsicTable intrinsics[] = {
  "abs","abs",1,
  "acos","acosf",1,
  "amax0","MAX",2,
  "amax1","MAX",2,
  "amin0","MIN",2,
  "amin1","MIN",2,
  "asin","asinf",1,
  "atan","atanf",1,
  "ccos","ccosf",1,
  "cos","cosf",1,
  "csin","csinf",1,
  "dble","(double)",1,
  "exp","expf",1,
  "float","(float)",1,
  "int","(int)",1,
  "log","logf",1,
  "long","(long)",1,
  "max","MAX",2,
  "max0","MAX",2,
  "max1","MAX",2,
  "min","MIN",2,
  "min0","MIN",2,
  "min1","MIN",2,
  "pow","powf",2,
  "short","(short)",1,
  "sign","SIGN",2,
  "sin","sinf",1,
  "size","",2,
  "sngl","(float)",1,
  "sqrt","sqrtf",1,
  "tan","tanf",1
};

/* returns TRUE if the string and number of arguments to the function match **
** returns KIND if the string matches this special case                     **
** returns MODULO if the string represents the Fortran "mod" function       **
** returns FALSE otherwise                                                  */
int isIntrinsic(char *name, int nArgs) {

  int i;
//printf("DEBUG: intrinsics check: var = %s nArgs = %d\n",name,nArgs);
  for (i=0; i<MAX_INTRINSICS; i++) {
    if (strcmp(name,intrinsics[i].FTNname) == 0) {
      if (intrinsics[i].nArgs == nArgs) { 
        return(TRUE); 
      }

  /* Fortran supports any number of arguments for max and min functions */
      if (((strcmp("max",intrinsics[i].FTNname) == 0) || 
           (strcmp("max0",intrinsics[i].FTNname) == 0) ||
           (strcmp("amax0",intrinsics[i].FTNname) == 0) ||
           (strcmp("max1",intrinsics[i].FTNname) == 0) ||
           (strcmp("amax1",intrinsics[i].FTNname) == 0) ||
           (strcmp("min",intrinsics[i].FTNname) == 0) ||
           (strcmp("min0",intrinsics[i].FTNname) == 0) ||
           (strcmp("amin0",intrinsics[i].FTNname) == 0) ||
           (strcmp("min1",intrinsics[i].FTNname) == 0) ||
           (strcmp("amin1",intrinsics[i].FTNname) == 0)) &&
           (nArgs > 2)) {
        return(TRUE);
      }
    }
  }
  if ((strcmp("kind",name)==0) && (nArgs == 1)) { return(KIND); }
  if ((strcmp("mod",name)==0) && (nArgs == 2)) { return(MODULO); }
  return(FALSE);
}

char *getIntrinsicName(char *name, int nArgs, POSITION *COORDREF) {

int i;
for (i=0; i<MAX_INTRINSICS; i++) {
  if (strcmp(name,intrinsics[i].FTNname) == 0) {
    if ((intrinsics[i].nArgs == nArgs)) {
      if (strlen(intrinsics[i].Cname)==0) {
        message(ERROR,"Fortran intrinsic not supported.",0,COORDREF);
      }
      return(intrinsics[i].Cname);
    } else {
      /* Fortran supports any number of arguments for max and min functions */
      if (((strcmp("max",name) == 0) || (strcmp("max0",name) == 0) ||
          (strcmp("amax0",name) == 0) || (strcmp("max1",name) == 0) ||
          (strcmp("amax1",name) == 0) || (strcmp("min",name) == 0) ||
          (strcmp("min0",name) == 0) || (strcmp("amin0",name) == 0) ||
          (strcmp("min1",name) == 0) || (strcmp("amin1",name) == 0)) &&
          (nArgs > 2)) {
        return(intrinsics[i].Cname);
      }
    }
  }
}
return(name);
}

PTGNode ConstantHandling(char *name,int type) {

int i;
PTGNode value=PTGNULL;
for (i=0; i<strlen(name); i++) {
        /* double type promotion */
  if (*(name+i) == 'd') {
    *(name+i) = 'e'; /* terminate string */
  }
} 
  if (type == REAL) {
    value = PTGSequence(PTGString(name),PTGAsIs("F"));
  } 
  if (type == DOUBLE) {
    value = PTGString(name);
  }
  if (type == LONG) {
    value = PTGSequence(PTGString(name),PTGAsIs("l"));
  }
  if (type == INT) {
    value = PTGString(name);
  }
  if (type == SHORT) {
    value = PTGString(name);
  }

return(value);
}

int Convert_to_int(char *name) {
  int value;
  (void) sscanf(name,"%d\n",&value);
//  printf("Convert_to_int: var: %s int: %d\n",name,value);
  return(value);
}

/* Routine to construct loop indices where the thread or block is used.  There
** are three modes:
**      PARALLEL        construct a do loop index with the blockId
**      THREAD          construct a do loop index with the threadId
**      SHARED          SHARED variable access, outside of the VECTOR do-loop
*/

PTGNode ConstructLoopIndex(PTGNode doIndex, PTGNode threadStart, int mode, RegionVars regionVars, int dim, int doloop) {
PTGNode output=PTGNULL;
char str[501];
int i,j,k;
PTGNode blockIndex;

  if (doloop == TRUE) {
    if (regionVars.threadOption[dim-1] >= 1) {
      blockIndex=PTGAsIs("x");
      if (regionVars.threadOption[dim-1] == 1) { blockIndex=PTGAsIs("x"); }
      if (regionVars.threadOption[dim-1] == 2) { blockIndex=PTGAsIs("y"); }
      if (regionVars.threadOption[dim-1] == 3) { blockIndex=PTGAsIs("z"); }
    }
        
        // handling of do-loop indexing
    if (mode == PARALLEL) {
      if (regionVars.threadOptionMode[dim-1] == FALSE) {
        output = PTGBlockIndexDef(doIndex,threadStart);
      } else if (regionVars.threadOptionMode[dim-1] == CHUNK) {
  // printf("DEBUG: regionVars dim = %d threadOption = %d\n",dim,regionVars.threadOption[dim-1]);
        output = PTGBlockThread(blockIndex,blockIndex,doIndex,threadStart);
      } else {
        output = PTGBlockIndex(
          doIndex,
          PTGNumber(regionVars.threadOption[dim-1]),
          doIndex,
          doIndex,
          PTGNumber(regionVars.threadOption[dim-1]),
          threadStart
        );
      }
    }
        // handling of do-loop indexing
    if (mode == VECTOR) {
//   printf("DEBUG: regionVars dim = %d threadOption = %d\n",dim,regionVars.threadOption[dim-1]);
      // if ((regionVars.threadOptionMode[dim-1] == BLOCKFACTOR) 
      if (regionVars.threadOption[dim-1] == FALSE) {
        output = PTGThreadIndexDef(doIndex,threadStart);
      } else if (regionVars.threadOptionMode[dim-1] == CHUNK) {
        output = PTGBlockThread(blockIndex,blockIndex,doIndex,threadStart);
      } else {
        output = PTGThreadIndex(
          doIndex,
          doIndex,
          PTGNumber(regionVars.threadOption[dim-1]),
          threadStart
        );
      }
    } 
  } else {      // array index calculation
    if (mode == SHARED) {
      output = PTGSharedBlock(
        PTGString(StringTable(regionVars.regionV[0])),
        PTGString(StringTable(regionVars.regionV[0])),
        doIndex     
      );
    }
  }
  return(output);
}


int UserConstants(DefTableKey objectkey, int sym) {

 char name[50];
 int i,j,k;
 int ilen = strlen(StringTable(GetClpValue(Constants,0)));
 if (ilen == 0) { return(FALSE); } 
 
 char *constants = (char *) malloc(ilen*sizeof(char));
 if (constants == NULL) {
    printf("ERROR: Memory allocation error in UserConstants.\n");
    exit(1);
  }
  (void) strcpy(constants,StringTable(GetClpValue(Constants,0)));

// printf("DEBUG: UserConstants: var = %s constants=%s\n",StringTable(sym),constants);

/* determine if the constant has been defined by the user               **
** the input "constants" supports multiple user defined constants       **
** Each variable-constant pair is comma separated, and each variable is **
** separated from its constant value with an '='.                       **
** Eg.  NX=96,NY=32                                                     */

for (i=0;i<ilen;i++) {
  k = 0;
  while ((i+k < ilen) && (*(constants+i+k)!= ',')) {
    *(name+k) = tolower(*(constants+i+k));
    if (*(name+k) == '=') {
      *(name+k) = '\0'; // terminate the string and compare
      if ((strlen(name)==strlen(StringTable(sym))) && (strcmp(name,StringTable(sym)) == 0)) {

        // see if the constant has already been declared
        if (GetConstantDeclared(objectkey,FALSE) == FALSE) {
          // convert the name to upper case
          for (j=0;j<strlen(name);j++) {
            *(name+j) = toupper(*(name+j));
          }
          *(name+(k++)) = ' ';  // replace the '=' with a space separator
                // process the constant value
          while ((i+k < ilen) && (*(constants+i+k)!= ',')) {
            (*(name+k)) = toupper(*(constants+i+k));
            k++;
          }
          *(name+k) = '\0';     // terminate the expression (variable + value)

          printf("begin_append 0\n");
          printf("#define %s\n",name);
          printf("end_append\n");
          ResetConstantDeclared(objectkey,TRUE);
        }
        return(TRUE);
      }
    }
    k++;
  }
  i += k;       // index to the next grouping
}

return(FALSE);
}


int isModule(int line) {

  int i;
  char filename[MAX_STRLEN+1];
  char *file;

  for (i=0; i< Num_ModuleFiles; i++) {
    strcpy(filename,Module_File[i].UseModuleRef);
    if (strcmp(MapFile(line),filename) == 0) {
      return(Module_File[i].Line);
    }
  }
  return(FALSE);
}


void SetVariableUse(DefTableKey objectKey, int region, int update, int type,
  int sym, int line, int stmtNumber) {

  int value;
  int valueRoutine;

        /* get the value        */
  if (type == GPU) {
    value = GetVariableGPU(objectKey,FALSE);
  } else {
    value = GetVariableCPU(objectKey,FALSE);
  }
  valueRoutine = value;

  if (region != value%REGION) {
     value = 0;         /* reset the value */
  }

        /* update it with the new region number */
  if (value < READ) {   // first access for this GPU/CPU region
    value = region;
    ResetVariableStmt(objectKey,stmtNumber);
  } else if (value < WRITE) {
    value = READ + region;
  } else if (value < READWRITE) {
    value = WRITE + region;
  } else {
    value = READWRITE + region;
  }

  if (valueRoutine < READ) {                    // no status
    if (update == FALSE) { valueRoutine += READ;  }     // READ status
    if (update == TRUE ) { valueRoutine += WRITE; }     // WRITE status
    if (update == UNKNOWN ) { valueRoutine += READWRITE; }
  } else if (valueRoutine < WRITE) {            // read only status
    if (update == TRUE ) { valueRoutine += 2000; }      // READWRITE status
    if (update == UNKNOWN ) { valueRoutine += 2000; }   // READWRITE status
  } else if (valueRoutine < READWRITE) {        // write only status
    if (update == FALSE) { valueRoutine += 1000; }
    if (update == UNKNOWN) { valueRoutine += 1000; }
  } else {      // variable has been read and written in this routine
  }
// printf("DEBUG: line = %d variable = %s valueRoutine = %d region = %d update = %d\n",line,StringTable(sym),valueRoutine,region,update);

  if (value < READ) {                   // no status
    if (update == FALSE) { value += READ;  }    // READ status
    if (update == TRUE ) { value += WRITE; }    // WRITE status
    if (update == UNKNOWN) { value += READWRITE; }      // WRITE status
  } else if (value < WRITE) {           // read only status
    if (update == TRUE ) { value += 2000; }     // READWRITE status
    if (update == UNKNOWN) { value += 2000; }   // READWRITE status
  } else if (value < READWRITE) {       // write only status
        /* if the value was written first, all successive reads will be
        ** using the value written, unless it was the same statement number */
    if ((update == FALSE) && (GetVariableStmt(objectKey,0) == stmtNumber)) { 
        value = value % WRITE + READ;   /* first access was a read */
    }
  } else {      // variable has been read and written in this routine
  }
        /* set the appropriate property */
  if (update == RESET) {
    value = 0;
    ResetVariableGPU(objectKey,value);  // to appear like there was no accesses 
  }
  if (GetVariableConstant(objectKey,FALSE) >= TRUE)  {
    ResetVariableGPU(objectKey,value);
    ResetVariableCPU(objectKey,value);
  } else {
    if (type == GPU) {
      ResetVariableGPU(objectKey,value);
    } else {
      ResetVariableCPU(objectKey,value);
    }
  }
  ResetVariableRoutine(objectKey,valueRoutine);

  if (GetClpValue(WarnLevel,0) == DEBUG) {
    printf("%d SetVariableUse: %s VariableRoutine: %d update = %d value: %d device: %d getVariableDefined: %d stmt: %d constant: %d\n",line,StringTable(sym),valueRoutine,update,value,type,GetVariableDefined(objectKey,0),stmtNumber,GetVariableConstant(objectKey,0));
  }
  return;
}

/* Routine to retrieve variable usage   */
int GetVariableUse(DefTableKey objectKey, int type, int mode,int sym,int region,int line, int stmtNumber) {

  int value;
  int valueRoutine;
  int returnVal = FALSE;
  int intent;

  if (type == GPU) {
    value = GetVariableGPU(objectKey,FALSE);
  } else if (type == CPU) {
    value = GetVariableCPU(objectKey,FALSE);
    if (GetVariableRoutine(objectKey,FALSE) == FALSE) {
      intent = GetIntent(objectKey,FALSE); 
      if ((intent == IN) || (intent == INOUT)) {
        value = WRITE+1;
// printf("DEBUG intent: %d GetVariable: %s type: %d value = %d region: %d %d stmt: %d %d\n",intent,StringTable(sym),type,value,region,value%REGION,GetVariableStmt(objectKey,0),stmtNumber);
      }
    }
  } else {
    valueRoutine = GetVariableRoutine(objectKey,FALSE);
  }

        /* obtains the routine READ or WRITE status for the variable */
  if (type == ROUTINE) {
    if (mode == READ) {
      if ((valueRoutine >= READ) && (valueRoutine < WRITE) || (valueRoutine >= READWRITE)) { 
        returnVal = TRUE;
      }
    }
    if (mode == WRITE) {
      if (valueRoutine >= WRITE) {
        returnVal = TRUE;
      }
    }
  }

  if (value%REGION != region) { value = 0; }
// printf("DEBUG: GetVariable: %s type: %d value = %d region: %d %d stmt: %d %d\n",StringTable(sym),type,value,region,value%REGION,GetVariableStmt(objectKey,0),stmtNumber);

  if (mode == READ) {
    if (((value >= READ) && (value < WRITE)) || (value >= READWRITE)) { 
      returnVal = TRUE; /* variable has already been read */
    }
  } else if (mode == WRITE) {
    if (value >= WRITE) {
      returnVal = TRUE; // variable has been written
    }
  } else if (mode == REGION) {
        // variable has been accessed, 
        // and is not being read in the first statement
    if ((value > 0) && (stmtNumber != GetVariableStmt(objectKey,0))) {
      returnVal = TRUE;
    }
  } else {
    printf("FATAL: unknown value for GetVariableUse access mode\n");
    exit(1);
  }

  if (GetClpValue(WarnLevel,0) == DEBUG) {
    if (type == ROUTINE) {
      printf("%d Variable Use: %s mode: %d valueRoutine: %d returnVal: %d\n",line,StringTable(sym),mode,valueRoutine,returnVal);
    } else {
      printf("%d Variable Use: %s mode: %d value %d chip: %d returnVal: %d\n",line,StringTable(sym),mode,value,type,returnVal);
    }
  }
  return(returnVal);  
}


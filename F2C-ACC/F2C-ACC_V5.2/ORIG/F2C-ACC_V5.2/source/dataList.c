
#include "deftbl.h"     /* eli definition table                 */
#include "csm.h"        /* string table module                  */
#include "clp.h"        /* command line arguments               */
#include "pdl_gen.h"    /* pdl properties                       */
#include "C-output.h"   /* contains Convert_to_Ctype function   */
#include "GPU_DirectiveDefs.h"

#include "ProgDeclsList.h"      // program declarations
#include "GPUVarsList.h"        // ACC$REGION data arguments
#include "VariableUseList.h"    // variable usage
#include "Bounds.h"

ProgDecls dvar;
ProgDecls PkgProgDecls(int sym,DefTableKey objectKey,DefTableKey unitKey,int type) {
// printf("DEBUG: PkgProgDecls var = %s type = %d\n",StringTable(sym),type);
  dvar.sym = sym;
  dvar.objectKey = objectKey;
  dvar.unitKey = unitKey;
  dvar.type = type;
  return(dvar);
}

VariableUse rvar;
VariableUse PkgVariableUse(int sym, int stmtNumber, DefTableKey objectKey, DefTableKey unitKey,POSITION *coord,int accRegionLine,int accRegionNumber, int cpuRegionNumber, int update,int line) {

//  fprintf(stderr,"VariableUse - adding var: %s %d regionNumber: %d update = %d constant: %d variableDeclared: %d\n",StringTable(sym),coord->line,accRegionNumber,update,GetVariableConstant(objectKey,0),GetVariableDefined(objectKey,0));
  rvar.sym = sym;
  rvar.stmtNumber = stmtNumber;
  rvar.objectKey = objectKey;
  rvar.unitKey = unitKey;
  rvar.line = coord->line;
  rvar.col = coord->col;
  rvar.accRegionLine = accRegionLine;
  rvar.accRegionNumber = accRegionNumber;
  rvar.cpuRegionNumber = cpuRegionNumber;
  rvar.update = update;
  rvar.line = line;
  return(rvar);
}

GPUVars var;
GPUVars InitGPUVars();
GPUVars InitGPUVars() {
  var.sym = 0;
  var.gsym = 0;
  var.objectKey = NoKey;
  var.unitKey = NoKey;
  var.intent = 0;
  var.scope = 0;
  var.optexpr = 0;
  var.condexpr = PTGNULL;
  var.actualexpr = 0;
  var.regionNumber = 0;
  var.sharedDim1 = 0;
  var.sharedDim2 = 0;
  var.demoteDim = 0;
  var.demoteDims[0] = 0;
  var.demoteDims[1] = 0;
  var.promoteDim = 0;
  var.promoteType = 0;
  var.promoteDims[0] = 0;
  var.promoteDims[1] = 0;
  return(var);
}
GPUVars PkgGPUVars(POSITION *coord,int sym, int gsym, DefTableKey objectKey, DefTableKey gobjectKey, DefTableKey unitKey, int intent, int scope, int optexpr, PTGNode condexpr,int actualexpr,int regionNumber, int sharedDim1, int sharedDim2, int demoteDim, Mote demote, int promoteDim, int promoteType, Mote promote,int promoteVar, int promoteLB, int device, int directiveType) {

// printf("Adding variable: %s demote: %d %d\n",StringTable(sym),demoteDim,demote.dims[0]);
  var.sym = sym;
  var.gsym = gsym;
  var.objectKey = objectKey;
  var.gobjectKey = gobjectKey;
  var.unitKey = unitKey;
  var.intent = intent;
  if (scope != SHARED) {
    if ((GetVariableScopeGPU(objectKey,0) != 0) && 
        (GetVariableScopeGPU(objectKey,0) != scope)) {
      message(ERROR,"GPU scope cannot be changed within a subroutine.",0,coord);
    } else {
      ResetVariableScopeGPU(objectKey,scope);
    }
  }
  if ((intent == OUT) || (intent == INOUT)) {
    ResetVariableIntentGPU(objectKey,intent);
  }

    // special case in SMS_GetPointer to do a table lookup of the GPU memory location
  if ((directiveType == ACCROUTINE) && (scope == EXTERN)) { scope = EXTERN_ROUTINE; }

  var.scope = scope;
  var.optexpr = optexpr;
  var.condexpr = condexpr;
  var.actualexpr = actualexpr;
  var.regionNumber = regionNumber;
  var.sharedDim1 = sharedDim1;
  var.sharedDim2 = sharedDim2;
  var.demoteDim = demoteDim;
  var.demoteDims[0] = demote.dims[0];
  var.demoteDims[1] = demote.dims[1];
  var.promoteDim = promoteDim;
  var.promoteType = promoteType;
  var.promoteDims[0] = promote.dims[0];
  var.promoteDims[1] = promote.dims[1];
  var.promoteVar = promoteVar;
  var.promoteLB = promoteLB;
//printf("var: %s dim: %d %d %d\n",StringTable(var.sym),var.promoteDim,var.promoteDims[0],var.promoteDims[1]);

if (sharedDim1 > 0) {
  ResetSharedDim1(objectKey,sharedDim1);
  ResetSharedDim2(objectKey,sharedDim2);
}
if ((promoteDim > 0) || (promote.dims[0] > 0)) {
  ResetVariablePromotedGPU(objectKey,promoteDim);
}
  var.device = device;
  return(var);
}

/*
Function to retrieve information about a specific element.  Currently this
function returns SCOPE, INTENT, and if an entry EXISTS in the list.  All
queries identifies the correct element uing the variables symbol table entry
or "sym" attribute.
*/
int GetGPUVarProperty(int sym, GPUVarsList list, int type, int localIndex) {

  int len = LengthGPUVarsList(list);
if (type == DEMOTEDIM) {
//  printf("DEBUG GetGPUVarProperty: len = %d var = %s type = %d\n",len,StringTable(sym),type);
}
  int j;
  for (j=1;j<=len;j++) {
    var = IthElemGPUVarsList(list,j);
 //printf("DEBUG: var = %s scope = %d localIndex = %d dims: %d %d\n",StringTable(var.sym),var.scope,localIndex,var.demoteDims[0],var.demoteDims[1]);
    if (var.sym == sym) {
      if (type == INTENT) { return(var.intent); }
      if (type == SCOPE)  {
        if (var.scope == SHARED) { return(var.scope); }
        if (var.scope == LOCAL ) { return(var.scope); }
        if (var.scope == EXTERN) { return(var.scope); }
        if (var.scope == EXTERN_ROUTINE) { return(var.scope); }
      }
      if (type == EXISTS) { return(TRUE); }
      if (type == DEMOTEDIM) { 
        if ((localIndex == var.demoteDims[0]) || (localIndex == var.demoteDims[1])) {
//      printf("var = %s localIndex = %d dims: %d %d\n",StringTable(var.sym),localIndex,var.demoteDims[0],var.demoteDims[1]);
          return(TRUE); 
        }
      }

// test prior to replacing promoteDim with the two dimensional counterpart
if (var.promoteDim != var.promoteDims[0]) {
  fprintf(stderr,"1 - PromoteDim inconsistency.  Exit");
  exit(1);
}
      if (type == PROMOTED) { return(var.promoteDim); }
      if (type == PROMOTE_TYPE) { return(var.promoteType); }
    }
  }
// if (type == DEMOTEDIM) {
// printf("FALSE var = %s localIndex = %d dims: %d %d\n",StringTable(var.sym),localIndex,var.demoteDims[0],var.demoteDims[1]);
// }
  return(FALSE);
}
  
// Routine to add declaratives on to the GPU list.
GPUVarsList AddLocalVars(ProgDeclsList llist, GPUVarsList list,int region) {
  int dlen = LengthProgDeclsList(llist);
  int len = LengthGPUVarsList(list);
  int i,j;
  int found;
  int foundShared;

  for (i=1; i<=dlen; i++) {
    dvar = IthElemProgDeclsList(llist,i);
//printf("DEBUG: AddLocalVar: local var = %s region: %d\n",StringTable(dvar.sym),region);
    if (dvar.type != CONSTANT) {

        /* search for an entry in the GPU list */
      found = FALSE;
      foundShared = FALSE;
      if (len > 0) {
        for (j=1;j<=len;j++) {
          var = IthElemGPUVarsList(list,j);
          if (var.sym == dvar.sym) { 
            found = TRUE;
            if (var.scope == SHARED) { foundShared = TRUE; }
//      printf("DEBUG: AddLocalVar Found var: %s len = %d\n",StringTable(dvar.sym),len);
          }
        }
      }
      if (found == TRUE) {
        if ((GetNumberOfDims(dvar.objectKey,0) > 0) && (foundShared == FALSE) &&
            (GetVariableSharedGPU(dvar.objectKey,0) == SHARED)) {
          fprintf(stderr,"NOTE: %s is using GLOBAL memory in ACC$REGION %d. SHARED memory could be used.\n",StringTable(dvar.sym),region);
        }
      } else {
        var.sym = dvar.sym;
        var.gsym = 0;
        var.objectKey = dvar.objectKey;
        var.unitKey = dvar.unitKey;
        var.intent = NONE;      /* default intent for local vars */
        var.scope = GetVariableScopeGPU(var.objectKey,GLOBAL);
        var.optexpr = FALSE;
        var.condexpr = PTGNULL;
        var.actualexpr = 0;
        var.regionNumber = 0;
        var.promoteDim = 0;
        var.promoteDims[0] = 0;
        var.promoteDims[1] = 0;
//      printf("DEBUG: AddLocalVar adding local var: %s len = %d dlen = %d var.scope = %d\n",StringTable(dvar.sym),len,dlen,var.scope);
        list = AppElGPUVarsList(list,var);
      }
    }
  }
  return (list);
}


#define DATA_MOVEMENT   10
#define DATA_MOVEMENT_VERBOSE   11
#define VARIABLE_USE    20
#define GLOBAL_MEMORY 30
#define MIN_NUM_ACCESSES 4
#define MAX_STRLEN 100

/* 
Routine that determines all arguments needed to pass between GPU and CPU
based on how they are used in the region.  This routine only processes
argments for a single ACC$REGION.  Processing is done when the end of the
region is encountered (!ACC$REGION END).
*/
void VariableAnalysis(int accRegionLine, GPUVarsList list,VariableUseList rlist, ProgDeclsList llist, int regionNumber,POSITION *coord, int routineName,int kernelsInFile,int translationType,RegionVars regionVars, PTGNode dataSectionPtg) {

  int i,j,k;
  int found = FALSE;            // is the variable listed in the ACC$REGION?
  int occCnt=0;                 // how many times has the variable been used?
  int intent;                   // calculated intent value
  char cintent[20],mintent[20]; // calculated and user specified intent string
  int iArgs=0,ioArgs=0,oArgs=0,nArgs=0,eArgs=0; // # of calculated data entries
  char inString[1000],inoutString[1000],outString[1000]; // string of variables
  char noneString[1000],externString[1000];
  int arrayDims[500],nDims=0,arrayDecl[500];

  int rlen = 0;                                   // # of variable use entries
  VariableUse my_var,nextVar,prevVar,lastUpdate;  // variable use structure
  int processedVars[MAX_TABLE_SIZE];              // list of variables processed
  int kernelNumber[MAX_KERNELS];                 // kernel where access occurred

  /* NVIDIA current restricts the number of arguments passed to a GPU   **
  ** kernel to a maximum of 4096 bytes.  If we exceed the limit, pass   **
  ** the struct containing all scalars with intent (IN) via a cudaMemcpy**
  ** rather than a direct copy.                                         */
  int argStorage = 0;
  int length = LengthGPUVarsList(list);
  for (i=1; i<=length; i++) {
    var = IthElemGPUVarsList(list,i);
    if (var.scope != SHARED) {
      if ((GetNumberOfDims(var.unitKey,0) > 0) && 
      ((var.intent == OUT) || (var.intent == INOUT))) {
        argStorage += 8;        // memory address
      } else {
        argStorage += 4;        // 4 byte real or float
      }
    }
  }


  kernelNumber[regionNumber-1] = accRegionLine; // equates a kernel to a line
  if ((GetClpValue(Analysis,0) == DATA_MOVEMENT) ||
      (GetClpValue(Analysis,0) == DATA_MOVEMENT_VERBOSE)) { 
    if (GetClpValue(Analysis,0) == DATA_MOVEMENT_VERBOSE) {
      fprintf(stderr,"\nF2C-ACC Analysis of the file: %s   DATA_MOVEMENT\n\n",StringTable(GetClpValue(FileName, 0)));
    }

    // initialize variables ...
    for (i=0;i<MAX_TABLE_SIZE;i++) {
      processedVars[i] = -1;
    }
    strcpy(noneString,"\n");
    strcpy(inString,"\n");
    strcpy(inoutString,"\n");
    strcpy(outString,"\n");

    if (GetClpValue(Analysis,0) == DATA_MOVEMENT_VERBOSE) {
      fprintf(stderr,"F2C-ACC Analysis of Routine: %s ACC$REGION %02d Line: %d\n",StringTable(routineName),regionNumber,accRegionLine);
    }

    // process the list containing all variables in the program and verify the
    // arrays are listed in the ACC$REGION data section

    int update;
    lastUpdate.accRegionLine = FALSE;   // region line of last update
    rlen = LengthVariableUseList(rlist);
    for (i=1;i<=rlen;i++) {
      rvar = IthElemVariableUseList(rlist,i);
// printf("DEBUG: VariableUseList var = %s update = %d region: %d line: %d variableDeclared: %d\n",StringTable(rvar.sym),rvar.update,rvar.accRegionNumber,rvar.line,GetVariableDefined(rvar.objectKey,0));

        // a lookup table is used to store each variable processed by is entry into the symbol table
        // verify storage is available
      if (rvar.sym > MAX_TABLE_SIZE) { 
        fprintf(stderr,"Fatal Error: F2C-ACC exceeded the symbol storage of 5000 variables. Exiting ...\n");
        exit(1);
      }
        // analyze each variable contained within the given ACC$REGION by line number: accRegionLine

      if ((accRegionLine > 0) && (rvar.accRegionLine == accRegionLine) && (processedVars[rvar.sym] != accRegionLine)) {
// printf("DEBUG: VariableUseList var = %s update = %d region: %d line: %d variableDeclared: %d\n",StringTable(rvar.sym),rvar.update,rvar.accRegionNumber,rvar.line,GetVariableDefined(rvar.objectKey,0));
        // store the string table entry so each variable is analyzed only once
        update = rvar.update;
        if (rvar.update >= TRUE) lastUpdate = rvar;
        processedVars[rvar.sym] = accRegionLine;

        /* determine the intent of this variable for this region based on three criteria
                1.  How was the variable in this GPU region first accessed?     (read or written?)
                2.  Prior to this GPU region, where was the variable last updated? ( prevVar )
                3.  After this GPU region, how was the variable accessed next? ( nextVar )
        */

        prevVar.line = 0;
        prevVar.accRegionLine = 0;
        nextVar.line = 0;
        nextVar.accRegionLine = 0;
        nextVar.update = -1;
        int prevGPURegion = 0;
        for (j=1;j<=rlen;j++) {
          my_var = IthElemVariableUseList(rlist,j);
          if (my_var.sym == rvar.sym) {
            if ((my_var.update >= TRUE) && (lastUpdate.line < my_var.line)) {
                lastUpdate = my_var;
            }
            if ((my_var.accRegionLine == accRegionLine) && (my_var.update == TRUE)) { update = TRUE; }

            // If the access of the variable was updated using itself (eg. a = a + 1), then it was READ first
            if ((my_var.line == rvar.line) && (my_var.update == 0) && (rvar.update == 1)) {
              rvar = my_var;
            }

                // find the last update to the variable occurred prior to the ACC$REGION
            if ((my_var.line < rvar.line) && (my_var.line >= prevVar.line)) {
 if ((strcmp(StringTable(rvar.sym),"rcl") == 0)) { 
//   printf("DEBUG: var = rcl line = %d prev-update = %d accRegion: %d\n",my_var.line,my_var.update,my_var.accRegionLine);
 }
              if (my_var.update >= TRUE) { prevVar = my_var; }
              if (my_var.accRegionLine > 0) { prevGPURegion = my_var.accRegionLine; }
            }

                // determine next time the variable is used after this region (CPU or GPU region)
            if ((my_var.line > rvar.line) && (my_var.accRegionLine != rvar.accRegionLine)) {
              if (nextVar.line == 0) { nextVar = my_var; }
              if ((nextVar.line != 0) && (my_var.line <= nextVar.line)) { nextVar = my_var; }
            }
          }
        }

        if (prevVar.line == 0) { 
          prevVar.accRegionLine = prevGPURegion; 
          prevVar.line = prevGPURegion; 
        }

 if ((strcmp(StringTable(rvar.sym),"sidevec_e") == 0)) { 
//  printf("Variable = %s region: %d numRegions: %d update = %d firstAccess = %d at: %d prevOwner = %d at: %d nextVar.update = %d at: %d\n",StringTable(rvar.sym),regionNumber,kernelsInFile,update,rvar.update,rvar.line,prevVar.accRegionLine,prevVar.line,nextVar.update,nextVar.line);
  }
        int input=0,output=0;
        int interProcedural = 0;
        if ((rvar.update == FALSE) && (GetVariableDefined(rvar.objectKey,0) != MODULE)) {       // first access is a READ
          if (GetNumberOfDims(rvar.unitKey,0) == 0) {
            input = IN;
          } else if (rvar.update == UNKNOWN) {
            input = IN;
            interProcedural = IN;
          } else {
            if (prevVar.line == 0) {    // no previous updates
              if ((GetVariableDefined(rvar.objectKey,0) == LOCAL) ||
                  (GetVariableDefined(rvar.objectKey,0) == MODULE)) { input = NONE; } // GPU owns it
              if (GetVariableDefined(rvar.objectKey,0) == PASSED_IN) { input = IN; }  // CPU owns it
              if (translationType == GPU) { input = NONE; }     // GPU kernel
            } else {
              if (prevVar.accRegionLine > 0) { // was last updated in a GPU region
                input = NONE;   // data resident on GPU
              } else {
                input = IN;     // used on CPU
              }
            }
          }
        } else {
          input = NONE;
        }
        if ((prevVar.line == 0) && ((GetIntent(rvar.objectKey,0) == IN) ||
             (GetIntent(rvar.objectKey,0) == INOUT)) && (input == NONE)) {
          input = IN;
         }
        if (update == TRUE) {   // the variable was updated in this GPU region
                /* copy data back to the CPU if this variable was       **
                ** last updated on the GPU in this GPU region           */ 
          if ((GetVariableDefined(rvar.objectKey,0) == PASSED_IN) &&
                (rvar.accRegionLine > 0) &&
                (lastUpdate.accRegionLine == rvar.accRegionLine)) {
            output = OUT;
          } else if (nextVar.line == 0) {  // no other accesses of this variable
            output = -1;
          } else {
            if (nextVar.update == TRUE) { // first access was a WRITE
              output = -1;      // no comms required
            } else if (nextVar.update == UNKNOWN) {
              interProcedural = OUT;
              output = OUT;
            } else {
              if (GetNumberOfDims(rvar.unitKey,0) == 0) {
                output = OUT;
              } else {
                if ((nextVar.accRegionLine == 0)) { // variable was accessed in a CPU region
                  output = OUT;
                } else {                                  // variable was accessed in a GPU region
                  output = -1;  // GPU resident
                }
              }
            }
          }
        } else {
          if (GetVariableDefined(rvar.objectKey,0) == MODULE) {
            output = 0;
          } else {
            output = -1;  // no further updates
          }
        }

        if  (input == NONE)                      { intent = NONE;  }
        if ((input == IN  ) && (output == -1  )) { intent = IN;    }
        if ((input == IN  ) && (output == OUT )) { intent = INOUT; }
        if ((input == NONE) && (output == OUT )) { intent = OUT;   }
                // check for a locally defined scalar variable which doesn't need copying anywhere
        if ((GetNumberOfDims(rvar.unitKey,0) == 0) && (intent == NONE) && (GetVariableDefined(rvar.objectKey,0) != MODULE)) { 
          if (output == -1) { intent = 0; }
        }

 if ((strcmp(StringTable(rvar.sym),"sidevec_e") == 0)) { 
  //printf("Variable = %s region: %d input: %d output: %d intent = %d\n",StringTable(rvar.sym),regionNumber,input,output,intent);
 }

        if (intent == NONE) { 
          (void) strcpy(cintent,"none");
        }
        if (intent == IN) { (void) strcpy(cintent,"in"); }
        if (intent == OUT) { (void) strcpy(cintent,"out"); }
        if (intent == INOUT) { (void) strcpy(cintent,"inout"); }

        // if the variable is listed in the ACC$REGION, use this entry, but 
        // inform the user that a difference exists between the analysis and
        // the user entry
        int length = LengthGPUVarsList(list);
        found = FALSE;
        for (j=1;j<=length;j++) {
          var = IthElemGPUVarsList(list,j);
          if ((var.sym == rvar.sym) && (var.scope != SHARED)) {
            found = TRUE;
            if ((intent != var.intent) || 
                (GetClpValue(Analysis,0) == DATA_MOVEMENT_VERBOSE)) {
              if (var.intent == NONE) { (void) strcpy(mintent,"none"); }
              if (var.intent == IN) { (void) strcpy(mintent,"in"); }
              if (var.intent == OUT) { (void) strcpy(mintent,"out"); }
              if (var.intent == INOUT) { (void) strcpy(mintent,"inout"); }
              if (intent != 0) {
                if ((interProcedural > 0) && (var.intent != interProcedural)) {
                  if (interProcedural == IN) { strcpy(cintent,"in"); }
                  if (interProcedural == OUT) { strcpy(cintent,"out"); }
                  if (intent != var.intent) {
                    fprintf(stderr,"  Variable: %12s intent: %5s   user specified intent: %5s\n",StringTable(rvar.sym),mintent,cintent);
                  }
                } else {
                  if (intent != var.intent) {
                    if ((GetClpValue(Analysis,0) == DATA_MOVEMENT_VERBOSE)) {
                      fprintf(stderr,"  Variable: %12s intent: %5s   user specified intent: %5s\n",StringTable(rvar.sym),cintent,mintent);
                    }
                  } else {
                    fprintf(stderr,"  Variable: %12s intent: %5s.\n",StringTable(rvar.sym),cintent);
                  }
                }
              } else {
                fprintf(stderr,"  NOTE: Variable: %12s lists intent: \"%5s\".   Analysis suggests no entry is required.\n",StringTable(rvar.sym),mintent);
              }
              intent = var.intent;
            }
          }
        }

        if (found == FALSE) {
          if (intent == IN) {
            if (GetVariableDefined(rvar.objectKey,0) != GPU_CONSTANT) {
              if (iArgs == 0) {
                strcpy(inString,"<");
              } else {
                strcat(inString,",");
              }
              strcat(inString,StringTable(rvar.sym));
              iArgs++;
            }
          }
          if (intent == INOUT) {
            if (ioArgs == 0) {
              strcpy(inoutString,"<");
            } else {
              strcat(inoutString,",");
            }
            strcat(inoutString,StringTable(rvar.sym));
            ioArgs++;
          }
          if (intent == OUT) {
            if (oArgs == 0) {
              strcpy(outString,"<");
            } else {
              strcat(outString,",");
            }
            strcat(outString,StringTable(rvar.sym));
            oArgs++;
          }
          if (intent == NONE) {
            if (GetVariableDefined(rvar.objectKey,0) == MODULE) {
              if (eArgs == 0) {
                strcpy(externString,"<");
              } else {
                strcat(externString,",");
              }
              strcat(externString,StringTable(rvar.sym));
              eArgs++;
            } else {    // default global scoped variable
              if (nArgs == 0) {
                strcpy(noneString,"<");
              } else {
                strcat(noneString,",");
              }
              strcat(noneString,StringTable(rvar.sym));
              nArgs++;
            }
          }
        }

        // the loop bounds may also need to be added.  Store these in arrayDims
        if (GetNumberOfDims(rvar.unitKey,0) > 0) {
          BoundsList blist = GetArraySizeList(rvar.objectKey,NULLBoundsList);
          int blen = LengthBoundsList(blist);
          for (j=1;j<=blen;j++) {
            Bounds bound = IthElemBoundsList(blist,j);

            int ufound = FALSE;
            int lfound = FALSE;
                // has the bound already been added?
            for (k=0;k<nDims;k++) {
              if ((bound.upper == arrayDims[k]) || (strcmp(StringTable(bound.upper),
                StringTable(arrayDims[k])) == 0)) { ufound = TRUE; }
              if ((bound.lower == arrayDims[k]) || (strcmp(StringTable(bound.lower),
                StringTable(arrayDims[k])) == 0)) { lfound = TRUE; }
            }
                // add them if they haven't been listed

                // determine where the variable was declared
            if ((lfound == FALSE) && (bound.lower != 0)) {
              int decl = 0;
              for (k=1;k<=rlen;k++) {
                my_var = IthElemVariableUseList(rlist,k);
                if (bound.lower == my_var.sym) {
                  decl = GetVariableDefined(my_var.objectKey,0);
                }
              }
                // if no explicit use of the variable, assume its in the module
              if (decl == 0) { decl = MODULE; }

              if (decl != GPU_CONSTANT) { 
                arrayDims[nDims] = bound.lower; 
                arrayDecl[nDims] = decl;
                nDims++;
                lfound = TRUE; 
              }
            }
            if ((ufound == FALSE) && (bound.upper != 0)) {
              int decl = 0;
              for (k=1;k<=rlen;k++) {
                my_var = IthElemVariableUseList(rlist,k);
                if (bound.upper == my_var.sym) {
                  decl = GetVariableDefined(my_var.objectKey,0);
                }
              }
              if (decl == 0) { decl = MODULE; }
              if (decl != GPU_CONSTANT) { 
                arrayDims[nDims] = bound.upper; 
                arrayDecl[nDims] = decl;
                nDims++;
                ufound = TRUE; 
              }
            }
          }
        }

      } // end - new variable processing
    } // end - loop thru all the variables accessed in the region

  /* 
  VariableUseList contains all variables used in the region.  However, the
  list does not contain the dimension of each variable that is also used in the
  region.  For example the variable u3d(ims:ime),may be used in the program as
  u3d(i,j), but the dimension variables may not appear.  This next segment looks
  at the bounds of each array to determine if they also need to be added.  The
  bounds are assumed to be scalars with intent IN.  Multi-term array bounds are
  not processed but could be in a future release.
  */

    for(i=0;i<nDims; i++) {
      // fprintf(stderr,"arrayDims = %d %s len: %d\n",arrayDims[i],StringTable(arrayDims[i]),(int)strlen(StringTable(arrayDims[i])));

      found = FALSE;
      for(j=0;j<(int)strlen(StringTable(arrayDims[i]));j++) {
        if (*(StringTable(arrayDims[i])+j)=='*') { found = TRUE; }
        if (*(StringTable(arrayDims[i])+j)=='+') { found = TRUE; }
        if (*(StringTable(arrayDims[i])+j)=='-') { found = TRUE; }
        if (*(StringTable(arrayDims[i])+j)=='/') { found = TRUE; }
      }
    
      if (IsNumeric(arrayDims[i]) == FALSE) {
        if (found == TRUE) {
          fprintf(stderr,"  NOTE: Multi-term dimension %s may contain terms that must be added.\n",StringTable(arrayDims[i]));
        } else {
        // has the variable already been specified in VariableUseList?
          found = FALSE;

          for (j=1;j<=rlen;j++) {
            my_var = IthElemVariableUseList(rlist,j);
            if ((my_var.sym == arrayDims[i]) && (my_var.accRegionLine == accRegionLine)) {
              found = TRUE; 
            }
          }
          for (j=1;j<=length;j++) {
            var = IthElemGPUVarsList(list,j);
            if (var.sym == arrayDims[i]) {
              found = TRUE;
            }
          }
          if (found == FALSE) {  // add the variable
            if (arrayDecl[i] == MODULE) {       // GPU resident
              if (eArgs == 0) {
                strcpy(externString,"<");
              } else {
                strcat(externString,",");
              }
              strcat(externString,StringTable(arrayDims[i]));
              eArgs++;
            } else {
              if (iArgs == 0) {
                strcpy(inString,"<");
              } else {
                strcat(inString,",");
              }
              strcat(inString,StringTable(arrayDims[i]));
              iArgs++;
            }
          }
        }
      }
    }

  // Finally, build a recommended output string
  
    char accString[5000];
    strcpy(accString,"");
    if (iArgs > 0) {
      strcat(inString,":in>");
      strcat(accString,inString);
    }
    if (ioArgs > 0) {
      if (iArgs > 0) { strcat(accString,","); }
      strcat(inoutString,":inout>");
      strcat(accString,inoutString);
    }
    if (oArgs > 0) {
      if (iArgs+ioArgs > 0) { strcat(accString,","); }
      strcat(outString,":out>");
      strcat(accString,outString);
    }
    if (nArgs > 0) {
      if (iArgs+ioArgs+oArgs > 0) { strcat(accString,","); }
      strcat(noneString,":none>");
      strcat(accString,noneString);
    }
    if (eArgs > 0) {
      if (iArgs+ioArgs+oArgs+nArgs > 0) { strcat(accString,","); }
      strcat(externString,":none,extern>");
      strcat(accString,externString);
    }

    if (length > 0) {
      dataSectionPtg = PTGSequence(PTGAsIs(","),dataSectionPtg);
    }
    PTGNode newArgs = PTGNULL;
    int tArgs = iArgs+ioArgs+oArgs+nArgs+eArgs;
    if (tArgs > 0) {
      newArgs = PTGSequence(PTGAsIs(","),PTGAsIs(accString));
printf("iargs = %d new args = ",iArgs);
PTGOut(newArgs);
printf("\n");
    }
    if (argStorage <= MAX_STORAGE_SIZE) {
      PTGOut(PTGAccRegion(
        PTGNumber(accRegionLine),
        ConstructAccRegion(regionVars),
        dataSectionPtg,
        newArgs
      ));
    } else {
      fprintf(stderr,"ERROR: F2C-ACC Variable Analysis - Data section is properly defined but has %d arguments. The maximum number of arguments allowed by CUDA is %d bytes\n",argStorage,MAX_STORAGE_SIZE);
    }
  }

  if ((GetClpValue(Analysis,0) == VARIABLE_USE) && (regionNumber == kernelsInFile)) {
    if (kernelsInFile >= MAX_KERNELS) {
      fprintf(stderr,"ERROR: number of regions exceeds the internal limit of %d\n",MAX_KERNELS);
      exit(1);
    }
    fprintf(stderr,"\nF2C-ACC Analysis of the file: %s  VARIABLE_USE\n\n",StringTable(GetClpValue(FileName, 0)));
    int nVars = 0,nVars3 = 0;
    int varIndex[MAX_TABLE_SIZE];
    int listEntry[MAX_TABLE_SIZE];
    int regionCnt[MAX_KERNELS];

    for (i=0;i<MAX_TABLE_SIZE;i++) { processedVars[i] = FALSE; }
    rlen = LengthVariableUseList(rlist);
    for (i=1;i<=rlen;i++) {
      rvar = IthElemVariableUseList(rlist,i);
        // look at all arrays used within a GPU region

// MWG:  uncomment to run only for arrays
      if ((GetNumberOfDims(rvar.unitKey,0) > 0) && (rvar.accRegionLine > 0) &&
          (processedVars[rvar.sym] == FALSE)) { 
/* MWG: uncomment to run for all variables */
      // if ((rvar.accRegionLine > 0) && (processedVars[rvar.sym] == FALSE))

        occCnt = 1;
        for (j=i+1;j<rlen;j++) {
          my_var = IthElemVariableUseList(rlist,j);
          if ((my_var.sym == rvar.sym) && (my_var.accRegionLine > 0)) {
            occCnt++;
          }
        }
        processedVars[rvar.sym] = occCnt;
        varIndex[nVars] = rvar.sym;
        listEntry[rvar.sym] = i;
        if (occCnt >= MIN_NUM_ACCESSES) { nVars3++; }
        nVars++;
      }
    }
    // sort the list, referencing each variable indirectly
    for (i=0; i<nVars; i++) {
      for (j=0; j<nVars-1; j++) {
        if (processedVars[varIndex[j]] < processedVars[varIndex[j+1]]) {
          int tmp = varIndex[j+1];
          varIndex[j+1] = varIndex[j];
          varIndex[j] = tmp;
        }
      }
    }
    // output the list
    fprintf(stderr,"F2C-ACC Analysis: %3d variables used in %d GPU regions were analyzed.\n",nVars,kernelsInFile);
    fprintf(stderr,"F2C-ACC Analysis: %3d variables contained at least %d accesses:\n",nVars3,MIN_NUM_ACCESSES);
    for (i=0; i<nVars; i++) {
      if (processedVars[varIndex[i]] >= MIN_NUM_ACCESSES) {
        rvar = IthElemVariableUseList(rlist,listEntry[varIndex[i]]);
        fprintf(stderr,"   %dD  variable: %10s was used: %3d times -->",GetNumberOfDims(rvar.unitKey,0),StringTable(rvar.sym),processedVars[varIndex[i]]);

        // get usage information for each ACC$REGION
        for (j=0;j<MAX_KERNELS;j++) { regionCnt[j] = 0; }
        for (j=1;j<=rlen;j++) {
          my_var = IthElemVariableUseList(rlist,j);
            // get the number of accesses per region
          if ((rvar.sym == my_var.sym) && (my_var.accRegionLine > 0)) {
            int k;
            for (k=0;k<kernelsInFile;k++) {
              if (my_var.accRegionLine == kernelNumber[k]) {
                regionCnt[k]++;
              }
            }
          }
        }
        for (j=0;j<kernelsInFile;j++) {
          fprintf(stderr," %2d",regionCnt[j]);
        }

                // output variable information
        if (GetNumberOfDims(rvar.unitKey,0) > 0) {
          fprintf(stderr,"      declaration: %s[",StringTable(rvar.sym));
          BoundsList blist = GetArraySizeList(rvar.objectKey, NULLBoundsList);
          for (j=1; j<=LengthBoundsList(blist); j++) {
            Bounds bound = IthElemBoundsList(blist,j);
            if (bound.upper > 0) {
              if (j==1) {
                if (bound.lower > 0) {
                  fprintf(stderr,"%s:%s",StringTable(bound.lower),StringTable(bound.upper));
                } else {
                  fprintf(stderr,"%s",StringTable(bound.upper));
                }
              } else {
                if (bound.lower > 0) {
                  fprintf(stderr,",%s:%s",StringTable(bound.lower),StringTable(bound.upper));
                } else {
                  fprintf(stderr,",%s",StringTable(bound.upper));
                }
              }
            }
          }
          fprintf(stderr,"]\n");
        } else {
          fprintf(stderr,"\n");
        }

      }
    }
  }
  return;
}

int ToUpper(int sym) {

char scalar[MAX_STRLEN+1];
int i;

for (i=0;i<strlen(StringTable(sym));i++) {
  scalar[i] = toupper(*(StringTable(sym)+i));
}
scalar[i] = '\0';
return(MakeName(scalar));
}

PTGNode BuildStruct(int programName, GPUVarsList list,int kernelNum) {

int i;
PTGNode rDecls=PTGNULL,iDecls=PTGNULL;
PTGNode output=PTGNULL;

  /* determine the number of scalar arguments in this Kernel */
  int rcnt = 0;
  int icnt = 0;
  int length = LengthGPUVarsList(list);
  for (i=1; i<=length; i++) {
    var = IthElemGPUVarsList(list,i);
    if ((GetNumberOfDims(var.unitKey,0) == 0) && (var.intent == IN) &&
        (GetVariableDefined(var.objectKey,0) != GPU_CONSTANT)) {
// NOTE: real*8 and integer*8 not supported yet ... 
      if ((GetType(var.unitKey,ErrorType) == RealType) ||
          (GetType(var.unitKey,ErrorType) == LogicalType) ||
          (GetType(var.unitKey,ErrorType) == IntegerType)) { 
        if (GetType(var.unitKey,ErrorType) == RealType) { 
          if(rcnt++ == 0) { 
            rDecls = PTGString(StringTable(var.sym));
          } else {
            rDecls = PTGCommaArgs(rDecls,PTGString(StringTable(var.sym)));
          }
        } else {
          if(icnt++ == 0) { 
            iDecls = PTGString(StringTable(var.sym));
          } else {
            iDecls = PTGCommaArgs(iDecls,PTGString(StringTable(var.sym)));
          }
        }
      }
    }
  }
  if (rcnt+icnt >0) {
    output = PTGScalarStructBegin();
    if (rcnt > 0) { output = PTGScalarStructField(output,PTGAsIs("float"),rDecls); }
    if (icnt > 0) { output = PTGScalarStructField(output,PTGAsIs("int"),iDecls); }
    output = PTGScalarStructEnd(
        output,
        PTGString(StringTable(programName)),
        PTGNumber(kernelNum)
    );
  }
  return(output);
}

/* SubArgsOutput is the driver routine for all generated output for     **
** ACC$REGION and the ACC$DATA directives.  Three lists are used that   **
** store all variables that may be output:                              **
** ProgDeclsList    - all defined local arrays                          **
** GPUVarsList      - all variables listed in the ACC$REGION            **
**                                                                      **
** GPUVarsList is recreated for each ACC$REGION; the other two lists    **
** are applied to the entire subroutine. The GPU list is optionally     **
** populated with local variables (AddLocalVars) in order to pass       **
** local variables required by each kernel.                             **
**                                                                      **
** The generated output, produced in the function GenerateOutput, is    **
** determined by the intent of the variable and the mode. Variable      **
** intent is further described in the GenerateOutput function. The mode **
** defines the types of output generation. The following modes are      **
** supported:                                                           **
** KERNEL           - generate arguments to the gpu kernel routine      **
** KERNEL_CALL      - generate arguments to call the gpu kernel         **
** KERNEL_IN        - generate gpu variables, memory allocation and     **
                                copies from the CPU to the GPU          **
** KERNEL_OUT       - generate copies from GPU to CPU as required       **
** KERNEL_DECLS     - generate scalar declarations passed by reference  **
** KERNEL_DECLS_END - generate assignments to return updated scalars    **
** SUBR_DECLS       - generate declarations for the CPU routine         **
** SUBR_END         - generate assigmments to update scalars            **
** ACC_DATA         - all declarations, allocation and copies for the   **
**                              ACC$DATA directive                      */      

PTGNode SubArgsOutput(int programName, ProgDeclsList llist, GPUVarsList list, int mode,int line, int declLine, int region,int numKernels,RegionVars regionVars, POSITION *coord) {

  PTGNode GenerateOutput(int *generated, int mode, int *nArgs,int *nScalars,GPUVars var,GPUVars varS, DefTableKey unitKey, DefTableKey objectKey, int sym, int gsym, int intent,int scope, int optexpr, PTGNode condexpr, int declareVar, int programName,int regionNumber,int length,RegionVars regionVars,POSITION *coord, int declLine);
  void GeneratePromotedVariable(GPUVars var,RegionVars regionVars);

// Add declared variables to the Kernel 
if (mode == SUBR_END) {
  list =  AddLocalVars(llist,list,region);
}

  int length = LengthGPUVarsList(list);
  int i,j;
  PTGNode output = PTGNULL;
  PTGNode arg;
  int nArgs = 0;  /* number of arguments output */
  int generated;
  int declareVar;       // GPU variables are declared once

  /* NVIDIA current restricts the number of arguments passed to a GPU   **
  ** kernel to a maximum of 4096 bytes.  If we exceed the limit, pass   **
  ** the struct containing all scalars with intent (IN) via a cudaMemcpy**
  ** rather than a direct copy.                                         */
  int argStorage = 0;
  for (i=1; i<=length; i++) {
    var = IthElemGPUVarsList(list,i);
    if (var.scope != SHARED) {
      if ((GetNumberOfDims(var.unitKey,0) > 0) || ((var.intent == OUT) ||
      (var.intent == INOUT))) {
        argStorage += 8;        // memory address
      } else {
        argStorage += 4;        // 4 byte real or float
      }
    }
  }

// printf("DEBUG: SubArgsOutput mode: %d GPU len = %d\n",mode,length);
if (mode == ACCDATA) {
        /* output cuda calls, declarations within the routine   */
  if (length > 0) {     /* process the GPU variables */
    nArgs = 0;  /* number of arguments output */
    for (j=1; j<=length; j++) {
      var = IthElemGPUVarsList(list,j);
// printf("DEBUG: SubArgsOutput ACCDATA var = %s scope = %d\n",StringTable(var.sym),var.scope);
      arg = GenerateOutput(&generated,mode,&nArgs,&j,var,var,var.unitKey,var.objectKey,var.sym,var.gsym,var.intent,var.scope,var.optexpr,var.condexpr,0,programName,region,length,regionVars,coord,declLine);
          /* Integrate the output */
      if (generated == TRUE) {
        if (nArgs == 1) {
          output = arg; 
        } else {
          output = PTGSequence(output,arg);
        }
      }
    }
  }
  return(output);
} else {        /* ACC$REGION output */
  /* loop thru variables listed as arguments in the ACC$REGION */
  int nScalars = 0; /* number of scalars with intent IN */
  GPUVars varT; // temporary
  GPUVars varS; // shared or local memory
  for (i=1; i<=length; i++) {
    varS.scope = 0; // initial value
    var = IthElemGPUVarsList(list,i);
    if (var.gsym == 0) {
      if ((var.scope == SHARED) || (var.scope == LOCAL)) { varS = var; }
      for (j=i+1;j<=length;j++) {
        varT = IthElemGPUVarsList(list,j);
        if (var.sym == varT.sym) { 
          if ((varT.scope == SHARED) || (varT.scope == LOCAL))  { 
            varS = varT; 
          } else { 
            var = varT; 
          }
        }
      }
    }
    if (varS.scope == 0) { varS = var; }

        /* VariableDeclaredGPU insures variables are defined only once */
    if (mode == SUBR_DECLS) {
      if ((GetVariableDeclaredGPU(var.objectKey,0) == 0) && (var.scope != SHARED)) {
        declareVar = TRUE;
      } else {
        declareVar = FALSE;
      }
      // do not promote a shared memory variable in which a blockfactor is given

// test prior to replacing promoteDim with the two dimensional counterpart
if (var.promoteDim != var.promoteDims[0]) {
  fprintf(stderr,"2 - PromoteDim inconsistency.  Exit");
  exit(1);
}
      if ((var.promoteDim > 0) && (var.promoteType != THREAD)) {
        if ((var.scope != SHARED) || (var.scope == SHARED) && 
           (var.promoteDim > 0) &&
          (GetRegionVarProperty(regionVars,BLOCKFACTOR,1) == 0)) {
/*
  printf("DEBUG: SubArgsOutput - Promote var = %s blocking: %d sharedDim1 = %dpromoteDim: %d %d\n",StringTable(var.sym),GetRegionVarProperty(regionVars,BLOCKFACTOR,1),var.sharedDim1,var.promoteDim,var.promoteDims[0]);
*/
          GeneratePromotedVariable(var,regionVars);
        }
      }
    }
    arg = GenerateOutput(&generated,mode,&nArgs,&nScalars,var,varS,var.unitKey,var.objectKey,var.sym,var.gsym,var.intent,var.scope,var.optexpr,var.condexpr,declareVar,programName,region,argStorage,regionVars,coord,declLine);
    if (mode == SUBR_DECLS) {
      if (((var.scope != SHARED) && (var.scope != LOCAL)) ||
         ((var.scope == LOCAL) && (var.intent != NONE))) {
        ResetVariableDeclaredGPU(var.objectKey,TRUE);
      }
    }

          /* Integrate the output */
    if (generated == TRUE) {
      if (nArgs == 1) {
        output = arg;
      } else {
        if ((mode == KERNEL_CALL) || (mode == KERNEL)) {
          output = PTGCommaArgs(output,arg);
        } else {
          output = PTGSequence(output,arg);
        }
      }
    }
  }
    /* copy the structure containing all the scalars to the GPU, this is  **
    ** done last because all members of the structure must be assigned.   */
  if ((mode == KERNEL_IN) && (nScalars > 0)) {
    PTGNode scalarStructName = PTGScalarStructVar(
            PTGString(StringTable(programName)),
            PTGNumber(region)
          );
    PTGNode scalarStructType = PTGScalarStruct(
            PTGString(StringTable(programName)),
            PTGNumber(region)
          );
    PTGNode cudaDecl = PTGCudaDecl(
        scalarStructType,
        PTGDeviceName(scalarStructName)
    );
    PTGNode cudaMalloc = PTGCudaMalloc(
        PTGDeviceName(scalarStructName),
        PTGAsIs("1"),
        scalarStructType,
        PTGString(StringTable(GetClpValue(FileName,0))),
        PTGNumber(coord->line),PTGString(StringTable(var.sym))
    );
    PTGNode copyToGPU = PTGCudaMemcpyToGPU(
        PTGDeviceName(scalarStructName),
        PTGVariableAddr(scalarStructName),
        PTGAsIs("1"),
        scalarStructType,
        PTGString(StringTable(GetClpValue(FileName,0))),
        PTGNumber(coord->line),PTGString(StringTable(var.sym))
    );
    if (argStorage > MAX_STORAGE_SIZE) {
      arg = PTGThreeArgs(cudaDecl,cudaMalloc,copyToGPU);
    }
    output = PTGSequence(output,arg);
  }
}

if ((mode == KERNEL) && (argStorage > MAX_STORAGE_SIZE)) {
    fprintf(stderr,"F2C-ACC ERROR: Accelerator region %d at line: %d requires %d bytes of storage.  This exceeds the CUDA limit of %d. Use the --Analysis option to determine variable usage.\n",region,line,argStorage,MAX_STORAGE_SIZE);
    exit(1);
}
return(output);
}

/* Generated output is determined both by the intent of the variable    **
** and the mode.  There are four types of intent supported:             **
** IN               - copy data to the GPU prior to kernel execution    **
** OUT              - copy data to the CPU after the kernel completes   **
** INOUT            - a combination of IN and OUT as defined above      **
** NONE             - no copies are required                            **
**                                                                      */

PTGNode GenerateOutput(int *generated, int mode, int *nArgs,int *nScalars,GPUVars var, GPUVars varS, DefTableKey unitKey, DefTableKey objectKey, int sym, int gsym, int intent,int scope,int optexpr, PTGNode condexpr, int declareVar, int programName,int regionNumber,int argStorage,RegionVars regionVars,POSITION *coord, int declLine) {

*generated = FALSE;
PTGNode arg = PTGNULL;
PTGNode CopySharedData(GPUVars var,GPUVars varS,int mode,RegionVars regionVars,POSITION *coord);

int len = GetTypeLength(unitKey,0);
PTGNode varName = PTGString(StringTable(sym));
PTGNode deviceName = PTGDeviceName(varName);
PTGNode hostName = PTGSequence(PTGAsIs("H_"),varName);
PTGNode sharedVar = PTGSequence(PTGString(StringTable(var.sym)),PTGAsIs("S"));

PTGNode cudaDecl = PTGCudaDecl(
        Convert_to_CudaType(len,GetType(unitKey,ErrorType)),
        deviceName
  );
PTGNode declExtern = PTGCudaDeclExtern(
        Convert_to_CudaType(len,GetType(unitKey,ErrorType)),
        deviceName
  );
PTGNode declGlobalExtern = PTGCudaGlobalExternDecl(
        Convert_to_CudaType(len,GetType(unitKey,ErrorType)),
        deviceName,
        PTGPointer(hostName)
);
PTGNode cudaMalloc = PTGCudaMalloc(
        deviceName,
        GetComputedSize(objectKey,PTGAsIs("1")),
        Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
        PTGString(StringTable(GetClpValue(FileName,0))),
        PTGNumber(coord->line),PTGString(StringTable(var.sym))
  );
PTGNode copyToGPU = PTGCudaMemcpyToGPU(
        deviceName,
        PTGString(StringTable(sym)),
        GetComputedSize(objectKey,PTGAsIs("1")),
        Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
        PTGString(StringTable(GetClpValue(FileName,0))),
        PTGNumber(coord->line),PTGString(StringTable(var.sym))
  );
PTGNode copyToCPU = PTGCudaMemcpyToCPU(
        PTGString(StringTable(sym)),
        deviceName,
        GetComputedSize(objectKey,PTGAsIs("1")),
        Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
        PTGString(StringTable(GetClpValue(FileName,0))),
        PTGNumber(coord->line),PTGString(StringTable(var.sym))
  );

  if (mode == KERNEL) {
//if (strcmp(StringTable(sym),"imvdif")==0) {
// printf("KERNEL var: %s region: %d VariableListed: %d VariableDefined: %d\n",StringTable(sym),regionNumber,GetVariableListedGPU(objectKey,0),GetVariableDefined(objectKey,0));
//}
    if (GetVariableListedGPU(objectKey,0) != KERNEL*1000+regionNumber) {
      if (GetVariableDefined(objectKey,0) == GPU_CONSTANT) { return(PTGNULL); }
      if (var.scope == SHARED) { return(PTGNULL); }
      if ((var.scope == LOCAL) && (intent == NONE)) { return(PTGNULL); }

      ResetVariableListedGPU(objectKey,KERNEL*1000+regionNumber);

        /* if the user specifies intent NONE on a scalar, add an element */
      if ((GetNumberOfDims(unitKey,0) == 0) && (intent == IN) &&
          (GetVariableDefined(objectKey,0) != GPU_CONSTANT) &&
          (scope != EXTERN)) { 
        (*nScalars)++;
        if (argStorage > MAX_STORAGE_SIZE) {
          varName = PTGPointer(PTGString(StringTable(programName)));
        } else {
          varName = PTGString(StringTable(programName));
        }
        if (*nScalars == 1) {
          *generated = TRUE;
          (*nArgs)++;   /* all arguments added for now  */
          arg = PTGScalarStructDecl(
            PTGString(StringTable(programName)),
            PTGNumber(regionNumber),
            varName,
            PTGNumber(regionNumber)
          );
        }
        return(arg);
      } 

      if (GetNumberOfDims(unitKey,0) > 0) {
        if ((scope == LOCAL) && (intent != NONE)) {
          varName = PTGSequence(PTGPointer(varName),PTGAsIs("G"));
        } else {
          varName = PTGPointer(varName);
        }
      } else {
        if (((intent == OUT) || (intent == INOUT)) || (scope == EXTERN)) { 
          /* variable is a scalar, that will be updated  or its GPU resident */
          varName = PTGPointer(deviceName);
        }
      }

      (*nArgs)++;
      *generated = TRUE;
      arg = PTGSubroutineArg(
          Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
          PTGNULL,
          varName
        );
    }
  } else if (mode == KERNEL_CALL) {
//printf("KERNEL_CALL VariableListed: %s region: %d VariableListed: %d\n",StringTable(sym),regionNumber,GetVariableListedGPU(objectKey,0));
    if (GetVariableListedGPU(objectKey,0) != KERNEL_CALL*1000+regionNumber) {
      if (GetVariableDefined(objectKey,0) == GPU_CONSTANT) { return(PTGNULL); }
      if (var.scope == SHARED) { return(PTGNULL); }
      if ((var.scope == LOCAL) && (intent == NONE)) { return(PTGNULL); }

      ResetVariableListedGPU(objectKey,KERNEL_CALL*1000+regionNumber);

      if ((GetNumberOfDims(unitKey,0) == 0) && (intent == IN) &&
          (GetVariableDefined(objectKey,0) != GPU_CONSTANT) && 
          (scope != EXTERN)) { 
        (*nScalars)++;
        if (*nScalars == 1) {
          *generated = TRUE;
          (*nArgs)++;   
          arg = PTGScalarStructVar(
            PTGString(StringTable(programName)),
            PTGNumber(regionNumber)
          );
          if (argStorage > MAX_STORAGE_SIZE) {
            arg = PTGDeviceName(arg);
          }
        }
        return(arg);
      } 

      if ((GetNumberOfDims(unitKey,0) > 0) || (scope == EXTERN) ||
           ((intent == OUT) || (intent == INOUT))) {
        (*nArgs)++;
        *generated = TRUE;
        arg = deviceName;
      }
    }
    return(arg);
  } else if (mode == SUBR_DECLS) {
        // declare variables as needed for the CPU routine
    if ((declareVar == FALSE) && (gsym == 0)) { return(PTGNULL); }

    if (GetNumberOfDims(unitKey,0) > 0) {
      if ((var.scope != LOCAL) || (var.scope == LOCAL) && (intent != NONE)) {
        *generated = TRUE;
        (*nArgs)++;
        if ((intent != NONE) && (declareVar == TRUE) && (var.scope != EXTERN)) {
          arg = PTGSequence(
            cudaDecl,
            cudaMalloc
          );
        } else {
          if (gsym != 0) {      // is there a mapping variable?
            if (declareVar == FALSE) { cudaDecl = PTGNULL; }
                // has the mapped variable been defined?
            if (GetVariableDeclaredGPU(var.gobjectKey,0) == 0) {
              ResetVariableDeclaredGPU(var.gobjectKey,TRUE);
              arg = PTGSequence(
                cudaDecl,
                PTGCudaDeclExtern(
                  Convert_to_CudaType(len,GetType(unitKey,ErrorType)),
                  PTGDeviceName(PTGString(StringTable(gsym)))
                )
              );
            } else { // declare referenced variable if needed
              arg = cudaDecl;
            }
          } else {
//printf("DEBUG: DECLARE var = %s line = %dGetVariableDeclaredGPU = %d\n",StringTable(var.sym),coord->line,GetVariableDeclaredGPU(objectKey,0));

            if ((GetVariableDefined(objectKey,0) == LOCAL) ||
              (scope == GLOBAL)) {
                arg = PTGSequence(
                  cudaDecl,
                  cudaMalloc
                );
            }
printf("DEBUG: DECLARE var = %s line = %d GetVariableDeclaredGPU = %d VariableDeclaredGPU = %d\n",StringTable(var.sym),coord->line,GetVariableDeclaredGPU(objectKey,0),GetVariableDeclaredGPU(objectKey,0));
            // if ((scope == EXTERN) && (GetVariableRoutine(objectKey,0) == 0))
            if ((scope == EXTERN) && (GetVariableDeclaredGPU(objectKey,0) == 0)) {
              if (GetVariableDefined(objectKey,0) != MODULE) {
                arg = declExtern;
              } else {  // defined via "use" reference
                arg = PTGCudaGlobalExternDecl(
                  Convert_to_CudaType(len,GetType(var.unitKey,ErrorType)),
                  PTGDeviceName(PTGString(StringTable(var.sym))),
                  PTGPointer(hostName)
                );
                // declare and assign the externally defined CPU pointer 
                if (GetNumberOfDims(unitKey,0) > 0) {
                  varName = PTGPointer(varName);
                } else {
                  hostName = PTGPointer(hostName);
                }
                arg = PTGSequence(arg,
                  PTGDeclAssignVar(
                    PTGIndent(2),
                    Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
                    varName,
                    hostName
                  )
                );
                ResetVariableRoutine(objectKey,TRUE);
              }
            }
                /*
                special case where the variable is passed via subroutine
                argument, is used in a cpu region, and then declared as a
                GPU resident variable in an ACC4REGION directive.  This 
                occurs in SMS pack and unpack routines where a call is made
                to SMS_Get_Pointer to retrieve the address of the GPU variable
                based on a variable lookup table.
                */
            if ((scope == EXTERN) && (GetVariableDefined(objectKey,0) == PASSED_IN) && (GetVariableDeclaredGPU(objectKey,0) == 0)) {
              arg = declExtern;
              // message(WARNING,"Variable is referenced in a CPU region, but declared \"extern\" in the ACC$REGION",0,coord);
            }
          }
        }
      }
    } else {    // NumberOfDims == 0
      if (((intent == OUT) || (intent == INOUT)) && (declareVar == TRUE) && (var.scope != EXTERN)) {
// printf("DEBUG: var = %s line = %d GetVariableRoutine = %d GetVariableDeclaredGPU = %d\n",StringTable(var.sym),coord->line,GetVariableRoutine(objectKey,0),GetVariableDeclaredGPU(objectKey,0));
        *generated = TRUE;
        (*nArgs)++;
        arg = PTGSequence(
          cudaDecl,
          cudaMalloc
        );
      }
if (var.scope == EXTERN) {
// printf("DEBUG: var = %s line = %d GetVariableRoutine = %d GetVariableDeclaredGPU = %d\n",StringTable(var.sym),coord->line,GetVariableRoutine(objectKey,0),GetVariableDeclaredGPU(objectKey,0));
}
      if ((var.scope == EXTERN) && (GetVariableRoutine(objectKey,0) == 0)) {
        *generated = TRUE;
        (*nArgs)++;
        if (GetVariableDefined(objectKey,0) == MODULE) {
          arg = PTGCudaGlobalExternDecl(
            Convert_to_CudaType(len,GetType(var.unitKey,ErrorType)),
            PTGDeviceName(PTGString(StringTable(var.sym))),
            PTGPointer(PTGHostName(PTGString(StringTable(var.sym))))
          );
        }
        if (GetNumberOfDims(unitKey,0) > 0) {
          varName = PTGPointer(varName);
        } else {
          hostName = PTGPointer(hostName);
        }
        arg = PTGSequence(
          arg,
          PTGDeclAssignVar(
            PTGIndent(2),
            Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
            varName,
            hostName
          )
        );
        ResetVariableRoutine(objectKey,TRUE);
      }
    }
  } else if (mode == KERNEL_IN) {
    if (var.scope == SHARED) { return(PTGNULL); }

// printf("DEBUG: GenerateOutput KERNEL_IN var = %s intent = %d scope = %d declareVar = %d\n",StringTable(sym),intent,scope,declareVar);
    if ((GetVariableCPU(objectKey,0) == FALSE) && (GetVariableDefined(objectKey,0) == LOCAL)) {
    } else {
      cudaDecl = PTGNULL;
    }
    if (GetNumberOfDims(unitKey,0) == 0) {
      if (intent == INOUT) {
        varName = PTGVariableAddr(PTGString(StringTable(sym)));
      }
    }

    if ((GetNumberOfDims(unitKey,0) == 0) && (intent == IN) &&
          (GetVariableDefined(objectKey,0) != GPU_CONSTANT)) { 
      if (*nScalars == 0) {
        (*nScalars)++;
        arg = PTGSequence(cudaDecl,
            PTGLineCR(PTGScalarStructDecl(
              PTGString(StringTable(programName)),
              PTGNumber(regionNumber),
              PTGString(StringTable(programName)),
              PTGNumber(regionNumber)
            ))
          );
      } 
      *generated = TRUE;
      (*nArgs)++;
      arg = PTGSequence(
        arg,
        PTGAssignVar(
          PTGIndent(2),
          PTGScalarStructName(
            PTGString(StringTable(programName)),
            PTGNumber(regionNumber),
            varName
          ),
          varName
        )
      );
    }

        // scalars with INOUT are copied, as well as arrays
    if ((intent == INOUT) || ((intent == IN) && (GetNumberOfDims(unitKey,0) > 0))) {
      *generated = TRUE;
      (*nArgs)++;
      if (gsym != 0) {
        arg = 
          PTGCudaMemcpyToGPU(
            PTGDeviceName(PTGString(StringTable(gsym))),
            varName,
            GetComputedSize(objectKey,PTGAsIs("1")),
            Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
            PTGString(StringTable(GetClpValue(FileName,0))),
            PTGNumber(coord->line),PTGString(StringTable(var.sym))
          );
      } else {
        arg = 
          PTGCudaMemcpyToGPU(
            PTGDeviceName(PTGString(StringTable(sym))),
            varName,
            GetComputedSize(objectKey,PTGAsIs("1")),
            Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
            PTGString(StringTable(GetClpValue(FileName,0))),
            PTGNumber(coord->line),PTGString(StringTable(var.sym))
          );
      }
    }

    if (intent == NONE) {
//printf("DEBUG: GenerateOutput KERNEL_IN var = %s intent = %d scope = %d declareVar = %d\n",StringTable(sym),intent,scope,declareVar);
        // This option supports mapping of arrays via the '=>' operator and
        // optional or conditional arguments via the conditional syntax
        // For example 'var=>var1[callSite==1]
      (*nArgs)++;
      *generated = TRUE;
      if (gsym != 0) {  // is there a mapping variable?
        PTGNode condend = PTGNULL;
        if (optexpr == TRUE) { condend = PTGAsIs(" }"); }
        arg = PTGExternAssign(
            condexpr,
            PTGDeviceName(PTGString(StringTable(sym))),
            PTGDeviceName(PTGString(StringTable(gsym))),
            condend
          ); 
      }
    } // END: intent == NONE
  } else if (mode == KERNEL_OUT) {
 // printf("DEBUG: GenerateOutput KERNEL_OUT var = %s intent = %d scope = %d declareVar = %d VariableDefined: %d\n",StringTable(sym),intent,scope,declareVar,GetVariableDefined(objectKey,0));
    if (scope == SHARED) { return(PTGNULL); }

    if ((GetNumberOfDims(unitKey,0) > 0) ||
        (intent == OUT) || (intent == INOUT)) {

        /* variable address is needed, so if it's a scalar, get the address */
      if (GetNumberOfDims(unitKey,0) == 0) {
        varName = PTGVariableAddr(varName);
      }
      if ((intent == INOUT) || (intent == OUT)) {
        (*nArgs)++;
        *generated = TRUE;
        arg = PTGSequence(
          PTGCudaMemcpyToCPU(
            varName,
            PTGDeviceName(PTGString(StringTable(sym))),
            GetComputedSize(objectKey,PTGAsIs("1")),
            Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
            PTGString(StringTable(GetClpValue(FileName,0))),
            PTGNumber(coord->line),PTGString(StringTable(var.sym))
          ),
          PTGNULL
        );
      }
    }
  } else if (mode == ACCDATA) {
    if ((scope == SHARED) && (GetNumberOfDims(unitKey,0) > 0)) {
      if (var.sharedDim1 > 0) {
        PTGNode sharedDims = PTGNULL;
        if (var.sharedDim2 > 0) {
          sharedDims = 
            PTGSharedDim2(
                PTGString(StringTable(ToUpper(var.sharedDim1))),
                PTGString(StringTable(var.sharedDim2))
            );
        } else if (var.sharedDim1 > 0) { 
          sharedDims = 
            PTGSharedDim1(
                PTGString(StringTable(ToUpper(var.sharedDim1)))
            );
        } else {
        }
        PTGOut(PTGDeclareVar(
          PTGAsIs("0"),
          PTGNULL,
          PTGAsIs(" __shared__ "),
          Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
          PTGSequence(sharedVar,sharedDims)
        ));
      } else {  // use the original sizes for the declaration
        PTGOut(PTGDeclareVar(
          PTGAsIs("0"),
          PTGNULL,
          PTGAsIs(" __shared__ "),
          Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
          GenerateArray(sharedVar,GetArraySizeList(objectKey,NULLBoundsList),objectKey,unitKey,0,GPU,0,0,0,0,regionVars)
        ));
      }
      return(PTGNULL);
    }  // end - shared array output

    *generated = TRUE;
    (*nArgs)++;
    PTGNode aVar;
    if (GetNumberOfDims(var.unitKey,0) == 0) {
      aVar = PTGVariableAddr(varName);
    } else {
      aVar = varName;
    }
    if (var.gsym != 0) {
      copyToGPU = PTGCudaMemcpyToGPU(
        PTGDeviceName(PTGString(StringTable(gsym))),
        aVar,
        GetComputedSize(objectKey,PTGAsIs("1")),
        Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
        PTGString(StringTable(GetClpValue(FileName,0))),
        PTGNumber(coord->line),PTGString(StringTable(var.sym))
      );
    } else  {
      copyToGPU = PTGCudaMemcpyToGPU(
        PTGDeviceName(PTGString(StringTable(sym))),
        aVar,
        GetComputedSize(objectKey,PTGAsIs("1")),
        Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
        PTGString(StringTable(GetClpValue(FileName,0))),
        PTGNumber(coord->line),PTGString(StringTable(var.sym))
      );
    }
    if (intent==IN) {
 printf("DEBUG: GenerateOutput ACCDATA var = %s intent = %d scope = %d declareVar = %d\n",StringTable(sym),intent,scope,declareVar);
      if (scope == EXTERN) {
        arg = copyToGPU;
        if (GetVariableDeclaredGPU(objectKey,0) == 0) {
          ResetVariableDeclaredGPU(objectKey,TRUE);
          if (gsym == 0) {
            PTGOut(PTGAppendNL(PTGNumber(declLine),declGlobalExtern));
          } else {
            PTGOut(PTGAppendNL(PTGNumber(declLine),cudaDecl));
          }
        }
      } else if (scope == LOCAL) {
        arg = PTGThreeArgs(cudaDecl,cudaMalloc,copyToGPU);
      } else if (scope == GLOBAL) {
        arg = PTGSequence(cudaMalloc,copyToGPU);
      } else if (scope == GPU_CONSTANT) {
        if (GetNumberOfDims(unitKey,0) == 0) {
          varName = PTGVariableAddr(varName);
        }
        if (gsym == 0) { 
          gsym = sym;
        } else {
        }
        arg = PTGCudaMemcpyToSymbol(
          PTGString(StringTable(gsym)),
          varName,
          GetComputedSize(objectKey,PTGAsIs("1")),
          Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
          PTGString(StringTable(GetClpValue(FileName,0))),
          PTGNumber(coord->line),PTGString(StringTable(sym))
        );
        PTGOut(PTGDeclareVar(
          PTGAsIs("0"),
          PTGNULL,
          PTGAsIs(" __constant__ "),
          Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
          GenerateArray(PTGString(StringTable(gsym)),GetArraySizeList(objectKey,NULLBoundsList),objectKey,unitKey,0,GPU,0,0,0,0,regionVars)
        ));
      } else {
      }
      if (var.scope == GLOBAL) {
        if (GetNumberOfDims(unitKey,0) == 0) {
          PTGNode varAddr;
          if (GetVariableDefined(var.objectKey,0) == PASSED_IN) {
            varAddr = PTGGlobalName(PTGString(StringTable(var.sym)));
          } else {
            varAddr = PTGVariableAddr(varName);
          }
          arg = PTGSequence(arg,PTGAssignVar(
            PTGIndent(2),
            PTGHostName(PTGString(StringTable(var.sym))),
            varAddr
          ));
        } else {
          arg = PTGSequence(arg,PTGAssignVar(
            PTGIndent(2),
            PTGHostName(PTGString(StringTable(var.sym))),
            PTGString(StringTable(var.sym))
          ));
        }
      } 
    }
    if (intent==OUT) {
      if (scope == EXTERN) {
        *generated = TRUE;
        (*nArgs)++;
//printf("DEBUG: GenerateOutput ACCDATA var = %s intent = %d scope = %d declareVar = %d VariableRoutine = %d\n",StringTable(sym),intent,scope,declareVar,GetVariableRoutine(objectKey,0));
        if (var.gsym != 0) {    // mapping to an externally referenced variable
          copyToCPU = PTGCudaMemcpyToCPU(
            PTGString(StringTable(sym)),
            PTGDeviceName(PTGString(StringTable(var.gsym))),
            GetComputedSize(objectKey,PTGAsIs("1")),
            Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
            PTGString(StringTable(GetClpValue(FileName,0))),
            PTGNumber(coord->line),PTGString(StringTable(var.sym))
          );
          if (GetVariableDeclaredGPU(var.gobjectKey,0) == 0) {
            ResetVariableDeclaredGPU(var.gobjectKey,TRUE);
            copyToCPU = PTGSequence(
                PTGCudaDeclExtern(
                  Convert_to_CudaType(len,GetType(unitKey,ErrorType)),
                  PTGDeviceName(PTGString(StringTable(gsym)))
                ),
                copyToCPU
              );
          }
        }
        if (GetVariableRoutine(objectKey,0) == 0) {
          ResetVariableRoutine(objectKey,TRUE);
          PTGNode assignVar;
          if (GetVariableDefined(objectKey,0) == PASSED_IN) {
            assignVar = PTGAssignVar(
                  PTGIndent(2),
                  varName,
                  hostName);
          } else {
            assignVar = PTGDeclAssignVar(
                  PTGIndent(2),
                  Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
                  varName,
                  hostName);
          }
          arg = copyToCPU;
        } else {
          arg = copyToCPU;
        }
        if (GetVariableDeclaredGPU(objectKey,0) == 0) {
          PTGOut(PTGAppendNL(PTGNumber(declLine),declGlobalExtern));
          ResetVariableDeclaredGPU(objectKey,TRUE);
        }
      } else if (scope == LOCAL) {
//        arg = PTGSequence(cudaDecl,copyToCPU);
      } else if (scope == GLOBAL) {
//        arg = copyToCPU;      // variable defined in GenerateGlobalDecls()
      } else {
      }
    }
    if (intent==NONE) {
      PTGNode assignVar;
      if (scope == EXTERN) {
        arg = declExtern;
      } else if (scope == GLOBAL) {
        if (GetVariableDefined(objectKey,0) == PASSED_IN) {
          assignVar = PTGAssignVar(
                  PTGIndent(2),
                  hostName,
                  varName);
          arg = PTGSequence(assignVar,cudaMalloc);
        } else {
          arg = cudaMalloc;
        }
      } else if (scope == LOCAL) {
        arg = PTGSequence(cudaDecl,cudaMalloc);
      } else {
        // shared "local" variable defined statically
        *generated = FALSE;
        (*nArgs)--;
      }
    }
    if (GetClpValue(Analysis,0) == GLOBAL_MEMORY) {
      PTGNode sizePtg=PTGNULL;
      BoundsList blist = GetArraySizeList(rvar.objectKey, NULLBoundsList);
      int length = LengthBoundsList(blist);
      if ((scope == GLOBAL) && (intent != OUT)) {
        int j;
        for (j=1; j<=length; j++) {
          if (j==1) {
            sizePtg = ArrayBoundsPTG(blist,j,SIZE,0);
          } else {
            sizePtg = PTGMulSequence(sizePtg,ArrayBoundsPTG(blist,j,SIZE,0));
          }
        }
        arg = PTGGlobalMemoryAdd(sizePtg);
      }
    }
  } else if (mode == KERNEL_DECLS) {
    if ((GetNumberOfDims(unitKey,0) == 0) && ((scope == EXTERN) || 
        ((intent == OUT) || (intent == INOUT)))) { 
      *generated = TRUE; 
      (*nArgs)++;
      arg =
        PTGDeclAssignVar(
          PTGIndent(2),
          Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
          varName,
          PTGPointer(deviceName)
        );
    }

    if ((GetNumberOfDims(unitKey,0) == 0) && (intent == IN) &&
          (GetVariableDefined(objectKey,0) != GPU_CONSTANT) &&
        (scope != EXTERN)) { 
      *generated = TRUE; 
      (*nArgs)++;
      PTGNode scalarStructRef;
      if (argStorage > MAX_STORAGE_SIZE) {
        scalarStructRef = PTGScalarStructNamePtr(
          PTGString(StringTable(programName)),
          PTGNumber(regionNumber),
          varName
        );
      } else {
        scalarStructRef = PTGScalarStructName(
          PTGString(StringTable(programName)),
          PTGNumber(regionNumber),
          varName
        );
      }
      arg =
        PTGDeclAssignVar(
          PTGIndent(2),
          Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
          PTGString(StringTable(sym)),
          scalarStructRef
        );
    }
    if ((GetNumberOfDims(unitKey,0) > 0) && (scope == LOCAL)) {
      *generated = TRUE;
      (*nArgs)++;
      arg = PTGDeclareLocal(
          Convert_to_Ctype(len,GetType(unitKey,ErrorType)),
          GenerateArray(PTGString(StringTable(sym)),GetArraySizeList(objectKey,NULLBoundsList),objectKey,unitKey,SPACES,GPU,var.demoteDims[0],var.demoteDims[1],var.promoteDim,var.promoteType,regionVars)
      );
// test prior to replacing promoteDim with the two dimensional counterpart
if (var.promoteDim != var.promoteDims[0]) {
  fprintf(stderr,"3 - PromoteDim inconsistency.  Exit");
  exit(1);
}
    }

    if ((GetClpValue(Generate,CUDA) == CUDA) && 
        (GetNumberOfDims(var.unitKey,0) > 0) && 
        ((varS.scope == SHARED) && (var.scope == GLOBAL)) &&
        ((varS.intent == IN) || (varS.intent == INOUT))) {
      *generated = TRUE;
      (*nArgs)++;
      if (varS.scope == LOCAL) {
        arg = PTGAsIs("// Generated copy from GPU global to local memory");
      } else {
        arg = PTGAsIs("// Generated copy from GPU global to shared memory");
      }
      arg = PTGSequenceCR(arg,CopySharedData(var,varS,mode,regionVars,coord));
    }

        // no copies, but checking declarations and usage
    if ((GetClpValue(Generate,CUDA) == CUDA)  &&
        (GetNumberOfDims(unitKey,0) > 0) && 
        ((var.scope == GLOBAL) && (varS.scope == SHARED)) &&
        ((varS.intent == NONE) || (varS.intent == OUT))) {
      *generated = TRUE;
      (*nArgs)++;
      arg = CopySharedData(var,varS,mode,regionVars,coord);
    }
  } else if (mode == KERNEL_DECLS_END) {
    if ((GetNumberOfDims(unitKey,0) == 0) && 
        ((intent == OUT) || (intent == INOUT))) { 
      *generated = TRUE; 
      (*nArgs)++;
      arg = PTGAssignVar(
          PTGIndent(2),
          PTGPointer(deviceName),
          varName
        );
    }
    if ((GetClpValue(Generate,CUDA) == CUDA) && 
        (GetNumberOfDims(unitKey,0) > 0) && 
        ((var.scope == GLOBAL) && 
        ((varS.scope == SHARED)) || (varS.scope == LOCAL)) &&
        ((varS.intent == OUT) || (varS.intent == INOUT))) {
      *generated = TRUE;
      (*nArgs)++;
      if (varS.scope == LOCAL) {
        arg = PTGAsIs("// Generated copy from GPU local to global memory");
      } else {
        arg = PTGAsIs("// Generated copy from GPU shared to global memory");
      }
      arg = PTGSequenceCR(arg,CopySharedData(var,varS,mode,regionVars,coord));
    }
  } else if (mode == SUBR_END) {
// printf("DEBUG SUBR_END: var = %s line = %d GetVariableGPU = %d intent = %d GetVariableCPU = %d GetVariableAllocated = %d  GetVariableDefined = %d GetVariableDeclaredGPU = %d ndims = %d scope = %d\n",StringTable(sym),coord->line,GetVariableGPU(objectKey,0),GetIntent(objectKey,0),GetVariableCPU(objectKey,0),GetVariableAllocated(objectKey,0),GetVariableDefined(objectKey,0),GetVariableDeclaredGPU(objectKey,0),GetNumberOfDims(unitKey,0),GetVariableScopeGPU(objectKey,0));
        /* update scalars that are passed in as subroutine arguments */
    if ((GetNumberOfDims(unitKey,0) == 0) && (GetVariableDefined(objectKey,0) == PASSED_IN)) {
        // all C variables, GPU variables with intent OUT
      if (((GetClpValue(Generate,CUDA) == C) || 
           (GetClpValue(Generate,CUDA) == CUDA)) && 
                ((intent == OUT) || (intent == INOUT))) {
        *generated = TRUE; 
        (*nArgs)++;
        arg = 
          PTGAssignVar(
            PTGIndent(2),
            PTGPointer(PTGGlobalName(PTGString(StringTable(sym)))),
            varName
          );
      }
    }

        // free CPU memory for allocated local variables
    if ((GetNumberOfDims(unitKey,0) > 0) && (GetVariableAllocated(objectKey,0) == TRUE)) {
      if ((GetVariableCPU(objectKey,0)>0) || (GetVariableGPU(objectKey,0)>0)) {
        *generated = TRUE;
        (*nArgs)++;
// printf("Free memory - var = %s GetVariableGPU = %d  GetVariableCPU = %d\n",
// StringTable(sym),GetVariableGPU(objectKey,0),GetVariableCPU(objectKey,0));
        arg = PTGFreeAlloc(PTGAsIs("  "),PTGString(StringTable(sym)));
        ResetVariableAllocated(objectKey,FALSE);
      }
    }
        // free GPU memory, if gsym==0, this is a mapped variable
// printf("DEBUG SUBR_END: var = %s GetVariableGPU = %d intent = %d GetVariableCPU = %d GetVariableAllocated = %d  GetVariableDefined = %d GetVariableDeclaredGPU = %d ndims = %d scope = %d\n",StringTable(sym),GetVariableGPU(objectKey,0),GetIntent(objectKey,0),GetVariableCPU(objectKey,0),GetVariableAllocated(objectKey,0),GetVariableDefined(objectKey,0),GetVariableDeclaredGPU(objectKey,0),GetNumberOfDims(unitKey,0),GetVariableScopeGPU(objectKey,0));
    PTGNode cudaFreePtg = PTGNULL;
    if ((GetNumberOfDims(unitKey,0) == 0) && (intent == IN) &&
        (GetVariableDefined(objectKey,0) != GPU_CONSTANT)) { 
//      printf("DEBUG: var = %s nScalars = %d\n",StringTable(sym),*nScalars);
    }
    if ((GetClpValue(Generate,CUDA) == CUDA)
        && (scope != EXTERN)
                // the variable was used in a GPU region
        && (GetVariableDeclaredGPU(objectKey,0) > 0)
                // the variable is an array, or a scalar with intent OUT
        && (((GetNumberOfDims(unitKey,0) > 0) 
                && ((GetVariableDefined(objectKey,0) == LOCAL) 
                || ((GetVariableDefined(objectKey,0) == PASSED_IN)
                         && (GetVariableScopeGPU(objectKey,0) != EXTERN))))
         || ((GetNumberOfDims(unitKey,0)==0) && 
                ((GetVariableIntentGPU(objectKey,0)==OUT)
              || (GetVariableIntentGPU(objectKey,0) == INOUT))))
                // the variable is not mapped to another variable
        && (gsym == 0)) {
      *generated = TRUE;
      (*nArgs)++;
      cudaFreePtg = PTGCudaFree(
        PTGDeviceName(varName),
        PTGString(StringTable(GetClpValue(FileName,0))),
        PTGNumber(coord->line),varName
      );
      ResetVariableDeclaredGPU(objectKey,FALSE);
    }
    arg = PTGSequence(arg,cudaFreePtg);
  } else {
    return(arg);
  }
  return(arg);
}

void GeneratePromotedVariable(GPUVars var,RegionVars regionVars) {

int i;
PTGNode output = PTGNULL;
PTGNode GPUtype;
if (var.scope == SHARED) { 
  GPUtype = PTGAsIs(" __shared__ ");
} else {
  GPUtype = PTGAsIs(" __device__ ");
}
PTGNode varName = PTGSequence(PTGString(StringTable(var.sym)),PTGAsIs("P"));
BoundsList blist = GetArraySizeList(var.objectKey, NULLBoundsList);

int length = LengthBoundsList(blist);
PTGNode arg;
if (length > 0) {
  for (i=1; i<=length; i++) {
    Bounds bound = IthElemBoundsList(blist,i);
    if (bound.lower == 0) {
      arg = PTGString(StringTable(ToUpper(bound.upper)));
    } else {
      arg = PTGFourArgs(
        PTGString(StringTable(ToUpper(bound.upper))),
        PTGAsIs("-"),
        PTGString(StringTable(ToUpper(bound.lower))),
        PTGAsIs("+1")
      );
    }
    if (i == 1) {
      output = PTGParens(arg);
    } else {
      output = PTGMulSequence(output,PTGParens(arg));
    }
  }
}

// test prior to replacing promoteDim with the two dimensional counterpart
if (var.promoteDim != var.promoteDims[0]) {
  fprintf(stderr,"4 - PromoteDim inconsistency.  Exit");
  exit(1);
}
// now calculate and add the promoted dimension
if ((var.promoteType == THREAD) || (regionVars.threadOptionMode[var.promoteDim-1] == CHUNK)) {
  output = PTGMulSequence(output,
    PTGString(
      StringTable(ToUpper(regionVars.regionV[var.promoteDim-1])))
  );
} else {
  output = PTGMulSequence(output,
    PTGString(
      StringTable(ToUpper(regionVars.regionP[var.promoteDim-1])))
  );
}

int len = GetTypeLength(var.unitKey,0);

  PTGOut(PTGDeclareVar(
    PTGAsIs("0"),
    PTGNULL,
    GPUtype,
    Convert_to_Ctype(len,GetType(var.unitKey,ErrorType)),
    PTGArrayRef(varName,PTGBrackets(output))
  ));

return;
}

/* 
Routine to generate subcripts needed to copy data between CPU and GPU.
Subscripts are generated for two cases: global memory access and shared 
memory access.  
*/

PTGNode GenerateSubscripts(GPUVars var, RegionVars regionVars,POSITION *coord, int mode, int shared) {

int cnt=0;
int found = FALSE;
int i;
PTGNode loopVar=PTGNULL;
PTGNode loopVars=PTGNULL;
int size=0;
int threadDim[2],blockDim[2];
char msg[256],str[80];

BoundsList blist = GetArraySizeList(var.objectKey, NULLBoundsList);
int length = LengthBoundsList(blist);

for (i=0;i<3;i++) {
  threadDim[i] = FALSE;
  blockDim[i] = FALSE;
  /* if (((regionVars.threadOptionMode[i] == CHUNK) ||
       (regionVars.threadOptionMode[i] == BLOCKFACTOR)) &&  */
  if ((regionVars.threadOptionMode[i] == CHUNK) && 
       (var.scope == SHARED) &&
       (var.intent != NONE) && (mode == KERNEL_DECLS)) {
    message(ERROR,"Data copies between GPU shared and global memory with the BLOCK or CHUNK option is not supported yet.",0,coord);
  }
}

for (i=1;i<=length;i++) {
  found = FALSE;        // vector dimension found
  PTGNode lowerPtg;
  Bounds bound = IthElemBoundsList(blist,i);
  // identify the thread parallel index by matching the array dimension with
  // the declared threadBlock
  
  if (bound.lower == 0) { 
    lowerPtg = PTGAsIs("1");
    size = bound.upper;
  } else {      // integrate the upper and lower bound
    lowerPtg = PTGString(StringTable(bound.lower));
    (void) sprintf(msg,"%s-%s+1",StringTable(bound.upper),StringTable(bound.lower));
    size = MakeName(msg);
  }

  // shared memory variables use the threadId and a lower bound of 0
  if (size == regionVars.regionV[0]) {
    threadDim[0] = TRUE;
    found = TRUE;
    if ((regionVars.threadOptionMode[0] == BLOCKFACTOR) && (shared == FALSE)) {
      loopVar = PTGThreeArgs(
                        PTGAsIs("threadIdx.x%("),
                        PTGString(StringTable(size)),
                        PTGAsIs(")+"));
      loopVar = PTGSequence(loopVar,lowerPtg);
    } else {
      if (shared == TRUE) {
        loopVar = PTGAsIs("threadIdx.x");
      } else {
        loopVar = PTGAsIs("threadIdx.x+");
        loopVar = PTGSequence(loopVar,lowerPtg);
      }
    }
  }
  if (size == regionVars.regionV[1]) {
    threadDim[1] = TRUE;
    found = TRUE;
    if ((regionVars.threadOptionMode[0] == BLOCKFACTOR) && (shared == FALSE)) {
        loopVar = PTGThreeArgs(
                        PTGAsIs("threadIdx.y%("),
                        PTGString(StringTable(size)),
                        PTGAsIs(")+"));
        loopVar = PTGSequence(loopVar,lowerPtg);
    } else {
      if (shared == TRUE) {
        loopVar = PTGAsIs("threadIdx.y");
      } else {
        loopVar = PTGAsIs("threadIdx.y+");
        loopVar = PTGSequence(loopVar,lowerPtg);
      }
    }
    loopVar = PTGSequence(loopVar,lowerPtg);
  }

        // note that shared is never used for the block dimension
  if (size == regionVars.regionP[0]) {
    blockDim[0] = TRUE;
    found = TRUE;
    if ((regionVars.threadOptionMode[0] == BLOCKFACTOR)) {
      loopVar = PTGBlockIndex(
        PTGAsIs("x"),
        PTGNumber(regionVars.threadOption[0]),
        PTGAsIs("x"), PTGAsIs("x"),
        PTGNumber(regionVars.threadOption[0]),
        lowerPtg
      );
    } else {
      loopVar = PTGSequence(PTGAsIs("blockIdx.x+"),lowerPtg);
    }
  }
  if (size == regionVars.regionP[1]) {
    lowerPtg = PTGAsIs("1");
    blockDim[1] = TRUE;
    found = TRUE;
    if ((regionVars.threadOptionMode[0] == BLOCKFACTOR)) {
      loopVar = PTGBlockIndex(
        PTGAsIs("y"),
        PTGNumber(regionVars.threadOption[0]),
        PTGAsIs("y"), PTGAsIs("y"),
        PTGNumber(regionVars.threadOption[0]),
        lowerPtg
      );
    } else {
      loopVar = PTGSequence(PTGAsIs("blockIdx.y+"),lowerPtg);
    }
  }
  if (found == FALSE) {
    (void) sprintf(str,"iS%d",i);
    loopVar = PTGString(StringTable(MakeName(str)));
  }

  if (cnt == 0) {
    if ((shared == FALSE) || ((var.demoteDims[0] != i) && (var.demoteDims[1] != i))) {
      cnt++;
      loopVars = loopVar;
    }
  } else {
    if ((shared == FALSE) || ((var.demoteDims[0] != i) && (var.demoteDims[1] != i))) {
      cnt++;
      loopVars = PTGCommaArgs(loopVars,loopVar);
    }
  }
}

if (mode == KERNEL_DECLS) {
  for (i=0;i<3;i++) {
    if ((regionVars.regionV[i] > 0) && (threadDim[i] == FALSE) && (var.sym > 0)) {
      sprintf(msg,"Thread dimension: %s is different than the dimensions of the shared memory variable: %s\n",StringTable(regionVars.regionV[i]),StringTable(var.sym));
      message(WARNING,msg,0,coord);
    }
  }
}
return(loopVars);
}

/* Routine to handle data copies between GPU global and GPU shared memory */
PTGNode CopySharedData(GPUVars var,GPUVars varS,int mode,RegionVars regionVars,POSITION *coord) {

PTGNode GenerateArrayRef(GPUVars var,int gpuvar, DefTableKey objectKey, PTGNode subscripts,RegionVars regionVars,POSITION *coord,int sharedCopy);
PTGNode GenerateSubscripts(GPUVars var, RegionVars regionVars, POSITION *coord, int mode, int shared);

int i,size;
PTGNode loopVar,loopVars;
PTGNode loopsPtg=PTGNULL,loopsEndPtg=PTGNULL;
PTGNode output = PTGNULL;
char str[10],msg[80];
int found;
static int sharedLoopVarsDeclared = FALSE;

printf("DEBUG CopyShared var = %s p0: %d %s p1: %d v1: %d %s v2: %d blocking: %d   varS scope: %d intent: %d  var scope: %d intent: %d\n",StringTable(var.sym),regionVars.regionP[0],StringTable(regionVars.regionP[0]),regionVars.symP[1],regionVars.regionV[0],StringTable(regionVars.regionV[0]),regionVars.symV[1],regionVars.threadOptionMode[0],varS.scope,varS.intent,var.scope,var.intent);

// Generate auxillary loops for each array dimension

BoundsList blist = GetArraySizeList(var.objectKey, NULLBoundsList);
int length = LengthBoundsList(blist);
int indentLevel = 0;
PTGNode lowerPtg;
for (i=1;i<=length;i++) {
  found = FALSE;
  Bounds bound = IthElemBoundsList(blist,i);
  if (bound.lower == 0) { 
    size = bound.upper;
    lowerPtg = PTGAsIs("1");
  } else {      // integrate the upper and lower bound
    (void) sprintf(msg,"%s-%s+1",StringTable(bound.upper),StringTable(bound.lower));
    size = MakeName(msg);
    lowerPtg = PTGString(StringTable(bound.lower));
  }
// printf("DEBUG: lower %d size %s  %s\n",bound.lower,StringTable(size),StringTable(regionVars.regionP[0]));

  if (size == regionVars.regionV[0]) {
    loopVar = PTGAsIs("threadIdx.x+1");
    found = TRUE;
  }
  if (size == regionVars.regionV[1]) {
    loopVar = PTGAsIs("threadIdx.y+1");
    found = TRUE;
  }
  if (size == regionVars.regionP[0]) {
    loopVar = PTGAsIs("blockIdx.x+1");
    found = TRUE;
  }
  if (size == regionVars.regionP[1]) {
    loopVar = PTGAsIs("blockIdx.y+1");
    found = TRUE;
  }
  if (found == FALSE) {
// printf("DEBUG: mode: %d %s  %s\n",mode,StringTable(size),StringTable(regionVars.regionP[0]));
    indentLevel += SPACES;
    // generate the loop variable based on the array dimension
    (void) sprintf(str,"iS%d",i);
    loopVar = PTGString(StringTable(MakeName(str)));
    loopsPtg = PTGThreeArgs(
        loopsPtg,
        PTGNULL,
        PTGLoopGen(
          PTGIndent(indentLevel),
          loopVar,
          lowerPtg,
          loopVar,
          PTGString(StringTable(bound.upper)),
          loopVar
        ));
  }
}

// generate the shared or local variable reference
PTGNode sharedVar;
if (varS.scope == SHARED) {
  sharedVar = PTGSequence(PTGString(StringTable(var.sym)),PTGAsIs("S"));
} else {
  sharedVar = PTGString(StringTable(var.sym));
}
loopVars = GenerateSubscripts(varS,regionVars,coord,mode,TRUE);
PTGNode sharedRef = PTGArrayRef(sharedVar,GenerateArrayRef(varS,TRUE,varS.objectKey,loopVars,regionVars,coord,SHARED));

// generate the global variable reference
PTGNode varName;
if (varS.scope == SHARED) {
  varName = PTGString(StringTable(var.sym));
} else {
  varName = PTGSequence(PTGString(StringTable(var.sym)),PTGAsIs("G"));
}
loopVars = GenerateSubscripts(var,regionVars,coord,mode,FALSE);
PTGNode globalRef = PTGArrayRef(varName,GenerateArrayRef(var,TRUE,var.objectKey,loopVars,regionVars,coord,GLOBAL));

// generate copies from global to shared memory
if (mode == KERNEL_DECLS) {
  if ((var.intent == IN) || (var.intent == INOUT)) {
    if (sharedLoopVarsDeclared == FALSE) {
      loopsPtg = PTGSequence(PTGDeclareSharedLoopVars(),loopsPtg);
      sharedLoopVarsDeclared = TRUE;
    }

    output = PTGSequence(
        loopsPtg,
        PTGAssignVar(PTGIndent(indentLevel+SPACES),sharedRef,globalRef)
    );
    for (i=indentLevel;i>0;i-=SPACES) {
      output = PTGSequence(output,PTGLoopGenEnd(PTGIndent(i)));
    }
  }
}

// generate copies from shared to global memory
if (mode == KERNEL_DECLS_END) {
//printf("DEBUG: CopyShared: var = %s scope = %d intent = %d\n",StringTable(var.sym),var.scope,var.intent);
  if (((varS.scope == SHARED) || (var.scope == LOCAL)) && 
      ((var.intent == OUT) || (var.intent == INOUT))) {
    if (sharedLoopVarsDeclared == FALSE) {
      loopsPtg = PTGSequence(PTGDeclareSharedLoopVars(),loopsPtg);
      sharedLoopVarsDeclared = TRUE;
    }
    output = PTGSequence(
        loopsPtg,
        PTGAssignVar(PTGIndent(indentLevel+SPACES),globalRef,sharedRef)
    );
    for (i=indentLevel;i>0;i-=SPACES) {
      output = PTGSequence(output,PTGLoopGenEnd(PTGIndent(i)));
    }
  }
}

return(output);
}

/* The !ACC$DATA directive is used to copy data from CPU to GPU and     **
** GPU to CPU indicated with a mode of "IN" or "OUT" respectively. The  **
** directive is used specifically during model initialization and to    **
** support model output.  The initial data copy, during model           **
** initialization will allocate memory on the GPU and copy data to the  **
** GPU.  A pointer to the GPU memory will be retained on the CPU so it  **
** can be referenced, and the memory can be deallocated when the        **
** program is complete or the memory is no longer needed.  These GPU    **
** also called device variables, are declared at the top of the routine **
** so they will have global scope, and can be referenced by other       **
** routines that run on the GPU.                                        **
**                                                                      **
** The folowing routine is used to declare global device variables and  **
** place these declarations at the top of the program so they may be    **
** accessed via "extern" declarations                                   */

PTGNode GenerateGlobalDecls(GPUVarsList list) {

  int length = LengthGPUVarsList(list);
  int j;
  PTGNode output = PTGNULL;
  PTGNode arg;
  int nArgs = 0;  /* number of arguments output */

  if (length > 0) {     /* process the GPU variables */
        /* output declarations that will be global scope */
    for (j=1; j<=length; j++) {
      var = IthElemGPUVarsList(list,j);
      if ((var.scope == GLOBAL) && ((var.intent==IN) || (var.intent==NONE))) {
        nArgs++;
// printf("DEBUG: GenerateGlobalDecls var = %s\n",StringTable(var.sym));
        int len = GetTypeLength(var.unitKey,0);

        arg = PTGCudaGlobalDecl(
          Convert_to_CudaType(len,GetType(var.unitKey,ErrorType)),
          PTGDeviceName(PTGString(StringTable(var.sym))),
          PTGPointer(PTGHostName(PTGString(StringTable(var.sym))))
        );
        if (nArgs == 1) { output = arg; }
        if (nArgs > 1) { output = PTGSequence(output,arg);}
      }
    }
  }
/*
 printf("DEBUG: GenerateGlobalDecls returning:");
 PTGOut(output);
 printf("\n");
*/
  return(output);
}

/* This function is used to determine if a user defined constant        **
** (using the --ThreadBlock=[value]) is numeric or a variable constant. **
** The function returns TRUE if it's strictly numeric.                  */
int IsNumeric(int idx) {
int i;
char *threads = StringTable(idx);

for (i=0;i<strlen(threads);i++) {
  if (isdigit(*(threads+i))==0) { return(FALSE); }
}
return(TRUE);
}

int InGPUVarsList(GPUVarsList list,int sym) {

  int j;
  int len = LengthGPUVarsList(list);
  if (len > 0) {
    for (j=1;j<=len;j++) {
      var = IthElemGPUVarsList(list,j);
      if (var.sym == sym) { printf("returning TRUE\n"); return(TRUE); }
    }
  }
  return(FALSE);
}

int InVariableUseList(VariableUseList rlist,int sym) {

  int j;
  int len = LengthVariableUseList(rlist);
  if (len > 0) {
    for (j=1;j<=len;j++) {
      rvar = IthElemVariableUseList(rlist,j);
fprintf(stderr,"InVariableUseList var = %s j: %d %s\n",StringTable(sym),j,StringTable(rvar.sym));
      if (rvar.sym == sym) { return(TRUE); }
    }
  }
  return(FALSE);
}

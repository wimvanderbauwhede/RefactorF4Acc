#ifndef _PTGGEN_H
#define _PTGGEN_H

#include <stdio.h>
#include "eliproto.h"

/* Include-files specified in .ptg.phi-files */

#include "ptg.h"
/* Definition of Output-Macros */

#if !defined(PTG_OUTPUT_FILE)
#    define PTG_OUTPUT_FILE FILE *
#    define PTG_OUTPUT_DEFAULT 1
#else
#    define PTG_OUTPUT_DEFAULT 0
#endif
#if !defined(PTG_OUTPUT_STRING)
#    define PTG_OUTPUT_STRING(file,param) fputs(param, file)
#    if !defined(PTG_OUTPUT_INT)
#            define PTG_OUTPUT_INT(file,param)    fprintf(file,"%d",param)
#    endif
#    if !defined(PTG_OUTPUT_LONG)
#            define PTG_OUTPUT_LONG(file,param)   fprintf(file,"%ld",param)
#    endif
#    if !defined(PTG_OUTPUT_SHORT)
#            define PTG_OUTPUT_SHORT(file,param)  fprintf(file,"%d",(int) param)
#    endif
#    if !defined(PTG_OUTPUT_CHAR)
#            define PTG_OUTPUT_CHAR(file,param)   fputc(param, file)
#    endif
#    if !defined(PTG_OUTPUT_FLOAT)
#            define PTG_OUTPUT_FLOAT(file,param)  fprintf(file,"%g",(double)param)
#    endif
#    if !defined(PTG_OUTPUT_DOUBLE)
#            define PTG_OUTPUT_DOUBLE(file,param) fprintf(file,"%g",param)
#    endif

#else
     /* PTG_OUTPUT_STRING defined */
     extern void _PTGPrintInt ELI_ARG((PTG_OUTPUT_FILE,int));
     extern void _PTGPrintLong ELI_ARG((PTG_OUTPUT_FILE,long));
     extern void _PTGPrintChar ELI_ARG((PTG_OUTPUT_FILE,char));
     extern void _PTGPrintDouble ELI_ARG((PTG_OUTPUT_FILE,double));
#    if !defined(PTG_OUTPUT_INT)
#            define PTG_OUTPUT_INT(file,param)    _PTGPrintInt(file,param)
#    endif
#    if !defined(PTG_OUTPUT_LONG)
#            define PTG_OUTPUT_LONG(file,param)   _PTGPrintLong(file,param)
#    endif
#    if !defined(PTG_OUTPUT_SHORT)
#            define PTG_OUTPUT_SHORT(file,param)  _PTGPrintInt(file,(int)param)
#    endif
#    if !defined(PTG_OUTPUT_CHAR)
#            define PTG_OUTPUT_CHAR(file,param)   _PTGPrintChar(file,param)
#    endif
#    if !defined(PTG_OUTPUT_FLOAT)
#            define PTG_OUTPUT_FLOAT(file,param)  _PTGPrintDouble(file,(double)param)
#    endif
#    if !defined(PTG_OUTPUT_DOUBLE)
#            define PTG_OUTPUT_DOUBLE(file,param) _PTGPrintDouble(file,param)
#    endif
#endif

/* Define PTGNode Type */
#if defined(__cplusplus)
struct _SPTG0;
typedef void (* _PTGProc)(struct _SPTG0 *);
#else
typedef void (* _PTGProc)();
#endif

typedef struct _SPTG0
{
  _PTGProc _print;
} * _PPTG0;
typedef _PPTG0 PTGNode;                      /* the only exported type */

/* predefined static PTGNULL-Node */

extern struct _SPTG0 _PTGNULL;
#define PTGNULL (& _PTGNULL)
#define PTGNull() (& _PTGNULL)

/* output functions */

#if PTG_OUTPUT_DEFAULT
extern PTGNode PTGOut ELI_ARG((PTGNode root));
extern PTGNode PTGOutFile ELI_ARG((const char *filename, PTGNode root));
extern PTGNode PTGOutFPtr ELI_ARG((FILE *output, PTGNode root));
#endif
extern PTGNode PTGProcess ELI_ARG((PTG_OUTPUT_FILE file, PTGNode root));

/* Memory Management functions. */

extern void PTGFree ELI_ARG((void));

/* ============================ */
/* functions for making PTG nodes */
PTGNode PTGId ELI_ARG((int p1));
PTGNode PTGAsIs ELI_ARG((CONST char* p1));
PTGNode PTGNumb ELI_ARG((int p1));
PTGNode PTGCString ELI_ARG((CONST char* p1));
PTGNode PTGCChar ELI_ARG((int p1));
PTGNode PTGPString ELI_ARG((CONST char* p1));
PTGNode PTGSeq ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGCommaSeq ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGEol ELI_ARG((PTGNode p1));
PTGNode PTGSize ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGFArrayArgs ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGGlobalSize ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGLowBounds ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGUpperBounds ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGFourArgs ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGAccDoLoop1 ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7, PTGNode p8));
PTGNode PTGAccDoLoop ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7, PTGNode p8, PTGNode p9));
PTGNode PTGAppend ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGAppendNL ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGAppendMaxMinStmt ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGArrayDim ELI_ARG((PTGNode p1));
PTGNode PTGArrayDimSize ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGBeginAppend ELI_ARG((PTGNode p1));
PTGNode PTGBrackets ELI_ARG((PTGNode p1));
PTGNode PTGArrayRef ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGArrayRefArg ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGArraySize ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGAssignStmt1 ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGAssignStmt2 ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGBlockIndex ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6));
PTGNode PTGBlockIndex0 ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5));
PTGNode PTGBlockIndexDef ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGBlockThread ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGCommaArgs ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGComplexConst ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGC_Decl ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGDataStmt ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6));
PTGNode PTGDeclareLoopVar ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGDefAppend ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGDeviceInit ELI_ARG((void));
PTGNode PTGDefineGlobalCR ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGDefineGlobalCRP ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGElse ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGElseIf ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGEndAppend ELI_ARG((void));
PTGNode PTGEndifStmt ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGEndLoop ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5));
PTGNode PTGEndLoopAppend ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGExit ELI_ARG((void));
PTGNode PTGEndRoutine ELI_ARG((PTGNode p1));
PTGNode PTGEndRoutineGPU ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGExpr ELI_ARG((PTGNode p1));
PTGNode PTGExprArgs ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGExternDecl ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGFreeAlloc ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGForLoop ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGFTNFunction ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGFunctionCall ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGFunctionDecl ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5));
PTGNode PTGFunctionRef ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGGenerateForLoop ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6));
PTGNode PTGGenerateEndLoop ELI_ARG((PTGNode p1));
PTGNode PTGGlobalMemoryDeclareVars ELI_ARG((void));
PTGNode PTGGPUReturn ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6));
PTGNode PTGGoTo ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGIfThread ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5));
PTGNode PTGIfThreadEnd ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGIfStmt ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGIfStmtSingle ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5));
PTGNode PTGIfStmtLabel ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5));
PTGNode PTGIncludeFilesCPU ELI_ARG((void));
PTGNode PTGIncludeFilesGPU ELI_ARG((void));
PTGNode PTGIndent ELI_ARG((int p1));
PTGNode PTGIntrinsicRef ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGKind ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGLabelDef ELI_ARG((PTGNode p1));
PTGNode PTGLabelRef ELI_ARG((PTGNode p1));
PTGNode PTGLoopBounds ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5));
PTGNode PTGLoopGen ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6));
PTGNode PTGLoopGenEnd ELI_ARG((PTGNode p1));
PTGNode PTGMalloc ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6));
PTGNode PTGMallocTest ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5));
PTGNode PTGMax ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGMin ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGMod ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGMulSequence ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGNumber ELI_ARG((int p1));
PTGNode PTGParens ELI_ARG((PTGNode p1));
PTGNode PTGPowerExprFTN ELI_ARG((void));
PTGNode PTGPowerExprFTND ELI_ARG((void));
PTGNode PTGPowerExpr ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGPowerExprD ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGPowerVarsInit ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGPowerVarsInitD ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGPowerVarsFloat ELI_ARG((void));
PTGNode PTGPowerVarsDouble ELI_ARG((void));
PTGNode PTGQuotedString ELI_ARG((PTGNode p1));
PTGNode PTGRemove ELI_ARG((PTGNode p1));
PTGNode PTGReplace ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGReplaceNoCR ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGReplaceMaxMin ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGRetName ELI_ARG((PTGNode p1));
PTGNode PTGReturn ELI_ARG((PTGNode p1));
PTGNode PTGBreak ELI_ARG((PTGNode p1));
PTGNode PTGReturnExpr ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGSequence ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGSequenceCR1 ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGSharedBlock ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGSQRmacro ELI_ARG((PTGNode p1));
PTGNode PTGStmtFunction ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGStrideLoopBounds ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6));
PTGNode PTGStrideNegLoopBounds ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6));
PTGNode PTGString ELI_ARG((CONST char* p1));
PTGNode PTGSubroutineArg ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGStaticVar ELI_ARG((void));
PTGNode PTGSubroutine_forCPU ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6));
PTGNode PTGSubroutine_forGPU1 ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7, PTGNode p8));
PTGNode PTGSubroutine_forGPU ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7, PTGNode p8, PTGNode p9));
PTGNode PTGSubroutineCallNoArgs ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGSubroutineCall ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGSubroutineExtern ELI_ARG((PTGNode p1));
PTGNode PTGSubroutineNoArgs_forCPU ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5));
PTGNode PTGSubroutineStmt_M4 ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGSubroutineStmt ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGThreadIndex ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGThreadIndexDef ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGThreeArgs ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGVoid ELI_ARG((void));
PTGNode PTGAccRegion ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGAccSync ELI_ARG((void));
PTGNode PTGAllocateLocal ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGAssignVar ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGBlocks ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGCudaDecl ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGCudaGlobalDecl ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGCudaGlobalExternDecl ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGCudaDeclExtern ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGCudaMalloc ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6));
PTGNode PTGCudaMemcpyToCPU ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7));
PTGNode PTGCudaMemcpyToGPU ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7));
PTGNode PTGCudaMemcpyToSymbol ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7));
PTGNode PTGCudaFree ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGCommaArgs3 ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGCondExpr ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGCondExprSimple ELI_ARG((PTGNode p1));
PTGNode PTGCondExprSimpleNeg ELI_ARG((PTGNode p1));
PTGNode PTGDeclAssignVar ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGDeclAssignExtern ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7));
PTGNode PTGDeclareErrorVar ELI_ARG((PTGNode p1));
PTGNode PTGDeclareLocal ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGDeclareVar ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5));
PTGNode PTGDeclareSharedLoopVars ELI_ARG((void));
PTGNode PTGDeviceName ELI_ARG((PTGNode p1));
PTGNode PTGExternAssign ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGGlobalName ELI_ARG((PTGNode p1));
PTGNode PTGHostName ELI_ARG((PTGNode p1));
PTGNode PTGKernelProgramName ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGKernelRoutineCopyEnd ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGKernelRoutineEnd ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGKernelRoutineStart ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5));
PTGNode PTGKernelCall ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4, PTGNode p5, PTGNode p6, PTGNode p7, PTGNode p8, PTGNode p9, PTGNode p10, PTGNode p11));
PTGNode PTGKernelCopyArgsIn ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGPointer ELI_ARG((PTGNode p1));
PTGNode PTGVariableAddr ELI_ARG((PTGNode p1));
PTGNode PTGScalarStruct ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGScalarStructVar ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGScalarStructDecl ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3, PTGNode p4));
PTGNode PTGScalarStructBegin ELI_ARG((void));
PTGNode PTGScalarStructEnd ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGScalarStructName ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGScalarStructNamePtr ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGScalarStructField ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGSequenceCR ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGLineCR ELI_ARG((PTGNode p1));
PTGNode PTGSharedDim1 ELI_ARG((PTGNode p1));
PTGNode PTGSharedDim2 ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGTimerDecl ELI_ARG((void));
PTGNode PTGThread ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGThreadEnd ELI_ARG((PTGNode p1));
PTGNode PTGThreadMod ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGThreads ELI_ARG((PTGNode p1, PTGNode p2));
PTGNode PTGDataSectionBlockFactor ELI_ARG((PTGNode p1));
PTGNode PTGDataSectionChevrons ELI_ARG((PTGNode p1));
PTGNode PTGDataSectionDemotePTG ELI_ARG((PTGNode p1));
PTGNode PTGDataSectionPromotePTG ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGDataSectionRename ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGDataSectionVarUsage ELI_ARG((PTGNode p1, PTGNode p2, PTGNode p3));
PTGNode PTGGlobalMemoryAdd ELI_ARG((PTGNode p1));
PTGNode PTGGlobalMemoryInit ELI_ARG((void));
PTGNode PTGGlobalMemorySizeOutput ELI_ARG((PTGNode p1));

/* prototypes for used function call insertions */

void PtgOutId ELI_ARG((PTG_OUTPUT_FILE, int));
void CPtgOutstr ELI_ARG((PTG_OUTPUT_FILE, CONST char*));
void CPtgOutchar ELI_ARG((PTG_OUTPUT_FILE, int));
void PPtgOutstr ELI_ARG((PTG_OUTPUT_FILE, CONST char*));
void IndentNewLine ELI_ARG((PTG_OUTPUT_FILE));
void IndentLabl ELI_ARG((PTG_OUTPUT_FILE, int));
/* ============================ */

#ifdef MONITOR
/* Monitoring support for structured values */
#define DAPTO_RESULTPTGNode(n) DAPTO_RESULT_PTR(n)
#define DAPTO_ARGPTGNode(n) DAPTO_ARG_PTR(n, PTGNode)
#endif

#endif

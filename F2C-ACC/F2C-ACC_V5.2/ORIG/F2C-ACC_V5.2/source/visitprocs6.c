
#include "HEAD.h"
#include "err.h"
#include "node.h"
#include "visitprocs.h"
#include "attrpredef.h"

#include "visitmap.h"

#ifdef MONITOR
#include "attr_mon_dapto.h"
#include "liga_dapto.h"
#endif

#ifndef _VisitVarDecl
#define _VisitVarDecl()
#endif

#ifndef _VisitEntry
#define _VisitEntry()
#endif

#ifndef _VisitExit
#define _VisitExit()
#endif


#if defined(__STDC__) || defined(__cplusplus)
#define _CALL_VS_(args) (void (*)args)
#else
#define _CALL_VS_(args) 
#endif
extern DefTableKey* _IG_incl60;
extern int* _IG_incl59;
extern int* _IG_incl57;
extern int* _IG_incl58;
extern int* _IG_incl54;
extern int* _IG_incl53;
extern int* _IG_incl52;
extern BoundsList* _IG_incl51;
extern int* _IG_incl50;
extern int* _IG_incl49;
extern int* _IG_incl48;
extern int* _IG_incl47;
extern int* _IG_incl46;
extern ProgDeclsList* _IG_incl43;
extern VariableUseList* _IG_incl42;
extern DefTableKey* _IG_incl40;
extern int* _IG_incl39;
extern int* _IG_incl38;
extern int* _IG_incl35;
extern int* _IG_incl34;
extern KindSetElement* _IG_incl31;
extern Environment* _IG_incl22;
extern DefTableKey* _IG_incl26;
extern Environment* _IG_incl23;
extern int* _IG_incl21;
extern int* _IG_incl20;
extern int* _IG_incl18;
extern int* _IG_incl17;
extern int* _IG_incl16;
extern Mote* _IG_incl15;
extern int* _IG_incl14;
extern int* _IG_incl13;
extern Mote* _IG_incl12;
extern int* _IG_incl11;
extern int* _IG_incl10;
extern int* _IG_incl9;
extern int* _IG_incl7;
extern int* _IG_incl19;
extern int* _IG_incl8;
extern int* _IG_incl5;
extern int* _IG_incl4;
extern int* _IG_incl2;
extern int* _IG_incl1;
extern int* _IG_incl0;
extern int* _IG_incl6;

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_605(_TPPrule_605 _currn)
#else
void _VS1rule_605(_currn )
_TPPrule_605 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_605(_TPPrule_605 _currn)
#else
void _VS2rule_605(_currn )
_TPPrule_605 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_605(_TPPrule_605 _currn)
#else
void _VS3rule_605(_currn )
_TPPrule_605 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_605(_TPPrule_605 _currn)
#else
void _VS4rule_605(_currn )
_TPPrule_605 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_605(_TPPrule_605 _currn)
#else
void _VS5rule_605(_currn )
_TPPrule_605 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_605(_TPPrule_605 _currn)
#else
void _VS6rule_605(_currn )
_TPPrule_605 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(4548)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_606(_TPPrule_606 _currn)
#else
void _VS1rule_606(_currn )
_TPPrule_606 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_606(_TPPrule_606 _currn)
#else
void _VS2rule_606(_currn )
_TPPrule_606 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_606(_TPPrule_606 _currn)
#else
void _VS3rule_606(_currn )
_TPPrule_606 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_606(_TPPrule_606 _currn)
#else
void _VS4rule_606(_currn )
_TPPrule_606 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_606(_TPPrule_606 _currn)
#else
void _VS5rule_606(_currn )
_TPPrule_606 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_606(_TPPrule_606 _currn)
#else
void _VS6rule_606(_currn )
_TPPrule_606 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(4548)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_607(_TPPrule_607 _currn)
#else
void _VS1rule_607(_currn )
_TPPrule_607 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_607(_TPPrule_607 _currn)
#else
void _VS3rule_607(_currn )
_TPPrule_607 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_607(_TPPrule_607 _currn)
#else
void _VS4rule_607(_currn )
_TPPrule_607 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_607(_TPPrule_607 _currn)
#else
void _VS5rule_607(_currn )
_TPPrule_607 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_607(_TPPrule_607 _currn)
#else
void _VS6rule_607(_currn )
_TPPrule_607 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(4548)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_608(_TPPrule_608 _currn)
#else
void _VS1rule_608(_currn )
_TPPrule_608 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_608(_TPPrule_608 _currn)
#else
void _VS3rule_608(_currn )
_TPPrule_608 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_608(_TPPrule_608 _currn)
#else
void _VS4rule_608(_currn )
_TPPrule_608 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_608(_TPPrule_608 _currn)
#else
void _VS5rule_608(_currn )
_TPPrule_608 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_608(_TPPrule_608 _currn)
#else
void _VS6rule_608(_currn )
_TPPrule_608 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(4548)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_609(_TPPrule_609 _currn)
#else
void _VS1rule_609(_currn )
_TPPrule_609 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_609(_TPPrule_609 _currn)
#else
void _VS3rule_609(_currn )
_TPPrule_609 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_609(_TPPrule_609 _currn)
#else
void _VS4rule_609(_currn )
_TPPrule_609 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_609(_TPPrule_609 _currn)
#else
void _VS5rule_609(_currn )
_TPPrule_609 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_609(_TPPrule_609 _currn)
#else
void _VS6rule_609(_currn )
_TPPrule_609 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(4548)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_610(_TPPrule_610 _currn)
#else
void _VS1rule_610(_currn )
_TPPrule_610 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_610(_TPPrule_610 _currn)
#else
void _VS2rule_610(_currn )
_TPPrule_610 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_610(_TPPrule_610 _currn)
#else
void _VS4rule_610(_currn )
_TPPrule_610 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_610(_TPPrule_610 _currn)
#else
void _VS5rule_610(_currn )
_TPPrule_610 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_610(_TPPrule_610 _currn)
#else
void _VS6rule_610(_currn )
_TPPrule_610 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATExpValue=0;
/*SPC(9238)*/
_currn->_ATObjectId=NoKey;
/*SPC(3838)*/
_currn->_ATValue=0;
/*SPC(862)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_610(_TPPrule_610 _currn)
#else
void _VS7rule_610(_currn )
_TPPrule_610 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_610(_TPPrule_610 _currn)
#else
void _VS8rule_610(_currn )
_TPPrule_610 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const33=ZERO();
/*SPC(4569)*/
_currn->_ATFunctionName=PTGNULL;
/*SPC(8976)*/
_currn->_ATDemoted=FALSE;
/*SPC(7814)*/
_currn->_ATLoopIncrNeg=
((EQ(MOD(ZERO(), 2), 1)
) ? (TRUE
) : (FALSE))
;
/*SPC(7687)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(4570)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_610(_TPPrule_610 _currn)
#else
void _VS9rule_610(_currn )
_TPPrule_610 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const18=ZERO();
/*SPC(4569)*/
_currn->_AT_const32=ZERO();
/*SPC(4569)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_610(_TPPrule_610 _currn)
#else
void _VS10rule_610(_currn )
_TPPrule_610 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATArgType=Convert_to_Ctype(_currn->_ATTypeLength_pre, LogicalType);
/*SPC(5976)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_610(_TPPrule_610 _currn)
#else
void _VS11rule_610(_currn )
_TPPrule_610 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS12rule_610(_TPPrule_610 _currn)
#else
void _VS12rule_610(_currn )
_TPPrule_610 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const34=ZERO();
/*SPC(4569)*/
_currn->_AT_const50=ZERO();
/*SPC(4569)*/
_currn->_AT_const63=ZERO();
/*SPC(4569)*/
_currn->_AT_const64=ZERO();
/*SPC(4569)*/
_currn->_AT_const65=ZERO();
/*SPC(4569)*/
_currn->_AT_const66=ZERO();
/*SPC(4569)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_611(_TPPrule_611 _currn)
#else
void _VS1rule_611(_currn )
_TPPrule_611 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_611(_TPPrule_611 _currn)
#else
void _VS2rule_611(_currn )
_TPPrule_611 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_611(_TPPrule_611 _currn)
#else
void _VS3rule_611(_currn )
_TPPrule_611 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_611(_TPPrule_611 _currn)
#else
void _VS4rule_611(_currn )
_TPPrule_611 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_611(_TPPrule_611 _currn)
#else
void _VS5rule_611(_currn )
_TPPrule_611 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_611(_TPPrule_611 _currn)
#else
void _VS6rule_611(_currn )
_TPPrule_611 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(4566)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_612(_TPPrule_612 _currn)
#else
void _VS1rule_612(_currn )
_TPPrule_612 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_612(_TPPrule_612 _currn)
#else
void _VS2rule_612(_currn )
_TPPrule_612 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_612(_TPPrule_612 _currn)
#else
void _VS3rule_612(_currn )
_TPPrule_612 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_612(_TPPrule_612 _currn)
#else
void _VS4rule_612(_currn )
_TPPrule_612 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_612(_TPPrule_612 _currn)
#else
void _VS5rule_612(_currn )
_TPPrule_612 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_612(_TPPrule_612 _currn)
#else
void _VS6rule_612(_currn )
_TPPrule_612 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(4562)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_613(_TPPrule_613 _currn)
#else
void _VS1rule_613(_currn )
_TPPrule_613 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_613(_TPPrule_613 _currn)
#else
void _VS3rule_613(_currn )
_TPPrule_613 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_613(_TPPrule_613 _currn)
#else
void _VS4rule_613(_currn )
_TPPrule_613 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_613(_TPPrule_613 _currn)
#else
void _VS5rule_613(_currn )
_TPPrule_613 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_613(_TPPrule_613 _currn)
#else
void _VS6rule_613(_currn )
_TPPrule_613 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGQuotedString(PTGString(StringTable(_currn->_ATTERM_1)));
/*SPC(4558)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_614(_TPPrule_614 _currn)
#else
void _VS1rule_614(_currn )
_TPPrule_614 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_614(_TPPrule_614 _currn)
#else
void _VS2rule_614(_currn )
_TPPrule_614 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_614(_TPPrule_614 _currn)
#else
void _VS3rule_614(_currn )
_TPPrule_614 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_614(_TPPrule_614 _currn)
#else
void _VS4rule_614(_currn )
_TPPrule_614 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_614(_TPPrule_614 _currn)
#else
void _VS5rule_614(_currn )
_TPPrule_614 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_614(_TPPrule_614 _currn)
#else
void _VS6rule_614(_currn )
_TPPrule_614 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=PTGSequence(PTGAsIs("-"), _currn->_desc1->_ATPtg);
/*SPC(4554)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_615(_TPPrule_615 _currn)
#else
void _VS1rule_615(_currn )
_TPPrule_615 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_615(_TPPrule_615 _currn)
#else
void _VS2rule_615(_currn )
_TPPrule_615 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_615(_TPPrule_615 _currn)
#else
void _VS3rule_615(_currn )
_TPPrule_615 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_615(_TPPrule_615 _currn)
#else
void _VS4rule_615(_currn )
_TPPrule_615 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_615(_TPPrule_615 _currn)
#else
void _VS5rule_615(_currn )
_TPPrule_615 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_615(_TPPrule_615 _currn)
#else
void _VS6rule_615(_currn )
_TPPrule_615 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=PTGSequence(PTGAsIs("+"), _currn->_desc1->_ATPtg);
/*SPC(4550)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_616(_TPPrule_616 _currn)
#else
void _VS1rule_616(_currn )
_TPPrule_616 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Syntax not well supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4540)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_616(_TPPrule_616 _currn)
#else
void _VS2rule_616(_currn )
_TPPrule_616 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_616(_TPPrule_616 _currn)
#else
void _VS3rule_616(_currn )
_TPPrule_616 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_616(_TPPrule_616 _currn)
#else
void _VS4rule_616(_currn )
_TPPrule_616 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_616(_TPPrule_616 _currn)
#else
void _VS5rule_616(_currn )
_TPPrule_616 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_616(_TPPrule_616 _currn)
#else
void _VS6rule_616(_currn )
_TPPrule_616 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATLength=80;
/*SPC(4538)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_617(_TPPrule_617 _currn)
#else
void _VS1rule_617(_currn )
_TPPrule_617 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Syntax not well supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4533)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_617(_TPPrule_617 _currn)
#else
void _VS3rule_617(_currn )
_TPPrule_617 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_617(_TPPrule_617 _currn)
#else
void _VS4rule_617(_currn )
_TPPrule_617 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_617(_TPPrule_617 _currn)
#else
void _VS5rule_617(_currn )
_TPPrule_617 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_617(_TPPrule_617 _currn)
#else
void _VS6rule_617(_currn )
_TPPrule_617 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATLength=80;
/*SPC(4531)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_618(_TPPrule_618 _currn)
#else
void _VS1rule_618(_currn )
_TPPrule_618 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Syntax not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4525)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_618(_TPPrule_618 _currn)
#else
void _VS2rule_618(_currn )
_TPPrule_618 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_618(_TPPrule_618 _currn)
#else
void _VS3rule_618(_currn )
_TPPrule_618 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_618(_TPPrule_618 _currn)
#else
void _VS4rule_618(_currn )
_TPPrule_618 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_618(_TPPrule_618 _currn)
#else
void _VS5rule_618(_currn )
_TPPrule_618 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_618(_TPPrule_618 _currn)
#else
void _VS6rule_618(_currn )
_TPPrule_618 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATLength=0;
/*SPC(4523)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), EQ(_currn->_ATLength, 0))) {
message(WARNING, "F2C-ACC ERROR: Length not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4489)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_619(_TPPrule_619 _currn)
#else
void _VS1rule_619(_currn )
_TPPrule_619 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_619(_TPPrule_619 _currn)
#else
void _VS2rule_619(_currn )
_TPPrule_619 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_619(_TPPrule_619 _currn)
#else
void _VS3rule_619(_currn )
_TPPrule_619 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_619(_TPPrule_619 _currn)
#else
void _VS4rule_619(_currn )
_TPPrule_619 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_619(_TPPrule_619 _currn)
#else
void _VS5rule_619(_currn )
_TPPrule_619 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_619(_TPPrule_619 _currn)
#else
void _VS6rule_619(_currn )
_TPPrule_619 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATLength=Convert_to_int(StringTable(_currn->_desc1->_ATLength));
/*SPC(4519)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), EQ(_currn->_ATLength, 0))) {
message(WARNING, "F2C-ACC ERROR: Length not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4489)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_620(_TPPrule_620 _currn)
#else
void _VS1rule_620(_currn )
_TPPrule_620 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_620(_TPPrule_620 _currn)
#else
void _VS2rule_620(_currn )
_TPPrule_620 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_620(_TPPrule_620 _currn)
#else
void _VS3rule_620(_currn )
_TPPrule_620 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_620(_TPPrule_620 _currn)
#else
void _VS4rule_620(_currn )
_TPPrule_620 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_620(_TPPrule_620 _currn)
#else
void _VS5rule_620(_currn )
_TPPrule_620 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_620(_TPPrule_620 _currn)
#else
void _VS6rule_620(_currn )
_TPPrule_620 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATLength=Convert_to_int(StringTable(_currn->_desc1->_ATLength));
/*SPC(4515)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), EQ(_currn->_ATLength, 0))) {
message(WARNING, "F2C-ACC ERROR: Length not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4489)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_621(_TPPrule_621 _currn)
#else
void _VS1rule_621(_currn )
_TPPrule_621 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_621(_TPPrule_621 _currn)
#else
void _VS2rule_621(_currn )
_TPPrule_621 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_621(_TPPrule_621 _currn)
#else
void _VS3rule_621(_currn )
_TPPrule_621 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_621(_TPPrule_621 _currn)
#else
void _VS4rule_621(_currn )
_TPPrule_621 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_621(_TPPrule_621 _currn)
#else
void _VS5rule_621(_currn )
_TPPrule_621 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_621(_TPPrule_621 _currn)
#else
void _VS6rule_621(_currn )
_TPPrule_621 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATLength=Convert_to_int(StringTable(_currn->_desc1->_ATLength));
/*SPC(4511)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), EQ(_currn->_ATLength, 0))) {
message(WARNING, "F2C-ACC ERROR: Length not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4489)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_622(_TPPrule_622 _currn)
#else
void _VS1rule_622(_currn )
_TPPrule_622 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_622(_TPPrule_622 _currn)
#else
void _VS2rule_622(_currn )
_TPPrule_622 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_622(_TPPrule_622 _currn)
#else
void _VS3rule_622(_currn )
_TPPrule_622 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_622(_TPPrule_622 _currn)
#else
void _VS4rule_622(_currn )
_TPPrule_622 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_622(_TPPrule_622 _currn)
#else
void _VS5rule_622(_currn )
_TPPrule_622 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_622(_TPPrule_622 _currn)
#else
void _VS6rule_622(_currn )
_TPPrule_622 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATLength=Convert_to_int(StringTable(_currn->_desc1->_ATLength));
/*SPC(4507)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), EQ(_currn->_ATLength, 0))) {
message(WARNING, "F2C-ACC ERROR: Length not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4489)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_623(_TPPrule_623 _currn)
#else
void _VS1rule_623(_currn )
_TPPrule_623 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_623(_TPPrule_623 _currn)
#else
void _VS2rule_623(_currn )
_TPPrule_623 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_623(_TPPrule_623 _currn)
#else
void _VS3rule_623(_currn )
_TPPrule_623 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_623(_TPPrule_623 _currn)
#else
void _VS4rule_623(_currn )
_TPPrule_623 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_623(_TPPrule_623 _currn)
#else
void _VS5rule_623(_currn )
_TPPrule_623 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=Convert_to_int(StringTable(IdnNumb(0, xIcon)));
/*SPC(4630)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_623(_TPPrule_623 _currn)
#else
void _VS6rule_623(_currn )
_TPPrule_623 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATLength=_currn->_desc1->_ATLength;
/*SPC(4503)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_624(_TPPrule_624 _currn)
#else
void _VS1rule_624(_currn )
_TPPrule_624 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_624(_TPPrule_624 _currn)
#else
void _VS3rule_624(_currn )
_TPPrule_624 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_624(_TPPrule_624 _currn)
#else
void _VS4rule_624(_currn )
_TPPrule_624 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_624(_TPPrule_624 _currn)
#else
void _VS5rule_624(_currn )
_TPPrule_624 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_624(_TPPrule_624 _currn)
#else
void _VS6rule_624(_currn )
_TPPrule_624 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_625(_TPPrule_625 _currn)
#else
void _VS1rule_625(_currn )
_TPPrule_625 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_625(_TPPrule_625 _currn)
#else
void _VS2rule_625(_currn )
_TPPrule_625 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_625(_TPPrule_625 _currn)
#else
void _VS3rule_625(_currn )
_TPPrule_625 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_625(_TPPrule_625 _currn)
#else
void _VS4rule_625(_currn )
_TPPrule_625 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_625(_TPPrule_625 _currn)
#else
void _VS5rule_625(_currn )
_TPPrule_625 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_625(_TPPrule_625 _currn)
#else
void _VS6rule_625(_currn )
_TPPrule_625 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATLength=_currn->_desc1->_ATLength;
/*SPC(4494)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), EQ(_currn->_ATLength, 0))) {
message(WARNING, "F2C-ACC ERROR: Length not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4489)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_626(_TPPrule_626 _currn)
#else
void _VS1rule_626(_currn )
_TPPrule_626 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4223)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_626(_TPPrule_626 _currn)
#else
void _VS3rule_626(_currn )
_TPPrule_626 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_626(_TPPrule_626 _currn)
#else
void _VS4rule_626(_currn )
_TPPrule_626 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_626(_TPPrule_626 _currn)
#else
void _VS5rule_626(_currn )
_TPPrule_626 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const32=ZERO();
/*SPC(4219)*/
_currn->_ATSym=0;
/*SPC(4220)*/
_currn->_ATPtg=PTGNULL;
/*SPC(4221)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_626(_TPPrule_626 _currn)
#else
void _VS6rule_626(_currn )
_TPPrule_626 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const34=ZERO();
/*SPC(4219)*/
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_627(_TPPrule_627 _currn)
#else
void _VS1rule_627(_currn )
_TPPrule_627 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_627(_TPPrule_627 _currn)
#else
void _VS2rule_627(_currn )
_TPPrule_627 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_627(_TPPrule_627 _currn)
#else
void _VS3rule_627(_currn )
_TPPrule_627 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_627(_TPPrule_627 _currn)
#else
void _VS4rule_627(_currn )
_TPPrule_627 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_627(_TPPrule_627 _currn)
#else
void _VS5rule_627(_currn )
_TPPrule_627 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const32=_currn->_desc1->_AT_const32;
/*SPC(4210)*/
_currn->_ATSym=_currn->_desc1->_ATValue;
/*SPC(4216)*/
_currn->_ATPtg=
((EQ((* _IG_incl46), TRUE)
) ? (_currn->_desc1->_ATPtg
) : (_currn->_desc1->_ATPtg))
;
/*SPC(4211)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_627(_TPPrule_627 _currn)
#else
void _VS6rule_627(_currn )
_TPPrule_627 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=_currn->_desc1->_AT_const34;
/*SPC(4210)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_628(_TPPrule_628 _currn)
#else
void _VS1rule_628(_currn )
_TPPrule_628 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUnitBind=BindIdn((* _IG_incl23), _currn->_ATSym);
/*SPC(47)*/
_currn->_ATUnitKey=KeyOf(_currn->_ATUnitBind);
/*SPC(49)*/

if (EQ(GetType(_currn->_ATUnitKey, NoKey), NoKey)) {
ResetType(_currn->_ATUnitKey, ParameterType(_currn->_ATSym, (&( _currn->_AT_pos))));

} else {
}
;
/*SPC(2780)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_628(_TPPrule_628 _currn)
#else
void _VS2rule_628(_currn )
_TPPrule_628 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
GuaranteeType(_currn->_ATUnitKey, DefaultType(_currn->_ATSym));
/*SPC(1610)*/
_currn->_ATCoord=(&( _currn->_AT_pos));
/*SPC(2988)*/
_currn->_ATBind=BindIdn((* _IG_incl22), _currn->_ATSym);
/*SPC(183)*/
_currn->_ATKey=KeyOf(_currn->_ATBind);
/*SPC(185)*/
_currn->_ATObjectKey=
((_currn->_ATKey
) ? (_currn->_ATKey
) : (_currn->_ATUnitKey))
;
/*SPC(2892)*/
_currn->_ATPtg=PTGString(StringTable(_currn->_ATTERM_1));
/*SPC(4172)*/

if (GE(isModule(((_currn->_AT_pos).line)), TRUE)) {
ResetVariableDefined(_currn->_ATObjectKey, MODULE);

} else {

if (EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0)) {
ResetVariableDefined(_currn->_ATObjectKey, CONSTANT);

} else {
}
;
}
;
/*SPC(5011)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_629(_TPPrule_629 _currn)
#else
void _VS1rule_629(_currn )
_TPPrule_629 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
InsertKindSet(_currn->_desc1->_ATUnitKey, Constant);
/*SPC(3351)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_629(_TPPrule_629 _currn)
#else
void _VS2rule_629(_currn )
_TPPrule_629 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_629(_TPPrule_629 _currn)
#else
void _VS3rule_629(_currn )
_TPPrule_629 _currn;

#endif
{
int* _IL_incl58;

_VisitVarDecl()
_VisitEntry();
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATIsConstant);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsConstant=TRUE;
/*SPC(4234)*/
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
ResetVariableConstant(_currn->_desc1->_ATObjectKey, _currn->_desc2->_ATValue);
/*SPC(4243)*/
_currn->_ATProgDeclsTakeIt=1;
/*SPC(562)*/
_currn->_ATProgDeclsElem=PkgProgDecls(_currn->_desc1->_ATSym, _currn->_desc1->_ATObjectKey, _currn->_desc1->_ATUnitKey, CONSTANT);
/*SPC(13242)*/
_currn->_AT_cProgDeclsListPtr_post=
((_currn->_ATProgDeclsTakeIt
) ? (RefEndConsProgDeclsList(_currn->_AT_cProgDeclsListPtr_pre, _currn->_ATProgDeclsElem)
) : (_currn->_AT_cProgDeclsListPtr_pre))
;
/*SPC(563)*/

if (GE(_currn->_desc2->_AT_const32, 1)) {
ResetVariableConstantValue(_currn->_desc1->_ATObjectKey, PTGParens(_currn->_desc2->_ATPtg));

} else {
ResetVariableConstantValue(_currn->_desc1->_ATObjectKey, _currn->_desc2->_ATPtg);
}
;
/*SPC(4237)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(4236)*/
_IG_incl58=_IL_incl58;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_629(_TPPrule_629 _currn)
#else
void _VS4rule_629(_currn )
_TPPrule_629 _currn;

#endif
{
int* _IL_incl58;

_VisitVarDecl()
_VisitEntry();
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATIsConstant);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), EQ(isModule(_currn->_AT_line), FALSE))) {
ResetVariableRoutine(_currn->_desc1->_ATObjectKey, TRUE);

} else {
}
;
/*SPC(4154)*/
_currn->_ATdefinePtg_RuleAttr_1086=
((GE(_currn->_desc2->_AT_const32, 1)
) ? (PTGDefineGlobalCRP(Convert_to_Ctype(GetTypeLength(_currn->_desc1->_ATUnitKey, 0), GetType(_currn->_desc1->_ATUnitKey, ErrorType)), _currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)
) : (PTGDefineGlobalCR(Convert_to_Ctype(GetTypeLength(_currn->_desc1->_ATUnitKey, 0), GetType(_currn->_desc1->_ATUnitKey, ErrorType)), _currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)))
;
/*SPC(4141)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(isModule(_currn->_AT_line), FALSE), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA))))) {
PTGOut(PTGAppend(PTGNumber(MapLine(_currn->_AT_line)), _currn->_ATdefinePtg_RuleAttr_1086));

} else {
}
;
/*SPC(4166)*/
_IG_incl58=_IL_incl58;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_630(_TPPrule_630 _currn)
#else
void _VS1rule_630(_currn )
_TPPrule_630 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_630(_TPPrule_630 _currn)
#else
void _VS2rule_630(_currn )
_TPPrule_630 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_630(_TPPrule_630 _currn)
#else
void _VS3rule_630(_currn )
_TPPrule_630 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_AT_cProgDeclsListPtr_pre=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_630(_TPPrule_630 _currn)
#else
void _VS4rule_630(_currn )
_TPPrule_630 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_631(_TPPrule_631 _currn)
#else
void _VS1rule_631(_currn )
_TPPrule_631 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_631(_TPPrule_631 _currn)
#else
void _VS2rule_631(_currn )
_TPPrule_631 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_631(_TPPrule_631 _currn)
#else
void _VS3rule_631(_currn )
_TPPrule_631 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_631(_TPPrule_631 _currn)
#else
void _VS4rule_631(_currn )
_TPPrule_631 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_632(_TPPrule_632 _currn)
#else
void _VS1rule_632(_currn )
_TPPrule_632 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const57=ZERO();
/*SPC(4093)*/
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_632(_TPPrule_632 _currn)
#else
void _VS2rule_632(_currn )
_TPPrule_632 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATStmtId=FALSE;
/*SPC(4820)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_632(_TPPrule_632 _currn)
#else
void _VS3rule_632(_currn )
_TPPrule_632 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATParameterAttr=TRUE;
/*SPC(4094)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_632(_TPPrule_632 _currn)
#else
void _VS4rule_632(_currn )
_TPPrule_632 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const59=ZERO();
/*SPC(4093)*/
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_632(_TPPrule_632 _currn)
#else
void _VS5rule_632(_currn )
_TPPrule_632 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const58=ZERO();
/*SPC(4093)*/
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xAttribute specification is  not supported.");
/*SPC(4866)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_633(_TPPrule_633 _currn)
#else
void _VS1rule_633(_currn )
_TPPrule_633 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_633(_TPPrule_633 _currn)
#else
void _VS2rule_633(_currn )
_TPPrule_633 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_633(_TPPrule_633 _currn)
#else
void _VS3rule_633(_currn )
_TPPrule_633 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_633(_TPPrule_633 _currn)
#else
void _VS4rule_633(_currn )
_TPPrule_633 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_633(_TPPrule_633 _currn)
#else
void _VS5rule_633(_currn )
_TPPrule_633 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_633(_TPPrule_633 _currn)
#else
void _VS6rule_633(_currn )
_TPPrule_633 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATSizeValue=MakeName(CatStrStr(CatStrStr(CatStrStr(StringTable(_currn->_desc2->_ATValue), "-("), StringTable(_currn->_desc1->_ATValue)), ")+1"));
/*SPC(4046)*/
_currn->_ATUpperValue=
((EQ((* _IG_incl47), 1)
) ? (0
) : (_currn->_desc2->_ATValue))
;
/*SPC(4041)*/
_currn->_ATLowerValue=
((EQ((* _IG_incl47), 1)
) ? (_currn->_ATSizeValue
) : (_currn->_desc1->_ATValue))
;
/*SPC(4036)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_633(_TPPrule_633 _currn)
#else
void _VS7rule_633(_currn )
_TPPrule_633 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ((* _IG_incl34), ASSIGN)))) {
message(ERROR, "Fortran 90 array syntax is not supported within an ACC$REGION.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8173)*/
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_633(_TPPrule_633 _currn)
#else
void _VS8rule_633(_currn )
_TPPrule_633 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const33=ADD(_currn->_desc1->_AT_const33, _currn->_desc2->_AT_const33);
/*SPC(4032)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATvariableName_RuleAttr_1090=PTGSequence(PTGAsIs("ii_"), PTGNumber(_currn->_ATLocalIndex_pre));
/*SPC(8177)*/
_currn->_ATPtg=_currn->_ATvariableName_RuleAttr_1090;
/*SPC(8178)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_633(_TPPrule_633 _currn)
#else
void _VS9rule_633(_currn )
_TPPrule_633 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const18=ADD(_currn->_desc1->_AT_const18, _currn->_desc2->_AT_const18);
/*SPC(4032)*/
_currn->_AT_const32=ADD(_currn->_desc1->_AT_const32, _currn->_desc2->_AT_const32);
/*SPC(4032)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATF90Syntax=TRUE;
/*SPC(8175)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_633(_TPPrule_633 _currn)
#else
void _VS10rule_633(_currn )
_TPPrule_633 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (AND(EQ(_currn->_ATUpdateStmt_pre, TRUE), EQ((* _IG_incl34), ASSIGN))) {
PTGOut(PTGSequence(PTGAppend(PTGNumber(SUB(MapLine(((_currn->_AT_pos).line)), 1)), PTGGenerateForLoop(PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATvariableName_RuleAttr_1090, _currn->_desc1->_ATPtg, _currn->_ATvariableName_RuleAttr_1090, _currn->_desc2->_ATPtg, _currn->_ATvariableName_RuleAttr_1090)), PTGAppend(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGGenerateEndLoop(PTGIndent(_currn->_ATIndentLevel_pre)))));

} else {
}
;

} else {
}
;
/*SPC(8197)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATValue;
/*SPC(8169)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_633(_TPPrule_633 _currn)
#else
void _VS11rule_633(_currn )
_TPPrule_633 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const19=ADD(IDENTICAL(_currn->_desc1->_ATConstantUsed), IDENTICAL(_currn->_desc2->_ATConstantUsed));
/*SPC(4032)*/
_currn->_AT_const34=ADD(_currn->_desc1->_AT_const34, _currn->_desc2->_AT_const34);
/*SPC(4032)*/
_currn->_AT_const50=ADD(ADD(_currn->_desc1->_AT_const50, IDENTICAL(_currn->_desc1->_ATConstantUsed)), ADD(_currn->_desc2->_AT_const50, IDENTICAL(_currn->_desc2->_ATConstantUsed)));
/*SPC(4032)*/
_currn->_AT_const63=ADD(_currn->_desc1->_AT_const63, _currn->_desc2->_AT_const63);
/*SPC(4032)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(4032)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(4032)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(4032)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATLowerObject=NoKey;
/*SPC(4029)*/
_currn->_ATUpperObject=NoKey;
/*SPC(4028)*/
_currn->_ATUpperPtg=_currn->_desc2->_ATPtg;
/*SPC(4035)*/
_currn->_ATLowerPtg=_currn->_desc1->_ATPtg;
/*SPC(4034)*/
_currn->_ATSizePtg=PTGSize(_currn->_desc2->_ATPtg, _currn->_desc1->_ATPtg);
/*SPC(4033)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_634(_TPPrule_634 _currn)
#else
void _VS1rule_634(_currn )
_TPPrule_634 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_634(_TPPrule_634 _currn)
#else
void _VS2rule_634(_currn )
_TPPrule_634 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_634(_TPPrule_634 _currn)
#else
void _VS3rule_634(_currn )
_TPPrule_634 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_634(_TPPrule_634 _currn)
#else
void _VS4rule_634(_currn )
_TPPrule_634 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_634(_TPPrule_634 _currn)
#else
void _VS5rule_634(_currn )
_TPPrule_634 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=
((EQ(_currn->_ATIsArray_pre, TRUE)
) ? (ADD(_currn->_desc1->_ATLocalIndex_post, 1)
) : (_currn->_desc1->_ATLocalIndex_post))
;
/*SPC(8878)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_634(_TPPrule_634 _currn)
#else
void _VS6rule_634(_currn )
_TPPrule_634 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATValue=IndCatStrStr(CatStrStr(StringTable(_currn->_desc1->_ATValue), StringTable(MakeName(","))), StringTable(_currn->_desc2->_ATValue));
/*SPC(4008)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_634(_TPPrule_634 _currn)
#else
void _VS7rule_634(_currn )
_TPPrule_634 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=ADD(_currn->_ATArgCnt_pre, 1);
/*SPC(8952)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=SUB(_currn->_desc2->_ATArgCnt_post, 1);
/*SPC(8953)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_634(_TPPrule_634 _currn)
#else
void _VS8rule_634(_currn )
_TPPrule_634 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxMinFunct=_currn->_ATMaxMinFunct;
/*SPC(8951)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const52=PTGMod(_currn->_desc1->_AT_const52, IDENTICAL(_currn->_desc2->_ATPtg));
/*SPC(4007)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATargs_RuleAttr_1091=
((OR(EQ(GetClpValue(Generate, CUDA), C), AND(EQ(_currn->_desc2->_ATDemoted, FALSE), EQ(_currn->_desc1->_ATDemoted, FALSE)))
) ? (PTGCommaArgs(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)
) : (
((EQ(_currn->_desc2->_ATDemoted, FALSE)
) ? (_currn->_desc2->_ATPtg
) : (_currn->_desc1->_ATPtg))
))
;
/*SPC(7919)*/
_currn->_ATDemoted=_currn->_desc2->_ATDemoted;
/*SPC(7848)*/
_currn->_ATPtg=
((GE(_currn->_desc1->_ATArgCnt_post, 2)
) ? (
((EQ(_currn->_ATMaxMinFunct, FMAX)
) ? (PTGMax(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)
) : (
((EQ(_currn->_ATMaxMinFunct, FMIN)
) ? (PTGMin(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)
) : (_currn->_ATargs_RuleAttr_1091))
))

) : (_currn->_ATargs_RuleAttr_1091))
;
/*SPC(7934)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_634(_TPPrule_634 _currn)
#else
void _VS9rule_634(_currn )
_TPPrule_634 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const18=ADD(_currn->_desc1->_AT_const18, _currn->_desc2->_AT_const18);
/*SPC(4007)*/
_currn->_AT_const32=ADD(_currn->_desc1->_AT_const32, _currn->_desc2->_AT_const32);
/*SPC(4007)*/
_currn->_AT_const51=ADD(_currn->_desc1->_AT_const51, _currn->_desc2->_AT_const51);
/*SPC(4007)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_634(_TPPrule_634 _currn)
#else
void _VS10rule_634(_currn )
_TPPrule_634 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_634(_TPPrule_634 _currn)
#else
void _VS11rule_634(_currn )
_TPPrule_634 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const19=ADD(_currn->_desc1->_AT_const19, _currn->_desc2->_AT_const19);
/*SPC(4007)*/
_currn->_AT_const34=ADD(_currn->_desc1->_AT_const34, _currn->_desc2->_AT_const34);
/*SPC(4007)*/
_currn->_AT_const50=ADD(_currn->_desc1->_AT_const50, _currn->_desc2->_AT_const50);
/*SPC(4007)*/
_currn->_AT_const63=ADD(_currn->_desc1->_AT_const63, _currn->_desc2->_AT_const63);
/*SPC(4007)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(4007)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(4007)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(4007)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATNotCharacterIndex=1;
/*SPC(3038)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_635(_TPPrule_635 _currn)
#else
void _VS1rule_635(_currn )
_TPPrule_635 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_635(_TPPrule_635 _currn)
#else
void _VS2rule_635(_currn )
_TPPrule_635 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_635(_TPPrule_635 _currn)
#else
void _VS3rule_635(_currn )
_TPPrule_635 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_635(_TPPrule_635 _currn)
#else
void _VS4rule_635(_currn )
_TPPrule_635 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_635(_TPPrule_635 _currn)
#else
void _VS5rule_635(_currn )
_TPPrule_635 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_635(_TPPrule_635 _currn)
#else
void _VS6rule_635(_currn )
_TPPrule_635 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATValue=_currn->_desc1->_ATValue;
/*SPC(4070)*/
_currn->_ATBoundsElem=PkgBounds(_currn->_desc1->_ATLocalIndex_post, (* _IG_incl48), 0, _currn->_desc1->_ATValue, NoKey, NoKey);
/*SPC(3973)*/
_currn->_ATBoundsTakeIt=
((EQ((* _IG_incl34), 1)
) ? (1
) : (0))
;
/*SPC(3968)*/
_currn->_AT_cBoundsListPtr_post=
((_currn->_ATBoundsTakeIt
) ? (RefEndConsBoundsList(_currn->_desc1->_AT_cBoundsListPtr_post, _currn->_ATBoundsElem)
) : (_currn->_desc1->_AT_cBoundsListPtr_post))
;
/*SPC(377)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_635(_TPPrule_635 _currn)
#else
void _VS7rule_635(_currn )
_TPPrule_635 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_635(_TPPrule_635 _currn)
#else
void _VS8rule_635(_currn )
_TPPrule_635 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(_currn->_desc1->_AT_const33, FALSE), AND(EQ(GetVariableSharedGPU(_currn->_ATArrayId_pre, 0), SHARED), AND(EQ(_currn->_ATLocalIndex_pre, 1), GE(GetRegionVarProperty(_currn->_ATRegionVars_pre, BLOCKFACTOR, _currn->_ATLocalIndex_pre), TRUE)))))
) ? (ConstructLoopIndex(_currn->_desc1->_ATPtg, PTGNULL, SHARED, _currn->_desc1->_ATRegionVars_post, _currn->_ATLocalIndex_pre, FALSE)
) : (_currn->_desc1->_ATPtg))
;
/*SPC(8151)*/
_currn->_ATDemoted=_currn->_desc1->_ATDemoted;
/*SPC(7853)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_635(_TPPrule_635 _currn)
#else
void _VS9rule_635(_currn )
_TPPrule_635 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const18=_currn->_desc1->_AT_const18;
/*SPC(3967)*/
_currn->_AT_const32=_currn->_desc1->_AT_const32;
/*SPC(3967)*/
_currn->_AT_const51=ZERO();
/*SPC(3967)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_635(_TPPrule_635 _currn)
#else
void _VS10rule_635(_currn )
_TPPrule_635 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_635(_TPPrule_635 _currn)
#else
void _VS11rule_635(_currn )
_TPPrule_635 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const19=IDENTICAL(_currn->_desc1->_ATConstantUsed);
/*SPC(3967)*/
_currn->_AT_const34=_currn->_desc1->_AT_const34;
/*SPC(3967)*/
_currn->_AT_const50=ADD(_currn->_desc1->_AT_const50, IDENTICAL(_currn->_desc1->_ATConstantUsed));
/*SPC(3967)*/
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(3967)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(3967)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(3967)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(3967)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATNotCharacterIndex=1;
/*SPC(3038)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_636(_TPPrule_636 _currn)
#else
void _VS1rule_636(_currn )
_TPPrule_636 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_636(_TPPrule_636 _currn)
#else
void _VS2rule_636(_currn )
_TPPrule_636 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_636(_TPPrule_636 _currn)
#else
void _VS3rule_636(_currn )
_TPPrule_636 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUnitId=_currn->_desc1->_ATUnitId;
/*SPC(3963)*/
_currn->_desc2->_ATObjectId=_currn->_desc1->_ATObjectId;
/*SPC(3962)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_636(_TPPrule_636 _currn)
#else
void _VS4rule_636(_currn )
_TPPrule_636 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_636(_TPPrule_636 _currn)
#else
void _VS5rule_636(_currn )
_TPPrule_636 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_636(_TPPrule_636 _currn)
#else
void _VS6rule_636(_currn )
_TPPrule_636 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_637(_TPPrule_637 _currn)
#else
void _VS1rule_637(_currn )
_TPPrule_637 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_637(_TPPrule_637 _currn)
#else
void _VS2rule_637(_currn )
_TPPrule_637 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_637(_TPPrule_637 _currn)
#else
void _VS3rule_637(_currn )
_TPPrule_637 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=1;
/*SPC(8786)*/
_currn->_desc1->_ATIsArray_pre=TRUE;
/*SPC(8681)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
ResetNumberOfDims(_currn->_ATUnitId, LengthBoundsList(_currn->_desc1->_ATBoundsList));
/*SPC(3958)*/
ResetArraySizeList(_currn->_ATObjectId, _currn->_desc1->_ATBoundsList);
/*SPC(3956)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_637(_TPPrule_637 _currn)
#else
void _VS4rule_637(_currn )
_TPPrule_637 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=FALSE;
/*SPC(8682)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_637(_TPPrule_637 _currn)
#else
void _VS5rule_637(_currn )
_TPPrule_637 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_637(_TPPrule_637 _currn)
#else
void _VS6rule_637(_currn )
_TPPrule_637 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_638(_TPPrule_638 _currn)
#else
void _VS1rule_638(_currn )
_TPPrule_638 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_638(_TPPrule_638 _currn)
#else
void _VS2rule_638(_currn )
_TPPrule_638 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_638(_TPPrule_638 _currn)
#else
void _VS3rule_638(_currn )
_TPPrule_638 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_638(_TPPrule_638 _currn)
#else
void _VS4rule_638(_currn )
_TPPrule_638 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxMinFunct=FALSE;
/*SPC(8890)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_638(_TPPrule_638 _currn)
#else
void _VS5rule_638(_currn )
_TPPrule_638 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_638(_TPPrule_638 _currn)
#else
void _VS6rule_638(_currn )
_TPPrule_638 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_639(_TPPrule_639 _currn)
#else
void _VS1rule_639(_currn )
_TPPrule_639 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_currn->_ATDims=_currn->_desc1->_ATDims;
/*SPC(3942)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_639(_TPPrule_639 _currn)
#else
void _VS2rule_639(_currn )
_TPPrule_639 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_639(_TPPrule_639 _currn)
#else
void _VS3rule_639(_currn )
_TPPrule_639 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_639(_TPPrule_639 _currn)
#else
void _VS4rule_639(_currn )
_TPPrule_639 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_639(_TPPrule_639 _currn)
#else
void _VS5rule_639(_currn )
_TPPrule_639 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_639(_TPPrule_639 _currn)
#else
void _VS6rule_639(_currn )
_TPPrule_639 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATSizeValue=_currn->_desc1->_ATSizeValue;
/*SPC(3943)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_640(_TPPrule_640 _currn)
#else
void _VS1rule_640(_currn )
_TPPrule_640 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

if (GE((* _IG_incl49), 1)) {
InsertKindSet(_currn->_desc1->_ATUnitKey, Array);

} else {
}
;
/*SPC(3909)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_640(_TPPrule_640 _currn)
#else
void _VS2rule_640(_currn )
_TPPrule_640 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_640(_TPPrule_640 _currn)
#else
void _VS3rule_640(_currn )
_TPPrule_640 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_640(_TPPrule_640 _currn)
#else
void _VS4rule_640(_currn )
_TPPrule_640 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (NE(GetVariableDefined(_currn->_desc1->_ATObjectKey, 0), PASSED_IN)) {

if (GE(isModule(_currn->_AT_line), TRUE)) {
ResetVariableDefined(_currn->_desc1->_ATObjectKey, MODULE);

} else {

if (EQ((* _IG_incl46), TRUE)) {
ResetVariableDefined(_currn->_desc1->_ATObjectKey, CONSTANT);

} else {

if (OR(EQ(GetVariableDefined(_currn->_desc1->_ATObjectKey, 0), MODULE), EQ(GetVariableDefined(_currn->_desc1->_ATObjectKey, 0), 0))) {
ResetVariableDefined(_currn->_desc1->_ATObjectKey, LOCAL);

} else {
}
;
}
;
}
;

} else {
}
;
/*SPC(5054)*/

if (EQ((* _IG_incl50), 1)) {
ResetNumberOfDims(_currn->_desc1->_ATUnitKey, (* _IG_incl49));

} else {
;
}
;
/*SPC(3919)*/

if (EQ((* _IG_incl50), 1)) {
ResetArraySizeList(_currn->_desc1->_ATObjectKey, (* _IG_incl51));

} else {
;
}
;
/*SPC(3913)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_640(_TPPrule_640 _currn)
#else
void _VS5rule_640(_currn )
_TPPrule_640 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/

if (EQ((* _IG_incl46), TRUE)) {

if (GE(_currn->_desc2->_AT_const32, 1)) {
ResetVariableConstantValue(_currn->_desc1->_ATObjectKey, PTGParens(_currn->_desc2->_ATPtg));

} else {
ResetVariableConstantValue(_currn->_desc1->_ATObjectKey, _currn->_desc2->_ATPtg);
}
;

} else {
PTGNULL;
}
;
/*SPC(4255)*/
FALSE;
/*SPC(13363)*/
_currn->_ATProgDeclsTakeIt=
((AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(GE(GetNumberOfDims(_currn->_desc1->_ATUnitKey, FALSE), TRUE), EQ((* _IG_incl50), TRUE)))
) ? (TRUE
) : (FALSE))
;
/*SPC(13212)*/
_currn->_ATProgDeclsElem=PkgProgDecls(_currn->_desc1->_ATSym, _currn->_desc1->_ATObjectKey, _currn->_desc1->_ATUnitKey, GetVariableDefined(_currn->_desc1->_ATObjectKey, 0));
/*SPC(13218)*/
ResetTypeLength(_currn->_desc1->_ATUnitKey, _currn->_ATTypeLength_pre);
/*SPC(4663)*/
_currn->_AT_cProgDeclsListPtr_post=
((_currn->_ATProgDeclsTakeIt
) ? (RefEndConsProgDeclsList(_currn->_AT_cProgDeclsListPtr_pre, _currn->_ATProgDeclsElem)
) : (_currn->_AT_cProgDeclsListPtr_pre))
;
/*SPC(563)*/

if (EQ((* _IG_incl46), TRUE)) {
ResetVariableConstant(_currn->_desc1->_ATObjectKey, _currn->_desc2->_ATSym);

} else {
FALSE;
}
;
/*SPC(4249)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(4248)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_640(_TPPrule_640 _currn)
#else
void _VS6rule_640(_currn )
_TPPrule_640 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATdefinePtg_RuleAttr_1097=
((GE(_currn->_desc2->_AT_const34, 1)
) ? (PTGDefineGlobalCRP(Convert_to_Ctype(GetTypeLength(_currn->_desc1->_ATUnitKey, 0), GetType(_currn->_desc1->_ATUnitKey, ErrorType)), _currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)
) : (PTGDefineGlobalCR(Convert_to_Ctype(GetTypeLength(_currn->_desc1->_ATUnitKey, 0), GetType(_currn->_desc1->_ATUnitKey, ErrorType)), _currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)))
;
/*SPC(4176)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (EQ(_currn->_ATTranslationType_pre, GPU)) {
SetVariableUse(_currn->_desc1->_ATObjectKey, _currn->_desc1->_ATGPURegionNumber_post, TRUE, GPU, _currn->_desc1->_ATSym, MapLine(_currn->_AT_line), _currn->_desc1->_ATStmtNumber_post);

} else {
SetVariableUse(_currn->_desc1->_ATObjectKey, _currn->_desc1->_ATCPURegionNumber_post, TRUE, CPU, _currn->_desc1->_ATSym, MapLine(_currn->_AT_line), _currn->_desc1->_ATStmtNumber_post);
}
;

} else {
;
}
;
/*SPC(4198)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xEntityDecl not supported.");
/*SPC(4745)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGAppend(PTGNumber(MapLine(_currn->_AT_line)), _currn->_ATdefinePtg_RuleAttr_1097));

} else {
}
;
/*SPC(4196)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_641(_TPPrule_641 _currn)
#else
void _VS1rule_641(_currn )
_TPPrule_641 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, " This language construct not supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4777)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/

if (GE((* _IG_incl49), 1)) {
InsertKindSet(_currn->_desc1->_ATUnitKey, Array);

} else {
}
;
/*SPC(3890)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_641(_TPPrule_641 _currn)
#else
void _VS2rule_641(_currn )
_TPPrule_641 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_641(_TPPrule_641 _currn)
#else
void _VS3rule_641(_currn )
_TPPrule_641 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATLocalIndex_post=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_641(_TPPrule_641 _currn)
#else
void _VS4rule_641(_currn )
_TPPrule_641 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
FALSE;
/*SPC(5031)*/

if (EQ((* _IG_incl50), 1)) {
ResetNumberOfDims(_currn->_desc1->_ATUnitKey, (* _IG_incl49));

} else {
;
}
;
/*SPC(3900)*/

if (EQ((* _IG_incl50), 1)) {
ResetArraySizeList(_currn->_desc1->_ATObjectKey, (* _IG_incl51));

} else {
;
}
;
/*SPC(3894)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_641(_TPPrule_641 _currn)
#else
void _VS5rule_641(_currn )
_TPPrule_641 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc3->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc3->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc3->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc3->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc3->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc3->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
FALSE;
/*SPC(13363)*/
_currn->_ATProgDeclsTakeIt=FALSE;
/*SPC(13190)*/
_currn->_ATProgDeclsElem=PkgProgDecls(0, NoKey, NoKey, 0);
/*SPC(13189)*/
ResetTypeLength(_currn->_desc1->_ATUnitKey, _currn->_desc2->_ATTypeLength_post);
/*SPC(4673)*/
_currn->_AT_cProgDeclsListPtr_post=
((_currn->_ATProgDeclsTakeIt
) ? (RefEndConsProgDeclsList(_currn->_AT_cProgDeclsListPtr_pre, _currn->_ATProgDeclsElem)
) : (_currn->_AT_cProgDeclsListPtr_pre))
;
/*SPC(563)*/
_currn->_ATDeclsOrder_post=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_641(_TPPrule_641 _currn)
#else
void _VS6rule_641(_currn )
_TPPrule_641 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xEntityDecl not supported.");
/*SPC(4745)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_642(_TPPrule_642 _currn)
#else
void _VS1rule_642(_currn )
_TPPrule_642 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, " This language construct not supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4766)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

if (GE((* _IG_incl49), 1)) {
InsertKindSet(_currn->_desc1->_ATUnitKey, Array);

} else {
}
;
/*SPC(3871)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_642(_TPPrule_642 _currn)
#else
void _VS2rule_642(_currn )
_TPPrule_642 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_642(_TPPrule_642 _currn)
#else
void _VS3rule_642(_currn )
_TPPrule_642 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_642(_TPPrule_642 _currn)
#else
void _VS4rule_642(_currn )
_TPPrule_642 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
FALSE;
/*SPC(5031)*/

if (EQ((* _IG_incl50), 1)) {
ResetNumberOfDims(_currn->_desc1->_ATUnitKey, (* _IG_incl49));

} else {
;
}
;
/*SPC(3881)*/

if (EQ((* _IG_incl50), 1)) {
ResetArraySizeList(_currn->_desc1->_ATObjectKey, (* _IG_incl51));

} else {
;
}
;
/*SPC(3875)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_642(_TPPrule_642 _currn)
#else
void _VS5rule_642(_currn )
_TPPrule_642 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
FALSE;
/*SPC(13363)*/
_currn->_ATProgDeclsTakeIt=FALSE;
/*SPC(13190)*/
_currn->_ATProgDeclsElem=PkgProgDecls(0, NoKey, NoKey, 0);
/*SPC(13189)*/
ResetTypeLength(_currn->_desc1->_ATUnitKey, _currn->_desc2->_ATTypeLength_post);
/*SPC(4668)*/
_currn->_AT_cProgDeclsListPtr_post=
((_currn->_ATProgDeclsTakeIt
) ? (RefEndConsProgDeclsList(_currn->_AT_cProgDeclsListPtr_pre, _currn->_ATProgDeclsElem)
) : (_currn->_AT_cProgDeclsListPtr_pre))
;
/*SPC(563)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_642(_TPPrule_642 _currn)
#else
void _VS6rule_642(_currn )
_TPPrule_642 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xEntityDecl not supported.");
/*SPC(4745)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_643(_TPPrule_643 _currn)
#else
void _VS1rule_643(_currn )
_TPPrule_643 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

if (OR(GE((* _IG_incl49), 1), EQ(GetType(_currn->_desc1->_ATUnitKey, NoKey), CharacterType))) {
InsertKindSet(_currn->_desc1->_ATUnitKey, Array);

} else {
}
;
/*SPC(3851)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_643(_TPPrule_643 _currn)
#else
void _VS2rule_643(_currn )
_TPPrule_643 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_643(_TPPrule_643 _currn)
#else
void _VS3rule_643(_currn )
_TPPrule_643 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_643(_TPPrule_643 _currn)
#else
void _VS4rule_643(_currn )
_TPPrule_643 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetVariableDefined(_currn->_desc1->_ATObjectKey, FALSE), MODULE), EQ(isModule(_currn->_AT_line), FALSE))) {
message(WARNING, "Variable is defined both locally and externally via a module.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(5046)*/

if (NE(GetVariableDefined(_currn->_desc1->_ATObjectKey, 0), PASSED_IN)) {

if (GE(isModule(((_currn->_AT_pos).line)), TRUE)) {
ResetVariableDefined(_currn->_desc1->_ATObjectKey, MODULE);

} else {

if (EQ((* _IG_incl46), TRUE)) {
ResetVariableDefined(_currn->_desc1->_ATObjectKey, CONSTANT);

} else {

if (OR(EQ(GetVariableDefined(_currn->_desc1->_ATObjectKey, 0), MODULE), EQ(GetVariableDefined(_currn->_desc1->_ATObjectKey, 0), 0))) {
ResetVariableDefined(_currn->_desc1->_ATObjectKey, LOCAL);

} else {
}
;
}
;
}
;

} else {
}
;
/*SPC(5033)*/

if (EQ((* _IG_incl50), 1)) {
ResetNumberOfDims(_currn->_desc1->_ATUnitKey, (* _IG_incl49));

} else {
;
}
;
/*SPC(3862)*/

if (EQ((* _IG_incl50), 1)) {
ResetArraySizeList(_currn->_desc1->_ATObjectKey, (* _IG_incl51));

} else {
;
}
;
/*SPC(3856)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_643(_TPPrule_643 _currn)
#else
void _VS5rule_643(_currn )
_TPPrule_643 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
ResetComputedSize(_currn->_desc1->_ATObjectKey, ComputeArraySize(FALSE, 0, _currn->_desc1->_ATUnitKey, _currn->_desc1->_ATObjectKey, (&( _currn->_AT_pos))));
/*SPC(13373)*/
_currn->_ATProgDeclsTakeIt=
((AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(GE(GetNumberOfDims(_currn->_desc1->_ATUnitKey, FALSE), TRUE), EQ((* _IG_incl50), TRUE)))
) ? (TRUE
) : (FALSE))
;
/*SPC(13194)*/
_currn->_ATProgDeclsElem=PkgProgDecls(_currn->_desc1->_ATSym, _currn->_desc1->_ATObjectKey, _currn->_desc1->_ATUnitKey, GetVariableDefined(_currn->_desc1->_ATObjectKey, 0));
/*SPC(13200)*/
ResetIntent(_currn->_desc1->_ATObjectKey, (* _IG_incl52));
/*SPC(6688)*/
ResetTypeLength(_currn->_desc1->_ATUnitKey, _currn->_ATTypeLength_pre);
/*SPC(4658)*/
_currn->_AT_cProgDeclsListPtr_post=
((_currn->_ATProgDeclsTakeIt
) ? (RefEndConsProgDeclsList(_currn->_AT_cProgDeclsListPtr_pre, _currn->_ATProgDeclsElem)
) : (_currn->_AT_cProgDeclsListPtr_pre))
;
/*SPC(563)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_643(_TPPrule_643 _currn)
#else
void _VS6rule_643(_currn )
_TPPrule_643 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xEntityDecl not supported.");
/*SPC(4745)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_644(_TPPrule_644 _currn)
#else
void _VS1rule_644(_currn )
_TPPrule_644 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_644(_TPPrule_644 _currn)
#else
void _VS2rule_644(_currn )
_TPPrule_644 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_644(_TPPrule_644 _currn)
#else
void _VS3rule_644(_currn )
_TPPrule_644 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_644(_TPPrule_644 _currn)
#else
void _VS4rule_644(_currn )
_TPPrule_644 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_644(_TPPrule_644 _currn)
#else
void _VS5rule_644(_currn )
_TPPrule_644 _currn;

#endif
{
int* _IL_incl47;

_VisitVarDecl()
_VisitEntry();
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATDeclLower);
_currn->_ATDeclLower=1;
/*SPC(3787)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATUpperObject=_currn->_desc2->_ATObjectId;
/*SPC(3799)*/
_currn->_ATLowerObject=_currn->_desc1->_ATObjectId;
/*SPC(3798)*/
_currn->_ATUpperValue=_currn->_desc2->_ATValue;
/*SPC(3797)*/
_currn->_ATLowerValue=_currn->_desc1->_ATValue;
/*SPC(3796)*/
_IG_incl47=_IL_incl47;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_644(_TPPrule_644 _currn)
#else
void _VS6rule_644(_currn )
_TPPrule_644 _currn;

#endif
{
int* _IL_incl47;

_VisitVarDecl()
_VisitEntry();
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATDeclLower);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl47=_IL_incl47;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_644(_TPPrule_644 _currn)
#else
void _VS7rule_644(_currn )
_TPPrule_644 _currn;

#endif
{
int* _IL_incl47;

_VisitVarDecl()
_VisitEntry();
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATDeclLower);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATSizeValue=MakeName(CatStrStr(CatStrStr(CatStrStr(StringTable(_currn->_desc2->_ATValue), "-("), StringTable(_currn->_desc1->_ATValue)), ")+1"));
/*SPC(3800)*/
_currn->_ATUpperPtg=_currn->_desc2->_ATPtg;
/*SPC(3795)*/
_currn->_ATLowerPtg=_currn->_desc1->_ATPtg;
/*SPC(3794)*/
_currn->_ATSizePtg=PTGSize(_currn->_desc2->_ATPtg, _currn->_desc1->_ATPtg);
/*SPC(3793)*/
_IG_incl47=_IL_incl47;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_645(_TPPrule_645 _currn)
#else
void _VS1rule_645(_currn )
_TPPrule_645 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_645(_TPPrule_645 _currn)
#else
void _VS2rule_645(_currn )
_TPPrule_645 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_645(_TPPrule_645 _currn)
#else
void _VS3rule_645(_currn )
_TPPrule_645 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_645(_TPPrule_645 _currn)
#else
void _VS4rule_645(_currn )
_TPPrule_645 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_645(_TPPrule_645 _currn)
#else
void _VS5rule_645(_currn )
_TPPrule_645 _currn;

#endif
{
int* _IL_incl47;

_VisitVarDecl()
_VisitEntry();
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATDeclLower);
_currn->_ATDeclLower=0;
/*SPC(3789)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATUpperObject=_currn->_desc1->_ATObjectId;
/*SPC(3823)*/
_currn->_ATLowerObject=NoKey;
/*SPC(3822)*/
_currn->_ATUpperValue=_currn->_desc1->_ATValue;
/*SPC(3821)*/
_currn->_ATLowerValue=0;
/*SPC(3820)*/
_IG_incl47=_IL_incl47;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_645(_TPPrule_645 _currn)
#else
void _VS6rule_645(_currn )
_TPPrule_645 _currn;

#endif
{
int* _IL_incl47;

_VisitVarDecl()
_VisitEntry();
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATDeclLower);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl47=_IL_incl47;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_645(_TPPrule_645 _currn)
#else
void _VS7rule_645(_currn )
_TPPrule_645 _currn;

#endif
{
int* _IL_incl47;

_VisitVarDecl()
_VisitEntry();
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATDeclLower);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATSizeValue=_currn->_desc1->_ATValue;
/*SPC(3819)*/
_currn->_ATUpperPtg=_currn->_desc1->_ATPtg;
/*SPC(3818)*/
_currn->_ATLowerPtg=PTGAsIs("1");
/*SPC(3817)*/
_currn->_ATSizePtg=_currn->_desc1->_ATPtg;
/*SPC(3816)*/
_IG_incl47=_IL_incl47;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_646(_TPPrule_646 _currn)
#else
void _VS1rule_646(_currn )
_TPPrule_646 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_646(_TPPrule_646 _currn)
#else
void _VS4rule_646(_currn )
_TPPrule_646 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_646(_TPPrule_646 _currn)
#else
void _VS5rule_646(_currn )
_TPPrule_646 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_646(_TPPrule_646 _currn)
#else
void _VS6rule_646(_currn )
_TPPrule_646 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_646(_TPPrule_646 _currn)
#else
void _VS7rule_646(_currn )
_TPPrule_646 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_647(_TPPrule_647 _currn)
#else
void _VS1rule_647(_currn )
_TPPrule_647 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_647(_TPPrule_647 _currn)
#else
void _VS2rule_647(_currn )
_TPPrule_647 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_647(_TPPrule_647 _currn)
#else
void _VS3rule_647(_currn )
_TPPrule_647 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_647(_TPPrule_647 _currn)
#else
void _VS4rule_647(_currn )
_TPPrule_647 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_647(_TPPrule_647 _currn)
#else
void _VS5rule_647(_currn )
_TPPrule_647 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_647(_TPPrule_647 _currn)
#else
void _VS6rule_647(_currn )
_TPPrule_647 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_647(_TPPrule_647 _currn)
#else
void _VS7rule_647(_currn )
_TPPrule_647 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_648(_TPPrule_648 _currn)
#else
void _VS1rule_648(_currn )
_TPPrule_648 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_648(_TPPrule_648 _currn)
#else
void _VS2rule_648(_currn )
_TPPrule_648 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_648(_TPPrule_648 _currn)
#else
void _VS3rule_648(_currn )
_TPPrule_648 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATObjectSym=_currn->_desc1->_ATSym;
/*SPC(3721)*/
_currn->_desc2->_ATObjectId=_currn->_desc1->_ATObjectKey;
/*SPC(3720)*/
_currn->_desc2->_ATUnitId=_currn->_desc1->_ATUnitKey;
/*SPC(3719)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_648(_TPPrule_648 _currn)
#else
void _VS4rule_648(_currn )
_TPPrule_648 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_648(_TPPrule_648 _currn)
#else
void _VS5rule_648(_currn )
_TPPrule_648 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_649(_TPPrule_649 _currn)
#else
void _VS1rule_649(_currn )
_TPPrule_649 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
AddLookupEntry(StringTable(_currn->_ATTERM_1), StringTable(GetClpValue(FileName, 0)));
/*SPC(3660)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_650(_TPPrule_650 _currn)
#else
void _VS1rule_650(_currn )
_TPPrule_650 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUnitBind=BindIdn((* _IG_incl23), _currn->_ATSym);
/*SPC(47)*/
_currn->_ATUnitKey=KeyOf(_currn->_ATUnitBind);
/*SPC(49)*/
GuaranteeType(_currn->_ATUnitKey, DefaultType(_currn->_ATSym));
/*SPC(1610)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_650(_TPPrule_650 _currn)
#else
void _VS2rule_650(_currn )
_TPPrule_650 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (DisjIS(ConsIS(Constant, ConsIS(IntrinsicFunction, ConsIS(InExternalStmt, ConsIS(Array, ConsIS(Subroutine, ConsIS(MainProgram, ConsIS(BlockDataSubprogram, ConsIS(ExternalFunction, ConsIS(StatementFunction, NullIS()))))))))), GetKindSet(_currn->_ATUnitKey, NullIS()))) {
InsertKindSet(_currn->_ATUnitKey, Variable);

} else {
}
;
/*SPC(3245)*/
_currn->_ATCoord=(&( _currn->_AT_pos));
/*SPC(2988)*/
_currn->_ATBind=BindingInEnv((* _IG_incl22), _currn->_ATSym);
/*SPC(195)*/
_currn->_ATKey=KeyOf(_currn->_ATBind);
/*SPC(199)*/
_currn->_ATObjectKey=
((_currn->_ATKey
) ? (_currn->_ATKey
) : (_currn->_ATUnitKey))
;
/*SPC(2892)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_654(_TPPrule_654 _currn)
#else
void _VS1rule_654(_currn )
_TPPrule_654 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_654(_TPPrule_654 _currn)
#else
void _VS2rule_654(_currn )
_TPPrule_654 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_654(_TPPrule_654 _currn)
#else
void _VS3rule_654(_currn )
_TPPrule_654 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_654(_TPPrule_654 _currn)
#else
void _VS4rule_654(_currn )
_TPPrule_654 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_655(_TPPrule_655 _currn)
#else
void _VS1rule_655(_currn )
_TPPrule_655 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_655(_TPPrule_655 _currn)
#else
void _VS2rule_655(_currn )
_TPPrule_655 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_655(_TPPrule_655 _currn)
#else
void _VS3rule_655(_currn )
_TPPrule_655 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_655(_TPPrule_655 _currn)
#else
void _VS4rule_655(_currn )
_TPPrule_655 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_656(_TPPrule_656 _currn)
#else
void _VS1rule_656(_currn )
_TPPrule_656 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGRemove(PTGNumb(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(9288)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_656(_TPPrule_656 _currn)
#else
void _VS2rule_656(_currn )
_TPPrule_656 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_656(_TPPrule_656 _currn)
#else
void _VS3rule_656(_currn )
_TPPrule_656 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_656(_TPPrule_656 _currn)
#else
void _VS4rule_656(_currn )
_TPPrule_656 _currn;

#endif
{
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(8745)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(3641)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_656(_TPPrule_656 _currn)
#else
void _VS5rule_656(_currn )
_TPPrule_656 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12737)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4605)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc2->_ATNumArgs=0;
/*SPC(7011)*/
_currn->_desc2->_ATignoreVar=TRUE;
/*SPC(5166)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATArraySym_post=0;
/*SPC(8604)*/
_currn->_ATArrayId_post=NoKey;
/*SPC(8600)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(11193)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc3->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc3->_ATDoAcc_post, ACCDO, _currn->_desc3->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc3->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_656(_TPPrule_656 _currn)
#else
void _VS6rule_656(_currn )
_TPPrule_656 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(_currn->_ATStmtNumber_pre, _currn->_ATThreadStmt_pre), NE(_currn->_ATStmtNumber_pre, FALSE))))) {
PTGOut(PTGThreadEnd(PTGNumber(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(13475)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12738)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8110)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3679)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(3641)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_656(_TPPrule_656 _currn)
#else
void _VS7rule_656(_currn )
_TPPrule_656 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_657(_TPPrule_657 _currn)
#else
void _VS1rule_657(_currn )
_TPPrule_657 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
DefaultImplicitTypes();
/*SPC(1601)*/
_currn->_desc1->_ATOrder_pre=0;
/*SPC(1198)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8595)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATFalse=0;
/*SPC(3347)*/
_currn->_ATKind=BlockDataSubprogram;
/*SPC(3137)*/
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_657(_TPPrule_657 _currn)
#else
void _VS2rule_657(_currn )
_TPPrule_657 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_657(_TPPrule_657 _currn)
#else
void _VS3rule_657(_currn )
_TPPrule_657 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATObjectSym=0;
/*SPC(3704)*/
_currn->_AT_const38=ZERO();
/*SPC(3136)*/
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_657(_TPPrule_657 _currn)
#else
void _VS4rule_657(_currn )
_TPPrule_657 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_AT_VariableUseauxList=NULLVariableUseList;
/*SPC(657)*/
_currn->_AT_ProgDeclsauxList=NULLProgDeclsList;
/*SPC(556)*/
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_desc1->_ATErrorVarDeclared_pre=FALSE;
/*SPC(13523)*/
_currn->_desc1->_ATThreadStmt_pre=FALSE;
/*SPC(13432)*/
_currn->_desc1->_ATThreadRegion_pre=FALSE;
/*SPC(13430)*/
_currn->_desc1->_ATBaseValue_pre=0;
/*SPC(13159)*/
_currn->_desc1->_ATThreadStop_pre=0;
/*SPC(13158)*/
_currn->_desc1->_ATThreadStart_pre=0;
/*SPC(13157)*/
_currn->_desc1->_ATDoAcc_pre=InitAccDo();
/*SPC(12973)*/
_currn->_desc1->_ATAccDoType_pre=0;
/*SPC(12802)*/
_currn->_desc1->_ATAccDoStmt_pre=0;
/*SPC(12798)*/
_currn->_desc1->_ATStmtNumber_pre=0;
/*SPC(12794)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12734)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12733)*/
_currn->_desc1->_ATAccDoLoopDim_pre=0;
/*SPC(12601)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=PTGNULL;
/*SPC(12375)*/
_currn->_desc1->_ATKernelNumber_pre=0;
/*SPC(12038)*/
_currn->_desc1->_ATNestLevel_pre=0;
/*SPC(11958)*/
_currn->_desc1->_ATAcceleratorRegion_pre=FALSE;
/*SPC(11402)*/
_currn->_desc1->_ATLastNonExecLine_pre=MapLine(_currn->_AT_line);
/*SPC(11380)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=FALSE;
/*SPC(9179)*/
_currn->_desc1->_ATArgCnt_pre=0;
/*SPC(8895)*/
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(8744)*/
_currn->_desc1->_ATArraySym_pre=0;
/*SPC(8603)*/
_currn->_desc1->_ATArrayId_pre=NoKey;
/*SPC(8599)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8109)*/
_currn->_desc1->_ATMaxRank_pre=0;
/*SPC(7950)*/
_currn->_desc1->_ATCPURegionNumber_pre=FALSE;
/*SPC(5187)*/
_currn->_desc1->_ATGPURegionNumber_pre=FALSE;
/*SPC(5185)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4604)*/
_currn->_desc1->_ATDeclsOrder_pre=0;
/*SPC(4229)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3678)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_VariableUseListADDROF(_currn->_AT_VariableUseauxList);
/*SPC(658)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_ProgDeclsListADDROF(_currn->_AT_ProgDeclsauxList);
/*SPC(557)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_AT_cProgDeclsListPtr_pre=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9104)*/
_currn->_ATProgramName=ZERO();
/*SPC(12015)*/
_currn->_ATLastDeclarative=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(11381)*/
_currn->_ATProgramUnitId=0;
/*SPC(5983)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_657(_TPPrule_657 _currn)
#else
void _VS5rule_657(_currn )
_TPPrule_657 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl54;
int* _IL_incl53;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
ProgDeclsList* _IL_incl43;
VariableUseList* _IL_incl42;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl21;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl54=_IG_incl54;_IG_incl54= &(_currn->_ATReturnStmt);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl43=_IG_incl43;_IG_incl43= &(_currn->_ATProgDeclsList);
_IL_incl42=_IG_incl42;_IG_incl42= &(_currn->_ATVariableUseList);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl21=_IG_incl21;_IG_incl21= &(_currn->_ATNumKernels);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATVariableUseList=_currn->_AT_VariableUseauxList;
/*SPC(659)*/
_currn->_ATProgDeclsList=_currn->_AT_ProgDeclsauxList;
/*SPC(558)*/
_currn->_ATNumKernels=ZERO();
/*SPC(12043)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc2->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATIntent=FALSE;
/*SPC(6658)*/
_currn->_ATReturnStmt=ZERO();
/*SPC(6423)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), NE(_currn->_ATTranslationType_pre, GPU)))) {
PTGOut(PTGAppend(PTGNumber(_currn->_desc2->_ATProgramLineNum_post), PTGNull()));

} else {
}
;
/*SPC(13388)*/
_currn->_ATSym=0;
/*SPC(5983)*/
_currn->_ATBoundsList=NULLBoundsList;
/*SPC(3725)*/
_currn->_ATObjectId=NoKey;
/*SPC(3702)*/
_currn->_ATUnitId=NoKey;
/*SPC(3698)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl54=_IL_incl54;
_IG_incl53=_IL_incl53;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl43=_IL_incl43;
_IG_incl42=_IL_incl42;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl21=_IL_incl21;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_658(_TPPrule_658 _currn)
#else
void _VS1rule_658(_currn )
_TPPrule_658 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
DefaultImplicitTypes();
/*SPC(1601)*/
_currn->_desc1->_ATOrder_pre=0;
/*SPC(1198)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATFalse=0;
/*SPC(3347)*/
_currn->_ATKind=BlockDataSubprogram;
/*SPC(3133)*/
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8595)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_658(_TPPrule_658 _currn)
#else
void _VS2rule_658(_currn )
_TPPrule_658 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_658(_TPPrule_658 _currn)
#else
void _VS3rule_658(_currn )
_TPPrule_658 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATObjectSym=0;
/*SPC(3704)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const38=_currn->_desc2->_AT_const38;
/*SPC(3132)*/
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_658(_TPPrule_658 _currn)
#else
void _VS4rule_658(_currn )
_TPPrule_658 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_AT_VariableUseauxList=NULLVariableUseList;
/*SPC(657)*/
_currn->_AT_ProgDeclsauxList=NULLProgDeclsList;
/*SPC(556)*/
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_desc1->_ATErrorVarDeclared_pre=FALSE;
/*SPC(13523)*/
_currn->_desc1->_ATThreadStmt_pre=FALSE;
/*SPC(13432)*/
_currn->_desc1->_ATThreadRegion_pre=FALSE;
/*SPC(13430)*/
_currn->_desc1->_ATBaseValue_pre=0;
/*SPC(13159)*/
_currn->_desc1->_ATThreadStop_pre=0;
/*SPC(13158)*/
_currn->_desc1->_ATThreadStart_pre=0;
/*SPC(13157)*/
_currn->_desc1->_ATDoAcc_pre=InitAccDo();
/*SPC(12973)*/
_currn->_desc1->_ATAccDoType_pre=0;
/*SPC(12802)*/
_currn->_desc1->_ATAccDoStmt_pre=0;
/*SPC(12798)*/
_currn->_desc1->_ATStmtNumber_pre=0;
/*SPC(12794)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12734)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12733)*/
_currn->_desc1->_ATAccDoLoopDim_pre=0;
/*SPC(12601)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=PTGNULL;
/*SPC(12375)*/
_currn->_desc1->_ATKernelNumber_pre=0;
/*SPC(12038)*/
_currn->_desc1->_ATNestLevel_pre=0;
/*SPC(11958)*/
_currn->_desc1->_ATAcceleratorRegion_pre=FALSE;
/*SPC(11402)*/
_currn->_desc1->_ATLastNonExecLine_pre=MapLine(_currn->_AT_line);
/*SPC(11380)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=FALSE;
/*SPC(9179)*/
_currn->_desc1->_ATArgCnt_pre=0;
/*SPC(8895)*/
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(8744)*/
_currn->_desc1->_ATArraySym_pre=0;
/*SPC(8603)*/
_currn->_desc1->_ATArrayId_pre=NoKey;
/*SPC(8599)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8109)*/
_currn->_desc1->_ATMaxRank_pre=0;
/*SPC(7950)*/
_currn->_desc1->_ATCPURegionNumber_pre=FALSE;
/*SPC(5187)*/
_currn->_desc1->_ATGPURegionNumber_pre=FALSE;
/*SPC(5185)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4604)*/
_currn->_desc1->_ATDeclsOrder_pre=0;
/*SPC(4229)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3678)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_VariableUseListADDROF(_currn->_AT_VariableUseauxList);
/*SPC(658)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_ProgDeclsListADDROF(_currn->_AT_ProgDeclsauxList);
/*SPC(557)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9104)*/
_currn->_ATProgramName=_currn->_desc2->_AT_const38;
/*SPC(12015)*/
_currn->_ATLastDeclarative=MAX(MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45), _currn->_desc3->_AT_const45);
/*SPC(11381)*/
_currn->_ATProgramUnitId=0;
/*SPC(5983)*/
_currn->_desc2->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc2->_ATBaseValue_pre=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStop_pre=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStart_pre=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoType_pre=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoStmt_pre=_currn->_desc1->_ATAccDoStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_AT_cProgDeclsListPtr_pre=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc3->_AT_cProgDeclsListPtr_pre=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_658(_TPPrule_658 _currn)
#else
void _VS5rule_658(_currn )
_TPPrule_658 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl54;
int* _IL_incl53;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
ProgDeclsList* _IL_incl43;
VariableUseList* _IL_incl42;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl21;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl54=_IG_incl54;_IG_incl54= &(_currn->_ATReturnStmt);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl43=_IG_incl43;_IG_incl43= &(_currn->_ATProgDeclsList);
_IL_incl42=_IG_incl42;_IG_incl42= &(_currn->_ATVariableUseList);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl21=_IG_incl21;_IG_incl21= &(_currn->_ATNumKernels);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATVariableUseList=_currn->_AT_VariableUseauxList;
/*SPC(659)*/
_currn->_ATProgDeclsList=_currn->_AT_ProgDeclsauxList;
/*SPC(558)*/
_currn->_ATNumKernels=_currn->_desc2->_AT_const41;
/*SPC(12043)*/
_currn->_desc2->_ATErrorVarDeclared_pre=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStmt_pre=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadRegion_pre=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATDataSectionPTG_pre=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_desc2->_ATKernelNumber_pre=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATProgramLineNum_pre=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATReturnStmt=_currn->_desc2->_AT_const39;
/*SPC(6423)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), NE(_currn->_ATTranslationType_pre, GPU)))) {
PTGOut(PTGAppend(PTGNumber(_currn->_desc3->_ATProgramLineNum_post), _currn->_desc2->_AT_const40));

} else {
}
;
/*SPC(13388)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATProgramLineNum_post=_currn->_desc3->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATIntent=FALSE;
/*SPC(6658)*/
_currn->_ATSym=0;
/*SPC(5983)*/
_currn->_ATBoundsList=NULLBoundsList;
/*SPC(3725)*/
_currn->_ATObjectId=NoKey;
/*SPC(3702)*/
_currn->_ATUnitId=NoKey;
/*SPC(3698)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl54=_IL_incl54;
_IG_incl53=_IL_incl53;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl43=_IL_incl43;
_IG_incl42=_IL_incl42;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl21=_IL_incl21;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_659(_TPPrule_659 _currn)
#else
void _VS1rule_659(_currn )
_TPPrule_659 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATFalse=0;
/*SPC(3347)*/
_currn->_ATKind=MainProgram;
/*SPC(3124)*/
DefaultImplicitTypes();
/*SPC(1601)*/
_currn->_desc1->_ATOrder_pre=0;
/*SPC(1198)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8595)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_659(_TPPrule_659 _currn)
#else
void _VS2rule_659(_currn )
_TPPrule_659 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_659(_TPPrule_659 _currn)
#else
void _VS3rule_659(_currn )
_TPPrule_659 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATObjectSym=0;
/*SPC(3704)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(3123)*/
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_659(_TPPrule_659 _currn)
#else
void _VS4rule_659(_currn )
_TPPrule_659 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_AT_VariableUseauxList=NULLVariableUseList;
/*SPC(657)*/
_currn->_AT_ProgDeclsauxList=NULLProgDeclsList;
/*SPC(556)*/
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_ATStmtUnitId=NoKey;
/*SPC(9104)*/
_currn->_ATProgramName=_currn->_desc1->_AT_const38;
/*SPC(12015)*/
_currn->_ATLastDeclarative=_currn->_desc1->_AT_const45;
/*SPC(11381)*/
_currn->_ATProgramUnitId=0;
/*SPC(5983)*/
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=0;
/*SPC(13159)*/
_currn->_desc1->_ATThreadStop_pre=0;
/*SPC(13158)*/
_currn->_desc1->_ATThreadStart_pre=0;
/*SPC(13157)*/
_currn->_desc1->_ATDoAcc_pre=InitAccDo();
/*SPC(12973)*/
_currn->_desc1->_ATAccDoType_pre=0;
/*SPC(12802)*/
_currn->_desc1->_ATAccDoStmt_pre=0;
/*SPC(12798)*/
_currn->_desc1->_ATStmtNumber_pre=0;
/*SPC(12794)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12733)*/
_currn->_desc1->_ATAccDoLoopDim_pre=0;
/*SPC(12601)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=0;
/*SPC(11958)*/
_currn->_desc1->_ATAcceleratorRegion_pre=FALSE;
/*SPC(11402)*/
_currn->_desc1->_ATLastNonExecLine_pre=MapLine(_currn->_AT_line);
/*SPC(11380)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=FALSE;
/*SPC(9179)*/
_currn->_desc1->_ATArgCnt_pre=0;
/*SPC(8895)*/
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(8744)*/
_currn->_desc1->_ATArraySym_pre=0;
/*SPC(8603)*/
_currn->_desc1->_ATArrayId_pre=NoKey;
/*SPC(8599)*/
_currn->_desc1->_ATMaxRank_pre=0;
/*SPC(7950)*/
_currn->_desc1->_ATCPURegionNumber_pre=FALSE;
/*SPC(5187)*/
_currn->_desc1->_ATGPURegionNumber_pre=FALSE;
/*SPC(5185)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4604)*/
_currn->_desc1->_ATDeclsOrder_pre=0;
/*SPC(4229)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_VariableUseListADDROF(_currn->_AT_VariableUseauxList);
/*SPC(658)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_ProgDeclsListADDROF(_currn->_AT_ProgDeclsauxList);
/*SPC(557)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_659(_TPPrule_659 _currn)
#else
void _VS5rule_659(_currn )
_TPPrule_659 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl54;
int* _IL_incl53;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
ProgDeclsList* _IL_incl43;
VariableUseList* _IL_incl42;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl21;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl54=_IG_incl54;_IG_incl54= &(_currn->_ATReturnStmt);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl43=_IG_incl43;_IG_incl43= &(_currn->_ATProgDeclsList);
_IL_incl42=_IG_incl42;_IG_incl42= &(_currn->_ATVariableUseList);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl21=_IG_incl21;_IG_incl21= &(_currn->_ATNumKernels);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATVariableUseList=_currn->_AT_VariableUseauxList;
/*SPC(659)*/
_currn->_ATProgDeclsList=_currn->_AT_ProgDeclsauxList;
/*SPC(558)*/
_currn->_ATNumKernels=_currn->_desc1->_AT_const41;
/*SPC(12043)*/
_currn->_desc1->_ATErrorVarDeclared_pre=FALSE;
/*SPC(13523)*/
_currn->_desc1->_ATThreadStmt_pre=FALSE;
/*SPC(13432)*/
_currn->_desc1->_ATThreadRegion_pre=FALSE;
/*SPC(13430)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12734)*/
_currn->_desc1->_ATDataSectionPTG_pre=PTGNULL;
/*SPC(12375)*/
_currn->_desc1->_ATKernelNumber_pre=0;
/*SPC(12038)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8109)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3678)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATReturnStmt=_currn->_desc1->_AT_const39;
/*SPC(6423)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), NE(_currn->_ATTranslationType_pre, GPU)))) {
PTGOut(PTGAppend(PTGNumber(_currn->_desc1->_ATProgramLineNum_post), _currn->_desc1->_AT_const40));

} else {
}
;
/*SPC(13388)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATIntent=FALSE;
/*SPC(6658)*/
_currn->_ATSym=0;
/*SPC(5983)*/
_currn->_ATBoundsList=NULLBoundsList;
/*SPC(3725)*/
_currn->_ATObjectId=NoKey;
/*SPC(3702)*/
_currn->_ATUnitId=NoKey;
/*SPC(3698)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl54=_IL_incl54;
_IG_incl53=_IL_incl53;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl43=_IL_incl43;
_IG_incl42=_IL_incl42;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl21=_IL_incl21;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_660(_TPPrule_660 _currn)
#else
void _VS1rule_660(_currn )
_TPPrule_660 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
DefaultImplicitTypes();
/*SPC(1601)*/
_currn->_desc1->_ATOrder_pre=0;
/*SPC(1198)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATFalse=0;
/*SPC(3347)*/
_currn->_ATKind=MainProgram;
/*SPC(3120)*/
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8595)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_660(_TPPrule_660 _currn)
#else
void _VS2rule_660(_currn )
_TPPrule_660 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_660(_TPPrule_660 _currn)
#else
void _VS3rule_660(_currn )
_TPPrule_660 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATObjectSym=0;
/*SPC(3704)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const38=_currn->_desc2->_AT_const38;
/*SPC(3119)*/
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_660(_TPPrule_660 _currn)
#else
void _VS4rule_660(_currn )
_TPPrule_660 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_AT_VariableUseauxList=NULLVariableUseList;
/*SPC(657)*/
_currn->_AT_ProgDeclsauxList=NULLProgDeclsList;
/*SPC(556)*/
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_desc1->_ATErrorVarDeclared_pre=FALSE;
/*SPC(13523)*/
_currn->_desc1->_ATThreadStmt_pre=FALSE;
/*SPC(13432)*/
_currn->_desc1->_ATThreadRegion_pre=FALSE;
/*SPC(13430)*/
_currn->_desc1->_ATBaseValue_pre=0;
/*SPC(13159)*/
_currn->_desc1->_ATThreadStop_pre=0;
/*SPC(13158)*/
_currn->_desc1->_ATThreadStart_pre=0;
/*SPC(13157)*/
_currn->_desc1->_ATDoAcc_pre=InitAccDo();
/*SPC(12973)*/
_currn->_desc1->_ATAccDoType_pre=0;
/*SPC(12802)*/
_currn->_desc1->_ATAccDoStmt_pre=0;
/*SPC(12798)*/
_currn->_desc1->_ATStmtNumber_pre=0;
/*SPC(12794)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12734)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12733)*/
_currn->_desc1->_ATAccDoLoopDim_pre=0;
/*SPC(12601)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=PTGNULL;
/*SPC(12375)*/
_currn->_desc1->_ATKernelNumber_pre=0;
/*SPC(12038)*/
_currn->_desc1->_ATNestLevel_pre=0;
/*SPC(11958)*/
_currn->_desc1->_ATAcceleratorRegion_pre=FALSE;
/*SPC(11402)*/
_currn->_desc1->_ATLastNonExecLine_pre=MapLine(_currn->_AT_line);
/*SPC(11380)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=FALSE;
/*SPC(9179)*/
_currn->_desc1->_ATArgCnt_pre=0;
/*SPC(8895)*/
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(8744)*/
_currn->_desc1->_ATArraySym_pre=0;
/*SPC(8603)*/
_currn->_desc1->_ATArrayId_pre=NoKey;
/*SPC(8599)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8109)*/
_currn->_desc1->_ATMaxRank_pre=0;
/*SPC(7950)*/
_currn->_desc1->_ATCPURegionNumber_pre=FALSE;
/*SPC(5187)*/
_currn->_desc1->_ATGPURegionNumber_pre=FALSE;
/*SPC(5185)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4604)*/
_currn->_desc1->_ATDeclsOrder_pre=0;
/*SPC(4229)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3678)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_VariableUseListADDROF(_currn->_AT_VariableUseauxList);
/*SPC(658)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_ProgDeclsListADDROF(_currn->_AT_ProgDeclsauxList);
/*SPC(557)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9104)*/
_currn->_ATProgramName=_currn->_desc2->_AT_const38;
/*SPC(12015)*/
_currn->_ATLastDeclarative=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(11381)*/
_currn->_ATProgramUnitId=0;
/*SPC(5983)*/
_currn->_desc2->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc2->_ATBaseValue_pre=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStop_pre=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStart_pre=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoType_pre=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoStmt_pre=_currn->_desc1->_ATAccDoStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_AT_cProgDeclsListPtr_pre=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_660(_TPPrule_660 _currn)
#else
void _VS5rule_660(_currn )
_TPPrule_660 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl54;
int* _IL_incl53;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
ProgDeclsList* _IL_incl43;
VariableUseList* _IL_incl42;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl21;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl54=_IG_incl54;_IG_incl54= &(_currn->_ATReturnStmt);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl43=_IG_incl43;_IG_incl43= &(_currn->_ATProgDeclsList);
_IL_incl42=_IG_incl42;_IG_incl42= &(_currn->_ATVariableUseList);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl21=_IG_incl21;_IG_incl21= &(_currn->_ATNumKernels);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATVariableUseList=_currn->_AT_VariableUseauxList;
/*SPC(659)*/
_currn->_ATProgDeclsList=_currn->_AT_ProgDeclsauxList;
/*SPC(558)*/
_currn->_ATNumKernels=_currn->_desc2->_AT_const41;
/*SPC(12043)*/
_currn->_desc2->_ATErrorVarDeclared_pre=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStmt_pre=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadRegion_pre=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATDataSectionPTG_pre=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_desc2->_ATKernelNumber_pre=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATReturnStmt=_currn->_desc2->_AT_const39;
/*SPC(6423)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), NE(_currn->_ATTranslationType_pre, GPU)))) {
PTGOut(PTGAppend(PTGNumber(_currn->_desc2->_ATProgramLineNum_post), _currn->_desc2->_AT_const40));

} else {
}
;
/*SPC(13388)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATIntent=FALSE;
/*SPC(6658)*/
_currn->_ATSym=0;
/*SPC(5983)*/
_currn->_ATBoundsList=NULLBoundsList;
/*SPC(3725)*/
_currn->_ATObjectId=NoKey;
/*SPC(3702)*/
_currn->_ATUnitId=NoKey;
/*SPC(3698)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl54=_IL_incl54;
_IG_incl53=_IL_incl53;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl43=_IL_incl43;
_IG_incl42=_IL_incl42;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl21=_IL_incl21;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_661(_TPPrule_661 _currn)
#else
void _VS1rule_661(_currn )
_TPPrule_661 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
DefaultImplicitTypes();
/*SPC(1601)*/
_currn->_desc1->_ATOrder_pre=0;
/*SPC(1198)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATFalse=0;
/*SPC(3347)*/
_currn->_ATKind=Subroutine;
/*SPC(3092)*/
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8595)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_661(_TPPrule_661 _currn)
#else
void _VS2rule_661(_currn )
_TPPrule_661 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_661(_TPPrule_661 _currn)
#else
void _VS3rule_661(_currn )
_TPPrule_661 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATObjectSym=0;
/*SPC(3704)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const38=ADD(IDENTICAL(_currn->_desc2->_ATProgramName), _currn->_desc3->_AT_const38);
/*SPC(3091)*/
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_661(_TPPrule_661 _currn)
#else
void _VS4rule_661(_currn )
_TPPrule_661 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_AT_VariableUseauxList=NULLVariableUseList;
/*SPC(657)*/
_currn->_AT_ProgDeclsauxList=NULLProgDeclsList;
/*SPC(556)*/
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_ATProgramName=ADD(IDENTICAL(_currn->_desc2->_ATProgramName), _currn->_desc3->_AT_const38);
/*SPC(12015)*/
_currn->_ATProgramUnitId=0;
/*SPC(5983)*/
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=0;
/*SPC(13159)*/
_currn->_desc1->_ATThreadStop_pre=0;
/*SPC(13158)*/
_currn->_desc1->_ATThreadStart_pre=0;
/*SPC(13157)*/
_currn->_desc1->_ATDoAcc_pre=InitAccDo();
/*SPC(12973)*/
_currn->_desc1->_ATAccDoType_pre=0;
/*SPC(12802)*/
_currn->_desc1->_ATAccDoStmt_pre=0;
/*SPC(12798)*/
_currn->_desc1->_ATStmtNumber_pre=0;
/*SPC(12794)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12733)*/
_currn->_desc1->_ATAccDoLoopDim_pre=0;
/*SPC(12601)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=0;
/*SPC(11958)*/
_currn->_desc1->_ATAcceleratorRegion_pre=FALSE;
/*SPC(11402)*/
_currn->_desc1->_ATLastNonExecLine_pre=MapLine(_currn->_AT_line);
/*SPC(11380)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=FALSE;
/*SPC(9179)*/
_currn->_desc1->_ATArgCnt_pre=0;
/*SPC(8895)*/
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(8744)*/
_currn->_desc1->_ATArraySym_pre=0;
/*SPC(8603)*/
_currn->_desc1->_ATArrayId_pre=NoKey;
/*SPC(8599)*/
_currn->_desc1->_ATMaxRank_pre=0;
/*SPC(7950)*/
_currn->_desc1->_ATCPURegionNumber_pre=FALSE;
/*SPC(5187)*/
_currn->_desc1->_ATGPURegionNumber_pre=FALSE;
/*SPC(5185)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4604)*/
_currn->_desc1->_ATDeclsOrder_pre=0;
/*SPC(4229)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_VariableUseListADDROF(_currn->_AT_VariableUseauxList);
/*SPC(658)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_ProgDeclsListADDROF(_currn->_AT_ProgDeclsauxList);
/*SPC(557)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9104)*/
_currn->_ATLastDeclarative=MAX(_currn->_desc2->_AT_const45, _currn->_desc3->_AT_const45);
/*SPC(11381)*/
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATBaseValue_pre=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStop_pre=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStart_pre=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoType_pre=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoStmt_pre=_currn->_desc1->_ATAccDoStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_AT_cProgDeclsListPtr_pre=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATBaseValue_pre=_currn->_desc2->_ATBaseValue_post;
/*SPC(0)*/
_currn->_desc3->_ATThreadStop_pre=_currn->_desc2->_ATThreadStop_post;
/*SPC(0)*/
_currn->_desc3->_ATThreadStart_pre=_currn->_desc2->_ATThreadStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoType_pre=_currn->_desc2->_ATAccDoType_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoStmt_pre=_currn->_desc2->_ATAccDoStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc3->_AT_cProgDeclsListPtr_pre=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_661(_TPPrule_661 _currn)
#else
void _VS5rule_661(_currn )
_TPPrule_661 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl54;
int* _IL_incl53;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
ProgDeclsList* _IL_incl43;
VariableUseList* _IL_incl42;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl21;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl54=_IG_incl54;_IG_incl54= &(_currn->_ATReturnStmt);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl43=_IG_incl43;_IG_incl43= &(_currn->_ATProgDeclsList);
_IL_incl42=_IG_incl42;_IG_incl42= &(_currn->_ATVariableUseList);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl21=_IG_incl21;_IG_incl21= &(_currn->_ATNumKernels);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_desc1->_ATErrorVarDeclared_pre=FALSE;
/*SPC(13523)*/
_currn->_desc1->_ATThreadStmt_pre=FALSE;
/*SPC(13432)*/
_currn->_desc1->_ATThreadRegion_pre=FALSE;
/*SPC(13430)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12734)*/
_currn->_desc1->_ATDataSectionPTG_pre=PTGNULL;
/*SPC(12375)*/
_currn->_desc1->_ATKernelNumber_pre=0;
/*SPC(12038)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8109)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3678)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATErrorVarDeclared_pre=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStmt_pre=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadRegion_pre=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATDataSectionPTG_pre=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_desc2->_ATKernelNumber_pre=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATVariableUseList=_currn->_AT_VariableUseauxList;
/*SPC(659)*/
_currn->_ATProgDeclsList=_currn->_AT_ProgDeclsauxList;
/*SPC(558)*/
_currn->_ATNumKernels=_currn->_desc3->_AT_const41;
/*SPC(12043)*/
_currn->_desc3->_ATErrorVarDeclared_pre=_currn->_desc2->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_desc3->_ATThreadStmt_pre=_currn->_desc2->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATThreadRegion_pre=_currn->_desc2->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATDataSectionPTG_pre=_currn->_desc2->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_desc3->_ATKernelNumber_pre=_currn->_desc2->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), NE(_currn->_ATTranslationType_pre, GPU)))) {
PTGOut(PTGAppend(PTGNumber(_currn->_desc3->_ATProgramLineNum_post), _currn->_desc3->_AT_const40));

} else {
}
;
/*SPC(13388)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATReturnStmt=_currn->_desc3->_AT_const39;
/*SPC(6423)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATProgramLineNum_post=_currn->_desc3->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATIntent=FALSE;
/*SPC(6658)*/
_currn->_ATSym=0;
/*SPC(5983)*/
_currn->_ATBoundsList=NULLBoundsList;
/*SPC(3725)*/
_currn->_ATObjectId=NoKey;
/*SPC(3702)*/
_currn->_ATUnitId=NoKey;
/*SPC(3698)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl54=_IL_incl54;
_IG_incl53=_IL_incl53;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl43=_IL_incl43;
_IG_incl42=_IL_incl42;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl21=_IL_incl21;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_662(_TPPrule_662 _currn)
#else
void _VS1rule_662(_currn )
_TPPrule_662 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
DefaultImplicitTypes();
/*SPC(1601)*/
_currn->_desc1->_ATOrder_pre=0;
/*SPC(1198)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATFalse=0;
/*SPC(3347)*/
_currn->_ATKind=Subroutine;
/*SPC(3088)*/
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8595)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_662(_TPPrule_662 _currn)
#else
void _VS2rule_662(_currn )
_TPPrule_662 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_662(_TPPrule_662 _currn)
#else
void _VS3rule_662(_currn )
_TPPrule_662 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATObjectSym=0;
/*SPC(3704)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const38=ADD(IDENTICAL(_currn->_desc1->_ATProgramName), _currn->_desc2->_AT_const38);
/*SPC(3087)*/
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_662(_TPPrule_662 _currn)
#else
void _VS4rule_662(_currn )
_TPPrule_662 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_AT_VariableUseauxList=NULLVariableUseList;
/*SPC(657)*/
_currn->_AT_ProgDeclsauxList=NULLProgDeclsList;
/*SPC(556)*/
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_ATStmtUnitId=NoKey;
/*SPC(9104)*/
_currn->_ATProgramName=ADD(IDENTICAL(_currn->_desc1->_ATProgramName), _currn->_desc2->_AT_const38);
/*SPC(12015)*/
_currn->_ATLastDeclarative=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(11381)*/
_currn->_ATProgramUnitId=SUBROUTINE;
/*SPC(5994)*/
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=0;
/*SPC(13159)*/
_currn->_desc1->_ATThreadStop_pre=0;
/*SPC(13158)*/
_currn->_desc1->_ATThreadStart_pre=0;
/*SPC(13157)*/
_currn->_desc1->_ATDoAcc_pre=InitAccDo();
/*SPC(12973)*/
_currn->_desc1->_ATAccDoType_pre=0;
/*SPC(12802)*/
_currn->_desc1->_ATAccDoStmt_pre=0;
/*SPC(12798)*/
_currn->_desc1->_ATStmtNumber_pre=0;
/*SPC(12794)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12733)*/
_currn->_desc1->_ATAccDoLoopDim_pre=0;
/*SPC(12601)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=0;
/*SPC(11958)*/
_currn->_desc1->_ATAcceleratorRegion_pre=FALSE;
/*SPC(11402)*/
_currn->_desc1->_ATLastNonExecLine_pre=MapLine(_currn->_AT_line);
/*SPC(11380)*/
_currn->_desc1->_ATDeclPowerVars_pre=FALSE;
/*SPC(9179)*/
_currn->_desc1->_ATArgCnt_pre=0;
/*SPC(8895)*/
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(8744)*/
_currn->_desc1->_ATArraySym_pre=0;
/*SPC(8603)*/
_currn->_desc1->_ATArrayId_pre=NoKey;
/*SPC(8599)*/
_currn->_desc1->_ATMaxRank_pre=0;
/*SPC(7950)*/
_currn->_desc1->_ATCPURegionNumber_pre=FALSE;
/*SPC(5187)*/
_currn->_desc1->_ATGPURegionNumber_pre=FALSE;
/*SPC(5185)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4604)*/
_currn->_desc1->_ATDeclsOrder_pre=0;
/*SPC(4229)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_VariableUseListADDROF(_currn->_AT_VariableUseauxList);
/*SPC(658)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_ProgDeclsListADDROF(_currn->_AT_ProgDeclsauxList);
/*SPC(557)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATBaseValue_pre=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStop_pre=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStart_pre=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoType_pre=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoStmt_pre=_currn->_desc1->_ATAccDoStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_AT_cProgDeclsListPtr_pre=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_662(_TPPrule_662 _currn)
#else
void _VS5rule_662(_currn )
_TPPrule_662 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl54;
int* _IL_incl53;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
ProgDeclsList* _IL_incl43;
VariableUseList* _IL_incl42;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl21;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl54=_IG_incl54;_IG_incl54= &(_currn->_ATReturnStmt);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl43=_IG_incl43;_IG_incl43= &(_currn->_ATProgDeclsList);
_IL_incl42=_IG_incl42;_IG_incl42= &(_currn->_ATVariableUseList);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl21=_IG_incl21;_IG_incl21= &(_currn->_ATNumKernels);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_desc1->_ATErrorVarDeclared_pre=FALSE;
/*SPC(13523)*/
_currn->_desc1->_ATThreadStmt_pre=FALSE;
/*SPC(13432)*/
_currn->_desc1->_ATThreadRegion_pre=FALSE;
/*SPC(13430)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12734)*/
_currn->_desc1->_ATDataSectionPTG_pre=PTGNULL;
/*SPC(12375)*/
_currn->_desc1->_ATKernelNumber_pre=0;
/*SPC(12038)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8109)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3678)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATVariableUseList=_currn->_AT_VariableUseauxList;
/*SPC(659)*/
_currn->_ATProgDeclsList=_currn->_AT_ProgDeclsauxList;
/*SPC(558)*/
_currn->_ATNumKernels=_currn->_desc2->_AT_const41;
/*SPC(12043)*/
_currn->_desc2->_ATErrorVarDeclared_pre=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStmt_pre=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadRegion_pre=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATDataSectionPTG_pre=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_desc2->_ATKernelNumber_pre=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), NE(_currn->_ATTranslationType_pre, GPU)))) {
PTGOut(PTGAppend(PTGNumber(_currn->_desc2->_ATProgramLineNum_post), _currn->_desc2->_AT_const40));

} else {
}
;
/*SPC(13388)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATReturnStmt=_currn->_desc2->_AT_const39;
/*SPC(6423)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATIntent=FALSE;
/*SPC(6658)*/
_currn->_ATSym=0;
/*SPC(5983)*/
_currn->_ATBoundsList=NULLBoundsList;
/*SPC(3725)*/
_currn->_ATObjectId=NoKey;
/*SPC(3702)*/
_currn->_ATUnitId=NoKey;
/*SPC(3698)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl54=_IL_incl54;
_IG_incl53=_IL_incl53;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl43=_IL_incl43;
_IG_incl42=_IL_incl42;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl21=_IL_incl21;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_663(_TPPrule_663 _currn)
#else
void _VS1rule_663(_currn )
_TPPrule_663 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

if (GetKindSet(_currn->_desc1->_ATUnitKey, Variable)) {
InsertKindSet(_currn->_desc1->_ATUnitKey, ExternalFunction);

} else {
}
;
/*SPC(3073)*/
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_663(_TPPrule_663 _currn)
#else
void _VS2rule_663(_currn )
_TPPrule_663 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_663(_TPPrule_663 _currn)
#else
void _VS3rule_663(_currn )
_TPPrule_663 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=TRUE;
/*SPC(8722)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_663(_TPPrule_663 _currn)
#else
void _VS4rule_663(_currn )
_TPPrule_663 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATisArray_RuleAttr_1120=_currn->_ATIsArray_pre;
/*SPC(8721)*/
_currn->_ATIsArray_post=_currn->_ATisArray_RuleAttr_1120;
/*SPC(8723)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_663(_TPPrule_663 _currn)
#else
void _VS5rule_663(_currn )
_TPPrule_663 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=1;
/*SPC(8803)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATlocal_RuleAttr_1120=_currn->_ATLocalIndex_pre;
/*SPC(8802)*/
_currn->_ATLocalIndex_post=_currn->_ATlocal_RuleAttr_1120;
/*SPC(8804)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_663(_TPPrule_663 _currn)
#else
void _VS6rule_663(_currn )
_TPPrule_663 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_663(_TPPrule_663 _currn)
#else
void _VS7rule_663(_currn )
_TPPrule_663 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=0;
/*SPC(8926)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATSym;
/*SPC(8726)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_ATarraySym_RuleAttr_1120=_currn->_ATArraySym_pre;
/*SPC(8725)*/
_currn->_ATnumArgs_RuleAttr_1120=_currn->_ATArgCnt_pre;
/*SPC(8925)*/
_currn->_ATArgCnt_post=_currn->_ATnumArgs_RuleAttr_1120;
/*SPC(8927)*/
_currn->_ATArraySym_post=_currn->_ATarraySym_RuleAttr_1120;
/*SPC(8727)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_663(_TPPrule_663 _currn)
#else
void _VS8rule_663(_currn )
_TPPrule_663 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATObjectKey;
/*SPC(8718)*/
_currn->_desc2->_ATMaxMinFunct=
((NOT(InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())))
) ? (
((OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "max"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "max0"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "max1"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "amax0"), 0), EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "amax1"), 0)))))
) ? (FMAX
) : (
((OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "min"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "min0"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "min1"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "amin0"), 0), EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "amin1"), 0)))))
) ? (FMIN
) : (FALSE))
))

) : (FALSE))
;
/*SPC(8929)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const33=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(3070)*/
_currn->_ATarrayId_RuleAttr_1120=_currn->_ATArrayId_pre;
/*SPC(8717)*/
_currn->_ATfunctionName_RuleAttr_1120=
((NOT(InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())))
) ? (PTGAsIs(getIntrinsicName(StringTable(_currn->_desc1->_ATSym), _currn->_desc2->_ATLocalIndex_post, (&( _currn->_AT_pos))))
) : (_currn->_desc1->_ATPtg))
;
/*SPC(9061)*/
_currn->_ATPtg=
((InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS()))
) ? (PTGArrayRef(_currn->_desc1->_ATPtg, FTNREFCPP(_currn->_desc1->_ATSym, _currn->_desc1->_ATRegionVars_post, 0, 0, _currn->_desc1->_ATUnitKey, _currn->_desc1->_ATObjectKey, _currn->_desc2->_ATPtg, (&( _currn->_AT_pos)), _currn->_desc1->_ATGPUVarsDeList_post))
) : (
((EQ(isIntrinsic(StringTable(_currn->_desc1->_ATSym), _currn->_desc2->_ATLocalIndex_post), TRUE)
) ? (PTGIntrinsicRef(_currn->_ATfunctionName_RuleAttr_1120, _currn->_desc2->_ATPtg)
) : (PTGFunctionRef(_currn->_ATfunctionName_RuleAttr_1120, _currn->_desc2->_ATPtg)))
))
;
/*SPC(9068)*/
_currn->_ATArrayId_post=_currn->_ATarrayId_RuleAttr_1120;
/*SPC(8719)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_663(_TPPrule_663 _currn)
#else
void _VS9rule_663(_currn )
_TPPrule_663 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATNumArgs=_currn->_desc2->_ATLocalIndex_post;
/*SPC(7038)*/
_currn->_desc1->_ATignoreVar=FALSE;
/*SPC(5129)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const18=ADD(IDENTICAL(_currn->_desc1->_ATMatch), _currn->_desc2->_AT_const18);
/*SPC(3070)*/
_currn->_AT_const32=_currn->_desc2->_AT_const32;
/*SPC(3070)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_663(_TPPrule_663 _currn)
#else
void _VS10rule_663(_currn )
_TPPrule_663 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_663(_TPPrule_663 _currn)
#else
void _VS11rule_663(_currn )
_TPPrule_663 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), GE(_currn->_desc2->_AT_const50, TRUE))))) {
message(WARNING, "Constant index value will be overwritten by other executing blocks in this loop", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12837)*/
_currn->_AT_const34=_currn->_desc2->_AT_const34;
/*SPC(3070)*/
_currn->_AT_const63=_currn->_desc2->_AT_const63;
/*SPC(3070)*/
_currn->_AT_const64=ADD(IDENTICAL(_currn->_desc1->_ATPar1), _currn->_desc2->_AT_const64);
/*SPC(3070)*/
_currn->_AT_const65=ADD(IDENTICAL(_currn->_desc1->_ATPar2), _currn->_desc2->_AT_const65);
/*SPC(3070)*/
_currn->_AT_const66=ADD(IDENTICAL(_currn->_desc1->_ATPar3), _currn->_desc2->_AT_const66);
/*SPC(3070)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATdeclLine_RuleAttr_1120=0;
/*SPC(9060)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_664(_TPPrule_664 _currn)
#else
void _VS1rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

if (GetKindSet(_currn->_desc1->_ATUnitKey, Variable)) {
InsertKindSet(_currn->_desc1->_ATUnitKey, ExternalFunction);

} else {
}
;
/*SPC(3067)*/
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_664(_TPPrule_664 _currn)
#else
void _VS2rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_664(_TPPrule_664 _currn)
#else
void _VS3rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=TRUE;
/*SPC(8694)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_664(_TPPrule_664 _currn)
#else
void _VS4rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATisArray_RuleAttr_1121=_currn->_ATIsArray_pre;
/*SPC(8693)*/
_currn->_ATIsArray_post=_currn->_ATisArray_RuleAttr_1121;
/*SPC(8695)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_664(_TPPrule_664 _currn)
#else
void _VS5rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=1;
/*SPC(8791)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATlocal_RuleAttr_1121=_currn->_desc1->_ATLocalIndex_post;
/*SPC(8790)*/
_currn->_ATLocalIndex_post=_currn->_ATlocal_RuleAttr_1121;
/*SPC(8792)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_664(_TPPrule_664 _currn)
#else
void _VS6rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATExpValue=0;
/*SPC(9238)*/
_currn->_ATObjectId=_currn->_desc1->_ATObjectKey;
/*SPC(3842)*/
_currn->_ATValue=IndCatStrStr(CatStrStr(CatStrStr(StringTable(_currn->_desc1->_ATSym), StringTable(MakeName("("))), StringTable(_currn->_desc2->_ATValue)), StringTable(MakeName(")")));
/*SPC(3994)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_664(_TPPrule_664 _currn)
#else
void _VS7rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=0;
/*SPC(8900)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATSym;
/*SPC(8698)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATarraySym_RuleAttr_1121=_currn->_ATArraySym_pre;
/*SPC(8697)*/
_currn->_ATnumArgs_RuleAttr_1121=_currn->_ATArgCnt_pre;
/*SPC(8899)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATnumArgs_RuleAttr_1121;
/*SPC(8901)*/
_currn->_ATArraySym_post=_currn->_ATarraySym_RuleAttr_1121;
/*SPC(8699)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_664(_TPPrule_664 _currn)
#else
void _VS8rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATObjectKey;
/*SPC(8690)*/
_currn->_desc2->_ATMaxMinFunct=
((NOT(InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())))
) ? (
((OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "max"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "max0"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "max1"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "amax0"), 0), EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "amax1"), 0)))))
) ? (FMAX
) : (
((OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "min"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "min0"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "min1"), 0), OR(EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "amin0"), 0), EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "amin1"), 0)))))
) ? (FMIN
) : (FALSE))
))

) : (FALSE))
;
/*SPC(8903)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const33=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(3064)*/
_currn->_ATarrayId_RuleAttr_1121=_currn->_ATArrayId_pre;
/*SPC(8689)*/
_currn->_ATarrayRef_RuleAttr_1121=FTNREFCPP(_currn->_desc1->_ATSym, _currn->_desc1->_ATRegionVars_post, 0, 0, _currn->_desc1->_ATUnitKey, _currn->_desc1->_ATObjectKey, _currn->_desc2->_ATPtg, (&( _currn->_AT_pos)), _currn->_desc1->_ATGPUVarsDeList_post);
/*SPC(8981)*/
_currn->_ATFunctionName=
((NOT(InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())))
) ? (PTGAsIs(getIntrinsicName(StringTable(_currn->_desc1->_ATSym), _currn->_desc2->_ATLocalIndex_post, (&( _currn->_AT_pos))))
) : (_currn->_desc1->_ATPtg))
;
/*SPC(9008)*/
_currn->_ATDemoted=FALSE;
/*SPC(7814)*/
_currn->_ATLoopIncrNeg=
((EQ(MOD(ZERO(), 2), 1)
) ? (TRUE
) : (FALSE))
;
/*SPC(7687)*/
_currn->_ATArrayId_post=_currn->_ATarrayId_RuleAttr_1121;
/*SPC(8691)*/
_currn->_ATPtg=
((EQ(isIntrinsic(StringTable(_currn->_desc1->_ATSym), _currn->_desc2->_ATLocalIndex_post), KIND)
) ? (_currn->_desc2->_ATPtg
) : (
((InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS()))
) ? (
((EQ((* _IG_incl53), FALSE)
) ? (PTGArrayRef(_currn->_desc1->_ATPtg, _currn->_ATarrayRef_RuleAttr_1121)
) : (PTGArrayRefArg(_currn->_desc1->_ATPtg, _currn->_ATarrayRef_RuleAttr_1121)))

) : (
((EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "mod"), 0)
) ? (_currn->_desc2->_AT_const52
) : (PTGFunctionRef(_currn->_ATFunctionName, _currn->_desc2->_ATPtg)))
))
))
;
/*SPC(8992)*/

if (AND(NOT(InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS()))), AND(NOT(InIS(ExternalFunction, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS()))), NOT(InIS(Variable, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())))))) {
message(WARNING, "Function not defined", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9018)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_664(_TPPrule_664 _currn)
#else
void _VS9rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATNumArgs=_currn->_desc2->_ATLocalIndex_post;
/*SPC(7032)*/
_currn->_desc1->_ATignoreVar=FALSE;
/*SPC(5129)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const18=ADD(IDENTICAL(_currn->_desc1->_ATMatch), _currn->_desc2->_AT_const18);
/*SPC(3064)*/
_currn->_AT_const32=_currn->_desc2->_AT_const32;
/*SPC(3064)*/
_currn->_ATrank_RuleAttr_1121=GetNumberOfDims(_currn->_desc1->_ATUnitKey, 0);
/*SPC(8015)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=
((AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)), AND(GE(_currn->_desc2->_AT_const51, TRUE), LT(_currn->_ATMaxRank_pre, _currn->_ATrank_RuleAttr_1121))))
) ? (SetRankDefineLoopVars(_currn->_ATrank_RuleAttr_1121, _currn->_ATMaxRank_pre, _currn->_ATLastNonExecLine_pre, _currn->_desc1->_ATIndentLevel_post, MapLine(((_currn->_AT_pos).line)))
) : (_currn->_ATMaxRank_pre))
;
/*SPC(8016)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_664(_TPPrule_664 _currn)
#else
void _VS10rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATtypeLen_RuleAttr_1121=GetTypeLength(_currn->_desc1->_ATUnitKey, 0);
/*SPC(5913)*/
_currn->_ATtype_RuleAttr_1121=GetType(_currn->_desc1->_ATUnitKey, ErrorType);
/*SPC(5914)*/
_currn->_ATpointer_RuleAttr_1121=
((AND(EQ(GetNumberOfDims(_currn->_desc1->_ATUnitKey, 0), 0), NE(_currn->_ATtype_RuleAttr_1121, CharacterType))
) ? (PTGNULL
) : (PTGAsIs("*")))
;
/*SPC(5916)*/
_currn->_ATArgType=PTGSubroutineArg(Convert_to_Ctype(_currn->_ATtypeLen_RuleAttr_1121, _currn->_ATtype_RuleAttr_1121), _currn->_ATpointer_RuleAttr_1121, PTGNULL);
/*SPC(5922)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_664(_TPPrule_664 _currn)
#else
void _VS11rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS12rule_664(_TPPrule_664 _currn)
#else
void _VS12rule_664(_currn )
_TPPrule_664 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=ADD(_currn->_ATDepth_pre, 1);
/*SPC(3687)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), GE(_currn->_desc2->_AT_const19, TRUE))))) {
message(WARNING, "Constant index value will be overwritten by other executing blocks in this loop", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12845)*/
_currn->_AT_const34=_currn->_desc2->_AT_const34;
/*SPC(3064)*/
_currn->_AT_const50=_currn->_desc2->_AT_const50;
/*SPC(3064)*/
_currn->_AT_const63=_currn->_desc2->_AT_const63;
/*SPC(3064)*/
_currn->_AT_const64=ADD(IDENTICAL(_currn->_desc1->_ATPar1), _currn->_desc2->_AT_const64);
/*SPC(3064)*/
_currn->_AT_const65=ADD(IDENTICAL(_currn->_desc1->_ATPar2), _currn->_desc2->_AT_const65);
/*SPC(3064)*/
_currn->_AT_const66=ADD(IDENTICAL(_currn->_desc1->_ATPar3), _currn->_desc2->_AT_const66);
/*SPC(3064)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(3688)*/
_currn->_ATdeclLine_RuleAttr_1121=0;
/*SPC(8980)*/
_currn->_ATpar1_RuleAttr_1121=
((GE(IDENTICAL(_currn->_desc1->_ATPar1), TRUE)
) ? (TRUE
) : (FALSE))
;
/*SPC(12950)*/
_currn->_ATpar2_RuleAttr_1121=
((GE(IDENTICAL(_currn->_desc1->_ATPar2), TRUE)
) ? (TRUE
) : (FALSE))
;
/*SPC(12951)*/
_currn->_ATpar3_RuleAttr_1121=
((GE(IDENTICAL(_currn->_desc1->_ATPar3), TRUE)
) ? (TRUE
) : (FALSE))
;
/*SPC(12952)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=_currn->_desc1->_ATUnitKey;
/*SPC(3841)*/

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(GE(_currn->_ATUpdate_pre, TRUE), AND(EQ(isIntrinsic(StringTable(_currn->_desc1->_ATSym), _currn->_desc2->_ATLocalIndex_post), FALSE), AND(OR(InIS(Variable, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())), InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS()))), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), AND(NE((* _IG_incl53), TRUE), AND(NE(GetGPUVarProperty(_currn->_desc1->_ATSym, _currn->_desc1->_ATGPUVarsDeList_post, SCOPE, 0), SHARED), EQ(GetBlockDim(_currn->_ATRegionVars_pre, _currn->_ATpar1_RuleAttr_1121, _currn->_ATpar2_RuleAttr_1121, _currn->_ATpar3_RuleAttr_1121, _currn->_desc1->_ATSym, _currn->_desc1->_ATGPUVarsDeList_post), FALSE))))))))) {
message(WARNING, "Variable may require storage for DO PARALLEL calculations", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12963)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_665(_TPPrule_665 _currn)
#else
void _VS1rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EmptyIS(InterIS(ConsIS(Array, ConsIS(StatementFunction, ConsIS(IntrinsicFunction, ConsIS(Subroutine, NullIS())))), GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())))) {

if (InIS(DummyArgument, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS()))) {
InsertKindSet(_currn->_desc1->_ATUnitKey, DummyProcedure);

} else {
InsertKindSet(_currn->_desc1->_ATUnitKey, ExternalFunction);
}
;

} else {
}
;
/*SPC(3046)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_665(_TPPrule_665 _currn)
#else
void _VS2rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_665(_TPPrule_665 _currn)
#else
void _VS3rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_665(_TPPrule_665 _currn)
#else
void _VS4rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_665(_TPPrule_665 _currn)
#else
void _VS5rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_665(_TPPrule_665 _currn)
#else
void _VS6rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATExpValue=0;
/*SPC(9238)*/
_currn->_ATObjectId=NoKey;
/*SPC(3838)*/
_currn->_ATValue=0;
/*SPC(862)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_665(_TPPrule_665 _currn)
#else
void _VS7rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_665(_TPPrule_665 _currn)
#else
void _VS8rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const33=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(3044)*/
_currn->_ATFunctionName=PTGNULL;
/*SPC(8976)*/
_currn->_ATDemoted=FALSE;
/*SPC(7814)*/
_currn->_ATLoopIncrNeg=
((EQ(MOD(ZERO(), 2), 1)
) ? (TRUE
) : (FALSE))
;
/*SPC(7687)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xExpr not supported.");
/*SPC(8958)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_665(_TPPrule_665 _currn)
#else
void _VS9rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATNumArgs=0;
/*SPC(7011)*/
_currn->_desc1->_ATignoreVar=FALSE;
/*SPC(5129)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const18=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(3044)*/
_currn->_AT_const32=ZERO();
/*SPC(3044)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_665(_TPPrule_665 _currn)
#else
void _VS10rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATArgType=PTGNULL;
/*SPC(5880)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_665(_TPPrule_665 _currn)
#else
void _VS11rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS12rule_665(_TPPrule_665 _currn)
#else
void _VS12rule_665(_currn )
_TPPrule_665 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=ZERO();
/*SPC(3044)*/
_currn->_AT_const50=ZERO();
/*SPC(3044)*/
_currn->_AT_const63=ZERO();
/*SPC(3044)*/
_currn->_AT_const64=IDENTICAL(_currn->_desc1->_ATPar1);
/*SPC(3044)*/
_currn->_AT_const65=IDENTICAL(_currn->_desc1->_ATPar2);
/*SPC(3044)*/
_currn->_AT_const66=IDENTICAL(_currn->_desc1->_ATPar3);
/*SPC(3044)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_666(_TPPrule_666 _currn)
#else
void _VS1rule_666(_currn )
_TPPrule_666 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_666(_TPPrule_666 _currn)
#else
void _VS2rule_666(_currn )
_TPPrule_666 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_666(_TPPrule_666 _currn)
#else
void _VS3rule_666(_currn )
_TPPrule_666 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_666(_TPPrule_666 _currn)
#else
void _VS4rule_666(_currn )
_TPPrule_666 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_666(_TPPrule_666 _currn)
#else
void _VS5rule_666(_currn )
_TPPrule_666 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_666(_TPPrule_666 _currn)
#else
void _VS6rule_666(_currn )
_TPPrule_666 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATValue=
((EQ((* _IG_incl47), 1)
) ? (_currn->_desc1->_ATLowerValue
) : (_currn->_desc1->_ATUpperValue))
;
/*SPC(4062)*/
_currn->_ATBoundsElem=PkgBounds(_currn->_desc1->_ATLocalIndex_post, (* _IG_incl48), _currn->_desc1->_ATLowerValue, _currn->_desc1->_ATUpperValue, NoKey, NoKey);
/*SPC(3985)*/
_currn->_ATBoundsTakeIt=
((EQ((* _IG_incl34), 1)
) ? (1
) : (0))
;
/*SPC(3980)*/
_currn->_AT_cBoundsListPtr_post=
((_currn->_ATBoundsTakeIt
) ? (RefEndConsBoundsList(_currn->_desc1->_AT_cBoundsListPtr_post, _currn->_ATBoundsElem)
) : (_currn->_desc1->_AT_cBoundsListPtr_post))
;
/*SPC(377)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_666(_TPPrule_666 _currn)
#else
void _VS7rule_666(_currn )
_TPPrule_666 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_666(_TPPrule_666 _currn)
#else
void _VS8rule_666(_currn )
_TPPrule_666 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(8163)*/
_currn->_ATDemoted=FALSE;
/*SPC(7851)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_666(_TPPrule_666 _currn)
#else
void _VS9rule_666(_currn )
_TPPrule_666 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const18=_currn->_desc1->_AT_const18;
/*SPC(3032)*/
_currn->_AT_const32=_currn->_desc1->_AT_const32;
/*SPC(3032)*/
_currn->_AT_const51=IDENTICAL(_currn->_desc1->_ATF90Syntax);
/*SPC(3032)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_666(_TPPrule_666 _currn)
#else
void _VS10rule_666(_currn )
_TPPrule_666 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_666(_TPPrule_666 _currn)
#else
void _VS11rule_666(_currn )
_TPPrule_666 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const19=_currn->_desc1->_AT_const19;
/*SPC(3032)*/
_currn->_AT_const34=_currn->_desc1->_AT_const34;
/*SPC(3032)*/
_currn->_AT_const50=_currn->_desc1->_AT_const50;
/*SPC(3032)*/
_currn->_AT_const63=ADD(_currn->_desc1->_AT_const63, IDENTICAL(_currn->_desc1->_ATF90Syntax));
/*SPC(3032)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(3032)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(3032)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(3032)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATNotCharacterIndex=0;
/*SPC(3034)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_667(_TPPrule_667 _currn)
#else
void _VS1rule_667(_currn )
_TPPrule_667 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_667(_TPPrule_667 _currn)
#else
void _VS2rule_667(_currn )
_TPPrule_667 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_667(_TPPrule_667 _currn)
#else
void _VS3rule_667(_currn )
_TPPrule_667 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_667(_TPPrule_667 _currn)
#else
void _VS4rule_667(_currn )
_TPPrule_667 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_667(_TPPrule_667 _currn)
#else
void _VS5rule_667(_currn )
_TPPrule_667 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_667(_TPPrule_667 _currn)
#else
void _VS6rule_667(_currn )
_TPPrule_667 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATValue=_currn->_desc1->_ATValue;
/*SPC(4018)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_667(_TPPrule_667 _currn)
#else
void _VS7rule_667(_currn )
_TPPrule_667 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_667(_TPPrule_667 _currn)
#else
void _VS8rule_667(_currn )
_TPPrule_667 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const52=IDENTICAL(_currn->_desc1->_ATPtg);
/*SPC(3027)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATDemoted=_currn->_desc1->_ATDemoted;
/*SPC(7844)*/
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(9022)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_667(_TPPrule_667 _currn)
#else
void _VS9rule_667(_currn )
_TPPrule_667 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const18=_currn->_desc1->_AT_const18;
/*SPC(3027)*/
_currn->_AT_const32=_currn->_desc1->_AT_const32;
/*SPC(3027)*/
_currn->_AT_const51=_currn->_desc1->_AT_const51;
/*SPC(3027)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_667(_TPPrule_667 _currn)
#else
void _VS10rule_667(_currn )
_TPPrule_667 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_667(_TPPrule_667 _currn)
#else
void _VS11rule_667(_currn )
_TPPrule_667 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const19=_currn->_desc1->_AT_const19;
/*SPC(3027)*/
_currn->_AT_const34=_currn->_desc1->_AT_const34;
/*SPC(3027)*/
_currn->_AT_const50=_currn->_desc1->_AT_const50;
/*SPC(3027)*/
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(3027)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(3027)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(3027)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(3027)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATNotCharacterIndex=_currn->_desc1->_ATNotCharacterIndex;
/*SPC(3029)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_668(_TPPrule_668 _currn)
#else
void _VS1rule_668(_currn )
_TPPrule_668 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
DefaultImplicitTypes();
/*SPC(1601)*/
_currn->_desc1->_ATOrder_pre=0;
/*SPC(1198)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATFalse=0;
/*SPC(3347)*/
_currn->_ATKind=ExternalFunction;
/*SPC(3022)*/
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8595)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_668(_TPPrule_668 _currn)
#else
void _VS2rule_668(_currn )
_TPPrule_668 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_668(_TPPrule_668 _currn)
#else
void _VS3rule_668(_currn )
_TPPrule_668 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATObjectSym=0;
/*SPC(3704)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const38=ADD(IDENTICAL(_currn->_desc2->_ATProgramName), _currn->_desc3->_AT_const38);
/*SPC(3020)*/
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_668(_TPPrule_668 _currn)
#else
void _VS4rule_668(_currn )
_TPPrule_668 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_AT_VariableUseauxList=NULLVariableUseList;
/*SPC(657)*/
_currn->_AT_ProgDeclsauxList=NULLProgDeclsList;
/*SPC(556)*/
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_ATProgramName=ADD(IDENTICAL(_currn->_desc2->_ATProgramName), _currn->_desc3->_AT_const38);
/*SPC(12015)*/
_currn->_ATProgramUnitId=FUNCTION;
/*SPC(5989)*/
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=0;
/*SPC(13159)*/
_currn->_desc1->_ATThreadStop_pre=0;
/*SPC(13158)*/
_currn->_desc1->_ATThreadStart_pre=0;
/*SPC(13157)*/
_currn->_desc1->_ATDoAcc_pre=InitAccDo();
/*SPC(12973)*/
_currn->_desc1->_ATAccDoType_pre=0;
/*SPC(12802)*/
_currn->_desc1->_ATAccDoStmt_pre=0;
/*SPC(12798)*/
_currn->_desc1->_ATStmtNumber_pre=0;
/*SPC(12794)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12733)*/
_currn->_desc1->_ATAccDoLoopDim_pre=0;
/*SPC(12601)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=0;
/*SPC(11958)*/
_currn->_desc1->_ATAcceleratorRegion_pre=FALSE;
/*SPC(11402)*/
_currn->_desc1->_ATLastNonExecLine_pre=MapLine(_currn->_AT_line);
/*SPC(11380)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=FALSE;
/*SPC(9179)*/
_currn->_desc1->_ATArgCnt_pre=0;
/*SPC(8895)*/
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(8744)*/
_currn->_desc1->_ATArraySym_pre=0;
/*SPC(8603)*/
_currn->_desc1->_ATArrayId_pre=NoKey;
/*SPC(8599)*/
_currn->_desc1->_ATMaxRank_pre=0;
/*SPC(7950)*/
_currn->_desc1->_ATCPURegionNumber_pre=FALSE;
/*SPC(5187)*/
_currn->_desc1->_ATGPURegionNumber_pre=FALSE;
/*SPC(5185)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4604)*/
_currn->_desc1->_ATDeclsOrder_pre=0;
/*SPC(4229)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_VariableUseListADDROF(_currn->_AT_VariableUseauxList);
/*SPC(658)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_ProgDeclsListADDROF(_currn->_AT_ProgDeclsauxList);
/*SPC(557)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9104)*/
_currn->_ATLastDeclarative=MAX(_currn->_desc2->_AT_const45, _currn->_desc3->_AT_const45);
/*SPC(11381)*/
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATBaseValue_pre=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStop_pre=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStart_pre=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoType_pre=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoStmt_pre=_currn->_desc1->_ATAccDoStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_AT_cProgDeclsListPtr_pre=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATBaseValue_pre=_currn->_desc2->_ATBaseValue_post;
/*SPC(0)*/
_currn->_desc3->_ATThreadStop_pre=_currn->_desc2->_ATThreadStop_post;
/*SPC(0)*/
_currn->_desc3->_ATThreadStart_pre=_currn->_desc2->_ATThreadStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoType_pre=_currn->_desc2->_ATAccDoType_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoStmt_pre=_currn->_desc2->_ATAccDoStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc3->_AT_cProgDeclsListPtr_pre=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_668(_TPPrule_668 _currn)
#else
void _VS5rule_668(_currn )
_TPPrule_668 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl54;
int* _IL_incl53;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
ProgDeclsList* _IL_incl43;
VariableUseList* _IL_incl42;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl21;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl54=_IG_incl54;_IG_incl54= &(_currn->_ATReturnStmt);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl43=_IG_incl43;_IG_incl43= &(_currn->_ATProgDeclsList);
_IL_incl42=_IG_incl42;_IG_incl42= &(_currn->_ATVariableUseList);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl21=_IG_incl21;_IG_incl21= &(_currn->_ATNumKernels);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_desc1->_ATErrorVarDeclared_pre=FALSE;
/*SPC(13523)*/
_currn->_desc1->_ATThreadStmt_pre=FALSE;
/*SPC(13432)*/
_currn->_desc1->_ATThreadRegion_pre=FALSE;
/*SPC(13430)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12734)*/
_currn->_desc1->_ATDataSectionPTG_pre=PTGNULL;
/*SPC(12375)*/
_currn->_desc1->_ATKernelNumber_pre=0;
/*SPC(12038)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8109)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3678)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATErrorVarDeclared_pre=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStmt_pre=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadRegion_pre=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATDataSectionPTG_pre=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_desc2->_ATKernelNumber_pre=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATVariableUseList=_currn->_AT_VariableUseauxList;
/*SPC(659)*/
_currn->_ATProgDeclsList=_currn->_AT_ProgDeclsauxList;
/*SPC(558)*/
_currn->_ATNumKernels=_currn->_desc3->_AT_const41;
/*SPC(12043)*/
_currn->_desc3->_ATErrorVarDeclared_pre=_currn->_desc2->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_desc3->_ATThreadStmt_pre=_currn->_desc2->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATThreadRegion_pre=_currn->_desc2->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATDataSectionPTG_pre=_currn->_desc2->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_desc3->_ATKernelNumber_pre=_currn->_desc2->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), NE(_currn->_ATTranslationType_pre, GPU)))) {
PTGOut(PTGAppend(PTGNumber(_currn->_desc3->_ATProgramLineNum_post), _currn->_desc3->_AT_const40));

} else {
}
;
/*SPC(13388)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATReturnStmt=_currn->_desc3->_AT_const39;
/*SPC(6423)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATProgramLineNum_post=_currn->_desc3->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATIntent=FALSE;
/*SPC(6658)*/
_currn->_ATSym=_currn->_desc2->_ATSym;
/*SPC(5990)*/
_currn->_ATBoundsList=NULLBoundsList;
/*SPC(3725)*/
_currn->_ATObjectId=NoKey;
/*SPC(3702)*/
_currn->_ATUnitId=NoKey;
/*SPC(3698)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl54=_IL_incl54;
_IG_incl53=_IL_incl53;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl43=_IL_incl43;
_IG_incl42=_IL_incl42;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl21=_IL_incl21;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_669(_TPPrule_669 _currn)
#else
void _VS1rule_669(_currn )
_TPPrule_669 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATFalse=0;
/*SPC(3347)*/
_currn->_ATKind=Module;
/*SPC(3017)*/
DefaultImplicitTypes();
/*SPC(1601)*/
_currn->_desc1->_ATOrder_pre=0;
/*SPC(1198)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8595)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_669(_TPPrule_669 _currn)
#else
void _VS2rule_669(_currn )
_TPPrule_669 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_669(_TPPrule_669 _currn)
#else
void _VS3rule_669(_currn )
_TPPrule_669 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATObjectSym=0;
/*SPC(3704)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(3016)*/
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_669(_TPPrule_669 _currn)
#else
void _VS4rule_669(_currn )
_TPPrule_669 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_desc1->_ATDoAcc_pre=InitAccDo();
/*SPC(12973)*/
_currn->_desc1->_ATStmtNumber_pre=0;
/*SPC(12794)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12734)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12733)*/
_currn->_desc1->_ATAccDoLoopDim_pre=0;
/*SPC(12601)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=0;
/*SPC(11958)*/
_currn->_desc1->_ATLastNonExecLine_pre=MapLine(_currn->_AT_line);
/*SPC(11380)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(8744)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8109)*/
_currn->_desc1->_ATGPURegionNumber_pre=FALSE;
/*SPC(5185)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4604)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3678)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_VariableUseauxList=NULLVariableUseList;
/*SPC(657)*/
_currn->_AT_ProgDeclsauxList=NULLProgDeclsList;
/*SPC(556)*/
_currn->_ATStmtUnitId=NoKey;
/*SPC(9104)*/
_currn->_ATProgramName=_currn->_desc1->_AT_const38;
/*SPC(12015)*/
_currn->_ATLastDeclarative=_currn->_desc1->_AT_const45;
/*SPC(11381)*/
_currn->_ATProgramUnitId=MODULE;
/*SPC(5998)*/
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=0;
/*SPC(13159)*/
_currn->_desc1->_ATThreadStop_pre=0;
/*SPC(13158)*/
_currn->_desc1->_ATThreadStart_pre=0;
/*SPC(13157)*/
_currn->_desc1->_ATAccDoType_pre=0;
/*SPC(12802)*/
_currn->_desc1->_ATAccDoStmt_pre=0;
/*SPC(12798)*/
_currn->_desc1->_ATAcceleratorRegion_pre=FALSE;
/*SPC(11402)*/
_currn->_desc1->_ATDeclPowerVars_pre=FALSE;
/*SPC(9179)*/
_currn->_desc1->_ATArgCnt_pre=0;
/*SPC(8895)*/
_currn->_desc1->_ATArraySym_pre=0;
/*SPC(8603)*/
_currn->_desc1->_ATArrayId_pre=NoKey;
/*SPC(8599)*/
_currn->_desc1->_ATMaxRank_pre=0;
/*SPC(7950)*/
_currn->_desc1->_ATCPURegionNumber_pre=FALSE;
/*SPC(5187)*/
_currn->_desc1->_ATDeclsOrder_pre=0;
/*SPC(4229)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_VariableUseListADDROF(_currn->_AT_VariableUseauxList);
/*SPC(658)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_ProgDeclsListADDROF(_currn->_AT_ProgDeclsauxList);
/*SPC(557)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_669(_TPPrule_669 _currn)
#else
void _VS5rule_669(_currn )
_TPPrule_669 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl54;
int* _IL_incl53;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
ProgDeclsList* _IL_incl43;
VariableUseList* _IL_incl42;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl21;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl54=_IG_incl54;_IG_incl54= &(_currn->_ATReturnStmt);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl43=_IG_incl43;_IG_incl43= &(_currn->_ATProgDeclsList);
_IL_incl42=_IG_incl42;_IG_incl42= &(_currn->_ATVariableUseList);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl21=_IG_incl21;_IG_incl21= &(_currn->_ATNumKernels);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATVariableUseList=_currn->_AT_VariableUseauxList;
/*SPC(659)*/
_currn->_ATProgDeclsList=_currn->_AT_ProgDeclsauxList;
/*SPC(558)*/
_currn->_ATNumKernels=_currn->_desc1->_AT_const41;
/*SPC(12043)*/
_currn->_desc1->_ATErrorVarDeclared_pre=FALSE;
/*SPC(13523)*/
_currn->_desc1->_ATThreadStmt_pre=FALSE;
/*SPC(13432)*/
_currn->_desc1->_ATThreadRegion_pre=FALSE;
/*SPC(13430)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=PTGNULL;
/*SPC(12375)*/
_currn->_desc1->_ATKernelNumber_pre=0;
/*SPC(12038)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATReturnStmt=_currn->_desc1->_AT_const39;
/*SPC(6423)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), NE(_currn->_ATTranslationType_pre, GPU)))) {
PTGOut(PTGAppend(PTGNumber(_currn->_desc1->_ATProgramLineNum_post), _currn->_desc1->_AT_const40));

} else {
}
;
/*SPC(13388)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATIntent=FALSE;
/*SPC(6658)*/
_currn->_ATSym=0;
/*SPC(5983)*/
_currn->_ATBoundsList=NULLBoundsList;
/*SPC(3725)*/
_currn->_ATObjectId=NoKey;
/*SPC(3702)*/
_currn->_ATUnitId=NoKey;
/*SPC(3698)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl54=_IL_incl54;
_IG_incl53=_IL_incl53;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl43=_IL_incl43;
_IG_incl42=_IL_incl42;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl21=_IL_incl21;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_670(_TPPrule_670 _currn)
#else
void _VS1rule_670(_currn )
_TPPrule_670 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
DefaultImplicitTypes();
/*SPC(1601)*/
_currn->_desc1->_ATOrder_pre=0;
/*SPC(1198)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATFalse=0;
/*SPC(3347)*/
_currn->_ATKind=ExternalFunction;
/*SPC(3013)*/
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8595)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_670(_TPPrule_670 _currn)
#else
void _VS2rule_670(_currn )
_TPPrule_670 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_670(_TPPrule_670 _currn)
#else
void _VS3rule_670(_currn )
_TPPrule_670 _currn;

#endif
{
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_ATObjectSym=0;
/*SPC(3704)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const38=ADD(IDENTICAL(_currn->_desc1->_ATProgramName), _currn->_desc2->_AT_const38);
/*SPC(3011)*/
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_670(_TPPrule_670 _currn)
#else
void _VS4rule_670(_currn )
_TPPrule_670 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl53;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_AT_VariableUseauxList=NULLVariableUseList;
/*SPC(657)*/
_currn->_AT_ProgDeclsauxList=NULLProgDeclsList;
/*SPC(556)*/
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_ATStmtUnitId=NoKey;
/*SPC(9104)*/
_currn->_ATProgramName=ADD(IDENTICAL(_currn->_desc1->_ATProgramName), _currn->_desc2->_AT_const38);
/*SPC(12015)*/
_currn->_ATLastDeclarative=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(11381)*/
_currn->_ATProgramUnitId=FUNCTION;
/*SPC(5985)*/
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=0;
/*SPC(13159)*/
_currn->_desc1->_ATThreadStop_pre=0;
/*SPC(13158)*/
_currn->_desc1->_ATThreadStart_pre=0;
/*SPC(13157)*/
_currn->_desc1->_ATDoAcc_pre=InitAccDo();
/*SPC(12973)*/
_currn->_desc1->_ATAccDoType_pre=0;
/*SPC(12802)*/
_currn->_desc1->_ATAccDoStmt_pre=0;
/*SPC(12798)*/
_currn->_desc1->_ATStmtNumber_pre=0;
/*SPC(12794)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12733)*/
_currn->_desc1->_ATAccDoLoopDim_pre=0;
/*SPC(12601)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=0;
/*SPC(11958)*/
_currn->_desc1->_ATAcceleratorRegion_pre=FALSE;
/*SPC(11402)*/
_currn->_desc1->_ATLastNonExecLine_pre=MapLine(_currn->_AT_line);
/*SPC(11380)*/
_currn->_desc1->_ATDeclPowerVars_pre=FALSE;
/*SPC(9179)*/
_currn->_desc1->_ATArgCnt_pre=0;
/*SPC(8895)*/
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(8744)*/
_currn->_desc1->_ATArraySym_pre=0;
/*SPC(8603)*/
_currn->_desc1->_ATArrayId_pre=NoKey;
/*SPC(8599)*/
_currn->_desc1->_ATMaxRank_pre=0;
/*SPC(7950)*/
_currn->_desc1->_ATCPURegionNumber_pre=FALSE;
/*SPC(5187)*/
_currn->_desc1->_ATGPURegionNumber_pre=FALSE;
/*SPC(5185)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4604)*/
_currn->_desc1->_ATDeclsOrder_pre=0;
/*SPC(4229)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_VariableUseListADDROF(_currn->_AT_VariableUseauxList);
/*SPC(658)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_ProgDeclsListADDROF(_currn->_AT_ProgDeclsauxList);
/*SPC(557)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATBaseValue_pre=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStop_pre=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStart_pre=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoType_pre=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoStmt_pre=_currn->_desc1->_ATAccDoStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_AT_cProgDeclsListPtr_pre=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl53=_IL_incl53;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_670(_TPPrule_670 _currn)
#else
void _VS5rule_670(_currn )
_TPPrule_670 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl59;
int* _IL_incl57;
int* _IL_incl58;
int* _IL_incl54;
int* _IL_incl53;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl48;
int* _IL_incl47;
ProgDeclsList* _IL_incl43;
VariableUseList* _IL_incl42;
int* _IL_incl39;
int* _IL_incl38;
int* _IL_incl35;
int* _IL_incl34;
KindSetElement* _IL_incl31;
Environment* _IL_incl22;
Environment* _IL_incl23;
int* _IL_incl21;
int* _IL_incl20;
int* _IL_incl19;
int* _IL_incl5;
int* _IL_incl4;
int* _IL_incl2;
int* _IL_incl1;
int* _IL_incl0;
int* _IL_incl6;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATFalse);
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATFalse);
_IL_incl58=_IG_incl58;_IG_incl58= &(_currn->_ATFalse);
_IL_incl54=_IG_incl54;_IG_incl54= &(_currn->_ATReturnStmt);
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATFalse);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATFalse);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATFalse);
_IL_incl48=_IG_incl48;_IG_incl48= &(_currn->_ATObjectSym);
_IL_incl47=_IG_incl47;_IG_incl47= &(_currn->_ATFalse);
_IL_incl43=_IG_incl43;_IG_incl43= &(_currn->_ATProgDeclsList);
_IL_incl42=_IG_incl42;_IG_incl42= &(_currn->_ATVariableUseList);
_IL_incl39=_IG_incl39;_IG_incl39= &(_currn->_ATProgramUnitId);
_IL_incl38=_IG_incl38;_IG_incl38= &(_currn->_ATLastDeclarative);
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATFalse);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATFalse);
_IL_incl31=_IG_incl31;_IG_incl31= &(_currn->_ATKind);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_IL_incl21=_IG_incl21;_IG_incl21= &(_currn->_ATNumKernels);
_IL_incl20=_IG_incl20;_IG_incl20= &(_currn->_ATProgramName);
_IL_incl19=_IG_incl19;_IG_incl19= &(_currn->_ATFalse);
_IL_incl5=_IG_incl5;_IG_incl5= &(_currn->_ATFalse);
_IL_incl4=_IG_incl4;_IG_incl4= &(_currn->_ATFalse);
_IL_incl2=_IG_incl2;_IG_incl2= &(_currn->_ATFalse);
_IL_incl1=_IG_incl1;_IG_incl1= &(_currn->_ATFalse);
_IL_incl0=_IG_incl0;_IG_incl0= &(_currn->_ATFalse);
_IL_incl6=_IG_incl6;_IG_incl6= &(_currn->_ATFalse);
_currn->_desc1->_ATErrorVarDeclared_pre=FALSE;
/*SPC(13523)*/
_currn->_desc1->_ATThreadStmt_pre=FALSE;
/*SPC(13432)*/
_currn->_desc1->_ATThreadRegion_pre=FALSE;
/*SPC(13430)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12734)*/
_currn->_desc1->_ATDataSectionPTG_pre=PTGNULL;
/*SPC(12375)*/
_currn->_desc1->_ATKernelNumber_pre=0;
/*SPC(12038)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8109)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3678)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATVariableUseList=_currn->_AT_VariableUseauxList;
/*SPC(659)*/
_currn->_ATProgDeclsList=_currn->_AT_ProgDeclsauxList;
/*SPC(558)*/
_currn->_ATNumKernels=_currn->_desc2->_AT_const41;
/*SPC(12043)*/
_currn->_desc2->_ATErrorVarDeclared_pre=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStmt_pre=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadRegion_pre=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATDataSectionPTG_pre=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_desc2->_ATKernelNumber_pre=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), NE(_currn->_ATTranslationType_pre, GPU)))) {
PTGOut(PTGAppend(PTGNumber(_currn->_desc2->_ATProgramLineNum_post), _currn->_desc2->_AT_const40));

} else {
}
;
/*SPC(13388)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATReturnStmt=_currn->_desc2->_AT_const39;
/*SPC(6423)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATIntent=FALSE;
/*SPC(6658)*/
_currn->_ATSym=_currn->_desc1->_ATSym;
/*SPC(5986)*/
_currn->_ATBoundsList=NULLBoundsList;
/*SPC(3725)*/
_currn->_ATObjectId=NoKey;
/*SPC(3702)*/
_currn->_ATUnitId=NoKey;
/*SPC(3698)*/
_IG_incl60=_IL_incl60;
_IG_incl59=_IL_incl59;
_IG_incl57=_IL_incl57;
_IG_incl58=_IL_incl58;
_IG_incl54=_IL_incl54;
_IG_incl53=_IL_incl53;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl48=_IL_incl48;
_IG_incl47=_IL_incl47;
_IG_incl43=_IL_incl43;
_IG_incl42=_IL_incl42;
_IG_incl39=_IL_incl39;
_IG_incl38=_IL_incl38;
_IG_incl35=_IL_incl35;
_IG_incl34=_IL_incl34;
_IG_incl31=_IL_incl31;
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;
_IG_incl21=_IL_incl21;
_IG_incl20=_IL_incl20;
_IG_incl19=_IL_incl19;
_IG_incl5=_IL_incl5;
_IG_incl4=_IL_incl4;
_IG_incl2=_IL_incl2;
_IG_incl1=_IL_incl1;
_IG_incl0=_IL_incl0;
_IG_incl6=_IL_incl6;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_671(_TPPrule_671 _currn)
#else
void _VS1rule_671(_currn )
_TPPrule_671 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
InsertKindSet(_currn->_desc1->_ATUnitKey, CommonBlock);
/*SPC(2995)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_671(_TPPrule_671 _currn)
#else
void _VS3rule_671(_currn )
_TPPrule_671 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_672(_TPPrule_672 _currn)
#else
void _VS1rule_672(_currn )
_TPPrule_672 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
ImplicitType(_currn->_desc1->_ATType, _currn->_ATTERM_1, (&( _currn->_AT_pos)));
/*SPC(2772)*/
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_672(_TPPrule_672 _currn)
#else
void _VS2rule_672(_currn )
_TPPrule_672 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_672(_TPPrule_672 _currn)
#else
void _VS3rule_672(_currn )
_TPPrule_672 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_672(_TPPrule_672 _currn)
#else
void _VS4rule_672(_currn )
_TPPrule_672 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_672(_TPPrule_672 _currn)
#else
void _VS5rule_672(_currn )
_TPPrule_672 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_673(_TPPrule_673 _currn)
#else
void _VS1rule_673(_currn )
_TPPrule_673 _currn;

#endif
{
int* _IL_incl49;

_VisitVarDecl()
_VisitEntry();
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGRemove(PTGNumb(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(4732)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDims=0;
/*SPC(3930)*/
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
_currn->_desc3->_ATType=_currn->_desc2->_ATType;
/*SPC(2748)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
_IG_incl49=_IL_incl49;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_673(_TPPrule_673 _currn)
#else
void _VS2rule_673(_currn )
_TPPrule_673 _currn;

#endif
{
int* _IL_incl49;

_VisitVarDecl()
_VisitEntry();
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const10=ZERO();
/*SPC(2746)*/
_IG_incl49=_IL_incl49;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_673(_TPPrule_673 _currn)
#else
void _VS3rule_673(_currn )
_TPPrule_673 _currn;

#endif
{
int* _IL_incl57;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl46;

_VisitVarDecl()
_VisitEntry();
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATParameterAttr);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATAttrStmt);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_IL_incl46=_IG_incl46;_IG_incl46= &(_currn->_ATParameterAttr);
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATParameterAttr=
((EQ(ZERO(), TRUE)
) ? (TRUE
) : (FALSE))
;
/*SPC(4107)*/
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_currn->_ATAttrStmt=1;
/*SPC(3847)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2746)*/
_IG_incl57=_IL_incl57;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl46=_IL_incl46;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_673(_TPPrule_673 _currn)
#else
void _VS4rule_673(_currn )
_TPPrule_673 _currn;

#endif
{
int* _IL_incl57;
int* _IL_incl52;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl46;

_VisitVarDecl()
_VisitEntry();
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATParameterAttr);
_IL_incl52=_IG_incl52;_IG_incl52= &(_currn->_ATIntent);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATAttrStmt);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_IL_incl46=_IG_incl46;_IG_incl46= &(_currn->_ATParameterAttr);
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIntent=FALSE;
/*SPC(6659)*/
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc3->_AT_cProgDeclsListPtr_pre=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc3->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc3->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc3->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc3->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc3->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc3->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl57=_IL_incl57;
_IG_incl52=_IL_incl52;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl46=_IL_incl46;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_673(_TPPrule_673 _currn)
#else
void _VS5rule_673(_currn )
_TPPrule_673 _currn;

#endif
{
int* _IL_incl57;
int* _IL_incl52;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl46;

_VisitVarDecl()
_VisitEntry();
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATParameterAttr);
_IL_incl52=_IG_incl52;_IG_incl52= &(_currn->_ATIntent);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATAttrStmt);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_IL_incl46=_IG_incl46;_IG_incl46= &(_currn->_ATParameterAttr);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3680)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc3->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(4719)*/
_currn->_ATSizeValue=0;
/*SPC(3931)*/
_IG_incl57=_IL_incl57;
_IG_incl52=_IL_incl52;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl46=_IL_incl46;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_674(_TPPrule_674 _currn)
#else
void _VS1rule_674(_currn )
_TPPrule_674 _currn;

#endif
{
int* _IL_incl49;

_VisitVarDecl()
_VisitEntry();
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGRemove(PTGNumb(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(4724)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDims=0;
/*SPC(3930)*/
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
_currn->_desc3->_ATType=_currn->_desc2->_ATType;
/*SPC(2743)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
_IG_incl49=_IL_incl49;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_674(_TPPrule_674 _currn)
#else
void _VS2rule_674(_currn )
_TPPrule_674 _currn;

#endif
{
int* _IL_incl49;

_VisitVarDecl()
_VisitEntry();
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const10=ZERO();
/*SPC(2741)*/
_IG_incl49=_IL_incl49;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_674(_TPPrule_674 _currn)
#else
void _VS3rule_674(_currn )
_TPPrule_674 _currn;

#endif
{
int* _IL_incl57;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl46;

_VisitVarDecl()
_VisitEntry();
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATParameterAttr);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATAttrStmt);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_IL_incl46=_IG_incl46;_IG_incl46= &(_currn->_ATParameterAttr);
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATParameterAttr=FALSE;
/*SPC(4092)*/
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_currn->_ATAttrStmt=1;
/*SPC(3847)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2741)*/
_IG_incl57=_IL_incl57;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl46=_IL_incl46;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_674(_TPPrule_674 _currn)
#else
void _VS4rule_674(_currn )
_TPPrule_674 _currn;

#endif
{
int* _IL_incl57;
int* _IL_incl52;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl46;

_VisitVarDecl()
_VisitEntry();
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATParameterAttr);
_IL_incl52=_IG_incl52;_IG_incl52= &(_currn->_ATIntent);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATAttrStmt);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_IL_incl46=_IG_incl46;_IG_incl46= &(_currn->_ATParameterAttr);
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIntent=FALSE;
/*SPC(6659)*/
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc3->_AT_cProgDeclsListPtr_pre=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc3->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc3->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc3->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc3->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc3->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc3->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl57=_IL_incl57;
_IG_incl52=_IL_incl52;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl46=_IL_incl46;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_674(_TPPrule_674 _currn)
#else
void _VS5rule_674(_currn )
_TPPrule_674 _currn;

#endif
{
int* _IL_incl57;
int* _IL_incl52;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl46;

_VisitVarDecl()
_VisitEntry();
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATParameterAttr);
_IL_incl52=_IG_incl52;_IG_incl52= &(_currn->_ATIntent);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATAttrStmt);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_IL_incl46=_IG_incl46;_IG_incl46= &(_currn->_ATParameterAttr);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3680)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc3->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(4719)*/
_currn->_ATSizeValue=0;
/*SPC(3931)*/
_IG_incl57=_IL_incl57;
_IG_incl52=_IL_incl52;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl46=_IL_incl46;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_675(_TPPrule_675 _currn)
#else
void _VS1rule_675(_currn )
_TPPrule_675 _currn;

#endif
{
int* _IL_incl49;

_VisitVarDecl()
_VisitEntry();
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGRemove(PTGNumb(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(4740)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATDims=_currn->_desc3->_AT_const57;
/*SPC(3934)*/
_currn->_desc4->_ATOrder_pre=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
_currn->_desc4->_ATType=_currn->_desc2->_ATType;
/*SPC(2738)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATOrder_post=_currn->_desc4->_ATOrder_post;
/*SPC(0)*/
_IG_incl49=_IL_incl49;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_675(_TPPrule_675 _currn)
#else
void _VS2rule_675(_currn )
_TPPrule_675 _currn;

#endif
{
int* _IL_incl49;

_VisitVarDecl()
_VisitEntry();
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_AT_const10=_currn->_desc3->_AT_const10;
/*SPC(2736)*/
_IG_incl49=_IL_incl49;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_675(_TPPrule_675 _currn)
#else
void _VS3rule_675(_currn )
_TPPrule_675 _currn;

#endif
{
int* _IL_incl57;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl46;

_VisitVarDecl()
_VisitEntry();
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATParameterAttr);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATAttrStmt);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_IL_incl46=_IG_incl46;_IG_incl46= &(_currn->_ATParameterAttr);
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATLocalIndex_pre=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc4->_ATIsArray_pre=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
_currn->_desc4->_AT_cBoundsListPtr_pre=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATParameterAttr=
((EQ(_currn->_desc3->_AT_const56, TRUE)
) ? (TRUE
) : (FALSE))
;
/*SPC(4098)*/
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_currn->_ATAttrStmt=1;
/*SPC(3847)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2736)*/
_IG_incl57=_IL_incl57;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl46=_IL_incl46;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_675(_TPPrule_675 _currn)
#else
void _VS4rule_675(_currn )
_TPPrule_675 _currn;

#endif
{
int* _IL_incl57;
int* _IL_incl52;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl46;

_VisitVarDecl()
_VisitEntry();
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATParameterAttr);
_IL_incl52=_IG_incl52;_IG_incl52= &(_currn->_ATIntent);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATAttrStmt);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_IL_incl46=_IG_incl46;_IG_incl46= &(_currn->_ATParameterAttr);
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIntent=_currn->_desc3->_AT_const59;
/*SPC(6662)*/
_currn->_desc4->_ATTranslationType_pre=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc4->_ATDoAcc_pre=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc4->_ATStmtNumber_pre=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATUpdate_pre=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc4->_ATAccDoLoopDim_pre=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc4->_ATRegionVars_pre=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc4->_ATNestLevel_pre=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc4->_ATAcceleratorRegion_pre=_currn->_desc3->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc4->_ATLastNonExecLine_pre=_currn->_desc3->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc4->_ATIndentLevel_pre=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc4->_ATDeclPowerVars_pre=_currn->_desc3->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc4->_ATArgCnt_pre=_currn->_desc3->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc4->_ATArraySym_pre=_currn->_desc3->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc4->_ATArrayId_pre=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc4->_ATMaxRank_pre=_currn->_desc3->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc4->_ATCPURegionNumber_pre=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATGPURegionNumber_pre=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATTypeLength_pre=_currn->_desc3->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc4->_ATDeclsOrder_pre=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc4->_AT_cVariableUseListPtr_pre=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc4->_AT_cProgDeclsListPtr_pre=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_desc4->_ATGPUVarsDeList_pre=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATTranslationType_post=_currn->_desc4->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc4->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc4->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc4->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc4->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc4->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc4->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc4->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc4->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc4->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc4->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc4->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc4->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc4->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc4->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc4->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc4->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc4->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc4->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc4->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc4->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl57=_IL_incl57;
_IG_incl52=_IL_incl52;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl46=_IL_incl46;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_675(_TPPrule_675 _currn)
#else
void _VS5rule_675(_currn )
_TPPrule_675 _currn;

#endif
{
int* _IL_incl57;
int* _IL_incl52;
BoundsList* _IL_incl51;
int* _IL_incl50;
int* _IL_incl49;
int* _IL_incl46;

_VisitVarDecl()
_VisitEntry();
_IL_incl57=_IG_incl57;_IG_incl57= &(_currn->_ATParameterAttr);
_IL_incl52=_IG_incl52;_IG_incl52= &(_currn->_ATIntent);
_IL_incl51=_IG_incl51;_IG_incl51= &(_currn->_ATBoundsList);
_IL_incl50=_IG_incl50;_IG_incl50= &(_currn->_ATAttrStmt);
_IL_incl49=_IG_incl49;_IG_incl49= &(_currn->_ATDims);
_IL_incl46=_IG_incl46;_IG_incl46= &(_currn->_ATParameterAttr);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3680)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc4->_ATDepth_pre=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATUpdateStmt_post=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc4->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc4->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc4->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(4719)*/
_currn->_ATSizeValue=_currn->_desc3->_AT_const58;
/*SPC(3936)*/
_IG_incl57=_IL_incl57;
_IG_incl52=_IL_incl52;
_IG_incl51=_IL_incl51;
_IG_incl50=_IL_incl50;
_IG_incl49=_IL_incl49;
_IG_incl46=_IL_incl46;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_676(_TPPrule_676 _currn)
#else
void _VS1rule_676(_currn )
_TPPrule_676 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_676(_TPPrule_676 _currn)
#else
void _VS2rule_676(_currn )
_TPPrule_676 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_676(_TPPrule_676 _currn)
#else
void _VS3rule_676(_currn )
_TPPrule_676 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_676(_TPPrule_676 _currn)
#else
void _VS4rule_676(_currn )
_TPPrule_676 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_676(_TPPrule_676 _currn)
#else
void _VS5rule_676(_currn )
_TPPrule_676 _currn;

#endif
{
int* _IL_incl59;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATKindLen);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATKindLen=TRUE;
/*SPC(4639)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl59=_IL_incl59;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_676(_TPPrule_676 _currn)
#else
void _VS6rule_676(_currn )
_TPPrule_676 _currn;

#endif
{
int* _IL_incl59;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATKindLen);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_IG_incl59=_IL_incl59;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_677(_TPPrule_677 _currn)
#else
void _VS1rule_677(_currn )
_TPPrule_677 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_677(_TPPrule_677 _currn)
#else
void _VS2rule_677(_currn )
_TPPrule_677 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_677(_TPPrule_677 _currn)
#else
void _VS3rule_677(_currn )
_TPPrule_677 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_677(_TPPrule_677 _currn)
#else
void _VS4rule_677(_currn )
_TPPrule_677 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_677(_TPPrule_677 _currn)
#else
void _VS5rule_677(_currn )
_TPPrule_677 _currn;

#endif
{
int* _IL_incl59;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATKindLen);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATKindLen=TRUE;
/*SPC(4635)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl59=_IL_incl59;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_677(_TPPrule_677 _currn)
#else
void _VS6rule_677(_currn )
_TPPrule_677 _currn;

#endif
{
int* _IL_incl59;

_VisitVarDecl()
_VisitEntry();
_IL_incl59=_IG_incl59;_IG_incl59= &(_currn->_ATKindLen);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_IG_incl59=_IL_incl59;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_678(_TPPrule_678 _currn)
#else
void _VS1rule_678(_currn )
_TPPrule_678 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_ATType=DoublePrecisionType;
/*SPC(2727)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_678(_TPPrule_678 _currn)
#else
void _VS3rule_678(_currn )
_TPPrule_678 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_678(_TPPrule_678 _currn)
#else
void _VS4rule_678(_currn )
_TPPrule_678 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_678(_TPPrule_678 _currn)
#else
void _VS5rule_678(_currn )
_TPPrule_678 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_678(_TPPrule_678 _currn)
#else
void _VS6rule_678(_currn )
_TPPrule_678 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("double");
/*SPC(4374)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_679(_TPPrule_679 _currn)
#else
void _VS1rule_679(_currn )
_TPPrule_679 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_ATType=DoublePrecisionType;
/*SPC(2723)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_679(_TPPrule_679 _currn)
#else
void _VS3rule_679(_currn )
_TPPrule_679 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_679(_TPPrule_679 _currn)
#else
void _VS4rule_679(_currn )
_TPPrule_679 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_679(_TPPrule_679 _currn)
#else
void _VS5rule_679(_currn )
_TPPrule_679 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_679(_TPPrule_679 _currn)
#else
void _VS6rule_679(_currn )
_TPPrule_679 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("double");
/*SPC(4370)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_680(_TPPrule_680 _currn)
#else
void _VS1rule_680(_currn )
_TPPrule_680 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "F2C-ACC ERROR: Type not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4467)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_currn->_ATType=ComplexType;
/*SPC(2719)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_680(_TPPrule_680 _currn)
#else
void _VS2rule_680(_currn )
_TPPrule_680 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_680(_TPPrule_680 _currn)
#else
void _VS3rule_680(_currn )
_TPPrule_680 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_680(_TPPrule_680 _currn)
#else
void _VS4rule_680(_currn )
_TPPrule_680 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_680(_TPPrule_680 _currn)
#else
void _VS5rule_680(_currn )
_TPPrule_680 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_680(_TPPrule_680 _currn)
#else
void _VS6rule_680(_currn )
_TPPrule_680 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(4350)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_681(_TPPrule_681 _currn)
#else
void _VS1rule_681(_currn )
_TPPrule_681 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_ATType=LogicalType;
/*SPC(2713)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "F2C-ACC ERROR: Type not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4472)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_681(_TPPrule_681 _currn)
#else
void _VS3rule_681(_currn )
_TPPrule_681 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_681(_TPPrule_681 _currn)
#else
void _VS4rule_681(_currn )
_TPPrule_681 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_681(_TPPrule_681 _currn)
#else
void _VS5rule_681(_currn )
_TPPrule_681 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_681(_TPPrule_681 _currn)
#else
void _VS6rule_681(_currn )
_TPPrule_681 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(4350)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_682(_TPPrule_682 _currn)
#else
void _VS1rule_682(_currn )
_TPPrule_682 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "F2C-ACC WARNING: Type length not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4444)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_currn->_ATType=LogicalType;
/*SPC(2709)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_682(_TPPrule_682 _currn)
#else
void _VS2rule_682(_currn )
_TPPrule_682 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_682(_TPPrule_682 _currn)
#else
void _VS3rule_682(_currn )
_TPPrule_682 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_682(_TPPrule_682 _currn)
#else
void _VS4rule_682(_currn )
_TPPrule_682 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_682(_TPPrule_682 _currn)
#else
void _VS5rule_682(_currn )
_TPPrule_682 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_682(_TPPrule_682 _currn)
#else
void _VS6rule_682(_currn )
_TPPrule_682 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("static int");
/*SPC(4442)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_683(_TPPrule_683 _currn)
#else
void _VS1rule_683(_currn )
_TPPrule_683 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_currn->_ATType=RealType;
/*SPC(2704)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_683(_TPPrule_683 _currn)
#else
void _VS2rule_683(_currn )
_TPPrule_683 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_683(_TPPrule_683 _currn)
#else
void _VS3rule_683(_currn )
_TPPrule_683 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_683(_TPPrule_683 _currn)
#else
void _VS4rule_683(_currn )
_TPPrule_683 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_683(_TPPrule_683 _currn)
#else
void _VS5rule_683(_currn )
_TPPrule_683 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_683(_TPPrule_683 _currn)
#else
void _VS6rule_683(_currn )
_TPPrule_683 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=
((EQ(_currn->_desc1->_ATLength, 4)
) ? (PTGAsIs("float")
) : (
((EQ(_currn->_desc1->_ATLength, 8)
) ? (PTGAsIs("double")
) : (PTGNULL))
))
;
/*SPC(4391)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_684(_TPPrule_684 _currn)
#else
void _VS1rule_684(_currn )
_TPPrule_684 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_currn->_ATType=IntegerType;
/*SPC(2699)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_684(_TPPrule_684 _currn)
#else
void _VS2rule_684(_currn )
_TPPrule_684 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_684(_TPPrule_684 _currn)
#else
void _VS3rule_684(_currn )
_TPPrule_684 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_684(_TPPrule_684 _currn)
#else
void _VS4rule_684(_currn )
_TPPrule_684 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_684(_TPPrule_684 _currn)
#else
void _VS5rule_684(_currn )
_TPPrule_684 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_684(_TPPrule_684 _currn)
#else
void _VS6rule_684(_currn )
_TPPrule_684 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=
((EQ(_currn->_desc1->_ATLength, 2)
) ? (PTGAsIs("short")
) : (
((EQ(_currn->_desc1->_ATLength, 4)
) ? (PTGAsIs("int")
) : (
((EQ(_currn->_desc1->_ATLength, 8)
) ? (PTGAsIs("long")
) : (PTGNULL))
))
))
;
/*SPC(4378)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_685(_TPPrule_685 _currn)
#else
void _VS1rule_685(_currn )
_TPPrule_685 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Limited support for this type.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4436)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_currn->_ATType=CharacterType;
/*SPC(2694)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_685(_TPPrule_685 _currn)
#else
void _VS2rule_685(_currn )
_TPPrule_685 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_685(_TPPrule_685 _currn)
#else
void _VS3rule_685(_currn )
_TPPrule_685 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_685(_TPPrule_685 _currn)
#else
void _VS4rule_685(_currn )
_TPPrule_685 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_685(_TPPrule_685 _currn)
#else
void _VS5rule_685(_currn )
_TPPrule_685 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_685(_TPPrule_685 _currn)
#else
void _VS6rule_685(_currn )
_TPPrule_685 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("char");
/*SPC(4433)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_686(_TPPrule_686 _currn)
#else
void _VS1rule_686(_currn )
_TPPrule_686 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_ATType=CharacterType;
/*SPC(2689)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_686(_TPPrule_686 _currn)
#else
void _VS3rule_686(_currn )
_TPPrule_686 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_686(_TPPrule_686 _currn)
#else
void _VS4rule_686(_currn )
_TPPrule_686 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_686(_TPPrule_686 _currn)
#else
void _VS5rule_686(_currn )
_TPPrule_686 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_686(_TPPrule_686 _currn)
#else
void _VS6rule_686(_currn )
_TPPrule_686 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("char");
/*SPC(4366)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_687(_TPPrule_687 _currn)
#else
void _VS1rule_687(_currn )
_TPPrule_687 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "F2C-ACC WARNING: Type length not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4451)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_currn->_ATType=LogicalType;
/*SPC(2683)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_687(_TPPrule_687 _currn)
#else
void _VS2rule_687(_currn )
_TPPrule_687 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_687(_TPPrule_687 _currn)
#else
void _VS3rule_687(_currn )
_TPPrule_687 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_687(_TPPrule_687 _currn)
#else
void _VS4rule_687(_currn )
_TPPrule_687 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_687(_TPPrule_687 _currn)
#else
void _VS5rule_687(_currn )
_TPPrule_687 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_687(_TPPrule_687 _currn)
#else
void _VS6rule_687(_currn )
_TPPrule_687 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("static int");
/*SPC(4449)*/

_VisitExit();
}


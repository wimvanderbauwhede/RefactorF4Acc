
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
void _VS1rule_222(_TPPrule_222 _currn)
#else
void _VS1rule_222(_currn )
_TPPrule_222 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATOrder_pre=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATOrder_post=_currn->_desc4->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_222(_TPPrule_222 _currn)
#else
void _VS2rule_222(_currn )
_TPPrule_222 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_222(_TPPrule_222 _currn)
#else
void _VS3rule_222(_currn )
_TPPrule_222 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATLocalIndex_pre=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc4->_ATIsArray_pre=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
_currn->_desc4->_AT_cBoundsListPtr_pre=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATLocalIndex_post=_currn->_desc4->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc4->_ATIsArray_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc4->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_222(_TPPrule_222 _currn)
#else
void _VS4rule_222(_currn )
_TPPrule_222 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_desc4->_ATGPUVarsDeList_pre=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
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
_currn->_ATArraySym_post=_currn->_desc4->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc4->_ATArrayId_post;
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
_currn->_ATGPUVarsDeList_post=_currn->_desc4->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_222(_TPPrule_222 _currn)
#else
void _VS5rule_222(_currn )
_TPPrule_222 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc4->_ATDepth_pre=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATUpdateStmt_post=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc4->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_223(_TPPrule_223 _currn)
#else
void _VS1rule_223(_currn )
_TPPrule_223 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10095)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_223(_TPPrule_223 _currn)
#else
void _VS2rule_223(_currn )
_TPPrule_223 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_223(_TPPrule_223 _currn)
#else
void _VS4rule_223(_currn )
_TPPrule_223 _currn;

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
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(10093)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_223(_TPPrule_223 _currn)
#else
void _VS5rule_223(_currn )
_TPPrule_223 _currn;

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
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(11193)*/
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_223(_TPPrule_223 _currn)
#else
void _VS6rule_223(_currn )
_TPPrule_223 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(_currn->_ATStmtNumber_pre, _currn->_ATThreadStmt_pre), NE(_currn->_ATStmtNumber_pre, FALSE))))) {
PTGOut(PTGThreadEnd(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

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
_currn->_AT_const39=ZERO();
/*SPC(10093)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
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
void _VS7rule_223(_TPPrule_223 _currn)
#else
void _VS7rule_223(_currn )
_TPPrule_223 _currn;

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
void _VS1rule_224(_TPPrule_224 _currn)
#else
void _VS1rule_224(_currn )
_TPPrule_224 _currn;

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
void _VS2rule_224(_TPPrule_224 _currn)
#else
void _VS2rule_224(_currn )
_TPPrule_224 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
void _VS2rule_225(_TPPrule_225 _currn)
#else
void _VS2rule_225(_currn )
_TPPrule_225 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_225(_TPPrule_225 _currn)
#else
void _VS3rule_225(_currn )
_TPPrule_225 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS1rule_226(_TPPrule_226 _currn)
#else
void _VS1rule_226(_currn )
_TPPrule_226 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_226(_TPPrule_226 _currn)
#else
void _VS2rule_226(_currn )
_TPPrule_226 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_226(_TPPrule_226 _currn)
#else
void _VS3rule_226(_currn )
_TPPrule_226 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
void _VS1rule_227(_TPPrule_227 _currn)
#else
void _VS1rule_227(_currn )
_TPPrule_227 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATEnv=NewScope((* _IG_incl22));
/*SPC(162)*/
_currn->_desc1->_ATUnitEnv=NewScope((* _IG_incl23));
/*SPC(26)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(10081)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_227(_TPPrule_227 _currn)
#else
void _VS2rule_227(_currn )
_TPPrule_227 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_227(_TPPrule_227 _currn)
#else
void _VS3rule_227(_currn )
_TPPrule_227 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_228(_TPPrule_228 _currn)
#else
void _VS1rule_228(_currn )
_TPPrule_228 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10077)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(10075)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_228(_TPPrule_228 _currn)
#else
void _VS2rule_228(_currn )
_TPPrule_228 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_228(_TPPrule_228 _currn)
#else
void _VS3rule_228(_currn )
_TPPrule_228 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_229(_TPPrule_229 _currn)
#else
void _VS1rule_229(_currn )
_TPPrule_229 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10071)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(10069)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_229(_TPPrule_229 _currn)
#else
void _VS2rule_229(_currn )
_TPPrule_229 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_229(_TPPrule_229 _currn)
#else
void _VS3rule_229(_currn )
_TPPrule_229 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_230(_TPPrule_230 _currn)
#else
void _VS1rule_230(_currn )
_TPPrule_230 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10065)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(10063)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_230(_TPPrule_230 _currn)
#else
void _VS2rule_230(_currn )
_TPPrule_230 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_230(_TPPrule_230 _currn)
#else
void _VS3rule_230(_currn )
_TPPrule_230 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_231(_TPPrule_231 _currn)
#else
void _VS1rule_231(_currn )
_TPPrule_231 _currn;

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
void _VS2rule_231(_TPPrule_231 _currn)
#else
void _VS2rule_231(_currn )
_TPPrule_231 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_231(_TPPrule_231 _currn)
#else
void _VS3rule_231(_currn )
_TPPrule_231 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_231(_TPPrule_231 _currn)
#else
void _VS4rule_231(_currn )
_TPPrule_231 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(10060)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_231(_TPPrule_231 _currn)
#else
void _VS5rule_231(_currn )
_TPPrule_231 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=ZERO();
/*SPC(10060)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_231(_TPPrule_231 _currn)
#else
void _VS6rule_231(_currn )
_TPPrule_231 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATSingleLineIf=FALSE;
/*SPC(7144)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=ADD(_currn->_desc1->_AT_const39, IDENTICAL(_currn->_desc1->_ATReturnStmt));
/*SPC(10060)*/
_currn->_AT_const40=PTGNull();
/*SPC(10060)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_231(_TPPrule_231 _currn)
#else
void _VS7rule_231(_currn )
_TPPrule_231 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_232(_TPPrule_232 _currn)
#else
void _VS1rule_232(_currn )
_TPPrule_232 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_desc1->_ATUnitEnv=NewScope((* _IG_incl23));
/*SPC(26)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_232(_TPPrule_232 _currn)
#else
void _VS2rule_232(_currn )
_TPPrule_232 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_232(_TPPrule_232 _currn)
#else
void _VS4rule_232(_currn )
_TPPrule_232 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(10057)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_232(_TPPrule_232 _currn)
#else
void _VS5rule_232(_currn )
_TPPrule_232 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(10057)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_232(_TPPrule_232 _currn)
#else
void _VS6rule_232(_currn )
_TPPrule_232 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(10057)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(10057)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_232(_TPPrule_232 _currn)
#else
void _VS7rule_232(_currn )
_TPPrule_232 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_233(_TPPrule_233 _currn)
#else
void _VS1rule_233(_currn )
_TPPrule_233 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_233(_TPPrule_233 _currn)
#else
void _VS2rule_233(_currn )
_TPPrule_233 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_233(_TPPrule_233 _currn)
#else
void _VS3rule_233(_currn )
_TPPrule_233 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_233(_TPPrule_233 _currn)
#else
void _VS4rule_233(_currn )
_TPPrule_233 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(10054)*/
_currn->_AT_const45=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(10054)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_233(_TPPrule_233 _currn)
#else
void _VS5rule_233(_currn )
_TPPrule_233 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(10054)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_233(_TPPrule_233 _currn)
#else
void _VS6rule_233(_currn )
_TPPrule_233 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(10054)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(10054)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_233(_TPPrule_233 _currn)
#else
void _VS7rule_233(_currn )
_TPPrule_233 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_234(_TPPrule_234 _currn)
#else
void _VS1rule_234(_currn )
_TPPrule_234 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_234(_TPPrule_234 _currn)
#else
void _VS2rule_234(_currn )
_TPPrule_234 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_234(_TPPrule_234 _currn)
#else
void _VS3rule_234(_currn )
_TPPrule_234 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_234(_TPPrule_234 _currn)
#else
void _VS4rule_234(_currn )
_TPPrule_234 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(10051)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_234(_TPPrule_234 _currn)
#else
void _VS5rule_234(_currn )
_TPPrule_234 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
_currn->_AT_const41=_currn->_desc2->_AT_const41;
/*SPC(10051)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc2->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc2->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc2->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc2->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc2->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_234(_TPPrule_234 _currn)
#else
void _VS6rule_234(_currn )
_TPPrule_234 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_AT_const39=_currn->_desc2->_AT_const39;
/*SPC(10051)*/
_currn->_AT_const40=_currn->_desc2->_AT_const40;
/*SPC(10051)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc2->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc2->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc2->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc2->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc2->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_234(_TPPrule_234 _currn)
#else
void _VS7rule_234(_currn )
_TPPrule_234 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_235(_TPPrule_235 _currn)
#else
void _VS1rule_235(_currn )
_TPPrule_235 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_235(_TPPrule_235 _currn)
#else
void _VS2rule_235(_currn )
_TPPrule_235 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_235(_TPPrule_235 _currn)
#else
void _VS3rule_235(_currn )
_TPPrule_235 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_235(_TPPrule_235 _currn)
#else
void _VS4rule_235(_currn )
_TPPrule_235 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(10048)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_235(_TPPrule_235 _currn)
#else
void _VS5rule_235(_currn )
_TPPrule_235 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
_currn->_AT_const41=_currn->_desc2->_AT_const41;
/*SPC(10048)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc2->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc2->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc2->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc2->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc2->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_235(_TPPrule_235 _currn)
#else
void _VS6rule_235(_currn )
_TPPrule_235 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_AT_const39=_currn->_desc2->_AT_const39;
/*SPC(10048)*/
_currn->_AT_const40=_currn->_desc2->_AT_const40;
/*SPC(10048)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc2->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc2->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc2->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc2->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc2->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_235(_TPPrule_235 _currn)
#else
void _VS7rule_235(_currn )
_TPPrule_235 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_236(_TPPrule_236 _currn)
#else
void _VS1rule_236(_currn )
_TPPrule_236 _currn;

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
void _VS2rule_236(_TPPrule_236 _currn)
#else
void _VS2rule_236(_currn )
_TPPrule_236 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_236(_TPPrule_236 _currn)
#else
void _VS3rule_236(_currn )
_TPPrule_236 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_236(_TPPrule_236 _currn)
#else
void _VS4rule_236(_currn )
_TPPrule_236 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=ZERO();
/*SPC(10045)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(10045)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_236(_TPPrule_236 _currn)
#else
void _VS5rule_236(_currn )
_TPPrule_236 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(10045)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_236(_TPPrule_236 _currn)
#else
void _VS6rule_236(_currn )
_TPPrule_236 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(10045)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(10045)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_236(_TPPrule_236 _currn)
#else
void _VS7rule_236(_currn )
_TPPrule_236 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_237(_TPPrule_237 _currn)
#else
void _VS1rule_237(_currn )
_TPPrule_237 _currn;

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
void _VS2rule_237(_TPPrule_237 _currn)
#else
void _VS2rule_237(_currn )
_TPPrule_237 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_237(_TPPrule_237 _currn)
#else
void _VS3rule_237(_currn )
_TPPrule_237 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_237(_TPPrule_237 _currn)
#else
void _VS4rule_237(_currn )
_TPPrule_237 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(10042)*/
_currn->_AT_const45=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(10042)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_237(_TPPrule_237 _currn)
#else
void _VS5rule_237(_currn )
_TPPrule_237 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_AT_const41=ADD(_currn->_desc1->_AT_const41, _currn->_desc2->_AT_const41);
/*SPC(10042)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc2->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc2->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc2->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc2->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc2->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_237(_TPPrule_237 _currn)
#else
void _VS6rule_237(_currn )
_TPPrule_237 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATErrorVarDeclared_pre=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStmt_pre=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadRegion_pre=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATProgramLineNum_pre=_currn->_desc1->_ATProgramLineNum_post;
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
_currn->_AT_const39=ADD(_currn->_desc1->_AT_const39, _currn->_desc2->_AT_const39);
/*SPC(10042)*/
_currn->_AT_const40=PTGSequence(_currn->_desc1->_AT_const40, _currn->_desc2->_AT_const40);
/*SPC(10042)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc2->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc2->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc2->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc2->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc2->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_237(_TPPrule_237 _currn)
#else
void _VS7rule_237(_currn )
_TPPrule_237 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_238(_TPPrule_238 _currn)
#else
void _VS1rule_238(_currn )
_TPPrule_238 _currn;

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

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_238(_TPPrule_238 _currn)
#else
void _VS2rule_238(_currn )
_TPPrule_238 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_238(_TPPrule_238 _currn)
#else
void _VS3rule_238(_currn )
_TPPrule_238 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_238(_TPPrule_238 _currn)
#else
void _VS4rule_238(_currn )
_TPPrule_238 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const38=_currn->_desc2->_AT_const38;
/*SPC(10039)*/
_currn->_AT_const45=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(10039)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_238(_TPPrule_238 _currn)
#else
void _VS5rule_238(_currn )
_TPPrule_238 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc2->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc2->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc2->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc2->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
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
_currn->_desc2->_AT_cProgDeclsListPtr_pre=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const41=_currn->_desc2->_AT_const41;
/*SPC(10039)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc2->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc2->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc2->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc2->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc2->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_238(_TPPrule_238 _currn)
#else
void _VS6rule_238(_currn )
_TPPrule_238 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc2->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc2->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc2->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=_currn->_desc2->_AT_const39;
/*SPC(10039)*/
_currn->_AT_const40=_currn->_desc2->_AT_const40;
/*SPC(10039)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc2->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc2->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc2->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc2->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc2->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_238(_TPPrule_238 _currn)
#else
void _VS7rule_238(_currn )
_TPPrule_238 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_239(_TPPrule_239 _currn)
#else
void _VS1rule_239(_currn )
_TPPrule_239 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10035)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_239(_TPPrule_239 _currn)
#else
void _VS2rule_239(_currn )
_TPPrule_239 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_239(_TPPrule_239 _currn)
#else
void _VS4rule_239(_currn )
_TPPrule_239 _currn;

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
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(10033)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_239(_TPPrule_239 _currn)
#else
void _VS5rule_239(_currn )
_TPPrule_239 _currn;

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
_currn->_desc3->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(11193)*/
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc3->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc3->_ATDoAcc_post, ACCDO, _currn->_desc3->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc3->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc3->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_239(_TPPrule_239 _currn)
#else
void _VS6rule_239(_currn )
_TPPrule_239 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(_currn->_ATStmtNumber_pre, _currn->_ATThreadStmt_pre), NE(_currn->_ATStmtNumber_pre, FALSE))))) {
PTGOut(PTGThreadEnd(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

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
_currn->_AT_const39=ZERO();
/*SPC(10033)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
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
void _VS7rule_239(_TPPrule_239 _currn)
#else
void _VS7rule_239(_currn )
_TPPrule_239 _currn;

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
void _VS1rule_240(_TPPrule_240 _currn)
#else
void _VS1rule_240(_currn )
_TPPrule_240 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10029)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_240(_TPPrule_240 _currn)
#else
void _VS2rule_240(_currn )
_TPPrule_240 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_240(_TPPrule_240 _currn)
#else
void _VS4rule_240(_currn )
_TPPrule_240 _currn;

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
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(10027)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_240(_TPPrule_240 _currn)
#else
void _VS5rule_240(_currn )
_TPPrule_240 _currn;

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
_currn->_desc3->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(11193)*/
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc3->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc3->_ATDoAcc_post, ACCDO, _currn->_desc3->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc3->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc3->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_240(_TPPrule_240 _currn)
#else
void _VS6rule_240(_currn )
_TPPrule_240 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(_currn->_ATStmtNumber_pre, _currn->_ATThreadStmt_pre), NE(_currn->_ATStmtNumber_pre, FALSE))))) {
PTGOut(PTGThreadEnd(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

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
_currn->_AT_const39=ZERO();
/*SPC(10027)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
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
void _VS7rule_240(_TPPrule_240 _currn)
#else
void _VS7rule_240(_currn )
_TPPrule_240 _currn;

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
void _VS1rule_241(_TPPrule_241 _currn)
#else
void _VS1rule_241(_currn )
_TPPrule_241 _currn;

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
void _VS2rule_241(_TPPrule_241 _currn)
#else
void _VS2rule_241(_currn )
_TPPrule_241 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_241(_TPPrule_241 _currn)
#else
void _VS3rule_241(_currn )
_TPPrule_241 _currn;

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
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
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
void _VS1rule_242(_TPPrule_242 _currn)
#else
void _VS1rule_242(_currn )
_TPPrule_242 _currn;

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
void _VS2rule_242(_TPPrule_242 _currn)
#else
void _VS2rule_242(_currn )
_TPPrule_242 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_242(_TPPrule_242 _currn)
#else
void _VS3rule_242(_currn )
_TPPrule_242 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_243(_TPPrule_243 _currn)
#else
void _VS1rule_243(_currn )
_TPPrule_243 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

if (InIS(InExternalStmt, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS()))) {
InsertKindSet(_currn->_desc1->_ATUnitKey, DummyProcedure);

} else {
InsertKindSet(_currn->_desc1->_ATUnitKey, DummyArgument);
}
;
/*SPC(3565)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_243(_TPPrule_243 _currn)
#else
void _VS2rule_243(_currn )
_TPPrule_243 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_243(_TPPrule_243 _currn)
#else
void _VS3rule_243(_currn )
_TPPrule_243 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_244(_TPPrule_244 _currn)
#else
void _VS1rule_244(_currn )
_TPPrule_244 _currn;

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
void _VS2rule_244(_TPPrule_244 _currn)
#else
void _VS2rule_244(_currn )
_TPPrule_244 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_244(_TPPrule_244 _currn)
#else
void _VS3rule_244(_currn )
_TPPrule_244 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_244(_TPPrule_244 _currn)
#else
void _VS4rule_244(_currn )
_TPPrule_244 _currn;

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
void _VS5rule_244(_TPPrule_244 _currn)
#else
void _VS5rule_244(_currn )
_TPPrule_244 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_245(_TPPrule_245 _currn)
#else
void _VS1rule_245(_currn )
_TPPrule_245 _currn;

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
void _VS2rule_245(_TPPrule_245 _currn)
#else
void _VS2rule_245(_currn )
_TPPrule_245 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_245(_TPPrule_245 _currn)
#else
void _VS3rule_245(_currn )
_TPPrule_245 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_245(_TPPrule_245 _currn)
#else
void _VS4rule_245(_currn )
_TPPrule_245 _currn;

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
void _VS5rule_245(_TPPrule_245 _currn)
#else
void _VS5rule_245(_currn )
_TPPrule_245 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_246(_TPPrule_246 _currn)
#else
void _VS1rule_246(_currn )
_TPPrule_246 _currn;

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
void _VS2rule_246(_TPPrule_246 _currn)
#else
void _VS2rule_246(_currn )
_TPPrule_246 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_246(_TPPrule_246 _currn)
#else
void _VS3rule_246(_currn )
_TPPrule_246 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_246(_TPPrule_246 _currn)
#else
void _VS4rule_246(_currn )
_TPPrule_246 _currn;

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
void _VS5rule_246(_TPPrule_246 _currn)
#else
void _VS5rule_246(_currn )
_TPPrule_246 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_247(_TPPrule_247 _currn)
#else
void _VS1rule_247(_currn )
_TPPrule_247 _currn;

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
void _VS2rule_247(_TPPrule_247 _currn)
#else
void _VS2rule_247(_currn )
_TPPrule_247 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_247(_TPPrule_247 _currn)
#else
void _VS3rule_247(_currn )
_TPPrule_247 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_247(_TPPrule_247 _currn)
#else
void _VS4rule_247(_currn )
_TPPrule_247 _currn;

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
void _VS5rule_247(_TPPrule_247 _currn)
#else
void _VS5rule_247(_currn )
_TPPrule_247 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_248(_TPPrule_248 _currn)
#else
void _VS1rule_248(_currn )
_TPPrule_248 _currn;

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
void _VS2rule_248(_TPPrule_248 _currn)
#else
void _VS2rule_248(_currn )
_TPPrule_248 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_248(_TPPrule_248 _currn)
#else
void _VS3rule_248(_currn )
_TPPrule_248 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_248(_TPPrule_248 _currn)
#else
void _VS4rule_248(_currn )
_TPPrule_248 _currn;

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
void _VS5rule_248(_TPPrule_248 _currn)
#else
void _VS5rule_248(_currn )
_TPPrule_248 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_249(_TPPrule_249 _currn)
#else
void _VS1rule_249(_currn )
_TPPrule_249 _currn;

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
void _VS2rule_249(_TPPrule_249 _currn)
#else
void _VS2rule_249(_currn )
_TPPrule_249 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_249(_TPPrule_249 _currn)
#else
void _VS3rule_249(_currn )
_TPPrule_249 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_249(_TPPrule_249 _currn)
#else
void _VS4rule_249(_currn )
_TPPrule_249 _currn;

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
void _VS5rule_249(_TPPrule_249 _currn)
#else
void _VS5rule_249(_currn )
_TPPrule_249 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_250(_TPPrule_250 _currn)
#else
void _VS1rule_250(_currn )
_TPPrule_250 _currn;

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
void _VS2rule_250(_TPPrule_250 _currn)
#else
void _VS2rule_250(_currn )
_TPPrule_250 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_250(_TPPrule_250 _currn)
#else
void _VS3rule_250(_currn )
_TPPrule_250 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_250(_TPPrule_250 _currn)
#else
void _VS4rule_250(_currn )
_TPPrule_250 _currn;

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
void _VS5rule_250(_TPPrule_250 _currn)
#else
void _VS5rule_250(_currn )
_TPPrule_250 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_251(_TPPrule_251 _currn)
#else
void _VS1rule_251(_currn )
_TPPrule_251 _currn;

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
void _VS2rule_251(_TPPrule_251 _currn)
#else
void _VS2rule_251(_currn )
_TPPrule_251 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_251(_TPPrule_251 _currn)
#else
void _VS3rule_251(_currn )
_TPPrule_251 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_251(_TPPrule_251 _currn)
#else
void _VS4rule_251(_currn )
_TPPrule_251 _currn;

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
void _VS5rule_251(_TPPrule_251 _currn)
#else
void _VS5rule_251(_currn )
_TPPrule_251 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_252(_TPPrule_252 _currn)
#else
void _VS1rule_252(_currn )
_TPPrule_252 _currn;

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
void _VS2rule_252(_TPPrule_252 _currn)
#else
void _VS2rule_252(_currn )
_TPPrule_252 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_252(_TPPrule_252 _currn)
#else
void _VS3rule_252(_currn )
_TPPrule_252 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_252(_TPPrule_252 _currn)
#else
void _VS4rule_252(_currn )
_TPPrule_252 _currn;

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
void _VS5rule_252(_TPPrule_252 _currn)
#else
void _VS5rule_252(_currn )
_TPPrule_252 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_253(_TPPrule_253 _currn)
#else
void _VS1rule_253(_currn )
_TPPrule_253 _currn;

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
void _VS2rule_253(_TPPrule_253 _currn)
#else
void _VS2rule_253(_currn )
_TPPrule_253 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_253(_TPPrule_253 _currn)
#else
void _VS3rule_253(_currn )
_TPPrule_253 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_253(_TPPrule_253 _currn)
#else
void _VS4rule_253(_currn )
_TPPrule_253 _currn;

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
void _VS5rule_253(_TPPrule_253 _currn)
#else
void _VS5rule_253(_currn )
_TPPrule_253 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_254(_TPPrule_254 _currn)
#else
void _VS1rule_254(_currn )
_TPPrule_254 _currn;

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
void _VS2rule_254(_TPPrule_254 _currn)
#else
void _VS2rule_254(_currn )
_TPPrule_254 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_254(_TPPrule_254 _currn)
#else
void _VS3rule_254(_currn )
_TPPrule_254 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_254(_TPPrule_254 _currn)
#else
void _VS4rule_254(_currn )
_TPPrule_254 _currn;

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
void _VS5rule_254(_TPPrule_254 _currn)
#else
void _VS5rule_254(_currn )
_TPPrule_254 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_255(_TPPrule_255 _currn)
#else
void _VS1rule_255(_currn )
_TPPrule_255 _currn;

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
void _VS2rule_255(_TPPrule_255 _currn)
#else
void _VS2rule_255(_currn )
_TPPrule_255 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_255(_TPPrule_255 _currn)
#else
void _VS3rule_255(_currn )
_TPPrule_255 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_255(_TPPrule_255 _currn)
#else
void _VS4rule_255(_currn )
_TPPrule_255 _currn;

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
void _VS5rule_255(_TPPrule_255 _currn)
#else
void _VS5rule_255(_currn )
_TPPrule_255 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_256(_TPPrule_256 _currn)
#else
void _VS1rule_256(_currn )
_TPPrule_256 _currn;

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
void _VS2rule_256(_TPPrule_256 _currn)
#else
void _VS2rule_256(_currn )
_TPPrule_256 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_256(_TPPrule_256 _currn)
#else
void _VS3rule_256(_currn )
_TPPrule_256 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_256(_TPPrule_256 _currn)
#else
void _VS4rule_256(_currn )
_TPPrule_256 _currn;

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
void _VS5rule_256(_TPPrule_256 _currn)
#else
void _VS5rule_256(_currn )
_TPPrule_256 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_257(_TPPrule_257 _currn)
#else
void _VS1rule_257(_currn )
_TPPrule_257 _currn;

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
void _VS2rule_257(_TPPrule_257 _currn)
#else
void _VS2rule_257(_currn )
_TPPrule_257 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_257(_TPPrule_257 _currn)
#else
void _VS3rule_257(_currn )
_TPPrule_257 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_257(_TPPrule_257 _currn)
#else
void _VS4rule_257(_currn )
_TPPrule_257 _currn;

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
void _VS5rule_257(_TPPrule_257 _currn)
#else
void _VS5rule_257(_currn )
_TPPrule_257 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_258(_TPPrule_258 _currn)
#else
void _VS1rule_258(_currn )
_TPPrule_258 _currn;

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
void _VS2rule_258(_TPPrule_258 _currn)
#else
void _VS2rule_258(_currn )
_TPPrule_258 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_258(_TPPrule_258 _currn)
#else
void _VS3rule_258(_currn )
_TPPrule_258 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_258(_TPPrule_258 _currn)
#else
void _VS4rule_258(_currn )
_TPPrule_258 _currn;

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
void _VS5rule_258(_TPPrule_258 _currn)
#else
void _VS5rule_258(_currn )
_TPPrule_258 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_259(_TPPrule_259 _currn)
#else
void _VS1rule_259(_currn )
_TPPrule_259 _currn;

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
void _VS2rule_259(_TPPrule_259 _currn)
#else
void _VS2rule_259(_currn )
_TPPrule_259 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_259(_TPPrule_259 _currn)
#else
void _VS3rule_259(_currn )
_TPPrule_259 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_259(_TPPrule_259 _currn)
#else
void _VS4rule_259(_currn )
_TPPrule_259 _currn;

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
void _VS5rule_259(_TPPrule_259 _currn)
#else
void _VS5rule_259(_currn )
_TPPrule_259 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_260(_TPPrule_260 _currn)
#else
void _VS1rule_260(_currn )
_TPPrule_260 _currn;

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
void _VS2rule_260(_TPPrule_260 _currn)
#else
void _VS2rule_260(_currn )
_TPPrule_260 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_260(_TPPrule_260 _currn)
#else
void _VS3rule_260(_currn )
_TPPrule_260 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_260(_TPPrule_260 _currn)
#else
void _VS4rule_260(_currn )
_TPPrule_260 _currn;

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
void _VS5rule_260(_TPPrule_260 _currn)
#else
void _VS5rule_260(_currn )
_TPPrule_260 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_261(_TPPrule_261 _currn)
#else
void _VS1rule_261(_currn )
_TPPrule_261 _currn;

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
void _VS2rule_261(_TPPrule_261 _currn)
#else
void _VS2rule_261(_currn )
_TPPrule_261 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_261(_TPPrule_261 _currn)
#else
void _VS3rule_261(_currn )
_TPPrule_261 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_261(_TPPrule_261 _currn)
#else
void _VS4rule_261(_currn )
_TPPrule_261 _currn;

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
void _VS5rule_261(_TPPrule_261 _currn)
#else
void _VS5rule_261(_currn )
_TPPrule_261 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_262(_TPPrule_262 _currn)
#else
void _VS1rule_262(_currn )
_TPPrule_262 _currn;

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
void _VS2rule_262(_TPPrule_262 _currn)
#else
void _VS2rule_262(_currn )
_TPPrule_262 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_262(_TPPrule_262 _currn)
#else
void _VS3rule_262(_currn )
_TPPrule_262 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_262(_TPPrule_262 _currn)
#else
void _VS4rule_262(_currn )
_TPPrule_262 _currn;

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
void _VS5rule_262(_TPPrule_262 _currn)
#else
void _VS5rule_262(_currn )
_TPPrule_262 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_263(_TPPrule_263 _currn)
#else
void _VS1rule_263(_currn )
_TPPrule_263 _currn;

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
void _VS2rule_263(_TPPrule_263 _currn)
#else
void _VS2rule_263(_currn )
_TPPrule_263 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_263(_TPPrule_263 _currn)
#else
void _VS3rule_263(_currn )
_TPPrule_263 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_263(_TPPrule_263 _currn)
#else
void _VS4rule_263(_currn )
_TPPrule_263 _currn;

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
void _VS5rule_263(_TPPrule_263 _currn)
#else
void _VS5rule_263(_currn )
_TPPrule_263 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_264(_TPPrule_264 _currn)
#else
void _VS1rule_264(_currn )
_TPPrule_264 _currn;

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
void _VS2rule_264(_TPPrule_264 _currn)
#else
void _VS2rule_264(_currn )
_TPPrule_264 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_264(_TPPrule_264 _currn)
#else
void _VS3rule_264(_currn )
_TPPrule_264 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_264(_TPPrule_264 _currn)
#else
void _VS4rule_264(_currn )
_TPPrule_264 _currn;

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
void _VS1rule_265(_TPPrule_265 _currn)
#else
void _VS1rule_265(_currn )
_TPPrule_265 _currn;

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
void _VS2rule_265(_TPPrule_265 _currn)
#else
void _VS2rule_265(_currn )
_TPPrule_265 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_265(_TPPrule_265 _currn)
#else
void _VS3rule_265(_currn )
_TPPrule_265 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_265(_TPPrule_265 _currn)
#else
void _VS4rule_265(_currn )
_TPPrule_265 _currn;

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
void _VS1rule_266(_TPPrule_266 _currn)
#else
void _VS1rule_266(_currn )
_TPPrule_266 _currn;

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
void _VS2rule_266(_TPPrule_266 _currn)
#else
void _VS2rule_266(_currn )
_TPPrule_266 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_266(_TPPrule_266 _currn)
#else
void _VS3rule_266(_currn )
_TPPrule_266 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
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
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_266(_TPPrule_266 _currn)
#else
void _VS4rule_266(_currn )
_TPPrule_266 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS1rule_267(_TPPrule_267 _currn)
#else
void _VS1rule_267(_currn )
_TPPrule_267 _currn;

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
void _VS2rule_267(_TPPrule_267 _currn)
#else
void _VS2rule_267(_currn )
_TPPrule_267 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_267(_TPPrule_267 _currn)
#else
void _VS3rule_267(_currn )
_TPPrule_267 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_267(_TPPrule_267 _currn)
#else
void _VS4rule_267(_currn )
_TPPrule_267 _currn;

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
void _VS1rule_268(_TPPrule_268 _currn)
#else
void _VS1rule_268(_currn )
_TPPrule_268 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATOrder_pre=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc5->_ATOrder_pre=_currn->_desc4->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_ATOrder_post=_currn->_desc5->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_268(_TPPrule_268 _currn)
#else
void _VS2rule_268(_currn )
_TPPrule_268 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_268(_TPPrule_268 _currn)
#else
void _VS3rule_268(_currn )
_TPPrule_268 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATIsArray_pre=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATLocalIndex_pre=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_AT_cBoundsListPtr_pre=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATTranslationType_pre=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc4->_ATDoAcc_pre=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc4->_ATRegionVars_pre=_currn->_desc3->_ATRegionVars_post;
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
_currn->_desc4->_ATDeclsOrder_pre=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc4->_ATGPUVarsDeList_pre=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATArrayId_pre=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATStmtNumber_pre=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATUpdate_pre=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc4->_ATAccDoLoopDim_pre=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc4->_ATNestLevel_pre=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc4->_ATMaxRank_pre=_currn->_desc3->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc4->_ATCPURegionNumber_pre=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATGPURegionNumber_pre=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATTypeLength_pre=_currn->_desc3->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc4->_AT_cVariableUseListPtr_pre=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc5->_ATIsArray_pre=_currn->_desc4->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_desc5->_ATLocalIndex_pre=_currn->_desc4->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_desc5->_AT_cBoundsListPtr_pre=_currn->_desc4->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_desc5->_ATTranslationType_pre=_currn->_desc4->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc5->_ATDoAcc_pre=_currn->_desc4->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc5->_ATRegionVars_pre=_currn->_desc4->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc5->_ATAcceleratorRegion_pre=_currn->_desc4->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc5->_ATLastNonExecLine_pre=_currn->_desc4->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc5->_ATIndentLevel_pre=_currn->_desc4->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc5->_ATDeclPowerVars_pre=_currn->_desc4->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc5->_ATArgCnt_pre=_currn->_desc4->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc5->_ATArraySym_pre=_currn->_desc4->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc5->_ATDeclsOrder_pre=_currn->_desc4->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc5->_ATGPUVarsDeList_pre=_currn->_desc4->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_desc5->_ATArrayId_pre=_currn->_desc4->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_desc5->_ATStmtNumber_pre=_currn->_desc4->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc5->_ATUpdate_pre=_currn->_desc4->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc5->_ATAccDoLoopDim_pre=_currn->_desc4->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc5->_ATNestLevel_pre=_currn->_desc4->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc5->_ATMaxRank_pre=_currn->_desc4->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc5->_ATCPURegionNumber_pre=_currn->_desc4->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc5->_ATGPURegionNumber_pre=_currn->_desc4->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc5->_ATTypeLength_pre=_currn->_desc4->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc5->_AT_cVariableUseListPtr_pre=_currn->_desc4->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_ATTranslationType_post=_currn->_desc5->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc5->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc5->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc5->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc5->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc5->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc5->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc5->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc5->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc5->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc5->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc5->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc5->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc5->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc5->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc5->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc5->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc5->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc5->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc5->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc5->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc5->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc5->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc5->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_268(_TPPrule_268 _currn)
#else
void _VS4rule_268(_currn )
_TPPrule_268 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATDepth_pre=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_desc5->_ATUpdateStmt_pre=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc5->_ATF90LoopStart_pre=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_desc5->_ATDepth_pre=_currn->_desc4->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_ATUpdateStmt_post=_currn->_desc5->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc5->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc5->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_269(_TPPrule_269 _currn)
#else
void _VS1rule_269(_currn )
_TPPrule_269 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATOrder_pre=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATOrder_post=_currn->_desc4->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_269(_TPPrule_269 _currn)
#else
void _VS2rule_269(_currn )
_TPPrule_269 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_269(_TPPrule_269 _currn)
#else
void _VS3rule_269(_currn )
_TPPrule_269 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATIsArray_pre=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATLocalIndex_pre=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_AT_cBoundsListPtr_pre=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATTranslationType_pre=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc4->_ATDoAcc_pre=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc4->_ATRegionVars_pre=_currn->_desc3->_ATRegionVars_post;
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
_currn->_desc4->_ATDeclsOrder_pre=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc4->_ATGPUVarsDeList_pre=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATArrayId_pre=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATStmtNumber_pre=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATUpdate_pre=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc4->_ATAccDoLoopDim_pre=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc4->_ATNestLevel_pre=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc4->_ATMaxRank_pre=_currn->_desc3->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc4->_ATCPURegionNumber_pre=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATGPURegionNumber_pre=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATTypeLength_pre=_currn->_desc3->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc4->_AT_cVariableUseListPtr_pre=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
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
_currn->_ATArraySym_post=_currn->_desc4->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc4->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc4->_ATIsArray_post;
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
_currn->_ATGPUVarsDeList_post=_currn->_desc4->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc4->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_269(_TPPrule_269 _currn)
#else
void _VS4rule_269(_currn )
_TPPrule_269 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATDepth_pre=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATUpdateStmt_post=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc4->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_270(_TPPrule_270 _currn)
#else
void _VS1rule_270(_currn )
_TPPrule_270 _currn;

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
_currn->_ATBind=BindIdn((* _IG_incl22), _currn->_ATSym);
/*SPC(183)*/
_currn->_ATKey=KeyOf(_currn->_ATBind);
/*SPC(185)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_270(_TPPrule_270 _currn)
#else
void _VS2rule_270(_currn )
_TPPrule_270 _currn;

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
_currn->_ATObjectKey=
((_currn->_ATKey
) ? (_currn->_ATKey
) : (_currn->_ATUnitKey))
;
/*SPC(2892)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_271(_TPPrule_271 _currn)
#else
void _VS1rule_271(_currn )
_TPPrule_271 _currn;

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
void _VS2rule_271(_TPPrule_271 _currn)
#else
void _VS2rule_271(_currn )
_TPPrule_271 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_271(_TPPrule_271 _currn)
#else
void _VS3rule_271(_currn )
_TPPrule_271 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_271(_TPPrule_271 _currn)
#else
void _VS4rule_271(_currn )
_TPPrule_271 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_271(_TPPrule_271 _currn)
#else
void _VS5rule_271(_currn )
_TPPrule_271 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_272(_TPPrule_272 _currn)
#else
void _VS1rule_272(_currn )
_TPPrule_272 _currn;

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
void _VS2rule_272(_TPPrule_272 _currn)
#else
void _VS2rule_272(_currn )
_TPPrule_272 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_272(_TPPrule_272 _currn)
#else
void _VS3rule_272(_currn )
_TPPrule_272 _currn;

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
void _VS4rule_272(_TPPrule_272 _currn)
#else
void _VS4rule_272(_currn )
_TPPrule_272 _currn;

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
void _VS5rule_272(_TPPrule_272 _currn)
#else
void _VS5rule_272(_currn )
_TPPrule_272 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_273(_TPPrule_273 _currn)
#else
void _VS1rule_273(_currn )
_TPPrule_273 _currn;

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
void _VS2rule_273(_TPPrule_273 _currn)
#else
void _VS2rule_273(_currn )
_TPPrule_273 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_273(_TPPrule_273 _currn)
#else
void _VS3rule_273(_currn )
_TPPrule_273 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_273(_TPPrule_273 _currn)
#else
void _VS4rule_273(_currn )
_TPPrule_273 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const38=_currn->_desc2->_AT_const38;
/*SPC(9928)*/
_currn->_AT_const45=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(9928)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_273(_TPPrule_273 _currn)
#else
void _VS5rule_273(_currn )
_TPPrule_273 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_AT_const41=_currn->_desc2->_AT_const41;
/*SPC(9928)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc2->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc2->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc2->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc2->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc2->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_273(_TPPrule_273 _currn)
#else
void _VS6rule_273(_currn )
_TPPrule_273 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATSingleLineIf=FALSE;
/*SPC(7144)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc2->_ATThreadStmt_pre=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc2->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc2->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ADD(ADD(_currn->_desc1->_AT_const39, IDENTICAL(_currn->_desc1->_ATReturnStmt)), _currn->_desc2->_AT_const39);
/*SPC(9928)*/
_currn->_AT_const40=_currn->_desc2->_AT_const40;
/*SPC(9928)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc2->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc2->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc2->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc2->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc2->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_273(_TPPrule_273 _currn)
#else
void _VS7rule_273(_currn )
_TPPrule_273 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_277(_TPPrule_277 _currn)
#else
void _VS1rule_277(_currn )
_TPPrule_277 _currn;

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
void _VS1rule_278(_TPPrule_278 _currn)
#else
void _VS1rule_278(_currn )
_TPPrule_278 _currn;

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
void _VS1rule_279(_TPPrule_279 _currn)
#else
void _VS1rule_279(_currn )
_TPPrule_279 _currn;

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
void _VS1rule_280(_TPPrule_280 _currn)
#else
void _VS1rule_280(_currn )
_TPPrule_280 _currn;

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
void _VS1rule_281(_TPPrule_281 _currn)
#else
void _VS1rule_281(_currn )
_TPPrule_281 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS1rule_282(_TPPrule_282 _currn)
#else
void _VS1rule_282(_currn )
_TPPrule_282 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS1rule_283(_TPPrule_283 _currn)
#else
void _VS1rule_283(_currn )
_TPPrule_283 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS1rule_284(_TPPrule_284 _currn)
#else
void _VS1rule_284(_currn )
_TPPrule_284 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_284(_TPPrule_284 _currn)
#else
void _VS3rule_284(_currn )
_TPPrule_284 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
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
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_284(_TPPrule_284 _currn)
#else
void _VS4rule_284(_currn )
_TPPrule_284 _currn;

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
void _VS1rule_285(_TPPrule_285 _currn)
#else
void _VS1rule_285(_currn )
_TPPrule_285 _currn;

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
void _VS2rule_285(_TPPrule_285 _currn)
#else
void _VS2rule_285(_currn )
_TPPrule_285 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_285(_TPPrule_285 _currn)
#else
void _VS3rule_285(_currn )
_TPPrule_285 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_285(_TPPrule_285 _currn)
#else
void _VS4rule_285(_currn )
_TPPrule_285 _currn;

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

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_286(_TPPrule_286 _currn)
#else
void _VS1rule_286(_currn )
_TPPrule_286 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_286(_TPPrule_286 _currn)
#else
void _VS3rule_286(_currn )
_TPPrule_286 _currn;

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
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
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
void _VS4rule_286(_TPPrule_286 _currn)
#else
void _VS4rule_286(_currn )
_TPPrule_286 _currn;

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
void _VS1rule_287(_TPPrule_287 _currn)
#else
void _VS1rule_287(_currn )
_TPPrule_287 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_287(_TPPrule_287 _currn)
#else
void _VS2rule_287(_currn )
_TPPrule_287 _currn;

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
void _VS3rule_287(_TPPrule_287 _currn)
#else
void _VS3rule_287(_currn )
_TPPrule_287 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_287(_TPPrule_287 _currn)
#else
void _VS4rule_287(_currn )
_TPPrule_287 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
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
_currn->_desc1->_ATNumArgs=0;
/*SPC(7011)*/
_currn->_desc1->_ATignoreVar=FALSE;
/*SPC(5129)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
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
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATDeclsOrder_post=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_287(_TPPrule_287 _currn)
#else
void _VS5rule_287(_currn )
_TPPrule_287 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_288(_TPPrule_288 _currn)
#else
void _VS1rule_288(_currn )
_TPPrule_288 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATOrder_pre=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATOrder_post=_currn->_desc4->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_288(_TPPrule_288 _currn)
#else
void _VS2rule_288(_currn )
_TPPrule_288 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_288(_TPPrule_288 _currn)
#else
void _VS3rule_288(_currn )
_TPPrule_288 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATIsArray_pre=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATIsArray_post=_currn->_desc4->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_288(_TPPrule_288 _currn)
#else
void _VS4rule_288(_currn )
_TPPrule_288 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc1->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
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
_currn->_desc1->_ATNumArgs=0;
/*SPC(7011)*/
_currn->_desc1->_ATignoreVar=FALSE;
/*SPC(5129)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
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
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATLocalIndex_pre=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_AT_cBoundsListPtr_pre=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATTranslationType_pre=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc4->_ATDoAcc_pre=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc4->_ATRegionVars_pre=_currn->_desc3->_ATRegionVars_post;
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
_currn->_desc4->_ATDeclsOrder_pre=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc4->_ATGPUVarsDeList_pre=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATArrayId_pre=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATStmtNumber_pre=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATUpdate_pre=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc4->_ATAccDoLoopDim_pre=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc4->_ATNestLevel_pre=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc4->_ATMaxRank_pre=_currn->_desc3->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc4->_ATCPURegionNumber_pre=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATGPURegionNumber_pre=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATTypeLength_pre=_currn->_desc3->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc4->_AT_cVariableUseListPtr_pre=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
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
_currn->_ATArraySym_post=_currn->_desc4->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc4->_ATArrayId_post;
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
_currn->_ATGPUVarsDeList_post=_currn->_desc4->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc4->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_288(_TPPrule_288 _currn)
#else
void _VS5rule_288(_currn )
_TPPrule_288 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATDepth_pre=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATUpdateStmt_post=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc4->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_289(_TPPrule_289 _currn)
#else
void _VS1rule_289(_currn )
_TPPrule_289 _currn;

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
void _VS2rule_289(_TPPrule_289 _currn)
#else
void _VS2rule_289(_currn )
_TPPrule_289 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_289(_TPPrule_289 _currn)
#else
void _VS3rule_289(_currn )
_TPPrule_289 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_289(_TPPrule_289 _currn)
#else
void _VS4rule_289(_currn )
_TPPrule_289 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_289(_TPPrule_289 _currn)
#else
void _VS5rule_289(_currn )
_TPPrule_289 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_290(_TPPrule_290 _currn)
#else
void _VS1rule_290(_currn )
_TPPrule_290 _currn;

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
void _VS2rule_290(_TPPrule_290 _currn)
#else
void _VS2rule_290(_currn )
_TPPrule_290 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_290(_TPPrule_290 _currn)
#else
void _VS3rule_290(_currn )
_TPPrule_290 _currn;

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
void _VS4rule_290(_TPPrule_290 _currn)
#else
void _VS4rule_290(_currn )
_TPPrule_290 _currn;

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
void _VS5rule_290(_TPPrule_290 _currn)
#else
void _VS5rule_290(_currn )
_TPPrule_290 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_291(_TPPrule_291 _currn)
#else
void _VS1rule_291(_currn )
_TPPrule_291 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_291(_TPPrule_291 _currn)
#else
void _VS2rule_291(_currn )
_TPPrule_291 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_291(_TPPrule_291 _currn)
#else
void _VS3rule_291(_currn )
_TPPrule_291 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_291(_TPPrule_291 _currn)
#else
void _VS4rule_291(_currn )
_TPPrule_291 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const38=_currn->_desc2->_AT_const38;
/*SPC(9874)*/
_currn->_AT_const45=MAX(MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45), _currn->_desc3->_AT_const45);
/*SPC(9874)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_291(_TPPrule_291 _currn)
#else
void _VS5rule_291(_currn )
_TPPrule_291 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc2->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc2->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc2->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
_currn->_desc2->_AT_cProgDeclsListPtr_pre=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const41=_currn->_desc2->_AT_const41;
/*SPC(9874)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc2->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc2->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc2->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc2->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc2->_ATAccDoStmt_post;
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
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc3->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_291(_TPPrule_291 _currn)
#else
void _VS6rule_291(_currn )
_TPPrule_291 _currn;

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
_currn->_desc2->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc2->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc2->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc2->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const39=_currn->_desc2->_AT_const39;
/*SPC(9874)*/
_currn->_AT_const40=_currn->_desc2->_AT_const40;
/*SPC(9874)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc2->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc2->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc2->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc2->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc2->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_291(_TPPrule_291 _currn)
#else
void _VS7rule_291(_currn )
_TPPrule_291 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_292(_TPPrule_292 _currn)
#else
void _VS1rule_292(_currn )
_TPPrule_292 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_292(_TPPrule_292 _currn)
#else
void _VS2rule_292(_currn )
_TPPrule_292 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_292(_TPPrule_292 _currn)
#else
void _VS4rule_292(_currn )
_TPPrule_292 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const38=ZERO();
/*SPC(9871)*/
_currn->_AT_const45=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(9871)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_292(_TPPrule_292 _currn)
#else
void _VS5rule_292(_currn )
_TPPrule_292 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const41=ZERO();
/*SPC(9871)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
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
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_292(_TPPrule_292 _currn)
#else
void _VS6rule_292(_currn )
_TPPrule_292 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(9871)*/
_currn->_AT_const40=PTGNull();
/*SPC(9871)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_293(_TPPrule_293 _currn)
#else
void _VS1rule_293(_currn )
_TPPrule_293 _currn;

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
void _VS2rule_293(_TPPrule_293 _currn)
#else
void _VS2rule_293(_currn )
_TPPrule_293 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_293(_TPPrule_293 _currn)
#else
void _VS3rule_293(_currn )
_TPPrule_293 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_293(_TPPrule_293 _currn)
#else
void _VS4rule_293(_currn )
_TPPrule_293 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(9868)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9868)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_293(_TPPrule_293 _currn)
#else
void _VS5rule_293(_currn )
_TPPrule_293 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(9868)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_293(_TPPrule_293 _currn)
#else
void _VS6rule_293(_currn )
_TPPrule_293 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(9868)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(9868)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_293(_TPPrule_293 _currn)
#else
void _VS7rule_293(_currn )
_TPPrule_293 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_294(_TPPrule_294 _currn)
#else
void _VS1rule_294(_currn )
_TPPrule_294 _currn;

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
void _VS2rule_294(_TPPrule_294 _currn)
#else
void _VS2rule_294(_currn )
_TPPrule_294 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_294(_TPPrule_294 _currn)
#else
void _VS3rule_294(_currn )
_TPPrule_294 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_294(_TPPrule_294 _currn)
#else
void _VS4rule_294(_currn )
_TPPrule_294 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=ZERO();
/*SPC(9865)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9865)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_294(_TPPrule_294 _currn)
#else
void _VS5rule_294(_currn )
_TPPrule_294 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=ZERO();
/*SPC(9865)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_294(_TPPrule_294 _currn)
#else
void _VS6rule_294(_currn )
_TPPrule_294 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(9865)*/
_currn->_AT_const40=PTGNull();
/*SPC(9865)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_294(_TPPrule_294 _currn)
#else
void _VS7rule_294(_currn )
_TPPrule_294 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_295(_TPPrule_295 _currn)
#else
void _VS1rule_295(_currn )
_TPPrule_295 _currn;

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
void _VS2rule_295(_TPPrule_295 _currn)
#else
void _VS2rule_295(_currn )
_TPPrule_295 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_295(_TPPrule_295 _currn)
#else
void _VS3rule_295(_currn )
_TPPrule_295 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_295(_TPPrule_295 _currn)
#else
void _VS4rule_295(_currn )
_TPPrule_295 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(9862)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9862)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_295(_TPPrule_295 _currn)
#else
void _VS5rule_295(_currn )
_TPPrule_295 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(9862)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_295(_TPPrule_295 _currn)
#else
void _VS6rule_295(_currn )
_TPPrule_295 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(9862)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(9862)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_295(_TPPrule_295 _currn)
#else
void _VS7rule_295(_currn )
_TPPrule_295 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_296(_TPPrule_296 _currn)
#else
void _VS1rule_296(_currn )
_TPPrule_296 _currn;

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
void _VS2rule_296(_TPPrule_296 _currn)
#else
void _VS2rule_296(_currn )
_TPPrule_296 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_296(_TPPrule_296 _currn)
#else
void _VS3rule_296(_currn )
_TPPrule_296 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_296(_TPPrule_296 _currn)
#else
void _VS4rule_296(_currn )
_TPPrule_296 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=ZERO();
/*SPC(9859)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9859)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_296(_TPPrule_296 _currn)
#else
void _VS5rule_296(_currn )
_TPPrule_296 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=ZERO();
/*SPC(9859)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_296(_TPPrule_296 _currn)
#else
void _VS6rule_296(_currn )
_TPPrule_296 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATSingleLineIf=FALSE;
/*SPC(7144)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=ADD(_currn->_desc1->_AT_const39, IDENTICAL(_currn->_desc1->_ATReturnStmt));
/*SPC(9859)*/
_currn->_AT_const40=PTGNull();
/*SPC(9859)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_296(_TPPrule_296 _currn)
#else
void _VS7rule_296(_currn )
_TPPrule_296 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_297(_TPPrule_297 _currn)
#else
void _VS1rule_297(_currn )
_TPPrule_297 _currn;

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
void _VS2rule_297(_TPPrule_297 _currn)
#else
void _VS2rule_297(_currn )
_TPPrule_297 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_297(_TPPrule_297 _currn)
#else
void _VS3rule_297(_currn )
_TPPrule_297 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_297(_TPPrule_297 _currn)
#else
void _VS4rule_297(_currn )
_TPPrule_297 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(9856)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9856)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_297(_TPPrule_297 _currn)
#else
void _VS5rule_297(_currn )
_TPPrule_297 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(9856)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_297(_TPPrule_297 _currn)
#else
void _VS6rule_297(_currn )
_TPPrule_297 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(9856)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(9856)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_297(_TPPrule_297 _currn)
#else
void _VS7rule_297(_currn )
_TPPrule_297 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_298(_TPPrule_298 _currn)
#else
void _VS1rule_298(_currn )
_TPPrule_298 _currn;

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
void _VS2rule_298(_TPPrule_298 _currn)
#else
void _VS2rule_298(_currn )
_TPPrule_298 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_298(_TPPrule_298 _currn)
#else
void _VS3rule_298(_currn )
_TPPrule_298 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_298(_TPPrule_298 _currn)
#else
void _VS4rule_298(_currn )
_TPPrule_298 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const38=ADD(_currn->_desc1->_AT_const38, _currn->_desc2->_AT_const38);
/*SPC(9853)*/
_currn->_AT_const45=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(9853)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_298(_TPPrule_298 _currn)
#else
void _VS5rule_298(_currn )
_TPPrule_298 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_AT_const41=ADD(_currn->_desc1->_AT_const41, _currn->_desc2->_AT_const41);
/*SPC(9853)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc2->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc2->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc2->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc2->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc2->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_298(_TPPrule_298 _currn)
#else
void _VS6rule_298(_currn )
_TPPrule_298 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATErrorVarDeclared_pre=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadStmt_pre=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATThreadRegion_pre=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATProgramLineNum_pre=_currn->_desc1->_ATProgramLineNum_post;
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
_currn->_AT_const39=ADD(_currn->_desc1->_AT_const39, _currn->_desc2->_AT_const39);
/*SPC(9853)*/
_currn->_AT_const40=PTGSequence(_currn->_desc1->_AT_const40, _currn->_desc2->_AT_const40);
/*SPC(9853)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc2->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc2->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc2->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc2->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc2->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_298(_TPPrule_298 _currn)
#else
void _VS7rule_298(_currn )
_TPPrule_298 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_299(_TPPrule_299 _currn)
#else
void _VS1rule_299(_currn )
_TPPrule_299 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_300(_TPPrule_300 _currn)
#else
void _VS1rule_300(_currn )
_TPPrule_300 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_301(_TPPrule_301 _currn)
#else
void _VS1rule_301(_currn )
_TPPrule_301 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_302(_TPPrule_302 _currn)
#else
void _VS1rule_302(_currn )
_TPPrule_302 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_303(_TPPrule_303 _currn)
#else
void _VS1rule_303(_currn )
_TPPrule_303 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9837)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_303(_TPPrule_303 _currn)
#else
void _VS2rule_303(_currn )
_TPPrule_303 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_303(_TPPrule_303 _currn)
#else
void _VS4rule_303(_currn )
_TPPrule_303 _currn;

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
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9835)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_303(_TPPrule_303 _currn)
#else
void _VS5rule_303(_currn )
_TPPrule_303 _currn;

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
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(11193)*/
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_303(_TPPrule_303 _currn)
#else
void _VS6rule_303(_currn )
_TPPrule_303 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(_currn->_ATStmtNumber_pre, _currn->_ATThreadStmt_pre), NE(_currn->_ATStmtNumber_pre, FALSE))))) {
PTGOut(PTGThreadEnd(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

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
_currn->_AT_const39=ZERO();
/*SPC(9835)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
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
void _VS7rule_303(_TPPrule_303 _currn)
#else
void _VS7rule_303(_currn )
_TPPrule_303 _currn;

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
void _VS1rule_304(_TPPrule_304 _currn)
#else
void _VS1rule_304(_currn )
_TPPrule_304 _currn;

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

if (InIS(DummyArgument, GetKindSet(_currn->_desc2->_ATUnitKey, NullIS()))) {
InsertKindSet(_currn->_desc2->_ATUnitKey, DummyProcedure);

} else {
InsertKindSet(_currn->_desc2->_ATUnitKey, InExternalStmt);
}
;
/*SPC(3604)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_304(_TPPrule_304 _currn)
#else
void _VS2rule_304(_currn )
_TPPrule_304 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_304(_TPPrule_304 _currn)
#else
void _VS3rule_304(_currn )
_TPPrule_304 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
void _VS1rule_305(_TPPrule_305 _currn)
#else
void _VS1rule_305(_currn )
_TPPrule_305 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

if (InIS(DummyArgument, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS()))) {
InsertKindSet(_currn->_desc1->_ATUnitKey, DummyProcedure);

} else {
InsertKindSet(_currn->_desc1->_ATUnitKey, InExternalStmt);
}
;
/*SPC(3604)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_305(_TPPrule_305 _currn)
#else
void _VS2rule_305(_currn )
_TPPrule_305 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_305(_TPPrule_305 _currn)
#else
void _VS3rule_305(_currn )
_TPPrule_305 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS1rule_306(_TPPrule_306 _currn)
#else
void _VS1rule_306(_currn )
_TPPrule_306 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_ATUnitBind=BindIdn((* _IG_incl23), _currn->_ATSym);
/*SPC(47)*/
_currn->_ATUnitKey=KeyOf(_currn->_ATUnitBind);
/*SPC(49)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_306(_TPPrule_306 _currn)
#else
void _VS2rule_306(_currn )
_TPPrule_306 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
GuaranteeType(_currn->_ATUnitKey, DefaultType(_currn->_ATSym));
/*SPC(1610)*/
_currn->_ATBind=BindIdn((* _IG_incl22), _currn->_ATSym);
/*SPC(183)*/
_currn->_ATKey=KeyOf(_currn->_ATBind);
/*SPC(185)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_306(_TPPrule_306 _currn)
#else
void _VS3rule_306(_currn )
_TPPrule_306 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATObjectKey=
((_currn->_ATKey
) ? (_currn->_ATKey
) : (_currn->_ATUnitKey))
;
/*SPC(2892)*/
_currn->_ATCoord=(&( _currn->_AT_pos));
/*SPC(2988)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(StatementFunction, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;
/*SPC(2802)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_307(_TPPrule_307 _currn)
#else
void _VS1rule_307(_currn )
_TPPrule_307 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_307(_TPPrule_307 _currn)
#else
void _VS2rule_307(_currn )
_TPPrule_307 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_307(_TPPrule_307 _currn)
#else
void _VS3rule_307(_currn )
_TPPrule_307 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_307(_TPPrule_307 _currn)
#else
void _VS4rule_307(_currn )
_TPPrule_307 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_307(_TPPrule_307 _currn)
#else
void _VS5rule_307(_currn )
_TPPrule_307 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATLocalIndex_post=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_307(_TPPrule_307 _currn)
#else
void _VS6rule_307(_currn )
_TPPrule_307 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
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
void _VS7rule_307(_TPPrule_307 _currn)
#else
void _VS7rule_307(_currn )
_TPPrule_307 _currn;

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
_currn->_desc3->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_307(_TPPrule_307 _currn)
#else
void _VS8rule_307(_currn )
_TPPrule_307 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const33=ADD(_currn->_desc1->_AT_const33, _currn->_desc3->_AT_const33);
/*SPC(9823)*/
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
_currn->_ATArrayId_post=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xExpr not supported.");
/*SPC(8958)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_307(_TPPrule_307 _currn)
#else
void _VS9rule_307(_currn )
_TPPrule_307 _currn;

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
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const18=ADD(_currn->_desc1->_AT_const18, _currn->_desc3->_AT_const18);
/*SPC(9823)*/
_currn->_AT_const32=ADD(_currn->_desc1->_AT_const32, _currn->_desc3->_AT_const32);
/*SPC(9823)*/
_currn->_ATStmtNumber_post=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
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

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_307(_TPPrule_307 _currn)
#else
void _VS10rule_307(_currn )
_TPPrule_307 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATArgType=PTGNULL;
/*SPC(5880)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_307(_TPPrule_307 _currn)
#else
void _VS11rule_307(_currn )
_TPPrule_307 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS12rule_307(_TPPrule_307 _currn)
#else
void _VS12rule_307(_currn )
_TPPrule_307 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const34=ADD(_currn->_desc1->_AT_const34, _currn->_desc3->_AT_const34);
/*SPC(9823)*/
_currn->_AT_const50=ADD(ADD(_currn->_desc1->_AT_const50, IDENTICAL(_currn->_desc1->_ATConstantUsed)), ADD(_currn->_desc3->_AT_const50, IDENTICAL(_currn->_desc3->_ATConstantUsed)));
/*SPC(9823)*/
_currn->_AT_const63=ADD(_currn->_desc1->_AT_const63, _currn->_desc3->_AT_const63);
/*SPC(9823)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc3->_AT_const64);
/*SPC(9823)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc3->_AT_const65);
/*SPC(9823)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc3->_AT_const66);
/*SPC(9823)*/
_currn->_ATDepth_post=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_308(_TPPrule_308 _currn)
#else
void _VS1rule_308(_currn )
_TPPrule_308 _currn;

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
void _VS2rule_308(_TPPrule_308 _currn)
#else
void _VS2rule_308(_currn )
_TPPrule_308 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_308(_TPPrule_308 _currn)
#else
void _VS3rule_308(_currn )
_TPPrule_308 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_308(_TPPrule_308 _currn)
#else
void _VS4rule_308(_currn )
_TPPrule_308 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=ZERO();
/*SPC(9820)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9820)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_308(_TPPrule_308 _currn)
#else
void _VS5rule_308(_currn )
_TPPrule_308 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=ZERO();
/*SPC(9820)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_308(_TPPrule_308 _currn)
#else
void _VS6rule_308(_currn )
_TPPrule_308 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(9820)*/
_currn->_AT_const40=PTGNull();
/*SPC(9820)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_308(_TPPrule_308 _currn)
#else
void _VS7rule_308(_currn )
_TPPrule_308 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_309(_TPPrule_309 _currn)
#else
void _VS1rule_309(_currn )
_TPPrule_309 _currn;

#endif
{
Environment* _IL_incl22;
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_ATEnv=RootEnv;
/*SPC(148)*/
_currn->_ATUnitEnv=UnitRootEnv;
/*SPC(12)*/
_currn->_desc1->_ATEnv=NewScope(_currn->_ATEnv);
/*SPC(162)*/
_currn->_desc1->_ATUnitEnv=NewScope(_currn->_ATUnitEnv);
/*SPC(26)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_309(_TPPrule_309 _currn)
#else
void _VS2rule_309(_currn )
_TPPrule_309 _currn;

#endif
{
Environment* _IL_incl22;
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_310(_TPPrule_310 _currn)
#else
void _VS1rule_310(_currn )
_TPPrule_310 _currn;

#endif
{
Environment* _IL_incl22;
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATEnv=RootEnv;
/*SPC(148)*/
_currn->_ATUnitEnv=UnitRootEnv;
/*SPC(12)*/
_currn->_desc2->_ATEnv=NewScope(_currn->_ATEnv);
/*SPC(162)*/
_currn->_desc2->_ATUnitEnv=NewScope(_currn->_ATUnitEnv);
/*SPC(26)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_310(_TPPrule_310 _currn)
#else
void _VS2rule_310(_currn )
_TPPrule_310 _currn;

#endif
{
Environment* _IL_incl22;
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATProgramLineNum_pre=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATProgramLineNum_post=_currn->_desc2->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_IG_incl22=_IL_incl22;
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_311(_TPPrule_311 _currn)
#else
void _VS1rule_311(_currn )
_TPPrule_311 _currn;

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
void _VS2rule_311(_TPPrule_311 _currn)
#else
void _VS2rule_311(_currn )
_TPPrule_311 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_311(_TPPrule_311 _currn)
#else
void _VS3rule_311(_currn )
_TPPrule_311 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_311(_TPPrule_311 _currn)
#else
void _VS4rule_311(_currn )
_TPPrule_311 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(9811)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9811)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_311(_TPPrule_311 _currn)
#else
void _VS5rule_311(_currn )
_TPPrule_311 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(9811)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_311(_TPPrule_311 _currn)
#else
void _VS6rule_311(_currn )
_TPPrule_311 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(9811)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(9811)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_311(_TPPrule_311 _currn)
#else
void _VS7rule_311(_currn )
_TPPrule_311 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_312(_TPPrule_312 _currn)
#else
void _VS1rule_312(_currn )
_TPPrule_312 _currn;

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
void _VS2rule_312(_TPPrule_312 _currn)
#else
void _VS2rule_312(_currn )
_TPPrule_312 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_312(_TPPrule_312 _currn)
#else
void _VS3rule_312(_currn )
_TPPrule_312 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_312(_TPPrule_312 _currn)
#else
void _VS4rule_312(_currn )
_TPPrule_312 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(9808)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9808)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_312(_TPPrule_312 _currn)
#else
void _VS5rule_312(_currn )
_TPPrule_312 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(9808)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_312(_TPPrule_312 _currn)
#else
void _VS6rule_312(_currn )
_TPPrule_312 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(9808)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(9808)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_312(_TPPrule_312 _currn)
#else
void _VS7rule_312(_currn )
_TPPrule_312 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_313(_TPPrule_313 _currn)
#else
void _VS1rule_313(_currn )
_TPPrule_313 _currn;

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
void _VS2rule_313(_TPPrule_313 _currn)
#else
void _VS2rule_313(_currn )
_TPPrule_313 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_313(_TPPrule_313 _currn)
#else
void _VS3rule_313(_currn )
_TPPrule_313 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_313(_TPPrule_313 _currn)
#else
void _VS4rule_313(_currn )
_TPPrule_313 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(9805)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9805)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_313(_TPPrule_313 _currn)
#else
void _VS5rule_313(_currn )
_TPPrule_313 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(9805)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_313(_TPPrule_313 _currn)
#else
void _VS6rule_313(_currn )
_TPPrule_313 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(9805)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(9805)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_313(_TPPrule_313 _currn)
#else
void _VS7rule_313(_currn )
_TPPrule_313 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_314(_TPPrule_314 _currn)
#else
void _VS1rule_314(_currn )
_TPPrule_314 _currn;

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
void _VS2rule_314(_TPPrule_314 _currn)
#else
void _VS2rule_314(_currn )
_TPPrule_314 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_314(_TPPrule_314 _currn)
#else
void _VS3rule_314(_currn )
_TPPrule_314 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_314(_TPPrule_314 _currn)
#else
void _VS4rule_314(_currn )
_TPPrule_314 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(9802)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9802)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_314(_TPPrule_314 _currn)
#else
void _VS5rule_314(_currn )
_TPPrule_314 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(9802)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_314(_TPPrule_314 _currn)
#else
void _VS6rule_314(_currn )
_TPPrule_314 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(9802)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(9802)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_314(_TPPrule_314 _currn)
#else
void _VS7rule_314(_currn )
_TPPrule_314 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_315(_TPPrule_315 _currn)
#else
void _VS1rule_315(_currn )
_TPPrule_315 _currn;

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
void _VS2rule_315(_TPPrule_315 _currn)
#else
void _VS2rule_315(_currn )
_TPPrule_315 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_315(_TPPrule_315 _currn)
#else
void _VS3rule_315(_currn )
_TPPrule_315 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_315(_TPPrule_315 _currn)
#else
void _VS4rule_315(_currn )
_TPPrule_315 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(9799)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9799)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_315(_TPPrule_315 _currn)
#else
void _VS5rule_315(_currn )
_TPPrule_315 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(9799)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_315(_TPPrule_315 _currn)
#else
void _VS6rule_315(_currn )
_TPPrule_315 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATProgramLineNum_pre=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(9799)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(9799)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_desc1->_ATProgramLineNum_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_315(_TPPrule_315 _currn)
#else
void _VS7rule_315(_currn )
_TPPrule_315 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_316(_TPPrule_316 _currn)
#else
void _VS1rule_316(_currn )
_TPPrule_316 _currn;

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
void _VS2rule_316(_TPPrule_316 _currn)
#else
void _VS2rule_316(_currn )
_TPPrule_316 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_316(_TPPrule_316 _currn)
#else
void _VS3rule_316(_currn )
_TPPrule_316 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_316(_TPPrule_316 _currn)
#else
void _VS4rule_316(_currn )
_TPPrule_316 _currn;

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
void _VS1rule_317(_TPPrule_317 _currn)
#else
void _VS1rule_317(_currn )
_TPPrule_317 _currn;

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
void _VS2rule_317(_TPPrule_317 _currn)
#else
void _VS2rule_317(_currn )
_TPPrule_317 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_317(_TPPrule_317 _currn)
#else
void _VS3rule_317(_currn )
_TPPrule_317 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_317(_TPPrule_317 _currn)
#else
void _VS4rule_317(_currn )
_TPPrule_317 _currn;

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
void _VS1rule_318(_TPPrule_318 _currn)
#else
void _VS1rule_318(_currn )
_TPPrule_318 _currn;

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
void _VS2rule_318(_TPPrule_318 _currn)
#else
void _VS2rule_318(_currn )
_TPPrule_318 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_318(_TPPrule_318 _currn)
#else
void _VS3rule_318(_currn )
_TPPrule_318 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_318(_TPPrule_318 _currn)
#else
void _VS4rule_318(_currn )
_TPPrule_318 _currn;

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
void _VS1rule_319(_TPPrule_319 _currn)
#else
void _VS1rule_319(_currn )
_TPPrule_319 _currn;

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
void _VS2rule_319(_TPPrule_319 _currn)
#else
void _VS2rule_319(_currn )
_TPPrule_319 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_319(_TPPrule_319 _currn)
#else
void _VS3rule_319(_currn )
_TPPrule_319 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_319(_TPPrule_319 _currn)
#else
void _VS4rule_319(_currn )
_TPPrule_319 _currn;

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
void _VS1rule_320(_TPPrule_320 _currn)
#else
void _VS1rule_320(_currn )
_TPPrule_320 _currn;

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
void _VS2rule_320(_TPPrule_320 _currn)
#else
void _VS2rule_320(_currn )
_TPPrule_320 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_320(_TPPrule_320 _currn)
#else
void _VS3rule_320(_currn )
_TPPrule_320 _currn;

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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_320(_TPPrule_320 _currn)
#else
void _VS4rule_320(_currn )
_TPPrule_320 _currn;

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
void _VS1rule_321(_TPPrule_321 _currn)
#else
void _VS1rule_321(_currn )
_TPPrule_321 _currn;

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
void _VS2rule_321(_TPPrule_321 _currn)
#else
void _VS2rule_321(_currn )
_TPPrule_321 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_321(_TPPrule_321 _currn)
#else
void _VS3rule_321(_currn )
_TPPrule_321 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
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
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
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
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_321(_TPPrule_321 _currn)
#else
void _VS4rule_321(_currn )
_TPPrule_321 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS1rule_322(_TPPrule_322 _currn)
#else
void _VS1rule_322(_currn )
_TPPrule_322 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9777)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
InsertKindSet(_currn->_desc2->_ATUnitKey, (* _IG_incl31));
/*SPC(3008)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_322(_TPPrule_322 _currn)
#else
void _VS2rule_322(_currn )
_TPPrule_322 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_322(_TPPrule_322 _currn)
#else
void _VS4rule_322(_currn )
_TPPrule_322 _currn;

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
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9775)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_322(_TPPrule_322 _currn)
#else
void _VS5rule_322(_currn )
_TPPrule_322 _currn;

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
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(11193)*/
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_322(_TPPrule_322 _currn)
#else
void _VS6rule_322(_currn )
_TPPrule_322 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(_currn->_ATStmtNumber_pre, _currn->_ATThreadStmt_pre), NE(_currn->_ATStmtNumber_pre, FALSE))))) {
PTGOut(PTGThreadEnd(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

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
_currn->_AT_const39=ZERO();
/*SPC(9775)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
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
void _VS7rule_322(_TPPrule_322 _currn)
#else
void _VS7rule_322(_currn )
_TPPrule_322 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_323(_TPPrule_323 _currn)
#else
void _VS1rule_323(_currn )
_TPPrule_323 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9771)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
InsertKindSet(_currn->_desc2->_ATUnitKey, (* _IG_incl31));
/*SPC(3008)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_323(_TPPrule_323 _currn)
#else
void _VS2rule_323(_currn )
_TPPrule_323 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_323(_TPPrule_323 _currn)
#else
void _VS4rule_323(_currn )
_TPPrule_323 _currn;

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
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9769)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_323(_TPPrule_323 _currn)
#else
void _VS5rule_323(_currn )
_TPPrule_323 _currn;

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
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(11193)*/
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc3->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc3->_ATDoAcc_post, ACCDO, _currn->_desc3->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc3->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc3->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_323(_TPPrule_323 _currn)
#else
void _VS6rule_323(_currn )
_TPPrule_323 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(_currn->_ATStmtNumber_pre, _currn->_ATThreadStmt_pre), NE(_currn->_ATStmtNumber_pre, FALSE))))) {
PTGOut(PTGThreadEnd(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const39=ZERO();
/*SPC(9769)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
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
void _VS7rule_323(_TPPrule_323 _currn)
#else
void _VS7rule_323(_currn )
_TPPrule_323 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_324(_TPPrule_324 _currn)
#else
void _VS1rule_324(_currn )
_TPPrule_324 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9765)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
InsertKindSet(_currn->_desc2->_ATUnitKey, (* _IG_incl31));
/*SPC(3008)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_324(_TPPrule_324 _currn)
#else
void _VS2rule_324(_currn )
_TPPrule_324 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_324(_TPPrule_324 _currn)
#else
void _VS3rule_324(_currn )
_TPPrule_324 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_324(_TPPrule_324 _currn)
#else
void _VS4rule_324(_currn )
_TPPrule_324 _currn;

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
_currn->_desc4->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9763)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_324(_TPPrule_324 _currn)
#else
void _VS5rule_324(_currn )
_TPPrule_324 _currn;

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
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_AT_cBoundsListPtr_pre=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATTranslationType_pre=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc4->_ATDoAcc_pre=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc4->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc4->_ATAcceleratorRegion_pre=_currn->_desc3->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc4->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc4->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc4->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc4->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc4->_ATGPUVarsDeList_pre=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATStmtNumber_pre=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATUpdate_pre=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc4->_ATAccDoLoopDim_pre=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc4->_ATNestLevel_pre=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc4->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc4->_ATCPURegionNumber_pre=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATGPURegionNumber_pre=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATTypeLength_pre=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc4->_AT_cVariableUseListPtr_pre=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc4->_ATNumArgs=0;
/*SPC(7011)*/
_currn->_desc4->_ATignoreVar=FALSE;
/*SPC(5129)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
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
_currn->_ATRegionVars_post=_currn->_desc4->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc4->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(11193)*/
_currn->_ATTranslationType_post=_currn->_desc4->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc4->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc4->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc4->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc4->_ATDoAcc_post, ACCDO, _currn->_desc4->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc4->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc4->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc4->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc4->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
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
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc4->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc4->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_324(_TPPrule_324 _currn)
#else
void _VS6rule_324(_currn )
_TPPrule_324 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(_currn->_ATStmtNumber_pre, _currn->_ATThreadStmt_pre), NE(_currn->_ATStmtNumber_pre, FALSE))))) {
PTGOut(PTGThreadEnd(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_AT_const39=ZERO();
/*SPC(9763)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc4->_ATUpdateStmt_post;
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
void _VS7rule_324(_TPPrule_324 _currn)
#else
void _VS7rule_324(_currn )
_TPPrule_324 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_325(_TPPrule_325 _currn)
#else
void _VS1rule_325(_currn )
_TPPrule_325 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUnitBind=BindIdn((* _IG_incl23), _currn->_ATSym);
/*SPC(47)*/
_currn->_ATUnitKey=KeyOf(_currn->_ATUnitBind);
/*SPC(49)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_325(_TPPrule_325 _currn)
#else
void _VS2rule_325(_currn )
_TPPrule_325 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
GuaranteeType(_currn->_ATUnitKey, DefaultType(_currn->_ATSym));
/*SPC(1610)*/
_currn->_ATBind=BindIdn((* _IG_incl22), _currn->_ATSym);
/*SPC(183)*/
_currn->_ATKey=KeyOf(_currn->_ATBind);
/*SPC(185)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_325(_TPPrule_325 _currn)
#else
void _VS3rule_325(_currn )
_TPPrule_325 _currn;

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
SetUnique(_currn->_ATUnitKey, 1, 0);
/*SPC(252)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_325(_TPPrule_325 _currn)
#else
void _VS4rule_325(_currn )
_TPPrule_325 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATCoord=(&( _currn->_AT_pos));
/*SPC(2988)*/
_currn->_ATObjectKey=
((_currn->_ATKey
) ? (_currn->_ATKey
) : (_currn->_ATUnitKey))
;
/*SPC(2892)*/
_currn->_ATUnique=GetUnique(_currn->_ATUnitKey, 0);
/*SPC(255)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(CommonBlock, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;
/*SPC(2939)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), GT(GetClpValue(WarnLevel, 32767), 0))) {

if (NOT(_currn->_ATUnique)) {
message(ERROR, "Symbol represents more than one global entity", 0, (&( _currn->_AT_pos)));

} else {
}
;

} else {
}
;
/*SPC(2944)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_326(_TPPrule_326 _currn)
#else
void _VS1rule_326(_currn )
_TPPrule_326 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9756)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9754)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_326(_TPPrule_326 _currn)
#else
void _VS2rule_326(_currn )
_TPPrule_326 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_326(_TPPrule_326 _currn)
#else
void _VS3rule_326(_currn )
_TPPrule_326 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_327(_TPPrule_327 _currn)
#else
void _VS1rule_327(_currn )
_TPPrule_327 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9750)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9748)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_327(_TPPrule_327 _currn)
#else
void _VS2rule_327(_currn )
_TPPrule_327 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_327(_TPPrule_327 _currn)
#else
void _VS3rule_327(_currn )
_TPPrule_327 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_328(_TPPrule_328 _currn)
#else
void _VS1rule_328(_currn )
_TPPrule_328 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9744)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9742)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_328(_TPPrule_328 _currn)
#else
void _VS2rule_328(_currn )
_TPPrule_328 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_328(_TPPrule_328 _currn)
#else
void _VS3rule_328(_currn )
_TPPrule_328 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_329(_TPPrule_329 _currn)
#else
void _VS1rule_329(_currn )
_TPPrule_329 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9738)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9736)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_329(_TPPrule_329 _currn)
#else
void _VS2rule_329(_currn )
_TPPrule_329 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_329(_TPPrule_329 _currn)
#else
void _VS3rule_329(_currn )
_TPPrule_329 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_330(_TPPrule_330 _currn)
#else
void _VS1rule_330(_currn )
_TPPrule_330 _currn;

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
void _VS1rule_331(_TPPrule_331 _currn)
#else
void _VS1rule_331(_currn )
_TPPrule_331 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9729)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9727)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_331(_TPPrule_331 _currn)
#else
void _VS2rule_331(_currn )
_TPPrule_331 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_331(_TPPrule_331 _currn)
#else
void _VS3rule_331(_currn )
_TPPrule_331 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_332(_TPPrule_332 _currn)
#else
void _VS1rule_332(_currn )
_TPPrule_332 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9723)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9721)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_332(_TPPrule_332 _currn)
#else
void _VS2rule_332(_currn )
_TPPrule_332 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_332(_TPPrule_332 _currn)
#else
void _VS3rule_332(_currn )
_TPPrule_332 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_333(_TPPrule_333 _currn)
#else
void _VS1rule_333(_currn )
_TPPrule_333 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(9717)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9715)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_333(_TPPrule_333 _currn)
#else
void _VS2rule_333(_currn )
_TPPrule_333 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_333(_TPPrule_333 _currn)
#else
void _VS3rule_333(_currn )
_TPPrule_333 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}


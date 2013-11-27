
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
void _VS1rule_437(_TPPrule_437 _currn)
#else
void _VS1rule_437(_currn )
_TPPrule_437 _currn;

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
void _VS2rule_437(_TPPrule_437 _currn)
#else
void _VS2rule_437(_currn )
_TPPrule_437 _currn;

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
void _VS3rule_437(_TPPrule_437 _currn)
#else
void _VS3rule_437(_currn )
_TPPrule_437 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_437(_TPPrule_437 _currn)
#else
void _VS4rule_437(_currn )
_TPPrule_437 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const38=ADD(_currn->_desc1->_AT_const38, _currn->_desc2->_AT_const38);
/*SPC(9355)*/
_currn->_AT_const45=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(9355)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_437(_TPPrule_437 _currn)
#else
void _VS5rule_437(_currn )
_TPPrule_437 _currn;

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
/*SPC(9355)*/
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
void _VS6rule_437(_TPPrule_437 _currn)
#else
void _VS6rule_437(_currn )
_TPPrule_437 _currn;

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
/*SPC(9355)*/
_currn->_AT_const40=PTGSequence(_currn->_desc1->_AT_const40, _currn->_desc2->_AT_const40);
/*SPC(9355)*/
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
void _VS7rule_437(_TPPrule_437 _currn)
#else
void _VS7rule_437(_currn )
_TPPrule_437 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_438(_TPPrule_438 _currn)
#else
void _VS1rule_438(_currn )
_TPPrule_438 _currn;

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
void _VS2rule_438(_TPPrule_438 _currn)
#else
void _VS2rule_438(_currn )
_TPPrule_438 _currn;

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
void _VS3rule_438(_TPPrule_438 _currn)
#else
void _VS3rule_438(_currn )
_TPPrule_438 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUnitCnt=ADD(1, GetUnitCnt(_currn->_ATUnitKey, 0));
/*SPC(286)*/
ResetUnitCnt(_currn->_ATUnitKey, _currn->_ATUnitCnt);
/*SPC(289)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_438(_TPPrule_438 _currn)
#else
void _VS4rule_438(_currn )
_TPPrule_438 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATCoord=(&( _currn->_AT_pos));
/*SPC(2988)*/
_currn->_ATUnitTotalCnt=GetUnitCnt(_currn->_ATUnitKey, 0);
/*SPC(293)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_439(_TPPrule_439 _currn)
#else
void _VS1rule_439(_currn )
_TPPrule_439 _currn;

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
void _VS2rule_439(_TPPrule_439 _currn)
#else
void _VS2rule_439(_currn )
_TPPrule_439 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_439(_TPPrule_439 _currn)
#else
void _VS3rule_439(_currn )
_TPPrule_439 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_439(_TPPrule_439 _currn)
#else
void _VS4rule_439(_currn )
_TPPrule_439 _currn;

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
_currn->_desc4->_ATIsArray_pre=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc5->_ATIsArray_pre=_currn->_desc4->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_ATIsArray_post=_currn->_desc5->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_439(_TPPrule_439 _currn)
#else
void _VS5rule_439(_currn )
_TPPrule_439 _currn;

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
_currn->_desc4->_ATLocalIndex_pre=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc5->_ATLocalIndex_pre=_currn->_desc4->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_ATLocalIndex_post=_currn->_desc5->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_439(_TPPrule_439 _currn)
#else
void _VS6rule_439(_currn )
_TPPrule_439 _currn;

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
_currn->_desc4->_AT_cBoundsListPtr_pre=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc5->_AT_cBoundsListPtr_pre=_currn->_desc4->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_AT_cBoundsListPtr_post=_currn->_desc5->_AT_cBoundsListPtr_post;
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
void _VS7rule_439(_TPPrule_439 _currn)
#else
void _VS7rule_439(_currn )
_TPPrule_439 _currn;

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
_currn->_ATTranslationType_post=_currn->_desc5->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc5->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc5->_ATRegionVars_post;
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
_currn->_ATArraySym_post=_currn->_desc5->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_desc5->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc5->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_439(_TPPrule_439 _currn)
#else
void _VS8rule_439(_currn )
_TPPrule_439 _currn;

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
_currn->_desc4->_ATArrayId_pre=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc5->_ATArrayId_pre=_currn->_desc4->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_AT_const33=ADD(ADD(ADD(_currn->_desc1->_AT_const33, _currn->_desc3->_AT_const33), _currn->_desc4->_AT_const33), _currn->_desc5->_AT_const33);
/*SPC(9349)*/
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
_currn->_ATArrayId_post=_currn->_desc5->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xExpr not supported.");
/*SPC(8958)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_439(_TPPrule_439 _currn)
#else
void _VS9rule_439(_currn )
_TPPrule_439 _currn;

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
_currn->_AT_const18=ADD(ADD(ADD(_currn->_desc1->_AT_const18, _currn->_desc3->_AT_const18), _currn->_desc4->_AT_const18), _currn->_desc5->_AT_const18);
/*SPC(9349)*/
_currn->_AT_const32=ADD(ADD(ADD(_currn->_desc1->_AT_const32, _currn->_desc3->_AT_const32), _currn->_desc4->_AT_const32), _currn->_desc5->_AT_const32);
/*SPC(9349)*/
_currn->_ATStmtNumber_post=_currn->_desc5->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc5->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc5->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc5->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc5->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc5->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc5->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc5->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc5->_AT_cVariableUseListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_439(_TPPrule_439 _currn)
#else
void _VS10rule_439(_currn )
_TPPrule_439 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_ATArgType=PTGNULL;
/*SPC(5880)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_439(_TPPrule_439 _currn)
#else
void _VS11rule_439(_currn )
_TPPrule_439 _currn;

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
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc5->_ATUpdateStmt_pre=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc5->_ATF90LoopStart_pre=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_ATUpdateStmt_post=_currn->_desc5->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc5->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS12rule_439(_TPPrule_439 _currn)
#else
void _VS12rule_439(_currn )
_TPPrule_439 _currn;

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
_currn->_desc4->_ATDepth_pre=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc5->_ATDepth_pre=_currn->_desc4->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_AT_const34=ADD(ADD(ADD(_currn->_desc1->_AT_const34, _currn->_desc3->_AT_const34), _currn->_desc4->_AT_const34), _currn->_desc5->_AT_const34);
/*SPC(9349)*/
_currn->_AT_const50=ADD(ADD(ADD(ADD(_currn->_desc1->_AT_const50, IDENTICAL(_currn->_desc1->_ATConstantUsed)), ADD(_currn->_desc3->_AT_const50, IDENTICAL(_currn->_desc3->_ATConstantUsed))), ADD(_currn->_desc4->_AT_const50, IDENTICAL(_currn->_desc4->_ATConstantUsed))), ADD(_currn->_desc5->_AT_const50, IDENTICAL(_currn->_desc5->_ATConstantUsed)));
/*SPC(9349)*/
_currn->_AT_const63=ADD(ADD(ADD(_currn->_desc1->_AT_const63, _currn->_desc3->_AT_const63), _currn->_desc4->_AT_const63), _currn->_desc5->_AT_const63);
/*SPC(9349)*/
_currn->_AT_const64=ADD(ADD(ADD(_currn->_desc1->_AT_const64, _currn->_desc3->_AT_const64), _currn->_desc4->_AT_const64), _currn->_desc5->_AT_const64);
/*SPC(9349)*/
_currn->_AT_const65=ADD(ADD(ADD(_currn->_desc1->_AT_const65, _currn->_desc3->_AT_const65), _currn->_desc4->_AT_const65), _currn->_desc5->_AT_const65);
/*SPC(9349)*/
_currn->_AT_const66=ADD(ADD(ADD(_currn->_desc1->_AT_const66, _currn->_desc3->_AT_const66), _currn->_desc4->_AT_const66), _currn->_desc5->_AT_const66);
/*SPC(9349)*/
_currn->_ATDepth_post=_currn->_desc5->_ATDepth_post;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_440(_TPPrule_440 _currn)
#else
void _VS1rule_440(_currn )
_TPPrule_440 _currn;

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
void _VS2rule_440(_TPPrule_440 _currn)
#else
void _VS2rule_440(_currn )
_TPPrule_440 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_440(_TPPrule_440 _currn)
#else
void _VS3rule_440(_currn )
_TPPrule_440 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_440(_TPPrule_440 _currn)
#else
void _VS4rule_440(_currn )
_TPPrule_440 _currn;

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
_currn->_desc4->_ATIsArray_pre=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATIsArray_post=_currn->_desc4->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_440(_TPPrule_440 _currn)
#else
void _VS5rule_440(_currn )
_TPPrule_440 _currn;

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
_currn->_desc4->_ATLocalIndex_pre=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATLocalIndex_post=_currn->_desc4->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_440(_TPPrule_440 _currn)
#else
void _VS6rule_440(_currn )
_TPPrule_440 _currn;

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
_currn->_desc4->_AT_cBoundsListPtr_pre=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_AT_cBoundsListPtr_post=_currn->_desc4->_AT_cBoundsListPtr_post;
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
void _VS7rule_440(_TPPrule_440 _currn)
#else
void _VS7rule_440(_currn )
_TPPrule_440 _currn;

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
_currn->_ATTranslationType_post=_currn->_desc4->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc4->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc4->_ATRegionVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc4->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc4->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_440(_TPPrule_440 _currn)
#else
void _VS8rule_440(_currn )
_TPPrule_440 _currn;

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
_currn->_desc4->_ATArrayId_pre=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_AT_const33=ADD(ADD(_currn->_desc1->_AT_const33, _currn->_desc3->_AT_const33), _currn->_desc4->_AT_const33);
/*SPC(9346)*/
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
_currn->_ATArrayId_post=_currn->_desc4->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xExpr not supported.");
/*SPC(8958)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_440(_TPPrule_440 _currn)
#else
void _VS9rule_440(_currn )
_TPPrule_440 _currn;

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
_currn->_AT_const18=ADD(ADD(_currn->_desc1->_AT_const18, _currn->_desc3->_AT_const18), _currn->_desc4->_AT_const18);
/*SPC(9346)*/
_currn->_AT_const32=ADD(ADD(_currn->_desc1->_AT_const32, _currn->_desc3->_AT_const32), _currn->_desc4->_AT_const32);
/*SPC(9346)*/
_currn->_ATStmtNumber_post=_currn->_desc4->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc4->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc4->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc4->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc4->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc4->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc4->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc4->_ATTypeLength_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc4->_AT_cVariableUseListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_440(_TPPrule_440 _currn)
#else
void _VS10rule_440(_currn )
_TPPrule_440 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATArgType=PTGNULL;
/*SPC(5880)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_440(_TPPrule_440 _currn)
#else
void _VS11rule_440(_currn )
_TPPrule_440 _currn;

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
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATUpdateStmt_post=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS12rule_440(_TPPrule_440 _currn)
#else
void _VS12rule_440(_currn )
_TPPrule_440 _currn;

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
_currn->_desc4->_ATDepth_pre=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_AT_const34=ADD(ADD(_currn->_desc1->_AT_const34, _currn->_desc3->_AT_const34), _currn->_desc4->_AT_const34);
/*SPC(9346)*/
_currn->_AT_const50=ADD(ADD(ADD(_currn->_desc1->_AT_const50, IDENTICAL(_currn->_desc1->_ATConstantUsed)), ADD(_currn->_desc3->_AT_const50, IDENTICAL(_currn->_desc3->_ATConstantUsed))), ADD(_currn->_desc4->_AT_const50, IDENTICAL(_currn->_desc4->_ATConstantUsed)));
/*SPC(9346)*/
_currn->_AT_const63=ADD(ADD(_currn->_desc1->_AT_const63, _currn->_desc3->_AT_const63), _currn->_desc4->_AT_const63);
/*SPC(9346)*/
_currn->_AT_const64=ADD(ADD(_currn->_desc1->_AT_const64, _currn->_desc3->_AT_const64), _currn->_desc4->_AT_const64);
/*SPC(9346)*/
_currn->_AT_const65=ADD(ADD(_currn->_desc1->_AT_const65, _currn->_desc3->_AT_const65), _currn->_desc4->_AT_const65);
/*SPC(9346)*/
_currn->_AT_const66=ADD(ADD(_currn->_desc1->_AT_const66, _currn->_desc3->_AT_const66), _currn->_desc4->_AT_const66);
/*SPC(9346)*/
_currn->_ATDepth_post=_currn->_desc4->_ATDepth_post;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_441(_TPPrule_441 _currn)
#else
void _VS1rule_441(_currn )
_TPPrule_441 _currn;

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
void _VS2rule_441(_TPPrule_441 _currn)
#else
void _VS2rule_441(_currn )
_TPPrule_441 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_441(_TPPrule_441 _currn)
#else
void _VS3rule_441(_currn )
_TPPrule_441 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_441(_TPPrule_441 _currn)
#else
void _VS4rule_441(_currn )
_TPPrule_441 _currn;

#endif
{
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_BoundsauxList=NULLBoundsList;
/*SPC(354)*/
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(9343)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_441(_TPPrule_441 _currn)
#else
void _VS5rule_441(_currn )
_TPPrule_441 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12737)*/
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
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(8745)*/
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
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4605)*/
_currn->_desc1->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_BoundsListADDROF(_currn->_AT_BoundsauxList);
/*SPC(355)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATBaseValue_post=_currn->_desc1->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc1->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc1->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc1->_ATAccDoStmt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=0;
/*SPC(8604)*/
_currn->_ATArrayId_post=NoKey;
/*SPC(8600)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(11193)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc1->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc1->_ATDoAcc_post, ACCDO, _currn->_desc1->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc1->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc1->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_441(_TPPrule_441 _currn)
#else
void _VS6rule_441(_currn )
_TPPrule_441 _currn;

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
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12738)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8110)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3679)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(9343)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
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
void _VS7rule_441(_TPPrule_441 _currn)
#else
void _VS7rule_441(_currn )
_TPPrule_441 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_442(_TPPrule_442 _currn)
#else
void _VS1rule_442(_currn )
_TPPrule_442 _currn;

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
/*SPC(9339)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_442(_TPPrule_442 _currn)
#else
void _VS2rule_442(_currn )
_TPPrule_442 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_442(_TPPrule_442 _currn)
#else
void _VS4rule_442(_currn )
_TPPrule_442 _currn;

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
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9335)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_442(_TPPrule_442 _currn)
#else
void _VS5rule_442(_currn )
_TPPrule_442 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
void _VS6rule_442(_TPPrule_442 _currn)
#else
void _VS6rule_442(_currn )
_TPPrule_442 _currn;

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
_currn->_AT_const39=ZERO();
/*SPC(9335)*/
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
void _VS7rule_442(_TPPrule_442 _currn)
#else
void _VS7rule_442(_currn )
_TPPrule_442 _currn;

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
void _VS1rule_443(_TPPrule_443 _currn)
#else
void _VS1rule_443(_currn )
_TPPrule_443 _currn;

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
/*SPC(9331)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_443(_TPPrule_443 _currn)
#else
void _VS2rule_443(_currn )
_TPPrule_443 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_443(_TPPrule_443 _currn)
#else
void _VS4rule_443(_currn )
_TPPrule_443 _currn;

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
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9327)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_443(_TPPrule_443 _currn)
#else
void _VS5rule_443(_currn )
_TPPrule_443 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc3->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc3->_ATDoAcc_post, ACCDO, _currn->_desc3->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc3->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
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
void _VS6rule_443(_TPPrule_443 _currn)
#else
void _VS6rule_443(_currn )
_TPPrule_443 _currn;

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
_currn->_AT_const39=ZERO();
/*SPC(9327)*/
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
void _VS7rule_443(_TPPrule_443 _currn)
#else
void _VS7rule_443(_currn )
_TPPrule_443 _currn;

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
void _VS1rule_444(_TPPrule_444 _currn)
#else
void _VS1rule_444(_currn )
_TPPrule_444 _currn;

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
/*SPC(9323)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_444(_TPPrule_444 _currn)
#else
void _VS2rule_444(_currn )
_TPPrule_444 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_444(_TPPrule_444 _currn)
#else
void _VS4rule_444(_currn )
_TPPrule_444 _currn;

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
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(9319)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_444(_TPPrule_444 _currn)
#else
void _VS5rule_444(_currn )
_TPPrule_444 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc3->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc3->_ATDoAcc_post, ACCDO, _currn->_desc3->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc3->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
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
void _VS6rule_444(_TPPrule_444 _currn)
#else
void _VS6rule_444(_currn )
_TPPrule_444 _currn;

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
_currn->_AT_const39=ZERO();
/*SPC(9319)*/
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
void _VS7rule_444(_TPPrule_444 _currn)
#else
void _VS7rule_444(_currn )
_TPPrule_444 _currn;

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
void _VS1rule_445(_TPPrule_445 _currn)
#else
void _VS1rule_445(_currn )
_TPPrule_445 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
void _VS1rule_446(_TPPrule_446 _currn)
#else
void _VS1rule_446(_currn )
_TPPrule_446 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS1rule_451(_TPPrule_451 _currn)
#else
void _VS1rule_451(_currn )
_TPPrule_451 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs(">");
/*SPC(9176)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_452(_TPPrule_452 _currn)
#else
void _VS1rule_452(_currn )
_TPPrule_452 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs(">=");
/*SPC(9175)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_453(_TPPrule_453 _currn)
#else
void _VS1rule_453(_currn )
_TPPrule_453 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("<");
/*SPC(9174)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_454(_TPPrule_454 _currn)
#else
void _VS1rule_454(_currn )
_TPPrule_454 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("<=");
/*SPC(9173)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_455(_TPPrule_455 _currn)
#else
void _VS1rule_455(_currn )
_TPPrule_455 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("==");
/*SPC(9171)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_456(_TPPrule_456 _currn)
#else
void _VS1rule_456(_currn )
_TPPrule_456 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("!=");
/*SPC(9170)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_457(_TPPrule_457 _currn)
#else
void _VS1rule_457(_currn )
_TPPrule_457 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("!=");
/*SPC(9169)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_458(_TPPrule_458 _currn)
#else
void _VS1rule_458(_currn )
_TPPrule_458 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("<");
/*SPC(9168)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_459(_TPPrule_459 _currn)
#else
void _VS1rule_459(_currn )
_TPPrule_459 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("<=");
/*SPC(9167)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_460(_TPPrule_460 _currn)
#else
void _VS1rule_460(_currn )
_TPPrule_460 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs(">");
/*SPC(9166)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_461(_TPPrule_461 _currn)
#else
void _VS1rule_461(_currn )
_TPPrule_461 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs(">=");
/*SPC(9165)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_462(_TPPrule_462 _currn)
#else
void _VS1rule_462(_currn )
_TPPrule_462 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("==");
/*SPC(9164)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_463(_TPPrule_463 _currn)
#else
void _VS1rule_463(_currn )
_TPPrule_463 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("||");
/*SPC(9163)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_464(_TPPrule_464 _currn)
#else
void _VS1rule_464(_currn )
_TPPrule_464 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("!=");
/*SPC(9162)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_465(_TPPrule_465 _currn)
#else
void _VS1rule_465(_currn )
_TPPrule_465 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("==");
/*SPC(9161)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_466(_TPPrule_466 _currn)
#else
void _VS1rule_466(_currn )
_TPPrule_466 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("F2C-ACC: xBinOp not supported.");
/*SPC(9154)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_467(_TPPrule_467 _currn)
#else
void _VS1rule_467(_currn )
_TPPrule_467 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("&&");
/*SPC(9159)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("---");
/*SPC(839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_468(_TPPrule_468 _currn)
#else
void _VS1rule_468(_currn )
_TPPrule_468 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("!");
/*SPC(9145)*/
_currn->_ATLoopIncrNeg=FALSE;
/*SPC(7684)*/
_currn->_ATValue=MakeName("---");
/*SPC(838)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_469(_TPPrule_469 _currn)
#else
void _VS1rule_469(_currn )
_TPPrule_469 _currn;

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
void _VS2rule_469(_TPPrule_469 _currn)
#else
void _VS2rule_469(_currn )
_TPPrule_469 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_469(_TPPrule_469 _currn)
#else
void _VS3rule_469(_currn )
_TPPrule_469 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_469(_TPPrule_469 _currn)
#else
void _VS4rule_469(_currn )
_TPPrule_469 _currn;

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
void _VS5rule_469(_TPPrule_469 _currn)
#else
void _VS5rule_469(_currn )
_TPPrule_469 _currn;

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
void _VS6rule_469(_TPPrule_469 _currn)
#else
void _VS6rule_469(_currn )
_TPPrule_469 _currn;

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
void _VS7rule_469(_TPPrule_469 _currn)
#else
void _VS7rule_469(_currn )
_TPPrule_469 _currn;

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
_currn->_desc3->_ATUnitScope=NoEnv;
/*SPC(969)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATArgCnt_post=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_469(_TPPrule_469 _currn)
#else
void _VS8rule_469(_currn )
_TPPrule_469 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxMinFunct=FALSE;
/*SPC(8890)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const33=_currn->_desc1->_AT_const33;
/*SPC(9096)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xSFDataRef not supported.");
/*SPC(9056)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_469(_TPPrule_469 _currn)
#else
void _VS9rule_469(_currn )
_TPPrule_469 _currn;

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
/*SPC(9096)*/
_currn->_AT_const32=ADD(_currn->_desc1->_AT_const32, _currn->_desc2->_AT_const32);
/*SPC(9096)*/
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
void _VS10rule_469(_TPPrule_469 _currn)
#else
void _VS10rule_469(_currn )
_TPPrule_469 _currn;

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
void _VS11rule_469(_TPPrule_469 _currn)
#else
void _VS11rule_469(_currn )
_TPPrule_469 _currn;

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
_currn->_AT_const34=ADD(_currn->_desc1->_AT_const34, _currn->_desc2->_AT_const34);
/*SPC(9096)*/
_currn->_AT_const63=ADD(_currn->_desc1->_AT_const63, _currn->_desc2->_AT_const63);
/*SPC(9096)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(9096)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(9096)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(9096)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_470(_TPPrule_470 _currn)
#else
void _VS1rule_470(_currn )
_TPPrule_470 _currn;

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
void _VS2rule_470(_TPPrule_470 _currn)
#else
void _VS2rule_470(_currn )
_TPPrule_470 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_470(_TPPrule_470 _currn)
#else
void _VS3rule_470(_currn )
_TPPrule_470 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_470(_TPPrule_470 _currn)
#else
void _VS4rule_470(_currn )
_TPPrule_470 _currn;

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
void _VS5rule_470(_TPPrule_470 _currn)
#else
void _VS5rule_470(_currn )
_TPPrule_470 _currn;

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
void _VS6rule_470(_TPPrule_470 _currn)
#else
void _VS6rule_470(_currn )
_TPPrule_470 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_470(_TPPrule_470 _currn)
#else
void _VS7rule_470(_currn )
_TPPrule_470 _currn;

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
_currn->_desc2->_ATUnitScope=NoEnv;
/*SPC(969)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATDeclsOrder_post=_currn->_desc1->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_470(_TPPrule_470 _currn)
#else
void _VS8rule_470(_currn )
_TPPrule_470 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const33=_currn->_desc1->_AT_const33;
/*SPC(9093)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xSFDataRef not supported.");
/*SPC(9056)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_470(_TPPrule_470 _currn)
#else
void _VS9rule_470(_currn )
_TPPrule_470 _currn;

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
/*SPC(9093)*/
_currn->_AT_const32=_currn->_desc1->_AT_const32;
/*SPC(9093)*/
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
void _VS10rule_470(_TPPrule_470 _currn)
#else
void _VS10rule_470(_currn )
_TPPrule_470 _currn;

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
void _VS11rule_470(_TPPrule_470 _currn)
#else
void _VS11rule_470(_currn )
_TPPrule_470 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=_currn->_desc1->_AT_const34;
/*SPC(9093)*/
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(9093)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(9093)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(9093)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(9093)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_471(_TPPrule_471 _currn)
#else
void _VS1rule_471(_currn )
_TPPrule_471 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_471(_TPPrule_471 _currn)
#else
void _VS2rule_471(_currn )
_TPPrule_471 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_471(_TPPrule_471 _currn)
#else
void _VS3rule_471(_currn )
_TPPrule_471 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_471(_TPPrule_471 _currn)
#else
void _VS4rule_471(_currn )
_TPPrule_471 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_471(_TPPrule_471 _currn)
#else
void _VS5rule_471(_currn )
_TPPrule_471 _currn;

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
void _VS6rule_471(_TPPrule_471 _currn)
#else
void _VS6rule_471(_currn )
_TPPrule_471 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_471(_TPPrule_471 _currn)
#else
void _VS7rule_471(_currn )
_TPPrule_471 _currn;

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
_currn->_desc2->_ATUnitScope=NoEnv;
/*SPC(969)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_471(_TPPrule_471 _currn)
#else
void _VS8rule_471(_currn )
_TPPrule_471 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const33=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(9090)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xSFDataRef not supported.");
/*SPC(9056)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_471(_TPPrule_471 _currn)
#else
void _VS9rule_471(_currn )
_TPPrule_471 _currn;

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
/*SPC(9090)*/
_currn->_AT_const32=ZERO();
/*SPC(9090)*/
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
void _VS10rule_471(_TPPrule_471 _currn)
#else
void _VS10rule_471(_currn )
_TPPrule_471 _currn;

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
void _VS11rule_471(_TPPrule_471 _currn)
#else
void _VS11rule_471(_currn )
_TPPrule_471 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=ZERO();
/*SPC(9090)*/
_currn->_AT_const63=ZERO();
/*SPC(9090)*/
_currn->_AT_const64=IDENTICAL(_currn->_desc1->_ATPar1);
/*SPC(9090)*/
_currn->_AT_const65=IDENTICAL(_currn->_desc1->_ATPar2);
/*SPC(9090)*/
_currn->_AT_const66=IDENTICAL(_currn->_desc1->_ATPar3);
/*SPC(9090)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_472(_TPPrule_472 _currn)
#else
void _VS1rule_472(_currn )
_TPPrule_472 _currn;

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
void _VS2rule_472(_TPPrule_472 _currn)
#else
void _VS2rule_472(_currn )
_TPPrule_472 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_472(_TPPrule_472 _currn)
#else
void _VS3rule_472(_currn )
_TPPrule_472 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_472(_TPPrule_472 _currn)
#else
void _VS4rule_472(_currn )
_TPPrule_472 _currn;

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
void _VS5rule_472(_TPPrule_472 _currn)
#else
void _VS5rule_472(_currn )
_TPPrule_472 _currn;

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
void _VS6rule_472(_TPPrule_472 _currn)
#else
void _VS6rule_472(_currn )
_TPPrule_472 _currn;

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
void _VS7rule_472(_TPPrule_472 _currn)
#else
void _VS7rule_472(_currn )
_TPPrule_472 _currn;

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
void _VS8rule_472(_TPPrule_472 _currn)
#else
void _VS8rule_472(_currn )
_TPPrule_472 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const33=_currn->_desc1->_AT_const33;
/*SPC(9051)*/
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
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(9052)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_472(_TPPrule_472 _currn)
#else
void _VS9rule_472(_currn )
_TPPrule_472 _currn;

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
/*SPC(9051)*/
_currn->_AT_const32=_currn->_desc1->_AT_const32;
/*SPC(9051)*/
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
void _VS10rule_472(_TPPrule_472 _currn)
#else
void _VS10rule_472(_currn )
_TPPrule_472 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATArgType=PTGNULL;
/*SPC(5880)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_472(_TPPrule_472 _currn)
#else
void _VS11rule_472(_currn )
_TPPrule_472 _currn;

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
void _VS12rule_472(_TPPrule_472 _currn)
#else
void _VS12rule_472(_currn )
_TPPrule_472 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=_currn->_desc1->_AT_const34;
/*SPC(9051)*/
_currn->_AT_const50=ZERO();
/*SPC(9051)*/
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(9051)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(9051)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(9051)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(9051)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_473(_TPPrule_473 _currn)
#else
void _VS1rule_473(_currn )
_TPPrule_473 _currn;

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
void _VS2rule_473(_TPPrule_473 _currn)
#else
void _VS2rule_473(_currn )
_TPPrule_473 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_473(_TPPrule_473 _currn)
#else
void _VS3rule_473(_currn )
_TPPrule_473 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_473(_TPPrule_473 _currn)
#else
void _VS4rule_473(_currn )
_TPPrule_473 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_473(_TPPrule_473 _currn)
#else
void _VS5rule_473(_currn )
_TPPrule_473 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS6rule_473(_TPPrule_473 _currn)
#else
void _VS6rule_473(_currn )
_TPPrule_473 _currn;

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
_currn->_ATObjectId=NoKey;
/*SPC(3838)*/
_currn->_ATValue=0;
/*SPC(862)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_473(_TPPrule_473 _currn)
#else
void _VS7rule_473(_currn )
_TPPrule_473 _currn;

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
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
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
void _VS8rule_473(_TPPrule_473 _currn)
#else
void _VS8rule_473(_currn )
_TPPrule_473 _currn;

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
_currn->_AT_const33=ADD(IDENTICAL(_currn->_desc1->_ATMatch), _currn->_desc2->_AT_const33);
/*SPC(9026)*/
_currn->_ATarrayRef_RuleAttr_930=FTNREFCPP(_currn->_desc1->_ATSym, _currn->_desc1->_ATRegionVars_post, 0, 0, _currn->_desc1->_ATUnitKey, _currn->_desc1->_ATObjectKey, _currn->_desc2->_ATPtg, (&( _currn->_AT_pos)), _currn->_desc1->_ATGPUVarsDeList_post);
/*SPC(9028)*/
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
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=
((InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS()))
) ? (PTGArrayRef(_currn->_desc1->_ATPtg, _currn->_ATarrayRef_RuleAttr_930)
) : (
((EQ(isIntrinsic(StringTable(_currn->_desc1->_ATSym), _currn->_desc2->_ATLocalIndex_post), TRUE)
) ? (PTGIntrinsicRef(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)
) : (PTGFunctionRef(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)))
))
;
/*SPC(9038)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_473(_TPPrule_473 _currn)
#else
void _VS9rule_473(_currn )
_TPPrule_473 _currn;

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
/*SPC(9026)*/
_currn->_AT_const32=_currn->_desc2->_AT_const32;
/*SPC(9026)*/
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
void _VS10rule_473(_TPPrule_473 _currn)
#else
void _VS10rule_473(_currn )
_TPPrule_473 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATArgType=PTGNULL;
/*SPC(5880)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_473(_TPPrule_473 _currn)
#else
void _VS11rule_473(_currn )
_TPPrule_473 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS12rule_473(_TPPrule_473 _currn)
#else
void _VS12rule_473(_currn )
_TPPrule_473 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const34=_currn->_desc2->_AT_const34;
/*SPC(9026)*/
_currn->_AT_const50=_currn->_desc2->_AT_const50;
/*SPC(9026)*/
_currn->_AT_const63=_currn->_desc2->_AT_const63;
/*SPC(9026)*/
_currn->_AT_const64=ADD(IDENTICAL(_currn->_desc1->_ATPar1), _currn->_desc2->_AT_const64);
/*SPC(9026)*/
_currn->_AT_const65=ADD(IDENTICAL(_currn->_desc1->_ATPar2), _currn->_desc2->_AT_const65);
/*SPC(9026)*/
_currn->_AT_const66=ADD(IDENTICAL(_currn->_desc1->_ATPar3), _currn->_desc2->_AT_const66);
/*SPC(9026)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATdeclLine_RuleAttr_930=0;
/*SPC(9027)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_474(_TPPrule_474 _currn)
#else
void _VS1rule_474(_currn )
_TPPrule_474 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported in this context.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11188)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_474(_TPPrule_474 _currn)
#else
void _VS2rule_474(_currn )
_TPPrule_474 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_474(_TPPrule_474 _currn)
#else
void _VS3rule_474(_currn )
_TPPrule_474 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=
((InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS()))
) ? (TRUE
) : (FALSE))
;
/*SPC(8732)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_474(_TPPrule_474 _currn)
#else
void _VS4rule_474(_currn )
_TPPrule_474 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_474(_TPPrule_474 _currn)
#else
void _VS5rule_474(_currn )
_TPPrule_474 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=1;
/*SPC(8809)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(8737)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATObjectKey;
/*SPC(8731)*/
_currn->_desc2->_ATMaxMinFunct=FALSE;
/*SPC(8890)*/
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
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATlocal_RuleAttr_931=_currn->_ATLocalIndex_pre;
/*SPC(8808)*/
_currn->_ATLocalIndex_post=_currn->_ATlocal_RuleAttr_931;
/*SPC(8810)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_474(_TPPrule_474 _currn)
#else
void _VS6rule_474(_currn )
_TPPrule_474 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
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
void _VS7rule_474(_TPPrule_474 _currn)
#else
void _VS7rule_474(_currn )
_TPPrule_474 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_474(_TPPrule_474 _currn)
#else
void _VS8rule_474(_currn )
_TPPrule_474 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGNULL;
/*SPC(11186)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_475(_TPPrule_475 _currn)
#else
void _VS1rule_475(_currn )
_TPPrule_475 _currn;

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
void _VS2rule_475(_TPPrule_475 _currn)
#else
void _VS2rule_475(_currn )
_TPPrule_475 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_475(_TPPrule_475 _currn)
#else
void _VS3rule_475(_currn )
_TPPrule_475 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_475(_TPPrule_475 _currn)
#else
void _VS4rule_475(_currn )
_TPPrule_475 _currn;

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
void _VS5rule_475(_TPPrule_475 _currn)
#else
void _VS5rule_475(_currn )
_TPPrule_475 _currn;

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
void _VS6rule_475(_TPPrule_475 _currn)
#else
void _VS6rule_475(_currn )
_TPPrule_475 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_475(_TPPrule_475 _currn)
#else
void _VS7rule_475(_currn )
_TPPrule_475 _currn;

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
void _VS8rule_475(_TPPrule_475 _currn)
#else
void _VS8rule_475(_currn )
_TPPrule_475 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const33=_currn->_desc1->_AT_const33;
/*SPC(8570)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_475(_TPPrule_475 _currn)
#else
void _VS9rule_475(_currn )
_TPPrule_475 _currn;

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
/*SPC(8570)*/
_currn->_AT_const32=_currn->_desc1->_AT_const32;
/*SPC(8570)*/
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
void _VS10rule_475(_TPPrule_475 _currn)
#else
void _VS10rule_475(_currn )
_TPPrule_475 _currn;

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
void _VS11rule_475(_TPPrule_475 _currn)
#else
void _VS11rule_475(_currn )
_TPPrule_475 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=_currn->_desc1->_AT_const34;
/*SPC(8570)*/
_currn->_AT_const50=_currn->_desc1->_AT_const50;
/*SPC(8570)*/
_currn->_AT_const63=ADD(_currn->_desc1->_AT_const63, IDENTICAL(_currn->_desc1->_ATF90Syntax));
/*SPC(8570)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(8570)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(8570)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(8570)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_476(_TPPrule_476 _currn)
#else
void _VS1rule_476(_currn )
_TPPrule_476 _currn;

#endif
{
int* _IL_incl35;

_VisitVarDecl()
_VisitEntry();
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATInStmtFunc);
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_IG_incl35=_IL_incl35;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_476(_TPPrule_476 _currn)
#else
void _VS2rule_476(_currn )
_TPPrule_476 _currn;

#endif
{
int* _IL_incl35;
Environment* _IL_incl22;

_VisitVarDecl()
_VisitEntry();
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATInStmtFunc);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8661)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_IG_incl35=_IL_incl35;
_IG_incl22=_IL_incl22;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_476(_TPPrule_476 _currn)
#else
void _VS3rule_476(_currn )
_TPPrule_476 _currn;

#endif
{
int* _IL_incl35;
Environment* _IL_incl22;

_VisitVarDecl()
_VisitEntry();
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATInStmtFunc);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
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
_currn->_ATPtg=PTGStmtFunction(PTGNULL, _currn->_desc1->_ATPtg);
/*SPC(8548)*/
_currn->_ATIndexPtg=PTGNULL;
/*SPC(8547)*/
_IG_incl35=_IL_incl35;
_IG_incl22=_IL_incl22;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_476(_TPPrule_476 _currn)
#else
void _VS4rule_476(_currn )
_TPPrule_476 _currn;

#endif
{
int* _IL_incl35;
Environment* _IL_incl22;

_VisitVarDecl()
_VisitEntry();
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATInStmtFunc);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(8546)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(8546)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(8546)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(8546)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=FALSE;
/*SPC(8660)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_IG_incl35=_IL_incl35;
_IG_incl22=_IL_incl22;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_477(_TPPrule_477 _currn)
#else
void _VS1rule_477(_currn )
_TPPrule_477 _currn;

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
void _VS2rule_477(_TPPrule_477 _currn)
#else
void _VS2rule_477(_currn )
_TPPrule_477 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_477(_TPPrule_477 _currn)
#else
void _VS3rule_477(_currn )
_TPPrule_477 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_477(_TPPrule_477 _currn)
#else
void _VS4rule_477(_currn )
_TPPrule_477 _currn;

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
void _VS5rule_477(_TPPrule_477 _currn)
#else
void _VS5rule_477(_currn )
_TPPrule_477 _currn;

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
void _VS6rule_477(_TPPrule_477 _currn)
#else
void _VS6rule_477(_currn )
_TPPrule_477 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre)) {
message(ERROR, "This Fortran 90 array syntax is not supported.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8497)*/
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
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_AT_const51=ZERO();
/*SPC(8495)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATF90Syntax=FALSE;
/*SPC(8104)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xExprList not supported.");
/*SPC(8085)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_477(_TPPrule_477 _currn)
#else
void _VS7rule_477(_currn )
_TPPrule_477 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_477(_TPPrule_477 _currn)
#else
void _VS8rule_477(_currn )
_TPPrule_477 _currn;

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
/*SPC(8495)*/
_currn->_AT_const63=ADD(_currn->_desc1->_AT_const63, _currn->_desc2->_AT_const63);
/*SPC(8495)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(8495)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(8495)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(8495)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_478(_TPPrule_478 _currn)
#else
void _VS1rule_478(_currn )
_TPPrule_478 _currn;

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
void _VS2rule_478(_TPPrule_478 _currn)
#else
void _VS2rule_478(_currn )
_TPPrule_478 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_478(_TPPrule_478 _currn)
#else
void _VS3rule_478(_currn )
_TPPrule_478 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_478(_TPPrule_478 _currn)
#else
void _VS4rule_478(_currn )
_TPPrule_478 _currn;

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
void _VS5rule_478(_TPPrule_478 _currn)
#else
void _VS5rule_478(_currn )
_TPPrule_478 _currn;

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
void _VS6rule_478(_TPPrule_478 _currn)
#else
void _VS6rule_478(_currn )
_TPPrule_478 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre)) {
message(ERROR, "This Fortran 90 array syntax is not supported.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8492)*/
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
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_AT_const51=ZERO();
/*SPC(8490)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATF90Syntax=FALSE;
/*SPC(8104)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xExprList not supported.");
/*SPC(8085)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_478(_TPPrule_478 _currn)
#else
void _VS7rule_478(_currn )
_TPPrule_478 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_478(_TPPrule_478 _currn)
#else
void _VS8rule_478(_currn )
_TPPrule_478 _currn;

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
/*SPC(8490)*/
_currn->_AT_const63=ADD(_currn->_desc1->_AT_const63, _currn->_desc2->_AT_const63);
/*SPC(8490)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(8490)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(8490)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(8490)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_479(_TPPrule_479 _currn)
#else
void _VS1rule_479(_currn )
_TPPrule_479 _currn;

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
void _VS2rule_479(_TPPrule_479 _currn)
#else
void _VS2rule_479(_currn )
_TPPrule_479 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_479(_TPPrule_479 _currn)
#else
void _VS3rule_479(_currn )
_TPPrule_479 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_479(_TPPrule_479 _currn)
#else
void _VS4rule_479(_currn )
_TPPrule_479 _currn;

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
void _VS5rule_479(_TPPrule_479 _currn)
#else
void _VS5rule_479(_currn )
_TPPrule_479 _currn;

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
void _VS6rule_479(_TPPrule_479 _currn)
#else
void _VS6rule_479(_currn )
_TPPrule_479 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre)) {
message(ERROR, "This Fortran 90 array syntax is not supported.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8487)*/
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
_currn->_AT_const51=ZERO();
/*SPC(8485)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATF90Syntax=FALSE;
/*SPC(8104)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xExprList not supported.");
/*SPC(8085)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_479(_TPPrule_479 _currn)
#else
void _VS7rule_479(_currn )
_TPPrule_479 _currn;

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
void _VS8rule_479(_TPPrule_479 _currn)
#else
void _VS8rule_479(_currn )
_TPPrule_479 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const19=IDENTICAL(_currn->_desc1->_ATConstantUsed);
/*SPC(8485)*/
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(8485)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(8485)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(8485)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(8485)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_480(_TPPrule_480 _currn)
#else
void _VS1rule_480(_currn )
_TPPrule_480 _currn;

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
void _VS2rule_480(_TPPrule_480 _currn)
#else
void _VS2rule_480(_currn )
_TPPrule_480 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_480(_TPPrule_480 _currn)
#else
void _VS3rule_480(_currn )
_TPPrule_480 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_480(_TPPrule_480 _currn)
#else
void _VS4rule_480(_currn )
_TPPrule_480 _currn;

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
void _VS5rule_480(_TPPrule_480 _currn)
#else
void _VS5rule_480(_currn )
_TPPrule_480 _currn;

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
/*SPC(8861)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_480(_TPPrule_480 _currn)
#else
void _VS6rule_480(_currn )
_TPPrule_480 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ((* _IG_incl34), ASSIGN)))) {
message(ERROR, "Fortran 90 array syntax is not supported within an ACC$REGION.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8453)*/
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
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
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const51=ZERO();
/*SPC(8449)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATvariableName_RuleAttr_937=PTGSequence(PTGAsIs("ii_"), PTGNumber(_currn->_desc2->_ATLocalIndex_post));
/*SPC(8458)*/
_currn->_ATF90Syntax=TRUE;
/*SPC(8455)*/
_currn->_ATPtg=PTGCommaArgs(_currn->_desc1->_ATPtg, _currn->_ATvariableName_RuleAttr_937);
/*SPC(8459)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_480(_TPPrule_480 _currn)
#else
void _VS7rule_480(_currn )
_TPPrule_480 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (AND(EQ(_currn->_ATUpdateStmt_pre, TRUE), EQ((* _IG_incl34), ASSIGN))) {
PTGOut(PTGSequence(PTGAppend(PTGNumber(SUB(MapLine(((_currn->_AT_pos).line)), 1)), PTGGenerateForLoop(PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATvariableName_RuleAttr_937, GetArrayBounds(_currn->_ATArrayId_pre, _currn->_ATLocalIndex_pre, LBOUND), _currn->_ATvariableName_RuleAttr_937, _currn->_desc2->_ATPtg, _currn->_ATvariableName_RuleAttr_937)), PTGAppend(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGGenerateEndLoop(PTGIndent(_currn->_ATIndentLevel_pre)))));

} else {
}
;

} else {
}
;
/*SPC(8478)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATValue;
/*SPC(8457)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_480(_TPPrule_480 _currn)
#else
void _VS8rule_480(_currn )
_TPPrule_480 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const19=IDENTICAL(_currn->_desc2->_ATConstantUsed);
/*SPC(8449)*/
_currn->_AT_const63=_currn->_desc2->_AT_const63;
/*SPC(8449)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(8449)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(8449)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(8449)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_481(_TPPrule_481 _currn)
#else
void _VS1rule_481(_currn )
_TPPrule_481 _currn;

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
void _VS2rule_481(_TPPrule_481 _currn)
#else
void _VS2rule_481(_currn )
_TPPrule_481 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_481(_TPPrule_481 _currn)
#else
void _VS3rule_481(_currn )
_TPPrule_481 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_481(_TPPrule_481 _currn)
#else
void _VS4rule_481(_currn )
_TPPrule_481 _currn;

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
void _VS5rule_481(_TPPrule_481 _currn)
#else
void _VS5rule_481(_currn )
_TPPrule_481 _currn;

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
/*SPC(8853)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_481(_TPPrule_481 _currn)
#else
void _VS6rule_481(_currn )
_TPPrule_481 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ((* _IG_incl34), ASSIGN)))) {
message(ERROR, "Fortran 90 array syntax is not supported within an ACC$REGION.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8417)*/
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
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
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const51=ZERO();
/*SPC(8413)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATvariableName_RuleAttr_938=PTGSequence(PTGAsIs("ii_"), PTGNumber(_currn->_desc2->_ATLocalIndex_post));
/*SPC(8422)*/
_currn->_ATF90Syntax=TRUE;
/*SPC(8419)*/
_currn->_ATPtg=PTGCommaArgs(_currn->_desc1->_ATPtg, _currn->_ATvariableName_RuleAttr_938);
/*SPC(8423)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_481(_TPPrule_481 _currn)
#else
void _VS7rule_481(_currn )
_TPPrule_481 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (AND(EQ(_currn->_ATUpdateStmt_pre, TRUE), EQ((* _IG_incl34), ASSIGN))) {
PTGOut(PTGSequence(PTGAppend(PTGNumber(SUB(MapLine(((_currn->_AT_pos).line)), 1)), PTGGenerateForLoop(PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATvariableName_RuleAttr_938, _currn->_desc2->_ATPtg, _currn->_ATvariableName_RuleAttr_938, GetArrayBounds(_currn->_ATArrayId_pre, _currn->_ATLocalIndex_pre, UBOUND), _currn->_ATvariableName_RuleAttr_938)), PTGAppend(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGGenerateEndLoop(PTGIndent(_currn->_ATIndentLevel_pre)))));

} else {
}
;

} else {
}
;
/*SPC(8442)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATValue;
/*SPC(8421)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_481(_TPPrule_481 _currn)
#else
void _VS8rule_481(_currn )
_TPPrule_481 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const19=IDENTICAL(_currn->_desc2->_ATConstantUsed);
/*SPC(8413)*/
_currn->_AT_const63=_currn->_desc2->_AT_const63;
/*SPC(8413)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(8413)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(8413)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(8413)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_482(_TPPrule_482 _currn)
#else
void _VS1rule_482(_currn )
_TPPrule_482 _currn;

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
void _VS2rule_482(_TPPrule_482 _currn)
#else
void _VS2rule_482(_currn )
_TPPrule_482 _currn;

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
void _VS3rule_482(_TPPrule_482 _currn)
#else
void _VS3rule_482(_currn )
_TPPrule_482 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_482(_TPPrule_482 _currn)
#else
void _VS4rule_482(_currn )
_TPPrule_482 _currn;

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
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_482(_TPPrule_482 _currn)
#else
void _VS5rule_482(_currn )
_TPPrule_482 _currn;

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
/*SPC(8845)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATLocalIndex_post=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_482(_TPPrule_482 _currn)
#else
void _VS6rule_482(_currn )
_TPPrule_482 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ((* _IG_incl34), ASSIGN)))) {
message(ERROR, "Fortran 90 array syntax is not supported within an ACC$REGION.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8381)*/
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
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
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
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
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const51=ZERO();
/*SPC(8377)*/
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
_currn->_ATDeclsOrder_post=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATvariableName_RuleAttr_939=PTGSequence(PTGAsIs("ii_"), PTGNumber(_currn->_desc2->_ATLocalIndex_post));
/*SPC(8386)*/
_currn->_ATF90Syntax=TRUE;
/*SPC(8383)*/
_currn->_ATPtg=PTGCommaArgs(_currn->_desc1->_ATPtg, _currn->_ATvariableName_RuleAttr_939);
/*SPC(8387)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_482(_TPPrule_482 _currn)
#else
void _VS7rule_482(_currn )
_TPPrule_482 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (AND(EQ(_currn->_ATUpdateStmt_pre, TRUE), EQ((* _IG_incl34), ASSIGN))) {
PTGOut(PTGSequence(PTGAppend(PTGNumber(SUB(MapLine(((_currn->_AT_pos).line)), 1)), PTGGenerateForLoop(PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATvariableName_RuleAttr_939, _currn->_desc2->_ATPtg, _currn->_ATvariableName_RuleAttr_939, _currn->_desc3->_ATPtg, _currn->_ATvariableName_RuleAttr_939)), PTGAppend(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGGenerateEndLoop(PTGIndent(_currn->_ATIndentLevel_pre)))));

} else {
}
;

} else {
}
;
/*SPC(8406)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATValue;
/*SPC(8385)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_482(_TPPrule_482 _currn)
#else
void _VS8rule_482(_currn )
_TPPrule_482 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const19=ADD(IDENTICAL(_currn->_desc2->_ATConstantUsed), IDENTICAL(_currn->_desc3->_ATConstantUsed));
/*SPC(8377)*/
_currn->_AT_const63=ADD(_currn->_desc2->_AT_const63, _currn->_desc3->_AT_const63);
/*SPC(8377)*/
_currn->_AT_const64=ADD(ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64), _currn->_desc3->_AT_const64);
/*SPC(8377)*/
_currn->_AT_const65=ADD(ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65), _currn->_desc3->_AT_const65);
/*SPC(8377)*/
_currn->_AT_const66=ADD(ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66), _currn->_desc3->_AT_const66);
/*SPC(8377)*/
_currn->_ATDepth_post=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_483(_TPPrule_483 _currn)
#else
void _VS1rule_483(_currn )
_TPPrule_483 _currn;

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
void _VS2rule_483(_TPPrule_483 _currn)
#else
void _VS2rule_483(_currn )
_TPPrule_483 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_483(_TPPrule_483 _currn)
#else
void _VS3rule_483(_currn )
_TPPrule_483 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_483(_TPPrule_483 _currn)
#else
void _VS4rule_483(_currn )
_TPPrule_483 _currn;

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
void _VS5rule_483(_TPPrule_483 _currn)
#else
void _VS5rule_483(_currn )
_TPPrule_483 _currn;

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
void _VS6rule_483(_TPPrule_483 _currn)
#else
void _VS6rule_483(_currn )
_TPPrule_483 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ((* _IG_incl34), ASSIGN)))) {
message(ERROR, "Fortran 90 array syntax is not supported within an ACC$REGION.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8345)*/
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const51=ZERO();
/*SPC(8341)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATvariableName_RuleAttr_940=PTGSequence(PTGAsIs("ii_"), PTGNumber(ADD(_currn->_desc1->_ATLocalIndex_post, 1)));
/*SPC(8350)*/
_currn->_ATF90Syntax=TRUE;
/*SPC(8347)*/
_currn->_ATPtg=PTGCommaArgs(_currn->_desc1->_ATPtg, _currn->_ATvariableName_RuleAttr_940);
/*SPC(8351)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_483(_TPPrule_483 _currn)
#else
void _VS7rule_483(_currn )
_TPPrule_483 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (AND(EQ(_currn->_ATUpdateStmt_pre, TRUE), EQ((* _IG_incl34), ASSIGN))) {
PTGOut(PTGSequence(PTGAppend(PTGNumber(SUB(MapLine(((_currn->_AT_pos).line)), 1)), PTGGenerateForLoop(PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATvariableName_RuleAttr_940, GetArrayBounds(_currn->_ATArrayId_pre, _currn->_ATLocalIndex_pre, LBOUND), _currn->_ATvariableName_RuleAttr_940, GetArrayBounds(_currn->_ATArrayId_pre, _currn->_ATLocalIndex_pre, UBOUND), _currn->_ATvariableName_RuleAttr_940)), PTGAppend(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGGenerateEndLoop(PTGIndent(_currn->_ATIndentLevel_pre)))));

} else {
}
;

} else {
}
;
/*SPC(8370)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=TRUE;
/*SPC(8349)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_483(_TPPrule_483 _currn)
#else
void _VS8rule_483(_currn )
_TPPrule_483 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const19=ZERO();
/*SPC(8341)*/
_currn->_AT_const63=ZERO();
/*SPC(8341)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(8341)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(8341)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(8341)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_484(_TPPrule_484 _currn)
#else
void _VS1rule_484(_currn )
_TPPrule_484 _currn;

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
void _VS2rule_484(_TPPrule_484 _currn)
#else
void _VS2rule_484(_currn )
_TPPrule_484 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_484(_TPPrule_484 _currn)
#else
void _VS3rule_484(_currn )
_TPPrule_484 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_484(_TPPrule_484 _currn)
#else
void _VS4rule_484(_currn )
_TPPrule_484 _currn;

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
void _VS5rule_484(_TPPrule_484 _currn)
#else
void _VS5rule_484(_currn )
_TPPrule_484 _currn;

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
void _VS6rule_484(_TPPrule_484 _currn)
#else
void _VS6rule_484(_currn )
_TPPrule_484 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ((* _IG_incl34), ASSIGN)))) {
message(ERROR, "Fortran 90 array syntax is not supported within an ACC$REGION.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8311)*/
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
_currn->_AT_const51=ZERO();
/*SPC(8307)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATvariableName_RuleAttr_941=PTGSequence(PTGAsIs("ii_"), PTGNumber(_currn->_ATLocalIndex_pre));
/*SPC(8316)*/
_currn->_ATF90Syntax=TRUE;
/*SPC(8313)*/
_currn->_ATPtg=_currn->_ATvariableName_RuleAttr_941;
/*SPC(8317)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_484(_TPPrule_484 _currn)
#else
void _VS7rule_484(_currn )
_TPPrule_484 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (EQ(_currn->_ATUpdateStmt_pre, TRUE)) {
PTGOut(PTGSequence(PTGAppend(PTGNumber(SUB(MapLine(((_currn->_AT_pos).line)), 1)), PTGGenerateForLoop(PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATvariableName_RuleAttr_941, _currn->_desc1->_ATPtg, _currn->_ATvariableName_RuleAttr_941, GetArrayBounds(_currn->_ATArrayId_pre, _currn->_ATLocalIndex_pre, UBOUND), _currn->_ATvariableName_RuleAttr_941)), PTGAppend(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGGenerateEndLoop(PTGIndent(_currn->_ATIndentLevel_pre)))));

} else {
}
;

} else {
}
;
/*SPC(8335)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATValue;
/*SPC(8314)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_484(_TPPrule_484 _currn)
#else
void _VS8rule_484(_currn )
_TPPrule_484 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const19=IDENTICAL(_currn->_desc1->_ATConstantUsed);
/*SPC(8307)*/
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(8307)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(8307)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(8307)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(8307)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_485(_TPPrule_485 _currn)
#else
void _VS1rule_485(_currn )
_TPPrule_485 _currn;

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
void _VS2rule_485(_TPPrule_485 _currn)
#else
void _VS2rule_485(_currn )
_TPPrule_485 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_485(_TPPrule_485 _currn)
#else
void _VS3rule_485(_currn )
_TPPrule_485 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_485(_TPPrule_485 _currn)
#else
void _VS4rule_485(_currn )
_TPPrule_485 _currn;

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
void _VS5rule_485(_TPPrule_485 _currn)
#else
void _VS5rule_485(_currn )
_TPPrule_485 _currn;

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
void _VS6rule_485(_TPPrule_485 _currn)
#else
void _VS6rule_485(_currn )
_TPPrule_485 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ((* _IG_incl34), ASSIGN)))) {
message(ERROR, "Fortran 90 array syntax is not supported within an ACC$REGION.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8278)*/
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
_currn->_AT_const51=ZERO();
/*SPC(8274)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATvariableName_RuleAttr_942=PTGSequence(PTGAsIs("ii_"), PTGNumber(_currn->_ATLocalIndex_pre));
/*SPC(8283)*/
_currn->_ATF90Syntax=TRUE;
/*SPC(8280)*/
_currn->_ATPtg=_currn->_ATvariableName_RuleAttr_942;
/*SPC(8284)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_485(_TPPrule_485 _currn)
#else
void _VS7rule_485(_currn )
_TPPrule_485 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (EQ(_currn->_ATUpdateStmt_pre, TRUE)) {
PTGOut(PTGSequence(PTGAppend(PTGNumber(SUB(MapLine(((_currn->_AT_pos).line)), 1)), PTGGenerateForLoop(PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATvariableName_RuleAttr_942, GetArrayBounds(_currn->_ATArrayId_pre, _currn->_ATLocalIndex_pre, LBOUND), _currn->_ATvariableName_RuleAttr_942, _currn->_desc1->_ATPtg, _currn->_ATvariableName_RuleAttr_942)), PTGAppend(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGGenerateEndLoop(PTGIndent(_currn->_ATIndentLevel_pre)))));

} else {
}
;

} else {
}
;
/*SPC(8302)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATValue;
/*SPC(8281)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_485(_TPPrule_485 _currn)
#else
void _VS8rule_485(_currn )
_TPPrule_485 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const19=IDENTICAL(_currn->_desc1->_ATConstantUsed);
/*SPC(8274)*/
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(8274)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(8274)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(8274)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(8274)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_486(_TPPrule_486 _currn)
#else
void _VS1rule_486(_currn )
_TPPrule_486 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_486(_TPPrule_486 _currn)
#else
void _VS4rule_486(_currn )
_TPPrule_486 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_486(_TPPrule_486 _currn)
#else
void _VS5rule_486(_currn )
_TPPrule_486 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_486(_TPPrule_486 _currn)
#else
void _VS6rule_486(_currn )
_TPPrule_486 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ((* _IG_incl34), ASSIGN)))) {
message(ERROR, "Fortran 90 array syntax is not supported within an ACC$REGION.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8243)*/
_currn->_AT_const51=ZERO();
/*SPC(8239)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATvariableName_RuleAttr_943=PTGSequence(PTGAsIs("ii_"), PTGNumber(_currn->_ATLocalIndex_pre));
/*SPC(8247)*/
_currn->_ATF90Syntax=TRUE;
/*SPC(8245)*/
_currn->_ATPtg=_currn->_ATvariableName_RuleAttr_943;
/*SPC(8248)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_486(_TPPrule_486 _currn)
#else
void _VS7rule_486(_currn )
_TPPrule_486 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (EQ(_currn->_ATUpdateStmt_pre, TRUE)) {
PTGOut(PTGSequence(PTGAppend(PTGNumber(SUB(MapLine(((_currn->_AT_pos).line)), 1)), PTGGenerateForLoop(PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATvariableName_RuleAttr_943, GetArrayBounds(_currn->_ATArrayId_pre, _currn->_ATLocalIndex_pre, LBOUND), _currn->_ATvariableName_RuleAttr_943, GetArrayBounds(_currn->_ATArrayId_pre, _currn->_ATLocalIndex_pre, UBOUND), _currn->_ATvariableName_RuleAttr_943)), PTGAppend(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGGenerateEndLoop(PTGIndent(_currn->_ATIndentLevel_pre)))));

} else {
}
;

} else {
}
;
/*SPC(8268)*/
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_486(_TPPrule_486 _currn)
#else
void _VS8rule_486(_currn )
_TPPrule_486 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const19=ZERO();
/*SPC(8239)*/
_currn->_AT_const63=ZERO();
/*SPC(8239)*/
_currn->_AT_const64=ZERO();
/*SPC(8239)*/
_currn->_AT_const65=ZERO();
/*SPC(8239)*/
_currn->_AT_const66=ZERO();
/*SPC(8239)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_487(_TPPrule_487 _currn)
#else
void _VS1rule_487(_currn )
_TPPrule_487 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_487(_TPPrule_487 _currn)
#else
void _VS4rule_487(_currn )
_TPPrule_487 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_487(_TPPrule_487 _currn)
#else
void _VS5rule_487(_currn )
_TPPrule_487 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_487(_TPPrule_487 _currn)
#else
void _VS6rule_487(_currn )
_TPPrule_487 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATSizeValue=0;
/*SPC(4025)*/
_currn->_ATUpperValue=0;
/*SPC(4027)*/
_currn->_ATLowerValue=0;
/*SPC(4026)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_487(_TPPrule_487 _currn)
#else
void _VS7rule_487(_currn )
_TPPrule_487 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ((* _IG_incl34), ASSIGN)))) {
message(ERROR, "Fortran 90 array syntax is not supported within an ACC$REGION.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8208)*/
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
void _VS8rule_487(_TPPrule_487 _currn)
#else
void _VS8rule_487(_currn )
_TPPrule_487 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const33=ZERO();
/*SPC(8204)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATvariableName_RuleAttr_944=PTGSequence(PTGAsIs("ii_"), PTGNumber(_currn->_ATLocalIndex_pre));
/*SPC(8212)*/
_currn->_ATPtg=_currn->_ATvariableName_RuleAttr_944;
/*SPC(8213)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_487(_TPPrule_487 _currn)
#else
void _VS9rule_487(_currn )
_TPPrule_487 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const18=ZERO();
/*SPC(8204)*/
_currn->_AT_const32=ZERO();
/*SPC(8204)*/
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
_currn->_ATF90Syntax=TRUE;
/*SPC(8210)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_487(_TPPrule_487 _currn)
#else
void _VS10rule_487(_currn )
_TPPrule_487 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (EQ(_currn->_ATUpdateStmt_pre, TRUE)) {
PTGOut(PTGSequence(PTGAppend(PTGNumber(SUB(MapLine(((_currn->_AT_pos).line)), 1)), PTGGenerateForLoop(PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATvariableName_RuleAttr_944, GetArrayBounds(_currn->_ATArrayId_pre, _currn->_ATLocalIndex_pre, LBOUND), _currn->_ATvariableName_RuleAttr_944, GetArrayBounds(_currn->_ATArrayId_pre, _currn->_ATLocalIndex_pre, UBOUND), _currn->_ATvariableName_RuleAttr_944)), PTGAppend(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGGenerateEndLoop(PTGIndent(_currn->_ATIndentLevel_pre)))));

} else {
}
;

} else {
}
;
/*SPC(8233)*/
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_487(_TPPrule_487 _currn)
#else
void _VS11rule_487(_currn )
_TPPrule_487 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const19=ZERO();
/*SPC(8204)*/
_currn->_AT_const34=ZERO();
/*SPC(8204)*/
_currn->_AT_const50=ZERO();
/*SPC(8204)*/
_currn->_AT_const63=ZERO();
/*SPC(8204)*/
_currn->_AT_const64=ZERO();
/*SPC(8204)*/
_currn->_AT_const65=ZERO();
/*SPC(8204)*/
_currn->_AT_const66=ZERO();
/*SPC(8204)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATLowerObject=NoKey;
/*SPC(4029)*/
_currn->_ATUpperObject=NoKey;
/*SPC(4028)*/
_currn->_ATUpperPtg=PTGNULL;
/*SPC(4024)*/
_currn->_ATLowerPtg=PTGNULL;
/*SPC(4023)*/
_currn->_ATSizePtg=PTGNULL;
/*SPC(4022)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_488(_TPPrule_488 _currn)
#else
void _VS1rule_488(_currn )
_TPPrule_488 _currn;

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
void _VS2rule_488(_TPPrule_488 _currn)
#else
void _VS2rule_488(_currn )
_TPPrule_488 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_488(_TPPrule_488 _currn)
#else
void _VS3rule_488(_currn )
_TPPrule_488 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_488(_TPPrule_488 _currn)
#else
void _VS4rule_488(_currn )
_TPPrule_488 _currn;

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
void _VS5rule_488(_TPPrule_488 _currn)
#else
void _VS5rule_488(_currn )
_TPPrule_488 _currn;

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
void _VS6rule_488(_TPPrule_488 _currn)
#else
void _VS6rule_488(_currn )
_TPPrule_488 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(GT(MapLine(_currn->_AT_line), _currn->_ATLastNonExecLine_pre), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ((* _IG_incl34), ASSIGN)))) {
message(ERROR, "Fortran 90 array syntax is not supported within an ACC$REGION.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(8116)*/
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
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_AT_const51=ZERO();
/*SPC(8112)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATvariableName_RuleAttr_945=PTGSequence(PTGAsIs("ii_"), PTGNumber(_currn->_ATLocalIndex_pre));
/*SPC(8122)*/
_currn->_ATF90Syntax=TRUE;
/*SPC(8119)*/
_currn->_ATPtg=_currn->_ATvariableName_RuleAttr_945;
/*SPC(8123)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_488(_TPPrule_488 _currn)
#else
void _VS7rule_488(_currn )
_TPPrule_488 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (EQ(_currn->_ATUpdateStmt_pre, TRUE)) {
PTGOut(PTGSequence(PTGAppend(PTGNumber(SUB(MapLine(((_currn->_AT_pos).line)), 1)), PTGGenerateForLoop(PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATvariableName_RuleAttr_945, _currn->_desc1->_ATPtg, _currn->_ATvariableName_RuleAttr_945, _currn->_desc2->_ATPtg, _currn->_ATvariableName_RuleAttr_945)), PTGAppend(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGGenerateEndLoop(PTGIndent(_currn->_ATIndentLevel_pre)))));

} else {
}
;

} else {
}
;
/*SPC(8141)*/
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
/*SPC(8120)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_488(_TPPrule_488 _currn)
#else
void _VS8rule_488(_currn )
_TPPrule_488 _currn;

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
/*SPC(8112)*/
_currn->_AT_const63=ADD(_currn->_desc1->_AT_const63, _currn->_desc2->_AT_const63);
/*SPC(8112)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(8112)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(8112)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(8112)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_489(_TPPrule_489 _currn)
#else
void _VS1rule_489(_currn )
_TPPrule_489 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

if ((* _IG_incl35)) {
InsertKindSet(_currn->_desc2->_ATUnitKey, Variable);

} else {
}
;
/*SPC(3275)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_489(_TPPrule_489 _currn)
#else
void _VS2rule_489(_currn )
_TPPrule_489 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_489(_TPPrule_489 _currn)
#else
void _VS3rule_489(_currn )
_TPPrule_489 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_489(_TPPrule_489 _currn)
#else
void _VS4rule_489(_currn )
_TPPrule_489 _currn;

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
void _VS5rule_489(_TPPrule_489 _currn)
#else
void _VS5rule_489(_currn )
_TPPrule_489 _currn;

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
/*SPC(8821)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_489(_TPPrule_489 _currn)
#else
void _VS6rule_489(_currn )
_TPPrule_489 _currn;

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
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
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
_currn->_desc2->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc2->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc2->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_ATPtg=
((OR(EQ(GetClpValue(Generate, CUDA), C), AND(EQ(_currn->_desc2->_ATDemoted, FALSE), EQ(_currn->_desc1->_ATDemoted, FALSE)))
) ? (PTGCommaArgs(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)
) : (
((EQ(_currn->_desc2->_ATDemoted, FALSE)
) ? (_currn->_desc2->_ATPtg
) : (_currn->_desc1->_ATPtg))
))
;
/*SPC(7905)*/
_currn->_ATDemoted=_currn->_desc2->_ATDemoted;
/*SPC(7860)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_489(_TPPrule_489 _currn)
#else
void _VS7rule_489(_currn )
_TPPrule_489 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, IDENTICAL(_currn->_desc2->_ATPar1));
/*SPC(7859)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, IDENTICAL(_currn->_desc2->_ATPar2));
/*SPC(7859)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, IDENTICAL(_currn->_desc2->_ATPar3));
/*SPC(7859)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_490(_TPPrule_490 _currn)
#else
void _VS1rule_490(_currn )
_TPPrule_490 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

if ((* _IG_incl35)) {
InsertKindSet(_currn->_desc1->_ATUnitKey, Variable);

} else {
}
;
/*SPC(3275)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_490(_TPPrule_490 _currn)
#else
void _VS2rule_490(_currn )
_TPPrule_490 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_490(_TPPrule_490 _currn)
#else
void _VS3rule_490(_currn )
_TPPrule_490 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_490(_TPPrule_490 _currn)
#else
void _VS4rule_490(_currn )
_TPPrule_490 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_490(_TPPrule_490 _currn)
#else
void _VS5rule_490(_currn )
_TPPrule_490 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_490(_TPPrule_490 _currn)
#else
void _VS6rule_490(_currn )
_TPPrule_490 _currn;

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
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_ATPtg=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(_currn->_desc1->_ATMatch, FALSE), AND(EQ(GetVariableSharedGPU(_currn->_ATArrayId_pre, 0), SHARED), AND(EQ(_currn->_ATLocalIndex_pre, 1), GE(GetRegionVarProperty(_currn->_ATRegionVars_pre, BLOCKFACTOR, _currn->_ATLocalIndex_pre), TRUE)))))
) ? (ConstructLoopIndex(_currn->_desc1->_ATPtg, PTGNULL, SHARED, _currn->_desc1->_ATRegionVars_post, _currn->_ATLocalIndex_pre, FALSE)
) : (_currn->_desc1->_ATPtg))
;
/*SPC(8560)*/
_currn->_ATDemoted=_currn->_desc1->_ATDemoted;
/*SPC(7857)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_490(_TPPrule_490 _currn)
#else
void _VS7rule_490(_currn )
_TPPrule_490 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const64=IDENTICAL(_currn->_desc1->_ATPar1);
/*SPC(7856)*/
_currn->_AT_const65=IDENTICAL(_currn->_desc1->_ATPar2);
/*SPC(7856)*/
_currn->_AT_const66=IDENTICAL(_currn->_desc1->_ATPar3);
/*SPC(7856)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_491(_TPPrule_491 _currn)
#else
void _VS1rule_491(_currn )
_TPPrule_491 _currn;

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
void _VS2rule_491(_TPPrule_491 _currn)
#else
void _VS2rule_491(_currn )
_TPPrule_491 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_491(_TPPrule_491 _currn)
#else
void _VS3rule_491(_currn )
_TPPrule_491 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_491(_TPPrule_491 _currn)
#else
void _VS4rule_491(_currn )
_TPPrule_491 _currn;

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
void _VS5rule_491(_TPPrule_491 _currn)
#else
void _VS5rule_491(_currn )
_TPPrule_491 _currn;

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
/*SPC(8837)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_491(_TPPrule_491 _currn)
#else
void _VS6rule_491(_currn )
_TPPrule_491 _currn;

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
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
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
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const51=ZERO();
/*SPC(7839)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATF90Syntax=FALSE;
/*SPC(8104)*/
_currn->_ATPtg=
((OR(EQ(GetClpValue(Generate, CUDA), C), AND(EQ(_currn->_desc2->_ATDemoted, FALSE), EQ(_currn->_desc1->_ATDemoted, FALSE)))
) ? (PTGCommaArgs(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)
) : (
((EQ(_currn->_desc2->_ATDemoted, FALSE)
) ? (_currn->_desc2->_ATPtg
) : (_currn->_desc1->_ATPtg))
))
;
/*SPC(7892)*/
_currn->_ATDemoted=_currn->_desc2->_ATDemoted;
/*SPC(7840)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_491(_TPPrule_491 _currn)
#else
void _VS7rule_491(_currn )
_TPPrule_491 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_491(_TPPrule_491 _currn)
#else
void _VS8rule_491(_currn )
_TPPrule_491 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const19=IDENTICAL(_currn->_desc2->_ATConstantUsed);
/*SPC(7839)*/
_currn->_AT_const63=_currn->_desc2->_AT_const63;
/*SPC(7839)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(7839)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(7839)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(7839)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_492(_TPPrule_492 _currn)
#else
void _VS1rule_492(_currn )
_TPPrule_492 _currn;

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
void _VS2rule_492(_TPPrule_492 _currn)
#else
void _VS2rule_492(_currn )
_TPPrule_492 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_492(_TPPrule_492 _currn)
#else
void _VS3rule_492(_currn )
_TPPrule_492 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_492(_TPPrule_492 _currn)
#else
void _VS4rule_492(_currn )
_TPPrule_492 _currn;

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
void _VS5rule_492(_TPPrule_492 _currn)
#else
void _VS5rule_492(_currn )
_TPPrule_492 _currn;

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
/*SPC(8869)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_492(_TPPrule_492 _currn)
#else
void _VS6rule_492(_currn )
_TPPrule_492 _currn;

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
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_AT_const51=ADD(ADD(_currn->_desc1->_AT_const51, IDENTICAL(_currn->_desc1->_ATF90Syntax)), _currn->_desc2->_AT_const51);
/*SPC(7835)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATF90Syntax=FALSE;
/*SPC(8104)*/
_currn->_ATPtg=
((OR(EQ(GetClpValue(Generate, CUDA), C), AND(EQ(_currn->_desc2->_ATDemoted, FALSE), EQ(_currn->_desc1->_ATDemoted, FALSE)))
) ? (PTGCommaArgs(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)
) : (
((EQ(_currn->_desc2->_ATDemoted, FALSE)
) ? (_currn->_desc2->_ATPtg
) : (_currn->_desc1->_ATPtg))
))
;
/*SPC(7879)*/
_currn->_ATDemoted=_currn->_desc2->_ATDemoted;
/*SPC(7836)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_492(_TPPrule_492 _currn)
#else
void _VS7rule_492(_currn )
_TPPrule_492 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS8rule_492(_TPPrule_492 _currn)
#else
void _VS8rule_492(_currn )
_TPPrule_492 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const19=ADD(_currn->_desc1->_AT_const19, _currn->_desc2->_AT_const19);
/*SPC(7835)*/
_currn->_AT_const63=ADD(ADD(_currn->_desc1->_AT_const63, IDENTICAL(_currn->_desc1->_ATF90Syntax)), _currn->_desc2->_AT_const63);
/*SPC(7835)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(7835)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(7835)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(7835)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_493(_TPPrule_493 _currn)
#else
void _VS1rule_493(_currn )
_TPPrule_493 _currn;

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
void _VS2rule_493(_TPPrule_493 _currn)
#else
void _VS2rule_493(_currn )
_TPPrule_493 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_493(_TPPrule_493 _currn)
#else
void _VS3rule_493(_currn )
_TPPrule_493 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_493(_TPPrule_493 _currn)
#else
void _VS4rule_493(_currn )
_TPPrule_493 _currn;

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
void _VS5rule_493(_TPPrule_493 _currn)
#else
void _VS5rule_493(_currn )
_TPPrule_493 _currn;

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
/*SPC(8829)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_493(_TPPrule_493 _currn)
#else
void _VS6rule_493(_currn )
_TPPrule_493 _currn;

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
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
printf("line: %d xExprList3: %d %d\n", MapLine(_currn->_AT_line), _currn->_desc1->_ATDemoted, _currn->_desc2->_ATDemoted);
/*SPC(7865)*/
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
_currn->_AT_const51=ADD(_currn->_desc1->_AT_const51, IDENTICAL(_currn->_desc1->_ATF90Syntax));
/*SPC(7831)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATF90Syntax=FALSE;
/*SPC(8104)*/
_currn->_ATPtg=
((OR(EQ(GetClpValue(Generate, CUDA), C), AND(EQ(_currn->_desc2->_ATDemoted, FALSE), EQ(_currn->_desc1->_ATDemoted, FALSE)))
) ? (PTGCommaArgs(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg)
) : (
((EQ(_currn->_desc2->_ATDemoted, FALSE)
) ? (_currn->_desc2->_ATPtg
) : (_currn->_desc1->_ATPtg))
))
;
/*SPC(7866)*/
_currn->_ATDemoted=_currn->_desc2->_ATDemoted;
/*SPC(7832)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_493(_TPPrule_493 _currn)
#else
void _VS7rule_493(_currn )
_TPPrule_493 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_493(_TPPrule_493 _currn)
#else
void _VS8rule_493(_currn )
_TPPrule_493 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const19=ADD(_currn->_desc1->_AT_const19, IDENTICAL(_currn->_desc2->_ATConstantUsed));
/*SPC(7831)*/
_currn->_AT_const63=ADD(ADD(_currn->_desc1->_AT_const63, IDENTICAL(_currn->_desc1->_ATF90Syntax)), _currn->_desc2->_AT_const63);
/*SPC(7831)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(7831)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(7831)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(7831)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_494(_TPPrule_494 _currn)
#else
void _VS1rule_494(_currn )
_TPPrule_494 _currn;

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
void _VS2rule_494(_TPPrule_494 _currn)
#else
void _VS2rule_494(_currn )
_TPPrule_494 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_494(_TPPrule_494 _currn)
#else
void _VS3rule_494(_currn )
_TPPrule_494 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_494(_TPPrule_494 _currn)
#else
void _VS4rule_494(_currn )
_TPPrule_494 _currn;

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
void _VS5rule_494(_TPPrule_494 _currn)
#else
void _VS5rule_494(_currn )
_TPPrule_494 _currn;

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
void _VS6rule_494(_TPPrule_494 _currn)
#else
void _VS6rule_494(_currn )
_TPPrule_494 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_AT_const51=ZERO();
/*SPC(7827)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATF90Syntax=FALSE;
/*SPC(8104)*/
_currn->_ATPtg=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(_currn->_desc1->_AT_const18, FALSE), AND(EQ(GetVariableSharedGPU(_currn->_ATArrayId_pre, 0), SHARED), AND(EQ(_currn->_ATLocalIndex_pre, 1), GE(GetRegionVarProperty(_currn->_ATRegionVars_pre, BLOCKFACTOR, _currn->_ATLocalIndex_pre), TRUE)))))
) ? (ConstructLoopIndex(_currn->_desc1->_ATPtg, PTGNULL, SHARED, _currn->_desc1->_ATRegionVars_post, _currn->_ATLocalIndex_pre, FALSE)
) : (_currn->_desc1->_ATPtg))
;
/*SPC(8090)*/
_currn->_ATDemoted=_currn->_desc1->_ATDemoted;
/*SPC(7828)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_494(_TPPrule_494 _currn)
#else
void _VS7rule_494(_currn )
_TPPrule_494 _currn;

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
void _VS8rule_494(_TPPrule_494 _currn)
#else
void _VS8rule_494(_currn )
_TPPrule_494 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const19=IDENTICAL(_currn->_desc1->_ATConstantUsed);
/*SPC(7827)*/
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(7827)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(7827)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(7827)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(7827)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_495(_TPPrule_495 _currn)
#else
void _VS1rule_495(_currn )
_TPPrule_495 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_495(_TPPrule_495 _currn)
#else
void _VS2rule_495(_currn )
_TPPrule_495 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_495(_TPPrule_495 _currn)
#else
void _VS3rule_495(_currn )
_TPPrule_495 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_495(_TPPrule_495 _currn)
#else
void _VS4rule_495(_currn )
_TPPrule_495 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_495(_TPPrule_495 _currn)
#else
void _VS5rule_495(_currn )
_TPPrule_495 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_495(_TPPrule_495 _currn)
#else
void _VS6rule_495(_currn )
_TPPrule_495 _currn;

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
void _VS7rule_495(_TPPrule_495 _currn)
#else
void _VS7rule_495(_currn )
_TPPrule_495 _currn;

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
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
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
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_495(_TPPrule_495 _currn)
#else
void _VS8rule_495(_currn )
_TPPrule_495 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const33=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(7819)*/
_currn->_ATFunctionName=PTGNULL;
/*SPC(8976)*/
_currn->_ATDemoted=_currn->_desc1->_ATDemoted;
/*SPC(7820)*/
_currn->_ATLoopIncrNeg=
((EQ(MOD(ZERO(), 2), 1)
) ? (TRUE
) : (FALSE))
;
/*SPC(7687)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(9100)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_495(_TPPrule_495 _currn)
#else
void _VS9rule_495(_currn )
_TPPrule_495 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const18=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(7819)*/
_currn->_AT_const32=ZERO();
/*SPC(7819)*/
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
void _VS10rule_495(_TPPrule_495 _currn)
#else
void _VS10rule_495(_currn )
_TPPrule_495 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATArgType=PTGNULL;
/*SPC(5880)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_495(_TPPrule_495 _currn)
#else
void _VS11rule_495(_currn )
_TPPrule_495 _currn;

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
void _VS12rule_495(_TPPrule_495 _currn)
#else
void _VS12rule_495(_currn )
_TPPrule_495 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=ZERO();
/*SPC(7819)*/
_currn->_AT_const50=ZERO();
/*SPC(7819)*/
_currn->_AT_const63=ZERO();
/*SPC(7819)*/
_currn->_AT_const64=IDENTICAL(_currn->_desc1->_ATPar1);
/*SPC(7819)*/
_currn->_AT_const65=IDENTICAL(_currn->_desc1->_ATPar2);
/*SPC(7819)*/
_currn->_AT_const66=IDENTICAL(_currn->_desc1->_ATPar3);
/*SPC(7819)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_496(_TPPrule_496 _currn)
#else
void _VS1rule_496(_currn )
_TPPrule_496 _currn;

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
void _VS2rule_496(_TPPrule_496 _currn)
#else
void _VS2rule_496(_currn )
_TPPrule_496 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const61=ZERO();
/*SPC(7731)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_496(_TPPrule_496 _currn)
#else
void _VS3rule_496(_currn )
_TPPrule_496 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(12643)*/
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
_currn->_AT_const60=PTGNull();
/*SPC(7731)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xLoopControl construct not supported.");
/*SPC(7694)*/
_currn->_ATLoopStart=PTGNULL;
/*SPC(7733)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_496(_TPPrule_496 _currn)
#else
void _VS4rule_496(_currn )
_TPPrule_496 _currn;

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
_currn->_ATDoLoop=TRUE;
/*SPC(12641)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_496(_TPPrule_496 _currn)
#else
void _VS5rule_496(_currn )
_TPPrule_496 _currn;

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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATLoopIncr=PTGNULL;
/*SPC(7735)*/
_currn->_ATLoopStop=PTGNULL;
/*SPC(7734)*/
_currn->_ATNumArgs=1;
/*SPC(7732)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_497(_TPPrule_497 _currn)
#else
void _VS1rule_497(_currn )
_TPPrule_497 _currn;

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
void _VS2rule_497(_TPPrule_497 _currn)
#else
void _VS2rule_497(_currn )
_TPPrule_497 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const61=IDENTICAL(_currn->_desc1->_ATSym);
/*SPC(7718)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_497(_TPPrule_497 _currn)
#else
void _VS3rule_497(_currn )
_TPPrule_497 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=1;
/*SPC(12645)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=2;
/*SPC(12646)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
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
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const60=IDENTICAL(_currn->_desc1->_ATPtg);
/*SPC(7718)*/
_currn->_ATPtg=PTGLoopBounds(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg, _currn->_desc1->_ATPtg, _currn->_desc3->_ATPtg, _currn->_desc1->_ATPtg);
/*SPC(7724)*/
_currn->_ATLoopStart=_currn->_desc2->_ATPtg;
/*SPC(7720)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_497(_TPPrule_497 _currn)
#else
void _VS4rule_497(_currn )
_TPPrule_497 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=TRUE;
/*SPC(12786)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(12643)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=FALSE;
/*SPC(12787)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_ATDoLoop=TRUE;
/*SPC(12641)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_497(_TPPrule_497 _currn)
#else
void _VS5rule_497(_currn )
_TPPrule_497 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc3->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATLoopIncr=PTGAsIs("1");
/*SPC(7722)*/
_currn->_ATLoopStop=_currn->_desc3->_ATPtg;
/*SPC(7721)*/
_currn->_ATNumArgs=2;
/*SPC(7719)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_498(_TPPrule_498 _currn)
#else
void _VS1rule_498(_currn )
_TPPrule_498 _currn;

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
void _VS2rule_498(_TPPrule_498 _currn)
#else
void _VS2rule_498(_currn )
_TPPrule_498 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_AT_const61=IDENTICAL(_currn->_desc1->_ATSym);
/*SPC(7699)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_498(_TPPrule_498 _currn)
#else
void _VS3rule_498(_currn )
_TPPrule_498 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=1;
/*SPC(12649)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=2;
/*SPC(12650)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
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
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATIsArray_pre=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATLocalIndex_pre=3;
/*SPC(12651)*/
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
_currn->_AT_const60=IDENTICAL(_currn->_desc1->_ATPtg);
/*SPC(7699)*/
_currn->_ATPtg=
((EQ(_currn->_desc4->_ATLoopIncrNeg, TRUE)
) ? (PTGStrideNegLoopBounds(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg, _currn->_desc1->_ATPtg, _currn->_desc3->_ATPtg, _currn->_desc1->_ATPtg, _currn->_desc4->_ATPtg)
) : (PTGStrideLoopBounds(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg, _currn->_desc1->_ATPtg, _currn->_desc3->_ATPtg, _currn->_desc1->_ATPtg, _currn->_desc4->_ATPtg)))
;
/*SPC(7705)*/
_currn->_ATLoopStart=_currn->_desc2->_ATPtg;
/*SPC(7701)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_498(_TPPrule_498 _currn)
#else
void _VS4rule_498(_currn )
_TPPrule_498 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=TRUE;
/*SPC(12782)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATLocalIndex_pre=0;
/*SPC(12643)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdate_pre=FALSE;
/*SPC(12783)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATTypeLength_pre=_currn->_ATTypeLength_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATGPUVarsDeList_post=_currn->_desc4->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_ATDoLoop=TRUE;
/*SPC(12641)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_498(_TPPrule_498 _currn)
#else
void _VS5rule_498(_currn )
_TPPrule_498 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
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
_currn->_ATRegionVars_post=_currn->_desc4->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc4->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc4->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc4->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc4->_ATDepth_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc4->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATLoopIncr=_currn->_desc4->_ATPtg;
/*SPC(7703)*/
_currn->_ATLoopStop=_currn->_desc3->_ATPtg;
/*SPC(7702)*/
_currn->_ATNumArgs=3;
/*SPC(7700)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_499(_TPPrule_499 _currn)
#else
void _VS1rule_499(_currn )
_TPPrule_499 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATObjectId=NoKey;
/*SPC(7108)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_499(_TPPrule_499 _currn)
#else
void _VS2rule_499(_currn )
_TPPrule_499 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATBind=BindingInEnv((* _IG_incl22), _currn->_ATSym);
/*SPC(195)*/
_currn->_ATKey=KeyOf(_currn->_ATBind);
/*SPC(199)*/
_currn->_ATUnitBind=BindingInEnv((* _IG_incl23), _currn->_ATSym);
/*SPC(59)*/
_currn->_ATUnitKey=KeyOf(_currn->_ATUnitBind);
/*SPC(63)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_500(_TPPrule_500 _currn)
#else
void _VS1rule_500(_currn )
_TPPrule_500 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(7103)*/
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
void _VS2rule_500(_TPPrule_500 _currn)
#else
void _VS2rule_500(_currn )
_TPPrule_500 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_500(_TPPrule_500 _currn)
#else
void _VS3rule_500(_currn )
_TPPrule_500 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_500(_TPPrule_500 _currn)
#else
void _VS4rule_500(_currn )
_TPPrule_500 _currn;

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
void _VS5rule_500(_TPPrule_500 _currn)
#else
void _VS5rule_500(_currn )
_TPPrule_500 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATObjectId=_currn->_desc3->_ATObjectId;
/*SPC(7101)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_500(_TPPrule_500 _currn)
#else
void _VS6rule_500(_currn )
_TPPrule_500 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_500(_TPPrule_500 _currn)
#else
void _VS7rule_500(_currn )
_TPPrule_500 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_500(_TPPrule_500 _currn)
#else
void _VS8rule_500(_currn )
_TPPrule_500 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_desc3->_ATUnitScope=NoEnv;
/*SPC(969)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
void _VS9rule_500(_TPPrule_500 _currn)
#else
void _VS9rule_500(_currn )
_TPPrule_500 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc2->_ATMaxMinFunct=FALSE;
/*SPC(8890)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const33=_currn->_desc1->_AT_const33;
/*SPC(7097)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_500(_TPPrule_500 _currn)
#else
void _VS10rule_500(_currn )
_TPPrule_500 _currn;

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
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
/*SPC(7097)*/
_currn->_AT_const32=ADD(_currn->_desc1->_AT_const32, _currn->_desc2->_AT_const32);
/*SPC(7097)*/
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
void _VS11rule_500(_TPPrule_500 _currn)
#else
void _VS11rule_500(_currn )
_TPPrule_500 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS12rule_500(_TPPrule_500 _currn)
#else
void _VS12rule_500(_currn )
_TPPrule_500 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const34=ADD(_currn->_desc1->_AT_const34, _currn->_desc2->_AT_const34);
/*SPC(7097)*/
_currn->_AT_const50=ADD(_currn->_desc1->_AT_const50, _currn->_desc2->_AT_const50);
/*SPC(7097)*/
_currn->_AT_const63=ADD(_currn->_desc1->_AT_const63, _currn->_desc2->_AT_const63);
/*SPC(7097)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(7097)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(7097)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(7097)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(7099)*/
_currn->_ATTypePtg=PTGNULL;
/*SPC(7100)*/
_currn->_ATSizePtg=PTGNULL;
/*SPC(7098)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_501(_TPPrule_501 _currn)
#else
void _VS1rule_501(_currn )
_TPPrule_501 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(7093)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_501(_TPPrule_501 _currn)
#else
void _VS2rule_501(_currn )
_TPPrule_501 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_501(_TPPrule_501 _currn)
#else
void _VS3rule_501(_currn )
_TPPrule_501 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_501(_TPPrule_501 _currn)
#else
void _VS4rule_501(_currn )
_TPPrule_501 _currn;

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
void _VS5rule_501(_TPPrule_501 _currn)
#else
void _VS5rule_501(_currn )
_TPPrule_501 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATObjectId=_currn->_desc2->_ATObjectId;
/*SPC(7091)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_501(_TPPrule_501 _currn)
#else
void _VS6rule_501(_currn )
_TPPrule_501 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_501(_TPPrule_501 _currn)
#else
void _VS7rule_501(_currn )
_TPPrule_501 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_501(_TPPrule_501 _currn)
#else
void _VS8rule_501(_currn )
_TPPrule_501 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUnitScope=NoEnv;
/*SPC(969)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
void _VS9rule_501(_TPPrule_501 _currn)
#else
void _VS9rule_501(_currn )
_TPPrule_501 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const33=_currn->_desc1->_AT_const33;
/*SPC(7087)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_501(_TPPrule_501 _currn)
#else
void _VS10rule_501(_currn )
_TPPrule_501 _currn;

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
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const18=_currn->_desc1->_AT_const18;
/*SPC(7087)*/
_currn->_AT_const32=_currn->_desc1->_AT_const32;
/*SPC(7087)*/
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
void _VS11rule_501(_TPPrule_501 _currn)
#else
void _VS11rule_501(_currn )
_TPPrule_501 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
void _VS12rule_501(_TPPrule_501 _currn)
#else
void _VS12rule_501(_currn )
_TPPrule_501 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=_currn->_desc1->_AT_const34;
/*SPC(7087)*/
_currn->_AT_const50=_currn->_desc1->_AT_const50;
/*SPC(7087)*/
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(7087)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(7087)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(7087)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(7087)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(7090)*/
_currn->_ATTypePtg=PTGNULL;
/*SPC(7089)*/
_currn->_ATSizePtg=PTGNULL;
/*SPC(7088)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_502(_TPPrule_502 _currn)
#else
void _VS1rule_502(_currn )
_TPPrule_502 _currn;

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
void _VS2rule_502(_TPPrule_502 _currn)
#else
void _VS2rule_502(_currn )
_TPPrule_502 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_502(_TPPrule_502 _currn)
#else
void _VS3rule_502(_currn )
_TPPrule_502 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_502(_TPPrule_502 _currn)
#else
void _VS4rule_502(_currn )
_TPPrule_502 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_502(_TPPrule_502 _currn)
#else
void _VS5rule_502(_currn )
_TPPrule_502 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATObjectId=_currn->_desc1->_ATObjectKey;
/*SPC(7083)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_502(_TPPrule_502 _currn)
#else
void _VS6rule_502(_currn )
_TPPrule_502 _currn;

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
void _VS7rule_502(_TPPrule_502 _currn)
#else
void _VS7rule_502(_currn )
_TPPrule_502 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_502(_TPPrule_502 _currn)
#else
void _VS8rule_502(_currn )
_TPPrule_502 _currn;

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
void _VS9rule_502(_TPPrule_502 _currn)
#else
void _VS9rule_502(_currn )
_TPPrule_502 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const33=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(7072)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATObjectKey;
/*SPC(8665)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_502(_TPPrule_502 _currn)
#else
void _VS10rule_502(_currn )
_TPPrule_502 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_AT_const18=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(7072)*/
_currn->_AT_const32=ZERO();
/*SPC(7072)*/
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
void _VS11rule_502(_TPPrule_502 _currn)
#else
void _VS11rule_502(_currn )
_TPPrule_502 _currn;

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
void _VS12rule_502(_TPPrule_502 _currn)
#else
void _VS12rule_502(_currn )
_TPPrule_502 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=ZERO();
/*SPC(7072)*/
_currn->_AT_const50=ZERO();
/*SPC(7072)*/
_currn->_AT_const63=ZERO();
/*SPC(7072)*/
_currn->_AT_const64=IDENTICAL(_currn->_desc1->_ATPar1);
/*SPC(7072)*/
_currn->_AT_const65=IDENTICAL(_currn->_desc1->_ATPar2);
/*SPC(7072)*/
_currn->_AT_const66=IDENTICAL(_currn->_desc1->_ATPar3);
/*SPC(7072)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATtypeLen_RuleAttr_959=GetTypeLength(_currn->_desc1->_ATUnitKey, 0);
/*SPC(7073)*/
_currn->_ATtype_RuleAttr_959=GetType(_currn->_desc1->_ATUnitKey, ErrorType);
/*SPC(7074)*/
_currn->_ATdeclLine_RuleAttr_959=
((EQ(_currn->_ATAcceleratorRegion_pre, FALSE)
) ? ((* _IG_incl38)
) : (_currn->_ATAcceleratorRegion_pre))
;
/*SPC(7075)*/
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(7084)*/
_currn->_ATTypePtg=Convert_to_Ctype(_currn->_ATtypeLen_RuleAttr_959, _currn->_ATtype_RuleAttr_959);
/*SPC(7082)*/
_currn->_ATSizePtg=ComputeArraySize(_currn->_ATAcceleratorRegion_pre, _currn->_ATdeclLine_RuleAttr_959, _currn->_desc1->_ATUnitKey, _currn->_desc1->_ATObjectKey, (&( _currn->_AT_pos)));
/*SPC(7081)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_503(_TPPrule_503 _currn)
#else
void _VS1rule_503(_currn )
_TPPrule_503 _currn;

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
void _VS2rule_503(_TPPrule_503 _currn)
#else
void _VS2rule_503(_currn )
_TPPrule_503 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_503(_TPPrule_503 _currn)
#else
void _VS3rule_503(_currn )
_TPPrule_503 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_503(_TPPrule_503 _currn)
#else
void _VS4rule_503(_currn )
_TPPrule_503 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATObjectId=_currn->_desc1->_ATObjectId;
/*SPC(7051)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_503(_TPPrule_503 _currn)
#else
void _VS5rule_503(_currn )
_TPPrule_503 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
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
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_503(_TPPrule_503 _currn)
#else
void _VS6rule_503(_currn )
_TPPrule_503 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
void _VS7rule_503(_TPPrule_503 _currn)
#else
void _VS7rule_503(_currn )
_TPPrule_503 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATTypePtg=_currn->_desc1->_ATTypePtg;
/*SPC(7049)*/
_currn->_ATSizePtg=_currn->_desc1->_ATSizePtg;
/*SPC(7048)*/
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(7050)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_504(_TPPrule_504 _currn)
#else
void _VS1rule_504(_currn )
_TPPrule_504 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported in this context.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11188)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_504(_TPPrule_504 _currn)
#else
void _VS2rule_504(_currn )
_TPPrule_504 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_504(_TPPrule_504 _currn)
#else
void _VS3rule_504(_currn )
_TPPrule_504 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_504(_TPPrule_504 _currn)
#else
void _VS4rule_504(_currn )
_TPPrule_504 _currn;

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
void _VS5rule_504(_TPPrule_504 _currn)
#else
void _VS5rule_504(_currn )
_TPPrule_504 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=1;
/*SPC(8815)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc2->_ATMaxMinFunct=FALSE;
/*SPC(8890)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATlocal_RuleAttr_961=_currn->_ATLocalIndex_pre;
/*SPC(8814)*/
_currn->_ATLocalIndex_post=_currn->_ATlocal_RuleAttr_961;
/*SPC(8816)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_504(_TPPrule_504 _currn)
#else
void _VS6rule_504(_currn )
_TPPrule_504 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_504(_TPPrule_504 _currn)
#else
void _VS7rule_504(_currn )
_TPPrule_504 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_504(_TPPrule_504 _currn)
#else
void _VS8rule_504(_currn )
_TPPrule_504 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATPtg=PTGNULL;
/*SPC(11186)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_505(_TPPrule_505 _currn)
#else
void _VS1rule_505(_currn )
_TPPrule_505 _currn;

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
void _VS2rule_505(_TPPrule_505 _currn)
#else
void _VS2rule_505(_currn )
_TPPrule_505 _currn;

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
void _VS3rule_505(_TPPrule_505 _currn)
#else
void _VS3rule_505(_currn )
_TPPrule_505 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=TRUE;
/*SPC(8708)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_505(_TPPrule_505 _currn)
#else
void _VS4rule_505(_currn )
_TPPrule_505 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATisArray_RuleAttr_962=_currn->_ATIsArray_pre;
/*SPC(8707)*/
_currn->_ATIsArray_post=_currn->_ATisArray_RuleAttr_962;
/*SPC(8709)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_505(_TPPrule_505 _currn)
#else
void _VS5rule_505(_currn )
_TPPrule_505 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=1;
/*SPC(8797)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATLocalIndex_pre=0;
/*SPC(8798)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATLocalIndex_post=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_505(_TPPrule_505 _currn)
#else
void _VS6rule_505(_currn )
_TPPrule_505 _currn;

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
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
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
void _VS7rule_505(_TPPrule_505 _currn)
#else
void _VS7rule_505(_currn )
_TPPrule_505 _currn;

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
_currn->_desc2->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATSym;
/*SPC(8712)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
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
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATarraySym_RuleAttr_962=_currn->_ATArraySym_pre;
/*SPC(8711)*/
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
_currn->_ATArraySym_post=_currn->_ATarraySym_RuleAttr_962;
/*SPC(8713)*/
_currn->_ATDeclsOrder_post=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_505(_TPPrule_505 _currn)
#else
void _VS8rule_505(_currn )
_TPPrule_505 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATArrayId_pre=_currn->_desc1->_ATObjectKey;
/*SPC(8704)*/
_currn->_desc2->_ATMaxMinFunct=FALSE;
/*SPC(8890)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const33=ADD(IDENTICAL(_currn->_desc1->_ATMatch), _currn->_desc3->_AT_const33);
/*SPC(7034)*/
_currn->_ATarrayId_RuleAttr_962=_currn->_ATArrayId_pre;
/*SPC(8703)*/
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
_currn->_ATArrayId_post=_currn->_ATarrayId_RuleAttr_962;
/*SPC(8705)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xExpr not supported.");
/*SPC(8958)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_505(_TPPrule_505 _currn)
#else
void _VS9rule_505(_currn )
_TPPrule_505 _currn;

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
/*SPC(7035)*/
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
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const18=ADD(ADD(IDENTICAL(_currn->_desc1->_ATMatch), _currn->_desc2->_AT_const18), _currn->_desc3->_AT_const18);
/*SPC(7034)*/
_currn->_AT_const32=ADD(_currn->_desc2->_AT_const32, _currn->_desc3->_AT_const32);
/*SPC(7034)*/
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
void _VS10rule_505(_TPPrule_505 _currn)
#else
void _VS10rule_505(_currn )
_TPPrule_505 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATArgType=PTGNULL;
/*SPC(5880)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_505(_TPPrule_505 _currn)
#else
void _VS11rule_505(_currn )
_TPPrule_505 _currn;

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
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS12rule_505(_TPPrule_505 _currn)
#else
void _VS12rule_505(_currn )
_TPPrule_505 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const34=ADD(_currn->_desc2->_AT_const34, _currn->_desc3->_AT_const34);
/*SPC(7034)*/
_currn->_AT_const50=ADD(_currn->_desc2->_AT_const50, _currn->_desc3->_AT_const50);
/*SPC(7034)*/
_currn->_AT_const63=ADD(_currn->_desc2->_AT_const63, _currn->_desc3->_AT_const63);
/*SPC(7034)*/
_currn->_AT_const64=ADD(ADD(IDENTICAL(_currn->_desc1->_ATPar1), _currn->_desc2->_AT_const64), _currn->_desc3->_AT_const64);
/*SPC(7034)*/
_currn->_AT_const65=ADD(ADD(IDENTICAL(_currn->_desc1->_ATPar2), _currn->_desc2->_AT_const65), _currn->_desc3->_AT_const65);
/*SPC(7034)*/
_currn->_AT_const66=ADD(ADD(IDENTICAL(_currn->_desc1->_ATPar3), _currn->_desc2->_AT_const66), _currn->_desc3->_AT_const66);
/*SPC(7034)*/
_currn->_ATDepth_post=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
_currn->_ATlocal_RuleAttr_962=_currn->_ATLocalIndex_pre;
/*SPC(8796)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_506(_TPPrule_506 _currn)
#else
void _VS1rule_506(_currn )
_TPPrule_506 _currn;

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
void _VS2rule_506(_TPPrule_506 _currn)
#else
void _VS2rule_506(_currn )
_TPPrule_506 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_506(_TPPrule_506 _currn)
#else
void _VS3rule_506(_currn )
_TPPrule_506 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8671)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=TRUE;
/*SPC(8670)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_506(_TPPrule_506 _currn)
#else
void _VS4rule_506(_currn )
_TPPrule_506 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=1;
/*SPC(8781)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8669)*/
_currn->_ATObjectId=_currn->_desc1->_ATObjectId;
/*SPC(7058)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_506(_TPPrule_506 _currn)
#else
void _VS5rule_506(_currn )
_TPPrule_506 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
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
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc2->_ATMaxMinFunct=FALSE;
/*SPC(8890)*/
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATlocal_RuleAttr_963=_currn->_ATLocalIndex_pre;
/*SPC(8780)*/
_currn->_ATLocalIndex_post=_currn->_ATlocal_RuleAttr_963;
/*SPC(8782)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_506(_TPPrule_506 _currn)
#else
void _VS6rule_506(_currn )
_TPPrule_506 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
void _VS7rule_506(_TPPrule_506 _currn)
#else
void _VS7rule_506(_currn )
_TPPrule_506 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATTypePtg=_currn->_desc1->_ATTypePtg;
/*SPC(7056)*/
_currn->_ATSizePtg=_currn->_desc1->_ATSizePtg;
/*SPC(7055)*/
_currn->_ATPtg=PTGArrayRef(_currn->_desc1->_ATPtg, PTGBrackets(_currn->_desc2->_ATPtg));
/*SPC(7057)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_507(_TPPrule_507 _currn)
#else
void _VS1rule_507(_currn )
_TPPrule_507 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(7067)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
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
void _VS2rule_507(_TPPrule_507 _currn)
#else
void _VS2rule_507(_currn )
_TPPrule_507 _currn;

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
void _VS3rule_507(_TPPrule_507 _currn)
#else
void _VS3rule_507(_currn )
_TPPrule_507 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATIsArray_pre=FALSE;
/*SPC(8677)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=TRUE;
/*SPC(8676)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_507(_TPPrule_507 _currn)
#else
void _VS4rule_507(_currn )
_TPPrule_507 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=1;
/*SPC(8774)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATLocalIndex_pre=0;
/*SPC(8775)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8675)*/
_currn->_ATObjectId=_currn->_desc1->_ATObjectId;
/*SPC(7065)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_507(_TPPrule_507 _currn)
#else
void _VS5rule_507(_currn )
_TPPrule_507 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
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
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc2->_ATMaxMinFunct=FALSE;
/*SPC(8890)*/
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
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
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
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATDeclsOrder_post=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=0;
/*SPC(8776)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_507(_TPPrule_507 _currn)
#else
void _VS6rule_507(_currn )
_TPPrule_507 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_507(_TPPrule_507 _currn)
#else
void _VS7rule_507(_currn )
_TPPrule_507 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATDepth_post=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
_currn->_ATTypePtg=_currn->_desc1->_ATTypePtg;
/*SPC(7063)*/
_currn->_ATSizePtg=_currn->_desc1->_ATSizePtg;
/*SPC(7062)*/
_currn->_ATPtg=PTGNULL;
/*SPC(7064)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_508(_TPPrule_508 _currn)
#else
void _VS1rule_508(_currn )
_TPPrule_508 _currn;

#endif
{
int* _IL_incl35;

_VisitVarDecl()
_VisitEntry();
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATInStmtFunc);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl35=_IL_incl35;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_508(_TPPrule_508 _currn)
#else
void _VS2rule_508(_currn )
_TPPrule_508 _currn;

#endif
{
int* _IL_incl35;
Environment* _IL_incl22;

_VisitVarDecl()
_VisitEntry();
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATInStmtFunc);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=FALSE;
/*SPC(8656)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl35=_IL_incl35;
_IG_incl22=_IL_incl22;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_508(_TPPrule_508 _currn)
#else
void _VS3rule_508(_currn )
_TPPrule_508 _currn;

#endif
{
int* _IL_incl35;
Environment* _IL_incl22;

_VisitVarDecl()
_VisitEntry();
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATInStmtFunc);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATLocalIndex_pre=1;
/*SPC(8769)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATDoAcc_pre=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12748)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=0;
/*SPC(8770)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
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
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc2->_ATMaxRank_pre=_currn->_ATMaxRank_pre;
/*SPC(0)*/
_currn->_desc2->_ATCPURegionNumber_pre=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATGPURegionNumber_pre=_currn->_desc1->_ATGPURegionNumber_post;
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
_currn->_ATLocalIndex_post=0;
/*SPC(8768)*/
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
_currn->_ATPtg=_currn->_desc2->_ATPtg;
/*SPC(8543)*/
_currn->_ATIndexPtg=_currn->_desc1->_ATPtg;
/*SPC(8542)*/
_IG_incl35=_IL_incl35;
_IG_incl22=_IL_incl22;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_508(_TPPrule_508 _currn)
#else
void _VS4rule_508(_currn )
_TPPrule_508 _currn;

#endif
{
int* _IL_incl35;
Environment* _IL_incl22;

_VisitVarDecl()
_VisitEntry();
_IL_incl35=_IG_incl35;_IG_incl35= &(_currn->_ATInStmtFunc);
_IL_incl22=_IG_incl22;_IG_incl22= &(_currn->_ATEnv);
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATUpdateStmt_pre=FALSE;
/*SPC(12749)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), GE(IDENTICAL(_currn->_desc2->_ATConstantUsed), TRUE)))) {
message(WARNING, "Constant index value will be overwritten by other executing blocks in this loop", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12861)*/
_currn->_AT_const63=_currn->_desc2->_AT_const63;
/*SPC(7022)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64);
/*SPC(7022)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65);
/*SPC(7022)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66);
/*SPC(7022)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=FALSE;
/*SPC(8655)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_IG_incl35=_IL_incl35;
_IG_incl22=_IL_incl22;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_509(_TPPrule_509 _currn)
#else
void _VS1rule_509(_currn )
_TPPrule_509 _currn;

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
/*SPC(8554)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATOrder_pre=_currn->_ATOrder_pre;
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
void _VS2rule_509(_TPPrule_509 _currn)
#else
void _VS2rule_509(_currn )
_TPPrule_509 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATIsArray_pre=
((InIS(Array, GetKindSet(_currn->_desc2->_ATUnitKey, NullIS()))
) ? (TRUE
) : (FALSE))
;
/*SPC(8644)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=1;
/*SPC(8762)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATIsArray_pre=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_desc5->_ATIsArray_pre=_currn->_desc4->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_509(_TPPrule_509 _currn)
#else
void _VS3rule_509(_currn )
_TPPrule_509 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc3->_ATLocalIndex_post;
/*SPC(8764)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc4->_ATLocalIndex_pre=0;
/*SPC(8763)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc5->_ATLocalIndex_pre=_currn->_desc4->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_509(_TPPrule_509 _currn)
#else
void _VS4rule_509(_currn )
_TPPrule_509 _currn;

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
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc4->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc5->_AT_cBoundsListPtr_pre=_currn->_desc4->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(7018)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_509(_TPPrule_509 _currn)
#else
void _VS5rule_509(_currn )
_TPPrule_509 _currn;

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
_currn->_desc2->_ATNumArgs=_currn->_desc3->_ATLocalIndex_post;
/*SPC(7019)*/
_currn->_desc2->_ATignoreVar=FALSE;
/*SPC(5129)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATSym;
/*SPC(8643)*/
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATObjectKey;
/*SPC(8642)*/
_currn->_desc3->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_desc4->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc4->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc4->_ATArraySym_pre=_currn->_desc3->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc4->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc4->_ATGPUVarsDeList_pre=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
_currn->_desc4->_ATArrayId_pre=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATStmtNumber_pre=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATUpdate_pre=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc4->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc4->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc4->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc4->_ATCPURegionNumber_pre=_currn->_desc3->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATGPURegionNumber_pre=_currn->_desc3->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc4->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
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
_currn->_ATArraySym_post=0;
/*SPC(8604)*/
_currn->_ATArrayId_post=NoKey;
/*SPC(8600)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(11193)*/
_currn->_ATRegionVars_post=_currn->_desc5->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc5->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc5->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc5->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc5->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc5->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc5->_ATDoAcc_post, ACCDO, _currn->_desc5->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc5->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc5->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc5->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc5->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc5->_ATDeclPowerVars_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc5->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc5->_ATLocalIndex_post;
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_509(_TPPrule_509 _currn)
#else
void _VS6rule_509(_currn )
_TPPrule_509 _currn;

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
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc5->_ATUpdateStmt_pre=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc5->_ATF90LoopStart_pre=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_desc5->_ATDepth_pre=_currn->_desc4->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc5->_prod])))((NODEPTR) _currn->_desc5);
_currn->_AT_const39=ZERO();
/*SPC(7018)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc5->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc5->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_509(_TPPrule_509 _currn)
#else
void _VS7rule_509(_currn )
_TPPrule_509 _currn;

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
void _VS2rule_510(_TPPrule_510 _currn)
#else
void _VS2rule_510(_currn )
_TPPrule_510 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_510(_TPPrule_510 _currn)
#else
void _VS3rule_510(_currn )
_TPPrule_510 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATTypeLen=
((EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "8"), 0)
) ? (8
) : (
((EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "4"), 0)
) ? (4
) : (
((EQ(strcmp(StringTable(_currn->_desc1->_ATSym), "2"), 0)
) ? (2
) : (0))
))
))
;
/*SPC(6936)*/
_currn->_ATSym=_currn->_desc1->_ATSym;
/*SPC(6935)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_511(_TPPrule_511 _currn)
#else
void _VS1rule_511(_currn )
_TPPrule_511 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_511(_TPPrule_511 _currn)
#else
void _VS3rule_511(_currn )
_TPPrule_511 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATSym=IdnNumb(0, _currn->_ATTERM_1);
/*SPC(6930)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_512(_TPPrule_512 _currn)
#else
void _VS1rule_512(_currn )
_TPPrule_512 _currn;

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
void _VS2rule_512(_TPPrule_512 _currn)
#else
void _VS2rule_512(_currn )
_TPPrule_512 _currn;

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
void _VS3rule_512(_TPPrule_512 _currn)
#else
void _VS3rule_512(_currn )
_TPPrule_512 _currn;

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

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_512(_TPPrule_512 _currn)
#else
void _VS4rule_512(_currn )
_TPPrule_512 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_512(_TPPrule_512 _currn)
#else
void _VS5rule_512(_currn )
_TPPrule_512 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(OR(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ(_currn->_ATTranslationType_pre, GPU)), AND(EQ(GetGPUVarProperty(_currn->_ATArraySym_pre, _currn->_ATGPUVarsDeList_pre, SCOPE, 0), SHARED), AND(EQ(GetAccDo(_currn->_ATDoAcc_pre, _currn->_ATLocalIndex_pre, PARALLEL, MATCH, _currn->_ATSym, (&( _currn->_AT_pos))), TRUE), AND(NE(GetGPUVarProperty(_currn->_ATArraySym_pre, _currn->_ATGPUVarsDeList_pre, DEMOTEDIM, _currn->_ATLocalIndex_pre), TRUE), GE(GetRegionVarProperty(_currn->_ATRegionVars_pre, BLOCKFACTOR, 1), TRUE)))))))) {
message(ERROR, "GPU Shared memory variables cannot contain a BLOCK dimension. Specify variable demotion for the shared variable.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(6865)*/
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_ATloopStart_RuleAttr_969=GetAccDo(_currn->_ATDoAcc_pre, _currn->_ATLocalIndex_pre, VECTOR, BASE, _currn->_ATSym, (&( _currn->_AT_pos)));
/*SPC(6822)*/
_currn->_ATDemoted=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetGPUVarProperty(_currn->_ATArraySym_pre, _currn->_ATGPUVarsDeList_pre, DEMOTEDIM, _currn->_ATLocalIndex_pre), TRUE))
) ? (TRUE
) : (FALSE))
;
/*SPC(7778)*/
_currn->_ATMatch=GetAccDo(_currn->_ATDoAcc_pre, _currn->_ATLocalIndex_pre, VECTOR, MATCH, _currn->_ATSym, (&( _currn->_AT_pos)));
/*SPC(6820)*/
_currn->_ATthreadPtg_RuleAttr_969=
((AND(EQ(GetVariableSharedGPU(_currn->_ATArrayId_pre, 0), SHARED), AND(EQ(_currn->_ATMatch, TRUE), GE(GetRegionVarProperty(_currn->_ATRegionVars_pre, BLOCKFACTOR, _currn->_ATLocalIndex_pre), TRUE)))
) ? (
((OR(EQ(strcmp(StringTable(_currn->_ATloopStart_RuleAttr_969), "1"), 0), EQ(_currn->_ATloopStart_RuleAttr_969, 0))
) ? (PTGAsIs("threadIdx.x")
) : (PTGThreeArgs(PTGAsIs("threadIdx.x+"), PTGString(StringTable(_currn->_ATloopStart_RuleAttr_969)), PTGAsIs("-1"))))

) : (PTGNULL))
;
/*SPC(6823)*/
_currn->_ATPtg=
((AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), OR(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ(_currn->_ATTranslationType_pre, GPU))))
) ? (
((AND(EQ(GetVariableSharedGPU(_currn->_ATArrayId_pre, 0), SHARED), AND(EQ(_currn->_ATMatch, TRUE), GE(GetRegionVarProperty(_currn->_ATRegionVars_pre, BLOCKFACTOR, _currn->_ATLocalIndex_pre), TRUE)))
) ? (_currn->_ATthreadPtg_RuleAttr_969
) : (
((AND(EQ((* _IG_incl20), _currn->_ATSym), EQ((* _IG_incl39), FUNCTION))
) ? (PTGRetName(PTGString(StringTable(_currn->_ATTERM_1)))
) : (PTGString(StringTable(_currn->_ATTERM_1))))
))

) : (
((AND(EQ((* _IG_incl20), _currn->_ATSym), EQ((* _IG_incl39), FUNCTION))
) ? (PTGRetName(PTGString(StringTable(_currn->_ATTERM_1)))
) : (PTGString(StringTable(_currn->_ATTERM_1))))
))
;
/*SPC(6835)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_512(_TPPrule_512 _currn)
#else
void _VS6rule_512(_currn )
_TPPrule_512 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPar3=
((EQ(GetRegionVarProperty(_currn->_ATRegionVars_pre, PARALLEL, 3), _currn->_ATSym)
) ? (TRUE
) : (FALSE))
;
/*SPC(12914)*/
_currn->_ATPar2=
((EQ(GetRegionVarProperty(_currn->_ATRegionVars_pre, PARALLEL, 2), _currn->_ATSym)
) ? (TRUE
) : (FALSE))
;
/*SPC(12909)*/
_currn->_ATPar1=
((EQ(GetRegionVarProperty(_currn->_ATRegionVars_pre, PARALLEL, 1), _currn->_ATSym)
) ? (TRUE
) : (FALSE))
;
/*SPC(12904)*/
_currn->_ATDevName=PTGPointer(PTGDeviceName(PTGString(StringTable(_currn->_ATSym))));
/*SPC(5521)*/
_currn->_ATHostName=PTGPointer(PTGHostName(PTGString(StringTable(_currn->_ATSym))));
/*SPC(5520)*/
_currn->_ATVarName=PTGString(StringTable(_currn->_ATSym));
/*SPC(5519)*/
_currn->_ATTypePtg=Convert_to_Ctype(GetTypeLength(_currn->_ATUnitKey, 0), GetType(_currn->_ATUnitKey, ErrorType));
/*SPC(5496)*/
_currn->_ATObjectKey=
((_currn->_ATKey
) ? (_currn->_ATKey
) : (_currn->_ATUnitKey))
;
/*SPC(2892)*/
_currn->_ATdefineVarCPU=
((AND(EQ(_currn->_ATAcceleratorRegion_pre, FALSE), AND(NE(_currn->_ATTranslationType_pre, GPU), AND(OR(EQ((* _IG_incl34), FALSE), EQ((* _IG_incl34), ASSIGN)), AND(OR(InIS(Variable, GetKindSet(_currn->_ATUnitKey, NullIS())), InIS(Constant, GetKindSet(_currn->_ATUnitKey, NullIS()))), EQ(GetVariableCPU(_currn->_ATObjectKey, FALSE), FALSE)))))
) ? (TRUE
) : (FALSE))
;
/*SPC(5383)*/
_currn->_ATCoord=(&( _currn->_AT_pos));
/*SPC(2988)*/
_currn->_ATName=
((EQ(_currn->_ATTranslationType_pre, GPU)
) ? (_currn->_ATDevName
) : (_currn->_ATHostName))
;
/*SPC(5649)*/
_currn->_ATextern=
((EQ(GetVariableDefined(_currn->_ATObjectKey, 0), MODULE)
) ? (PTGAsIs("extern ")
) : (
((AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), GE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTED, 2), TRUE))
) ? (PTGAsIs(" __device__ ")
) : (PTGNULL))
))
;
/*SPC(5498)*/
_currn->_ATdefineVarGPUKernel=
((AND(EQ(_currn->_ATTranslationType_pre, GPU), AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), AND(InIS(Variable, GetKindSet(_currn->_ATUnitKey, NullIS())), EQ(GetVariableGPU(_currn->_ATObjectKey, 0), FALSE))))
) ? (TRUE
) : (FALSE))
;
/*SPC(5395)*/
_currn->_ATdefineVarGPU=
((AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), AND(NE(GetVariableDefined(_currn->_ATObjectKey, 0), MODULE), AND(InIS(Variable, GetKindSet(_currn->_ATUnitKey, NullIS())), AND(NE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, EXISTS, 0), TRUE), NE(MOD(GetVariableGPU(_currn->_ATObjectKey, FALSE), REGION), MOD(_currn->_ATGPURegionNumber_pre, REGION))))))
) ? (TRUE
) : (FALSE))
;
/*SPC(5371)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), EQ(GetClpValue(WarnLevel, 0), DEBUG))) {
printf("xSFDummyArgName: var = %s line = %d region = %d defineVarGPU = %d defineVarCPU = %d StmtId = %d GetVariableCPU = %d\n", StringTable(_currn->_ATSym), MapLine(((_currn->_AT_pos).line)), _currn->_ATAcceleratorRegion_pre, _currn->_ATdefineVarGPU, _currn->_ATdefineVarCPU, (* _IG_incl34), GetVariableCPU(_currn->_ATObjectKey, 0));

} else {
}
;
/*SPC(5773)*/
_currn->_ATDeclLine=
((AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), GE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTED, 2), TRUE))
) ? (0
) : (
((OR(EQ(_currn->_ATAcceleratorRegion_pre, FALSE), AND(InIS(Array, GetKindSet(_currn->_ATUnitKey, NullIS())), EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL)))
) ? (_currn->_ATLastNonExecLine_pre
) : (_currn->_ATAcceleratorRegion_pre))
))
;
/*SPC(5507)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(OR(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetClpValue(Generate, CUDA), C)), AND(EQ(isModule(((_currn->_AT_pos).line)), FALSE), AND(NE(GetVariableDefined(_currn->_ATObjectKey, FALSE), PASSED_IN), OR(EQ(_currn->_ATdefineVarGPU, TRUE), OR(EQ(_currn->_ATdefineVarGPUKernel, TRUE), EQ(_currn->_ATdefineVarCPU, TRUE)))))))) {

if (AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), MODULE), EQ(GetVariableDeclaredGPU(_currn->_ATObjectKey, 0), FALSE))) {
PTGOut(PTGAppend(PTGNumber(_currn->_ATDeclLine), PTGDeclAssignExtern(_currn->_ATextern, _currn->_ATTypePtg, PTGPointer(PTGDeviceName(PTGString(StringTable(_currn->_ATSym)))), PTGPointer(PTGHostName(PTGString(StringTable(_currn->_ATSym)))), Convert_to_Ctype(GetTypeLength(_currn->_ATUnitKey, 0), GetType(_currn->_ATUnitKey, ErrorType)), _currn->_ATVarName, _currn->_ATName)));

} else {
PTGOut(PTGDeclareVar(PTGNumber(_currn->_ATDeclLine), _currn->_ATextern, PTGNULL, _currn->_ATTypePtg, GenerateArray(_currn->_ATPtg, GetArraySizeList(_currn->_ATObjectKey, NULLBoundsList), _currn->_ATObjectKey, _currn->_ATUnitKey, _currn->_ATIndentLevel_pre, _currn->_ATTranslationType_pre, 0, 0, 0, 0, _currn->_ATRegionVars_pre)));
}
;

} else {
}
;
/*SPC(5654)*/

if (AND(OR(EQ((* _IG_incl34), FALSE), EQ((* _IG_incl34), ASSIGN)), AND(EQ(isModule(((_currn->_AT_pos).line)), FALSE), EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0)))) {

if (EQ(_currn->_ATdefineVarCPU, TRUE)) {
SetVariableUse(_currn->_ATObjectKey, _currn->_ATCPURegionNumber_pre, _currn->_ATUpdate_pre, CPU, _currn->_ATSym, MapLine(((_currn->_AT_pos).line)), _currn->_ATStmtNumber_pre);

} else {

if (OR(EQ(_currn->_ATdefineVarGPU, TRUE), EQ(_currn->_ATdefineVarGPUKernel, TRUE))) {
SetVariableUse(_currn->_ATObjectKey, _currn->_ATGPURegionNumber_pre, _currn->_ATUpdate_pre, GPU, _currn->_ATSym, MapLine(((_currn->_AT_pos).line)), _currn->_ATStmtNumber_pre);

} else {
FALSE;
}
;
}
;

} else {
}
;
/*SPC(5247)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(EQ(isModule(((_currn->_AT_pos).line)), FALSE), AND(OR(GE(_currn->_ATAcceleratorRegion_pre, TRUE), AND(EQ(_currn->_ATTranslationType_pre, GPU), AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), NE(GetVariableSharedGPU(_currn->_ATObjectKey, 0), SHARED)))), AND(EQ((* _IG_incl6), FALSE), AND(GT(GetNumberOfDims(_currn->_ATUnitKey, 0), 0), NE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, EXISTS, 0), TRUE)))))))) {

if (GE(_currn->_ATAcceleratorRegion_pre, TRUE)) {
message(ERROR, "Variable is not listed in the ACC$REGION directive.", 0, (&( _currn->_AT_pos)));

} else {
message(ERROR, "Local variable is not defined.  It must be declared in SHARED memory, or passed via argument list.", 0, (&( _currn->_AT_pos)));
}
;

} else {
}
;
/*SPC(5756)*/

if ((* _IG_incl35)) {

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(Subroutine, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(MainProgram, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(BlockDataSubprogram, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(Array, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(Subroutine, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(MainProgram, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(BlockDataSubprogram, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(StatementFunction, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(DummyProcedure, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;
;

} else {
}
;
/*SPC(3342)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_513(_TPPrule_513 _currn)
#else
void _VS1rule_513(_currn )
_TPPrule_513 _currn;

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
void _VS2rule_513(_TPPrule_513 _currn)
#else
void _VS2rule_513(_currn )
_TPPrule_513 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
GuaranteeType(_currn->_ATUnitKey, DefaultType(_currn->_ATSym));
/*SPC(1610)*/

if (DisjIS(ConsIS(Constant, ConsIS(IntrinsicFunction, ConsIS(InExternalStmt, ConsIS(Array, ConsIS(Subroutine, ConsIS(MainProgram, ConsIS(BlockDataSubprogram, ConsIS(ExternalFunction, ConsIS(StatementFunction, NullIS()))))))))), GetKindSet(_currn->_ATUnitKey, NullIS()))) {
InsertKindSet(_currn->_ATUnitKey, Variable);

} else {
}
;
/*SPC(3245)*/
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

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_513(_TPPrule_513 _currn)
#else
void _VS3rule_513(_currn )
_TPPrule_513 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_ATVariableUseTakeIt=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (TRUE
) : (FALSE))
;
/*SPC(11538)*/
_currn->_ATVariableUseElem=PkgVariableUse(_currn->_ATSym, _currn->_ATStmtNumber_pre, _currn->_ATObjectKey, _currn->_ATUnitKey, (&( _currn->_AT_pos)), _currn->_ATAcceleratorRegion_pre, _currn->_ATGPURegionNumber_pre, _currn->_ATCPURegionNumber_pre, _currn->_ATUpdate_pre, MapLine(((_currn->_AT_pos).line)));
/*SPC(11535)*/
_currn->_AT_cVariableUseListPtr_post=
((_currn->_ATVariableUseTakeIt
) ? (RefEndConsVariableUseList(_currn->_AT_cVariableUseListPtr_pre, _currn->_ATVariableUseElem)
) : (_currn->_AT_cVariableUseListPtr_pre))
;
/*SPC(664)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_513(_TPPrule_513 _currn)
#else
void _VS4rule_513(_currn )
_TPPrule_513 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=
((AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(OR(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ(_currn->_ATTranslationType_pre, GPU)), EQ(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, SCOPE, 0), SHARED))))
) ? (PTGSequence(PTGString(StringTable(_currn->_ATTERM_1)), PTGAsIs("S"))
) : (
((AND(EQ((* _IG_incl20), _currn->_ATSym), EQ((* _IG_incl39), FUNCTION))
) ? (PTGRetName(PTGString(StringTable(_currn->_ATTERM_1)))
) : (PTGString(StringTable(_currn->_ATTERM_1))))
))
;
/*SPC(6804)*/
_currn->_ATCoord=(&( _currn->_AT_pos));
/*SPC(2988)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(Subroutine, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;
/*SPC(3576)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(MainProgram, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;
/*SPC(3583)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(BlockDataSubprogram, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;
/*SPC(3590)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), LT(GetClpValue(WarnLevel, 0), 0))) {

if (InIS(ExternalFunction, GetKindSet(_currn->_ATUnitKey, NullIS()))) {
message(NOTE, "Unable to classify this identifier.", 0, _currn->_ATCoord);

} else {
}
;

} else {
}
;
/*SPC(3598)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_514(_TPPrule_514 _currn)
#else
void _VS1rule_514(_currn )
_TPPrule_514 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUnitBind=BindIdn((* _IG_incl23), _currn->_ATSym);
/*SPC(47)*/
_currn->_ATUnitKey=KeyOf(_currn->_ATUnitBind);
/*SPC(49)*/
IsType(_currn->_ATUnitKey, (* _IG_incl40), ErrorType);
/*SPC(2555)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_514(_TPPrule_514 _currn)
#else
void _VS2rule_514(_currn )
_TPPrule_514 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
GuaranteeType(_currn->_ATUnitKey, DefaultType(_currn->_ATSym));
/*SPC(1610)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_514(_TPPrule_514 _currn)
#else
void _VS3rule_514(_currn )
_TPPrule_514 _currn;

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
void _VS4rule_514(_TPPrule_514 _currn)
#else
void _VS4rule_514(_currn )
_TPPrule_514 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_ATUnitCnt=ADD(1, GetUnitCnt(_currn->_ATUnitKey, 0));
/*SPC(286)*/
ResetUnitCnt(_currn->_ATUnitKey, _currn->_ATUnitCnt);
/*SPC(289)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_514(_TPPrule_514 _currn)
#else
void _VS5rule_514(_currn )
_TPPrule_514 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), GT(GetClpValue(WarnLevel, 32767), 0))) {

if (AND(GetIntrinsic(_currn->_ATObjectKey, 0), NE(GetType(_currn->_ATUnitKey, NoKey), GetType(_currn->_ATObjectKey, NoKey)))) {
message(ERROR, "Cannot change the type of an intrinsic function", 0, (&( _currn->_AT_pos)));

} else {
}
;

} else {
}
;
/*SPC(2635)*/

if (AND(GT(GetClpValue(WarnLevel, 32767), 0), EQ(GetType(_currn->_ATUnitKey, NoKey), ErrorType))) {
message(ERROR, "Defined with different types", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(2561)*/
_currn->_ATUnitTotalCnt=GetUnitCnt(_currn->_ATUnitKey, 0);
/*SPC(293)*/
_currn->_ATPtg=
((AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(OR(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ(_currn->_ATTranslationType_pre, GPU)), EQ(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, SCOPE, 0), SHARED))))
) ? (PTGSequence(PTGString(StringTable(_currn->_ATTERM_1)), PTGAsIs("S"))
) : (
((AND(EQ((* _IG_incl20), _currn->_ATSym), EQ((* _IG_incl39), FUNCTION))
) ? (PTGRetName(PTGString(StringTable(_currn->_ATTERM_1)))
) : (PTGString(StringTable(_currn->_ATTERM_1))))
))
;
/*SPC(6788)*/
_currn->_ATCoord=(&( _currn->_AT_pos));
/*SPC(2988)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), GT(GetClpValue(WarnLevel, 32767), 0))) {

if (DisjIS(GetKindSet(_currn->_ATUnitKey, SingleIS(Variable)), ConsIS(Constant, ConsIS(Variable, ConsIS(Array, ConsIS(ExternalFunction, ConsIS(IntrinsicFunction, ConsIS(InExternalStmt, ConsIS(StatementFunction, NullIS()))))))))) {
message(ERROR, "This class of symbolic name cannot be typed", 0, (&( _currn->_AT_pos)));

} else {
}
;

} else {
}
;
/*SPC(2592)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_515(_TPPrule_515 _currn)
#else
void _VS1rule_515(_currn )
_TPPrule_515 _currn;

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
void _VS2rule_515(_TPPrule_515 _currn)
#else
void _VS2rule_515(_currn )
_TPPrule_515 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
GuaranteeType(_currn->_ATUnitKey, DefaultType(_currn->_ATSym));
/*SPC(1610)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_515(_TPPrule_515 _currn)
#else
void _VS3rule_515(_currn )
_TPPrule_515 _currn;

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

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_515(_TPPrule_515 _currn)
#else
void _VS4rule_515(_currn )
_TPPrule_515 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
void _VS5rule_515(_TPPrule_515 _currn)
#else
void _VS5rule_515(_currn )
_TPPrule_515 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_515(_TPPrule_515 _currn)
#else
void _VS6rule_515(_currn )
_TPPrule_515 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_515(_TPPrule_515 _currn)
#else
void _VS7rule_515(_currn )
_TPPrule_515 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(OR(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ(_currn->_ATTranslationType_pre, GPU)), AND(EQ(GetGPUVarProperty(_currn->_ATArraySym_pre, _currn->_ATGPUVarsDeList_pre, SCOPE, 0), SHARED), AND(EQ(GetAccDo(_currn->_ATDoAcc_pre, _currn->_ATLocalIndex_pre, PARALLEL, MATCH, _currn->_ATSym, (&( _currn->_AT_pos))), TRUE), AND(NE(GetGPUVarProperty(_currn->_ATArraySym_pre, _currn->_ATGPUVarsDeList_pre, DEMOTEDIM, _currn->_ATLocalIndex_pre), TRUE), GE(GetRegionVarProperty(_currn->_ATRegionVars_pre, BLOCKFACTOR, 1), TRUE)))))))) {
message(ERROR, "GPU Shared memory variables cannot contain a BLOCK dimension. Specify variable demotion for the shared variable.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(6783)*/
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
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_ATMatch=GetAccDo(_currn->_ATDoAcc_pre, _currn->_ATLocalIndex_pre, VECTOR, MATCH, _currn->_ATSym, (&( _currn->_AT_pos)));
/*SPC(6723)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_515(_TPPrule_515 _currn)
#else
void _VS8rule_515(_currn )
_TPPrule_515 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATloopStart_RuleAttr_972=GetAccDo(_currn->_ATDoAcc_pre, _currn->_ATLocalIndex_pre, VECTOR, BASE, _currn->_ATSym, (&( _currn->_AT_pos)));
/*SPC(6725)*/
_currn->_ATthreadPtg_RuleAttr_972=
((AND(EQ(GetVariableSharedGPU(_currn->_ATArrayId_pre, 0), SHARED), AND(EQ(_currn->_ATMatch, TRUE), GE(GetRegionVarProperty(_currn->_ATRegionVars_pre, BLOCKFACTOR, _currn->_ATLocalIndex_pre), TRUE)))
) ? (
((OR(EQ(strcmp(StringTable(_currn->_ATloopStart_RuleAttr_972), "1"), 0), EQ(_currn->_ATloopStart_RuleAttr_972, 0))
) ? (PTGAsIs("threadIdx.x")
) : (PTGThreeArgs(PTGAsIs("threadIdx.x+"), PTGString(StringTable(_currn->_ATloopStart_RuleAttr_972)), PTGAsIs("-1"))))

) : (PTGNULL))
;
/*SPC(6727)*/
_currn->_ATDemoted=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetGPUVarProperty(_currn->_ATArraySym_pre, _currn->_ATGPUVarsDeList_pre, DEMOTEDIM, _currn->_ATLocalIndex_pre), TRUE))
) ? (TRUE
) : (FALSE))
;
/*SPC(7769)*/
_currn->_ATPtg=
((EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0)
) ? (
((AND(EQ((* _IG_incl20), _currn->_ATSym), EQ((* _IG_incl39), FUNCTION))
) ? (PTGRetName(PTGString(StringTable(_currn->_ATTERM_1)))
) : (
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), OR(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ(_currn->_ATTranslationType_pre, GPU)))
) ? (
((EQ(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, SCOPE, 0), SHARED)
) ? (PTGSequence(PTGString(StringTable(_currn->_ATTERM_1)), PTGAsIs("S"))
) : (
((OR(AND(GE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTED, _currn->_ATLocalIndex_pre), TRUE), NE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTE_TYPE, _currn->_ATLocalIndex_pre), THREAD)), AND(GE(GetVariablePromotedGPU(_currn->_ATObjectKey, 0), TRUE), EQ(_currn->_ATTranslationType_pre, GPU)))
) ? (PTGSequence(PTGString(StringTable(_currn->_ATTERM_1)), PTGAsIs("P"))
) : (
((AND(EQ(GetVariableSharedGPU(_currn->_ATArrayId_pre, 0), SHARED), AND(EQ(_currn->_ATMatch, TRUE), GE(GetRegionVarProperty(_currn->_ATRegionVars_pre, BLOCKFACTOR, _currn->_ATLocalIndex_pre), TRUE)))
) ? (_currn->_ATthreadPtg_RuleAttr_972
) : (PTGString(StringTable(_currn->_ATTERM_1))))
))
))

) : (PTGString(StringTable(_currn->_ATTERM_1))))
))

) : (PTGNULL))
;
/*SPC(6746)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_515(_TPPrule_515 _currn)
#else
void _VS9rule_515(_currn )
_TPPrule_515 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_ATUnitCnt=ADD(1, GetUnitCnt(_currn->_ATUnitKey, 0));
/*SPC(286)*/
_currn->_ATVariableUseTakeIt=
((AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(isIntrinsic(StringTable(_currn->_ATSym), _currn->_ATNumArgs), FALSE), AND(OR(InIS(Array, GetKindSet(_currn->_ATUnitKey, NullIS())), InIS(Variable, GetKindSet(_currn->_ATUnitKey, NullIS()))), AND(EQ(_currn->_ATignoreVar, FALSE), NE((* _IG_incl6), ACCREGION)))))
) ? (TRUE
) : (FALSE))
;
/*SPC(11522)*/
_currn->_ATVariableUseElem=PkgVariableUse(_currn->_ATSym, _currn->_ATStmtNumber_pre, _currn->_ATObjectKey, _currn->_ATUnitKey, (&( _currn->_AT_pos)), _currn->_ATAcceleratorRegion_pre, _currn->_ATGPURegionNumber_pre, _currn->_ATCPURegionNumber_pre, _currn->_ATUpdate_pre, MapLine(((_currn->_AT_pos).line)));
/*SPC(11519)*/
_currn->_AT_cVariableUseListPtr_post=
((_currn->_ATVariableUseTakeIt
) ? (RefEndConsVariableUseList(_currn->_AT_cVariableUseListPtr_pre, _currn->_ATVariableUseElem)
) : (_currn->_AT_cVariableUseListPtr_pre))
;
/*SPC(664)*/
ResetUnitCnt(_currn->_ATUnitKey, _currn->_ATUnitCnt);
/*SPC(289)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_515(_TPPrule_515 _currn)
#else
void _VS10rule_515(_currn )
_TPPrule_515 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(isIntrinsic(StringTable(_currn->_ATSym), _currn->_ATArgCnt_pre), FALSE), AND(EQ(_currn->_ATignoreVar, FALSE), EQ(GetVariableDefined(_currn->_ATObjectKey, FALSE), FALSE))))) {
ResetVariableDefined(_currn->_ATObjectKey, LOCAL);

} else {
}
;
/*SPC(5125)*/
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATDevName=
((GT(GetNumberOfDims(_currn->_ATUnitKey, 0), 0)
) ? (PTGDeviceName(PTGString(StringTable(_currn->_ATSym)))
) : (PTGPointer(PTGDeviceName(PTGString(StringTable(_currn->_ATSym))))))
;
/*SPC(5447)*/
_currn->_ATHostName=
((GT(GetNumberOfDims(_currn->_ATUnitKey, 0), 0)
) ? (PTGHostName(PTGString(StringTable(_currn->_ATSym)))
) : (PTGPointer(PTGHostName(PTGString(StringTable(_currn->_ATSym))))))
;
/*SPC(5442)*/
_currn->_ATVarName=
((GT(GetNumberOfDims(_currn->_ATUnitKey, 0), 0)
) ? (PTGPointer(PTGString(StringTable(_currn->_ATSym)))
) : (PTGString(StringTable(_currn->_ATSym))))
;
/*SPC(5437)*/
_currn->_ATextern=
((EQ(GetVariableDefined(_currn->_ATObjectKey, 0), MODULE)
) ? (PTGAsIs("extern ")
) : (
((AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), GE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTED, 2), TRUE))
) ? (PTGAsIs(" __device__ ")
) : (PTGNULL))
))
;
/*SPC(5415)*/
_currn->_ATTypePtg=Convert_to_Ctype(GetTypeLength(_currn->_ATUnitKey, 0), GetType(_currn->_ATUnitKey, ErrorType));
/*SPC(5412)*/
_currn->_ATlocalVariableCPU=
((AND(EQ((* _IG_incl6), ACCREGION), AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), AND(NE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, SCOPE, 0), SHARED), EQ(GetVariableCPU(_currn->_ATObjectKey, 0), 0))))
) ? (TRUE
) : (FALSE))
;
/*SPC(5287)*/
_currn->_ATdefineVarGPUKernel=
((AND(EQ(_currn->_ATTranslationType_pre, GPU), AND(NE((* _IG_incl5), ACCROUTINE), AND(EQ(isIntrinsic(StringTable(_currn->_ATSym), _currn->_ATNumArgs), FALSE), AND(OR(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), EQ(GetVariableDefined(_currn->_ATObjectKey, 0), MODULE)), OR(AND(InIS(Array, GetKindSet(_currn->_ATUnitKey, NullIS())), AND(NE(GetVariableSharedGPU(_currn->_ATObjectKey, 0), SHARED), EQ(GetVariableGPU(_currn->_ATObjectKey, 0), FALSE))), AND(InIS(Variable, GetKindSet(_currn->_ATUnitKey, NullIS())), EQ(GetVariableGPU(_currn->_ATObjectKey, 0), FALSE)))))))
) ? (TRUE
) : (FALSE))
;
/*SPC(5312)*/
_currn->_ATdefineVarGPU=
((AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), AND(NE((* _IG_incl6), ACCREGION), AND(NE(GetVariableDefined(_currn->_ATObjectKey, 0), MODULE), AND(EQ(isIntrinsic(StringTable(_currn->_ATSym), _currn->_ATNumArgs), FALSE), OR(AND(InIS(Array, GetKindSet(_currn->_ATUnitKey, NullIS())), AND(NE(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), AND(NE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, SCOPE, 0), SHARED), EQ(MOD(GetVariableGPU(_currn->_ATObjectKey, FALSE), REGION), FALSE)))), AND(InIS(Variable, GetKindSet(_currn->_ATUnitKey, NullIS())), AND(NE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, EXISTS, 0), TRUE), NE(MOD(GetVariableGPU(_currn->_ATObjectKey, FALSE), REGION), MOD(_currn->_ATGPURegionNumber_pre, REGION)))))))))
) ? (TRUE
) : (FALSE))
;
/*SPC(5269)*/
_currn->_ATdefineVarCPU=
((AND(OR(EQ(_currn->_ATAcceleratorRegion_pre, FALSE), EQ(_currn->_ATlocalVariableCPU, TRUE)), AND(NE(_currn->_ATTranslationType_pre, GPU), AND(OR(EQ((* _IG_incl34), FALSE), EQ((* _IG_incl34), ASSIGN)), AND(NE((* _IG_incl4), ACCDATA), AND(EQ(isIntrinsic(StringTable(_currn->_ATSym), _currn->_ATNumArgs), FALSE), AND(OR(InIS(Array, GetKindSet(_currn->_ATUnitKey, NullIS())), OR(InIS(Constant, GetKindSet(_currn->_ATUnitKey, NullIS())), InIS(Variable, GetKindSet(_currn->_ATUnitKey, NullIS())))), EQ(GetVariableRoutine(_currn->_ATObjectKey, FALSE), FALSE)))))))
) ? (TRUE
) : (FALSE))
;
/*SPC(5296)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), EQ(GetClpValue(WarnLevel, 0), DEBUG))) {
printf("xName var = %s accRegion = %d line = %d defineVarGPU = %d defineVarCPU = %d VariableDefined = %d variableCPU = %d variableGPU = %d localVariable = %d defineVarGPUKernel = %d VariableSharedGPU = %d variableRoutine = %d isModule = %d\n", StringTable(_currn->_ATSym), _currn->_ATAcceleratorRegion_pre, MapLine(((_currn->_AT_pos).line)), _currn->_ATdefineVarGPU, _currn->_ATdefineVarCPU, GetVariableDefined(_currn->_ATObjectKey, 0), GetVariableCPU(_currn->_ATObjectKey, FALSE), GetVariableGPU(_currn->_ATObjectKey, 0), _currn->_ATlocalVariableCPU, _currn->_ATdefineVarGPUKernel, GetVariableSharedGPU(_currn->_ATObjectKey, 0), GetVariableRoutine(_currn->_ATObjectKey, 0), GetVariableDeclaredGPU(_currn->_ATObjectKey, 0));

} else {
isModule(((_currn->_AT_pos).line));
}
;
/*SPC(5711)*/
_currn->_ATName=
((EQ(_currn->_ATTranslationType_pre, GPU)
) ? (_currn->_ATDevName
) : (_currn->_ATHostName))
;
/*SPC(5528)*/
_currn->_ATDeclLine=
((AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), GE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTED, 2), TRUE))
) ? (0
) : (
((EQ(_currn->_ATdefineVarCPU, TRUE)
) ? (_currn->_ATLastNonExecLine_pre
) : (
((EQ(_currn->_ATdefineVarGPUKernel, TRUE)
) ? (_currn->_ATLastNonExecLine_pre
) : (_currn->_ATAcceleratorRegion_pre))
))
))
;
/*SPC(5424)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(OR(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetClpValue(Generate, CUDA), C)), AND(EQ(isModule(((_currn->_AT_pos).line)), FALSE), AND(NE(GetVariableDefined(_currn->_ATObjectKey, FALSE), PASSED_IN), AND(NE(GetVariableDefined(_currn->_ATObjectKey, FALSE), GPU_CONSTANT), AND(EQ(_currn->_ATignoreVar, FALSE), OR(EQ(_currn->_ATdefineVarGPU, TRUE), OR(EQ(_currn->_ATdefineVarGPUKernel, TRUE), EQ(_currn->_ATdefineVarCPU, TRUE)))))))))) {

if (AND(GT(GetNumberOfDims(_currn->_ATUnitKey, 0), 0), AND(NE(_currn->_ATTranslationType_pre, GPU), EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL)))) {
PTGOut(PTGAllocateLocal(PTGNumber(_currn->_ATDeclLine), GenerateAllocation(_currn->_ATPtg, _currn->_ATUnitKey, _currn->_ATObjectKey, ALLOCATE)));

} else {

if (AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), MODULE), EQ(GetVariableDeclaredGPU(_currn->_ATObjectKey, 0), FALSE))) {
PTGOut(PTGAppend(PTGNumber(_currn->_ATDeclLine), PTGDeclAssignExtern(_currn->_ATextern, _currn->_ATTypePtg, PTGPointer(PTGDeviceName(PTGString(StringTable(_currn->_ATSym)))), PTGPointer(PTGHostName(PTGString(StringTable(_currn->_ATSym)))), _currn->_ATTypePtg, _currn->_ATVarName, _currn->_ATName)));

} else {
PTGOut(PTGDeclareVar(PTGNumber(_currn->_ATDeclLine), _currn->_ATextern, PTGNULL, _currn->_ATTypePtg, GenerateArray(_currn->_ATPtg, GetArraySizeList(_currn->_ATObjectKey, NULLBoundsList), _currn->_ATObjectKey, _currn->_ATUnitKey, _currn->_ATIndentLevel_pre, _currn->_ATTranslationType_pre, GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, DEMOTEDIM, 1), GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, DEMOTEDIM, 2), GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTED, 2), GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTE_TYPE, 2), _currn->_ATRegionVars_pre)));
}
;
}
;

} else {
}
;
/*SPC(5534)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(OR(GE(_currn->_ATAcceleratorRegion_pre, TRUE), AND(EQ(_currn->_ATTranslationType_pre, GPU), AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), NE(GetVariableSharedGPU(_currn->_ATObjectKey, 0), SHARED)))), AND(EQ((* _IG_incl6), FALSE), AND(EQ(isIntrinsic(StringTable(_currn->_ATSym), _currn->_ATNumArgs), FALSE), AND(GT(GetNumberOfDims(_currn->_ATUnitKey, 0), 0), NE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, EXISTS, 0), TRUE)))))))) {

if (GE(_currn->_ATAcceleratorRegion_pre, TRUE)) {
message(ERROR, "Variable is not listed in the ACC$REGION directive.", 0, (&( _currn->_AT_pos)));

} else {
}
;

} else {
}
;
/*SPC(5695)*/

if (AND(OR(EQ((* _IG_incl34), FALSE), EQ((* _IG_incl34), ASSIGN)), AND(NE((* _IG_incl4), ACCDATA), AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), EQ(_currn->_ATignoreVar, FALSE))))) {

if (EQ(_currn->_ATdefineVarCPU, TRUE)) {
SetVariableUse(_currn->_ATObjectKey, _currn->_ATCPURegionNumber_pre, _currn->_ATUpdate_pre, CPU, _currn->_ATSym, ((_currn->_AT_pos).line), _currn->_ATStmtNumber_pre);

} else {

if (OR(EQ(_currn->_ATdefineVarGPU, TRUE), EQ(_currn->_ATdefineVarGPUKernel, TRUE))) {
SetVariableUse(_currn->_ATObjectKey, _currn->_ATGPURegionNumber_pre, _currn->_ATUpdate_pre, GPU, _currn->_ATSym, ((_currn->_AT_pos).line), _currn->_ATStmtNumber_pre);

} else {
FALSE;
}
;
}
;

} else {
}
;
/*SPC(5212)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_515(_TPPrule_515 _currn)
#else
void _VS11rule_515(_currn )
_TPPrule_515 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUnitTotalCnt=GetUnitCnt(_currn->_ATUnitKey, 0);
/*SPC(293)*/
_currn->_ATPar3=
((EQ(GetRegionVarProperty(_currn->_ATRegionVars_pre, PARALLEL, 3), _currn->_ATSym)
) ? (TRUE
) : (FALSE))
;
/*SPC(12878)*/
_currn->_ATPar2=
((EQ(GetRegionVarProperty(_currn->_ATRegionVars_pre, PARALLEL, 2), _currn->_ATSym)
) ? (TRUE
) : (FALSE))
;
/*SPC(12873)*/
_currn->_ATPar1=
((EQ(GetRegionVarProperty(_currn->_ATRegionVars_pre, PARALLEL, 1), _currn->_ATSym)
) ? (TRUE
) : (FALSE))
;
/*SPC(12868)*/
_currn->_ATCoord=(&( _currn->_AT_pos));
/*SPC(2988)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_516(_TPPrule_516 _currn)
#else
void _VS1rule_516(_currn )
_TPPrule_516 _currn;

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
void _VS2rule_516(_TPPrule_516 _currn)
#else
void _VS2rule_516(_currn )
_TPPrule_516 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
GuaranteeType(_currn->_ATUnitKey, DefaultType(_currn->_ATSym));
/*SPC(1610)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_516(_TPPrule_516 _currn)
#else
void _VS3rule_516(_currn )
_TPPrule_516 _currn;

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

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_516(_TPPrule_516 _currn)
#else
void _VS4rule_516(_currn )
_TPPrule_516 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
void _VS5rule_516(_TPPrule_516 _currn)
#else
void _VS5rule_516(_currn )
_TPPrule_516 _currn;

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
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=
((AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), EQ(GetClpValue(Generate, CUDA), CUDA))
) ? (
((AND(OR(GE(_currn->_ATAcceleratorRegion_pre, TRUE), EQ(_currn->_ATTranslationType_pre, GPU)), EQ(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, SCOPE, 0), SHARED))
) ? (PTGSequence(PTGString(StringTable(_currn->_ATTERM_1)), PTGAsIs("S"))
) : (PTGString(StringTable(_currn->_ATTERM_1))))

) : (PTGString(StringTable(_currn->_ATTERM_1))))
;
/*SPC(6707)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_516(_TPPrule_516 _currn)
#else
void _VS6rule_516(_currn )
_TPPrule_516 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_ATUnitCnt=ADD(1, GetUnitCnt(_currn->_ATUnitKey, 0));
/*SPC(286)*/
_currn->_ATVariableUseTakeIt=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (TRUE
) : (FALSE))
;
/*SPC(11549)*/
_currn->_ATVariableUseElem=PkgVariableUse(_currn->_ATSym, _currn->_ATStmtNumber_pre, _currn->_ATObjectKey, _currn->_ATUnitKey, (&( _currn->_AT_pos)), _currn->_ATAcceleratorRegion_pre, _currn->_ATGPURegionNumber_pre, _currn->_ATCPURegionNumber_pre, _currn->_ATUpdate_pre, MapLine(((_currn->_AT_pos).line)));
/*SPC(11546)*/
_currn->_AT_cVariableUseListPtr_post=
((_currn->_ATVariableUseTakeIt
) ? (RefEndConsVariableUseList(_currn->_AT_cVariableUseListPtr_pre, _currn->_ATVariableUseElem)
) : (_currn->_AT_cVariableUseListPtr_pre))
;
/*SPC(664)*/
ResetUnitCnt(_currn->_ATUnitKey, _currn->_ATUnitCnt);
/*SPC(289)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_516(_TPPrule_516 _currn)
#else
void _VS7rule_516(_currn )
_TPPrule_516 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_516(_TPPrule_516 _currn)
#else
void _VS8rule_516(_currn )
_TPPrule_516 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUnitTotalCnt=GetUnitCnt(_currn->_ATUnitKey, 0);
/*SPC(293)*/
_currn->_ATDevName=
((GT(GetNumberOfDims(_currn->_ATUnitKey, 0), 0)
) ? (PTGDeviceName(PTGString(StringTable(_currn->_ATSym)))
) : (PTGPointer(PTGDeviceName(PTGString(StringTable(_currn->_ATSym))))))
;
/*SPC(5488)*/
_currn->_ATHostName=
((GT(GetNumberOfDims(_currn->_ATUnitKey, 0), 0)
) ? (PTGHostName(PTGString(StringTable(_currn->_ATSym)))
) : (PTGPointer(PTGHostName(PTGString(StringTable(_currn->_ATSym))))))
;
/*SPC(5483)*/
_currn->_ATVarName=
((GT(GetNumberOfDims(_currn->_ATUnitKey, 0), 0)
) ? (PTGPointer(PTGString(StringTable(_currn->_ATSym)))
) : (PTGString(StringTable(_currn->_ATSym))))
;
/*SPC(5478)*/
_currn->_ATextern=
((EQ(GetVariableDefined(_currn->_ATObjectKey, 0), MODULE)
) ? (PTGAsIs("extern ")
) : (
((AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), GE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTED, 2), TRUE))
) ? (PTGAsIs(" __device__ ")
) : (PTGNULL))
))
;
/*SPC(5457)*/
_currn->_ATTypePtg=Convert_to_Ctype(GetTypeLength(_currn->_ATUnitKey, 0), GetType(_currn->_ATUnitKey, ErrorType));
/*SPC(5455)*/
_currn->_ATdefineVarGPUKernel=
((AND(EQ(_currn->_ATTranslationType_pre, GPU), AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), OR(AND(InIS(Array, GetKindSet(_currn->_ATUnitKey, NullIS())), AND(NE(GetVariableSharedGPU(_currn->_ATObjectKey, 0), SHARED), EQ(GetVariableGPU(_currn->_ATObjectKey, 0), FALSE))), AND(InIS(Variable, GetKindSet(_currn->_ATUnitKey, NullIS())), EQ(GetVariableGPU(_currn->_ATObjectKey, 0), FALSE)))))
) ? (TRUE
) : (FALSE))
;
/*SPC(5357)*/
_currn->_ATdefineVarGPU=
((AND(GE(_currn->_ATAcceleratorRegion_pre, TRUE), AND(NE(GetVariableDefined(_currn->_ATObjectKey, 0), MODULE), OR(AND(InIS(Array, GetKindSet(_currn->_ATUnitKey, NullIS())), AND(NE(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), EQ(MOD(GetVariableGPU(_currn->_ATObjectKey, FALSE), REGION), FALSE))), AND(InIS(Variable, GetKindSet(_currn->_ATUnitKey, NullIS())), AND(NE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, EXISTS, 0), TRUE), NE(MOD(GetVariableGPU(_currn->_ATObjectKey, FALSE), REGION), MOD(_currn->_ATGPURegionNumber_pre, REGION)))))))
) ? (TRUE
) : (FALSE))
;
/*SPC(5329)*/
_currn->_ATdefineVarCPU=
((AND(EQ(_currn->_ATAcceleratorRegion_pre, FALSE), AND(NE(_currn->_ATTranslationType_pre, GPU), AND(OR(EQ((* _IG_incl34), FALSE), EQ((* _IG_incl34), ASSIGN)), AND(OR(InIS(Variable, GetKindSet(_currn->_ATUnitKey, NullIS())), OR(InIS(Constant, GetKindSet(_currn->_ATUnitKey, NullIS())), InIS(Array, GetKindSet(_currn->_ATUnitKey, NullIS())))), EQ(GetVariableCPU(_currn->_ATObjectKey, FALSE), FALSE)))))
) ? (TRUE
) : (FALSE))
;
/*SPC(5344)*/
_currn->_ATCoord=(&( _currn->_AT_pos));
/*SPC(2988)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), EQ(GetClpValue(WarnLevel, 0), DEBUG))) {
printf("xVariableName: var = %s line = %d region = %d defineVarGPU = %d defineVarCPU = %d StmtId = %d GetVariableCPU = %d\n", StringTable(_currn->_ATSym), MapLine(((_currn->_AT_pos).line)), _currn->_ATAcceleratorRegion_pre, _currn->_ATdefineVarGPU, _currn->_ATdefineVarCPU, (* _IG_incl34), GetVariableCPU(_currn->_ATObjectKey, 0));

} else {
}
;
/*SPC(5748)*/
_currn->_ATName=
((EQ(_currn->_ATTranslationType_pre, GPU)
) ? (_currn->_ATDevName
) : (_currn->_ATHostName))
;
/*SPC(5590)*/
_currn->_ATDeclLine=
((AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), GE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTED, 2), TRUE))
) ? (0
) : (
((OR(EQ(_currn->_ATAcceleratorRegion_pre, FALSE), AND(InIS(Array, GetKindSet(_currn->_ATUnitKey, NullIS())), EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL)))
) ? (_currn->_ATLastNonExecLine_pre
) : (_currn->_ATAcceleratorRegion_pre))
))
;
/*SPC(5466)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(OR(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetClpValue(Generate, CUDA), C)), AND(EQ(isModule(((_currn->_AT_pos).line)), FALSE), AND(NE(GetVariableDefined(_currn->_ATObjectKey, FALSE), PASSED_IN), AND(NE(GetVariableDefined(_currn->_ATObjectKey, FALSE), MODULE), OR(EQ(_currn->_ATdefineVarGPU, TRUE), OR(EQ(_currn->_ATdefineVarGPUKernel, TRUE), EQ(_currn->_ATdefineVarCPU, TRUE))))))))) {

if (AND(GT(GetNumberOfDims(_currn->_ATUnitKey, 0), 0), EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL))) {
PTGOut(PTGAllocateLocal(PTGNumber(_currn->_ATDeclLine), GenerateAllocation(_currn->_ATPtg, _currn->_ATUnitKey, _currn->_ATObjectKey, ALLOCATE)));

} else {

if (AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), MODULE), EQ(GetVariableDeclaredGPU(_currn->_ATObjectKey, 0), FALSE))) {
PTGOut(PTGAppend(PTGNumber(_currn->_ATDeclLine), PTGDeclAssignExtern(_currn->_ATextern, _currn->_ATTypePtg, PTGPointer(PTGDeviceName(PTGString(StringTable(_currn->_ATSym)))), PTGPointer(PTGHostName(PTGString(StringTable(_currn->_ATSym)))), Convert_to_Ctype(GetTypeLength(_currn->_ATUnitKey, 0), GetType(_currn->_ATUnitKey, ErrorType)), _currn->_ATVarName, _currn->_ATName)));

} else {
PTGOut(PTGDeclareVar(PTGNumber(_currn->_ATDeclLine), _currn->_ATextern, PTGNULL, _currn->_ATTypePtg, GenerateArray(_currn->_ATPtg, GetArraySizeList(_currn->_ATObjectKey, NULLBoundsList), _currn->_ATObjectKey, _currn->_ATUnitKey, _currn->_ATIndentLevel_pre, _currn->_ATTranslationType_pre, GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, DEMOTEDIM, 1), GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, DEMOTEDIM, 2), GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTED, 2), GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, PROMOTE_TYPE, 2), _currn->_ATRegionVars_pre)));
}
;
}
;

} else {
}
;
/*SPC(5595)*/

if (AND(OR(EQ((* _IG_incl34), FALSE), EQ((* _IG_incl34), ASSIGN)), AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), EQ(isModule(((_currn->_AT_pos).line)), FALSE)))) {

if (EQ(_currn->_ATdefineVarCPU, TRUE)) {
SetVariableUse(_currn->_ATObjectKey, _currn->_ATCPURegionNumber_pre, _currn->_ATUpdate_pre, CPU, _currn->_ATSym, ((_currn->_AT_pos).line), _currn->_ATStmtNumber_pre);

} else {

if (OR(EQ(_currn->_ATdefineVarGPU, TRUE), EQ(_currn->_ATdefineVarGPUKernel, TRUE))) {
SetVariableUse(_currn->_ATObjectKey, _currn->_ATGPURegionNumber_pre, _currn->_ATUpdate_pre, GPU, _currn->_ATSym, ((_currn->_AT_pos).line), _currn->_ATStmtNumber_pre);

} else {
FALSE;
}
;
}
;

} else {
}
;
/*SPC(5230)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(GetClpValue(Generate, CUDA), CUDA), AND(OR(GE(_currn->_ATAcceleratorRegion_pre, TRUE), AND(EQ(_currn->_ATTranslationType_pre, GPU), AND(EQ(GetVariableDefined(_currn->_ATObjectKey, 0), LOCAL), NE(GetVariableSharedGPU(_currn->_ATObjectKey, 0), SHARED)))), AND(EQ((* _IG_incl6), FALSE), AND(GT(GetNumberOfDims(_currn->_ATUnitKey, 0), 0), NE(GetGPUVarProperty(_currn->_ATSym, _currn->_ATGPUVarsDeList_pre, EXISTS, 0), TRUE))))))) {

if (GE(_currn->_ATAcceleratorRegion_pre, TRUE)) {
message(ERROR, "Variable is not listed in the ACC$REGION directive.", 0, (&( _currn->_AT_pos)));

} else {
message(ERROR, "Local variable is not defined.  It must be declared in SHARED memory, or passed via argument list.", 0, (&( _currn->_AT_pos)));
}
;

} else {
}
;
/*SPC(5733)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_517(_TPPrule_517 _currn)
#else
void _VS1rule_517(_currn )
_TPPrule_517 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIntent=OUT;
/*SPC(6681)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_518(_TPPrule_518 _currn)
#else
void _VS1rule_518(_currn )
_TPPrule_518 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIntent=INOUT;
/*SPC(6677)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_519(_TPPrule_519 _currn)
#else
void _VS1rule_519(_currn )
_TPPrule_519 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIntent=IN;
/*SPC(6673)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_520(_TPPrule_520 _currn)
#else
void _VS1rule_520(_currn )
_TPPrule_520 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIntent=INOUT;
/*SPC(6669)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_521(_TPPrule_521 _currn)
#else
void _VS1rule_521(_currn )
_TPPrule_521 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const57=ZERO();
/*SPC(6665)*/
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_521(_TPPrule_521 _currn)
#else
void _VS2rule_521(_currn )
_TPPrule_521 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATStmtId=FALSE;
/*SPC(4820)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_521(_TPPrule_521 _currn)
#else
void _VS3rule_521(_currn )
_TPPrule_521 _currn;

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
_currn->_ATParameterAttr=FALSE;
/*SPC(4091)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_521(_TPPrule_521 _currn)
#else
void _VS4rule_521(_currn )
_TPPrule_521 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const59=IDENTICAL(_currn->_desc1->_ATIntent);
/*SPC(6665)*/
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
void _VS5rule_521(_TPPrule_521 _currn)
#else
void _VS5rule_521(_currn )
_TPPrule_521 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const58=ZERO();
/*SPC(6665)*/
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
void _VS1rule_522(_TPPrule_522 _currn)
#else
void _VS1rule_522(_currn )
_TPPrule_522 _currn;

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
void _VS2rule_522(_TPPrule_522 _currn)
#else
void _VS2rule_522(_currn )
_TPPrule_522 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_522(_TPPrule_522 _currn)
#else
void _VS3rule_522(_currn )
_TPPrule_522 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_522(_TPPrule_522 _currn)
#else
void _VS4rule_522(_currn )
_TPPrule_522 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_522(_TPPrule_522 _currn)
#else
void _VS5rule_522(_currn )
_TPPrule_522 _currn;

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
void _VS6rule_522(_TPPrule_522 _currn)
#else
void _VS6rule_522(_currn )
_TPPrule_522 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_522(_TPPrule_522 _currn)
#else
void _VS7rule_522(_currn )
_TPPrule_522 _currn;

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
void _VS8rule_522(_TPPrule_522 _currn)
#else
void _VS8rule_522(_currn )
_TPPrule_522 _currn;

#endif
{
int* _IL_incl53;

_VisitVarDecl()
_VisitEntry();
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATSubArg);
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATSubArg=FALSE;
/*SPC(6638)*/
_currn->_AT_const33=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(6650)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xArg not supported.");
/*SPC(6629)*/
_IG_incl53=_IL_incl53;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_522(_TPPrule_522 _currn)
#else
void _VS9rule_522(_currn )
_TPPrule_522 _currn;

#endif
{
int* _IL_incl53;

_VisitVarDecl()
_VisitEntry();
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATSubArg);
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
/*SPC(6650)*/
_currn->_AT_const32=ZERO();
/*SPC(6650)*/
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
_IG_incl53=_IL_incl53;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_522(_TPPrule_522 _currn)
#else
void _VS10rule_522(_currn )
_TPPrule_522 _currn;

#endif
{
int* _IL_incl53;

_VisitVarDecl()
_VisitEntry();
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATSubArg);
_currn->_ATArgType=PTGNULL;
/*SPC(5870)*/
_IG_incl53=_IL_incl53;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_522(_TPPrule_522 _currn)
#else
void _VS11rule_522(_currn )
_TPPrule_522 _currn;

#endif
{
int* _IL_incl53;

_VisitVarDecl()
_VisitEntry();
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATSubArg);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_IG_incl53=_IL_incl53;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS12rule_522(_TPPrule_522 _currn)
#else
void _VS12rule_522(_currn )
_TPPrule_522 _currn;

#endif
{
int* _IL_incl53;

_VisitVarDecl()
_VisitEntry();
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATSubArg);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=ZERO();
/*SPC(6650)*/
_currn->_AT_const50=ZERO();
/*SPC(6650)*/
_currn->_AT_const63=ZERO();
/*SPC(6650)*/
_currn->_AT_const64=IDENTICAL(_currn->_desc1->_ATPar1);
/*SPC(6650)*/
_currn->_AT_const65=IDENTICAL(_currn->_desc1->_ATPar2);
/*SPC(6650)*/
_currn->_AT_const66=IDENTICAL(_currn->_desc1->_ATPar3);
/*SPC(6650)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_IG_incl53=_IL_incl53;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_523(_TPPrule_523 _currn)
#else
void _VS1rule_523(_currn )
_TPPrule_523 _currn;

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
void _VS2rule_523(_TPPrule_523 _currn)
#else
void _VS2rule_523(_currn )
_TPPrule_523 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_523(_TPPrule_523 _currn)
#else
void _VS3rule_523(_currn )
_TPPrule_523 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_523(_TPPrule_523 _currn)
#else
void _VS4rule_523(_currn )
_TPPrule_523 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_523(_TPPrule_523 _currn)
#else
void _VS5rule_523(_currn )
_TPPrule_523 _currn;

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
void _VS6rule_523(_TPPrule_523 _currn)
#else
void _VS6rule_523(_currn )
_TPPrule_523 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_523(_TPPrule_523 _currn)
#else
void _VS7rule_523(_currn )
_TPPrule_523 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
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
void _VS8rule_523(_TPPrule_523 _currn)
#else
void _VS8rule_523(_currn )
_TPPrule_523 _currn;

#endif
{
int* _IL_incl53;

_VisitVarDecl()
_VisitEntry();
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATSubArg);
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATSubArg=FALSE;
/*SPC(6638)*/
_currn->_AT_const33=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(6647)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xArg not supported.");
/*SPC(6629)*/
_IG_incl53=_IL_incl53;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_523(_TPPrule_523 _currn)
#else
void _VS9rule_523(_currn )
_TPPrule_523 _currn;

#endif
{
int* _IL_incl53;

_VisitVarDecl()
_VisitEntry();
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATSubArg);
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
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const18=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(6647)*/
_currn->_AT_const32=ZERO();
/*SPC(6647)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
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
_IG_incl53=_IL_incl53;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_523(_TPPrule_523 _currn)
#else
void _VS10rule_523(_currn )
_TPPrule_523 _currn;

#endif
{
int* _IL_incl53;

_VisitVarDecl()
_VisitEntry();
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATSubArg);
_currn->_ATArgType=PTGNULL;
/*SPC(5870)*/
_IG_incl53=_IL_incl53;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_523(_TPPrule_523 _currn)
#else
void _VS11rule_523(_currn )
_TPPrule_523 _currn;

#endif
{
int* _IL_incl53;

_VisitVarDecl()
_VisitEntry();
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATSubArg);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_IG_incl53=_IL_incl53;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS12rule_523(_TPPrule_523 _currn)
#else
void _VS12rule_523(_currn )
_TPPrule_523 _currn;

#endif
{
int* _IL_incl53;

_VisitVarDecl()
_VisitEntry();
_IL_incl53=_IG_incl53;_IG_incl53= &(_currn->_ATSubArg);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=ZERO();
/*SPC(6647)*/
_currn->_AT_const50=ZERO();
/*SPC(6647)*/
_currn->_AT_const63=ZERO();
/*SPC(6647)*/
_currn->_AT_const64=IDENTICAL(_currn->_desc1->_ATPar1);
/*SPC(6647)*/
_currn->_AT_const65=IDENTICAL(_currn->_desc1->_ATPar2);
/*SPC(6647)*/
_currn->_AT_const66=IDENTICAL(_currn->_desc1->_ATPar3);
/*SPC(6647)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_IG_incl53=_IL_incl53;

_VisitExit();
}


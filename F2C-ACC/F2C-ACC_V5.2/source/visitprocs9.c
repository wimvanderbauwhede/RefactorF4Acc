
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
void _VS1rule_854(_TPPrule_854 _currn)
#else
void _VS1rule_854(_currn )
_TPPrule_854 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATSym=IdnNumb(0, _currn->_ATTERM_1);
/*SPC(1175)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_854(_TPPrule_854 _currn)
#else
void _VS2rule_854(_currn )
_TPPrule_854 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNumber(_currn->_ATTERM_1);
/*SPC(6922)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_855(_TPPrule_855 _currn)
#else
void _VS1rule_855(_currn )
_TPPrule_855 _currn;

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
void _VS2rule_855(_TPPrule_855 _currn)
#else
void _VS2rule_855(_currn )
_TPPrule_855 _currn;

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
void _VS3rule_855(_TPPrule_855 _currn)
#else
void _VS3rule_855(_currn )
_TPPrule_855 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
void _VS4rule_855(_TPPrule_855 _currn)
#else
void _VS4rule_855(_currn )
_TPPrule_855 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_855(_TPPrule_855 _currn)
#else
void _VS5rule_855(_currn )
_TPPrule_855 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATVarType=_currn->_desc1->_ATFieldType;
/*SPC(1161)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATFieldType=_currn->_desc2->_ATFieldType;
/*SPC(1162)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_856(_TPPrule_856 _currn)
#else
void _VS1rule_856(_currn )
_TPPrule_856 _currn;

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
void _VS2rule_856(_TPPrule_856 _currn)
#else
void _VS2rule_856(_currn )
_TPPrule_856 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_856(_TPPrule_856 _currn)
#else
void _VS3rule_856(_currn )
_TPPrule_856 _currn;

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
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
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
void _VS4rule_856(_TPPrule_856 _currn)
#else
void _VS4rule_856(_currn )
_TPPrule_856 _currn;

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
void _VS5rule_856(_TPPrule_856 _currn)
#else
void _VS5rule_856(_currn )
_TPPrule_856 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATFieldType=GetType(_currn->_desc1->_ATUnitKey, NoKey);
/*SPC(1156)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_857(_TPPrule_857 _currn)
#else
void _VS1rule_857(_currn )
_TPPrule_857 _currn;

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
void _VS2rule_857(_TPPrule_857 _currn)
#else
void _VS2rule_857(_currn )
_TPPrule_857 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_857(_TPPrule_857 _currn)
#else
void _VS3rule_857(_currn )
_TPPrule_857 _currn;

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
void _VS4rule_857(_TPPrule_857 _currn)
#else
void _VS4rule_857(_currn )
_TPPrule_857 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_857(_TPPrule_857 _currn)
#else
void _VS5rule_857(_currn )
_TPPrule_857 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATvarType_RuleAttr_1314=GetType(_currn->_desc1->_AT_const67, NoKey);
/*SPC(1147)*/
_currn->_desc2->_ATUnitScope=GetUnitScope(_currn->_ATvarType_RuleAttr_1314, NoEnv);
/*SPC(1150)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATFieldType=GetType(_currn->_desc2->_ATUnitKey, NoKey);
/*SPC(1152)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_858(_TPPrule_858 _currn)
#else
void _VS1rule_858(_currn )
_TPPrule_858 _currn;

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
void _VS2rule_858(_TPPrule_858 _currn)
#else
void _VS2rule_858(_currn )
_TPPrule_858 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_858(_TPPrule_858 _currn)
#else
void _VS3rule_858(_currn )
_TPPrule_858 _currn;

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
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
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
void _VS4rule_858(_TPPrule_858 _currn)
#else
void _VS4rule_858(_currn )
_TPPrule_858 _currn;

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
void _VS5rule_858(_TPPrule_858 _currn)
#else
void _VS5rule_858(_currn )
_TPPrule_858 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const67=_currn->_desc1->_ATUnitKey;
/*SPC(1141)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_859(_TPPrule_859 _currn)
#else
void _VS1rule_859(_currn )
_TPPrule_859 _currn;

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
void _VS2rule_859(_TPPrule_859 _currn)
#else
void _VS2rule_859(_currn )
_TPPrule_859 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_859(_TPPrule_859 _currn)
#else
void _VS3rule_859(_currn )
_TPPrule_859 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
void _VS4rule_859(_TPPrule_859 _currn)
#else
void _VS4rule_859(_currn )
_TPPrule_859 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_859(_TPPrule_859 _currn)
#else
void _VS5rule_859(_currn )
_TPPrule_859 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const67=_currn->_desc1->_ATUnitKey;
/*SPC(1137)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_860(_TPPrule_860 _currn)
#else
void _VS1rule_860(_currn )
_TPPrule_860 _currn;

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
void _VS2rule_860(_TPPrule_860 _currn)
#else
void _VS2rule_860(_currn )
_TPPrule_860 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_860(_TPPrule_860 _currn)
#else
void _VS3rule_860(_currn )
_TPPrule_860 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_860(_TPPrule_860 _currn)
#else
void _VS4rule_860(_currn )
_TPPrule_860 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_860(_TPPrule_860 _currn)
#else
void _VS5rule_860(_currn )
_TPPrule_860 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const67=_currn->_desc1->_ATUnitKey;
/*SPC(1133)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_861(_TPPrule_861 _currn)
#else
void _VS1rule_861(_currn )
_TPPrule_861 _currn;

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
/*SPC(10530)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_861(_TPPrule_861 _currn)
#else
void _VS2rule_861(_currn )
_TPPrule_861 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_861(_TPPrule_861 _currn)
#else
void _VS3rule_861(_currn )
_TPPrule_861 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_861(_TPPrule_861 _currn)
#else
void _VS4rule_861(_currn )
_TPPrule_861 _currn;

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
void _VS5rule_861(_TPPrule_861 _currn)
#else
void _VS5rule_861(_currn )
_TPPrule_861 _currn;

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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_861(_TPPrule_861 _currn)
#else
void _VS6rule_861(_currn )
_TPPrule_861 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_861(_TPPrule_861 _currn)
#else
void _VS7rule_861(_currn )
_TPPrule_861 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_861(_TPPrule_861 _currn)
#else
void _VS8rule_861(_currn )
_TPPrule_861 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATVarType=_currn->_desc1->_ATFieldType;
/*SPC(1128)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATPtg=PTGNULL;
/*SPC(10528)*/
_currn->_ATFieldType=_currn->_desc2->_ATFieldType;
/*SPC(1129)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_862(_TPPrule_862 _currn)
#else
void _VS1rule_862(_currn )
_TPPrule_862 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10530)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_862(_TPPrule_862 _currn)
#else
void _VS2rule_862(_currn )
_TPPrule_862 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_862(_TPPrule_862 _currn)
#else
void _VS3rule_862(_currn )
_TPPrule_862 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_862(_TPPrule_862 _currn)
#else
void _VS4rule_862(_currn )
_TPPrule_862 _currn;

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
void _VS5rule_862(_TPPrule_862 _currn)
#else
void _VS5rule_862(_currn )
_TPPrule_862 _currn;

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
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
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
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_862(_TPPrule_862 _currn)
#else
void _VS6rule_862(_currn )
_TPPrule_862 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_862(_TPPrule_862 _currn)
#else
void _VS7rule_862(_currn )
_TPPrule_862 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_862(_TPPrule_862 _currn)
#else
void _VS8rule_862(_currn )
_TPPrule_862 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATVarType=GetType(_currn->_desc1->_ATUnitKey, NoKey);
/*SPC(1122)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATPtg=PTGNULL;
/*SPC(10528)*/
_currn->_ATFieldType=_currn->_desc2->_ATFieldType;
/*SPC(1124)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_863(_TPPrule_863 _currn)
#else
void _VS1rule_863(_currn )
_TPPrule_863 _currn;

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
/*SPC(4856)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_863(_TPPrule_863 _currn)
#else
void _VS2rule_863(_currn )
_TPPrule_863 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_863(_TPPrule_863 _currn)
#else
void _VS3rule_863(_currn )
_TPPrule_863 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_863(_TPPrule_863 _currn)
#else
void _VS4rule_863(_currn )
_TPPrule_863 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUnitId=_currn->_desc1->_ATUnitId;
/*SPC(4080)*/
_currn->_ATObjectId=_currn->_desc1->_ATObjectId;
/*SPC(4079)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_863(_TPPrule_863 _currn)
#else
void _VS5rule_863(_currn )
_TPPrule_863 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
void _VS6rule_863(_TPPrule_863 _currn)
#else
void _VS6rule_863(_currn )
_TPPrule_863 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_863(_TPPrule_863 _currn)
#else
void _VS7rule_863(_currn )
_TPPrule_863 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATVarType=_currn->_desc1->_ATFieldType;
/*SPC(1102)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATFieldType=_currn->_desc2->_ATFieldType;
/*SPC(1103)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_864(_TPPrule_864 _currn)
#else
void _VS1rule_864(_currn )
_TPPrule_864 _currn;

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
void _VS2rule_864(_TPPrule_864 _currn)
#else
void _VS2rule_864(_currn )
_TPPrule_864 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_864(_TPPrule_864 _currn)
#else
void _VS3rule_864(_currn )
_TPPrule_864 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_864(_TPPrule_864 _currn)
#else
void _VS4rule_864(_currn )
_TPPrule_864 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUnitId=_currn->_desc1->_ATUnitKey;
/*SPC(4075)*/
_currn->_ATObjectId=_currn->_desc1->_ATObjectKey;
/*SPC(4074)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_864(_TPPrule_864 _currn)
#else
void _VS5rule_864(_currn )
_TPPrule_864 _currn;

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
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_864(_TPPrule_864 _currn)
#else
void _VS6rule_864(_currn )
_TPPrule_864 _currn;

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
void _VS7rule_864(_TPPrule_864 _currn)
#else
void _VS7rule_864(_currn )
_TPPrule_864 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATFieldType=GetType(_currn->_desc1->_ATUnitKey, NoKey);
/*SPC(1097)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_865(_TPPrule_865 _currn)
#else
void _VS1rule_865(_currn )
_TPPrule_865 _currn;

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
void _VS2rule_865(_TPPrule_865 _currn)
#else
void _VS2rule_865(_currn )
_TPPrule_865 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_865(_TPPrule_865 _currn)
#else
void _VS3rule_865(_currn )
_TPPrule_865 _currn;

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
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_865(_TPPrule_865 _currn)
#else
void _VS4rule_865(_currn )
_TPPrule_865 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATVarType=_currn->_desc1->_ATFieldType;
/*SPC(991)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATFieldType=_currn->_desc2->_ATFieldType;
/*SPC(992)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_866(_TPPrule_866 _currn)
#else
void _VS1rule_866(_currn )
_TPPrule_866 _currn;

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
void _VS2rule_866(_TPPrule_866 _currn)
#else
void _VS2rule_866(_currn )
_TPPrule_866 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_866(_TPPrule_866 _currn)
#else
void _VS3rule_866(_currn )
_TPPrule_866 _currn;

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
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
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
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
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
void _VS4rule_866(_TPPrule_866 _currn)
#else
void _VS4rule_866(_currn )
_TPPrule_866 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATFieldType=GetType(_currn->_desc1->_ATUnitKey, NoKey);
/*SPC(986)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_867(_TPPrule_867 _currn)
#else
void _VS1rule_867(_currn )
_TPPrule_867 _currn;

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
void _VS4rule_867(_TPPrule_867 _currn)
#else
void _VS4rule_867(_currn )
_TPPrule_867 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_867(_TPPrule_867 _currn)
#else
void _VS5rule_867(_currn )
_TPPrule_867 _currn;

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
void _VS6rule_867(_TPPrule_867 _currn)
#else
void _VS6rule_867(_currn )
_TPPrule_867 _currn;

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
void _VS7rule_867(_TPPrule_867 _currn)
#else
void _VS7rule_867(_currn )
_TPPrule_867 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_867(_TPPrule_867 _currn)
#else
void _VS8rule_867(_currn )
_TPPrule_867 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUnitScope=GetUnitScope(_currn->_ATVarType, NoEnv);
/*SPC(979)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATFieldType=GetType(_currn->_desc1->_ATUnitKey, NoKey);
/*SPC(981)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_868(_TPPrule_868 _currn)
#else
void _VS1rule_868(_currn )
_TPPrule_868 _currn;

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
void _VS2rule_868(_TPPrule_868 _currn)
#else
void _VS2rule_868(_currn )
_TPPrule_868 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_868(_TPPrule_868 _currn)
#else
void _VS3rule_868(_currn )
_TPPrule_868 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_868(_TPPrule_868 _currn)
#else
void _VS4rule_868(_currn )
_TPPrule_868 _currn;

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
void _VS5rule_868(_TPPrule_868 _currn)
#else
void _VS5rule_868(_currn )
_TPPrule_868 _currn;

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
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_868(_TPPrule_868 _currn)
#else
void _VS6rule_868(_currn )
_TPPrule_868 _currn;

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
void _VS7rule_868(_TPPrule_868 _currn)
#else
void _VS7rule_868(_currn )
_TPPrule_868 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_868(_TPPrule_868 _currn)
#else
void _VS8rule_868(_currn )
_TPPrule_868 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATUnitScope=GetUnitScope(_currn->_ATVarType, NoEnv);
/*SPC(973)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATFieldType=GetType(_currn->_desc2->_ATUnitKey, NoKey);
/*SPC(975)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_869(_TPPrule_869 _currn)
#else
void _VS1rule_869(_currn )
_TPPrule_869 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_desc2->_ATUnitEnv=NewScope((* _IG_incl23));
/*SPC(26)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_869(_TPPrule_869 _currn)
#else
void _VS2rule_869(_currn )
_TPPrule_869 _currn;

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
void _VS3rule_869(_TPPrule_869 _currn)
#else
void _VS3rule_869(_currn )
_TPPrule_869 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=MAX(MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45), _currn->_desc3->_AT_const45);
/*SPC(958)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_869(_TPPrule_869 _currn)
#else
void _VS4rule_869(_currn )
_TPPrule_869 _currn;

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
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATUnitScopeKey=_currn->_desc1->_AT_const68;
/*SPC(959)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
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
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_869(_TPPrule_869 _currn)
#else
void _VS5rule_869(_currn )
_TPPrule_869 _currn;

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
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_870(_TPPrule_870 _currn)
#else
void _VS1rule_870(_currn )
_TPPrule_870 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_870(_TPPrule_870 _currn)
#else
void _VS2rule_870(_currn )
_TPPrule_870 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_870(_TPPrule_870 _currn)
#else
void _VS3rule_870(_currn )
_TPPrule_870 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(957)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_870(_TPPrule_870 _currn)
#else
void _VS4rule_870(_currn )
_TPPrule_870 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
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
ResetUnitScope(_currn->_ATUnitScopeKey, _currn->_ATUnitEnv);
/*SPC(117)*/
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_870(_TPPrule_870 _currn)
#else
void _VS5rule_870(_currn )
_TPPrule_870 _currn;

#endif
{
Environment* _IL_incl23;

_VisitVarDecl()
_VisitEntry();
_IL_incl23=_IG_incl23;_IG_incl23= &(_currn->_ATUnitEnv);
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
_IG_incl23=_IL_incl23;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_871(_TPPrule_871 _currn)
#else
void _VS1rule_871(_currn )
_TPPrule_871 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_ATType=_currn->_desc1->_ATType;
/*SPC(947)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_871(_TPPrule_871 _currn)
#else
void _VS3rule_871(_currn )
_TPPrule_871 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_871(_TPPrule_871 _currn)
#else
void _VS4rule_871(_currn )
_TPPrule_871 _currn;

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
void _VS5rule_871(_TPPrule_871 _currn)
#else
void _VS5rule_871(_currn )
_TPPrule_871 _currn;

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
void _VS6rule_871(_TPPrule_871 _currn)
#else
void _VS6rule_871(_currn )
_TPPrule_871 _currn;

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
void _VS1rule_872(_TPPrule_872 _currn)
#else
void _VS1rule_872(_currn )
_TPPrule_872 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATType=_currn->_desc1->_ATUnitKey;
/*SPC(942)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_872(_TPPrule_872 _currn)
#else
void _VS2rule_872(_currn )
_TPPrule_872 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATSym=_currn->_desc1->_ATSym;
/*SPC(943)*/
_currn->_ATUnitBind=BindingInEnv((* _IG_incl23), _currn->_ATSym);
/*SPC(59)*/
_currn->_ATUnitKey=KeyOf(_currn->_ATUnitBind);
/*SPC(63)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_873(_TPPrule_873 _currn)
#else
void _VS1rule_873(_currn )
_TPPrule_873 _currn;

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
void _VS2rule_873(_TPPrule_873 _currn)
#else
void _VS2rule_873(_currn )
_TPPrule_873 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_873(_TPPrule_873 _currn)
#else
void _VS3rule_873(_currn )
_TPPrule_873 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_873(_TPPrule_873 _currn)
#else
void _VS4rule_873(_currn )
_TPPrule_873 _currn;

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
void _VS5rule_873(_TPPrule_873 _currn)
#else
void _VS5rule_873(_currn )
_TPPrule_873 _currn;

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
void _VS6rule_873(_TPPrule_873 _currn)
#else
void _VS6rule_873(_currn )
_TPPrule_873 _currn;

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
_currn->_ATValue=IndCatStrStr(CatStrStr(StringTable(MakeName("(")), StringTable(_currn->_desc1->_ATValue)), StringTable(MakeName(")")));
/*SPC(866)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_873(_TPPrule_873 _currn)
#else
void _VS7rule_873(_currn )
_TPPrule_873 _currn;

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
void _VS8rule_873(_TPPrule_873 _currn)
#else
void _VS8rule_873(_currn )
_TPPrule_873 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const33=_currn->_desc1->_AT_const33;
/*SPC(865)*/
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
_currn->_ATPtg=PTGExpr(_currn->_desc1->_ATPtg);
/*SPC(8972)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_873(_TPPrule_873 _currn)
#else
void _VS9rule_873(_currn )
_TPPrule_873 _currn;

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
/*SPC(865)*/
_currn->_AT_const32=_currn->_desc1->_AT_const32;
/*SPC(865)*/
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
void _VS10rule_873(_TPPrule_873 _currn)
#else
void _VS10rule_873(_currn )
_TPPrule_873 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATArgType=PTGNULL;
/*SPC(5880)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_873(_TPPrule_873 _currn)
#else
void _VS11rule_873(_currn )
_TPPrule_873 _currn;

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
void _VS12rule_873(_TPPrule_873 _currn)
#else
void _VS12rule_873(_currn )
_TPPrule_873 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=_currn->_desc1->_AT_const34;
/*SPC(865)*/
_currn->_AT_const50=ADD(_currn->_desc1->_AT_const50, IDENTICAL(_currn->_desc1->_ATConstantUsed));
/*SPC(865)*/
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(865)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(865)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(865)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(865)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_874(_TPPrule_874 _currn)
#else
void _VS1rule_874(_currn )
_TPPrule_874 _currn;

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
void _VS2rule_874(_TPPrule_874 _currn)
#else
void _VS2rule_874(_currn )
_TPPrule_874 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_874(_TPPrule_874 _currn)
#else
void _VS3rule_874(_currn )
_TPPrule_874 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_874(_TPPrule_874 _currn)
#else
void _VS4rule_874(_currn )
_TPPrule_874 _currn;

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
void _VS5rule_874(_TPPrule_874 _currn)
#else
void _VS5rule_874(_currn )
_TPPrule_874 _currn;

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
void _VS6rule_874(_TPPrule_874 _currn)
#else
void _VS6rule_874(_currn )
_TPPrule_874 _currn;

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
_currn->_ATValue=IndCatStrStr(CatStrStr(StringTable(_currn->_desc1->_ATValue), StringTable(_currn->_desc2->_ATValue)), StringTable(_currn->_desc3->_ATValue));
/*SPC(851)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_874(_TPPrule_874 _currn)
#else
void _VS7rule_874(_currn )
_TPPrule_874 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATexact_RuleAttr_1331=
((AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), AND(EQ(_currn->_desc2->_ATPowerFunct, TRUE), NE(_currn->_desc3->_ATExpValue, 2)))
) ? (
((AND(EQ(GetClpValue(Exact, 0), CPU), AND(NE(_currn->_ATTranslationType_pre, GPU), EQ(_currn->_ATAcceleratorRegion_pre, FALSE)))
) ? (CPU
) : (
((AND(EQ(GetClpValue(Exact, 0), GPU), OR(EQ(_currn->_ATTranslationType_pre, GPU), EQ(_currn->_ATAcceleratorRegion_pre, TRUE)))
) ? (GPU
) : (FALSE))
))

) : (FALSE))
;
/*SPC(9183)*/

if (AND(EQ(_currn->_ATexact_RuleAttr_1331, CPU), EQ(_currn->_ATDeclPowerVars_pre, FALSE))) {
PTGOut(PTGAppend(PTGNumber(_currn->_ATLastNonExecLine_pre), PTGPowerVarsFloat()));

} else {
}
;
/*SPC(9221)*/
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
_currn->_desc1->_ATDeclPowerVars_pre=
((AND(EQ(_currn->_ATexact_RuleAttr_1331, CPU), EQ(_currn->_ATDeclPowerVars_pre, FALSE))
) ? (TRUE
) : (_currn->_ATDeclPowerVars_pre))
;
/*SPC(9229)*/
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
_currn->_ATDeclsOrder_post=_currn->_desc3->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_desc3->_ATArgCnt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_desc3->_ATArraySym_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_874(_TPPrule_874 _currn)
#else
void _VS8rule_874(_currn )
_TPPrule_874 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(OR(EQ(GetClpValue(Analysis, 0), 0), EQ(GetClpValue(Analysis, 1), GLOBAL_MEMORY)), EQ((* _IG_incl53), TRUE))) {
message(NOTE, "The first argument will be the type specified for the function prototype.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(5908)*/
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const33=ADD(_currn->_desc1->_AT_const33, _currn->_desc3->_AT_const33);
/*SPC(849)*/

if (EQ(_currn->_ATexact_RuleAttr_1331, CPU)) {
PTGOut(PTGAppend(PTGNumber(SUB(MapLine(((_currn->_AT_pos).line)), 1)), PTGPowerVarsInit(PTGIndent(_currn->_ATIndentLevel_pre), _currn->_desc1->_ATPtg, PTGIndent(_currn->_ATIndentLevel_pre), _currn->_desc3->_ATPtg)));

} else {
}
;
/*SPC(9213)*/
_currn->_ATFunctionName=PTGNULL;
/*SPC(8976)*/
_currn->_ATDemoted=ADD(_currn->_desc1->_ATDemoted, _currn->_desc3->_ATDemoted);
/*SPC(7824)*/
_currn->_ATLoopIncrNeg=
((EQ(MOD(ZERO(), 2), 1)
) ? (TRUE
) : (FALSE))
;
/*SPC(7687)*/
_currn->_ATArrayId_post=_currn->_desc3->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=
((EQ(_currn->_desc2->_ATPowerFunct, TRUE)
) ? (
((EQ(_currn->_desc3->_ATExpValue, 2)
) ? (PTGSQRmacro(_currn->_desc1->_ATPtg)
) : (
((EQ(_currn->_ATexact_RuleAttr_1331, CPU)
) ? (PTGPowerExprFTN()
) : (PTGPowerExpr(_currn->_desc1->_ATPtg, _currn->_desc3->_ATPtg)))
))

) : (PTGExprArgs(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg, _currn->_desc3->_ATPtg)))
;
/*SPC(9201)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_874(_TPPrule_874 _currn)
#else
void _VS9rule_874(_currn )
_TPPrule_874 _currn;

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
/*SPC(849)*/
_currn->_AT_const32=ADD(ADD(_currn->_desc1->_AT_const32, IDENTICAL(_currn->_desc2->_ATCnt)), _currn->_desc3->_AT_const32);
/*SPC(849)*/
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
void _VS10rule_874(_TPPrule_874 _currn)
#else
void _VS10rule_874(_currn )
_TPPrule_874 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATArgType=_currn->_desc1->_ATArgType;
/*SPC(5904)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_874(_TPPrule_874 _currn)
#else
void _VS11rule_874(_currn )
_TPPrule_874 _currn;

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
void _VS12rule_874(_TPPrule_874 _currn)
#else
void _VS12rule_874(_currn )
_TPPrule_874 _currn;

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
_currn->_AT_const34=ADD(ADD(_currn->_desc1->_AT_const34, IDENTICAL(_currn->_desc2->_ATCnt)), _currn->_desc3->_AT_const34);
/*SPC(849)*/
_currn->_AT_const50=ADD(ADD(_currn->_desc1->_AT_const50, IDENTICAL(_currn->_desc1->_ATConstantUsed)), ADD(_currn->_desc3->_AT_const50, IDENTICAL(_currn->_desc3->_ATConstantUsed)));
/*SPC(849)*/
_currn->_AT_const63=ADD(_currn->_desc1->_AT_const63, _currn->_desc3->_AT_const63);
/*SPC(849)*/
_currn->_AT_const64=ADD(_currn->_desc1->_AT_const64, _currn->_desc3->_AT_const64);
/*SPC(849)*/
_currn->_AT_const65=ADD(_currn->_desc1->_AT_const65, _currn->_desc3->_AT_const65);
/*SPC(849)*/
_currn->_AT_const66=ADD(_currn->_desc1->_AT_const66, _currn->_desc3->_AT_const66);
/*SPC(849)*/
_currn->_ATDepth_post=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_875(_TPPrule_875 _currn)
#else
void _VS1rule_875(_currn )
_TPPrule_875 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("F2C-ACC: xBinOp not supported.");
/*SPC(9154)*/
_currn->_ATPowerFunct=TRUE;
/*SPC(9152)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("**");
/*SPC(848)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_876(_TPPrule_876 _currn)
#else
void _VS1rule_876(_currn )
_TPPrule_876 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("/");
/*SPC(9158)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("/");
/*SPC(847)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_877(_TPPrule_877 _currn)
#else
void _VS1rule_877(_currn )
_TPPrule_877 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("*");
/*SPC(9157)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("*");
/*SPC(846)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_878(_TPPrule_878 _currn)
#else
void _VS1rule_878(_currn )
_TPPrule_878 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("-");
/*SPC(9156)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("-");
/*SPC(845)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_879(_TPPrule_879 _currn)
#else
void _VS1rule_879(_currn )
_TPPrule_879 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("+");
/*SPC(9155)*/
_currn->_ATPowerFunct=FALSE;
/*SPC(9151)*/
_currn->_ATCnt=1;
/*SPC(4137)*/
_currn->_ATValue=MakeName("+");
/*SPC(844)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_880(_TPPrule_880 _currn)
#else
void _VS1rule_880(_currn )
_TPPrule_880 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("+");
/*SPC(9144)*/
_currn->_ATLoopIncrNeg=FALSE;
/*SPC(7684)*/
_currn->_ATValue=MakeName("+");
/*SPC(842)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_881(_TPPrule_881 _currn)
#else
void _VS1rule_881(_currn )
_TPPrule_881 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("-");
/*SPC(9143)*/
_currn->_ATLoopIncrNeg=TRUE;
/*SPC(7685)*/
_currn->_ATValue=MakeName("-");
/*SPC(841)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_882(_TPPrule_882 _currn)
#else
void _VS1rule_882(_currn )
_TPPrule_882 _currn;

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
void _VS2rule_882(_TPPrule_882 _currn)
#else
void _VS2rule_882(_currn )
_TPPrule_882 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_882(_TPPrule_882 _currn)
#else
void _VS3rule_882(_currn )
_TPPrule_882 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_882(_TPPrule_882 _currn)
#else
void _VS4rule_882(_currn )
_TPPrule_882 _currn;

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
void _VS5rule_882(_TPPrule_882 _currn)
#else
void _VS5rule_882(_currn )
_TPPrule_882 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_882(_TPPrule_882 _currn)
#else
void _VS6rule_882(_currn )
_TPPrule_882 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATExpValue=0;
/*SPC(9238)*/
_currn->_ATObjectId=NoKey;
/*SPC(3838)*/
_currn->_ATValue=IndCatStrStr(StringTable(_currn->_desc1->_ATValue), StringTable(_currn->_desc2->_ATValue));
/*SPC(833)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_882(_TPPrule_882 _currn)
#else
void _VS7rule_882(_currn )
_TPPrule_882 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
void _VS8rule_882(_TPPrule_882 _currn)
#else
void _VS8rule_882(_currn )
_TPPrule_882 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const33=_currn->_desc2->_AT_const33;
/*SPC(831)*/
_currn->_ATFunctionName=PTGNULL;
/*SPC(8976)*/
_currn->_ATDemoted=FALSE;
/*SPC(7814)*/
_currn->_ATLoopIncrNeg=
((EQ(MOD(IDENTICAL(_currn->_desc1->_ATLoopIncrNeg), 2), 1)
) ? (TRUE
) : (FALSE))
;
/*SPC(7687)*/
_currn->_ATArrayId_post=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=PTGSequence(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg);
/*SPC(9147)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_882(_TPPrule_882 _currn)
#else
void _VS9rule_882(_currn )
_TPPrule_882 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_AT_const18=_currn->_desc2->_AT_const18;
/*SPC(831)*/
_currn->_AT_const32=_currn->_desc2->_AT_const32;
/*SPC(831)*/
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
void _VS10rule_882(_TPPrule_882 _currn)
#else
void _VS10rule_882(_currn )
_TPPrule_882 _currn;

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
void _VS11rule_882(_TPPrule_882 _currn)
#else
void _VS11rule_882(_currn )
_TPPrule_882 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
void _VS12rule_882(_TPPrule_882 _currn)
#else
void _VS12rule_882(_currn )
_TPPrule_882 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const34=_currn->_desc2->_AT_const34;
/*SPC(831)*/
_currn->_AT_const50=ADD(_currn->_desc2->_AT_const50, IDENTICAL(_currn->_desc2->_ATConstantUsed));
/*SPC(831)*/
_currn->_AT_const63=_currn->_desc2->_AT_const63;
/*SPC(831)*/
_currn->_AT_const64=_currn->_desc2->_AT_const64;
/*SPC(831)*/
_currn->_AT_const65=_currn->_desc2->_AT_const65;
/*SPC(831)*/
_currn->_AT_const66=_currn->_desc2->_AT_const66;
/*SPC(831)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_883(_TPPrule_883 _currn)
#else
void _VS1rule_883(_currn )
_TPPrule_883 _currn;

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
void _VS2rule_883(_TPPrule_883 _currn)
#else
void _VS2rule_883(_currn )
_TPPrule_883 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_883(_TPPrule_883 _currn)
#else
void _VS3rule_883(_currn )
_TPPrule_883 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_883(_TPPrule_883 _currn)
#else
void _VS4rule_883(_currn )
_TPPrule_883 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_883(_TPPrule_883 _currn)
#else
void _VS5rule_883(_currn )
_TPPrule_883 _currn;

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
void _VS6rule_883(_TPPrule_883 _currn)
#else
void _VS6rule_883(_currn )
_TPPrule_883 _currn;

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
_currn->_ATValue=
((EQ(GetValue(_currn->_desc1->_ATObjectKey, 0), 0)
) ? (_currn->_desc1->_ATSym
) : (GetValue(_currn->_desc1->_ATObjectKey, 0)))
;
/*SPC(824)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_883(_TPPrule_883 _currn)
#else
void _VS7rule_883(_currn )
_TPPrule_883 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())), AND(EQ((* _IG_incl34), ASSIGN), AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))))) {
message(WARNING, "Fortran 90 array assignments in ACC$REGIONs are not supported.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(7961)*/
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
void _VS8rule_883(_TPPrule_883 _currn)
#else
void _VS8rule_883(_currn )
_TPPrule_883 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const33=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(822)*/
_currn->_ATdeclLine_RuleAttr_1340=
((EQ(_currn->_ATAcceleratorRegion_pre, FALSE)
) ? ((* _IG_incl38)
) : (_currn->_ATAcceleratorRegion_pre))
;
/*SPC(4276)*/
_currn->_ATrank_RuleAttr_1340=GetNumberOfDims(_currn->_desc1->_ATUnitKey, 0);
/*SPC(7964)*/
_currn->_ATFunctionName=PTGNULL;
/*SPC(8976)*/
_currn->_ATDemoted=_currn->_desc1->_ATDemoted;
/*SPC(7816)*/
_currn->_ATLoopIncrNeg=
((EQ(MOD(ZERO(), 2), 1)
) ? (TRUE
) : (FALSE))
;
/*SPC(7687)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATarrayRef_RuleAttr_1340=
((InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS()))
) ? (PTGArrayRef(_currn->_desc1->_ATPtg, FTNREFCPP(_currn->_desc1->_ATSym, _currn->_desc1->_ATRegionVars_post, _currn->_desc1->_ATAcceleratorRegion_post, _currn->_ATdeclLine_RuleAttr_1340, _currn->_desc1->_ATUnitKey, _currn->_desc1->_ATObjectKey, GenerateLoopIndices(_currn->_ATrank_RuleAttr_1340), (&( _currn->_AT_pos)), _currn->_desc1->_ATGPUVarsDeList_post))
) : (PTGNULL))
;
/*SPC(4281)*/
_currn->_ATPtg=
((OR(EQ((* _IG_incl58), TRUE), EQ((* _IG_incl57), TRUE))
) ? (GetVariableConstantValue(_currn->_desc1->_ATObjectKey, PTGNULL)
) : (
((AND(EQ(_currn->_ATTranslationType_pre, FORTRAN), AND(EQ(_currn->_ATAcceleratorRegion_pre, FALSE), EQ(GetGPUVarProperty(_currn->_desc1->_ATSym, _currn->_desc1->_ATGPUVarsDeList_post, SCOPE, 0), EXTERN_ROUTINE)))
) ? (PTGDeviceName(_currn->_desc1->_ATPtg)
) : (
((AND(EQ((* _IG_incl34), ASSIGN), InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())))
) ? (_currn->_ATarrayRef_RuleAttr_1340
) : (_currn->_desc1->_ATPtg))
))
))
;
/*SPC(4299)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_883(_TPPrule_883 _currn)
#else
void _VS9rule_883(_currn )
_TPPrule_883 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), EQ((* _IG_incl50), TRUE))) {
UserConstants(_currn->_desc1->_ATObjectKey, _currn->_desc1->_ATSym);

} else {
}
;
/*SPC(4269)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(4274)*/
_currn->_desc1->_ATUpdate_pre=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATNestLevel_pre=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_desc1->_ATMaxRank_pre=
((AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), AND(OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)), AND(EQ((* _IG_incl34), ASSIGN), AND(InIS(Array, GetKindSet(_currn->_desc1->_ATUnitKey, NullIS())), LT(_currn->_ATMaxRank_pre, _currn->_ATrank_RuleAttr_1340)))))
) ? (SetRankDefineLoopVars(_currn->_ATrank_RuleAttr_1340, _currn->_ATMaxRank_pre, _currn->_ATLastNonExecLine_pre, _currn->_desc1->_ATIndentLevel_post, MapLine(((_currn->_AT_pos).line)))
) : (_currn->_ATMaxRank_pre))
;
/*SPC(7965)*/
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
_currn->_desc1->_ATignoreVar=
((EQ((* _IG_incl57), TRUE)
) ? (TRUE
) : (FALSE))
;
/*SPC(5176)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const18=IDENTICAL(_currn->_desc1->_ATMatch);
/*SPC(822)*/
_currn->_AT_const32=ZERO();
/*SPC(822)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATCPURegionNumber_post=_currn->_desc1->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=
((AND(EQ((* _IG_incl59), TRUE), GE(GetVariableConstant(_currn->_desc1->_ATObjectKey, 0), TRUE))
) ? (Convert_to_int(StringTable(GetVariableConstant(_currn->_desc1->_ATObjectKey, 0)))
) : (_currn->_desc1->_ATTypeLength_post))
;
/*SPC(4616)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATMaxRank_post=_currn->_desc1->_ATMaxRank_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_883(_TPPrule_883 _currn)
#else
void _VS10rule_883(_currn )
_TPPrule_883 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATtypeLen_RuleAttr_1340=GetTypeLength(_currn->_desc1->_ATUnitKey, 0);
/*SPC(5882)*/
_currn->_ATtype_RuleAttr_1340=GetType(_currn->_desc1->_ATUnitKey, ErrorType);
/*SPC(5883)*/
_currn->_ATpointer_RuleAttr_1340=
((AND(EQ(GetNumberOfDims(_currn->_desc1->_ATUnitKey, 0), 0), NE(_currn->_ATtype_RuleAttr_1340, CharacterType))
) ? (PTGNULL
) : (PTGAsIs("*")))
;
/*SPC(5888)*/
_currn->_ATArgType=PTGSubroutineArg(Convert_to_Ctype(_currn->_ATtypeLen_RuleAttr_1340, _currn->_ATtype_RuleAttr_1340), _currn->_ATpointer_RuleAttr_1340, PTGNULL);
/*SPC(5895)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_883(_TPPrule_883 _currn)
#else
void _VS11rule_883(_currn )
_TPPrule_883 _currn;

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
void _VS12rule_883(_TPPrule_883 _currn)
#else
void _VS12rule_883(_currn )
_TPPrule_883 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=ZERO();
/*SPC(822)*/
_currn->_AT_const50=ZERO();
/*SPC(822)*/
_currn->_AT_const63=ZERO();
/*SPC(822)*/
_currn->_AT_const64=IDENTICAL(_currn->_desc1->_ATPar1);
/*SPC(822)*/
_currn->_AT_const65=IDENTICAL(_currn->_desc1->_ATPar2);
/*SPC(822)*/
_currn->_AT_const66=IDENTICAL(_currn->_desc1->_ATPar3);
/*SPC(822)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (AND(EQ(_currn->_ATTranslationType_pre, FORTRAN), AND(EQ(_currn->_ATAcceleratorRegion_pre, FALSE), AND(EQ(GetVariableDeclaredGPU(_currn->_desc1->_ATObjectKey, 0), FALSE), EQ(GetGPUVarProperty(_currn->_desc1->_ATSym, _currn->_desc1->_ATGPUVarsDeList_post, SCOPE, 0), EXTERN_ROUTINE))))) {
PTGOut(PTGDeclareVar(PTGNumber(_currn->_ATLastNonExecLine_pre), PTGNULL, PTGNULL, Convert_to_Ctype(GetTypeLength(_currn->_desc1->_ATUnitKey, 0), GetType(_currn->_desc1->_ATUnitKey, ErrorType)), PTGPointer(PTGDeviceName(_currn->_desc1->_ATPtg))));

} else {
}
;

} else {
}
;
/*SPC(4318)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (AND(EQ(_currn->_ATTranslationType_pre, FORTRAN), AND(EQ(_currn->_ATAcceleratorRegion_pre, FALSE), AND(EQ(GetVariableDeclaredGPU(_currn->_desc1->_ATObjectKey, 0), FALSE), EQ(GetGPUVarProperty(_currn->_desc1->_ATSym, _currn->_desc1->_ATGPUVarsDeList_post, SCOPE, 0), EXTERN_ROUTINE))))) {
ResetVariableDeclaredGPU(_currn->_desc1->_ATObjectKey, TRUE);

} else {
}
;

} else {
}
;
/*SPC(4344)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_884(_TPPrule_884 _currn)
#else
void _VS1rule_884(_currn )
_TPPrule_884 _currn;

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
void _VS2rule_884(_TPPrule_884 _currn)
#else
void _VS2rule_884(_currn )
_TPPrule_884 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_884(_TPPrule_884 _currn)
#else
void _VS3rule_884(_currn )
_TPPrule_884 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_884(_TPPrule_884 _currn)
#else
void _VS4rule_884(_currn )
_TPPrule_884 _currn;

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
void _VS5rule_884(_TPPrule_884 _currn)
#else
void _VS5rule_884(_currn )
_TPPrule_884 _currn;

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
void _VS6rule_884(_TPPrule_884 _currn)
#else
void _VS6rule_884(_currn )
_TPPrule_884 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_currn->_ATExpValue=_currn->_desc1->_ATExpValue;
/*SPC(9240)*/
_currn->_ATObjectId=NoKey;
/*SPC(3838)*/
_currn->_ATValue=_currn->_desc1->_ATValue;
/*SPC(819)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_884(_TPPrule_884 _currn)
#else
void _VS7rule_884(_currn )
_TPPrule_884 _currn;

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
void _VS8rule_884(_TPPrule_884 _currn)
#else
void _VS8rule_884(_currn )
_TPPrule_884 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const33=_currn->_desc1->_AT_const33;
/*SPC(817)*/
_currn->_ATFunctionName=PTGNULL;
/*SPC(8976)*/
_currn->_ATDemoted=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetGPUVarProperty(_currn->_ATArraySym_pre, _currn->_ATGPUVarsDeList_pre, DEMOTEDIM, _currn->_ATLocalIndex_pre), TRUE))
) ? (TRUE
) : (FALSE))
;
/*SPC(7805)*/
_currn->_ATLoopIncrNeg=
((EQ(MOD(ZERO(), 2), 1)
) ? (TRUE
) : (FALSE))
;
/*SPC(7687)*/
_currn->_ATArrayId_post=_currn->_desc1->_ATArrayId_post;
/*SPC(0)*/
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(8968)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_884(_TPPrule_884 _currn)
#else
void _VS9rule_884(_currn )
_TPPrule_884 _currn;

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
/*SPC(817)*/
_currn->_AT_const32=_currn->_desc1->_AT_const32;
/*SPC(817)*/
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
_currn->_ATTypeLength_post=
((EQ((* _IG_incl59), TRUE)
) ? (Convert_to_int(StringTable(_currn->_desc1->_ATSym))
) : (_currn->_ATTypeLength_pre))
;
/*SPC(4608)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_884(_TPPrule_884 _currn)
#else
void _VS10rule_884(_currn )
_TPPrule_884 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATArgType=_currn->_desc1->_ATArgType;
/*SPC(5931)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_884(_TPPrule_884 _currn)
#else
void _VS11rule_884(_currn )
_TPPrule_884 _currn;

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
void _VS12rule_884(_TPPrule_884 _currn)
#else
void _VS12rule_884(_currn )
_TPPrule_884 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const34=_currn->_desc1->_AT_const34;
/*SPC(817)*/
_currn->_AT_const50=ADD(_currn->_desc1->_AT_const50, IDENTICAL(_currn->_desc1->_ATConstantUsed));
/*SPC(817)*/
_currn->_AT_const63=_currn->_desc1->_AT_const63;
/*SPC(817)*/
_currn->_AT_const64=_currn->_desc1->_AT_const64;
/*SPC(817)*/
_currn->_AT_const65=_currn->_desc1->_AT_const65;
/*SPC(817)*/
_currn->_AT_const66=_currn->_desc1->_AT_const66;
/*SPC(817)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12819)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_885(_TPPrule_885 _currn)
#else
void _VS1rule_885(_currn )
_TPPrule_885 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_885(_TPPrule_885 _currn)
#else
void _VS4rule_885(_currn )
_TPPrule_885 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_885(_TPPrule_885 _currn)
#else
void _VS5rule_885(_currn )
_TPPrule_885 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_885(_TPPrule_885 _currn)
#else
void _VS6rule_885(_currn )
_TPPrule_885 _currn;

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
_currn->_ATValue=IdnNumb(0, _currn->_ATTERM_1);
/*SPC(814)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_885(_TPPrule_885 _currn)
#else
void _VS7rule_885(_currn )
_TPPrule_885 _currn;

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
void _VS8rule_885(_TPPrule_885 _currn)
#else
void _VS8rule_885(_currn )
_TPPrule_885 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const33=ZERO();
/*SPC(812)*/
_currn->_ATFunctionName=PTGNULL;
/*SPC(8976)*/
_currn->_ATDemoted=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetGPUVarProperty(_currn->_ATArraySym_pre, _currn->_ATGPUVarsDeList_pre, DEMOTEDIM, _currn->_ATLocalIndex_pre), TRUE))
) ? (TRUE
) : (FALSE))
;
/*SPC(7796)*/
_currn->_ATLoopIncrNeg=
((EQ(MOD(ZERO(), 2), 1)
) ? (TRUE
) : (FALSE))
;
/*SPC(7687)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNumber(_currn->_ATTERM_1);
/*SPC(8960)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_885(_TPPrule_885 _currn)
#else
void _VS9rule_885(_currn )
_TPPrule_885 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const18=ZERO();
/*SPC(812)*/
_currn->_AT_const32=ZERO();
/*SPC(812)*/
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
void _VS10rule_885(_TPPrule_885 _currn)
#else
void _VS10rule_885(_currn )
_TPPrule_885 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATArgType=PTGNULL;
/*SPC(5880)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS11rule_885(_TPPrule_885 _currn)
#else
void _VS11rule_885(_currn )
_TPPrule_885 _currn;

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
void _VS12rule_885(_TPPrule_885 _currn)
#else
void _VS12rule_885(_currn )
_TPPrule_885 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const34=ZERO();
/*SPC(812)*/
_currn->_AT_const50=ZERO();
/*SPC(812)*/
_currn->_AT_const63=ZERO();
/*SPC(812)*/
_currn->_AT_const64=ZERO();
/*SPC(812)*/
_currn->_AT_const65=ZERO();
/*SPC(812)*/
_currn->_AT_const66=ZERO();
/*SPC(812)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATConstantUsed=CheckArray(_currn->_ATGPURegionNumber_pre, _currn->_ATArrayId_pre, _currn->_ATRegionVars_pre, _currn->_ATDoAcc_pre, _currn->_ATLocalIndex_pre);
/*SPC(12821)*/
_currn->_ATUnitId=NoKey;
/*SPC(3839)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_886(_TPPrule_886 _currn)
#else
void _VS1rule_886(_currn )
_TPPrule_886 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_886(_TPPrule_886 _currn)
#else
void _VS2rule_886(_currn )
_TPPrule_886 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_886(_TPPrule_886 _currn)
#else
void _VS3rule_886(_currn )
_TPPrule_886 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATPtg=PTGAsIs("FALSE");
/*SPC(4586)*/
_currn->_ATValue=IdnNumb(0, 0);
/*SPC(805)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_887(_TPPrule_887 _currn)
#else
void _VS1rule_887(_currn )
_TPPrule_887 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_887(_TPPrule_887 _currn)
#else
void _VS2rule_887(_currn )
_TPPrule_887 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_887(_TPPrule_887 _currn)
#else
void _VS3rule_887(_currn )
_TPPrule_887 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATPtg=PTGAsIs("TRUE");
/*SPC(4582)*/
_currn->_ATValue=IdnNumb(0, 1);
/*SPC(801)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_888(_TPPrule_888 _currn)
#else
void _VS1rule_888(_currn )
_TPPrule_888 _currn;

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
void _VS2rule_888(_TPPrule_888 _currn)
#else
void _VS2rule_888(_currn )
_TPPrule_888 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_888(_TPPrule_888 _currn)
#else
void _VS4rule_888(_currn )
_TPPrule_888 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_888(_TPPrule_888 _currn)
#else
void _VS5rule_888(_currn )
_TPPrule_888 _currn;

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
void _VS6rule_888(_TPPrule_888 _currn)
#else
void _VS6rule_888(_currn )
_TPPrule_888 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATExpValue=0;
/*SPC(9243)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_888(_TPPrule_888 _currn)
#else
void _VS7rule_888(_currn )
_TPPrule_888 _currn;

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
void _VS8rule_888(_TPPrule_888 _currn)
#else
void _VS8rule_888(_currn )
_TPPrule_888 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const33=ZERO();
/*SPC(796)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATPtg=
((EQ(_currn->_desc1->_ATTypeLen, 8)
) ? (ConstantHandling(StringTable(_currn->_ATTERM_1), DOUBLE)
) : (ConstantHandling(StringTable(_currn->_ATTERM_1), REAL)))
;
/*SPC(7003)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_888(_TPPrule_888 _currn)
#else
void _VS9rule_888(_currn )
_TPPrule_888 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const18=ZERO();
/*SPC(796)*/
_currn->_AT_const32=ZERO();
/*SPC(796)*/
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
_currn->_ATArgType=Convert_to_Ctype(8, DoublePrecisionType);
/*SPC(5960)*/
_currn->_ATSym=IdnNumb(0, _currn->_ATTERM_1);
/*SPC(7002)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_888(_TPPrule_888 _currn)
#else
void _VS10rule_888(_currn )
_TPPrule_888 _currn;

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
void _VS11rule_888(_TPPrule_888 _currn)
#else
void _VS11rule_888(_currn )
_TPPrule_888 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const34=ZERO();
/*SPC(796)*/
_currn->_AT_const50=ZERO();
/*SPC(796)*/
_currn->_AT_const63=ZERO();
/*SPC(796)*/
_currn->_AT_const64=ZERO();
/*SPC(796)*/
_currn->_AT_const65=ZERO();
/*SPC(796)*/
_currn->_AT_const66=ZERO();
/*SPC(796)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12825)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_889(_TPPrule_889 _currn)
#else
void _VS1rule_889(_currn )
_TPPrule_889 _currn;

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
void _VS2rule_889(_TPPrule_889 _currn)
#else
void _VS2rule_889(_currn )
_TPPrule_889 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_889(_TPPrule_889 _currn)
#else
void _VS4rule_889(_currn )
_TPPrule_889 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_889(_TPPrule_889 _currn)
#else
void _VS5rule_889(_currn )
_TPPrule_889 _currn;

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
void _VS6rule_889(_TPPrule_889 _currn)
#else
void _VS6rule_889(_currn )
_TPPrule_889 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATExpValue=0;
/*SPC(9243)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_889(_TPPrule_889 _currn)
#else
void _VS7rule_889(_currn )
_TPPrule_889 _currn;

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
void _VS8rule_889(_TPPrule_889 _currn)
#else
void _VS8rule_889(_currn )
_TPPrule_889 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const33=ZERO();
/*SPC(792)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATPtg=
((EQ(_currn->_desc1->_ATTypeLen, 8)
) ? (ConstantHandling(StringTable(_currn->_ATTERM_1), DOUBLE)
) : (ConstantHandling(StringTable(_currn->_ATTERM_1), REAL)))
;
/*SPC(6990)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_889(_TPPrule_889 _currn)
#else
void _VS9rule_889(_currn )
_TPPrule_889 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const18=ZERO();
/*SPC(792)*/
_currn->_AT_const32=ZERO();
/*SPC(792)*/
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
_currn->_ATArgType=Convert_to_Ctype(4, RealType);
/*SPC(5953)*/
_currn->_ATSym=IdnNumb(0, _currn->_ATTERM_1);
/*SPC(6989)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_889(_TPPrule_889 _currn)
#else
void _VS10rule_889(_currn )
_TPPrule_889 _currn;

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
void _VS11rule_889(_TPPrule_889 _currn)
#else
void _VS11rule_889(_currn )
_TPPrule_889 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const34=ZERO();
/*SPC(792)*/
_currn->_AT_const50=ZERO();
/*SPC(792)*/
_currn->_AT_const63=ZERO();
/*SPC(792)*/
_currn->_AT_const64=ZERO();
/*SPC(792)*/
_currn->_AT_const65=ZERO();
/*SPC(792)*/
_currn->_AT_const66=ZERO();
/*SPC(792)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12825)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_890(_TPPrule_890 _currn)
#else
void _VS1rule_890(_currn )
_TPPrule_890 _currn;

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
void _VS2rule_890(_TPPrule_890 _currn)
#else
void _VS2rule_890(_currn )
_TPPrule_890 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_890(_TPPrule_890 _currn)
#else
void _VS4rule_890(_currn )
_TPPrule_890 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_890(_TPPrule_890 _currn)
#else
void _VS5rule_890(_currn )
_TPPrule_890 _currn;

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
void _VS6rule_890(_TPPrule_890 _currn)
#else
void _VS6rule_890(_currn )
_TPPrule_890 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATExpValue=0;
/*SPC(9243)*/
_currn->_ATValue=IdnNumb(0, _currn->_ATTERM_1);
/*SPC(789)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_890(_TPPrule_890 _currn)
#else
void _VS7rule_890(_currn )
_TPPrule_890 _currn;

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
void _VS8rule_890(_TPPrule_890 _currn)
#else
void _VS8rule_890(_currn )
_TPPrule_890 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const33=ZERO();
/*SPC(788)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATPtg=
((EQ(_currn->_desc1->_ATTypeLen, 8)
) ? (ConstantHandling(StringTable(IdnNumb(0, _currn->_ATTERM_1)), LONG)
) : (
((EQ(_currn->_desc1->_ATTypeLen, 4)
) ? (ConstantHandling(StringTable(IdnNumb(0, _currn->_ATTERM_1)), INT)
) : (ConstantHandling(StringTable(IdnNumb(0, _currn->_ATTERM_1)), SHORT)))
))
;
/*SPC(6960)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_890(_TPPrule_890 _currn)
#else
void _VS9rule_890(_currn )
_TPPrule_890 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const18=ZERO();
/*SPC(788)*/
_currn->_AT_const32=ZERO();
/*SPC(788)*/
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
_currn->_ATArgType=Convert_to_Ctype(4, IntegerType);
/*SPC(5946)*/
_currn->_ATSym=IdnNumb(0, _currn->_ATTERM_1);
/*SPC(6959)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_890(_TPPrule_890 _currn)
#else
void _VS10rule_890(_currn )
_TPPrule_890 _currn;

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
void _VS11rule_890(_TPPrule_890 _currn)
#else
void _VS11rule_890(_currn )
_TPPrule_890 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const34=ZERO();
/*SPC(788)*/
_currn->_AT_const50=ZERO();
/*SPC(788)*/
_currn->_AT_const63=ZERO();
/*SPC(788)*/
_currn->_AT_const64=ZERO();
/*SPC(788)*/
_currn->_AT_const65=ZERO();
/*SPC(788)*/
_currn->_AT_const66=ZERO();
/*SPC(788)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12825)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_891(_TPPrule_891 _currn)
#else
void _VS3rule_891(_currn )
_TPPrule_891 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("FALSE");
/*SPC(4578)*/
_currn->_ATValue=IdnNumb(0, 0);
/*SPC(785)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_892(_TPPrule_892 _currn)
#else
void _VS3rule_892(_currn )
_TPPrule_892 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATPtg=PTGAsIs("TRUE");
/*SPC(4574)*/
_currn->_ATValue=IdnNumb(0, 1);
/*SPC(781)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_893(_TPPrule_893 _currn)
#else
void _VS1rule_893(_currn )
_TPPrule_893 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_893(_TPPrule_893 _currn)
#else
void _VS4rule_893(_currn )
_TPPrule_893 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_893(_TPPrule_893 _currn)
#else
void _VS5rule_893(_currn )
_TPPrule_893 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_893(_TPPrule_893 _currn)
#else
void _VS6rule_893(_currn )
_TPPrule_893 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATExpValue=0;
/*SPC(9243)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_893(_TPPrule_893 _currn)
#else
void _VS7rule_893(_currn )
_TPPrule_893 _currn;

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
void _VS8rule_893(_TPPrule_893 _currn)
#else
void _VS8rule_893(_currn )
_TPPrule_893 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const33=ZERO();
/*SPC(776)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATPtg=
((OR(EQ((* _IG_incl57), TRUE), EQ((* _IG_incl58), TRUE))
) ? (ConstantHandling(StringTable(_currn->_ATTERM_1), DOUBLE)
) : (PTGString(StringTable(_currn->_ATTERM_1))))
;
/*SPC(9125)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_893(_TPPrule_893 _currn)
#else
void _VS9rule_893(_currn )
_TPPrule_893 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const18=ZERO();
/*SPC(776)*/
_currn->_AT_const32=ZERO();
/*SPC(776)*/
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
_currn->_ATArgType=Convert_to_Ctype(8, DoublePrecisionType);
/*SPC(5957)*/
_currn->_ATSym=IdnNumb(0, _currn->_ATTERM_1);
/*SPC(6998)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_893(_TPPrule_893 _currn)
#else
void _VS10rule_893(_currn )
_TPPrule_893 _currn;

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
void _VS11rule_893(_TPPrule_893 _currn)
#else
void _VS11rule_893(_currn )
_TPPrule_893 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const34=ZERO();
/*SPC(776)*/
_currn->_AT_const50=ZERO();
/*SPC(776)*/
_currn->_AT_const63=ZERO();
/*SPC(776)*/
_currn->_AT_const64=ZERO();
/*SPC(776)*/
_currn->_AT_const65=ZERO();
/*SPC(776)*/
_currn->_AT_const66=ZERO();
/*SPC(776)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12825)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_894(_TPPrule_894 _currn)
#else
void _VS1rule_894(_currn )
_TPPrule_894 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_894(_TPPrule_894 _currn)
#else
void _VS4rule_894(_currn )
_TPPrule_894 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_894(_TPPrule_894 _currn)
#else
void _VS5rule_894(_currn )
_TPPrule_894 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_894(_TPPrule_894 _currn)
#else
void _VS6rule_894(_currn )
_TPPrule_894 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATExpValue=0;
/*SPC(9243)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_894(_TPPrule_894 _currn)
#else
void _VS7rule_894(_currn )
_TPPrule_894 _currn;

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
void _VS8rule_894(_TPPrule_894 _currn)
#else
void _VS8rule_894(_currn )
_TPPrule_894 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const33=ZERO();
/*SPC(772)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATtypeLen_RuleAttr_1351=GetTypeLength((* _IG_incl60), 0);
/*SPC(6971)*/
_currn->_ATPtg=
((OR(EQ((* _IG_incl57), TRUE), EQ((* _IG_incl58), TRUE))
) ? (
((EQ(_currn->_ATtypeLen_RuleAttr_1351, 8)
) ? (ConstantHandling(StringTable(_currn->_ATTERM_1), DOUBLE)
) : (ConstantHandling(StringTable(_currn->_ATTERM_1), REAL)))

) : (
((EQ(_currn->_ATtypeLen_RuleAttr_1351, 8)
) ? (PTGString(StringTable(_currn->_ATTERM_1))
) : (PTGSequence(PTGString(StringTable(_currn->_ATTERM_1)), PTGAsIs("F"))))
))
;
/*SPC(6974)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_894(_TPPrule_894 _currn)
#else
void _VS9rule_894(_currn )
_TPPrule_894 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const18=ZERO();
/*SPC(772)*/
_currn->_AT_const32=ZERO();
/*SPC(772)*/
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
_currn->_ATArgType=Convert_to_Ctype(4, RealType);
/*SPC(5950)*/
_currn->_ATSym=IdnNumb(0, _currn->_ATTERM_1);
/*SPC(6973)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_894(_TPPrule_894 _currn)
#else
void _VS10rule_894(_currn )
_TPPrule_894 _currn;

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
void _VS11rule_894(_TPPrule_894 _currn)
#else
void _VS11rule_894(_currn )
_TPPrule_894 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const34=ZERO();
/*SPC(772)*/
_currn->_AT_const50=ZERO();
/*SPC(772)*/
_currn->_AT_const63=ZERO();
/*SPC(772)*/
_currn->_AT_const64=ZERO();
/*SPC(772)*/
_currn->_AT_const65=ZERO();
/*SPC(772)*/
_currn->_AT_const66=ZERO();
/*SPC(772)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATConstantUsed=FALSE;
/*SPC(12825)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_895(_TPPrule_895 _currn)
#else
void _VS1rule_895(_currn )
_TPPrule_895 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_895(_TPPrule_895 _currn)
#else
void _VS4rule_895(_currn )
_TPPrule_895 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_895(_TPPrule_895 _currn)
#else
void _VS5rule_895(_currn )
_TPPrule_895 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATLocalIndex_post=_currn->_ATLocalIndex_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_895(_TPPrule_895 _currn)
#else
void _VS6rule_895(_currn )
_TPPrule_895 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATValue=IdnNumb(0, _currn->_ATTERM_1);
/*SPC(769)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_895(_TPPrule_895 _currn)
#else
void _VS7rule_895(_currn )
_TPPrule_895 _currn;

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
void _VS8rule_895(_TPPrule_895 _currn)
#else
void _VS8rule_895(_currn )
_TPPrule_895 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const33=ZERO();
/*SPC(768)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNumber(_currn->_ATTERM_1);
/*SPC(6955)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS9rule_895(_TPPrule_895 _currn)
#else
void _VS9rule_895(_currn )
_TPPrule_895 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const18=ZERO();
/*SPC(768)*/
_currn->_AT_const32=ZERO();
/*SPC(768)*/
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
_currn->_ATArgType=Convert_to_Ctype(4, IntegerType);
/*SPC(5943)*/
_currn->_ATSym=IdnNumb(0, _currn->_ATTERM_1);
/*SPC(6954)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS10rule_895(_TPPrule_895 _currn)
#else
void _VS10rule_895(_currn )
_TPPrule_895 _currn;

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
void _VS11rule_895(_TPPrule_895 _currn)
#else
void _VS11rule_895(_currn )
_TPPrule_895 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const34=ZERO();
/*SPC(768)*/
_currn->_AT_const50=ZERO();
/*SPC(768)*/
_currn->_AT_const63=ZERO();
/*SPC(768)*/
_currn->_AT_const64=ZERO();
/*SPC(768)*/
_currn->_AT_const65=ZERO();
/*SPC(768)*/
_currn->_AT_const66=ZERO();
/*SPC(768)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_ATConstantUsed=CheckArray(_currn->_ATGPURegionNumber_pre, _currn->_ATArrayId_pre, _currn->_ATRegionVars_pre, _currn->_ATDoAcc_pre, _currn->_ATLocalIndex_pre);
/*SPC(12827)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_896(_TPPrule_896 _currn)
#else
void _VS1rule_896(_currn )
_TPPrule_896 _currn;

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
void _VS2rule_896(_TPPrule_896 _currn)
#else
void _VS2rule_896(_currn )
_TPPrule_896 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_896(_TPPrule_896 _currn)
#else
void _VS3rule_896(_currn )
_TPPrule_896 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_896(_TPPrule_896 _currn)
#else
void _VS4rule_896(_currn )
_TPPrule_896 _currn;

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
void _VS5rule_896(_TPPrule_896 _currn)
#else
void _VS5rule_896(_currn )
_TPPrule_896 _currn;

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
_currn->_ATObjectId=_currn->_desc1->_ATObjectId;
/*SPC(3827)*/
_currn->_ATValue=_currn->_desc1->_ATValue;
/*SPC(763)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_896(_TPPrule_896 _currn)
#else
void _VS6rule_896(_currn )
_TPPrule_896 _currn;

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
void _VS7rule_896(_TPPrule_896 _currn)
#else
void _VS7rule_896(_currn )
_TPPrule_896 _currn;

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
_currn->_ATUnitId=_currn->_desc1->_ATUnitId;
/*SPC(3828)*/
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(3829)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_897(_TPPrule_897 _currn)
#else
void _VS1rule_897(_currn )
_TPPrule_897 _currn;

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
void _VS2rule_897(_TPPrule_897 _currn)
#else
void _VS2rule_897(_currn )
_TPPrule_897 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_897(_TPPrule_897 _currn)
#else
void _VS3rule_897(_currn )
_TPPrule_897 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_897(_TPPrule_897 _currn)
#else
void _VS4rule_897(_currn )
_TPPrule_897 _currn;

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
void _VS5rule_897(_TPPrule_897 _currn)
#else
void _VS5rule_897(_currn )
_TPPrule_897 _currn;

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
_currn->_ATObjectId=_currn->_desc1->_ATObjectId;
/*SPC(3834)*/
_currn->_ATValue=_currn->_desc1->_ATValue;
/*SPC(758)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_897(_TPPrule_897 _currn)
#else
void _VS6rule_897(_currn )
_TPPrule_897 _currn;

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
void _VS7rule_897(_TPPrule_897 _currn)
#else
void _VS7rule_897(_currn )
_TPPrule_897 _currn;

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
_currn->_ATUnitId=_currn->_desc1->_ATUnitId;
/*SPC(3833)*/
_currn->_ATPtg=_currn->_desc1->_ATPtg;
/*SPC(3835)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1090(_TPPrule_1090 _currn)
#else
void _VS1rule_1090(_currn )
_TPPrule_1090 _currn;

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
void _VS2rule_1090(_TPPrule_1090 _currn)
#else
void _VS2rule_1090(_currn )
_TPPrule_1090 _currn;

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
void _VS3rule_1090(_TPPrule_1090 _currn)
#else
void _VS3rule_1090(_currn )
_TPPrule_1090 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1090(_TPPrule_1090 _currn)
#else
void _VS4rule_1090(_currn )
_TPPrule_1090 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(14336)*/
_currn->_AT_const45=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(14336)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1090(_TPPrule_1090 _currn)
#else
void _VS5rule_1090(_currn )
_TPPrule_1090 _currn;

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
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
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
/*SPC(14336)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
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
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
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
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_1090(_TPPrule_1090 _currn)
#else
void _VS6rule_1090(_currn )
_TPPrule_1090 _currn;

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
/*SPC(14336)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(14336)*/
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
void _VS7rule_1090(_TPPrule_1090 _currn)
#else
void _VS7rule_1090(_currn )
_TPPrule_1090 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1089(_TPPrule_1089 _currn)
#else
void _VS1rule_1089(_currn )
_TPPrule_1089 _currn;

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
void _VS2rule_1089(_TPPrule_1089 _currn)
#else
void _VS2rule_1089(_currn )
_TPPrule_1089 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1089(_TPPrule_1089 _currn)
#else
void _VS4rule_1089(_currn )
_TPPrule_1089 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const38=ZERO();
/*SPC(14332)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(14332)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1089(_TPPrule_1089 _currn)
#else
void _VS5rule_1089(_currn )
_TPPrule_1089 _currn;

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
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
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
_currn->_AT_const41=ZERO();
/*SPC(14332)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
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
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_1089(_TPPrule_1089 _currn)
#else
void _VS6rule_1089(_currn )
_TPPrule_1089 _currn;

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
_currn->_AT_const39=ZERO();
/*SPC(14332)*/
_currn->_AT_const40=PTGNull();
/*SPC(14332)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
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
void _VS7rule_1089(_TPPrule_1089 _currn)
#else
void _VS7rule_1089(_currn )
_TPPrule_1089 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1088(_TPPrule_1088 _currn)
#else
void _VS1rule_1088(_currn )
_TPPrule_1088 _currn;

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
void _VS2rule_1088(_TPPrule_1088 _currn)
#else
void _VS2rule_1088(_currn )
_TPPrule_1088 _currn;

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
void _VS4rule_1088(_TPPrule_1088 _currn)
#else
void _VS4rule_1088(_currn )
_TPPrule_1088 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const38=ZERO();
/*SPC(14328)*/
_currn->_AT_const45=ZERO();
/*SPC(14328)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1088(_TPPrule_1088 _currn)
#else
void _VS5rule_1088(_currn )
_TPPrule_1088 _currn;

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
_currn->_AT_const41=ZERO();
/*SPC(14328)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_1088(_TPPrule_1088 _currn)
#else
void _VS6rule_1088(_currn )
_TPPrule_1088 _currn;

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
_currn->_AT_const39=ZERO();
/*SPC(14328)*/
_currn->_AT_const40=PTGNull();
/*SPC(14328)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
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
void _VS1rule_1087(_TPPrule_1087 _currn)
#else
void _VS1rule_1087(_currn )
_TPPrule_1087 _currn;

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
void _VS2rule_1087(_TPPrule_1087 _currn)
#else
void _VS2rule_1087(_currn )
_TPPrule_1087 _currn;

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
void _VS4rule_1087(_TPPrule_1087 _currn)
#else
void _VS4rule_1087(_currn )
_TPPrule_1087 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const38=ZERO();
/*SPC(14324)*/
_currn->_AT_const45=ZERO();
/*SPC(14324)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1087(_TPPrule_1087 _currn)
#else
void _VS5rule_1087(_currn )
_TPPrule_1087 _currn;

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
_currn->_AT_const41=ZERO();
/*SPC(14324)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_1087(_TPPrule_1087 _currn)
#else
void _VS6rule_1087(_currn )
_TPPrule_1087 _currn;

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
_currn->_AT_const39=ZERO();
/*SPC(14324)*/
_currn->_AT_const40=PTGNull();
/*SPC(14324)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
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
void _VS1rule_1086(_TPPrule_1086 _currn)
#else
void _VS1rule_1086(_currn )
_TPPrule_1086 _currn;

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
void _VS2rule_1086(_TPPrule_1086 _currn)
#else
void _VS2rule_1086(_currn )
_TPPrule_1086 _currn;

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
void _VS3rule_1086(_TPPrule_1086 _currn)
#else
void _VS3rule_1086(_currn )
_TPPrule_1086 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1086(_TPPrule_1086 _currn)
#else
void _VS4rule_1086(_currn )
_TPPrule_1086 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const38=_currn->_desc2->_AT_const38;
/*SPC(14320)*/
_currn->_AT_const45=_currn->_desc2->_AT_const45;
/*SPC(14320)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1086(_TPPrule_1086 _currn)
#else
void _VS5rule_1086(_currn )
_TPPrule_1086 _currn;

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
_currn->_AT_const41=_currn->_desc2->_AT_const41;
/*SPC(14320)*/
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
void _VS6rule_1086(_TPPrule_1086 _currn)
#else
void _VS6rule_1086(_currn )
_TPPrule_1086 _currn;

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
_currn->_AT_const39=_currn->_desc2->_AT_const39;
/*SPC(14320)*/
_currn->_AT_const40=_currn->_desc2->_AT_const40;
/*SPC(14320)*/
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
void _VS7rule_1086(_TPPrule_1086 _currn)
#else
void _VS7rule_1086(_currn )
_TPPrule_1086 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1085(_TPPrule_1085 _currn)
#else
void _VS1rule_1085(_currn )
_TPPrule_1085 _currn;

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
void _VS2rule_1085(_TPPrule_1085 _currn)
#else
void _VS2rule_1085(_currn )
_TPPrule_1085 _currn;

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
void _VS3rule_1085(_TPPrule_1085 _currn)
#else
void _VS3rule_1085(_currn )
_TPPrule_1085 _currn;

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
void _VS4rule_1085(_TPPrule_1085 _currn)
#else
void _VS4rule_1085(_currn )
_TPPrule_1085 _currn;

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
void _VS1rule_1084(_TPPrule_1084 _currn)
#else
void _VS1rule_1084(_currn )
_TPPrule_1084 _currn;

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
void _VS2rule_1084(_TPPrule_1084 _currn)
#else
void _VS2rule_1084(_currn )
_TPPrule_1084 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1084(_TPPrule_1084 _currn)
#else
void _VS3rule_1084(_currn )
_TPPrule_1084 _currn;

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
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
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
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
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
void _VS4rule_1084(_TPPrule_1084 _currn)
#else
void _VS4rule_1084(_currn )
_TPPrule_1084 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1083(_TPPrule_1083 _currn)
#else
void _VS1rule_1083(_currn )
_TPPrule_1083 _currn;

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
void _VS2rule_1083(_TPPrule_1083 _currn)
#else
void _VS2rule_1083(_currn )
_TPPrule_1083 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1083(_TPPrule_1083 _currn)
#else
void _VS3rule_1083(_currn )
_TPPrule_1083 _currn;

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
void _VS4rule_1083(_TPPrule_1083 _currn)
#else
void _VS4rule_1083(_currn )
_TPPrule_1083 _currn;

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
void _VS1rule_1082(_TPPrule_1082 _currn)
#else
void _VS1rule_1082(_currn )
_TPPrule_1082 _currn;

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
void _VS2rule_1082(_TPPrule_1082 _currn)
#else
void _VS2rule_1082(_currn )
_TPPrule_1082 _currn;

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
void _VS3rule_1082(_TPPrule_1082 _currn)
#else
void _VS3rule_1082(_currn )
_TPPrule_1082 _currn;

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
void _VS4rule_1082(_TPPrule_1082 _currn)
#else
void _VS4rule_1082(_currn )
_TPPrule_1082 _currn;

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
void _VS1rule_1081(_TPPrule_1081 _currn)
#else
void _VS1rule_1081(_currn )
_TPPrule_1081 _currn;

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
void _VS2rule_1081(_TPPrule_1081 _currn)
#else
void _VS2rule_1081(_currn )
_TPPrule_1081 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1081(_TPPrule_1081 _currn)
#else
void _VS3rule_1081(_currn )
_TPPrule_1081 _currn;

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
void _VS4rule_1081(_TPPrule_1081 _currn)
#else
void _VS4rule_1081(_currn )
_TPPrule_1081 _currn;

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
void _VS1rule_1080(_TPPrule_1080 _currn)
#else
void _VS1rule_1080(_currn )
_TPPrule_1080 _currn;

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
void _VS2rule_1080(_TPPrule_1080 _currn)
#else
void _VS2rule_1080(_currn )
_TPPrule_1080 _currn;

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
void _VS3rule_1080(_TPPrule_1080 _currn)
#else
void _VS3rule_1080(_currn )
_TPPrule_1080 _currn;

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
void _VS4rule_1080(_TPPrule_1080 _currn)
#else
void _VS4rule_1080(_currn )
_TPPrule_1080 _currn;

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
void _VS1rule_1079(_TPPrule_1079 _currn)
#else
void _VS1rule_1079(_currn )
_TPPrule_1079 _currn;

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
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1079(_TPPrule_1079 _currn)
#else
void _VS2rule_1079(_currn )
_TPPrule_1079 _currn;

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
void _VS3rule_1079(_TPPrule_1079 _currn)
#else
void _VS3rule_1079(_currn )
_TPPrule_1079 _currn;

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
void _VS4rule_1079(_TPPrule_1079 _currn)
#else
void _VS4rule_1079(_currn )
_TPPrule_1079 _currn;

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
void _VS5rule_1079(_TPPrule_1079 _currn)
#else
void _VS5rule_1079(_currn )
_TPPrule_1079 _currn;

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
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATLocalIndex_post=_currn->_desc3->_ATLocalIndex_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_1079(_TPPrule_1079 _currn)
#else
void _VS6rule_1079(_currn )
_TPPrule_1079 _currn;

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
/*SPC(14292)*/
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
_currn->_ATF90Syntax=FALSE;
/*SPC(8104)*/
_currn->_ATPtg=PTGAsIs("F2C-ACC: xExprList not supported.");
/*SPC(8085)*/
_currn->_ATDemoted=FALSE;
/*SPC(7813)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_1079(_TPPrule_1079 _currn)
#else
void _VS7rule_1079(_currn )
_TPPrule_1079 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS8rule_1079(_TPPrule_1079 _currn)
#else
void _VS8rule_1079(_currn )
_TPPrule_1079 _currn;

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
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const19=ADD(ADD(IDENTICAL(_currn->_desc1->_ATConstantUsed), IDENTICAL(_currn->_desc2->_ATConstantUsed)), IDENTICAL(_currn->_desc3->_ATConstantUsed));
/*SPC(14292)*/
_currn->_AT_const63=ADD(ADD(_currn->_desc1->_AT_const63, _currn->_desc2->_AT_const63), _currn->_desc3->_AT_const63);
/*SPC(14292)*/
_currn->_AT_const64=ADD(ADD(_currn->_desc1->_AT_const64, _currn->_desc2->_AT_const64), _currn->_desc3->_AT_const64);
/*SPC(14292)*/
_currn->_AT_const65=ADD(ADD(_currn->_desc1->_AT_const65, _currn->_desc2->_AT_const65), _currn->_desc3->_AT_const65);
/*SPC(14292)*/
_currn->_AT_const66=ADD(ADD(_currn->_desc1->_AT_const66, _currn->_desc2->_AT_const66), _currn->_desc3->_AT_const66);
/*SPC(14292)*/
_currn->_ATDepth_post=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1077(_TPPrule_1077 _currn)
#else
void _VS1rule_1077(_currn )
_TPPrule_1077 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1077(_TPPrule_1077 _currn)
#else
void _VS2rule_1077(_currn )
_TPPrule_1077 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1077(_TPPrule_1077 _currn)
#else
void _VS3rule_1077(_currn )
_TPPrule_1077 _currn;

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
void _VS4rule_1077(_TPPrule_1077 _currn)
#else
void _VS4rule_1077(_currn )
_TPPrule_1077 _currn;

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
void _VS1rule_1076(_TPPrule_1076 _currn)
#else
void _VS1rule_1076(_currn )
_TPPrule_1076 _currn;

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
void _VS2rule_1076(_TPPrule_1076 _currn)
#else
void _VS2rule_1076(_currn )
_TPPrule_1076 _currn;

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
void _VS3rule_1076(_TPPrule_1076 _currn)
#else
void _VS3rule_1076(_currn )
_TPPrule_1076 _currn;

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
void _VS4rule_1076(_TPPrule_1076 _currn)
#else
void _VS4rule_1076(_currn )
_TPPrule_1076 _currn;

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
void _VS1rule_1075(_TPPrule_1075 _currn)
#else
void _VS1rule_1075(_currn )
_TPPrule_1075 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1075(_TPPrule_1075 _currn)
#else
void _VS2rule_1075(_currn )
_TPPrule_1075 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1075(_TPPrule_1075 _currn)
#else
void _VS3rule_1075(_currn )
_TPPrule_1075 _currn;

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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1075(_TPPrule_1075 _currn)
#else
void _VS4rule_1075(_currn )
_TPPrule_1075 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1074(_TPPrule_1074 _currn)
#else
void _VS1rule_1074(_currn )
_TPPrule_1074 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1074(_TPPrule_1074 _currn)
#else
void _VS2rule_1074(_currn )
_TPPrule_1074 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1074(_TPPrule_1074 _currn)
#else
void _VS3rule_1074(_currn )
_TPPrule_1074 _currn;

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
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATRegionVars_pre=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc3->_ATLastNonExecLine_pre=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc3->_ATIndentLevel_pre=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc1->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc1->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATArrayId_pre=_currn->_desc1->_ATArrayId_post;
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
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1074(_TPPrule_1074 _currn)
#else
void _VS4rule_1074(_currn )
_TPPrule_1074 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1073(_TPPrule_1073 _currn)
#else
void _VS1rule_1073(_currn )
_TPPrule_1073 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1073(_TPPrule_1073 _currn)
#else
void _VS2rule_1073(_currn )
_TPPrule_1073 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1073(_TPPrule_1073 _currn)
#else
void _VS3rule_1073(_currn )
_TPPrule_1073 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
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
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1073(_TPPrule_1073 _currn)
#else
void _VS4rule_1073(_currn )
_TPPrule_1073 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1072(_TPPrule_1072 _currn)
#else
void _VS1rule_1072(_currn )
_TPPrule_1072 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1072(_TPPrule_1072 _currn)
#else
void _VS2rule_1072(_currn )
_TPPrule_1072 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1072(_TPPrule_1072 _currn)
#else
void _VS3rule_1072(_currn )
_TPPrule_1072 _currn;

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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1072(_TPPrule_1072 _currn)
#else
void _VS4rule_1072(_currn )
_TPPrule_1072 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1071(_TPPrule_1071 _currn)
#else
void _VS3rule_1071(_currn )
_TPPrule_1071 _currn;

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
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1071(_TPPrule_1071 _currn)
#else
void _VS4rule_1071(_currn )
_TPPrule_1071 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1070(_TPPrule_1070 _currn)
#else
void _VS1rule_1070(_currn )
_TPPrule_1070 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1070(_TPPrule_1070 _currn)
#else
void _VS2rule_1070(_currn )
_TPPrule_1070 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1070(_TPPrule_1070 _currn)
#else
void _VS3rule_1070(_currn )
_TPPrule_1070 _currn;

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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1070(_TPPrule_1070 _currn)
#else
void _VS4rule_1070(_currn )
_TPPrule_1070 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1069(_TPPrule_1069 _currn)
#else
void _VS1rule_1069(_currn )
_TPPrule_1069 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1069(_TPPrule_1069 _currn)
#else
void _VS2rule_1069(_currn )
_TPPrule_1069 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1069(_TPPrule_1069 _currn)
#else
void _VS3rule_1069(_currn )
_TPPrule_1069 _currn;

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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1069(_TPPrule_1069 _currn)
#else
void _VS4rule_1069(_currn )
_TPPrule_1069 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1068(_TPPrule_1068 _currn)
#else
void _VS1rule_1068(_currn )
_TPPrule_1068 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1068(_TPPrule_1068 _currn)
#else
void _VS2rule_1068(_currn )
_TPPrule_1068 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1068(_TPPrule_1068 _currn)
#else
void _VS3rule_1068(_currn )
_TPPrule_1068 _currn;

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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1068(_TPPrule_1068 _currn)
#else
void _VS4rule_1068(_currn )
_TPPrule_1068 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1067(_TPPrule_1067 _currn)
#else
void _VS3rule_1067(_currn )
_TPPrule_1067 _currn;

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
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1067(_TPPrule_1067 _currn)
#else
void _VS4rule_1067(_currn )
_TPPrule_1067 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1066(_TPPrule_1066 _currn)
#else
void _VS4rule_1066(_currn )
_TPPrule_1066 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATCPURegionNumber_pre=_currn->_ATCPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=ZERO();
/*SPC(14240)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_ATUpdate_pre;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_ATNestLevel_pre;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc1->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_ATIndentLevel_pre;
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
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1066(_TPPrule_1066 _currn)
#else
void _VS5rule_1066(_currn )
_TPPrule_1066 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const40=PTGNull();
/*SPC(14240)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1065(_TPPrule_1065 _currn)
#else
void _VS1rule_1065(_currn )
_TPPrule_1065 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1065(_TPPrule_1065 _currn)
#else
void _VS2rule_1065(_currn )
_TPPrule_1065 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1065(_TPPrule_1065 _currn)
#else
void _VS3rule_1065(_currn )
_TPPrule_1065 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1065(_TPPrule_1065 _currn)
#else
void _VS4rule_1065(_currn )
_TPPrule_1065 _currn;

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
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
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
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=IDENTICAL(_currn->_desc1->_ATNumKernels);
/*SPC(14236)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc1->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1065(_TPPrule_1065 _currn)
#else
void _VS5rule_1065(_currn )
_TPPrule_1065 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const40=PTGNull();
/*SPC(14236)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1064(_TPPrule_1064 _currn)
#else
void _VS1rule_1064(_currn )
_TPPrule_1064 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1064(_TPPrule_1064 _currn)
#else
void _VS2rule_1064(_currn )
_TPPrule_1064 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1064(_TPPrule_1064 _currn)
#else
void _VS3rule_1064(_currn )
_TPPrule_1064 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1064(_TPPrule_1064 _currn)
#else
void _VS4rule_1064(_currn )
_TPPrule_1064 _currn;

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
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=ZERO();
/*SPC(14232)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1064(_TPPrule_1064 _currn)
#else
void _VS5rule_1064(_currn )
_TPPrule_1064 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATThreadRegion_pre=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const40=PTGNull();
/*SPC(14232)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_ATKernelNumber_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1063(_TPPrule_1063 _currn)
#else
void _VS1rule_1063(_currn )
_TPPrule_1063 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1063(_TPPrule_1063 _currn)
#else
void _VS4rule_1063(_currn )
_TPPrule_1063 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const41=ZERO();
/*SPC(14228)*/
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_ATDoAcc_pre;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
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
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1063(_TPPrule_1063 _currn)
#else
void _VS5rule_1063(_currn )
_TPPrule_1063 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const40=PTGNull();
/*SPC(14228)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_ATKernelNumber_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1062(_TPPrule_1062 _currn)
#else
void _VS1rule_1062(_currn )
_TPPrule_1062 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1062(_TPPrule_1062 _currn)
#else
void _VS2rule_1062(_currn )
_TPPrule_1062 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1062(_TPPrule_1062 _currn)
#else
void _VS3rule_1062(_currn )
_TPPrule_1062 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1062(_TPPrule_1062 _currn)
#else
void _VS4rule_1062(_currn )
_TPPrule_1062 _currn;

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
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=ZERO();
/*SPC(14224)*/
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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1062(_TPPrule_1062 _currn)
#else
void _VS5rule_1062(_currn )
_TPPrule_1062 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const40=PTGNull();
/*SPC(14224)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_ATKernelNumber_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1061(_TPPrule_1061 _currn)
#else
void _VS1rule_1061(_currn )
_TPPrule_1061 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1061(_TPPrule_1061 _currn)
#else
void _VS2rule_1061(_currn )
_TPPrule_1061 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1061(_TPPrule_1061 _currn)
#else
void _VS3rule_1061(_currn )
_TPPrule_1061 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1061(_TPPrule_1061 _currn)
#else
void _VS4rule_1061(_currn )
_TPPrule_1061 _currn;

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
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=ZERO();
/*SPC(14220)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1061(_TPPrule_1061 _currn)
#else
void _VS5rule_1061(_currn )
_TPPrule_1061 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATErrorVarDeclared_pre=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const40=IDENTICAL(_currn->_desc1->_ATGlobalDecls);
/*SPC(14220)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_ATThreadRegion_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_ATKernelNumber_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1060(_TPPrule_1060 _currn)
#else
void _VS1rule_1060(_currn )
_TPPrule_1060 _currn;

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
void _VS2rule_1060(_TPPrule_1060 _currn)
#else
void _VS2rule_1060(_currn )
_TPPrule_1060 _currn;

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
void _VS3rule_1060(_TPPrule_1060 _currn)
#else
void _VS3rule_1060(_currn )
_TPPrule_1060 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1060(_TPPrule_1060 _currn)
#else
void _VS4rule_1060(_currn )
_TPPrule_1060 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const38=_currn->_desc1->_AT_const38;
/*SPC(14216)*/
_currn->_AT_const45=MAX(_currn->_desc1->_AT_const45, _currn->_desc2->_AT_const45);
/*SPC(14216)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1060(_TPPrule_1060 _currn)
#else
void _VS5rule_1060(_currn )
_TPPrule_1060 _currn;

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
_currn->_desc2->_ATAcceleratorRegion_pre=_currn->_desc1->_ATAcceleratorRegion_post;
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
/*SPC(14216)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
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
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
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
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_1060(_TPPrule_1060 _currn)
#else
void _VS6rule_1060(_currn )
_TPPrule_1060 _currn;

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
_currn->_desc2->_ATTranslationType_pre=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=_currn->_desc1->_AT_const39;
/*SPC(14216)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(14216)*/
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
void _VS7rule_1060(_TPPrule_1060 _currn)
#else
void _VS7rule_1060(_currn )
_TPPrule_1060 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1059(_TPPrule_1059 _currn)
#else
void _VS1rule_1059(_currn )
_TPPrule_1059 _currn;

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
void _VS2rule_1059(_TPPrule_1059 _currn)
#else
void _VS2rule_1059(_currn )
_TPPrule_1059 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1059(_TPPrule_1059 _currn)
#else
void _VS4rule_1059(_currn )
_TPPrule_1059 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const38=ZERO();
/*SPC(14212)*/
_currn->_AT_const45=_currn->_desc1->_AT_const45;
/*SPC(14212)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1059(_TPPrule_1059 _currn)
#else
void _VS5rule_1059(_currn )
_TPPrule_1059 _currn;

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
_currn->_desc1->_ATAcceleratorRegion_pre=_currn->_ATAcceleratorRegion_pre;
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
_currn->_AT_const41=ZERO();
/*SPC(14212)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
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
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_ATArgCnt_post=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATArraySym_post=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_ATArrayId_post=_currn->_ATArrayId_pre;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_1059(_TPPrule_1059 _currn)
#else
void _VS6rule_1059(_currn )
_TPPrule_1059 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATTranslationType_pre=_currn->_ATTranslationType_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=ZERO();
/*SPC(14212)*/
_currn->_AT_const40=PTGNull();
/*SPC(14212)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
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
void _VS1rule_1058(_TPPrule_1058 _currn)
#else
void _VS1rule_1058(_currn )
_TPPrule_1058 _currn;

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
void _VS2rule_1058(_TPPrule_1058 _currn)
#else
void _VS2rule_1058(_currn )
_TPPrule_1058 _currn;

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
void _VS4rule_1058(_TPPrule_1058 _currn)
#else
void _VS4rule_1058(_currn )
_TPPrule_1058 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const38=ZERO();
/*SPC(14208)*/
_currn->_AT_const45=ZERO();
/*SPC(14208)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1058(_TPPrule_1058 _currn)
#else
void _VS5rule_1058(_currn )
_TPPrule_1058 _currn;

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
_currn->_AT_const41=ZERO();
/*SPC(14208)*/
_currn->_ATTranslationType_post=_currn->_desc1->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_ATAccDoStmt_pre;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_1058(_TPPrule_1058 _currn)
#else
void _VS6rule_1058(_currn )
_TPPrule_1058 _currn;

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
_currn->_AT_const39=ZERO();
/*SPC(14208)*/
_currn->_AT_const40=PTGNull();
/*SPC(14208)*/
_currn->_ATErrorVarDeclared_post=_currn->_ATErrorVarDeclared_pre;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
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
void _VS1rule_1057(_TPPrule_1057 _currn)
#else
void _VS1rule_1057(_currn )
_TPPrule_1057 _currn;

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
void _VS2rule_1057(_TPPrule_1057 _currn)
#else
void _VS2rule_1057(_currn )
_TPPrule_1057 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1057(_TPPrule_1057 _currn)
#else
void _VS3rule_1057(_currn )
_TPPrule_1057 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1057(_TPPrule_1057 _currn)
#else
void _VS4rule_1057(_currn )
_TPPrule_1057 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_AT_const38=ZERO();
/*SPC(14204)*/
_currn->_AT_const45=ZERO();
/*SPC(14204)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1057(_TPPrule_1057 _currn)
#else
void _VS5rule_1057(_currn )
_TPPrule_1057 _currn;

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
_currn->_desc1->_AT_cVariableUseListPtr_pre=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_desc1->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const41=_currn->_desc1->_AT_const41;
/*SPC(14204)*/
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
_currn->_ATDeclPowerVars_post=_currn->_ATDeclPowerVars_pre;
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
_currn->_ATDeclsOrder_post=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_1057(_TPPrule_1057 _currn)
#else
void _VS6rule_1057(_currn )
_TPPrule_1057 _currn;

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
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATDataSectionPTG_pre=_currn->_ATDataSectionPTG_pre;
/*SPC(0)*/
_currn->_desc1->_ATKernelNumber_pre=_currn->_ATKernelNumber_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=ZERO();
/*SPC(14204)*/
_currn->_AT_const40=_currn->_desc1->_AT_const40;
/*SPC(14204)*/
_currn->_ATErrorVarDeclared_post=_currn->_desc1->_ATErrorVarDeclared_post;
/*SPC(0)*/
_currn->_ATThreadStmt_post=_currn->_desc1->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATThreadRegion_post=_currn->_desc1->_ATThreadRegion_post;
/*SPC(0)*/
_currn->_ATProgramLineNum_post=_currn->_ATProgramLineNum_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATDataSectionPTG_post=_currn->_desc1->_ATDataSectionPTG_post;
/*SPC(0)*/
_currn->_ATKernelNumber_post=_currn->_desc1->_ATKernelNumber_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_ATDepth_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1056(_TPPrule_1056 _currn)
#else
void _VS1rule_1056(_currn )
_TPPrule_1056 _currn;

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
void _VS2rule_1056(_TPPrule_1056 _currn)
#else
void _VS2rule_1056(_currn )
_TPPrule_1056 _currn;

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
void _VS3rule_1056(_TPPrule_1056 _currn)
#else
void _VS3rule_1056(_currn )
_TPPrule_1056 _currn;

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
void _VS4rule_1056(_TPPrule_1056 _currn)
#else
void _VS4rule_1056(_currn )
_TPPrule_1056 _currn;

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
void _VS1rule_1055(_TPPrule_1055 _currn)
#else
void _VS1rule_1055(_currn )
_TPPrule_1055 _currn;

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
void _VS2rule_1055(_TPPrule_1055 _currn)
#else
void _VS2rule_1055(_currn )
_TPPrule_1055 _currn;

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
void _VS3rule_1055(_TPPrule_1055 _currn)
#else
void _VS3rule_1055(_currn )
_TPPrule_1055 _currn;

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
void _VS4rule_1055(_TPPrule_1055 _currn)
#else
void _VS4rule_1055(_currn )
_TPPrule_1055 _currn;

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
void _VS1rule_1054(_TPPrule_1054 _currn)
#else
void _VS1rule_1054(_currn )
_TPPrule_1054 _currn;

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
void _VS2rule_1054(_TPPrule_1054 _currn)
#else
void _VS2rule_1054(_currn )
_TPPrule_1054 _currn;

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
void _VS3rule_1054(_TPPrule_1054 _currn)
#else
void _VS3rule_1054(_currn )
_TPPrule_1054 _currn;

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
void _VS4rule_1054(_TPPrule_1054 _currn)
#else
void _VS4rule_1054(_currn )
_TPPrule_1054 _currn;

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
void _VS1rule_1053(_TPPrule_1053 _currn)
#else
void _VS1rule_1053(_currn )
_TPPrule_1053 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1049(_TPPrule_1049 _currn)
#else
void _VS1rule_1049(_currn )
_TPPrule_1049 _currn;

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
void _VS2rule_1049(_TPPrule_1049 _currn)
#else
void _VS2rule_1049(_currn )
_TPPrule_1049 _currn;

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
void _VS3rule_1049(_TPPrule_1049 _currn)
#else
void _VS3rule_1049(_currn )
_TPPrule_1049 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_desc2->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
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
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
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
void _VS4rule_1049(_TPPrule_1049 _currn)
#else
void _VS4rule_1049(_currn )
_TPPrule_1049 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_ATDepth_pre;
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
void _VS1rule_1048(_TPPrule_1048 _currn)
#else
void _VS1rule_1048(_currn )
_TPPrule_1048 _currn;

#endif
{
DefTableKey* _IL_incl40;
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl40=_IG_incl40;_IG_incl40= &(_currn->_ATType);
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1048(_TPPrule_1048 _currn)
#else
void _VS2rule_1048(_currn )
_TPPrule_1048 _currn;

#endif
{
DefTableKey* _IL_incl40;
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl40=_IG_incl40;_IG_incl40= &(_currn->_ATType);
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1048(_TPPrule_1048 _currn)
#else
void _VS3rule_1048(_currn )
_TPPrule_1048 _currn;

#endif
{
DefTableKey* _IL_incl40;
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl40=_IG_incl40;_IG_incl40= &(_currn->_ATType);
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1048(_TPPrule_1048 _currn)
#else
void _VS4rule_1048(_currn )
_TPPrule_1048 _currn;

#endif
{
DefTableKey* _IL_incl40;
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl40=_IG_incl40;_IG_incl40= &(_currn->_ATType);
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_1048(_TPPrule_1048 _currn)
#else
void _VS5rule_1048(_currn )
_TPPrule_1048 _currn;

#endif
{
DefTableKey* _IL_incl40;
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl40=_IG_incl40;_IG_incl40= &(_currn->_ATType);
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
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
_currn->_desc1->_AT_cProgDeclsListPtr_pre=_currn->_AT_cProgDeclsListPtr_pre;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc1->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_1048(_TPPrule_1048 _currn)
#else
void _VS6rule_1048(_currn )
_TPPrule_1048 _currn;

#endif
{
DefTableKey* _IL_incl40;
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl40=_IG_incl40;_IG_incl40= &(_currn->_ATType);
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
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
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1047(_TPPrule_1047 _currn)
#else
void _VS1rule_1047(_currn )
_TPPrule_1047 _currn;

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
/*SPC(6571)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(14164)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1047(_TPPrule_1047 _currn)
#else
void _VS2rule_1047(_currn )
_TPPrule_1047 _currn;

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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13518)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1047(_TPPrule_1047 _currn)
#else
void _VS3rule_1047(_currn )
_TPPrule_1047 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1046(_TPPrule_1046 _currn)
#else
void _VS1rule_1046(_currn )
_TPPrule_1046 _currn;

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
/*SPC(6571)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(14160)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1046(_TPPrule_1046 _currn)
#else
void _VS2rule_1046(_currn )
_TPPrule_1046 _currn;

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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13518)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1046(_TPPrule_1046 _currn)
#else
void _VS3rule_1046(_currn )
_TPPrule_1046 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1045(_TPPrule_1045 _currn)
#else
void _VS1rule_1045(_currn )
_TPPrule_1045 _currn;

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
/*SPC(6571)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(14156)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1045(_TPPrule_1045 _currn)
#else
void _VS2rule_1045(_currn )
_TPPrule_1045 _currn;

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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13518)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1045(_TPPrule_1045 _currn)
#else
void _VS3rule_1045(_currn )
_TPPrule_1045 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1044(_TPPrule_1044 _currn)
#else
void _VS1rule_1044(_currn )
_TPPrule_1044 _currn;

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
/*SPC(6571)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(14152)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1044(_TPPrule_1044 _currn)
#else
void _VS2rule_1044(_currn )
_TPPrule_1044 _currn;

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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13518)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1044(_TPPrule_1044 _currn)
#else
void _VS3rule_1044(_currn )
_TPPrule_1044 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1043(_TPPrule_1043 _currn)
#else
void _VS1rule_1043(_currn )
_TPPrule_1043 _currn;

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
/*SPC(6571)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(14148)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1043(_TPPrule_1043 _currn)
#else
void _VS2rule_1043(_currn )
_TPPrule_1043 _currn;

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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13518)*/
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1043(_TPPrule_1043 _currn)
#else
void _VS3rule_1043(_currn )
_TPPrule_1043 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=_currn->_ATDepth_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATDoAcc_post=_currn->_desc1->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATUpdate_post=_currn->_desc1->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_ATNestLevel_post=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc1->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATGPURegionNumber_post=_currn->_desc1->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_ATTypeLength_post=_currn->_desc1->_ATTypeLength_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1042(_TPPrule_1042 _currn)
#else
void _VS3rule_1042(_currn )
_TPPrule_1042 _currn;

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
_currn->_AT_cVariableUseListPtr_post=_currn->_AT_cVariableUseListPtr_pre;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1042(_TPPrule_1042 _currn)
#else
void _VS4rule_1042(_currn )
_TPPrule_1042 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATUpdateStmt_post=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1041(_TPPrule_1041 _currn)
#else
void _VS1rule_1041(_currn )
_TPPrule_1041 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1041(_TPPrule_1041 _currn)
#else
void _VS2rule_1041(_currn )
_TPPrule_1041 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1041(_TPPrule_1041 _currn)
#else
void _VS3rule_1041(_currn )
_TPPrule_1041 _currn;

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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1041(_TPPrule_1041 _currn)
#else
void _VS4rule_1041(_currn )
_TPPrule_1041 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATUpdateStmt_post=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1040(_TPPrule_1040 _currn)
#else
void _VS1rule_1040(_currn )
_TPPrule_1040 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1040(_TPPrule_1040 _currn)
#else
void _VS2rule_1040(_currn )
_TPPrule_1040 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_1040(_TPPrule_1040 _currn)
#else
void _VS3rule_1040(_currn )
_TPPrule_1040 _currn;

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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1040(_TPPrule_1040 _currn)
#else
void _VS4rule_1040(_currn )
_TPPrule_1040 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_1039(_TPPrule_1039 _currn)
#else
void _VS1rule_1039(_currn )
_TPPrule_1039 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_1039(_TPPrule_1039 _currn)
#else
void _VS2rule_1039(_currn )
_TPPrule_1039 _currn;

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
void _VS3rule_1039(_TPPrule_1039 _currn)
#else
void _VS3rule_1039(_currn )
_TPPrule_1039 _currn;

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
_currn->_desc2->_AT_cVariableUseListPtr_pre=_currn->_desc1->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_desc1->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_AT_cVariableUseListPtr_post=_currn->_desc3->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_1039(_TPPrule_1039 _currn)
#else
void _VS4rule_1039(_currn )
_TPPrule_1039 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/

_VisitExit();
}


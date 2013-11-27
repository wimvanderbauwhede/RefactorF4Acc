
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
void _VS1rule_688(_TPPrule_688 _currn)
#else
void _VS1rule_688(_currn )
_TPPrule_688 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_ATType=LogicalType;
/*SPC(2678)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_688(_TPPrule_688 _currn)
#else
void _VS3rule_688(_currn )
_TPPrule_688 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_688(_TPPrule_688 _currn)
#else
void _VS4rule_688(_currn )
_TPPrule_688 _currn;

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
void _VS5rule_688(_TPPrule_688 _currn)
#else
void _VS5rule_688(_currn )
_TPPrule_688 _currn;

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
void _VS6rule_688(_TPPrule_688 _currn)
#else
void _VS6rule_688(_currn )
_TPPrule_688 _currn;

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
_currn->_ATPtg=PTGAsIs("int");
/*SPC(4362)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_689(_TPPrule_689 _currn)
#else
void _VS1rule_689(_currn )
_TPPrule_689 _currn;

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
/*SPC(4462)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_currn->_ATType=ComplexType;
/*SPC(2672)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_689(_TPPrule_689 _currn)
#else
void _VS2rule_689(_currn )
_TPPrule_689 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_689(_TPPrule_689 _currn)
#else
void _VS3rule_689(_currn )
_TPPrule_689 _currn;

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
void _VS4rule_689(_TPPrule_689 _currn)
#else
void _VS4rule_689(_currn )
_TPPrule_689 _currn;

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
void _VS5rule_689(_TPPrule_689 _currn)
#else
void _VS5rule_689(_currn )
_TPPrule_689 _currn;

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
void _VS6rule_689(_TPPrule_689 _currn)
#else
void _VS6rule_689(_currn )
_TPPrule_689 _currn;

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
void _VS1rule_690(_TPPrule_690 _currn)
#else
void _VS1rule_690(_currn )
_TPPrule_690 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_ATType=ComplexType;
/*SPC(2667)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "F2C-ACC ERROR: Type not supported", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4457)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_690(_TPPrule_690 _currn)
#else
void _VS3rule_690(_currn )
_TPPrule_690 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_690(_TPPrule_690 _currn)
#else
void _VS4rule_690(_currn )
_TPPrule_690 _currn;

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
void _VS5rule_690(_TPPrule_690 _currn)
#else
void _VS5rule_690(_currn )
_TPPrule_690 _currn;

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
void _VS6rule_690(_TPPrule_690 _currn)
#else
void _VS6rule_690(_currn )
_TPPrule_690 _currn;

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
void _VS1rule_691(_TPPrule_691 _currn)
#else
void _VS1rule_691(_currn )
_TPPrule_691 _currn;

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
/*SPC(2661)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_691(_TPPrule_691 _currn)
#else
void _VS2rule_691(_currn )
_TPPrule_691 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_691(_TPPrule_691 _currn)
#else
void _VS3rule_691(_currn )
_TPPrule_691 _currn;

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
void _VS4rule_691(_TPPrule_691 _currn)
#else
void _VS4rule_691(_currn )
_TPPrule_691 _currn;

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
void _VS5rule_691(_TPPrule_691 _currn)
#else
void _VS5rule_691(_currn )
_TPPrule_691 _currn;

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

if (AND(NE(_currn->_desc1->_ATTypeLength_post, 4), NE(_currn->_desc1->_ATTypeLength_post, 8))) {
message(ERROR, "Kind not supported.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4428)*/
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
void _VS6rule_691(_TPPrule_691 _currn)
#else
void _VS6rule_691(_currn )
_TPPrule_691 _currn;

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
((EQ(_currn->_desc1->_ATTypeLength_post, 4)
) ? (PTGAsIs("float")
) : (PTGAsIs("double")))
;
/*SPC(4421)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_692(_TPPrule_692 _currn)
#else
void _VS1rule_692(_currn )
_TPPrule_692 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_ATType=RealType;
/*SPC(2656)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_692(_TPPrule_692 _currn)
#else
void _VS3rule_692(_currn )
_TPPrule_692 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_692(_TPPrule_692 _currn)
#else
void _VS4rule_692(_currn )
_TPPrule_692 _currn;

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
void _VS5rule_692(_TPPrule_692 _currn)
#else
void _VS5rule_692(_currn )
_TPPrule_692 _currn;

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
void _VS6rule_692(_TPPrule_692 _currn)
#else
void _VS6rule_692(_currn )
_TPPrule_692 _currn;

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
_currn->_ATPtg=PTGAsIs("float");
/*SPC(4358)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_693(_TPPrule_693 _currn)
#else
void _VS1rule_693(_currn )
_TPPrule_693 _currn;

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
/*SPC(2650)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_693(_TPPrule_693 _currn)
#else
void _VS2rule_693(_currn )
_TPPrule_693 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_693(_TPPrule_693 _currn)
#else
void _VS3rule_693(_currn )
_TPPrule_693 _currn;

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
void _VS4rule_693(_TPPrule_693 _currn)
#else
void _VS4rule_693(_currn )
_TPPrule_693 _currn;

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
void _VS5rule_693(_TPPrule_693 _currn)
#else
void _VS5rule_693(_currn )
_TPPrule_693 _currn;

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

if (AND(NE(_currn->_desc1->_ATTypeLength_post, 2), AND(NE(_currn->_desc1->_ATTypeLength_post, 4), NE(_currn->_desc1->_ATTypeLength_post, 8)))) {
message(ERROR, "Kind not supported.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4416)*/
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
void _VS6rule_693(_TPPrule_693 _currn)
#else
void _VS6rule_693(_currn )
_TPPrule_693 _currn;

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
((EQ(_currn->_desc1->_ATTypeLength_post, 2)
) ? (PTGAsIs("short")
) : (
((EQ(_currn->_desc1->_ATTypeLength_post, 4)
) ? (PTGAsIs("int")
) : (
((EQ(_currn->_desc1->_ATTypeLength_post, 8)
) ? (PTGAsIs("long")
) : (PTGAsIs("")))
))
))
;
/*SPC(4402)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_694(_TPPrule_694 _currn)
#else
void _VS1rule_694(_currn )
_TPPrule_694 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_ATType=IntegerType;
/*SPC(2645)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_694(_TPPrule_694 _currn)
#else
void _VS3rule_694(_currn )
_TPPrule_694 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_694(_TPPrule_694 _currn)
#else
void _VS4rule_694(_currn )
_TPPrule_694 _currn;

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
void _VS5rule_694(_TPPrule_694 _currn)
#else
void _VS5rule_694(_currn )
_TPPrule_694 _currn;

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
void _VS6rule_694(_TPPrule_694 _currn)
#else
void _VS6rule_694(_currn )
_TPPrule_694 _currn;

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
_currn->_ATPtg=PTGAsIs("int");
/*SPC(4354)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_695(_TPPrule_695 _currn)
#else
void _VS1rule_695(_currn )
_TPPrule_695 _currn;

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
_currn->_desc1->_ATType=_currn->_ATType;
/*SPC(2639)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_695(_TPPrule_695 _currn)
#else
void _VS2rule_695(_currn )
_TPPrule_695 _currn;

#endif
{
DefTableKey* _IL_incl40;
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl40=_IG_incl40;_IG_incl40= &(_currn->_ATType);
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_695(_TPPrule_695 _currn)
#else
void _VS3rule_695(_currn )
_TPPrule_695 _currn;

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
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATIsArray_pre=_currn->_desc1->_ATIsArray_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_695(_TPPrule_695 _currn)
#else
void _VS4rule_695(_currn )
_TPPrule_695 _currn;

#endif
{
DefTableKey* _IL_incl40;
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl40=_IG_incl40;_IG_incl40= &(_currn->_ATType);
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_695(_TPPrule_695 _currn)
#else
void _VS5rule_695(_currn )
_TPPrule_695 _currn;

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
_currn->_desc2->_AT_cProgDeclsListPtr_pre=_currn->_desc1->_AT_cProgDeclsListPtr_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_AT_cVariableUseListPtr_post=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc2->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_695(_TPPrule_695 _currn)
#else
void _VS6rule_695(_currn )
_TPPrule_695 _currn;

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
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
_IG_incl40=_IL_incl40;
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_696(_TPPrule_696 _currn)
#else
void _VS1rule_696(_currn )
_TPPrule_696 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11109)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATType=_currn->_desc2->_ATType;
/*SPC(2588)*/
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_696(_TPPrule_696 _currn)
#else
void _VS2rule_696(_currn )
_TPPrule_696 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_696(_TPPrule_696 _currn)
#else
void _VS3rule_696(_currn )
_TPPrule_696 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2587)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_696(_TPPrule_696 _currn)
#else
void _VS4rule_696(_currn )
_TPPrule_696 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
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
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_696(_TPPrule_696 _currn)
#else
void _VS5rule_696(_currn )
_TPPrule_696 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3681)*/
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
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_697(_TPPrule_697 _currn)
#else
void _VS1rule_697(_currn )
_TPPrule_697 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11103)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATType=_currn->_desc2->_ATType;
/*SPC(2584)*/
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_697(_TPPrule_697 _currn)
#else
void _VS2rule_697(_currn )
_TPPrule_697 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_697(_TPPrule_697 _currn)
#else
void _VS3rule_697(_currn )
_TPPrule_697 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2582)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_697(_TPPrule_697 _currn)
#else
void _VS4rule_697(_currn )
_TPPrule_697 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
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
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_697(_TPPrule_697 _currn)
#else
void _VS5rule_697(_currn )
_TPPrule_697 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3681)*/
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
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_698(_TPPrule_698 _currn)
#else
void _VS1rule_698(_currn )
_TPPrule_698 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
_currn->_desc1->_ATExecutable=0;
/*SPC(1735)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11097)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATOrder_pre=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATType=_currn->_desc2->_ATType;
/*SPC(2579)*/
_currn->_desc4->_ATOrder_pre=_currn->_desc3->_ATOrder_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATOrder_post=_currn->_desc4->_ATOrder_post;
/*SPC(0)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_698(_TPPrule_698 _currn)
#else
void _VS2rule_698(_currn )
_TPPrule_698 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATIsArray_pre=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATIsArray_post=_currn->_desc4->_ATIsArray_post;
/*SPC(0)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_698(_TPPrule_698 _currn)
#else
void _VS3rule_698(_currn )
_TPPrule_698 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2578)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_698(_TPPrule_698 _currn)
#else
void _VS4rule_698(_currn )
_TPPrule_698 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
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
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_desc4->_ATLocalIndex_pre=_currn->_desc3->_ATLocalIndex_post;
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
_currn->_desc4->_AT_cBoundsListPtr_pre=_currn->_desc3->_AT_cBoundsListPtr_post;
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
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_698(_TPPrule_698 _currn)
#else
void _VS5rule_698(_currn )
_TPPrule_698 _currn;

#endif
{
DefTableKey* _IL_incl26;

_VisitVarDecl()
_VisitEntry();
_IL_incl26=_IG_incl26;_IG_incl26= &(_currn->_ATType);
_currn->_desc1->_ATUpdateStmt_pre=_currn->_ATUpdateStmt_pre;
/*SPC(0)*/
_currn->_desc1->_ATF90LoopStart_pre=_currn->_ATF90LoopStart_pre;
/*SPC(0)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3681)*/
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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc4->_ATDepth_pre=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATUpdateStmt_post=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
_IG_incl26=_IL_incl26;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_699(_TPPrule_699 _currn)
#else
void _VS1rule_699(_currn )
_TPPrule_699 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2547)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11091)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_699(_TPPrule_699 _currn)
#else
void _VS2rule_699(_currn )
_TPPrule_699 _currn;

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
void _VS4rule_699(_TPPrule_699 _currn)
#else
void _VS4rule_699(_currn )
_TPPrule_699 _currn;

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
/*SPC(2546)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_699(_TPPrule_699 _currn)
#else
void _VS5rule_699(_currn )
_TPPrule_699 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_699(_TPPrule_699 _currn)
#else
void _VS6rule_699(_currn )
_TPPrule_699 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2546)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_699(_TPPrule_699 _currn)
#else
void _VS7rule_699(_currn )
_TPPrule_699 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_700(_TPPrule_700 _currn)
#else
void _VS1rule_700(_currn )
_TPPrule_700 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2543)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11085)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_700(_TPPrule_700 _currn)
#else
void _VS2rule_700(_currn )
_TPPrule_700 _currn;

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
void _VS4rule_700(_TPPrule_700 _currn)
#else
void _VS4rule_700(_currn )
_TPPrule_700 _currn;

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
/*SPC(2542)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_700(_TPPrule_700 _currn)
#else
void _VS5rule_700(_currn )
_TPPrule_700 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_700(_TPPrule_700 _currn)
#else
void _VS6rule_700(_currn )
_TPPrule_700 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2542)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_700(_TPPrule_700 _currn)
#else
void _VS7rule_700(_currn )
_TPPrule_700 _currn;

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
void _VS1rule_701(_TPPrule_701 _currn)
#else
void _VS1rule_701(_currn )
_TPPrule_701 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2539)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11079)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2538)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_701(_TPPrule_701 _currn)
#else
void _VS2rule_701(_currn )
_TPPrule_701 _currn;

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
void _VS3rule_701(_TPPrule_701 _currn)
#else
void _VS3rule_701(_currn )
_TPPrule_701 _currn;

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
void _VS1rule_702(_TPPrule_702 _currn)
#else
void _VS1rule_702(_currn )
_TPPrule_702 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2535)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11073)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2534)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_702(_TPPrule_702 _currn)
#else
void _VS2rule_702(_currn )
_TPPrule_702 _currn;

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
void _VS3rule_702(_TPPrule_702 _currn)
#else
void _VS3rule_702(_currn )
_TPPrule_702 _currn;

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
void _VS1rule_703(_TPPrule_703 _currn)
#else
void _VS1rule_703(_currn )
_TPPrule_703 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2531)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11067)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2530)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_703(_TPPrule_703 _currn)
#else
void _VS2rule_703(_currn )
_TPPrule_703 _currn;

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
void _VS3rule_703(_TPPrule_703 _currn)
#else
void _VS3rule_703(_currn )
_TPPrule_703 _currn;

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
void _VS1rule_704(_TPPrule_704 _currn)
#else
void _VS1rule_704(_currn )
_TPPrule_704 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2527)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11061)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2526)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_704(_TPPrule_704 _currn)
#else
void _VS2rule_704(_currn )
_TPPrule_704 _currn;

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
void _VS3rule_704(_TPPrule_704 _currn)
#else
void _VS3rule_704(_currn )
_TPPrule_704 _currn;

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
void _VS1rule_705(_TPPrule_705 _currn)
#else
void _VS1rule_705(_currn )
_TPPrule_705 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2521)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11055)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_705(_TPPrule_705 _currn)
#else
void _VS2rule_705(_currn )
_TPPrule_705 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_705(_TPPrule_705 _currn)
#else
void _VS4rule_705(_currn )
_TPPrule_705 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2519)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_705(_TPPrule_705 _currn)
#else
void _VS5rule_705(_currn )
_TPPrule_705 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
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
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_705(_TPPrule_705 _currn)
#else
void _VS6rule_705(_currn )
_TPPrule_705 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2519)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_705(_TPPrule_705 _currn)
#else
void _VS7rule_705(_currn )
_TPPrule_705 _currn;

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
void _VS1rule_706(_TPPrule_706 _currn)
#else
void _VS1rule_706(_currn )
_TPPrule_706 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2514)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11049)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_706(_TPPrule_706 _currn)
#else
void _VS2rule_706(_currn )
_TPPrule_706 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_706(_TPPrule_706 _currn)
#else
void _VS4rule_706(_currn )
_TPPrule_706 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2512)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_706(_TPPrule_706 _currn)
#else
void _VS5rule_706(_currn )
_TPPrule_706 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_706(_TPPrule_706 _currn)
#else
void _VS6rule_706(_currn )
_TPPrule_706 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2512)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_706(_TPPrule_706 _currn)
#else
void _VS7rule_706(_currn )
_TPPrule_706 _currn;

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
void _VS1rule_707(_TPPrule_707 _currn)
#else
void _VS1rule_707(_currn )
_TPPrule_707 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2507)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11043)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_707(_TPPrule_707 _currn)
#else
void _VS2rule_707(_currn )
_TPPrule_707 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_707(_TPPrule_707 _currn)
#else
void _VS4rule_707(_currn )
_TPPrule_707 _currn;

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
/*SPC(2505)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_707(_TPPrule_707 _currn)
#else
void _VS5rule_707(_currn )
_TPPrule_707 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
void _VS6rule_707(_TPPrule_707 _currn)
#else
void _VS6rule_707(_currn )
_TPPrule_707 _currn;

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
/*SPC(2505)*/
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
void _VS7rule_707(_TPPrule_707 _currn)
#else
void _VS7rule_707(_currn )
_TPPrule_707 _currn;

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
void _VS1rule_708(_TPPrule_708 _currn)
#else
void _VS1rule_708(_currn )
_TPPrule_708 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2500)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11037)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_708(_TPPrule_708 _currn)
#else
void _VS2rule_708(_currn )
_TPPrule_708 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_708(_TPPrule_708 _currn)
#else
void _VS4rule_708(_currn )
_TPPrule_708 _currn;

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
/*SPC(2498)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_708(_TPPrule_708 _currn)
#else
void _VS5rule_708(_currn )
_TPPrule_708 _currn;

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
void _VS6rule_708(_TPPrule_708 _currn)
#else
void _VS6rule_708(_currn )
_TPPrule_708 _currn;

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
/*SPC(2498)*/
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
void _VS7rule_708(_TPPrule_708 _currn)
#else
void _VS7rule_708(_currn )
_TPPrule_708 _currn;

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
void _VS1rule_709(_TPPrule_709 _currn)
#else
void _VS1rule_709(_currn )
_TPPrule_709 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2492)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11031)*/
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
void _VS2rule_709(_TPPrule_709 _currn)
#else
void _VS2rule_709(_currn )
_TPPrule_709 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_709(_TPPrule_709 _currn)
#else
void _VS3rule_709(_currn )
_TPPrule_709 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_709(_TPPrule_709 _currn)
#else
void _VS4rule_709(_currn )
_TPPrule_709 _currn;

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
_currn->_desc3->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2490)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_709(_TPPrule_709 _currn)
#else
void _VS5rule_709(_currn )
_TPPrule_709 _currn;

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
/*SPC(5156)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
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
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_709(_TPPrule_709 _currn)
#else
void _VS6rule_709(_currn )
_TPPrule_709 _currn;

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
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const39=ZERO();
/*SPC(2490)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_709(_TPPrule_709 _currn)
#else
void _VS7rule_709(_currn )
_TPPrule_709 _currn;

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
void _VS1rule_710(_TPPrule_710 _currn)
#else
void _VS1rule_710(_currn )
_TPPrule_710 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2486)*/
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
void _VS2rule_710(_TPPrule_710 _currn)
#else
void _VS2rule_710(_currn )
_TPPrule_710 _currn;

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
void _VS3rule_710(_TPPrule_710 _currn)
#else
void _VS3rule_710(_currn )
_TPPrule_710 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_710(_TPPrule_710 _currn)
#else
void _VS4rule_710(_currn )
_TPPrule_710 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const45=MAX(IDENTICAL(_currn->_desc1->_ATLastDeclarative), _currn->_desc3->_AT_const45);
/*SPC(2485)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_710(_TPPrule_710 _currn)
#else
void _VS5rule_710(_currn )
_TPPrule_710 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc3->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc3->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc3->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
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
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc3->_AT_cProgDeclsListPtr_pre=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATBaseValue_post=_currn->_desc3->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc3->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc3->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc3->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc3->_ATAccDoStmt_post;
/*SPC(0)*/
_currn->_ATArraySym_post=0;
/*SPC(8604)*/
_currn->_ATArrayId_post=NoKey;
/*SPC(8600)*/
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc3->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATPtg=PTGNULL;
/*SPC(11193)*/
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
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
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_710(_TPPrule_710 _currn)
#else
void _VS6rule_710(_currn )
_TPPrule_710 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc3->_ATSingleLineIf=FALSE;
/*SPC(7144)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const39=ADD(_currn->_desc3->_AT_const39, IDENTICAL(_currn->_desc3->_ATReturnStmt));
/*SPC(2485)*/
_currn->_ATThreadStmt_post=_currn->_desc3->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_710(_TPPrule_710 _currn)
#else
void _VS7rule_710(_currn )
_TPPrule_710 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_711(_TPPrule_711 _currn)
#else
void _VS1rule_711(_currn )
_TPPrule_711 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2480)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11022)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_711(_TPPrule_711 _currn)
#else
void _VS2rule_711(_currn )
_TPPrule_711 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_711(_TPPrule_711 _currn)
#else
void _VS4rule_711(_currn )
_TPPrule_711 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2478)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_711(_TPPrule_711 _currn)
#else
void _VS5rule_711(_currn )
_TPPrule_711 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_711(_TPPrule_711 _currn)
#else
void _VS6rule_711(_currn )
_TPPrule_711 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2478)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_711(_TPPrule_711 _currn)
#else
void _VS7rule_711(_currn )
_TPPrule_711 _currn;

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
void _VS1rule_712(_TPPrule_712 _currn)
#else
void _VS1rule_712(_currn )
_TPPrule_712 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2472)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11016)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_712(_TPPrule_712 _currn)
#else
void _VS2rule_712(_currn )
_TPPrule_712 _currn;

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
void _VS4rule_712(_TPPrule_712 _currn)
#else
void _VS4rule_712(_currn )
_TPPrule_712 _currn;

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
/*SPC(2470)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_712(_TPPrule_712 _currn)
#else
void _VS5rule_712(_currn )
_TPPrule_712 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_712(_TPPrule_712 _currn)
#else
void _VS6rule_712(_currn )
_TPPrule_712 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2470)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_712(_TPPrule_712 _currn)
#else
void _VS7rule_712(_currn )
_TPPrule_712 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_713(_TPPrule_713 _currn)
#else
void _VS1rule_713(_currn )
_TPPrule_713 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2464)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11010)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_713(_TPPrule_713 _currn)
#else
void _VS2rule_713(_currn )
_TPPrule_713 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_713(_TPPrule_713 _currn)
#else
void _VS3rule_713(_currn )
_TPPrule_713 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_713(_TPPrule_713 _currn)
#else
void _VS4rule_713(_currn )
_TPPrule_713 _currn;

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
/*SPC(2462)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_713(_TPPrule_713 _currn)
#else
void _VS5rule_713(_currn )
_TPPrule_713 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
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
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
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
_currn->_desc3->_ATNumArgs=0;
/*SPC(7011)*/
_currn->_desc3->_ATignoreVar=FALSE;
/*SPC(5129)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
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
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_713(_TPPrule_713 _currn)
#else
void _VS6rule_713(_currn )
_TPPrule_713 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const39=ZERO();
/*SPC(2462)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_713(_TPPrule_713 _currn)
#else
void _VS7rule_713(_currn )
_TPPrule_713 _currn;

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
void _VS1rule_714(_TPPrule_714 _currn)
#else
void _VS1rule_714(_currn )
_TPPrule_714 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2457)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(11004)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_714(_TPPrule_714 _currn)
#else
void _VS2rule_714(_currn )
_TPPrule_714 _currn;

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
void _VS4rule_714(_TPPrule_714 _currn)
#else
void _VS4rule_714(_currn )
_TPPrule_714 _currn;

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
/*SPC(2455)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_714(_TPPrule_714 _currn)
#else
void _VS5rule_714(_currn )
_TPPrule_714 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_714(_TPPrule_714 _currn)
#else
void _VS6rule_714(_currn )
_TPPrule_714 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2455)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_714(_TPPrule_714 _currn)
#else
void _VS7rule_714(_currn )
_TPPrule_714 _currn;

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
void _VS1rule_715(_TPPrule_715 _currn)
#else
void _VS1rule_715(_currn )
_TPPrule_715 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2451)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10998)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2450)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_715(_TPPrule_715 _currn)
#else
void _VS2rule_715(_currn )
_TPPrule_715 _currn;

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
void _VS3rule_715(_TPPrule_715 _currn)
#else
void _VS3rule_715(_currn )
_TPPrule_715 _currn;

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
void _VS1rule_716(_TPPrule_716 _currn)
#else
void _VS1rule_716(_currn )
_TPPrule_716 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2447)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10992)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2446)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_716(_TPPrule_716 _currn)
#else
void _VS2rule_716(_currn )
_TPPrule_716 _currn;

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
void _VS3rule_716(_TPPrule_716 _currn)
#else
void _VS3rule_716(_currn )
_TPPrule_716 _currn;

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
void _VS1rule_717(_TPPrule_717 _currn)
#else
void _VS1rule_717(_currn )
_TPPrule_717 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2443)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10986)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2442)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_717(_TPPrule_717 _currn)
#else
void _VS2rule_717(_currn )
_TPPrule_717 _currn;

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
void _VS3rule_717(_TPPrule_717 _currn)
#else
void _VS3rule_717(_currn )
_TPPrule_717 _currn;

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
void _VS1rule_718(_TPPrule_718 _currn)
#else
void _VS1rule_718(_currn )
_TPPrule_718 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2439)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10980)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2438)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_718(_TPPrule_718 _currn)
#else
void _VS2rule_718(_currn )
_TPPrule_718 _currn;

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
void _VS3rule_718(_TPPrule_718 _currn)
#else
void _VS3rule_718(_currn )
_TPPrule_718 _currn;

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
void _VS1rule_719(_TPPrule_719 _currn)
#else
void _VS1rule_719(_currn )
_TPPrule_719 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2433)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10974)*/
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
void _VS2rule_719(_TPPrule_719 _currn)
#else
void _VS2rule_719(_currn )
_TPPrule_719 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_719(_TPPrule_719 _currn)
#else
void _VS3rule_719(_currn )
_TPPrule_719 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_719(_TPPrule_719 _currn)
#else
void _VS4rule_719(_currn )
_TPPrule_719 _currn;

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
_currn->_desc3->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2431)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_719(_TPPrule_719 _currn)
#else
void _VS5rule_719(_currn )
_TPPrule_719 _currn;

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
/*SPC(5153)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
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
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_719(_TPPrule_719 _currn)
#else
void _VS6rule_719(_currn )
_TPPrule_719 _currn;

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
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const39=ZERO();
/*SPC(2431)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_719(_TPPrule_719 _currn)
#else
void _VS7rule_719(_currn )
_TPPrule_719 _currn;

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
void _VS1rule_720(_TPPrule_720 _currn)
#else
void _VS1rule_720(_currn )
_TPPrule_720 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2426)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10968)*/
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
void _VS2rule_720(_TPPrule_720 _currn)
#else
void _VS2rule_720(_currn )
_TPPrule_720 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_720(_TPPrule_720 _currn)
#else
void _VS3rule_720(_currn )
_TPPrule_720 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_720(_TPPrule_720 _currn)
#else
void _VS4rule_720(_currn )
_TPPrule_720 _currn;

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
_currn->_desc3->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2424)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_720(_TPPrule_720 _currn)
#else
void _VS5rule_720(_currn )
_TPPrule_720 _currn;

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
/*SPC(5150)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
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
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_720(_TPPrule_720 _currn)
#else
void _VS6rule_720(_currn )
_TPPrule_720 _currn;

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
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const39=ZERO();
/*SPC(2424)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_720(_TPPrule_720 _currn)
#else
void _VS7rule_720(_currn )
_TPPrule_720 _currn;

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
void _VS1rule_721(_TPPrule_721 _currn)
#else
void _VS1rule_721(_currn )
_TPPrule_721 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2419)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10962)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_721(_TPPrule_721 _currn)
#else
void _VS2rule_721(_currn )
_TPPrule_721 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_721(_TPPrule_721 _currn)
#else
void _VS4rule_721(_currn )
_TPPrule_721 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2417)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_721(_TPPrule_721 _currn)
#else
void _VS5rule_721(_currn )
_TPPrule_721 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_721(_TPPrule_721 _currn)
#else
void _VS6rule_721(_currn )
_TPPrule_721 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2417)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_721(_TPPrule_721 _currn)
#else
void _VS7rule_721(_currn )
_TPPrule_721 _currn;

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
void _VS1rule_722(_TPPrule_722 _currn)
#else
void _VS1rule_722(_currn )
_TPPrule_722 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2412)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10956)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_722(_TPPrule_722 _currn)
#else
void _VS2rule_722(_currn )
_TPPrule_722 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_722(_TPPrule_722 _currn)
#else
void _VS4rule_722(_currn )
_TPPrule_722 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2410)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_722(_TPPrule_722 _currn)
#else
void _VS5rule_722(_currn )
_TPPrule_722 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_722(_TPPrule_722 _currn)
#else
void _VS6rule_722(_currn )
_TPPrule_722 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2410)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_722(_TPPrule_722 _currn)
#else
void _VS7rule_722(_currn )
_TPPrule_722 _currn;

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
void _VS1rule_723(_TPPrule_723 _currn)
#else
void _VS1rule_723(_currn )
_TPPrule_723 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2404)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10950)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_723(_TPPrule_723 _currn)
#else
void _VS2rule_723(_currn )
_TPPrule_723 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_723(_TPPrule_723 _currn)
#else
void _VS3rule_723(_currn )
_TPPrule_723 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_723(_TPPrule_723 _currn)
#else
void _VS4rule_723(_currn )
_TPPrule_723 _currn;

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
/*SPC(2402)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_723(_TPPrule_723 _currn)
#else
void _VS5rule_723(_currn )
_TPPrule_723 _currn;

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
/*SPC(5147)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
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
void _VS6rule_723(_TPPrule_723 _currn)
#else
void _VS6rule_723(_currn )
_TPPrule_723 _currn;

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
_currn->_AT_const39=ZERO();
/*SPC(2402)*/
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
void _VS7rule_723(_TPPrule_723 _currn)
#else
void _VS7rule_723(_currn )
_TPPrule_723 _currn;

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
void _VS1rule_724(_TPPrule_724 _currn)
#else
void _VS1rule_724(_currn )
_TPPrule_724 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2397)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_724(_TPPrule_724 _currn)
#else
void _VS2rule_724(_currn )
_TPPrule_724 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_724(_TPPrule_724 _currn)
#else
void _VS4rule_724(_currn )
_TPPrule_724 _currn;

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
/*SPC(2395)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_724(_TPPrule_724 _currn)
#else
void _VS5rule_724(_currn )
_TPPrule_724 _currn;

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
_currn->_ATPtg=PTGBreak(_currn->_desc1->_ATPtg);
/*SPC(10936)*/
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
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
void _VS6rule_724(_TPPrule_724 _currn)
#else
void _VS6rule_724(_currn )
_TPPrule_724 _currn;

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

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (EQ(_currn->_ATSingleLineIf, FALSE)) {
PTGOut(PTGReplace(PTGNumber(MapLine(_currn->_AT_line)), PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATPtg));

} else {
}
;

} else {
}
;
/*SPC(10943)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12738)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8110)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3679)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=ZERO();
/*SPC(2395)*/
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
void _VS7rule_724(_TPPrule_724 _currn)
#else
void _VS7rule_724(_currn )
_TPPrule_724 _currn;

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
void _VS1rule_725(_TPPrule_725 _currn)
#else
void _VS1rule_725(_currn )
_TPPrule_725 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2389)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10931)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_725(_TPPrule_725 _currn)
#else
void _VS2rule_725(_currn )
_TPPrule_725 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_725(_TPPrule_725 _currn)
#else
void _VS3rule_725(_currn )
_TPPrule_725 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_725(_TPPrule_725 _currn)
#else
void _VS4rule_725(_currn )
_TPPrule_725 _currn;

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
/*SPC(2387)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_725(_TPPrule_725 _currn)
#else
void _VS5rule_725(_currn )
_TPPrule_725 _currn;

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
_currn->_desc2->_ATignoreVar=FALSE;
/*SPC(5129)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
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
void _VS6rule_725(_TPPrule_725 _currn)
#else
void _VS6rule_725(_currn )
_TPPrule_725 _currn;

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
_currn->_AT_const39=ZERO();
/*SPC(2387)*/
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
void _VS7rule_725(_TPPrule_725 _currn)
#else
void _VS7rule_725(_currn )
_TPPrule_725 _currn;

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
void _VS1rule_726(_TPPrule_726 _currn)
#else
void _VS1rule_726(_currn )
_TPPrule_726 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2382)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_726(_TPPrule_726 _currn)
#else
void _VS2rule_726(_currn )
_TPPrule_726 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_726(_TPPrule_726 _currn)
#else
void _VS4rule_726(_currn )
_TPPrule_726 _currn;

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
/*SPC(2380)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_726(_TPPrule_726 _currn)
#else
void _VS5rule_726(_currn )
_TPPrule_726 _currn;

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
_currn->_ATPtg=PTGAsIs("continue;");
/*SPC(10917)*/
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
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
void _VS6rule_726(_TPPrule_726 _currn)
#else
void _VS6rule_726(_currn )
_TPPrule_726 _currn;

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

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (EQ(_currn->_ATSingleLineIf, FALSE)) {
PTGOut(PTGReplace(PTGNumber(MapLine(_currn->_AT_line)), PTGIndent(_currn->_ATIndentLevel_pre), _currn->_ATPtg));

} else {
}
;

} else {
}
;
/*SPC(10924)*/
_currn->_desc1->_ATUpdateStmt_pre=FALSE;
/*SPC(12738)*/
_currn->_desc1->_ATF90LoopStart_pre=0;
/*SPC(8110)*/
_currn->_desc1->_ATDepth_pre=0;
/*SPC(3679)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const39=ZERO();
/*SPC(2380)*/
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
void _VS7rule_726(_TPPrule_726 _currn)
#else
void _VS7rule_726(_currn )
_TPPrule_726 _currn;

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
void _VS1rule_727(_TPPrule_727 _currn)
#else
void _VS1rule_727(_currn )
_TPPrule_727 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2376)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGRemove(PTGNumb(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(4836)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_727(_TPPrule_727 _currn)
#else
void _VS2rule_727(_currn )
_TPPrule_727 _currn;

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
void _VS4rule_727(_TPPrule_727 _currn)
#else
void _VS4rule_727(_currn )
_TPPrule_727 _currn;

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
_currn->_ATStmtId=DEALLOCATE;
/*SPC(4832)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2375)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_727(_TPPrule_727 _currn)
#else
void _VS5rule_727(_currn )
_TPPrule_727 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_727(_TPPrule_727 _currn)
#else
void _VS6rule_727(_currn )
_TPPrule_727 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2375)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_727(_TPPrule_727 _currn)
#else
void _VS7rule_727(_currn )
_TPPrule_727 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_728(_TPPrule_728 _currn)
#else
void _VS1rule_728(_currn )
_TPPrule_728 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2372)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "deallocate - stat=Variable option is not supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4827)*/
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
void _VS2rule_728(_TPPrule_728 _currn)
#else
void _VS2rule_728(_currn )
_TPPrule_728 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_728(_TPPrule_728 _currn)
#else
void _VS4rule_728(_currn )
_TPPrule_728 _currn;

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
_currn->_ATStmtId=DEALLOCATE;
/*SPC(4825)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2371)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_728(_TPPrule_728 _currn)
#else
void _VS5rule_728(_currn )
_TPPrule_728 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
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
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_728(_TPPrule_728 _currn)
#else
void _VS6rule_728(_currn )
_TPPrule_728 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const39=ZERO();
/*SPC(2371)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_728(_TPPrule_728 _currn)
#else
void _VS7rule_728(_currn )
_TPPrule_728 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_729(_TPPrule_729 _currn)
#else
void _VS1rule_729(_currn )
_TPPrule_729 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2368)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGRemove(PTGNumb(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(4844)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_729(_TPPrule_729 _currn)
#else
void _VS2rule_729(_currn )
_TPPrule_729 _currn;

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
void _VS4rule_729(_TPPrule_729 _currn)
#else
void _VS4rule_729(_currn )
_TPPrule_729 _currn;

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
_currn->_ATStmtId=ALLOCATE;
/*SPC(4822)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2367)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_729(_TPPrule_729 _currn)
#else
void _VS5rule_729(_currn )
_TPPrule_729 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_729(_TPPrule_729 _currn)
#else
void _VS6rule_729(_currn )
_TPPrule_729 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2367)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_729(_TPPrule_729 _currn)
#else
void _VS7rule_729(_currn )
_TPPrule_729 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_730(_TPPrule_730 _currn)
#else
void _VS1rule_730(_currn )
_TPPrule_730 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2364)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Allocate - stat=Variable option is not supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(4850)*/
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
void _VS2rule_730(_TPPrule_730 _currn)
#else
void _VS2rule_730(_currn )
_TPPrule_730 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_730(_TPPrule_730 _currn)
#else
void _VS4rule_730(_currn )
_TPPrule_730 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2363)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_730(_TPPrule_730 _currn)
#else
void _VS5rule_730(_currn )
_TPPrule_730 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
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
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_730(_TPPrule_730 _currn)
#else
void _VS6rule_730(_currn )
_TPPrule_730 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const39=ZERO();
/*SPC(2363)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_730(_TPPrule_730 _currn)
#else
void _VS7rule_730(_currn )
_TPPrule_730 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATBoundsList=_currn->_AT_BoundsauxList;
/*SPC(356)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_731(_TPPrule_731 _currn)
#else
void _VS1rule_731(_currn )
_TPPrule_731 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2360)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10912)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_731(_TPPrule_731 _currn)
#else
void _VS2rule_731(_currn )
_TPPrule_731 _currn;

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
void _VS4rule_731(_TPPrule_731 _currn)
#else
void _VS4rule_731(_currn )
_TPPrule_731 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2358)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_731(_TPPrule_731 _currn)
#else
void _VS5rule_731(_currn )
_TPPrule_731 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_731(_TPPrule_731 _currn)
#else
void _VS6rule_731(_currn )
_TPPrule_731 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2358)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_731(_TPPrule_731 _currn)
#else
void _VS7rule_731(_currn )
_TPPrule_731 _currn;

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
void _VS1rule_732(_TPPrule_732 _currn)
#else
void _VS1rule_732(_currn )
_TPPrule_732 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2355)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10906)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_732(_TPPrule_732 _currn)
#else
void _VS2rule_732(_currn )
_TPPrule_732 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_732(_TPPrule_732 _currn)
#else
void _VS4rule_732(_currn )
_TPPrule_732 _currn;

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
/*SPC(2353)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_732(_TPPrule_732 _currn)
#else
void _VS5rule_732(_currn )
_TPPrule_732 _currn;

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
void _VS6rule_732(_TPPrule_732 _currn)
#else
void _VS6rule_732(_currn )
_TPPrule_732 _currn;

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
/*SPC(2353)*/
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
void _VS7rule_732(_TPPrule_732 _currn)
#else
void _VS7rule_732(_currn )
_TPPrule_732 _currn;

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
void _VS1rule_733(_TPPrule_733 _currn)
#else
void _VS1rule_733(_currn )
_TPPrule_733 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2344)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10900)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2343)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_733(_TPPrule_733 _currn)
#else
void _VS2rule_733(_currn )
_TPPrule_733 _currn;

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
void _VS3rule_733(_TPPrule_733 _currn)
#else
void _VS3rule_733(_currn )
_TPPrule_733 _currn;

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
void _VS1rule_734(_TPPrule_734 _currn)
#else
void _VS1rule_734(_currn )
_TPPrule_734 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2340)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10894)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2339)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_734(_TPPrule_734 _currn)
#else
void _VS2rule_734(_currn )
_TPPrule_734 _currn;

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
void _VS3rule_734(_TPPrule_734 _currn)
#else
void _VS3rule_734(_currn )
_TPPrule_734 _currn;

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
void _VS1rule_735(_TPPrule_735 _currn)
#else
void _VS1rule_735(_currn )
_TPPrule_735 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2336)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10888)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2335)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_735(_TPPrule_735 _currn)
#else
void _VS2rule_735(_currn )
_TPPrule_735 _currn;

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
void _VS3rule_735(_TPPrule_735 _currn)
#else
void _VS3rule_735(_currn )
_TPPrule_735 _currn;

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
void _VS1rule_736(_TPPrule_736 _currn)
#else
void _VS1rule_736(_currn )
_TPPrule_736 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2332)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10882)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2331)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_736(_TPPrule_736 _currn)
#else
void _VS2rule_736(_currn )
_TPPrule_736 _currn;

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
void _VS3rule_736(_TPPrule_736 _currn)
#else
void _VS3rule_736(_currn )
_TPPrule_736 _currn;

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
void _VS1rule_737(_TPPrule_737 _currn)
#else
void _VS1rule_737(_currn )
_TPPrule_737 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2328)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10876)*/
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
void _VS2rule_737(_TPPrule_737 _currn)
#else
void _VS2rule_737(_currn )
_TPPrule_737 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_737(_TPPrule_737 _currn)
#else
void _VS3rule_737(_currn )
_TPPrule_737 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_737(_TPPrule_737 _currn)
#else
void _VS4rule_737(_currn )
_TPPrule_737 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const45=MAX(IDENTICAL(_currn->_desc1->_ATLastDeclarative), _currn->_desc3->_AT_const45);
/*SPC(2327)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_737(_TPPrule_737 _currn)
#else
void _VS5rule_737(_currn )
_TPPrule_737 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc3->_ATBaseValue_pre=_currn->_ATBaseValue_pre;
/*SPC(0)*/
_currn->_desc3->_ATThreadStop_pre=_currn->_ATThreadStop_pre;
/*SPC(0)*/
_currn->_desc3->_ATThreadStart_pre=_currn->_ATThreadStart_pre;
/*SPC(0)*/
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoType_pre=_currn->_ATAccDoType_pre;
/*SPC(0)*/
_currn->_desc3->_ATAccDoStmt_pre=_currn->_ATAccDoStmt_pre;
/*SPC(0)*/
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
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
_currn->_desc3->_ATDeclsOrder_pre=_currn->_desc2->_ATDeclsOrder_post;
/*SPC(0)*/
_currn->_desc3->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
_currn->_desc3->_AT_cProgDeclsListPtr_pre=_currn->_AT_cProgDeclsListPtr_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATBaseValue_post=_currn->_desc3->_ATBaseValue_post;
/*SPC(0)*/
_currn->_ATThreadStop_post=_currn->_desc3->_ATThreadStop_post;
/*SPC(0)*/
_currn->_ATThreadStart_post=_currn->_desc3->_ATThreadStart_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATAccDoType_post=_currn->_desc3->_ATAccDoType_post;
/*SPC(0)*/
_currn->_ATAccDoStmt_post=_currn->_desc3->_ATAccDoStmt_post;
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
_currn->_AT_cProgDeclsListPtr_post=_currn->_desc3->_AT_cProgDeclsListPtr_post;
/*SPC(0)*/
_currn->_ATGPUVarsDeList_post=_currn->_desc3->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_737(_TPPrule_737 _currn)
#else
void _VS6rule_737(_currn )
_TPPrule_737 _currn;

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
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATThreadStmt_pre=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_desc3->_ATSingleLineIf=FALSE;
/*SPC(7144)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const39=ADD(_currn->_desc3->_AT_const39, IDENTICAL(_currn->_desc3->_ATReturnStmt));
/*SPC(2327)*/
_currn->_ATThreadStmt_post=_currn->_desc3->_ATThreadStmt_post;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATDepth_post=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_737(_TPPrule_737 _currn)
#else
void _VS7rule_737(_currn )
_TPPrule_737 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_738(_TPPrule_738 _currn)
#else
void _VS1rule_738(_currn )
_TPPrule_738 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2324)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10870)*/
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
void _VS2rule_738(_TPPrule_738 _currn)
#else
void _VS2rule_738(_currn )
_TPPrule_738 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2323)*/
_currn->_ATIsArray_post=_currn->_desc3->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_738(_TPPrule_738 _currn)
#else
void _VS3rule_738(_currn )
_TPPrule_738 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
/*SPC(5144)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
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
_currn->_desc3->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
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
void _VS4rule_738(_TPPrule_738 _currn)
#else
void _VS4rule_738(_currn )
_TPPrule_738 _currn;

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
_currn->_desc2->_ATUpdateStmt_pre=_currn->_desc1->_ATUpdateStmt_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
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
void _VS1rule_739(_TPPrule_739 _currn)
#else
void _VS1rule_739(_currn )
_TPPrule_739 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2320)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10864)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_739(_TPPrule_739 _currn)
#else
void _VS2rule_739(_currn )
_TPPrule_739 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2319)*/
_currn->_ATIsArray_post=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_739(_TPPrule_739 _currn)
#else
void _VS3rule_739(_currn )
_TPPrule_739 _currn;

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
void _VS4rule_739(_TPPrule_739 _currn)
#else
void _VS4rule_739(_currn )
_TPPrule_739 _currn;

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
void _VS1rule_740(_TPPrule_740 _currn)
#else
void _VS1rule_740(_currn )
_TPPrule_740 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2314)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(7258)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_740(_TPPrule_740 _currn)
#else
void _VS2rule_740(_currn )
_TPPrule_740 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_740(_TPPrule_740 _currn)
#else
void _VS4rule_740(_currn )
_TPPrule_740 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2312)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_740(_TPPrule_740 _currn)
#else
void _VS5rule_740(_currn )
_TPPrule_740 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
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
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_740(_TPPrule_740 _currn)
#else
void _VS6rule_740(_currn )
_TPPrule_740 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2312)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_740(_TPPrule_740 _currn)
#else
void _VS7rule_740(_currn )
_TPPrule_740 _currn;

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
void _VS1rule_741(_TPPrule_741 _currn)
#else
void _VS1rule_741(_currn )
_TPPrule_741 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2307)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(7252)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_741(_TPPrule_741 _currn)
#else
void _VS2rule_741(_currn )
_TPPrule_741 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_741(_TPPrule_741 _currn)
#else
void _VS4rule_741(_currn )
_TPPrule_741 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2305)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_741(_TPPrule_741 _currn)
#else
void _VS5rule_741(_currn )
_TPPrule_741 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
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
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_741(_TPPrule_741 _currn)
#else
void _VS6rule_741(_currn )
_TPPrule_741 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2305)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_741(_TPPrule_741 _currn)
#else
void _VS7rule_741(_currn )
_TPPrule_741 _currn;

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
void _VS1rule_742(_TPPrule_742 _currn)
#else
void _VS1rule_742(_currn )
_TPPrule_742 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2300)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_742(_TPPrule_742 _currn)
#else
void _VS2rule_742(_currn )
_TPPrule_742 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_742(_TPPrule_742 _currn)
#else
void _VS4rule_742(_currn )
_TPPrule_742 _currn;

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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2298)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_742(_TPPrule_742 _currn)
#else
void _VS5rule_742(_currn )
_TPPrule_742 _currn;

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
_currn->_desc1->_ATIndentLevel_pre=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (SUB(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11348)*/
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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGElseIf(PTGNumber(MapLine(_currn->_AT_line)), PTGIndent(_currn->_desc1->_ATIndentLevel_post), _currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg));

} else {
}
;
/*SPC(7239)*/
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
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (ADD(_currn->_desc1->_ATIndentLevel_post, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11353)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_742(_TPPrule_742 _currn)
#else
void _VS6rule_742(_currn )
_TPPrule_742 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_AT_const39=ZERO();
/*SPC(2298)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_742(_TPPrule_742 _currn)
#else
void _VS7rule_742(_currn )
_TPPrule_742 _currn;

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
void _VS1rule_743(_TPPrule_743 _currn)
#else
void _VS1rule_743(_currn )
_TPPrule_743 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2286)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(7246)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_743(_TPPrule_743 _currn)
#else
void _VS2rule_743(_currn )
_TPPrule_743 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_743(_TPPrule_743 _currn)
#else
void _VS4rule_743(_currn )
_TPPrule_743 _currn;

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
/*SPC(2284)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_743(_TPPrule_743 _currn)
#else
void _VS5rule_743(_currn )
_TPPrule_743 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
void _VS6rule_743(_TPPrule_743 _currn)
#else
void _VS6rule_743(_currn )
_TPPrule_743 _currn;

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
/*SPC(2284)*/
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
void _VS7rule_743(_TPPrule_743 _currn)
#else
void _VS7rule_743(_currn )
_TPPrule_743 _currn;

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
void _VS1rule_744(_TPPrule_744 _currn)
#else
void _VS1rule_744(_currn )
_TPPrule_744 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2271)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10858)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_744(_TPPrule_744 _currn)
#else
void _VS2rule_744(_currn )
_TPPrule_744 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_744(_TPPrule_744 _currn)
#else
void _VS3rule_744(_currn )
_TPPrule_744 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_744(_TPPrule_744 _currn)
#else
void _VS4rule_744(_currn )
_TPPrule_744 _currn;

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
/*SPC(2269)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_744(_TPPrule_744 _currn)
#else
void _VS5rule_744(_currn )
_TPPrule_744 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), _currn->_ATNestLevel_pre))) {
message(ERROR, "ACC$DO GPU parallelism not supported with this construct.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(13102)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=ADD(_currn->_ATNestLevel_pre, 1);
/*SPC(11994)*/
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
/*SPC(5141)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(ZERO(), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
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
void _VS6rule_744(_TPPrule_744 _currn)
#else
void _VS6rule_744(_currn )
_TPPrule_744 _currn;

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
_currn->_AT_const39=ZERO();
/*SPC(2269)*/
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
void _VS7rule_744(_TPPrule_744 _currn)
#else
void _VS7rule_744(_currn )
_TPPrule_744 _currn;

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
void _VS1rule_745(_TPPrule_745 _currn)
#else
void _VS1rule_745(_currn )
_TPPrule_745 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2264)*/
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
void _VS2rule_745(_TPPrule_745 _currn)
#else
void _VS2rule_745(_currn )
_TPPrule_745 _currn;

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
void _VS3rule_745(_TPPrule_745 _currn)
#else
void _VS3rule_745(_currn )
_TPPrule_745 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_745(_TPPrule_745 _currn)
#else
void _VS4rule_745(_currn )
_TPPrule_745 _currn;

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
/*SPC(2262)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_745(_TPPrule_745 _currn)
#else
void _VS5rule_745(_currn )
_TPPrule_745 _currn;

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
_currn->_desc1->_ATNestLevel_pre=ADD(_currn->_ATNestLevel_pre, 1);
/*SPC(11990)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATloopVar_RuleAttr_1202=_currn->_desc3->_AT_const61;
/*SPC(13030)*/
_currn->_desc1->_ATDoAcc_pre=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(_currn->_ATAccDoStmt_pre, _currn->_ATStmtNumber_pre))
) ? (SetAccDo(_currn->_ATDoAcc_pre, _currn->_ATAccDoType_pre, _currn->_desc1->_ATNestLevel_post, _currn->_ATThreadStart_pre, _currn->_ATThreadStop_pre, _currn->_ATAccDoLoopDim_pre, _currn->_ATloopVar_RuleAttr_1202, _currn->_ATBaseValue_pre, (&( _currn->_AT_pos)))
) : (_currn->_ATDoAcc_pre))
;
/*SPC(13044)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc3->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATthreadType_RuleAttr_1202=
((EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, VECTOR, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)
) ? (VECTOR
) : (
((EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, PARALLEL, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)
) ? (PARALLEL
) : (FALSE))
))
;
/*SPC(7373)*/
_currn->_ATthreadRange_RuleAttr_1202=
((AND(OR(EQ(_currn->_ATthreadType_RuleAttr_1202, VECTOR), EQ(_currn->_ATthreadType_RuleAttr_1202, PARALLEL)), NE(_currn->_ATThreadStart_pre, 0))
) ? (PTGIfThread(PTGIndent(_currn->_desc1->_ATIndentLevel_post), _currn->_desc3->_AT_const60, PTGString(StringTable(GetAccDo(_currn->_desc1->_ATDoAcc_post, _currn->_ATAccDoLoopDim_pre, _currn->_ATthreadType_RuleAttr_1202, START, 0, (&( _currn->_AT_pos))))), _currn->_desc3->_AT_const60, PTGString(StringTable(GetAccDo(_currn->_desc1->_ATDoAcc_post, _currn->_ATAccDoLoopDim_pre, _currn->_ATthreadType_RuleAttr_1202, STOP, 0, (&( _currn->_AT_pos))))))
) : (PTGNULL))
;
/*SPC(7382)*/
_currn->_ATthreadStart_RuleAttr_1202=
((AND(NE(_currn->_ATthreadType_RuleAttr_1202, 0), GT(GetAccDo(_currn->_desc1->_ATDoAcc_post, _currn->_ATAccDoLoopDim_pre, _currn->_ATthreadType_RuleAttr_1202, BASE, 0, (&( _currn->_AT_pos))), 0))
) ? (PTGString(StringTable(GetAccDo(_currn->_desc1->_ATDoAcc_post, _currn->_ATAccDoLoopDim_pre, _currn->_ATthreadType_RuleAttr_1202, BASE, 0, (&( _currn->_AT_pos)))))
) : (_currn->_desc3->_ATLoopStart))
;
/*SPC(7398)*/
_currn->_ATdoIndex_RuleAttr_1202=
((EQ(_currn->_ATAccDoLoopDim_pre, 1)
) ? (PTGAsIs("x")
) : (
((EQ(_currn->_ATAccDoLoopDim_pre, 2)
) ? (PTGAsIs("y")
) : (
((EQ(_currn->_ATAccDoLoopDim_pre, 3)
) ? (PTGAsIs("z")
) : (PTGNULL))
))
))
;
/*SPC(7407)*/
_currn->_ATGPUindex_RuleAttr_1202=
((EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, PARALLEL, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)
) ? (ConstructLoopIndex(_currn->_ATdoIndex_RuleAttr_1202, _currn->_ATthreadStart_RuleAttr_1202, PARALLEL, _currn->_desc1->_ATRegionVars_post, _currn->_ATAccDoLoopDim_pre, TRUE)
) : (
((EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, VECTOR, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)
) ? (ConstructLoopIndex(_currn->_ATdoIndex_RuleAttr_1202, _currn->_ATthreadStart_RuleAttr_1202, VECTOR, _currn->_desc1->_ATRegionVars_post, _currn->_ATAccDoLoopDim_pre, TRUE)
) : (PTGNULL))
))
;
/*SPC(7419)*/
_currn->_ATPtg=PTGForLoop(_currn->_desc1->_ATPtg, _currn->_desc3->_ATPtg);
/*SPC(7428)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12737)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4605)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, ACCDO, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)) {
PTGOut(PTGAccDoLoop1(PTGNumb(MapLine(((_currn->_AT_pos).line))), PTGIndent(_currn->_desc1->_ATIndentLevel_post), _currn->_desc3->_AT_const60, _currn->_ATGPUindex_RuleAttr_1202, PTGNumb(MapLine(((_currn->_AT_pos).line))), _currn->_ATthreadRange_RuleAttr_1202, PTGIndent(_currn->_desc1->_ATIndentLevel_post), _currn->_ATPtg));

} else {
PTGOut(PTGReplace(PTGNumb(MapLine(((_currn->_AT_pos).line))), PTGIndent(_currn->_desc1->_ATIndentLevel_post), _currn->_ATPtg));
}
;

} else {
}
;
/*SPC(7430)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(7372)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
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
/*SPC(5138)*/
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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATRegionVars_post=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(_currn->_ATAccDoStmt_pre, _currn->_ATStmtNumber_pre))
) ? (
((EQ(_currn->_ATAccDoType_pre, PARALLEL)
) ? (SetRegionVar(_currn->_ATRegionVars_pre, DO_PARALLEL, _currn->_ATloopVar_RuleAttr_1202, NoKey, _currn->_ATAccDoLoopDim_pre, 0, 0, 0, _currn->_desc3->_ATLoopStart, (&( _currn->_AT_pos)))
) : (
((EQ(_currn->_ATAccDoType_pre, VECTOR)
) ? (SetRegionVar(_currn->_ATRegionVars_pre, DO_VECTOR, _currn->_ATloopVar_RuleAttr_1202, NoKey, _currn->_ATAccDoLoopDim_pre, 0, 0, 0, _currn->_desc3->_ATLoopStart, (&( _currn->_AT_pos)))
) : (_currn->_ATRegionVars_pre))
))

) : (_currn->_ATRegionVars_pre))
;
/*SPC(13031)*/
_currn->_ATIndentLevel_post=
((EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0)
) ? (ADD(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11221)*/
_currn->_ATTranslationType_post=_currn->_desc3->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc3->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc3->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(IDENTICAL(_currn->_desc3->_ATDoLoop), 0), GE(GetAccInfo(_currn->_desc3->_ATDoAcc_post, ACCDO, _currn->_desc3->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc3->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc3->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_745(_TPPrule_745 _currn)
#else
void _VS6rule_745(_currn )
_TPPrule_745 _currn;

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
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc3->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), NE(_currn->_desc3->_ATNumArgs, 2))) {

if (EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, ACCDO, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)) {
message(WARNING, "ACC$DO does not support do-loop stride arguments", 0, (&( _currn->_AT_pos)));

} else {
}
;

} else {
}
;
/*SPC(7459)*/
_currn->_AT_const39=ZERO();
/*SPC(2262)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_745(_TPPrule_745 _currn)
#else
void _VS7rule_745(_currn )
_TPPrule_745 _currn;

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
void _VS1rule_746(_TPPrule_746 _currn)
#else
void _VS1rule_746(_currn )
_TPPrule_746 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2257)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10852)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_746(_TPPrule_746 _currn)
#else
void _VS2rule_746(_currn )
_TPPrule_746 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_746(_TPPrule_746 _currn)
#else
void _VS3rule_746(_currn )
_TPPrule_746 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_746(_TPPrule_746 _currn)
#else
void _VS4rule_746(_currn )
_TPPrule_746 _currn;

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
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
ResetDoLabelCount(_currn->_desc3->_ATUnitKey, ADD(GetDoLabelCount(_currn->_desc3->_ATUnitKey, 0), 1));
/*SPC(11950)*/
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2255)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_746(_TPPrule_746 _currn)
#else
void _VS5rule_746(_currn )
_TPPrule_746 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), _currn->_ATNestLevel_pre))) {
message(ERROR, "ACC$DO GPU parallelism not supported with this construct.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(13096)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=ADD(_currn->_ATNestLevel_pre, 1);
/*SPC(11986)*/
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
/*SPC(5135)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
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
void _VS6rule_746(_TPPrule_746 _currn)
#else
void _VS6rule_746(_currn )
_TPPrule_746 _currn;

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
_currn->_AT_const39=ZERO();
/*SPC(2255)*/
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
void _VS7rule_746(_TPPrule_746 _currn)
#else
void _VS7rule_746(_currn )
_TPPrule_746 _currn;

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
void _VS1rule_747(_TPPrule_747 _currn)
#else
void _VS1rule_747(_currn )
_TPPrule_747 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2250)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10846)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc4->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATOrder_post=_currn->_desc4->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_747(_TPPrule_747 _currn)
#else
void _VS2rule_747(_currn )
_TPPrule_747 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_747(_TPPrule_747 _currn)
#else
void _VS3rule_747(_currn )
_TPPrule_747 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_747(_TPPrule_747 _currn)
#else
void _VS4rule_747(_currn )
_TPPrule_747 _currn;

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
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
ResetDoLabelCount(_currn->_desc3->_ATUnitKey, ADD(GetDoLabelCount(_currn->_desc3->_ATUnitKey, 0), 1));
/*SPC(11943)*/
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2248)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_747(_TPPrule_747 _currn)
#else
void _VS5rule_747(_currn )
_TPPrule_747 _currn;

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
_currn->_desc1->_ATNestLevel_pre=ADD(_currn->_ATNestLevel_pre, 1);
/*SPC(11982)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATloopVar_RuleAttr_1204=_currn->_desc4->_AT_const61;
/*SPC(13007)*/
_currn->_desc1->_ATDoAcc_pre=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(_currn->_ATAccDoStmt_pre, _currn->_ATStmtNumber_pre))
) ? (SetAccDo(_currn->_ATDoAcc_pre, _currn->_ATAccDoType_pre, _currn->_desc1->_ATNestLevel_post, _currn->_ATThreadStart_pre, _currn->_ATThreadStop_pre, _currn->_ATAccDoLoopDim_pre, _currn->_ATloopVar_RuleAttr_1204, _currn->_ATBaseValue_pre, (&( _currn->_AT_pos)))
) : (_currn->_ATDoAcc_pre))
;
/*SPC(13021)*/
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
/*SPC(5132)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATDoAcc_pre=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
_currn->_desc4->_ATTranslationType_pre=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_desc4->_ATDoAcc_pre=_currn->_desc3->_ATDoAcc_post;
/*SPC(0)*/
_currn->_desc4->_ATRegionVars_pre=_currn->_desc2->_ATRegionVars_post;
/*SPC(0)*/
_currn->_desc4->_ATAcceleratorRegion_pre=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_desc4->_ATLastNonExecLine_pre=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_desc4->_ATIndentLevel_pre=_currn->_desc2->_ATIndentLevel_post;
/*SPC(0)*/
_currn->_desc4->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc4->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc4->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc4->_ATArrayId_pre=_currn->_desc2->_ATArrayId_post;
/*SPC(0)*/
_currn->_desc4->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_desc4->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc4->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
_currn->_desc4->_AT_cBoundsListPtr_pre=_currn->_desc3->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATStmtNumber_pre=_currn->_desc3->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc4->_ATAccDoLoopDim_pre=_currn->_desc3->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc4->_ATNestLevel_pre=_currn->_desc3->_ATNestLevel_post;
/*SPC(0)*/
_currn->_desc4->_ATMaxRank_pre=_currn->_desc2->_ATMaxRank_post;
/*SPC(0)*/
_currn->_desc4->_ATCPURegionNumber_pre=_currn->_desc2->_ATCPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATGPURegionNumber_pre=_currn->_desc2->_ATGPURegionNumber_post;
/*SPC(0)*/
_currn->_desc4->_ATTypeLength_pre=_currn->_desc2->_ATTypeLength_post;
/*SPC(0)*/
_currn->_desc4->_AT_cVariableUseListPtr_pre=_currn->_desc2->_AT_cVariableUseListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
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
_currn->_ATIndentLevel_post=_currn->_desc4->_ATIndentLevel_post;
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
_currn->_ATRegionVars_post=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(_currn->_ATAccDoStmt_pre, _currn->_ATStmtNumber_pre))
) ? (
((EQ(_currn->_ATAccDoType_pre, PARALLEL)
) ? (SetRegionVar(_currn->_ATRegionVars_pre, DO_PARALLEL, _currn->_ATloopVar_RuleAttr_1204, NoKey, _currn->_ATAccDoLoopDim_pre, 0, 0, 0, _currn->_desc4->_ATLoopStart, (&( _currn->_AT_pos)))
) : (
((EQ(_currn->_ATAccDoType_pre, VECTOR)
) ? (SetRegionVar(_currn->_ATRegionVars_pre, DO_VECTOR, _currn->_ATloopVar_RuleAttr_1204, NoKey, _currn->_ATAccDoLoopDim_pre, 0, 0, 0, _currn->_desc4->_ATLoopStart, (&( _currn->_AT_pos)))
) : (_currn->_ATRegionVars_pre))
))

) : (_currn->_ATRegionVars_pre))
;
/*SPC(13008)*/
_currn->_ATTranslationType_post=_currn->_desc4->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc4->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc4->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc4->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(IDENTICAL(_currn->_desc4->_ATDoLoop), 0), GE(GetAccInfo(_currn->_desc4->_ATDoAcc_post, ACCDO, _currn->_desc4->_ATNestLevel_post, 0), TRUE))
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_747(_TPPrule_747 _currn)
#else
void _VS6rule_747(_currn )
_TPPrule_747 _currn;

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
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc4->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_AT_const39=ZERO();
/*SPC(2248)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_747(_TPPrule_747 _currn)
#else
void _VS7rule_747(_currn )
_TPPrule_747 _currn;

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
void _VS1rule_748(_TPPrule_748 _currn)
#else
void _VS1rule_748(_currn )
_TPPrule_748 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2243)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10840)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_748(_TPPrule_748 _currn)
#else
void _VS2rule_748(_currn )
_TPPrule_748 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_748(_TPPrule_748 _currn)
#else
void _VS4rule_748(_currn )
_TPPrule_748 _currn;

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
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
ResetDoLabelCount(_currn->_desc2->_ATUnitKey, ADD(GetDoLabelCount(_currn->_desc2->_ATUnitKey, 0), 1));
/*SPC(11936)*/
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2241)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_748(_TPPrule_748 _currn)
#else
void _VS5rule_748(_currn )
_TPPrule_748 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), TRUE))) {
message(ERROR, "ACC$DO GPU parallelism not supported with this construct.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(13084)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=ADD(_currn->_ATNestLevel_pre, 1);
/*SPC(11970)*/
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATStmtNumber_pre=_currn->_desc1->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc2->_ATAccDoLoopDim_pre=_currn->_desc1->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc2->_ATNestLevel_pre=_currn->_desc1->_ATNestLevel_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
void _VS6rule_748(_TPPrule_748 _currn)
#else
void _VS6rule_748(_currn )
_TPPrule_748 _currn;

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
/*SPC(2241)*/
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
void _VS7rule_748(_TPPrule_748 _currn)
#else
void _VS7rule_748(_currn )
_TPPrule_748 _currn;

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
void _VS1rule_749(_TPPrule_749 _currn)
#else
void _VS1rule_749(_currn )
_TPPrule_749 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2236)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10834)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_749(_TPPrule_749 _currn)
#else
void _VS2rule_749(_currn )
_TPPrule_749 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_749(_TPPrule_749 _currn)
#else
void _VS4rule_749(_currn )
_TPPrule_749 _currn;

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
/*SPC(2234)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_749(_TPPrule_749 _currn)
#else
void _VS5rule_749(_currn )
_TPPrule_749 _currn;

#endif
{
DefTableKey* _IL_incl60;
int* _IL_incl34;

_VisitVarDecl()
_VisitEntry();
_IL_incl60=_IG_incl60;_IG_incl60= &(_currn->_ATStmtUnitId);
_IL_incl34=_IG_incl34;_IG_incl34= &(_currn->_ATStmtId);

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), TRUE))) {
message(ERROR, "ACC$DO GPU parallelism not supported with this construct.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(13090)*/
_currn->_desc1->_ATRegionVars_pre=_currn->_ATRegionVars_pre;
/*SPC(0)*/
_currn->_desc1->_ATIndentLevel_pre=_currn->_ATIndentLevel_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=ADD(_currn->_ATNestLevel_pre, 1);
/*SPC(11978)*/
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
void _VS6rule_749(_TPPrule_749 _currn)
#else
void _VS6rule_749(_currn )
_TPPrule_749 _currn;

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
/*SPC(2234)*/
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
void _VS7rule_749(_TPPrule_749 _currn)
#else
void _VS7rule_749(_currn )
_TPPrule_749 _currn;

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
void _VS1rule_750(_TPPrule_750 _currn)
#else
void _VS1rule_750(_currn )
_TPPrule_750 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2229)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATOrder_post=_currn->_desc2->_ATOrder_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_750(_TPPrule_750 _currn)
#else
void _VS2rule_750(_currn )
_TPPrule_750 _currn;

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
void _VS4rule_750(_TPPrule_750 _currn)
#else
void _VS4rule_750(_currn )
_TPPrule_750 _currn;

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
/*SPC(2227)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_750(_TPPrule_750 _currn)
#else
void _VS5rule_750(_currn )
_TPPrule_750 _currn;

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
_currn->_desc1->_ATNestLevel_pre=ADD(_currn->_ATNestLevel_pre, 1);
/*SPC(11974)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATloopVar_RuleAttr_1207=_currn->_desc2->_AT_const61;
/*SPC(12977)*/
_currn->_desc1->_ATDoAcc_pre=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(_currn->_ATAccDoStmt_pre, _currn->_ATStmtNumber_pre))
) ? (SetAccDo(_currn->_ATDoAcc_pre, _currn->_ATAccDoType_pre, _currn->_desc1->_ATNestLevel_post, _currn->_ATThreadStart_pre, _currn->_ATThreadStop_pre, _currn->_ATAccDoLoopDim_pre, _currn->_ATloopVar_RuleAttr_1207, _currn->_ATBaseValue_pre, (&( _currn->_AT_pos)))
) : (_currn->_ATDoAcc_pre))
;
/*SPC(12998)*/
_currn->_desc1->_ATLastNonExecLine_pre=_currn->_ATLastNonExecLine_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc2->_ATArgCnt_pre=_currn->_ATArgCnt_pre;
/*SPC(0)*/
_currn->_desc2->_ATArraySym_pre=_currn->_ATArraySym_pre;
/*SPC(0)*/
_currn->_desc2->_ATArrayId_pre=_currn->_ATArrayId_pre;
/*SPC(0)*/
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
_currn->_desc2->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc2->_ATGPUVarsDeList_pre=_currn->_ATGPUVarsDeList_pre;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATthreadType_RuleAttr_1207=
((EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, VECTOR, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)
) ? (VECTOR
) : (
((EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, PARALLEL, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)
) ? (PARALLEL
) : (FALSE))
))
;
/*SPC(7270)*/
_currn->_ATthreadRange_RuleAttr_1207=
((AND(OR(EQ(_currn->_ATthreadType_RuleAttr_1207, VECTOR), EQ(_currn->_ATthreadType_RuleAttr_1207, PARALLEL)), NE(_currn->_ATThreadStart_pre, 0))
) ? (PTGIfThread(PTGIndent(_currn->_desc1->_ATIndentLevel_post), _currn->_desc2->_AT_const60, PTGString(StringTable(GetAccDo(_currn->_desc1->_ATDoAcc_post, _currn->_ATAccDoLoopDim_pre, _currn->_ATthreadType_RuleAttr_1207, START, 0, (&( _currn->_AT_pos))))), _currn->_desc2->_AT_const60, PTGString(StringTable(GetAccDo(_currn->_desc1->_ATDoAcc_post, _currn->_ATAccDoLoopDim_pre, _currn->_ATthreadType_RuleAttr_1207, STOP, 0, (&( _currn->_AT_pos))))))
) : (PTGNULL))
;
/*SPC(7278)*/
_currn->_ATthreadStart_RuleAttr_1207=
((AND(NE(_currn->_ATthreadType_RuleAttr_1207, 0), GT(GetAccDo(_currn->_desc1->_ATDoAcc_post, _currn->_ATAccDoLoopDim_pre, _currn->_ATthreadType_RuleAttr_1207, BASE, 0, (&( _currn->_AT_pos))), 0))
) ? (PTGString(StringTable(GetAccDo(_currn->_desc1->_ATDoAcc_post, _currn->_ATAccDoLoopDim_pre, _currn->_ATthreadType_RuleAttr_1207, BASE, 0, (&( _currn->_AT_pos)))))
) : (_currn->_desc2->_ATLoopStart))
;
/*SPC(7295)*/
_currn->_ATdoIndex_RuleAttr_1207=
((EQ(_currn->_ATAccDoLoopDim_pre, 1)
) ? (PTGAsIs("x")
) : (
((EQ(_currn->_ATAccDoLoopDim_pre, 2)
) ? (PTGAsIs("y")
) : (
((EQ(_currn->_ATAccDoLoopDim_pre, 3)
) ? (PTGAsIs("z")
) : (PTGNULL))
))
))
;
/*SPC(7304)*/
_currn->_ATGPUindex_RuleAttr_1207=
((EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, PARALLEL, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)
) ? (ConstructLoopIndex(_currn->_ATdoIndex_RuleAttr_1207, _currn->_ATthreadStart_RuleAttr_1207, PARALLEL, _currn->_desc1->_ATRegionVars_post, _currn->_ATAccDoLoopDim_pre, TRUE)
) : (
((EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, VECTOR, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)
) ? (ConstructLoopIndex(_currn->_ATdoIndex_RuleAttr_1207, _currn->_ATthreadStart_RuleAttr_1207, VECTOR, _currn->_desc1->_ATRegionVars_post, _currn->_ATAccDoLoopDim_pre, TRUE)
) : (PTGNULL))
))
;
/*SPC(7316)*/
_currn->_ATPtg=PTGForLoop(_currn->_desc1->_ATPtg, _currn->_desc2->_ATPtg);
/*SPC(7351)*/
_currn->_desc1->_ATStmtNumber_pre=_currn->_ATStmtNumber_pre;
/*SPC(0)*/
_currn->_desc1->_ATUpdate_pre=FALSE;
/*SPC(12737)*/
_currn->_desc1->_ATAccDoLoopDim_pre=_currn->_ATAccDoLoopDim_pre;
/*SPC(0)*/
_currn->_desc1->_ATTypeLength_pre=0;
/*SPC(4605)*/

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {

if (EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, ACCDO, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)) {
PTGOut(PTGAccDoLoop1(PTGNumb(MapLine(((_currn->_AT_pos).line))), PTGIndent(_currn->_desc1->_ATIndentLevel_post), _currn->_desc2->_AT_const60, _currn->_ATGPUindex_RuleAttr_1207, PTGNumb(MapLine(((_currn->_AT_pos).line))), _currn->_ATthreadRange_RuleAttr_1207, PTGIndent(_currn->_desc1->_ATIndentLevel_post), _currn->_ATPtg));

} else {
PTGOut(PTGReplace(PTGNumb(MapLine(((_currn->_AT_pos).line))), PTGIndent(_currn->_desc1->_ATIndentLevel_post), _currn->_ATPtg));
}
;

} else {
}
;
/*SPC(7325)*/
_currn->_desc1->_ATGPURegionNumber_pre=_currn->_ATGPURegionNumber_pre;
/*SPC(7269)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

if (AND(EQ(_currn->_ATthreadType_RuleAttr_1207, PARALLEL), EQ(_currn->_ATAccDoLoopDim_pre, 0))) {
message(ERROR, "This variable is not listed in !ACC$REGION for block parallelism.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(7363)*/

if (AND(EQ(_currn->_ATthreadType_RuleAttr_1207, VECTOR), EQ(_currn->_ATAccDoLoopDim_pre, 0))) {
message(ERROR, "This variable is not listed in !ACC$REGION for thread parallelism.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(7368)*/
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
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_ATRegionVars_post=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(_currn->_ATAccDoStmt_pre, _currn->_ATStmtNumber_pre))
) ? (
((EQ(_currn->_ATAccDoType_pre, PARALLEL)
) ? (SetRegionVar(_currn->_ATRegionVars_pre, DO_PARALLEL, _currn->_ATloopVar_RuleAttr_1207, NoKey, _currn->_ATAccDoLoopDim_pre, 0, 0, 0, _currn->_desc2->_ATLoopStart, (&( _currn->_AT_pos)))
) : (
((EQ(_currn->_ATAccDoType_pre, VECTOR)
) ? (SetRegionVar(_currn->_ATRegionVars_pre, DO_VECTOR, _currn->_ATloopVar_RuleAttr_1207, NoKey, _currn->_ATAccDoLoopDim_pre, 0, 0, 0, _currn->_desc2->_ATLoopStart, (&( _currn->_AT_pos)))
) : (_currn->_ATRegionVars_pre))
))

) : (_currn->_ATRegionVars_pre))
;
/*SPC(12979)*/
_currn->_ATIndentLevel_post=
((EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0)
) ? (ADD(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11213)*/
_currn->_ATTranslationType_post=_currn->_desc2->_ATTranslationType_post;
/*SPC(0)*/
_currn->_ATDoAcc_post=_currn->_desc2->_ATDoAcc_post;
/*SPC(0)*/
_currn->_ATStmtNumber_post=ADD(_currn->_desc2->_ATStmtNumber_post, 1);
/*SPC(12795)*/
_currn->_ATUpdate_post=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_ATAccDoLoopDim_post=
((AND(EQ(IDENTICAL(_currn->_desc2->_ATDoLoop), 0), GE(GetAccInfo(_currn->_desc2->_ATDoAcc_post, ACCDO, _currn->_desc2->_ATNestLevel_post, 0), TRUE))
) ? (0
) : (_currn->_desc2->_ATAccDoLoopDim_post))
;
/*SPC(12604)*/
_currn->_ATNestLevel_post=_currn->_desc2->_ATNestLevel_post;
/*SPC(0)*/
_currn->_ATAcceleratorRegion_post=_currn->_desc2->_ATAcceleratorRegion_post;
/*SPC(0)*/
_currn->_ATLastNonExecLine_post=_currn->_desc2->_ATLastNonExecLine_post;
/*SPC(0)*/
_currn->_ATDeclPowerVars_post=_currn->_desc2->_ATDeclPowerVars_post;
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
_currn->_ATDeclsOrder_post=_currn->_desc2->_ATDeclsOrder_post;
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
void _VS6rule_750(_TPPrule_750 _currn)
#else
void _VS6rule_750(_currn )
_TPPrule_750 _currn;

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
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), NE(_currn->_desc2->_ATNumArgs, 2))) {

if (EQ(GetAccInfo(_currn->_desc1->_ATDoAcc_post, ACCDO, _currn->_desc1->_ATNestLevel_post, 0), _currn->_desc1->_ATNestLevel_post)) {
message(WARNING, "ACC$DO does not support do-loop stride arguments", 0, (&( _currn->_AT_pos)));

} else {
}
;

} else {
}
;
/*SPC(7356)*/
_currn->_AT_const39=ZERO();
/*SPC(2227)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_750(_TPPrule_750 _currn)
#else
void _VS7rule_750(_currn )
_TPPrule_750 _currn;

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
void _VS1rule_751(_TPPrule_751 _currn)
#else
void _VS1rule_751(_currn )
_TPPrule_751 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2214)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_751(_TPPrule_751 _currn)
#else
void _VS2rule_751(_currn )
_TPPrule_751 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_751(_TPPrule_751 _currn)
#else
void _VS4rule_751(_currn )
_TPPrule_751 _currn;

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
/*SPC(2212)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_751(_TPPrule_751 _currn)
#else
void _VS5rule_751(_currn )
_TPPrule_751 _currn;

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
_currn->_desc1->_ATIndentLevel_pre=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (SUB(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11237)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=SUB(_currn->_ATNestLevel_pre, 1);
/*SPC(12001)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDoAcc_pre=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), TRUE))
) ? (SetAccDo(_currn->_ATDoAcc_pre, ENDDO, _currn->_ATNestLevel_pre, 0, 0, 0, 0, 0, (&( _currn->_AT_pos)))
) : (_currn->_ATDoAcc_pre))
;
/*SPC(13124)*/
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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATArraySym_post=0;
/*SPC(8604)*/
_currn->_ATArrayId_post=NoKey;
/*SPC(8600)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATcomment_RuleAttr_1208=
((GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), TRUE)
) ? (PTGAsIs("//")
) : (PTGNULL))
;
/*SPC(7585)*/
_currn->_ATthreadRange_RuleAttr_1208=
((GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO_OPT, _currn->_ATNestLevel_pre, 0), TRUE)
) ? (PTGIfThreadEnd(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGIndent(_currn->_desc1->_ATIndentLevel_post))
) : (PTGNULL))
;
/*SPC(7590)*/
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
_currn->_ATPtg=PTGEndLoop(PTGNumber(MapLine(((_currn->_AT_pos).line))), _currn->_ATcomment_RuleAttr_1208, PTGIndent(_currn->_desc1->_ATIndentLevel_post), PTGNULL, _currn->_ATthreadRange_RuleAttr_1208);
/*SPC(7596)*/
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

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(_currn->_ATPtg);

} else {
}
;
/*SPC(7607)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_751(_TPPrule_751 _currn)
#else
void _VS6rule_751(_currn )
_TPPrule_751 _currn;

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
/*SPC(2212)*/
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
void _VS7rule_751(_TPPrule_751 _currn)
#else
void _VS7rule_751(_currn )
_TPPrule_751 _currn;

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
void _VS1rule_752(_TPPrule_752 _currn)
#else
void _VS1rule_752(_currn )
_TPPrule_752 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2207)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_752(_TPPrule_752 _currn)
#else
void _VS2rule_752(_currn )
_TPPrule_752 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_752(_TPPrule_752 _currn)
#else
void _VS4rule_752(_currn )
_TPPrule_752 _currn;

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
/*SPC(2205)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_752(_TPPrule_752 _currn)
#else
void _VS5rule_752(_currn )
_TPPrule_752 _currn;

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
_currn->_desc1->_ATIndentLevel_pre=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (SUB(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11229)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=SUB(_currn->_ATNestLevel_pre, 1);
/*SPC(11998)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDoAcc_pre=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), TRUE))
) ? (SetAccDo(_currn->_ATDoAcc_pre, ENDDO, _currn->_ATNestLevel_pre, 0, 0, 0, 0, 0, (&( _currn->_AT_pos)))
) : (_currn->_ATDoAcc_pre))
;
/*SPC(13116)*/
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
_currn->_ATArraySym_post=0;
/*SPC(8604)*/
_currn->_ATArrayId_post=NoKey;
/*SPC(8600)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATcomment_RuleAttr_1209=
((GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), TRUE)
) ? (PTGAsIs("//")
) : (PTGNULL))
;
/*SPC(7558)*/
_currn->_ATthreadRange_RuleAttr_1209=
((GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO_OPT, _currn->_ATNestLevel_pre, 0), TRUE)
) ? (PTGIfThreadEnd(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGIndent(_currn->_desc1->_ATIndentLevel_post))
) : (PTGNULL))
;
/*SPC(7563)*/
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
_currn->_ATPtg=PTGEndLoop(PTGNumber(MapLine(((_currn->_AT_pos).line))), _currn->_ATcomment_RuleAttr_1209, PTGIndent(_currn->_desc1->_ATIndentLevel_post), PTGNULL, _currn->_ATthreadRange_RuleAttr_1209);
/*SPC(7569)*/
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
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

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(_currn->_ATPtg);

} else {
}
;
/*SPC(7580)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_752(_TPPrule_752 _currn)
#else
void _VS6rule_752(_currn )
_TPPrule_752 _currn;

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
/*SPC(2205)*/
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
void _VS7rule_752(_TPPrule_752 _currn)
#else
void _VS7rule_752(_currn )
_TPPrule_752 _currn;

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
void _VS1rule_753(_TPPrule_753 _currn)
#else
void _VS1rule_753(_currn )
_TPPrule_753 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2200)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_753(_TPPrule_753 _currn)
#else
void _VS2rule_753(_currn )
_TPPrule_753 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_753(_TPPrule_753 _currn)
#else
void _VS4rule_753(_currn )
_TPPrule_753 _currn;

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
/*SPC(2198)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_753(_TPPrule_753 _currn)
#else
void _VS5rule_753(_currn )
_TPPrule_753 _currn;

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
_currn->_desc1->_ATIndentLevel_pre=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (SUB(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11245)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=SUB(_currn->_ATNestLevel_pre, 1);
/*SPC(12005)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDoAcc_pre=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), TRUE))
) ? (SetAccDo(_currn->_ATDoAcc_pre, ENDDO, _currn->_ATNestLevel_pre, 0, 0, 0, 0, 0, (&( _currn->_AT_pos)))
) : (_currn->_ATDoAcc_pre))
;
/*SPC(13107)*/
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
_currn->_ATArraySym_post=0;
/*SPC(8604)*/
_currn->_ATArrayId_post=NoKey;
/*SPC(8600)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATcomment_RuleAttr_1210=
((GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), TRUE)
) ? (PTGAsIs("//")
) : (PTGNULL))
;
/*SPC(7612)*/
_currn->_ATthreadRange_RuleAttr_1210=
((GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO_OPT, _currn->_ATNestLevel_pre, 0), TRUE)
) ? (PTGIfThreadEnd(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGIndent(_currn->_desc1->_ATIndentLevel_post))
) : (PTGNULL))
;
/*SPC(7617)*/
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
_currn->_ATPtg=PTGEndLoop(PTGNumber(MapLine(((_currn->_AT_pos).line))), _currn->_ATcomment_RuleAttr_1210, PTGIndent(_currn->_desc1->_ATIndentLevel_post), PTGNULL, _currn->_ATthreadRange_RuleAttr_1210);
/*SPC(7623)*/
_currn->_ATTranslationType_post=_currn->_ATTranslationType_pre;
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

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(_currn->_ATPtg);

} else {
}
;
/*SPC(7634)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_753(_TPPrule_753 _currn)
#else
void _VS6rule_753(_currn )
_TPPrule_753 _currn;

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
/*SPC(2198)*/
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
void _VS7rule_753(_TPPrule_753 _currn)
#else
void _VS7rule_753(_currn )
_TPPrule_753 _currn;

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
void _VS1rule_754(_TPPrule_754 _currn)
#else
void _VS1rule_754(_currn )
_TPPrule_754 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2193)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_754(_TPPrule_754 _currn)
#else
void _VS2rule_754(_currn )
_TPPrule_754 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_754(_TPPrule_754 _currn)
#else
void _VS4rule_754(_currn )
_TPPrule_754 _currn;

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
/*SPC(2191)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_754(_TPPrule_754 _currn)
#else
void _VS5rule_754(_currn )
_TPPrule_754 _currn;

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
_currn->_desc1->_ATIndentLevel_pre=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (SUB(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11253)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATNestLevel_pre=SUB(_currn->_ATNestLevel_pre, 1);
/*SPC(12009)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc1->_ATDoAcc_pre=
((AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), TRUE))
) ? (SetAccDo(_currn->_ATDoAcc_pre, ENDDO, _currn->_ATNestLevel_pre, 0, 0, 0, 0, 0, (&( _currn->_AT_pos)))
) : (_currn->_ATDoAcc_pre))
;
/*SPC(13132)*/
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
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATArraySym_post=0;
/*SPC(8604)*/
_currn->_ATArrayId_post=NoKey;
/*SPC(8600)*/
_currn->_AT_cBoundsListPtr_post=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
_currn->_ATcomment_RuleAttr_1211=
((GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO, _currn->_ATNestLevel_pre, 0), TRUE)
) ? (PTGAsIs("//")
) : (PTGNULL))
;
/*SPC(7639)*/
_currn->_ATthreadRange_RuleAttr_1211=
((GE(GetAccInfo(_currn->_ATDoAcc_pre, ACCDO_OPT, _currn->_ATNestLevel_pre, 0), TRUE)
) ? (PTGIfThreadEnd(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGIndent(_currn->_desc1->_ATIndentLevel_post))
) : (PTGNULL))
;
/*SPC(7644)*/
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
_currn->_ATPtg=PTGEndLoop(PTGNumber(MapLine(((_currn->_AT_pos).line))), _currn->_ATcomment_RuleAttr_1211, PTGIndent(_currn->_desc1->_ATIndentLevel_post), PTGNULL, _currn->_ATthreadRange_RuleAttr_1211);
/*SPC(7650)*/
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

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(_currn->_ATPtg);

} else {
}
;
/*SPC(7661)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_754(_TPPrule_754 _currn)
#else
void _VS6rule_754(_currn )
_TPPrule_754 _currn;

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
/*SPC(2191)*/
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
void _VS7rule_754(_TPPrule_754 _currn)
#else
void _VS7rule_754(_currn )
_TPPrule_754 _currn;

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
void _VS1rule_755(_TPPrule_755 _currn)
#else
void _VS1rule_755(_currn )
_TPPrule_755 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2116)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10828)*/
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
void _VS2rule_755(_TPPrule_755 _currn)
#else
void _VS2rule_755(_currn )
_TPPrule_755 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_755(_TPPrule_755 _currn)
#else
void _VS4rule_755(_currn )
_TPPrule_755 _currn;

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
/*SPC(2115)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_755(_TPPrule_755 _currn)
#else
void _VS5rule_755(_currn )
_TPPrule_755 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
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
_currn->_ATRegionVars_post=_currn->_desc4->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc4->_ATIndentLevel_post;
/*SPC(0)*/
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_755(_TPPrule_755 _currn)
#else
void _VS6rule_755(_currn )
_TPPrule_755 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATDepth_pre=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_AT_const39=ZERO();
/*SPC(2115)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_755(_TPPrule_755 _currn)
#else
void _VS7rule_755(_currn )
_TPPrule_755 _currn;

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
void _VS1rule_756(_TPPrule_756 _currn)
#else
void _VS1rule_756(_currn )
_TPPrule_756 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2112)*/

if (EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)) {
message(WARNING, "Language construct not currently supported at this time.", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(10822)*/
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
void _VS2rule_756(_TPPrule_756 _currn)
#else
void _VS2rule_756(_currn )
_TPPrule_756 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_756(_TPPrule_756 _currn)
#else
void _VS4rule_756(_currn )
_TPPrule_756 _currn;

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
/*SPC(2111)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_756(_TPPrule_756 _currn)
#else
void _VS5rule_756(_currn )
_TPPrule_756 _currn;

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
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
_currn->_desc2->_ATIsArray_pre=_currn->_ATIsArray_pre;
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
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATIsArray_pre=_currn->_desc2->_ATIsArray_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
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
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATStmtNumber_pre=_currn->_desc2->_ATStmtNumber_post;
/*SPC(0)*/
_currn->_desc3->_ATUpdate_pre=_currn->_desc2->_ATUpdate_post;
/*SPC(0)*/
_currn->_desc3->_ATAccDoLoopDim_pre=_currn->_desc2->_ATAccDoLoopDim_post;
/*SPC(0)*/
_currn->_desc3->_ATNestLevel_pre=_currn->_desc2->_ATNestLevel_post;
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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
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
_currn->_ATRegionVars_post=_currn->_desc4->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc4->_ATIndentLevel_post;
/*SPC(0)*/
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
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_756(_TPPrule_756 _currn)
#else
void _VS6rule_756(_currn )
_TPPrule_756 _currn;

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
_currn->_desc2->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc2->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc2->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATDepth_pre=_currn->_desc2->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc4->_ATUpdateStmt_pre=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc4->_ATF90LoopStart_pre=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_desc4->_ATDepth_pre=_currn->_desc3->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc4->_prod])))((NODEPTR) _currn->_desc4);
_currn->_AT_const39=ZERO();
/*SPC(2111)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc4->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc4->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_756(_TPPrule_756 _currn)
#else
void _VS7rule_756(_currn )
_TPPrule_756 _currn;

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
void _VS1rule_757(_TPPrule_757 _currn)
#else
void _VS1rule_757(_currn )
_TPPrule_757 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2107)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2106)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_757(_TPPrule_757 _currn)
#else
void _VS2rule_757(_currn )
_TPPrule_757 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12071)*/
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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13516)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
_currn->_ATGPUVarsDeList_post=NULLGPUVarsList;
/*SPC(11780)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_757(_TPPrule_757 _currn)
#else
void _VS3rule_757(_currn )
_TPPrule_757 _currn;

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
void _VS4rule_757(_TPPrule_757 _currn)
#else
void _VS4rule_757(_currn )
_TPPrule_757 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), AND(NE(_currn->_ATTranslationType_pre, GPU), EQ(GetClpValue(Generate, CUDA), CUDA))))) {

if (EQ((* _IG_incl54), FALSE)) {
PTGOut(PTGEndRoutineGPU(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGNumber(MapLine(((_currn->_AT_pos).line))), SubArgsOutput((* _IG_incl20), (* _IG_incl43), _currn->_ATGPUVarsDeList_pre, SUBR_END, 0, 0, _currn->_ATGPURegionNumber_pre, (* _IG_incl21), _currn->_ATRegionVars_pre, (&( _currn->_AT_pos)))));

} else {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(((_currn->_AT_pos).line)))));
}
;

} else {

if (OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA))) {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

} else {
}
;
}
;
/*SPC(6450)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_758(_TPPrule_758 _currn)
#else
void _VS1rule_758(_currn )
_TPPrule_758 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2103)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2102)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_758(_TPPrule_758 _currn)
#else
void _VS2rule_758(_currn )
_TPPrule_758 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12071)*/
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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13516)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
_currn->_ATGPUVarsDeList_post=NULLGPUVarsList;
/*SPC(11780)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_758(_TPPrule_758 _currn)
#else
void _VS3rule_758(_currn )
_TPPrule_758 _currn;

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
void _VS4rule_758(_TPPrule_758 _currn)
#else
void _VS4rule_758(_currn )
_TPPrule_758 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), AND(NE(_currn->_ATTranslationType_pre, GPU), EQ(GetClpValue(Generate, CUDA), CUDA))))) {

if (EQ((* _IG_incl54), FALSE)) {
PTGOut(PTGEndRoutineGPU(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGNumber(MapLine(((_currn->_AT_pos).line))), SubArgsOutput((* _IG_incl20), (* _IG_incl43), _currn->_ATGPUVarsDeList_pre, SUBR_END, 0, 0, _currn->_ATGPURegionNumber_pre, (* _IG_incl21), _currn->_ATRegionVars_pre, (&( _currn->_AT_pos)))));

} else {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(((_currn->_AT_pos).line)))));
}
;

} else {

if (OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA))) {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

} else {
}
;
}
;
/*SPC(6450)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_759(_TPPrule_759 _currn)
#else
void _VS1rule_759(_currn )
_TPPrule_759 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2099)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2098)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_759(_TPPrule_759 _currn)
#else
void _VS2rule_759(_currn )
_TPPrule_759 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12071)*/
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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13516)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
_currn->_ATGPUVarsDeList_post=NULLGPUVarsList;
/*SPC(11780)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_759(_TPPrule_759 _currn)
#else
void _VS3rule_759(_currn )
_TPPrule_759 _currn;

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
void _VS4rule_759(_TPPrule_759 _currn)
#else
void _VS4rule_759(_currn )
_TPPrule_759 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), AND(NE(_currn->_ATTranslationType_pre, GPU), EQ(GetClpValue(Generate, CUDA), CUDA))))) {

if (EQ((* _IG_incl54), FALSE)) {
PTGOut(PTGEndRoutineGPU(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGNumber(MapLine(((_currn->_AT_pos).line))), SubArgsOutput((* _IG_incl20), (* _IG_incl43), _currn->_ATGPUVarsDeList_pre, SUBR_END, 0, 0, _currn->_ATGPURegionNumber_pre, (* _IG_incl21), _currn->_ATRegionVars_pre, (&( _currn->_AT_pos)))));

} else {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(((_currn->_AT_pos).line)))));
}
;

} else {

if (OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA))) {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

} else {
}
;
}
;
/*SPC(6450)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_760(_TPPrule_760 _currn)
#else
void _VS1rule_760(_currn )
_TPPrule_760 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2095)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2094)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_760(_TPPrule_760 _currn)
#else
void _VS2rule_760(_currn )
_TPPrule_760 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12071)*/
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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13516)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
_currn->_ATGPUVarsDeList_post=NULLGPUVarsList;
/*SPC(11780)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_760(_TPPrule_760 _currn)
#else
void _VS3rule_760(_currn )
_TPPrule_760 _currn;

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
void _VS4rule_760(_TPPrule_760 _currn)
#else
void _VS4rule_760(_currn )
_TPPrule_760 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), AND(NE(_currn->_ATTranslationType_pre, GPU), EQ(GetClpValue(Generate, CUDA), CUDA))))) {

if (EQ((* _IG_incl54), FALSE)) {
PTGOut(PTGEndRoutineGPU(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGNumber(MapLine(((_currn->_AT_pos).line))), SubArgsOutput((* _IG_incl20), (* _IG_incl43), _currn->_ATGPUVarsDeList_pre, SUBR_END, 0, 0, _currn->_ATGPURegionNumber_pre, (* _IG_incl21), _currn->_ATRegionVars_pre, (&( _currn->_AT_pos)))));

} else {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(((_currn->_AT_pos).line)))));
}
;

} else {

if (OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA))) {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

} else {
}
;
}
;
/*SPC(6450)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_761(_TPPrule_761 _currn)
#else
void _VS1rule_761(_currn )
_TPPrule_761 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2091)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2090)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_761(_TPPrule_761 _currn)
#else
void _VS2rule_761(_currn )
_TPPrule_761 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12071)*/
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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13516)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
_currn->_ATGPUVarsDeList_post=NULLGPUVarsList;
/*SPC(11780)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_761(_TPPrule_761 _currn)
#else
void _VS3rule_761(_currn )
_TPPrule_761 _currn;

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
void _VS4rule_761(_TPPrule_761 _currn)
#else
void _VS4rule_761(_currn )
_TPPrule_761 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(strcmp(MapFile(((_currn->_AT_pos).line)), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), AND(NE(_currn->_ATTranslationType_pre, GPU), EQ(GetClpValue(Generate, CUDA), CUDA))))) {

if (EQ((* _IG_incl54), FALSE)) {
PTGOut(PTGEndRoutineGPU(PTGNumber(MapLine(((_currn->_AT_pos).line))), PTGNumber(MapLine(((_currn->_AT_pos).line))), SubArgsOutput((* _IG_incl20), (* _IG_incl43), _currn->_ATGPUVarsDeList_pre, SUBR_END, 0, 0, _currn->_ATGPURegionNumber_pre, (* _IG_incl21), _currn->_ATRegionVars_pre, (&( _currn->_AT_pos)))));

} else {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(((_currn->_AT_pos).line)))));
}
;

} else {

if (OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA))) {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(((_currn->_AT_pos).line)))));

} else {
}
;
}
;
/*SPC(6450)*/
(*(_CALL_VS_((NODEPTR )) (VS8MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_762(_TPPrule_762 _currn)
#else
void _VS1rule_762(_currn )
_TPPrule_762 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2086)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetClpValue(Generate, CUDA), C)))) {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(6579)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2085)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_762(_TPPrule_762 _currn)
#else
void _VS2rule_762(_currn )
_TPPrule_762 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12077)*/
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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13517)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
_currn->_ATGPUVarsDeList_post=NULLGPUVarsList;
/*SPC(11783)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_762(_TPPrule_762 _currn)
#else
void _VS3rule_762(_currn )
_TPPrule_762 _currn;

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
void _VS1rule_763(_TPPrule_763 _currn)
#else
void _VS1rule_763(_currn )
_TPPrule_763 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2082)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetClpValue(Generate, CUDA), C)))) {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(6579)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2081)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_763(_TPPrule_763 _currn)
#else
void _VS2rule_763(_currn )
_TPPrule_763 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12077)*/
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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13517)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
_currn->_ATGPUVarsDeList_post=NULLGPUVarsList;
/*SPC(11783)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_763(_TPPrule_763 _currn)
#else
void _VS3rule_763(_currn )
_TPPrule_763 _currn;

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
void _VS1rule_764(_TPPrule_764 _currn)
#else
void _VS1rule_764(_currn )
_TPPrule_764 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2078)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetClpValue(Generate, CUDA), C)))) {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(6579)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2077)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_764(_TPPrule_764 _currn)
#else
void _VS2rule_764(_currn )
_TPPrule_764 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12077)*/
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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13517)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
_currn->_ATGPUVarsDeList_post=NULLGPUVarsList;
/*SPC(11783)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_764(_TPPrule_764 _currn)
#else
void _VS3rule_764(_currn )
_TPPrule_764 _currn;

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
void _VS1rule_765(_TPPrule_765 _currn)
#else
void _VS1rule_765(_currn )
_TPPrule_765 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2074)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetClpValue(Generate, CUDA), C)))) {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(6579)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2073)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_765(_TPPrule_765 _currn)
#else
void _VS2rule_765(_currn )
_TPPrule_765 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12077)*/
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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13517)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
_currn->_ATGPUVarsDeList_post=NULLGPUVarsList;
/*SPC(11783)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_765(_TPPrule_765 _currn)
#else
void _VS3rule_765(_currn )
_TPPrule_765 _currn;

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
void _VS1rule_766(_TPPrule_766 _currn)
#else
void _VS1rule_766(_currn )
_TPPrule_766 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2070)*/

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), CUDA), EQ(GetClpValue(Generate, CUDA), C)))) {
PTGOut(PTGEndRoutine(PTGNumber(MapLine(_currn->_AT_line))));

} else {
}
;
/*SPC(6579)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2069)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_766(_TPPrule_766 _currn)
#else
void _VS2rule_766(_currn )
_TPPrule_766 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12077)*/
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
_currn->_ATTranslationType_post=FORTRAN;
/*SPC(13517)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
_currn->_ATGPUVarsDeList_post=NULLGPUVarsList;
/*SPC(11783)*/
_currn->_AT_cBoundsListPtr_post=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_766(_TPPrule_766 _currn)
#else
void _VS3rule_766(_currn )
_TPPrule_766 _currn;

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
void _VS1rule_767(_TPPrule_767 _currn)
#else
void _VS1rule_767(_currn )
_TPPrule_767 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2065)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2064)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_767(_TPPrule_767 _currn)
#else
void _VS2rule_767(_currn )
_TPPrule_767 _currn;

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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_767(_TPPrule_767 _currn)
#else
void _VS3rule_767(_currn )
_TPPrule_767 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12065)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
void _VS1rule_768(_TPPrule_768 _currn)
#else
void _VS1rule_768(_currn )
_TPPrule_768 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2061)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2060)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_768(_TPPrule_768 _currn)
#else
void _VS2rule_768(_currn )
_TPPrule_768 _currn;

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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_768(_TPPrule_768 _currn)
#else
void _VS3rule_768(_currn )
_TPPrule_768 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12065)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
void _VS1rule_769(_TPPrule_769 _currn)
#else
void _VS1rule_769(_currn )
_TPPrule_769 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2057)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2056)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_769(_TPPrule_769 _currn)
#else
void _VS2rule_769(_currn )
_TPPrule_769 _currn;

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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_769(_TPPrule_769 _currn)
#else
void _VS3rule_769(_currn )
_TPPrule_769 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12065)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
void _VS1rule_770(_TPPrule_770 _currn)
#else
void _VS1rule_770(_currn )
_TPPrule_770 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2053)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2052)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_770(_TPPrule_770 _currn)
#else
void _VS2rule_770(_currn )
_TPPrule_770 _currn;

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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_770(_TPPrule_770 _currn)
#else
void _VS3rule_770(_currn )
_TPPrule_770 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12065)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
void _VS1rule_771(_TPPrule_771 _currn)
#else
void _VS1rule_771(_currn )
_TPPrule_771 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(2049)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(2048)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_771(_TPPrule_771 _currn)
#else
void _VS2rule_771(_currn )
_TPPrule_771 _currn;

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
_currn->_ATRegionVars_post=_currn->_desc1->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc1->_ATIndentLevel_post;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_771(_TPPrule_771 _currn)
#else
void _VS3rule_771(_currn )
_TPPrule_771 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();

if (AND(EQ(GetClpValue(Generate, CUDA), CUDA), GE(_currn->_ATAcceleratorRegion_pre, TRUE))) {
message(ERROR, "ACC$REGION directive was not ended in this routine. \n", 0, (&( _currn->_AT_pos)));

} else {
}
;
/*SPC(12065)*/
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
_currn->_ATAcceleratorRegion_post=_currn->_ATAcceleratorRegion_pre;
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
void _VS1rule_772(_TPPrule_772 _currn)
#else
void _VS1rule_772(_currn )
_TPPrule_772 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(1843)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(1842)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_772(_TPPrule_772 _currn)
#else
void _VS2rule_772(_currn )
_TPPrule_772 _currn;

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
_currn->_desc1->_ATIndentLevel_pre=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (SUB(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11314)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGEndifStmt(PTGNumber(MapLine(_currn->_AT_line)), PTGIndent(_currn->_desc1->_ATIndentLevel_post)));

} else {
}
;
/*SPC(7201)*/
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
void _VS3rule_772(_TPPrule_772 _currn)
#else
void _VS3rule_772(_currn )
_TPPrule_772 _currn;

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
void _VS1rule_773(_TPPrule_773 _currn)
#else
void _VS1rule_773(_currn )
_TPPrule_773 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(1839)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(1838)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_773(_TPPrule_773 _currn)
#else
void _VS2rule_773(_currn )
_TPPrule_773 _currn;

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
_currn->_desc1->_ATIndentLevel_pre=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (SUB(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11307)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGEndifStmt(PTGNumber(MapLine(_currn->_AT_line)), PTGIndent(_currn->_desc1->_ATIndentLevel_post)));

} else {
}
;
/*SPC(7190)*/
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
void _VS3rule_773(_TPPrule_773 _currn)
#else
void _VS3rule_773(_currn )
_TPPrule_773 _currn;

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
void _VS1rule_774(_TPPrule_774 _currn)
#else
void _VS1rule_774(_currn )
_TPPrule_774 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(1835)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(1833)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_774(_TPPrule_774 _currn)
#else
void _VS2rule_774(_currn )
_TPPrule_774 _currn;

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
_currn->_desc1->_ATIndentLevel_pre=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (SUB(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11300)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGEndifStmt(PTGNumber(MapLine(_currn->_AT_line)), PTGIndent(_currn->_desc1->_ATIndentLevel_post)));

} else {
}
;
/*SPC(7179)*/
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
void _VS3rule_774(_TPPrule_774 _currn)
#else
void _VS3rule_774(_currn )
_TPPrule_774 _currn;

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
void _VS1rule_775(_TPPrule_775 _currn)
#else
void _VS1rule_775(_currn )
_TPPrule_775 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(1830)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(1828)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_775(_TPPrule_775 _currn)
#else
void _VS2rule_775(_currn )
_TPPrule_775 _currn;

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
_currn->_desc1->_ATIndentLevel_pre=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (SUB(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11293)*/
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(PTGEndifStmt(PTGNumber(MapLine(_currn->_AT_line)), PTGIndent(_currn->_desc1->_ATIndentLevel_post)));

} else {
}
;
/*SPC(7168)*/
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
void _VS3rule_775(_TPPrule_775 _currn)
#else
void _VS3rule_775(_currn )
_TPPrule_775 _currn;

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
void _VS1rule_776(_TPPrule_776 _currn)
#else
void _VS1rule_776(_currn )
_TPPrule_776 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATExecutable=1;
/*SPC(1819)*/
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
void _VS2rule_776(_TPPrule_776 _currn)
#else
void _VS2rule_776(_currn )
_TPPrule_776 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATIsArray_post=FALSE;
/*SPC(8596)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_776(_TPPrule_776 _currn)
#else
void _VS3rule_776(_currn )
_TPPrule_776 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_776(_TPPrule_776 _currn)
#else
void _VS4rule_776(_currn )
_TPPrule_776 _currn;

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
_currn->_desc3->_ATIsArray_pre=_currn->_ATIsArray_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS4MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATLocalIndex_pre=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATStmtId=ZERO();
/*SPC(4817)*/
_currn->_desc3->_AT_cBoundsListPtr_pre=_currn->_desc2->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS6MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const45=IDENTICAL(_currn->_desc1->_ATLastDeclarative);
/*SPC(1817)*/
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_776(_TPPrule_776 _currn)
#else
void _VS5rule_776(_currn )
_TPPrule_776 _currn;

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
_currn->_desc1->_ATIndentLevel_pre=
((EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0)
) ? (ADD(_currn->_ATIndentLevel_pre, SPACES)
) : (_currn->_ATIndentLevel_pre))
;
/*SPC(11285)*/
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
/*SPC(5159)*/
(*(_CALL_VS_((NODEPTR )) (VS9MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
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
_currn->_desc3->_ATDeclPowerVars_pre=_currn->_ATDeclPowerVars_pre;
/*SPC(0)*/
_currn->_desc3->_ATArgCnt_pre=_currn->_desc2->_ATArgCnt_post;
/*SPC(0)*/
_currn->_desc3->_ATArraySym_pre=_currn->_desc2->_ATArraySym_post;
/*SPC(0)*/
_currn->_desc3->_ATDeclsOrder_pre=_currn->_ATDeclsOrder_pre;
/*SPC(0)*/
_currn->_desc3->_ATGPUVarsDeList_pre=_currn->_desc2->_ATGPUVarsDeList_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS7MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_ATStmtUnitId=NoKey;
/*SPC(9105)*/
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
(*(_CALL_VS_((NODEPTR )) (VS10MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
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
_currn->_ATPtg=PTGIfStmtLabel(PTGNumber(MapLine(_currn->_AT_line)), PTGIndent(_currn->_ATIndentLevel_pre), PTGNULL, _currn->_desc1->_ATPtg, _currn->_desc3->_ATPtg);
/*SPC(7134)*/
_currn->_ATRegionVars_post=_currn->_desc3->_ATRegionVars_post;
/*SPC(0)*/
_currn->_ATIndentLevel_post=_currn->_desc3->_ATIndentLevel_post;
/*SPC(0)*/
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
_currn->_ATLastNonExecLine_post=_currn->_desc3->_ATLastNonExecLine_post;
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

if (AND(EQ(strcmp(MapFile(_currn->_AT_line), StringTable(GetClpValue(FileName, 0))), 0), OR(EQ(GetClpValue(Generate, CUDA), C), EQ(GetClpValue(Generate, CUDA), CUDA)))) {
PTGOut(_currn->_ATPtg);

} else {
}
;
/*SPC(7132)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_776(_TPPrule_776 _currn)
#else
void _VS6rule_776(_currn )
_TPPrule_776 _currn;

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
_currn->_desc3->_ATUpdateStmt_pre=_currn->_desc2->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_desc3->_ATF90LoopStart_pre=_currn->_desc1->_ATF90LoopStart_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS11MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_desc3->_ATDepth_pre=_currn->_desc1->_ATDepth_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS12MAP[_currn->_desc3->_prod])))((NODEPTR) _currn->_desc3);
_currn->_AT_const39=ZERO();
/*SPC(1817)*/
_currn->_ATThreadStmt_post=_currn->_ATThreadStmt_pre;
/*SPC(0)*/
_currn->_ATUpdateStmt_post=_currn->_desc3->_ATUpdateStmt_post;
/*SPC(0)*/
_currn->_ATF90LoopStart_post=_currn->_desc3->_ATF90LoopStart_post;
/*SPC(0)*/
_currn->_ATReturnStmt=FALSE;
/*SPC(6415)*/
_IG_incl60=_IL_incl60;
_IG_incl34=_IL_incl34;

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_776(_TPPrule_776 _currn)
#else
void _VS7rule_776(_currn )
_TPPrule_776 _currn;

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
void _VS1rule_777(_TPPrule_777 _currn)
#else
void _VS1rule_777(_currn )
_TPPrule_777 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATOrder_pre=_currn->_ATOrder_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATOrder_post=_currn->_desc1->_ATOrder_post;
/*SPC(0)*/
_currn->_ATDims=ADD(_currn->_desc1->_ATDims, 1);
/*SPC(1728)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_777(_TPPrule_777 _currn)
#else
void _VS2rule_777(_currn )
_TPPrule_777 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_777(_TPPrule_777 _currn)
#else
void _VS3rule_777(_currn )
_TPPrule_777 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_777(_TPPrule_777 _currn)
#else
void _VS4rule_777(_currn )
_TPPrule_777 _currn;

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
void _VS5rule_777(_TPPrule_777 _currn)
#else
void _VS5rule_777(_currn )
_TPPrule_777 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS5MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_desc2->_ATLocalIndex_pre=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_desc2->_AT_cBoundsListPtr_pre=_currn->_desc1->_AT_cBoundsListPtr_post;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);
_currn->_ATLocalIndex_post=_currn->_desc2->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATBoundsElem=PkgBounds(_currn->_desc2->_ATLocalIndex_post, (* _IG_incl48), 0, 0, NoKey, NoKey);
/*SPC(3758)*/
_currn->_ATBoundsTakeIt=1;
/*SPC(3757)*/
_currn->_AT_cBoundsListPtr_post=
((_currn->_ATBoundsTakeIt
) ? (RefEndConsBoundsList(_currn->_desc2->_AT_cBoundsListPtr_post, _currn->_ATBoundsElem)
) : (_currn->_desc2->_AT_cBoundsListPtr_post))
;
/*SPC(377)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_777(_TPPrule_777 _currn)
#else
void _VS6rule_777(_currn )
_TPPrule_777 _currn;

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
void _VS7rule_777(_TPPrule_777 _currn)
#else
void _VS7rule_777(_currn )
_TPPrule_777 _currn;

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
_currn->_ATSizeValue=0;
/*SPC(3946)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_778(_TPPrule_778 _currn)
#else
void _VS1rule_778(_currn )
_TPPrule_778 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATOrder_post=_currn->_ATOrder_pre;
/*SPC(0)*/
_currn->_ATDims=1;
/*SPC(1724)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_778(_TPPrule_778 _currn)
#else
void _VS4rule_778(_currn )
_TPPrule_778 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_ATIsArray_post=_currn->_ATIsArray_pre;
/*SPC(0)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS5rule_778(_TPPrule_778 _currn)
#else
void _VS5rule_778(_currn )
_TPPrule_778 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
_currn->_desc1->_ATLocalIndex_pre=_currn->_ATLocalIndex_pre;
/*SPC(0)*/
_currn->_desc1->_AT_cBoundsListPtr_pre=_currn->_AT_cBoundsListPtr_pre;
/*SPC(0)*/
(*(_CALL_VS_((NODEPTR )) (VS1MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
_currn->_ATLocalIndex_post=_currn->_desc1->_ATLocalIndex_post;
/*SPC(0)*/
_currn->_ATBoundsElem=PkgBounds(_currn->_desc1->_ATLocalIndex_post, (* _IG_incl48), 0, 0, NoKey, NoKey);
/*SPC(3758)*/
_currn->_ATBoundsTakeIt=1;
/*SPC(3757)*/
_currn->_AT_cBoundsListPtr_post=
((_currn->_ATBoundsTakeIt
) ? (RefEndConsBoundsList(_currn->_desc1->_AT_cBoundsListPtr_post, _currn->_ATBoundsElem)
) : (_currn->_desc1->_AT_cBoundsListPtr_post))
;
/*SPC(377)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_778(_TPPrule_778 _currn)
#else
void _VS6rule_778(_currn )
_TPPrule_778 _currn;

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
void _VS7rule_778(_TPPrule_778 _currn)
#else
void _VS7rule_778(_currn )
_TPPrule_778 _currn;

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
_currn->_ATSizeValue=0;
/*SPC(3946)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS1rule_779(_TPPrule_779 _currn)
#else
void _VS1rule_779(_currn )
_TPPrule_779 _currn;

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
_currn->_ATDims=ADD(_currn->_desc1->_ATDims, 1);
/*SPC(1720)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS2rule_779(_TPPrule_779 _currn)
#else
void _VS2rule_779(_currn )
_TPPrule_779 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS2MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS3rule_779(_TPPrule_779 _currn)
#else
void _VS3rule_779(_currn )
_TPPrule_779 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc1->_prod])))((NODEPTR) _currn->_desc1);
(*(_CALL_VS_((NODEPTR )) (VS3MAP[_currn->_desc2->_prod])))((NODEPTR) _currn->_desc2);

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS4rule_779(_TPPrule_779 _currn)
#else
void _VS4rule_779(_currn )
_TPPrule_779 _currn;

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
void _VS5rule_779(_TPPrule_779 _currn)
#else
void _VS5rule_779(_currn )
_TPPrule_779 _currn;

#endif
{

_VisitVarDecl()
_VisitEntry();
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
_currn->_ATBoundsElem=PkgBounds(_currn->_desc2->_ATLocalIndex_post, (* _IG_incl48), 0, 0, NoKey, NoKey);
/*SPC(3758)*/
_currn->_ATBoundsTakeIt=1;
/*SPC(3757)*/
_currn->_AT_cBoundsListPtr_post=
((_currn->_ATBoundsTakeIt
) ? (RefEndConsBoundsList(_currn->_desc2->_AT_cBoundsListPtr_post, _currn->_ATBoundsElem)
) : (_currn->_desc2->_AT_cBoundsListPtr_post))
;
/*SPC(377)*/

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS6rule_779(_TPPrule_779 _currn)
#else
void _VS6rule_779(_currn )
_TPPrule_779 _currn;

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

_VisitExit();
}

#if defined(__STDC__) || defined(__cplusplus)
void _VS7rule_779(_TPPrule_779 _currn)
#else
void _VS7rule_779(_currn )
_TPPrule_779 _currn;

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
_currn->_ATSizeValue=0;
/*SPC(3946)*/

_VisitExit();
}


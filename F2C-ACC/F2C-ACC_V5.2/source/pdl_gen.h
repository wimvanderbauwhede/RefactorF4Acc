#ifndef PDL_GEN_H
#define PDL_GEN_H

#include "deftbl.h"

#ifdef ELI_ARG
#undef ELI_ARG
#endif

#if defined(__STDC__) || defined(__cplusplus)
#define ELI_ARG(proto)    proto
#else
#define ELI_ARG(proto)    ()
#endif

#include "CoordCmp.h"
#include "envmod.h"
#include "IntSet.h"
#include "err.h"
#include "f77expr.h"
#include "strmath.h"
#include "termcode.h"
#include "BoundsList.h"
#include "ptg_gen.h"

#define TYPE int
extern TYPE Getint ELI_ARG((int _Property, DefTableKey key, TYPE deflt));
extern void Setint ELI_ARG((int _Property, DefTableKey key, TYPE _add, TYPE _replace));
extern void Resetint ELI_ARG((int _Property, DefTableKey key, TYPE _val));
#undef TYPE
#define TYPE Environment
extern TYPE GetEnvironment ELI_ARG((int _Property, DefTableKey key, TYPE deflt));
extern void SetEnvironment ELI_ARG((int _Property, DefTableKey key, TYPE _add, TYPE _replace));
extern void ResetEnvironment ELI_ARG((int _Property, DefTableKey key, TYPE _val));
#undef TYPE
#define TYPE IntSet
extern TYPE GetIntSet ELI_ARG((int _Property, DefTableKey key, TYPE deflt));
extern void SetIntSet ELI_ARG((int _Property, DefTableKey key, TYPE _add, TYPE _replace));
extern void ResetIntSet ELI_ARG((int _Property, DefTableKey key, TYPE _val));
extern TYPE InsertIntSet ELI_ARG((int _Property, DefTableKey key, int val));
extern TYPE UnionIntSet ELI_ARG((int _Property, DefTableKey key, TYPE val));
extern TYPE IntersectIntSet ELI_ARG((int _Property, DefTableKey key, TYPE val));
#undef TYPE
#define TYPE DefTableKey
extern TYPE GetDefTableKey ELI_ARG((int _Property, DefTableKey key, TYPE deflt));
extern void SetDefTableKey ELI_ARG((int _Property, DefTableKey key, TYPE _add, TYPE _replace));
extern void ResetDefTableKey ELI_ARG((int _Property, DefTableKey key, TYPE _val));
extern void IsDefTableKey ELI_ARG((int _Property, DefTableKey key, TYPE _which, TYPE _error));
extern void GuaranteeDefTableKey ELI_ARG((int _Property, DefTableKey key, TYPE val));
#undef TYPE
#define TYPE BoundsList
extern TYPE GetBoundsList ELI_ARG((int _Property, DefTableKey key, TYPE deflt));
extern void SetBoundsList ELI_ARG((int _Property, DefTableKey key, TYPE _add, TYPE _replace));
extern void ResetBoundsList ELI_ARG((int _Property, DefTableKey key, TYPE _val));
#undef TYPE
#define TYPE PTGNode
extern TYPE GetPTGNode ELI_ARG((int _Property, DefTableKey key, TYPE deflt));
extern void SetPTGNode ELI_ARG((int _Property, DefTableKey key, TYPE _add, TYPE _replace));
extern void ResetPTGNode ELI_ARG((int _Property, DefTableKey key, TYPE _val));
#undef TYPE

#define SetClpValue(key, _add, _replace)   \
		Setint(1, (key), (_add), (_replace))
#define ResetClpValue(key, _val)   \
		Resetint(1, (key), (_val))
#define GetClpValue(key, deflt)   \
		Getint(1, (key), (deflt))
#define SetUnitScope(key, _add, _replace)   \
		SetEnvironment(2, (key), (_add), (_replace))
#define ResetUnitScope(key, _val)   \
		ResetEnvironment(2, (key), (_val))
#define GetUnitScope(key, deflt)   \
		GetEnvironment(2, (key), (deflt))
#define SetUnique(key, _add, _replace)   \
		Setint(3, (key), (_add), (_replace))
#define ResetUnique(key, _val)   \
		Resetint(3, (key), (_val))
#define GetUnique(key, deflt)   \
		Getint(3, (key), (deflt))
#define SetUnitCnt(key, _add, _replace)   \
		Setint(4, (key), (_add), (_replace))
#define ResetUnitCnt(key, _val)   \
		Resetint(4, (key), (_val))
#define GetUnitCnt(key, deflt)   \
		Getint(4, (key), (deflt))
#define IntersectKindSet(key, val)   \
		IntersectIntSet(5, (key), (val))
#define UnionKindSet(key, val)   \
		UnionIntSet(5, (key), (val))
#define InsertKindSet(key, val)   \
		InsertIntSet(5, (key), (val))
#define SetKindSet(key, _add, _replace)   \
		SetIntSet(5, (key), (_add), (_replace))
#define ResetKindSet(key, _val)   \
		ResetIntSet(5, (key), (_val))
#define GetKindSet(key, deflt)   \
		GetIntSet(5, (key), (deflt))
#define SetValue(key, _add, _replace)   \
		Setint(6, (key), (_add), (_replace))
#define ResetValue(key, _val)   \
		Resetint(6, (key), (_val))
#define GetValue(key, deflt)   \
		Getint(6, (key), (deflt))
#define SetIntrinsic(key, _add, _replace)   \
		Setint(7, (key), (_add), (_replace))
#define ResetIntrinsic(key, _val)   \
		Resetint(7, (key), (_val))
#define GetIntrinsic(key, deflt)   \
		Getint(7, (key), (deflt))
#define GuaranteeType(key, val)   \
		GuaranteeDefTableKey(8, (key), (val))
#define IsType(key, _which, _error)   \
		IsDefTableKey(8, (key), (_which), (_error))
#define SetType(key, _add, _replace)   \
		SetDefTableKey(8, (key), (_add), (_replace))
#define ResetType(key, _val)   \
		ResetDefTableKey(8, (key), (_val))
#define GetType(key, deflt)   \
		GetDefTableKey(8, (key), (deflt))
#define SetNumberOfDims(key, _add, _replace)   \
		Setint(9, (key), (_add), (_replace))
#define ResetNumberOfDims(key, _val)   \
		Resetint(9, (key), (_val))
#define GetNumberOfDims(key, deflt)   \
		Getint(9, (key), (deflt))
#define SetarrayApp(key, _add, _replace)   \
		Setint(10, (key), (_add), (_replace))
#define ResetarrayApp(key, _val)   \
		Resetint(10, (key), (_val))
#define GetarrayApp(key, deflt)   \
		Getint(10, (key), (deflt))
#define SettypeApp(key, _add, _replace)   \
		Setint(11, (key), (_add), (_replace))
#define ResettypeApp(key, _val)   \
		Resetint(11, (key), (_val))
#define GettypeApp(key, deflt)   \
		Getint(11, (key), (deflt))
#define SetconstantApp(key, _add, _replace)   \
		Setint(12, (key), (_add), (_replace))
#define ResetconstantApp(key, _val)   \
		Resetint(12, (key), (_val))
#define GetconstantApp(key, deflt)   \
		Getint(12, (key), (deflt))
#define SetexternalApp(key, _add, _replace)   \
		Setint(13, (key), (_add), (_replace))
#define ResetexternalApp(key, _val)   \
		Resetint(13, (key), (_val))
#define GetexternalApp(key, deflt)   \
		Getint(13, (key), (deflt))
#define SetintrinsicApp(key, _add, _replace)   \
		Setint(14, (key), (_add), (_replace))
#define ResetintrinsicApp(key, _val)   \
		Resetint(14, (key), (_val))
#define GetintrinsicApp(key, deflt)   \
		Getint(14, (key), (deflt))
#define SetArraySizeList(key, _add, _replace)   \
		SetBoundsList(15, (key), (_add), (_replace))
#define ResetArraySizeList(key, _val)   \
		ResetBoundsList(15, (key), (_val))
#define GetArraySizeList(key, deflt)   \
		GetBoundsList(15, (key), (deflt))
#define SetCPUDecl(key, _add, _replace)   \
		Setint(16, (key), (_add), (_replace))
#define ResetCPUDecl(key, _val)   \
		Resetint(16, (key), (_val))
#define GetCPUDecl(key, deflt)   \
		Getint(16, (key), (deflt))
#define SetGPUDecl(key, _add, _replace)   \
		Setint(17, (key), (_add), (_replace))
#define ResetGPUDecl(key, _val)   \
		Resetint(17, (key), (_val))
#define GetGPUDecl(key, deflt)   \
		Getint(17, (key), (deflt))
#define SetVariableConstant(key, _add, _replace)   \
		Setint(18, (key), (_add), (_replace))
#define ResetVariableConstant(key, _val)   \
		Resetint(18, (key), (_val))
#define GetVariableConstant(key, deflt)   \
		Getint(18, (key), (deflt))
#define SetVariableConstantValue(key, _add, _replace)   \
		SetPTGNode(19, (key), (_add), (_replace))
#define ResetVariableConstantValue(key, _val)   \
		ResetPTGNode(19, (key), (_val))
#define GetVariableConstantValue(key, deflt)   \
		GetPTGNode(19, (key), (deflt))
#define SetConstantDeclared(key, _add, _replace)   \
		Setint(20, (key), (_add), (_replace))
#define ResetConstantDeclared(key, _val)   \
		Resetint(20, (key), (_val))
#define GetConstantDeclared(key, deflt)   \
		Getint(20, (key), (deflt))
#define SetTypeLength(key, _add, _replace)   \
		Setint(21, (key), (_add), (_replace))
#define ResetTypeLength(key, _val)   \
		Resetint(21, (key), (_val))
#define GetTypeLength(key, deflt)   \
		Getint(21, (key), (deflt))
#define SetVariableDefined(key, _add, _replace)   \
		Setint(22, (key), (_add), (_replace))
#define ResetVariableDefined(key, _val)   \
		Resetint(22, (key), (_val))
#define GetVariableDefined(key, deflt)   \
		Getint(22, (key), (deflt))
#define SetVariableCPU(key, _add, _replace)   \
		Setint(23, (key), (_add), (_replace))
#define ResetVariableCPU(key, _val)   \
		Resetint(23, (key), (_val))
#define GetVariableCPU(key, deflt)   \
		Getint(23, (key), (deflt))
#define SetVariableGPU(key, _add, _replace)   \
		Setint(24, (key), (_add), (_replace))
#define ResetVariableGPU(key, _val)   \
		Resetint(24, (key), (_val))
#define GetVariableGPU(key, deflt)   \
		Getint(24, (key), (deflt))
#define SetIntent(key, _add, _replace)   \
		Setint(25, (key), (_add), (_replace))
#define ResetIntent(key, _val)   \
		Resetint(25, (key), (_val))
#define GetIntent(key, deflt)   \
		Getint(25, (key), (deflt))
#define SetRoutineDefined(key, _add, _replace)   \
		Setint(26, (key), (_add), (_replace))
#define ResetRoutineDefined(key, _val)   \
		Resetint(26, (key), (_val))
#define GetRoutineDefined(key, deflt)   \
		Getint(26, (key), (deflt))
#define SetVariableAllocated(key, _add, _replace)   \
		Setint(27, (key), (_add), (_replace))
#define ResetVariableAllocated(key, _val)   \
		Resetint(27, (key), (_val))
#define GetVariableAllocated(key, deflt)   \
		Getint(27, (key), (deflt))
#define SetVariableRoutine(key, _add, _replace)   \
		Setint(28, (key), (_add), (_replace))
#define ResetVariableRoutine(key, _val)   \
		Resetint(28, (key), (_val))
#define GetVariableRoutine(key, deflt)   \
		Getint(28, (key), (deflt))
#define SetVariableStmt(key, _add, _replace)   \
		Setint(29, (key), (_add), (_replace))
#define ResetVariableStmt(key, _val)   \
		Resetint(29, (key), (_val))
#define GetVariableStmt(key, deflt)   \
		Getint(29, (key), (deflt))
#define SetVariableScopeGPU(key, _add, _replace)   \
		Setint(30, (key), (_add), (_replace))
#define ResetVariableScopeGPU(key, _val)   \
		Resetint(30, (key), (_val))
#define GetVariableScopeGPU(key, deflt)   \
		Getint(30, (key), (deflt))
#define SetVariableIntentGPU(key, _add, _replace)   \
		Setint(31, (key), (_add), (_replace))
#define ResetVariableIntentGPU(key, _val)   \
		Resetint(31, (key), (_val))
#define GetVariableIntentGPU(key, deflt)   \
		Getint(31, (key), (deflt))
#define SetDoLabelCount(key, _add, _replace)   \
		Setint(32, (key), (_add), (_replace))
#define ResetDoLabelCount(key, _val)   \
		Resetint(32, (key), (_val))
#define GetDoLabelCount(key, deflt)   \
		Getint(32, (key), (deflt))
#define SetThreadDim(key, _add, _replace)   \
		Setint(33, (key), (_add), (_replace))
#define ResetThreadDim(key, _val)   \
		Resetint(33, (key), (_val))
#define GetThreadDim(key, deflt)   \
		Getint(33, (key), (deflt))
#define SetRegionNumber(key, _add, _replace)   \
		Setint(34, (key), (_add), (_replace))
#define ResetRegionNumber(key, _val)   \
		Resetint(34, (key), (_val))
#define GetRegionNumber(key, deflt)   \
		Getint(34, (key), (deflt))
#define SetComputedSize(key, _add, _replace)   \
		SetPTGNode(35, (key), (_add), (_replace))
#define ResetComputedSize(key, _val)   \
		ResetPTGNode(35, (key), (_val))
#define GetComputedSize(key, deflt)   \
		GetPTGNode(35, (key), (deflt))
#define SetVariableDeclaredGPU(key, _add, _replace)   \
		Setint(36, (key), (_add), (_replace))
#define ResetVariableDeclaredGPU(key, _val)   \
		Resetint(36, (key), (_val))
#define GetVariableDeclaredGPU(key, deflt)   \
		Getint(36, (key), (deflt))
#define SetVariableSharedGPU(key, _add, _replace)   \
		Setint(37, (key), (_add), (_replace))
#define ResetVariableSharedGPU(key, _val)   \
		Resetint(37, (key), (_val))
#define GetVariableSharedGPU(key, deflt)   \
		Getint(37, (key), (deflt))
#define SetVariablePromotedGPU(key, _add, _replace)   \
		Setint(38, (key), (_add), (_replace))
#define ResetVariablePromotedGPU(key, _val)   \
		Resetint(38, (key), (_val))
#define GetVariablePromotedGPU(key, deflt)   \
		Getint(38, (key), (deflt))
#define SetVariableListedGPU(key, _add, _replace)   \
		Setint(39, (key), (_add), (_replace))
#define ResetVariableListedGPU(key, _val)   \
		Resetint(39, (key), (_val))
#define GetVariableListedGPU(key, deflt)   \
		Getint(39, (key), (deflt))
#define SetSharedDim1(key, _add, _replace)   \
		Setint(40, (key), (_add), (_replace))
#define ResetSharedDim1(key, _val)   \
		Resetint(40, (key), (_val))
#define GetSharedDim1(key, deflt)   \
		Getint(40, (key), (deflt))
#define SetSharedDim2(key, _add, _replace)   \
		Setint(41, (key), (_add), (_replace))
#define ResetSharedDim2(key, _val)   \
		Resetint(41, (key), (_val))
#define GetSharedDim2(key, deflt)   \
		Getint(41, (key), (deflt))

extern struct PropList PDLk[];

#define ErrorType (&PDLk[0])
#define IntegerType (&PDLk[1])
#define RealType (&PDLk[2])
#define DoublePrecisionType (&PDLk[3])
#define ComplexType (&PDLk[4])
#define LogicalType (&PDLk[5])
#define CharacterType (&PDLk[6])
#define DerivedType (&PDLk[7])
#define INTKey (&PDLk[8])
#define IFIXKey (&PDLk[9])
#define IDINTKey (&PDLk[10])
#define REALKey (&PDLk[11])
#define FLOATKey (&PDLk[12])
#define SNGLKey (&PDLk[13])
#define DBLEKey (&PDLk[14])
#define CMPLXKey (&PDLk[15])
#define ICHARKey (&PDLk[16])
#define CHARKey (&PDLk[17])
#define AINTKey (&PDLk[18])
#define DINTKey (&PDLk[19])
#define ANINTKey (&PDLk[20])
#define DNINTKey (&PDLk[21])
#define NINTKey (&PDLk[22])
#define IDNINTKey (&PDLk[23])
#define ABSKey (&PDLk[24])
#define IABSKey (&PDLk[25])
#define DABSKey (&PDLk[26])
#define CABSKey (&PDLk[27])
#define MODKey (&PDLk[28])
#define AMODKey (&PDLk[29])
#define DMODKey (&PDLk[30])
#define SIGNKey (&PDLk[31])
#define ISIGNKey (&PDLk[32])
#define DSIGNKey (&PDLk[33])
#define DIMKey (&PDLk[34])
#define IDIMKey (&PDLk[35])
#define DDIMKey (&PDLk[36])
#define DPRODKey (&PDLk[37])
#define MAXKey (&PDLk[38])
#define MAX0Key (&PDLk[39])
#define AMAX1Key (&PDLk[40])
#define DMAX1Key (&PDLk[41])
#define AMAX0Key (&PDLk[42])
#define MAX1Key (&PDLk[43])
#define MINKey (&PDLk[44])
#define MIN0Key (&PDLk[45])
#define AMIN1Key (&PDLk[46])
#define DMIN1Key (&PDLk[47])
#define AMIN0Key (&PDLk[48])
#define MIN1Key (&PDLk[49])
#define LENKey (&PDLk[50])
#define INDEXKey (&PDLk[51])
#define AIMAGKey (&PDLk[52])
#define CONJGKey (&PDLk[53])
#define SQRTKey (&PDLk[54])
#define DSQRTKey (&PDLk[55])
#define CSQRTKey (&PDLk[56])
#define EXPKey (&PDLk[57])
#define DEXPKey (&PDLk[58])
#define CEXPKey (&PDLk[59])
#define LOGKey (&PDLk[60])
#define ALOGKey (&PDLk[61])
#define DLOGKey (&PDLk[62])
#define CLOGKey (&PDLk[63])
#define LOG10Key (&PDLk[64])
#define ALOG10Key (&PDLk[65])
#define DLOG10Key (&PDLk[66])
#define SINKey (&PDLk[67])
#define DSINKey (&PDLk[68])
#define CSINKey (&PDLk[69])
#define COSKey (&PDLk[70])
#define DCOSKey (&PDLk[71])
#define CCOSKey (&PDLk[72])
#define TANKey (&PDLk[73])
#define DTANKey (&PDLk[74])
#define ASINKey (&PDLk[75])
#define DASINKey (&PDLk[76])
#define ACOSKey (&PDLk[77])
#define DACOSKey (&PDLk[78])
#define ATANKey (&PDLk[79])
#define DATANKey (&PDLk[80])
#define ATAN2Key (&PDLk[81])
#define DATAN2Key (&PDLk[82])
#define SINHKey (&PDLk[83])
#define DSINHKey (&PDLk[84])
#define COSHKey (&PDLk[85])
#define DCOSHKey (&PDLk[86])
#define TANHKey (&PDLk[87])
#define DTANHKey (&PDLk[88])
#define LGEKey (&PDLk[89])
#define LGTKey (&PDLk[90])
#define LLEKey (&PDLk[91])
#define LLTKey (&PDLk[92])

extern DefTableKey CloneKey ELI_ARG((DefTableKey key));
/* Clone a definition
 *    On entry-
 *       key=a valid definition
 *    On exit-
 *       CloneKey=Unique definition with the same properties
 *                and property values as key
 ***/

#ifdef MONITOR
extern void pdl_mon_properties ELI_ARG((DefTableKey));
#endif

#endif

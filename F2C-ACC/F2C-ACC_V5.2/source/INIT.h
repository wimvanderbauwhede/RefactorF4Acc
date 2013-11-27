#ifndef INIT_H1
#define INIT_H1

  obstack_init(&SrcFileStack);
#endif

#ifndef INIT_H2
#define INIT_H2

if (UnitRootEnv == NoEnv) UnitRootEnv = NewEnv ();
#endif

#ifndef INIT_H3
#define INIT_H3

if (RootEnv == NoEnv) RootEnv = NewEnv ();
#endif

#ifndef INIT_H4
#define INIT_H4


#include "PreDefMod.h"
#define PreDef(sym,key,type) \
        PreDefine(sym, xIdent, &_sym, RootEnv, key, &bind);
{
int _sym;
Binding bind;

PreDef("int",    INTKey,    IntegerType)
PreDef("ifix",   IFIXKey,   IntegerType)
PreDef("idint",  IDINTKey,  IntegerType)
PreDef("real",   REALKey,   RealType)
PreDef("float",  FLOATKey,  RealType)
PreDef("sngl",   SNGLKey,   RealType)
PreDef("dble",   DBLEKey,   DoublePrecisionType)
PreDef("cmplx",  CMPLXKey,  ComplexType)
PreDef("ichar",  ICHARKey,  IntegerType)
PreDef("char",   CHARKey,   CharacterType)
PreDef("aint",   AINTKey,   RealType)
PreDef("dint",   DINTKey,   DoublePrecisionType)
PreDef("anint",  ANINTKey,  RealType)
PreDef("dnint",  DNINTKey,  DoublePrecisionType)
PreDef("nint",   NINTKey,   IntegerType)
PreDef("idnint", IDNINTKey, IntegerType)
PreDef("abs",    ABSKey,    RealType)
PreDef("iabs",   IABSKey,   IntegerType)
PreDef("dabs",   DABSKey,   DoublePrecisionType)
PreDef("cabs",   CABSKey,   RealType)
PreDef("mod",    MODKey,    IntegerType)
PreDef("amod",   AMODKey,   RealType)
PreDef("dmod",   DMODKey,   DoublePrecisionType)
PreDef("sign",   SIGNKey,   RealType)
PreDef("isign",  ISIGNKey,  IntegerType)
PreDef("dsign",  DSIGNKey,  DoublePrecisionType)
PreDef("dim",    DIMKey,    RealType)
PreDef("idim",   IDIMKey,   IntegerType)
PreDef("ddim",   DDIMKey,   DoublePrecisionType)
PreDef("dprod",  DPRODKey,  DoublePrecisionType)
PreDef("max",    MAXKey,    IntegerType)
PreDef("max0",   MAX0Key,   IntegerType)
PreDef("amax1",  AMAX1Key,  RealType)
PreDef("dmax1",  DMAX1Key,  DoublePrecisionType)
PreDef("amax0",  AMAX0Key,  RealType)
PreDef("max1",   MAX1Key,   IntegerType)
PreDef("min",    MINKey,    IntegerType)
PreDef("min0",   MIN0Key,   IntegerType)
PreDef("amin1",  AMIN1Key,  RealType)
PreDef("dmin1",  DMIN1Key,  DoublePrecisionType)
PreDef("amin0",  AMIN0Key,  RealType)
PreDef("min1",   MIN1Key,   IntegerType)
PreDef("len",    LENKey,    IntegerType)
PreDef("index",  INDEXKey,  IntegerType)
PreDef("aimag",  AIMAGKey,  RealType)
PreDef("conjg",  CONJGKey,  ComplexType)
PreDef("sqrt",   SQRTKey,   RealType)
PreDef("dsqrt",  DSQRTKey,  DoublePrecisionType)
PreDef("csqrt",  CSQRTKey,  ComplexType)
PreDef("exp",    EXPKey,    RealType)
PreDef("dexp",   DEXPKey,   DoublePrecisionType)
PreDef("cexp",   CEXPKey,   ComplexType)
PreDef("log",    LOGKey,    RealType)
PreDef("alog",   ALOGKey,   RealType)
PreDef("dlog",   DLOGKey,   DoublePrecisionType)
PreDef("clog",   CLOGKey,   ComplexType)
PreDef("log10",  LOG10Key,  RealType)
PreDef("alog10", ALOG10Key, RealType)
PreDef("dlog10", DLOG10Key, DoublePrecisionType)
PreDef("sin",    SINKey,    RealType)
PreDef("dsin",   DSINKey,   DoublePrecisionType)
PreDef("csin",   CSINKey,   ComplexType)
PreDef("cos",    COSKey,    RealType)
PreDef("dcos",   DCOSKey,   DoublePrecisionType)
PreDef("ccos",   CCOSKey,   ComplexType)
PreDef("tan",    TANKey,    RealType)
PreDef("dtan",   DTANKey,   DoublePrecisionType)
PreDef("asin",   ASINKey,   RealType)
PreDef("dasin",  DASINKey,  DoublePrecisionType)
PreDef("acos",   ACOSKey,   RealType)
PreDef("dacos",  DACOSKey,  DoublePrecisionType)
PreDef("atan",   ATANKey,   RealType)
PreDef("datan",  DATANKey,  DoublePrecisionType)
PreDef("atan2",  ATAN2Key,  RealType)
PreDef("datan2", DATAN2Key, DoublePrecisionType)
PreDef("sinh",   SINHKey,   RealType)
PreDef("dsinh",  DSINHKey,  DoublePrecisionType)
PreDef("cosh",   COSHKey,   RealType)
PreDef("dcosh",  DCOSHKey,  DoublePrecisionType)
PreDef("tanh",   TANHKey,   RealType)
PreDef("dtanh",  DTANHKey,  DoublePrecisionType)
PreDef("lge",    LGEKey,    LogicalType)
PreDef("lgt",    LGTKey,    LogicalType)
PreDef("lle",    LLEKey,    LogicalType)
PreDef("llt",    LLTKey,    LogicalType)

}
#undef PreDef

#endif

#ifndef INIT_H5
#define INIT_H5
/* $Id: liga.init,v 4.3 1997/09/15 14:46:48 cogito Exp $ */
/* (C) Copyright 1997 University of Paderborn */

/* This file is part of the Eli Module Library.

The Eli Module Library is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public License as
published by the Free Software Foundation; either version 2 of the
License, or (at your option) any later version.

The Eli Module Library is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.

You should have received a copy of the GNU Library General Public
License along with the Eli Module Library; see the file COPYING.LIB.
If not, write to the Free Software Foundation, Inc., 59 Temple Place -
Suite 330, Boston, MA 02111-1307, USA.  */

/* As a special exception, when this file is copied by Eli into the
   directory resulting from a :source derivation, you may use that
   created file as a part of that directory without restriction. */

InitTree();

#endif


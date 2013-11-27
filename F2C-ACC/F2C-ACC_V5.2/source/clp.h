#ifndef CLP_H

#define CLP_H
#include "clplib.h"
#include "pdl_gen.h"
#include "DefTableKeyList.h"

extern DefTableKey CLP_InputFile;
#ifdef PROTO_OK
extern void clp_usage (char *);
#else
extern void clp_usage ();
#endif

extern int FixedFormat;
extern DefTableKey FileName;
extern DefTableKey Analysis;
extern DefTableKey Constants;
extern DefTableKey DeviceInit;
extern DefTableKey Exact;
extern DefTableKey Generate;
extern DefTableKey Header;
extern DefTableKeyList IncludeDirs;
extern DefTableKeyList IncludeFiles;
extern DefTableKey Integer8;
extern DefTableKey Local;
extern DefTableKey ModuleFile;
extern DefTableKey ModuleUse;
extern DefTableKey Original;
extern DefTableKey Real8;
extern DefTableKey ScanLength;
extern DefTableKey Timer;
extern DefTableKey TransFile;
extern DefTableKey WarnLevel;

#endif

#ifndef PTGCOMMON_H
#define PTGCOMMON_H

#include "eliproto.h"
#include "ptg_gen.h"
#include "csm.h"


void CPtgOutstr ELI_ARG((PTG_OUTPUT_FILE fs, CONST char *s));
void CPtgOutchar ELI_ARG((PTG_OUTPUT_FILE fs, int c));
void PPtgOutstr ELI_ARG((PTG_OUTPUT_FILE fs, CONST char *s));
void PtgOutId ELI_ARG((PTG_OUTPUT_FILE fs, int c));


#define PTGCStringId(id) PTGCString(StringTable(id))
#define PTGPStringId(id) PTGPString(StringTable(id))


#endif

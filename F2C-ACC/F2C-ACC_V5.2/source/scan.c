
static char RCSid[] =
  "$Id: Scan.fw,v 1.1 2006/03/08 20:23:28 govett Exp $";

#include <string.h>
#include "eliproto.h"

#if 0
#define FixedFormat 1
#endif

#if !0
#include "Include.h"
#include "clp.h"
#include "CmdLineIncl.h"
#endif



#include "err.h"
/* Exported entities used in the FORTRAN scanner:
 *   POSITION   (type):         Source text coordinates
 *   ERROR      (constant):     Severity indicating output cannot be run
 *   curpos     (variable):     Storage for token coordinates
 *   message    (operation):    Report an error
 ***/


#include "source.h"
/* Exported entities used in the FORTRAN scanner:
 *   TEXTSTART  (variable):     Pointer to a line of input text
 *   LineNum    (variable):     Index of the current text buffer line
 *   refillBuf  (operation):    Refill the text buffer from the source file
 ***/


#include "obstack.h"
/* Exported entities used in the FORTRAN scanner:
 *   ObstackP           (type):         Variable-size storage area
 *   obstack_init       (operation):    Initialize using defaults
 *   obstack_begin      (operation):    Initialize using specified values
 *   obstack_grow       (operation):    Add data to the current contiguous area
 *   obstack_1grow      (operation):    Add one character to the current string
 *   obstack_finish     (operation):    Complete the current growth
 *   obstack_free       (operation):    Cut back the storage in use
 ***/


#include "csm.h"
/* Exported entities used in the FORTRAN scanner:
 *   NoStr      (constant):     Non-existent string
 *   Csm_obstk  (constant):     Dynamic string storage facility
 *   CsmStrPtr  (variable):     Pointer to string in dynamic string storage
 *   stostr     (operation):    Make a stored string permanent
 ***/


#include "idn.h"



#include "gla.h"
/* Exported entities used in the FORTRAN scanner support routines
 *   NORETURN   (constant):     Classification of an ignored character sequence
 *   TokenStart (variable):     Pointer to the current character sequence
 *   TokenEnd   (variable):     Pointer to the first unprocessed character
 *   ResetScan  (variable):     True if TokenEnd is invalid
 ***/


#include "termcode.h"
#include "litcode.h"
#include "tabsize.h"

#define PARSE_LEN 500



static char F77Fold[] = {
   0 ,  1 ,  2 ,  3 ,  4 ,  5 ,  6 ,  7 ,
   8 ,  9 ,  10,  11,  12,  13,  14,  15,
   16,  17,  18,  19,  20,  21,  22,  23,
   24,  25,  26,  27,  28,  29,  30,  31,
   0 , '!', '"', '#', '$', '%', '&', '\'',      /* Skip spaces */
  '(', ')', '*', '+', ',', '-', '.', '/',
  '0', '1', '2', '3', '4', '5', '6', '7',
  '8', '9', ':', ';', '<', '=', '>', '?',
  '@','a', 'b', 'c', 'd', 'e', 'f', 'g',       /* Change upper to lower */
  'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
  'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
  'x', 'y', 'z', '[', '\\',']', '^', '_',
  '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g',
  'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
  'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
  'x', 'y', 'z', '{', '|', '}', '~', 127
};


static char FoldIntrinsic[] = {
   0 ,  1 ,  2 ,  3 ,  4 ,  5 ,  6 ,  7 ,
   8 ,  9 ,  10,  11,  12,  13,  14,  15,
   16,  17,  18,  19,  20,  21,  22,  23,
   24,  25,  26,  27,  28,  29,  30,  31,
   0 , '!', '"', '#', '$', '%', '&', '\'',      /* Skip spaces */
   0 ,  0 , '*', '+', ',', '-', '.', '/',
  '0', '1', '2', '3', '4', '5', '6', '7',
  '8', '9', ':', ';', '<', '=', '>', '?',
  '@','a', 'b', 'c', 'd', 'e', 'f', 'g',       /* Change upper to lower */
  'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
  'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
  'x', 'y', 'z', '[', '\\',']', '^', '_',
  '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g',
  'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
  'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
  'x', 'y', 'z', '{', '|', '}', '~', 127
};



char *
#ifdef PROTO_OK
NormalizeFixed(char *start, int length, ObstackP obstk, char *table)
#else
NormalizeFixed(start, length, obstk, table)
char *start; int length; ObstackP obstk; char *table;
#endif
/* Normalize a string to an obstack
 *   On entry-
 *     start points to a string to be normalized
 *     length=length of the string to be normalized
 *     obstk points to the area in which the normalized string will be stored
 *     table points to the translation table
 *   On exit-
 *     NormalizeFixed points to the normalized string
 ***/

{
  register char temp;

  while (length-- > 0) {
    if (temp = table[*start++]) obstack_1grow(obstk, temp);
  }
  obstack_1grow(obstk, '\0');
  return (char *)obstack_finish(obstk);
}



char *
#ifdef PROTO_OK
NormalizeVariable(char *start, int length, ObstackP obstk, char *table)
#else
NormalizeVariable(start, length, obstk, table)
char *start; int length; ObstackP obstk; char *table;
#endif
/* Normalize a string to an obstack
 *   On entry-
 *     start points to a string to be normalized
 *     length=length of the string to be normalized
 *     obstk points to the area in which the normalized string will be stored
 *     table points to the translation table
 *   On exit-
 *     NormalizeVariable points to the normalized string
 ***/

{
  register char temp;

  while (length-- > 0 && (temp = table[*start++])) obstack_1grow(obstk, temp);
  obstack_1grow(obstk, '\0');
  return (char *)obstack_finish(obstk);
}



#if !0
extern void NextIncludedLine ELI_ARG((char *));
extern char *fstr ELI_ARG((char *start, int length));
#endif


static Obstack Statement;
static char *Stmt = NoStr;


typedef struct { int IndexInStmt, LineIndex, Offset; } MapElement;
static MapElement *Map, Current;
static Obstack MapData;


static MapElement *CoordBase;

void
#ifdef PROTO_OK
TokenCoords(int p, POSITION *pos, int right)
#else
TokenCoords(p, pos, right)
int p; POSITION *pos; int right;
#endif
{ while (p >= CoordBase[1].IndexInStmt) CoordBase++;
  if (!right) {
    pos->line = CoordBase->LineIndex;
#ifdef MONITOR
    pos->col = pos->cumcol = p - CoordBase->Offset;
#else
    pos->col = p - CoordBase->Offset;
#endif
  } else {
#ifdef RIGHTCOORD
    pos->rline = CoordBase->LineIndex;
#ifdef MONITOR
    pos->rcol = pos->rcumcol = p - CoordBase->Offset;
#else
    pos->rcol = p - CoordBase->Offset;
#endif
#endif
  }
}







char *
#ifdef PROTO_OK
IsComment(char *p)
#else
IsComment(p)
char *p;
#endif
/* Standard interface for a line classification predicate
 *   On entry-
 *     p points to the first character of a source text line
 *   If the scanning operation is satisfied then on exit-
 *     The function returns a pointer to the first unexamined character
 *   Otherwise on exit-
 *     The function returns a null pointer
 ***/

{ register char *q;
short i;

  if (!*p) return NoStr;
  for (q = p; *q == ' ' || *q == '\t'; q++) ;
  switch (*q) {
    case '\n':
      LineNum++; return q+1;
    default:
      return NoStr;
    case 'C': case 'c': case '*': case '!':
      if ((q == p) && (!FixedFormat && (toupper(*q) == 'C'))) { return NoStr; }
      if (FixedFormat && q == p+5) { return NoStr; };
      if ((*q == '!') || ((q == p) && (toupper(*q) == 'C'))) { 

      /* two options exist:                                   **
      **      its an F2C-ACC directive:  CACC$, or !ACC$           **
      **      its a comment                                   */
            if ( ((*(q+1) == 'A') || (*(q+1) == 'a')) &&
                 ((*(q+2) == 'C') || (*(q+2) == 'c')) &&
                 ((*(q+3) == 'C') || (*(q+3) == 'c')) &&
                  (*(q+4) == '$')) {

      /* remove the '$' character since it can't be parsed    */
              for (i=4;i>0;i--) {
                *(q+i) = *(q+i-1);
              }
              *(q+1) = ' ';

      /* !sms$insert directive names will be blanked */
              if ((toupper(*(q+5)) == 'I') && (toupper(*(q+6)) == 'N') &&
                 (toupper(*(q+7)) == 'S') && (toupper(*(q+8)) == 'E') &&
                (toupper(*(q+9)) == 'R') && (toupper(*(q+10)) == 'T')) {
                if (toupper(*(q+11)) != ' ') { break; } 
                for (i=0; i<=10; i++) *(q+i) = ' ';
              }
              return q+1;
            } else { break; }
        }    /* free or fixed format comment */
        return NoStr; break;          /* parse error!!        */
  }
  do { q++; } while (*q != '\n');
  LineNum++; return q+1;
}



char *
#ifdef PROTO_OK
IsContinue(char *p)
#else
IsContinue(p)
char *p;
#endif
/* Standard interface for a line classification predicate
 *   On entry-
 *     p points to the first character of a source text line
 *   If the scanning operation is satisfied then on exit-
 *     The function returns a pointer to the first unexamined character
 *   Otherwise on exit-
 *     The function returns a null pointer
 ***/

{
  register int i;
  if (!*p) return NoStr;
  if ((toupper(*(p+1)=='A')) && (toupper(*(p+2)=='C')) &&
       (toupper(*(p+3)=='C')) && (*(p+4)=='>')) {
    for (i=0; i<5; i++) { *(p+i) = ' '; }
    if (FixedFormat) { *(p+5)='+'; } else { *(p+5) = ' '; return(p+6); }
  }

  // if this is not an ACC$ continuation line, it's a comment
  if (FixedFormat) { 
    for (i = 0; i < 5; i++) if (p[i] != ' ') return NoStr;
    if (p[5] == ' ' || p[5] == '\t') return NoStr;
    if (p[5] == '0') { p[5] = ' '; return NoStr; }
    return p+6;
  } else {
    register char c;
    while ((c = *p++) == ' ' || c == '\t') ;
/* MWG: handle continuation characters that are not '&' that appear in
        the sixth column
*/
    if ((c == '&') || ((c == '1') && (i==6))) {
printf("continuation line?\\n");
        return(p);
    } else {
        return NoStr;
    }
  }
}





void
#ifdef PROTO_OK
NextNonComment(char *p)
#else
NextNonComment(p)
char *p;
#endif
/* Standard interface for a line positioning operation
 *   On entry-
 *     p points to the first character of a source text line
 *     LineNum is the index of the source line pointed to by p
 *   On exit-

 * LineNum=index of the current source line in the entire text
 * TEXTSTART points to the first character of the current source line

 *     The line pointed to by TEXTSTART is of the desired class
 ***/

{ char *next;
  for (;;) {
    if (!*p) {
      refillBuf(p);
      p = TEXTSTART;
#if !0
      if (!*p) p = ContinuationText();
#endif
    }
    if (!(next = IsComment(p))) break;
    p = next;
  }
#if 0
  TEXTSTART = p;
#else
  NextIncludedLine(p);
#endif
}



void
#ifdef PROTO_OK
NextInitialLine(char *p)
#else
NextInitialLine(p)
char *p;
#endif
/* Standard interface for a line positioning operation
 *   On entry-
 *     p points to the first character of a source text line
 *     LineNum is the index of the source line pointed to by p
 *   On exit-

 * LineNum=index of the current source line in the entire text
 * TEXTSTART points to the first character of the current source line

 *     The line pointed to by TEXTSTART is of the desired class
 ***/

{
  for (;;) {
    char *next;
    NextNonComment(p);
    if (!(next = IsContinue(TEXTSTART))) return;
    { POSITION e; e.line = LineNum; e.col = next - TEXTSTART + 1;
      message(ERROR, "Continuation without initial line", 0, &e);
      while (*next++ != '\n') ;
      LineNum++;
      p = next;
    }
  }
}

#if !0

#include <stdio.h>
#include "csm.h"
#include "clp.h"
#include "ppp.h"
#include "CoordMap.h"

#define FALSE 0
#define TRUE 1
#define NEXT 2

#define INCLUDE 2
#define USE 3
#define NOT_USE 4

#define ALWAYS_OUTPUT 32767
#define DEBUG 3
#define C 0
#define CUDA 1

void
#ifdef PROTO_OK
NextIncludedLine(char *p)
#else
NextIncludedLine(p)
char *p;
#endif
/* Standard interface for a line positioning operation
 *   On entry-
 *     p points to the first character of a source text line
 *     LineNum is the index of the source line pointed to by p
 *   On exit-

 * LineNum=index of the current source line in the entire text
 * TEXTSTART points to the first character of the current source line

 *     The line pointed to by TEXTSTART is of the desired class
 ***/


{ char c, *q,*loc;

  void create_module_file(char *modulename,int access_type, char *use_only);
  int i,j;
  short found;
  short found_file;
  char s[80];
  static int first_time=TRUE;
        
  if (strcmp(StringTable(GetClpValue(FileName,0)),MapFile(LineOf(curpos))) == 0) {
    ModuleFileNestLevel = 0;
  }

  if (!(TEXTSTART = p)) return;

        /* When an optional module file is used, we must first create   **
        ** that file.                                                   */

  StartLine = p - 1;
  while ((c = *p++) == ' ' || c == '\t') {
    if (c == '\t') StartLine -= TABSIZE(p - StartLine);
  }

        /* search for "include" string */

  q = "include";
  loc = p;
  found_file = FALSE;
  while (*q) {
    if (F77Fold[c] != *q) {
      p = loc;
      goto check_use;
    }
    c = *p++; q++;
  }

        /* eliminate any spaces between the include word and the file   **
        ** to be included / used.                                       */

  found_file = INCLUDE;
  while ((c = *p++) == ' ' || c == '\t') {
    if (c == '\t') StartLine -= TABSIZE(p - StartLine);
  }
  if (c != '\'' && c != '"' ) return;
  curpos.line = LineNum; curpos.col = p - StartLine;
  p = fstr(p - 1, 1); q = CsmStrPtr;

  while ((c = *p++) == ' ' || c == '\t') {
    if (c == '\t') StartLine -= TABSIZE(p - StartLine);
  }
  if (c == '!') while (c != '\n') c = *p++;


check_use:
  if (found_file != INCLUDE) {
    q = "use";
    loc = p-1;  /* save the start location of the use reference */
    while (*q) {
      if (F77Fold[c] != *q) {
        return;
      }
      c = *p++; q++;
   }

        /* a space must follow the "use" reference      */
    if (c != ' ') return;

        /* look at the next non-blank character to eliminate invalid    **
        ** statements containing the string "use"  eg. use = 3          */
    while ((c == ' ' || c == '\t')) {
      c = *p++;
    }
    if ((c == '(') || (c == ',') || (c == '=')) return;
    found_file = USE;

    curpos.line = LineNum; curpos.col = p - StartLine;
    p = fstr(p - 2, 1); q = CsmStrPtr;

    if (q[strlen(q)-1] == ',') {
      q[strlen(q)-1] = '\0';
    }

    while ((c = *p++) == ' ' || c == '\t') {
      if (c == '\t') StartLine -= TABSIZE(p - StartLine);
    }
    if (c == '!') while (c != '\n') {
      c = *p++;
    }

  }

  LineNum++;
  TEXTSTART = p;

  if (found_file == INCLUDE) {
    int i;
    found = FALSE;
    for (i=0; i<Num_ModuleFiles; i++) {
      if ((strcmp(MapFile(LineOf(curpos)),q) == 0) ||
          (strcmp(Module_File[i].UseModuleRef,q)==0))  {
        found = TRUE;
      }
    }
        /* if the include is contained within a module, classify it     **
        ** as a pseudo module file, because that is the scope in which  **
        ** it appears to the program being processed.                   */
    if (found == FALSE) {
      if (GetClpValue(WarnLevel,0) == DEBUG) {
        printf("INCLUDE: adding module: %s\n",q);
      }
        (void) strcpy(Module_File[Num_ModuleFiles].FileName, 
                MapFile(LineOf(curpos)));
        Module_File[Num_ModuleFiles].Line = MapLine(LineOf(curpos));
        (void) strcpy(Module_File[Num_ModuleFiles].UseModuleRef,q);
        Module_File[Num_ModuleFiles].NestLevel = ModuleFileNestLevel;
        Num_ModuleFiles++;
    }

        /* This is probably unused - legacy PPP stuff */
    if (Num_IncludeFiles > MAX_INCLUDE_FILES) {
      message(ERROR,"Maximum number of include files exceeded.",0,&curpos);
    } else {
      strcpy(Include_Line[Num_IncludeFiles].FileName, q);
      if (strcmp(MapFile(LineOf(curpos)),
                StringTable(GetClpValue(FileName,0)))==0)
        Include_Line[Num_IncludeFiles].Line = MapLine(LineOf(curpos));
      else 
        Include_Line[Num_IncludeFiles].Line = 
                                Include_Line[Num_IncludeFiles-1].Line;

        /* convert from single to double quotes for C and CUDA generation */
      if (strcmp(StringTable(GetClpValue(FileName,0)),
                 MapFile(LineOf(curpos))) == 0) {
        if ((GetClpValue(Generate,CUDA) == CUDA ) ||
            (GetClpValue(Generate,CUDA) == C)) {
          fprintf(stdout,"replace %d       #include \"%s.h\"\n",
                MapLine(LineOf(curpos)),q);
        }
      }

      Num_IncludeFiles++;
    }

/* if include files are nested, we must use the line number of the      **
** original file.                                                       */

    found = FALSE;
    for (i=1; i<=LengthDefTableKeyList(IncludeFiles); i++) {
      if (strcmp(q, StringTable(GetClpValue(
                IthElemDefTableKeyList(IncludeFiles,i),0))) == 0) {
        found = i;
      }
    }

    fprintf(stderr,"processing include file: %s\n",q);
    if (!ReadingFrom(FindFile(q))) {
      if (GetClpValue(WarnLevel,ALWAYS_OUTPUT) > 0) {
           message(ERROR, "Cannot open include file", 0, &curpos);
      }
    }
    p = TEXTSTART;
    obstack_free(Csm_obstk, q);
    NextInitialLine(p);
  }

  if (found_file == USE) {
    p = loc;
    *p = 'S'; /* change "use" to "sse" so we don't re-parse this stmt! */
    TEXTSTART = p;

        /* convert module name to lower case    */
    for (i=0;i<strlen(q); i++) {
      *(q+i) = tolower(*(q+i));
    }

        /* Store the module reference and line number in the    **
        ** Module_File structure                                */

    if (Num_ModuleFiles >= MAX_MODULE_REFS) {
        message(FATAL,"Exceeded maximum storage for module file structure.", 0, &curpos);
        exit(1);
    } else {
        /* increment past the "module" keyword to get to the module name */
      if (strcmp(q,"module") == 0) {
        p = fstr(p + 1, 1); q = CsmStrPtr;
        p = TEXTSTART;  /* reset to start of line       */
        q+=9;   /* increment past the module statement  */
      }
    }

    LineNum--;
    create_module_file(q,USE,p+9);
    ModuleFileNestLevel--;
    p = TEXTSTART;
    NextInitialLine(p);
  }

  p = TEXTSTART;
  obstack_free(Csm_obstk, q);
  NextInitialLine(p);
  return;
}


void create_module_file(char *modulename,int access_type,char *use_only) {

        /* Module files are created because they are listed in a        **
        ** use clause.  A temporary file is built containing            **
        ** the body of the module (ie. module statements stripped out). **
        ** Note: this routine is recursive.                             */

  char UseRef[80];
  char UseFile[81],NewUseFile[85];
  char line[81];
  FILE *tfile,*ufile,*nufile;
  char str1[80],str2[80],str3[80],str2_orig[80],prev_mod[80];
  short output=FALSE;
  int i,j;
  int module_found;
  static int nest_level = 1;

        /* recursive declaration */
  void create_module_file(char *modulename,int access_type,char *use_only);

  fprintf(stderr,"processing module: %s\n",modulename);
  *prev_mod = '\0';
        /* convert input filename to lower case */
  for (i=0;i<strlen(modulename); i++) {
    *(modulename+i) = tolower(*(modulename+i));
  }

        // extract the "only" clause if its there
  int only_incr = FALSE;
  for (i=0;i<strlen(use_only);i++) {
    if ((only_incr == FALSE) && (*(use_only+i) == ',')) {
      only_incr = i+1;
    }
  }
  if (only_incr != FALSE) {
    use_only+=only_incr;
    for (i=0;i<20;i++) {
      char c = *(use_only+i);
      if ((int) c == 10) {
        // printf("only ch = 10 %c %d %x\n",*(use_only+i),(int) c, (int) c);
      }
    }
  }

        /* eliminate trailing "," that can preceed the optional "only" clause */

  int len = strlen(modulename);
  for (i=0;i<strlen(modulename); i++) {
    if ( (*(modulename+i) == ',') || (*(modulename+i) == ' ')) {
      *(modulename+i) = '\0';
      j = i-1;
      len = j;
      while(*(modulename+j) == ' ') {
        *(modulename+j) = '\0';
        j--;
      }
    }
  }


  /* add to module file structure that tracks module use */
    if (Num_ModuleFiles >= MAX_MODULE_REFS) {
        message(FATAL,"Exceeded maximum storage for module file structure.", 0, &curpos);
        exit(1);
    } else {
      int found = FALSE;
        int i;
      char filename[80];
      (void) strcpy(filename,modulename);       
        /* MWG: append a ".gpu.tmp" suffix to temporary module files */
      (void) strcat(filename,".gpu.tmp");
      for (i=0; i<Num_ModuleFiles; i++) {
        if (strcmp(filename,Module_File[i].UseModuleRef)==0) {
          found = TRUE;
        }
      }
      if (found == FALSE) {
        if (GetClpValue(WarnLevel,0) == DEBUG) {
          printf("USE: adding module: %s\n",filename);
        }
        (void) strcpy(Module_File[Num_ModuleFiles].FileName, MapFile(LineOf(curpos)));
        Module_File[Num_ModuleFiles].Line = MapLine(LineOf(curpos));
        (void) strcpy(Module_File[Num_ModuleFiles].UseModuleRef,filename);
        Num_ModuleFiles++;
      }
    }

        /* A module look table file must be used to equate a module     **
        ** reference to a file name.  By default, the file:             **
        ** Fortran_Module_Lookup.txt will be used.                      */
        
  if (GetClpValue(TransFile,0) == 0) {
    if ((tfile = fopen("Fortran_Module_Lookup.txt","r")) == NULL) {
      message(ERROR,"Unknown module reference detected that must be added to the lookup table: Fortran_Lookup_Table.txt before this file can be processed.",0,&curpos);
      exit(1);
    }
  } else {      /* open the user defined lookup file    */
    if ((tfile = fopen(StringTable(GetClpValue(TransFile,0)),"r"))==NULL) {
      message(ERROR, "Cannot open lookup file specified by the --Flookup command line option", 0, &curpos);
      fprintf(stderr,"\nLookup FileName: %s\n\n",StringTable(GetClpValue(TransFile,0)));
      exit(1);
    } 
  }

        /* a lookup file should now be open so begin looking for        **
        ** the module reference                                         */

  module_found = FALSE;
  while(fgets(line,130,tfile) != NULL) {
    (void) sscanf(line,"%s %s\n",UseRef,UseFile);
    for (i=0;i<strlen(UseRef); i++) {
      *(UseRef+i) = tolower(*(UseRef+i));
    }
                /* is the module name listed in the lookup file?        */
    if (strcmp(UseRef,modulename) == 0) {
      module_found = TRUE;

        /* if a module file is listed in the lookup file, then generate **
        ** the output file name that will be generated (built) on the   **
        ** first pass executable (IncludeF.exe) and then accessed by    **
        ** the second pass executables.                                 */

      strcpy(NewUseFile,modulename);
      strcat(NewUseFile,".gpu.tmp");

    /* create a temporary file containing the module body, with **
    ** module begin and end statements stripped out             */

        /* check to see if the temp file already exists */
      if ((nufile = fopen(NewUseFile,"r")) == NULL) {
        if ((ufile = fopen(UseFile,"r")) == NULL) {
          message(ERROR,"Unable to open the module file required to satisfy the 'use' statement.",0,&curpos);
          exit(1);
        } else {
          if ((nufile = fopen(NewUseFile,"w")) == NULL) {
            message(ERROR,"Unable to open temporary file for writing.",0,&curpos);
          } else {
            while (fgets(line,80,ufile) != NULL) {
              (void) sscanf(line,"%s %s %s\n",str1,str2,str3);
              for (i=0;i<strlen(str1); i++) {
                *(str1+i) = tolower(*(str1+i));
              }
              strcpy(str2_orig,str2);
              for (i=0;i<strlen(str2); i++) {
                *(str2+i) = tolower(*(str2+i));
              }
              for (i=0;i<strlen(str3); i++) {
                *(str3+i) = tolower(*(str3+i));
              }

              if (((strcmp(str1,"module")==0) && (strcmp(str2,UseRef)==0)) &&
                (output == FALSE)) {
                output = NEXT;
              }
              if ((strcmp(str1,"endmodule")==0) ||((strcmp(str1,"end")==0) &&
                   (strcmp(str2,"module")==0)) || (strcmp(str1, "contains")==0)) {
                output = FALSE;
              }

                        /* recurse into referenced file if "use"        **
                        ** statement is detected.                       */
              if ((strcmp(str1,"use") == 0) && (output == TRUE)) {
                if (str2_orig[strlen(str2_orig)-1] == ',') {
                  str2_orig[strlen(str2_orig)-1] = '\0';
                }

        /* if the module has already been processed, skip it */
                if ((strlen(line)>1) && (strcmp(prev_mod,str2_orig)!=0) && (output!=FALSE)) {
                  strcpy(prev_mod,str2_orig);

                  nest_level++;
                  create_module_file(str2_orig,USE,use_only );
                  nest_level--;
                }

              }
              if (output == TRUE) {
                fprintf(nufile,"%s",line);
              }
              if (output == NEXT) { output = TRUE; }
            }
            fflush(nufile);
            fclose(nufile);
            output = FALSE;
          }
          fclose(ufile);
        }       
      } else {
        fclose(nufile);
      }
      if ((nufile = fopen(NewUseFile,"r")) != NULL) {
        ReadingFrom(FindFile(NewUseFile));
        break;
      }
    }
  }

  if (module_found == FALSE) {
    message(ERROR,"Unable to open module file associated with this use reference.  Entry must exist in the lookup file:  Fortran_Module_Lookup.txt.",0,&curpos);
    exit(1);
  }
  fclose(tfile);
  return;
}

#endif




void
#ifdef PROTO_OK
ExtractFixedLine(char *p)
#else
ExtractFixedLine(p)
char *p;
#endif
/* Standard interface for a line extraction operation
 *   On entry-
 *     The current line is not a comment line
 *     p points to the first character to be extracted

 * LineNum=index of the current source line in the entire text
 * TEXTSTART points to the first character of the current source line

 *   On exit-
 *     The source text is positioned at the next non-comment line

 * LineNum=index of the current source line in the entire text
 * TEXTSTART points to the first character of the current source line

 ***/

{ register char c;
  char *Position0 = TEXTSTART - 1;
/* MWG: Modification to include comments within an executable statment */
  int comment = 0;      /* within a comment = FALSE     */
  int instring = 0;     /* within a string = FALSE      */

  while (p - Position0 <= GetClpValue(ScanLength,PARSE_LEN)) {
/* Invariant: (p - Position0) indexes the first unfilled column
 *            p points to the first unprocessed character
 */
    if ((c = *p) == '\n') { obstack_1grow(&Statement, ' '); Position0--; }
/* MWG: Modification to include comments within an executable statment */
    else {
      if ( (( instring == 0) && (c == '!')) || (comment == 1)) {
        c = ' ';
        comment = 1;
      }
      if ( (c == '\'') || (c == '"') ) {
        if (instring == 1) { instring = 0; } else {instring = 1;}
      }
      p++;
      if (c != '\t') obstack_1grow(&Statement, c);
      else {
        register int size = TABSIZE(p - Position0);
        do obstack_1grow(&Statement, ' ');
        while (size-- && (p - Position0--) <= GetClpValue(ScanLength,PARSE_LEN));
      }
    }
  }

  while (*p++ != '\n') ;
  LineNum++;
  NextNonComment(p);
}

#if !0

char *CurrentLine = NoStr;


void
#ifdef PROTO_OK
ExtractVariableLine(char *p)
#else
ExtractVariableLine(p)
char *p;
#endif
/* Standard interface for a line extraction operation
 *   On entry-
 *     The current line is not a comment line
 *     p points to the first character to be extracted

 * LineNum=index of the current source line in the entire text
 * TEXTSTART points to the first character of the current source line

 *   On exit-
 *     The source text is positioned at the next non-comment line

 * LineNum=index of the current source line in the entire text
 * TEXTSTART points to the first character of the current source line

 ***/

{ register char c;
  char *Position0 = TEXTSTART - 1;

  if (CurrentLine) obstack_free(Csm_obstk, CurrentLine);
  if (*p) {
    while ((c = *p++) != '\n') {
      if (c != '\t') obstack_1grow(Csm_obstk, c);
      else {
        register int size = TABSIZE(p - Position0);
        Position0 -= size;
        do obstack_1grow(Csm_obstk, ' '); while (size--);
      }
    }
    obstack_1grow(Csm_obstk, '\n');
  }
  obstack_1grow(Csm_obstk, '\0');
  CurrentLine = obstack_finish(Csm_obstk);
  LineNum++;
  NextNonComment(p);
}

#endif




void
LoadFixedFormat()
{ ExtractFixedLine(TEXTSTART);
  Current.IndexInStmt += PARSE_LEN;
  
  for (;;) {
    char *next;
    if (!(next = IsContinue(TEXTSTART))) return;

{ Current.LineIndex = LineNum;
  Current.Offset = Current.IndexInStmt - ((next) - TEXTSTART + 1);
  obstack_grow(&MapData, &Current, sizeof(Current)); }

    ExtractFixedLine(next);
    Current.IndexInStmt += PARSE_LEN-6;
  }
}


#if !0

void
LoadVariableFormat()
{ register char J, *p,*next;
  int
    JSQ = 0,            /* 1 if within a string delimited by ' */
    JDQ = 0,            /* 1 if within a string delimited by " */
    JHOLL = 0,          /* 1 if within a Hollerith constant */
    HCount = -1;        /* Possible Hollerith count */

  ExtractVariableLine(TEXTSTART); p = CurrentLine;
  while ((J = *p++) != '\n') {

    if (JSQ && J == '\'') { JSQ = 0; goto add; }
    if (JDQ && J == '"') { JDQ = 0; goto add; }
    if (JSQ || JDQ || JHOLL) {
      if (J != '&') {
        if (JHOLL && --HCount == 0) JHOLL = 0;
        goto add;
      }

{ register char temp, *tempp = p;
  char *next = IsContinue(TEXTSTART);
  while ((temp = *tempp++) == ' ') ;
  if (temp != '\n' || !next) goto add;

{ Current.LineIndex = LineNum;
  Current.Offset = Current.IndexInStmt - ((next) - TEXTSTART + 1);
  obstack_grow(&MapData, &Current, sizeof(Current)); }

  ExtractVariableLine(next); p = CurrentLine;
}

      continue;
    }


    switch (J) {
    case '&':

{ char *next = IsContinue(TEXTSTART);
  while ((J = *p++) == ' ') ;
  if (J != '\n') {
    if (J != '!') {
      POSITION e;
      e.line = Current.LineIndex; e.col = p - CurrentLine - Current.Offset;
      message(ERROR, "Only a comment can follow &", 0, &e);
    }
    while (*p++ != '\n') ;
  }
  if (!next) {

obstack_1grow(&Statement, ' '); Current.IndexInStmt++;

    if (HCount > 0) HCount = -1;
    next = TEXTSTART;
  }

{ Current.LineIndex = LineNum;
  Current.Offset = Current.IndexInStmt - ((next) - TEXTSTART + 1);
  obstack_grow(&MapData, &Current, sizeof(Current)); }

  ExtractVariableLine(next); p = CurrentLine;
}

      continue;
    case '!': while (*p != '\n') p++; continue;
    case '\'': JSQ = 1; HCount = -1; break;
    case '"': JDQ = 1; HCount = -1; break;
    case '(': case ',': case '/': case '*': HCount = 0; break;
    case '0': case '1': case '2': case '3': case '4':
    case '5': case '6': case '7': case '8': case '9':
      if (HCount >= 0) HCount = HCount * 10 + J - '0'; break;
    case 'H': case 'h': if (HCount > 0) JHOLL = 1; break;
    case ' ': if (HCount == 0) break;
    default: HCount = -1;
    }

add:

obstack_1grow(&Statement, J); Current.IndexInStmt++;

  }

/* this code segment adapts the parser for sms directives, which        **
** do not require ampersands to appear at the end of the line.          */
while ((next = IsContinue(TEXTSTART))) {
    
    { Current.LineIndex = LineNum;
      Current.Offset = Current.IndexInStmt - ((next) - TEXTSTART + 1);
      obstack_grow(&MapData, &Current, sizeof(Current)); }
    
        ExtractFixedLine(next);
                Current.IndexInStmt += PARSE_LEN-6;
}

  obstack_free(Csm_obstk, CurrentLine); CurrentLine = NoStr;
  NextInitialLine(TEXTSTART);
}

#endif


void
LoadStmtBuffer()
{
  if (Stmt) {
    obstack_free(&Statement, (void *)Stmt);
    obstack_free(&MapData, (void *)Map);
  } else {
    obstack_init(&Statement);
    obstack_init(&MapData);
    NextInitialLine(TEXTSTART);
  }

  Current.IndexInStmt = 1;

{ Current.LineIndex = LineNum;
  Current.Offset = Current.IndexInStmt - ((TEXTSTART) - TEXTSTART + 1);
  obstack_grow(&MapData, &Current, sizeof(Current)); }


  if (*TEXTSTART) {
#if 0
    LoadFixedFormat();
#else
    if (FixedFormat) LoadFixedFormat(); else LoadVariableFormat();
#endif

obstack_1grow(&Statement, '\n'); Current.IndexInStmt++;

  }


obstack_1grow(&Statement, '\0'); Current.IndexInStmt++;


{ Current.LineIndex = LineNum;
  Current.Offset = Current.IndexInStmt - ((TEXTSTART) - TEXTSTART + 1);
  obstack_grow(&MapData, &Current, sizeof(Current)); }

  Stmt = (char *)obstack_finish(&Statement);
  CoordBase = Map = (MapElement *)obstack_finish(&MapData);
}




static int Assignment = 0;      /* Nonzero if the statement is an assignment */
static char NewScanMark = '\0'; /* Trigger for restarting the scanner */


int
#ifdef PROTO_OK
IsAssignment(char *p)
#else
IsAssignment(p)
char *p;
#endif
/* Check for an assignment statement
 *   If the string pointed to by p is an assignment statement then on exit-
 *     IsAssignment=1
 *   Otherwise on exit-
 *     IsAssignment=0
 ***/
{
  register char J;
  char JSQ = 0, JDQ = 0, ISW = 0, JEQ = 0;
  int Level = 0, JHOLL = 0;
#if !0
  char JCOLON = 0;
#endif

  if (!*p) return 0;
  while ((J = *p++) != '\n') {
    if (J == ' ') continue;
    if (JSQ) { if (J == '\'') JSQ = 0; continue; }
    if (JDQ) { if (J == '"') JDQ = 0; continue; }

#if !0
    if (J != ':') JCOLON = 0;
#endif
    switch (J) {
    case '\'': JSQ = 1; JHOLL = 0; break;
    case '"': JDQ = 1; JHOLL = 0; break;
    case '0': case '1': case '2': case '3': case '4':
    case '5': case '6': case '7': case '8': case '9':
      if (JHOLL) JHOLL++; break;
    case 'h': case 'H': if (JHOLL > 1) return 0; JHOLL = 0; break;
#if !0
    case ':': if (JCOLON) return 0; JCOLON = 1; JHOLL = 0; break;
    case ';': return JEQ;
#endif
    case '/': case '*': if (Level == 0 && !JEQ) return 0; JHOLL = 1; break;
    case ',': if (Level == 0) return 0; JHOLL = 1; break;
    case '(': Level++; ISW = 0; JHOLL = 1; continue;
    case ')': JHOLL = 0; if (--Level) break; ISW = !JEQ; continue;
    case '=': if (Level != 0 && !JEQ) return 0; JEQ = 1;
    default: JHOLL = 0;
    }

    if (ISW) {

{ NewScanMark = *(p - 1); *(p - 1) = '\0'; }

      return JEQ;
    }
  }
  return JEQ;
}



char *
#ifdef PROTO_OK
auxNUL(char *start, int length)
#else
auxNUL(start, length)
char *start; int length;
#endif
/* Standard interface for an auxiliary scanner
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *   On exit-
 *     The function returns a pointer to the first character
 *       beyond the scanned string
 ***/

{
  if (NewScanMark) {
    *start = NewScanMark; NewScanMark = '\0';
    Assignment = IsAssignment(start);
  }
  return start;
}




int NewClass;   /* Code for the alternative classification */
char *NewEnd;   /* Pointer to the first character beyond the token */
void  (*Processor) ELI_ARG((char *, int, int *, int *));


int CurrentClass = NORETURN;


int
#ifdef PROTO_OK
Reparatur(POSITION *coord, int *klass, int *intrinsic)
#else
Reparatur(coord, klass, intrinsic)
POSITION *coord; int *klass, *intrinsic;
#endif
/* Repair a syntax error by changing the lookahead token
 *   On entry-
 *     coord points to the coordinates of the lookahead token
 *     klass points to the classification of the lookahead token
 *     intrinsic points to the intrinsic attribute of the lookahead token
 *   If the lookahead token has been changed then on exit-
 *     Reparatur=1
 *     coord, klass and intrinsic reflect the change
 *   Else on exit-
 *     Reparatur=0
 *     coord, klass and intrinsic are unchanged
 ***/

{
  if (CurrentClass != *klass) return 0;
  CurrentClass = NORETURN;
  *klass = NewClass;
  TokenEnd = NewEnd;
  Processor(TokenStart, TokenEnd - TokenStart, klass, intrinsic);
  return 1;
}



void
NewStmtBuffer()
{ LoadStmtBuffer();
  TokenEnd = Stmt; StartLine = Stmt - 1;
  Assignment = IsAssignment(TokenEnd);
}




typedef struct {                /* Definition of a keyword */
  char *keychars;                  /* Character form */
  int keycode;                     /* Syntax code */
  int length;                      /* Length of the keyword string */
} Keywd;

#include "keywds.h"

/**/
int
#ifdef PROTO_OK
Keyword(char *c)
#else
Keyword(c)
char *c;
#endif
/* Get the classification code for a keyword
 *   On entry-
 *     c points to a normalized identifier string
 *   If c has a keyword prefix then on exit-
 *     Keyword=Syntax code of the keyword
 *   Otherwise on exit-
 *     Keyword=-1
 **/
{
  int i;

  for (i = MAXKWD; i >= 0; i--) {
    register char *p = c, *q =  KeyTable[i].keychars;
    register int different = 0;

    while (*p && *q && !different) different = *p++ - *q++;

    if (!different) {
      if (!*q) return i;
    } else if (different > 0 && p == c+1) return -1;
  }
  return -1;
}



void
#ifdef PROTO_OK
mkfidn(char *start, int length, int *klass, int *intrinsic)
#else
mkfidn(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ int dummy = *klass;
  CsmStrPtr = NormalizeFixed(start, length, Csm_obstk, F77Fold);
  mkidn(CsmStrPtr, strlen(CsmStrPtr), &dummy, intrinsic);
}



void
#ifdef PROTO_OK
nobody(char *start, int length, int *klass, int *intrinsic)
#else
nobody(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ }



void
#ifdef PROTO_OK
keycheck(char *start, int length, int *klass, int *intrinsic)
#else
keycheck(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ int k;

#if 0
  CsmStrPtr = NormalizeFixed(start, length, Csm_obstk, F77Fold);
#else
  if (FixedFormat)
    CsmStrPtr = NormalizeFixed(start, length, Csm_obstk, F77Fold);
  else {
    CsmStrPtr = NormalizeVariable(start, length, Csm_obstk, F77Fold);
    TokenEnd = start + strlen(CsmStrPtr);
  }
#endif

  if (Assignment) {
    int dummy = xIdent;
    mkidn(CsmStrPtr, strlen(CsmStrPtr), &dummy, intrinsic);
    return;
  }

#if !0

  if (!FixedFormat) {
    mkidn(CsmStrPtr, TokenEnd - start, klass, intrinsic);

    if (*klass != xIdent) {

/* klass points to the classification being returned by this processor */
  { CurrentClass = *klass; NewClass = xIdent; NewEnd =  TokenEnd; Processor =  nobody; }

    /* MWG - do not return - do a keyword check for sms directives   */
    /* return;  */
    }
  } 

#endif


  /* MWG hack to eliminate problems with the select statement */
  /* if ((k = Keyword(CsmStrPtr)) >= 0) { */

  if (((k = Keyword(CsmStrPtr)) >= 0)  &&
        ((FixedFormat) || (strlen(CsmStrPtr) == KeyTable[k].length))) {
    int n;

    obstack_free(Csm_obstk, CsmStrPtr);

    *klass = KeyTable[k].keycode;

/* klass points to the classification being returned by this processor */
  { CurrentClass = *klass; NewClass = xIdent; NewEnd =  start + length; Processor =  mkfidn; }


    TokenEnd = start;
    for (n = 0; n < KeyTable[k].length; n++) while (*TokenEnd++ == ' ') ;
  } else {
    int dummy = xIdent;
    mkidn(CsmStrPtr, strlen(CsmStrPtr), &dummy, intrinsic);
    return;
  }
}






void
#ifdef PROTO_OK
mkfint(char *start, int length, int *klass, int *intrinsic)
#else
mkfint(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{
  *intrinsic = 0;
  while (length-- > 0) {
    register int v = *start - '0';

    if (v >= 0 && v < 10) *intrinsic = *intrinsic * 10 + v;
    else if (*start != ' ') { TokenEnd = start; return; }
    start++;
  }
#ifdef MONITOR
  while (TokenEnd[-1] == ' ') TokenEnd--;
#endif
}



void
#ifdef PROTO_OK
mkfloat(char *start, int length, int *klass, int *intrinsic)
#else
mkfloat(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ int dummy = xRcon;

  CsmStrPtr = NormalizeFixed(start, length, Csm_obstk, F77Fold);
  mkidn(CsmStrPtr, strlen(CsmStrPtr), &dummy, intrinsic);
  if (*start == '.') return;
  while (length-- > 0) {
    register int temp = *start;
    if (temp >= '0' && temp <= '9' || temp == ' ') start++;
  }

/* klass points to the classification being returned by this processor */
  { CurrentClass = *klass; NewClass = xIcon; NewEnd =  start; Processor =  mkfint; }

}



char *
#ifdef PROTO_OK
fstr(char *start, int length)
#else
fstr(start, length)
char *start; int length;
#endif
/* Standard interface for an auxiliary scanner
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *   On exit-
 *     The function returns a pointer to the first character
 *       beyond the scanned string
 ***/

/* Additional postcondition-
 *   CsmStrPtr points to the transformed string
 ***/
{ register char temp, quote;

  quote = *start++;
  for (;;) {
    if ((temp = *start++) == '\n') {
      /* message(ERROR, "Closing quote missing", 0, &curpos); */
      start--;
      break;
    }
    if (temp == quote) {
      if (*start != quote) break;
      start++;
    }
    obstack_1grow(Csm_obstk, temp);
  }
  obstack_1grow(Csm_obstk, '\0');
  CsmStrPtr = (char *)obstack_finish(Csm_obstk);

  return start;
}


void
#ifdef PROTO_OK
mkfstr(char *start, int length, int *klass, int *intrinsic)
#else
mkfstr(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ int dummy = xScon;

  mkidn(CsmStrPtr, strlen(CsmStrPtr), &dummy, intrinsic);
}



void
#ifdef PROTO_OK
mkholl(char *start, int length, int *klass, int *intrinsic)
#else
mkholl(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ register char temp, *p = start;
  register int count = 0, digits = length - 1;
  int dummy = xScon;

  while (digits--) {
    register int v = *p++ - '0';
    if (v >= 0) count = count * 10 + v;
  }
  *intrinsic = count;

  p++;
  while (count > 0 && (temp = *p++) != '\n') {
    obstack_1grow(Csm_obstk, temp);
    count--;
  }
  obstack_1grow(Csm_obstk, '\0');
  CsmStrPtr = (char *)obstack_finish(Csm_obstk);

  if (count) {  /* Return the integer preceding the H */
    obstack_free(Csm_obstk, CsmStrPtr);
    *klass = xIcon; TokenEnd = start + length - 1;
    return;
  }

  mkidn(CsmStrPtr, strlen(CsmStrPtr), &dummy, intrinsic);
  *klass = xScon;

/* klass points to the classification being returned by this processor */
  { CurrentClass = *klass; NewClass = xIcon; NewEnd =  start + length - 1; Processor =  mkfint; }


  TokenEnd = p;
}



void
#ifdef PROTO_OK
mkfopr(char *start, int length, int *klass, int *intrinsic)
#else
mkfopr(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{
#if 0
  CsmStrPtr = NormalizeFixed(start, length, Csm_obstk, F77Fold);
#else
  if (FixedFormat)
    CsmStrPtr = NormalizeFixed(start, length, Csm_obstk, F77Fold);
  else {
    CsmStrPtr = NormalizeVariable(start, length, Csm_obstk, F77Fold);
    if (length != strlen(CsmStrPtr)) {
      message(ERROR,"Space within an operator",0,&curpos);
      obstack_free(Csm_obstk, CsmStrPtr);
      *intrinsic = 0;
      return;
    }
  }
#endif
  mkidn(CsmStrPtr, strlen(CsmStrPtr), klass, intrinsic);
}




void
#ifdef PROTO_OK
mkiokw(char *start, int length, int *klass, int *intrinsic)
#else
mkiokw(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ if (!Assignment) {
    CsmStrPtr = NormalizeFixed(start, length, Csm_obstk, F77Fold);
    mkidn(CsmStrPtr, strlen(CsmStrPtr), klass, intrinsic);

    if (*klass != NORETURN) {

/* klass points to the classification being returned by this processor */
  { CurrentClass = *klass; NewClass = xIdent; NewEnd =  start + length - 1; Processor =  mkfidn; }

      return;
    }
  }
  TokenEnd = start + length - 1; *klass = xIdent;
  keycheck(start, length - 1, klass, intrinsic);
}



void
#ifdef PROTO_OK
mkfmti(char *start, int length, int *klass, int *intrinsic)
#else
mkfmti(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ register char c = *start;
  mkidn(start, length, klass, intrinsic);
  if (c != '+' && c != '-')

/* klass points to the classification being returned by this processor */
  { CurrentClass = *klass; NewClass = xIcon; NewEnd =  start + length - 1; Processor =  mkfint; }

}



void
#ifdef PROTO_OK
mkslsh(char *start, int length, int *klass, int *intrinsic)
#else
mkslsh(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ *klass = Slash; }


void
#ifdef PROTO_OK
mkconc(char *start, int length, int *klass, int *intrinsic)
#else
mkconc(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ *klass = Concat;

/* klass points to the classification being returned by this processor */
  { CurrentClass = *klass; NewClass = Slash; NewEnd =  start + 1; Processor =  mkslsh; }
 }



void
#ifdef PROTO_OK
mklpar(char *start, int length, int *klass, int *intrinsic)
#else
mklpar(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ *klass = LeftParen; }

#if !0

void
#ifdef PROTO_OK
mkrpar(char *start, int length, int *klass, int *intrinsic)
#else
mkrpar(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ *klass = RightParen; }


void
#ifdef PROTO_OK
mklabr(char *start, int length, int *klass, int *intrinsic)
#else
mklabr(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ *klass = LeftAcBracket;

/* klass points to the classification being returned by this processor */
  { CurrentClass = *klass; NewClass = LeftParen; NewEnd =  start + 1; Processor =  mklpar; }
 }


void
#ifdef PROTO_OK
mkrabr(char *start, int length, int *klass, int *intrinsic)
#else
mkrabr(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ *klass = RightAcBracket;

/* klass points to the classification being returned by this processor */
  { CurrentClass = *klass; NewClass = Slash; NewEnd =  start + 1; Processor =  mkslsh; }
 }
#endif



void
#ifdef PROTO_OK
mkimpl(char *start, int length, int *klass, int *intrinsic)
#else
mkimpl(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ int dummy;

  CsmStrPtr = NormalizeFixed(start, length - 1, Csm_obstk, FoldIntrinsic);
  TokenEnd = start + length - 1;
  dummy = xIdent; mkidn(CsmStrPtr, strlen(CsmStrPtr), &dummy, intrinsic);

/* klass points to the classification being returned by this processor */
  { CurrentClass = *klass; NewClass = LeftParen; NewEnd =  start + 1; Processor =  mklpar; }

}




void
#ifdef PROTO_OK
EndOfStmt(char *start, int length, int *klass, int *intrinsic)
#else
EndOfStmt(start, length, klass, intrinsic)
char *start; int length, *klass; int *intrinsic;
#endif
/* Standard interface for a processor
 *   On entry-
 *     start points to the first character of the scanned string
 *     length=length of the scanned string
 *     klass points to a location containing the initial classification
 *     intrinsic points to a location to receive the intrinsic attribute
 *   On exit-
 *     klass points to a location containing the final classification
 *     intrinsic points to a location containing the intrinsic attribute value
 *       (if relevant)
 ***/

{ if (start[length-1] == '\n') ResetScan = 1;
  else Assignment = IsAssignment(TokenEnd);
}


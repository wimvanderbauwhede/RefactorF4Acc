#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "clp.h"
#include "clpintf.h"
#include "pdl_gen.h"
#include "csm.h"
#include "eliproto.h"

#define TYPE_MASK      0x001F
#define BOOL           0x0001
#define INTVAL         0x0002
#define STRVAL         0x0004
#define USAGE          0x0008
#define TERM           0x0010

#define JOINED         0x0100
#define SPACED         0x0200
#define PLURAL         0x0400

typedef struct opt opt;
struct opt {
    CONST char *str;
    int flags;
    int *count;
    DefTableKey *key;
    DefTableKeyList *list;
};

DefTableKey CLP_InputFile = NoKey;
int FixedFormat = 0;
DefTableKey FileName = NoKey;
DefTableKey Analysis = NoKey;
static int Analysis_count = 0;
DefTableKey Constants = NoKey;
static int Constants_count = 0;
DefTableKey DeviceInit = NoKey;
static int DeviceInit_count = 0;
DefTableKey Exact = NoKey;
static int Exact_count = 0;
DefTableKey Generate = NoKey;
static int Generate_count = 0;
DefTableKey Header = NoKey;
static int Header_count = 0;
DefTableKeyList IncludeDirs = NULLDefTableKeyList;
DefTableKeyList IncludeFiles = NULLDefTableKeyList;
DefTableKey Integer8 = NoKey;
static int Integer8_count = 0;
DefTableKey Local = NoKey;
static int Local_count = 0;
DefTableKey ModuleFile = NoKey;
static int ModuleFile_count = 0;
DefTableKey ModuleUse = NoKey;
static int ModuleUse_count = 0;
DefTableKey Original = NoKey;
static int Original_count = 0;
DefTableKey Real8 = NoKey;
static int Real8_count = 0;
DefTableKey ScanLength = NoKey;
static int ScanLength_count = 0;
DefTableKey Timer = NoKey;
static int Timer_count = 0;
DefTableKey TransFile = NoKey;
static int TransFile_count = 0;
DefTableKey WarnLevel = NoKey;
static int WarnLevel_count = 0;
static int error_count = 0;

#define NUMOPTS 19

static opt opts[] = {
    { "-fixed", BOOL , &FixedFormat, NULL, NULL },
    { "-anal", INTVAL | JOINED, &Analysis_count, &Analysis, NULL },
    { "-constants", STRVAL | JOINED, &Constants_count, &Constants, NULL },
    { "-DeviceInit", INTVAL | JOINED, &DeviceInit_count, &DeviceInit, NULL },
    { "-Exact", INTVAL | JOINED, &Exact_count, &Exact, NULL },
    { "-generate", INTVAL | JOINED, &Generate_count, &Generate, NULL },
    { "-h", INTVAL | JOINED, &Header_count, &Header, NULL },
    { "-I", STRVAL | PLURAL | JOINED, NULL, NULL, &IncludeDirs },
    { "-iF", STRVAL | PLURAL | JOINED, NULL, NULL, &IncludeFiles },
    { "-i8", INTVAL | JOINED, &Integer8_count, &Integer8, NULL },
    { "-local", INTVAL | JOINED, &Local_count, &Local, NULL },
    { "-module", INTVAL | JOINED, &ModuleFile_count, &ModuleFile, NULL },
    { "-use", INTVAL | JOINED, &ModuleUse_count, &ModuleUse, NULL },
    { "-o", STRVAL | JOINED, &Original_count, &Original, NULL },
    { "-r8", INTVAL | JOINED, &Real8_count, &Real8, NULL },
    { "-SL", INTVAL | JOINED, &ScanLength_count, &ScanLength, NULL },
    { "-timer", INTVAL | JOINED, &Timer_count, &Timer, NULL },
    { "-lF", STRVAL | JOINED, &TransFile_count, &TransFile, NULL },
    { "-V", INTVAL | JOINED, &WarnLevel_count, &WarnLevel, NULL },
    { "dummy", 0, NULL, NULL, NULL }
};

static void
#ifdef PROTO_OK
clp_error (const char *str, const char *msg)
#else
clp_error (str, msg)
char *str, *msg;
#endif
{
  if (str == (char *) NULL)
    fprintf (stderr, "%s\n", msg);
  else
    fprintf (stderr, "%s %s\n", str, msg);
  error_count++;
}

static int
#ifdef PROTO_OK
clp_atos (char *str)
#else
clp_atos (str)
char *str;
#endif
{
  return stostr (str, strlen(str));
}

void
#ifdef PROTO_OK
clp_usage (char *prog)
#else
clp_usage (prog)
  char *prog;
#endif
{
  fprintf (stderr, "Usage: %s [options] parameters\n", prog);
  fprintf (stderr, "  Items marked with * may be repeated.\n");
  fprintf (stderr, "  Options:\n");
  fprintf (stderr, "    -fixed           Select fixed input format\n");
  fprintf (stderr, "    -analint         [10=DATA_MOVEMENT, 20=VARIABLE_USE] to obtain diagnostic information\n");
  fprintf (stderr, "    -constantsstring VariableName = Value\n");
  fprintf (stderr, "    -DeviceInitint   0=FALSE, 1=TRUE] initialize the GPU?\n");
  fprintf (stderr, "    -Exactint        [1=CPU, 2=GPU] generate bit-wise exact results with replacment intrinsics\n");
  fprintf (stderr, "    -generateint     Output Language:  [0=ANSI-C, 1=CUDA, 2=ANALYSIS]\n");
  fprintf (stderr, "    -hint            [0=FALSE, 1=TRUE] file type is an include file\n");
  fprintf (stderr, "    -Istring         Directories to search for included files*\n");
  fprintf (stderr, "    -iFstring        Included file(s) that are processed by PPP*\n");
  fprintf (stderr, "    -i8int           0=FALSE, 1=TRUE] treat integer declarations as integer*8\n");
  fprintf (stderr, "    -localint        [0=FALSE, 1=TRUE] add local variables to the kernel\n");
  fprintf (stderr, "    -moduleint       [0=FALSE, 1=TRUE] file is module\n");
  fprintf (stderr, "    -useint          [0=INCLUDE, 1=EXTERN] Strategy for handling module references\n");
  fprintf (stderr, "    -ostring         Original path and filename of input file\n");
  fprintf (stderr, "    -r8int           0=FALSE, 1=TRUE] promote real and complex variables to 8 bytes\n");
  fprintf (stderr, "    -SLint           Length Options: 72, 80\n");
  fprintf (stderr, "    -timerint        [0=FALSE, 1=TRUE] invoke print statements to output runtimes for each routine\n");
  fprintf (stderr, "    -lFstring        Module file lookup table\n");
  fprintf (stderr, "    -Vint            Message Level [0=ERRORS, 1=ERRORS+WARNINGS (default), 2=ALL]\n");
  fprintf (stderr, "  Parameters:\n");
  fprintf (stderr, "    FileName         \n");
    exit (1);
}

void
#ifdef PROTO_OK
clp_init (int argc, char *argv[])
#else
clp_init (argc, argv)
int argc;
char *argv[];
#endif
{
  int i, j, p, t;
  DefTableKey k;
  opt *o;
  char *s;

  SetFileErr ("%p: cannot open %f for reading", 0);
  for (i = 1; i < argc; i++) {
    for (j = 0, o = opts; j < NUMOPTS; j++, o++)
      if (strncmp (o->str, argv[i], strlen (o->str)) == 0)
        break;
    if (j == NUMOPTS)
      break;
    s = argv[i] + strlen (o->str);
    if (o->flags & USAGE) {
      if (*s != '\0')
        clp_error (o->str, "must not have a value");
      clp_usage (argv[0]);
    } else if (o->flags & TERM) {
      if (*s != '\0')
        clp_error (o->str, "must not have a value");
      i++;
      break;
    } else {
      if (o->count != (int *) NULL)
        (*o->count)++;
      p = o->flags & PLURAL;
      if ((!p) && (*o->count > 1))
        clp_error (o->str, "can only be given once");
      t = o->flags & TYPE_MASK;
      switch (t) {
        case BOOL:
          if (*s != '\0')
            clp_error (o->str, "must not have a value");
          break;
        case INTVAL:
        case STRVAL: {
          if (o->flags & JOINED) {
            if (*s == '\0') {
              if (o->flags & SPACED) {
                if (i == argc - 1) {
                  clp_error (o->str, "must have a value");
                  continue;
                } else {
                  i++;
                  s = argv[i];
                }
              } else {
                clp_error (o->str, "must have a joined value");
                continue;
              }
            }
          } else if (o->flags & SPACED) {
            if (*s != '\0') {
              clp_error (o->str, "must not have a joined value");
              continue;
            }
            if (i == argc - 1) {
              clp_error (o->str, "must have a value");
              continue;
            } else {
              i++;
              s = argv[i];
            }
          }
          if (p) {
            DefTableKey k = NewKey ();
            switch (t) {
              case INTVAL:
                SetClpValue (k, atoi (s), 0);
                break;
              case STRVAL:
                SetClpValue (k, clp_atos (s), 0);
                break;
            }
            *o->list = AppElDefTableKeyList (*o->list, k);
          } else {
            *o->key = NewKey ();
            switch (t) {
              case INTVAL:
                SetClpValue (*o->key, atoi (s), 0);
                break;
              case STRVAL:
                SetClpValue (*o->key, clp_atos (s), 0);
                break;
            }
          }
        }
      }
    }
  }
  if (i < argc) {
    FileName = NewKey ();
    SetClpValue (FileName, clp_string (argv[i++]), 0);
    CLP_InputFile = FileName;
  }
  if ((i < argc) || (error_count > 0))
    clp_usage (argv[0]);
}

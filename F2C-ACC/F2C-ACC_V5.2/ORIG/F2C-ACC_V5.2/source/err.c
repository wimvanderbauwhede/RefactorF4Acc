
static char RCSid[] = "$Id: CoordMap.fw,v 2.16 2009/10/05 03:24:06 profw Exp $";
/* Copyright 1989, The Regents of the University of Colorado
 * Permission is granted to use any portion of this file for any purpose,
 * commercial or otherwise, provided that this notice remains unchanged.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "err.h"
#include "source.h"
#include "CoordMap.h"

#if defined(unix) || defined (_unix)
#include <unistd.h>
#include <fcntl.h>
#endif

#if defined(_WIN32) || defined(MSDOS) || defined(_MSDOS)
#include <io.h> 
#endif

#ifdef MONITOR
#include "dapto_dapto.h"
#include "err_dapto.h"
#endif

        /* Variables exported by the Error Module */

int ErrorCount[] = {            /* Counts at each severity level */
  0, 0, 0, 0
  };
int LineNum = 1;                /* Index of the current line
                                   in the total source text */

POSITION NoCoord = { 0 };       /* The NULL coordinate */


POSITION curpos;                /* Position variable for general use */

static const char *key[] = {"NOTE", "WARNING", "ERROR", "DEADLY"};

struct msg {
  int severity;
  POSITION loc;
  int grammar;
  CONST char *Msgtext;
  struct msg *forward, *back;
};


static struct msg reports = {   /* Error report list */
  DEADLY, { 0 }, 0, "", &reports, &reports};

static struct msg emergency;    /* In case malloc fails */

static int ImmediateOutput = 1; /* 1 if immediate error output required */
static int GrammarLine = 1;     /* 1 to print AG line number */
static int ErrorLimit = 1;      /* 1 to abort after too many errors */

void
#if defined(__cplusplus) || defined(__STDC__)
ErrorInit(int ImmOut, int AGout, int ErrLimit)
#else
ErrorInit(ImmOut, AGout, ErrLimit)
int ImmOut, AGout, ErrLimit;
#endif
/* Initialize the error module
 *    On entry-
 *       ImmOut=1 if immediate error output required
 *       AGout=1 to print AG line number on error reports
 *       ErrLimit=1 to limit the number of errors reported
 ***/
{
#ifdef MONITOR
  _dapto_enter ("message");
#endif

  ImmediateOutput = ImmOut;
  GrammarLine = AGout;
  ErrorLimit = ErrLimit;

  reports.severity = DEADLY;
  reports.loc.line = reports.loc.col = 0;
  reports.grammar = 0; reports.Msgtext = "";
  reports.forward = reports.back = &reports;

#ifdef MONITOR
  _dapto_leave ("message");
#endif
}

#if defined(__cplusplus) || defined(__STDC__)
int
earlier(POSITION *p, POSITION *q)
#else
int
earlier(p,q)
POSITION *p, *q;
#endif
/* Check relative position
 *    On exit-
 *       earlier != 0 if p defines a position in the source Msgtext that
 *          preceeds the position defined by q
 ***/
{
  if (p->line != q->line) return(p->line < q->line);
  return(p->col < q->col);
}

#if defined(__cplusplus) || defined(__STDC__)
void
message(int severity, const char *Msgtext, int grammar, POSITION *source)
#else
void
message(severity, Msgtext, grammar, source)
int severity; char *Msgtext; int grammar; POSITION *source;
#endif
/* Report an error
 *    On entry-
 *      severity=error severity
 *      Msgtext=message text
 *      grammar=identification of the test that failed
 *      source=source coordinates at which the error was detected
 ***/
{
  int fail = 0;
  struct msg *r, *c;

#ifdef MONITOR
  _dapto_enter ("message");
#endif

  if (severity < NOTE || severity > DEADLY) {
    (void)fprintf(stderr, "Invalid severity code %d for \"%s\"\n",
      severity, Msgtext);
    severity = DEADLY;
    }

  if (source == (POSITION *)0) source = &NoCoord;

#ifdef MONITOR
  _dapto_message (key[severity], Msgtext, source->line, source->col);
#endif

  if (ImmediateOutput) {
    (void)fprintf(stderr, "\"%s\", line %d:%d %s: %s",
      MapFile(source->line),
      MapLine(source->line),
      source->col,
      key[severity],
      Msgtext);
    if (grammar>0 && GrammarLine) (void)fprintf(stderr," AG=%d\n", grammar);
    else (void)putc('\n', stderr);
    (void)fflush(stderr);
  }

  ErrorCount[severity]++;

  if ((r = (struct msg *)malloc(sizeof(struct msg))) == (struct msg *)0) {
    r = &emergency;
    (void)fprintf(stderr, "No storage for error report at");
    fail = 1;
  }
  r->loc = *source;
  r->severity = severity;
  r->Msgtext = Msgtext;
  r->grammar = grammar;

  c = reports.back; while (earlier(&r->loc,&c->loc)) c = c->back;
  r->forward = c->forward; c->forward = r;
  r->back = c; (r->forward)->back = r;


  if(ErrorLimit && ErrorCount[ERROR] > LineNum/20 +10) {
    (void)fprintf(stderr, "\"%s\", line %d:%d %s: %s",
      MapFile(source->line),
      MapLine(source->line),
      source->col,
      key[DEADLY],
      "Too many ERRORs");
    fail = 1;
  }
  if (severity == DEADLY || fail ) {
    (void)putc('\n', stderr);
#ifdef MONITOR
    _dapto_leave ("message");
#endif
    exit(1);
  }

#ifdef MONITOR
  _dapto_leave ("message");
#endif
}

struct msg emerg =
                { DEADLY, {0}, 0, "", &emerg, &emerg };

struct msg3d
       {  int           sev;
          POSITION      loc;
          CONST char   *nam;
          int           grm;
          CONST char   *txt;
          struct msg3d *forw;
          struct msg3d *back;
       };

struct msg3d emergency3d;
struct msg3d r_list =
              { DEADLY, {0}, "", 0, "", &r_list, &r_list };

#if defined(__cplusplus) || defined(__STDC__)
static void
lisedit_2d(const char *name, FILE *stream, int cutoff, int erronly)
#else
static void
lisedit_2d(name, stream, cutoff, erronly)
char *name; FILE *stream; int cutoff, erronly;
#endif
/* Output the listing with embedded error messages
 *    On entry-
 *       name is the source file name
 *       stream specifies the listing file
 *       cutoff=lowest severity level that will be listed
 *    If erronly != 0 then on exit-
 *       Source file lines containing errors have been added to file stream
 *          with error messages attached
 *    Else on exit-
 *       All source file lines have been added to file stream
 *          with error messages attached to those containing errors
 ***/
{
  register char *p;
  int           fd;
  struct msg *r;
  int           SaveErronly;

  if (name == NULL || *name == '\0') {
    (void)fprintf(stderr, "lisedit: Null source file name\n");
    exit(1);
  }
  if ( strcmp(name, NoFile)  )
  {
    if ( ((fd = open(name,0)) < 0) )
    {
        perror(name);
        exit(1);
    }
    initBuf(name, fd);
    p = TEXTSTART; LineNum = 1;
  }
  else
  {
    SaveErronly = erronly;
    erronly = 1;
  }
  /* Establish the following invariant:
   *   if no reports remain to be output then r==&reports
   *   else r addresses the earliest (in the text) report to be output
   */
  for (r = reports.forward;
       r != &reports && r->severity < cutoff;
       r = r->forward);

  while (r != &reports && MapLine(r->loc.line) == 0) {
    if (r->severity >= cutoff){
      (void)fprintf(stream, "*** %s for %s: %s\n",
                    key[r->severity], name, r->Msgtext);
    }
    do r = r->forward; while (r != &reports && r->severity < cutoff);
  }

  while (r != &reports || (!erronly && *p != 0)) {
    if (r != &reports && LineNum > MapLine(r->loc.line)) {
      /* Output reports for the last line printed */
      char buf[BUFSIZ];
      int l, s;

      (void)sprintf(buf, "*** %s for %s: %s",
                    key[r->severity], name, r->Msgtext);
      l = strlen(buf);
      s = r->loc.col - 1 + (erronly?8:0);
      if (l > s) {
        while (s--) (void)putc(' ', stream);
        (void)fprintf(stream, "^\n%s\n", buf);
      } else {
        (void)fprintf(stream, "%s", buf);
        while (l < (s--)) (void)putc('-', stream);
        (void)fprintf(stream, "^\n");
      }
      do r = r->forward; while (r != &reports && r->severity < cutoff);
    } else { /* Print up through the next line with a report */
      register char c;
      char *StartLine = p;

      while ((c = *p++) && c != '\n' && c != '\r') ;
      if (c == '\r' && *p == '\n') c = *p++;
      if (c == '\n' || c == '\r') {
        if (!erronly || LineNum == MapLine(r->loc.line)) {
          if (erronly) (void)fprintf(stream, "%6d |", LineNum);
          (void)fwrite(StartLine, p-StartLine, 1, stream);
        }
        if (*p == 0) { refillBuf(p); p = TEXTSTART; }
      } else /* c == 0 */ {
        if (erronly) (void)fprintf(stream, "%6d |", LineNum);
        (void)fputs("(End-of-file)\n", stream);
        p--;
      }
      LineNum++;
    }
  }
  (void)close(fd);
  erronly = SaveErronly;
}


#if defined(__cplusplus) || defined(__STDC__)
static int
earlierCoord(struct msg3d *p, struct msg3d *q)
#else
static int
earlierCoord(p, q)
struct msg3d *p; struct msg3d *q;
#endif
/* Check relative position
 *    On exit-
 *       earlier != 0 if p defines a position in the source Msgtext that
 *          preceeds the position defined by q
 ***/

{  int b;
   b = strcmp(p->nam, q->nam);

   if (b==0)
   {  return(p->loc.line < q->loc.line);
   } else
   { if (b<0)
     {  return(1==1);
     } else
     {  return(1==0);
     }
   }

}

#define INCLMSG ("The following text has been included from ")

#if defined(__cplusplus) || defined(__STDC__)
void
lisedit(const char *name, FILE *stream, int cutoff, int erronly)
#else
void
lisedit(name, stream, cutoff, erronly)
char *name; FILE *stream; int cutoff, erronly;
#endif
{
  char         *msgtxt;
  CONST char   *tmp_name;
  struct msg   *rep;
  struct msg   *frep;
  struct msg3d *r1;
  struct msg3d *r2;
  struct msg3d *fr;
  struct       { int         sev;
                 POSITION    loc;
                 CONST char *nam;
                 int         grm;
                 CONST char *txt;
               } tmp;



/* steps necessary
 * 0.      make sure reports is not empty
 * 1/2.    save a copy of reports.
 * 1.      copy reports to r_list
 * 2.      sort r_list on position
 * 3.      remap r_list from 2D to 3D coordinates
 * 4.      separate lists and send them through lisedit
 * 4 1/2.  restore reports
 */

/* Step 0.   Make sure reports is not empty */
if (reports.forward != &reports)
{

   /* Step 1/2. Save a copy of reports */

   /* Step 1.   Copy reports to r_list */
   /* Step 3.   Remap r_list from 2D to 3D coordinates */

     rep = reports.forward;
     while (rep != &reports)
     { /* allocate space for r1 */
        if ((r1 = (struct msg3d *)malloc(sizeof(struct msg3d))) == (struct msg3d *)0)
        {  r1 = &emergency3d;
           (void)fprintf(stderr, "No storage for copy at");
           exit(1);
        }

        /* copy relevant information from reports */
        r1->sev = rep->severity;
        r1->loc      = rep->loc;
        r1->grm  = rep->grammar;
        r1->txt  = rep->Msgtext;

        /* link the new element into r_list */
        r1->forw           = &r_list;
        r1->back           = r_list.back;
        r_list.back->forw = r1;
        r_list.back       = r1;

        /* Remap the coordinates from 2D to 3D */
        r1->nam      = MapFile(r1->loc.line);

        /* Map Line in lisedit_2d() */
        /* r1->loc.line = MapLine(r1->loc.line); */

        /* Unlink and deallocate the element copied
         * from reports, pointer ends up on the next
         * element to copy */
        rep->back->forward = rep->forward;
        rep->forward->back = rep->back;
        frep = rep;
        rep  = rep->forward;
        free(frep);
     }


   /* Step 2.   Sort r_list on Position */

     /* Set up r1 */
     r1 = r_list.forw;
     while (r1 != &r_list)
     {  /* Set up r2 */
        r2 = r1->forw;
        while (r2 != &r_list)
        {
           if (earlierCoord(r2, r1))
           {  tmp.sev = r1->sev; r1->sev = r2->sev; r2->sev = tmp.sev;
              tmp.loc = r1->loc; r1->loc = r2->loc; r2->loc = tmp.loc;
              tmp.nam = r1->nam; r1->nam = r2->nam; r2->nam = tmp.nam;
              tmp.grm = r1->grm; r1->grm = r2->grm; r2->grm = tmp.grm;
              tmp.txt = r1->txt; r1->txt = r2->txt; r2->txt = tmp.txt;
           }
           r2 = r2->forw;
        }
        r1 = r1->forw;
     }


   /* Step 4.  Separate lists and send them through lisedit */

     r1 = r_list.forw;
     while (r1 != &r_list)
     {  tmp_name = r1->nam;

        /* Build a new list based on reports        */

        /* Make one dummy node for file information */
        rep=(struct msg *)malloc(sizeof(struct msg));
        msgtxt = (char *)malloc(strlen(INCLMSG)+strlen(tmp_name)+1);
        if ( (rep == (struct msg *)0)  ||  (msgtxt == (char *)0) )
        {
          (void)fprintf(stderr,
                        "DEADLY ERROR: Storage allocation failed in lisedit()\n");
          exit(1);
        }
        sprintf(msgtxt, "%s%s", INCLMSG, tmp_name);
        rep->severity = NOTE;
        rep->loc      = NoCoord;
        rep->grammar  = r1->grm;
        rep->Msgtext  = msgtxt;

        reports.forward = rep;
        reports.back    = rep;
        rep->forward  = &reports;
        rep->back     = &reports;

        r2 = r1;

        /* Insert rest of the elements */
        while (strcmp(r2->nam, tmp_name)==0)
        {  if ((rep=(struct msg *)malloc(sizeof(struct msg))) == (struct msg *)0)
           {  rep = &emerg;
              (void)fprintf(stderr,
                            "DEADLY ERROR: Storage allocation failed in lisedit()\n");
              exit(1);
           }

           /* Copy the information */
           rep->severity = r2->sev;
           rep->loc      = r2->loc;
           rep->grammar  = r2->grm;
           rep->Msgtext  = r2->txt;

           /* Link the element into reports */
           rep->forward  = &reports;
           rep->back     = reports.back;
           reports.back->forward = rep;
           reports.back          = rep;

           r2 = r2->forw;
         }

        /* Deallocate the copied elements in r_list */
        while (r1 != r2)
        {  /* Unlink the first element of the list */
           r1->back->forw = r1->forw;
           r1->forw->back = r1->back;
           /* Deallocate and step up one step */
           fr = r1;
           r1 = r1->forw;
           free(fr);
        }

        lisedit_2d(tmp_name, stream, cutoff, erronly);

        /* Deallocate the reports sent to lisedit */
        rep = reports.forward;
        while (rep != &reports)
        {  rep->forward->back = rep->back;
           rep->back->forward = rep->forward;
           frep = rep;
           rep  = rep->forward;
           free(frep);
        }

      }

   /* Step 4 1/2. Restore reports */
 }

 }

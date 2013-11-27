#include "PtgCommon.h"


#define SQ      '\''
#define DQ      '\"'

#ifdef PROTO_OK
void CPtgOutstr(PTG_OUTPUT_FILE fs, const char *s)
#else
void CPtgOutstr(fs, s) 
        PTG_OUTPUT_FILE fs; 
        char *s;
#endif
{
        char buffer[5];
        int c;

        PTG_OUTPUT_CHAR(fs, DQ);

        while ((c = (unsigned int)(*s++) & 0377)) /*XXX*/
        {

        if (c >= '\177') 
        {
                (void)sprintf(buffer, "\\%03o", c);
                PTG_OUTPUT_STRING(fs, buffer);
        }
        else if (c == '\\') 
                PTG_OUTPUT_STRING(fs, "\\\\");
        else if (c == '"') 
                PTG_OUTPUT_STRING(fs, "\\\"");
        else if (c >= ' ') 
                PTG_OUTPUT_CHAR(fs, c);
        else switch (c) 
        {
                case '\n': PTG_OUTPUT_STRING(fs, "\\n"); break;
                case '\t': PTG_OUTPUT_STRING(fs, "\\t"); break;
                case '\b': PTG_OUTPUT_STRING(fs, "\\b"); break;
                case '\r': PTG_OUTPUT_STRING(fs, "\\r"); break;
                case '\f': PTG_OUTPUT_STRING(fs, "\\f"); break;
                default:   sprintf(buffer, "\\%03o", c); 
                           PTG_OUTPUT_STRING(fs, buffer); 
        }

        }

        PTG_OUTPUT_CHAR(fs, DQ);
}

#ifdef PROTO_OK
void CPtgOutchar (PTG_OUTPUT_FILE fs, int ch)
#else
void CPtgOutchar(fs, ch) 
        PTG_OUTPUT_FILE fs; 
        int ch;
#endif
{
        char buffer[5];
        int c;

        PTG_OUTPUT_CHAR(fs, SQ);

        if ((c = (unsigned int)(ch) & 0377)) /*XXX*/
        {

        if (c >= '\177') 
        {
                (void)sprintf(buffer, "\\%03o", c);
                PTG_OUTPUT_STRING(fs, buffer);
        }
        else if (c == '\\') 
                PTG_OUTPUT_STRING(fs, "\\\\");
        else if (c == '"') 
                PTG_OUTPUT_STRING(fs, "\\\"");
        else if (c >= ' ') 
                PTG_OUTPUT_CHAR(fs, c);
        else switch (c) 
        {
                case '\n': PTG_OUTPUT_STRING(fs, "\\n"); break;
                case '\t': PTG_OUTPUT_STRING(fs, "\\t"); break;
                case '\b': PTG_OUTPUT_STRING(fs, "\\b"); break;
                case '\r': PTG_OUTPUT_STRING(fs, "\\r"); break;
                case '\f': PTG_OUTPUT_STRING(fs, "\\f"); break;
                default:   sprintf(buffer, "\\%03o", c); 
                           PTG_OUTPUT_STRING(fs, buffer); 
        }

        }

        PTG_OUTPUT_CHAR(fs, SQ);
}


#ifdef PROTO_OK
void PPtgOutstr(PTG_OUTPUT_FILE fs, const char *s)
#else
void PPtgOutstr(fs, s) 
        PTG_OUTPUT_FILE fs; 
        char *s;
#endif
{
        int c;

        PTG_OUTPUT_CHAR(fs, SQ);

        while ((c = (unsigned int)(*s++) & 0177)) { /*XXX*/
                if (c == '\'') 
                        PTG_OUTPUT_STRING(fs, "''");
                else    PTG_OUTPUT_CHAR(fs, c);
        }

        PTG_OUTPUT_CHAR(fs, SQ);

}

#ifdef PROTO_OK
void PtgOutId (PTG_OUTPUT_FILE fs, int id)
#else
void PtgOutId (fs, id) 
        PTG_OUTPUT_FILE fs; 
        int id;
#endif
{
        PTG_OUTPUT_STRING(fs, StringTable(id));
}



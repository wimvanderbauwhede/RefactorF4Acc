
#include "err.h"
#include "csm.h"
#include "idn.h"

#define _EMPTYxIdentIDENT
#ifndef _EMPTYIDENT
#undef _EMPTYxIdentIDENT

/* identifier code is set on instantiation: */
#include "termcode.h"
#define _IDENTCODE xIdent

#else
#undef _EMPTYxIdentIDENT

/* identifier code is not set on instantiation, use default: */
#define _IDENTCODE 0

#endif

#include "MakeName.h"

#include <string.h>
#define obstack_strgrow(obs, dat) obstack_grow(obs, dat, strlen(dat))
#define obstack_strcpy(obs, dat) obstack_copy0(obs, dat, strlen(dat))


static int      num = 0;

#if defined(__STDC__) || defined(__cplusplus)
int GenerateName (char *prefix)
#else
int GenerateName (prefix) char *prefix;
#endif
{
    int newid, stored;
    int idtoken;
    char numstring[32];

    stored = numstr; /* save number of strings stored so far */
    do {
        num++;
        sprintf (numstring, "%d", num);
        obstack_strgrow(Csm_obstk, prefix);
        CsmStrPtr = (char *)obstack_strcpy(Csm_obstk, numstring);
        idtoken = _IDENTCODE;
        mkidn (CsmStrPtr, strlen (CsmStrPtr), &idtoken, &newid);
    } while (stored == numstr);

    return (newid);

}/*GenerateName*/

int
#if defined(__STDC__) || defined(__cplusplus)
MakeName (const char *str)
#else
MakeName (str) char *str;
#endif
{
    int newid, idtoken = _IDENTCODE;
    if (str)
    {
        mkidn (str, strlen (str), &idtoken, &newid);
        return (newid);
    }
    else
        return 0;
}/* MakeName */

#if defined(__STDC) || defined(__cplusplus)
int IdnNumb (int id, int num)
#else
int IdnNumb (id, num) int id, num;
#endif
{
    int newid, idtoken = _IDENTCODE;
    char numstring[32];

    sprintf (numstring, "%d", num);
    obstack_strgrow(Csm_obstk, StringTable(id));
    CsmStrPtr = (char *)obstack_strcpy(Csm_obstk, numstring);
    mkidn (CsmStrPtr, strlen (CsmStrPtr), &idtoken, &newid);
    return (newid);
}/* IdnNumb */

#if defined(__STDC) || defined(__cplusplus)
int PreIdnPost (char *pre, int id, char *post)
#else
int PreIdnPost (pre, id, post) char *pre, *post; int id;
#endif
{
    int newid, lg, idtoken = _IDENTCODE;

    obstack_strgrow(Csm_obstk, pre);
    obstack_strgrow(Csm_obstk, StringTable (id));
    CsmStrPtr = (char *)obstack_strcpy(Csm_obstk, post);
    mkidn (CsmStrPtr, strlen (CsmStrPtr), &idtoken, &newid);
    return (newid);
}/* PreIdnPost */

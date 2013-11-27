
#ifndef F77EXPR_H
#define F77EXPR_H

#ifndef ELI_ARG
#if defined(__cplusplus) || defined(__STDC__)
#define ELI_ARG(x) x
#else
#define ELI_ARG(x) ()
#endif
#endif


typedef char *(*ExecUnOpFn) ELI_ARG((char *));
typedef char *(*ExecBinOpFn) ELI_ARG((char *, char *, int));
char *NoUnOpExec ELI_ARG((char *));
char *strneg ELI_ARG((CONST char *,int));
char *strnot ELI_ARG((char *));
char *NoBinOpExec ELI_ARG((char *, char *, int));
char *stradd ELI_ARG((CONST char *, CONST char *, int));
char *strsub ELI_ARG((CONST char *, CONST char *, int));
char *strmult ELI_ARG((CONST char *, CONST char *, int));
char *strdivi ELI_ARG((CONST char *, CONST char *, int));
char *strdivf ELI_ARG((CONST char *, CONST char *, int));
char *strpow ELI_ARG((CONST char *, CONST char *, int));
char *strand ELI_ARG((char *, char *, int));
char *strior ELI_ARG((char *, char *, int));
char *streqv ELI_ARG((char *, char *, int));
char *strneq ELI_ARG((char *, char *, int));


#endif

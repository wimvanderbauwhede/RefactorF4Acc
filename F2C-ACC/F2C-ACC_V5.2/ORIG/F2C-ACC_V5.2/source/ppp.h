	/* these decls are used to handle include file processing	*/

#define MAX_MODULE_LEN 100
#define MAX_FILE_LEN 150
#define MAX_INCLUDE_FILES 500
#define MAX_MODULE_REFS 20000

typedef struct {
  int Line;
  char FileName[MAX_FILE_LEN];
} IncludeFileStruct;
IncludeFileStruct Include_Line[MAX_INCLUDE_FILES];

int Num_IncludeFiles;

typedef struct {
  char UseModuleRef[MAX_MODULE_LEN];
  char FileName[MAX_FILE_LEN];
  int Line;
  int NestLevel;
} ModuleFileStruct;
ModuleFileStruct Module_File[MAX_MODULE_REFS];

int Num_ModuleFiles;
int ModuleFileNestLevel;

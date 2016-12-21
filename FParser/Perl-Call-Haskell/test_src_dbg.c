#include <stdio.h>      /* printf, scanf, NULL */
#include <stdlib.h>
#include "ProcessStrCWrapper.h"


char* f2(char* x1) {

    char* res = f2_ffi_c(x1);
    return res;
}
        int main(int argc, char* argv[]) {

            const char* str="Hello, world!\n";
            printf("BEFORE hs_init()\n");
            hs_ProcessStr_init();
            printf("BEFORE FFI CALL\n");
            char* retstr=f2(str);
            printf("AFTER FFI CALL\n");
//            printf("BEFORE hs_exit()\n");
//            hs_exit();
            printf("%s",retstr);
//            free (str);
//            char* str1 = (char*)malloc(15);
            const char* str1="Hello, world2!\n";
//            printf("BEFORE hs_init(2)\n");
            hs_ProcessStr_init(); // Calling just hs_init() segfaults here; calling hs_ProcessStr_init() segfaults on the FFI call
            printf("BEFORE FFI CALL\n");
            char* retstr2=f2(str1);
            printf("BEFORE hs_exit()\n");
//            hs_ProcessStr_end();
            hs_exit();
            printf("%s",retstr2);
//            free (str1); // segfaults!
            return 1;
        }
    

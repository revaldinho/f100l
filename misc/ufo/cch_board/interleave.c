#include <stdio.h>
#include <stdlib.h>

#define MAX_FILES 16

void main(int argc, char *argv[]) {

   FILE *f[MAX_FILES];
   char c;

   for (int i = 1; i < argc; i++) {
      if ((f[i] = fopen(argv[i], "r")) == NULL) {
         perror(argv[i]);
         exit(1);
      }
   }

   int done;
   do {
      done = 1;
      char row[MAX_FILES];
      for (int i = 1; i < argc; i++) {
         int n = fread(&c, 1, 1, f[i]);
         if (n == 1) {
            row[i] = c;
            done = 0;
         } else {
            row[i] = 0;
         }
      }
      if (!done) {
         for (int i = argc - 1; i >= 1; i--) {
            putchar(row[i]);
         }
      }
   } while (!done);

   for (int i = 1; i < argc; i++) {
      fclose(f[i]);
   }

}

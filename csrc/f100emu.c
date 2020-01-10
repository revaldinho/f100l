#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <ctype.h>
#include <unistd.h>
#include "f100.h"

#define BUFSZ 16
#define GRPSZ 16
#define F100MEMSZ 65536

void hex16dump( uint16_t data[], int dlen, char *filename) {
  FILE *f;
  int i, j, max;
  char *astr = (char * ) malloc (2*GRPSZ + 1);
  char *dstr = (char * ) malloc (5*GRPSZ + 1);

  max = dlen + ((dlen%GRPSZ>0)?dlen + GRPSZ - dlen%GRPSZ: 0);
  if ( filename != NULL ) f = fopen(filename,"w") ;else f=stdout;
  for (i=0; i< max ; i++ ) {
    j=i%GRPSZ;
    sprintf( dstr+(j*5), "%04X ", data[i] ) ;  
    sprintf( astr+(j*2), "%c%c", INTTOPRINT((data[i]>>8)&0xFF),INTTOPRINT(data[i]&0xFF));
    if (j==GRPSZ-1) fprintf( f, "%04X: %s%s%c", i-j, dstr, astr, (i>0)?'\n':'\0');
  }
  if (f != stdout) fclose(f);
}

void read_hex_file( uint16_t *mem, char *filename, bool big_endian){
  char buf[BUFSZ];
  char hstr[BUFSZ+1];
  int n, hexn=0, i, j ;
  int first, second;
  if (big_endian) {
    first = 256;
    second = 1;
  } else {
    first = 1;
    second = 256;
  }
  
  FILE *f = fopen( filename, "rt") ;  
    while( (n=fread( buf, 1, BUFSZ, f))> 0) {
      for (i=0 ; i<n ; i++) if (ISHEXCH(buf[i])) hstr[hexn++]=buf[i];
      for (j=0; j<=hexn-4; j+=4) {
        *mem++=(HEXPAIRTOD(hstr[j],hstr[j+1])*first)+(HEXPAIRTOD(hstr[j+2],hstr[j+3])*second);
      }
      // Digits left over must be carried forward to the next line
      for (i=0; j<hexn; j++) hstr[i++] = hstr[j];
      hexn = i;
    }
    fclose(f);
}

void read_bin_file( uint16_t *mem, char *filename){
  char buf[BUFSZ+2];
  int n, j ; 
  FILE *f = fopen( filename, "rb") ;  
    while( (n=fread( buf, 1, BUFSZ-(BUFSZ%2), f))> 0) {
      for (j=0; j<=n-2; j+=2) *mem++=((buf[j]&0xFF)<<8) + (buf[j+1]&0xFF);
    }
    fclose(f);
}

void usage(){
  puts("Usage:\n   f100emu -f <filename> [-b][-m][-t][-h]");
  puts("Options:\n   -f <filename>  program file name");
  puts("   -b       program file in binary format");
  puts("   -x       program file in hex format (default)");
  puts("   -t       print logic trace");
  puts("   -m       print memory accesses");  
  puts("   -h       print this summary");
  exit(0);
}

int main (int argc, char **argv ) {
  bool     trace = false;
  bool     memtrace = false;  
  uint16_t *mem;
  cpu_t f100_cpu;
  int c;
  bool binaryNotHex=false;
  char *filename=NULL;
  opterr = 0;
  
  while ( (c=getopt(argc, argv,"bhmtxf:")) != -1 ) {
    switch(c) {
    case 'f': filename = optarg; break;
    case 'm': memtrace = true; break;
    case 't': trace = true; break;      
    case 'b': binaryNotHex = true; break;
    case 'x': binaryNotHex = false; break;
    default : usage(); break;
    }
  }    
  if ( filename==NULL) usage();
  else if ( access(filename,R_OK) == -1 ) {
    printf("Error - file %s cannot be opened for reading in read_hex_file\n", filename);
    exit(1);
  }
 
  f100_cpu = f100_init();
  if (binaryNotHex) read_bin_file(f100_cpu.mem, filename);
  else read_hex_file(f100_cpu.mem, filename, false);
  f100_trace(true);
  f100_reset(true);
  f100_exec(50000, trace, memtrace);
  if (true) hex16dump(f100_cpu.mem,0x8000,"cdump.hexl");
  return (0);
}

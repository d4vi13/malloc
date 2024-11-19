#include <stdio.h>
#include "meuAlocador.h"

struct metadata{
    long int used;
    long int size;
};

typedef struct metadata metadata, *pmetadata;
    

int main () {
  void *a, *b, *c;
  pmetadata ma, mb, mc;
  iniciaAlocador();               // Impressão esperada

//  imprimeMapa();                  // <vazio>
//
    a = (void *) alocaMem(10);
    ma = a - 16;
    printf("%ld %ld\n",ma->used, ma->size);
//  imprimeMapa();                  // ################**********
    b = (void *) alocaMem(4);
    mb = b - 16;
    printf("%ld %ld\n",mb->used, mb->size);
    c = (void *) alocaMem(8000);
    mc = c - 16;
    printf("%ld %ld\n",mc->used, mc->size);
 
//  imprimeMapa();                  // ################**********##############****
//  liberaMem(a);
//  imprimeMapa();                  // ################----------##############****
//  liberaMem(b);                   // ################----------------------------
//                                  // ou
//                                  // <vazio>
//  finalizaAlocador();
}

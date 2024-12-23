#include <stdio.h>
#include "meuAlocador.h"

struct metadata{
    long int used;
    long int size;
};

typedef struct metadata metadata, *pmetadata;
    

int main () {
  void *a, *b, *c, *d;
  pmetadata ma, mb, mc, md;
  iniciaAlocador();               // Impressão esperada

//  imprimeMapa();                  // <vazio>
//
    
/*    imprimeMapa();
    a = (void *) alocaMem(0);
    printf("a\n");
    imprimeMapa();
    printf("a\n");
    a = (void *) alocaMem(-10);
    printf("a\n");
    */
        a = (void *) alocaMem(4096);
    
    ma = a - 16;
    printf("%p %ld %ld\n",ma,ma->used, ma->size);
    printf("%p %ld %ld\n",ma,ma+ma->size +8, ma->size);

    imprimeMapa();                  // ################**********
    b = (void *) alocaMem(4);
    mb = b - 16;
    printf("%p %ld %ld\n",mb, mb->used, mb->size);
    c = (void *) alocaMem(8000);
    mc = c - 16;
    printf("%p %ld %ld\n",mc, mc->used, mc->size);
    d = (void *) alocaMem(3000);
    md = d - 16;
    liberaMem(d);
    printf("%p %ld %ld\n",md, md->used, md->size);
    d = (void *) alocaMem(500);
    md = d - 16;
    printf("%p %ld %ld\n",md, md->used, md->size);

    printf("%ld\n", mb-ma); 
    printf("%ld\n", md-mb); 
    printf("%ld\n", mc-mb); 
  imprimeMapa();                  // ################**********##############****
//  liberaMem(a);
//  imprimeMapa();                  // ################----------##############****
//  liberaMem(b);                   // ################----------------------------
//                                  // ou
//                                  // <vazio>
//  finalizaAlocador();
}

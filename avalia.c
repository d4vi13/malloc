#include <stdio.h>
#include "meuAlocador.h"

int main (long int argc, char** argv) {
  void *a,*b,*c,*d,*e;

  iniciaAlocador(); 
  imprimeMapa();
  // 0) estado inicial

  a=(void *) alocaMem(100);
  printf("1\n");
  imprimeMapa();
  b=(void *) alocaMem(130);
  printf("2\n");
  imprimeMapa();
  c=(void *) alocaMem(120);
  printf("3\n");
  imprimeMapa();
  d=(void *) alocaMem(110);
  printf("4\n");
  imprimeMapa();
  // 1) Espero ver quatro segmentos ocupados

  liberaMem(b);
  printf("5\n");
  imprimeMapa(); 
  liberaMem(d);
  printf("6\n");
  imprimeMapa(); 
  // 2) Espero ver quatro segmentos alternando
  //    ocupados e livres

  b=(void *) alocaMem(50);
  printf("7\n");
  imprimeMapa();
  d=(void *) alocaMem(90);
  printf("8\n");
  imprimeMapa();
  e=(void *) alocaMem(40);
  printf("9\n");
  imprimeMapa();
  // 3) Deduzam
	
  liberaMem(c);
  imprimeMapa(); 
  liberaMem(a);
  imprimeMapa();
  liberaMem(b);
  imprimeMapa();
  liberaMem(d);
  imprimeMapa();
  liberaMem(e);
  imprimeMapa();
   // 4) volta ao estado inicial

  finalizaAlocador();
}

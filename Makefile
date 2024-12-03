TARGET = malloc
OBJS = avalia.o gerenciador.o imprimeMapa.o proximo_bloco.o teto_divisao.o cria_bloco.o alocaBloco.o liberaMem.o alocaMem.o

LFLAGS = -dynamic-linker /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o -lc -z noexecstack 

CC = gcc
LD = ld
AS = as

all: $(OBJS) 
	$(LD) $(OBJS) -o $(TARGET) $(LFLAGS) 

avalia.o: meuAlocador.h
	$(CC) -c avalia.c


%.o: src/%.s
	$(AS) $< -o $@ -g
	
.PHONY=clean
clean:
	-rm *.o
purge:
	rm -f *.o
	rm -f $(TARGET)


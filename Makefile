TARGET = malloc
OBJS = exemplo.o gerenciador.o

LFLAGS = -dynamic-linker /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o   

CC = gcc
LD = ld
AS = as

all: $(OBJS) 
	$(LD) $(OBJS) -o $(TARGET) $(LFLAGS) 

exemplo.o: meuAlocador.h
	$(CC) -c exemplo.c

gerenciador.o: 
	$(AS) gerenciador.s -o gerenciador.o -g

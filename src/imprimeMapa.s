.section .data
    menos: .string "-"
    mais: .string "+"
    hashtag: .string "#"
    breakline: .string "\n"

.section .text
.globl imprimeMapa

imprimeMapa:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movq topoInicialHeap, %r10

// Loop responsavel por iterar sobre os blocos
while_imprime:
// Checa se nao foi iniciada
    movq topoAtualHeap, %r15
    cmpq %r10, %r15
    je out_imprime
    movq %r10, -8(%rbp)

// Loop responsavel por imprimir # que simbolizam os metadados
    movq $16, %r8
imprime_metadata:
// Checa se imprimiu 16 #
    movq $0, %r15
    cmpq %r8,%r15
    je out_imprime_metadata 

// Imprime #
    movq %r8, -16(%rbp)
    movq $hashtag, %rdi
    call printf

// Avanca
    movq -16(%rbp), %r8
    subq $1, %r8
    jmp imprime_metadata
out_imprime_metadata:

// Avalia se o bloco esta alocado ou nao, para decidir o caracter
    movq $0, %r15                                                                                                                                                                                                                                                                                                                                                                                                                         
    movq -8(%rbp), %r9
    cmpq (%r9), %r15
    je usa_str_menos
    jmp usa_str_mais

usa_str_menos:
    movq $menos, -24(%rbp)
    jmp imprime_bloco
usa_str_mais:
    movq $mais, -24(%rbp)
    jmp imprime_bloco

imprime_bloco:
// Bota em r8 o tamanho do bloco a ser impresso
    movq -8(%rbp), %r8
    movq 8(%r8), %r8
while_block:
// Checa se tudo ja foi impresso
    movq $0, %r15
    cmpq %r8, %r15
    je out_block

// Imprime o caracter
    movq %r8, -16(%rbp)
    movq -24(%rbp), %rdi
    call printf

// Avanca
    movq -16(%rbp), %r8
    subq $1, %r8
    jmp while_block
out_block:
    movq -8(%rbp), %rdi
    call proximo_bloco
    movq %rax, %r10 
    jmp while_imprime

out_imprime:

    movq $breakline, %rdi
    call printf

    addq $32, %rsp
    popq %rbp
    ret


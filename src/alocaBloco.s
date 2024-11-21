.section .text
.globl alocaBloco

alocaBloco:
    push %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    // salva endereco base
    movq %rdi, -8(%rbp) 
    // salva tamanho a ser alocado                                                                                                                                                                                                                                                                                                                                                                                                        
    movq %rsi, -16(%rbp)

    // size - requested - 16
    movq 8(%rdi), %rsi
    subq -16(%rbp), %rsi
    subq $16, %rsi

    // endereco base + requested + 16
    addq -16(%rbp), %rdi
    addq $16, %rdi

    movq $0, %rdx
    call criaBloco

    // criaBloco(enderecoBase, requested + err, True)    
    movq -8(%rbp), %rdi
    movq -16(%rbp), %rsi
    addq %rax, %rsi
    movq $1, %rdx

    call criaBloco
    addq $16, %rsp
    popq %rbp
    ret


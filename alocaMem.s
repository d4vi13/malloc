.section .text
.globl alocaMem

// r8 contem o valor a ser alocado
// r10 eh o bloco a ser avaliado
// r12 ira guardar o melhor bloco
// Aqui esta implementado first fit, deve-se trocar para best fit
alocaMem:
    pushq %rbp
    movq %rsp, %rbp
    subq $24, %rsp
    movq %rdi, -8(%rbp)
    movq topoInicialHeap, %r10
    movq %r10, bloco
    movq topoAtualHeap, %r12
while:
    movq -8(%rbp), %r8
    movq topoAtualHeap, %r15
    cmpq %r15, %r10
    je out_while

    // se alguma das condições forem ativadas va para o proximo bloco
    movq $1, %r15
    cmpq (%r10), %r15
    je next
    // r8 > 8(%r10) verificar se realmente eh isso
    cmpq %r8, 8(%r10)
    jl next

    // garante que ao achar o primeiro bloco apropriado ele eh tomado
    movq topoAtualHeap, %r15
    cmpq %r15, %r12
    je best

    movq 8(%r10), %r15
    movq 8(%r12), %r14
    cmpq %r15, %r14
    jl best
    jmp next
best:
    movq %r10, %r12
    movq %r12, bloco
    jmp next

// move r10 para o proximo bloco
next:
    movq %r10, %rdi
    call proximo_bloco
    movq %rax, %r10
    jmp while

out_while:
    movq topoAtualHeap, %r10
    cmpq %r10, %r12
    jne aloca

    movq %r10, bloco

    // teto(requested/ 4096)
    movq %r8, %rdi
    movq $4096, %rsi
    call teto_divisao

    // new = teto_divisao(requested, 4096) * 4096
    movq %rax, %r12
    imulq $4096, %r12

    // save the amount to be allocated
    movq %r12, -16(%rbp)

    // topoAtualHeap += new + 16
    addq $16, %r12
    addq %r12, topoAtualHeap

    // brk(bloco)
    movq topoAtualHeap, %rdi
    movq $12, %rax
    syscall

    movq bloco, %rdi
    movq -16(%rbp), %rsi
    movq $0, %rdx
    call criaBloco

    jmp aloca
aloca:
    movq bloco, %rdi
    movq -8(%rbp) , %rsi
    call alocaBloco
    movq bloco, %rax
    addq $16, %rax
    jmp exit

exit:
    addq $24, %rsp
    popq %rbp
    ret


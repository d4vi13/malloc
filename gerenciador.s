.section .data
    msg: .string "Topo inicial da heap: %ld\n\0" 
    printf_alloc: .string "Chamada do printf para alocação de seu buffer operacional\n"
    
.section .bss:
    .lcomm topoInicialHeap, 8
    .lcomm topoAtualHeap, 8
    .lcomm bloco, 8

.section .text
.globl iniciaAlocador, finalizaAlocador, alocaMem, liberaMem

iniciaAlocador:
    pushq %rbp
    movq %rsp, %rbp
    movq $printf_alloc, %rdi
    call printf 
    movq $0, %rdi
    movq $12, %rax
    syscall
    movq %rax, topoInicialHeap
    movq %rax, topoAtualHeap
    movq %rax, bloco
    popq %rbp
    ret     

finalizaAlocador:
    pushq %rbp
    movq %rsp, %rbp
    movq topoInicialHeap, %rdi
    movq $12, %rax
    syscall
    popq %rbp
    ret 


ceil_div:
    pushq %rbp
    movq %rsp, %rbp

    movq %rdi, %rax
    cqto
    idivq %rsi
    testq %rdx, %rdx
    jz no_remainder
    addq $1, %rax

no_remainder:
    
    popq %rbp
    ret    

criaBloco:
    pushq %rbp
    movq %rsp, %rbp
    
    movq %rsi, %rax
    imul $-1, %rax

    movq $0, %r15
    cmpq %r15, %rsi
    jle out_if

    movq %rdx, (%rdi)
    movq %rsi, 8(%rdi)
    movq $0, %rax
out_if:
    popq %rbp
    ret 

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

// r8 contem o valor a ser alocado
// r10 eh o bloco a ser avaliado
// Aqui esta implementado first fit, deve-se trocar para best fit
alocaMem:
    pushq %rbp
    movq %rsp, %rbp
    subq $24, %rsp
    movq %rdi, -8(%rbp)
    movq topoInicialHeap, %r10
    movq %r10, bloco
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

    // bloco eh adequado 
    movq %r10, bloco
    jmp aloca

// move r10 para o proximo bloco
next:
    movq %r10, %r9
    addq 8(%r9), %r10
    addq $16, %r10
    jmp while 

out_while:
    movq topoAtualHeap, %r10
    movq %r10, bloco
    
    // teto(requested/ 4096)
    movq %r8, %rdi
    movq $4096, %rsi
    call ceil_div 
    
    // new = ceil_div(requested, 4096) * 4096
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

liberaMem:



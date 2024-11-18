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

criaBloco:
    pushq %rbp
    movq %rsp, %rbp
    movq %rdx, (%rdi)
    movq %rsi, 8(%rdi)
    popq %rbp
    ret 

alocaBloco:
    push %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq %rdi, -8(%rbp) // salva endereco base
    movq %rsi, -16(%rbp) // salva tamanho a ser alocado 

    // size - requested - 16
    movq 8(%rdi), %rsi
    subq -16(%rbp), %rsi
    subq $16, %rsi

    // endereco base + requested + 16
    addq %rsi, %rdi
    addq $16, %rdi
   
    movq $0, %rdx 
    call criaBloco

    // criaBloco(enderecoBase, requested + err, True)    
    movq -8(%rbp), %rdi 
    movq -16(%rbp), %rsi
    addq %rax, %rsi
    movq $1, %rdx

    call criaBloco 

// r8 contem o valor a ser alocado
// r10 eh o bloco a ser avaliado
// Aqui esta implementado first fit, deve-se trocar para best fit
alocaMem:
    pushq %rbp
    movq %rsp, %rbp
    subq $24, %rsp
    movq %rdi, -8(%rbp)
    movq topoInicialHeap, %r10
    movq topoInicialHeap, bloco
while: 
    movq -8(%rbp), %r8
    cmpq topoAtualHeap, %r10
    je out_while

    // se alguma das condições forem ativadas va para o proximo bloco
    cmpq (%r10), 1
    je next
    // r8 > 8(%r10) verificar se realmente eh isso
    cmpq %r8 8(%r10)
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
    movq topoAtualHeap, bloco
    movq topoAtualHeap, %r10
    
    // teto(requested/ 4096)
    movq %r8, %rdi
    movq $4096, %rsi
    call ceil_div 
    
    // new = ceil_div(requested, 4096) * 4096
    movq %rax, %r12
    mult $4096, %r12

    // topoAtualHeap += new + 16
    addq $16, %r12
    addq %r12, topoAtualHeap 

    // brk(bloco)
    movq topoAtualHeap, %rdi
    movq $12, %rax
    syscall

    jmp aloca
aloca:    
    movq bloco, %rdi
    movq -8(%rbp) , %rsi
    call alocaBloco
    jmp exit

exit:
    addq $24, %rsp
    popq %rbp
    ret    

liberaMem:



.section .data
    msg: .string "Topo inicial da heap: %ld\n\0" 
    printf_alloc: .string "Chamada do printf para alocação de seu buffer operacional\n"
    
.section .bss:
    .comm topoInicialHeap, 8
    .comm topoAtualHeap, 8
    .comm bloco, 8

.section .text
.globl iniciaAlocador, finalizaAlocador 

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


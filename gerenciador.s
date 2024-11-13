.section .data
    msg: .string "Topo inicial da heap: %ld\n\0" 
    printf_alloc: .string "Chamada do printf para alocação de seu buffer operacional\n"
    num: .quad 5

.section .bss:
    .lcomm topoInicialHeap, 8

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
    popq %rbp
    ret     

finalizaAlocador:
    pushq %rbp
    movq %rsp, %rbp
    movq $topoInicialHeap, %rdi
    movq $12, %rax
    syscall
    popq %rbp
    ret 


alocaMem:

liberaMem:



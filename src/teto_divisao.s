.section .text
.globl teto_divisao

teto_divisao:
    pushq %rbp
    movq %rsp, %rbp                                                                                                                                                       

    movq %rdi, %rax
    cqto
    idivq %rsi
    testq %rdx, %rdx
    jz sem_resto
    addq $1, %rax

sem_resto:
    popq %rbp
    ret


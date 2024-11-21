.section .text
.globl criaBloco

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



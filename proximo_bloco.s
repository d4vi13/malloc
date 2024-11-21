.section .text
.globl proximo_bloco

proximo_bloco:
    pushq %rbp
    movq %rsp, %rbp
    movq %rdi, %rax
    addq 8(%rdi), %rax
    addq $16, %rax
    popq %rbp
    ret

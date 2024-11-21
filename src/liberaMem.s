.section .text
.globl liberaMem

liberaMem:
    pushq %rbp
    movq %rsp, %rbp

    movq $0, -16(%rdi)

    popq %rbp
    ret      

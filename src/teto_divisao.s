.section .text
.globl teto_divisao

teto_divisao:
    pushq %rbp
    movq %rsp, %rbp                                                                                                                                                       
    // move valor para rax e extende sinal para octal
    movq %rdi, %rax
    cqto
    
    // divide rdi/rsi
    idivq %rsi 
   
    // rdx contem resto, ve se tem resto  
    movq $0, %rdi
    cmpq %rdx, %rdi
    je sem_resto
    addq $1, %rax

sem_resto:
    popq %rbp
    ret


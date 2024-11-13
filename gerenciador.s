.section .data
    msg: .string "Topo inicial da heap: %ld\n\0" 
    printf_alloc: .string "Chamada do printf para alocação de seu buffer operacional\n"
    num: .quad 5

.section .bss:
    .lcomm topoInicialHeap, 8
    .lcomm topoAtualHeap, 8

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

// r8 contem o valor a ser alocado
// r10 eh o bloco a ser avaliado
alocaMem:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq %rdi, -8(%rbp)
    movq topoInicialHeap, %r10
while: 
    movq -8(%rbp), %r8
    cmpq topoAtualHeap, %r10
    je out
    cmpq (%r10), 1
    jne aloca
    // r8 <= 8(%r10) verificar se realmente eh isso
    cmpq %r8 8(%r10)
    jge aloca
    movq %r10, %r9
    addq 8(%r10), %r9
    addq $16, %r9
    movq %r9, %r10
    jmp while 
aloca:    
    # salva o bloco para alocar dps
    movq %r10, -16(%rbp)
    # primeiro parametro block + requested + 16
    movq %r10, %rdi
    addq %r8, %rdi
    addq $16, %rdi
    # segundo parametro block->size - requested - 16
    movq 8(%r10), %rsi
    subq %r8, %rsi
    subq $16, %rsi
    call criaBloco
    #restaura r10 e r8
    movq -16(%rbp), %r10 
    movq -8(%rbp), %r8 
    movq %r10, %rdi
    # tamanho do bloco, mais um possivel retornado da criaBloco
    movq %r8, %rsi
    addq %rax, %rsi  
    # deve botar em rax o ponteiro certo
    call alocaBloco
    jmp out
out:
    

liberaMem:



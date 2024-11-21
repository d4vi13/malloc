.section .data
    menos: .string "-"
    mais: .string "+"
    hashtag: .string "#"

.section .text
.globl imprimeMapa

imprimeMapa:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movq topoInicialHeap, %r10
while_imprime:
    movq topoAtualHeap, %r15
    cmpq %r10, %r15
    je out_imprime
    movq %r10, -8(%rbp)

    movq $16, %r8
for_metadata:
    movq $0, %r15
    cmpq %r8,%r15
    je out_for
    movq %r8, -16(%rbp)
    movq $hashtag, %rdi
    call printf
    movq -16(%rbp), %r8
    subq $1, %r8
    jmp for_metadata
out_for:

    movq $0, %r15                                                                                                                                                                                                                                                                                                                                                                                                                         
    movq -8(%rbp), %r9
    cmpq (%r9), %r15
    je usa_str_menos
    jmp usa_str_mais

usa_str_menos:
    movq $menos, -24(%rbp)
    jmp imprime_bloco
usa_str_mais:
    movq $mais, -24(%rbp)
    jmp imprime_bloco

imprime_bloco:
    movq -8(%rbp), %r8
    movq 8(%r8), %r8
while_block:
    movq $0, %r15
    cmpq %r8, %r15
    je out_block
    movq %r8, -16(%rbp)
    movq -24(%rbp), %rdi
    call printf
    movq -16(%rbp), %r8
    subq $1, %r8
    jmp while_block
out_block:
    movq -8(%rbp), %r9
    addq 8(%r9), %r10
    addq $16, %r10
    jmp while_imprime

out_imprime:

    addq $32, %rsp
    popq %rbp
    ret


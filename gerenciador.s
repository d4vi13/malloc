.intel_syntax noprefix
.section .data
    msg: .string "Topo inicial da heap: %ld\n\0" 
    num: .quad 5
#.section .bss
#   .lcomm topoInicialHeap 8 

.section .text
.globl main, iniciaAlocador, finalizaAlocador, alocaMem, liberaMem

main:
    push rbp
    mov rbp, rsp

    mov rdi, msg
    mov rax, [num]
    mov rsi, rax
    call printf 

    pop rbp
    ret

finalizaAlocador:

alocaMem:

liberaMem:



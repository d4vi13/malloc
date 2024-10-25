.intel_syntax noprefix
.section .data
    msg: .string "Topoo inicial da heap: %lld\n"
.section .bss
    .lcomm topoInicialHeap 8 

.section .text
.globl main, iniciaAlocador, finalizaAlocador, alocaMem, liberaMem

main:#iniciaAlocador:
    mov rsi, topoInicialHeap 
    mov rdi, qword ptr [msg]
    call printf 

finalizaAlocador:

alocaMem:

liberaMem:



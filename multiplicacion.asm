.text
.globl __start
__start:
    li $t4, -1
    li $v0, 4
    la $a0, prmp01
    syscall
    li $v0, 5
    syscall
    addi $t0, $v0, 0

    li $v0, 4
    la $a0, prmp02
    syscall
    li $v0, 5
    syscall
    addi $t1, $v0, 0
    mult $t0, $t1
    mflo $t2
    mfhi $t3
    bltz $t2, negativo
    beq $t3, $zero, sisepuede
    j nosepuede
negativo:
    beq $t3, $t4, sisepuede
    j nosepuede
sisepuede:
    li $v0, 4
    la $a0, sicabe
    syscall
    li $v0, 1
    addi $a0, $t2, 0
    syscall
    j fin
nosepuede:
    li $v0, 4
    la $a0, nocabe
    syscall
fin:
    li $v0, 10
    syscall
.data
    nocabe: .asciiz "No se puede representar en 32b"
    sicabe: .asciiz "Si se puede representar, el valor es: "
    prmp01: .asciiz "factor 01:"
    prmp02: .asciiz "factor 02:"

.text
.globl __start
__start:
    # Carga -1 para comparación
    li $t4, -1

    # Lee factor 01 (dividendo)
    li $v0, 4
    la $a0, prmp01
    syscall
    li $v0, 5
    syscall
    move $t0, $v0

    # Lee factor 02 (divisor)
    li $v0, 4
    la $a0, prmp02
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Verifica división por cero
    beq $t1, $zero, div_cero

    # Realiza la división (con signo)
    div $t0, $t1
    mflo $t2  # Cociente
    mfhi $t3  # Resto

    # Verifica si el cociente cabe en 32 bits
    # Rango: -2^31 a 2^31 - 1
    # Caso especial: Si dividendo = -2^31 y divisor = -1, cociente = 2^31 (desborda)
    li $t5, -2147483648  # -2^31
    li $t6, 2147483647   # 2^31 - 1
    beq $t0, $t5, check_special  # Si dividendo = -2^31
    j check_range

check_special:
    beq $t1, $t4, nosepuede  # Si divisor = -1, cociente = 2^31 (desborda)

check_range:
    blt $t2, $t5, nosepuede  # Si cociente < -2^31
    bgt $t2, $t6, nosepuede  # Si cociente > 2^31 - 1
    j sisepuede

div_cero:
    li $v0, 4
    la $a0, div_error
    syscall
    j fin

sisepuede:
    li $v0, 4
    la $a0, sicabe
    syscall
    li $v0, 1
    move $a0, $t2
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
    nocabe: .asciiz "No se puede representar en 32b\n"
    sicabe: .asciiz "Si se puede representar, el valor es: "
    prmp01: .asciiz "dividendo: "
    prmp02: .asciiz "divisor: "
    div_error: .asciiz "Error: división por cero\n"

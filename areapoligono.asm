.text
.globl __start
__start:
li $s0,5        #Número de vertices
li $t0,4        #Constante para cargar las "y"
li $t8,0	#Registro donde acumulamos las sumas
li $t9,0	#Registro donde acumulamos las restas
li $t5,2	#Constante para dividir mi resultado


#Sumas
lw $t1,p1	#Cargamos x1
lw $t2,p2($t0)	#Cargamos y2
mul $t3,$t1,$t2	#Multiplicamos x1 con y2
add $t8,$t8,$t3	#Acumulamos la multiplicación

lw $t1,p2	#Cargamos x2
lw $t2,p3($t0)	#Cargamos y3
mul $t3,$t1,$t2	#Multiplicamos x2 con y3
add $t8,$t8,$t3	#Acumulamos la multiplicación

lw $t1,p3	#Cargamos x3
lw $t2,p4($t0)	#Cargamos y4
mul $t3,$t1,$t2	#Multiplicamos x3 con y4
add $t8,$t8,$t3	#Acumulamos la multiplicación

lw $t1,p4	#Cargamos x4
lw $t2,p5($t0)	#Cargamos y5
mul $t3,$t1,$t2	#Multiplicamos x4 con y5
add $t8,$t8,$t3	#Acumulamos la multiplicación

lw $t1,p5	#Cargamos x5
lw $t2,p1($t0)	#Cargamos y1
mul $t3,$t1,$t2	#Multiplicamos x5 con y1
add $t8,$t8,$t3	#Acumulamos la multiplicación


#Restas
lw $t1,p2	#Cargamos x2
lw $t2,p1($t0)	#Cargamos y1
mul $t3,$t1,$t2	#Multiplicamos x2 con y1
add $t9,$t9,$t3	#Acumulamos la multiplicación

lw $t1,p3	#Cargamos x3
lw $t2,p2($t0)	#Cargamos y2
mul $t3,$t1,$t2	#Multiplicamos x3 con y2
add $t9,$t9,$t3	#Acumulamos la multiplicación

lw $t1,p4	#Cargamos x4
lw $t2,p3($t0)	#Cargamos y3
mul $t3,$t1,$t2	#Multiplicamos x4 con y3
add $t9,$t9,$t3	#Acumulamos la multiplicación

lw $t1,p5	#Cargamos x5
lw $t2,p4($t0)	#Cargamos y4
mul $t3,$t1,$t2	#Multiplicamos x5 con y4
add $t9,$t9,$t3	#Acumulamos la multiplicación

lw $t1,p1	#Cargamos x1
lw $t2,p5($t0)	#Cargamos y5
mul $t3,$t1,$t2	#Multiplicamos x1 con y5
add $t9,$t9,$t3	#Acumulamos la multiplicación

#Resta y valor absoluto
sub $t4,$t8,$t9	#Restamos los terminos
abs $t4,$t4	#Sacamos el valor absoluto de ete resultado


#División
mtc1 $t4,$f8	#Pasamos nuestro número al registro de los flotantes para dividirlo
mtc1 $t5,$f9	#Pasamos nuestro divisor al registro de los flotantes
cvt.s.w $f8,$f8 #Convertimos nuestro número en flotante
cvt.s.w $f9,$f9	#Convertimos nuestro divisor en flotante
div.s $f12,$f8,$f9#dividimos nuestro resultado entre 2
li $v0,2	#Preparamos nuestro syscall para imprimir un flotante
syscall 	#Imprimimos nuestro resultado total

#Fin del programa
li $v0,10	#Preparamos nuestro syscall para finalizar el programa
syscall 	# servicio de finalizar programa


.data
p1: .word 2,0 	# que define (x1, y1)
p2: .word 4,5 	# que define (x2, y2)
p3: .word 20,10 # que define (x3, y3)
p4: .word 10,3	# que define (x4, y4)
p5: .word 5,2 	# que define (x5, y5)

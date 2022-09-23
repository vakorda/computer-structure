
#1 Exercise #####################################################################################################################################
.data
msg: .string "My first program"
.text
.globl main
main:
 li a7, 1
 la a0, msg
 ecall
 jr ra

#2 exercise #####################################################################################################################################
"code in high level"
int a = 6;
int b = 7;
int c = 3;
int d;
d = (a+b) * (a+b);
"code in assembly"
.data
	a: .byte 6
	b: .byte 7
	c: .byte 3
	d: .byte 0
.text
main:
	li t0 6 #a
	li t1 7	#b
	li t2 3 #c
	
	add t3 t0 t1 #t3 = a+b
	mul t4 t3 t3 #t4 = t3 * t3 = (a+b) * (a+b)
#3 exercise ######################################################################################################################################
.text
main:
	li a0 0
	li t0 100
	li t2 1
bucle: bgt t2 t0 fin
	add a0 a0 t2 
	addi t2 t2 1
	j bucle

fin:
	li a7 1
	ecall
#4 exercise ######################################################################################################################################
.text
main:
	li t1 7
	li t2 3
	
	if_1: bgt t1 t2 continue
	mv t0 t1 #t0 = t1
	mv t1 t2 #t1 = t2
	mv t2 t0 #t2 = t0

continue:
	rem t0 t1 t2 # t0 = t1 % t3
	bnez t0 fin_2  # if 
	li a0 0
	j fin
	
fin:
  li a0 1

fin_2:
	li a7 1
  ecall
#5 exercise ######################################################################################################################################
.text
main:
	li t0 8
	li t1 0
	li a0 0
	li a7 1

bucle_1: beq t1 t0 fin
	addi t1 t1 1
	li a7 11
	li a0 10
	ecall
	li a0 0
	j bucle_2

bucle_2: beq a0 t1 bucle_1
	addi a0 a0 1
	li a7 1
	ecall
	j bucle_2


fin:
	li a7 1
	li a7 10 
	ecall
#6 exercise ######################################################################################################################################
.text
main:
	li t1 7
	li t2 3
	li a7 1

if_1: bgt t1 t2 continue
	mv a0 t2
	ecall
	li a7 10
	ecall

continue:
	mv a0 t1
	ecall
#7 exercise ######################################################################################################################################
.data
	even: .string "E"
	odd: .string "O"
.text
main:
	li t1 10
	li t2 2
	li a7 11
	rem t3 t1 t2
	beqz t3 even1
	j odd1

even1:
	la t0 even
  lbu t1 0(t0)
	mv a0 t1
  ecall
	li a7 10
	ecall
odd1:
	la t0 odd
  lbu t1 0(t0)
	mv a0 t1
	ecall

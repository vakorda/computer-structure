.data
   stored_key: .string "one"
   user_key: .string "Please insert password:" # Necessary so that the next message appears below
.text
main:
	jal ra study_energy
    
    li a7 10 # exit
    ecall

study_energy:
	# saving ra
	sw ra 0(sp)
    addi sp sp -4

    li t4 0
	li t5 26
    li a3 'a'
loop2: bge t4 t5 end2
  	sb a3 0(sp)
  	sb x0 1(sp)
	mv a2 sp
    rdcycle t1
    li a7 11
    ecall
    jal ra string_compare
  
    mv a0 a3
	rdcycle t6
    sub t6 t6 t1
	mv a0 t6
	li a7 1
	ecall
	li a7 11
	li a0 10
	ecall
    addi a3 a3 1
    addi t4 t4 1
    j loop2
end2:
    addi sp sp 4
    lw ra 0(sp)
	jr ra

string_compare:
    la t0 stored_key #Argument 1 = adress 1
    lbu t2 0(t0) # a = char11
    lbu t3 0(a2) # b = char12

buc1: beqz t2 try #if t2 is equal to 0, we check if t3 is also equal
    bne t2 t3 not_eq # if a[n] != b[n] -> not eq
    addi t0 t0 1 # Address1 + 1
    addi a2 a2 1 # Address2 + 1
    lbu t2 0(t0) # reset value of the addresses
    lbu t3 0(a2)
    j buc1

try: bnez t3 not_eq # and if t3 is also equal, both words have the same length so its the same word
	li a0 1 #its the same word, so 1
    jr ra
not_eq:
    li a0 0 #different words, so 0
    jr ra

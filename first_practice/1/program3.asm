.data
   stored_key: .string "hola"
   .align 2
   dummy: .zero 9
.text

# string_compare: a0, a1, a2,   ,   ,   ,   ,   ,   , t2, t3,   ,   ,
# study_energy:   a0,   , a2, a3,   ,   ,   ,   , t1,   ,   ,   ,   ,
# loop_1:         a0,   ,   , a3,   ,   ,   , a7,   ,   ,   ,   , t5,
# total:          a0, a1, a2, a3,   ,   ,   , a7, t1, t2, t3,   , t5,
# free:             ,   ,   ,   , a4, a5, a6,   ,   ,   ,   , t4,   , t6

main:
	la a0 stored_key #Argument 1 = saved password
	la a1 dummy # dummy
    jal ra attack
    li a7 10 # end
    ecall
    
attack:
	addi sp sp -4
	sw ra 0(sp)
	
initialize_cycle:
    li a2 'a' # first char on the alphabet
    li t0 26 # number of letters on the alphabet
    
    # study energy for zero
    sb x0 0(sp)
    mv a3 sp
    jal ra study_energy # a3 = letter to study energy for -> a0
    # save # cycles for 0 in t1
    mv t1 t3
    
loop_1: blez t0 end
    sb a2 0(sp)
    sb x0 1(sp)
    
    mv a3 sp
    
    jal ra study_energy 
    
    bgt a4 t1 update_letter
     
    addi a2 a2 1 # next char
    addi t0 t0 -1 # lower counter
    j loop_1
	
update_letter:
	sb a2 0(a1)
    addi a1 a1 1
    j initialize_cycle

end:
	# adds final 0
	sb x0 0(a1)
	lw ra 0(sp)
    addi sp sp 4
	jr ra



study_energy:
	addi sp sp -4
	# save ra
    sw ra 0(sp)
    # go to prev
    
    
    rdcycle t2
    jal ra string_compare # a2 = Address1 -> a0
    rdcycle a4
    sub a4 a4 t2
    
    # restore previous ra
    lw ra 0(sp)
    addi sp sp 4
    jr ra


string_compare:
    lbu t4 0(a0) # a = char11
    lbu t5 0(a3) # b = char12

buc1: beqz t4 exit_string_compare #if t2 is equal to 0, we check if t3 is also equal
    bne t4 t5 exit_string_compare # if a[n] != b[n] -> not eq
    addi a0 a0 1 # Address1 + 1
    addi a3 a3 1 # Address2 + 1
    lbu t4 0(a0) # reset value of the addresses
    lbu t5 0(a3)
    j buc1

exit_string_compare: jr ra

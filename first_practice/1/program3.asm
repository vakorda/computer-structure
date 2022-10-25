.data
   stored_key: .string "password"
   .align 2
   dummy: .zero 9
.text

# string_compare: a0, a1, a2,   ,   ,   ,   ,   ,   , t2, t3,   ,   ,
# study_energy:   a0,   , a2, a3,   ,   ,   ,   , t1,   ,   ,   ,   ,
# loop_1:         a0,   ,   , a3,   ,   ,   , a7,   ,   ,   ,   , t5,
# total:          a0, a1, a2, a3,   ,   ,   , a7, t1, t2, t3,   , t5,
# free:             ,   ,   ,   , a4, a5, a6,   ,   ,   ,   , t4,   , t6

main:
	la a1 stored_key #Argument 1 = saved password
	la a4 dummy #cracked passsword
    jal ra attack
    li a7 10 # end
    ecall
    
attack:
	sw ra 0(sp)

point_1:
    li a3 'a' # first char on the alphabet
    li t5 26 # number of letters on the alphabet
    
    # study energy for zero
    sb x0 0(sp)
    mv a2 sp
    jal ra study_energy # a3 = letter to study energy for -> a0
    # save # cycles for 0 in t4
    mv t4 a0
    
loop_1: beqz t5 end
	mv a0 a3 # print char
    li a7 11
    ecall
    # save char in the stack
    
    sb a3 0(sp)
    sb x0 1(sp)
    
    mv a2 sp
    
    jal ra study_energy # a3 = letter to study energy for -> a0
    
    li a7 1 # print cycles
    ecall
    
    bgt a0 t4 update_letter
    
    li a7 11 # go to next line
    li a0 10
    ecall
     
    addi a3 a3 1 # next char
    addi t5 t5 -1 # lower counter
    j loop_1
	
    
end:
	sb x0 0(a4)
	lw ra 0(sp)
	jr ra

update_letter:
	sb a3 0(a4)
    addi a4 a4 1
    j point_1

study_energy:
	addi sp sp -4
	# save ra
    sw ra 0(sp)
    # go to prev
    
    
    rdcycle t1
    jal ra string_compare # a2 = Address1 -> a0
    rdcycle a0
    sub a0 a0 t1
    
    # restore previous ra
    lw ra 0(sp)
    addi sp sp 4
    jr ra


string_compare:
    
    lbu t2 0(a1) # a = char11
    lbu t3 0(a2) # b = char12

buc1: beqz t2 try #if t2 is equal to 0, we check if t3 is also equal
    bne t2 t3 not_eq # if a[n] != b[n] -> not eq
    addi a1 a1 1 # Address1 + 1
    addi a2 a2 1 # Address2 + 1
    lbu t2 0(a1) # reset value of the addresses
    lbu t3 0(a2)
    j buc1

try: bnez t3 not_eq # and if t3 is also equal, both words have the same length so its the same word
	li a0 1 # its the same word, so 1
    jr ra
not_eq:
    li a0 0 # different words, so 0
    jr ra

.data
   stored_key: .string "one"
   user_key: .string "Please insert password:" # Necessary so that the next message appears below
   valid_msg: .string "Valid"
   no_valid_msg: .string "Invalid"
.text
main:
	jal ra study_energy
  li a7 10
  ecall
 
string_compare:
    la t0 stored_key #Argument 1 = adress 1
    lbu t2 0(t0) # char1 = str1[1]
    lbu t3 0(a2) # char2 = str2[1]

    buc1: beqz t2 end # if char1 == 0: -> try(t3 == 0) if t2 is equal to 0, we check if t3 is also equal
        bne t2 t3 end # if char1 != char2 -> print no
        addi t0 t0 1 # Address1 + 1
        addi a2 a2 1 # Address2 + 1
        lbu t2 0(t0) # move to next char
        lbu t3 0(a2)
        j buc1								# else: print_no; if not, one word is longer so they arent equal		

    end:
    	mv a0 a3
    	li a7 11
         ecall
		jr ra

study_energy:
	mv fp sp
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
  jal ra string_compare
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
  lw ra 0(fp)
	jr ra

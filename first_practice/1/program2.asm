..data
   stored_key: .string "one"
   user_key: .string "Please insert password:
" # Necessary so that the next message appears below
   valid_msg: .string "Valid"
   no_valid_msg: .string "Invalid"
.text
main:
    # read string from the user (only loads 4 bytes)
    # compare strings
    # print if they are correct
    
	la a0 user_key # load str(user_key)
    li a1 4 # a1 = length of the user_key string (stored_key length + 1) in case they put the wrong key
    
    li a7 4
    ecall  # print("Please insert password")
     
    li a7 8
    ecall  # read password

	la a2 stored_key # Argument 1 = adress 1
    mv a3 a0         # Argument 2 = user_key
 	jal ra string_compare # a2 = adress1, a3 = adress2 -> a0 = return
 	
    # Print message
    li a7 4
    ecall

    li a7 10 # exit
    ecall
string_compare:
    lbu t2 0(a2) # char1 = str1[1]
    lbu t3 0(a3) # char2 = str2[1]

  buc1: beqz t2 try # if char1 == 0: -> try(t3 == 0) if t2 is equal to 0, we check if t3 is also equal
        bne t2 t3 print_no # if char1 != char2 -> print no
        addi a2 a2 1 # Address1 + 1
        addi a3 a3 1 # Address2 + 1
        lbu t2 0(a2) # move to next char
        lbu t3 0(a3)
        j buc1
        
   try: bnez t3 print_no # if buc1(char1 == 0) and char2 == 0: print_yes; and if t3 is also equal, both words have the same length so its the same word
        la a0 valid_msg
        jr ra
print_no:
        la a0 no_valid_msg
    	jr ra

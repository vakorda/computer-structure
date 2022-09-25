.data
 stored_key: .string "one"
 user_key: .string "Please insert password"
 valid_msg: .string "Valid"
 no_valid_msg: .string "Invalid"
.text
main:

# read the user key from keyboard and store in user_key
# call to string_compare(stored_key, user_key)
# with the correct arguments
		la a0 user_key # load str(user_key)
    li a1 4 # a1 = length of the user_key string (stored_key length + 1) in case they put the wrong key
    
    li a7 4
    ecall  # print("Please insert password")
     
    li a7 8
    ecall  # read password

    mv t1 a0 # Adress2 = user_key
 	jal ra string_compare ############
 
print_message:
 		beqz a0 print_no # if result == 0: print(no_valid_msg)
 		j print_yes			 # else: print(valid_msg)
 
string_compare:
    la t0 stored_key #Argument 1 = adress 1
    lbu t2 0(t0) # char1 = str1[1]
    lbu t3 0(t1) # char2 = str2[1]

buc1: beqz t2 try # if char1 == 0: -> try(t3 == 0) if t2 is equal to 0, we check if t3 is also equal
    bne t2 t3 not_eq # if char1 != char2 -> not eq
    addi t0 t0 1 # Address1 + 1
    addi t1 t1 1 # Address2 + 1
    lbu t2 0(t0) # move to next char
    lbu t3 0(t1)
    j buc1
try:
		beqz t3 yes # if buc1(char1 == 0) and char2 == 0: and if t3 is also equal, both words have the same length so its the same word
		j not_eq    # else: if not, one word is longer so they arent equal
yes: 
		li a7 1 #read int
  	li a0 1 #its the same word, so 1
  	j print_message
not_eq:
		li a7 1
  	li a0 0 #different words, so 0
  	j print_message
    
print_yes: la a0 valid_msg
 		j end
print_no: la a0 no_valid_msg
 		j end
end: li a7 4
 		ecall

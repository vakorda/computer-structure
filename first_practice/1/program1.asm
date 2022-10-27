.data
  .align 2
    string1: .string "ayer"
    string2: .string "aye"

.text
main:
    la a1 string1 # adress1 = string1
    la a2 string2 # adress2 = string2
	
    jal ra string_compare # a1 = adress1, a2 = adress2 -> return = a0
    
    # print to test
    li a7 1
    ecall
    
    li a7 10 #exit
    ecall
string_compare: # a1 = adress1, a2 = adress2 -> return[1, 0, -1] = a0
    lbu t2 0(a1) # char1 = adress1[0]
    lbu t3 0(a2) # char2 = adress2[0]
    
    # if char1 == 0 and char2 == 0: error
    bnez t2 buc1 
    beqz t3 error

buc1: beqz t2 try # if char1 == 0 -> check if char2 == 0
    bne t2 t3 not_eq # if char1 != char2 -> not eq
    addi a1 a1 1 # address1 + 1
    addi a2 a2 1 # address2 + 1
    lbu t2 0(a1) # set next char into registers
    lbu t3 0(a2)
    j buc1

try: bnez t3 not_eq # char2 also == 0: both words have the same length and characters -> return 1
    li a0 1 # its the same word, so 1
    jr ra
not_eq:
    li a0 0 # different words -> return 0
    jr ra
error:
    li a0 -1 # both words 0 -> return -1
    jr ra

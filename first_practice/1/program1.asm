.data
  .align 2
    string1: .string ""
    string2: .string ""

.text
main:
    la a0 string1 # string1 = adress 1
    la a1 string2 # string2 = adress 2
	
    jal ra string_compare # a0 = adress1, a1 = adress2 -> return = a0
    
    # print to test
    li a7 1
    ecall
    
    li a7 10 #exit
    ecall
string_compare: # a0 = adress1, a1 = adress2 -> return[1, 0, -1] = a0
    lbu t0 0(a0) # char1 = adress1[0]
    lbu t1 0(a1) # char2 = adress2[0]
    
    # if char1 == 0 and char2 == 0: error
    bnez t0 buc1 
    beqz t1 error

buc1: beqz t0 try # if char1 == 0 -> check if char2 == 0
    bne t0 t1 not_eq # if char1 != char2 -> not eq
    addi a0 a0 1 # address1 + 1
    addi a1 a1 1 # address2 + 1
    lbu t0 0(a0) # set next char into registers
    lbu t1 0(a1)
    j buc1

try: bnez t1 not_eq # char2 also == 0: both words have the same length and characters -> return 1
    li a0 1 # its the same word, so 1
    jr ra
not_eq:
    li a0 0 # different words -> return 0
    jr ra
error:
    li a0 -1 # both words 0 -> return -1
    jr ra

.data
  .align 2
    string1: .string "holar"
    string2: .string "holas"

.text
main:
    la a1 string1 #Argument 1 = adress 1
    la a2 string2 #Argument 2 = adress 2
	
    jal ra string_compare # a1 = adress1, a2 = adress2 -> a0 = return
    
    # print to test
    li a7 1 #print int
    ecall
    
    li a7 10 #exit
    ecall
string_compare:
    lbu t2 0(a1) # a = char11
    lbu t3 0(a2) # b = char12
    
    # if t2 == 0 and t3 == 0: error
    bnez t2 buc1 
    beqz t3 error

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
error:
    li a0 -1 # both words 0, so -1
    jr ra

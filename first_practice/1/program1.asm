.data
  .align 2
    string1: .string "holar"
    string2: .string "holas"

.text
main:
	la a2 string1 #Argument 1 = adress 1
    la a3 string2 #Argument 2 = adress 2
	
    jal ra string_compare # a2 = adress1, a3 = adress2 -> a0 = return
    
    # print to test
    li a7 1 #print int
    ecall
    
    li a7 10 #exit
    ecall
string_compare:
    lbu t2 0(a2) # a = char11
    lbu t3 0(a3) # b = char12

buc1: beqz t2 try # if t2 == 0, we check t3 == 0
    bne t2 t3 not_eq # if a[n] != b[n] -> not eq
    addi a2 a2 1 # Address1 + 1
    addi a3 a3 1 # Address2 + 1
    lbu t2 0(a2) # load new characters
    lbu t3 0(a3)
    j buc1

try: beqz t3 yes # if t3 also == 0, both words have the same length and charachters
	# t3 != 0 one word is longer so they arent equal -> not_eq
not_eq:
    li a0 0 #different words, so 0
    jr ra
yes: 
    li a0 1 #its the same word, so 1
    jr ra

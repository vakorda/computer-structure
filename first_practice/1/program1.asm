.data
  .align 4
    string1: .string "hola"
    string2: .string "holas"

.text
main:
	li a7 1 #read int
	li a0 -1
    jal x1 string_compare
    ecall
    li a7 10
    ecall
    
string_compare:
    la t0 string1 #Argument 1 = adress 1
    la t1 string2 #Argument 2 = adress 2
    lw t2 0(t0) # a = char11
    lw t3 0(t1) # b = char12

buc1: beqz t2 try #if t2 is equal to 0, we check if t3 is also equal
    bne t2 t3 not_eq # if a[n] != b[n] -> not eq
    addi t0 t0 1 # Address1 + 1
    addi t1 t1 1 # Address2 + 1
    lbu t2 0(t0) # reset value of the addresses
    lbu t3 0(t1)
    j buc1
try:
	beqz t3 yes #and if t3 is also equal, both words have the same length so its the same word
	li a0 0 #if not, one word is longer so they arent equal
    jr ra
yes: 
    li a0 1 #its the same word, so 1
    jr ra
not_eq:
	li a0 0 #if not, one word is longer so they arent equal
    jr ra

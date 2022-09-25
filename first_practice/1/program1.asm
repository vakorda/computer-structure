.data
  .align 2
    string1: .string "hola"
    string2: .string "hola"

.text
main:
	li s1 0
string_compare:
    la t0 string1 #Argument 1 = adress 1
    la t1 string2 #Argument 2 = adress 2
    lbu t2 0(t0) # a = char11
    lbu t3 0(t1) # b = char12

buc1: beqz t2 try #if t2 is equal to 0, we check if t3 is also equal
    bne t2 t3 not_eq # if a[n] != b[n] -> not eq
    addi t0 t0 1 # Address1 + 1
    addi t1 t1 1 # Address2 + 1
    lbu t2 0(t0) # reset value of the addresses
    lbu t3 0(t1)
    j buc1
try:
	beqz t3 yes #and if t3 is also equal, both words have the same length so its the same word
	j not_eq #if not, one word is longer so they arent equal
yes: 
	li a7 1 #read int
    li a0 1 #its the same word, so 1
    ecall
    li a7 10 #exit
    ecall
not_eq:
	li a7 1
    li a0 0 #different words, so 0
    ecall
    li a7 10 #exit
    ecall

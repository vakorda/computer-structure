.data
    string1: .string "hola"
    string2: .string "hola"
.text
main:
    li a0 -1
    la a1 string1 #Argument 1 = adress 1
    la a2 string2 #Argument 2 = adress 2
    jal x1 string_compare
    li a7 1
    ecall
    li a7 10
    ecall
string_compare:
    mv t0 a1 #Argument 1 = adress 1
    mv t1 a2 #Argument 2 = adress 2
    lbu t2 0(t0) # a = char1 of 1
    lbu t3 0(t1) # b = char1 of 2

buc1: beqz t2 try #if t2 is equal to 0, we check if t3 is also equal
    bne t2 t3 not_eq # if a[n] != b[n] -> not eq
    addi t0 t0 1 # Address1 + 1
    addi t1 t1 1 # Address2 + 1
    lbu t2 0(t0) # reset value of the addresses
    lbu t3 0(t1)
    j buc1
try:
    beqz t3 yes # and if t3 is also equal, both words have the same length so its the same word
    j not_eq # if not, one word is longer so they arent equal
yes:
    li a0 1 # its the same word, so 1
    j exit
not_eq:
    li a0 0 # different words, so 0
    j exit
exit:
    jr ra

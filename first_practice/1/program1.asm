.data
	.align 2
    string1: .string "hola"
    string2: .string "hola"

.text
main: 
	syscal 
string_compare:
    la t0 string1 #Argument 1 = adress 1
    la t1 string2 #Argument 2 = adress 2
    lbu t2 0(t0) # a = char11
    lbu t3 0(t1) # b = char12

    buc1: beqz t2 fin
    bne t2 t3 not_eq # if a[n] != b[n] -> not eq
    addi t0 t0 1 # Address1 + 1
    addi t1 t1 1 # Address2 + 1
    lbu t2 0(t0) # reset value of the addresses
    lbu t3 0(t1)
    j buc1
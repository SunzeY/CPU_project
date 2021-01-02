.data
.macro input(%i)#整数输入宏
li $v0, 5
syscall
move %i, $v0
.end_macro

.macro output(%i)#整数输出宏
move $a0, %i
li $v0, 1
syscall
.end_macro

link: .space 256 #link[8][8]={0}
G: .space 28     #G[7]={0}

.text
jal in
nop
li $v0, 10
syscall

in:
input($s0) #n
input($t0) #m
li $t1, 0
forin_begin:
slt $t2, $t1, $t0
beq $t2, $0, forin_end
nop
input($t2)
input($t3)
subi $t2, $t2, 1
subi $t3, $t3, 1
sll $t4, $t2, 3
add $t5, $t4, $t3
sll $t5, $t5, 2
li $t6, 1
sw $t6 link($t5)

sll $t4, $t3, 3
add $t5, $t4, $t2
sll $t5, $t5, 2
la $t6, link($t5)
li $t6, 1
sw $t6 link($t5)

addi $t1, $t1, 1
j forin_begin
forin_end:
jr $ra
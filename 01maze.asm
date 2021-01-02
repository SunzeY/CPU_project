.data

maze: .space 196
end: .space 8
dirct: .space 32
enter: .asciiz "\n"
.macro input(%i)
li $v0, 5
syscall
move %i, $v0
.end_macro

.text
jal initial
nop
jal in
nop
jal find_path
nop
move $a0, $s5
li $v0, 1
syscall
li $v0, 10
syscall

find_path:
addi $sp, $sp, -16
sw $s2, 12($sp)
sw $s3, 8($sp)
sw $s4, 4($sp) #i save
sw $ra, 0($sp)
mult $s2, $s1
mflo $t0
add $t0, $t0, $s3
sll $t0, $t0, 2
li $t1, 1
sw $t1, maze($t0) #maze[x][y]=1
li $t1, 1
lw $t2, end($0)
sll $t1, $t1, 2
lw $t4, end($t1)
seq $t3, $s2, $t2
seq $t5, $t4, $s3
and $t6, $t5, $t3
beq $t6, $0, else
addi $s5, $s5, 1 #s5=posspath
j end_if
else:
li $s4, 0
for_begin:
slti $t0, $s4, 4
beq $t0, $0, for_end
sll $t1, $s4, 3
lw $t2, dirct($t1)
addi $t1, $t1, 4
lw $t3, dirct($t1)
add $s6, $s2, $t2
add $s7, $s3, $t3
jal pathable
nop
beq $a0, $0, el
move $s2, $s6
move $s3, $s7
jal find_path
sll $t1, $s4, 3
lw $t2, dirct($t1)
addi $t1, $t1, 4
lw $t3, dirct($t1)
sub $s2, $s2, $t2
sub $s3, $s3, $t3
sll $t1, $s4, 3
lw $t2, dirct($t1)
addi $t1, $t1, 4
lw $t3, dirct($t1)
add $s6, $s2, $t2
add $s7, $s3, $t3
mult $s6, $s1
mflo $t6
add $t6, $t6, $s7
sll $t6, $t6, 2
sw $0, maze($t6)
el:
addi $s4, $s4, 1
j for_begin
for_end:
end_if:
lw $ra, 0($sp)
lw $s4, 4($sp) 
lw $s3, 8($sp)
lw $s2, 12($sp)
addi $sp, $sp, 16
jr $ra

pathable:
li $t1, 1
sle $t2, $s0, $s6
sle $t3, $s1, $s7
slt $t4, $s6, $0
slt $t5, $s7, $0
or $t3, $t3, $t2
or $t4, $t3, $t4
or $t5, $t4, $t5
beq $t5, $0, elsei
li $t1, 0
j endi
elsei:
mult $s6, $s1
mflo $t6
add $t6, $t6, $s7
sll $t6, $t6, 2
lw $t7, maze($t6)
slti $t1, $t7, 1
endi:
move $a0, $t1
jr $ra

in:
input($s0)#m
input($s1)#n
li $t0, 0
form1_begin:
slt $t1, $t0, $s0
beq $t1, $0, form1_end
li $t1, 0
form2_begin:
slt $t2, $t1, $s1
beq $t2, $0, form2_end
mult $t0, $s1
mflo $t3
add $t3, $t3, $t1
sll $t3, $t3, 2
li $v0, 5
syscall
sw $v0, maze($t3)
addi $t1, $t1, 1
j form2_begin
form2_end:
addi $t0, $t0, 1
j form1_begin
form1_end:
input($s2)
input($s3)
addi $s2, $s2, -1
addi $s3, $s3, -1
input($t0)
la $t2, end
addi $t0, $t0, -1
sw $t0, 0($t2)
input($t1)
addi $t1, $t1, -1
sw $t1, 4($t2)
jr $ra

initial:
li $t1, 1
li $t2, -1
la $t3, dirct
sw $0, 0($t3)
sw $t1, 4($t3)
sw $0, 8($t3)
sw $t2, 12($t3)
sw $t1 16($t3)
sw $0, 20($t3)
sw $t2, 24($t3)
sw $0, 28($t3)
jr $ra

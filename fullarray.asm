.data
state: .space 28
array: .space 28
space: .asciiz " "
enter: .asciiz "\n"
.text
li $v0, 5
syscall
move $s0, $v0
li $a0, 0
jal fullarray
nop
li $v0, 10
syscall

fullarray:
addi $sp, $sp, -12
sw $ra, 8($sp)
sw $s1, 4($sp)
sw $a0, 0($sp)
slt $t0, $a0, $s0
bne $t0, $0, else

li $t1, 0
for_begin:
slt $t2, $t1, $s0
beq $t2, $0, for_end
sll $t3, $t1, 2
lw $t8, array($t3)
move $a0, $t8
li $v0, 1
syscall
la $a0, space
li $v0, 4
syscall
addi $t1, $t1, 1
j for_begin
for_end:
la $a0, enter
li $v0, 4
syscall

j end
else:

li $s1, 0
for1_begin:
slt $t2, $s1, $s0
beq $t2, $0, for1_end
sll $t2, $s1, 2
lw $t3, state($t2)
bne $t3, $0, end_if 
addi $t4, $s1, 1
sll $t5, $a0, 2
sw $t4 array($t5)
li $t6, 1
sw $t6, state($t2)
addi $a0, $a0, 1
jal fullarray
addi $a0, $a0, -1
sll $t7, $s1, 2
sw $0, state($t7)
end_if:
addi $s1, $s1, 1
j for1_begin
for1_end:
end:

lw $a0, 0($sp)
lw $s1, 4($sp)
lw $ra, 8($sp)
addi $sp, $sp, 12
jr $ra

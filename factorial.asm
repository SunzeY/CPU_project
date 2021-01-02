li $v0, 5
syscall
move $a0, $v0
jal factorial
move $a0, $a1
li $v0, 1
syscall
li $v0, 10
syscall

factorial:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $a0, 0($sp)
li $t0, 1
if:
 bne $a0, $t0, else
 lw $a0, 0($sp)
 lw $ra, 4($sp)
 addi $sp, $sp, 8
 li $a1, 1
 jr $ra
else:
 addi $a0, $a0, -1
 jal factorial
 lw $a0, 0($sp)
 lw $ra, 4($sp)
 addi $sp, $sp, 8
 multu $a0, $a1
 mflo $a1
 jr $ra
 
 

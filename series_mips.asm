.data
a: .space 1004
.text
li $s5, 10
addi $t0, $t0, 1
sb $t0, a($0)
addi $v0, $v0, 5
syscall
add $s0 $s0, $v0
addi $s1, $s1, 1
li $s2, 1
for1_begin:
sle $t0, $s2, $s0
beq $t0, $0 for1_end
li $s3, 0
for2_begin:
slt $t0, $s3, $s1
beq $t0, $0, for2_end
lb $t1, a($s3)
mult $t1, $s2
mflo $t1
add $t2, $t1, $s4
div $t2, $s5
mflo $s4
mfhi $t1
sb $t1, a($s3)
addi $s3, $s3, 1
j for2_begin
for2_end:
loop:
beq $s4, $0, end
div $s4, $s5
mfhi $t0
sb $t0, a($s1)
mflo $s4
addi $s1, $s1, 1
j loop
end:
addi $s2, $s2, 1
j for1_begin
for1_end:
addi $t0, $s1, -1
for0_begin:
slt $t1, $t0, $0
bne $t1, $0, for0_end
lb $a0, a($t0)
li $v0, 1
syscall
addi $t0, $t0, -1
j for0_begin
for0_end:
li $v0, 10
syscall
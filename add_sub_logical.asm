.include "./cs47_common_macro.asm"
.include "cs47_proj_macro.asm"
.text
.globl add_sub_logical
#Procedure: add_sub_logical(<arg>, <arg>, <arg>)
#Arguments: $a0 = operand1, $a1 = operand2, $a2= mode
#Returns: $v0 =sum, $v1= final carry out
add_sub_logical:
	addi	$sp, $sp, -48
	sw	$fp, 48($sp)
	sw	$ra, 44($sp)
	sw	$a0, 40($sp)#operand1
	sw	$a1, 36($sp)#operand2
	sw	$a2, 32($sp)#mode
	sw	$s0, 28($sp)
	sw	$s1, 24($sp)
	sw	$s2, 20($sp)
	sw	$s3, 16($sp)
	sw	$s4, 12($sp)
	sw	$s5, 8($sp)
	addi	$fp, $sp, 48
	add	$s0, $zero, $zero #$s0 = i = 0
	add 	$s1, $zero, $zero #$s1 = s = 0
	add	$s2, $zero, $zero #$s2 = c = 0
	extract_nth_bit($s2,$a2,$s2)#c= $a2[0]
	add	$t4, $zero, $zero #$t4 = 0
	add	$t5, $zero, $zero #$t5 = 0
	addi	$t9, $zero, 0xFFFFFFFF #$t9 = sub operation marker (0xffffffff)
	beq	$a2, $t9, sub_op#checks if operation is a sub operation
	j	start_loop
sub_op:
	not	$a1, $a1
	j	start_loop
start_loop:
	extract_nth_bit($t4, $a0, $s0)#$t4 = $a0[i]
	extract_nth_bit($t5, $a1, $s0)#$t5 = $a1[i]
	#sum = carry in XOR a XOR b
	xor	$t6, $t4, $t5#$t6 = $a0[i] XOR $a1[i]
	xor	$t6, $s2, $t6#$t6 = c XOR $t6 
	# carry out = carry in AND (a XOR b) OR (a AND b)
	xor 	$s3, $t4, $t5#$s3 = a XOR b
	and	$s4, $t4, $t5#$s4 = a AND b
	and 	$s5, $s2, $s3#$s5 = c AND $s3
	or 	$s2, $s5, $s4#c = $s5 OR $s4
	
	add	$t7, $zero, $zero#$t7 = 0
	insert_to_nth_bit($s1,$s0,$t6,$t7)#s[i] = sum
	
	add	$s0, $s0, 1#i++
	j	end_check
end_check:
	addi	$t8, $zero, 32#$t8 = 32
	beq	$s0, $t8, end#if i==32, end the loop
	j	start_loop
end:
	move	$v0, $s1#$v0 = result
	move	$v1, $s2#$v1= carry out
	#restore RTE
	lw	$fp, 48($sp)
	lw	$ra, 44($sp)
	lw	$a0, 40($sp)
	lw	$a1, 36($sp)
	lw	$a2, 32($sp)
	lw	$s0, 28($sp)
	lw	$s1, 24($sp)
	lw	$s2, 20($sp)
	lw	$s3, 16($sp)
	lw	$s4, 12($sp)
	lw	$s5, 8($sp)
	addi	$sp, $sp, 48
	
	jr $ra

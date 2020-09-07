.include "cs47_proj_macro.asm"
.text
.globl mul_signed
#$a0 = multiplicand, $a1 = multiplier
#$v0 = lo part of result, $v1 = hi part of result
mul_signed:
	addi	$sp, $sp, -52
	sw	$fp, 52($sp)
	sw	$ra, 48($sp)
	sw	$a0, 44($sp)
	sw	$a1, 40($sp)
	sw	$s0, 36($sp)
	sw	$s1, 32($sp)
	sw	$s2, 28($sp)
	sw	$s3, 24($sp)
	sw	$s4, 20($sp)
	sw	$s5, 16($sp)
	sw	$s6, 12($sp)
	sw	$s7, 8($sp)
	addi	$fp, $sp, 52
	
	move 	$s3, $a0#$s3 = original $a0
	move	$s6, $a1#$s6 = original $a1
	jal 	twos_complement_if_neg
	move	$s0, $v0#$s0 = 2's complement of $a0
	move	$a0, $a1
	jal	twos_complement_if_neg
	move	$s1, $v0#$s0 = 2's complement of $a1
	move	$a0, $s0
	move	$a1, $s1
	jal	mul_unsigned
	move	$s0, $v0#$s0=RLo
	move	$s1, $v1#$s1=RHi
	add	$s4,$zero,$zero
	add	$s5,$zero,$zero
	li	$s7, 31#$t9=31
	extract_nth_bit($s4, $s3, $s7)#$s4=$a0[31]
	extract_nth_bit($s5, $s6, $s7)#$s5=$a1[31]
	xor 	$s2, $s4, $s5#$s2 = sign of product
	beqz	$s2, pos_result				
	move	$a0, $s0
	move	$a1, $s1
	jal	twos_complement_64th
	move	$s0, $v0
	move	$s1, $v1
pos_result:
	move 	$v0,$s0
	move	$v1,$s1
	lw	$fp, 52($sp)			
	lw	$ra, 48($sp)
	lw	$a0, 44($sp)
	lw	$a1, 40($sp)
	lw	$s0, 36($sp)
	lw	$s1, 32($sp)
	lw	$s2, 28($sp)
	lw	$s3, 24($sp)
	lw	$s4, 20($sp)
	lw	$s5, 16($sp)
	lw	$s6, 12($sp)
	lw	$s7, 8($sp)
	addi	$sp, $sp, 52
	jr	$ra

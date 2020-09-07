.include "./cs47_proj_macro.asm"
.text
.globl au_normal
# TBD: Complete your project procedures
# Needed skeleton is given
#####################################################################
# Implement au_normal
# Argument:
# 	$a0: First number
#	$a1: Second number
#	$a2: operation code ('+':add, '-':sub, '*':mul, '/':div)
# Return:
#	$v0: ($a0+$a1) | ($a0-$a1) | ($a0*$a1):LO | ($a0 / $a1)
# 	$v1: ($a0 * $a1):HI | ($a0 % $a1)
# Notes:
#####################################################################
au_normal:
# TBD: Complete it
	addi	$sp, $sp, -24
	sw	$fp, 24($sp)
	sw	$ra, 20($sp)
	sw	$a0, 16($sp)#operand1
	sw	$a1, 12($sp)#operand2
	sw	$a2, 8($sp)#mode
	addi	$fp, $sp, 24
	
	addi	$t4, $zero, '+'
	addi	$t5, $zero, '-'
	addi	$t6, $zero, '*'
	addi	$t7, $zero, '/'
	beq	$a2, $t4, add_op
	beq	$a2, $t5, sub_op
	beq	$a2, $t6, mul_op
	beq	$a2, $t7, div_op
	j	end
add_op:	
	add	$v0, $a0, $a1
	j	end
sub_op: 
	sub	$v0,$a0,$a1
	j	end
mul_op:
	mult	$a0, $a1
	mflo	$v0
	mfhi	$v1
	j	end
div_op:
	div	$a0, $a1
	mflo	$v0
	mfhi	$v1
	j	end
end:
	lw	$fp, 24($sp)
	lw	$ra, 20($sp)
	lw	$a0, 16($sp)
	lw	$a1, 12($sp)
	lw	$a2, 8($sp)
	addi	$sp, $sp, 24
	
	jr	$ra

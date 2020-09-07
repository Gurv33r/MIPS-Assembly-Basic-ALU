.include "./cs47_proj_macro.asm"
.include "./add_logical.asm"
.include "./sub_logical.asm"
.text
.globl au_logical
# TBD: Complete your project procedures
# Needed skeleton is given
#####################################################################
# Implement au_logical
# Argument:
# 	$a0: First number
#	$a1: Second number
#	$a2: operation code ('+':add, '-':sub, '*':mul, '/':div)
# Return:
#	$v0: ($a0+$a1) | ($a0-$a1) | ($a0*$a1):LO | ($a0 / $a1)
# 	$v1: ($a0 * $a1):HI | ($a0 % $a1)
# Notes:
#####################################################################
au_logical:
# TBD: Complete it
	addi	$sp, $sp, -24
	sw	$fp, 24($sp)
	sw	$ra, 20($sp)
	sw	$a0, 16($sp)#operand1
	sw	$a1, 12($sp)#operand2
	sw	$a2, 8($sp)#mode
	addi	$fp, $sp, 24
	
	beq	$a2, '+', add_op
	beq	$a2, '-', sub_op
	beq	$a2, '*', mul_op
	beq	$a2, '/', div_op
	j	end
add_op:	
	jal	add_logical
	j	end
sub_op: 
	jal	sub_logical
	j	end
mul_op:
	jal	mul_signed
	j	end
div_op:
	jal	div_signed
	j	end
end:
	lw	$fp, 24($sp)
	lw	$ra, 20($sp)
	lw	$a0, 16($sp)
	lw	$a1, 12($sp)
	lw	$a2, 8($sp)
	addi	$sp, $sp, 24
	
	jr	$ra

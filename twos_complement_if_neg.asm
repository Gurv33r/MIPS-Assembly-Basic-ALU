.include "cs47_proj_macro.asm"
.text
.globl twos_complement_if_neg
twos_complement_if_neg:
	addi	$sp, $sp , -28
	sw	$fp, 28($sp)
	sw	$ra, 24($sp)
	sw	$a0, 20($sp)
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	addi	$fp, $sp, 28
	
	bgez	$a0, is_pos
	jal	twos_complement
	j	end
is_pos:
	move	$v0, $a0
	j	end
end:
	lw	$fp, 28($sp)
	lw	$ra, 24($sp)
	lw	$a0, 20($sp)
	lw	$s0, 16($sp)
	lw	$s1, 12($sp)
	lw	$s2, 8($sp)
	addi	$sp, $sp, 28
	
	jr	$ra

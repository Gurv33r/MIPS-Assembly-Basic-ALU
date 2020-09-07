.include "add_logical.asm"
.text
.globl twos_complement
#$a0 = arg sequence
#$v0 = 2's complement of $a0
twos_complement:
	addi	$sp, $sp , -20
	sw	$fp, 20($sp)
	sw	$ra, 16($sp)
	sw	$a0, 12($sp)
	sw	$a1, 8($sp)
	addi	$fp, $sp, 20
	
	not	$a0,$a0
	li	$a1, 1
	jal	add_logical
end:
	lw	$fp, 20($sp)
	lw	$ra, 16($sp)
	lw	$a0, 12($sp)
	lw	$a1, 8($sp)
	addi	$sp, $sp, 20
	jr	$ra

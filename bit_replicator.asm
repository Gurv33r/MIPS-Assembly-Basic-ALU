.text
.globl bit_replicator
#$a0 = bit value to be replicated
#$v0 = 0x0000000 if $a0 = 0x0 or 0xffffffff if $a1 = 0x1
bit_replicator:
	addi	$sp, $sp , -16
	sw	$fp, 16($sp)
	sw	$ra, 12($sp)
	sw	$a0, 8($sp)
	addi	$fp, $sp, 16
	
	addi 	$t1, $zero, 1
	beq	$a0, $zero, rep_0
	beq	$a0, $t1, rep_1
	j	end
rep_0:
	add	$v0, $zero, $zero
	j	end
rep_1:
	addi	$v0, $zero, 0xffffffff
	j	end
end:
	lw	$fp, 16($sp)
	lw	$ra, 12($sp)
	lw	$a0, 8($sp)
	addi	$sp, $sp, 16
	
	jr	$ra

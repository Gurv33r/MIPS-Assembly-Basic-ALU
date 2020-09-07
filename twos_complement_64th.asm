.include "add_logical.asm"
.text
.globl twos_complement_64th
twos_complement_64th:
	addi	$sp, $sp , -32
	sw	$fp, 32($sp)
	sw	$ra, 28($sp)
	sw	$a0, 24($sp)#						break here 
	sw	$a1, 20($sp)
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	addi	$fp, $sp, 32
	
	not	$s0,$a0#$s0= !lo
	not	$s1,$a1#$s1=!hi
	
	move 	$a0, $s0#$a0=!lo
	li	$a1, 1#$a1=1
	jal	add_logical
	move	$s0, $v0#$s0 = $a0+1
	move	$s2, $v1#$s2 = final carry out 
	
	move	$a0, $s1#$a0 = !hi
	move 	$a1, $s2#$a1 = final carry out
	jal	add_logical
	move	$s1, $v0 #$s1 = !hi + final carry out
	
	move 	$v0, $s0#lo = !lo+1
	move 	$v1, $s1#hi = !hi + final carry out
	j	end
end:
	lw	$fp, 32($sp)
	lw	$ra, 28($sp)
	lw	$a0, 24($sp)#				break here
	lw	$a1, 20($sp)
	lw	$s0, 16($sp)
	lw	$s1, 12($sp)
	lw	$s2, 8($sp)
	addi	$sp, $sp, 32
	
	jr	$ra

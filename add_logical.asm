.text
#Procedure: add_logical(<arg>, <arg>, <arg>)
#Arguments: $a0 = operand1, $a1 = operand2, $a2= mode
add_logical:
	addi	$sp, $sp, -24
	sw	$fp, 24($sp)
	sw	$ra, 20($sp)
	sw	$a0, 16($sp)#operand1
	sw	$a1, 12($sp)#operand2
	sw	$a2, 8($sp)#mode
	addi	$fp, $sp, 24
	
	addi 	$a2, $zero, 0x0#mode = add  
	jal	add_sub_logical
	j	add_end
add_end:
	lw	$fp, 24($sp)
	lw	$ra, 20($sp)
	lw	$a0, 16($sp)
	lw	$a1, 12($sp)
	lw	$a2, 8($sp)
	addi	$sp, $sp, 24
	
	jr	$ra

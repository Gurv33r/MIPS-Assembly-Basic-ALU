.include "cs47_proj_macro.asm"
.include "add_logical.asm"
.text
.globl mul_unsigned
#$a0 = multiplicand, $a1 = multiplier
#v0 = LO part of result, $v1 = HI part of result
mul_unsigned:
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
	
	add 	$s0,$zero,$zero#$s0 = i = 0
	add 	$s1,$zero,$zero#$s1 = h = 0 
	move	$s2, $a1#$s2 = l = $a1 
	move	$s3, $a0#$s3 = m = $a0
	j	loop	
loop:	
	#r = {32{l[0]}}
	add 	$s4, $zero, $zero
	extract_nth_bit($s4, $s2, $zero)#$s4 = l[0]
	move 	$a0, $s4#$a0 = $s4
	jal bit_replicator #$v0 = {32{l[0]}}
	move	$s4, $v0 #$s4 = r = {32{l[0]}}
	and	$s5, $s3, $s4#$s5 = x = m & r                          
	#h=h+x
	move	$a0, $s1#$a0 = $s1
	move	$a1, $s5#$a1 = $s5                                    
	jal	add_logical#					
	move	$s1, $v0 #h = h + x                              
	srl	$s2, $s2, 1#l = l >> 1				
	add	$s6, $zero, $zero#$s6 =0			
	extract_nth_bit($s6,$s1,$zero)#$s6=h[0]
	addi	$s7, $zero, 0x1f
	insert_to_nth_bit($s2, $s7, $s6, $zero)#l[31]=h[0]
	srl	$s1, $s1, 1#h = h >> 1 				
	addi	$s0, $s0, 1#i++					
	beq	$s0, 32, end #if i == 32, end loop
	j	loop#						
end:
	move	$v0, $s2 #$v0 = $s2 = l                         
	move	$v1, $s1 #%v1 = $s1 = h 
	lw	$fp, 52($sp)#			
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

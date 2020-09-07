.include "cs47_proj_macro.asm"
.text
.globl div_signed
#$a0 = multiplicand, $a1 = multiplier
#$v0 = lo part of result, $v1 = hi part of result
div_signed:
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
	
	move    $s0,    $a0    # $v0 = n1
    	move    $s1,    $a1    # $v1 = n2
    	move    $a0,    $s0            
    	jal twos_complement_if_neg     
    	move    $s2,    $v0
    	move    $a0,    $s1
    	jal twos_complement_if_neg 
    	move    $s3,    $v0
    	move    $a0,    $s2
    	move    $a1,    $s3
    	jal div_unsigned
    	move    $s4,    $v0             # $s4 = q
    	move    $s5,    $v1             # $r5 = r
    	li      $t5,    31   
    	extract_nth_bit($s6,$s0,$t5)       # $s6 = n1[31]
    	extract_nth_bit($s7, $s1, $t5)	#$s7 = n2[31]
    	xor     $t6,    $s6,    $s7     # $t6 = s = $s6 xor $s7
    	beqz    $t6,    pos_q    # if s == 0, jump to pos_q
    	move    $a0,    $s4              
    	jal 	twos_complement
    	move    $s4,    $v0                 # $v4 = 2's complement of q
pos_q:
    	beqz    $s6,    pos_r    	# iif n1[31] = 0, jump to pos_r
    	move    $a0,    $s5               
    	jal twos_complement
    	move    $s5,    $v0                 # $v4 = 2's complement of r
pos_r:
   	move    $v0,    $s4                 # $v0 = q
   	move    $v1,    $s5                 # $v1 = r
	
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
	
	
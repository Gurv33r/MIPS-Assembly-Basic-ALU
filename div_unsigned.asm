.include "cs47_proj_macro.asm"
.include "sub_logical.asm"
.text
.globl div_unsigned
#$a0 = dividend, $a1 = divisor
#$v0 = quotient, $v1 = remainder
div_unsigned:
	addi	$sp, $sp , -52
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
	
	 move    $s0,    $zero	# i
   	 move    $s1,    $a0	# q
   	 move    $s2,    $a1 	# d
    	 move    $s3,    $zero	# r
loop:
	sll     $s3,    $s3,    1       # r = r << 1
    	li      $s4, 31
    	extract_nth_bit($s5, $s1, $s4)       # $s5 = q[31]
    	insert_to_nth_bit($s3, $zero, $s5, $zero)# r[0] = q[31]
    	sll     $s1,    $s1,    1       # q = q << 1
    	move    $a0,    $s3             # $a0 = r
    	move    $a1,    $s2             # $a1 = d
    	jal     sub_logical              # r - d
    	move    $s7,    $v0             # s = r - d
    	bltz    $s7,    neg_S             # if s is negative, jump to neg_S
    	move    $s3,    $s7             # r = s
    	li      $s6,    1               # $s6 = 1
    	insert_to_nth_bit($s1, $zero, $s6, $zero)    # q[0]=1
neg_S:
    	add     $s0,    $s0,    1       # i = i + 1
    	beq     $s0,    32,     end
    	j       loop
end:
    	move    $v0,    $s1
    	move    $v1,    $s3
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


   
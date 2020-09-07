# Add you macro definition here - do not touch cs47_common_macro.asm"
#<------------------ MACRO DEFINITIONS ---------------------->#

	#Macro: insert_to_nth_bit
	#Usage: insert_to_nth_bit(<reg>,<reg>,<reg>,<reg>)
	.macro insert_to_nth_bit($regD,$regS,$regT,$maskReg)
	la	$t0, 0($regD)#$t0 = $regD = bit pattern to be modifed 
	la	$t1, 0($regS)#$t1 = $regS = nth index
	la	$t2, 0($regT)#$t2 = $regT = bit to be inserted
	la	$t3, 1($maskReg)#$t3 = $maskReg = mask
	
	sllv	$t3, $t3, $t1#$maskReg = $maskReg << $regS
	not	$t3, $t3#$maskReg = !$maskReg
	and	$t3, $t3, $t0#$maskReg = $maskReg AND $regD
	sllv	$t2, $t2, $t1#$regT = $regT << $regS
	or	$t0, $t3, $t2#$regD = $maskReg OR $regT
	move	$regD, $t0#store new $regD
	.end_macro 	
	
	#Macro: extract_nth_bit 
	#Usage: extract_nth_bit(<reg>,<reg>,<reg>)
	.macro extract_nth_bit($regD,$regS,$regT)
	#$regD = result, should hold either 0 or 1, will be modified
	#$regS = source bit pattern
	#$regT = nth index
	srlv 	$regD, $regS, $regT#shift bit pattern right by n
	andi	$regD, 0x1#logical AND on mask and $regD
	.end_macro

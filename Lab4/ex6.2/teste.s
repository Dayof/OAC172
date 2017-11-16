.text

	la $t0, 0x0040001c	
	jalr $t0
	la $t1, 0x00400020
	jalr $t0, $t1
	j fim
	jr $ra
	jr $t0
fim:	li $t1, 4
	li $t2, 4	
	mul $t0, $t1, $t2
	

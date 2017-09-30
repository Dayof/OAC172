.data
	ender: .asciiz "\n "

.text 


	main:
	
	li $a0, 14
	li $a1, 10
	jal bala
	
	li $v0, 10	#### fim do mundo
	syscall		####
	
	
		bala:
			move $t0, $a0 		## a0	(vx)
			move $t1, $a1 		## a1 (vy)
			li $s5, 1		# tempo inicial
			li $s0, 10		# g - aceleracao da gravidade
			li $s1, 2		# aux
			
			li $t2, 321
			
			div $t4, $t1, $s0	# t = vy / g
			add $s6, $t4, $t4	# t total do lancamento
			
			
			
			li $s3, 0x00000000	# cor preta
			li $s4, 4278266560	# endereco do primeiro pixel da tela (decimal)
			mov:
				
				mul $t5, $t0, $s5	# t5 = vx * t
				#add $t2, $t2, $t5	# dx = dx + t5
				
				
				bgt $s5, $t4,pula
					
				mul $t6, $s5, $s5	# t^2
				mul $t7, $t1, $s5	# t7 = vy * t
				
				mul $t8, $s0, $t6	# t8 = g * t^2
				div $t8, $t8, $s1	# t8 = t8/2
				
				add $t9, $t7, $t8	# t9 = vy * t + (g * t^2) / 2
				#add $t3, $t3, $t9	# dy = dy + t9	
			   pula:
				addi $s5, $s5, 1
				
				ble $s5, 1, pula2
				
				add $t2, $t2, $t5
				
			pula2:	sub $s4, $s4, $t2
				add $s4, $s4, $t5
				li $v0, 1
				move $a0, $t2
				syscall
				
				
				
				ble $s5, $s6, mov
				
				
				
				
				
						
	     fimBala:
	     			jr $ra
		    

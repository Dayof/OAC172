.data
	ender: .asciiz "\n "

.text 


	main:
	
	li $a0, 40
	li $a1, 30
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
			sb $s3,0($s4)
			mov:
				mul $t5, $t0, $s5	# t5 = vx * t
				
				
				bgt $s5, $t4, pula
					
				mul $t6, $s5, $s5	# t^2
				mul $t7, $t1, $s5	# t7 = vy * t
				
				mul $t8, $s0, $t6	# t8 = g * t^2
				div $t8, $t8, $s1	# t8 = t8/2
				
				add $t9, $t7, $t8	# t9 = vy * t + (g * t^2) / 2
				j pend
			   pula:
			   	mul $t9, $t9, -1
			   pend:
				addi $s5, $s5, 1
				
				#mul $s7,$t9,2
				#mul $t5,$t5,2
				
				li $s4, 4278266560
				mul $t9, $t9, 320
				
				bgt $s5, $t4, faz
				j nf
				
			   faz: 
			   	sub $s4, $s4, $t5
			   	add $s4, $s4, $t9
			   	j nn
			    nf: 
				sub $s4, $s4, $t9
				add $s4, $s4, $t5
			    nn:
				
				sb $s3,0($s4)
				
				
				
				
				ble $s5, $s6, mov		
	     fimBala:		
	     			jr $ra
		    

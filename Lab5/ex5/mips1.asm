.data
	gravidade: .word -10
	space: .asciiz " "



.text

	main:
		
		
		#li $s2, 0xFF012AC0	# s2 = endereco final da tela
		#li $s3, 0x00000000
		##sb $s3, ($s2)
		
		li $a0, 40
		li $a1, 20
		jal lancamento
		
	
	li $v0, 10	#######
	syscall		#######
	
	lancamento:
		    add $t0, $zero, $a0		# t0 == vx
		    add $t1, $zero, $a1		# t1 == vy
		    
		    	      
		    la $t2, gravidade		# t2 == g
		    lw $t2, ($t2)
		    
		    div $t3, $t1, $t2		# t3 = vy/g*(-1) 
		    mul $t3, $t3, -1		# t3 = t*(-1)
		    
		    				### t3 == t (subida)
		    				
		    				
		    
		    mul $t4, $t3, 2		# t4 = t (lancamento)
		    
		    li $t5, 0			# i loop (tempo corrido)
		    
		    
		    
		    forL:
		    	 mul $t6, $t0, $t5	# (x) t6 = vx * i (tempo corrido)
		    	 
		    	 ble $t5, $t3, sobe
		    	 j desce
		    	 sobe:
		    	      mul $t7, $t1, $t5	# t7 = vy * i (tempo corrido)
		    	      mul $t8, $t5, $t5	# t8 = i^2 (tempo corrido)^2
		    	      mul $t8, $t2, $t8 # t8 = g * i^2
		    	      div $t8, $t8, 2	# t8 = g*i^2 /2
		    	      add $t8, $t7, $t8	# (y) t8 = vy*i + (g*i^2 /2 )
		    	      add $t9, $zero, $t5	# t9 = t5 (i)
		    	      beq $t9, 1, salt
		    	      addi $t9, $t9, -1		# para nao repetir o ponto de subida
		    	      salt:
		    	      j fimS
		        desce:
		              mul $t7, $t1, $t9	# t7 = vy * i (tempo corrido)
		    	      mul $t8, $t9, $t9	# t8 = i^2 (tempo corrido)
		    	      mul $t8, $t2, $t8 # t8 = g * i^2
		    	      div $t8, $t8, 2	# t8 = g*i^2 /2
		    	      add $t8, $t7, $t8	# (y) t8 = vy*i + (g*i^2 /2 )
		    	      add $t9, $t9, -1	# t9--
		   	 fimS:
		    	      
		    	     mul $t7, $t6, 10		# xp = x * 10(pixels)
		    	     mul $s1, $t8, 10		# yp = y * 10(pixels)
		    	     
		    	    # li $v0, 1
		    	   #  move $a0, $t8
		    	   #  syscall
		    	    # li $v0, 4
		    	   #  la $a0, space
		    	   # syscall
		    	      
		    	      
		    	      li $s2, 4278266880	# s2 = endereco final da tela
		    	      li $s3, 0x00000000
		    	      
		    	      mul $s6, $s1, 320		# s6 = yp * 320
		    	      sub $s6, $s6, 320		# s6 = (yp*320) - 320
		    	      bgt $s6, -1, vai		# if (s6 > -1) vai
		    	      mul $s6, $s6, -1		# else s6 = s6*(-1)
		    	      vai: 
		    	     
		    	      
		    	      sub $s4, $s6, $t7		# s4 = s6 - xp
		    	     
		    	      
		    	      sub $s5, $s2, $s4		# s5 = s2 - s4
		    	      li $v0, 34
		    	     move $a0, $s5
		    	     syscall
		    	     li $v0, 4
		    	     la $a0, space
		    	     syscall
		    	      sb $s3, ($s5) 		# escreve na tela
		    	      
		    	      add $t5, $t5, 1		# i (tempo corrido) ++
		    
		    
		    ble $t5, $t4, forL
		    
		    jr $ra
	    fimLanc:
		    

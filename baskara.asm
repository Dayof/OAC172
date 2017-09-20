.data
	  abc: .float 0, 0, 0
	 four: .float 4
	  two: .float 2
    negativoF: .float -1
    negativoW: .word -1
        cplex: .asciiz "i"
         mais: .asciiz "+"
        menos: .asciiz "-"
  quebralinha: .asciiz "\n"
        raiz1: .asciiz "R(1) = "
        raiz2: .asciiz "R(2) = "
        space: .asciiz " "
        aviso: .asciiz "Digite ' 1 ' para calcular outra funcao, se nao digite ' 0 ' para encerrar."
         mesg: .asciiz "Digite o valor do coeficiente "
         coef: .asciiz "ABC"
.text

	main:
	 
       continue:
       		la, $t0, abc		# carrega o vetor abc vazio em t0
       		li $t1, 0		# i = 0
		li $t2, 3		# flag = 3
	 	la $t4, coef   		# char dos coeficientes
	    ler:	
		li $v0, 4		#################### 
		la $a0, mesg		# mostra mesg na tela
		syscall			####################
		
		lb $t5,($t4)		# carrega primeira posicao da string coef ( char dos coeficiente )
		
		li $v0, 11		# codigo print de char
		move $a0, $t5		# a0 = t5
		syscall			# print
		
		addi $t4, $t4, 1	# coef++ , anda 1 byte no vetor de coeficientes
		
		li $v0, 4		###################
		la $a0, quebralinha	###################
		syscall			###################
		
		li $v0, 6		# ler float do teclado e armazena em f0
		syscall			####################
		
		swc1 $f0, ($t0)		# armazena o valor lido no vetor abc ( t0 )
		addi $t0,$t0,4		# anda uma posicao (4bytes) em abc
		addi $t1, $t1, 1	# i++
		
		blt $t1, $t2, ler	# if ( i < flag ) go ler
		
		
		li $v0, 4
		la $a0, quebralinha
		syscall
		
		jal baskara		# chama a funcao baskara
		move $a0, $v0		# move o retorno em v0 para passagem de argumento em a0
		jal show		# chama a funcao show passando o a0
		
		li $v0, 4		####################
		la $a0, aviso		#       printa aviso
		syscall			####################
		
		li $v0, 4
		la $a0, quebralinha
		syscall
		
		li $v0, 5		# ler opcao calcular novamente ou nao
		syscall			####################
		move $t3, $v0		####################
		beq $t3, 1, continue 	# if ( t3 == 1 ) go continue, else o calculo termina
		
		#jal baskara
		
		#move $a0, $v0
		
		#jal show
		
		
		li $v0, 10		# return 0
		syscall			# return 0
			
		
		
		
       delta:
       		la $t0, abc
       		lwc1, $f1,0($t0)		# a
       		lwc1, $f2,4($t0)		# b
       		lwc1, $f3,8($t0)		# c
       		
       		mul.s $f2, $f2, $f2   	# b^2
       		la $t1, four		# 4
       		lwc1 $f4, ($t1)
       		mul.s $f1, $f4, $f1	# 4*a
       		mul.s $f3, $f1, $f3	# (4*a) * c
       		
       		sub.s $f3, $f2, $f3	# b^2 - 4*a*c
       		
       		
       		#la $t0, negativoF
       		#lwc1 $f1, ($t0)
       		#mul.s $f3, $f3, $f1
       		
       		
       		mov.s $f0, $f3		# return delta (pelo f0)
    
       		jr $ra
       		
     baskara:
     		addi $sp, $sp, -4	# libera espaco para um word na pilha
     		sw $ra, 4($sp)		# salva o endereco de retorno $ra na pilha
     		jal delta		# chama a funcao que calcula o delta
		# f0 = delta
		lw $ra, 4($sp)		# devolve o endereco de retorno da funcao atual
		addi $sp, $sp, 4	# libera o espaco alocado pela pilha
		
		li $t1, 0		# 0 em inteiro
		mtc1 $t1, $f9		# movo 0 para o coproc 1
		cvt.s.w $f9, $f9	# converto 0 de int para float
		add.s $f8, $f9, $f0	# faco uma copia do delta em f0 para f8, COPIA
					# f0 = delta(float)
					# f8 = delta(float)
					
		cvt.w.s $f1, $f8 	# converte delta de float para word
		mfc1 $t3, $f1		# movo delta do coproc 1 para os registradores de int
					# t3 = delta(int)
		
		bgtz $t3, next		# if (t3 > 0) go next, else multiplica por (-1) 
		
		la $t1, negativoF
        	lwc1 $f4, ($t1)			# f4 = -1
        	mul.s $f0, $f0, $f4		# delta = f0 * (-1)
        	
        	next:
		
		la $t5, negativoW	# carrengo o (-1) int
		lw $t6,($t5)		# t6 = -1
		
		
        	la, $t0, abc
        	lwc1, $f1,0($t0)		# a
        	lwc1, $f2,4($t0)		# b
        	lwc1, $f3,8($t0)		# c
        	
        	la $t1, negativoF
        	lwc1 $f4, ($t1)			# f4 = -1
        	mul.s $f2, $f4, $f2		# (-1)*b
        	sqrt.s $f5, $f0			# f5 = raiz(f0) = raiz(delta)
        	la $t2, two
        	lwc1 $f6, ($t2)			# f6 = 2
        	mul.s $f1, $f6, $f1		# 2 * a
        	
        	slt $t4, $t3, $zero	# if ( t3 < 0 ) t4 = 1 , else t4 = 0
        	
        	
        	beqz $t4, reais
        	
        	
           complexas:
           		# f18 = x1
           		# f20 = x2
           		
           		div.s $f18, $f2, $f1		# -b / 2 * a
           		div.s $f20, $f5, $f1		# raiz(delta) / 2 * a
           		addi $sp, $sp, -8		# aloca 2 espacos na pilha
           		swc1 $f18, 4($sp)		# armazena a raiz na pilha
           		swc1 $f20, 0($sp)		# armazena a raiz na pilha
           		
               		j endReais			# salta para o fim da funcao para retorno complexo
               reais:
        		# f18 = x1
        		# f20 = x2
        		add.s $f7, $f2, $f5		# f7 = -b + raiz(delta)
        		div.s $f18, $f7, $f1		# f7 / 2 * a
        	
        		sub.s $f7, $f2, $f5		# f7 = -b - raiz(delta)
        		div.s $f20, $f7, $f1		# f7 / 2 * a
        		
        		addi $sp, $sp, -8		# libera 2 espacos na pilha
           		swc1 $f18, 4($sp)		# armazena a raiz na pilha
           		swc1 $f20, 0($sp)		# armazena a raiz na pilha
           		
        		li $t0, 1			# t0 = 1
        		move $v0, $t0			# return t0 = 1
        		jr $ra				# return
        		
       	    endReais:	
       	    		li $t0, 2			# t0 = 2
       	    		move $v0, $t0			# return t0 = 2
       	    		jr $ra				# return
       	   
    show:		
    	       		move $t0, $a0			# t0 = a0  argumento passado
    	       		beq $t0, 2, showC		# if ( t0 == 2 ) go showC, else showR
    	       			
    	       showR:
    	       		lwc1 $f18, 4($sp)		# retira a raiz x1 da pilha
    	       		lwc1 $f20, 0($sp)		# retira a raiz x2 da pilha
    	       		addi $sp, $sp, 8		# libera o espaco alocado pela pilha
    	       		
    	       		li $v0, 4			###################
    	       		la $a0, raiz1			###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 2			###################	
    	       		mov.s $f12, $f18		###################
    	       		syscall				###################
    	       						#     area de print
    	       		li $v0, 4			###################
    	       		la $a0, quebralinha		###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 4			###################
    	       		la $a0, raiz2			###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 2			###################
    	       		mov.s $f12, $f20		###################
    	       		syscall				###################
    	       		
    	       		li $v0, 4
    	       		la $a0, quebralinha		
    	       		syscall	
			li $v0, 4
			la $a0, quebralinha
			syscall			
    	       		
    	       		j end
    	      showC:
    	      		lwc1 $f18, 4($sp)		# retira a raiz complexa positiva da pilha
    	       		lwc1 $f20, 0($sp)		# retira a raiz complexa negativa da pilha
    	       		addi $sp, $sp, 8		# libera espaco alocado pela pilha
    	       		
    	       		li $v0, 4			###################
    	       		la $a0, raiz1			###################
    	       		syscall				###################
    	       						#  area de print R1
    	       		li $v0, 2			###################
    	       		mov.s $f12, $f18		###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 4			###################
    	       		la $a0, space			###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 4			###################
    	       		la $a0, mais			###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 4			###################
    	       		la $a0, space			###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 2			###################
    	       		mov.s $f12, $f20		###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 4			###################
    	       		la $a0, cplex			###################
    	       		syscall				###################
    	       		
    	       		li $v0, 4
    	       		la $a0, quebralinha
    	       		syscall
    	       		
    	       		li $v0, 4			###################
    	       		la $a0, raiz2			###################
    	       		syscall				###################
    	       						#  area de print R2
    	       		li $v0, 2			###################
    	       		mov.s $f12, $f18		###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 4			###################
    	       		la $a0, space			###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 4			###################
    	       		la $a0, menos			###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 4			###################
    	       		la $a0, space			###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 2			###################
    	       		mov.s $f12, $f20		###################
    	       		syscall				###################
    	       						###################
    	       		li $v0, 4			###################
    	       		la $a0, cplex			###################
    	       		syscall				###################
    	       		
    	       		li $v0, 4			
    	       		la $a0, quebralinha		
    	       		syscall
			li $v0, 4
			la $a0, quebralinha
			syscall
    	       						
    	       		
    	       		end:					
    	       		jr $ra
    	       		
    	       		
    	       		
    						
        		
        	
        	
        	
        	
        	   		
       		

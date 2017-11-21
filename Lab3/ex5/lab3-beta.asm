.data
	gravidade: .float -9.8
	Not: .float -1.0
	tw: .float 2.0
	zero: .float 0.0
	
	ten: .float 10.0
	#bn: .asciiz "\n"
	#sp: .asciiz " "
	
	one: .float 0.001
	fall: .float -0.001
	notf: .float -0.001
	
	cosO: .float 0.2588190451 # 75 graus
	senO: .float 0.96592582628 # 75 graus
	
	#msg1: .asciiz "\nDigite a velocidade inicial do lancamento:  "
	
	Vzero: .float 22 #### velocidade inicial do lancamento (decomposta posteriormente em vx e vy)
	
.text

	main:
		jal fullTela
		
		jal decompV
		
		jal lancamento
			
	li $v0, 10	################ FIM DO PROGRAMA
	syscall		################
	
	lancamento:
		l.s $f2, gravidade
		l.s $f3, Not
		l.s $f6, tw
		
		l.s $f17, fall
		l.s $f18, zero
		l.s $f19, notf
		
		l.s $f7, zero 	# t float var
		l.s $f8, one	# ++ float  
		
		div.s $f4, $f1, $f2		# t = vy / g(-9.8)
		mul.s $f4, $f4, $f3		# f4 = t*(-1) tempo de subida float
		
		mul.s $f5, $f4, $f6		# f5 =tempo de lancamento float
		
		li $t1, 0
		li $t2, 320
		li $t3, -1
		
		
		for:
			mul.s $f9, $f0, $f7	# f9 = vx * t lanc(float)

			c.lt.s $f7, $f4		# if ( f7 < tempo de subida)
			bc1t sobe		# if true - continua subindo
			
			j desce			# else - comeca a descer
		   
		   sobe:	
			mul.s $f10, $f1, $f7	# f10 = vy * t float var
			div.s $f11, $f2, $f6	# f11 = g / 2
			mul.s $f13, $f7, $f7	# f13 = t * t -- (floats) var
			mul.s $f13, $f11, $f13	# f13 = g/2 * t*t
			add.s $f11, $f10, $f13	# f11 = vy*t + g/2*t^2
			
			add.s $f16, $f18, $f7	# f16 = f7
			add.s $f16, $f16, $f19  # f16 = f16 - notf (para nao repetir o calculo do topo)
			
			j endDesce
		
		 desce:
		 	mul.s $f10, $f1, $f16	# f10 = vy * t float var
			div.s $f11, $f2, $f6	# f11 = g / 2
			mul.s $f13, $f16, $f16	# f13 = t * t -- (floats) var
			mul.s $f13, $f11, $f13	# f13 = g/2 * t*t
			add.s $f11, $f10, $f13	# f11 = vy*t + g/2*t^2
			add.s $f16, $f16, $f17	# f16 = f16 - fall
	       endDesce:
		   	
		   	
		   	
		   	l.s $f14, ten		# f14 = 10
		   	mul.s $f15, $f9, $f14	# f15 = x(metros) * 10 pixels  (float) 
		   	cvt.w.s $f15, $f15	# f15 convertido de float para int
		   	mfc1 $t3, $f15		# x == t3 = f15
		   	
		   	mul.s $f15, $f11, $f14	# f15 = y(metros) * 10 pixels (float)
		   	cvt.w.s $f15, $f15	# f15 convertido de float para int
		   	mfc1 $t4, $f15		# y == t4 = f15
		   	
		   	li $t5, 4278266880	# f5 = fim da tela
		   	li $s0, 0x07070707	# s0 = cor
		   	li $s1, 0x00000000	# s0 = cor
		   	
		   	#mul $t6, $t4, 320	# t6 = y * 320
		   	
		   	mult $t4, $t2		# t4 * t2 (320)
		   	mflo $t6		# t6 = lo
		   	
		   	
		   	sub $t6, $t6, 320	# t6 = (y * 320) - 320
		   	bgt $t6, -1, vai	# if (t8 > -1) , pula pro "vai", else {
		   	#mul $t6, $t6, -1	# t8 = t8 * (-1) }
		   	mult $t6, $t3
		   	mflo $t6
		   
		   vai:
		   	sub $t8, $t6, $t3	# t8 = t6 - x
		   	
		   	beqz $t1, salt
		   	sb $s1, ($t9)
		   	salt:
		   	sub $t9, $t5, $t8	# t9 = t5 - t8
		   	
		   	sb $s0, ($t9)		# escreve na tela
		   	
		   	li $t1, 1
		   	
		   	add.s $f7, $f7, $f8	# t float ++
			c.le.s $f7, $f5		# if ( f7 <= tempo de lancamento)
			bc1t for		# if true - repete o loop
		   	
			jr $ra			# retorno main


	fullTela:
		li $t0, 0xff000000
		li $t1, 0xff012c00
		li $t2, 0xF8F8F8F8
		
		tela:
		sw $t2, ($t0)
		addi $t0, $t0, 0x00000004
		
		ble $t0, $t1, tela

		jr $ra 		# retorno main
		
	decompV:
		l.s $f0, Vzero
		
		l.s $f1, cosO
		l.s $f2, senO
		
		mul.s $f30, $f0, $f1	# vx = v * cos
		mul.s $f31, $f0, $f2	# vy = v * sen
		
		mov.s $f0, $f30		# f0 = vx
		mov.s $f1, $f31		# f1 = vy
		
		jr $ra

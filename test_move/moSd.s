.eqv SD_DATA_ADDR 0x00413E00		# ARQUIVO.txt sem header. Addr = Offset.[Caso tenha header Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores l�gicos/f�sicos * tamanho do setor)]. Olhe pelo WinHex o offset do seu cart�o SD
.eqv VGA_INI_ADDR 0xFF000000		# FF000000 - C0   # Endere�o inicial da VGA, mas existe um BUG, que pode ser concertado ao subtrair um offest no endere�o da VGA
.eqv USER_DATA    0x10012000		# Endere�o da SRAM
.eqv VGA_QTD_BYTE 76800

.text
	main:	
		la	$a0, SD_DATA_ADDR	# CARREGA O ENDERENCO INICIAL DO SD CARD
		la	$a1, USER_DATA		# DESTINO DA LEITURA DO CARTAO
 		la	$a2, VGA_QTD_BYTE	# TAMANHO DE BYTES LIDOS , BASICAMENTE O TAMANHO DE UMA IMAGEM 320*240
 	
		li	$v0, 49			# SYSCALL 49 - LEITURA DO SD CARD 
		syscall	
		
		la	$t0, VGA_INI_ADDR	#################################
		la	$t1, USER_DATA		######### Verifica os dados lidos
		li	$t3, VGA_QTD_BYTE
		
		WriteVGA:			#################################
 			lw	$t2, ($t1)	#################################
			sw	$t2, ($t0)	#################################
			addi	$t0, $t0, 4	#################################
			addi	$t1, $t1, 4	#################################
			addi 	$t3, $t3, -4	#################################
						#####################  Print Tela
			slti $t4, $t3, 1	#################################
			beq $t4, $zero, WriteVGA
			
		li $a0, 0x00413E00
		la $a1, USER_DATA
		li $a2, 5270
		li $v0, 49
		syscall
		
		
		
		#la $a0, lut
		li $s4, 0
		li $s6, 0
		
		li $t0, 92
		li $t1, 49
	
		#addi $a0, $a0, 4
		li $a0, 0x10012000		
		move $t2, $zero
		move $t3, $zero

		li $t5, 320
		#mul $t4, $a1, $t5		# 320*x
		mult $s4, $t5
		mflo $t4
		add $t4, $t4, $s6		# +y
		li $t6, 0xFF000000
		add $t6, $t6, $t4    # endere�o inicial de impress�o do sprite
		move $t8, $t6
	
	for1:	beq $t2, $t0, out1

	for2:	beq $t3, $t1, out2
		lb $t7, 0($a0)
		#lb $s2, 0($t6)#
		#sb $s2, 0($s1)#
		sb $t7, 0($t6)
		#addi $s1, $s1, 1
		addi $a0 ,$a0, 1 
		addi $t6, $t6, 1
		addi $t3, $t3, 1
		j for2
	out2:	addi $t6, $t8, 320
		move $t8, $t6
		addi $t2, $t2, 1
		move $t3, $zero
		j for1
	out1:
	li $v0, 10 	################# exit ################
	syscall		#################      ################
	

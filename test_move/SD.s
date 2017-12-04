.eqv SD_DATA_ADDR 0x00413E00		# ARQUIVO.txt sem header. Addr = Offset.[Caso tenha header Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores l�gicos/f�sicos * tamanho do setor)]. Olhe pelo WinHex o offset do seu cart�o SD
.eqv VGA_INI_ADDR 0xFF000000		# FF000000 - C0   # Endere�o inicial da VGA, mas existe um BUG, que pode ser concertado ao subtrair um offest no endere�o da VGA
.eqv USER_DATA    0x10012000		# Endere�o da SRAM
.eqv VGA_QTD_BYTE 76800			# VGA Bytes
	.data
	
	.text
	
Main:
	la	$a0, SD_DATA_ADDR	# CARREGA O ENDERENCO INICIAL DO SD CARD
	la	$a1, USER_DATA		# DESTINO DA LEITURA DO CARTAO
 	la	$a2, VGA_QTD_BYTE	# TAMANHO DE BYTES LIDOS , BASICAMENTE O TAMANHO DE UMA IMAGEM 320*240
 	
	li	$v0, 49			# SYSCALL 49 - LEITURA DO SD CARD 
	syscall				#################################
	
	# Usado para verificar os dados lidos usando o In System Memory Content Editor
	
	la	$t0, VGA_INI_ADDR	#################################
	la	$t1, USER_DATA		######### Verifica os dados lidos
	li	$t3, VGA_QTD_BYTE	#################################
	
		
	WriteVGA:			#################################
 		lw	$t2, ($t1)	#################################
		sw	$t2, ($t0)	#################################
		addi	$t0, $t0, 4	#################################
		addi	$t1, $t1, 4	#################################
		addi 	$t3, $t3, -4	#################################
					#####################  Print Tela
	slti $t4, $t3, 1		#################################
	beq	$t4, $zero, WriteVGA	#################################
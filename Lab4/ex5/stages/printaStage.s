
.eqv SD_DATA_ADDR 0x00404000		# ARQUIVO.txt sem header. Addr = Offset.[Caso tenha header Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores l�gicos/f�sicos * tamanho do setor)]. Olhe pelo WinHex o offset do seu cart�o SD
.eqv VGA_INI_ADDR 0xFEFFFF40		# FF000000 - C0   # Endere�o inicial da VGA, mas existe um BUG, que pode ser concertado ao subtrair um offest no endere�o da VGA
.eqv USER_DATA    0x10012000		# Endere�o da SRAM
.eqv VGA_QTD_BYTE 76800			# VGA Bytes



.data 
STAGE: .word "balrog_bit.txt"
STAGE1: .word "blanka_bit.txt" 
STAGE2: .word "chunli_bit.txt"
STAGE3: .word "dhalsim_bit.txt"
STAGE4: .word "ehonda_bit.txt"
STAGE5: .word "guile_bit.txt"
STAGE6: .word "ken_bit.txt"
STAGE7: .word "mbison_bit.txt"
STAGE8: .word "ryu_bit.txt"
STAGE9: .word "sagat_bit.txt"
STAGE10: .word "vega_bit.txt"
STAGE11: .word "zangief_bit.txt"

.text
# Abre o arquivo
	la $a0,STAGE
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 
	
# Abre o arquivo
	la $a0,STAGE1
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 
	
	
# Abre o arquivo
	la $a0,STAGE2
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 
	
# Abre o arquivo
	la $a0,STAGE3
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 
	
# Abre o arquivo
	la $a0,STAGE4
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 
	
# Abre o arquivo
	la $a0,STAGE5
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 
	
# Abre o arquivo
	la $a0,STAGE6
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 
	
# Abre o arquivo
	la $a0,STAGE7
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 
	
# Abre o arquivo
	la $a0,STAGE8
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 
	
# Abre o arquivo
	la $a0,STAGE9
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 
	
# Abre o arquivo
	la $a0,STAGE10
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 
	
# Abre o arquivo
	la $a0,STAGE11
	li $a1,0
	li $a2,0
	li $v0,13
	syscall



# Le o arquivos para a memoria VGA
	move $a0,$v0
	la $a1,0xFF000000
	li $a2,76800
	li $v0,14
	syscall
	

#Fecha o arquivo
	move $a0,$s1
	li $v0,16
	syscall
	
	li $a0, 500
	li $v0, 32
	syscall 

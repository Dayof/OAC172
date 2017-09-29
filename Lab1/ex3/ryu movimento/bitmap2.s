###############################################
#  Programa de exemplo para bitmap display    #
#  Set 2017				      #
#  Marcus Vinicius			      #
###############################################
.eqv VGA 0xFF000000

.data 
SPRITE: .byte 92,49,0,0
BUFFER: .space 5300
FILE2: .asciiz "parte1.bin"
FILE3: .asciiz "parte2.bin"
FILE4: .asciiz "parte3.bin"
FILE5: .asciiz "parte4.bin"
FILE6: .asciiz "invertido.bin"
FILE7: .asciiz "invertido2.bin"
FILE8: .asciiz "invertido3.bin"
FILE9: .asciiz "invertido4.bin"

.text
	addi $t8, $zero, 20
	move $s0, $zero 
LOOP3: 
	beq $t8, $s0, FORA3
########################################################################################################################
# Abre o arquivo sprite
	la $a0,FILE2  #pega o endereço da imagem
	li $a1,0 #argumento para syscall
	li $a2,0 #argumento para syscall
	li $v0,13 #codigo para ler
	syscall

# Le o sprite para a memoria BUFFER
	move $a0,$v0 #endereço da imagem 
	la $a1,BUFFER #endereço do buffer
	li $a2,5270 #tamanho do buffer
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	

	la $a0,SPRITE #pega o endereço do 
	li $a1,100
	li $a2,40
	jal PrintSprite
	
	j INVERTIDO
	
	li $a0, 110
	li $v0, 32
	syscall

############################################################################################################################

Sprite1:			
# Abre o arquivo sprite
	la $a0,FILE3  #pega o endereço da imagem
	li $a1,0 #argumento para syscall
	li $a2,0 #argumento para syscall
	li $v0,13 #codigo para ler
	syscall

# Le o sprite para a memoria BUFFER
	move $a0,$v0 #endereço da imagem 
	la $a1,BUFFER #endereço do buffer
	li $a2,5270 #tamanho do buffer
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	

	la $a0,SPRITE #pega o endereço do 
	li $a1,100
	li $a2,40
	jal PrintSprite
	
	j INVERTIDO2
	
	li $a0, 110
	li $v0, 32
	syscall
	
#################################################################################################################################	

Sprite2:	
	# Abre o arquivo sprite
	la $a0,FILE4  #pega o endereço da imagem
	li $a1,0 #argumento para syscall
	li $a2,0 #argumento para syscall
	li $v0,13 #codigo para ler
	syscall

# Le o sprite para a memoria BUFFER
	move $a0,$v0 #endereço da imagem 
	la $a1,BUFFER #endereço do buffer
	li $a2,5270 #tamanho do buffer
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	

	la $a0,SPRITE #pega o endereço do 
	li $a1,100
	li $a2,40
	jal PrintSprite
	
	j INVERTIDO3
	
	li $a0, 110
	li $v0, 32
	syscall
	
##################################################################################################################################

Sprite3:
# Abre o arquivo sprite
	la $a0,FILE5  #pega o endereço da imagem
	li $a1,0 #argumento para syscall
	li $a2,0 #argumento para syscall
	li $v0,13 #codigo para ler
	syscall

# Le o sprite para a memoria BUFFER
	move $a0,$v0 #endereço da imagem 
	la $a1,BUFFER #endereço do buffer
	li $a2,5270 #tamanho do buffer
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	

	la $a0,SPRITE #pega o endereço do 
	li $a1,100
	li $a2,40
	jal PrintSprite
	
	li $a0, 110
	li $v0, 32
	syscall
	
	j INVERTIDO4
	
	
FORA3:
	li $v0,10
	syscall
	
###########################################################################################################################

PrintSprite: 
# imprime o sprite na tela
	lb $t0,0($a0)		# TamX
	lb $t1,1($a0)		# TamY
	la $s2, 0xFFFFFFFF
	addi $a0,$a0,4		
	move $t2,$zero
	move $t3,$zero
	
	li $t5,320
	mul $t4,$a1,$t5		# 320*x
	add $t4,$t4,$a2		# +y
	la $t6,VGA
	add $t6,$t6,$t4    # endereço inicial de impressão do sprite
	move $t8,$t6
LOOP1:	beq $t2,$t0,FORA1
LOOP2:	beq $t3,$t1,FORA2
	lb $t7,0($a0)
	sb $s2,0($t6)
	sb $t7,0($t6)
	addi $a0,$a0,1
	addi $t6,$t6,1
	addi $t3,$t3,1
	j LOOP2
FORA2:	addi $t6,$t8,320
	move $t8,$t6
	addi $t2,$t2,1
	move $t3,$zero
	j LOOP1
FORA1:	jr $ra

############################################################################################################################
INVERTIDO: 
	la $a0,FILE6  #pega o endereço da imagem
	li $a1,0 #argumento para syscall
	li $a2,0 #argumento para syscall
	li $v0,13 #codigo para ler
	syscall

# Le o sprite para a memoria BUFFER
	move $a0,$v0 #endereço da imagem 
	la $a1,BUFFER #endereço do buffer
	li $a2,5270 #tamanho do buffer
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	

	la $a0,SPRITE #pega o endereço do 
	li $a1,100
	li $a2,240
	jal PrintSpriteInvertido
		
	j Sprite1
	
	li $a0, 110
	li $v0, 32
	syscall

###########################################################################################################################
INVERTIDO2: 
	la $a0,FILE7  #pega o endereço da imagem
	li $a1,0 #argumento para syscall
	li $a2,0 #argumento para syscall
	li $v0,13 #codigo para ler
	syscall

# Le o sprite para a memoria BUFFER
	move $a0,$v0 #endereço da imagem 
	la $a1,BUFFER #endereço do buffer
	li $a2,5270 #tamanho do buffer
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	

	la $a0,SPRITE #pega o endereço do 
	li $a1,100
	li $a2,240
	jal PrintSpriteInvertido
	
	j Sprite2
	
	li $a0, 110
	li $v0, 32
	syscall

#####################################################################################################################
INVERTIDO3: 
	la $a0,FILE8  #pega o endereço da imagem
	li $a1,0 #argumento para syscall
	li $a2,0 #argumento para syscall
	li $v0,13 #codigo para ler
	syscall

# Le o sprite para a memoria BUFFER
	move $a0,$v0 #endereço da imagem 
	la $a1,BUFFER #endereço do buffer
	li $a2,5270 #tamanho do buffer
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	

	la $a0,SPRITE #pega o endereço do 
	li $a1,100
	li $a2,240
	jal PrintSpriteInvertido
	
	j Sprite3
	
	li $a0, 110
	li $v0, 32
	syscall
	
######################################################################################################################
INVERTIDO4: 
	la $a0,FILE9  #pega o endereço da imagem
	li $a1,0 #argumento para syscall
	li $a2,0 #argumento para syscall
	li $v0,13 #codigo para ler
	syscall

# Le o sprite para a memoria BUFFER
	move $a0,$v0 #endereço da imagem 
	la $a1,BUFFER #endereço do buffer
	li $a2,5270 #tamanho do buffer
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	

	la $a0,SPRITE #pega o endereço do 
	li $a1,100
	li $a2,240
	jal PrintSpriteInvertido
	
	li $a0, 110
	li $v0, 32
	syscall
	
	addi $s0, $s0, 1 
	j LOOP3
	
	
##############################################################################################################################	
PrintSpriteInvertido: 
# imprime o sprite na tela
	lb $t0,0($a0)		# TamX
	lb $t1,1($a0)		# TamY
	la $s2, 0xFFFFFFFF
	addi $a0,$a0,4		
	move $t2,$zero
	move $t3,$zero
	
	li $t5,320
	mul $t4,$a1,$t5		# 320*x
	add $t4,$t4,$a2		# +y
	la $t6,VGA
	add $t6,$t6,$t4    # endereço inicial de impressão do sprite
	move $t8,$t6
LOOP4:	beq $t2,$t0,FORA4
LOOP5:	beq $t3,$t1,FORA5
	lb $t7,0($a0)
	sb $s2,0($t6)
	sb $t7,0($t6)
	addi $a0,$a0,1
	addi $t6,$t6,1
	addi $t3,$t3,1
	j LOOP5
FORA5:	addi $t6,$t8,320
	move $t8,$t6
	addi $t2,$t2,1
	move $t3,$zero
	j LOOP4
FORA4:	jr $ra

##########################################################################################################################
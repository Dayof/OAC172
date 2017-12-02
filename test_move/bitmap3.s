###############################################
#  Programa de exemplo para bitmap display    #
#  Set 2017				      #
#  Marcus Vinicius			      #
###############################################
.eqv VGA 0xFF000000

.data 
SPRITE: .byte 85,62,0,0
BUFFER: .space 5300
FILE1: .asciiz "ken.bin"
FILE2: .asciiz "ryu2.bin"

.text

# Preenche a tela de vermelho

	la $t1,0xFF012C00
	la $s2,0xFF000000
	la $s1,0xF8F8F8F8
LOOP: 	beq $s2,$t1,FORA
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP
FORA:	
# Abre o arquivo com tela de fundo
	la $a0,FILE1
	li $a1,0
	li $a2,0
	li $v0,13
	syscall

# Le o arquivo para a memoria VGA
	move $a0,$v0
	la $a1,VGA
	li $a2,76800
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall


# Abre o arquivo sprite
PULA:	la $a0,FILE2
	li $a1,0
	li $a2,0
	li $v0,13
	syscall

# Le o sprite para a memoria BUFFER
	move $a0,$v0
	la $a1,BUFFER
	li $a2,5270
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	

	la $a0,SPRITE
	li $a1,100
	li $a2,100
	jal PrintSprite
	
	li $v0,10
	syscall

PrintSprite: 
# imprime o sprite na tela
	lb $t0,0($a0)		# TamX
	lb $t1,1($a0)		# TamY
	
	addi $a0,$a0,4		
	move $t2,$zero
	move $t3,$zero

	li $t5,320
	mul $t4,$a1,$t5		# 320*x
	add $t4,$t4,$a2		# +y
	la $t6,VGA
	add $t6,$t6,$t4    # endere�o inicial de impress�o do sprite
	move $t8,$t6
	
LOOP1:	beq $t2,$t0,FORA1
LOOP2:	beq $t3,$t1,FORA2
	lb $t7,0($a0)
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

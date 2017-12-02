.eqv VGA 0xFF000000

.data

	lutador: .byte 92,49,0,0
	buf: .space 5300
	bufe:	.byte 92,49,0,0
	salvo: .space 5300
	
	f1:  .asciiz "ken.bin"
	f2: .asciiz "parte1.bin"
	f3: .asciiz "parte2.bin"
	f4: .asciiz "parte3.bin"
	f5: .asciiz "parte4.bin"
	
.text
	main:	
		# Abre o arquivo com tela de fundo
		la $a0, f1
		li $a1, 0
		li $a2, 0
		li $v0, 13
		syscall
		# Le o arquivo para a memoria VGA
		move $a0, $v0
		la $a1, VGA
		li $a2, 76800
		li $v0, 14
		syscall
		#Fecha o arquivo
		li $v0, 16
		syscall
		
	    mov:
		# Abre o arquivo sprite
		la $a0, f2
		li $a1, 0
		li $a2, 0
		li $v0, 13
		syscall
		# Le o sprite para a memoria BUFFER
		move $a0, $v0
		la $a1, buf
		li $a2, 5270
		li $v0, 14
		syscall
		#Fecha o arquivo
		li $v0, 16
		syscall

		la $a0, lutador
		li $a1, 100
		li $a2, 100
		la $s1, salvo
		jal PrintLutador
		
		la $a0, bufe
		li $a1, 100
		li $a2, 100
		jal PrintBuffer
		
		# Abre o arquivo sprite
		la $a0, f3
		li $a1, 0
		li $a2, 0
		li $v0, 13
		syscall
		# Le o sprite para a memoria BUFFER
		move $a0, $v0
		la $a1, buf
		li $a2, 5270
		li $v0, 14
		syscall
		#Fecha o arquivo
		li $v0, 16
		syscall

		la $a0, lutador
		li $a1, 100
		li $a2, 100
		la $s1, salvo
		jal PrintLutador
		
		la $a0, bufe
		li $a1, 100
		li $a2, 100
		jal PrintBuffer
		
		# Abre o arquivo sprite
		la $a0, f4
		li $a1, 0
		li $a2, 0
		li $v0, 13
		syscall
		# Le o sprite para a memoria BUFFER
		move $a0, $v0
		la $a1, buf
		li $a2, 5270
		li $v0, 14
		syscall
		#Fecha o arquivo
		li $v0, 16
		syscall

		la $a0, lutador
		li $a1, 100
		li $a2, 100
		la $s1, salvo
		jal PrintLutador
		
		la $a0, bufe
		li $a1, 100
		li $a2, 100
		jal PrintBuffer
		
		# Abre o arquivo sprite
		la $a0, f5
		li $a1, 0
		li $a2, 0
		li $v0, 13
		syscall
		# Le o sprite para a memoria BUFFER
		move $a0, $v0
		la $a1, buf
		li $a2, 5270
		li $v0, 14
		syscall
		#Fecha o arquivo
		li $v0, 16
		syscall

		la $a0, lutador
		li $a1, 100
		li $a2, 100
		la $s1, salvo
		jal PrintLutador
		
		la $a0, bufe
		li $a1, 100
		li $a2, 100
		jal PrintBuffer
		
		j mov
	
	
	li $v0, 10 	################# exit ################
	syscall		#################      ################
	

		
PrintLutador: 
# imprime o sprite na tela
	lb $t0, 0($a0)		# TamX
	lb $t1, 1($a0)		# TamY
	
	addi $a0, $a0, 4		
	move $t2, $zero
	move $t3, $zero

	li $t5, 320
	mul $t4, $a1, $t5		# 320*x
	add $t4, $t4, $a2		# +y
	la $t6, VGA
	add $t6, $t6, $t4    # endere�o inicial de impress�o do sprite
	move $t8, $t6
	
for1:	beq $t2, $t0, out1

for2:	beq $t3, $t1, out2
	lb $t7, 0($a0)
	lb $s2, 0($t6)#
	sb $s2, 0($s1)#
	sb $t7, 0($t6)
	addi $s1, $s1, 1
	addi $a0 ,$a0, 1 
	addi $t6, $t6, 1
	addi $t3, $t3, 1
	j for2
out2:	addi $t6, $t8, 320
	move $t8, $t6
	addi $t2, $t2, 1
	move $t3, $zero
	j for1
out1:	jr $ra

PrintBuffer:
# imprime o sprite na tela
	lb $t0, 0($a0)		# TamX
	lb $t1, 1($a0)		# TamY
	
	addi $a0, $a0, 4		
	move $t2, $zero
	move $t3, $zero

	li $t5, 320
	mul $t4, $a1, $t5		# 320*x
	add $t4, $t4, $a2		# +y
	la $t6, VGA
	add $t6, $t6, $t4    # endere�o inicial de impress�o do sprite
	move $t8, $t6
	
for12:	beq $t2, $t0, out12

for22:	beq $t3, $t1, out22
	lb $t7, 0($a0)
	sb $t7, 0($t6)
	addi $a0 ,$a0, 1 
	addi $t6, $t6, 1
	addi $t3, $t3, 1
	j for22
out22:	addi $t6, $t8, 320
	move $t8, $t6
	addi $t2, $t2, 1
	move $t3, $zero
	j for1
out12:	jr $ra

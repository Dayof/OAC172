.data
$LC0:
	.ascii	"\n"
v:
	.word	5
	.word	8
	.word	3
	.word	4
	.word	7
	.word	6
	.word	8
	.word	0
	.word	1
	.word	9
.text
main:
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	la	$4,v # lui	$16,%hi(v) and addiu	$4,$16,%lo(v)
	sw	$31,20($sp)
	jal	show
	li	$5,10			# 0xa

	la	$4,v # addiu	$4,$16,%lo(v)
	jal	sort
	li	$5,10			# 0xa

	lw	$31,20($sp)
	la	$4,v # addiu	$4,$16,%lo(v)
	lw	$16,16($sp)
	li	$5,10			# 0xa
	jal	show
	addiu	$sp,$sp,24

	li	$2,10
	syscall
	nop
show:
	addiu	$sp,$sp,-40
	sw	$18,28($sp)
	sw	$31,36($sp)
	sw	$19,32($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	blez	$5,$L3
	move	$18,$5

	#lui	$19,%hi($LC0)
	move	$17,$4
	move	$16,$0
	#addiu	$19,$19,%lo($LC0)
$L4:
	lw	$5,0($17)
	#move	$4,$19
	#jal	printf
	addiu	$16,$16,1

	bne	$16,$18,$L4
	addiu	$17,$17,4

$L3:
	lw	$31,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	#li	$4,10			# 0xa
	#j	putchar
	addiu	$sp,$sp,40
swap:
	sll	$5,$5,2
	addiu	$2,$5,4
	addu	$5,$4,$5
	addu	$4,$4,$2
	lw	$3,0($4)
	lw	$2,0($5)
	sw	$3,0($5)
	jr	$31
	sw	$2,0($4)
sort:
	blez	$5,$L18
	move	$10,$0

	addiu	$12,$5,-1
	move	$2,$4
	li	$9,-1			# 0xffffffffffffffff
	beq	$10,$12,$L18
	move	$3,$10

$L15:
	bltz	$10,$L12
	addiu	$11,$2,4

	lw	$4,0($2)
	lw	$5,4($2)
	addiu	$11,$2,4
	slt	$6,$5,$4
	beq	$6,$0,$L12
	move	$8,$11

	j	$L14
	move	$6,$2

$L17:
	lw	$4,-4($6)
	lw	$5,4($2)
	move	$8,$7
	slt	$7,$5,$4
	beq	$7,$0,$L12
	move	$6,$2

$L14:
	addiu	$3,$3,-1
	sw	$5,0($2)
	move	$7,$6
	addiu	$2,$6,-4
	bne	$3,$9,$L17
	sw	$4,0($8)

$L12:
	addiu	$10,$10,1
	move	$2,$11
	bne	$10,$12,$L15
	move	$3,$10

$L18:
	jr	$31
	nop


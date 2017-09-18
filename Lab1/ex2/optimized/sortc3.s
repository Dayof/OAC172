.data
$LC0:
	.ascii	"%d\011\000"
	.align	2
	.globl	show
.text
show:
	addiu	$sp,$sp,-40
	sw	$18,28($sp)
	sw	$31,36($sp)
	sw	$19,32($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	blez	$5,$L3
	move	$18,$5

	la	$19, $LC0     
	move	$17,$4
	move	$16,$0
$L4:
	lw	$5,0($17)
	move	$4,$19
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
	li	$4,10			# 0xa
	#j	putchar
	addiu	$sp,$sp,40

	.globl	swap
swap:
	sll	$a1,$a1,2
	addiu	$v0,$a1,4
	addu	$a1,$a0,$a1
	addu	$a0,$a0,$v0
	lw	$v1,0($a0)
	lw	$v0,4($a0)
	sw	$v1,0($a0)
	jr	$ra
	sw	$v0,0($a0)

	.globl	sort
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

	.globl	main
main:
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	la	$4, v
	sw	$31,20($sp)
	jal	show
	li	$5,10			# 0xa

	la	$4, v
	jal	sort
	li	$5,10			# 0xa

	lw	$31,20($sp)
	la	$4, v
	lw	$16,16($sp)
	li	$5,10			# 0xa
	j	show
	addiu	$sp,$sp,24

	.globl	v
	.data
	.align	2
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

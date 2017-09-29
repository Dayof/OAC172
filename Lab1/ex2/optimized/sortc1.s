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
	sw	$31,20($sp)
	sw	$16,16($sp)
	la $4, v # lui	$16,%hi(v), addiu	$4,$16,%lo(v)
	jal	show
	li	$5,10			# 0xa

	la $4, v # lui	$16,%hi(v), addiu	$4,$16,%lo(v)
	jal	sort
	li	$5,10			# 0xa

	la $4, v # lui	$16,%hi(v), addiu	$4,$16,%lo(v)
	# addiu	$4,$16,%lo(v)
	jal	show
	li	$5,10			# 0xa
	
	li	$2,10 # end program
	syscall
	nop
	
	#lw	$31,20($sp)
	#lw	$16,16($sp)
	#jr	$31
	#addiu	$sp,$sp,24
show:
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$19,32($sp)
	sw	$18,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	blez	$5,$L2
	move	$18,$5

	move	$17,$4
	move	$16,$0
	# la $19, $LC0 # lui	$19,%hi($LC0), addiu	$19,$19,%lo($LC0)
$L3:
	# move	$4,$19
	# jal	printf
	lw	$5,0($17)

	addiu	$16,$16,1
	bne	$16,$18,$L3
	addiu	$17,$17,4

$L2:
	# jal	putchar
	# li	$4,10			# 0xa

	lw	$31,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,40
	
swap:
	sll	$5,$5,2
	addu	$2,$4,$5
	lw	$3,0($2)
	addiu	$5,$5,4
	addu	$4,$4,$5
	lw	$5,0($4)
	sw	$5,0($2)
	jr	$31
	sw	$3,0($4)
	
sort:
	blez	$5,$L14
	nop

	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$18,$4
	move	$20,$4
	addiu	$22,$5,-1
	move	$21,$0
	j	$L8
	li	$19,-1			# 0xffffffffffffffff

$L11:
	bltz	$16,$L9
	nop

	lw	$3,0($20)
	lw	$2,4($20)
	slt	$2,$2,$3
	beq	$2,$0,$L9
	move	$4,$18

	move	$17,$20
$L15:
	jal	swap
	move	$5,$16

	addiu	$16,$16,-1
	beq	$16,$19,$L9
	nop

	lw	$3,-4($17)
	addiu	$17,$17,-4
	lw	$2,4($17)
	slt	$2,$2,$3
	bne	$2,$0,$L15
	move	$4,$18

$L9:
	addiu	$21,$21,1
	addiu	$20,$20,4
$L8:
	bne	$21,$22,$L11
	move	$16,$21

	lw	$31,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addiu	$sp,$sp,48
$L14:
	jr	$31
	nop


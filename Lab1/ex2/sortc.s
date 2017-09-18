.data
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

$LC0:
  .ascii	"\n"       # alterado de "%d\011\000" para "\n"
  .globl	main

.text
main:
  addiu	$sp,$sp,-24
  sw	$31,20($sp)
  sw	$fp,16($sp)
  move	$fp,$sp
  la	$a0, v			  # substitui lui	$2,%hi(v) e addiu $4,$2,%lo(v)
  li	$5,10
  jal	show
  nop

  la	$a0, v			  # substitui lui	$2,%hi(v) e addiu $4,$2,%lo(v)
  li	$5,10
  jal	sort
  nop

  la	$a0, v			  # substitui lui	$2,%hi(v) e addiu $4,$2,%lo(v)
  li	$5,10
  jal	show
  nop

  li 	$v0,10			 # adicionado para encerrar a execucao ao final do main
  syscall

show:
  addiu	$sp,$sp,-32
  sw	$31,28($sp)
  sw	$fp,24($sp)
  move	$fp,$sp
  sw	$4,32($fp)
  sw	$5,36($fp)
  sw	$0,16($fp)
  j	$L2
  nop

$L3:
  lw	$2,16($fp)
  sll	$2,$2,2
  lw	$3,32($fp)
  addu	$2,$3,$2
  lw	$2,0($2)

  move	$4,$2			 # alterado de $5 para $4 para imprimir os valores do vetor
  li	$2, 1			   # substitui o printf para imprimir os valores do vetor
  syscall

  lw	$2,16($fp)
  addiu	$2,$2,1
  sw	$2,16($fp)

$L2:
  lw	$3,16($fp)
  lw	$2,36($fp)
  slt	$2,$3,$2
  bne	$2,$0,$L3
  nop

  la	$4,$LC0			 # substitui lui	$3,%hi($LC0) e addiu	$4,$3,%lo($LC0)
  li	$2,4         # substitui putchar para imprimir "\n" (newline)
  syscall
  nop

  move	$sp,$fp
  lw	$31,28($sp)
  lw	$fp,24($sp)
  addiu	$sp,$sp,32
  jr	$31			     # troca de j para jr
  nop

  .globl	swap
swap:
  addiu	$sp,$sp,-16
  sw	$fp,12($sp)
  move	$fp,$sp
  sw	$4,16($fp)
  sw	$5,20($fp)
  lw	$2,20($fp)
  sll	$2,$2,2
  lw	$3,16($fp)
  addu	$2,$3,$2
  lw	$2,0($2)
  sw	$2,0($fp)
  lw	$2,20($fp)
  sll	$2,$2,2
  lw	$3,16($fp)
  addu	$2,$3,$2
  lw	$3,20($fp)
  addiu	$3,$3,1
  sll	$3,$3,2
  lw	$4,16($fp)
  addu	$3,$4,$3
  lw	$3,0($3)
  sw	$3,0($2)
  lw	$2,20($fp)
  addiu	$2,$2,1
  sll	$2,$2,2
  lw	$3,16($fp)
  addu	$2,$3,$2
  lw	$3,0($fp)
  sw	$3,0($2)
  move	$sp,$fp
  lw	$fp,12($sp)
  addiu	$sp,$sp,16
  jr	$31          # troca de j para jr
  nop

  .globl	sort
sort:
  addiu	$sp,$sp,-32
  sw	$31,28($sp)
  sw	$fp,24($sp)
  move	$fp,$sp
  sw	$4,32($fp)
  sw	$5,36($fp)
  sw	$0,16($fp)
  j	$L6
  nop

$L10:
  lw	$2,16($fp)
  addiu	$2,$2,-1
  sw	$2,20($fp)
  j	$L7
  nop

$L9:
  lw	$4,32($fp)
  lw	$5,20($fp)
  jal	swap
  nop

  lw	$2,20($fp)
  addiu	$2,$2,-1
  sw	$2,20($fp)
  $L7:
  lw	$2,20($fp)
  bltz	$2,$L8
  nop

  lw	$2,20($fp)
  sll	$2,$2,2
  lw	$3,32($fp)
  addu	$2,$3,$2
  lw	$3,0($2)
  lw	$2,20($fp)
  addiu	$2,$2,1
  sll	$2,$2,2
  lw	$4,32($fp)
  addu	$2,$4,$2
  lw	$2,0($2)
  slt	$2,$2,$3
  bne	$2,$0,$L9
  nop

$L8:
  lw	$2,16($fp)
  addiu	$2,$2,1
  sw	$2,16($fp)
  $L6:
  lw	$3,16($fp)
  lw	$2,36($fp)
  slt	$2,$3,$2
  bne	$2,$0,$L10
  nop

  move	$sp,$fp
  lw	$31,28($sp)
  lw	$fp,24($sp)
  addiu	$sp,$sp,32
  jr	$31          # troca de j para jr
  nop

<<<<<<< HEAD
.data 
FINISH: .asciiz "finish"
=======
.data

>>>>>>> 838c6e0fcb8d6e815865e944599b1d7bb97b853a
.text
	addd:
		lui $at, 0x0000
		ori $t0, $at, 8
		lui $at, 0x0000
		ori $t1, $at, 4
		add $t0, $t0, $t1
		beq $t0, 12, mull
		jal end

	mull:
		lui $at, 0x0000
		ori $t0, $at, 5
		lui $at, 0x0000
		ori $t1, $at, 4
		mult $t0, $t1
		mflo $t0
		beq $t0, 20, subb
		jal end

	subb:
		lui $at, 0x0000
		ori $t0, $at, 5
		lui $at, 0x0000
		ori $t1, $at, 9
		sub $t0, $t0, $t1
		beq $t0,-4, andd
		jal end

	andd:
		lui $at, 0x0000
		ori $t0, $at, 1
		lui $at, 0x0000
		ori $t1, $at, 4
		and $t0, $t0, $t1
		beq $t0, 0, orr
		jal end

	orr:
		lui $at, 0x0000
		ori $t0, $at, 1
		lui $at, 0x0000
		ori $t1, $at, 4
		or $t0,$t0,$t1
		beq $t0,5,mfhii
		jal end

	mfhii:
		mfhi $t0
		beq $t0, 0, mfloo
		jal end

	mfloo:
		mflo $t0
		beq $t0, 20, slll
		jal end

	slll:
		lui $at, 0x0000
		ori $t0, $at, 1
		sll $t0, $t0, 3
		beq $t0, 8, srll
		jal end

	srll:
		lui $at, 0x0000
		ori $t0, $at, 8
		srl $t0, $t0, 3
		beq $t0, 1, sraa
		jal end

	sraa:
		lui $at, 0x0000
		ori $t0, $at, 8
		sra $t1, $t0, 3
		beq $t1, 1, sravv
		jal end

	sravv:
		lui $at, 0x0000
		ori $t0, $at, 8
		lui $at, 0x0000
		ori $t1, $at, 3
		srav $t0, $t0, $t1
		beq $t0, 1, sllvv
		jal end

	sllvv:
		lui $at, 0x0000
		ori $t0, $at, 1
		lui $at, 0x0000
		ori $t1, $at, 3
		sllv $t0, $t0, $t1
		beq $t0, 8, srlvv
		jal end

	srlvv:
		lui $at, 0x0000
		ori $t0, $at, 8
		lui $at, 0x0000
		ori $t1, $at, 3
		srlv $t0, $t0, $t1
		beq $t0, 1, xorr
		jal end

	xorr:
		lui $at, 0x0000
		ori $t0, $at, 8
		lui $at, 0x0000
		ori $t1, $at, 3
		xor $t0, $t0, $t1
		beq $t0, 11, norr
		jal end

	norr:
		lui $at, 0x0000
		ori $t0, $at, 4
		lui $at, 0x0000
		ori $t1, $at, 5
		nor $t0, $t0, $t1
		beq $t0, 0xfffffffa, fish
		jal end

		j fish
end:
	la $a0, FINISH
	li $v0, 4
	syscall 
	j fish
	
fish:
	li $v0, 10
	syscall 

	addd:
		lui $at, 0x0000
		ori $t0, $at, 8
		lui $at, 0x0000
		ori $t1, $at, 4
		#li $t0, 8
		#li $t1, 4
		add $t0, $t0, $t1
		beq $t0, 12, mull
		jal end

	mull:
		lui $at, 0x0000
		ori $t0, $at, 5
		lui $at, 0x0000
		ori $t1, $at, 4
		#li $t0, 5
		#li $t1, 4
		mul $t0, $t0, $t1
		beq $t0, 20, subb
		jal end

	subb:
		lui $at, 0x0000
		ori $t0, $at, 5
		lui $at, 0x0000
		ori $t1, $at, 9
		#li $t0, 5
		#li $t1, 9
		sub $t0, $t0, $t1
		beq $t0,-4, andd
		jal end

	andd:
		lui $at, 0x0000
		ori $t0, $at, 1
		lui $at, 0x0000
		ori $t1, $at, 4
		#li $t0, 1
		#li $t1, 4
		and $t0, $t0, $t1
		beq $t0, 0, orr
		jal end

	orr:
		lui $at, 0x0000
		ori $t0, $at, 1
		lui $at, 0x0000
		ori $t1, $at, 4
		#li $t0,1
		#li $t1,4
		or $t0,$t0,$t1
		beq $t0,5,mfhii
		jal end

	mfhii:
		mfhi $t0
		beq $t0, 0, mfloo
		jal end

	mfloo:
		mflo $t0
		beq $t0, 8, slll
		jal end

	slll:
		lui $at, 0x0000
		ori $t0, $at, 1
		#li $t0, 1
		sll $t0, $t0, 3
		beq $t0, 8, srll
		jal end

	srll:
		lui $at, 0x0000
		ori $t0, $at, 8
		#li $t0, 8
		srl $t0, $t0, 3
		beq $t0, 1, sraa
		jal end

	sraa:
		lui $at, 0x0000
		ori $t0, $at, 8
		#li $t0, 8
		sra $t0, $t0, 3
		beq $t0, 1, sravv
		jal end

	sravv:
		lui $at, 0x0000
		ori $t0, $at, 8
		lui $at, 0x0000
		ori $t1, $at, 3
		#li $t0, 8
		#li $t1, 3
		srav $t0, $t0, $t1
		beq $t0, 1, sllvv
		jal end

	sllvv:
		lui $at, 0x0000
		ori $t0, $at, 1
		lui $at, 0x0000
		ori $t1, $at, 3
		#li $t0, 1
		#li $t1, 3
		sllv $t0, $t0, $t1
		beq $t0, 8, srlvv
		jal end

	srlvv:
		lui $at, 0x0000
		ori $t0, $at, 8
		lui $at, 0x0000
		ori $t1, $at, 3
		#li $t0, 8
		#li $t1, 3
		srlv $t0, $t0, $t1
		beq $t0, 1, xorr
		jal end

	xorr:
		lui $at, 0x0000
		ori $t0, $at, 8
		lui $at, 0x0000
		ori $t1, $at, 3
		#li $t0, 8
		#li $t1, 3
		xor $t0, $t0, $t1
		beq $t0, 11, norr
		jal end

	norr:
		lui $at, 0x0000
		ori $t0, $at, 8
		lui $at, 0x0000
		ori $t1, $at, 3
		#li $t0, 8
		#li $t1, 3
		nor $t0, $t0, $t1
		beq $t0, 0xFFFFFFF4, srll
		jal end

end:
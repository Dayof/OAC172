/*
 * Bloco de Controle MULTICICLO
 *
 */			
module Control_MULTI (
	/* I/O type definition */
	input wire iCLK, iRST,//, iSleepDone;
	input wire [5:0] iOp, iFunct,// iV0;
	input wire [4:0] iFmt, iRt,//;		// 1/2016. Adicionado iRt.
	input wire iFt,
	output wire oIRWrite, oMemtoReg, oMemWrite, oMemRead, oIorD, oPCWrite, oPCWriteBEQ, oPCWriteBNE,
oRegWrite, oRegDst, oFPPCWriteBc1t, oFPPCWriteBc1f, oFPRegWrite, oFPFlagWrite, oFPU2Mem, //oSleepWrite, 
	output wire [1:0] oALUOp, oALUSrcA, oFPDataReg, oFPRegDst,
	output wire [2:0] oALUSrcB, oPCSource, oStore,
	output wire [5:0] oState,
	//Adicionado em 1/2014
	output wire [2:0] oLoadCase,
	output wire [1:0] oWriteCase,
	// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
	input iCOP0ALUoverflow, iCOP0FPALUoverflow, iCOP0FPALUunderflow, iCOP0FPALUnan, iCOP0UserMode, iCOP0ExcLevel,
	input [7:0] iCOP0PendingInterrupt,
	output oCOP0PCOriginalWrite,
	output reg oCOP0RegWrite, oCOP0Eret, oCOP0ExcOccurred,
	output oCOP0BranchDelay,
	output [4:0] oCOP0ExcCode,
	output oCOP0Interrupted,
	//Adicionado em 2017/1
	input iFPBusy,
	output oFPStart
	);


reg [40:0] word;			
reg [5:0] pr_state, nx_state;

assign   oFPStart = word[40];

assign	oWriteCase = word[39:38];		//  1/2014
assign	oLoadCase = word[37:35];		//  1/2014
assign	oFPRegDst = word[34:33];
assign	oFPDataReg = word[32:31];
assign	oFPRegWrite = word[30];
assign	oFPPCWriteBc1t = word[29];
assign	oFPPCWriteBc1f = word[28];
assign	oFPFlagWrite = word[27];
assign	oFPU2Mem = word[26];
//assign	oClearJAction = word[25]; // Disponivel
//assign	oJReset 	= word[24];  // Disponivel
//assign	oSleepWrite = word[23]; // Disponivel
assign	oStore		= word[22:20];
assign	oPCWrite	= word[19];
assign	oPCWriteBNE	= word[18];
assign	oPCWriteBEQ	= word[17];
assign	oIorD		= word[16];
assign	oMemRead	= word[15];
assign	oMemWrite	= word[14];
assign	oIRWrite	= word[13];
assign	oMemtoReg	= word[12];
assign	oPCSource	= word[11:9];
assign	oALUOp		= word[8:7];
assign	oALUSrcB	= word[6:4];
assign	oALUSrcA	= word[3:2];
assign	oRegWrite	= word[1];
assign	oRegDst		= word[0];

assign	oState		= pr_state;

// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
assign 	oCOP0PCOriginalWrite = pr_state != COP0EXC;
assign 	oCOP0Interrupted = pr_state == COP0EXC && oCOP0ExcCode == EXCODEINT;

initial
begin
	pr_state	<= FETCH;
end

// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
wire wCOP0PendingInterrupt;
assign oCOP0BranchDelay = iOp == OPCBEQ || iOp == OPCBNE || iOp == OPCJMP || iOp == OPCJAL || (iOp == OPCRFMT && iFunct == FUNJR) || (iOp == OPCFLT && iFmt == FMTBC1);
assign wCOP0PendingInterrupt = iCOP0PendingInterrupt != 8'b0 && ~iCOP0ExcLevel;

/* Main control block */
always @(posedge iCLK or posedge iRST)
begin
	if (iRST)
		pr_state	<= FETCH;
	else
		pr_state	<= nx_state;
end

// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
always @(*)
begin
	if (iOp == OPCRFMT && iFunct == FUNSYS)
		oCOP0ExcCode <= EXCODESYS;
	else if ((iOp == OPCRFMT && (iFunct == FUNADD || iFunct == FUNSUB) || iOp == OPCADDI) && iCOP0ALUoverflow)
		oCOP0ExcCode <= EXCODEALU;
	else if (
		iOp == OPCFLT && 
		(
			(((iFmt == FMTW && iFunct == FUNCVTSW) || (iFmt == FMTS && (iFunct == FUNADDS || iFunct == FUNSUBS || iFunct == FUNMULS || iFunct == FUNDIVS))) && (iCOP0FPALUoverflow || iCOP0FPALUunderflow)) ||
			(iFmt == FMTW && iFunct == FUNCVTWS && iCOP0FPALUoverflow)
		)
	)
		oCOP0ExcCode <= EXCODEFPALU;
	else if (iOp == OPCCOP0)
		oCOP0ExcCode <= EXCODEINSTR;
	else if (wCOP0PendingInterrupt)
		oCOP0ExcCode <= EXCODEINT;
	else
		oCOP0ExcCode <= EXCODEINSTR;
end

always @(*)
begin
	// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
	oCOP0RegWrite <= pr_state == COP0MTC0;
	oCOP0Eret <= pr_state == COP0ERET;
	oCOP0ExcOccurred <= pr_state == COP0EXC;
	// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
	
	case (pr_state)
	
		FETCH:
		begin
			word	<= 41'b00000000000000000000010001010000000010000;
			nx_state	<= DECODE;
		end
		
		DECODE:
		begin
			word	<= 41'b00000000000000000000000000000000000110000;
			case (iOp)
				OPCRM: 	// Grupo 2 - (2/2016)
					if (iFunct == FUNMADD || iFunct == FUNMSUB || iFunct == FUNMADDU || iFunct == FUNMSUBU)
						nx_state	<= nx_state <= wCOP0PendingInterrupt ? COP0EXC : RM;
					else
						if (iFunct== FUNMUL)
							nx_state	<= MUL;
						else
							nx_state <= FETCH;
						
				OPCRFMT:
					case (iFunct)
						FUNJR: 						nx_state <= wCOP0PendingInterrupt ? COP0EXC : JR;
						FUNJALR:						nx_state <= wCOP0PendingInterrupt ? COP0EXC : JALR;
						FUNSLL, FUNSRL, FUNSRA: nx_state	<= SHIFT;
						FUNSYS: 						nx_state	<= iCOP0UserMode ? COP0EXC : FETCH;
						default:						nx_state	<= RFMT;
					endcase
							
					
				OPCJMP:
					nx_state	<= wCOP0PendingInterrupt ? COP0EXC : JUMP;
				OPCBEQ:
					nx_state	<= wCOP0PendingInterrupt ? COP0EXC : BEQ;
				OPCBNE:
					nx_state	<= wCOP0PendingInterrupt ? COP0EXC : BNE;
				OPCJAL:
					nx_state	<= wCOP0PendingInterrupt ? COP0EXC : JAL;

				//operações implementadas em 1/2016 - bgtz, blez, bgez, bgezal, bgltz, bltzal.
				OPCBGTZ:
					nx_state	<= wCOP0PendingInterrupt ? COP0EXC : BGTZ;
				OPCBLEZ:
					nx_state	<= wCOP0PendingInterrupt ? COP0EXC : BLEZ;
				OPCBGE_LTZ:
					case (iRt)
						RTBGEZ:
							nx_state	<= wCOP0PendingInterrupt ? COP0EXC : BGEZ;
						RTBGEZAL:
							nx_state	<= wCOP0PendingInterrupt ? COP0EXC : BGEZAL;
						RTBLTZ:
							nx_state	<= wCOP0PendingInterrupt ? COP0EXC : BLTZ;
						RTBLTZAL:
							nx_state	<= wCOP0PendingInterrupt ? COP0EXC : BLTZAL;
						default:
							nx_state	<= ERRO;
					endcase
				
				//operaçoes adicionadas em 1/2014
				OPCLB,
				OPCLBU,
				OPCLH,
				OPCLHU,
				OPCSB,
				OPCSH,
				OPCLW,
				OPCSW,
				OPCLWC1,	//Load e Store da FPU
				OPCSWC1:
					nx_state	<= LWSW;

				OPCANDI,
				OPCORI,
				OPCXORI:
					nx_state	<= IFMTL;
					
				OPCADDI,
				OPCADDIU,
				OPCSLTI,
				OPCSLTIU,
				OPCLUI:
					nx_state	<= IFMTA;
					
				OPCFLT:
					case (iFmt)
						FMTMTC:
							nx_state <= FPUMTC1;
						FMTMFC:
							nx_state <= FPUMFC1;
						FMTBC1:
						begin
							if (wCOP0PendingInterrupt)
								nx_state <= COP0EXC;
							else if (iFt)
								nx_state <= FPUBC1T;
							else
								nx_state <= FPUBC1F;
						end
						FMTW,
						FMTS:
							case(iFunct)
								FUNMOV:
									nx_state	<= FPUMOV;
								FUNCEQ,
								FUNCLT,
								FUNCLE:
									nx_state	<= FPUCOMP;
								default:
									nx_state	<= FPUFRSTART;
							endcase
						default:
							nx_state <= COP0EXC;
					endcase
					
				// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
				OPCCOP0:
				begin
					case (iFmt)
						FMTMTC:
							nx_state <= iCOP0UserMode ? COP0EXC : COP0MTC0;
						FMTMFC:
							nx_state <= iCOP0UserMode ? COP0EXC : COP0MFC0;
						FMTERET:
							nx_state <= (iFunct != FUNERET) || iCOP0UserMode ? COP0EXC : COP0ERET;
						default:
							nx_state <= COP0EXC;
					endcase
				end
				// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
				
				default:
					nx_state	<= COP0EXC;
			endcase
		end
		
		FPUMTC1:
		begin
			word	<= 41'b00000001101000000000000000000000000000000;
			nx_state	<= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		FPUMFC1:
		begin
			word	<= 41'b00000000000000000010100000000000000000010;
			nx_state <= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		FPUBC1T:
		begin
			word	<= 41'b00000000000100000000000000000001000000000;
			nx_state <= FETCH;
		end
		
		FPUBC1F:
		begin
			word	<= 41'b00000000000010000000000000000001000000000;
			nx_state <= FETCH;
		end
		
		FPUMOV:
		begin
			word	<= 41'b00000000111000000000000000000000000000000;
			nx_state <= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		FPUCOMP:
		begin
			word	<= 41'b00000000000001000000000000000000000000000;
			nx_state <= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		FPUFRSTART:
		begin
			word	<= 41'b10000000000000000000000000000000000000000;
			nx_state <= FPUFRWAIT;
		end
		
		FPUFRWAIT:
		begin
			word	<= 41'b00000000000000000000000000000000000000000;
			nx_state <= iFPBusy ? FPUFRWAIT : FPUFR2;
		end
		
		FPUFR2:
		begin
			word	<= 41'b00000000001000000000000000000000000000000;
			if (
				wCOP0PendingInterrupt ||
				(
					(
						(((iFmt == FMTW && iFunct == FUNCVTSW) || (iFmt == FMTS && (iFunct == FUNADDS || iFunct == FUNSUBS || iFunct == FUNMULS || iFunct == FUNDIVS))) && (iCOP0FPALUoverflow || iCOP0FPALUunderflow)) ||
						(iFmt == FMTW && iFunct == FUNCVTWS && iCOP0FPALUoverflow)
					) &&
					~iCOP0ExcLevel
				)
			)
				nx_state <= COP0EXC;
			else
				nx_state <= FETCH;
		end
		
		LWSW:
		begin
			word	<= 41'b00000000000000000000000000000000000100100;
			/****DUVIDA AQUI***/
			case (iOp)
				OPCLW,				
				OPCLB,OPCLBU,OPCLH,OPCLHU,		// 1/2014
				OPCLWC1:
					nx_state	<= LW;
				OPCSB:								// 1/2014
					nx_state <= STATE_SB;		// 1/2014
				OPCSH:								// 1/2014
					nx_state <= STATE_SH;		// 1/2014
				OPCSW:
					nx_state	<= SW;
				OPCSWC1:
					nx_state	<= FPUSWC1;
				default:
					nx_state	<= ERRO;
			endcase
		end
		LW:
		begin
			word	<= 41'b00000000000000000000000011000000000000000;
			case (iOp)
				OPCLW:
					nx_state	<= LW2;
				OPCLWC1:
					nx_state	<= FPULWC1;
				
				//Listinha de casos 1/2014
				OPCLB:
					nx_state <= STATE_LB;
				OPCLBU:
					nx_state <= STATE_LBU;
				OPCLH:
					nx_state <= STATE_LH;
				OPCLHU:
					nx_state <= STATE_LHU;
				
				default:
					nx_state	<= ERRO;
			endcase
		end
		
		FPULWC1:
		begin
			word	<= 41'b00000010011000000000000000000000000000000;
			nx_state	<= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		FPUSWC1:
		begin
			word	<= 41'b00000000000000100000000010100000000000000;
			nx_state	<= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		LW2:
		begin
			word	<= 41'b00000000000000000000000000001000000000010;
			nx_state	<= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		STATE_LB:
		begin
			word	<= 41'b00001100000000000000000000001000000000010;
			nx_state	<= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		STATE_LBU:
		begin
			word	<= 41'b00010000000000000000000000001000000000010;
			nx_state	<= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		STATE_LH:
		begin
			word	<= 41'b00000100000000000000000000001000000000010;
			nx_state	<= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		STATE_LHU:
		begin
			word	<= 41'b00001000000000000000000000001000000000010;
			nx_state	<= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		STATE_SB:
		begin
			word	<= 41'b01000000000000000000000010100000000000000;
			nx_state	<= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		STATE_SH:
		begin
			word	<= 41'b00100000000000000000000010100000000000000;
			nx_state	<= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		SW:
		begin
			word	<= 41'b00000000000000000000000010100000000000000;
			nx_state	<= wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		RM:
		begin
			word	<= 41'b00000000000000000000000000000000110000100;
			nx_state	<= FETCH;
		end
		
		RFMT:
		begin
			word	<= 41'b00000000000000000000000000000000100000100;
			case (iFunct)
				FUNMULT,
				FUNDIV,
				FUNMULTU,
				FUNDIVU:
					nx_state	<= FETCH;
				default:
					nx_state	<= RFMT2;
			endcase
		end
		
		RFMT2:
		begin
			word	<= 41'b00000000000000000000000000000000000000011;
			nx_state	<= ((iFunct == FUNADD || iFunct == FUNSUB) && iCOP0ALUoverflow && ~iCOP0ExcLevel) || wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		SHIFT:
		begin
			word	<= 41'b00000000000000000000000000000000100001000;
			nx_state	<= RFMT2;
		end
		
		IFMTL:
		begin
			word	<= 41'b00000000000000000000000000000000111000100;
			nx_state	<= IFMT2;
		end
		
		IFMTA:
		begin
			word	<= 41'b00000000000000000000000000000000110100100;
			nx_state	<= IFMT2;
		end
		
		MUL:
		begin
			word	<= 41'b00000000000000000001100000000000100000101;
			nx_state	<= MULA;
		end
		MULA:
		begin
			word  <= 41'b00000000000000000001100000000000100000111;
			nx_state <= FETCH;
		end
		IFMT2:
		begin
			word	<= 41'b00000000000000000000000000000000000000010;
			nx_state	<= (iOp == OPCADDI && iCOP0ALUoverflow && ~iCOP0ExcLevel) || wCOP0PendingInterrupt ? COP0EXC : FETCH;
		end
		
		BEQ:
		begin
			word	<= 41'b00000000000000000000000100000001010000100;
			nx_state	<= FETCH;
		end

		BNE:
		begin
			word	<= 41'b00000000000000000000001000000001010000100;
			nx_state	<= FETCH;
		end

		JUMP:
		begin
			word	<= 41'b00000000000000000000010000000010000000000;
			nx_state	<= FETCH;
		end

		JAL:
		begin
			word	<= 41'b00000000000000000000110000000010111010010;
			nx_state	<= FETCH;
		end		
		
		//adicionado em 1/2016, bgez, bgezal, bltz, bltzal.
		BGEZ:
		begin
			word	<= 41'b00000000000000000000000100000001111010100;
			nx_state	<= FETCH;
		end
		
		BGEZAL:
		begin
			word	<= 41'b00000000000000000000100100000001111010110;
			nx_state	<= FETCH;
		end
		
		BLTZ:
		begin
			word	<= 41'b00000000000000000000001000000001111010100;
			nx_state	<= FETCH;
		end
		
		BLTZAL:
		begin
			word	<= 41'b00000000000000000011101000000001111010110;
			nx_state	<= FETCH;
		end
		
		BGTZ: //1/2016
		begin
			word	<= 41'b00000000000000000000000100000001111010100;
			nx_state	<= FETCH;
		end
		
		BLEZ://1/2016
		begin
			word	<= 41'b00000000000000000000001000000001111010100;
			nx_state	<= FETCH;
		end

		JR:
		begin
			word	<= 41'b00000000000000000000010000000011000000000;
			nx_state	<= FETCH;
		end
		
		JALR:
		begin
			word	<=	41'b00000000000000000001010000000011000000011;
			nx_state	<= FETCH;
		end
		
		// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
		COP0MTC0:
		begin
			word	<= 41'b00000000000000000000000000000000000000000;
			nx_state	<= FETCH;
		end
		
		COP0MFC0:
		begin
			word	<= 41'b00000000000000000011000000000000000000010;
			nx_state	<= FETCH;
		end
		
		COP0ERET:
		begin
			word	<= 41'b00000000000000000000010000000101000000000;
			nx_state	<= FETCH;
		end
		
		COP0EXC:
		begin
			word	<= 41'b00000000000000000000010000000100000000000;
			nx_state	<= FETCH;
		end
		// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
				
		ERRO:
		begin
			word  <= 41'b00000000000000000000000000000000000000001;
			nx_state	<= ERRO;
		end

		default:
		begin
			word	<= 41'b0;
			nx_state	<= ERRO;
		end
		
	endcase
end

endmodule

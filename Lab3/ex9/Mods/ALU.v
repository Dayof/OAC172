/*
 * ALU
 *
 * Arithmetic Logic Unit with control signals as defined by the COD book:
 *
 * Signal controls in ALUOP.v
 */
module ALU (
	input iCLK, iRST,
	input signed [31:0] iA, iB,
	input [4:0] iControlSignal,
	input [4:0] iShamt,
	output oZero, oOverflow,
	output [31:0] oALUresult
	);

reg [31:0] HI, LO;

assign oZero = (oALUresult == 32'b0);

initial
begin
    {HI,LO} <= 64'b0;
end

assign oOverflow = iControlSignal==OPADD ?
        ((iA[31] == 0 && iB[31] == 0 &&  oALUresult[31] == 1) || (iA[31] == 1 && iB[31] == 1 && oALUresult[31] == 0))
        : iControlSignal==OPSUB ?
            ((iA[31] == 0 && iB[31] == 1 && oALUresult[31]== 1)|| (iA[31] == 1 && iB[31] == 0 && oALUresult[31] == 0))
            : 1'b0;

always @(*)
begin
    case (iControlSignal)
        OPAND:
            oALUresult  = iA & iB;
        OPOR:
            oALUresult  = iA | iB;
        OPADD:
            oALUresult  = iA + iB;
        OPMFHI:
            oALUresult  = HI;
        OPSLL:
            oALUresult  = iB << iShamt;
        OPMFLO:
            oALUresult  = LO;
        OPSUB:
            oALUresult  = iA - iB;
        OPSLT:
            oALUresult  = iA < iB;
        OPSGT:                          //2016/1 - implementada para as operacoes bgtz e blez
			oALUresult  = iA > iB;
        OPSRL:
            oALUresult  = iB >> iShamt;
        OPSRA:
            oALUresult  = iB >>> iShamt;
        OPXOR:
            oALUresult  = iA ^ iB;
        OPSLTU:
            oALUresult  = $unsigned(iA) < $unsigned(iB);
        OPNOR:
            oALUresult  = ~(iA | iB);
        OPLUI:
            oALUresult  = {iB[15:0],16'b0};
        OPSLLV:
            oALUresult  = iB << iA[4:0];
        OPSRAV:
            oALUresult  = iB >>> iA[4:0];
        OPSRLV:
            oALUresult  = iB >> iA[4:0];

// para testes e simulacao	
		  OPMULT:
            oALUresult  = LO;
        OPMULT:
            oALUresult  = LO;
        OPDIV:
            oALUresult  = LO;
//

        default:
            oALUresult  = 32'b0;
    endcase
end

always @(posedge iCLK or posedge iRST)
begin
    if (iRST)
    begin
        {HI,LO}    <= 64'b0;
    end
    else
        case (iControlSignal)
				OPMUL:
					LO    <= iA * iB;
            OPMULT:
                {HI,LO} <= iA * iB;

            OPDIV:
                begin
                    LO    <= iA / iB;
                    HI    <= iA % iB;
                end
					
            OPMULTU:
                {HI,LO}   <= $unsigned(iA) * $unsigned(iB);

            OPDIVU:
                begin
                    LO    <= $unsigned(iA) / $unsigned(iB);
                    HI    <= $unsigned(iA) % $unsigned(iB);
                end

            // 2015/1
            OPMTHI:
                HI <= iA;

            // 2015/1
            OPMTLO:
                LO <= iA;
					 
				// Relatorio questao B.9) - Grupo 2 - (2/2016)
				OPMADD:
					{HI, LO} <= $signed({HI, LO}) + $signed($signed(iA) * $signed(iB));
				
				// Relatorio questao B.9) - Grupo 2 - (2/2016)
				OPMADDU:
					{HI, LO} <= {HI, LO} + ($unsigned(iA) * $unsigned(iB));
				
				// Relatorio questao B.9) - Grupo 2 - (2/2016)
				OPMSUB:
					{HI, LO} <= $signed({HI, LO}) - $signed($signed(iA) * $signed(iB));
				
				// Relatorio questao B.9) - Grupo 2 - (2/2016)
				OPMSUBU:
					{HI, LO} <= {HI, LO} - ($unsigned(iA) * $unsigned(iB));
        endcase
end

endmodule

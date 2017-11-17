/* Parametros Gerais*/
parameter
    ON          = 1'b1,
    OFF         = 1'b0,
    ZERO        = 32'h0,

/* Operacoes da ULA */
    OPAND       = 5'b00000,             //0
    OPOR        = 5'b00001,             //1
    OPADD       = 5'b00010,             //2
    OPMFHI      = 5'b00011,             //3
    OPSLL       = 5'b00100,             //4
    OPMFLO      = 5'b00101,             //5
    OPSUB       = 5'b00110,             //6
    OPSLT       = 5'b00111,             //7
    OPSRL       = 5'b01000,             //8
    OPSRA       = 5'b01001,             //9
    OPXOR       = 5'b01010,             //10
    OPSLTU      = 5'b01011,             //11
    OPNOR       = 5'b01100,             //12
    OPMULT      = 5'b01101,             //13
    OPDIV       = 5'b01110,             //14
    OPLUI       = 5'b01111,             //15
    OPSLLV      = 5'b10000,             //16
    OPSRAV      = 5'b10001,             //17
    OPSRLV      = 5'b10010,             //18
    OPMULTU     = 5'b10011,             //19
    OPDIVU      = 5'b10100,             //20
    OPMTHI      = 5'b10101,             //21        2015/1
    OPMTLO      = 5'b10110,             //22        2015/1
    OPSGT       = 5'b10111,             //23        2016/1
	 OPMADD		 = 5'b11000,				 //24 		 Relatorio questao B.9) - Grupo 2 - (2/2016)
	 OPMADDU		 = 5'b11001,				 //25 		 Relatorio questao B.9) - Grupo 2 - (2/2016)
	 OPMSUB		 = 5'b11010,				 //26 		 Relatorio questao B.9) - Grupo 2 - (2/2016)
	 OPMSUBU		 = 5'b11011,				 //27 		 Relatorio questao B.9) - Grupo 2 - (2/2016)
	 OPMUL		 = 5'b11100,

/* Operacoes da ULA FP */
    OPADDS      = 4'b0001,
    OPSUBS      = 4'b0010,
    OPMULS      = 4'b0011,
    OPDIVS      = 4'b0100,
    OPSQRT      = 4'b0101,
    OPABS       = 4'b0110,
    OPNEG       = 4'b0111,
    OPCEQ       = 4'b1000,
    OPCLT       = 4'b1001,
    OPCLE       = 4'b1010,
    OPCVTSW     = 4'b1011,
    OPCVTWS     = 4'b1100,
    OPCEILWS    = 4'b1101,
    OPFLOORWS   = 4'b1110,
    OPROUNDWS   = 4'b1111,


/* Campo FUNCT */
    FUNSLL      = 6'h00,
	 FUNMADD		 = 6'h00,					 // Relatorio questao B.9) - Grupo 2 - (2/2016)
	 FUNMADDU	 = 6'h01,	 				// Relatorio questao B.9) - Grupo 2 - (2/2016)
    FUNMUL		 = 6'h02,
	 FUNSRL      = 6'h02,
    FUNSRA      = 6'h03,
	 FUNMSUB		 = 6'h04,					 // Relatorio questao B.9) - Grupo 2 - (2/2016)
	 FUNMSUBU	 = 6'h05,					 // Relatorio questao B.9) - Grupo 2 - (2/2016)
    FUNJR       = 6'h08,
	 FUNJALR		 =	6'h09,
    FUNSYS      = 6'h0C,
    FUNMFHI     = 6'h10,
    FUNMTHI     = 6'h11,                // 2015/1
    FUNMFLO     = 6'h12,
    FUNMTLO     = 6'h13,                // 2015/1
    FUNMULT     = 6'h18,
    FUNMULTU    = 6'h19,
    FUNDIV      = 6'h1A,
    FUNDIVU     = 6'h1B,
    FUNADD      = 6'h20,
    FUNADDU     = 6'h21,
    FUNSUB      = 6'h22,
    FUNSUBU     = 6'h23,
    FUNAND      = 6'h24,
    FUNOR       = 6'h25,
    FUNXOR      = 6'h26,
    FUNNOR      = 6'h27,
    FUNSLT      = 6'h2A,
    FUNSLTU     = 6'h2B,
    FUNSLLV     = 6'h04,
    FUNSRLV     = 6'b000110,
    FUNSRAV     = 6'b000111,
    /*Abaixo FUNCT de operacoes em ponto flutuante*/
    FUNADDS     = 6'h00,
    FUNSUBS     = 6'h01,
    FUNMULS     = 6'h02,
    FUNDIVS     = 6'h03,
    FUNSQRT     = 6'h04,
    FUNABS      = 6'h05,
    FUNMOV      = 6'h06,
    FUNNEG      = 6'h07,
    FUNCEQ      = 6'h32,
    FUNCLT      = 6'h3c,
    FUNCLE      = 6'h3e,
    FUNCVTSW    = 6'h20,
    FUNCVTWS    = 6'h24,
    FUNERET     = 6'h18,                // feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
    FUNROUNDWS  = 6'h0c,
	 FUNCEILWS   = 6'h0e,
	 FUNFLOORWS  = 6'h0f,

/* Campo OPCODE */
    OPCRFMT     = 6'h00,                /* Tipo-R */
    OPCJMP      = 6'h02,
    OPCJAL      = 6'h03,
    OPCBEQ      = 6'h04,
    OPCBNE      = 6'h05,
    OPCADDI     = 6'h08,
    OPCADDIU    = 6'h09,
    OPCSLTI     = 6'h0A,
    OPCSLTIU    = 6'h0B,
    OPCANDI     = 6'h0C,
    OPCORI      = 6'h0D,
    OPCXORI     = 6'h0E,
    OPCLUI      = 6'h0F,
    OPCCOP0     = 6'h10,                // feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
    OPCFLT      = 6'h11,                /*OPCODE para operacoes da FPU*/
	 OPCRM	 	 = 6'h1C,   				 // Grupo 2 - (2/2016)
	 OPMFUNCT 	 = 6'h1C,   				 // Relatorio questao B.9) - Grupo 2 - (2/2016)
    OPCMUL 		 = 6'h1C,
	 OPCLW       = 6'h23,
    OPCLB       = 6'h20,
    OPCLBU      = 6'h24,
    OPCLH       = 6'h21,
    OPCLHU      = 6'h25,
    OPCSW       = 6'h2B,
    OPCSB       = 6'h28,
    OPCSH       = 6'h29,
    OPCLWC1     = 6'h31,
    OPCSWC1     = 6'h39,
    OPCDUMMY    = 6'h3F,                // Para o MemStore e MemLoad
    OPCBGE_LTZ  = 6'h01,                // 1/2016: Para as instruções bgez, bgezal, bgltz, bltzal
    OPCBGTZ     = 6'h07,                // 1/2016
    OPCBLEZ     = 6'h06,                // 1/2016

/* Campo $rt */                         // 1/2016
    RTBGEZ      = 5'b00001,
    RTBGEZAL    = 5'b10001,
    RTBLTZ      = 5'b00000,
    RTBLTZAL    = 5'b10000,
    RTZERO      = 5'B00000,

/* Campo FMT */
    FMTS        = 5'h10,
    FMTW        = 5'h14,
    FMTBC1      = 5'h8,
    FMTMFC      = 5'h0,
    FMTMTC      = 5'h4,
    FMTERET     = 5'h10,                // feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)

/* Bit 16 da instrucao, usado somente para BC1 da FPU*/
    FTTRUE      = 1'b1,
    FTFALSE     = 1'b0,

// feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
    EXCODEINT   = 5'd0,
    EXCODESYS   = 5'd8,
    EXCODEINSTR = 5'd10,
    EXCODEALU   = 5'd12,
    EXCODEFPALU = 5'd15,


/* Memory access types ***********************************************************************************************/
    LOAD_TYPE_LW        = 3'b000,
    LOAD_TYPE_LH        = 3'b001,
    LOAD_TYPE_LHU       = 3'b010,
    LOAD_TYPE_LB        = 3'b011,
    LOAD_TYPE_LBU       = 3'b100,
    LOAD_TYPE_DUMMY     = 3'b111,

    STORE_TYPE_SW       = 2'b00,
    STORE_TYPE_SH       = 2'b01,
    STORE_TYPE_SB       = 2'b10,
    STORE_TYPE_DUMMY    = 2'b11,


/* ADDRESS MACROS *****************************************************************************************************/

    BACKGROUND_IMAGE    = "display.mif",

	 BEGINNING_BOOT      = 32'h0000_0000,
	 BOOT_WIDTH				= 9,					// 128 words = 128x4 = 512 bytes
    END_BOOT            = (BEGINNING_BOOT + 2**BOOT_WIDTH) - 1,	 
//    END_BOOT            = 32'h000001FF,	// 128 words

    BEGINNING_TEXT      = 32'h0040_0000,
	 TEXT_WIDTH				= 14,					// 4096 words = 4096x4 = 16384 bytes
    END_TEXT            = (BEGINNING_TEXT + 2**TEXT_WIDTH) - 1,	 
//    END_TEXT            = 32'h00403FFF,	// 4096 words

	 
    BEGINNING_DATA      = 32'h1001_0000,
	 DATA_WIDTH				= 13,					// 2048 words = 2048x4 = 8192 bytes
    END_DATA            = (BEGINNING_DATA + 2**DATA_WIDTH) - 1,	 
//    END_DATA            = 32'h10011FFF,	// 2048 words

    BEGINNING_SRAM      = 32'h1001_2000,
	 SRAM_WIDTH				= 21,					// 2 MiBytes
    END_SRAM            = (BEGINNING_SRAM + 2**SRAM_WIDTH) - 1,	 
//    END_SRAM            = 32'h10211FFF,	// 512 Ki words

    // STACK_ADDRESS       = 32'h10011ffc, // Colocar Para Simulacao forma de onda do MIPS que nao tem SRAM
	 // STACK_ADDRESS       = END_DATA-3,
    //STACK_ADDRESS       = 32'h10211FFC, // Para DE2 que tem  SRAM
	 STACK_ADDRESS       = END_SRAM-3,

    BEGINNING_KTEXT     = 32'h8000_0000,
	 KTEXT_WIDTH			= 13,					// 2048 words = 2048x4 = 8192 bytes
    END_KTEXT           = (BEGINNING_KTEXT + 2**KTEXT_WIDTH) - 1,	 	 
//    END_KTEXT           = 32'h80001FFF,	// 2048 words
	 
    BEGINNING_KDATA     = 32'h9000_0000,
	 KDATA_WIDTH			= 12,					// 512 words = 512x4 = 2048 bytes
    END_KDATA           = (BEGINNING_KDATA + 2**KDATA_WIDTH) - 1,	 	 
//    END_KDATA           = 32'h900007FF, 	// 512 words


	/* O que isso faz? */
	 ASCII_MIN           = 32'h00000080,
	 ASCII_MAX           = 32'h0000407F,
	 BACKGROUND          = 32'h00004080,
	 MAIN_COLOR          = 32'h00004084,
	 //LETRAS_MIN = 32'h00000100,
	 //LETRAS_MAX = 32'h00001763,
	 //NUMBER_MIN = 32'h00001764,
	 //NUMBER_MAX = 32'h00002403,
	 
    BEGINNING_IODEVICES         = 32'hFF00_0000,
	 
    BEGINNING_VGA               = 32'hFF00_0000,
    END_VGA                     = 32'hFF01_2C00,  // 320 x 240 = 76800 bytes

    AUDIO_INL_ADDRESS           = 32'hFF10_0000,
    AUDIO_INR_ADDRESS           = 32'hFF10_0004,
    AUDIO_OUTL_ADDRESS          = 32'hFF10_0008,
    AUDIO_OUTR_ADDRESS          = 32'hFF10_000C,
    AUDIO_CTRL1_ADDRESS         = 32'hFF10_0010,
    AUDIO_CRTL2_ADDRESS         = 32'hFF10_0014,

    BUFFER0_TECLADO_ADDRESS     = 32'hFF10_0100,
    BUFFER1_TECLADO_ADDRESS     = 32'hFF10_0104,

    TECLADOxMOUSE_ADDRESS       = 32'hFF10_0110,
    BUFFERMOUSE_ADDRESS         = 32'hFF10_0114,

    RS232_READ_ADDRESS          = 32'hFF10_0120,
    RS232_WRITE_ADDRESS         = 32'hFF10_0121,
    RS232_CONTROL_ADDRESS       = 32'hFF10_0122,

	
    BEGINNING_LCD               = 32'hFF10_0130,
    SECOND_LINE_LCD             = 32'hFF10_0140,
    END_LCD                     = 32'hFF10_014F,
    LCD_CLEAR_ADDRESS           = 32'hFF10_0150,

    //SYSCALL NOTE ADDRESS
    NOTE_SYSCALL_ADDRESS        = 32'hFF10_0200,
    NOTE_CLOCK                  = 32'hFF10_0204,
    NOTE_MELODY                 = 32'hFF10_0208,
    MUSIC_TEMPO_ADDRESS         = 32'hFF10_020C,
    MUSIC_ADDRESS               = 32'hFF10_0210,         // Endereco para uso do Controlador do sintetizador
    PAUSE_ADDRESS               = 32'hFF10_0214,

    BEGINNING_SD_BUFFER         = 32'hFF10_026c,         // Início do buffer de leitura do cartão SD [512 bytes] 
    END_SD_BUFFER               = 32'hFF10_044C,
    SD_INTERFACE_ADDR           = 32'hFF10_0450,         // Endereço do cartão SD a ser lido [4 bytes]
    SD_INTERFACE_CTRL           = 32'hFF10_0454,         // Informações de controle da interface do cartão SD [1 byte]
		
	 IRDA_DECODER_ADDRESS		 = 32'hFF10_049C,
	 IRDA_CONTROL_ADDRESS       = 32'hFF10_0500, 	 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
	 IRDA_READ_ADDRESS          = 32'hFF10_0504,		 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
    IRDA_WRITE_ADDRESS         = 32'hFF10_0508,		 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
    
	 STOPWATCH_ADDRESS			 = 32'hFF10_050C, 		//Feito em 2/2016 para servir de cronometro
	 LFSR_ADDRESS					 = 32'hFF10_0510,			// Gerador de numeros aleatorios
	 
	 KEYMAP0_ADDRESS				 = 32'hFF10_0520,			// Mapa do teclado 2017/2
	 KEYMAP1_ADDRESS				 = 32'hFF10_0524,
	 KEYMAP2_ADDRESS				 = 32'hFF10_0528,
	 KEYMAP3_ADDRESS				 = 32'hFF10_052C,
	 
	 BREAK_ADDRESS					 = 32'h0000_0000,  	// um store aqui poe o processador no modo clock manual para debug
	 
/* STATES ************************************************************************************************************/
    FETCH           = 6'd0,
    DECODE          = 6'd1,
    LWSW            = 6'd2,
    LW              = 6'd3,
    LW2             = 6'd4,
    SW              = 6'd5,
    RFMT            = 6'd6,
    RFMT2           = 6'd7,
    SHIFT           = 6'd8,
    IFMTL           = 6'd9,
    IFMTA           = 6'd10,
    IFMT2           = 6'd11,
    BEQ             = 6'd12,
    BNE             = 6'd13,
    JUMP            = 6'd14,
    JAL             = 6'd15,
    JR              = 6'd16,
	 JALR				  = 6'd21,
	 MUL				  = 6'd22,
	 MULA				  = 6'd23,

    // feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)
    COP0MTC0        = 6'd17,
    COP0MFC0        = 6'd18,
    COP0ERET        = 6'd19,
    COP0EXC         = 6'd20,
    // feito no semestre 2013/1 para implementar a deteccao de excecoes (COP0)

    /*Estados da FPU*/
    FPUFRSTART      = 6'd38,
    FPUFR2          = 6'd39,
    FPUMOV          = 6'd40,
    FPUMFC1         = 6'd41,
    FPUMTC1         = 6'd42,
    FPUBC1T         = 6'd43,
    FPUBC1F         = 6'd44,
    FPULWC1         = 6'd45,
    FPUSWC1         = 6'd46,
    FPUCOMP         = 6'd47,    //tava assim, vou manter em homenagem aos semestres anteriores
    FPUFRWAIT       = 6'd48,

    //Adicionados em 1/2014
    STATE_LB        = 6'd49,
    STATE_LBU       = 6'd50,
    STATE_LH        = 6'd51,
    STATE_LHU       = 6'd52,
    STATE_SB        = 6'd53,
    STATE_SH        = 6'd54,

     //Adicionados em 1/2016
     BGEZ           = 6'd55,
     BGEZAL         = 6'd56,
     BLTZ           = 6'd57,
     BLTZAL         = 6'd58,
     BGTZ           = 6'd59,
     BLEZ           = 6'd60,
	  
	  //Adicionados em 2/2016 (Grupo 2)
	  RM				  = 6'd61,

	  ERRO            = 6'd63;  // Estado de Erro

//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0516003李智嘉
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [31:0]addr_now;
wire [31:0]addr_next;
wire [31:0]instruction;

wire [1:0]RegDst;
wire RegWrite,branch,ALUSrc;
wire [2:0]ALUOp;

wire [4:0]writeReg;

wire [31:0]RS;
wire [31:0]RT;
wire [31:0]RtALU;

wire [3:0]ALUCtrl;

wire [31:0]extend;
wire [31:0]extendShift;

wire zero;
wire [31:0]result;

wire [31:0]addr_plus;

wire [31:0]current_program;
reg [31:0]Reg_current_program=32'd0;

wire ALUSrc2;
wire [31:0]RsALU;

wire ExtendMult;
wire [31:0]SignExtend;
wire [31:0]ZeroExtend;

wire [1:0]MemToReg;
wire [1:0]BranchType;
wire Jump;
wire MemRead;
wire MemWrite;

wire [31:0]branch_add;
wire [31:0]Readdata;
wire [31:0]WriteData;
wire selectBranch;

wire equalToZero;
wire checkJr;
wire [31:0]pcChoice;

always @(current_program)begin
        Reg_current_program<=current_program;
end

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(Reg_current_program) , 
	    .pc_out_o(addr_now) 
	    );
	
Adder Adder1(
        .src1_i(addr_now),     
	    .src2_i(32'd4),     
	    .sum_o(addr_next)
	    );
	
Instr_Memory IM(
        .addr_i(addr_now),  
	    .instr_o(instruction)    
	    );

MUX_4to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .data2_i(5'd31),
        .data3_i(5'd0),  // currently not use
        .select_i(RegDst),
        .data_o(writeReg)
        );

Equal_To_Zero ETZ(
        .src_i(instruction[31:0]),
        .output_o(equalToZero));
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(writeReg) ,  
        .RDdata_i(WriteData)  , 
        .RegWrite_i (RegWrite&equalToZero&(!checkJr)),
        .RSdata_o(RS) ,
        .RTdata_o(RT)
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALUOp),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),
	    .Branch_o(branch),
        .ZeroExt_o(ExtendMult),
        .MemToReg_o(MemToReg),
        .BranchType_o(BranchType),
        .Jump_o(Jump),
        .MemRead_o(MemRead),
        .MemWrite_o(MemWrite)
	    );

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALUCtrl),
        .ALUSrc2_o(ALUSrc2)
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(SignExtend)
        );

Zero_Extend ZE(
        .data_i(instruction[15:0]),
        .data_o(ZeroExtend)
        );

MUX_2to1 #(.size(32)) Mux_Extend(
        .data0_i(SignExtend),
        .data1_i(ZeroExtend),
        .select_i(ExtendMult),
        .data_o(extend)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc2(
        .data0_i(RS),
        .data1_i({27'b0,instruction[10:6]}),
        .select_i(ALUSrc2),
        .data_o(RsALU)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RT),
        .data1_i(extend),
        .select_i(ALUSrc),
        .data_o(RtALU)
        );
		
ALU ALU(
        .src1_i(RsALU),
	    .src2_i(RtALU),
	    .ctrl_i(ALUCtrl),
	    .result_o(result),
		.zero_o(zero)
	    );

Data_Memory Data_Memory(
        .clk_i(clk_i),
        .addr_i(result),
        .data_i(RT),
        .MemRead_i(MemRead),
        .MemWrite_i(MemWrite),
        .data_o(Readdata)
        );

MUX_4to1 #(.size(32)) WriteMux(
        .data0_i(result),
        .data1_i(Readdata),
        .data2_i(SignExtend),
        .data3_i(addr_next),
        .select_i(MemToReg),
        .data_o(WriteData)
        );
		
Adder Adder2(
        .src1_i(addr_next),     
	    .src2_i(extendShift),     
	    .sum_o(addr_plus)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(extend),
        .data_o(extendShift)
        ); 		

MUX_4to1 #(.size(1)) Mux_branch(
        .data0_i(zero),
        .data1_i(result[31]|zero),
        .data2_i(result[31]),
        .data3_i(~zero),
        .select_i(BranchType),
        .data_o(selectBranch)
        );
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(addr_next),
        .data1_i(addr_plus),
        .select_i(branch&selectBranch),
        .data_o(branch_add)
        );	

MUX_2to1 #(.size(32)) Add_Mult(
        .data0_i(branch_add),
        .data1_i({addr_next[31:28],instruction[25:0],2'b0}),
        .select_i(Jump),
        .data_o(pcChoice)
        );

Check_jr check_jr(
        .ist_i(instruction[31:0]),
        .output_o(checkJr)
        );

MUX_2to1 #(.size(32)) PC_Mult(
        .data0_i(pcChoice),
        .data1_i(RS),
        .select_i(checkJr),
        .data_o(current_program)
        );


endmodule
//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0516003李智嘉
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	ZeroExt_o,
	MemToReg_o,
	BranchType_o,
	Jump_o,
	MemRead_o,
	MemWrite_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output  [1:0]  RegDst_o;
output         Branch_o;
output ZeroExt_o;
output	[1:0]MemToReg_o;
output	[1:0]BranchType_o;
output	Jump_o;
output	MemRead_o;
output	MemWrite_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg    [1:0]   RegDst_o;
reg            Branch_o;
reg ZeroExt_o;
reg	[1:0]MemToReg_o;
reg	[1:0]BranchType_o;
reg	Jump_o;
reg	MemRead_o;
reg	MemWrite_o;

//Parameter
wire R,beq,addi,sltiu;
wire ori,bne;
// wire lui;
wire lw,sw,j;
wire jal;

wire ble,bnez,bltz,li;

assign R = (~instr_op_i[5])&(~instr_op_i[4])&(~instr_op_i[3])&(~instr_op_i[2])&(~instr_op_i[1])&(~instr_op_i[0]);
assign beq = (~instr_op_i[5])&(~instr_op_i[4])&(~instr_op_i[3])&instr_op_i[2]&(~instr_op_i[1])&(~instr_op_i[0]);
assign addi = (~instr_op_i[5])&(~instr_op_i[4])&instr_op_i[3]&(~instr_op_i[2])&(~instr_op_i[1])&(~instr_op_i[0]);
assign sltiu = (~instr_op_i[5])&(~instr_op_i[4])&instr_op_i[3]&(~instr_op_i[2])&instr_op_i[1]&instr_op_i[0];

// assign lui = (~instr_op_i[5])&(~instr_op_i[4])&instr_op_i[3]&instr_op_i[2]&instr_op_i[1]&instr_op_i[0];
assign ori = (~instr_op_i[5])&(~instr_op_i[4])&instr_op_i[3]&instr_op_i[2]&(~instr_op_i[1])&instr_op_i[0];
assign bne = (~instr_op_i[5])&(~instr_op_i[4])&(~instr_op_i[3])&instr_op_i[2]&(~instr_op_i[1])&instr_op_i[0];

assign lw = instr_op_i[5]&(~instr_op_i[4])&(~instr_op_i[3])&(~instr_op_i[2])&instr_op_i[1]&instr_op_i[0];
assign sw = instr_op_i[5]&(~instr_op_i[4])&instr_op_i[3]&(~instr_op_i[2])&instr_op_i[1]&instr_op_i[0];
assign j = (~instr_op_i[5])&(~instr_op_i[4])&(~instr_op_i[3])&(~instr_op_i[2])&instr_op_i[1]&(~instr_op_i[0]);
assign jal = (~instr_op_i[5])&(~instr_op_i[4])&(~instr_op_i[3])&(~instr_op_i[2])&instr_op_i[1]&instr_op_i[0];

assign ble = (~instr_op_i[5])&(~instr_op_i[4])&(~instr_op_i[3])&instr_op_i[2]&instr_op_i[1]&(~instr_op_i[0]);
assign bnez = (~instr_op_i[5])&(~instr_op_i[4])&(~instr_op_i[3])&instr_op_i[2]&(~instr_op_i[1])&instr_op_i[0];
assign bltz = (~instr_op_i[5])&(~instr_op_i[4])&(~instr_op_i[3])&(~instr_op_i[2])&(~instr_op_i[1])&instr_op_i[0];
assign li = (~instr_op_i[5])&(~instr_op_i[4])&instr_op_i[3]&instr_op_i[2]&instr_op_i[1]&instr_op_i[0];


//Main function
always @(*) begin
	ALU_op_o[2]=   ori | bne;
	ALU_op_o[1]= addi | sltiu | bne | lw | sw | li;
	ALU_op_o[0]= beq | sltiu | ori | ble | bnez | bltz;
	ALUSrc_o = addi | sltiu |   ori | lw | sw | li;
	RegWrite_o = R | addi | sltiu |   ori | lw | jal | li;
	RegDst_o[1] = jal;
	RegDst_o[0] = R;
	Branch_o = beq | bne | ble | bnez | bltz;
	ZeroExt_o = ori;
	MemToReg_o[1] = jal;
	MemToReg_o[0] = lw | jal;
	BranchType_o[1] = bnez | bltz;
	BranchType_o[0] = ble | bnez;
	Jump_o = j | jal;
	MemRead_o = lw;
	MemWrite_o = sw;
end

endmodule





                    
                    
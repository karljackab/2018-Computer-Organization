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
	ZeroExt_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output ZeroExt_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg ZeroExt_o;

//Parameter
wire R,beq,addi,sltiu;
wire lui,ori,bne;
assign R = (~instr_op_i[5])&(~instr_op_i[4])&(~instr_op_i[3])&(~instr_op_i[2])&(~instr_op_i[1])&(~instr_op_i[0]);
assign beq = (~instr_op_i[5])&(~instr_op_i[4])&(~instr_op_i[3])&instr_op_i[2]&(~instr_op_i[1])&(~instr_op_i[0]);
assign addi = (~instr_op_i[5])&(~instr_op_i[4])&instr_op_i[3]&(~instr_op_i[2])&(~instr_op_i[1])&(~instr_op_i[0]);
assign sltiu = (~instr_op_i[5])&(~instr_op_i[4])&instr_op_i[3]&(~instr_op_i[2])&instr_op_i[1]&instr_op_i[0];

assign lui = (~instr_op_i[5])&(~instr_op_i[4])&instr_op_i[3]&instr_op_i[2]&instr_op_i[1]&instr_op_i[0];
assign ori = (~instr_op_i[5])&(~instr_op_i[4])&instr_op_i[3]&instr_op_i[2]&(~instr_op_i[1])&instr_op_i[0];
assign bne = (~instr_op_i[5])&(~instr_op_i[4])&(~instr_op_i[3])&instr_op_i[2]&(~instr_op_i[1])&instr_op_i[0];


//Main function
always @(*) begin
	ALU_op_o[2]= lui | ori | bne;
	ALU_op_o[1]= addi | sltiu | bne;
	ALU_op_o[0]= beq | sltiu | ori;
	ALUSrc_o = addi | sltiu | lui | ori;
	RegWrite_o = R | addi | sltiu | lui | ori;
	RegDst_o = R;
	Branch_o = beq | bne;
	ZeroExt_o = ori;
end

endmodule





                    
                    
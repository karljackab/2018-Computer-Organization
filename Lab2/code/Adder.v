//Subject:     CO project 2 - Adder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0516003李智嘉
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Adder(
    src1_i,
	src2_i,
	sum_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
output [32-1:0]	 sum_o;

//Internal Signals
wire    [32-1:0]	 sum_o;

//Parameter
wire [7:0]c;

//Main function
Adder_4bit a1(src1_i[3:0],src2_i[3:0],1'b0,sum_o[3:0],c[0]);
Adder_4bit a2(src1_i[7:4],src2_i[7:4],c[0],sum_o[7:4],c[1]);
Adder_4bit a3(src1_i[11:8],src2_i[11:8],c[1],sum_o[11:8],c[2]);
Adder_4bit a4(src1_i[15:12],src2_i[15:12],c[2],sum_o[15:12],c[3]);
Adder_4bit a5(src1_i[19:16],src2_i[19:16],c[3],sum_o[19:16],c[4]);
Adder_4bit a6(src1_i[23:20],src2_i[23:20],c[4],sum_o[23:20],c[5]);
Adder_4bit a7(src1_i[27:24],src2_i[27:24],c[5],sum_o[27:24],c[6]);
Adder_4bit a8(src1_i[31:28],src2_i[31:28],c[6],sum_o[31:28],c[7]);

endmodule
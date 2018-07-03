// 0516003 李智嘉
`timescale 1ns/1ps

module alu(
	rst_n,         // negative reset            (input)
	src1,          // 32 bits source 1          (input)
	src2,          // 32 bits source 2          (input)
	ALU_control,   // 4 bits ALU control input  (input)
	bonus_control, // 3 bits bonus control input(input)
	result,        // 32 bits result            (output)
	zero,          // 1 bit when the output is 0, zero must be set (output)
	cout,          // 1 bit carry out           (output)
	overflow       // 1 bit overflow            (output)
);


input				rst_n;
input	[32-1:0]	src1;
input	[32-1:0]	src2;
input	[4-1:0]		ALU_control;
input	[3-1:0]		bonus_control;

output	[32-1:0]	result;
output				zero;
output				cout;
output				overflow;

reg		[32-1:0]	result;
reg					zero;
reg					cout;
reg					overflow;

//serlf define
wire	[32-1:0] sm_result;
wire	[32-1:0] sm_cout;
reg less;
wire [32-1:0] sub_result;
reg equal;

alu_top b0 (src1[0] ,src2[0] ,less,ALU_control[3],ALU_control[2],ALU_control[2] ,ALU_control[1:0],equal,bonus_control[2:0],sm_result[0] ,sm_cout[1],sub_result[0]);
alu_top b1 (src1[1] ,src2[1] ,1'b0,ALU_control[3],ALU_control[2],sm_cout[1]		,ALU_control[1:0],1'b0,					 ,sm_result[1] ,sm_cout[2],sub_result[1]);
alu_top b2 (src1[2] ,src2[2] ,1'b0,ALU_control[3],ALU_control[2],sm_cout[2]		,ALU_control[1:0],1'b0,					 ,sm_result[2] ,sm_cout[3],sub_result[2]);
alu_top b3 (src1[3] ,src2[3] ,1'b0,ALU_control[3],ALU_control[2],sm_cout[3]		,ALU_control[1:0],1'b0,					 ,sm_result[3] ,sm_cout[4],sub_result[3]);
alu_top b4 (src1[4] ,src2[4] ,1'b0,ALU_control[3],ALU_control[2],sm_cout[4]		,ALU_control[1:0],1'b0,					 ,sm_result[4] ,sm_cout[5],sub_result[4]);
alu_top b5 (src1[5] ,src2[5] ,1'b0,ALU_control[3],ALU_control[2],sm_cout[5]		,ALU_control[1:0],1'b0,					 ,sm_result[5] ,sm_cout[6],sub_result[5]);
alu_top b6 (src1[6] ,src2[6] ,1'b0,ALU_control[3],ALU_control[2],sm_cout[6]		,ALU_control[1:0],1'b0,					 ,sm_result[6] ,sm_cout[7],sub_result[6]);
alu_top b7 (src1[7] ,src2[7] ,1'b0,ALU_control[3],ALU_control[2],sm_cout[7]		,ALU_control[1:0],1'b0,					 ,sm_result[7] ,sm_cout[8],sub_result[7]);
alu_top b8 (src1[8] ,src2[8] ,1'b0,ALU_control[3],ALU_control[2],sm_cout[8]		,ALU_control[1:0],1'b0,					 ,sm_result[8] ,sm_cout[9],sub_result[8]);
alu_top b9 (src1[9] ,src2[9] ,1'b0,ALU_control[3],ALU_control[2],sm_cout[9]		,ALU_control[1:0],1'b0,					 ,sm_result[9] ,sm_cout[10],sub_result[9]);
alu_top b10(src1[10],src2[10],1'b0,ALU_control[3],ALU_control[2],sm_cout[10]	,ALU_control[1:0],1'b0,					 ,sm_result[10],sm_cout[11],sub_result[10]);
alu_top b11(src1[11],src2[11],1'b0,ALU_control[3],ALU_control[2],sm_cout[11]	,ALU_control[1:0],1'b0,					 ,sm_result[11],sm_cout[12],sub_result[11]);
alu_top b12(src1[12],src2[12],1'b0,ALU_control[3],ALU_control[2],sm_cout[12]	,ALU_control[1:0],1'b0,					 ,sm_result[12],sm_cout[13],sub_result[12]);
alu_top b13(src1[13],src2[13],1'b0,ALU_control[3],ALU_control[2],sm_cout[13]	,ALU_control[1:0],1'b0,					 ,sm_result[13],sm_cout[14],sub_result[13]);
alu_top b14(src1[14],src2[14],1'b0,ALU_control[3],ALU_control[2],sm_cout[14]	,ALU_control[1:0],1'b0,					 ,sm_result[14],sm_cout[15],sub_result[14]);
alu_top b15(src1[15],src2[15],1'b0,ALU_control[3],ALU_control[2],sm_cout[15]	,ALU_control[1:0],1'b0,					 ,sm_result[15],sm_cout[16],sub_result[15]);
alu_top b16(src1[16],src2[16],1'b0,ALU_control[3],ALU_control[2],sm_cout[16]	,ALU_control[1:0],1'b0,					 ,sm_result[16],sm_cout[17],sub_result[16]);
alu_top b17(src1[17],src2[17],1'b0,ALU_control[3],ALU_control[2],sm_cout[17]	,ALU_control[1:0],1'b0,					 ,sm_result[17],sm_cout[18],sub_result[17]);
alu_top b18(src1[18],src2[18],1'b0,ALU_control[3],ALU_control[2],sm_cout[18]	,ALU_control[1:0],1'b0,					 ,sm_result[18],sm_cout[19],sub_result[18]);
alu_top b19(src1[19],src2[19],1'b0,ALU_control[3],ALU_control[2],sm_cout[19]	,ALU_control[1:0],1'b0,					 ,sm_result[19],sm_cout[20],sub_result[19]);
alu_top b20(src1[20],src2[20],1'b0,ALU_control[3],ALU_control[2],sm_cout[20]	,ALU_control[1:0],1'b0,					 ,sm_result[20],sm_cout[21],sub_result[20]);
alu_top b21(src1[21],src2[21],1'b0,ALU_control[3],ALU_control[2],sm_cout[21]	,ALU_control[1:0],1'b0,					 ,sm_result[21],sm_cout[22],sub_result[21]);
alu_top b22(src1[22],src2[22],1'b0,ALU_control[3],ALU_control[2],sm_cout[22]	,ALU_control[1:0],1'b0,					 ,sm_result[22],sm_cout[23],sub_result[22]);
alu_top b23(src1[23],src2[23],1'b0,ALU_control[3],ALU_control[2],sm_cout[23]	,ALU_control[1:0],1'b0,					 ,sm_result[23],sm_cout[24],sub_result[23]);
alu_top b24(src1[24],src2[24],1'b0,ALU_control[3],ALU_control[2],sm_cout[24]	,ALU_control[1:0],1'b0,					 ,sm_result[24],sm_cout[25],sub_result[24]);
alu_top b25(src1[25],src2[25],1'b0,ALU_control[3],ALU_control[2],sm_cout[25]	,ALU_control[1:0],1'b0,					 ,sm_result[25],sm_cout[26],sub_result[25]);
alu_top b26(src1[26],src2[26],1'b0,ALU_control[3],ALU_control[2],sm_cout[26]	,ALU_control[1:0],1'b0,					 ,sm_result[26],sm_cout[27],sub_result[26]);
alu_top b27(src1[27],src2[27],1'b0,ALU_control[3],ALU_control[2],sm_cout[27]	,ALU_control[1:0],1'b0,					 ,sm_result[27],sm_cout[28],sub_result[27]);
alu_top b28(src1[28],src2[28],1'b0,ALU_control[3],ALU_control[2],sm_cout[28]	,ALU_control[1:0],1'b0,					 ,sm_result[28],sm_cout[29],sub_result[28]);
alu_top b29(src1[29],src2[29],1'b0,ALU_control[3],ALU_control[2],sm_cout[29]	,ALU_control[1:0],1'b0,					 ,sm_result[29],sm_cout[30],sub_result[29]);
alu_top b30(src1[30],src2[30],1'b0,ALU_control[3],ALU_control[2],sm_cout[30]	,ALU_control[1:0],1'b0,					 ,sm_result[30],sm_cout[31],sub_result[30]);
alu_top b31(src1[31],src2[31],1'b0,ALU_control[3],ALU_control[2],sm_cout[31]	,ALU_control[1:0],1'b0,					 ,sm_result[31],sm_cout[0],sub_result[31]);

// set result
always @(*)
begin
	if(rst_n==1)
		result[31:0]<=sm_result[31:0];
end

//set overflow
always @(*)
begin
	if(rst_n)
		if(ALU_control[3:1]==3'b011) // when ALU will do subtraction
		begin
			overflow=~sm_cout[0];
			less=overflow;
			if(sub_result==32'b0)
				equal=1;
			else
				equal=0;
		end
		else
			overflow=sm_cout[0];
	else
		overflow=0;
end

//set zero
always @(*)
begin
	if(rst_n==1&&result==32'b0)
		zero=1'b1;
	else
		zero=1'b0;
end

//set cout
always @(*)
begin
	if(rst_n==1&&ALU_control!=4'b0111)
		cout=sm_cout[0];
	else
		cout=0;
end

endmodule

//Subject:     CO project 2 - Adder_4bit
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0516003李智嘉
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Adder_4bit(
    src1_i,
	src2_i,
	cin_i,
	sum_o,
	cout_o
	);
     
//I/O ports
input  [3:0]  src1_i;
input  [3:0]	 src2_i;
input cin_i;
output [3:0]	 sum_o;
output cout_o;

//Internal Signals
wire    [3:0]	 sum_o;
wire cout_o;
wire cin_i;

//Parameter
reg [3:0] c;
reg [3:0] sum;

assign sum_o[0]=sum[0];
assign sum_o[1]=sum[1];
assign sum_o[2]=sum[2];
assign sum_o[3]=sum[3];
assign cout_o=c[3];

//Main function
always @(*) begin
	{c[0],sum[0]}=src1_i[0]+src2_i[0]+cin_i;
	{c[1],sum[1]}=src1_i[1]+src2_i[1]+c[0];
	{c[2],sum[2]}=src1_i[2]+src2_i[2]+c[1];
	{c[3],sum[3]}=src1_i[3]+src2_i[3]+c[2];
end

endmodule
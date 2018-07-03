//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0516003李智嘉
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;
reg set;

//Parameter

//Main function
assign zero_o=set;
always @(src1_i,src2_i,ctrl_i) begin
	case(ctrl_i)
		0:result_o = src1_i&src2_i;
		1:result_o = src1_i|src2_i;
		2:result_o = src1_i+src2_i;
		3:result_o = src1_i*src2_i;
		6:result_o = src1_i-src2_i;
		7:result_o = src1_i<src2_i?1:0;
		12:result_o = ~(src1_i|src2_i);
		9:result_o = $signed(src2_i)>>>src1_i;
		10:result_o = src2_i<<16;
		11:
			if(src1_i!=src2_i)begin
				result_o<=1;
				set<=1;
			end
			else begin
				result_o<=0;
				set<=0;
			end
		default result_o <= 0;
	endcase
	set<=(result_o==0);
end

endmodule
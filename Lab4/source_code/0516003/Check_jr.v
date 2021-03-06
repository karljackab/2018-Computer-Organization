//Subject:     CO project 3 - Check_jr
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0516003李智嘉
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------


module Check_jr(
	ist_i,
	output_o);

// IO port
input [31:0]ist_i;
output output_o;

// parameter
reg out;

assign output_o=out;

always @(ist_i) begin
	if(ist_i[31:26]==6'd0 & ist_i[20:0]==21'd8)
		out=1'b1;
	else
		out=1'b0;
end

endmodule
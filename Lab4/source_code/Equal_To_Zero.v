//Subject:     CO project 3 - Equal_To_Zero
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0516003李智嘉
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Equal_To_Zero(
    src_i,
	output_o
	);
     
//I/O ports
input  [32-1:0]  src_i;
output 	 output_o;

//Internal Signals

reg output_o;

//Parameter

//Main function

always @(src_i) begin
	if(src_i == 32'b0)
		output_o <= 1'b0;
	else
		output_o <= 1'b1;
end

endmodule
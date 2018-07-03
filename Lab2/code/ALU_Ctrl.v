//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0516003李智嘉
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o,
          ALUSrc2_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
output ALUSrc2_o;
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
reg ALUSrc2_o=0;

//Parameter

       
//Select exact operation
always @(*) begin
	ALUSrc2_o=1'b0;
	case(ALUOp_i)
		3'b000:
			case(funct_i)
				6'b100001:ALUCtrl_o[3:0]<=4'd2;
				6'b100011:ALUCtrl_o[3:0]<=4'd6;
				6'b100100:ALUCtrl_o[3:0]<=4'd0;
				6'b100101:ALUCtrl_o[3:0]<=4'd1;
				6'b101010:ALUCtrl_o[3:0]<=4'd7;
				6'b000011:begin
					ALUCtrl_o[3:0]<=4'd9;
					ALUSrc2_o<=1'b1;
				end
				6'b000111:ALUCtrl_o[3:0]<=4'd9;
			endcase
		3'b001:ALUCtrl_o[3:0]<=4'd6;
		3'b010:ALUCtrl_o[3:0]<=4'd2;
		3'b011:ALUCtrl_o[3:0]<=4'd7;
		3'b100:ALUCtrl_o[3:0]<=4'd10;
		3'b101:ALUCtrl_o[3:0]<=4'd1;
		3'b110:ALUCtrl_o[3:0]<=4'd11;
	endcase
end

endmodule     





                    
                    
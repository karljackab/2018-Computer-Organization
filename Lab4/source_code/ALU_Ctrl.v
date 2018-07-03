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
	case(ALUOp_i)
		3'b000:
			case(funct_i)
				6'b100001:begin 
					ALUCtrl_o[3:0]=4'd2;
					ALUSrc2_o=1'b0;
				end
				6'b100011:begin
					ALUCtrl_o[3:0]=4'd6;
					ALUSrc2_o=1'b0;
				end
				6'b100100:begin
					ALUCtrl_o[3:0]=4'd0;
					ALUSrc2_o=1'b0;
				end
				6'b100101:begin
					ALUCtrl_o[3:0]=4'd1;
					ALUSrc2_o=1'b0;
				end
				6'b101010:begin
					ALUCtrl_o[3:0]=4'd7;
					ALUSrc2_o=1'b0;
				end
				6'b000011:begin
					ALUCtrl_o[3:0]=4'd9;
					ALUSrc2_o=1'b1;
				end
				6'b000111:begin
					ALUCtrl_o[3:0]=4'd9;
					ALUSrc2_o=1'b0;
				end
				6'b011000:begin
					ALUCtrl_o[3:0]=4'd3;
					ALUSrc2_o=1'b0;
				end
			endcase
		3'b001:begin
			ALUCtrl_o[3:0]=4'd6;
			ALUSrc2_o=1'b0;
		end
		3'b010:begin
			ALUCtrl_o[3:0]=4'd2;
			ALUSrc2_o=1'b0;
		end
		3'b011:begin
			ALUCtrl_o[3:0]=4'd7;
			ALUSrc2_o=1'b0;
		end
		3'b100:begin
			ALUCtrl_o[3:0]=4'd10;
			ALUSrc2_o=1'b0;
		end
		3'b101:begin
			ALUCtrl_o[3:0]=4'd1;
			ALUSrc2_o=1'b0;
		end
		3'b110:begin
			ALUCtrl_o[3:0]=4'd11;
			ALUSrc2_o=1'b0;
		end
	endcase
end

endmodule     





                    
                    
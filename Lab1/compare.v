// 0516003 李智嘉

module compare(
	less,		//1bit (input)
	equal,	//1bit (input)
	cmp,		//3bit compare code(input)
	result	//1bit (output)
);

input				less;
input				equal;
input	[3-1:0]	cmp;
output 			result;

reg result;

always @(*)
begin
	case(cmp)
		3'b000:	result=less;
		3'b001:	result=less|equal;
		3'b010:	result=~equal;
		3'b011:	result=equal;
		3'b111:	result=~less;
		3'b110:	result=(~less)&(~equal);
		default:	result=0;
	endcase
end

endmodule
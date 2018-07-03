// 0516003 李智嘉
`timescale 1ns/1ps

module alu_top(
	src1,		//1 bit source 1 (input)
	src2,		//1 bit source 2 (input)
	less,		//1 bit less     (input)
	A_invert,	//1 bit A_invert (input)
	B_invert,	//1 bit B_invert (input)
	cin,		//1 bit carry in (input)
	operation,	//operation      (input)
	equal,		//1 bit equal	 (input)
	cmp,		//3 bit bonus cmp(input)
	result,		//1 bit result   (output)
	cout,		//1 bit carry out(output)
	sub_result	//1 bit subtract res(output)
);

input			src1;
input			src2;
input			less;
input			A_invert;
input			B_invert;
input			cin;
input	[2-1:0]	operation;
input			equal;
input [3-1:0]	cmp;

output			result;
output			cout;
output	sub_result;

reg				result;
reg	cout;
wire	cmp_result;
reg sub_result;

compare c(less,equal,cmp,cmp_result);

always@( * )
begin
	case(operation)
		2'b00:
			begin
				result = (src1^A_invert)&(src2^B_invert);
				cout = cin;
			end
		2'b01:
			begin
				result = (src1^A_invert)|(src2^B_invert);
				cout = cin;
			end
		2'b10:
			begin
				{cout,result} = (src1^A_invert)+(src2^B_invert)+cin;
			end
		2'b11:
			begin
				{cout,sub_result} = (src1^A_invert)+(src2^B_invert)+cin;
				result=cmp_result;
			end
	endcase
end

endmodule
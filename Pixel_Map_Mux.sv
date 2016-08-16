module PixelMapMux (input Reset,
						  input [19:0][9:0][3:0] a,
						  input [19:0][9:0][3:0] b,
						  input [19:0][9:0][3:0] c,
						  input [1:0] sel,
						  output [19:0][9:0][3:0] out);

always_comb
begin
	out = '{default:4'b0};
	
	if (Reset)
		out = '{default:4'b0};

	if (sel == 2'd1)
		out = a;
	else if (sel == 2'd2)
		out = b;
	else
		out = c;

end


endmodule

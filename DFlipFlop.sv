module DFlipFlop (input Clk, Reset, Load,
						input [19:0][9:0][3:0] In,
						output [19:0][9:0][3:0] Out);

always_ff @ (posedge Clk or posedge Reset)
begin
	if (Reset)
		Out <= '{default:4'b0};
	
	else if (Load)
		Out <= In;
		
	else
		Out <= Out;
	
end

endmodule

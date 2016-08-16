module Pixel_Map_Reg (input Clk, Reset,
							 input [19:0][9:0][3:0] PRegIn,
							 input LoadReg,
							 input reset_game,
							 output [19:0][9:0][3:0] PRegOut);
							 
always_ff @ (posedge Clk or posedge Reset)
begin
	if (Reset)
		PRegOut <= '{default:4'b0}; 
	else if (reset_game)
		PRegOut <= '{default:4'b0}; 
	else if (LoadReg)
		PRegOut <= PRegIn;
		
	else
		PRegOut <= PRegOut;
end
							 
							 
endmodule

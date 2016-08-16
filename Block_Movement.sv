
module  Block_Movement (input Clk, Reset, MoveBlock,
								input [9:0] Block_X_Pos, Block_Y_Pos,
								output[9:0]  shape_x, shape_y);
    
    parameter [9:0] x_start = 298;
    parameter [9:0] y_start = 100;	 
	 
always_ff @ (posedge Clk)
begin
	if (Reset)
	begin
		shape_x <= x_start;
		shape_y <= y_start;
	end
	
	else if (MoveBlock)
	begin
		shape_x <= Block_X_Pos;
		shape_y <= Block_Y_Pos;
	end
	
	else
	begin
		shape_x <= shape_x;
		shape_y <= shape_y;
	end


end

endmodule





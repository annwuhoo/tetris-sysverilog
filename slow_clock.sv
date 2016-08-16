module slow_clock (input Clk,
						 output off_clk,
						 output slw_clk,
						 output slw_slw_clk);

logic [3:0] counter = 4'd0;
logic [2:0] counteroff = 3'd0;
logic [1:0] counter1 = 2'd0;

always_ff @ (posedge Clk)
begin
	counter = counter + 4'd1;
	
	if (counter == 4'b1111)
		begin
			counter = 4'b0;
			slw_slw_clk = ~slw_slw_clk;
		end
		
end

always_ff @ (posedge Clk)
begin
	counter1 = counter1 + 1'd1;
	
	if (counter1 == 2'b11)
		begin
			counter1 = 2'b0;
			slw_clk = ~slw_clk;
		end
		
end

always_ff @ (posedge Clk)
begin
	counteroff = counteroff + 1'd1;
		if (counteroff == 3'b010)
			begin
			counteroff = 3'b0;
			off_clk = ~off_clk;
			end
end

endmodule




// Slows down the clock by 10 times for all the other clocks
module fast_clock (input OrigClk,
						 output Clk);

logic [3:0] counter = 4'd0;

always_ff @ (posedge OrigClk)
begin
	counter = counter + 4'd1;
	
	if (counter == 4'd20)
		begin
			counter = 4'd0;
			Clk = ~Clk;
		end
		
end

endmodule




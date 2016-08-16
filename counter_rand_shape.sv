module counter_rand_shape (input Clk,
								   input touchdown,
									input ResetShape,
									input [15:0] keycode,
									output [2:0] Counteroff,
									output [2:0] holdshapeout,
									output [2:0] shape_num);
		
logic [2:0] Counter = 3'd1;
logic [2:0] shape = 3'd1;
logic [2:0] holdshape = 3'd0;
logic [2:0] temp;
logic act_once = 1'b0;

assign Counteroff = Counter;	
assign shape_num = shape;
assign holdshapeout = holdshape;

	always_ff @ (posedge Clk)
		begin
			if (Counter == 3'd8)
				begin
					Counter = 3'd1;
				end
			else if (touchdown||ResetShape)
				begin
					if ((shape == Counter)) // If the same, increment to next
					shape = Counter - 3'd1;
					else // Else, they are different and store
					shape = Counter;
				end
			else
				begin
					Counter = Counter + 3'd1;
				end		
		
			if ((~act_once) && (keycode == 16'h0013) && (holdshape == 3'd0)) // if P is Pressed, Hold old shape, generate new shape
				begin
				holdshape = shape;
				if (~(shape==Counter))
					begin
						shape = Counter + 1'd1;
					end
				else
					begin
						shape = Counter;
					end
				act_once = 1'b1;
				end
				
			else if ((~act_once) && (keycode == 16'h0013)) // if P is pressed, Swap Shapes
				begin
					temp = shape;
					shape = holdshape;
					holdshape = temp;
					act_once = 1'b1;
				end
			
			else if ((act_once) && (keycode == 16'h0000))
				begin
					act_once = 1'b0;
				end
		end
		
endmodule
						
//pseudo_rand_num

module rand_num (
						input logic Clk,
						input logic slw_clk,
						input logic Reset,
						input logic touchdown,
						input logic ResetShape,
						input logic [15:0] keycode,
						output logic [7:0] Randoutout,
						output logic [2:0] holdshape,
						output logic [2:0] shape_num);
						
	logic [2:0] rand_num;
	logic [7:0] Randout;
	logic [2:0] hold_shape_num = 3'd0;
	logic [2:0] temp;
	logic [15:0] keywant = 16'h0013; //'P' is pressed
	logic [2:0] shape = 3'd1;
	
	assign shape_num = shape;
	assign Randoutout = Randout;
	assign holdshape = hold_shape_num;

	enum logic [3:0] {Idle, Keypress_Do, Wait1, Wait2, Wait3, Wait4, Wait5} Next_State, State;
		
	lfsr rand_gen (.Clk(slw_clk),
						.Reset,
						.Enable(1),
						.Randout);
						
always_ff @ (posedge slw_clk or posedge Reset)
    begin  //Begin Initilization Procedure
		if (Reset)
			begin
				State <= Idle;
			end
		else 
			begin
				State <= Next_State;
			end
	 end
						
always_comb
    begin // Transitions Happen Here
    
    Next_State = State;
   
        unique case (State)
				
				Idle:
					begin
						if (keycode == keywant) //Goes to Swap Piece
						Next_State <= Keypress_Do;
						
						else if (touchdown||ResetShape)
						Next_State <= Wait1;
					end
					
				Keypress_Do:
					if (keycode == 16'h0000)
					Next_State <= Idle;
				
				Wait1:
					Next_State <= Wait2;
				
				Wait2:
					Next_State <= Wait3;
					
				Wait3:
					Next_State <= Wait4;
					
				Wait4:
					Next_State <= Wait4;
					
				Wait5:
					Next_State <= Idle;
				
		 endcase
	end
	
always_ff @ (posedge Clk)
	begin	
		unique case (State)

			Wait5:
				begin
					if (~(shape == Randout[4:2]))
						begin
						shape = Randout[4:2];
						end
				end
		
			Keypress_Do:
				begin
					if (hold_shape_num == 3'd0)
						begin
							hold_shape_num = shape;
							if (~(shape == Randout[4:2]))
							shape = Randout[4:2];
						end
					else
						begin
							temp = shape;
							shape = hold_shape_num;
							hold_shape_num = temp;
						end
				end
		endcase
	end
endmodule 
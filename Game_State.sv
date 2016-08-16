// Game State Module

module Game_State (input Clk,
						 input Reset,
						 input endgame,
						 input [15:0] keycode,
						 output       reset_game,
						 output [1:0] gamestate);
	
	enum logic [2:0] {Idle, Game, End} State, Next_State;
	
	always_ff @ (posedge Clk or posedge Reset)
    begin  //Begin Initilization Procedure
		if (Reset)
			begin
				State <= Idle;
			end
		else // Transition only if UP is pressed
			begin
				State <= Next_State;
			end
	 end
	
		
	always_comb
    begin // Transitions Happen Here
    
    Next_State = State;
   
        unique case (State)
				
				Idle:
					if (keycode == 16'h0028) //'Enter' is pressed
					Next_State <= Game;
				
				Game:
					if (endgame)
					Next_State <= End;
				
				End:
					if (keycode == 16'h0028) //'Enter' is pressed
					Next_State <= Game;
					
			default : ;
		
		endcase
		
	end
	
	
	always_ff @ (posedge Clk or posedge Reset)
		begin
				unique case(State)		
					Idle:
						begin
						gamestate = 2'd1;
						reset_game = 0;
						end
					Game:
						begin
						gamestate = 2'd2;
						reset_game = 0;
						end
					End:
						begin
						gamestate = 2'd3;
						if (keycode == 16'h0028) //'Enter' is pressed
						reset_game = 1;
						end
						default : ;
				endcase
		end
endmodule 
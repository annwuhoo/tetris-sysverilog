// State Machine for KeyPress

module keypress_state_machine (
								 input Clk,
								 input Reset,
								 input touchdown,
								 input ResetShape,
								 input [15:0] keycode,
								 output [2:0] keypress );

	enum logic [3:0] {State_A_1, State_A_2, State_S_1, State_D_1, State_D_2, State_SBar_1, State_SBar_2} Idle, State, Next_State;
	
	always_ff @ (posedge Clk or posedge Reset)
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
						if      (keycode == 16'h0004) //'a'
							Next_State <= State_A_1;
						else if (keycode == 16'h0007) //'d'
							Next_State <= State_D_1;
						else if (keycode == 16'h0016) //'s'
							Next_State <= State_S_1;
						else if (keycode == 16'h002C)
							Next_State <= State_SBar_1;
						end
				State_A_1: 
						Next_State <= State_A_2;
				State_A_2:
						begin
						if (keycode == 16'h0000)
						Next_State <= Idle;
						end
				State_D_1: 
						Next_State <= State_D_2;
				State_D_2:
						begin
						if (keycode == 16'h0000)
						Next_State <= Idle;
						end
				State_SBar_1:
						if (touchdown||ResetShape)
						Next_State <= State_SBar_2;
				State_SBar_2:
						if (keycode == 16'h0000)
						Next_State <= Idle;
				State_S_1: 
						Next_State <= Idle;
				default : ;
		endcase
	end
	
	always_comb
		begin
		//Default Zeros
			keypress = 3'd0;
			
		unique case (State)
				State_A_1:
					keypress = 3'd1;
				State_D_1:
					keypress = 3'd2;
				State_S_1:
					keypress = 3'd3;
				State_SBar_1:
					keypress = 3'd4;
				 default : ;
			endcase
		end
		
endmodule 

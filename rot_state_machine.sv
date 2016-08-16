// State Machine to Control Rotating Blocks

module rot_state_machine (
									input logic Clk,
									input logic Reset,
									input logic [15:0] keycode,
									output logic [1:0] shape_rot);
		
		enum logic [2:0] {State_0_1, State_0_2, State_1_1, State_1_2, State_2_1, State_2_2, State_3_1, State_3_2} State, Next_State, Hold;
		
		logic [15:0] keywant = 16'h001A; // 'W'
		
	always_ff @ (posedge Clk or posedge Reset)
    begin  //Begin Initilization Procedure
		if (Reset)
			begin
				State <= State_0_1;
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
				
				State_0_1:
					if (keycode == keywant)
					Next_State <= State_0_2;
				State_0_2:
					if (keycode == 16'h0000)
					Next_State <= State_1_1;
				State_1_1:
					if (keycode == keywant)
					Next_State <= State_1_2;
				State_1_2:
					if (keycode == 16'h0000)
					Next_State <= State_2_1;
				State_2_1:
					if (keycode == keywant)
					Next_State <= State_2_2;
				State_2_2:
					if (keycode == 16'h0000)
					Next_State <= State_3_1;
				State_3_1:
					if (keycode == keywant)
					Next_State <= State_3_2;
				State_3_2:
					if (keycode == 16'h0000)
					Next_State <= State_0_1;
					
			
			default : ;
		endcase
	end
	
	always_ff @ (posedge Clk or posedge Reset)
		begin
		//Default Zeros
			shape_rot = 2'd0;
			case(State)
					State_0_1:
						shape_rot = 2'd0;
					State_1_1:
						shape_rot = 2'd1;
					State_2_1:
						shape_rot = 2'd2;
					State_3_1:
						shape_rot = 2'd3;
				default : ;
			endcase
		end
		
endmodule 




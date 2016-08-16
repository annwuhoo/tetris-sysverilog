// State Machine to Control Rotating Blocks

module shapenum_state_machine (
									input logic Clk,
									input logic Reset,
									input logic touchdown,
									input logic [15:0] keycode,
									output logic [2:0] shape_num);
		
		enum logic [3:0] {State_0_1, State_0_2, State_1_1, State_1_2, State_2_1, State_2_2, State_3_1, State_3_2, State_4_1, State_4_2, State_5_1, State_5_2, State_6_1, State_6_2} State, Next_State;
		
		logic [15:0] keywant = 16'h0013; // P

						
always_ff @ (posedge Clk or posedge Reset)
    begin  //Begin Initilization Procedure
		if (Reset)
			begin
				State <= State_0_1;
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
					Next_State <= State_4_1;
				State_4_1:
					if (keycode == keywant)
					Next_State <= State_4_2;
				State_4_2:
					if (keycode == 16'h0000)
					Next_State <= State_5_1;
				State_5_1:
					if (keycode == keywant)
					Next_State <= State_5_2;
				State_5_2:
					if (keycode == 16'h0000)
					Next_State <= State_6_1;
				State_6_1:
					if (keycode == keywant)
					Next_State <= State_6_2;
				State_6_2:
					if (keycode == 16'h0000)
					Next_State <= State_0_1;
					
			
			default : ;
		endcase
	end
	
	always_comb
		begin
		//Default Zeros
			shape_num = 3'd0;
			
			case(State)
					State_0_1:
						shape_num = 3'd1;
					State_1_1:
						shape_num = 3'd2;
					State_2_1:
						shape_num = 3'd3;
					State_3_1:
						shape_num = 3'd4;
					State_4_1:
						shape_num = 3'd5;
					State_5_1:
						shape_num = 3'd6;
					State_6_1:
						shape_num = 3'd7;

				default : ;
			endcase
			
		end
		
endmodule 




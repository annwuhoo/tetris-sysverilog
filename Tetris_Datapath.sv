module Tetris_Datapath (input Clk, Reset, slw_slw_clk, reset_game,
								// inputs for Block.sv
								input [2:0] keypress,
								input [2:0] shape_num,
								input [1:0] shape_rot, gamestate,
								input [9:0] shape_size_x, shape_size_y,
								// outputs for Color_Mapper.sv
								output [9:0] shape_x, shape_y, 
								output [13:0] theScore,
								output [19:0][9:0][3:0] PixelMapOut,
								output ResetShapeout,
								output touchdownout,
								output endgame_out,
								output stopxleft, stopxright);


logic [19:0][9:0][3:0] PixelMap;
assign PixelMapOut = PixelMap; // Output from realpixmap
assign theScore = Score;
assign ResetShapeout = ResetShape;
assign touchdownout = touchdown;
assign endgame_out = endgame;
assign stopxleft = stop_x_left;
assign stopxright = stop_x_right;

// Internal logic to connect module instances
logic ResetShape, NeedsClear, NeedsLoad, touchdown, LoadRealReg, stop_x_left, stop_x_right, endgame; //MoveBlock
logic LoadAll, Load0, Load1, Load2, Load3, Load4, Load5, Load6, Load7, Load8, Load9, Load10, Load11, Load12, Load13, Load14, Load15, Load16, Load17, Load18, Load19;
logic line0, line1, line2, line3, line4, line5, line6, line7, line8, line9, line10, line11, line12, line13, line14, line15, line16, line17, line18, line19;
logic [9:0] shape_x_h, shape_y_h, Block_X_Pos, Block_Y_Pos;
logic [1:0] Mux_Select;
logic [19:0][9:0][3:0] load_map_h, clear_map_h, clear_map_out, temppixmap_in, p_mux_out, pixmap_to_load;
logic [4:0] CheckClear;
logic [13:0] Score;

// Outputs for Color_Mapper
assign shape_x = shape_x_h;
assign shape_y = shape_y_h;


	// Internal Register to hold PixelMap
	Pixel_Map_Reg realpixmap (.Clk,
									  .Reset,
									  .reset_game,
									  .PRegIn(p_mux_out),
									  .LoadReg(LoadRealReg),
									  .PRegOut(PixelMap));

	// Dynamic block				 
	Block block_inst ( .Reset,
							 .decis_clk(Clk),
							 .reset_game,
							 .Score,
							 .gamestate,
							 .keypress,
							 .stop_x_left,
							 .stop_x_right,
							 .touchdown,
							 .ResetShape,				
							 .shape_size_x,
							 .shape_size_y,
							 .shape_x(shape_x_h),	// Outputs to both Load_Pixel_Map and Color_Mapper
							 .shape_y(shape_y_h));

//	Block_Decisions bdeci_inst (.Reset,
//										 .decis_clk(Clk),
//										 .ResetShape,
//										 .reset_game,
//										 .stop_x_left,
//										 .stop_x_right,
//										 .gamestate,
//										 .Score,
//										 .keypress,
//										 .shape_size_x,
//										 .shape_size_y,
//										 .touchdown,
//										 .Block_X_Pos_out(Block_X_Pos),
//										 .Block_Y_Pos_out(Block_Y_Pos));
//							 
//	Block_Movement bmove_inst (.Clk,
//										.Reset,
//										.MoveBlock,
//										.Block_X_Pos,
//										.Block_Y_Pos,
//										.shape_x(shape_x_h),
//										.shape_y(shape_y_h));

	// loads appropriately into pixel_map depending on Block.sv
	Load_Pixel_Map loadmap0 (.Clk,							// From external
									 .Reset,							// From external
									 .reset_game,
									 //.ActivateLoad,				// from FSM
									 .PixelMapIn(PixelMap),		// From PMapReg
									 .PixelMapOut(load_map_h),	// to mux for internal PixelMap
									 .shape_x(shape_x_h),
									 .shape_y(shape_y_h),
									 .*);								// Inputs from Block.sv

	// Checks if fsm needs to go to load stage and clear stage (alters nothing). Provides individual logic if each line needs to be cleared.
	Check_Pixel_Map checkmap0 (.*);

	
	// Module to Implement Clear Pixel Map
/* module Temp_Pixel_Map_Reg (input Clk, Reset, LoadAll,
									input Load0, Load1, Load2, Load3, Load4, Load5, Load6, Load7, Load8, Load9, Load10, Load11, Load12, Load13, Load14, Load15,
											Load16, Load17, Load18, Load19,
									input [19:0][9:0][3:0] PixelMap,	// to initialize Clear sequence
									output [19:0][9:0][3:0] PixelMapOut);	*/

	Temp_Pixel_Map_Reg temppixmap (.PixelMapOut(clear_map_h),
											 .*);
							  						  
	// FSM: if any of the lines are all full, go to ActivateClear after ActivateLoad. else, swap between Block and Load
	Datapath_state_machine dsm0 (.*);

	// Mux to choose inputs to PixelMap		
	PixelMapMux pmmux0 (.Reset,
							  .a(load_map_h),
							  .b(clear_map_h),
							  .c(PixelMap),
							  .sel(Mux_Select),	// from FSM
							  .out(p_mux_out));
							  
endmodule

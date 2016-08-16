  //-------------------------------------------------------------------------
//      lab7_usb.sv                                                      --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Fall 2014 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 7                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module  lab8 		(    input         CLOCK_50,
                       input[3:0]    KEY, //bit 0 is set up as Reset
							  output [6:0]  HEX0, HEX1,// HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
							  output [8:0]  LEDG,
							  output [17:0] LEDR,
							  // VGA Interface 
                       output [7:0]  VGA_R,					//VGA Red
							                VGA_G,					//VGA Green
												 VGA_B,					//VGA Blue
							  output        VGA_CLK,				//VGA Clock
							                VGA_SYNC_N,			//VGA Sync signal
												 VGA_BLANK_N,			//VGA Blank signal
												 VGA_VS,					//VGA virtical sync signal	
												 VGA_HS,					//VGA horizontal sync signal
							  // CY7C67200 Interface
							  inout [15:0]  OTG_DATA,						//	CY7C67200 Data bus 16 Bits
							  output [1:0]  OTG_ADDR,						//	CY7C67200 Address 2 Bits
							  output        OTG_CS_N,						//	CY7C67200 Chip Select
												 OTG_RD_N,						//	CY7C67200 Write
												 OTG_WR_N,						//	CY7C67200 Read
												 OTG_RST_N,						//	CY7C67200 Reset
							  input			 OTG_INT,						//	CY7C67200 Interrupt
							  // SDRAM Interface for Nios II Software
							  output [12:0] DRAM_ADDR,				// SDRAM Address 13 Bits
							  inout [31:0]  DRAM_DQ,				// SDRAM Data 32 Bits
							  output [1:0]  DRAM_BA,				// SDRAM Bank Address 2 Bits
							  output [3:0]  DRAM_DQM,				// SDRAM Data Mast 4 Bits
							  output			 DRAM_RAS_N,			// SDRAM Row Address Strobe
							  output			 DRAM_CAS_N,			// SDRAM Column Address Strobe
							  output			 DRAM_CKE,				// SDRAM Clock Enable
							  output			 DRAM_WE_N,				// SDRAM Write Enable
							  output			 DRAM_CS_N,				// SDRAM Chip Select
							  output			 DRAM_CLK				// SDRAM Clock
											);
    
    logic Reset_h, vssig, Clk, slw_clk, slw_slw_clk, off_clk;
    logic [9:0] drawxsig, drawysig; 
	 logic [9:0] blockxsig, blockysig, blocksizesig_x, blocksizesig_y;
	 logic [15:0] keycode;
	 logic [2:0] keypress, shape_num, shapenext, shapenextnext;
	 logic [1:0] shape_rot,gamestate;
	 logic [9:0] shape_size_x, shape_size_y;
	 logic [9:0] shape_x, shape_y;
	 logic [13:0] Score;
	 logic [4:0] thousand_digit, hundred_digit, ten_digit, single_digit;
	 logic touchdown, reset_game, endgame, ResetShape, stopxleft, stopxright;
	 logic [19:0][9:0][3:0] PixelMapOut;
    logic [7:0] Randout;
	 logic [2:0] holdshape;
	 logic [2:0] Counteroff;
	 
	 assign Clk = CLOCK_50;
    assign {Reset_h}=~ (KEY[1]);  // The push buttons are active low
	 
	 wire [1:0] hpi_addr;
	 wire [15:0] hpi_data_in, hpi_data_out;
	 wire hpi_r, hpi_w,hpi_cs;
	 
	 hpi_io_intf hpi_io_inst(   .from_sw_address(hpi_addr),
										 .from_sw_data_in(hpi_data_in),
										 .from_sw_data_out(hpi_data_out),
										 .from_sw_r(hpi_r),
										 .from_sw_w(hpi_w),
										 .from_sw_cs(hpi_cs),
		 								 .OTG_DATA(OTG_DATA),    
										 .OTG_ADDR(OTG_ADDR),    
										 .OTG_RD_N(OTG_RD_N),    
										 .OTG_WR_N(OTG_WR_N),    
										 .OTG_CS_N(OTG_CS_N),    
										 .OTG_RST_N(OTG_RST_N),   
										 .OTG_INT(OTG_INT),
										 .Clk(Clk),
										 .Reset(Reset_h)
	 );
	 
	 //The connections for nios_system might be named different depending on how you set up Qsys
	 nios_system nios_system (
										 .clk_clk(Clk),         
										 .reset_reset_n(KEY[0]),   
										 .sdram_wire_addr(DRAM_ADDR), 
										 .sdram_wire_ba(DRAM_BA),   
										 .sdram_wire_cas_n(DRAM_CAS_N),
										 .sdram_wire_cke(DRAM_CKE),  
										 .sdram_wire_cs_n(DRAM_CS_N), 
										 .sdram_wire_dq(DRAM_DQ),   
										 .sdram_wire_dqm(DRAM_DQM),  
										 .sdram_wire_ras_n(DRAM_RAS_N),
										 .sdram_wire_we_n(DRAM_WE_N), 
										 .sdram_clk_clk(DRAM_CLK),
										 .keycode_export(keycode),  
										 .otg_hpi_address_export(hpi_addr),
										 .otg_hpi_data_in_port(hpi_data_in),
										 .otg_hpi_data_out_port(hpi_data_out),
										 .otg_hpi_cs_export(hpi_cs),
										 .otg_hpi_r_export(hpi_r),
										 .otg_hpi_w_export(hpi_w));

	
    vga_controller vgasync_instance(	.Clk(Clk),
													.Reset(Reset_h),
													.hs(VGA_HS),
													.vs(VGA_VS),
													.pixel_clk(VGA_CLK),
													.blank(VGA_BLANK_N),
													.sync(VGA_SYNC_N), // active low, not used in lab
													.DrawX(drawxsig),
													.DrawY(drawysig));
									
		rot_state_machine rsm (.Clk,
									  .Reset(Reset_h),
									  .keycode,
									  .shape_rot);	
	//------------------SHAPE NUM BLOCKS----------------//
		// shapenum_state_machine snsm (.Clk,
		// 									  .touchdown,
		// 									  .Reset(Reset_h),
		// 									  .keycode,
		// 									  .shape_num);


  		rand_table (.Clk,
  					.Reset(Reset_h),
   					.ResetShape,
  					.touchdown,
   					.keycode,
  					.shape_num,
					.endgame,
					.shapenext,
					.shapenextnext,
  					.holdshape);
											  
											  
//		counter_rand_shape crs_gen(.Clk(off_clk),
//											.touchdown,
//											.ResetShape,
//											.keycode,
//											.holdshapeout(holdshape),
//											.shape_num);
//
//			rand_num (.Clk,
//						 .slw_clk,
//						 .Reset(Reset_h),
//						 .ResetShape,
//						 .touchdown,
//						 .keycode,
//						 .Randoutout(Randout),
//						 .holdshape,
//						.shape_num);
//--------------------------------------------------------//

	keypress_state_machine kpsm (.Clk(Clk), 
										  .Reset(Reset_h),
										  .keycode,
										  .touchdown,
										  .ResetShape,
										  .keypress);

		Block_Param  blockparam1 (.shape_num,
										  .shape_rot,
										  .shape_size_x,
										  .shape_size_y);

	
	 Tetris_Datapath tetris_screen (.Clk,
											  .slw_slw_clk,
											  .Reset(Reset_h),
											  .keypress,		// Inputs for Block.sv
											  .shape_size_x,
											  .shape_size_y,
											  .shape_num,
											  .shape_rot,
											  .shape_x,			// This and below: Ouputs to Color_Mapper
											  .shape_y,
											  .reset_game,
											  .gamestate,
											  .ResetShapeout(ResetShape), 
											  .touchdownout(touchdown),
											  .theScore(Score),
											  .endgame_out(endgame),
											  .stopxright,
											  .stopxleft,
											  .PixelMapOut);
	 
	Score_Board game_score (//.Clk,
									.Reset(Reset_h),
									.reset_game,
									.Score,
									.thousand_digit,
									.hundred_digit,
									.ten_digit,
									.single_digit);
	 
    color_mapper color_instance(	.DrawX(drawxsig),
											.DrawY(drawysig),
											.keycode,
											.shape_num,
											.shape_rot,
											.shape_x,
											.shape_y,
											.shape_size_x,
											.shape_size_y,
											.thousand_digit,
											.hundred_digit,
											.ten_digit,
											.single_digit,
											.gamestate,
											.holdshape,
											.shapenext,
											.shapenextnext,
											//.endgame,
											//.touchdown,
											.PixelMapOut,
											.Red(VGA_R),
											.Green(VGA_G),
											.Blue(VGA_B));
						 
	Game_State gs0 (.Clk,
						 .Reset(Reset_h),
						 .endgame,
						 .keycode,
						 .reset_game,
						 .gamestate);
							 	
	
	
		slow_clock slw (.Clk,
							.off_clk,
							 .slw_clk,
							 .slw_slw_clk);
							 

// lfsr lsfr1 (.Clk(slw_slw_clk),
//						 .Reset(Reset_h),
//						 .Enable(1),
//						 .Randout);
		
	
		assign LEDG[1:0] = shape_rot;
		assign LEDG[4:2] = shape_num;
		assign LEDG[6] = stopxright;
		assign LEDG[7] = stopxleft;
		assign LEDR[5:3] = Counteroff;
		assign LEDR[2:0] = holdshape[2:0];
	 HexDriver hex_inst_0 (keycode[3:0], HEX0);
	 HexDriver hex_inst_1 (keycode[7:4], HEX1);
	 
    
endmodule




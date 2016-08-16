module Big_Pixel_Map (input Clk, Reset,		
						// Inputs from Block.sv
                  input [9:0] shape_x, shape_y, 		// Bottom right coord of shape
						input [1:0] shape_num, shape_rot,	// What shape it is
						input touchdown,
						// Outputs to Block.sv
						output ResetShape,
						// Output to Color_Mapper.sv
						output [79:0][39:0][3:0] PixelMapOut
						//output [3:0] MapCurrPixel
						); 
							 

logic [79:0][39:0][3:0] PixelMap; // scale down of 320x160 --> 80x40

// scale down the shape_x and shape_y to the smaller version
logic [9:0] scaled_x, scaled_y, offset_x, offset_y;
logic [4:0] be = 4;
logic [9:0] shape_x_board = 250;
logic [9:0] shape_y_board = 100;
logic [9:0] shape_size_x_board = 160;
logic [9:0] shape_size_y_board = 320;

assign offset_x = (shape_x - shape_x_board);
assign offset_y = (shape_y - shape_y_board);
assign scaled_x = (offset_x - (offset_x%be))/be;
assign scaled_y = (offset_y - (offset_y%be))/be;

// Sprites
logic [3:0][15:0][3:0] I_block_h;
logic [15:0][3:0][3:0] I_block_v;
logic [7:0][7:0][3:0] O_block;
Sprite_Table_FE ST(.I_block_h,
						 .I_block_v,
						 .O_block);

// Output the pixel map pixels to ColorMapper
assign PixelMapOut = PixelMap;

// Check the map
always_ff @ (posedge Clk)
begin
	ResetShape <= 1'b0;
	if (Reset) begin
		PixelMap <= '{default:4'b0}; // fill it all with zeros	
	end
	
	unique case(shape_num)
		// I BLOCK: reference scaled_x and scaled_y represent top left coordinates
		2'd1 : begin
					if (shape_rot == 2'd0 || shape_rot == 2'd2) begin // I_block_h: 4x16
						// If touch down or collision, load into pixel map
						if ((touchdown == 1'b1) || ((PixelMap[scaled_y+5][scaled_x+1] > 0) || (PixelMap[scaled_y+5][scaled_x+5] > 0) || (PixelMap[scaled_y+5][scaled_x+14] > 0)))  begin
							// first row
							PixelMap[scaled_y][scaled_x] <= I_block_h[0][0];
							PixelMap[scaled_y][scaled_x+1] <= I_block_h[0][1];
							PixelMap[scaled_y][scaled_x+2] <= I_block_h[0][2];
							PixelMap[scaled_y][scaled_x+3] <= I_block_h[0][3];
							PixelMap[scaled_y][scaled_x+4] <= I_block_h[0][4];
							PixelMap[scaled_y][scaled_x+5] <= I_block_h[0][5];
							PixelMap[scaled_y][scaled_x+6] <= I_block_h[0][6];
							PixelMap[scaled_y][scaled_x+7] <= I_block_h[0][7];
							PixelMap[scaled_y][scaled_x+8] <= I_block_h[0][8];
							PixelMap[scaled_y][scaled_x+9] <= I_block_h[0][9];
							PixelMap[scaled_y][scaled_x+10] <= I_block_h[0][10];
							PixelMap[scaled_y][scaled_x+11] <= I_block_h[0][11];
							PixelMap[scaled_y][scaled_x+12] <= I_block_h[0][12];
							PixelMap[scaled_y][scaled_x+13] <= I_block_h[0][13];
							PixelMap[scaled_y][scaled_x+14] <= I_block_h[0][14];
							PixelMap[scaled_y][scaled_x+15] <= I_block_h[0][15];
							// second row
							PixelMap[scaled_y+1][scaled_x] <= I_block_h[1][0];
							PixelMap[scaled_y+1][scaled_x+1] <= I_block_h[1][1];
							PixelMap[scaled_y+1][scaled_x+2] <= I_block_h[1][2];
							PixelMap[scaled_y+1][scaled_x+3] <= I_block_h[1][3];
							PixelMap[scaled_y+1][scaled_x+4] <= I_block_h[1][4];
							PixelMap[scaled_y+1][scaled_x+5] <= I_block_h[1][5];
							PixelMap[scaled_y+1][scaled_x+6] <= I_block_h[1][6];
							PixelMap[scaled_y+1][scaled_x+7] <= I_block_h[1][7];
							PixelMap[scaled_y+1][scaled_x+8] <= I_block_h[1][8];
							PixelMap[scaled_y+1][scaled_x+9] <= I_block_h[1][9];
							PixelMap[scaled_y+1][scaled_x+10] <= I_block_h[1][10];
							PixelMap[scaled_y+1][scaled_x+11] <= I_block_h[1][11];
							PixelMap[scaled_y+1][scaled_x+12] <= I_block_h[1][12];
							PixelMap[scaled_y+1][scaled_x+13] <= I_block_h[1][13];
							PixelMap[scaled_y+1][scaled_x+14] <= I_block_h[1][14];
							PixelMap[scaled_y+1][scaled_x+15] <= I_block_h[1][15];
							// third row
							PixelMap[scaled_y+2][scaled_x] <= I_block_h[2][0];
							PixelMap[scaled_y+2][scaled_x+1] <= I_block_h[2][1];
							PixelMap[scaled_y+2][scaled_x+2] <= I_block_h[2][2];
							PixelMap[scaled_y+2][scaled_x+3] <= I_block_h[2][3];
							PixelMap[scaled_y+2][scaled_x+4] <= I_block_h[2][4];
							PixelMap[scaled_y+2][scaled_x+5] <= I_block_h[2][5];
							PixelMap[scaled_y+2][scaled_x+6] <= I_block_h[2][6];
							PixelMap[scaled_y+2][scaled_x+7] <= I_block_h[2][7];
							PixelMap[scaled_y+2][scaled_x+8] <= I_block_h[2][8];
							PixelMap[scaled_y+2][scaled_x+9] <= I_block_h[2][9];
							PixelMap[scaled_y+2][scaled_x+10] <= I_block_h[2][10];
							PixelMap[scaled_y+2][scaled_x+11] <= I_block_h[2][11];
							PixelMap[scaled_y+2][scaled_x+12] <= I_block_h[2][12];
							PixelMap[scaled_y+2][scaled_x+13] <= I_block_h[2][13];
							PixelMap[scaled_y+2][scaled_x+14] <= I_block_h[2][14];
							PixelMap[scaled_y+2][scaled_x+15] <= I_block_h[2][15];
							// fourth row
							PixelMap[scaled_y+3][scaled_x] <= I_block_h[3][0];
							PixelMap[scaled_y+3][scaled_x+1] <= I_block_h[3][1];
							PixelMap[scaled_y+3][scaled_x+2] <= I_block_h[3][2];
							PixelMap[scaled_y+3][scaled_x+3] <= I_block_h[3][3];
							PixelMap[scaled_y+3][scaled_x+4] <= I_block_h[3][4];
							PixelMap[scaled_y+3][scaled_x+5] <= I_block_h[3][5];
							PixelMap[scaled_y+3][scaled_x+6] <= I_block_h[3][6];
							PixelMap[scaled_y+3][scaled_x+7] <= I_block_h[3][7];
							PixelMap[scaled_y+3][scaled_x+8] <= I_block_h[3][8];
							PixelMap[scaled_y+3][scaled_x+9] <= I_block_h[3][9];
							PixelMap[scaled_y+3][scaled_x+10] <= I_block_h[3][10];
							PixelMap[scaled_y+3][scaled_x+11] <= I_block_h[3][11];
							PixelMap[scaled_y+3][scaled_x+12] <= I_block_h[3][12];
							PixelMap[scaled_y+3][scaled_x+13] <= I_block_h[3][13];
							PixelMap[scaled_y+3][scaled_x+14] <= I_block_h[3][14];
							PixelMap[scaled_y+3][scaled_x+15] <= I_block_h[3][15];							
							// Reset block
							ResetShape <= 1'b1;
						end
					end
					
					else begin // I_block_v: 4x1
						if ((touchdown == 1'b1) || (PixelMap[scaled_y+16][scaled_x] > 0)) begin
							// first column
							PixelMap[scaled_y][scaled_x] <= I_block_v[0][0];
							PixelMap[scaled_y+1][scaled_x] <= I_block_v[1][0];
							PixelMap[scaled_y+2][scaled_x] <= I_block_v[2][0];
							PixelMap[scaled_y+3][scaled_x] <= I_block_v[3][0];
							PixelMap[scaled_y+4][scaled_x] <= I_block_v[4][0];
							PixelMap[scaled_y+5][scaled_x] <= I_block_v[5][0];
							PixelMap[scaled_y+6][scaled_x] <= I_block_v[6][0];
							PixelMap[scaled_y+7][scaled_x] <= I_block_v[7][0];
							PixelMap[scaled_y+8][scaled_x] <= I_block_v[8][0];
							PixelMap[scaled_y+9][scaled_x] <= I_block_v[9][0];
							PixelMap[scaled_y+10][scaled_x] <= I_block_v[10][0];
							PixelMap[scaled_y+11][scaled_x] <= I_block_v[11][0];
							PixelMap[scaled_y+12][scaled_x] <= I_block_v[12][0];
							PixelMap[scaled_y+13][scaled_x] <= I_block_v[13][0];
							PixelMap[scaled_y+14][scaled_x] <= I_block_v[14][0];
							PixelMap[scaled_y+15][scaled_x] <= I_block_v[15][0];
							// second col
							PixelMap[scaled_y][scaled_x+1] <= I_block_v[0][1];
							PixelMap[scaled_y+1][scaled_x+1] <= I_block_v[1][1];
							PixelMap[scaled_y+2][scaled_x+1] <= I_block_v[2][1];
							PixelMap[scaled_y+3][scaled_x+1] <= I_block_v[3][1];
							PixelMap[scaled_y+4][scaled_x+1] <= I_block_v[4][1];
							PixelMap[scaled_y+5][scaled_x+1] <= I_block_v[5][1];
							PixelMap[scaled_y+6][scaled_x+1] <= I_block_v[6][1];
							PixelMap[scaled_y+7][scaled_x+1] <= I_block_v[7][1];
							PixelMap[scaled_y+8][scaled_x+1] <= I_block_v[8][1];
							PixelMap[scaled_y+9][scaled_x+1] <= I_block_v[9][1];
							PixelMap[scaled_y+10][scaled_x+1] <= I_block_v[10][1];
							PixelMap[scaled_y+11][scaled_x+1] <= I_block_v[11][1];
							PixelMap[scaled_y+12][scaled_x+1] <= I_block_v[12][1];
							PixelMap[scaled_y+13][scaled_x+1] <= I_block_v[13][1];
							PixelMap[scaled_y+14][scaled_x+1] <= I_block_v[14][1];
							PixelMap[scaled_y+15][scaled_x+1] <= I_block_v[15][1];
							// third col
							PixelMap[scaled_y][scaled_x+2] <= I_block_v[0][2];
							PixelMap[scaled_y+1][scaled_x+2] <= I_block_v[1][2];
							PixelMap[scaled_y+2][scaled_x+2] <= I_block_v[2][2];
							PixelMap[scaled_y+3][scaled_x+2] <= I_block_v[3][2];
							PixelMap[scaled_y+4][scaled_x+2] <= I_block_v[4][2];
							PixelMap[scaled_y+5][scaled_x+2] <= I_block_v[5][2];
							PixelMap[scaled_y+6][scaled_x+2] <= I_block_v[6][2];
							PixelMap[scaled_y+7][scaled_x+2] <= I_block_v[7][2];
							PixelMap[scaled_y+8][scaled_x+2] <= I_block_v[8][2];
							PixelMap[scaled_y+9][scaled_x+2] <= I_block_v[9][2];
							PixelMap[scaled_y+10][scaled_x+2] <= I_block_v[10][2];
							PixelMap[scaled_y+11][scaled_x+2] <= I_block_v[11][2];
							PixelMap[scaled_y+12][scaled_x+2] <= I_block_v[12][2];
							PixelMap[scaled_y+13][scaled_x+2] <= I_block_v[13][2];
							PixelMap[scaled_y+14][scaled_x+2] <= I_block_v[14][2];
							PixelMap[scaled_y+15][scaled_x+2] <= I_block_v[15][2];
							// fourth col
							PixelMap[scaled_y][scaled_x+3] <= I_block_v[0][3];
							PixelMap[scaled_y+1][scaled_x+3] <= I_block_v[1][3];
							PixelMap[scaled_y+2][scaled_x+3] <= I_block_v[2][3];
							PixelMap[scaled_y+3][scaled_x+3] <= I_block_v[3][3];
							PixelMap[scaled_y+4][scaled_x+3] <= I_block_v[4][3];
							PixelMap[scaled_y+5][scaled_x+3] <= I_block_v[5][3];
							PixelMap[scaled_y+6][scaled_x+3] <= I_block_v[6][3];
							PixelMap[scaled_y+7][scaled_x+3] <= I_block_v[7][3];
							PixelMap[scaled_y+8][scaled_x+3] <= I_block_v[8][3];
							PixelMap[scaled_y+9][scaled_x+3] <= I_block_v[9][3];
							PixelMap[scaled_y+10][scaled_x+3] <= I_block_v[10][3];
							PixelMap[scaled_y+11][scaled_x+3] <= I_block_v[11][3];
							PixelMap[scaled_y+12][scaled_x+3] <= I_block_v[12][3];
							PixelMap[scaled_y+13][scaled_x+3] <= I_block_v[13][3];
							PixelMap[scaled_y+14][scaled_x+3] <= I_block_v[14][3];
							PixelMap[scaled_y+15][scaled_x+3] <= I_block_v[15][3];
							// Reset block
							ResetShape <= 1'b1;
						end					
					end
				end
				
		// O BLOCK
		2'd2 : begin
					if ((touchdown == 1'b1) || (PixelMap[scaled_y+8][scaled_x] > 0) || (PixelMap[scaled_y+8][scaled_x+5] > 0)) begin
						// First row
						PixelMap[scaled_y][scaled_x] <= O_block[0][0];
						PixelMap[scaled_y][scaled_x+1] <= O_block[0][1];
						PixelMap[scaled_y][scaled_x+2] <= O_block[0][2];
						PixelMap[scaled_y][scaled_x+3] <= O_block[0][3];
						PixelMap[scaled_y][scaled_x+4] <= O_block[0][4];
						PixelMap[scaled_y][scaled_x+5] <= O_block[0][5];
						PixelMap[scaled_y][scaled_x+6] <= O_block[0][6];
						PixelMap[scaled_y][scaled_x+7] <= O_block[0][7];						
						// Second row
						PixelMap[scaled_y+1][scaled_x] <= O_block[1][0];
						PixelMap[scaled_y+1][scaled_x+1] <= O_block[1][1];
						PixelMap[scaled_y+1][scaled_x+2] <= O_block[1][2];
						PixelMap[scaled_y+1][scaled_x+3] <= O_block[1][3];
						PixelMap[scaled_y+1][scaled_x+4] <= O_block[1][4];
						PixelMap[scaled_y+1][scaled_x+5] <= O_block[1][5];
						PixelMap[scaled_y+1][scaled_x+6] <= O_block[1][6];
						PixelMap[scaled_y+1][scaled_x+7] <= O_block[1][7];	
						// Third row
						PixelMap[scaled_y+2][scaled_x] <= O_block[2][0];
						PixelMap[scaled_y+2][scaled_x+1] <= O_block[2][1];
						PixelMap[scaled_y+2][scaled_x+2] <= O_block[2][2];
						PixelMap[scaled_y+2][scaled_x+3] <= O_block[2][3];
						PixelMap[scaled_y+2][scaled_x+4] <= O_block[2][4];
						PixelMap[scaled_y+2][scaled_x+5] <= O_block[2][5];
						PixelMap[scaled_y+2][scaled_x+6] <= O_block[2][6];
						PixelMap[scaled_y+2][scaled_x+7] <= O_block[2][7];							
						// Fourth row
						PixelMap[scaled_y+3][scaled_x] <= O_block[3][0];
						PixelMap[scaled_y+3][scaled_x+1] <= O_block[3][1];
						PixelMap[scaled_y+3][scaled_x+2] <= O_block[3][2];
						PixelMap[scaled_y+3][scaled_x+3] <= O_block[3][3];
						PixelMap[scaled_y+3][scaled_x+4] <= O_block[3][4];
						PixelMap[scaled_y+3][scaled_x+5] <= O_block[3][5];
						PixelMap[scaled_y+3][scaled_x+6] <= O_block[3][6];
						PixelMap[scaled_y+3][scaled_x+7] <= O_block[3][7];	
						// Fifth row
						PixelMap[scaled_y+4][scaled_x] <= O_block[4][0];
						PixelMap[scaled_y+4][scaled_x+1] <= O_block[4][1];
						PixelMap[scaled_y+4][scaled_x+2] <= O_block[4][2];
						PixelMap[scaled_y+4][scaled_x+3] <= O_block[4][3];
						PixelMap[scaled_y+4][scaled_x+4] <= O_block[4][4];
						PixelMap[scaled_y+4][scaled_x+5] <= O_block[4][5];
						PixelMap[scaled_y+4][scaled_x+6] <= O_block[4][6];
						PixelMap[scaled_y+4][scaled_x+7] <= O_block[4][7];	
						// Sixth row
						PixelMap[scaled_y+5][scaled_x] <= O_block[5][0];
						PixelMap[scaled_y+5][scaled_x+1] <= O_block[5][1];
						PixelMap[scaled_y+5][scaled_x+2] <= O_block[5][2];
						PixelMap[scaled_y+5][scaled_x+3] <= O_block[5][3];
						PixelMap[scaled_y+5][scaled_x+4] <= O_block[5][4];
						PixelMap[scaled_y+5][scaled_x+5] <= O_block[5][5];
						PixelMap[scaled_y+5][scaled_x+6] <= O_block[5][6];
						PixelMap[scaled_y+5][scaled_x+7] <= O_block[5][7];	
						// Seventh row
						PixelMap[scaled_y+6][scaled_x] <= O_block[6][0];
						PixelMap[scaled_y+6][scaled_x+1] <= O_block[6][1];
						PixelMap[scaled_y+6][scaled_x+2] <= O_block[6][2];
						PixelMap[scaled_y+6][scaled_x+3] <= O_block[6][3];
						PixelMap[scaled_y+6][scaled_x+4] <= O_block[6][4];
						PixelMap[scaled_y+6][scaled_x+5] <= O_block[6][5];
						PixelMap[scaled_y+6][scaled_x+6] <= O_block[6][6];
						PixelMap[scaled_y+6][scaled_x+7] <= O_block[6][7];	
						// Eighth row
						PixelMap[scaled_y+7][scaled_x] <= O_block[7][0];
						PixelMap[scaled_y+7][scaled_x+1] <= O_block[7][1];
						PixelMap[scaled_y+7][scaled_x+2] <= O_block[7][2];
						PixelMap[scaled_y+7][scaled_x+3] <= O_block[7][3];
						PixelMap[scaled_y+7][scaled_x+4] <= O_block[7][4];
						PixelMap[scaled_y+7][scaled_x+5] <= O_block[7][5];
						PixelMap[scaled_y+7][scaled_x+6] <= O_block[7][6];
						PixelMap[scaled_y+7][scaled_x+7] <= O_block[7][7];	
						// Reset block
						ResetShape <= 1'b1;						
					end		
				end
	endcase
	
end
endmodule

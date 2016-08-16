// Performs clear operation: Based on FSM, it checks and (if necessary) performs clear for each line.
module Clear_Pixel_Map(//input Clk,
							  input [4:0] CheckClear, // from FSM: dictates which line to check for this clock cycle
							  input fast_clk,
							  input [19:0][9:0][3:0] PixelMapIn,
							  input line0, line1, line2, line3, line4, line5, line6, line7, line8, line9, line10, line11, line12, line13, line14, line15, line16, line17, line18, line19,
							  output [19:0][9:0][3:0] PixelMapOut
							  );

logic [19:0][9:0][3:0] CurrPixelMap;			  
logic [3:0] iter;

// Create fast counter to copy each line [0:9]
always_ff @ (posedge fast_clk)
begin
	iter <= iter + 4'd1;
	
	if (iter == 4'd10)
			iter <= 4'd0;
end

// CLEAR PROCEDURE:
// max is clear 4 lines at a time
always_comb
begin
	CurrPixelMap = PixelMapIn;
	
	case(CheckClear)
		5'd0 : begin
					if (line0) begin
						CurrPixelMap[0][iter] = 4'd0;
					end
				 end
				 
		5'd1 : begin
					if (line1) begin
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				 end
	
		5'd2 : begin
					if (line2) begin
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				 end
		
		5'd3 : begin
					if (line3) begin
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				 end
			
		5'd4 : begin
					if (line4) begin
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				 end
			
		5'd5 : begin
					if (line5) begin
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				 end
			
		5'd6 : begin
					if (line6) begin
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				 end
		
		5'd7 : begin
					if (line7) begin
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				 end
			
		5'd8 : begin
					if (line8) begin
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				 end
		
		5'd9 : begin
					if (line9) begin
						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				 end
		
		5'd10 : begin
					if (line10) begin
						CurrPixelMap[10][iter] = PixelMapIn[9][iter];
						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				  end
		
		5'd11 : begin
					if (line11) begin
						CurrPixelMap[11][iter] = PixelMapIn[10][iter];
						CurrPixelMap[10][iter] = PixelMapIn[9][iter];
						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				  end
		
		5'd12 : begin
					if (line12) begin
						CurrPixelMap[12][iter] = PixelMapIn[11][iter];
						CurrPixelMap[11][iter] = PixelMapIn[10][iter];
						CurrPixelMap[10][iter] = PixelMapIn[9][iter];
						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				  end
		
		5'd13 : begin
					if (line13) begin
						CurrPixelMap[13][iter] = PixelMapIn[12][iter];
						CurrPixelMap[12][iter] = PixelMapIn[11][iter];
						CurrPixelMap[11][iter] = PixelMapIn[10][iter];
						CurrPixelMap[10][iter] = PixelMapIn[9][iter];
						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				  end
		
		5'd14 : begin
					if (line14) begin
						CurrPixelMap[14][iter] = PixelMapIn[13][iter];
						CurrPixelMap[13][iter] = PixelMapIn[12][iter];
						CurrPixelMap[12][iter] = PixelMapIn[11][iter];
						CurrPixelMap[11][iter] = PixelMapIn[10][iter];
						CurrPixelMap[10][iter] = PixelMapIn[9][iter];
						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				  end
		
		5'd15 : begin
					if (line15) begin
						CurrPixelMap[15][iter] = PixelMapIn[14][iter];
						CurrPixelMap[14][iter] = PixelMapIn[13][iter];
						CurrPixelMap[13][iter] = PixelMapIn[12][iter];
						CurrPixelMap[12][iter] = PixelMapIn[11][iter];
						CurrPixelMap[11][iter] = PixelMapIn[10][iter];
						CurrPixelMap[10][iter] = PixelMapIn[9][iter];
						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				  end
		
		5'd16 : begin
					if (line16) begin
						CurrPixelMap[16][iter] = PixelMapIn[15][iter];
						CurrPixelMap[15][iter] = PixelMapIn[14][iter];
						CurrPixelMap[14][iter] = PixelMapIn[13][iter];
						CurrPixelMap[13][iter] = PixelMapIn[12][iter];
						CurrPixelMap[12][iter] = PixelMapIn[11][iter];
						CurrPixelMap[11][iter] = PixelMapIn[10][iter];
						CurrPixelMap[10][iter] = PixelMapIn[9][iter];
						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end
			     end	
		
		5'd17 : begin
					if (line17) begin
						CurrPixelMap[17][iter] = PixelMapIn[16][iter];
						CurrPixelMap[16][iter] = PixelMapIn[15][iter];
						CurrPixelMap[15][iter] = PixelMapIn[14][iter];
						CurrPixelMap[14][iter] = PixelMapIn[13][iter];
						CurrPixelMap[13][iter] = PixelMapIn[12][iter];
						CurrPixelMap[12][iter] = PixelMapIn[11][iter];
						CurrPixelMap[11][iter] = PixelMapIn[10][iter];
						CurrPixelMap[10][iter] = PixelMapIn[9][iter];
						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				  end
		
		5'd18 : begin
					if (line18) begin
						CurrPixelMap[18][iter] = PixelMapIn[17][iter];
						CurrPixelMap[17][iter] = PixelMapIn[16][iter];
						CurrPixelMap[16][iter] = PixelMapIn[15][iter];
						CurrPixelMap[15][iter] = PixelMapIn[14][iter];
						CurrPixelMap[14][iter] = PixelMapIn[13][iter];
						CurrPixelMap[13][iter] = PixelMapIn[12][iter];
						CurrPixelMap[12][iter] = PixelMapIn[11][iter];
						CurrPixelMap[11][iter] = PixelMapIn[10][iter];
						CurrPixelMap[10][iter] = PixelMapIn[9][iter];
						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
					end	
				  end
		
		5'd19 : begin
					if (line19) begin
						CurrPixelMap[19][iter] = PixelMapIn[18][iter];
						CurrPixelMap[18][iter] = PixelMapIn[17][iter];
						CurrPixelMap[17][iter] = PixelMapIn[16][iter];
						CurrPixelMap[16][iter] = PixelMapIn[15][iter];
						CurrPixelMap[15][iter] = PixelMapIn[14][iter];
						CurrPixelMap[14][iter] = PixelMapIn[13][iter];
						CurrPixelMap[13][iter] = PixelMapIn[12][iter];
						CurrPixelMap[12][iter] = PixelMapIn[11][iter];
						CurrPixelMap[11][iter] = PixelMapIn[10][iter];
						CurrPixelMap[10][iter] = PixelMapIn[9][iter];
						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
						CurrPixelMap[0][iter] = 4'd0;
						
//						CurrPixelMap[0][iter] = 4'd0;
//						CurrPixelMap[1][iter] = PixelMapIn[0][iter];
//						CurrPixelMap[2][iter] = PixelMapIn[1][iter];
//						CurrPixelMap[3][iter] = PixelMapIn[2][iter];
//						CurrPixelMap[4][iter] = PixelMapIn[3][iter];
//						CurrPixelMap[5][iter] = PixelMapIn[4][iter];
//						CurrPixelMap[6][iter] = PixelMapIn[5][iter];
//						CurrPixelMap[7][iter] = PixelMapIn[6][iter];
//						CurrPixelMap[8][iter] = PixelMapIn[7][iter];
//						CurrPixelMap[9][iter] = PixelMapIn[8][iter];
//						CurrPixelMap[10][iter] = PixelMapIn[9][iter];
//						CurrPixelMap[11][iter] = PixelMapIn[10][iter];
//						CurrPixelMap[12][iter] = PixelMapIn[11][iter];
//						CurrPixelMap[13][iter] = PixelMapIn[12][iter];
//						CurrPixelMap[14][iter] = PixelMapIn[13][iter];
//						CurrPixelMap[15][iter] = PixelMapIn[14][iter];
//						CurrPixelMap[16][iter] = PixelMapIn[15][iter];
//						CurrPixelMap[17][iter] = PixelMapIn[16][iter];
//						CurrPixelMap[18][iter] = PixelMapIn[17][iter];
//						CurrPixelMap[19][iter] = PixelMapIn[18][iter];	
					 end
					end
		endcase
		
		PixelMapOut = CurrPixelMap;
		
end



endmodule

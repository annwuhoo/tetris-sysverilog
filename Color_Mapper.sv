//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input         [9:0]  DrawX, DrawY,
							  input         [9:0]  shape_size_x, shape_size_y, shape_x, shape_y,
							  input         [2:0]  shape_num, holdshape, shapenext, shapenextnext,
							  input         [1:0]  shape_rot, gamestate,
							  input         [15:0] keycode,
							  input 			 [4:0]  thousand_digit, hundred_digit, ten_digit, single_digit, // score
							  input			 [19:0][9:0][3:0] PixelMapOut,
//							  output 						endgame,
                       output logic  [7:0]  Red, Green, Blue );
    
	 logic [4:0][22:0][3:0] HOLD;
	 logic [4:0][30:0][3:0] ANNWU;
	 logic [4:0][53:0][3:0] PATRICKSU;    
	 logic [10:0][24:0][3:0] GAMEOVER;
    logic [4:0][39:0][3:0] TETRIS_h;
	 logic [39:0][4:0][3:0] TETRIS;
	 logic [39:0][4:0][3:0] TETRIS2;
	 logic [3:0][15:0][3:0] I_block_h;
	 logic [15:0][3:0][3:0] I_block_v;
	 logic [7:0][7:0][3:0]  O_block;
	 logic [7:0][11:0][3:0] J_block_0;
	 logic [11:0][7:0][3:0] J_block_1;
	 logic [7:0][11:0][3:0] J_block_2;
	 logic [11:0][7:0][3:0] J_block_3;
	 logic [7:0][11:0][3:0] L_block_0;
	 logic [11:0][7:0][3:0] L_block_1;
	 logic [7:0][11:0][3:0] L_block_2;
	 logic [11:0][7:0][3:0] L_block_3;
	 logic [7:0][11:0][3:0] S_block_0;
	 logic [11:0][7:0][3:0] S_block_1;
	 logic [7:0][11:0][3:0] Z_block_0;
	 logic [11:0][7:0][3:0] Z_block_1;
	 logic [7:0][11:0][3:0] T_block_0;
	 logic [11:0][7:0][3:0] T_block_1;
	 logic [7:0][11:0][3:0] T_block_2;
	 logic [11:0][7:0][3:0] T_block_3;
	 logic [4:0][28:0][3:0] SCORE_Letters;
	 logic [4:0][4:0][3:0] zero;
	 logic [4:0][4:0][3:0] one;
	 logic [4:0][4:0][3:0] two;
	 logic [4:0][4:0][3:0] three;
	 logic [4:0][4:0][3:0] four;
	 logic [4:0][4:0][3:0] five;
	 logic [4:0][4:0][3:0] six;
	 logic [4:0][4:0][3:0] seven;
	 logic [4:0][4:0][3:0] eight;
	 logic [4:0][4:0][3:0] nine;	 	 
	 
	 logic [3:0] color;
	 logic [9:0] offset_x, offset_y, offset_tetris_x, offset_tetris_y,offset_tetris_x2, offset_tetris_y2, offset_pixmap_x, offset_pixmap_y, offset_tetris_yh,offset_tetris_xh;
	 logic [9:0] offset_SCORE_x, offset_SCORE_y, offset_thou_x, offset_thou_y, offset_hun_x, offset_hun_y, offset_ten_x, offset_ten_y, offset_single_x, offset_single_y, offset_x_go, offset_y_go;
	 logic [9:0] offset_wu_x, offset_wu_y, offset_su_x, offset_su_y, offset_holdshape_x, offset_holdshape_y, offset_hold_x, offset_hold_y;
	 logic [9:0] offset_shapenext_x, offset_shapenext_y, offset_shapenextnext_x, offset_shapenextnext_y;
	 logic [4:0] fe, te, be, goe, goey, tebigx, tebigy, sbe, ne; // Factor Expansion, up to 31
	 logic [3:0] pixelmapcolor;
	 
	 //Acting Block Parameters
	 logic shape_on; 
	
	 //GAMEOVER
	 logic [9:0] go_x_board = 250;
	 logic [9:0] go_y_board = 200;
	 logic [9:0] go_size_x = 150;
	 logic [9:0] go_size_y = 99;
	 
	
	 //Board
	 logic [3:0] board;
	 logic [9:0] shape_x_board = 250;
	 logic [9:0] shape_y_board = 100;
	 logic [9:0] shape_size_x_board = 160;
	 logic [9:0] shape_size_y_board = 320;
	 
	 /**** ScoreBoard ****/ 
	 //ScoreBoard
	 logic scoreboard;
	 logic [9:0] scoreboard_x = 475;
	 logic [9:0] scoreboard_size_x = 160;
	 logic [9:0] scoreboard_y = 50;
	 logic [9:0] scoreboard_size_y = 50;
	 // SCORE Letters:
	 logic [9:0] SCORE_Letters_x = 475;
	 logic [9:0] SCORE_Letters_size_x = 116;
	 logic [9:0] SCORE_Letters_y = 50;
	 logic [9:0] SCORE_Letters_size_y = 20;
	 // Score Numbers
	 // Thousand_digit: Bottom half, in quarters
	 logic [9:0] thousand_x = 492;
	 logic [9:0] thousand_size_x = 20;
	 logic [9:0] thousand_y = 75;
	 logic [9:0] thousand_size_y = 20;
	 // Hundred_digit
	 logic [9:0] hundred_x = 516;
	 logic [9:0] hundred_size_x = 20;
	 logic [9:0] hundred_y = 75;
	 logic [9:0] hundred_size_y = 20;
	 // Ten_digit
	 logic [9:0] ten_x = 540;
	 logic [9:0] ten_size_x = 20;
	 logic [9:0] ten_y = 75;
	 logic [9:0] ten_size_y = 20;
	 // Single_digit
	 logic [9:0] single_x = 564;
	 logic [9:0] single_size_x = 20;
	 logic [9:0] single_y = 75;
	 logic [9:0] single_size_y = 20;	 
	 
	 
	 //TETRIS String
	 logic [9:0] tetris_x = 420;
	 logic [9:0] tetris_y = 100;
	 logic [9:0] tetris_x2 = 200;
	 logic [9:0] tetris_y2 = 100;
	 logic [9:0] tetris_xh = 40;
	 logic [9:0] tetris_yh = 100;
	 logic [9:0] tetris_size_x = 40;
	 logic [9:0] tetris_size_y = 320;
	 logic [9:0] tetris_size_xh = 520;
	 logic [9:0] tetris_size_yh = 150;
	 Sprite_Table_FE ST(.*);
	
	 // Initialize Unit Blocks
	 logic [3:0][3:0][3:0] I_block_UB;
	 logic [3:0][3:0][3:0] O_block_UB;
	 logic [3:0][3:0][3:0] J_block_UB;
	 logic [3:0][3:0][3:0] T_block_UB;
	 logic [3:0][3:0][3:0] L_block_UB;
	 logic [3:0][3:0][3:0] S_block_UB;
	 logic [3:0][3:0][3:0] Z_block_UB; 
	 Sprite_Table_UNITBLOCK ub0 (.*);
	 
	 //Names
	 logic [9:0] wu_x = 220;
	 logic [9:0] wu_y = 380;
	 logic [9:0] wu_size_x = 186;
	 logic [9:0] wu_size_y = 30;
	 logic [9:0] su_x = 150;
	 logic [9:0] su_y = 330;
	 logic [9:0] su_size_x = 324;
	 logic [9:0] su_size_y = 30;
	 
	 
	 //Hold Shape
	 logic [9:0] holdshape_x = 75;
	 logic [9:0] holdshape_y = 110;
    logic [9:0] holdshape_size_x;
	 logic [9:0] holdshape_size_y;
	 
	 //HOLD Letters
	 logic [9:0] hold_x = 60;
	 logic [9:0] hold_y = 70;
	 logic [9:0] hold_size_x = 92;
	 logic [9:0] hold_size_y = 20;

	 //Shapenext
	 logic [9:0] shapenext_x = 510;
	 logic [9:0] shapenext_y = 130;
	 logic [9:0] shapenext_size_x;
	 logic [9:0] shapenext_size_y; 

	  //Shapenextnext
	 logic [9:0] shapenextnext_x = 510;
	 logic [9:0] shapenextnext_y = 180;
	 logic [9:0] shapenextnext_size_x;
	 logic [9:0] shapenextnext_size_y;
	 
	 Block_Param_Hold BPM (.shape_num(holdshape),
				              .shape_size_x(holdshape_size_x),
								  .shape_size_y(holdshape_size_y));
	 
	 Block_Param_Hold BPM2 (.shape_num(shapenext),
				              .shape_size_x(shapenext_size_x),
								  .shape_size_y(shapenext_size_y));
	 
	 Block_Param_Hold BPM3 (.shape_num(shapenextnext),
				              .shape_size_x(shapenextnext_size_x),
								  .shape_size_y(shapenextnext_size_y));
	 
    always_comb
    begin
	 shape_on <= 1'b0;
	 pixelmapcolor <= 4'b0;
	 color <= 4'b0;
	 board <= 1'b0;
	 scoreboard <= 1'b0;
	 offset_x <= DrawX - shape_x;
	 offset_y <= DrawY - shape_y;
	 offset_x_go <= DrawX - go_x_board;
	 offset_y_go <= DrawY - go_y_board;
	 offset_tetris_x <= DrawX - tetris_x;
	 offset_tetris_y <= DrawY - tetris_y;
	 offset_tetris_x2 <= DrawX - tetris_x2;
	 offset_tetris_y2 <= DrawY - tetris_y2;
	 offset_tetris_xh <= DrawX - tetris_xh;
	 offset_tetris_yh <= DrawY - tetris_yh;
	 offset_pixmap_x <= DrawX - shape_x_board;
	 offset_pixmap_y <= DrawY - shape_y_board;
	 offset_wu_x <= DrawX - wu_x;
	 offset_wu_y <= DrawY - wu_y;
	 offset_su_x <= DrawX - su_x;
	 offset_su_y <= DrawY - su_y;
	 offset_holdshape_x <= DrawX - holdshape_x;
	 offset_holdshape_y <= DrawY - holdshape_y;
	 offset_hold_x <= DrawX - hold_x;
	 offset_hold_y <= DrawY - hold_y;
	 offset_shapenext_x <= DrawX - shapenext_x;
	 offset_shapenext_y <= DrawY - shapenext_y;
	 offset_shapenextnext_x <= DrawX - shapenextnext_x;
	 offset_shapenextnext_y <= DrawY - shapenextnext_y;

	// Score
	 offset_SCORE_x <= DrawX - SCORE_Letters_x;
	 offset_SCORE_y <= DrawY - SCORE_Letters_y;
	 offset_thou_x <= DrawX - thousand_x;
	 offset_thou_y <= DrawY - thousand_y;
	 offset_hun_x <= DrawX - hundred_x;
	 offset_hun_y <= DrawY - hundred_y;
	 offset_ten_x <= DrawX - ten_x;
	 offset_ten_y <= DrawY - ten_y;
	 offset_single_x <= DrawX - single_x;
	 offset_single_y <= DrawY - single_y;

	 
	 sbe <= 5'd4;
	 fe <= 5'd4;
	 te <= 5'd8;
	 be <= 5'd16;
	 goe <= 5'd6;
	 goey <= 5'd9;
	 tebigx <= 5'd13;
	 tebigy <= 5'd30;
//	 endgame <= 1'b0;
	 ne <= 5'd6;
	 
//	 //MANUAL END GAME--------------------
//	 if (keycode == 16'h0038) // '?' pressed
//	 endgame <= 1'b1;
//	 //--------------------------------------
	 
	 
	 
	if (gamestate == 2'd1) //Idle State -- Beginning Screen
		begin
			board <= 4'd1;
		   shape_on <= 1'b1;	
			
			if ((DrawX >= tetris_xh) && (DrawX <= tetris_xh + tetris_size_xh) && (DrawY >= tetris_yh) && (DrawY < (tetris_yh + tetris_size_yh)))
				begin
				color <= TETRIS_h[(offset_tetris_yh - (offset_tetris_yh%tebigy))/tebigy][(offset_tetris_xh - (offset_tetris_xh%tebigx))/tebigx];
				end
			
			if ((DrawX >= wu_x) && (DrawX <= wu_x + wu_size_x) && (DrawY >= wu_y) && (DrawY < (wu_y + wu_size_y)))
				begin
				color <= ANNWU[(offset_wu_y - (offset_wu_y%ne))/ne][(offset_wu_x - (offset_wu_x%ne))/ne];
				end
			
			if ((DrawX >= su_x) && (DrawX <= su_x + su_size_x) && (DrawY >= su_y) && (DrawY < (su_y + su_size_y)))
				begin
				color <= PATRICKSU[(offset_su_y - (offset_su_y%ne))/ne][(offset_su_x - (offset_su_x%ne))/ne];
				end
		end
			 	 
	else // Game State --- Lets Play Some Tetris!
	begin

		//Shape Next Color Generation
		if ((DrawX >= shapenext_x) && (DrawX <= shapenext_x + shapenext_size_x) && (DrawY >= shapenext_y) && (DrawY < (shapenext_y + shapenext_size_y)))
		begin
			shape_on <= 1'b1;

			if ((shapenext == 3'd1)) // Horizontal I_Block
				color <=I_block_h[(offset_shapenext_y - (offset_shapenext_y%fe))/fe][(offset_shapenext_x - (offset_shapenext_x%fe))/fe]; 

			else if ((shapenext == 3'd2)) // O_block
				color <= O_block[(offset_shapenext_y - (offset_shapenext_y%fe))/fe][(offset_shapenext_x - (offset_shapenext_x%fe))/fe];
			
			else if ((shapenext == 3'd3))
					color <= J_block_0[(offset_shapenext_y - (offset_shapenext_y%fe))/fe][(offset_shapenext_x - (offset_shapenext_x%fe))/fe];
			
			else if ((shapenext == 3'd4))
				color <= L_block_0[(offset_shapenext_y - (offset_shapenext_y%fe))/fe][(offset_shapenext_x - (offset_shapenext_x%fe))/fe];
					
			else if ((shapenext == 3'd5))
				color <= S_block_0[(offset_shapenext_y - (offset_shapenext_y%fe))/fe][(offset_shapenext_x - (offset_shapenext_x%fe))/fe];
				
			else if ((shapenext == 3'd6))
				color <= T_block_0[(offset_shapenext_y - (offset_shapenext_y%fe))/fe][(offset_shapenext_x - (offset_shapenext_x%fe))/fe];
		
			else if ((shapenext == 3'd7))
				color <= Z_block_0[(offset_shapenext_y - (offset_shapenext_y%fe))/fe][(offset_shapenext_x - (offset_shapenext_x%fe))/fe];
		end

		//Shape next next Color Generation
		if ((DrawX >= shapenextnext_x) && (DrawX <= shapenextnext_x + shapenextnext_size_x) && (DrawY >= shapenextnext_y) && (DrawY < (shapenextnext_y + shapenextnext_size_y)))
		begin
			shape_on <= 1'b1;

			if ((shapenextnext == 3'd1)) // Horizontal I_Block
				color <=I_block_h[(offset_shapenextnext_y - (offset_shapenextnext_y%fe))/fe][(offset_shapenextnext_x - (offset_shapenextnext_x%fe))/fe]; 

			else if ((shapenextnext == 3'd2)) // O_block
				color <= O_block[(offset_shapenextnext_y - (offset_shapenextnext_y%fe))/fe][(offset_shapenextnext_x - (offset_shapenextnext_x%fe))/fe];
			
			else if ((shapenextnext == 3'd3))
					color <= J_block_0[(offset_shapenextnext_y - (offset_shapenextnext_y%fe))/fe][(offset_shapenextnext_x - (offset_shapenextnext_x%fe))/fe];
			
			else if ((shapenextnext == 3'd4))
				color <= L_block_0[(offset_shapenextnext_y - (offset_shapenextnext_y%fe))/fe][(offset_shapenextnext_x - (offset_shapenextnext_x%fe))/fe];
					
			else if ((shapenextnext == 3'd5))
				color <= S_block_0[(offset_shapenextnext_y - (offset_shapenextnext_y%fe))/fe][(offset_shapenextnext_x - (offset_shapenextnext_x%fe))/fe];
				
			else if ((shapenextnext == 3'd6))
				color <= T_block_0[(offset_shapenextnext_y - (offset_shapenextnext_y%fe))/fe][(offset_shapenextnext_x - (offset_shapenextnext_x%fe))/fe];
		
			else if ((shapenextnext == 3'd7))
				color <= Z_block_0[(offset_shapenextnext_y - (offset_shapenextnext_y%fe))/fe][(offset_shapenextnext_x - (offset_shapenextnext_x%fe))/fe];
		end
		
		//Hold Shape Letter Generation
		if ((DrawX >= hold_x) && (DrawX <= hold_x + hold_size_x) && (DrawY >= hold_y) && (DrawY < (hold_y + hold_size_y)))
			begin
				shape_on <= 1'b1;
				color <= HOLD [(offset_hold_y - (offset_hold_y%fe))/fe][(offset_hold_x - (offset_hold_x%fe))/fe];
			end
	
	
		//Hold Shape Color Generation
		if ((DrawX >= holdshape_x) && (DrawX <= holdshape_x + holdshape_size_x) && (DrawY >= holdshape_y) && (DrawY < (holdshape_y + holdshape_size_y)))
		begin
			shape_on <= 1'b1;

			if ((holdshape == 3'd1)) // Horizontal I_Block
				color <=I_block_h[(offset_holdshape_y - (offset_holdshape_y%fe))/fe][(offset_holdshape_x - (offset_holdshape_x%fe))/fe]; 

			else if ((holdshape == 3'd2)) // O_block
				color <= O_block[(offset_holdshape_y - (offset_holdshape_y%fe))/fe][(offset_holdshape_x - (offset_holdshape_x%fe))/fe];
			
			else if ((holdshape == 3'd3))
					color <= J_block_0[(offset_holdshape_y - (offset_holdshape_y%fe))/fe][(offset_holdshape_x - (offset_holdshape_x%fe))/fe];
			
			else if ((holdshape == 3'd4))
				color <= L_block_0[(offset_holdshape_y - (offset_holdshape_y%fe))/fe][(offset_holdshape_x - (offset_holdshape_x%fe))/fe];
					
			else if ((holdshape == 3'd5))
				color <= S_block_0[(offset_holdshape_y - (offset_holdshape_y%fe))/fe][(offset_holdshape_x - (offset_holdshape_x%fe))/fe];
				
			else if ((holdshape == 3'd6))
				color <= T_block_0[(offset_holdshape_y - (offset_holdshape_y%fe))/fe][(offset_holdshape_x - (offset_holdshape_x%fe))/fe];
		
			else if ((holdshape == 3'd7))
				color <= Z_block_0[(offset_holdshape_y - (offset_holdshape_y%fe))/fe][(offset_holdshape_x - (offset_holdshape_x%fe))/fe];
		end
	
		//TETRIS STRING RIGHT SIDE
		if ((DrawX >= tetris_x) && (DrawX <= tetris_x + tetris_size_x) && (DrawY >= tetris_y) && (DrawY < (tetris_y + tetris_size_y)))
			begin
			shape_on <= 1'b1;
			color <= TETRIS[(offset_tetris_y - (offset_tetris_y%te))/te][(offset_tetris_x - (offset_tetris_x%te))/te];
			end
			
		//TETRIS STRING LEFT SIDE
		if ((DrawX >= tetris_x2) && (DrawX <= tetris_x2 + tetris_size_x) && (DrawY >= tetris_y2) && (DrawY < (tetris_y2 + tetris_size_y)))
			begin
			shape_on <= 1'b1;
			color <= TETRIS2[(offset_tetris_y2 - (offset_tetris_y2%te))/te][(offset_tetris_x2 - (offset_tetris_x2%te))/te];
			end
			
		//ScoreBoard Drawing
		if ((DrawX >= scoreboard_x) && (DrawX <= (scoreboard_x + scoreboard_size_x)) && (DrawY >= scoreboard_y) && (DrawY < (scoreboard_y + scoreboard_size_y)))
			begin
			scoreboard <= 1'b1;
				// SCORE Letters
				if ((DrawX >= SCORE_Letters_x) && (DrawX <= SCORE_Letters_x + SCORE_Letters_size_x) && (DrawY >= SCORE_Letters_y) && (DrawY < (SCORE_Letters_y + SCORE_Letters_size_y)))
				begin
					color <= SCORE_Letters[(offset_SCORE_y - (offset_SCORE_y%fe))/fe][(offset_SCORE_x - (offset_SCORE_x%fe))/fe];
				end
				// Thousand_digit
				else if ((DrawX >= thousand_x) && (DrawX <= (thousand_x + thousand_size_x)) && (DrawY >= thousand_y) && (DrawY < (thousand_y + thousand_size_y)))
				begin
					unique case(thousand_digit)
						5'd0: color <= zero[(offset_thou_y - (offset_thou_y%sbe))/sbe][(offset_thou_x - (offset_thou_x%sbe))/sbe]; 
						5'd1: color <= one[(offset_thou_y - (offset_thou_y%sbe))/sbe][(offset_thou_x - (offset_thou_x%sbe))/sbe]; 			
						5'd2: color <= two[(offset_thou_y - (offset_thou_y%sbe))/sbe][(offset_thou_x - (offset_thou_x%sbe))/sbe]; 
						5'd3: color <= three[(offset_thou_y - (offset_thou_y%sbe))/sbe][(offset_thou_x - (offset_thou_x%sbe))/sbe]; 
						5'd4: color <= four[(offset_thou_y - (offset_thou_y%sbe))/sbe][(offset_thou_x - (offset_thou_x%sbe))/sbe]; 
						5'd5: color <= five[(offset_thou_y - (offset_thou_y%sbe))/sbe][(offset_thou_x - (offset_thou_x%sbe))/sbe]; 
						5'd6: color <= six[(offset_thou_y - (offset_thou_y%sbe))/sbe][(offset_thou_x - (offset_thou_x%sbe))/sbe]; 
						5'd7: color <= seven[(offset_thou_y - (offset_thou_y%sbe))/sbe][(offset_thou_x - (offset_thou_x%sbe))/sbe]; 
						5'd8: color <= eight[(offset_thou_y - (offset_thou_y%sbe))/sbe][(offset_thou_x - (offset_thou_x%sbe))/sbe]; 
						5'd9: color <= nine[(offset_thou_y - (offset_thou_y%sbe))/sbe][(offset_thou_x - (offset_thou_x%sbe))/sbe];
					default : ;	
					endcase
				end
				// Hundred_digit
				else if ((DrawX >= hundred_x) && (DrawX <= (hundred_x + hundred_size_x)) && (DrawY >= hundred_y) && (DrawY < (hundred_y + hundred_size_y)))
				begin
					unique case(hundred_digit)
						5'd0: color <= zero[(offset_hun_y - (offset_hun_y%sbe))/sbe][(offset_hun_x - (offset_hun_x%sbe))/sbe]; 
						5'd1: color <= one[(offset_hun_y - (offset_hun_y%sbe))/sbe][(offset_hun_x - (offset_hun_x%sbe))/sbe]; 		
						5'd2: color <= two[(offset_hun_y - (offset_hun_y%sbe))/sbe][(offset_hun_x - (offset_hun_x%sbe))/sbe]; 
						5'd3: color <= three[(offset_hun_y - (offset_hun_y%sbe))/sbe][(offset_hun_x - (offset_hun_x%sbe))/sbe]; 
						5'd4: color <= four[(offset_hun_y - (offset_hun_y%sbe))/sbe][(offset_hun_x - (offset_hun_x%sbe))/sbe]; 
						5'd5: color <= five[(offset_hun_y - (offset_hun_y%sbe))/sbe][(offset_hun_x - (offset_hun_x%sbe))/sbe]; 
						5'd6: color <= six[(offset_hun_y - (offset_hun_y%sbe))/sbe][(offset_hun_x - (offset_hun_x%sbe))/sbe]; 
						5'd7: color <= seven[(offset_hun_y - (offset_hun_y%sbe))/sbe][(offset_hun_x - (offset_hun_x%sbe))/sbe]; 
						5'd8: color <= eight[(offset_hun_y - (offset_hun_y%sbe))/sbe][(offset_hun_x - (offset_hun_x%sbe))/sbe]; 
						5'd9: color <= nine[(offset_hun_y - (offset_hun_y%sbe))/sbe][(offset_hun_x - (offset_hun_x%sbe))/sbe]; 
					default : ;	
					endcase
				end	
				// Ten_digit
				else if ((DrawX >= ten_x) && (DrawX <= (ten_x + ten_size_x)) && (DrawY >= ten_y) && (DrawY < (ten_y + ten_size_y)))
				begin
					unique case(ten_digit)
						5'd0: color <= zero[(offset_ten_y - (offset_ten_y%sbe))/sbe][(offset_ten_x - (offset_ten_x%sbe))/sbe]; 
						5'd1: color <= one[(offset_ten_y - (offset_ten_y%sbe))/sbe][(offset_ten_x - (offset_ten_x%sbe))/sbe]; 		
						5'd2: color <= two[(offset_ten_y - (offset_ten_y%sbe))/sbe][(offset_ten_x - (offset_ten_x%sbe))/sbe]; 
						5'd3: color <= three[(offset_ten_y - (offset_ten_y%sbe))/sbe][(offset_ten_x - (offset_ten_x%sbe))/sbe]; 
						5'd4: color <= four[(offset_ten_y - (offset_ten_y%sbe))/sbe][(offset_ten_x - (offset_ten_x%sbe))/sbe]; 
						5'd5: color <= five[(offset_ten_y - (offset_ten_y%sbe))/sbe][(offset_ten_x - (offset_ten_x%sbe))/sbe]; 
						5'd6: color <= six[(offset_ten_y - (offset_ten_y%sbe))/sbe][(offset_ten_x - (offset_ten_x%sbe))/sbe]; 
						5'd7: color <= seven[(offset_ten_y - (offset_ten_y%sbe))/sbe][(offset_ten_x - (offset_ten_x%sbe))/sbe]; 
						5'd8: color <= eight[(offset_ten_y - (offset_ten_y%sbe))/sbe][(offset_ten_x - (offset_ten_x%sbe))/sbe]; 
						5'd9: color <= nine[(offset_ten_y - (offset_ten_y%sbe))/sbe][(offset_ten_x - (offset_ten_x%sbe))/sbe]; 
					default : ;	
					endcase
				end	
				// Single_digit
				else if ((DrawX >= single_x) && (DrawX <= (single_x + single_size_x)) && (DrawY >= single_y) && (DrawY < (single_y + single_size_y)))
				begin
					unique case(single_digit)
						5'd0: color <= zero[(offset_single_y - (offset_single_y%sbe))/sbe][(offset_single_x - (offset_single_x%sbe))/sbe]; 
						5'd1: color <= one[(offset_single_y - (offset_single_y%sbe))/sbe][(offset_single_x - (offset_single_x%sbe))/sbe]; 					
						5'd2: color <= two[(offset_single_y - (offset_single_y%sbe))/sbe][(offset_single_x - (offset_single_x%sbe))/sbe]; 
						5'd3: color <= three[(offset_single_y - (offset_single_y%sbe))/sbe][(offset_single_x - (offset_single_x%sbe))/sbe]; 
						5'd4: color <= four[(offset_single_y - (offset_single_y%sbe))/sbe][(offset_single_x - (offset_single_x%sbe))/sbe]; 
						5'd5: color <= five[(offset_single_y - (offset_single_y%sbe))/sbe][(offset_single_x - (offset_single_x%sbe))/sbe]; 
						5'd6: color <= six[(offset_single_y - (offset_single_y%sbe))/sbe][(offset_single_x - (offset_single_x%sbe))/sbe]; 
						5'd7: color <= seven[(offset_single_y - (offset_single_y%sbe))/sbe][(offset_single_x - (offset_single_x%sbe))/sbe]; 
						5'd8: color <= eight[(offset_single_y - (offset_single_y%sbe))/sbe][(offset_single_x - (offset_single_x%sbe))/sbe]; 
						5'd9: color <= nine[(offset_single_y - (offset_single_y%sbe))/sbe][(offset_single_x - (offset_single_x%sbe))/sbe]; 
					default : ;	
					endcase
				end		
			end				
			
	 
	 	//Board Drawing
		if ((DrawX >= shape_x_board) && (DrawX <= shape_x_board + shape_size_x_board) && (DrawY >= shape_y_board) && (DrawY < (shape_y_board + shape_size_y_board)))
			begin
			shape_on <= 1'b1;
			board <= 4'd2;
			end
	 
		//Block Expansion Drawing
		if((DrawX >= shape_x) && (DrawX < (shape_x + shape_size_x)) && (DrawY >= shape_y) && (DrawY < (shape_y + shape_size_y)))
			begin
			shape_on <= 1'b1;
			if ( (shape_num == 3'd1) && ((shape_rot == 2'd0) || (shape_rot == 2'd2)) ) // Horizontal I_Block
				
				color <=I_block_h[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe]; 
				
			else if ( (shape_num == 3'd1) && ((shape_rot == 2'd1) || (shape_rot == 2'd3)) ) // Vertical I_block
				
				color <=I_block_v[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
				
			else if ( (shape_num == 3'd2) ) // O_block
				
				color <= O_block[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
			
			else if ( (shape_num == 3'd3) )
				begin
				unique case (shape_rot)
					2'd0:
						color <= J_block_0[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd1:
						color <= J_block_1[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd2:
						color <= J_block_2[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd3:
						color <= J_block_3[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
				default: ;
				endcase
				end
			
			else if ( (shape_num == 3'd4) )
				begin
				unique case (shape_rot)
					2'd0:
						color <= L_block_0[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd1:
						color <= L_block_1[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd2:
						color <= L_block_2[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd3:
						color <= L_block_3[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
				default: ;
				endcase
				end
			
			else if ( (shape_num == 3'd5) )
				begin
				unique case (shape_rot)
					2'd0:
						color <= S_block_0[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd1:
						color <= S_block_1[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd2:
						color <= S_block_0[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd3:
						color <= S_block_1[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
				default: ;
				endcase
				end

			else if ( (shape_num == 3'd6) )
				begin
				unique case (shape_rot)
					2'd0:
						color <= T_block_0[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd1:
						color <= T_block_1[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd2:
						color <= T_block_2[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd3:
						color <= T_block_3[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
				default: ;
				endcase
				end
			else if ( (shape_num == 3'd7) )
				begin
				unique case (shape_rot)
					2'd0:
						color <= Z_block_0[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd1:
						color <= Z_block_1[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd2:
						color <= Z_block_0[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
					2'd3:
						color <= Z_block_1[(offset_y - (offset_y%fe))/fe][(offset_x - (offset_x%fe))/fe];
				default: ;
				endcase
				end
		end
		
		// Pixel Map Expansion Drawing
		if((DrawX >= shape_x_board) && (DrawX < (shape_x_board + shape_size_x_board)) && (DrawY >= shape_y_board) && (DrawY < (shape_y_board + shape_size_y_board)))
			begin
				shape_on <= 1'b1;
				pixelmapcolor <= PixelMapOut[(offset_pixmap_y - (offset_pixmap_y%be))/be][(offset_pixmap_x - (offset_pixmap_x%be))/be]; 
				// Obtain correct sprite unit block
				case (pixelmapcolor)
					4'd1 : color <= I_block_UB[(offset_pixmap_y - (offset_pixmap_y%fe))/fe][(offset_pixmap_x - (offset_pixmap_x%fe))/fe]; 
					4'd2 : color <= O_block_UB[(offset_pixmap_y - (offset_pixmap_y%fe))/fe][(offset_pixmap_x - (offset_pixmap_x%fe))/fe];
					4'd3 : color <= J_block_UB[(offset_pixmap_y - (offset_pixmap_y%fe))/fe][(offset_pixmap_x - (offset_pixmap_x%fe))/fe];
					4'd4 : color <= L_block_UB[(offset_pixmap_y - (offset_pixmap_y%fe))/fe][(offset_pixmap_x - (offset_pixmap_x%fe))/fe];
					4'd5 : color <= S_block_UB[(offset_pixmap_y - (offset_pixmap_y%fe))/fe][(offset_pixmap_x - (offset_pixmap_x%fe))/fe];
					4'd6 : color <= Z_block_UB[(offset_pixmap_y - (offset_pixmap_y%fe))/fe][(offset_pixmap_x - (offset_pixmap_x%fe))/fe];
					4'd8 : color <= T_block_UB[(offset_pixmap_y - (offset_pixmap_y%fe))/fe][(offset_pixmap_x - (offset_pixmap_x%fe))/fe];
				default : ;
				endcase
			end		
		
		if (gamestate == 2'd3) // End Game State
			begin
			//GAME OVER Drawing
			if ((DrawX >= go_x_board) && (DrawX <= go_x_board + go_size_x) && (DrawY >= go_y_board) && (DrawY < (go_y_board + go_size_y)))
				begin
				shape_on <= 1'b1;
				color <= GAMEOVER[(offset_y_go - (offset_y_go%goey))/goey][(offset_x_go - (offset_x_go%goe))/goe]; 
				end
			end
		
		
	end
end
    always_comb
    begin
	
		//Background gets last priority
	  Red <= 8'h00;
	  Green <= 8'h47;
	  Blue <= 8'hab  - DrawX[9:3] - DrawX[9:3];
	  
	  //Board gets second to last priority
		
		if (board == 4'd2) //GameState
			begin
				//Gray Board
				Red <= 8'h69 - DrawX[9:3];
				Green <= 8'h69 - DrawX[9:3];
				Blue <= 8'h69 - DrawX[9:3];
			end
		else if (board == 4'd1) // Idle State
			begin
				//Royal Blue?
				Red <= 8'h09 + DrawX[9:3];
				Green <= 8'h04 + DrawX[9:3];
				Blue <= 8'h6a + DrawX[9:3];
			end
		else if (board == 4'd3) // End State
			begin
				//
				Red <= 8'h58 + DrawX[9:3];
				Green <= 8'h62 + DrawX[9:3];
				Blue <= 8'h6f + DrawX[9:3];
			end		    	  

		//Acting block gets final decision
		if (shape_on||scoreboard)
			begin
				unique case (color)
					4'd1: // CYAN
						begin
							Red <= 8'h00;
							Green <= 8'hff;
							Blue <= 8'hff;
						end
					4'd2: //YELLOW
						begin
							Red <= 8'hff;
							Green <= 8'hff;
							Blue <= 8'h00;
						end
					4'd3: //BLUE
						begin
							Red <= 8'h00;
							Green <= 8'h00;
							Blue <= 8'hff;
						end
					4'd4: //ORANGE
						begin
							Red <= 8'hff;
							Green <= 8'ha5;
							Blue <= 8'h00;
						end

					4'd5: //GREEN
						begin
							Red <= 8'h00;
							Green <= 8'hff;
							Blue <= 8'h00;
						end
					4'd6: //RED
						begin
							Red <= 8'hff;
							Green <= 8'h00;
							Blue <= 8'h00;
						end
					4'd7: //GRAY
						begin
							Red <= 8'hff;
							Green <= 8'hff;
							Blue <= 8'hff;
						end
					4'd8: //PURPLE
						begin
							Red <= 8'h8A;
							Green <= 8'h2B;
							Blue <= 8'hE2;
						end
					4'd9: //WHITE
						begin
							Red <= 8'hff;
							Green <= 8'hff;
							Blue <= 8'hff;
						end
					default : ;
				endcase
				

		end
    end
endmodule






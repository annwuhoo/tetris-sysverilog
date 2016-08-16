module Block_Param_Hold(
						 input [2:0] shape_num,
						 output logic [9:0] shape_size_x, 
					    output logic [9:0] shape_size_y);
						 
			
		always_comb
		begin
			shape_size_x = 10'b0;
			shape_size_y = 10'b0;
			
			if ( (shape_num == 3'd1)) // Horizontal I_block
				begin
				shape_size_x = 10'd64;
				shape_size_y = 10'd16;
				end
			else if ( (shape_num == 3'd2) ) // O_block
				begin
				shape_size_x = 10'd32;
				shape_size_y = 10'd32;
				end
			
			else if ( (shape_num == 3'd3) )
				begin
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
				end
				
			else if ( (shape_num == 3'd4) )
				begin
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
				end

			else if ( (shape_num == 3'd5) )
				begin
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
				end

			else if ( (shape_num == 3'd6) )
				begin
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
				end
				
			else if ( (shape_num == 3'd7) )
				begin
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
				end
	
		end
endmodule

			


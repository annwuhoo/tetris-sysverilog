// Outputs Size Parameters given a certain shape_num and shape_rot

module Block_Param(
						 input [2:0] shape_num,
					    input [1:0] shape_rot,
						 output logic [9:0] shape_size_x, 
					    output logic [9:0] shape_size_y);
						 
			
		always_comb
		begin
			shape_size_x = 10'b0;
			shape_size_y = 10'b0;
			
			if ( (shape_num == 3'd1) && ((shape_rot == 2'd0) || (shape_rot == 2'd2)) ) // Horizontal I_block
				begin
				shape_size_x = 10'd64;
				shape_size_y = 10'd16;
				end
			else if ( (shape_num == 3'd1) && ((shape_rot == 2'd1) || (shape_rot == 2'd3)) ) // Vertical I_block
				begin
				shape_size_x = 10'd16;
				shape_size_y = 10'd64;
				end
			else if ( (shape_num == 3'd2) ) // O_block
				begin
				shape_size_x = 10'd32;
				shape_size_y = 10'd32;
				end
			
			else if ( (shape_num == 3'd3) )
				begin
				unique case (shape_rot)
					2'd0:
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
					2'd1:
						begin
						shape_size_x = 10'd32;
						shape_size_y = 10'd48;
						end
					2'd2:
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
					2'd3:
						begin
						shape_size_x = 10'd32;
						shape_size_y = 10'd48;
						end
				default: ;
				endcase
				end

			else if ( (shape_num == 3'd4) )
				begin
				unique case (shape_rot)
					2'd0:
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
					2'd1:
						begin
						shape_size_x = 10'd32;
						shape_size_y = 10'd48;
						end
					2'd2:
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
					2'd3:
						begin
						shape_size_x = 10'd32;
						shape_size_y = 10'd48;
						end
				default: ;
				endcase
				end
			
			else if ( (shape_num == 3'd5) )
				begin
				unique case (shape_rot)
					2'd0:
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
					2'd1:
						begin
						shape_size_x = 10'd32;
						shape_size_y = 10'd48;
						end
					2'd2:
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
					2'd3:
						begin
						shape_size_x = 10'd32;
						shape_size_y = 10'd48;
						end
				default: ;
				endcase
				end
			
			else if ( (shape_num == 3'd6) )
				begin
				unique case (shape_rot)
					2'd0:
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
					2'd1:
						begin
						shape_size_x = 10'd32;
						shape_size_y = 10'd48;
						end
					2'd2:
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
					2'd3:
						begin
						shape_size_x = 10'd32;
						shape_size_y = 10'd48;
						end
				default: ;
				endcase
				end
			
			else if ( (shape_num == 3'd7) )
				begin
				unique case (shape_rot)
					2'd0:
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
					2'd1:
						begin
						shape_size_x = 10'd32;
						shape_size_y = 10'd48;
						end
					2'd2:
						begin
						shape_size_x = 10'd48;
						shape_size_y = 10'd32;
						end
					2'd3:
						begin
						shape_size_x = 10'd32;
						shape_size_y = 10'd48;
						end
				default: ;
				endcase
				end
		end
endmodule

			


module rand_table( input Clk,
				   input Reset,
				   input ResetShape,
				   input touchdown,
					input endgame,
				   input [15:0] keycode,
				   output [2:0] shape_num,
				   output [2:0] shapenext,
				   output [2:0] shapenextnext,
				   output [2:0] holdshape
				   );


logic [99:0][3:0] pieces;
logic [9:0] temp;
logic [9:0] pointer = 10'd0;
logic [9:0] hold = 10'd100;
logic [15:0] keyforce = 16'h0013; // if "P" is pressed
logic act_once, activate;
logic [9:0] plimit = 10'd101;
logic [9:0] counter;
logic [9:0] snext = 10'd1;
logic [9:0] ssnext = 10'd2;
logic [9:0] now = 10'd0;

assign shape_num = pieces[pointer];
assign holdshape = pieces[hold];
assign shapenext = pieces[snext];
assign shapenextnext = pieces[ssnext];


always_comb
	begin
	pieces <= '{0,7,7,1,5,4,7,5,1,1,3,3,6,1,3,5,6,3,4,4,4,3,3,5,5,1,3,4,5,1,6,6,7,5,4,2,3,1,5,5,6,2,6,5,6,5,6,3,2,6,1,3,7,4,7,5,4,6,5,7,4,3,1,6,6,7,2,1,7,7,6,3,4,3,1,7,3,1,3,5,1,2,3,3,4,7,6,1,6,5,7,4,2,2,4,1,2,3,1,7};          
	end
	
always_ff @ (posedge Clk or posedge Reset)
	begin
		if (Reset)
			begin
				hold = 10'd100;
				act_once = 1'd0;
				counter = 10'd0;
				activate = 1'd0;
			end


			
		else if (endgame)
			begin
				hold = 10'd100;
				act_once = 1'd0;
				counter = 10'd0;
				activate = 1'd0;
			end

		
		else if (activate)
			begin
				if (counter == 10'd20)
					begin

						//Now is the index of the table
						//Pointer is the current acting block
						//snext is the block on deck
						//ssnext is the block in the hole

						activate = 1'd0;
						counter = 10'd0;
						now = now + 10'd1;
						pointer = now + 10'd0;
						snext = now + 10'd1;
						ssnext = now + 10'd2;

						if (now >= plimit)
							begin
								now = now - plimit;
							end
						if (snext >= plimit)
							begin
								snext = snext - plimit;
							end
						if (ssnext >= plimit)
							begin
								ssnext = ssnext - plimit;
							end
					end
					
				else
					begin
						counter = counter + 10'd1;
					end
			end
		
		else if (touchdown||ResetShape)
			begin
				activate = 1'd1;
			end


			//Comment this out for shape swap. Make sure the random function generator actually works first
		 else if ((keycode == keyforce)&&(~act_once))
			begin
				act_once = 1'd1;
				if (hold == 10'd100) // Nothing In there Yet
					begin
						hold = pointer;
						now = now + 1;
						pointer = now;
						snext = now + 10'd1;
						ssnext = now + 10'd2;

						if (now >= plimit)
							begin
								now = now - plimit;
							end
						if (snext >= plimit)
							begin
								snext = snext - plimit;
							end
						if (ssnext >= plimit)
							begin
								ssnext = ssnext - plimit;
							end
					end
				else
					begin
						temp = hold;
						hold = pointer;
						pointer = temp;
					end
			end

		else if ((act_once)&&(keycode == 16'h0000))
			begin
				act_once  = 1'd0;
			end
	end
	
endmodule 
//Sprite Table for Expansion by Factor
//Single block is a 4x4 block for Acting Blocks
//Single block in TETRIS font is 8x8 block
//These factors can be changed in the ColorMapper under varaibles fe and te respectively
module Sprite_Table_UNITBLOCK (
					// variable [#Rows][#Cols][EntryDepth]
					 output logic [3:0][3:0][3:0] I_block_UB,
					 output logic [3:0][3:0][3:0] O_block_UB,
					 output logic [3:0][3:0][3:0] J_block_UB,
					 output logic [3:0][3:0][3:0] T_block_UB,
					 output logic [3:0][3:0][3:0] L_block_UB,
					 output logic [3:0][3:0][3:0] S_block_UB,
					 output logic [3:0][3:0][3:0] Z_block_UB);
	
	//Single Standard Block is 16x16
	always_comb
	begin
	
	I_block_UB <= '{
	
		'{7,7,7,7},
		'{7,1,1,7},
		'{7,1,1,7},
		'{7,7,7,7}
	};
	
	O_block_UB <= '{
	
		'{7,7,7,7},
		'{7,2,2,7},
		'{7,2,2,7},
		'{7,7,7,7}
	};
	
	J_block_UB <= '{
	
		'{7,7,7,7},
		'{7,3,3,7},
		'{7,3,3,7},
		'{7,7,7,7}
	};
	
	L_block_UB <= ' {
	
	'{7,7,7,7},
	'{7,4,4,7},
	'{7,4,4,7},
	'{7,7,7,7}
	};

	S_block_UB <= '{
	
	'{7,7,7,7},
	'{7,5,5,7},
	'{7,5,5,7},
	'{7,7,7,7}
	};
	
	Z_block_UB <= '{
	
	'{7,7,7,7},
	'{7,6,6,7},
	'{7,6,6,7},
	'{7,7,7,7}
	};
	
	T_block_UB <= '{
	
	'{7,7,7,7},
	'{7,8,8,7},
	'{7,8,8,7},
	'{7,7,7,7}
	};
	end
endmodule 
	


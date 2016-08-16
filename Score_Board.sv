// Separate current score into individual digits
module Score_Board (input Reset,
						 input reset_game,
						 input[13:0] Score,
						 output [4:0] thousand_digit,
						 output [4:0] hundred_digit,
						 output [4:0] ten_digit,
						 output [4:0] single_digit);
						 
logic [4:0] ten = 10;
logic [6:0] hundred = 100;
logic [9:0] thousand = 1000;
						 
always_comb
begin
	thousand_digit = 5'b0;
	hundred_digit = 5'b0;
	ten_digit = 5'b0;
	single_digit = 5'b0;
	
	if (Reset)
		begin
		thousand_digit <= 5'b0;
		hundred_digit <= 5'b0;
		ten_digit <= 5'b0;
		single_digit <= 5'b0;
		end

	else
		begin
		single_digit <= Score%ten;
		ten_digit <= (Score/ten)%ten;
		hundred_digit <= (Score/hundred)%ten;
		thousand_digit <= (Score/thousand)%thousand;
		end
						 
end						 
endmodule

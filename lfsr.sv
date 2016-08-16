//-----------------------------------------------------
// Design Name : lfsr
// File Name   : lfsr.v
// Function    : Linear feedback shift register
// Coder       : Deepak Kumar Tala
//-----------------------------------------------------
module lfsr    (
output [7:0] Randout             ,  // Output of the counter
input Enable          ,  // Enable  for counter
input Clk             ,  // clock input
input Reset              // reset input
);

////----------Output Ports--------------
//output [7:0] out;
////------------Input Ports--------------
//input [7:0] data;
//input enable, clk, reset;
//------------Internal Variables--------
logic [7:0] out;
wire        linear_feedback, linear_feedback2, linear_feedback3;

//-------------Code Starts Here-------

assign Randout = out;
assign linear_feedback = ~(out[5] ^ out[4]);
assign linear_feedback2 = ~(out[2] ^ out[3]);
assign linear_feedback3 = ~(out[6] ^ out[7]);

always @(posedge Clk or posedge Reset)
if (Reset) begin // active high reset
  out <= 8'b1 ;
end 
else if (Enable) 
begin
  out <= {linear_feedback2,out[5],
          out[4],out[3],
          linear_feedback3,out[1],
          out[0], linear_feedback};
end 

endmodule // End Of Module counter
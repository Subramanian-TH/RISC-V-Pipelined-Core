module Mux(
input [31:0] a, b,
input s,
output [31:0] q
 );
 
   assign q = (s == 1'b0) ? a : b;
    
endmodule

module Mux_4_to_1(
input [31:0] a, b, c, d, 
input [1:0] s,
output [31:0] r
    );
    
    assign r = (s == 2'b00) ? a :
               (s == 2'b01) ? b :
               (s == 2'b10) ? c : d;
    
endmodule

module Mux_3_to_1(
input [31:0] a, b, c,
input [1:0] sel,
output [31:0] d
    );
    
    assign d = (sel == 2'b00) ? a :
               (sel == 2'b01) ? b :
               (sel == 2'b10) ? c : 32'h00000000;
endmodule

module Hazard_Unit(
input rst, RegWrite_M, RegWrite_W,
input [4:0] Rd_M, Rd_W,
input [4:0] RS1_E, RS2_E,
output [1:0] ForwardAE, ForwardBE
    );
    
    assign ForwardAE = (rst == 1'b1) ? 2'b00 :
                       ((RegWrite_M == 1'b1) & (Rd_M != 5'h00) & (Rd_M == RS1_E)) ? 2'b10 : 
                       ((RegWrite_W == 1'b1) & (Rd_W != 5'h00) & (Rd_W == RS1_E)) ? 2'b01 : 2'b00;
                       
    assign ForwardBE = (rst == 1'b1) ? 2'b00 :                    
                       ((RegWrite_M == 1'b1) & (Rd_M != 5'h00) & (Rd_M == RS2_E)) ? 2'b10 :          
                       ((RegWrite_W == 1'b1) & (Rd_W != 5'h00) & (Rd_W == RS2_E)) ? 2'b01 : 2'b00;             

endmodule

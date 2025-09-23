module Hazard_Unit(
input rst, RegWrite_M, RegWrite_W, PCSrc_E,
input [4:0] Rd_M, Rd_W, Rd_E,
input [4:0] RS1_E, RS2_E,
input [4:0] RS1_D, RS2_D,
input [1:0] ResultSrc_E,
output [1:0] ForwardAE, ForwardBE,
output StallF, StallD, FlushE,
output FlushD
    );
    
    wire lwStall;
    //Forwarding logic
    
    assign ForwardAE = (rst == 1'b1) ? 2'b00 :
                       ((RegWrite_M == 1'b1) & (Rd_M != 5'h00) & (Rd_M == RS1_E)) ? 2'b10 : 
                       ((RegWrite_W == 1'b1) & (Rd_W != 5'h00) & (Rd_W == RS1_E)) ? 2'b01 : 2'b00;
                       
    assign ForwardBE = (rst == 1'b1) ? 2'b00 :                    
                       ((RegWrite_M == 1'b1) & (Rd_M != 5'h00) & (Rd_M == RS2_E)) ? 2'b10 :          
                       ((RegWrite_W == 1'b1) & (Rd_W != 5'h00) & (Rd_W == RS2_E)) ? 2'b01 : 2'b00;  
      
      //Stall Logic          
     assign lwStall = ((ResultSrc_E == 2'b01) & (Rd_E != 5'h00) & ((RS1_D == Rd_E) | (RS2_D == Rd_E))) ?  1'b1 : 1'b0;
     
     assign StallF = lwStall;
     assign StallD = lwStall;
     assign FlushE = lwStall;  
     
     //Flush Logic 
     assign FlushD = PCSrc_E;              

endmodule

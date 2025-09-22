module Writeback_Cycle(
input clk, rst,
input [1:0] ResultSrc_W,
input [31:0] ReadData_W, PCPlus4_W, ALUResult_W,
output [31:0] Result_W
    );
    
    
    //Module Instantiation
    Mux_4_to_1 WB_Mux(.a(ALUResult_W), 
                      .b(ALUResult_W), 
                      .c(ReadData_W), 
                      .d(PCPlus4_W),
                      .s(ResultSrc_W), 
                      .r(Result_W)
                      );
                      
                                                
endmodule

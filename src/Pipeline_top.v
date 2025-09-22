module Pipeline_top(
input clk, rst,
output ALU_Result_Out
    );
    
    
    //Interim Wires
    wire PCSrcE, RegWriteW, MemWriteE, ALUSrcE, RegWriteE, BranchE, JumpE, RegWriteM, MemWriteM;
    wire [1:0] ResultSrcE, ResultSrcM, ResultSrcW;
    wire [2:0] ALUControlE;
    wire [4:0] RdW, RdE, RdM, RS1E, RS2E;
    wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RD1E, RD2E, PCE, PCPlus4E, ImmExtE, 
                ALUResultM, WriteDataM, PCPlus4M, ReadDataW, PCPlus4W, ALUResultW ;
    wire [1:0] ForwardAE, ForwardBE;                
    //Module Instantiation
    Fetch_Cycle Fetch (.clk(clk), 
                       .rst(rst), 
                       .PCSrcE(PCSrcE), 
                       .PCTargetE(PCTargetE), 
                       .InstrD(InstrD),
                       .PCD(PCD), 
                       .PCPlus4D(PCPlus4D)
                       );
                       
    Decode_Cycle Decode(.clk(clk), 
                        .rst(rst), 
                        .RegWriteW(RegWriteW), 
                        .RdW(RdW), 
                        .InstrD(InstrD),
                        .PCD(PCD), 
                        .PCPlus4D(PCPlus4D), 
                        .ResultW(ResultW), 
                        .MemWrite_E(MemWriteE), 
                        .ALUSrc_E(ALUSrcE), 
                        .RegWrite_E(RegWriteE), 
                        .Branch_E(BranchE), 
                        .Jump_E(JumpE), 
                        .ResultSrc_E(ResultSrcE), 
                        .ALUControl_E(ALUControlE), 
                        .RD1_E(RD1E), 
                        .RD2_E(RD2E), 
                        .PC_E(PCE), 
                        .PCPlus4_E(PCPlus4E), 
                        .ImmExt_E(ImmExtE), 
                        .Rd_E(RdE),
                        .RS1E(RS1E),
                        .RS2E(RS2E)
                        ); 
                        
    Execute_Cycle Execute(.clk(clk), 
                          .rst(rst), 
                          .MemWrite_E(MemWriteE), 
                          .ALUSrc_E(ALUSrcE), 
                          .RegWrite_E(RegWriteE), 
                          .Branch_E(BranchE), 
                          .Jump_E(JumpE), 
                          .ResultSrc_E(ResultSrcE), 
                          .ALUControl_E(ALUControlE), 
                          .Rd_E(RdE), 
                          .RD1_E(RD1E), 
                          .RD2_E(RD2E), 
                          .PC_E(PCE), 
                          .PCPlus4_E(PCPlus4E),
                          .PCSrcE(PCSrcE), 
                          .ImmExt_E(ImmExtE), 
                          .RegWrite_M(RegWriteM), 
                          .MemWrite_M(MemWriteM), 
                          .ResultSrc_M(ResultSrcM), 
                          .ALUResult_M(ALUResultM), 
                          .WriteData_M(WriteDataM),
                          .PCPlus4_M(PCPlus4M), 
                          .PCTarget_E(PCTargetE), 
                          .Rd_M(RdM),
                          .ResultW(ResultW),
                          .ForwardAE(ForwardAE),
                          .ForwardBE(ForwardBE)
                          );
                          
    Memory_Cycle Memory(.clk(clk),
                        .rst(rst),
                        .RegWrite_M(RegWriteM), 
                        .MemWrite_M(MemWriteM), 
                        .ResultSrc_M(ResultSrcM), 
                        .ALUResult_M(ALUResultM), 
                        .WriteData_M(WriteDataM), 
                        .PCPlus4_M(PCPlus4M), 
                        .Rd_M(RdM), 
                        .RegWrite_W(RegWriteW),
                        .ResultSrc_W(ResultSrcW), 
                        .ReadData_W(ReadDataW), 
                        .PCPlus4_W(PCPlus4W), 
                        .ALUResult_W(ALUResultW), 
                        .Rd_W(RdW)
                        ); 
                        
    Writeback_Cycle Writeback(.clk(clk), 
                              .rst(rst), 
                              .ResultSrc_W(ResultSrcW), 
                              .ReadData_W(ReadDataW), 
                              .PCPlus4_W(PCPlus4W), 
                              .ALUResult_W(ALUResultW), 
                              .Result_W(ResultW)
                              ); 
                              
    //Hazard Unit
    Hazard_Unit Forwarding(.rst(rst), 
                           .RegWrite_M(RegWriteM), 
                           .RegWrite_W(RegWriteW),
                           .Rd_M(RdM), 
                           .Rd_W(RdW),
                           .RS1_E(RS1E), 
                           .RS2_E(RS2E),
                           .ForwardAE(ForwardAE), 
                           .ForwardBE(ForwardBE)
                           );    
                           
    assign ALU_Result_Out = ResultW[0];                                                                                                 
                                                                        
endmodule

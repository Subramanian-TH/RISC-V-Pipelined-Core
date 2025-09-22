module Execute_Cycle(
input clk, rst,
input MemWrite_E, ALUSrc_E, RegWrite_E, Branch_E, Jump_E,
input [1:0] ResultSrc_E,
input [1:0] ForwardAE, ForwardBE,
input [2:0] ALUControl_E,
input [4:0] Rd_E,
input [31:0] RD1_E, RD2_E, PC_E, PCPlus4_E, ImmExt_E, ResultW,
output RegWrite_M, MemWrite_M, PCSrcE,  
output [1:0] ResultSrc_M, 
output [31:0] ALUResult_M, WriteData_M, PCPlus4_M, PCTarget_E,
output [4:0] Rd_M
    );
    
    //Interim Wires
    wire [31:0] SrcA_E, SrcB_E, ALUResult_E;
    wire Zero_E; 
    wire [31:0] WriteData_E;
    
    //Registers Declaration
    reg RegWrite_E_r, MemWrite_E_r;
    reg [1:0] ResultSrc_E_r;
    reg [31:0] ALUResult_E_r, WriteData_E_r, PCPlus4_E_r;
    reg [4:0] Rd_E_r;
     
    //Module Instantiation
    
    Mux_3_to_1 Hazard_Mux_A(.a(RD1_E),
                            .b(ResultW),
                            .c(ALUResult_M),
                            .sel(ForwardAE),
                            .d(SrcA_E) 
                            );
                            
    Mux_3_to_1 Hazard_Mux_B(.a(RD2_E),
                            .b(ResultW),
                            .c(ALUResult_M),
                            .sel(ForwardBE),
                            .d(WriteData_E) 
                            );                          
                                
    Mux Mux_to_ALU (.a(WriteData_E),
                    .b(ImmExt_E),
                    .s(ALUSrc_E),
                    .q(SrcB_E)
                    );
                    
    ALU ALU(.A(SrcA_E),
            .B(SrcB_E),
            .ALUControl(ALUControl_E),
            .Result(ALUResult_E),
            .Z(Zero_E), 
            .N(), 
            .C(),
            .V()
            );
            
    PC_Adder PCTarget_Adder(.a(PC_E),
                            .b(ImmExt_E),
                            .r(PCTarget_E)
                            );  
                            
     PCSrc PCSRC(.Branch(Branch_E), 
                 .Jump(Jump_E), 
                 .Zero(Zero_E),
                 .PCSrc_E(PCSrcE)
                 );    
                 
                 
     // Pipelining
     always@(posedge clk or posedge rst)
     begin
     if(rst == 1'b1)
     begin
     RegWrite_E_r <= 1'b0;
     MemWrite_E_r <= 1'b0;
     ResultSrc_E_r <= 2'b00;
     Rd_E_r <= 5'h00;
     ALUResult_E_r <= 32'h00000000; 
     WriteData_E_r <= 32'h00000000; 
     PCPlus4_E_r <= 32'h00000000;
     end    
     
     else
     begin 
     RegWrite_E_r <= RegWrite_E;
     MemWrite_E_r <= MemWrite_E;
     ResultSrc_E_r <= ResultSrc_E;
     Rd_E_r <= Rd_E;
     ALUResult_E_r <= ALUResult_E; 
     WriteData_E_r <= WriteData_E; 
     PCPlus4_E_r <= PCPlus4_E;
     end
     end
     
     
     //Output Assignment
     assign RegWrite_M = RegWrite_E_r;
     assign MemWrite_M = MemWrite_E_r;
     assign ResultSrc_M = ResultSrc_E_r;
     assign Rd_M = Rd_E_r;
     assign ALUResult_M = ALUResult_E_r;
     assign WriteData_M = WriteData_E_r;
     assign PCPlus4_M = PCPlus4_E_r;
                                                      
    
endmodule

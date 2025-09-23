module Decode_Cycle(
input clk, rst, RegWriteW, 
input FlushE,
input [4:0] RdW, 
input [31:0] InstrD, PCD, PCPlus4D, ResultW,
output MemWrite_E, ALUSrc_E, RegWrite_E, Branch_E, Jump_E,
output [1:0] ResultSrc_E, 
output [2:0] ALUControl_E,
output [31:0] RD1_E, RD2_E, PC_E, PCPlus4_E, ImmExt_E,
output [4:0] Rd_E, RS1E, RS2E
);

 //Interim  Wires
 
 wire MemWriteD, ALUSrcD, RegWriteD, BranchD, JumpD;
 wire [31:0] RD1D, RD2D, ImmExtD;
 wire [1:0] ImmSrcD, ResultSrcD, ALUOp;
 wire [2:0] ALUControlD;
 
 //Register Declaration
 
 reg MemWriteD_r, ALUSrcD_r, RegWriteD_r, BranchD_r, JumpD_r;
 reg [1:0] ResultSrcD_r;
 reg [2:0] ALUControlD_r;
 reg [31:0] RD1_r, RD2_r, PCD_r, PCPlus4D_r, ImmExtD_r;
 reg [4:0] RdD_r, RS1D_r, RS2D_r;
 
 
 // Module Instantiation
 
  Control_Unit_Top Control_Unit( 
                                .fn7(InstrD[30]), 
                                .fn3(InstrD[14:12]), 
                                .op(InstrD[6:0]),
                                .MemWrite(MemWriteD), 
                                .ALUSrc(ALUSrcD), 
                                .RegWrite(RegWriteD), 
                                .Branch(BranchD), 
                                .Jump(JumpD),  
                                .ResultSrc(ResultSrcD), 
                                .ImmSrc(ImmSrcD),
                                .ALUControl(ALUControlD),
                                .ALUOp(ALUOp)
                                );
                                
  Register_File Reg_File(.clk(clk),
                         .rst(rst),
                         .A1(InstrD[19:15]),
                         .A2(InstrD[24:20]), 
                         .A3(RdW), 
                         .WE3(RegWriteW),
                         .WD3(ResultW), 
                         .RD1(RD1D), 
                         .RD2(RD2D)
                         );
                         
   Sign_Extend Sign_Extender(.Instr(InstrD), 
                             .ImmSrc(ImmSrcD), 
                             .ImmExt(ImmExtD)
                             );       
                             
                             
    //Pipelining 
    always@(posedge clk or posedge rst)
    begin
    if(rst == 1'b1)
    begin
    MemWriteD_r <= 1'b0;
    ALUSrcD_r <= 1'b0; 
    RegWriteD_r <= 1'b0;
    BranchD_r <= 1'b0; 
    JumpD_r <= 1'b0;
    ResultSrcD_r <= 2'b00;
    ALUControlD_r <= 3'b000;
    RD1_r <= 32'h00000000;
    RD2_r <= 32'h00000000;
    PCD_r <= 32'h00000000;
    PCPlus4D_r <= 32'h00000000; 
    ImmExtD_r <= 32'h00000000;
    RdD_r <= 5'h00;
    RS1D_r <= 5'h00;
    RS2D_r <= 5'h00;
    end 
    
    else if(FlushE)
    begin   
    MemWriteD_r <= 1'b0;
    ALUSrcD_r <= 1'b0; 
    RegWriteD_r <= 1'b0;
    BranchD_r <= 1'b0; 
    JumpD_r <= 1'b0;
    ResultSrcD_r <= 2'b00;
    ALUControlD_r <= 3'b000;
    RD1_r <= 32'h00000000;
    RD2_r <= 32'h00000000;
    PCD_r <= 32'h00000000;
    PCPlus4D_r <= 32'h00000000; 
    ImmExtD_r <= 32'h00000000;
    RdD_r <= 5'h00;
    RS1D_r <= 5'h00;
    RS2D_r <= 5'h00;
    end 
    
    else
    begin   
    MemWriteD_r <= MemWriteD;
    ALUSrcD_r <= ALUSrcD; 
    RegWriteD_r <= RegWriteD;
    BranchD_r <= BranchD; 
    JumpD_r <= JumpD;
    ResultSrcD_r <= ResultSrcD;
    ALUControlD_r <= ALUControlD;
    RD1_r <= RD1D;
    RD2_r <= RD2D;
    PCD_r <= PCD;
    PCPlus4D_r <= PCPlus4D; 
    ImmExtD_r <= ImmExtD;
    RdD_r <= InstrD[11:7];
    RS1D_r <= InstrD[19:15];
    RS2D_r <= InstrD[24:20];
    end 
    end
    
    //Output Assignment (Execute Stage)
    
    assign MemWrite_E = MemWriteD_r;
    assign ALUSrc_E = ALUSrcD_r;
    assign RegWrite_E = RegWriteD_r;
    assign Branch_E = BranchD_r;
    assign Jump_E = JumpD_r;
    assign ResultSrc_E = ResultSrcD_r;
    assign ALUControl_E = ALUControlD_r;
    assign RD1_E = RD1_r;
    assign RD2_E = RD2_r;
    assign PC_E = PCD_r;
    assign PCPlus4_E = PCPlus4D_r;
    assign ImmExt_E = ImmExtD_r;
    assign Rd_E = RdD_r; 
    assign RS1E = RS1D_r;
    assign RS2E = RS2D_r;                                                                         

endmodule

module Memory_Cycle(
input clk, rst, 
input RegWrite_M, MemWrite_M,
input [1:0] ResultSrc_M,
input [31:0]  ALUResult_M, WriteData_M, PCPlus4_M,
input [4:0] Rd_M,
output RegWrite_W,
output [1:0] ResultSrc_W,
output [31:0] ReadData_W, PCPlus4_W, ALUResult_W,
output [4:0] Rd_W
    );
    
    //Interim Wires
    wire [31:0] ReadData_M;
    
    //Register Declaration
    reg RegWrite_M_r;
    reg [1:0] ResultSrc_M_r;
    reg [31:0] ReadData_M_r, PCPlus4_M_r, ALUResult_M_r;
    reg [4:0] Rd_M_r;
    
    
    //Module Instantiation
    Data_Memory Data_Mem(.clk(clk), 
                         .rst(rst), 
                         .WE(MemWrite_M), 
                         .A(ALUResult_M),
                         .WD(WriteData_M), 
                         .RD(ReadData_M)
                         );
                         
    //Pipelining
    always@(posedge clk or posedge rst)
    begin
    if(rst == 1'b1)
    begin 
     RegWrite_M_r <=  1'b0;
     ResultSrc_M_r <= 2'b00;
     ReadData_M_r <= 32'h00000000;
     PCPlus4_M_r <= 32'h00000000;
     Rd_M_r <= 5'h00;
     ALUResult_M_r <= 32'h00000000;
    end 
    
    else
    begin   
     RegWrite_M_r <=  RegWrite_M;
     ResultSrc_M_r <= ResultSrc_M;
     ReadData_M_r <= ReadData_M;
     PCPlus4_M_r <= PCPlus4_M;
     Rd_M_r <= Rd_M;
     ALUResult_M_r <= ALUResult_M;
    end 
    end
    
    //Output Assignment
    assign RegWrite_W = RegWrite_M_r;
    assign ResultSrc_W = ResultSrc_M_r;
    assign ReadData_W = ReadData_M_r;
    assign Rd_W = Rd_M_r;
    assign PCPlus4_W = PCPlus4_M_r;
    assign ALUResult_W = ALUResult_M_r;
                             
                                
endmodule

module Fetch_Cycle(
input clk, rst, 
input en,
input FlushD,
input PCSrcE,
input StallF, StallD,  
input [31:0] PCTargetE,
output [31:0] InstrD, PCD, PCPlus4D
    );
    
    //Interim WIres 
    
    wire [31:0] PC_F, PCF, PCPlus4F, InstrF;
    
    //Registers Declaration
   
    reg [31:0] InstrF_reg, PCF_reg, PCPlus4F_reg; 
    
    //Module Instantiation
    
    Mux PC_Mux(.a(PCPlus4F), 
               .b(PCTargetE), 
               .s(PCSrcE), 
               .q(PC_F));
               
    PC PC_Module(.clk(clk), 
                 .rst(rst), 
                 .en(~StallF),
                 .PC_Next(PC_F),
                 .PC(PCF));
      
    Instr_Mem Instruction_Memory(.rst(rst),
                                 .A(PCF),
                                 .RD(InstrF));   
              
    PC_Adder PC_Adder_Module(.a(PCF),
                             .b(32'h00000004),
                             .r(PCPlus4F));  
                             
    //Register Logic
    
     always@(posedge clk or posedge rst)
     begin 
     if(rst)
     begin 
       InstrF_reg <= 32'h00000000;
       PCF_reg <= 32'h00000000;
       PCPlus4F_reg <= 32'h00000000; 
     end 
     
     else if(FlushD)   
     begin 
       InstrF_reg <= 32'h00000000;
       PCF_reg <= 32'h00000000;
       PCPlus4F_reg <= 32'h00000000; 
     end 
     
     else if(~StallD) 
     begin  
       InstrF_reg <= InstrF;
       PCF_reg <= PCF;
       PCPlus4F_reg <= PCPlus4F; 
     end
     end  
     
     //Output Declaration
     
     assign InstrD = InstrF_reg;
     assign PCD = PCF_reg;
     assign PCPlus4D = PCPlus4F_reg;
endmodule

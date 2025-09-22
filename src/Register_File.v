module Register_File(
input clk, rst,
input [4:0] A1, A2, A3,
input WE3,
input [31:0] WD3,
output [31:0] RD1, RD2
    );
    
    
    reg [31:0] registers [31:0];
    
    assign RD1 = (rst) ? 32'h00000000 : registers[A1];
    assign RD2 = (rst) ? 32'h00000000 : registers[A2];
    
    always@(posedge clk)
    begin
    if(WE3)
    registers[A3] <= WD3;
    end 
    
    
    initial begin   
    registers[0] = 32'h00000000;
    registers[5] = 32'h00000005;
    registers[6] = 32'h00000006;
    registers[7] = 32'h00000009;
    registers[8] = 32'h00000008;
    registers[9] = 32'h00000020;
    registers[12] = 32'h00000001;
    registers[13] = 32'h00000002;
    end
    
     
endmodule
    
    

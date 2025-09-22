module Data_Memory(
input clk, rst,
input WE, 
input [31:0] A, WD, 
output [31:0] RD
    );
    
    
    //Memory 
    reg [31:0] Data_mem [1023:0];
    
    //Read operation
    assign RD = (rst) ? 32'h00000000 : Data_mem[A];
    
    //Write Operation
    always@(posedge clk)
    begin
    if(WE)
    begin
    Data_mem[A] <= WD;
    end
    end
    
    initial begin
    Data_mem[40] = 32'h00000016;
    Data_mem[0] = 32'h00000007;    
    end
    
endmodule

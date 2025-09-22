module PC(
input clk, rst, 
input [31:0] PC_Next,
output reg [31:0] PC
    );
    
    always@(posedge clk)
    begin 
    if(rst)
    PC <= 32'h00000000; 
    else
    PC <= PC_Next;
    end 
    
endmodule

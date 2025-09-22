module Instr_Mem(
input rst,
input [31:0] A,
output [31:0] RD
    );
    
    reg [31:0] mem [31:0];
    
    assign RD = (rst) ? 32'h00000000 : mem[A[31:2]];
    
    initial begin 
    $readmemh("memfile.hex", mem);
    $display("Successfully read !"); 
    end 
    
endmodule

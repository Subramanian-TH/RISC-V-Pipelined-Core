module ALU(
input [31:0] A, B,
input [2:0] ALUControl,
output [31:0] Result,
output Z, N, C, V
    );
    
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;
    wire [31:0] mux_1;
    wire [31:0] sum;
    wire cout;
    wire [31:0] slt;
    wire [31:0] mux_2;
    
    assign a_and_b = A & B;
    assign a_or_b = A | B;
    assign not_b = ~B;
    
    assign mux_1 = (ALUControl[0] == 1'b1) ? not_b : B;
    
    assign {cout, sum} = A + mux_1 + ALUControl[0];
    
    //Set less than operation
    
    assign slt = {31'b0000000000000000000000000000000, sum[31]};
    
    assign mux_2 = (ALUControl == 3'b000) ? sum :
                   (ALUControl == 3'b001) ? sum :
                   (ALUControl == 3'b010) ? a_and_b : 
                   (ALUControl == 3'b011) ? a_or_b : 
                   (ALUControl == 3'b101) ? slt : 32'h00000000;
                   
    assign Result =  mux_2;
    
    assign Z = &(~Result);
    
    assign N = Result[31];
    
    assign C = cout & (~ALUControl[1]);
    
    assign V = (~(A[31] ^ B[31] ^ ALUControl[0])) & (A[31] ^ sum[31]) & (~ALUControl[1]);
                      
    
    
endmodule

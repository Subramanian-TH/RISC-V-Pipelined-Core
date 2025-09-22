module Control_Unit_Top(
input fn7,
input [2:0] fn3, 
input [6:0] op,
output MemWrite, ALUSrc, RegWrite, Branch, Jump, 
output [1:0] ResultSrc, ImmSrc, ALUOp,
output [2:0] ALUControl
);



    Main_Decoder Main_Decoder_Module(.op(op),
                                     .MemWrite(MemWrite), 
                                     .RegWrite(RegWrite), 
                                     .ALUSrc(ALUSrc), 
                                     .ResultSrc(ResultSrc),
                                     .ImmSrc(ImmSrc),
                                     .ALUOp(ALUOp),
                                     .Branch(Branch),
                                     .Jump(Jump)
                                     );
                               
    ALU_Decoder ALU_Decoder_Module(.op(op[5]), 
                                   .fn7(fn7),
                                   .ALUOp(ALUOp),
                                   .fn3(fn3),
                                   .ALUControl(ALUControl)
                                   );
                            

endmodule

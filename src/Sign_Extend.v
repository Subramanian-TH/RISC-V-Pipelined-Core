module Sign_Extend(
input [31:0] Instr,
input [1:0] ImmSrc,
output [31:0] ImmExt
    );
    
    assign ImmExt = (ImmSrc == 2'b00) ? {{20{Instr[31]}}, Instr[31:20]} :
                    (ImmSrc == 2'b01) ? {{20{Instr[31]}}, Instr[31:25], Instr[11:7]} :
                    (ImmSrc == 2'b10) ? {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0} : 
                                        {{11{Instr[31]}}, Instr[31], Instr[19:12], Instr[20], Instr[30:21], 1'b0};
                    
endmodule

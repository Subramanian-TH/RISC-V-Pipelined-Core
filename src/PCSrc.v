module PCSrc(
input Branch, Jump, Zero,
output PCSrc_E
    );
    
    assign PCSrc_E = (Branch & Zero) | Jump;
endmodule

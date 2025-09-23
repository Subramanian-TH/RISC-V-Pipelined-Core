module Pipeline_tb();

reg clk = 1'b0, rst;

Pipeline_top Pipelined_RISCV(.clk(clk),
                             .rst(rst)
                              );
                              
    always #50 clk = ~clk;
    
    initial begin
    rst = 1'b1;
    #100;
    rst = 1'b0;
    #1000;
    $finish;
    end  
                                  
endmodule

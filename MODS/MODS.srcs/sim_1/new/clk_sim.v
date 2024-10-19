`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2024 14:20:32
// Design Name: 
// Module Name: clk_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_sim(

    );
    reg CLOCK;
    wire slow_clk;
    flexy_clock dut (CLOCK, 7, slow_clk);
    initial begin 
        CLOCK = 0;
    end
    always begin
        #5 CLOCK = ~CLOCK; 
    end
endmodule

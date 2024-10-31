`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2024 14:13:06
// Design Name: 
// Module Name: flexy_clock
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


module flexy_clock(
    input clk,
    input [31:0] m_value,
    output reg slow_clk
    );
    
    reg [31:0] COUNT;
    
    initial begin
        COUNT = 0;
        slow_clk = 0;
    end 
    
    always @ (posedge clk) begin
        COUNT <= (COUNT == m_value) ? 0 : COUNT + 1;
        slow_clk <= (COUNT == 0) ? ~slow_clk : slow_clk; 
    end
    
endmodule

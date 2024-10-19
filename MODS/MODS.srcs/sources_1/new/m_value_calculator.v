`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2024 18:10:46
// Design Name: 
// Module Name: m_value_calculator
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


module m_value_calculator(
    input [31:0] freq, 
    output m_value
    );
//    initial begin 
        assign m_value = (100_000_000/(2*freq)) - 1;
//    end
endmodule

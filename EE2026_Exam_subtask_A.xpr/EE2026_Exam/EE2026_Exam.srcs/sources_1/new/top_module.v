`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 14:48:29
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clk, [15:0]sw, btnR, btnC,
    output [15:0]led, [3:0]an, [7:0]seg
    );
    
    wire [3:0]an_A;
    wire [7:0]seg_A;
    wire [3:0]an_B;
    wire [7:0]seg_B;    
    
    subtask_A(sw[2], led, an, seg);
    
//    subtask_B(clk, sw[15], btnR, an_B, seg_B);
    
//    assign an = sw[15] ? an_B : an_A;
//    assign seg = sw[15] ? seg_B : seg_A; 
    
endmodule

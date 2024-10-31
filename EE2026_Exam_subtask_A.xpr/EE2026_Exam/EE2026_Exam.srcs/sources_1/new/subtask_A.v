`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 14:52:12
// Design Name: 
// Module Name: subtask_A
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


module subtask_A(
    input sw2, 
    output [15:0]led, [3:0]an, [7:0]seg
    );
    
    assign led = sw2 ? 16'b000000_1101001010 : 16'b000000_1111111111;
    assign an = 4'b0010;
    assign seg = 8'b10011001;
    
endmodule

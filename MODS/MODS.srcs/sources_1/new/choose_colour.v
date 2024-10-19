`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2024 15:51:17
// Design Name: 
// Module Name: choose_colour
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


module choose_colour(
    input clk, [4:0]sw,
    output reg [15:0] oled_data
    );
    
    always @ (posedge clk) begin
        // blue
        oled_data[4:0] = sw[0] ? 5'b11111 : 0;
        // green
        oled_data[10:5] = sw[1] ? 6'b111111 : 0;
        // red
        oled_data[15:11] = sw[2] ? 5'b11111 : 0; 
    end
endmodule

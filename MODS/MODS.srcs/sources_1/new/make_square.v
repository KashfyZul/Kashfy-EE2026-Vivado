`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2024 17:17:39
// Design Name: 
// Module Name: make_square
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


module make_square(
    input clk, [6:0]x, [6:0]y, 
    [6:0]x_val, [6:0]y_val, [6:0]sq_width, [6:0]sq_height, [15:0]sq_colour, 
    [6:0]x_val2, [6:0]y_val2, [6:0]sq_width2, [6:0]sq_height2, [15:0]sq_colour2, 
    [15:0]bg_colour,
    output reg [15:0]oled_data
    );
    
    
    always @ (posedge clk) begin
        if (x >= x_val && x < x_val + sq_width && y >= y_val && y < y_val + sq_height) begin
            oled_data = sq_colour;
        end else if (x >= x_val2 && x < x_val2 + sq_width2 && y >= y_val2 && y < y_val2 + sq_height2) begin
            oled_data = sq_colour2; 
        end else begin
            oled_data = bg_colour;
        end
    end 
        
endmodule

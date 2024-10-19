`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2024 16:08:35
// Design Name: 
// Module Name: choose_pixel_colour
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


module choose_pixel_colour(
    input clk, [6:0]x, [6:0]y, 
    output reg [15:0]oled_data
    );
    reg [6:0]x_var;
    reg [6:0]y_var;
    initial begin
        x_var = 25;
        y_var = 25; 
    end
    always @ (posedge clk) begin
        if (x >= x_var && x < x_var+25 && y >= y_var && y < y_var+25) begin
//        if (x >= 25 && x < 50 && y >= 25 && y < 50) begin
            oled_data <= 16'b11111_000000_00000;
        end else begin
            oled_data <= 16'b00000_101010_10101;
        end
    end
    
    wire clk25;
    flexy_clock clk_25Hz (.clk(clk), .m_value(1999999), .slow_clk(clk25));
    
    always @ (posedge clk25) begin
           x_var <= x_var + 1;
           y_var <= y_var;
    end
endmodule

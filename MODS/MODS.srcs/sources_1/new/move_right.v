`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2024 16:45:57
// Design Name: 
// Module Name: move_right
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


module move_right(
    input clk, [6:0] start_x, [6:0] start_y,
    output reg [6:0] x_var, 
    reg [6:0] y_var
    );
    initial begin
        x_var = start_x;
        y_var = start_y;
    end
    always @ (posedge clk) begin
        x_var <= x_var + 1;
        y_var <= y_var;
    end
endmodule

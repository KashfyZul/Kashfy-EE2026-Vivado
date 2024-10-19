`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2024 19:00:57
// Design Name: 
// Module Name: direction_mux
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


module direction_mux(
    input clk, btnC, btnL, btnR, btnD, btnU, is_y_stat,
    output reg [6:0]x_vect, reg [6:0]y_vect 
    );
//    always @ (posedge clk) begin
//        if (btnC) begin // stop moving
//            x_vect = 0;
//            y_vect = 0;
//        end else if (btnL) begin // move left
//            x_vect = 127;
//            y_vect = 0;
//        end else if (btnR) begin // move right
//            x_vect = 1;
//            y_vect = 0;
//        end else if (btnD) begin // move down
//            x_vect = 0;
//            y_vect = 1;
//        end else if (btnU) begin // move up
//            x_vect = 0;
//            y_vect = 127;
//        end
//    end

    reg [31:0]jump_height;
    reg [31:0]jumping;
    initial begin
        x_vect = 0;
        y_vect = 0;
        jump_height = 20;
        jumping = 0;  
    end
    always @ (posedge clk) begin
        if (btnL) begin // move left
            x_vect = 127;
//            y_vect = 0;
        end else if (btnR) begin // move right
            x_vect = 1;
//            y_vect = 0;
        end else begin
            x_vect = 0;
        end
//        if (jumping > 0) begin
//            y_vect = 127;
//            jumping = jumping - 1;
//        end else 
        if (is_y_stat) begin
            if (btnU) begin
                y_vect = 127;
//                jumping = jump_height;
            end
        end else begin
            y_vect = 1;
        end
    end
endmodule

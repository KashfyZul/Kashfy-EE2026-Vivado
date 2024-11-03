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
    output reg [6:0]x_vect, reg [6:0]y_vect, reg facing // 1 is left, 0 is right
    );

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
            facing = 1;
        end else if (btnR) begin // move right
            x_vect = 1;
            facing = 0;
        end else begin
            x_vect = 0;
        end
//        if (jumping > 0) begin
//            y_vect = 127;
//            jumping = jumping - 1;
//        end else 
        
    end
    wire clk1000;    
    flexy_clock clk1hz (.clk(clk), .m_value(49_999), .slow_clk(clk1000));
    reg [31:0] counter = 0;        
    always @ (posedge clk1000) begin // for debouncing of buttons    
        if (counter != 32'hFFFFFFFF) begin 
            counter <= counter + 1; // prevents counter overflow
        end
        if (is_y_stat) begin
            if (btnU && counter >= 200) begin
            y_vect = 127;
            end
        end else begin
            y_vect = 1;
        end         
        if (btnU) begin
            counter <= 0;    
        end
    end

endmodule

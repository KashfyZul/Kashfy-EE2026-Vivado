`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 00:26:52
// Design Name: 
// Module Name: proj_animate
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


module proj_animate(
    input clk, btnD,
    [6:0]x_ref, [6:0]y_ref, [6:0]x_vect, [6:0]y_vect, [6:0]sq_width, [6:0]sq_height, 
    [6:0]proj_width, [6:0]proj_height,
//    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, 
    [6:0]x_platform1, [6:0]y_platform1, [6:0]width_platform1, [6:0]height_platform1,
    [6:0]x_platform2, [6:0]y_platform2, [6:0]width_platform2, [6:0]height_platform2,
    reset,
    output reg [6:0]x_var, reg [6:0]y_var
    );

    // shoot either left or right dependning on directin of movement of player (x_vect, y_vect)
    // starts from centre of player sprite 
    // shoots with constant velocity (constant x_increment)

    wire [6:0] launchpt_x_left;
    wire [6:0] launchpt_x_right;
    wire [6:0] launchpt_y;
    reg [6:0] launch_x; // starting pts for projectile launch
    reg [6:0] launch_y;
    reg [6:0] x_increment;
    reg [6:0] y_increment;
    
    initial begin
        x_increment = 0;
        y_increment = 0;
    end
    
    
    assign launchpt_x_left = x_ref;
    assign launchpt_x_right = x_ref + sq_width;
    assign launchpt_y = y_ref + ((sq_height - proj_height) / 2);
    
    wire fps_clock;
    flexy_clock get_fps_clock (.clk(clk), .m_value(1_249_999), .slow_clk(fps_clock));
    
    always @ (posedge fps_clock) begin
        
        
        if (btnD && x_increment == 0) begin // should only run when button is pressed and projectile is not launched (not moving)
            x_increment = x_vect;
            if (x_vect == 1) begin // facing right, launch from right
                x_var = launchpt_x_right; // starting point for projectile
            end else if (x_vect == 127) begin // facing left, launch from left
                x_var = launchpt_x_left; // starting point for projectile
            end
            y_var = launchpt_y;
        end else if (x_increment != 0) begin
            
        end
        
        x_var = x_var + x_increment;
        y_var = y_var;
        
    end



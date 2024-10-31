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


module projectile_animate(
    input clk, btnD,
    [6:0]x_ref, [6:0]y_ref, [6:0]x_vect, [6:0]y_vect, [6:0]sq_width, [6:0]sq_height, 
    [6:0]proj_width, [6:0]proj_height, [2:0]char_no,
//    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, 
    [6:0]x_platform1, [6:0]y_platform1, [6:0]width_platform1, [6:0]height_platform1,
    [6:0]x_platform2, [6:0]y_platform2, [6:0]width_platform2, [6:0]height_platform2,
    reset,
    output [6:0]x_var, [6:0]y_var, [6:0]new_proj_width, proj_move, proj_hit_enemy
    );
    
//    assign new_proj_width = 2;

//    single_shot(.clk(clk), .btnD(btnD), 
//        .x_ref(x_ref), .y_ref(y_ref), .x_vect(x_vect), .y_vect(y_vect), .sq_width(sq_width), .sq_height(sq_height),
//        .proj_width(proj_width), .proj_height(proj_height),
//        .x_platform1(x_platform1), .y_platform1(y_platform1), .width_platform1(width_platform1), .height_platform1(height_platform1),
//        .x_platform2(x_platform2), .y_platform2(y_platform2), .width_platform2(width_platform2), .height_platform2(height_platform2), .reset(reset),
//        .x_var(x_var), .y_var(y_var), .proj_move(proj_move), .proj_hit_enemy(proj_hit_enemy)
//    );

    laser_shot(.clk(clk), .btnD(btnD), 
        .x_ref(x_ref), .y_ref(y_ref), .x_vect(x_vect), .y_vect(y_vect), .sq_width(sq_width), .sq_height(sq_height),
        .proj_width(proj_width), .proj_height(proj_height),
        .x_platform1(x_platform1), .y_platform1(y_platform1), .width_platform1(width_platform1), .height_platform1(height_platform1),
        .x_platform2(x_platform2), .y_platform2(y_platform2), .width_platform2(width_platform2), .height_platform2(height_platform2), .reset(reset),
        .x_var(x_var), .y_var(y_var), .new_proj_width(new_proj_width), .proj_move(proj_move), .proj_hit_enemy(proj_hit_enemy)
    );

endmodule

module single_shot(
    input clk, btnD,
    [6:0]x_ref, [6:0]y_ref, [6:0]x_vect, [6:0]y_vect, [6:0]sq_width, [6:0]sq_height, 
    [6:0]proj_width, [6:0]proj_height,
//    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, 
    [6:0]x_platform1, [6:0]y_platform1, [6:0]width_platform1, [6:0]height_platform1,
    [6:0]x_platform2, [6:0]y_platform2, [6:0]width_platform2, [6:0]height_platform2,
    reset,
    output reg [6:0]x_var, reg [6:0]y_var, reg proj_move, reg proj_hit_enemy
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
        proj_move = 0;
    end
    
    
    assign launchpt_x_left = x_ref - proj_width;
    assign launchpt_x_right = x_ref + sq_width;
    assign launchpt_y = y_ref + ((sq_height - proj_height) / 2);
    
    wire fps_clock;
    flexy_clock get_fps_clock (.clk(clk), .m_value(624_999), .slow_clk(fps_clock));
    
    always @ (posedge fps_clock) begin
        if (reset) begin
            x_increment = 0;
            y_increment = 0;
        end
        if (btnD && x_increment == 0) begin // should only run when button is pressed and projectile is not launched (not moving)
            x_increment = x_vect;
            if (x_vect == 1) begin // facing right, launch from right
                x_var = launchpt_x_right; // starting point for projectile
            end else if (x_vect == 127) begin // facing left, launch from left
                x_var = launchpt_x_left; // starting point for projectile
            end
            y_var = launchpt_y;
//        end else if (x_increment == 0) begin
//            if (x_vect == 1) begin // facing right, launch from right
//                x_var = launchpt_x_right; // starting point for projectile
//            end else if (x_vect == 127) begin // facing left, launch from left
//                x_var = launchpt_x_left; // starting point for projectile
//            end
//             y_var = launchpt_y;
        end else if (x_increment == 0) begin
            x_var = x_ref;
            y_var = y_ref;
            proj_move = 0;
        end
        
        // check left bound of screen
        if (x_var == 0 && x_increment == 127) begin 
            x_increment = 0;
        // check right bound of screen
        end else if (x_var + proj_width - 1 == 95 && x_increment == 1) begin
            x_increment = 0;
        // check left bound of platform1
        end else if (x_var + proj_width == x_platform1 && (y_var + proj_height > y_platform1 && y_var < y_platform1 + height_platform1) && x_increment == 1) begin // left bound of red square
            x_increment = 0;
        // check right bound of platform1
        end else if (x_var == x_platform1 + width_platform1 && (y_var + proj_height > y_platform1 && y_var < y_platform1 + height_platform1) && x_increment == 127) begin // right bound of red square
            x_increment = 0;
        // check left bound of platform2
        end else if (x_var + proj_width == x_platform2 && (y_var + proj_height > y_platform2 && y_var < y_platform2 + height_platform2) && x_increment == 1) begin // left bound of red square
            x_increment = 0;
        // check right bound of platform2
        end else if (x_var == x_platform2 + width_platform2 && (y_var + proj_height > y_platform2 && y_var < y_platform2 + height_platform2) && x_increment == 127) begin // right bound of red square
            x_increment = 0;
        end
        
        proj_move = x_increment ? 1 : 0;
        x_var = x_var + x_increment;
        y_var = y_var;
        
    end
endmodule

module laser_shot(
    input clk, btnD,
    [6:0]x_ref, [6:0]y_ref, [6:0]x_vect, [6:0]y_vect, [6:0]sq_width, [6:0]sq_height, 
    [6:0]proj_width, [6:0]proj_height, [2:0]char_no,
//    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, 
    [6:0]x_platform1, [6:0]y_platform1, [6:0]width_platform1, [6:0]height_platform1,
    [6:0]x_platform2, [6:0]y_platform2, [6:0]width_platform2, [6:0]height_platform2,
    reset,
    output reg [6:0]x_var, reg [6:0]y_var, reg [6:0]new_proj_width, reg proj_move, reg proj_hit_enemy
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
        proj_move = 0;
        new_proj_width = proj_width;
    end
    
    
    assign launchpt_x_left = x_ref - proj_width;
    assign launchpt_x_right = x_ref + sq_width;
    assign launchpt_y = y_ref + ((sq_height - proj_height) / 2);
    
    wire fps_clock;
    flexy_clock get_fps_clock (.clk(clk), .m_value(249_999), .slow_clk(fps_clock));
    
    always @ (posedge fps_clock) begin
        if (reset) begin
            x_increment = 0;
            y_increment = 0;
            x_var = x_ref + sq_width / 2;
            y_var = y_ref;
            proj_move = 0;
        end
        if (btnD && x_increment == 0) begin // should only run when button is pressed and projectile is not launched (not moving)
            x_increment = x_vect;
            if (x_vect == 1) begin // facing right, launch from right
                x_var = launchpt_x_right; // starting point for projectile
                
                
                
            end else if (x_vect == 127) begin // facing left, launch from left
                x_var = launchpt_x_left; // starting point for projectile
                
                
            end
            y_var = launchpt_y;
//        end else if (x_increment == 0) begin
//            if (x_vect == 1) begin // facing right, launch from right
//                x_var = launchpt_x_right; // starting point for projectile
//            end else if (x_vect == 127) begin // facing left, launch from left
//                x_var = launchpt_x_left; // starting point for projectile
//            end
//             y_var = launchpt_y;
        end else if (x_increment == 0) begin
            x_var = x_ref + sq_width / 2;
            y_var = y_ref;
            proj_move = 0;
        end
        
        // check left bound of screen
        if (x_var == 0 && x_increment == 127) begin 
            x_increment = 0;
        // check right bound of screen
        end else if (x_var + proj_width - 1 == 95 && x_increment == 1) begin
            x_increment = 0;
        // check left bound of platform1
        end else if (x_var + proj_width == x_platform1 && (y_var + proj_height > y_platform1 && y_var < y_platform1 + height_platform1) && x_increment == 1) begin // left bound of red square
            x_increment = 0;
        // check right bound of platform1
        end else if (x_var == x_platform1 + width_platform1 && (y_var + proj_height > y_platform1 && y_var < y_platform1 + height_platform1) && x_increment == 127) begin // right bound of red square
            x_increment = 0;
        // check left bound of platform2
        end else if (x_var + proj_width == x_platform2 && (y_var + proj_height > y_platform2 && y_var < y_platform2 + height_platform2) && x_increment == 1) begin // left bound of red square
            x_increment = 0;
        // check right bound of platform2
        end else if (x_var == x_platform2 + width_platform2 && (y_var + proj_height > y_platform2 && y_var < y_platform2 + height_platform2) && x_increment == 127) begin // right bound of red square
            x_increment = 0;
        end
        
        
        if (x_increment == 127) begin
            proj_move = 1;
            new_proj_width = new_proj_width + 1;
        end else if (x_increment == 1) begin
            proj_move = 1;
            new_proj_width = new_proj_width + 1;
            x_increment = 0;
        end else begin
            proj_move = 0;
//            new_proj_width = proj_width;
        end
        x_var = x_var + x_increment;
        y_var = y_var;
        
    end
endmodule
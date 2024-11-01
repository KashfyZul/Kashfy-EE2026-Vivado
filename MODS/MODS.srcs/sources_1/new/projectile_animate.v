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
    [2:0]char_no,
//    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, 
    [6:0]x_platform1, [6:0]y_platform1, [6:0]width_platform1, [6:0]height_platform1,
    [6:0]x_platform2, [6:0]y_platform2, [6:0]width_platform2, [6:0]height_platform2,
    reset,
    output reg [6:0]x_varA, reg [6:0]y_varA, reg [6:0]x_varB, reg [6:0]y_varB, reg [6:0]proj_width, reg[6:0]proj_height, reg proj_move, reg proj_hit_enemy
    );
    

    wire [6:0]x_var1; 
    wire [6:0]y_var1; 
    wire [6:0]proj_width1;
    wire [6:0]proj_height1;
    wire proj_move1;
    wire proj_hit_enemy1;
    wire [6:0]x_var2; 
    wire [6:0]y_var2; 
    wire [6:0]proj_width2;
    wire [6:0]proj_height2;
    wire proj_move2;
    wire proj_hit_enemy2;
    wire [6:0]x_var31; 
    wire [6:0]y_var31;
    wire [6:0]x_var32; 
    wire [6:0]y_var32; 
    wire [6:0]proj_width3;
    wire [6:0]proj_height3;
    wire proj_move3;
    wire proj_hit_enemy3;
    wire [6:0]x_var4; 
    wire [6:0]y_var4; 
    wire [6:0]proj_width4;
    wire [6:0]proj_height4;
    wire proj_move4;
    wire proj_hit_enemy4;


    single_shot(.clk(clk), .btnD(btnD), 
        .x_ref(x_ref), .y_ref(y_ref), .x_vect(x_vect), .y_vect(y_vect), .sq_width(sq_width), .sq_height(sq_height),
        
        .x_platform1(x_platform1), .y_platform1(y_platform1), .width_platform1(width_platform1), .height_platform1(height_platform1),
        .x_platform2(x_platform2), .y_platform2(y_platform2), .width_platform2(width_platform2), .height_platform2(height_platform2), .reset(reset),
        .x_var(x_var1), .y_var(y_var1), .proj_width(proj_width1), .proj_height(proj_height1), .proj_move(proj_move1), .proj_hit_enemy(proj_hit_enemy1)
    );

    laser_shot2(.clk(clk), .btnD(btnD), 
        .x_ref(x_ref), .y_ref(y_ref), .x_vect(x_vect), .y_vect(y_vect), .sq_width(sq_width), .sq_height(sq_height),

        .x_platform1(x_platform1), .y_platform1(y_platform1), .width_platform1(width_platform1), .height_platform1(height_platform1),
        .x_platform2(x_platform2), .y_platform2(y_platform2), .width_platform2(width_platform2), .height_platform2(height_platform2), .reset(reset),
        .x_var(x_var2), .y_var(y_var2), .proj_width(proj_width2), .proj_height(proj_height2), .proj_move(proj_move2), .proj_hit_enemy(proj_hit_enemy2)
    );
    
    dual_shot(.clk(clk), .btnD(btnD), 
        .x_ref(x_ref), .y_ref(y_ref), .x_vect(x_vect), .y_vect(y_vect), .sq_width(sq_width), .sq_height(sq_height),

        .x_platform1(x_platform1), .y_platform1(y_platform1), .width_platform1(width_platform1), .height_platform1(height_platform1),
        .x_platform2(x_platform2), .y_platform2(y_platform2), .width_platform2(width_platform2), .height_platform2(height_platform2), .reset(reset),
        .x_var1(x_var31), .y_var1(y_var31), .x_var2(x_var32), .y_var2(y_var32), .proj_width(proj_width3), .proj_height(proj_height3), .proj_move(proj_move3), .proj_hit_enemy(proj_hit_enemy3)
    );
    
    
    parab_shot(.clk(clk), .btnD(btnD), 
        .x_ref(x_ref), .y_ref(y_ref), .x_vect(x_vect), .y_vect(y_vect), .sq_width(sq_width), .sq_height(sq_height),

        .x_platform1(x_platform1), .y_platform1(y_platform1), .width_platform1(width_platform1), .height_platform1(height_platform1),
        .x_platform2(x_platform2), .y_platform2(y_platform2), .width_platform2(width_platform2), .height_platform2(height_platform2), .reset(reset),
        .x_var(x_var4), .y_var(y_var4), .proj_width(proj_width4), .proj_height(proj_height4), .proj_move(proj_move4), .proj_hit_enemy(proj_hit_enemy4)
    );

    
    always @ (posedge clk) begin
        if (char_no == 0) begin
            x_varA = x_var31;
            y_varA = y_var31;
            x_varB = x_var32;
            y_varB = y_var32;
            proj_width = proj_width3;
            proj_height = proj_height3;
            proj_move = proj_move3;
            proj_hit_enemy = proj_hit_enemy3;
        end else if (char_no == 1) begin
            x_varA = x_var4;
            y_varA = y_var4;
            x_varB = 0;
            y_varB = 0;
            proj_width = proj_width4;
            proj_height = proj_height4;
            proj_move = proj_move4;
            proj_hit_enemy = proj_hit_enemy4;
        end else if (char_no == 2) begin
            x_varA = x_var2;
            y_varA = y_var2;
            x_varB = 0;
            y_varB = 0;
            proj_width = proj_width2;
            proj_height = proj_height2;
            proj_move = proj_move2;
            proj_hit_enemy = proj_hit_enemy2;
        end
    end
    

endmodule


module parab_shot(
    input clk, btnD,
    [6:0]x_ref, [6:0]y_ref, [6:0]x_vect, [6:0]y_vect, [6:0]sq_width, [6:0]sq_height, 
    
//    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, 
    [6:0]x_platform1, [6:0]y_platform1, [6:0]width_platform1, [6:0]height_platform1,
    [6:0]x_platform2, [6:0]y_platform2, [6:0]width_platform2, [6:0]height_platform2,
    reset,
    output reg [6:0]x_var, reg [6:0]y_var, reg [6:0]proj_width, reg[6:0]proj_height, reg proj_move, reg proj_hit_enemy
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
    reg [31:0]jump_time;
    reg [31:0]jumping;
    reg [31:0]falling;
    reg start;
    reg is_y_stat;
    
    initial begin
        x_increment = 0;
        y_increment = 0;
        proj_move = 0;
        proj_width = 8;
        proj_height = 3;
        
        is_y_stat = 0;
        jump_time = 12;
        jumping = 0;  
        falling = 0;
        start = 1;
    end
    
    
    assign launchpt_x_left = x_ref - proj_width;
    assign launchpt_x_right = x_ref + sq_width;
    assign launchpt_y = y_ref + ((sq_height - proj_height) / 2);
    
    wire fps_clock;
    flexy_clock get_fps_clock (.clk(clk), .m_value(1_249_999), .slow_clk(fps_clock));
    
    always @ (posedge fps_clock) begin
        if (reset) begin
            is_y_stat = 0;
            jump_time = 12;
            jumping = 0;  
            falling = 0;
            x_increment = 0;
            y_increment = 0;
            start = 0;
        end
        if (btnD && x_increment == 0) begin // should only run when button is pressed and projectile is not launched (not moving)
            x_increment = x_vect;
            jumping = jump_time;
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
            if (is_y_stat) begin
                falling = 0;
            end
        end
        
        if (jumping > 0) begin
            y_increment = 127 - jumping / 3 + 1;
        end else if (falling < 64) begin
            y_increment = 1 + falling / 3; 
        end
        jumping = (jumping > 0) ? jumping - 1 : 0; // count down to 0
        falling = (jumping > 0) ? 0 : falling + 1; // falling counter will count continuously, will reset when y is stationary 
        // REFINE THE COLLISIONS! 
        
        // check for collisions with boundaries of screen
        // check left bound of screen
        if (x_var == 0 && x_vect == 127) begin 
            x_increment = 0;
            y_increment = 0;
        // check right bound of screen
        end else if (x_var + sq_width - 1 == 95 && x_vect == 1) begin
            x_increment = 0;
            y_increment = 0;
        // check left bound of platform1
        end else if (x_var + sq_width == x_platform1 && (y_var + sq_height > y_platform1 && y_var < y_platform1 + height_platform1) && x_vect == 1) begin // left bound of red square
            x_increment = 0;
            y_increment = 0;
        // check right bound of platform1
        end else if (x_var == x_platform1 + width_platform1 && (y_var + sq_height > y_platform1 && y_var < y_platform1 + height_platform1) && x_vect == 127) begin // right bound of red square
            x_increment = 0;
            y_increment = 0;
        // check left bound of platform2
        end else if (x_var + sq_width == x_platform2 && (y_var + sq_height > y_platform2 && y_var < y_platform2 + height_platform2) && x_vect == 1) begin // left bound of red square
            x_increment = 0;
            y_increment = 0;
        // check right bound of platform2
        end else if (x_var == x_platform2 + width_platform2 && (y_var + sq_height > y_platform2 && y_var < y_platform2 + height_platform2) && x_vect == 127) begin // right bound of red square
            x_increment = 0;
            y_increment = 0;
        end
        
        // check upper bound of screen
        if ((y_var == 0 || y_var > 63) && (jumping > 0 && jumping < jump_time)) begin
            x_increment = 0;
            y_increment = 0;
        // check lower bound of screen
        end else if (y_var + sq_height - 1 == 63 && (falling >= 0 && falling < 64) && jumping == 0) begin
            x_increment = 0;
            y_increment = 0;
        // check upper bound of platform1
        end else if ((y_var + sq_height == y_platform1) && (x_var + sq_width > x_platform1 && x_var - 1 < x_platform1 + width_platform1) && (falling >= 0 && falling < 64) && jumping == 0) begin // upper bound of red square
            x_increment = 0;
            y_increment = 0;
        // check upper bound of platform2
        end else if ((y_var + sq_height == y_platform2) && (x_var + sq_width > x_platform2 && x_var - 1 < x_platform2 + width_platform2) && (falling >= 0 && falling < 64) && jumping == 0) begin // upper bound of red square
            x_increment = 0;
            y_increment = 0;
        // check lower bound of screen before collision to slow down player
        end else if (y_var + sq_height - 1 + y_increment >= 63 && (falling >= 0 && falling < 64) && jumping == 0) begin
            y_increment = 1; // falling counter
        // check upper bound of platform1 before collision to slow down player
        end else if ((y_var + sq_height + y_increment >= y_platform1 && y_var + sq_height < y_platform1 + height_platform1) && (x_var + sq_width > x_platform1 && x_var - 1 < x_platform1 + width_platform1) && (falling > 0 && falling < 64)) begin // upper bound of red square
            y_increment = 1; // falling counter resets
        // check upper bound of platform2 before collision to slow down player
        end else if ((y_var + sq_height + y_increment >= y_platform2 && y_var + sq_height < y_platform2 + height_platform2) && (x_var + sq_width > x_platform2 && x_var - 1 < x_platform2 + width_platform2) && (falling > 0 && falling < 64)) begin // upper bound of red square
            y_increment = 1; // falling counter resets
        // check lower bound of platform 1
        end else if ((y_var <= y_platform1 + height_platform1 - 1 && y_var > y_platform1) && (x_var + sq_width - 1 > x_platform1 && x_var - 1 < x_platform1 + width_platform1) && (jumping > 0 && jumping < jump_time)) begin // lower bound of red square
            x_increment = 0;
            y_increment = 0;
        // check lower bound of platform 2
        end else if ((y_var <= y_platform2 + height_platform2 - 1 && y_var > y_platform2) && (x_var + sq_width - 1 > x_platform2 && x_var - 1 < x_platform2 + width_platform2) && (jumping > 0 && jumping < jump_time)) begin // lower bound of red square
            x_increment = 0;
            y_increment = 0;
        end
        
        is_y_stat = (y_increment == 0) ? 1 : 0;
        proj_move = x_increment || y_increment ? 1 : 0;
        x_var = x_var + x_increment;
        y_var = y_var + y_increment;
        
    end
endmodule


module dual_shot(
    input clk, btnD,
    [6:0]x_ref, [6:0]y_ref, [6:0]x_vect, [6:0]y_vect, [6:0]sq_width, [6:0]sq_height, 
    
//    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, 
    [6:0]x_platform1, [6:0]y_platform1, [6:0]width_platform1, [6:0]height_platform1,
    [6:0]x_platform2, [6:0]y_platform2, [6:0]width_platform2, [6:0]height_platform2,
    reset,
    output reg [6:0]x_var1, reg [6:0]y_var1, reg [6:0]x_var2, reg [6:0]y_var2, reg [6:0]proj_width, reg[6:0]proj_height, reg proj_move, reg proj_hit_enemy
    );

    // shoot either left or right dependning on directin of movement of player (x_vect, y_vect)
    // starts from centre of player sprite 
    // shoots with constant velocity (constant x_increment)

    wire [6:0] launchpt_x_left;
    wire [6:0] launchpt_x_right;
    wire [6:0] launchpt_y;
    reg [6:0] launch_x; // starting pts for projectile launch
    reg [6:0] launch_y;
    reg [6:0] x_increment1;
    reg [6:0] x_increment2;
    reg [6:0] y_increment;
    
    initial begin
        x_increment1 = 0;
        x_increment2 = 0;
        y_increment = 0;
        proj_move = 0;
        proj_width = 3;
        proj_height = 3;
    end
    
    
    assign launchpt_x_left = x_ref - proj_width;
    assign launchpt_x_right = x_ref + sq_width;
    assign launchpt_y = y_ref + ((sq_height - proj_height) / 2);
    
    wire fps_clock;
    flexy_clock get_fps_clock (.clk(clk), .m_value(624_999), .slow_clk(fps_clock));
    
    always @ (posedge fps_clock) begin
        if (reset) begin
            x_increment1 = 0;
            x_increment2 = 0;
            y_increment = 0;
        end
        if (btnD && x_increment1 == 0 && x_increment2 == 0) begin // should only run when button is pressed and projectile is not launched (not moving)
//            x_increment = x_vect;
            x_increment1 = 1; // to increment right
            x_increment2 = 127; // to increment left
            x_var1 = launchpt_x_right; // starting point for projectile
            x_var2 = launchpt_x_left; // starting point for projectile
            y_var1 = launchpt_y;
            y_var2 = launchpt_y;
            
//        end else if (x_increment == 0) begin
//            if (x_vect == 1) begin // facing right, launch from right
//                x_var = launchpt_x_right; // starting point for projectile
//            end else if (x_vect == 127) begin // facing left, launch from left
//                x_var = launchpt_x_left; // starting point for projectile
//            end
//             y_var = launchpt_y;
        end else if (x_increment1 == 0 && x_increment2 == 0) begin
            x_increment1 = 0;
            x_increment2 = 0;
            x_var1 = x_ref + 1;
            y_var1 = y_ref;
            x_var2 = x_ref + 1;
            y_var2 = y_ref;
            proj_move = 0;
        end
        
        // check left bound of screen
        if (x_var2 == 0 && x_increment2 == 127) begin 
            x_increment2 = 0;
        // check right bound of screen
        end else if (x_var1 + proj_width - 1 == 95 && x_increment1 == 1) begin
            x_increment1 = 0;
        // check right bound of platform1
        end else if (x_var2 + proj_width == x_platform1 && (y_var2 + proj_height > y_platform1 && y_var2 < y_platform1 + height_platform1) && x_increment2 == 127) begin // left bound of red square
            x_increment2 = 0;
        // check left bound of platform1
        end else if (x_var1 == x_platform1 + width_platform1 && (y_var1 + proj_height > y_platform1 && y_var1 < y_platform1 + height_platform1) && x_increment1 == 1) begin // right bound of red square
            x_increment1 = 0;
        // check left bound of platform2
        end else if (x_var1 + proj_width == x_platform2 && (y_var1 + proj_height > y_platform2 && y_var1 < y_platform2 + height_platform2) && x_increment1 == 1) begin // left bound of red square
            x_increment1 = 0;
        // check right bound of platform2
        end else if (x_var2 == x_platform2 + width_platform2 && (y_var2 + proj_height > y_platform2 && y_var2 < y_platform2 + height_platform2) && x_increment2 == 127) begin // right bound of red square
            x_increment2 = 0;
        end
        
        proj_move = x_increment1 || x_increment2 ? 1 : 0;
        x_var1 = x_var1 + x_increment1;
        y_var1 = y_var1;
        x_var2 = x_var2 + x_increment2;
        y_var2 = y_var2;
        
    end
endmodule

module laser_shot2(
    input clk, btnD,
    [6:0]x_ref, [6:0]y_ref, [6:0]x_vect, [6:0]y_vect, [6:0]sq_width, [6:0]sq_height, 
    
//    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, 
    [6:0]x_platform1, [6:0]y_platform1, [6:0]width_platform1, [6:0]height_platform1,
    [6:0]x_platform2, [6:0]y_platform2, [6:0]width_platform2, [6:0]height_platform2,
    reset,
    output reg [6:0]x_var, reg [6:0]y_var, reg [6:0]proj_width, reg [6:0]proj_height, reg proj_move, reg proj_hit_enemy
    );
    

    reg [6:0] launchpt_x_left;
    reg [6:0] launchpt_x_right;
    reg [6:0] launchpt_y;
    
    reg [31:0] count;
    reg [6:0] direction;
    
    initial begin
        proj_move = 0;
        proj_width = 0;
        proj_height = 6;
        count = 0;
    end
    
    
//    assign launchpt_x_left = x_ref - proj_width;
//    assign launchpt_x_right = x_ref + sq_width;
//    assign launchpt_y = y_ref + ((sq_height - proj_height) / 2);
    
    wire fps_clock;
    flexy_clock get_fps_clock (.clk(clk), .m_value(624_999), .slow_clk(fps_clock));
    
    always @ (posedge fps_clock) begin
        if (reset) begin
            x_var = x_ref + sq_width / 2;
            y_var = y_ref;
            proj_move = 0;
        end
        
        launchpt_x_left = x_ref;
        launchpt_x_right = x_ref + sq_width;
        launchpt_y = y_ref + ((sq_height - proj_height) / 2);
        
        if (btnD && !proj_move && x_vect) begin
            direction = x_vect;
            if (x_vect == 1) begin // shoot right
                x_var = launchpt_x_right;
                y_var = launchpt_y;
                proj_width = 95 - x_var;
            end else if (x_vect == 127) begin
                x_var = 0;
                y_var = launchpt_y;
                proj_width = launchpt_x_left;
            end
            proj_move = 1; 
            count = 1;
        end else if (proj_move && count) begin
            count = (count == 20) ? 0 : count + 1;
            if (direction == 1) begin // shooting right
                x_var = launchpt_x_right;
            end else if (direction == 127) begin
                proj_width = launchpt_x_left;
            end
            y_var = launchpt_y;
        end else begin
            proj_move = 0;
            x_var = 0;
            y_var = 0;
            proj_width = 0;
            direction = 0;
//            count = (count == 500) ? 0 : count + 1;
//            if (count == 0) begin
//                proj_move = 0;
//            end
        end
        
    end

endmodule

module single_shot(
    input clk, btnD,
    [6:0]x_ref, [6:0]y_ref, [6:0]x_vect, [6:0]y_vect, [6:0]sq_width, [6:0]sq_height, 
    
//    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, 
    [6:0]x_platform1, [6:0]y_platform1, [6:0]width_platform1, [6:0]height_platform1,
    [6:0]x_platform2, [6:0]y_platform2, [6:0]width_platform2, [6:0]height_platform2,
    reset,
    output reg [6:0]x_var, reg [6:0]y_var, reg [6:0]proj_width, reg[6:0]proj_height, reg proj_move, reg proj_hit_enemy
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
        proj_width = 8;
        proj_height = 3;
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


//module laser_shot(
//    input clk, btnD,
//    [6:0]x_ref, [6:0]y_ref, [6:0]x_vect, [6:0]y_vect, [6:0]sq_width, [6:0]sq_height, 
    
////    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, 
//    [6:0]x_platform1, [6:0]y_platform1, [6:0]width_platform1, [6:0]height_platform1,
//    [6:0]x_platform2, [6:0]y_platform2, [6:0]width_platform2, [6:0]height_platform2,
//    reset,
//    output reg [6:0]x_var, reg [6:0]y_var, reg [6:0]proj_width, reg [6:0]proj_height, reg proj_move, reg proj_hit_enemy
//    );

//    // shoot either left or right dependning on directin of movement of player (x_vect, y_vect)
//    // starts from centre of player sprite 
//    // shoots with constant velocity (constant x_increment)

//    wire [6:0] launchpt_x_left;
//    wire [6:0] launchpt_x_right;
//    wire [6:0] launchpt_y;
//    reg [6:0] launch_x; // starting pts for projectile launch
//    reg [6:0] launch_y;
//    reg [6:0] x_increment;
//    reg [6:0] y_increment;
    
//    initial begin
//        x_increment = 0;
//        y_increment = 0;
//        proj_move = 0;
//        proj_width = 2;
//        proj_height = 2;
//    end
    
    
//    assign launchpt_x_left = x_ref - proj_width;
//    assign launchpt_x_right = x_ref + sq_width;
//    assign launchpt_y = y_ref + ((sq_height - proj_height) / 2);
    
//    wire fps_clock;
//    flexy_clock get_fps_clock (.clk(clk), .m_value(249_999), .slow_clk(fps_clock));
    
//    always @ (posedge fps_clock) begin
//        if (reset) begin
//            x_increment = 0;
//            y_increment = 0;
//            x_var = x_ref + sq_width / 2;
//            y_var = y_ref;
//            proj_move = 0;
//        end
//        if (btnD && x_increment == 0) begin // should only run when button is pressed and projectile is not launched (not moving)
//            x_increment = x_vect;
//            if (x_vect == 1) begin // facing right, launch from right
//                x_var = launchpt_x_right; // starting point for projectile
                
                
                
//            end else if (x_vect == 127) begin // facing left, launch from left
//                x_var = launchpt_x_left; // starting point for projectile
                
                
//            end
//            y_var = launchpt_y;
////        end else if (x_increment == 0) begin
////            if (x_vect == 1) begin // facing right, launch from right
////                x_var = launchpt_x_right; // starting point for projectile
////            end else if (x_vect == 127) begin // facing left, launch from left
////                x_var = launchpt_x_left; // starting point for projectile
////            end
////             y_var = launchpt_y;
//        end else if (x_increment == 0) begin
//            x_var = x_ref + sq_width / 2;
//            y_var = y_ref;
//            proj_move = 0;
//        end
        
//        // check left bound of screen
//        if (x_var == 0 && x_increment == 127) begin 
//            x_increment = 0;
//        // check right bound of screen
//        end else if (x_var + proj_width - 1 == 95 && x_increment == 1) begin
//            x_increment = 0;
//        // check left bound of platform1
//        end else if (x_var + proj_width == x_platform1 && (y_var + proj_height > y_platform1 && y_var < y_platform1 + height_platform1) && x_increment == 1) begin // left bound of red square
//            x_increment = 0;
//        // check right bound of platform1
//        end else if (x_var == x_platform1 + width_platform1 && (y_var + proj_height > y_platform1 && y_var < y_platform1 + height_platform1) && x_increment == 127) begin // right bound of red square
//            x_increment = 0;
//        // check left bound of platform2
//        end else if (x_var + proj_width == x_platform2 && (y_var + proj_height > y_platform2 && y_var < y_platform2 + height_platform2) && x_increment == 1) begin // left bound of red square
//            x_increment = 0;
//        // check right bound of platform2
//        end else if (x_var == x_platform2 + width_platform2 && (y_var + proj_height > y_platform2 && y_var < y_platform2 + height_platform2) && x_increment == 127) begin // right bound of red square
//            x_increment = 0;
//        end
        
        
//        if (x_increment == 127) begin
//            proj_move = 1;
//            proj_width = proj_width + 1;
//        end else if (x_increment == 1) begin
//            proj_move = 1;
//            proj_width = proj_width + 1;
//            x_increment = 0;
//        end else begin
//            proj_move = 0;
////            new_proj_width = proj_width;
//        end
//        x_var = x_var + x_increment;
//        y_var = y_var;
        
//    end
//endmodule
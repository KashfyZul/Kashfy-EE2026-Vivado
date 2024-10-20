`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2024 18:04:11
// Design Name: 
// Module Name: animate
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


module animate(
    input clk, [6:0]x_start, [6:0]y_start, [6:0]x_vect, [6:0]y_vect, [6:0]sq_width, [6:0]sq_height, 
    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, [6:0]x_obstacle, [6:0]y_obstacle,
    output reg [6:0]x_var, reg [6:0]y_var, reg [15:0]center_sq_colour, reg is_y_stat, reg [3:0]sprite_no
    );
    
    reg [6:0] x_increment;
    reg [6:0] y_increment;
    reg [31:0]jump_time;
    reg [31:0]jumping;
    reg [31:0]falling;
    
    initial begin
        x_var = x_start;
        y_var = y_start;
        // for some reason x_var and y_var cant take values of x_start and y_start... values must be written dirctly in this initial block
        center_sq_colour = 16'b11111_000000_00000;
        is_y_stat = 0;
        jump_time = 15;
        jumping = 0;  
        falling = 0;
    end
//    wire m_value;
//    m_value_calculator calc_m (.freq(fps), .m_value(m_value));
    wire fps_clock;
    flexy_clock get_fps_clock (.clk(clk), .m_value(1_249_999), .slow_clk(fps_clock));
   
   // s = ut + 1/2 at**2
   // 64 = 1t + 1/2 (0.33)t**2
   // t**2 + 3t - 192 = 0
   // t = 12.4 or 
   
   // assume time taken for y to fall through screen is 30 clock cycles
   
    always @ (posedge fps_clock) begin
        x_increment = x_vect;
        
        // y_vect == 127 -> start jumping counter 
        // jumping > 0 -> increment y by 127 - jumping / 3 + 1
        // jumping > 0 -> jumping -= 1
        // falling += 1 
        // 

        if (y_vect == 127) begin // start jump
            jumping = jump_time; // start rising counter (counts down)
//        end else if (y_vect == 1) begin // start fall
        end else if (is_y_stat) begin // if y is stationary, continually reset "falling" counter
            falling = 0; // reset falling counter (counts up)
        end else begin // if y is changing
            falling = falling;
        end
         
        if (jumping > 0) begin
            y_increment = 127 - jumping / 3 + 1;
        end else if (falling < 30) begin
            y_increment = 1 + falling / 3; 
        end else begin
            y_increment = y_vect;
        end
//        y_increment = (jumping > 0) ? 127 : y_vect;
        jumping = (jumping > 0) ? jumping - 1 : 0; // count down to 0
//        falling = (falling < jump_time) ? falling + 1: jump_time; // count up to jump_time
        falling = falling + 1; // falling counter will count continuously, will reset when y is stationary 
        // REFINE THE COLLISIONS! 
        
        // check for collisions with boundaries of screen
        if (x_var == 0 && x_vect == 127) begin // check position (x_var) as well as direvtion vector (x_vect)
            x_increment = 0;
        end else if (x_var + sq_width - 1 == 95 && x_vect == 1) begin
            x_increment = 0;    
        end else if (x_var + sq_width == x_obstacle && (y_var + sq_height > y_obstacle && y_var < y_obstacle + 5) && x_vect == 1) begin // left bound of red square
            x_increment = 0;
        end else if (x_var == x_obstacle + 25 && (y_var + sq_height > y_obstacle && y_var < y_obstacle + 5) && x_vect == 127) begin // right bound of red square
            x_increment = 0;
        end
        if ((y_var == 0 || y_var > 63) && (jumping > 0 && jumping < 15)) begin
            y_increment = 1;
        end else if (y_var + sq_height - 1 == 63 && (falling > 0 && falling < 30)) begin
            y_increment = 0;
        end else if ((y_var + sq_height == y_obstacle && y_var + sq_height < y_obstacle + 5) && (x_var + sq_width > x_obstacle && x_var - 1 < x_obstacle + 25) && (falling > 0 && falling < 30)) begin // upper bound of red square
            y_increment = 0;
        end else if (y_var + sq_height - 1 + y_increment >= 63 && (falling > 0 && falling < 30)) begin
            y_increment = 1; // falling counter 
        end else if ((y_var + sq_height + y_increment >= y_obstacle && y_var + sq_height < y_obstacle + 5) && (x_var + sq_width > x_obstacle && x_var - 1 < x_obstacle + 25) && (falling > 0 && falling < 30)) begin // upper bound of red square
            y_increment = 1; // falling counter resets
//        end else if (y_var <= y_obstacle + 5 - 1 && (x_var + sq_width - 1 > x_obstacle && x_var - 1 < x_obstacle + 25) && y_vect == 127) begin // lower bound of red square
        end else if ((y_var <= y_obstacle + 5 - 1 && y_var > y_obstacle) && (x_var + sq_width - 1 > x_obstacle && x_var - 1 < x_obstacle + 25) && (jumping > 0 && jumping < 15)) begin // lower bound of red square
            y_increment = 1;
        
        end
        
//         // check for collisions with boundaries of screen
//           if (x_var == 0 && x_vect == 127) begin // check position (x_var) as well as direvtion vector (x_vect)
//               x_increment = 0;
//           end else if (x_var + sq_width - 1 == 95 && x_vect == 1) begin
//               x_increment = 0;
//           end else if (x_var + sq_width - 1 == 35 && (y_var + sq_height > 20 && y_var < 20 + 25) && x_vect == 1) begin // left bound of red square
//               x_increment = 0;
//           end else if (x_var - 1 == 35 + 25 && (y_var + sq_height > 20 && y_var < 20 + 25) && x_vect == 127) begin // right bound of red square
//               x_increment = 0;
//           end
//           if (y_var == 0 && y_vect == 127) begin
//               y_increment = 0;
//           end else if (y_var + sq_height - 1 == 63 && y_vect == 1) begin
//               y_increment = 0;
//           end else if (y_var + sq_height == 20 && (x_var + sq_width - 1 > 35 && x_var < 35 + 25) && y_vect == 1) begin // upper bound of red square
//               y_increment = 0;
//           end else if (y_var == 20 + 25 && (x_var + sq_width - 1 > 35 && x_var < 35 + 25) && y_vect == 127) begin // lower bound of red square
//               y_increment = 0;
           
//           end
        
        if (x_increment == 0 && y_increment == 0) begin
//           center_sq_colour = stat_colour;
            sprite_no = 1; // stationary
//            center_sq_colour = 16'b11111_000000_00000; 
        end else if (x_increment != 0 && y_increment == 0) begin // lateral movement but no jumping/falling
//            center_sq_colour = move_colour;
            sprite_no = 2; // walking
//            center_sq_colour = 16'b11111_000111_00000;
        end else begin
//            center_sq_colour = jump_colour;
            sprite_no = 3; // jumping
        end
        is_y_stat = (y_increment == 0) ? 1 : 0; 
        x_var = x_var + x_increment;
        y_var = y_var + y_increment;
    end
    
endmodule

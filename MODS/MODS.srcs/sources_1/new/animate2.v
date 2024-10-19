`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2024 16:31:12
// Design Name: 
// Module Name: animate2
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


module animate2(
    input clk, [6:0]x_start, [6:0]y_start, [6:0]x_vect, [6:0]y_vect, [6:0]sq_width, [6:0]sq_height, 
    [31:0]fps, [15:0]stat_colour, [15:0]move_colour, [15:0]jump_colour, [6:0]x_obstacle, [6:0]y_obstacle,
    output reg [6:0]x_var, reg [6:0]y_var, reg [15:0]center_sq_colour, reg is_y_stat
    );
    
    reg [6:0] x_increment;
    reg [6:0] y_increment;
    wire [2:0] gravity = 4; // units is pixels per 100ms?
    reg [6:0] f_movement; // the desired clk frequency for jumping and falling
    initial begin
            x_var = x_start;
            y_var = y_start;
            center_sq_colour = 16'b11111_000000_00000;
            is_y_stat = 0;
            f_movement = 1;
        end
    
    // always block to receive input commands and manipulate movement
    always @ (posedge clk) begin
        x_increment = x_vect; // x_increment can be rewritten to 0 if an obstacle is detected
        y_increment = y_vect;
        
    end 
    
//    reg [31:0] t_fallen; // the no. of seconds that player has been risng/falling
//    reg [31:0] COUNT;
//    // always block to act as a timer for rising/falling, manipulate t_fallen
//    always @ (posedge clk) begin // every 10ns
//        COUNT <= (COUNT == 100_000) ? 0 : COUNT + 1; // increment t_fallen every 1ms
//        t_fallen <= (COUNT == 100_000) ? t_fallen + 1 : t_fallen; 
//    end
    
    wire every_10ms;
    flexy_clock get_10ms_clock (.clk(clk), .m_value(499_999), .slow_clk(every_10ms));
    always @ (posedge every_10ms) begin
        x_var = x_var + x_increment;
    end
    
    wire every_100ms;
    flexy_clock get_100ms_clock (.clk(clk), .m_value(4_999_999), .slow_clk(every_100ms));
    
    // update speed/frequency of y
    always @ (posedge every_100ms) begin        
        f_movement = (f_movement < 64) ? f_movement + 4 : f_movement; 
    end
    
    wire movement_clk;
    wire [31:0] m_value;  
    assign m_value = (100_000_000 / (2 * f_movement)) - 1;
    flexy_clock get_movement_clock (.clk(clk), .m_value(m_value), .slow_clk(movement_clk));
    // always block with a variable clock to write to the y position directly 
    always @ (posedge movement_clk) begin
        y_var = y_var + 1;
    end
    
    
endmodule

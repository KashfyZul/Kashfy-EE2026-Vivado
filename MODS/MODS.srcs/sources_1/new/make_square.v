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
    input clk, [6:0]x, [6:0]y, [3:0]sprite_no, [2:0]char_no, proj_move,
    [6:0]x_val, [6:0]y_val, [6:0]sq_width, [6:0]sq_height, [15:0]sq_colour,
    [6:0]x_val2, [6:0]y_val2, [6:0]sq_width2, [6:0]sq_height2, [15:0]sq_colour2, 
    [6:0]x_muff, [6:0]y_muff, [6:0]sq_width3, [6:0]sq_height3, [15:0]sq_colour3, 
    [6:0]x_proj1, [6:0]y_proj1, [6:0]x_proj2, [6:0]y_proj2, [6:0]proj_width, [6:0]proj_height, [15:0]proj_colour,
    [6:0]x_platform1, [6:0]y_platform1, [6:0]width_platform1, [6:0]height_platform1,
    [6:0]x_platform2, [6:0]y_platform2, [6:0]width_platform2, [6:0]height_platform2,
    [6:0]x_platform3, [6:0]y_platform3, [6:0]width_platform3, [6:0]height_platform3,
    [6:0]x_platform4, [6:0]y_platform4, [6:0]width_platform4, [6:0]height_platform4, 
    [15:0]platform_colour, [15:0]bg_colour,
    output reg [15:0]oled_data
    );
    
    wire [15:0]WHITE = 16'b11111_111111_11111;
    wire [15:0]RED = 16'b11111_000000_00000; 
    wire [15:0]YELLOW = 16'b11111_111111_00000;
    wire [15:0]BLUE = 16'b00000_000000_11111;
    wire [15:0]MAGENTA = 16'b11111_000000_11111;
    wire [15:0]sprite_1_colour;
    wire [15:0]sprite_2_colour;
    wire [15:0]sprite_3_colour;
    
    always @ (posedge clk) begin
        if (x >= x_val && x < x_val + sq_width && y >= y_val && y < y_val + sq_height) begin
            if (char_no == 0) begin

                oled_data = sprite_1_colour;
            end else if (char_no == 1) begin
                oled_data = sprite_2_colour;
            end else if (char_no == 2) begin
                oled_data = sprite_3_colour;
            end
        end else if (x >= x_val2 && x < x_val2 + sq_width2 && y >= y_val2 && y < y_val2 + sq_height2) begin
            oled_data = MAGENTA;
        end else if (x >= x_muff && x < x_muff + sq_width3 && y >= y_muff && y < y_muff + sq_height3) begin
            oled_data = YELLOW;
        end else if (x >= x_proj1 && x < x_proj1 + proj_width && y >= y_proj1 && y < y_proj1 + proj_height) begin
            if (char_no == 2) begin
                if ((y >= y_proj1 && y < y_proj1 + 1) || (y >= y_proj1 + 5 && y < y_proj1 + proj_height)) begin
                    oled_data = proj_move ? 16'b00111_000111_00000 : 0;
                end else if ((y >= y_proj1 + 1 && y < y_proj1 + 2) || (y >= y_proj1 + 4 && y < y_proj1 + 5)) begin
                    oled_data = proj_move ? 16'b11111_111111_00011 : 0;
                end else if ((y >= y_proj1 + 2 && y < y_proj1 + 4)) begin
                    oled_data = proj_move ? WHITE : 0;
                end
            end else begin
            oled_data = proj_move ? WHITE : 0;
            end
        end else if (x_proj2 && y_proj2 && x >= x_proj2 && x < x_proj2 + proj_width && y >= y_proj2 && y < y_proj2 + proj_height) begin
            oled_data = proj_move ? WHITE : 0;
        end else if (x >= x_platform1 && x < x_platform1 + width_platform1 && y >= y_platform1 && y < y_platform1 + height_platform1) begin
            oled_data = platform_colour;
        end else if (x >= x_platform2 && x < x_platform2 + width_platform2 && y >= y_platform2 && y < y_platform2 + height_platform2) begin
            oled_data = platform_colour;
        end else if (x >= x_platform3 && x < x_platform3 + width_platform3 && y >= y_platform3 && y < y_platform3 + height_platform3) begin
            oled_data = platform_colour;
        end else if (x >= x_platform4 && x < x_platform4 + width_platform4 && y >= y_platform4 && y < y_platform4 + height_platform4) begin
            oled_data = platform_colour;
        end else begin
            oled_data = bg_colour;
        end
    end 
        
    sprite_1 draw_sprite_1 (.x_oled(x), .y_oled(y), .x_ref(x_val), .y_ref(y_val), .sprite_width(sq_width), .sprite_height(sq_height), .colour(sprite_1_colour));
    sprite_2 draw_sprite_2 (.x_oled(x), .y_oled(y), .x_ref(x_val), .y_ref(y_val), .sprite_width(sq_width), .sprite_height(sq_height), .colour(sprite_2_colour));
    sprite_3 draw_sprite_3 (.x_oled(x), .y_oled(y), .x_ref(x_val), .y_ref(y_val), .sprite_width(sq_width), .sprite_height(sq_height), .colour(sprite_3_colour));
    
endmodule


module sprite_1(
    input [6:0]x_oled, [6:0]y_oled, [6:0]x_ref, [6:0]y_ref, [6:0]sprite_width, [6:0]sprite_height, 
    output reg [15:0]colour
    );
    
    wire [15:0]RED = 16'b11111_000000_00000; 
    wire [15:0]BLUE = 16'b00000_000000_11111;
    wire [15:0]GREEN = 16'b00000_111111_00000;
    
    always begin
        if (y_oled < y_ref + (sprite_height / 4)) begin
            colour = RED;
        end else if (y_oled >= y_ref + (sprite_height / 3) && y_oled < y_ref + ( 2 * (sprite_height / 3))) begin
            colour = GREEN;
        end else begin
            colour = BLUE;
        end
    end
    
endmodule

module sprite_2(
    input [6:0]x_oled, [6:0]y_oled, [6:0]x_ref, [6:0]y_ref, [6:0]sprite_width, [6:0]sprite_height, 
    output reg [15:0]colour
    );
    
    wire [15:0]YELLOW = 16'b11111_111111_00000; 
    wire [15:0]CYAN = 16'b00000_111111_11111;
    wire [15:0]MAGENTA = 16'b11111_000000_11111;
    
    always begin
        if (x_oled < x_ref + (sprite_width / 3)) begin
            colour = YELLOW;
        end else if (x_oled >= x_ref + (sprite_width / 3) && x_oled < x_ref + ( 2 * (sprite_width / 3))) begin
            colour = MAGENTA;
        end else begin
            colour = CYAN;
        end
    end
    
endmodule

module sprite_3(
    input [6:0]x_oled, [6:0]y_oled, [6:0]x_ref, [6:0]y_ref, [6:0]sprite_width, [6:0]sprite_height, 
    output reg [15:0]colour
    );
    
    wire [15:0]YELLOW = 16'b11111_111111_00000; 
    wire [15:0]CYAN = 16'b00000_111111_11111;
    wire [15:0]MAGENTA = 16'b11111_000000_11111;
    wire [15:0]RED = 16'b11111_000000_00000; 
    wire [15:0]YELLOW = 16'b11111_111111_00000;
    wire [15:0]BLUE = 16'b00000_000000_11111;
    
    wire [6:0]x_center = x_ref + (sprite_width / 2);
    wire [6:0]y_center = y_ref + (sprite_height / 2);
    
//    always begin
//        if ((x_oled - x_center)**2 + (y_oled - y_center)**2 == (sprite_width/2)**2) begin
//        if ((x_oled - x_center)*(x_oled - x_center) + (y_oled - y_center)*(y_oled - y_center) == (sprite_width/2)*(sprite_width/2)) begin
//            colour = MAGENTA;
//        end else if ((x_oled - x_center)**2 + (y_oled - y_center)**2 == (sprite_width/2 - 1)**2) begin
//            colour = CYAN;
//        end else if ((x_oled - x_center)**2 + (y_oled - y_center)**2 == (sprite_width/2 - 2)**2) begin
//            colour = MAGENTA;
//        end else if ((x_oled - x_center)**2 + (y_oled - y_center)**2 == (sprite_width/2 - 3)**2) begin
//            colour = CYAN;
//        end else begin
//            colour = 0;
//        end
//    end

    always begin
        if (x_oled < x_ref + (sprite_width / 4)) begin
            colour = RED;
        end else if (x_oled >= x_ref + (sprite_width / 4) && x_oled < x_ref + ( 2 * (sprite_width / 4))) begin
            colour = MAGENTA;
        end else if (x_oled >= x_ref + 2 * (sprite_width / 4) && x_oled < x_ref + ( 3 * (sprite_width / 4))) begin
            colour = BLUE;
        end else begin
            colour = CYAN;
        end
    end

    
endmodule


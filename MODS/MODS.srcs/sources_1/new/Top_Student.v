`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input clk, btnC, btnL, btnR, btnD, btnU, [4:0]sw,  
    output [7:0]JC, [2:0]led
    );
// 3.A3: oled_data initialisation
//reg [15:0] oled_data;
wire [15:0] oled_data;
reg [15:0] oled_data_reg;
// for x and y coordinates of OLED
wire [6:0] x;
wire [6:0] y;
wire [6:0] x_var;
wire [6:0] y_var;
wire [6:0] x_var2;
wire [6:0] y_var2;


wire frame_begin, sending_pixels, sample_pixels;
wire [12:0] pixel_index;
//reg [15:0] oled_colour;

initial begin
    oled_data_reg = 0;
//    oled_colour = 16'b00000_111111_00000;
end

//assign oled_data = oled_data_reg;

// convert pixel_index to coordinates
assign x = pixel_index % 96;
assign y = pixel_index / 96;

/*            
3.A2: instantiate clock divider module
    inputs: basys clock, m_value (the count limit of the clock)
    output: 6.25 MHz wire
*/
wire clk6p25m;
flexy_clock clk_6p25MHz (.clk(clk), .m_value(7), .slow_clk(clk6p25m));
wire clk25m;
flexy_clock clk_25MHz (.clk(clk), .m_value(7), .slow_clk(clk25m));

// use pushbuttons to choose direction
wire [6:0]x_vect;
wire [6:0]y_vect;
wire is_y_stat;
direction_mux choose_direction (.clk(clk), .btnC(btnC), .btnL(btnL), .btnR(btnR), .btnD(btnD), .btnU(btnU), .is_y_stat(is_y_stat), .x_vect(x_vect), .y_vect(y_vect));

// animate the movement of the square
wire [15:0]center_sq_colour;
wire [6:0] x_spawn = 48;
wire [6:0] y_spawn = 0;
wire [3:0] hitbox_size = 8; 
wire [3:0] sprite_no;
animate animate_hero (.clk(clk), 
        .x_start(48), .y_start(0), .x_vect(x_vect), .y_vect(y_vect), .sq_width(hitbox_size), .sq_height(hitbox_size),
//        .fps(20), .stat_colour(16'b11111_000000_00000), .move_colour(16'b11100_001111_00000), .jump_colour(16'b11111_000000_11000), 
        .x_platform1(30), .y_platform1(40), .width_platform1(25), .height_platform1(5),
        .x_platform2(55), .y_platform2(20), .width_platform2(25), .height_platform2(5), 
        .x_var(x_var), .y_var(y_var), .center_sq_colour(center_sq_colour), .is_y_stat(is_y_stat), .sprite_no(sprite_no));

// track damage of player (3 lives)
wire hit;
hero_damage(.clk(clk), .hit(hit), .LED(led));

// animate the enemy (for test)
enimate animate_enemy (.clk(clk), 
        .x_start(80), .y_start(0), .x_vect(127), .y_vect(1), .sq_width(hitbox_size), .sq_height(hitbox_size),
        .x_hero(x_var), .y_hero(y_var), .width_hero(8), .height_hero(8),
//        .fps(20), .stat_colour(16'b11111_000000_00000), .move_colour(16'b11100_001111_00000), .jump_colour(16'b11111_000000_11000), 
        .x_platform1(30), .y_platform1(40), .width_platform1(25), .height_platform1(5),
        .x_platform2(55), .y_platform2(20), .width_platform2(25), .height_platform2(5), 
        .x_var(x_var2), .y_var(y_var2), .center_sq_colour(center_sq_colour), .hit(hit));

// draw the squares
make_square draw_sq (.clk(clk), .x(x), .y(y), .sprite_no(sprite_no),
        .x_val(x_var), .y_val(y_var), .sq_width(8),.sq_height(8), .sq_colour(center_sq_colour),
        .x_val2(x_var2), .y_val2(y_var2), .sq_width2(8),.sq_height2(8), .sq_colour2(center_sq_colour),
        .x_platform1(30), .y_platform1(40), .width_platform1(25), .height_platform1(5),
        .x_platform2(55), .y_platform2(20), .width_platform2(25), .height_platform2(5), 
        .platform_colour(16'b00000_111111_00000), .bg_colour(0), .oled_data(oled_data));

// 3.A1: instantiate Oled_Display
Oled_Display Q3A1 (.clk(clk6p25m), .reset(0), .frame_begin(frame_begin), .sending_pixels(sending_pixels),
  .sample_pixel(sample_pixels) , .pixel_index(pixel_index), .pixel_data(oled_data), .cs(JC[0]), .sdin(JC[1]), 
  .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]), .pmoden(JC[7]));

//wire left;
//wire right;
//wire middle;
//wire new_event;
//wire [11:0]xpos, ypos;
//wire [3:0]zpos;
//wire ps2_clk;
//wire ps2_data;

//assign led[15] = left;
//assign led[14] = middle;
//assign led[13] = right;

//// Mouse code
//MouseCtl meowse (.clk(clk), .rst(0), .xpos(xpos), .ypos(ypos), .zpos(zpos), 
//.left(left), .middle(middle), .right(right), .new_event(new_event), .value(0), 
//.setx(0), .sety(0), .setmax_x(0), .setmax_y(0), .ps2_clk(), .ps2_data());



endmodule
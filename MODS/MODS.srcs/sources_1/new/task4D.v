`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2024 15:21:11
// Design Name: 
// Module Name: task4D
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


module task4D(
    input clk, btnC, btnL, btnR, btnD, btnU, [4:0]sw,  
    output [7:0]JC
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

// use pushbuttons to choose direction
wire [6:0]x_vect;
wire [6:0]y_vect;
direction_mux choose_direction (.clk(clk), .btnC(btnC), .btnL(btnL), .btnR(btnR), .btnD(btnD), .btnU(btnU), .x_vect(x_vect), .y_vect(y_vect));

// animate the movement of the square
wire [15:0]center_sq_colour;
animate(.clk(clk), .x_start(0), .y_start(0), .x_vect(x_vect), .y_vect(y_vect), .sq_width(7), .sq_height(7), .fps(20), 
        .stat_colour(16'b11111_000000_00000), .move_colour(16'b11100_001111_00000), .x_var(x_var), .y_var(y_var), .center_sq_colour(center_sq_colour));

// draw the squares
make_square draw_sq (.clk(clk), .x(x), .y(y), 
        .x_val(x_var), .y_val(y_var), .sq_width(7),.sq_height(7), .sq_colour(16'b00000_111111_00000),
        .x_val2(36), .y_val2(20), .sq_width2(25),.sq_height2(25), .sq_colour2(center_sq_colour), 
        .bg_colour(0), .oled_data(oled_data));


// 3.A1: instantiate Oled_Display
Oled_Display Q3A1 (.clk(clk6p25m), .reset(0), .frame_begin(frame_begin), .sending_pixels(sending_pixels),
  .sample_pixel(sample_pixels) , .pixel_index(pixel_index), .pixel_data(oled_data), .cs(JC[0]), .sdin(JC[1]), 
  .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]), .pmoden(JC[7]));

endmodule
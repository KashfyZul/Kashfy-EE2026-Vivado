`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2024 02:34:08 AM
// Design Name: 
// Module Name: seven_seg_display
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


module seven_seg_display2(
    input [31:0] n,
    input CLOCK,
    output reg [3:0] an,
    output reg [6:0] seg
    
    );
    
    parameter ZERO = 7'b1000000;
    parameter ONE = 7'b1111001;
    parameter TWO = 7'b0100100;
    parameter THREE = 7'b0110000;
    parameter FOUR = 7'b0011001;
    parameter FIVE = 7'b0010010;
    parameter SIX = 7'b0000010;
    parameter SEVEN = 7'b1111000;
    parameter EIGHT = 7'b0000000;
    parameter NINE = 7'b0010000;

    
    wire [3:0] ones, tens, hundreds, thousands;
    assign ones = n % 10;
    assign tens = (n / 10) % 10;
    assign hundreds = (n / 100) % 10;
    assign thousands = (n / 1000) % 10;
    
    reg [1:0] n_select = 0;
    
    wire clk1000;
    flexy_clock clock1k (.clk(CLOCK), .m_value(49_999), .slow_clk(clk1000));
    
    always @ (posedge clk1000)
    begin
        n_select <= n_select + 1; // changes number to display every 1ms

        case (n_select)
            0: begin
                an <= 4'b1110;
                case (ones)
                    1: seg <= ONE;
                    2: seg <= TWO;
                    3: seg <= THREE;
                    4: seg <= FOUR;
                    5: seg <= FIVE;
                    6: seg <= SIX;
                    7: seg <= SEVEN;
                    8: seg <= EIGHT;
                    9: seg <= NINE;
                    0: seg <= ZERO;
                endcase
            end
            1: begin
                an <= 4'b1101;
                case (tens)
                    1: seg <= ONE;
                    2: seg <= TWO;
                    3: seg <= THREE;
                    4: seg <= FOUR;
                    5: seg <= FIVE;
                    6: seg <= SIX;
                    7: seg <= SEVEN;
                    8: seg <= EIGHT;
                    9: seg <= NINE;
                    0: seg <= ZERO;
                endcase            
            end
            2: begin
                an <= 4'b1011;
                case (hundreds)
                    1: seg <= ONE;
                    2: seg <= TWO;
                    3: seg <= THREE;
                    4: seg <= FOUR;
                    5: seg <= FIVE;
                    6: seg <= SIX;
                    7: seg <= SEVEN;
                    8: seg <= EIGHT;
                    9: seg <= NINE;
                    0: seg <= ZERO;
                endcase
            end
            3: begin
                an <= 4'b0111;
                case (thousands)
                    1: seg <= ONE;
                    2: seg <= TWO;
                    3: seg <= THREE;
                    4: seg <= FOUR;
                    5: seg <= FIVE;
                    6: seg <= SIX;
                    7: seg <= SEVEN;
                    8: seg <= EIGHT;
                    9: seg <= NINE;
                    0: seg <= ZERO;
                endcase
            end
        endcase
    end 
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2024 16:42:27
// Design Name: 
// Module Name: touch_muff
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


module touch_muff(
    input clk, hit_muff, start_muff, reset,
    output reg [2:0]char_no
    );
    
    wire damage_clk;
    flexy_clock(.clk(clk), .m_value(49_999), .slow_clk(damage_clk)); // every 1ms
    
    reg [31:0]muff_count;
    reg [2:0]random_counter; // count from 0 to 4
    
    initial begin
        random_counter = 0;
        char_no = start_muff;
    end
    
    always @ (posedge damage_clk) begin
         
        if (reset) begin
            muff_count = 0;
        end
        if (hit_muff) begin
            muff_count = muff_count + 1;
            char_no = random_counter;            
        end
        random_counter = (random_counter == 2) ? 0: random_counter + 1; // currently counts from 0 to 2 just to test with 3 sprites
    end
    
endmodule

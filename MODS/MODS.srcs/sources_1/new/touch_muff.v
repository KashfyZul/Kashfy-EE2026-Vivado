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
    output reg [2:0]char_no,
    output reg [31:0]muff_count
    );
    
    wire damage_clk;
    flexy_clock(.clk(clk), .m_value(1_249_999), .slow_clk(damage_clk)); // every 1ms
    
    localparam N = 5; // number of characters    
    wire [11:0]random_counter; // count from 0 to 4
    LFSR_random rng (.CLOCK(clk), .rst(reset), .n(N), .random(random_counter));
    
    initial begin
        muff_count = 0;
    end
    
    always @ (posedge damage_clk) begin
         
        if (reset) begin
            muff_count = 0;
        end
        
        if (hit_muff) begin            
            muff_count = muff_count + 1;
            char_no = ((char_no + (random_counter % (N - 1))) + 1) % N;        
        end
    end
    
endmodule

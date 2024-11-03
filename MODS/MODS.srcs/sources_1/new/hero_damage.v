`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2024 23:35:56
// Design Name: 
// Module Name: hero_damage
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


module hero_damage(
    input clk, hit, reset,
    output reg [2:0]LED
    );
    
    reg [31:0]counter;
    
    initial begin
        LED = 3'b111;
        counter = 0;
    end
    
    wire damage_clk;
    flexy_clock(.clk(clk), .m_value(49_999), .slow_clk(damage_clk)); // every 1ms
    wire fps_clock;
    flexy_clock get_fps_clock (.clk(clk), .m_value(1_249_999), .slow_clk(fps_clock));
    
    always @ (posedge fps_clock) begin
        if (reset) begin
            LED = 3'b111;
            counter = 0;
        end
    
        if (counter == 0) begin
            if (hit) begin
                LED = LED >> 1;
                counter = counter + 1;
            end
        end else if (counter == 40) begin // should have 1 second cooldown
            counter = 0;
        end else begin
            counter = counter + 1;
        end
    end
    
endmodule

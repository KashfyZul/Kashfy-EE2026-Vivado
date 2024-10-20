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
    input clk, hit, 
    output reg [2:0]LED
    );
    
    initial begin
        LED = 3'b111;
    end
    
    wire damage_clk;
    flexy_clock(.clk(clk), .m_value(49_999_999), .slow_clk(damage_clk));
    
    always @ (posedge damage_clk) begin
        if (hit) begin
            LED = LED >> 1;
        end
    end
    
endmodule

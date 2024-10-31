`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2024 14:56:43
// Design Name: 
// Module Name: subtask_B
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


module subtask_B(
    input clk, sw15, btnR,
    output reg [3:0]an, reg [7:0]seg
    );
    
    reg [1:0]direction;
    reg btn_pressed;
    wire [3:0]move_right_an;
    wire [7:0]move_right_seg;
    wire [3:0]move_left_an;
    wire [7:0]move_left_seg;
    wire move_left;
    
    initial begin
        direction = 0;
        btn_pressed = 0;
        an = 4'b1011;
        seg = 8'b11111110;
    end
    
    move_right(clk, direction, an, seg, 
                move_left, move_right_an, move_right_seg);
    
    
    always @ (posedge clk) begin
        if (btnR) begin
            btn_pressed = 1;
        end else if (btn_pressed && !btnR) begin // btnR is released
            direction = 1; // move to the right
        end else if (direction == 0) begin // not moving
            an = 4'b1011;
            seg = 8'b11111110;
        end else if (direction == 1) begin // moving to the right
            an = move_right_an;
            seg = move_right_seg;
        end else if (direction == 2) begin // moving to the left
            an = move_left_an;
            seg = move_left_seg;
        end
    end
    
endmodule

module move_right(
    input clk, [1:0]direction, [3:0]an, [7:0]seg, // treat direction like a "reset"
    output reg move_left, reg [3:0]move_right_an, reg [7:0]move_right_seg
    );
    
    wire move_right_clk;
    flexy_clock move_right (clk, 44_999_999, move_right_clk); // 1ms clock
    
    initial begin
        move_right_an = an;
        move_right_seg = seg;
        move_left = 0;
    end
        
    always @ (posedge move_right_clk) begin
        // anode 4
        if (direction == 1) begin
            move_right_an = 4'b0111;
            move_right_seg = 8'b11110111;
            move_left = 0;
        end
        if (move_right_an == 4'b0111) begin
            if (move_right_seg == 8'b01111111) begin
                move_right_seg = 8'b11110111;
            end else if (move_right_seg == 8'b11011111) begin
                move_right_seg = 8'b11111110;
            end else if (move_right_seg == 8'b11111110) begin
                move_right_an = 4'b1011;
                move_right_seg = 8'b11111110;
            end else begin
                move_right_seg = move_right_seg << 1;
                move_right_seg = move_right_seg + 1;
            end
        // anode 3
        end else if (move_right_an == 4'b1011) begin
            move_right_an = 4'b1101;
            move_right_seg = 8'b11111110;
        // anode 2
        end else if (move_right_an == 4'b1101) begin
            if (move_right_seg == 8'b11111011) begin
                move_right_an = 4'b1110;
                move_right_seg = 8'b11101111;
            end else begin
                move_right_seg = move_right_seg << 1;
                move_right_seg = move_right_seg + 1;
            end
        // anode 1
        end else if (move_right_an == 4'b1110) begin
            if (move_right_seg == 8'b11011111) begin
                move_right_seg = 8'b11111110;
            end else if (move_right_seg == 8'b11111011) begin
                move_right_seg = 8'b01111111;
            end else if (move_right_seg == 8'b01111111) begin
                // need to move left alr
                move_left = 1;
            end else begin
                move_right_seg = move_right_seg << 1;
                move_right_seg = move_right_seg + 1;
            end
        
        end
    end

endmodule

//module move_left(
//    input clk, [1:0]direction, [3:0]an, [7:0]seg, // treat direction like a "reset"
//    output reg move_right, reg [3:0]move_left_an, reg [7:0]move_left_seg
//    );
    
//    wire move_left_clk;
//    flexy_clock move_left (clk, 44_999_999, move_left_clk); // 1ms clock
    
//    initial begin
//        move_left_an = an;
//        move_left_seg = seg;
//        move_right = 0;
//    end
        
//    always @ (posedge move_left_clk) begin
//        // anode 4
//        if (direction == 1) begin
//            move_left_an = 4'b0111;
//            move_left_seg = 8'b11110111;
//            move_right = 0;
//        end
//        if (move_left_an == 4'b0111) begin
//            if (move_left_seg == 8'b01111111) begin
//                move_left_seg = 8'b11110111;
//            end else if (move_left_seg == 8'b11011111) begin
//                move_left_seg = 8'b11111110;
//            end else if (move_left_seg == 8'b11111110) begin
//                move_left_an = 4'b1011;
//                move_left_seg = 8'b11111110;
//            end else begin
//                move_left_seg = move_left_seg << 1;
//                move_left_seg = move_left_seg + 1;
//            end
//        // anode 3
//        end else if (move_left_an == 4'b1011) begin
//            move_left_an = 4'b1101;
//            move_left_seg = 8'b11111110;
//        // anode 2
//        end else if (move_left_an == 4'b1101) begin
//            if (move_left_seg == 8'b11111011) begin
//                move_left_an = 4'b1110;
//                move_left_seg = 8'b11101111;
//            end else begin
//                move_left_seg = move_left_seg << 1;
//                move_left_seg = move_left_seg + 1;
//            end
//        // anode 1
//        end else if (move_left_an == 4'b1110) begin
//            if (move_left_seg == 8'b11011111) begin
//                move_left_seg = 8'b11111110;
//            end else if (move_left_seg == 8'b11111011) begin
//                move_right_seg = 8'b01111111;
//            end else if (move_right_seg == 8'b01111111) begin
//                // need to move left alr
//                move_left = 1;
//            end else begin
//                move_right_seg = move_right_seg << 1;
//                move_right_seg = move_right_seg + 1;
//            end
        
//        end
//    end

//endmodule
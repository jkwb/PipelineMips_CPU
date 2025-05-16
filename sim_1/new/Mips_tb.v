`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 22:55:10
// Design Name: 
// Module Name: Mips_tb
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


module Mips_tb();
    wire [3:0] an1, an2;
    wire [7:0] seg1, seg2;
    reg clk,rst;
    reg [4:0] user_add;
    
    PipelineMips pipeline_mips(
        .an1(an1),
        .an2(an2),
        .seg1(seg1),
        .seg2(seg2),
        .clk(clk),
        .rst(rst),
        .user_add(user_add)
    );
    
    initial begin
        clk = 0;
    end
    initial begin
        rst = 0;
        #40
        rst = 1;
        #40
        rst = 0;
    end
    always #20 clk = ~clk;

endmodule

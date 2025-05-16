`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 19:12:51
// Design Name: 
// Module Name: Clk_div
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


module Clk_div(
    input clk,
    output reg clk_div1,
    output reg clk_div2
    );
    parameter n1 = 26'd1, n2 = 25'd100000;
    reg [25:0] count1 = 26'd0;
    reg [24:0] count2 = 25'd0;
    initial begin
        clk_div1 = 0;
        clk_div2 = 0;
    end
    always@(posedge clk)begin
        if(count1 == n1-1) begin
            count1 <= 0;
            clk_div1 <= ~clk_div1;
        end
        else 
            count1 <= count1 + 1;
    end

    always@(posedge clk)begin
        if(count2 == n2-1) begin
            count2 <= 0;
            clk_div2 <= ~clk_div2;
        end
        else 
            count2 <= count2 + 1;
    end
endmodule

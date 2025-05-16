`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 14:23:58
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input en,
    input [31:0] PC,
    output reg [31:0] PCF
    );
    initial PCF = 32'b0;
    always@(posedge clk)begin
        if(~en) PCF <= PC;
    end
endmodule

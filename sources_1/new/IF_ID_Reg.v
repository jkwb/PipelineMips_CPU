`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 14:28:46
// Design Name: 
// Module Name: IF_ID_Reg
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


module IF_ID_Reg(
    input clk,
    input en,
    input clr,
    input [31:0] InstrF,
    input [31:0] PCPlus4F,
    output reg [31:0] InstrD,
    output reg [31:0] PCPlus4D
    );
    
    initial begin
        InstrD = 32'b0;
        PCPlus4D = 32'b0;
    end
    
    always@(posedge clk)begin
        if(~en)begin
            if(clr)begin
                InstrD <= 32'b0;
                PCPlus4D <= 32'b0;
            end
            else begin
                InstrD <= InstrF;
                PCPlus4D <= PCPlus4F;
            end
        end
    end
endmodule

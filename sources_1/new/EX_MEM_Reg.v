`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 16:07:16
// Design Name: 
// Module Name: EX_MEM_Reg
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


module EX_MEM_Reg(
    input clk,
    input RegWriteE,
    input MemtoRegE,
    input MemWriteE,
    input [31:0] ALUOutE,
    input [31:0] WriteDataE,
    input [4:0] WriteRegE,
    output reg RegWriteM,
    output reg MemtoRegM,
    output reg MemWriteM,
    output reg [31:0] ALUOutM,
    output reg [31:0] WriteDataM,
    output reg [4:0] WriteRegM
    );
    
    initial begin
        RegWriteM = 0;
        MemtoRegM = 0;
        MemWriteM = 0;
        ALUOutM = 32'b0;
        WriteDataM = 32'b0;
        WriteRegM  = 5'b0;
    end
    
    always@(posedge clk) begin
        RegWriteM <= RegWriteE;
        MemtoRegM <= MemtoRegE;
        MemWriteM <= MemWriteE;
        ALUOutM <= ALUOutE;
        WriteDataM <= WriteDataE;
        WriteRegM <= WriteRegE;
    end
endmodule

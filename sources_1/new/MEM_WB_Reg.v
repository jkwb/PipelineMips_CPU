`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 16:16:15
// Design Name: 
// Module Name: MEM_WB_Reg
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


module MEM_WB_Reg(
    input clk,
    input RegWriteM,
    input MemtoRegM,
    input [31:0] ReadDataM,  //
    input [31:0] ALUOutM,
    input [4:0] WriteRegM,
    output reg RegWriteW,
    output reg MemtoRegW,
    output reg [31:0] ReadDataW, //
    output reg [31:0] ALUOutW,
    output reg [4:0] WriteRegW
    );
    
    initial begin
        RegWriteW = 0;
        MemtoRegW = 0;
        ReadDataW = 32'b0; //
        ALUOutW = 32'b0;
        WriteRegW = 5'b0;
    end
    
    always@(posedge clk)begin
        RegWriteW <= RegWriteM;
        MemtoRegW <= MemtoRegM;
        ReadDataW <= ReadDataM; //
        ALUOutW <= ALUOutM;
        WriteRegW <= WriteRegM;
    end
endmodule

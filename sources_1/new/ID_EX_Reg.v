`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 15:25:24
// Design Name: 
// Module Name: ID_EX_Reg
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


module ID_EX_Reg(
    input clk,
    input clr,
    input RegWriteD,
    input MemtoRegD,
    input MemWriteD,
    input [3:0] ALUControlD,
    input ALUSrcD,
    input RegDstD,
    input [31:0] RegOut1D,
    input [31:0] RegOut2D,
    input [4:0] RsD,
    input [4:0] RtD,
    input [4:0] RdD,
    input [31:0] ExtendImmD,
    output reg RegWriteE,
    output reg MemtoRegE,
    output reg MemWriteE,
    output reg [3:0] ALUControlE,
    output reg ALUSrcE,
    output reg RegDstE,
    output reg [31:0] RegOut1E,
    output reg [31:0] RegOut2E,
    output reg [4:0] RsE,
    output reg [4:0] RtE,
    output reg [4:0] RdE,
    output reg [31:0] ExtendImmE
    );
    
    initial begin
        RegWriteE = 0;
        MemtoRegE = 0;
        MemWriteE = 0;
        ALUControlE = 4'b0;
        ALUSrcE = 0;
        RegDstE = 0;
        RegOut1E = 32'b0;
        RegOut2E = 32'b0;
        RsE = 5'b0;
        RtE = 5'b0;
        RdE = 5'b0;
        ExtendImmE = 32'b0;   
    end
    
    always@(posedge clk)begin
        if(clr) begin
            RegWriteE <= 1'b0;
            MemtoRegE <= 1'b0;
            MemWriteE <= 1'b0;
            ALUControlE <= 4'b0;
            ALUSrcE <= 1'b0;
            RegDstE <= 1'b0;
            RegOut1E <= 32'b0;
            RegOut2E <= 32'b0;
            RsE <= 5'b0;
            RtE <= 5'b0;
            RdE <= 5'b0;
            ExtendImmE <= 32'b0;
        end
        else begin
            RegWriteE <= RegWriteD;
            MemtoRegE <= MemtoRegD;
            MemWriteE <= MemWriteD;
            ALUControlE <= ALUControlD;
            ALUSrcE <= ALUSrcD;
            RegDstE <= RegDstD;
            RegOut1E <= RegOut1D;
            RegOut2E <= RegOut2D;
            RsE <= RsD;
            RtE <= RtD;
            RdE <= RdD;
            ExtendImmE <= ExtendImmD;
        end
    end
endmodule

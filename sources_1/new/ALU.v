`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 15:45:40
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] SrcAE,
    input [31:0] SrcBE,
    input [3:0] ALUControlE,
    output reg [31:0] ALUOutE
    );
    
    always@(*)begin
        case(ALUControlE)
            4'b0000: ALUOutE = SrcAE + SrcBE;
            4'b0001: ALUOutE = SrcAE - SrcBE;
            4'b0010: ALUOutE = SrcAE & SrcBE;
            4'b0011: ALUOutE = SrcAE | SrcBE;
            4'b0100: ALUOutE = SrcAE ^ SrcBE;
            4'b0101: ALUOutE = ~(SrcAE | SrcBE);
            4'b0110: ALUOutE = $signed(SrcAE) < $signed(SrcBE) ? 32'b1 : 32'b0;
            4'b0111: ALUOutE = SrcAE << SrcBE;
            4'b1000: ALUOutE = SrcAE >> SrcBE;
            4'b1001: ALUOutE = $signed(SrcAE) >>> SrcBE;
            default: ALUOutE = 32'b0;
        endcase
    end
endmodule

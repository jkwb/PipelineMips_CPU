`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 17:09:07
// Design Name: 
// Module Name: ImmExtend
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


module ImmExtend(
    input [15:0] imm,
    input [5:0] Op,
    input [5:0] Funct,
    output reg [31:0] ExtendImmD
    );
    
    always@(*)begin
        case(Op)
            6'b001100: ExtendImmD = {{16{1'b0}},imm[15:0]};
            6'b001101: ExtendImmD = {{16{1'b0}},imm[15:0]};
            6'b001110: ExtendImmD = {{16{1'b0}},imm[15:0]};
            default: ExtendImmD = {{16{imm[15]}},imm[15:0]};
        endcase
    end
endmodule

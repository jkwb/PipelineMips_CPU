`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 13:53:01
// Design Name: 
// Module Name: RegFiles
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


module RegFiles(
    input clk,
    input rst,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [4:0] user_add,
    input [31:0] WD3,
    input WE3,
    output [31:0] RD1,
    output [31:0] RD2,
    output [31:0] user_dout
    );
    
    reg [31:0] regfile [31:1];
    integer i;
    always@(negedge clk or posedge rst)begin
        if(rst) for(i = 1; i <= 31; i = i+1) regfile[i] <= 32'b0;
        else if(WE3 && A3 != 5'b0) regfile[A3] = WD3;
    end
    
    assign RD1 = (A1 != 5'b0) ? regfile[A1] : 32'b0; 
    assign RD2 = (A2 != 5'b0) ? regfile[A2] : 32'b0; 
    assign user_dout = (user_add != 5'b0) ? regfile[user_add] : 32'b0;
endmodule

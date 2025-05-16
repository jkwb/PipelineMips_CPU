`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 14:04:54
// Design Name: 
// Module Name: DataRam
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


module DataRam(
    input clk,
    input [31:0] A,
    input [31:0] WD,
    input WE,
    output [31:0] RD
    );
    
    reg [31:0] ram_cell [4095:0];
    wire add_valid = (A[31:14] == 18'h0) ? 1 :0;
    wire [11:0] addr = A[13:2];
    initial begin
        //ram_cell[0] = ......
        //
        ram_cell[0] = 32'd1;
        ram_cell[1] = 32'd1;
        ram_cell[2] = 32'd0;
        ram_cell[3] = 32'd0;
        ram_cell[4] = 32'd0;
        ram_cell[5] = 32'd0;
        ram_cell[6] = 32'd0;
        ram_cell[7] = 32'd0;
    end
    always@(posedge clk)begin
        if(WE && add_valid) ram_cell[addr] = WD;
    end
    
    assign RD = add_valid ? ram_cell[addr] : 0;
endmodule

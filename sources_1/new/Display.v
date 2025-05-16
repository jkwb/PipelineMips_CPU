`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 18:59:02
// Design Name: 
// Module Name: Display
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


module Display(
    input clk,
    input [15:0] num,
    output reg [7:0] seg,
    output reg [3:0] an
    );
    reg [1:0] state;
    reg [3:0] bcd;
    initial state <= 2'b00;
    always@(posedge clk)begin
        state <= state + 1;
    end
    
    always@(*)begin
        case(state)
            2'b00: begin
                an = 4'b0001;
                bcd = num[3:0]; 
            end
            2'b01:begin
                an = 4'b0010;
                bcd = num[7:4];
            end
            2'b10:begin
                an = 4'b0100;
                bcd = num[11:8];
            end
            2'b11:begin
                an = 4'b1000;
                bcd = num[15:12];
            end
        endcase 
    end
    
    always@(*)begin
        case(bcd)
            4'h0: seg = 8'hfc;
            4'h1: seg = 8'h60;
            4'h2: seg = 8'hda;
            4'h3: seg = 8'hf2;
            4'h4: seg = 8'h66;
            4'h5: seg = 8'hb6;
            4'h6: seg = 8'hbe;
            4'h7: seg = 8'he0;
            4'h8: seg = 8'hfe;
            4'h9: seg = 8'hf6;
            4'ha: seg = 8'hee;
            4'hb: seg = 8'h3e;
            4'hc: seg = 8'h9c;
            4'hd: seg = 8'h7a;
            4'he: seg = 8'h9e;
            4'hf: seg = 8'h8e;
            default: seg = 8'h00;      //°Ë¶ÎÈ«Ï¨Ãð
        endcase
    end
endmodule

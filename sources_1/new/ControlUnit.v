`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 14:34:36
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input [5:0] Op,
    input [5:0] Funct,
    output reg RegWriteD,
    output reg MemtoRegD,
    output reg MemWriteD,
    output reg [3:0] ALUControlD,
    output reg ALUSrcD,
    output reg RegDstD,
    output reg Jump,
    output reg BranchD
    );
    
    always@(*) begin
        case(Op) 
            /* R型指令 */
            6'b000000:
                case(Funct)
                    /* add */
                    6'b100000: begin
                        RegWriteD = 1;
                        MemtoRegD = 0;
                        MemWriteD = 0;
                        ALUControlD = 4'b0000;   //加法
                        ALUSrcD = 0;            //从寄存器选择操作数
                        RegDstD = 1;            //写入rd寄存器
                        Jump = 0;
                        BranchD = 0;
                    end
                    /* sub */
                    6'b100010:begin
                        RegWriteD = 1;
                        MemtoRegD = 0;
                        MemWriteD = 0;
                        ALUControlD = 4'b0001;   //减法
                        ALUSrcD = 0;            //从寄存器选择操作数
                        RegDstD = 1;            //写入rd寄存器
                        Jump = 0;
                        BranchD = 0;
                    end
                    /* and */
                    6'b100100:begin
                        RegWriteD = 1;
                        MemtoRegD = 0;
                        MemWriteD = 0;
                        ALUControlD = 4'b0010;   //and
                        ALUSrcD = 0;            //从寄存器选择操作数
                        RegDstD = 1;            //写入rd寄存器
                        Jump = 0;
                        BranchD = 0;
                    end
                    /* or */
                    6'b100101:begin
                        RegWriteD = 1;
                        MemtoRegD = 0;
                        MemWriteD = 0;
                        ALUControlD = 4'b0011;   //or
                        ALUSrcD = 0;            //从寄存器选择操作数
                        RegDstD = 1;            //写入rd寄存器
                        Jump = 0;
                        BranchD = 0;
                    end
                    /* xor */
                    6'b100110:begin
                        RegWriteD = 1;
                        MemtoRegD = 0;
                        MemWriteD = 0;
                        ALUControlD = 4'b0100;   //xor
                        ALUSrcD = 0;            //从寄存器选择操作数
                        RegDstD = 1;            //写入rd寄存器
                        Jump = 0;
                        BranchD = 0;
                    end
                    /* nor */
                    6'b100111:begin
                        RegWriteD = 1;
                        MemtoRegD = 0;
                        MemWriteD = 0;
                        ALUControlD = 4'b0101;   //nor
                        ALUSrcD = 0;            //从寄存器选择操作数
                        RegDstD = 1;            //写入rd寄存器
                        Jump = 0;
                        BranchD = 0;
                    end
                    /* slt */
                    6'b101010:begin
                        RegWriteD = 1;
                        MemtoRegD = 0;
                        MemWriteD = 0;
                        ALUControlD = 4'b0110;   //小于置位
                        ALUSrcD = 0;            //从寄存器选择操作数
                        RegDstD = 1;            //写入rd寄存器
                        Jump = 0;
                        BranchD = 0;
                    end
                    /* sllv */
                    6'b000100:begin
                        RegWriteD = 1;
                        MemtoRegD = 0;
                        MemWriteD = 0;
                        ALUControlD = 4'b0111;   //左移
                        ALUSrcD = 0;            //从寄存器选择操作数
                        RegDstD = 1;            //写入rd寄存器
                        Jump = 0;
                        BranchD = 0;
                    end
                    /* srlv */
                    6'b000110:begin
                        RegWriteD = 1;
                        MemtoRegD = 0;
                        MemWriteD = 0;
                        ALUControlD = 4'b1000;   //逻辑右移
                        ALUSrcD = 0;            //从寄存器选择操作数
                        RegDstD = 1;            //写入rd寄存器
                        Jump = 0;
                        BranchD = 0;
                    end
                    /* srav */
                    6'b000111:begin
                        RegWriteD = 1;
                        MemtoRegD = 0;
                        MemWriteD = 0;
                        ALUControlD = 4'b1001;   //算术右移
                        ALUSrcD = 0;            //从寄存器选择操作数
                        RegDstD = 1;            //写入rd寄存器
                        Jump = 0;
                        BranchD = 0;
                    end
                    default:begin
                        RegWriteD = 0;
                        MemtoRegD = 0;
                        MemWriteD = 0;
                        ALUControlD = 4'b0000;   
                        ALUSrcD = 0;            
                        RegDstD = 0;            
                        Jump = 0;
                        BranchD = 0;
                    end
                endcase
                
            /* I型指令 */    
            /* addi */
            6'b001000: begin
                RegWriteD = 1;
                MemtoRegD = 0;
                MemWriteD = 0;
                ALUControlD = 4'b0000;   //加法
                ALUSrcD = 1;            //立即数作为操作数
                RegDstD = 0;            //写入rt寄存器
                Jump = 0;
                BranchD = 0;
            end
            /* andi */
            6'b001100:begin
                RegWriteD = 1;
                MemtoRegD = 0;
                MemWriteD = 0;
                ALUControlD = 4'b0010;   //and
                ALUSrcD = 1;            //立即数作为操作数
                RegDstD = 0;            //写入rt寄存器
                Jump = 0;
                BranchD = 0;
            end
            /* ori*/
            6'b001101:begin
                RegWriteD = 1;
                MemtoRegD = 0;
                MemWriteD = 0;
                ALUControlD = 4'b0011;   //or
                ALUSrcD = 1;            //立即数作为操作数
                RegDstD = 0;            //写入rt寄存器
                Jump = 0;
                BranchD = 0;
            end
            /* xori */
            6'b001110:begin
                RegWriteD = 1;
                MemtoRegD = 0;
                MemWriteD = 0;
                ALUControlD = 4'b0100;   //xor
                ALUSrcD = 1;            //立即数作为操作数
                RegDstD = 0;            //写入rt寄存器
                Jump = 0;
                BranchD = 0;
            end
            /* lw */
            6'b100011:begin
                RegWriteD = 1;
                MemtoRegD = 1;
                MemWriteD = 0;
                ALUControlD = 4'b0000;   //加法
                ALUSrcD = 1;            //立即数作为操作数
                RegDstD = 0;            //写入rt寄存器
                Jump = 0;
                BranchD = 0;
            end
            /* sw */
            6'b101011:begin
                RegWriteD = 0;
                MemtoRegD = 0;
                MemWriteD = 1;
                ALUControlD = 4'b0000;   //加法
                ALUSrcD = 1;            //立即数作为操作数
                RegDstD = 0;            
                Jump = 0;
                BranchD = 0;
            end
            /* beq */
            6'b000100:begin
                RegWriteD = 0;
                MemtoRegD = 0;
                MemWriteD = 0;
                ALUControlD = 4'b0001;   //减法
                ALUSrcD = 0;            
                RegDstD = 0;            
                Jump = 0;
                BranchD = 1;
            end
            default:begin
                RegWriteD = 0;
                MemtoRegD = 0;
                MemWriteD = 0;
                ALUControlD = 4'b0000;   
                ALUSrcD = 0;            
                RegDstD = 0;            
                Jump = 0;
                BranchD = 0;
            end
            
            /* J型指令 */
            6'b000010:begin
                RegWriteD = 0;
                MemtoRegD = 0;
                MemWriteD = 0;
                ALUControlD = 4'b0000;   
                ALUSrcD = 0;            
                RegDstD = 0;            
                Jump = 1;
                BranchD = 0;
            end
        endcase
    end
endmodule

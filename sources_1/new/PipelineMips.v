`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/10 18:50:54
// Design Name: 
// Module Name: PipelineMips
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


module PipelineMips(
    input clk, 
    input rst,
    input [4:0] user_add,
    output [3:0] an1,
    output [3:0] an2,
    output [7:0] seg1,
    output [7:0] seg2
    );
   
    wire clk_div1,clk_div2;
    wire [31:0] user_dout;
    wire RegWriteD,MemtoRegD,MemWriteD,ALUSrcD,RegDstD,BranchD,Jump;
    wire [3:0] ALUControlD, ALUControlE;
    wire RegWriteE,MemtoRegE,MemWriteE,ALUSrcE,RegDstE;
    wire RegWriteM,MemtoRegM,MemWriteM;
    wire RegWriteW,MemtoRegW;
    wire StallF,StallD,FlushE;
    wire ForwardAD,ForwardBD;
    wire [1:0] ForwardAE, ForwardBE;
    wire [31:0] PC,PC1,PC2,PCF,PCPlus4F,PCPlus4D,PCBranchD;
    wire [31:0] InstrF,InstrD;
    wire [31:0] ExtendImmD,ExtendImmE;
    wire [4:0] RsD,RtD,RdD,RsE,RtE,RdE;
    wire [31:0] RegOut1D,RegOut2D,RegOut1E,RegOut2E,Compare1,Compare2;
    wire PCSrcD,EqualD;
    wire [31:0] SrcAE,SrcBE,ALUOutE,ALUOutM,WriteDataE,WriteDataM;
    wire [4:0] WriteRegE,WriteRegM,WriteRegW;
    wire [31:0] ReadDataM,ReadDataW,ALUOutW,ResultW; //
    wire clr_id;
    
    assign EqualD = (Compare1 == Compare2) ? 1 : 0;
    assign PCSrcD = BranchD & EqualD;
    assign PC1 = PCSrcD ? PCBranchD : PCPlus4F;
    assign PC2 = {PCPlus4F[31:28],InstrD[25:0]<<2};
    assign PC = Jump ? PC2 : PC1;
    assign PCPlus4F = PCF + 4;
    assign PCBranchD = PCPlus4D + (ExtendImmD << 2);
    assign clr_id = PCSrcD | Jump;
    assign Compare1 = ForwardAD ? ALUOutM : RegOut1D;
    assign Compare2 = ForwardBD ? ALUOutM : RegOut2D;
    assign WriteRegE = RegDstE ? RdE : RtE;
    assign SrcAE = (ForwardAE == 2'b10) ? ALUOutM :(ForwardAE == 2'b01 ? ResultW : RegOut1E);
    assign WriteDataE = (ForwardBE == 2'b10) ? ALUOutM :(ForwardBE == 2'b01 ? ResultW : RegOut2E);
    //assign SrcAE = (ForwardAE == 2'b11) ? ALUOutE : ((ForwardAE == 2'b10) ? ALUOutM :(ForwardAE == 2'b01 ? ResultW : RegOut1E));
    //assign WriteDataE = (ForwardBE == 2'b11) ? ALUOutE : ((ForwardBE == 2'b10) ? ALUOutM :(ForwardBE == 2'b01 ? ResultW : RegOut2E));
    assign SrcBE = ALUSrcE ? ExtendImmE : WriteDataE;
    assign ResultW = MemtoRegW ? ReadDataW : ALUOutW;
    
    Clk_div clk_div(
        .clk(clk),
        .clk_div1(clk_div1),
        .clk_div2(clk_div2)
    );
    
    PC pc(
        .clk(clk_div1),
        .en(StallF),
        .PC(PC),
        .PCF(PCF)
    );
    
    InsRam ins_ram(
        .A(PCF),
        .RD(InstrF)
    );
    
    IF_ID_Reg if_id(
        .clk(clk_div1),
        .en(StallD),
        .clr(clr_id),
        .InstrF(InstrF),
        .PCPlus4F(PCPlus4F),
        .InstrD(InstrD),
        .PCPlus4D(PCPlus4D)
    );
    
    RegFiles regfiles(
        .clk(clk_div1),
        .rst(rst),
        .A1(InstrD[25:21]),
        .A2(InstrD[20:16]),
        .A3(WriteRegW),
        .user_add(user_add),
        .WD3(ResultW),
        .WE3(RegWriteW),
        .RD1(RegOut1D),
        .RD2(RegOut2D),
        .user_dout(user_dout)
    );
    
    ControlUnit control_unit(
        .Op(InstrD[31:26]),
        .Funct(InstrD[5:0]),
        .RegWriteD(RegWriteD),
        .MemtoRegD(MemtoRegD),
        .MemWriteD(MemWriteD),
        .ALUControlD(ALUControlD),
        .ALUSrcD(ALUSrcD),
        .RegDstD(RegDstD),
        .Jump(Jump),
        .BranchD(BranchD)
    );
    
    ImmExtend imm_extend(
        .imm(InstrD[15:0]),
        .Op(InstrD[31:26]),
        .Funct(InstrD[5:0]),
        .ExtendImmD(ExtendImmD)
    );
    
    ID_EX_Reg id_ex(
        .clk(clk_div1),
        .clr(FlushE),
        .RegWriteD(RegWriteD),
        .MemtoRegD(MemtoRegD),
        .MemWriteD(MemWriteD),
        .ALUControlD(ALUControlD),
        .ALUSrcD(ALUSrcD),
        .RegDstD(RegDstD),
        .RegOut1D(RegOut1D),
        .RegOut2D(RegOut2D),
        .RsD(InstrD[25:21]),
        .RtD(InstrD[20:16]),
        .RdD(InstrD[15:11]),
        .ExtendImmD(ExtendImmD),
        .RegWriteE(RegWriteE),
        .MemtoRegE(MemtoRegE),
        .MemWriteE(MemWriteE),
        .ALUControlE(ALUControlE),
        .ALUSrcE(ALUSrcE),
        .RegDstE(RegDstE),
        .RegOut1E(RegOut1E),
        .RegOut2E(RegOut2E),
        .RsE(RsE),
        .RtE(RtE),
        .RdE(RdE),
        .ExtendImmE(ExtendImmE)
    );
    
    ALU alu(
        .SrcAE(SrcAE),
        .SrcBE(SrcBE),
        .ALUControlE(ALUControlE),
        .ALUOutE(ALUOutE)
    );
    
    EX_MEM_Reg ex_mem(
        .clk(clk_div1),
        .RegWriteE(RegWriteE),
        .MemtoRegE(MemtoRegE),
        .MemWriteE(MemWriteE),
        .ALUOutE(ALUOutE),
        .WriteDataE(WriteDataE),
        .WriteRegE(WriteRegE),
        .RegWriteM(RegWriteM),
        .MemtoRegM(MemtoRegM),
        .MemWriteM(MemWriteM),
        .ALUOutM(ALUOutM),
        .WriteDataM(WriteDataM),
        .WriteRegM(WriteRegM)
    );
    
    DataRam data_ram(
        .clk(clk_div1),
        .A(ALUOutM),
        .WD(WriteDataM),
        .WE(MemWriteM),
        .RD(ReadDataM)  //ÐÞ¸ÄReadDataMÎªReadDataW
    );
    
    MEM_WB_Reg mem_wb(
        .clk(clk_div1),
        .RegWriteM(RegWriteM),
        .MemtoRegM(MemtoRegM),
        .ReadDataM(ReadDataM), //
        .ALUOutM(ALUOutM),
        .WriteRegM(WriteRegM),
        .RegWriteW(RegWriteW),
        .MemtoRegW(MemtoRegW),
        .ReadDataW(ReadDataW), //
        .ALUOutW(ALUOutW),
        .WriteRegW(WriteRegW)
    );
    
    HazardsUnit hazards_unit(
        .rst(rst),
        .BranchD(BranchD),
        .RsD(InstrD[25:21]),
        .RsE(RsE),
        .RtD(InstrD[20:16]),
        .RtE(RtE),
        .WriteRegE(WriteRegE),
        .WriteRegM(WriteRegM),
        .WriteRegW(WriteRegW),
        .RegWriteE(RegWriteE),
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .MemtoRegE(MemtoRegE),
        .MemtoRegM(MemtoRegM),
        .StallF(StallF),
        .StallD(StallD),
        .ForwardAD(ForwardAD),
        .ForwardBD(ForwardBD),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .FlushE(FlushE)
    );
    
    Display display1(
        .clk(clk_div2),
        .num(user_dout[15:0]),
        .seg(seg1),
        .an(an1)
    );
    
    Display display2(
        .clk(clk_div2),
        .num(user_dout[31:16]),
        .seg(seg2),
        .an(an2)
    );
endmodule
